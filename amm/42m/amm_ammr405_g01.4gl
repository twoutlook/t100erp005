#該程式未解開Section, 採用最新樣板產出!
{<section id="ammr405_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-06-29 02:44:24), PR版次:0001(2015-07-01 10:14:53)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: ammr405_g01
#+ Description: ...
#+ Creator....: 05423(2015-06-29 00:49:19)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ammr405_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   rtiadocno LIKE rtia_t.rtiadocno, 
   rtiadocdt LIKE rtia_t.rtiadocdt, 
   rtia004 LIKE rtia_t.rtia004, 
   l_rtia004_desc LIKE ooag_t.ooag011, 
   rtia005 LIKE rtia_t.rtia005, 
   l_rtia005_desc LIKE ooefl_t.ooefl003, 
   rtiacnfdt LIKE rtia_t.rtiacnfdt, 
   rtiacnfid LIKE rtia_t.rtiacnfid, 
   l_rtiacnfid_desc LIKE ooag_t.ooag011, 
   l_mmaq022 LIKE mmaq_t.mmaq022, 
   l_mmaq022_desc LIKE ooefl_t.ooefl003, 
   rtia041 LIKE rtia_t.rtia041, 
   rtia001 LIKE rtia_t.rtia001, 
   rtia002 LIKE rtia_t.rtia002, 
   rtia009 LIKE rtia_t.rtia009, 
   rtiaent LIKE rtia_t.rtiaent, 
   rtiasite LIKE rtia_t.rtiasite, 
   rtiastus LIKE rtia_t.rtiastus, 
   mmaf001 LIKE mmaf_t.mmaf001, 
   mmaf008 LIKE mmaf_t.mmaf008, 
   mmea_t_mmea001 LIKE mmea_t.mmea001, 
   mmea_t_mmea002 LIKE mmea_t.mmea002, 
   l_mmea001_mmea002 LIKE mmea_t.mmea001, 
   l_mmag004 LIKE mmag_t.mmag004, 
   l_mmag004_desc LIKE oocql_t.oocql004, 
   mmea_t_mmea003 LIKE mmea_t.mmea003, 
   l_mmea003_desc LIKE mmanl_t.mmanl003, 
   mmea_t_mmea008 LIKE mmea_t.mmea008, 
   mmea_t_mmea010 LIKE mmea_t.mmea010, 
   l_mmea008_mmea010 LIKE mmea_t.mmea010, 
   mmea_t_mmea006 LIKE mmea_t.mmea006, 
   mmea_t_mmea004 LIKE mmea_t.mmea004, 
   l_mmea004_desc LIKE mmaf_t.mmaf008, 
   mmea_t_mmea011 LIKE mmea_t.mmea011, 
   l_rtiastus_desc LIKE oocql_t.oocql004
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #where condition
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="ammr405_g01.main" readonly="Y" >}
PUBLIC FUNCTION ammr405_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "ammr405_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ammr405_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ammr405_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ammr405_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ammr405_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ammr405_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT DISTINCT rtiadocno,rtiadocdt,rtia004,NULL,rtia005,NULL,rtiacnfdt,rtiacnfid,NULL,mmaq022, 
       NULL,rtia041,rtia001,rtia002,rtia009,rtiaent,rtiasite,rtiastus,mmaf001,mmaf008,mmea_t.mmea001, 
       mmea_t.mmea002,NULL,mmag004,oocql004,mmea_t.mmea003,mmanl003,COALESCE(mmea_t.mmea008,0),COALESCE(mmea_t.mmea010,0),0,COALESCE(mmea_t.mmea006,0), 
       mmea_t.mmea004,trim(mmea004)||'.'||trim(mmaf008),COALESCE(mmea_t.mmea011,0),NULL"
 
