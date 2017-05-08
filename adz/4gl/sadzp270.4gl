#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/01/17
#
#+ 程式代碼......: sadzp270
#+ 設計人員......:
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp270.4gl
# Description    : SQL BUILDER
# Memo           :
# 修改歷程       : 
#                  20160627   by elena  :1.行業複製所有內容皆不置換
#                                        2.一般複製，當addpoint name(dzba_t,dzbb_t)不包含function.、report.、dialog.，且結尾包含ONACTION，則不置換，其餘情形皆置換
#                  20160704   by elena  :行業環境時，addpoint 內容如有包含temp table name則不置換，其他無包含temp table name的段落要置換.
#                  20160711   by elena  :判斷是否為行業程式改由註冊資料判斷
#                  20160712   by elena  :dzba,dzbb在客製環境時，含define的addpoint name複製剔除 function., report., dialog. 三種情況
#                  20160729   by elena  :1.行業複製，增加寫檔dzau_t、dzbu_t
#                                        2.dzbc_t、dzbd_t複製時，如此為freestyle或解開section，則sectionid須轉換，內容仍不轉換.
#                  20161003   by elena  :1.增加判斷當程式為解開section或是轉freestyle時，addpoint標準define段不複製「customerization」，也不清空define段內容。
#                  20161013   by elena  :addpoint標準define或global.variable內容不複製到「customerization」addpoint中，標準內容也不清空
#                                        但如果複製目標原本就有「customerization」的addpoint，依然進行複製。


IMPORT os
IMPORT util
SCHEMA ds


GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp270.inc"



   DEFINE   ms_dgenv             LIKE dzaf_t.dzaf010,       #環境變數DGENV (s:標準/ c:客製)
            ms_erpid             LIKE dzaf_t.dzaf007,       #環境變數ERPID(產品代號)
            ms_erpver            LIKE dzaf_t.dzaf008,       #環境變數ERPVER(產品版本)
            ms_cust              LIKE dzaf_t.dzaf009        #環境變數CUST (客戶代號)

   DEFINE g_gen_prog           LIKE dzaa_t.dzaa001,
          g_gen_ver            STRING,
          g_gen_spec_ver       STRING,                      #產生程式的規格版次
          g_gen_code_ver       STRING,
          g_gen_identity       LIKE dzaf_t.dzaf010,
          g_copy_source        LIKE dzaa_t.dzaa001, 　      #複製來源   
          g_design_point_ver   STRING,                      #產生程式的設計點版次
          g_source_ver         STRING,              　      #來源建構版次
          g_source_spec_ver    STRING,                      #來源規格版次
          g_source_code_ver    STRING,                      #來源代碼版次   
          g_source_identity    LIKE dzaf_t.dzaf010,         #來源識別標示
          g_source_type        LIKE dzaf_t.dzaf005,         #來源類型
          g_use_table_replace  LIKE type_t.chr1,            #是否啟用表格替換功能
          g_dzaa_t_exculded_wc   STRING,                    #設計資料的排除條件
          g_dzba_t_exculded_wc   STRING,                    #appint的排除資料
          g_gzzd_t_exculded_wc   STRING,                    #appint的排除資料
         ga_dzeb DYNAMIC ARRAY OF type_col_relation,        #編輯用新舊欄位對應表
  
         ga_dzeb_stored DYNAMIC ARRAY OF type_col_relation, #儲存用新舊欄位對應表

         ga_excluded_col DYNAMIC ARRAY OF RECORD            #沒有對應到要排除的欄位
            table_id       LIKE dzea_t.dzea001,
            col_id         LIKE dzeb_t.dzeb002,
            col_name       LIKE dzebl_t.dzebl003,
            table_id_tmp   LIKE dzea_t.dzea001,
            col_id_tmp     LIKE dzea_t.dzea001
         END RECORD,
         ga_dzca      DYNAMIC ARRAY OF RECORD               #存放開窗識別碼
            origin         LIKE dzca_t.dzca001,
            replace        STRING
          END RECORD,
         ga_dzcd      DYNAMIC ARRAY OF RECORD               #存放校驗帶值識別碼
            origin         LIKE dzcd_t.dzcd001,
            replace        STRING
          END RECORD,
         g_use_current_sub_prog LIKE type_t.chr1,           #是否使用原本的子程式
         g_not_copy_appoint    LIKE type_t.chr1,            #是否不複製appoint的內容
         ga_gzzq_t            DYNAMIC ARRAY OF RECORD       #ACTION多語言對照檔
            gzzq002     　　　　  LIKE gzzq_t.gzzq002       #功能編號
                              END RECORD,
         ga_dzag DYNAMIC ARRAY OF dzag_type,
         addpoint_list DYNAMIC ARRAY OF RECORD              #紀錄要轉換的addpoint
            name  STRING
         END RECORD,
         g_industry        STRING,                          #是否為行業別
         g_freestyle       STRING,                          #是否是freestyle  #20160729 add by elena 
         g_section_modify  STRING                           #是否解開section  #20161003 add by elena