#   #end add-point
#   LET g_select = " SELECT rtiadocno,rtiadocdt,rtia004,NULL,rtia005,NULL,rtiacnfdt,rtiacnfid,NULL,NULL, 
#       NULL,rtia041,rtia001,rtia002,rtia009,rtiaent,rtiasite,rtiastus,mmaf001,mmaf008,mmea_t.mmea001, 
#       mmea_t.mmea002,NULL,NULL,NULL,mmea_t.mmea003,NULL,mmea_t.mmea008,mmea_t.mmea010,NULL,mmea_t.mmea006, 
#       mmea_t.mmea004,NULL,mmea_t.mmea011,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM rtia_t LEFT OUTER JOIN mmea_t ON rtiadocno = mmeadocno AND rtiaent = rtiaent ",
                "             LEFT OUTER JOIN mmaf_t ON mmea004 = mmaf001 AND mmeaent = mmafent   ",
                "             LEFT OUTER JOIN mmaq_t ON mmaqent = mmafent AND mmaq003 = mmaf001 ",
                "             LEFT OUTER JOIN mmag_t ON mmagent = mmafent AND mmag001 = mmaf001 AND mmag002 = '09' ",
                "             LEFT OUTER JOIN oocql_t ON oocql001 = '2024' AND mmag004 = oocql002 AND oocql003 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN mmanl_t ON mmanl001 = mmea003 AND mmanlent = mmeaent AND mmanl002 = '",g_dlang,"'"
#   #end add-point
#    LET g_from = " FROM rtia_t,mmaf_t,mmea_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY rtiadocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("rtia_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ammr405_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ammr405_g01_curs CURSOR FOR ammr405_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ammr405_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ammr405_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   rtiadocno LIKE rtia_t.rtiadocno, 
   rtiadocdt LIKE rtia_t.rtiadocdt, 
   rtia004 LIKE rtia_t.rtia004, 
   l_rtia004_desc LIKE ooag_t.ooag011, 
   rtia005 LIKE rtia_t.rtia005, 
   l_rtia005_desc LIKE ooefl_t.ooefl003, 
   rtiacnfdt LIKE rtia_t.rtiacnfdt, 
   rtiacnfid LIKE rtia_t.rtiacnfid, 
   l_rtiacnfid_desc LIKE ooag_t.ooag011, 
   l_mmaq022 LIKE mmaq_t.mmaq022, 
   l_mmaq022_desc LIKE ooefl_t.ooefl003, 
   rtia041 LIKE rtia_t.rtia041, 
   rtia001 LIKE rtia_t.rtia001, 
   rtia002 LIKE rtia_t.rtia002, 
   rtia009 LIKE rtia_t.rtia009, 
   rtiaent LIKE rtia_t.rtiaent, 
   rtiasite LIKE rtia_t.rtiasite, 
   rtiastus LIKE rtia_t.rtiastus, 
   mmaf001 LIKE mmaf_t.mmaf001, 
   mmaf008 LIKE mmaf_t.mmaf008, 
   mmea_t_mmea001 LIKE mmea_t.mmea001, 
   mmea_t_mmea002 LIKE mmea_t.mmea002, 
   l_mmea001_mmea002 LIKE mmea_t.mmea001, 
   l_mmag004 LIKE mmag_t.mmag004, 
   l_mmag004_desc LIKE oocql_t.oocql004, 
   mmea_t_mmea003 LIKE mmea_t.mmea003, 
   l_mmea003_desc LIKE mmanl_t.mmanl003, 
   mmea_t_mmea008 LIKE mmea_t.mmea008, 
   mmea_t_mmea010 LIKE mmea_t.mmea010, 
   l_mmea008_mmea010 LIKE mmea_t.mmea010, 
   mmea_t_mmea006 LIKE mmea_t.mmea006, 
   mmea_t_mmea004 LIKE mmea_t.mmea004, 
   l_mmea004_desc LIKE mmaf_t.mmaf008, 
   mmea_t_mmea011 LIKE mmea_t.mmea011, 
   l_rtiastus_desc LIKE oocql_t.oocql004
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ammr405_g01_curs INTO sr_s.*
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()       
          LET g_rep_success = 'N'    
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       #获取说明
       #发卡人员rtia004
       IF NOT cl_null(sr_s.rtia004) THEN
          CALL ammr405_g01_get_person_desc(sr_s.rtia004) RETURNING sr_s.l_rtia004_desc
          IF NOT cl_null(sr_s.l_rtia004_desc) THEN