PUBLIC FUNCTION sadzp270_copy_database_data_ALL(subPara, sub_dzag, sub_dzeb_stored, sub_prog)
#PUBLIC FUNCTION sadzp270_copy_database_data_ALL(subPara, ga_dzag)
   DEFINE subPara type_para
   DEFINE sub_dzag DYNAMIC ARRAY OF dzag_type 
   DEFINE sub_dzeb_stored DYNAMIC ARRAY OF type_col_relation
   DEFINE sub_prog STRING

   DEFINE ls_sql            STRING,
          ls_where          STRING,
          l_user            LIKE dzaa_t.dzaaownid,
          l_dept            LIKE dzaa_t.dzaaowndp,
          l_date            LIKE dzaa_t.dzaacrtdt,
          ls_err            STRING,
          ln_cnt            LIKE type_t.num5,
          lb_flag           BOOLEAN, #檢查transation的過程式否有錯誤
          ln_addpoint_cnt   LIKE type_t.num5,
          ls_test           base.StringBuffer,
          ls_copy_source    STRING,
          lb_result         BOOLEAN

   DEFINE ls_on_action      LIKE  dzad_t.dzad002,
          lb_on_action      BOOLEAN,
          json_on_action    util.JSONObject,                 #紀錄OnAction list   20160627 add by elena
          json_temp_table   util.JSONObject                  #20160704 
    
   DEFINE l_dzaxstus LIKE dzax_t.dzaxstus,
          l_dzax002  LIKE dzax_t.dzax002,
          l_dzax003  LIKE dzax_t.dzax003 

   #dzaa_t
   DEFINE ls_dzaastus LIKE dzaa_t.dzaastus,
          ls_dzaa002  LIKE dzaa_t.dzaa002,  #錯誤訊息用
          ls_dzaa003  LIKE dzaa_t.dzaa003,
          ls_dzaa005  LIKE dzaa_t.dzaa005,
          ls_dzaa007  LIKE dzaa_t.dzaa007   #行業別用 
   
   #dzab_t
   DEFINE ls_dzabstus LIKE dzab_t.dzabstus,
          ls_dzab002  LIKE dzab_t.dzab002,  #錯誤訊息用
          ls_dzab004  LIKE dzab_t.dzab004,
          ls_dzab006  LIKE dzab_t.dzab006,
          ls_dzab099  LIKE dzab_t.dzab099

   #dzac_t
   DEFINE ls_dzacstus LIKE dzac_t.dzacstus,
          ls_dzac002  LIKE dzac_t.dzac002,
          ls_dzac003  LIKE dzac_t.dzac003,
          ls_dzac004  LIKE dzac_t.dzac004,  #錯誤訊息用
          ls_dzac005  LIKE dzac_t.dzac005,
          ls_dzac006  LIKE dzac_t.dzac006,
          ls_dzac007  LIKE dzac_t.dzac007,
          ls_dzac008  LIKE dzac_t.dzac008,
          ls_dzac009  LIKE dzac_t.dzac009,
          ls_dzac010  LIKE dzac_t.dzac010,
          ls_dzac011  LIKE dzac_t.dzac011,
          ls_dzac014  LIKE dzac_t.dzac014,
          ls_dzac015  LIKE dzac_t.dzac015,
          ls_dzac016  LIKE dzac_t.dzac016,
          ls_dzac017  LIKE dzac_t.dzac017,
          ls_dzac018  LIKE dzac_t.dzac018, 
          ls_dzac019  LIKE dzac_t.dzac019,
          ls_dzac099  LIKE dzac_t.dzac099,
          ls_dzac020  LIKE dzac_t.dzac020,
          ls_dzac021  LIKE dzac_t.dzac021


   #dzad_t
   DEFINE ls_dzadstus LIKE dzad_t.dzadstus,
          ls_dzad002  LIKE dzad_t.dzad002,
          ls_dzad003  LIKE dzad_t.dzad003,  #錯誤訊息用
          ls_dzad099  LIKE dzad_t.dzad099,
          ls_dzad006  LIKE dzad_t.dzad006,
          ls_dzad007  LIKE dzad_t.dzad007

   #dzag_t
   DEFINE ls_dzagstus LIKE dzag_t.dzagstus,
          ls_dzag002  LIKE dzag_t.dzag002,
          ls_dzag003  LIKE dzag_t.dzag003,  #錯誤訊息用
          ls_dzag004  LIKE dzag_t.dzag004,
          ls_dzag005  LIKE dzag_t.dzag005,
          ls_dzag007  LIKE dzag_t.dzag007,
          ls_dzag008  LIKE dzag_t.dzag008,
          ls_dzag009  LIKE dzag_t.dzag009,
          ls_dzag010  LIKE dzag_t.dzag010

   #dzak_t
   DEFINE ls_dzakstus LIKE dzak_t.dzakstus,
          ls_dzak002  LIKE dzak_t.dzak002,
          ls_dzak003  LIKE dzak_t.dzak003,  #錯誤訊息用
          ls_dzak005  LIKE dzak_t.dzak005,
          ls_dzak007  LIKE dzak_t.dzak007,
          ls_dzak008  LIKE dzak_t.dzak008,
          ls_dzak009  LIKE dzak_t.dzak009,
          ls_dzak010  LIKE dzak_t.dzak010,
          ls_dzak011  LIKE dzak_t.dzak011 


   #dzai_t
   DEFINE ls_dzaistus LIKE dzai_t.dzaistus,
          ls_dzai002  LIKE dzai_t.dzai002,
          ls_dzai003  LIKE dzai_t.dzai003,  #錯誤訊息用
          ls_dzai005  LIKE dzai_t.dzai005,
          ls_dzai007  LIKE dzai_t.dzai007,
          ls_dzai008  LIKE dzai_t.dzai008,
          ls_dzai009  LIKE dzai_t.dzai009,
          ls_dzai010  LIKE dzai_t.dzai010,
          ls_dzai011  LIKE dzai_t.dzai011

   #dzaj_t
   DEFINE ls_dzajstus LIKE dzaj_t.dzajstus,
          ls_dzaj002  LIKE dzaj_t.dzaj002,
          ls_dzaj003  LIKE dzaj_t.dzaj003,  #錯誤訊息用
          ls_dzaj005  LIKE dzaj_t.dzaj005,
          ls_dzaj007  LIKE dzaj_t.dzaj007,
          ls_dzaj008  LIKE dzaj_t.dzaj008,
          ls_dzaj009  LIKE dzaj_t.dzaj009,
          ls_dzaj010  LIKE dzaj_t.dzaj010,
          ls_dzaj011  LIKE dzaj_t.dzaj011,
          ls_dzaj099  LIKE dzaj_t.dzaj099

   #dzal_t
   DEFINE ls_dzalstus LIKE dzal_t.dzalstus,
          ls_dzal002  LIKE dzal_t.dzal002,
          ls_dzal003  LIKE dzal_t.dzal003,  #錯誤訊息用
          ls_dzal005  LIKE dzal_t.dzal005,
          ls_dzal006  LIKE dzal_t.dzal006,
          ls_dzal007  LIKE dzal_t.dzal007,
          ls_dzal008  LIKE dzal_t.dzal008

   #dzff_t
   DEFINE ls_dzffstus LIKE dzff_t.dzffstus,
          ls_dzff002  LIKE dzff_t.dzff002,  #錯誤訊息用
          ls_dzff003  LIKE dzff_t.dzff003,
          ls_dzff004  LIKE dzff_t.dzff004,
          ls_dzff005  LIKE dzff_t.dzff005,
          ls_dzff006  LIKE dzff_t.dzff006,
          ls_dzff007  LIKE dzff_t.dzff007

   #dzfs_t
   DEFINE ls_dzfsstus LIKE dzfs_t.dzfsstus,
          ls_dzfs001  LIKE dzfs_t.dzfs001,  #錯誤訊息用
          ls_dzfs003  LIKE dzfs_t.dzfs003,
          ls_dzfs004  LIKE dzfs_t.dzfs004,
          ls_dzfs006  LIKE dzfs_t.dzfs006,
          ls_dzfs007  LIKE dzfs_t.dzfs007,
          ls_dzfs008  LIKE dzfs_t.dzfs008,
          ls_dzfs009  LIKE dzfs_t.dzfs009,
          ls_dzfs010  LIKE dzfs_t.dzfs010

   #dzfq_t
   DEFINE ls_dzfqstus LIKE dzfq_t.dzfqstus,
          ls_dzfq001  LIKE dzfq_t.dzfq001,
          ls_dzfq002  LIKE dzfq_t.dzfq002,
          ls_dzfq003  LIKE dzfq_t.dzfq003,  #錯誤訊息用
          ls_dzfq005  LIKE dzfq_t.dzfq005,
          ls_dzfq006  LIKE dzfq_t.dzfq006,
          ls_dzfq007  LIKE dzfq_t.dzfq007,
          ls_dzfq008  LIKE dzfq_t.dzfq008,
          ls_dzfq009  LIKE dzfq_t.dzfq009,
          ls_dzfq010  LIKE dzfq_t.dzfq010,
          ls_dzfq011  LIKE dzfq_t.dzfq011,
          ls_dzfq012  LIKE dzfq_t.dzfq012,
          ls_dzfq013  LIKE dzfq_t.dzfq013,
          ls_dzfq014  LIKE dzfq_t.dzfq014,
          ls_dzfq015  LIKE dzfq_t.dzfq015,
          ls_dzfq016  LIKE dzfq_t.dzfq016 


   #gzzd_t
   DEFINE ls_gzzdstus LIKE gzzd_t.gzzdstus,
          ls_gzzd002  LIKE gzzd_t.gzzd002,
          ls_gzzd003  LIKE gzzd_t.gzzd003,
          ls_gzzd004  LIKE gzzd_t.gzzd004,
          ls_gzzd005  LIKE gzzd_t.gzzd005,
          ls_gzzd006  LIKE gzzd_t.gzzd006


   #gzzp_t
   DEFINE ls_gzzpstus LIKE gzzp_t.gzzpstus,
          ls_gzzp002  LIKE gzzp_t.gzzp002,
          ls_gzzp003  LIKE gzzp_t.gzzp003,
          ls_gzzp004  LIKE gzzp_t.gzzp004,
          ls_gzzp005  LIKE gzzp_t.gzzp005
   
   #dzba_t
   DEFINE ls_dzbastus  LIKE dzba_t.dzbastus,
          ls_dzba002   LIKE dzba_t.dzba002,  #錯誤訊息用
          ls_dzba003   LIKE dzba_t.dzba003,
          ln_dzba006   LIKE dzba_t.dzba006,
          ls_dzba006   STRING,
          ls_dzba007   LIKE dzba_t.dzba007,  #行業別用
          ls_dzba009   LIKE dzba_t.dzba009,
          ls_dzbastus_c  LIKE dzba_t.dzbastus, #_customerization用
          ls_dzba002_c   LIKE dzba_t.dzba002,  #_customerization用
          ls_dzba003_c   LIKE dzba_t.dzba003,  #_customerization用
          ln_dzba006_c   LIKE dzba_t.dzba006,  #_customerization用
          ls_dzba006_c   STRING,               #_customerization用
          ls_dzba009_c   LIKE dzba_t.dzba009,  #_customerization用
          ls_action      STRING,
          lb_action      BOOLEAN,
          li_count       INTEGER


   #dzbb_T
   DEFINE ls_dzbbstus         LIKE dzbb_t.dzbbstus,
          ls_dzbb002          LIKE dzbb_t.dzbb002,
          ls_dzbb003          LIKE dzbb_t.dzbb003,  #錯誤訊息用
          ls_dzbb098          LIKE dzbb_t.dzbb098,
          ls_dzbb006          LIKE dzbb_t.dzbb006,
          ls_dzbbstus_c       LIKE dzbb_t.dzbbstus,
          ls_dzbb002_c        LIKE dzbb_t.dzbb002,  #_customerization
          ls_dzbb003_c        LIKE dzbb_t.dzbb003,  #_customerization
          ls_dzbb098_c        LIKE dzbb_t.dzbb098,  #_customerization
          ls_dzbb006_c        LIKE dzbb_t.dzbb006,  #_customerization
          ls_dzbb098_tmp      base.StringTokenizer, #20160704
          ls_dzbb098_tmp_line base.StringTokenizer, #20160704
          ls_dzbb098_buffer   base.StringBuffer,    #20160704
          ls_str              STRING,               #20160704
          ls_replace          STRING,               #20160704
          ls_tmp_table        STRING,               #20160704
          ls_str_tmp          STRING

  #dzbc_t
  DEFINE ls_dzbcstus LIKE dzbc_t.dzbcstus,
         ls_dzbc002  LIKE dzbc_t.dzbc002,  #錯誤訊息用
         ls_dzbc003  LIKE dzbc_t.dzbc003,
         ls_dzbc004  LIKE dzbc_t.dzbc004,
         ls_dzbc005  LIKE dzbc_t.dzbc005,
         ls_dzbc009  LIKE dzbc_t.dzbc009,
         ls_dzbc010  LIKE dzbc_t.dzbc010,
         ls_dzbc011  LIKE dzbc_t.dzbc011

   #dzbd_t
   DEFINE ls_dzbdstus LIKE dzbd_t.dzbdstus,
          ls_dzbd002  LIKE dzbd_t.dzbd002,
          ls_dzbd003  LIKE dzbd_t.dzbd003,
          ls_dzbd004  LIKE dzbd_t.dzbd004,
          ls_dzbd098  LIKE dzbd_t.dzbd098  

   #dzam_t
   DEFINE ls_dzamstus LIKE dzam_t.dzamstus,
          ls_dzam003  LIKE dzam_t.dzam003,
          ls_dzam004  LIKE dzam_t.dzam004  #錯誤訊息用


   #dzax_t
   DEFINE ls_dzax002  LIKE dzax_t.dzax002,
          ls_dzax003  LIKE dzax_t.dzax003,
          ln_dzax007  LIKE dzax_t.dzax007,
          ls_dzax007  STRING
   
   DEFINE ls_err_msg STRING
   
 
   LET g_gen_prog = subPara.g_gen_prog
   LET ms_dgenv = subPara.ms_dgenv
   LET ms_erpid = subPara.ms_erpid           
   LET ms_erpver = subPara.ms_erpver
   LET ms_cust = subPara.ms_cust
   LET g_gen_prog = subPara.g_gen_prog  

   #LET g_gen_ver = subPara.g_gen_ver
   #LET g_gen_spec_ver = subPara.g_gen_spec_ver
   #LET g_gen_code_ver = subPara.g_gen_code_ver
   #LET g_gen_identity = subPara.g_gen_identity
   #LET g_design_point_ver = subPara.g_design_point_ver
   
   LET g_copy_source = subPara.g_copy_source
   LET g_source_ver = subPara.g_source_ver
   LET g_source_spec_ver = subPara.g_source_spec_ver
   LET g_source_code_ver = subPara.g_source_code_ver
   LET g_source_identity = subPara.g_source_identity
   LET g_use_table_replace = subPara.g_use_table_replace
   LET g_source_type = subPara.g_source_type



 
   IF g_source_type = "X" or g_source_type = "G" THEN
      CALL sadzp060_2_get_spec_curr_revision(g_copy_source, g_source_type, "") RETURNING g_source_spec_ver, g_source_identity ,ls_err_msg
   #ELSE
   #   LET g_source_type = "N"  #N表示非報表
   END IF

   LET ga_dzag = sub_dzag
   LET ga_dzeb_stored = sub_dzeb_stored

   LET l_user        = g_user
   LET l_dept        = g_dept
   LET l_date        = cl_get_current()
  
   LET g_gen_prog    = g_gen_prog CLIPPED
   LET g_copy_source = g_copy_source

  #20140922 modify -Begin-
  #LET g_gen_spec_ver    = g_gen_spec_ver CLIPPED
  #LET g_design_point_ver  = g_design_point_ver
  #LET g_source_ver  = g_source_ver CLIPPED

   LET g_gen_spec_ver    = g_gen_spec_ver.trim() 
   LET g_design_point_ver  = g_design_point_ver.trim() 
   LET g_source_ver  = g_source_ver.trim()
  #20140922 modify -End-
   
   LET lb_flag = TRUE
  
   #複製時,目標程式的版次應該都reset由1開始
   LET g_gen_ver      = '1'
   LET g_gen_spec_ver = '1'
   LET g_gen_code_ver = '1'
   LET g_design_point_ver = '1'
   LET g_gen_identity =  ms_dgenv

   #BEGIN WORK

   CALL cl_err_collect_init()  #錯誤訊息彙總
   

   #BEGIN:20160707 mark by elena 行業程式判斷改為由sadzp060_ind_check_industry_prog
   ##判斷是否是行業別 gzzb001<>gzzb003
   #LET ls_sql = "SELECT COUNT(*) FROM gzzb_t WHERE gzzb001='" ,g_gen_prog , "' AND gzzb001<>gzzb003 "
   #PREPARE query_gzzb_t FROM ls_sql
   #EXECUTE query_gzzb_t INTO ln_cnt
   #IF ln_cnt > 0 THEN
   #   LET g_industry = "Y"
   #ELSE
   #   LET g_industry = "N"
   #END IF
   #END:20160707

   #BEGIN:20160711 add by elena
   IF sadzp060_ind_check_prog_by_type(g_gen_prog, g_source_type) THEN
      LET g_industry = "Y"
   ELSE
      LET g_industry = "N"
   END IF   
   #END:20160707 

 
   #BEGIN:20160729 add by elena
   #SELECT COUNT(*) INTO ln_cnt FROM DZAX_T WHERE DZAX001 = g_copy_source AND DZAX003 = 'Y'
   #IF ln_cnt > 0 THEN
   #   LET g_freestyle = "Y" 
   #ELSE
   #   LET g_freestyle = "N"
   #END IF
   #END:20160729  

   #BEGIN:20161003 add by elena
   CALL sadzp169_02_chk_not_free_style(g_copy_source, g_source_identity) RETURNING lb_result,ls_err_msg
   IF lb_result THEN
      LET g_freestyle = "N" 
   ELSE
      LET g_freestyle = "Y"
   END IF
   #END:20161003


   #BEGIN:20161003 add by elena  只有有程式的型態需要查詢其他都是N。
   IF g_source_type MATCHES "[SMZBWQGX]" THEN
      LET ls_sql = "SELECT COUNT(*) FROM dzbc_t",
                   " WHERE dzbc001='", g_copy_source ,"'",
                   "   AND dzbc002=",g_source_code_ver,
                   "   AND (dzbc005='m' or dzbc005='c') ",
                   "   AND dzbcstus='Y'"
 
      PREPARE query_section_modify FROM ls_sql
      EXECUTE query_section_modify INTO ln_cnt

      IF ln_cnt > 0 THEN
         LET g_section_modify = "Y" 
      ELSE
         LET g_section_modify = "N"
      END IF
   ELSE
      LET g_section_modify = "N"
   END IF
   #END:20161003
 

   #BEGIN:20160627 add by elena  取得所有Action(只有非行業複製需要，行業複製皆不置換)
   IF g_industry == "N" THEN
      LET json_on_action = util.JSONObject.create()
      LET ls_sql = "select distinct dzad002 from dzad_t where dzad001='",g_copy_source,"'"
      PREPARE select_on_action FROM ls_sql
      DECLARE on_action_curs CURSOR FOR select_on_action

      LET ln_cnt=0

      FOREACH on_action_curs INTO ls_on_action
         CALL json_on_action.put(ls_on_action,1)
      END FOREACH
   END IF
   #END:20160627



   ##轉換表格前置作業
   IF g_use_table_replace = "Y" THEN 
      # 篩選會影響到的開窗和校驗帶值識別值
      CALL sadzp270_filter_q_id_and_v_id()
      #產生要排除的欄位資料陣列
      CALL sadzp270_select_excluded_column()
      LET  g_dzaa_t_exculded_wc = sadzp270_gen_excluded_where_condition("dzaa003")
      #DISPLAY "g_dzaa_t_exculded_wc = ",g_dzaa_t_exculded_wc
      LET  g_dzba_t_exculded_wc = sadzp270_gen_excluded_where_condition("dzba003")
      #DISPLAY "g_dzba_t_exculded_wc = ",g_dzba_t_exculded_wc
      LET  g_gzzd_t_exculded_wc = sadzp270_gen_excluded_where_condition("gzzd003")
      #DISPLAY "g_gzzd_t_exculded_wc = ",g_gzzd_t_exculded_wc
  

   END IF


   #TRY #by mandy

 
   #####dzaa_t#####
   #組SQL
   #轉換表格需在where條件加入g_dzaa_t_excluded_wc，排除例外條件
   
   #報表刪除所有資料
   IF g_source_type = "X" or g_source_type = "G" THEN
      DELETE FROM dzaa_t WHERE dzaa001 = g_gen_prog 
   END IF

   LET ls_sql = "SELECT dzaastus, dzaa002, dzaa003, dzaa005, dzaa007 from dzaa_t "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa009='",g_source_identity,"' AND dzaastus='Y' "
   LET ls_sql = ls_sql , ls_where
    
   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF
  
 
   LET ls_sql = ls_sql , "ORDER BY dzaa005, dzaa003 "

   PREPARE select_dzaa_t FROM ls_sql
   DECLARE dzaa_curs CURSOR FOR select_dzaa_t

   #一筆一筆複製資料
   #轉換表格：dzaa003 需轉換欄位名稱
   LET ln_cnt=0  
   
   FOREACH dzaa_curs INTO ls_dzaastus, ls_dzaa002, ls_dzaa003, ls_dzaa005, ls_dzaa007
      LET ln_cnt = ln_cnt + 1     
      IF g_use_table_replace = "Y" THEN
         LET ls_dzaa003 = sadzp270_gen_replace_sql_str("dzaa003", "dzaa_t", ls_dzaa003)
      END IF

      ##行業別：dzaa005 IN ('1','2','3','5','6','7') :Y  ELSE:N
      IF g_industry = "Y" THEN
         IF ls_dzaa005 = "1" OR ls_dzaa005 = "2" OR ls_dzaa005 = "3" OR ls_dzaa005 = "5" OR ls_dzaa005 = "6" OR ls_dzaa005 = "7" THEN
            LET ls_dzaa007 = "Y"
         ELSE
            LET ls_dzaa007 = "N"
         END IF

      END IF

      TRY

         LET ls_sql = "INSERT INTO dzaa_t ",
                      "   (dzaastus, dzaa001, dzaa002, dzaa003, dzaa004, dzaa005, ",
                      "    dzaa006, dzaa007, dzaa008, dzaa009, dzaa010, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp, dzaacrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzaastus, "', '", g_gen_prog, "', ", g_gen_spec_ver, ",'", ls_dzaa003 CLIPPED, "', ", g_design_point_ver, ", '", ls_dzaa005 CLIPPED, "', '", 
                           ms_dgenv, "', '" ,  ls_dzaa007 CLIPPED, "', '", ms_erpver, "', '", ms_dgenv, "', '", ms_cust, "', '", l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP)"

         #DISPLAY ls_sql

         PREPARE dzaa_prep FROM ls_sql  
         EXECUTE dzaa_prep
         
 
      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"   
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzaa_t"
            #LET g_errparam.replace[2] = "dzaa001 = '",g_gen_prog, "' AND dzaa002 = '", g_gen_spec_ver, "' AND dzaa003 = '", ls_dzaa003, "'" 
            LET g_errparam.replace[2] = "dzaa001 = '", g_copy_source, "' AND dzaa002 = '", ls_dzaa002 CLIPPED, "' AND dzaa003 = '", ls_dzaa003 CLIPPED, "'"
            CALL cl_err()
    
         END IF
         LET lb_flag = FALSE         
      END TRY
   END FOREACH
   #DISPLAY "dzaa_count = ", ln_cnt  

   FREE select_dzaa_t
   FREE dzaa_curs
   FREE dzaa_prep  

   #BEGIN:20160729 modify by elena
   #####dzau_t#####
   IF g_industry = "Y" THEN
      DELETE FROM DZAU_T WHERE DZAU001 = g_gen_prog
      LET ls_sql = "INSERT INTO dzau_t(dzau001,dzau003,dzau004,dzau005)",
                   " SELECT '",g_gen_prog,"',dzaa003,dzaa004,dzaa005 FROM dzaa_t",
                   "  WHERE dzaa001='",g_gen_prog,"'",
                   "    AND dzaa002=",g_gen_spec_ver
      PREPARE dzau_prep2 FROM ls_sql
      EXECUTE dzau_prep2
      FREE dzau_prep2
   END IF   
   #END:20160729

   #####dzab_t#####
   
   LOCATE ls_dzab099 IN FILE
   
   #報表刪除所有資料
   IF g_source_type = "X" or g_source_type = "G" THEN
      DELETE FROM dzab_t WHERE dzab001 = g_gen_prog      
   END IF

   LET ls_sql = "SELECT dzabstus, dzab002, dzab004, dzab006, dzab099 from dzab_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzab001 AND dzaa003=dzab004 AND dzaa004=dzab002 AND dzaa006 = dzab003 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='3' AND dzaa009='",g_source_identity,"' AND dzaastus='Y' "
   
   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql, g_dzaa_t_exculded_wc 
   END IF

   PREPARE select_dzab_t FROM ls_sql
   DECLARE dzab_curs CURSOR FOR select_dzab_t

   #一筆一筆複製資料
   #轉換表格：dzab099 (CLOB) 轉換欄位名稱、程式名稱。
   #不轉換表格:dzab099 (CLOB) 轉換程式名稱。
   LET ln_cnt = 0  
   FOREACH dzab_curs INTO ls_dzabstus, ls_dzab002, ls_dzab004, ls_dzab006, ls_dzab099
 
      LET ln_cnt = ln_cnt + 1  
      #g_use_table_replace="Y" or "N" 都轉換
      #20160627 by elena 行業別不轉換dzab009
      IF g_industry = "N" THEN
         LET ls_dzab099 = sadzp270_gen_replace_sql_str("dzab099", "dzab_t", ls_dzab099)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzab_t ",
                      "   (dzabstus, dzab001, dzab002, dzab003, dzab004, dzab005, dzab006, ",
                      "    dzabownid, dzabowndp, dzabcrtid, dzabcrtdp, dzabcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzabstus,"', '", g_gen_prog, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ls_dzab004 CLIPPED, "', '", ms_cust, "', '", ls_dzab006 CLIPPED, "', '",
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP )"

         #DISPLAY ls_sql
         PREPARE dzab_prep FROM ls_sql 
         EXECUTE dzab_prep
       

         #IF ls_dzab099 IS NOT NULL THEN 
            #避免資料內容有引號，先做取代
            #LET ls_dzab099 = cl_replace_str(ls_dzab099, "'", "''")

            LET ls_sql = "UPDATE dzab_t ",
                         #"   SET dzab099 = '", ls_dzab099, "' ",
                         "   SET dzab099 = ?  ",
                         "WHERE dzab001 = '", g_gen_prog, "' AND dzab002 = ", g_design_point_ver, " AND dzab003 = '", ms_dgenv, "' AND dzab004 = '", ls_dzab004 CLIPPED, "' "
              
            #DISPLAY ls_sql
            PREPARE dzab_update_prep FROM ls_sql 
            EXECUTE dzab_update_prep USING ls_dzab099
         #END IF

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592" 
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzab_t"
            #LET g_errparam.replace[2] = "dzab001 = '", g_gen_prog, "' AND dzab002 = ", g_design_point_ver, " AND dzab003 = '", ms_dgenv, "' AND dzab004 = '", ls_dzab004, "'"
            LET g_errparam.replace[2] = "dzab001 = '", g_copy_source, "' AND dzab002 = ", ls_dzab002, " AND dzab003 = '", ms_dgenv, "' AND dzab004 = '", ls_dzab004, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE ls_dzab099
      LOCATE ls_dzab099 IN FILE
   END FOREACH
   #DISPLAY "dzab_count = ", ln_cnt 
   FREE ls_dzab099
   FREE select_dzab_t
   FREE dzab_curs
   FREE dzab_prep
   FREE dzab_update_prep


   IF g_source_type <> "G" AND g_source_type <> "X" THEN
   
   #####dzac_t######
   LOCATE ls_dzac099 IN FILE   

   LET ls_sql = "SELECT dzacstus, dzac002, dzac003, dzac004, dzac005, dzac006, dzac007, dzac008, dzac009, ",
                "       dzac010, dzac011, dzac014, dzac015, dzac016, dzac017, dzac018, dzac019, dzac099, dzac020, dzac021 ",
                "FROM dzac_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012 "

   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaa009='",g_source_identity,"' AND dzaastus='Y' "


   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql, g_dzaa_t_exculded_wc
   END IF

   PREPARE select_dzac_t FROM ls_sql
   DECLARE dzac_curs CURSOR FOR select_dzac_t


   #一筆一筆複製資料
   #轉、不轉換表格：dzac002、dzac003、dzac005 轉換欄位名稱。
   LET ln_cnt = 0 
   FOREACH dzac_curs INTO ls_dzacstus, ls_dzac002, ls_dzac003, ls_dzac004, ls_dzac005, ls_dzac006, ls_dzac007, ls_dzac008, ls_dzac009, ls_dzac010, 
                          ls_dzac011, ls_dzac014, ls_dzac015, ls_dzac016, ls_dzac017, ls_dzac018, ls_dzac019, ls_dzac099, ls_dzac020, ls_dzac021

      LET ln_cnt = ln_cnt + 1 
      IF g_use_table_replace = "Y" THEN
         LET ls_dzac002 = sadzp270_gen_replace_sql_str("dzac002", "dzac_t", ls_dzac002)
         LET ls_dzac003 = sadzp270_gen_replace_sql_str("dzac003", "dzac_t", ls_dzac003)
         LET ls_dzac005 = sadzp270_gen_replace_sql_str("dzac005", "dzac_t", ls_dzac005)
      END IF
      #g_use_table_replace="Y" or "N" 都轉換
      #20160627 by elena 行業不轉換
      IF g_industry = "N" THEN     
         LET ls_dzac099 = sadzp270_gen_replace_sql_str("dzac099", "dzac_t", ls_dzac099)
      END IF

      TRY

         #避免資料內容有引號，先做取代
         #LET ls_dzac014 = cl_replace_str(ls_dzac014, "'", "''")

         LET ls_sql = "INSERT INTO dzac_t ",
                      "   (dzacstus, dzac001, dzac002, dzac003, dzac004, dzac005, ",
                      "    dzac006, dzac007, dzac008, dzac009, dzac010, dzac011, dzac012, dzac013, ",
                      "    dzac014, dzac015, dzac016, dzac017, dzac018, dzac019, dzac020, dzac021, ",
                      "    dzacownid, dzacowndp, dzaccrtid, dzaccrtdp, dzaccrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzacstus, "', '", g_gen_prog, "', '",  ls_dzac002 CLIPPED, "', '", ls_dzac003 CLIPPED, "', ", g_design_point_ver, ", '", ls_dzac005 CLIPPED, "', '", 
                           ls_dzac006 CLIPPED, "', '", ls_dzac007 CLIPPED, "', '", ls_dzac008 CLIPPED, "', '", ls_dzac009 CLIPPED, "', '", ls_dzac010 CLIPPED, "', '", ls_dzac011 CLIPPED, "', '", ms_dgenv, "', '", ms_cust, "',  
                           ? , '", ls_dzac015 CLIPPED, "', '", ls_dzac016 CLIPPED, "', '", ls_dzac017 CLIPPED, "', '", ls_dzac018 CLIPPED, "', '", ls_dzac019 CLIPPED, "', '", ls_dzac020 CLIPPED, "', '", ls_dzac021 CLIPPED, "', '",
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "
 

         #DISPLAY ls_sql
         PREPARE dzac_prep FROM ls_sql
         EXECUTE dzac_prep USING ls_dzac014

  
         #避免資料內容有引號，先做取代
         #LET ls_dzac099 = cl_replace_str(ls_dzac099, "'", "''")

         LET ls_sql = "UPDATE dzac_t ",
                      #"   SET dzac099 = '", ls_dzac099, "' ",
                      "   SET dzac099 = ? ",
                      "WHERE dzac001 = '", g_gen_prog, "' AND dzac003 = '", ls_dzac003, "' AND dzac004 = ", g_design_point_ver, " AND dzac012 = '", ms_dgenv, "' "

         #DISPLAY ls_sql
         PREPARE dzac_update_prep FROM ls_sql  
         EXECUTE dzac_update_prep USING ls_dzac099

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzac_t"
            #LET g_errparam.replace[2] = "dzac001 = '", g_gen_prog, "' AND dzac003 = '", ls_dzac003, "' AND dzac004 = ", g_design_point_ver, " AND dzac012 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzac001 = '", g_copy_source, "' AND dzac003 = '", ls_dzac003, "' AND dzac004 = ", ls_dzac004, " AND dzac012 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE ls_dzac099
      LOCATE ls_dzac099 IN FILE
   END FOREACH
  
   #DISPLAY "dzac_count = ", ln_cnt 

   FREE ls_dzac099
   FREE select_dzac_t
   FREE dzac_curs
   FREE dzac_prep  
   FREE dzac_update_prep

   #####dzad_t#####
   LOCATE ls_dzad099 IN FILE
   LET ls_sql = "SELECT dzadstus, dzad002, dzad003, dzad099, dzad006, dzad007 FROM dzad_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzad001 AND dzaa003=dzad002 AND dzaa004=dzad003 AND dzaa006=dzad005 "

   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='2' AND dzaa009='",g_source_identity,"' AND dzaastus='Y' "


   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF

   PREPARE select_dzad_t FROM ls_sql
   DECLARE dzad_curs CURSOR FOR select_dzad_t

   #一筆一筆複製資料
   #轉換表格：dzad099 (CLOB) 轉換欄位名稱、程式名稱。
   #不轉換表格:dzad099 (CLOB) 轉換程式名稱。

   LET ln_cnt = 0 
   FOREACH dzad_curs INTO ls_dzadstus, ls_dzad002, ls_dzad003, ls_dzad099, ls_dzad006, ls_dzad007

      LET ln_cnt = ln_cnt + 1 
      #g_use_table_replace="Y" or "N" 都轉換
      #20160627 add by elena 行業不轉換
      IF g_industry = "N" THEN
         LET ls_dzad099 = sadzp270_gen_replace_sql_str("dzad099", "dzad_t", ls_dzad099)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzad_t ",
                      "   (dzadstus, dzad001, dzad002, dzad003, dzad005, dzad006, dzad007, dzad008, ",
                      "    dzadownid, dzadowndp, dzadcrtid, dzadcrtdp, dzadcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzadstus, "', '", g_gen_prog, "', '", ls_dzad002, "', ", g_design_point_ver, ", '",  ms_dgenv, "', '", ls_dzad006, "', '", ls_dzad007, "', '",ms_cust, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "
 
         #ISPLAY ls_sql
         PREPARE dzad_prep FROM ls_sql  
         EXECUTE dzad_prep



         #避免資料內容有引號，先做取代
         #LET ls_dzad099 = cl_replace_str(ls_dzad099, "'", "''")

         LET ls_sql = "UPDATE dzad_t ",
                      #"   SET dzad099 = '", ls_dzad099, "' ",
                      "   SET dzad099 = ? ",
                      "WHERE dzad001 = '", g_gen_prog, "' AND dzad002 = '", ls_dzad002, "' AND dzad003 = ", g_design_point_ver, " AND dzad005 = '", ms_dgenv, "' "

         #DISPLAY ls_sql
         PREPARE dzad_update_prep FROM ls_sql  
         EXECUTE dzad_update_prep USING ls_dzad099


      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzad_t"
            #LET g_errparam.replace[2] = "dzad001 = '", g_gen_prog, "' AND dzad002 = '", ls_dzad002, "' AND dzad003 = ", g_design_point_ver, " AND dzad005 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzad001 = '", g_copy_source, "' AND dzad002 = '", ls_dzad002, "' AND dzad003 = ", ls_dzad003, " AND dzad005 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE ls_dzac099
      LOCATE ls_dzac099 IN FILE
   END FOREACH

   #DISPLAY "dzad_count = ", ln_cnt 
   FREE ls_dzad099
   FREE select_dzad_t
   FREE dzad_curs 
   FREE dzad_prep   
   FREE dzad_update_prep

   #####dzag_t#####

   LET ls_sql = "SELECT dzagstus, dzag002, dzag003, dzag004, dzag005, dzag007, dzag008, dzag009, dzag010 FROM dzag_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa004=dzag003 AND dzaa006=dzag006 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TABLE' AND dzaa005='4' ",
                  "AND dzaa009='",g_source_identity,"' AND dzaastus='Y' AND dzagstus='Y' "


   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql, g_dzaa_t_exculded_wc
   END IF

   PREPARE select_dzag_t FROM ls_sql
   DECLARE dzag_c_curs CURSOR FOR select_dzag_t

   #一筆一筆複製資料
   #轉換表格：dzag002、dzag004 轉換欄位名稱。
   #不轉換表格:無。

   LET ln_cnt = 0  
   FOREACH dzag_c_curs INTO ls_dzagstus, ls_dzag002, ls_dzag003, ls_dzag004, ls_dzag005, ls_dzag007, ls_dzag008, ls_dzag009, ls_dzag010

      LET ln_cnt = ln_cnt + 1  
      #g_use_table_replace="Y" or "N" 都轉換
      #20160627 add by elena  改成g_use_table_replace = "Y"時才轉換
      IF g_use_table_replace = "Y" THEN
         LET ls_dzag002 = sadzp270_gen_replace_sql_str("dzag002", "dzag_t", ls_dzag002)
         LET ls_dzag004 = sadzp270_gen_replace_sql_str("dzag004", "dzag_t", ls_dzag004)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzag_t ",
                      "   (dzagstus, dzag001, dzag002, dzag003, dzag004, dzag005, dzag006, ",
                      "    dzag007, dzag008, dzag009, dzag010, dzag011, dzag012, ",
                      "    dzagownid, dzagowndp, dzagcrtid, dzagcrtdp, dzagcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzagstus, "', '", g_gen_prog, "', '", ls_dzag002, "', ", g_design_point_ver, ", '", ls_dzag004 CLIPPED, "', '", ls_dzag005, "', '", ms_dgenv, "', '",
                           ls_dzag007, "', '", ls_dzag008 CLIPPED, "', '", ls_dzag009 CLIPPED, "', '", ls_dzag010 CLIPPED, "', '", ms_cust, "', '", ms_dgenv, "', '",
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzag_insert_prep FROM ls_sql   
         EXECUTE dzag_insert_prep


      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzag_t"
            #LET g_errparam.replace[2] = "dzag001 = '", g_gen_prog, "' AND dzag002 = '", ls_dzag002, "' AND dzag003 = ", g_design_point_ver, " AND dzag006 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzag001 = '", g_copy_source, "' AND dzag002 = '", ls_dzag002, "' AND dzag003 = ", ls_dzag003, " AND dzag006 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH

   #DISPLAY "dzag_count = ", ln_cnt  
   FREE select_dzag_t
   FREE dzag_c_curs
   FREE dzag_insert_prep  


   #####dzak_t#####
   LET ls_sql = "SELECT dzakstus, dzak002, dzak003, dzak005, dzak007, dzak008, dzak009, dzak010, dzak011 FROM dzak_t ",
                "INNER JOIN dzac_t ON dzac001=dzak001 AND dzac003=dzak002 AND dzac004=dzak003 AND dzac012=dzak004 ",
                "INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012 "

   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaa009='",g_source_identity,"' ",
                  " AND dzaastus='Y' AND dzacstus='Y'  AND dzakstus='Y' "

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF  


   PREPARE select_dzak_t FROM ls_sql
   DECLARE dzak_curs CURSOR FOR select_dzak_t

   #一筆一筆複製資料
   #轉換表格：dzak002  轉換欄位名稱、程式名稱。
   #不轉換表格:無。
   LET ln_cnt = 0  
   FOREACH dzak_curs INTO ls_dzakstus, ls_dzak002, ls_dzak003, ls_dzak005, ls_dzak007, ls_dzak008, ls_dzak009, ls_dzak010, ls_dzak011
 
      LET ln_cnt = ln_cnt + 1   
      #g_use_table_replace="Y"轉換
      IF g_use_table_replace = "Y" THEN
         LET ls_dzak002 = sadzp270_gen_replace_sql_str("dzak002", "dzak_t", ls_dzak002)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzak_t ",
                      "   (dzakstus, dzak001, dzak002, dzak003, dzak004, dzak005, dzak007, ",
                      "    dzak008, dzak009, dzak010, dzak011, dzak012, ",
                      "    dzakownid, dzakowndp, dzakcrtid, dzakcrtdp, dzakcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzakstus, "', '", g_gen_prog, "', '", ls_dzak002, "', ", g_design_point_ver, ", '", ms_dgenv, "', ? , '", ls_dzak007 CLIPPED, "', '", 
                           ls_dzak008 CLIPPED, "', '", ls_dzak009 CLIPPED, "', '", ls_dzak010 CLIPPED, "', '", ls_dzak011 CLIPPED, "', '", ms_cust, "', '",
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzak_prep FROM ls_sql  
         EXECUTE dzak_prep USING ls_dzak005


      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzak_t"
            #LET g_errparam.replace[2] = "dzak001 = '", g_gen_prog, "' AND dzak002 = '", ls_dzak002, "' AND dzak003 = ", g_design_point_ver, " AND dzak004 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzak001 = '", g_copy_source, "' AND dzak002 = '", ls_dzak002, "' AND dzak003 = ", ls_dzak003, " AND dzak004 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH
   
   #DISPLAY "dzak_count = ", ln_cnt 
   FREE select_dzak_t
   FREE dzak_curs
   FREE dzak_prep  


   #####dzai_t#####
   LET ls_sql = "SELECT dzaistus, dzai002, dzai003, dzai005, dzai007, dzai008, dzai009, dzai010, dzai011 FROM dzai_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzai001 AND dzaa003=dzai002 AND dzaa004=dzai003 AND dzaa006=dzai004 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='6'  AND dzaa009='",g_source_identity,"' AND dzaastus='Y' "

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF

   PREPARE select_dzai_t FROM ls_sql
   DECLARE dzai_curs CURSOR FOR select_dzai_t

   #一筆一筆複製資料
   #轉換表格：dzai002、005、007、008、009、010、011 轉換欄位名稱、程式名稱。
   #不轉換表格:無。

   LET ln_cnt = 0  
   FOREACH dzai_curs INTO ls_dzaistus, ls_dzai002, ls_dzai003, ls_dzai005, ls_dzai007, ls_dzai008, ls_dzai009, ls_dzai010, ls_dzai011

      LET ln_cnt = ln_cnt + 1  
      #g_use_table_replace="Y"轉換

      IF g_use_table_replace = "Y" THEN 
         LET ls_dzai002 = sadzp270_gen_replace_sql_str("dzai002", "dzai_t", ls_dzai002)
         LET ls_dzai005 = sadzp270_gen_replace_sql_str("dzai005", "dzai_t", ls_dzai005)
         LET ls_dzai007 = sadzp270_gen_replace_sql_str("dzai007", "dzai_t", ls_dzai007)
         LET ls_dzai008 = sadzp270_gen_replace_sql_str("dzai008", "dzai_t", ls_dzai008)
         LET ls_dzai009 = sadzp270_gen_replace_sql_str("dzai009", "dzai_t", ls_dzai009)
         LET ls_dzai010 = sadzp270_gen_replace_sql_str("dzai010", "dzai_t", ls_dzai010)
         LET ls_dzai011 = sadzp270_gen_replace_sql_str("dzai011", "dzai_t", ls_dzai011)
      END IF
 
      #dzai007內容如有引號，置換為雙引號
      #LET ls_dzai007 = cl_replace_str(ls_dzai007, "'", "''") 


      TRY

      LET ls_sql = "INSERT INTO dzai_t ",
                   "   (dzaistus, dzai001, dzai002, dzai003, dzai004, dzai005, dzai007, ",
                   "    dzai008, dzai009, dzai010, dzai011, dzai012, ",
                   "    dzaiownid, dzaiowndp, dzaicrtid, dzaicrtdp, dzaicrtdt) ",
                   "VALUES ",
                   "   ('", ls_dzaistus, "', '", g_gen_prog, "', '", ls_dzai002 CLIPPED, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ls_dzai005 CLIPPED, "', ? , '",
                            ls_dzai008 CLIPPED, "', '", ls_dzai009 CLIPPED, "', '", ls_dzai010 CLIPPED, "', '", ls_dzai011 CLIPPED, "', '", ms_cust, "', '",
                            l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "
  
      #DISPLAY ls_sql
      PREPARE dzai_prep FROM ls_sql   
      EXECUTE dzai_prep USING ls_dzai007
      

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzai_t"
            #LET g_errparam.replace[2] = "dzai001 = '", g_gen_prog, "' AND dzai002 = '", ls_dzai002, "' AND dzai003 = ", g_design_point_ver, " AND dzai004 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzai001 = '", g_copy_source, "' AND dzai002 = '", ls_dzai002, "' AND dzai003 = ", ls_dzai003, " AND dzai004 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH
  
   #DISPLAY "dzai_count = ", ln_cnt   
   FREE select_dzai_t
   FREE dzai_curs
   FREE dzai_prep  


   #####dzaj_t#####
   LOCATE ls_dzaj099 IN FILE
   LET ls_sql = "SELECT dzajstus, dzaj002, dzaj003, dzaj005, dzaj007, dzaj008, dzaj009, dzaj010, dzaj011 FROM dzaj_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzaj001 AND dzaa003=dzaj002 AND dzaa004=dzaj003 AND dzaa006=dzaj004 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='7' AND dzaa009='",g_source_identity,"' AND dzaastus='Y' "

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF

   PREPARE select_dzaj_t FROM ls_sql
   DECLARE dzaj_curs CURSOR FOR select_dzaj_t

   #一筆一筆複製資料
   #轉換表格：dzaj002、005、007、008、009、010、011、 dzaj099 (CLOB) 轉換欄位名稱、程式名稱。
   #不轉換表格:dzaj099 (CLOB) 轉換程式名稱。

   LET ln_cnt = 0  
   FOREACH dzaj_curs INTO ls_dzajstus, ls_dzaj002, ls_dzaj003, ls_dzaj005, ls_dzaj007, ls_dzaj008, ls_dzaj009, ls_dzaj010, ls_dzaj011

      LET ln_cnt = ln_cnt + 1  
      #g_use_table_replace="Y" or "N" 都轉換
      IF g_use_table_replace = "Y" THEN
         LET ls_dzaj002 = sadzp270_gen_replace_sql_str("dzaj002", "dzaj_t", ls_dzaj002)
         LET ls_dzaj005 = sadzp270_gen_replace_sql_str("dzaj005", "dzaj_t", ls_dzaj005)
         LET ls_dzaj007 = sadzp270_gen_replace_sql_str("dzaj007", "dzaj_t", ls_dzaj007)
         LET ls_dzaj008 = sadzp270_gen_replace_sql_str("dzaj008", "dzaj_t", ls_dzaj008)
         LET ls_dzaj009 = sadzp270_gen_replace_sql_str("dzaj009", "dzaj_t", ls_dzaj009)
         LET ls_dzaj010 = sadzp270_gen_replace_sql_str("dzaj010", "dzaj_t", ls_dzaj010)
         LET ls_dzaj011 = sadzp270_gen_replace_sql_str("dzaj011", "dzaj_t", ls_dzaj011)
      END IF
      #20160627 add by elena 行業不轉換
      IF g_industry = "N" THEN
         LET ls_dzaj099 = sadzp270_gen_replace_sql_str("dzaj099", "dzaj_t", ls_dzaj099)
      END IF

      TRY
      
         LET ls_sql = "INSERT INTO dzaj_t ",
                      "   (dzajstus, dzaj001, dzaj002, dzaj003, dzaj004, dzaj005, dzaj007, ",
                      "    dzaj008, dzaj009, dzaj010, dzaj011, dzaj012, ",
                      "    dzajownid, dzajowndp, dzajcrtid, dzajcrtdp, dzajcrtdt) ", 
                      "VALUES ",
                      "('", ls_dzajstus, "', '", g_gen_prog, "', '", ls_dzaj002, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ls_dzaj005, "', ? , '",
                        ls_dzaj008, "', '", ls_dzaj009, "', '", ls_dzaj010, "', '", ls_dzaj011, "', '", ms_cust, "', '",
                        l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzaj_prep FROM ls_sql  
         EXECUTE dzaj_prep USING ls_dzaj007


 
         #避免資料內容有引號，先做取代
         #LET ls_dzaj099 = cl_replace_str(ls_dzaj099, "'", "''")
            
         LET ls_sql = "UPDATE dzaj_t ",
                      #"   SET dzaj099 = '", ls_dzaj099, "'",
                      "   SET dzaj099 =  ? ",
                      "WHERE  dzaj001= '", g_gen_prog, "' AND dzaj002= '",  ls_dzaj002, "' AND dzaj003 = ", g_design_point_ver, " AND dzaj004 = '", ms_dgenv, "' "

         #DISPLAY ls_sql
         PREPARE dzaj_update_prep FROM ls_sql  
         EXECUTE dzaj_update_prep USING ls_dzaj099

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzaj_t"
            #LET g_errparam.replace[2] = "dzaj001= '", g_gen_prog, "' AND dzaj002= '",  ls_dzaj002, "' AND dzaj003 = ", g_design_point_ver, " AND dzaj004 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzaj001= '", g_copy_source, "' AND dzaj002= '",  ls_dzaj002, "' AND dzaj003 = ", ls_dzaj003, " AND dzaj004 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE ls_dzaj099
      LOCATE ls_dzaj099 IN FILE
   END FOREACH
 
   #DISPLAY "dzaj_count = ", ln_cnt  
   FREE ls_dzaj099
   FREE select_dzaj_t
   FREE dzaj_curs
   FREE dzaj_prep  
   FREE dzaj_update_prep

   #####dzal_t#####
   LET ls_sql = "SELECT dzalstus, dzal002, dzal003, dzal005, dzal006, dzal007, dzal008 FROM dzal_t ",
                "INNER JOIN dzac_t ON dzac001=dzal001 AND dzac003=dzal005 AND dzac004=dzal003 AND dzac012=dzal004 ",
                "INNER JOIN dzaa_t ON dzaa001=dzac001 AND dzaa003=dzac003 AND dzaa004=dzac004 AND dzaa006=dzac012 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='1' AND dzaa009='",g_source_identity,
                  "' AND dzaastus='Y'  AND dzacstus='Y'  AND dzalstus='Y' "


   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF

   PREPARE select_dzal_t FROM ls_sql
   DECLARE dzal_curs CURSOR FOR select_dzal_t

   #一筆一筆複製資料
   #轉換表格：dzal002、dzal005 轉換欄位名稱、程式名稱。
   #不轉換表格:無。
   LET ln_cnt = 0  
   FOREACH dzal_curs INTO ls_dzalstus, ls_dzal002, ls_dzal003, ls_dzal005, ls_dzal006, ls_dzal007, ls_dzal008

      LET ln_cnt = ln_cnt + 1  
      #g_use_table_replace="Y"轉換
      IF g_use_table_replace = "Y" THEN
         LET ls_dzal002 = sadzp270_gen_replace_sql_str("dzal002", "dzal_t", ls_dzal002)
         LET ls_dzal005 = sadzp270_gen_replace_sql_str("dzal005", "dzal_t", ls_dzal005)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzal_t ",
                      "   (dzalstus, dzal001, dzal002, dzal003, dzal004, dzal005, dzal006, ",
                      "    dzal007, dzal008, dzal009, dzalownid, dzalowndp, dzalcrtid, dzalcrtdp, dzalcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzalstus, "', '", g_gen_prog, "', '", ls_dzal002, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ls_dzal005, "', ? , '", 
                           ls_dzal007, "', '", ls_dzal008, "', '", ms_cust, "', '", l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzal_prep FROM ls_sql   
         EXECUTE dzal_prep USING ls_dzal006

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzal_t"
            #LET g_errparam.replace[2] = "dzal001 = '", g_gen_prog, "' AND dzal002 = '", ls_dzal002, "' AND dzal003 = ", g_design_point_ver, " AND dzal004 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzal001 = '", g_copy_source, "' AND dzal002 = '", ls_dzal002, "' AND dzal003 = ", ls_dzal003, " AND dzal004 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH

   #DISPLAY "dzal_count = ", ln_cnt  
   FREE select_dzal_t
   FREE dzal_curs
   FREE dzal_prep  


   #####dzff_t#####
   LET ls_sql = "SELECT dzffstus, dzff002, dzff003, dzff004, dzff005, dzff006, dzff007 FROM dzff_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzff001 AND dzaa003=dzff003 AND dzaa004=dzff002 AND dzaa006=dzff008 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa005='5' AND dzaa009='",g_source_identity,"' AND dzaastus='Y' AND dzffstus='Y' "

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF

   LET ls_sql = ls_sql, " ORDER BY dzff003, dzff004"

   PREPARE select_dzff_t FROM ls_sql
   DECLARE dzff_curs CURSOR FOR select_dzff_t

   #一筆一筆複製資料
   #轉換表格： dzff006、dzaf007 轉換欄位名稱、程式名稱。
   #不轉換表格:無。
   LET ln_cnt = 0 
   FOREACH dzff_curs INTO ls_dzffstus, ls_dzff002, ls_dzff003, ls_dzff004, ls_dzff005, ls_dzff006, ls_dzff007

      LET ln_cnt = ln_cnt + 1 
      #g_use_table_replace="Y"轉換
      IF g_use_table_replace = "Y" THEN
         LET ls_dzff006 = sadzp270_gen_replace_sql_str("dzff006", "dzff_t", ls_dzff006)
         LET ls_dzff007 = sadzp270_gen_replace_sql_str("dzff007", "dzff_t", ls_dzff007)
      END IF

      TRY
 
         LET ls_sql = "INSERT INTO dzff_t ",
                      "   (dzffstus, dzff001, dzff002, dzff003, dzff004, dzff005, dzff006, ",
                      "    dzff007, dzff008, dzff009, dzffownid, dzffowndp, dzffcrtid, dzffcrtdp, dzffcrtdt) ",
                      "VALUES ",
                      "   ('",ls_dzffstus, "', '", g_gen_prog, "', ", g_design_point_ver, ", '", ls_dzff003, "', '", ls_dzff004, "', '", ls_dzff005, "', '", ls_dzff006, "', '", 
                           ls_dzff007, "', '", ms_dgenv, "', '", ms_cust, "', '", l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzff_prep FROM ls_sql  
         EXECUTE dzff_prep

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzff_t"
            #LET g_errparam.replace[2] = "dzff001 = '", g_gen_prog, "' AND dzff002 = '", g_design_point_ver, "' AND dzff003 = ", ls_dzff003, " AND dzff005 = '", ls_dzff005, "' AND dzff008 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzff001 = '", g_copy_source, "' AND dzff002 = '", ls_dzff002, "' AND dzff003 = ", ls_dzff003, " AND dzff005 = '", ls_dzff005, "' AND dzff008 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH

   #DISPLAY "dzff_count = ", ln_cnt 
   FREE select_dzff_t
   FREE dzff_curs
   FREE dzff_prep  


   #####dzfs_t#####
   LET ls_sql = "SELECT dzfsstus, dzfs001, dzfs003, dzfs004, dzfs006, dzfs007, dzfs008, dzfs009, dzfs010 FROM dzfs_t ",
                "INNER JOIN dzag_t ON dzag001=dzfs002 AND dzag002=dzfs004 AND dzag003=dzfs001 AND dzag006=dzfs005 ",
                "INNER JOIN dzaa_t ON dzaa001=dzag001 AND dzaa004=dzag003 AND dzaa006=dzag006 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='TABLE' AND dzaa005='4' AND dzaa009='",g_source_identity,
                  "' AND dzaastus='Y' AND dzagstus='Y' AND dzfsstus='Y' "

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc
   END IF

   PREPARE select_dzfs_t FROM ls_sql
   DECLARE dzfs_curs CURSOR FOR select_dzfs_t

   #一筆一筆複製資料
   #轉換表格：dzfs003、dzfs004 轉換欄位名稱、程式名稱。
   #不轉換表格:dzfs003 (CLOB) 轉換程式名稱。

   LET ln_cnt = 0  
   FOREACH dzfs_curs INTO ls_dzfsstus, ls_dzfs001, ls_dzfs003, ls_dzfs004, ls_dzfs006, ls_dzfs007, ls_dzfs008, ls_dzfs009, ls_dzfs010

      LET ln_cnt = ln_cnt + 1  
      #g_use_table_replace="Y" or "N" 都轉換
      IF g_use_table_replace = "Y" THEN
         LET ls_dzfs004 = sadzp270_gen_replace_sql_str("dzfs004", "dzfs_t", ls_dzfs004)
      END IF
      #20160627 add by elena 行業不轉換
      IF g_industry = "N" THEN
         LET ls_dzfs003 = sadzp270_gen_replace_sql_str("dzfs003", "dzfs_t", ls_dzfs003)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzfs_t ",
                      "   (dzfsstus, dzfs001, dzfs002, dzfs003, dzfs004, dzfs005, ",
                      "    dzfs006, dzfs007, dzfs008, dzfs009, dzfs010, dzfs011, dzfs012, ",
                      "    dzfsownid, dzfsowndp, dzfscrtid, dzfscrtdp, dzfscrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzfsstus, "', ", g_design_point_ver, ", '", g_gen_prog, "', '", ls_dzfs003, "', '", ls_dzfs004, "', '", ms_dgenv, "', '",
                           ls_dzfs006, "', '", ls_dzfs007, "', '", ls_dzfs008, "', '", ls_dzfs009, "', '", ls_dzfs010, "', '", ms_cust, "', '", ms_dgenv, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzfs_prep FROM ls_sql  
         EXECUTE dzfs_prep
 

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzfs_t"
            #LET g_errparam.replace[2] = "dzfs001 = '", g_design_point_ver, "' AND dzfs002 = '", g_gen_prog, "' AND dzfs003 = ", ls_dzfs003, " AND dzfs005 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzfs001 = '", ls_dzfs001, "' AND dzfs002 = '", g_copy_source, "' AND dzfs003 = ", ls_dzfs003, " AND dzfs005 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH

   #DISPLAY "dzfs_count = ", ln_cnt  
   FREE select_dzfs_t
   FREE dzfs_curs
   FREE dzfs_prep  

   ##dzfq_t、gzzd_t、gzzg_t、gzzq_t刪除設計資料時並未列入刪除，需先檢核是否存在資料，存在的話需先刪除在進行新增。
   #####dzfq#####
   LET ls_sql = 
      "SELECT COUNT(*) FROM dzfq_t",
      " WHERE dzfq004 = '",g_gen_prog,"'",
      "   AND dzfq003 = '1'"
      PREPARE query_data_to_dzfq_t  FROM ls_sql
      LET ls_err = "error:query_data_to_dzfq_t"
      EXECUTE query_data_to_dzfq_t INTO ln_cnt
      IF ln_cnt > 0 THEN 
          LET ls_sql = "DELETE FROM dzfq_t WHERE dzfq004='",g_gen_prog,"' AND dzfq003='1'"
          EXECUTE IMMEDIATE ls_sql
      END IF


   LET ls_sql = "SELECT dzfqstus, dzfq001, dzfq002, dzfq003, dzfq005, dzfq006, dzfq007, dzfq008, dzfq009, dzfq010, dzfq011, dzfq012, dzfq013, dzfq014, dzfq015, dzfq016 FROM dzfq_t "
   LET ls_where = "WHERE dzfq004 = '", g_copy_source, "'"


   LET ls_sql = ls_sql , ls_where

   #IF g_use_table_replace = "Y" THEN
   #   LET ls_sql = ls_sql , g_dzaa_t_exculded_wc   #20150623 :mark by madey
   #END IF

   PREPARE select_dzfq_t FROM ls_sql
   DECLARE dzfq_curs CURSOR FOR select_dzfq_t

   #一筆一筆複製資料
   #轉換表格：無。
   #不轉換表格:無。
   LET ln_cnt = 0  
   FOREACH dzfq_curs INTO ls_dzfqstus, ls_dzfq001, ls_dzfq002, ls_dzfq003, ls_dzfq005, ls_dzfq006, ls_dzfq007, ls_dzfq008, ls_dzfq009, ls_dzfq010, ls_dzfq011, ls_dzfq012, ls_dzfq013, ls_dzfq014, ls_dzfq015, ls_dzfq016

      LET ln_cnt = ln_cnt + 1  
      #無轉換需求

      TRY

         LET ls_sql = "INSERT INTO dzfq_t ",
                      "   (dzfqstus, dzfq001, dzfq002, dzfq003, dzfq004, ",
                      "    dzfq005, dzfq006, dzfq007, dzfq008, dzfq009, dzfq010, ",
                      "    dzfq011, dzfq012, dzfq013, dzfq014, dzfq015, dzfq016, ",
                      "    dzfqownid, dzfqowndp, dzfqcrtid, dzfqcrtdp, dzfqcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzfqstus, "', '", ls_dzfq001, "', '", ls_dzfq002, "', ", g_design_point_ver, ", '", g_gen_prog, "', '", 
                           ls_dzfq005, "', '", ls_dzfq006, "', '", ls_dzfq007, "', '", ls_dzfq008, "', '", ls_dzfq009, "', '", ls_dzfq010, "', '", 
                           ls_dzfq011, "', '", ls_dzfq012, "', '", ls_dzfq013, "', '", ls_dzfq014, "', '", ls_dzfq015, "', '", ls_dzfq016, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzfq_prep FROM ls_sql   
         EXECUTE dzfq_prep

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzfq_t"
            #LET g_errparam.replace[2] = "dzfq003 = '", g_design_point_ver , "' AND dzfq004 = ", g_gen_prog, "'"
            LET g_errparam.replace[2] = "dzfq003 = '", ls_dzfq003 , "' AND dzfq004 = ", g_copy_source, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH

   #DISPLAY "dzfq_count = ", ln_cnt  
   FREE select_dzfq_t
   FREE dzfq_curs
   FREE dzfq_prep  

   #####gzzd_t#####
   LET ls_sql = 
      "SELECT COUNT(*) FROM gzzd_t
        WHERE gzzd001 = '",g_gen_prog,"'"
      PREPARE query_data_to_gzzd_t  FROM ls_sql
      LET ls_err = "error:query_data_to_gzzd_t"
      EXECUTE query_data_to_gzzd_t INTO ln_cnt
      IF ln_cnt > 0 THEN 
          LET ls_sql = "DELETE FROM gzzd_t WHERE gzzd001='",g_gen_prog,"'"
          EXECUTE IMMEDIATE ls_sql
      END IF


   LET ls_sql = "SELECT gzzdstus, gzzd002, gzzd003, gzzd004, gzzd005, gzzd006 FROM gzzd_t "
   LET ls_where = "WHERE gzzd001 = '",g_copy_source,"' AND gzzdstus='Y' "

   LET ls_sql = ls_sql , ls_where


   PREPARE select_gzzd_t FROM ls_sql
   DECLARE gzzd_c_curs CURSOR FOR select_gzzd_t

   #一筆一筆複製資料
   #轉換表格：gzzd003 轉換欄位名稱、程式名稱。
   #不轉換表格:gzzd003 轉換程式名稱。
   LET ln_cnt = 0  
   FOREACH gzzd_c_curs INTO ls_gzzdstus, ls_gzzd002, ls_gzzd003, ls_gzzd004, ls_gzzd005, ls_gzzd006 

      LET ln_cnt = ln_cnt + 1  
      #g_use_table_replace="Y" or "N" 都轉換
      #20160627 add by elena 行業不轉換
      IF g_industry = "N" THEN
         LET ls_gzzd003 = sadzp270_gen_replace_sql_str("gzzd003", "gzzd_t", ls_gzzd003)
      END IF

      TRY

         LET ls_sql = "INSERT INTO gzzd_t ",
                      "   (gzzdstus, gzzd001, gzzd002, gzzd003, gzzd004, gzzd005, gzzd006, ", 
                      "    gzzdownid, gzzdowndp, gzzdcrtid, gzzdcrtdp, gzzdcrtdt) ",
                      "VALUES ",
                      "   ('", ls_gzzdstus, "', '", g_gen_prog, "', '", ls_gzzd002, "', '", ls_gzzd003, "', '", ls_gzzd004, "', ? , '", ls_gzzd006 CLIPPED, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE gzzd_prep FROM ls_sql   
         EXECUTE gzzd_prep USING ls_gzzd005

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "gzzd_t"
            #LET g_errparam.replace[2] = "gzzd001 = '", g_gen_prog, "' AND gzzd002 = '", ls_gzzd002, "' AND gzzd003 = ", ls_gzzd003, " AND gzzd004 = '", ls_gzzd004, "'"
            LET g_errparam.replace[2] = "gzzd001 = '", g_copy_source, "' AND gzzd002 = '", ls_gzzd002, "' AND gzzd003 = ", ls_gzzd003, " AND gzzd004 = '", ls_gzzd004, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH

   #DISPLAY "gzzd_count = ", ln_cnt  
   FREE select_gzzd_t
   FREE gzzd_c_curs
   FREE gzzd_prep


   #####gzzq#####
   LET ls_sql = 
      "SELECT COUNT(*) FROM gzzq_t
        WHERE gzzq001 = '",g_gen_prog,"'"
      PREPARE query_data_to_gzzq_t  FROM ls_sql
      LET ls_err = "error:query_data_to_gzzq_t"
      EXECUTE query_data_to_gzzq_t INTO ln_cnt
      IF ln_cnt > 0 THEN 
          LET ls_sql = "DELETE FROM gzzq_t WHERE gzzq001='",g_gen_prog,"'"
          EXECUTE IMMEDIATE ls_sql
      END IF

   #20160627 add by elena  行業不轉換
   IF g_industry = "Y" THEN
      LET ls_sql =
         "SELECT gzzq002",
         "  FROM gzzq_t
           WHERE gzzq001 = '",g_copy_source,"'"
   ELSE
      LET ls_sql =
         "SELECT REPLACE(gzzq002,'",
         g_copy_source,"','",
         g_gen_prog,"') gzzq002",
         "  FROM gzzq_t
           WHERE gzzq001 = '",g_copy_source,"'"
   END IF
   LET ls_err = "error:insert_data_to_gzzq_t"
   CALL sadzp270_insert_gzzq_t(ls_sql)
   
   #####gzzp_t#####
   LET ls_sql = 
      "SELECT COUNT(*) FROM gzzp_t
        WHERE gzzp001 = '",g_gen_prog,"'"
      PREPARE query_data_to_gzzp_t_2  FROM ls_sql
      LET ls_err = "error:query_data_to_gzzp_t"
      EXECUTE query_data_to_gzzp_t_2 INTO ln_cnt
      IF ln_cnt > 0 THEN 
          LET ls_sql = "DELETE FROM gzzp_t WHERE gzzp001='",g_gen_prog,"'"
          EXECUTE IMMEDIATE ls_sql
      END IF

   LET ls_sql = "SELECT gzzpstus, gzzp002, gzzp003, gzzp004, gzzp005 FROM gzzp_t "
   LET ls_where = "WHERE gzzp001='",g_copy_source,"' AND gzzpstus='Y' "

   LET ls_sql = ls_sql , ls_where


   PREPARE select_gzzp_t FROM ls_sql
   DECLARE gzzp_curs CURSOR FOR select_gzzp_t

   #一筆一筆複製資料
   #轉換表格：無。
   #不轉換表格:無。
   LET ln_cnt = 0  
   FOREACH gzzp_curs INTO ls_gzzpstus, ls_gzzp002, ls_gzzp003, ls_gzzp004, ls_gzzp005

      LET ln_cnt = ln_cnt + 1  
      TRY

         LET ls_sql = "INSERT INTO gzzp_t ",
                      "   (gzzpstus, gzzp001, gzzp002, gzzp003, gzzp004, gzzp005, ",
                      "    gzzpownid, gzzpowndp, gzzpcrtid, gzzpcrtdp, gzzpcrtdt) ",
                      "VALUES ",
                      "   ('", ls_gzzpstus, "', '", g_gen_prog, "', '", ls_gzzp002, "', '", ls_gzzp003, "', ?, '", ls_gzzp005, "', '",
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "
         #DISPLAY ls_sql
         PREPARE gzzp_prep FROM ls_sql  
         EXECUTE gzzp_prep using ls_gzzp004

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "gzzp_t"
            #LET g_errparam.replace[2] = "gzzp001 = '", g_gen_prog, "' AND gzzp002 = '", ls_gzzp002, "'"
            LET g_errparam.replace[2] = "gzzp001 = '", g_copy_source, "' AND gzzp002 = '", ls_gzzp002, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH
 
   #DISPLAY "gzzp_count = ", ln_cnt  
   FREE select_gzzp_t
   FREE gzzp_curs
   FREE gzzp_prep               

   END IF

   #####dzba_t#####

   #報表刪除所有資料
   IF g_source_type = "X" or g_source_type = "G" THEN
      DELETE FROM dzba_t WHERE dzba001 = g_gen_prog      
   END IF
 
   #查詢條件剃除dzba003包含 _customerization資料
   LET ls_sql = "SELECT dzbastus, dzba002, dzba003, dzba006, dzba007, dzba009 FROM dzba_t "
   LET ls_where = "WHERE dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y' ",
                  " AND dzba003 not like '%customerization%'"

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzba_t_exculded_wc
   END IF

   PREPARE select_dzba_t FROM ls_sql
   DECLARE dzba_curs CURSOR FOR select_dzba_t


   #一筆一筆複製資料
   #轉換表格：dzba003 轉換欄位名稱、程式名稱。
   #不轉換表格:dzba003 轉換程式名稱。
   LET ln_cnt = 0  
   FOREACH dzba_curs INTO ls_dzbastus, ls_dzba002, ls_dzba003, ln_dzba006, ls_dzba007, ls_dzba009  #elena  20150703  add ls_dzba007 for 行業別引用

      LET ln_cnt = ln_cnt + 1 

      #行業別，dzba003開頭不為function、dialog、report時，替換程式代號；反之，原值複製
      #20160627 modify by elena 行業不轉換
      #非行業別，g_use_table_replace="Y" or "N" 都轉換
      IF g_industry = "Y" THEN
         #LET ls_test = base.StringBuffer.create()
         #CALL ls_test.append(ls_dzba003)
         #IF  ls_test.getIndexOf('function.',1) <=0 AND  ls_test.getIndexOf('dialog.',1) <= 0 AND ls_test.getIndexOf('report.',1) <= 0 THEN
         #   LET ls_dzba003 =  sadzp270_gen_replace_sql_str("dzba003", "dzba_t", ls_dzba003)
         #END IF

         #行業別dzba007=Y   #elena 20150703
         LET ls_dzba007 = "Y"
      ELSE

         #Begin:20160627 add by elena:addpoint name中包含來源程式代號的，再進一步檢查是否為OnAction，無程式代號則忽略，有程式代號且非OnAction則轉換
         LET ls_copy_source = g_copy_source CLIPPED
         LET ls_action = ls_dzba003 CLIPPED
         LET lb_action = FALSE
         IF ls_action.getindexof(ls_copy_source,1) >1 THEN
            IF ls_action.getindexof('function.',1)>0 OR ls_action.getindexof('dialog.',1)>0 OR ls_action.getindexof('report.',1)>0 THEN
               #function、dialog、report 要轉換
            ELSE
               CALL sadzp270_split_return_last_substring(ls_action,'.') RETURNING ls_action
               CALL json_on_action.has(ls_action) RETURNING lb_action
            END IF
         ELSE
            #addpoint name未包含程式代號，不進行轉換
            LET lb_action = TRUE
         END IF
         IF NOT lb_action THEN
            LET ls_dzba003 = sadzp270_gen_replace_sql_str("dzba003", "dzba_t", ls_dzba003)
         END IF
         #End:20160627

         #非行業別 dzba007=N  #elena 20150703
         LET ls_dzba007 = "N"
      END IF

      #dzba006除去空白
      LET ls_dzba006 = ln_dzba006
      LET ls_dzba006 = ls_dzba006 CLIPPED


      TRY

         LET ls_sql = "INSERT INTO dzba_t ",
                      "   (dzbastus, dzba001, dzba002, dzba003, dzba004, dzba005, ",
                      "    dzba006, dzba007, dzba008, dzba009, dzba010, dzba011, ",
                      "    dzbaownid, dzbaowndp, dzbacrtid, dzbacrtdp, dzbacrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzbastus, "', '", g_gen_prog, "', ", g_gen_spec_ver, ", '", ls_dzba003, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", 
                           ls_dzba006 CLIPPED, "', '", ls_dzba007 , "', '", ms_erpver, "', '", ls_dzba009 CLIPPED, "', '", ms_dgenv, "', '", ms_cust, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP ) "

         #DISPLAY ls_sql
         PREPARE dzba_prep FROM ls_sql  
         EXECUTE dzba_prep
 
         #20161003 add by elena 來源不為解開section、非freestyle且目標為客製程式時，才需做_customerization轉換動作
         IF ms_dgenv = "c" AND g_section_modify = "N" AND g_freestyle = "N"  THEN

            LET ls_dzba003_c = ls_dzba003, "_customerization"
            LET ls_test = base.StringBuffer.create()
            CALL ls_test.append(ls_dzba003)
            #20160712 modify by elena  剔除function.,report.,dialog
            IF ls_test.getIndexOf('function.',1) >0 OR ls_test.getIndexOf('report.',1) >0 OR ls_test.getIndexOf('dialog.',1) >0 THEN
            ELSE
               IF ls_test.getIndexOf('define',1) >0 OR ls_dzba003 == "global.variable" THEN


                  #先查詢是否已存在此筆資料，
                  LET ls_sql = "SELECT count(*) FROM dzba_t ",
                               "WHERE dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzba003 = '", ls_dzba003_c ,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y' "
 
                  PREPARE count_dzba_t  FROM ls_sql
                  EXECUTE count_dzba_t  INTO ln_addpoint_cnt

                  #查詢結果>0，複製資料後新增;查詢結果<=0，直接新增
                  IF ln_addpoint_cnt > 0 THEN
                         
                     #查詢出客製資料(_customerization)後，將客製資料進行複製
                     LET ls_sql = "SELECT dzbastus, dzba002, dzba003, dzba006, dzba009 FROM dzba_t ",
                                  "WHERE dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzba003 = '", ls_dzba003_c ,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y' "
                     PREPARE select_dzba_c_t FROM ls_sql
                     DECLARE dzba_c_curs CURSOR FOR select_dzba_c_t

                     FOREACH dzba_c_curs INTO ls_dzbastus_c, ls_dzba002_c, ls_dzba003_c, ln_dzba006_c, ls_dzba009_c
                       
                        LET ls_dzba006_c = ln_dzba006_c
                        
                        LET ls_sql = "INSERT INTO dzba_t ",
                                     "   (dzbastus, dzba001, dzba002, dzba003, dzba004, dzba005, ",
                                     "    dzba006, dzba007, dzba008, dzba009, dzba010, dzba011, ",
                                     "    dzbaownid, dzbaowndp, dzbacrtid, dzbacrtdp, dzbacrtdt) ",
                                     "VALUES ",
                                     "   ('", ls_dzbastus, "', '", g_gen_prog, "', ", g_gen_spec_ver, ", '", ls_dzba003_c, "', ", g_design_point_ver, ", '", ms_dgenv, "', '",
                                              ls_dzba006_c CLIPPED, "', 'N", "', '", ms_erpver, "', '", ls_dzba009_c CLIPPED, "', '", ms_dgenv, "', '", ms_cust, "', '",
                                              l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP ) "
                        
                        PREPARE dzba_prep_c1 FROM ls_sql  
                        EXECUTE dzba_prep_c1

                     END FOREACH 
                  ELSE
                     #BEGIN:20161013 mark by elena 如果原先無此客製addpoint，則不新增
                     #LET ls_sql = "INSERT INTO dzba_t ",
                     #             "   (dzbastus, dzba001, dzba002, dzba003, dzba004, dzba005, ",
                     #             "    dzba006, dzba007, dzba008, dzba009, dzba010, dzba011, ",
                     #             "    dzbaownid, dzbaowndp, dzbacrtid, dzbacrtdp, dzbacrtdt) ",
                     #             "VALUES ",
                     #             "   ('", ls_dzbastus, "', '", g_gen_prog, "', ", g_gen_spec_ver, ", '", ls_dzba003_c, "', ", g_design_point_ver, ", '", ms_dgenv, "', '",
                     #                      ls_dzba006 CLIPPED, "', 'N", "', '", ms_erpver, "', '", ls_dzba009 CLIPPED, "', '", ms_dgenv, "', '", ms_cust, "', '",
                     #                      l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP ) "


                     #PREPARE dzba_prep_c2 FROM ls_sql  
                     #EXECUTE dzba_prep_c2
                     #END:20161013 mark by elena

                  END IF
               END IF
            END IF
         END IF   


      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzba_t"
            #LET g_errparam.replace[2] = "dzba001 = '", g_gen_prog, "' AND dzba002 = '", g_gen_spec_ver, "' AND dzba003 = ", ls_dzba003, " AND dzba010 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzba001 = '", g_copy_source, "' AND dzba002 = '", ls_dzba002, "' AND dzba003 = ", ls_dzba003, " AND dzba010 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH
 
   #DISPLAY "dzba_count = ", ln_cnt  
   FREE select_dzba_t
   FREE dzba_curs
   FREE dzba_prep 

   #BUGIN:20160729 add by elena
   #####dzbu_t#####
   IF g_industry = "Y" THEN
       DELETE FROM DZBU_T WHERE DZBU001 = g_gen_prog
       LET ls_sql = "INSERT INTO dzbu_t(dzbu001,dzbu003,dzbu004)",
                   " SELECT '",g_gen_prog,"',dzba003,dzba004 FROM dzba_t",
                   "  WHERE dzba001='",g_gen_prog,"'",
                   "    AND dzba002=",g_gen_spec_ver
      PREPARE dzbu_prep2 FROM ls_sql
      EXECUTE dzbu_prep2
      FREE dzbu_prep2

   END IF
   #END:20160729
    
   #####dzbb_t#####
   LOCATE ls_dzbb098 IN FILE
   LOCATE ls_dzbb098_c IN FILE

   #報表刪除所有資料
   IF g_source_type = "X" or g_source_type = "G" THEN
      DELETE FROM dzbb_t WHERE dzbb001 = g_gen_prog      
   END IF

   #查詢條件剔除_customerization 
   LET ls_sql = "SELECT dzbbstus, dzbb002, dzbb003, dzbb098, dzbb006 FROM dzbb_t ",
                "INNER JOIN dzba_t ON dzba001 = dzbb001 AND dzba004 = dzbb003 AND dzba003 = dzbb002 AND dzba005 = dzbb004 "
   LET ls_where = "WHERE dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y' ",
                  " AND dzbb002 not like '%customerization%' "

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzba_t_exculded_wc
   END IF

   PREPARE select_dzbb_t FROM ls_sql
   DECLARE dzbb_curs CURSOR FOR select_dzbb_t
   #BEGIN:20160704 add by elena
   #在行業環境時，一個一個add point 尋找是否存在CREATE TEMP TABLE字串，有則記錄該temp table
   IF g_industry = "N" AND sadzp060_ind_check_area() THEN
      LET ls_dzbb098_buffer = base.StringBuffer.create()
      LET json_temp_table = util.JSONObject.create()
      LET ln_cnt = 0
      FOREACH dzbb_curs INTO ls_dzbbstus, ls_dzbb002, ls_dzbb003, ls_dzbb098, ls_dzbb006

         LET ln_cnt = ln_cnt + 1
         CALL ls_dzbb098_buffer.clear()
         CALL ls_dzbb098_buffer.append(ls_dzbb098)
         IF ls_dzbb098_buffer.getindexof("CREATE TEMP TABLE",1)>0 THEN

            #以行為單位拆開
            LET ls_dzbb098_tmp_line = base.StringTokenizer.create(ls_dzbb098, "\n")
            WHILE ls_dzbb098_tmp_line.hasMoreTokens()
               LET ls_str = ls_dzbb098_tmp_line.nextToken()
               #DISPLAY ls_str
               CALL ls_dzbb098_buffer.clear()
               CALL ls_dzbb098_buffer.append(ls_str)

               IF ls_dzbb098_buffer.getindexof("CREATE TEMP TABLE",1)>0 THEN
                  LET ls_dzbb098_tmp = base.StringTokenizer.create(ls_str, " ")
                  WHILE ls_dzbb098_tmp.hasMoreTokens()
                     LET ls_str = ls_dzbb098_tmp.nextToken()
                     DISPLAY ls_str
                     IF NOT cl_null(ls_str) THEN
                        IF ls_str =="CREATE" THEN
                           LET ls_str = ls_dzbb098_tmp.nextToken()
                           IF ls_str =="TEMP" THEN
                              LET ls_str = ls_dzbb098_tmp.nextToken()
                              IF ls_str =="TABLE" THEN
                                 LET ls_str = ls_dzbb098_tmp.nextToken()
                                 #temp table name有包含程式代號才加入
                                 IF ls_str.getindexof(g_copy_source,1) > 0 THEN
                                    CALL json_temp_table.put(ls_str,1)
                                 END IF
                              END IF
                           END IF
                        END IF
                     END IF
                  END WHILE
               END IF
            END WHILE
         END IF

      END FOREACH
   END IF



   #END:20160704


   #一筆一筆複製資料
   #轉換表格：dzbb002、dzbb098 (CLOB) 轉換欄位名稱、程式名稱。
   #不轉換表格:dzbb002、dzbb098 (CLOB) 轉換程式名稱。
   LET ln_cnt = 0  
   FOREACH dzbb_curs INTO ls_dzbbstus, ls_dzbb002, ls_dzbb003, ls_dzbb098, ls_dzbb006

      LET ln_cnt = ln_cnt + 1 

      #行業別，dzbb002開頭不為function、dialog、report時，替換程式代號；反之，原值複製
      #20160627 modify by elena 行業不轉換
      #非行業別，g_use_table_replace="Y" or "N" 都轉換
      IF g_industry = "Y" THEN
         #LET ls_test = base.StringBuffer.create()
         #CALL ls_test.append(ls_dzbb002)
         #IF  ls_test.getIndexOf('function.',1) <=0 AND  ls_test.getIndexOf('dialog.',1) <= 0 AND ls_test.getIndexOf('report.',1) <= 0 THEN
         #   LET ls_dzbb002 = sadzp270_gen_replace_sql_str("dzbb002", "dzbb_t", ls_dzbb002)
         #END IF  
      ELSE
         #BEGIN:20160704   先用特殊符號置換temp table name，最後再置換回來
         IF g_industry = "N" AND sadzp060_ind_check_area() THEN
            CALL ls_dzbb098_buffer.clear()
            CALL ls_dzbb098_buffer.append(ls_dzbb098)

            LET ls_copy_source = g_copy_source CLIPPED           
 
            FOR ln_cnt = 1 TO json_temp_table.getLength()
               LET ls_str = " ",json_temp_table.name(ln_cnt)
               LET ls_str_tmp = ls_copy_source.substring(1,3),"¥", ls_copy_source.substring(4,ls_copy_source.getLength())
               LET ls_replace = cl_replace_str( ls_str, ls_copy_source, ls_str_tmp)    #ls_str.substring(1,4),"¥",ls_str.substring(5,ls_str.getLength())
               DISPLAY ls_str
               DISPLAY ls_replace
               IF ls_dzbb098_buffer.getindexof(ls_str,1)>0 THEN
                  CALL ls_dzbb098_buffer.replace(ls_str,ls_replace,0)
               END IF
            END FOR
            LET ls_dzbb098 = ls_dzbb098_buffer.toString()
         END IF
         #END:20160704

         #Begin:20160627 add by elena:addpoint name中包含來源程式代號的，再進一步檢查是否為OnAction，無程式代號則忽略，有程式代號且非OnAction則轉換
         LET ls_copy_source = g_copy_source CLIPPED
         LET ls_action = ls_dzbb002 CLIPPED
         LET lb_action = FALSE
         IF ls_action.getindexof(ls_copy_source,1) >1 THEN
            IF ls_action.getindexof('function.',1)>0 OR ls_action.getindexof('dialog.',1)>0 OR ls_action.getindexof('report.',1)>0 THEN
               #function、dialog、report 要轉換
            ELSE
               CALL sadzp270_split_return_last_substring(ls_action,'.') RETURNING ls_action
               CALL json_on_action.has(ls_action) RETURNING lb_action
            END IF
         ELSE
            #addpoint name未包含程式代號，不進行轉換
            LET lb_action = TRUE
         END IF
         #非ON ACTION需進行轉換
         IF NOT lb_action THEN
            LET ls_dzbb002 = sadzp270_gen_replace_sql_str("dzbb002", "dzbb_t", ls_dzbb002)
         END IF
         #End:20160627

         LET ls_dzbb098 = sadzp270_gen_replace_sql_str("dzbb098", "dzbb_t", ls_dzbb098)

         #BEGIN:20160704
         IF g_industry = "N" AND sadzp060_ind_check_area() THEN
            CALL ls_dzbb098_buffer.clear()
            CALL ls_dzbb098_buffer.append(ls_dzbb098)
            LET ls_copy_source = g_copy_source CLIPPED

            FOR ln_cnt = 1 TO json_temp_table.getLength()
               LET ls_str = " ",json_temp_table.name(ln_cnt)
               LET ls_str_tmp = ls_copy_source.substring(1,3),"¥", ls_copy_source.substring(4,ls_copy_source.getLength())
               LET ls_replace = cl_replace_str( ls_str, ls_copy_source, ls_str_tmp)    #ls_str.substring(1,4),"¥",ls_str.substring(5,ls_str.getLength())           
 

               #LET ls_str = json_temp_table.name(ln_cnt)
               #LET ls_str = " ", ls_str.substring(1,3),"¥",ls_str.substring(4,ls_str.getLength())
               #LET ls_replace = " ",json_temp_table.name(ln_cnt)
               DISPLAY ls_str
               DISPLAY ls_replace
               IF ls_dzbb098_buffer.getindexof(ls_replace,1)>0 THEN
                  #CALL ls_dzbb098_buffer.replace(ls_str,ls_replace,0)
                  CALL ls_dzbb098_buffer.replace(ls_replace,ls_str,0)
               END IF
            END FOR
            LET ls_dzbb098=ls_dzbb098_buffer.toString()
         END IF
         #END:20160704

      END IF
      


      TRY

         LET ls_sql = "INSERT INTO dzbb_t ", 
                      "   (dzbbstus, dzbb001, dzbb002, dzbb003, dzbb004, dzbb005, dzbb006, ",
                      "    dzbbownid, dzbbowndp, dzbbcrtid, dzbbcrtdp, dzbbcrtdt ) ",
                      "VALUES ",
                      "   ('", ls_dzbbstus CLIPPED, "', '", g_gen_prog, "', '", ls_dzbb002, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ms_cust, "', '", ls_dzbb006 CLIPPED, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP ) "
         #DISPLAY ls_sql
         PREPARE dzbb_prep FROM ls_sql   
         EXECUTE dzbb_prep

 
         LET ls_sql = "UPDATE dzbb_t ",
                      #"   SET dzbb098 = '", ls_dzbb098, "' ",
                      "   SET dzbb098 =  ? ",
                      "WHERE dzbb001 = '", g_gen_prog,"' AND dzbb002 = '", ls_dzbb002, "' AND dzbb003 = ", g_design_point_ver, " AND dzbb004 = '", ms_dgenv, "'"

         #DISPLAY ls_sql
         PREPARE dzbb_update_prep FROM ls_sql  
         EXECUTE dzbb_update_prep USING ls_dzbb098

         #20161003 add by elena 來源不為解開section、不為freestyle且目標為客製程式時，才需做_customerization轉換動作
         IF ms_dgenv = "c"  AND g_section_modify = "N" AND g_freestyle = "N" THEN

            LET ls_dzbb002_c = ls_dzbb002, "_customerization"
            LET ls_test = base.StringBuffer.create()
            CALL ls_test.append(ls_dzbb002)
            #20160712 modify by elena  剔除function,report,dialog
            IF ls_test.getIndexOf('function.',1) >0 OR ls_test.getIndexOf('report.',1) > 0 OR ls_test.getIndexOf('dialog.',1) > 0 THEN
            ELSE
               IF ls_test.getIndexOf('define',1) >0 OR ls_dzbb002 == "global.variable" THEN

                  LET ls_dzbb002_c = ls_dzbb002, "_customerization"

                  #查詢是否存在資料
                  LET ls_sql = "SELECT COUNT(*) FROM dzbb_t ",
                               "INNER JOIN dzba_t ON dzba001 = dzbb001 AND dzba004 = dzbb003 AND dzba003 = dzbb002 AND dzba005 = dzbb004 ",
                               "WHERE dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y' AND dzbb002='", ls_dzbb002_c ,"' "
                  PREPARE count_dzbb_t  FROM ls_sql
                  EXECUTE count_dzbb_t  INTO ln_addpoint_cnt

                  IF ln_addpoint_cnt > 0 THEN 
                   
                     LET ls_sql = "SELECT dzbbstus, dzbb002, dzbb003, dzbb098, dzbb006 FROM dzbb_t ",
                                  "INNER JOIN dzba_t ON dzba001 = dzbb001 AND dzba004 = dzbb003 AND dzba003 = dzbb002 AND dzba005 = dzbb004 ",
                                  "WHERE  dzba001='",g_copy_source,"' AND dzba002='",g_source_code_ver,"' AND dzba010='",g_source_identity,"' AND dzbastus='Y' AND dzbb002 = '", ls_dzbb002_c ,"' "
 
                     PREPARE select_dzbb_c_t FROM ls_sql
                     DECLARE dzbb_c_curs CURSOR FOR select_dzbb_c_t

                     FOREACH dzbb_c_curs INTO ls_dzbbstus_c, ls_dzbb002_c, ls_dzbb003_c, ls_dzbb098_c, ls_dzbb006_c

                        #新增資料後，將標準dzbb098資料append到複製dzbb098後更新dzbb098
                        LET ls_sql = "INSERT INTO dzbb_t ",
                                     "   (dzbbstus, dzbb001, dzbb002, dzbb003, dzbb004, dzbb005, dzbb006, ",
                                     "    dzbbownid, dzbbowndp, dzbbcrtid, dzbbcrtdp, dzbbcrtdt ) ",
                                     "VALUES ",
                                     "   ('", ls_dzbbstus_c, "', '", g_gen_prog, "', '", ls_dzbb002_c, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ms_cust, "', '", ls_dzbb006_c, "', '",
                                              l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP ) "
                        PREPARE dzbb_prep_c1 FROM ls_sql  
                        EXECUTE dzbb_prep_c1                   


                        #更新dzbb098
                        CALL ls_test.clear()
                        CALL ls_test.append(ls_dzbb098_c)
                        #CALL ls_test.append(ls_dzbb098)  #20161013  mark by elena  標準addpoint內容不移至客製addpoint
                        LET ls_dzbb098 = ls_test.toString()

                        LET ls_sql = "UPDATE dzbb_t ",
                                     #"   SET dzbb098 = '", ls_test.toString(), "' ",
                                     "   SET dzbb098 =  ? ",
                                     "WHERE dzbb001 = '", g_gen_prog,"' AND dzbb002 = '", ls_dzbb002_c, "' AND dzbb003 = ", g_design_point_ver, " AND dzbb004 = '", ms_dgenv, "'"

                        PREPARE dzbb_update_prep_c1 FROM ls_sql  
                        EXECUTE dzbb_update_prep_c1 USING ls_dzbb098

                     END FOREACH

                  ELSE
                     #BEGIN:20161013 mark by elena 如果原先無此客製addpoint，則不新增
                     #LET ls_sql = "INSERT INTO dzbb_t ",
                     #                "   (dzbbstus, dzbb001, dzbb002, dzbb003, dzbb004, dzbb005, dzbb006, ",
                     #                "    dzbbownid, dzbbowndp, dzbbcrtid, dzbbcrtdp, dzbbcrtdt ) ",
                     #                "VALUES ",
                     #                "   ('", ls_dzbbstus, "', '", g_gen_prog, "', '", ls_dzbb002_c, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ms_cust, "', '", ls_dzbb006, "', '",
                     #                         l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP ) "
                     #PREPARE dzbb_prep_c2 FROM ls_sql
                     #EXECUTE dzbb_prep_c2

                     ##更新dzbb098
                     ##CALL ls_test.clear()
                     ##CALL ls_test.append(ls_dzbb098)
                     #
 
                     #LET ls_sql = "UPDATE dzbb_t ",
                     #             #"   SET dzbb098 = '", ls_test.toString(), "' ",
                     #             "   SET dzbb098 =  ? ",
                     #             "WHERE dzbb001 = '", g_gen_prog,"' AND dzbb002 = '", ls_dzbb002_c, "' AND dzbb003 = ", g_design_point_ver, " AND dzbb004 = '", ms_dgenv, "'"

                     #PREPARE dzbb_update_prep_c2 FROM ls_sql  
                     #EXECUTE dzbb_update_prep_c2 USING ls_dzbb098
                     #END:20161013 mark by elena

                  END IF  


                  #BEGIN:20161013 mark by elena define段和global.variable標準addpoint內容不清空
                  ##清空複製標準的dzbb098資料
                  #CALL ls_test.clear()
                  #LET ls_sql = "UPDATE dzbb_t ",
                  #             "   SET dzbb098 = '' ",
                  #             "WHERE dzbb001 = '" , g_gen_prog , "' AND dzbb002= '" , ls_dzbb002 , "' AND dzbb003 = '" , g_design_point_ver , "' AND dzbb004 = '" , ms_dgenv , "' "

                  #PREPARE dzbb_delete_prep FROM ls_sql
                  #EXECUTE dzbb_delete_prep
                  #END:20161013 mark by elena
 
               END IF
            END IF
         END IF

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            IF SQLCA.SQLCODE = -6372 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00593"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = "dzbb_t"
               #LET g_errparam.replace[2] = "dzbb001 = '", g_gen_prog, "' and dzbb002 = '", ls_dzbb002, "' and dzbb003 = '", g_design_point_ver, "' and dzbb004 = '", ms_dgenv, "'"
               LET g_errparam.replace[2] = "dzbb001 = '", g_copy_source, "' and dzbb002 = '", ls_dzbb002, "' and dzbb003 = '", ls_dzbb003, "' and dzbb004 = '", ms_dgenv, "'"
               LET g_errparam.replace[3] = "dzbb098"
               CALL cl_err()
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00592" 
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = "dzbb_t"
               #LET g_errparam.replace[2] = "dzbb001 = '", g_gen_prog, "' and dzbb002 = '", ls_dzbb002, "' and dzbb003 = '", g_design_point_ver, "' and dzbb004 = '", ms_dgenv, "'"
               LET g_errparam.replace[2] = "dzbb001 = '", g_copy_source, "' and dzbb002 = '", ls_dzbb002, "' and dzbb003 = '", ls_dzbb003, "' and dzbb004 = '", ms_dgenv, "'"
               CALL cl_err()
            END IF
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE ls_dzbb098
      FREE ls_dzbb098_c
      LOCATE ls_dzbb098 IN FILE
      LOCATE ls_dzbb098_c IN FILE
   END FOREACH
   #DISPLAY "dzbb_count ", ln_cnt  
   FREE ls_dzbb098
   FREE select_dzbb_t
   FREE dzbb_curs
   FREE dzbb_prep  
   FREE dzbb_update_prep

   #####dzbc_t#####
   
   #報表刪除所有資料
   IF g_source_type = "X" or g_source_type = "G" THEN
      DELETE FROM dzbc_t WHERE dzbc001 = g_gen_prog      
   END IF
 
   LET ls_sql = "SELECT dzbcstus, dzbc002, dzbc003, dzbc004, dzbc005, dzbc009, dzbc010, dzbc011 FROM dzbc_t "
   LET ls_where = "WHERE dzbc001='",g_copy_source,"' AND dzbc002='",g_source_code_ver,"' AND dzbc007='",g_source_identity,"' AND dzbcstus='Y' "

   LET ls_sql = ls_sql , ls_where


   PREPARE select_dzbc_t FROM ls_sql
   DECLARE dzbc_curs CURSOR FOR select_dzbc_t

   #一筆一筆複製資料
   #轉換表格：dzbc003 轉換欄位名稱、程式名稱。
   #不轉換表格:dzbc003  轉換程式名稱。
   LET ln_cnt = 0  
   FOREACH dzbc_curs INTO ls_dzbcstus, ls_dzbc002, ls_dzbc003, ls_dzbc004, ls_dzbc005, ls_dzbc009, ls_dzbc010, ls_dzbc011
      LET ln_cnt = ln_cnt + 1 
      #g_use_table_replace="Y" or "N" 都轉換
      #20160627
      #BEGIN:20160729 modify by elena 增加行業環境下，freestyle與解開section情形的sectionid轉換
      IF g_industry = "N" THEN
         LET ls_dzbc003 = sadzp270_gen_replace_sql_str("dzbc003", "dzbc_t", ls_dzbc003) 
      ELSE
         IF g_freestyle = "Y" OR ls_dzbc005 = "m" OR ls_dzbc005 = "c" THEN
            LET ls_dzbc003 = sadzp270_gen_replace_sql_str("dzbc003", "dzbc_t", ls_dzbc003)
         END IF
      END IF
      #END:20160729

      TRY

         LET ls_sql = "INSERT INTO dzbc_t ",
                      "   (dzbcstus, dzbc001, dzbc002, dzbc003, dzbc004, dzbc005, ",
                      "    dzbc006, dzbc007, dzbc008, dzbc009, dzbc010, dzbc011, ", 
                      "    dzbcownid, dzbcowndp, dzbccrtid, dzbccrtdp, dzbccrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzbcstus, "', '", g_gen_prog, "', ", g_gen_spec_ver, ", '", ls_dzbc003, "', ", ls_dzbc004, ", '", ls_dzbc005, "', '", 
                           ms_erpver, "', '", ms_dgenv, "', '", ms_cust, "', '", ls_dzbc009, "', '", ls_dzbc010, "', '", ls_dzbc011, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzbc_prep FROM ls_sql  
         EXECUTE dzbc_prep

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzbc_t"
            #LET g_errparam.replace[2] = "dzbc001 = '", g_gen_prog, "' AND dzbc002 = '", g_gen_spec_ver, "' AND dzbc003 = ", ls_dzbc003, " AND dzbc007 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzbc001 = '", g_copy_source, "' AND dzbc002 = '", ls_dzbc002, "' AND dzbc003 = ", ls_dzbc003, " AND dzbc007 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH
   #DISPLAY "dzbc_count = ", ln_cnt  
   FREE select_dzbc_t
   FREE dzbc_curs
   FREE dzbc_prep  


   #####dzbd_t#####
   LOCATE ls_dzbd098 IN FILE

   #報表刪除所有資料
   IF g_source_type = "X" or g_source_type = "G" THEN
      DELETE FROM dzbd_t WHERE dzbd001 = g_gen_prog      
   END IF

   LET ls_sql = "SELECT dzbdstus, dzbd002, dzbd003, dzbd004, dzbd098 FROM dzbd_t ",
                "INNER JOIN dzbc_t ON dzbc001 = dzbd001 AND dzbc003 = dzbd002 AND dzbc004 = dzbd003 AND dzbc005 = dzbd004 "
   LET ls_where = "WHERE dzbc001='",g_copy_source,"' AND dzbc002='",g_source_code_ver,"' AND dzbc007='",g_source_identity,"' AND dzbcstus='Y' "


   LET ls_sql = ls_sql , ls_where

   PREPARE select_dzbd_t FROM ls_sql
   DECLARE dzbd_curs CURSOR FOR select_dzbd_t

   #一筆一筆複製資料
   #轉換表格：dzbd002、dzbd098 (CLOB) 轉換欄位名稱、程式名稱。
   #不轉換表格:dzbd002、dzbd098 (CLOB) 轉換程式名稱。
   LET ln_cnt = 0 
   FOREACH dzbd_curs INTO ls_dzbdstus, ls_dzbd002, ls_dzbd003, ls_dzbd004, ls_dzbd098
      LET ln_cnt = ln_cnt + 1 
      #g_use_table_replac e="Y" or "N" 都轉換
      #20160627
      #BEGIN:20160729 modify by elena :增加行業環境下，freestyle與解開section情形的sectionid轉換
      IF g_industry = "N" THEN
         LET ls_dzbd002 = sadzp270_gen_replace_sql_str("dzbd002", "dzbd_t", ls_dzbd002)
      ELSE
         IF g_freestyle = "Y" OR ls_dzbd004 = "m" OR ls_dzbd004 = "c" THEN
            LET ls_dzbd002 = sadzp270_gen_replace_sql_str("dzbd002", "dzbd_t", ls_dzbd002)
         END IF
      END IF
      #END:20160729  
 
      #非行業別時，dzbd098轉換
      IF g_industry <> "Y" THEN
         LET ls_dzbd098 = sadzp270_gen_replace_sql_str("dzbd098", "dzbd_t", ls_dzbd098)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzbd_t ",
                      "   (dzbdstus, dzbd001, dzbd002, dzbd003, dzbd004, dzbd005, ",
                      "    dzbdownid, dzbdowndp, dzbdcrtid, dzbdcrtdp, dzbdcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzbdstus, "', '", g_gen_prog, "', '", ls_dzbd002, "', ", ls_dzbd003, ", '", ls_dzbd004, "', '", ms_cust, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzbd_prep FROM ls_sql 
         EXECUTE dzbd_prep



         #避免資料內容有引號，先做取代
         #LET ls_dzbd098 = cl_replace_str(ls_dzbd098, "'", "''")
 
         LET ls_sql = "UPDATE dzbd_t ",
                      #"   SET dzbd098 = '", ls_dzbd098, "' ",
                      "   SET dzbd098 =  ? ",
                      "WHERE dzbd001 = '", g_gen_prog, "' AND dzbd002 = '", ls_dzbd002, "' AND dzbd003 = ", ls_dzbd003, " AND dzbd004 = '", ls_dzbd004, "' "

         #DISPLAY ls_sql
         PREPARE dzbd_update_prep FROM ls_sql   
         EXECUTE dzbd_update_prep USING ls_dzbd098

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            IF SQLCA.SQLCODE = -6372 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00593"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = "dzbd_t"
               #LET g_errparam.replace[2] = "dzbd001 = '", g_gen_prog, "' AND dzbd002 = '", ls_dzbd002, "' AND dzbd003 = ", ls_dzbd003, " AND dzbd004 = '", ls_dzbd004, "'"
               LET g_errparam.replace[2] = "dzbd001 = '", g_copy_source, "' AND dzbd002 = '", ls_dzbd002, "' AND dzbd003 = ", ls_dzbd003, " AND dzbd004 = '", ls_dzbd004, "'"
               LET g_errparam.replace[3] = "dzbd098"
               CALL cl_err()
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00592"
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = "dzbd_t"
               #LET g_errparam.replace[2] = "dzbd001 = '", g_gen_prog, "' AND dzbd002 = '", ls_dzbd002, "' AND dzbd003 = ", ls_dzbd003, " AND dzbd004 = '", ls_dzbd004, "'"
               LET g_errparam.replace[2] = "dzbd001 = '", g_copy_source, "' AND dzbd002 = '", ls_dzbd002, "' AND dzbd003 = ", ls_dzbd003, " AND dzbd004 = '", ls_dzbd004, "'"
               CALL cl_err()
            END IF
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE ls_dzbd098
      LOCATE ls_dzbd098 IN FILE
   END FOREACH
   #DISPLAY "dzbd_count = ", ln_cnt  
   FREE ls_dzbd098
   FREE select_dzbd_t
   FREE dzbd_curs
   FREE dzbd_prep  
   FREE dzbd_update_prep

   


   IF g_source_type <> "X" AND g_source_type <> "G" THEN

   #####dzam_t#####
   LET ls_sql = "SELECT dzamstus, dzam003, dzam004 FROM dzam_t ",
                "INNER JOIN dzaa_t ON dzaa001=dzam001 AND dzaa004=dzam004 AND dzaa006=dzam005 "
   LET ls_where = "WHERE dzaa001='",g_copy_source,"' AND dzaa002='",g_source_spec_ver,"' AND dzaa003='EXCLUDE' AND dzaa005='a' AND dzaa009='",g_source_identity,
                  "' AND dzaastus='Y'   AND dzamstus='Y' "

   LET ls_sql = ls_sql , ls_where

   IF g_use_table_replace = "Y" THEN
      LET ls_sql = ls_sql , g_dzaa_t_exculded_wc 
   END IF

   PREPARE select_dzam_t FROM ls_sql
   DECLARE dzam_curs CURSOR FOR select_dzam_t

   #一筆一筆複製資料
   #轉換表格：dzam003  轉換欄位名稱、程式名稱。
   #不轉換表格:無。
   LET ln_cnt = 0 
   FOREACH dzam_curs INTO ls_dzamstus, ls_dzam003, ls_dzam004
      LET ln_cnt = ln_cnt + 1 
      #g_use_table_replace="Y" 轉換
      IF g_use_table_replace = "Y" THEN
         LET ls_dzam003 = sadzp270_gen_replace_sql_str("dzam003", "dzam_t", ls_dzam003)
      END IF

      TRY

         LET ls_sql = "INSERT INTO dzam_t ",
                      "   (dzamstus, dzam001, dzam002, dzam003, dzam004, dzam005, dzam006, ",
                      "    dzamownid, dzamowndp, dzamcrtid, dzamcrtdp, dzamcrtdt) ",
                      "VALUES ",
                      "   ('", ls_dzamstus, "', '", g_gen_prog, "', '", ms_dgenv, "', '", ls_dzam003, "', ", g_design_point_ver, ", '", ms_dgenv, "', '", ms_cust, "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzam_prep FROM ls_sql  
         EXECUTE dzam_prep

      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzam_t"
            #LET g_errparam.replace[2] = "dzam001 = '", g_gen_prog, "' AND dzam003 = '", ls_dzam003, "' AND dzam004 = ", g_design_point_ver, " AND dzam005 = '", ms_dgenv, "'"
            LET g_errparam.replace[2] = "dzam001 = '", g_copy_source, "' AND dzam003 = '", ls_dzam003, "' AND dzam004 = ", ls_dzam004, " AND dzam005 = '", ms_dgenv, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH

   #DISPLAY "dzbd_count = ", ln_cnt  
   FREE select_dzam_t
   FREE dzam_curs
   FREE dzam_prep  

   ##dzax_t刪除設計資料時並未列入刪除，需先檢核是否存在資料，存在的話需先刪除在進行新增。
   #####dzax_t#####
   LET ls_sql = 
      "SELECT COUNT(*) FROM dzax_t",
      " WHERE dzax001 = '",g_gen_prog,"' AND dzax006 = '",ms_dgenv,"'" 
      PREPARE query_data_to_dzax_t_2  FROM ls_sql
      LET ls_err = "error:query_data_to_dzax_t"
      EXECUTE query_data_to_dzax_t_2 INTO ln_cnt

      IF ln_cnt > 0  THEN
         LET ls_sql = "DELETE FROM dzax_t WHERE dzax001='",g_gen_prog,"' AND dzax006 = '",ms_dgenv,"'" 
         EXECUTE IMMEDIATE ls_sql
      END IF

   LET ls_sql = "SELECT dzax002, dzax003, dzax007 FROM dzax_t "
   LET ls_where = "WHERE dzax001 = '",g_copy_source,"' AND dzax006 = '",g_source_identity,"' "
 
   LET ls_sql = ls_sql , ls_where


   PREPARE select_dzax_t FROM ls_sql
   DECLARE dzax_curs CURSOR FOR select_dzax_t

   #一筆一筆複製資料
   #轉換表格：無。
   #不轉換表格:無。
   LET ln_cnt = 0  
   FOREACH dzax_curs INTO ls_dzax002, ls_dzax003, ln_dzax007 
      LET ln_cnt = ln_cnt + 1 

      TRY

         LET ls_dzax007 = ln_dzax007
         LET ls_dzax007 = ls_dzax007 CLIPPED
         LET ls_sql = "INSERT INTO dzax_t ",
                      "   (dzaxstus, dzax001, dzax002, dzax003, dzax004, dzax005, dzax006, dzax007, ",
                      "    dzaxownid, dzaxowndp, dzaxcrtid, dzaxcrtdp, dzaxcrtdt) ",
                      "VALUES ",
                      "   ('Y','", g_gen_prog, "', '", ls_dzax002, "', '", ls_dzax003, "', 'N', '", ms_cust, "', '", ms_dgenv, "', '", ls_dzax007 , "', '", 
                           l_user, "', '", l_dept, "', '", l_user, "', '", l_dept, "', SYSTIMESTAMP) "

         #DISPLAY ls_sql
         PREPARE dzax_prep FROM ls_sql   
         EXECUTE dzax_prep


      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592" 
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzax_t"
            #LET g_errparam.replace[2] = "dzax001 = '", g_gen_prog, "'"
            LET g_errparam.replace[2] = "dzax001 = '", g_copy_source, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
   END FOREACH
   #DISPLAY "dzax_count = ", ln_cnt  
   FREE select_dzax_t
   FREE dzax_curs
   FREE dzax_prep  
  
   #####dzfi_t#####
   #IF g_industry = "Y" THEN
      TRY
         LET ls_sql = "insert into dzfi_t  (dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, dzfi011,      ",
                      "                     dzfi012, dzfi013, dzfi014, dzfi015, dzfi016, dzfi017, dzfistus)                                         ",
                      "select '", g_gen_prog ,"' dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, dzfi011, ",
                      "        dzfi012, dzfi013, dzfi014, dzfi015, dzfi016, dzfi017, dzfistus from dzfi_t where dzfi001='", g_copy_source ,"'       "
     
         PREPARE dzfi_curs FROM ls_sql
         EXECUTE dzfi_curs
 
      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzfi_t"
            #LET g_errparam.replace[2] = "dzfi001 = '", g_gen_prog, "'"
            LET g_errparam.replace[2] = "dzfi001 = '", g_copy_source, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE

      END TRY
  
      FREE dzfi_curs
   #END IF

   #####dzfj_t#####
   #IF g_industry = "Y" THEN
      TRY
         LET ls_sql = "insert into dzfj_t (dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, dzfj006, dzfj007, dzfj008, dzfj009, dzfj010,       ",
                      "                    dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, dzfj016, dzfj017, dzfj018, dzfjSTUS)               ",
                      "select '", g_gen_prog ,"' dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, ",
                      "                          dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, dzfj016, dzfj017, dzfj018, dzfjSTUS          ",
                      "from dzfj_t where dzfj001='", g_copy_source ,"'                                                                     "
         PREPARE dzfj_curs FROM ls_sql
         EXECUTE dzfj_curs
      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzfj_t"
            #LET g_errparam.replace[2] = "dzfj001 = '", g_gen_prog, "'"
            LET g_errparam.replace[2] = "dzfj001 = '", g_copy_source, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE dzfj_curs
   #END IF

   #####dzfk_t#####
   #IF g_industry = "Y" THEN
      TRY
         LET ls_sql = "insert into dzfk_t (dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, dzfk006, dzfk007, dzfk008, dzfk009)       ",
                      "select '", g_gen_prog ,"' dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, dzfk006, dzfk007, dzfk008, dzfk009  ",
                      "from dzfk_t where dzfk001='", g_copy_source ,"'                                                            "                                                              

         PREPARE dzfk_curs FROM ls_sql
         EXECUTE dzfk_curs
      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzfk_t"
            #LET g_errparam.replace[2] = "dzfk001 = '", g_gen_prog, "'"
            LET g_errparam.replace[2] = "dzfk001 = '", g_copy_source, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE dzfk_curs
   #END IF
 
   #####dzfl_t#####
   #IF g_industry = "Y" THEN
      TRY
         LET ls_sql = "insert into dzfl_t (dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, dzfl006, dzfl007, dzfl008, dzflstus)        ",
                      "select '", g_gen_prog ,"' dzfl001, dzfl002, dzfl003, dzfl004, dzfl005, dzfl006, dzfl007, dzfl008, dzflstus   ",
                      "from dzfl_t where dzfl001='", g_copy_source ,"'                                                              "
         PREPARE dzfl_curs FROM ls_sql
         EXECUTE dzfl_curs
      CATCH
         #錯誤訊息
         IF SQLCA.SQLCODE <0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00592"
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = "dzfl_t"
            #LET g_errparam.replace[2] = "dzfl001 = '", g_gen_prog, "'"
            LET g_errparam.replace[2] = "dzfl001 = '", g_copy_source, "'"
            CALL cl_err()
         END IF
         LET lb_flag = FALSE
      END TRY
      FREE dzfl_curs
   #END IF
   
   END IF


   #CATCH #by mandy

   #END TRY
 
   #COMMIT WORK
 
   #IF NOT lb_flag THEN
      #顯示匯總錯誤訊息
      CALL cl_err_collect_show()
   #END IF

   RETURN lb_flag   
   




END FUNCTION

FUNCTION sadzp270_split_return_last_substring(p_string,p_split)

   DEFINE p_string  STRING,
          p_split   STRING

   DEFINE li_total  INTEGER,
          li_count  INTEGER,
          li_cnt    INTEGER,
          li_length INTEGER,
          ls_char   STRING


   CALL cl_str_sepcnt(p_string, p_split) RETURNING li_total
 
   LET li_length = p_string.getLength()
   LET li_count = 0
  
   FOR li_cnt = 1 TO li_length 
      LET ls_char = p_string.substring(li_cnt,li_cnt)
      IF ls_char == p_split THEN
         LET li_count = li_count+1
         IF li_count == li_total-1 THEN
            RETURN p_string.substring(li_cnt+1,li_length)
         END IF
      END IF
   END FOR

END FUNCTION

#elena add start
PRIVATE FUNCTION sadzp270_gen_replace_sql_str(p_col_id,p_table_id, data)
   DEFINE p_col_id       STRING,
          p_table_id     STRING,
          data           STRING,
          l_return_str   STRING,
          l_i            LIKE type_t.num5,
          l_old_str      STRING,
          l_new_str      STRING,
          l_buf          base.StringBuffer

   LET l_buf = base.StringBuffer.create()

   #使用表格欄位轉換時的取代方式
   IF g_use_table_replace = "Y" THEN
   
      #不複製appint的內容
      IF p_col_id = "dzbb098" AND g_not_copy_appoint = "Y" THEN
         RETURN "''"
      END IF

      #LET l_return_str = p_col_id
      LET l_return_str = data

      IF p_col_id <> "dzbb098" AND p_col_id <> "dzbd098" THEN
         #產生轉換欄位代號的SQL片段
         FOR l_i = 1 TO ga_dzeb_stored.getLength()
            IF ga_dzeb_stored[l_i].new_col_id IS NULL OR ga_dzeb_stored[l_i].old_col_id IS NULL THEN
               CONTINUE FOR
            END IF
         
            #原本的欄位代號
            LET l_old_str = ga_dzeb_stored[l_i].old_col_id
            LET l_old_str = l_old_str.trim()
            
            #要轉換的欄位代號
            LET l_new_str = ga_dzeb_stored[l_i].new_col_id
            LET l_new_str = l_new_str.trim()

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
         END FOR

         #產生轉換表格代號的SQL片段
         FOR l_i = 1 TO ga_dzag.getLength()
            IF ga_dzag[l_i].new_table_id IS NULL OR 
               ga_dzag[l_i].old_table_id IS NULL THEN
                  CONTINUE FOR
            END IF
            
            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
            

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
         END FOR
      END IF

      #轉換程式代號的SQL片段
      IF p_col_id = "dzab099" OR 
         p_col_id = "dzac099" OR 
         p_col_id = "dzad099" OR
         p_col_id = "dzba003" OR
         p_col_id = "gzzd003" OR #20140710:madey
         p_col_id = "dzbb002" OR #20150511:elena
         p_col_id = "dzbc003" OR #20150511:elena
         p_col_id = "dzbd002"      THEN  #20150511:elena
         #來源程式代號
         LET l_old_str = g_copy_source
         LET l_old_str = l_old_str.trim()

         #產生程式代號
         LET l_new_str = g_gen_prog
         LET l_new_str = l_new_str.trim()
            
         #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
      END IF

      IF p_col_id = "dzbb098" OR p_col_id = "dzbd098"  THEN
         #轉換程式代號的SQL片段
         LET l_old_str = g_copy_source
         LET l_old_str = l_old_str.trim()

         LET l_new_str = g_gen_prog
         LET l_new_str = l_new_str.trim()
            
         #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
         
         #排除會影響到的開窗識別碼
         FOR l_i = 1 TO ga_dzca.getLength()

            LET l_old_str = ga_dzca[l_i].origin
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzca[l_i].replace
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
         END FOR

         #排除會影響到的校驗帶值識別碼
         FOR l_i = 1 TO ga_dzcd.getLength()

            LET l_old_str = ga_dzcd[l_i].origin
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzcd[l_i].replace
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
         END FOR
         
         #產生轉換欄位代號的SQL片段
         FOR l_i = 1 TO ga_dzeb_stored.getLength()
            IF ga_dzeb_stored[l_i].new_col_id IS NULL OR ga_dzeb_stored[l_i].old_col_id IS NULL  THEN
               CONTINUE FOR
            END IF


            #原本的欄位代號
            LET l_old_str = ga_dzeb_stored[l_i].old_col_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str
            
            #要轉換的欄位代號
            LET l_new_str = ga_dzeb_stored[l_i].new_col_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
         END FOR

         #產生轉換表格代號的SQL片段
         FOR l_i = 1 TO ga_dzag.getLength()
            IF ga_dzag[l_i].new_table_id IS NULL OR 
               ga_dzag[l_i].old_table_id IS NULL THEN
                  CONTINUE FOR
            END IF

            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
            
            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
            LET l_old_str = "_",l_old_str

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)
            LET l_new_str = "_",l_new_str

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
            
            #原本的表格代號
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = l_old_str.subString(1,l_old_str.getLength()-2)
            LET l_old_str = l_old_str,"_"

            #要轉換的表格代號
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = l_new_str.subString(1,l_new_str.getLength()-2)
            LET l_new_str = l_new_str,"_"

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
            
         END FOR
      
         #產生轉換表格代號g_前綴的SQL片段
         FOR l_i = 1 TO ga_dzag.getLength()
            IF ga_dzag[l_i].new_table_id IS NULL OR 
               ga_dzag[l_i].old_table_id IS NULL THEN
                  CONTINUE FOR
            END IF
            
            LET l_old_str = ga_dzag[l_i].old_table_id
            LET l_old_str = l_old_str.trim()
            LET l_old_str = "g_",l_old_str.subString(1,l_old_str.getLength()-2)
            
            LET l_new_str = ga_dzag[l_i].new_table_id
            LET l_new_str = l_new_str.trim()
            LET l_new_str = "g_",l_new_str.subString(1,l_new_str.getLength()-2)

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
            
         END FOR    
      
         #還原被錯誤取代的字串,比如：imaa_t.imba001 還原成 imba_t.imba001
         FOR l_i = 1 TO ga_excluded_col.getLength()
            IF ga_excluded_col[l_i].col_id IS NULL OR 
               ga_excluded_col[l_i].col_id_tmp IS NULL OR 
               ga_excluded_col[l_i].table_id IS NULL OR 
               ga_excluded_col[l_i].table_id_tmp IS NULL THEN
            END IF
         
            LET l_old_str = ga_excluded_col[l_i].table_id_tmp CLIPPED ,".",ga_excluded_col[l_i].col_id CLIPPED,""
            LET l_old_str = l_old_str.trim()

            LET l_new_str = ga_excluded_col[l_i].table_id CLIPPED ,".",ga_excluded_col[l_i].col_id CLIPPED,""
            LET l_new_str = l_new_str.trim()

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
            
         END FOR

         #恢復會影響到的開窗識別碼
         FOR l_i = 1 TO ga_dzca.getLength()

            LET l_old_str = ga_dzca[l_i].replace
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzca[l_i].origin
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)

         END FOR

         #恢復會影響到的校驗帶值識別碼
         FOR l_i = 1 TO ga_dzcd.getLength()

            LET l_old_str = ga_dzcd[l_i].replace
            LET l_old_str = l_old_str.trim()
            LET l_old_str = " ",l_old_str

            LET l_new_str = ga_dzcd[l_i].origin
            LET l_new_str = l_new_str.trim()
            LET l_new_str = " ",l_new_str

            #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
            LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)

         END FOR


         #使用當前的子元件/子畫面/子程式
         IF g_use_current_sub_prog = "Y" THEN

          ##20150505:mark -Begin-
          ##FOR l_i = 1 TO ga_sub_prog.getLength()
          ##   CALL l_buf.clear()
          ##   CALL l_buf.append(ga_sub_prog[l_i].sub_prog_id)
          ##   CALL l_buf.replace(g_copy_source,g_gen_prog,0)
          ##   LET ga_sub_prog[l_i].sub_prog_tmp_id = l_buf.toString()
          ##   LET l_old_str = l_buf.toString()
          ##   LET l_new_str = ga_sub_prog[l_i].sub_prog_id
          ##  #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')" #mark by madey 20140312
          ##  #add by madey 20140312 --start--
          ##  #還原子畫面時的條件要更精準,以免因為子畫面id與functoin name重覆時,整個都被還原
          ##   CASE ga_sub_prog[l_i].sub_prog_type
          ##      WHEN 'F' #子畫面
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'w_",l_old_str,"','w_",l_new_str,"')"
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'""",l_old_str,"""','""",l_new_str,"""')"
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'''",l_old_str,"''','''",l_new_str,"''')"
          ##         LET l_return_str = cl_replace_str(l_return_str, 'w_",l_old_str,"', 'w_",l_new_str,"')
          ##         LET l_return_str = cl_replace_str(l_return_str, '""",l_old_str,"""', '""",l_new_str,"""')
          ##         LET l_return_str = cl_replace_str(l_return_str, '''",l_old_str,"''', '''",l_new_str,"''')
          ##      OTHERWISE 
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
          ##         LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
          ##   END CASE
          ##  #add by madey 20140312 --end --
          ##END FOR
          ##20150505:mark -End-

         END IF
         
      END IF
   ELSE
      #不使用表格轉換的appoint的處理
      #LET l_return_str = p_col_id
       LET l_return_str = data
      #生轉換程式代號的SQL片段
      IF p_col_id = "dzbb098" OR  p_col_id = "dzbd098"  THEN
         #來源程式代號
         LET l_old_str = g_copy_source
         LET l_old_str = l_old_str.trim()

         #產生程式代號
         LET l_new_str = g_gen_prog
         LET l_new_str = l_new_str.trim()
            
         #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)

         #使用當前的子元件/子畫面/子程式
         IF g_use_current_sub_prog = "Y" THEN

          ##20150505:mark -Begin-
          ##FOR l_i = 1 TO ga_sub_prog.getLength()
          ##   CALL l_buf.clear()
          ##   CALL l_buf.append(ga_sub_prog[l_i].sub_prog_id)
          ##   CALL l_buf.replace(g_copy_source,g_gen_prog,0)
          ##   LET ga_sub_prog[l_i].sub_prog_tmp_id = l_buf.toString()
          ##   LET l_old_str = l_buf.toString()
          ##   LET l_new_str = ga_sub_prog[l_i].sub_prog_id
          ##  #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')" #mark by madey 20140312
          ##  #add by madey 20140312 --start--
          ##  #還原子畫面時的條件要更精準,以免因為子畫面id與functoin name重覆時,整個都被還原
          ##   CASE ga_sub_prog[l_i].sub_prog_type
          ##      WHEN 'F' #子畫面
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'w_",l_old_str,"','w_",l_new_str,"')"
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'""",l_old_str,"""','""",l_new_str,"""')"
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'''",l_old_str,"''','''",l_new_str,"''')"
          ##         LET l_return_str = cl_replace_str(l_return_str, 'w_",l_old_str,"', 'w_",l_new_str,"')
          ##         LET l_return_str = cl_replace_str(l_return_str, '""",l_old_str,"""', '""",l_new_str,"""')
          ##         LET l_return_str = cl_replace_str(l_return_str, '''",l_old_str,"''', '''",l_new_str,"''')
          ##      OTHERWISE 
          ##         #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
          ##         LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
          ##   END CASE
          ##  #add by madey 20140312 --end --
          ##END FOR
          ##20150505:mark -End-

         END IF
      ELSE
         #來源程式代號
         LET l_old_str = g_copy_source
         LET l_old_str = l_old_str.trim()

         #產生程式代號
         LET l_new_str = g_gen_prog
         LET l_new_str = l_new_str.trim()
            
         #LET l_return_str = "REPLACE (",l_return_str,",'",l_old_str,"','",l_new_str,"')"
         LET l_return_str = cl_replace_str(l_return_str, l_old_str, l_new_str)
      END IF
   END IF
   
   RETURN l_return_str