#             LET sr_s.l_rtia004_desc = sr_s.rtia004,'.',sr_s.l_rtia004_desc
          ELSE 
             LET sr_s.l_rtia004_desc = sr_s.rtia004
          END IF
       END IF
       #发卡部门rtia005
       IF NOT cl_null(sr_s.rtia005) THEN
          CALL ammr405_g01_get_org_desc(sr_s.rtia005) RETURNING sr_s.l_rtia005_desc
          IF NOT cl_null(sr_s.l_rtia005_desc) THEN
#             LET sr_s.l_rtia005_desc = sr_s.rtia005,'.',sr_s.l_rtia005_desc
          ELSE 
             LET sr_s.l_rtia005_desc = sr_s.rtia005
          END IF
       END IF
       #售卡店号rtiasite
       IF NOT cl_null(sr_s.rtiasite) THEN
          CALL ammr405_g01_get_org_desc(sr_s.rtiasite) RETURNING sr_s.l_mmaq022_desc
          IF NOT cl_null(sr_s.l_mmaq022_desc) THEN
             LET sr_s.l_mmaq022_desc = sr_s.rtiasite,'.',sr_s.l_mmaq022_desc
          ELSE 
             LET sr_s.l_mmaq022_desc = sr_s.rtiasite
          END IF
       END IF
       #审核人rtiacnfid
       IF NOT cl_null(sr_s.rtiacnfid) THEN
          CALL ammr405_g01_get_person_desc(sr_s.rtiacnfid) RETURNING sr_s.l_rtiacnfid_desc
          IF NOT cl_null(sr_s.l_rtiacnfid_desc) THEN
#             LET sr_s.l_rtiacnfid_desc = sr_s.rtiacnfid,'.',sr_s.l_rtiacnfid_desc
          ELSE 
             LET sr_s.l_rtiacnfid_desc = sr_s.rtiacnfid
          END IF
       END IF
       #状态码说明
       IF NOT cl_null(sr_s.rtiastus) THEN
          SELECT gzcbl004 INTO sr_s.l_rtiastus_desc
            FROM gzcbl_t
           WHERE gzcbl001 = '13'
             AND gzcbl002 = sr_s.rtiastus
             AND gzcbl003 = g_dlang
       END IF
       
       IF cl_null(sr_s.l_mmag004_desc) THEN
          LET sr_s.l_mmag004_desc = sr_s.l_mmag004
       END IF
       
       #若起讫卡号相同，则使用起始卡号，反之，使用连接符连接
       IF NOT cl_null(sr_s.mmea_t_mmea001) OR sr_s.mmea_t_mmea001 != ' ' THEN
          IF sr_s.mmea_t_mmea001 == sr_s.mmea_t_mmea002 THEN
             LET sr_s.l_mmea001_mmea002 = sr_s.mmea_t_mmea001
          ELSE
             LET sr_s.l_mmea001_mmea002 = sr_s.mmea_t_mmea001 CLIPPED,'~',sr_s.mmea_t_mmea002 CLIPPED
          END IF
       ELSE 
          INITIALIZE sr_s.l_mmea001_mmea002 TO NULL
       END IF          
       #面额 = 单张储值金额 + 单张加值金额 mmea008 + mmea010
       LET sr_s.l_mmea008_mmea010 = sr_s.mmea_t_mmea008 + sr_s.mmea_t_mmea010
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].rtiadocno = sr_s.rtiadocno
       LET sr[l_cnt].rtiadocdt = sr_s.rtiadocdt
       LET sr[l_cnt].rtia004 = sr_s.rtia004
       LET sr[l_cnt].l_rtia004_desc = sr_s.l_rtia004_desc
       LET sr[l_cnt].rtia005 = sr_s.rtia005
       LET sr[l_cnt].l_rtia005_desc = sr_s.l_rtia005_desc
       LET sr[l_cnt].rtiacnfdt = sr_s.rtiacnfdt
       LET sr[l_cnt].rtiacnfid = sr_s.rtiacnfid
       LET sr[l_cnt].l_rtiacnfid_desc = sr_s.l_rtiacnfid_desc
       LET sr[l_cnt].l_mmaq022 = sr_s.l_mmaq022
       LET sr[l_cnt].l_mmaq022_desc = sr_s.l_mmaq022_desc
       LET sr[l_cnt].rtia041 = sr_s.rtia041
       LET sr[l_cnt].rtia001 = sr_s.rtia001
       LET sr[l_cnt].rtia002 = sr_s.rtia002
       LET sr[l_cnt].rtia009 = sr_s.rtia009
       LET sr[l_cnt].rtiaent = sr_s.rtiaent
       LET sr[l_cnt].rtiasite = sr_s.rtiasite
       LET sr[l_cnt].rtiastus = sr_s.rtiastus
       LET sr[l_cnt].mmaf001 = sr_s.mmaf001
       LET sr[l_cnt].mmaf008 = sr_s.mmaf008
       LET sr[l_cnt].mmea_t_mmea001 = sr_s.mmea_t_mmea001
       LET sr[l_cnt].mmea_t_mmea002 = sr_s.mmea_t_mmea002
       LET sr[l_cnt].l_mmea001_mmea002 = sr_s.l_mmea001_mmea002
       LET sr[l_cnt].l_mmag004 = sr_s.l_mmag004
       LET sr[l_cnt].l_mmag004_desc = sr_s.l_mmag004_desc
       LET sr[l_cnt].mmea_t_mmea003 = sr_s.mmea_t_mmea003
       LET sr[l_cnt].l_mmea003_desc = sr_s.l_mmea003_desc
       LET sr[l_cnt].mmea_t_mmea008 = sr_s.mmea_t_mmea008
       LET sr[l_cnt].mmea_t_mmea010 = sr_s.mmea_t_mmea010
       LET sr[l_cnt].l_mmea008_mmea010 = sr_s.l_mmea008_mmea010
       LET sr[l_cnt].mmea_t_mmea006 = sr_s.mmea_t_mmea006
       LET sr[l_cnt].mmea_t_mmea004 = sr_s.mmea_t_mmea004
       LET sr[l_cnt].l_mmea004_desc = sr_s.l_mmea004_desc
       LET sr[l_cnt].mmea_t_mmea011 = sr_s.mmea_t_mmea011
       LET sr[l_cnt].l_rtiastus_desc = sr_s.l_rtiastus_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammr405_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ammr405_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT ammr405_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ammr405_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ammr405_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="ammr405_g01.rep" readonly="Y" >}