END FUNCTION
##elena add end


#+ 篩選會影響到的開窗和校驗帶值識別值
PRIVATE FUNCTION sadzp270_filter_q_id_and_v_id()
   DEFINE l_sql STRING,
          l_i   LIKE type_t.num5,
          l_j   LIKE type_t.num5,
          l_origin STRING,
          l_replace STRING,
          l_str    STRING

   
   CALL ga_dzca.clear()
   LET l_i = 1
   LET l_j = 1
   
   FOR l_i = 1 TO ga_dzag.getLength()

      IF ga_dzag[l_i].new_table_id IS NULL OR ga_dzag[l_i].old_table_id IS NULL THEN
         CONTINUE FOR
      END IF

      LET l_str = ga_dzag[l_i].old_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzca001 FROM dzca_t WHERE dzca001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzca001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzca001_pre2 FROM l_sql
      DECLARE dzca001_curs2 CURSOR FOR dzca001_pre2
      FOREACH dzca001_curs2 INTO ga_dzca[l_j].origin 
         LET l_replace = ga_dzca[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzca[l_j].replace = l_replace
         #DISPLAY ga_dzca[l_j].origin,":",ga_dzca[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      
      LET l_str = ga_dzag[l_i].new_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzca001 FROM dzca_t WHERE dzca001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzca001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzca001_pre3 FROM l_sql
      DECLARE dzca001_curs3 CURSOR FOR dzca001_pre2
      FOREACH dzca001_curs3 INTO ga_dzca[l_j].origin 
         LET l_replace = ga_dzca[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzca[l_j].replace = l_replace
         #DISPLAY ga_dzca[l_j].origin,":",ga_dzca[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      FREE dzca001_pre2
      FREE dzca001_curs2
      FREE dzca001_pre3
      FREE dzca001_curs3
   END FOR

   CALL ga_dzca.deleteElement(l_j)
   LET l_j = l_j -1


   CALL ga_dzcd.clear()
   LET l_i = 1
   LET l_j = 1
   
   FOR l_i = 1 TO ga_dzag.getLength()

      IF ga_dzag[l_i].new_table_id IS NULL OR ga_dzag[l_i].old_table_id IS NULL THEN
         CONTINUE FOR
      END IF

      LET l_str = ga_dzag[l_i].old_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzcd001 FROM dzcd_t WHERE dzcd001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzcd001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzcd001_pre2 FROM l_sql
      DECLARE dzcd001_curs2 CURSOR FOR dzcd001_pre2
      FOREACH dzcd001_curs2 INTO ga_dzcd[l_j].origin 
         LET l_replace = ga_dzcd[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzcd[l_j].replace = l_replace
         #DISPLAY ga_dzcd[l_j].origin,":",ga_dzcd[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      
      LET l_str = ga_dzag[l_i].new_table_id
      LET l_str = l_str.trim()
      LET l_str = l_str.subString(1,l_str.getLength()-2)

      LET l_sql = "SELECT dzcd001 FROM dzcd_t WHERE dzcd001 LIKE '%",l_str,"%' ",
                  " ORDER BY dzcd001"
      #DISPLAY "l_sql = ",l_sql
      PREPARE dzcd001_pre3 FROM l_sql
      DECLARE dzcd001_curs3 CURSOR FOR dzcd001_pre2
      FOREACH dzcd001_curs3 INTO ga_dzcd[l_j].origin 
         LET l_replace = ga_dzcd[l_j].origin
         LET l_replace = l_replace.trim()

         LET l_replace = l_replace.subString(1,4),"￥",l_replace.subString(5,l_replace.getLength())
         LET ga_dzcd[l_j].replace = l_replace
         #DISPLAY ga_dzcd[l_j].origin,":",ga_dzcd[l_j].replace
         
         LET l_j = l_j + 1
      END FOREACH

      FREE dzcd001_pre2
      FREE dzcd001_curs2
      FREE dzcd001_pre3
      FREE dzcd001_curs3
   END FOR

   CALL ga_dzcd.deleteElement(l_j)
   LET l_j = l_j -1
   
   
END FUNCTION   


PRIVATE FUNCTION sadzp270_select_excluded_column()
   DEFINE  l_i            LIKE type_t.num5,
           l_ac           LIKE type_t.num5,
           l_new_prefix   STRING,
           l_old_prefix   STRING,
           l_str_buff     base.StringBuffer

   CALL ga_excluded_col.clear()
   
   FOR l_i = 1 TO ga_dzeb_stored.getLength()

      #若對應的新欄位值為空表示,欲轉換的舊欄位字串沒有對應到要轉換的新欄位字串,
      IF cl_null(ga_dzeb_stored[l_i].new_col_id) THEN

      CALL ga_excluded_col.appendElement()
         LET l_ac = ga_excluded_col.getLength()
         LET ga_excluded_col[l_ac].col_id = ga_dzeb_stored[l_i].old_col_id
         LET ga_excluded_col[l_ac].table_id = ga_dzeb_stored[l_i].old_table_id
         LET ga_excluded_col[l_ac].col_name = ga_dzeb_stored[l_i].old_col_name

         #暫存欲轉換的表格代號
         LET ga_excluded_col[l_ac].table_id_tmp = ga_dzeb_stored[l_i].new_table_id
         
         #去除新表格表格代號的'_t',產生新表格的前綴
         LET l_new_prefix = ga_excluded_col[l_ac].table_id_tmp
         LET l_new_prefix = l_new_prefix.trim()
         LET l_new_prefix = l_new_prefix.subString(1,l_new_prefix.getLength()-2)

         #去除舊表格代號的'_t',產生舊表格的前綴
         LET l_old_prefix = ga_excluded_col[l_ac].table_id
         LET l_old_prefix = l_old_prefix.trim()
         LET l_old_prefix = l_old_prefix.subString(1,l_old_prefix.getLength()-2)

         LET l_str_buff = base.StringBuffer.create()
         CALL l_str_buff.append(ga_excluded_col[l_ac].col_id )
         CALL l_str_buff.replace(l_old_prefix,l_new_prefix,0)

         #產生要替換回來的欄位字串（包含欲轉換的新表格代號的前綴）
         LET ga_excluded_col[l_ac].col_id_tmp = l_str_buff.toString()
         
      END IF
   END FOR
END FUNCTION


#+ 產生排除欄位的where條件
PRIVATE FUNCTION sadzp270_gen_excluded_where_condition(p_column_id)
   DEFINE p_column_id     LIKE dzeb_t.dzeb002,
          l_i             LIKE type_t.num5,
          l_exculded_wc   STRING

   #CALL ga_excluded_col.clear()

   IF ga_excluded_col.getLength() = 0 THEN
      LET l_exculded_wc = " AND 1=1"
      RETURN l_exculded_wc
   END IF

   #select * from dzaa_t where dzaa001 = 'aiti003' 
   #AND NOT dzaa003 LIKE '%bgad001%'
   #AND NOT dzaa003 LIKE '%bgad002
   
   #LET l_exculded_wc = " AND NOT ",p_column_id," LIKE "
   LET l_exculded_wc = ASCII 10
   
   FOR l_i = 1 TO ga_excluded_col.getLength()
      IF ga_excluded_col[l_i].col_id IS NULL OR 
         ga_excluded_col[l_i].col_id_tmp IS NULL OR 
         ga_excluded_col[l_i].table_id IS NULL OR 
         ga_excluded_col[l_i].table_id_tmp IS NULL THEN
      END IF
      
      LET l_exculded_wc = l_exculded_wc," AND NOT ",p_column_id," LIKE '%",ga_excluded_col[l_i].col_id CLIPPED,"%' ",ASCII 10
   END FOR
          
   RETURN l_exculded_wc
END FUNCTION


#+ 複製gzzq_t(ACTION多語言對照檔)
PRIVATE FUNCTION sadzp270_insert_gzzq_t(ps_sql)
   DEFINE ln_cnt     LIKE type_t.num5,
          ps_sql     STRING,
          ls_text    STRING,
          ls_comment STRING,
          ls_standard STRING
          
   #DISPLAY "### sadzp270_insert_gzzq_t ### start ###"

   PREPARE insert_data_to_gzzq_t FROM ps_sql
   DECLARE gzzq_curs CURSOR FOR insert_data_to_gzzq_t

   CALL ga_gzzq_t.clear()
   LET ln_cnt = 1
   
   FOREACH gzzq_curs INTO ga_gzzq_t[ln_cnt].*

      CALL s_azzi903_get_gzzq(g_copy_source,ga_gzzq_t[ln_cnt].gzzq002) RETURNING ls_text,ls_comment,ls_standard
   
      IF NOT s_azzi903_ins_gzzq(g_gen_prog, ga_gzzq_t[ln_cnt].gzzq002,ls_text,ls_comment) THEN
         #DISPLAY "ERROR: insert gzzq_t :",ga_gzzq_t[ln_cnt].gzzq002
      END IF
      
      LET ln_cnt = ln_cnt + 1
   END FOREACH

   CALL ga_gzzq_t.deleteElement(ln_cnt)
   LET ln_cnt = ln_cnt - 1
  
   DISPLAY "### adzp270_insert_gzzq_t ### end ###"
   FREE insert_data_to_gzzq_t

END FUNCTION
   