PRIVATE REPORT ammr405_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE l_count          LIKE type_t.num5  #用来统计数量
DEFINE l_sum_1          LIKE type_t.num5  #用来合计面额
DEFINE l_sum_2          LIKE type_t.num5  #用来合计工本费
DEFINE l_sum_3          LIKE type_t.num5  #用来合计储值金额
DEFINE l_rtiastus       LIKE oocql_t.oocql004
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.rtiadocno,sr1.l_mmea001_mmea002
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.rtiadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            LET g_grPageHeader.title0104 = sr1.l_rtiastus_desc
            #end add-point:rep.header 
            LET g_rep_docno = sr1.rtiadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            LET l_rtiastus = sr1.l_rtiastus_desc
            PRINTX l_rtiastus
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'rtiaent=' ,sr1.rtiaent,'{+}rtiadocno=' ,sr1.rtiadocno         
            CALL cl_gr_init_apr(sr1.rtiadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.rtiadocno.before name="rep.b_group.rtiadocno.before"
           LET l_count = 0
           LET l_sum_1 = 0
           LET l_sum_2 = 0
           LET l_sum_3 = 0
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.rtiaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rtiadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ammr405_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ammr405_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ammr405_g01_subrep01
           DECLARE ammr405_g01_repcur01 CURSOR FROM g_sql
           FOREACH ammr405_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ammr405_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ammr405_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ammr405_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.rtiadocno.after name="rep.b_group.rtiadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_mmea001_mmea002
 
           #add-point:rep.b_group.l_mmea001_mmea002.before name="rep.b_group.l_mmea001_mmea002.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_mmea001_mmea002.after name="rep.b_group.l_mmea001_mmea002.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.rtiaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rtiadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_mmea001_mmea002 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ammr405_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ammr405_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ammr405_g01_subrep02
           DECLARE ammr405_g01_repcur02 CURSOR FROM g_sql
           FOREACH ammr405_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ammr405_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ammr405_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ammr405_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          LET l_count = l_count + 1
          LET l_sum_1 = l_sum_1 + sr1.l_mmea008_mmea010
          LET l_sum_2 = l_sum_2 + sr1.mmea_t_mmea006
          LET l_sum_3 = l_sum_3 + sr1.mmea_t_mmea011
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.rtiaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rtiadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_mmea001_mmea002 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ammr405_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ammr405_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ammr405_g01_subrep03
           DECLARE ammr405_g01_repcur03 CURSOR FROM g_sql
           FOREACH ammr405_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ammr405_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ammr405_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ammr405_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.rtiadocno
 
           #add-point:rep.a_group.rtiadocno.before name="rep.a_group.rtiadocno.before"
           PRINTX l_count
           PRINTX l_sum_1
           PRINTX l_sum_2
           PRINTX l_sum_3
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.rtiaent CLIPPED ,"'", " AND  ooff003 = '", sr1.rtiadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ammr405_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ammr405_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ammr405_g01_subrep04
           DECLARE ammr405_g01_repcur04 CURSOR FROM g_sql
           FOREACH ammr405_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ammr405_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ammr405_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ammr405_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.rtiadocno.after name="rep.a_group.rtiadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_mmea001_mmea002
 
           #add-point:rep.a_group.l_mmea001_mmea002.before name="rep.a_group.l_mmea001_mmea002.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_mmea001_mmea002.after name="rep.a_group.l_mmea001_mmea002.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ammr405_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ammr405_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ammr405_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ammr405_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ammr405_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="ammr405_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 获取人员姓名
# Memo...........:
# Usage..........: CALL ammr405_g01_get_person_desc(p_ooag001)
#                  RETURNING r_ooag011
# Date & Author..: 2015-6-29 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION ammr405_g01_get_person_desc(p_ooag001)
DEFINE p_ooag001  LIKE ooag_t.ooag001
DEFINE r_ooag011  LIKE ooag_t.ooag011

   INITIALIZE r_ooag011 TO NULL
   IF cl_null(p_ooag001) THEN
      RETURN r_ooag011
   END IF
   
   SELECT ooag011 INTO r_ooag011
     FROM ooag_t
    WHERE ooag001 = p_ooag001
      AND ooagent = g_enterprise
   
   RETURN r_ooag011
END FUNCTION

################################################################################
# Descriptions...: 获取组织说明
# Memo...........:
# Usage..........: CALL ammr405_g01_get_org_desc(p_ooefl001)
#                  RETURNING r_ooefl003
# Date & Author..: 2015-6-29 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION ammr405_g01_get_org_desc(p_ooefl001)
DEFINE p_ooefl001  LIKE ooefl_t.ooefl001
DEFINE r_ooefl003  LIKE ooefl_t.ooefl003

   INITIALIZE r_ooefl003 TO NULL
   IF cl_null(p_ooefl001) THEN
      RETURN r_ooefl003
   END IF
   
   SELECT ooefl003 INTO r_ooefl003
     FROM ooefl_t
    WHERE ooefl001 = p_ooefl001
      AND ooeflent = g_enterprise
      AND ooefl002 = g_dlang
   
   RETURN r_ooefl003
END FUNCTION

 
{</section>}
 
{<section id="ammr405_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 