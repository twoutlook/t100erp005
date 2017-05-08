#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr801_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-11-09 15:46:57), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: asfr801_g01
#+ Description: ...
#+ Creator....: 05947(2015-06-09 14:25:56)
#+ Modifier...: 08993 -SD/PR- 00000
 
{</section>}
 
{<section id="asfr801_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#150525-00007#2   2015/11/17   By 06948   增加sfaa013單位欄位
#160816-00001#9  2016/08/17  By 08734     抓取理由碼改CALL sub
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
   sfoadocno LIKE sfoa_t.sfoadocno, 
   l_sfoadocno LIKE type_t.chr1000, 
   sfoa001 LIKE sfoa_t.sfoa001, 
   l_sfaa010 LIKE type_t.chr1000, 
   l_imaal003 LIKE type_t.chr1000, 
   l_imaal004 LIKE type_t.chr1000, 
   sfoa906 LIKE sfoa_t.sfoa906, 
   l_sfaa016 LIKE type_t.chr1000, 
   sfoa003 LIKE sfoa_t.sfoa003, 
   l_sfoa003_desc LIKE type_t.chr1000, 
   l_sfaa013_sfoa003 LIKE type_t.chr30, 
   sfoa004 LIKE sfoa_t.sfoa004, 
   l_sfoa004_desc LIKE type_t.chr1000, 
   l_sfaa013_sfoa004 LIKE type_t.chr30, 
   sfoa900 LIKE sfoa_t.sfoa900, 
   sfoa902 LIKE sfoa_t.sfoa902, 
   sfoa905 LIKE sfoa_t.sfoa905, 
   l_sfoa905_desc LIKE type_t.chr1000, 
   sfoaent LIKE sfoa_t.sfoaent, 
   sfob002 LIKE sfob_t.sfob002, 
   l_show LIKE type_t.chr1000, 
   sfob901 LIKE sfob_t.sfob901, 
   l_sfob901_desc LIKE type_t.chr1000, 
   sfob906 LIKE sfob_t.sfob906, 
   l_sfob906_show LIKE type_t.chr1000, 
   sfob003 LIKE sfob_t.sfob003, 
   sfob004 LIKE sfob_t.sfob004, 
   l_sfob003_sfob004 LIKE type_t.chr1000, 
   l_sfob003_desc LIKE type_t.chr1000, 
   sfob005 LIKE sfob_t.sfob005, 
   l_sfob005_desc LIKE type_t.chr1000, 
   sfob006 LIKE sfob_t.sfob006, 
   sfob007 LIKE sfob_t.sfob007, 
   sfob008 LIKE sfob_t.sfob008, 
   l_sfob007_sfob008 LIKE type_t.chr1000, 
   l_sfob007_desc LIKE type_t.chr1000, 
   sfob905 LIKE sfob_t.sfob905, 
   l_sfob905_desc LIKE type_t.chr1000, 
   sfob009 LIKE sfob_t.sfob009, 
   sfob010 LIKE sfob_t.sfob010, 
   l_sfob009_sfob010 LIKE type_t.chr1000, 
   l_sfob009_desc LIKE type_t.chr30, 
   sfob011 LIKE sfob_t.sfob011, 
   l_sfob011_desc LIKE type_t.chr1000, 
   sfob023 LIKE sfob_t.sfob023, 
   sfob024 LIKE sfob_t.sfob024, 
   sfob025 LIKE sfob_t.sfob025, 
   sfob026 LIKE sfob_t.sfob026, 
   sfob012 LIKE sfob_t.sfob012, 
   sfob013 LIKE sfob_t.sfob013, 
   l_sfob012_sfob013 LIKE type_t.chr1000, 
   l_sfob013_desc LIKE type_t.chr1000, 
   sfob014 LIKE sfob_t.sfob014, 
   sfob015 LIKE sfob_t.sfob015, 
   sfob016 LIKE sfob_t.sfob016, 
   sfob017 LIKE sfob_t.sfob017, 
   sfob018 LIKE sfob_t.sfob018, 
   sfob019 LIKE sfob_t.sfob019, 
   sfob052 LIKE sfob_t.sfob052, 
   sfob020 LIKE sfob_t.sfob020, 
   sfob053 LIKE sfob_t.sfob053, 
   sfob054 LIKE sfob_t.sfob054, 
   l_sfob053_sfob054 LIKE type_t.chr1000, 
   sfob021 LIKE sfob_t.sfob021, 
   sfob022 LIKE sfob_t.sfob022, 
   l_sfob021_sfob022 LIKE type_t.chr1000, 
   l_sfob053 LIKE type_t.chr1000, 
   sfoasite LIKE sfoa_t.sfoasite, 
   l_key LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       chk LIKE type_t.chr1,         #列印已刪除項 
       chk2 LIKE type_t.chr1          #列印未變更項
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
 DEFINE g_acc                 LIKE gzcb_t.gzcb004
 TYPE sr3_r RECORD
   sfodseq  LIKE sfod_t.sfodseq,             #項序      sfod008 0/1 check out / check in
   sfod003  LIKE sfod_t.sfod003,             #項目
   l_sfod003   LIKE sfod_t.sfod003,          
   l_sfod003_desc LIKE type_t.chr50,         #項目說明
   l_sfod003_desc1   LIKE type_t.chr50,
   sfod004  LIKE sfod_t.sfod004,             #形態
   l_sfod004   LIKE sfod_t.sfod004,
   l_sfod004_desc LIKE type_t.chr50,         #形態說明
   l_sfod004_desc1   LIKE type_t.chr50,
   sfod005  LIKE sfod_t.sfod005,             #下限
   l_sfod005   LIKE sfod_t.sfod005,    
   sfod006  LIKE sfod_t.sfod006,             #上限
   l_sfod006   LIKE sfod_t.sfod006,
   sfod007  LIKE sfod_t.sfod007,             #預設值
   l_sfod007   LIKE sfod_t.sfod007,          
   sfod008  LIKE sfod_t.sfod008,             #必要
   l_sfod008   LIKE sfod_t.sfod008,
   sfod901  LIKE sfod_t.sfod901,             #變更類型
   l_sfod901   LIKE sfod_t.sfod901,
   l_sfod901_desc LIKE type_t.chr50,         #變更類型說明
   l_sfod901_desc1   LIKE type_t.chr50,
   sfod905  LIKE sfod_t.sfod905,             #變更理由
   l_sfod905   LIKE sfod_t.sfod905,
   l_sfod905_desc LIKE type_t.chr50,         #變更理由說明
   l_sfod905_desc1   LIKE type_t.chr50,
   sfod906  LIKE sfod_t.sfod906,             #變更備註
   l_sfod906   LIKE sfod_t.sfod906,
   l_sfod003_btl   LIKE type_t.num15_3,
   l_sfod003_desc_btl   LIKE type_t.num15_3,
   l_sfod004_desc_btl   LIKE type_t.num15_3,
   l_sfod005_btl   LIKE type_t.num15_3,
   l_sfod006_btl   LIKE type_t.num15_3,
   l_sfod007_btl   LIKE type_t.num15_3,
   l_sfod008_btl   LIKE type_t.num15_3,
   l_show   LIKE type_t.chr2     #判定是否需要列印变更前信息
END RECORD

TYPE sr4_r RECORD  #單身變更欄位
   sfob002           LIKE sfob_t.sfob002,      #項次
   l_show            LIKE type_t.chr2,         #變更前（是否顯示）
   sfob901           LIKE sfob_t.sfob901,      #變更類型
   l_sfob901_desc    LIKE type_t.chr50,        #變更類型說明
   sfob906           LIKE sfob_t.sfob906,      #變更備註
   l_sfob906_show    LIKE type_t.chr2,         #變更備註顯示否
   sfob905           LIKE sfob_t.sfob905,      #變更理由
   l_sfob905_desc    LIKE type_t.chr50,        #變更理由說明          
   l_sfob905_show    LIKE type_t.chr2,         #變更理由顯示否
   sfob003           LIKE sfob_t.sfob003,      #本站作業
   sfob004           LIKE sfob_t.sfob004,      #本站作業序
   l_sfob003_sfob004 LIKE type_t.chr1000, 
   l_sfob003_desc    LIKE type_t.chr50,        #本站作業說明
   sfob005           LIKE sfob_t.sfob005,      #群組性質
   l_sfob005_desc    LIKE type_t.chr50, 
   sfob006           LIKE sfob_t.sfob006,      #群組
   sfob007           LIKE sfob_t.sfob007,      #上站作業
   sfob008           LIKE sfob_t.sfob008,      #上站作業序
   l_sfob007_sfob008 LIKE type_t.chr80,      
   l_sfob007_desc    LIKE type_t.chr50,        #上站作業說明
   sfob009           LIKE sfob_t.sfob009,      #下站作業
   sfob010           LIKE sfob_t.sfob010,      #下站作業序
   l_sfob009_sfob010 LIKE type_t.chr80,      
   l_sfob009_desc    LIKE type_t.chr50,        #下站作業說明
   sfob011           LIKE sfob_t.sfob011,      #工作站
   l_sfob011_desc    LIKE type_t.chr30,        #工作站說明
   sfob023           LIKE sfob_t.sfob023,      #固定工時
   sfob024           LIKE sfob_t.sfob024,      #標準工時
   sfob025           LIKE sfob_t.sfob025,      #固定機時
   sfob026           LIKE sfob_t.sfob026,      #標準機時
   sfob012           LIKE sfob_t.sfob012,      #委外否
   sfob013           LIKE sfob_t.sfob013,      #委外廠商
   l_sfob012_sfob013 LIKE type_t.chr50,      
   l_sfob013_desc    LIKE type_t.chr80, 
   sfob014           LIKE sfob_t.sfob014,      #move in
   sfob015           LIKE sfob_t.sfob015,      #check in
   sfob016           LIKE sfob_t.sfob016,      #報工
   sfob017           LIKE sfob_t.sfob017,      #PQC
   sfob018           LIKE sfob_t.sfob018,      #check out
   sfob019           LIKE sfob_t.sfob019,      #move out
   sfob052           LIKE sfob_t.sfob052,      #轉入單位
   sfob020           LIKE sfob_t.sfob020,      #轉出單位
   sfob053           LIKE sfob_t.sfob053,      #轉入單位轉換率分子
   sfob054           LIKE sfob_t.sfob054,      #轉入單位轉換率分母
   l_sfob053_sfob054 LIKE type_t.chr50,      
   sfob021           LIKE sfob_t.sfob021,      #單位轉換率分子
   sfob022           LIKE sfob_t.sfob022,      #單位轉換率分母
   l_sfob021_sfob022 LIKE type_t.chr50
END RECORD
#150525-00007#2 --- add start ---
DEFINE g_fix_show           LIKE type_t.chr1    #固定 Label
DEFINE g_std_show           LIKE type_t.chr1    #標準 Label
DEFINE g_tranin_show        LIKE type_t.chr1    #轉入 Label
DEFINE g_tranout_show       LIKE type_t.chr1    #轉出 Label
#150525-00007#2 --- add end   ---
#end add-point
 
{</section>}
 
{<section id="asfr801_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr801_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  列印已刪除項 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.chk2  列印未變更項
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"
 
#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
   LET tm.chk2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog    #150525-00007#2 mark
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'asft801'  #150525-00007#2 add  #160816-00001#9  2016/08/17  By 08734 Mark
   LET g_acc = s_fin_get_scc_value('24','asft801','2')  #160816-00001#9  2016/08/17  By 08734 add
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asfr801_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr801_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr801_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr801_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr801_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr801_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE l_wc          STRING
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   LET l_wc=tm.wc
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
  
   #end add-point
   LET g_select = " SELECT sfoadocno,'',sfoa001,'','','',sfoa906,'',sfoa003,'',NULL,sfoa004,'',NULL, 
       sfoa900,sfoa902,sfoa905,'',sfoaent,sfob002,'',sfob901,'',sfob906,'',sfob003,sfob004,'','',sfob005, 
       '',sfob006,sfob007,sfob008,'','',sfob905,'',sfob009,sfob010,'',NULL,sfob011,'',sfob023,sfob024, 
       sfob025,sfob026,sfob012,sfob013,'','',sfob014,sfob015,sfob016,sfob017,sfob018,sfob019,sfob052, 
       sfob020,sfob053,sfob054,'',sfob021,sfob022,'','',sfoasite,''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
 
   LET g_select = " SELECT DISTINCT sfoadocno,(TRIM (sfoadocno) || '   RUN CARD:' || TRIM (sfoa001)),sfoa001,
       sfaa010,imaal003,imaal004,sfoa906,sfaa016,sfoa003,'','',sfoa004,'','',sfoa900,
       sfoa902,sfoa905,'',sfoaent,sfob002,'N',sfob901,'',sfob906,'N',sfob003,
       sfob004,(TRIM (sfob003) || '/' || TRIM (sfob004)),'',sfob005,
       '',sfob006,sfob007,sfob008,(TRIM (sfob007) || '/' || TRIM (sfob008)),
       '',sfob905,'',sfob009,sfob010,(TRIM (sfob009) || '/' || TRIM (sfob010)),
       '',sfob011,'',sfob023,sfob024,sfob025,sfob026,sfob012,sfob013,
       (TRIM (sfob012) || ' ' || TRIM (sfob013)),'',sfob014,sfob015,sfob016,
       sfob017,sfob018,sfob019,sfob052,sfob020,sfob053,sfob054,TRIM (sfob053) || '/' || TRIM (sfob054),sfob021,sfob022,
       TRIM (sfob021) || '/' || TRIM (sfob022),'',sfoasite,TRIM (sfoadocno) || '-' || TRIM (sfoa900)"
   #end add-point
    LET g_from = " FROM  sfoa_t  LEFT OUTER JOIN ( SELECT sfob_t.* FROM sfob_t  ) x  ON sfoa_t.sfoaent  
        = x.sfobent AND sfoa_t.sfoadocno = x.sfobdocno AND sfoa_t.sfoa001 = x.sfob001 AND sfoa_t.sfoa900  
        = x.sfob900"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM sfoa_t",
      #" LEFT JOIN sfob_t ON sfoadocno=sfobdocno AND sfoaent=sfobent AND sfoasite=sfobsite AND sfoa902=sfob902",   #150525-00007#2 mark
       " LEFT JOIN sfob_t ON sfoadocno=sfobdocno AND sfoaent=sfobent AND sfoasite=sfobsite AND sfoa900=sfob900",                       #150525-00007#2 add
       " LEFT JOIN sfaa_t ON sfoadocno=sfaadocno AND sfoasite=sfaasite",
       " LEFT JOIN imaal_t ON imaal001=sfaa010 AND imaalent=sfaaent AND imaal002 = '",g_dlang,"'"                                                                    #150525-00007#2 delete ,
      #" LEFT JOIN oocql_t ON oocqlent='"||g_enterprise||"' AND oocql003='"||g_dlang||"' AND oocql002=sfob905"     #150525-00007#2 mark
   
   IF l_wc.getIndexOf("sfaa010",1) THEN
      LET g_from  = g_from CLIPPED,
          "  LEFT JOIN sfaa_t ON sfaaent=sfoaent AND sfaasite=sfoasite AND sfaadocno=sfoadocno "
   END IF
   IF l_wc.getIndexOf("sfaa016",1) THEN
      LET g_from  = g_from CLIPPED,
          "  LEFT JOIN sfaa_t ON sfaaent=sfoaent AND sfaasite=sfoasite AND sfaadocno=sfoadocno "
   END IF
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   IF tm.chk = 'Y' AND tm.chk2 = 'Y' THEN 
   ELSE
      IF tm.chk = 'Y' AND tm.chk2 = 'N' THEN
         LET g_where = g_where CLIPPED ," AND sfob901 <> '1' "
      END IF
      IF tm.chk = 'N' AND tm.chk2 = 'Y' THEN
         LET g_where = g_where CLIPPED ," AND sfob901 <> '4' "
      END IF
      IF tm.chk = 'N' AND tm.chk2 = 'N' THEN
         LET g_where = g_where CLIPPED ," AND sfob901 not in ('1','4') "
      END IF
   END IF
   #end add-point
    LET g_order = " ORDER BY sfoadocno,sfob002"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY sfoadocno,sfoa900,sfob002"     #150525-00007#2 add
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfoa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr801_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr801_g01_curs CURSOR FOR asfr801_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr801_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr801_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfoadocno LIKE sfoa_t.sfoadocno, 
   l_sfoadocno LIKE type_t.chr1000, 
   sfoa001 LIKE sfoa_t.sfoa001, 
   l_sfaa010 LIKE type_t.chr1000, 
   l_imaal003 LIKE type_t.chr1000, 
   l_imaal004 LIKE type_t.chr1000, 
   sfoa906 LIKE sfoa_t.sfoa906, 
   l_sfaa016 LIKE type_t.chr1000, 
   sfoa003 LIKE sfoa_t.sfoa003, 
   l_sfoa003_desc LIKE type_t.chr1000, 
   l_sfaa013_sfoa003 LIKE type_t.chr30, 
   sfoa004 LIKE sfoa_t.sfoa004, 
   l_sfoa004_desc LIKE type_t.chr1000, 
   l_sfaa013_sfoa004 LIKE type_t.chr30, 
   sfoa900 LIKE sfoa_t.sfoa900, 
   sfoa902 LIKE sfoa_t.sfoa902, 
   sfoa905 LIKE sfoa_t.sfoa905, 
   l_sfoa905_desc LIKE type_t.chr1000, 
   sfoaent LIKE sfoa_t.sfoaent, 
   sfob002 LIKE sfob_t.sfob002, 
   l_show LIKE type_t.chr1000, 
   sfob901 LIKE sfob_t.sfob901, 
   l_sfob901_desc LIKE type_t.chr1000, 
   sfob906 LIKE sfob_t.sfob906, 
   l_sfob906_show LIKE type_t.chr1000, 
   sfob003 LIKE sfob_t.sfob003, 
   sfob004 LIKE sfob_t.sfob004, 
   l_sfob003_sfob004 LIKE type_t.chr1000, 
   l_sfob003_desc LIKE type_t.chr1000, 
   sfob005 LIKE sfob_t.sfob005, 
   l_sfob005_desc LIKE type_t.chr1000, 
   sfob006 LIKE sfob_t.sfob006, 
   sfob007 LIKE sfob_t.sfob007, 
   sfob008 LIKE sfob_t.sfob008, 
   l_sfob007_sfob008 LIKE type_t.chr1000, 
   l_sfob007_desc LIKE type_t.chr1000, 
   sfob905 LIKE sfob_t.sfob905, 
   l_sfob905_desc LIKE type_t.chr1000, 
   sfob009 LIKE sfob_t.sfob009, 
   sfob010 LIKE sfob_t.sfob010, 
   l_sfob009_sfob010 LIKE type_t.chr1000, 
   l_sfob009_desc LIKE type_t.chr30, 
   sfob011 LIKE sfob_t.sfob011, 
   l_sfob011_desc LIKE type_t.chr1000, 
   sfob023 LIKE sfob_t.sfob023, 
   sfob024 LIKE sfob_t.sfob024, 
   sfob025 LIKE sfob_t.sfob025, 
   sfob026 LIKE sfob_t.sfob026, 
   sfob012 LIKE sfob_t.sfob012, 
   sfob013 LIKE sfob_t.sfob013, 
   l_sfob012_sfob013 LIKE type_t.chr1000, 
   l_sfob013_desc LIKE type_t.chr1000, 
   sfob014 LIKE sfob_t.sfob014, 
   sfob015 LIKE sfob_t.sfob015, 
   sfob016 LIKE sfob_t.sfob016, 
   sfob017 LIKE sfob_t.sfob017, 
   sfob018 LIKE sfob_t.sfob018, 
   sfob019 LIKE sfob_t.sfob019, 
   sfob052 LIKE sfob_t.sfob052, 
   sfob020 LIKE sfob_t.sfob020, 
   sfob053 LIKE sfob_t.sfob053, 
   sfob054 LIKE sfob_t.sfob054, 
   l_sfob053_sfob054 LIKE type_t.chr1000, 
   sfob021 LIKE sfob_t.sfob021, 
   sfob022 LIKE sfob_t.sfob022, 
   l_sfob021_sfob022 LIKE type_t.chr1000, 
   l_sfob053 LIKE type_t.chr1000, 
   sfoasite LIKE sfoa_t.sfoasite, 
   l_key LIKE type_t.chr1000
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
    FOREACH asfr801_g01_curs INTO sr_s.*
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
       #去除多余'/'
       #本站作业
       IF sr_s.l_sfob003_sfob004 = '/' THEN
          LET sr_s.l_sfob003_sfob004 = NULL
       END IF
       #上站作业
       IF sr_s.l_sfob007_sfob008 = '/' THEN
          LET sr_s.l_sfob007_sfob008 = NULL
       END IF
       #下站作业
       IF sr_s.l_sfob009_sfob010 = '/' THEN
          LET sr_s.l_sfob009_sfob010 = NULL
       END IF
       IF sr_s.l_sfob012_sfob013 = ' ' THEN
          LET sr_s.l_sfob012_sfob013 = NULL
       END IF
       #转出转换率
       IF sr_s.l_sfob021_sfob022 = '/' THEN
          LET sr_s.l_sfob021_sfob022 = NULL
       END IF
       #转入转换率
       IF sr_s.l_sfob053_sfob054 = '/' THEN
          LET sr_s.l_sfob053_sfob054 = NULL
       END IF
       #显示变更备注
       IF NOT cl_null(sr_s.sfob906) THEN
          LET sr_s.l_sfob906_show = 'Y'
       END IF
       
       #获取说明
       #单位
       IF NOT cl_null(sr_s.sfoa003) THEN
         CALL asfr801_g01_desc('2',g_acc,sr_s.sfoa003) RETURNING sr_s.l_sfoa003_desc
         LET sr_s.l_sfoa003_desc = sr_s.sfoa003,' ',sr_s.l_sfoa003_desc
       END IF
       #单位
       IF NOT cl_null(sr_s.sfoa004) THEN
         CALL asfr801_g01_desc('2',g_acc,sr_s.sfoa004) RETURNING sr_s.l_sfoa004_desc
         LET sr_s.l_sfoa004_desc = sr_s.sfoa004,' ',sr_s.l_sfoa004_desc
       END IF
       #变更理由:sfoa905
       IF NOT cl_null(sr_s.sfoa905) THEN
         CALL asfr801_g01_desc('2',g_acc,sr_s.sfoa905) RETURNING sr_s.l_sfoa905_desc
         LET sr_s.l_sfoa905_desc = sr_s.sfoa905,'.',sr_s.l_sfoa905_desc
       END IF
       #变更理由:sfob905
       IF NOT cl_null(sr_s.sfob905) THEN
         CALL asfr801_g01_desc('2',g_acc,sr_s.sfob905) RETURNING sr_s.l_sfob905_desc
         LET sr_s.l_sfob905_desc = sr_s.sfob905,'.',sr_s.l_sfob905_desc
       END IF
       #变更类型:sfob901
       IF NOT cl_null(sr_s.sfob901) THEN
         CALL asfr801_g01_desc('1','5448',sr_s.sfob901) RETURNING sr_s.l_sfob901_desc
         LET sr_s.l_sfob901_desc = sr_s.sfob901,'.',sr_s.l_sfob901_desc
       END IF
       #群组性质:sfob005
       IF NOT cl_null(sr_s.sfob005) THEN
         CALL asfr801_g01_desc('1','1202',sr_s.sfob005) RETURNING sr_s.l_sfob005_desc
         LET sr_s.l_sfob005_desc = sr_s.sfob005,'.',sr_s.l_sfob005_desc
       END IF
       #本站作业:sfob003
       IF NOT cl_null(sr_s.sfob003) THEN
         CALL asfr801_g01_desc('2','221',sr_s.sfob003) RETURNING sr_s.l_sfob003_desc
       END IF
       #上站作业:sfob007
       IF NOT cl_null(sr_s.sfob007) THEN
         CALL asfr801_g01_desc('2','221', sr_s.sfob007) RETURNING sr_s.l_sfob007_desc
       END IF
       #下站作业:sfob009
       IF NOT cl_null(sr_s.sfob009) THEN
         CALL asfr801_g01_desc('2', '221',sr_s.sfob009) RETURNING sr_s.l_sfob009_desc
       END IF       
       #工作站:sfob011
       IF NOT cl_null(sr_s.sfob011) THEN
         CALL asfr801_g01_desc('3',' ', sr_s.sfob011) RETURNING sr_s.l_sfob011_desc
       END IF
       #委外加工厂商:sfob013
       IF NOT cl_null(sr_s.sfob013) THEN
         CALL asfr801_g01_desc('4',' ', sr_s.sfob013) RETURNING sr_s.l_sfob013_desc
       END IF
       #取得生產數量及完工數量的單位
       #150525-00007#2 add start
       SELECT sfaa013 INTO sr_s.l_sfaa013_sfoa003
         FROM sfaa_t 
        WHERE sfaaent = g_enterprise 
          AND sfaasite = g_site 
          AND sfaadocno = sr_s.sfoadocno
       IF cl_null(sr_s.l_sfaa013_sfoa003) THEN
          LET sr_s.l_sfaa013_sfoa003 = ''
       END IF
       LET sr_s.l_sfaa013_sfoa004 = sr_s.l_sfaa013_sfoa003
       #150525-00007#2 add end
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfoadocno = sr_s.sfoadocno
       LET sr[l_cnt].l_sfoadocno = sr_s.l_sfoadocno
       LET sr[l_cnt].sfoa001 = sr_s.sfoa001
       LET sr[l_cnt].l_sfaa010 = sr_s.l_sfaa010
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].sfoa906 = sr_s.sfoa906
       LET sr[l_cnt].l_sfaa016 = sr_s.l_sfaa016
       LET sr[l_cnt].sfoa003 = sr_s.sfoa003
       LET sr[l_cnt].l_sfoa003_desc = sr_s.l_sfoa003_desc
       LET sr[l_cnt].l_sfaa013_sfoa003 = sr_s.l_sfaa013_sfoa003
       LET sr[l_cnt].sfoa004 = sr_s.sfoa004
       LET sr[l_cnt].l_sfoa004_desc = sr_s.l_sfoa004_desc
       LET sr[l_cnt].l_sfaa013_sfoa004 = sr_s.l_sfaa013_sfoa004
       LET sr[l_cnt].sfoa900 = sr_s.sfoa900
       LET sr[l_cnt].sfoa902 = sr_s.sfoa902
       LET sr[l_cnt].sfoa905 = sr_s.sfoa905
       LET sr[l_cnt].l_sfoa905_desc = sr_s.l_sfoa905_desc
       LET sr[l_cnt].sfoaent = sr_s.sfoaent
       LET sr[l_cnt].sfob002 = sr_s.sfob002
       LET sr[l_cnt].l_show = sr_s.l_show
       LET sr[l_cnt].sfob901 = sr_s.sfob901
       LET sr[l_cnt].l_sfob901_desc = sr_s.l_sfob901_desc
       LET sr[l_cnt].sfob906 = sr_s.sfob906
       LET sr[l_cnt].l_sfob906_show = sr_s.l_sfob906_show
       LET sr[l_cnt].sfob003 = sr_s.sfob003
       LET sr[l_cnt].sfob004 = sr_s.sfob004
       LET sr[l_cnt].l_sfob003_sfob004 = sr_s.l_sfob003_sfob004
       LET sr[l_cnt].l_sfob003_desc = sr_s.l_sfob003_desc
       LET sr[l_cnt].sfob005 = sr_s.sfob005
       LET sr[l_cnt].l_sfob005_desc = sr_s.l_sfob005_desc
       LET sr[l_cnt].sfob006 = sr_s.sfob006
       LET sr[l_cnt].sfob007 = sr_s.sfob007
       LET sr[l_cnt].sfob008 = sr_s.sfob008
       LET sr[l_cnt].l_sfob007_sfob008 = sr_s.l_sfob007_sfob008
       LET sr[l_cnt].l_sfob007_desc = sr_s.l_sfob007_desc
       LET sr[l_cnt].sfob905 = sr_s.sfob905
       LET sr[l_cnt].l_sfob905_desc = sr_s.l_sfob905_desc
       LET sr[l_cnt].sfob009 = sr_s.sfob009
       LET sr[l_cnt].sfob010 = sr_s.sfob010
       LET sr[l_cnt].l_sfob009_sfob010 = sr_s.l_sfob009_sfob010
       LET sr[l_cnt].l_sfob009_desc = sr_s.l_sfob009_desc
       LET sr[l_cnt].sfob011 = sr_s.sfob011
       LET sr[l_cnt].l_sfob011_desc = sr_s.l_sfob011_desc
       LET sr[l_cnt].sfob023 = sr_s.sfob023
       LET sr[l_cnt].sfob024 = sr_s.sfob024
       LET sr[l_cnt].sfob025 = sr_s.sfob025
       LET sr[l_cnt].sfob026 = sr_s.sfob026
       LET sr[l_cnt].sfob012 = sr_s.sfob012
       LET sr[l_cnt].sfob013 = sr_s.sfob013
       LET sr[l_cnt].l_sfob012_sfob013 = sr_s.l_sfob012_sfob013
       LET sr[l_cnt].l_sfob013_desc = sr_s.l_sfob013_desc
       LET sr[l_cnt].sfob014 = sr_s.sfob014
       LET sr[l_cnt].sfob015 = sr_s.sfob015
       LET sr[l_cnt].sfob016 = sr_s.sfob016
       LET sr[l_cnt].sfob017 = sr_s.sfob017
       LET sr[l_cnt].sfob018 = sr_s.sfob018
       LET sr[l_cnt].sfob019 = sr_s.sfob019
       LET sr[l_cnt].sfob052 = sr_s.sfob052
       LET sr[l_cnt].sfob020 = sr_s.sfob020
       LET sr[l_cnt].sfob053 = sr_s.sfob053
       LET sr[l_cnt].sfob054 = sr_s.sfob054
       LET sr[l_cnt].l_sfob053_sfob054 = sr_s.l_sfob053_sfob054
       LET sr[l_cnt].sfob021 = sr_s.sfob021
       LET sr[l_cnt].sfob022 = sr_s.sfob022
       LET sr[l_cnt].l_sfob021_sfob022 = sr_s.l_sfob021_sfob022
       LET sr[l_cnt].l_sfob053 = sr_s.l_sfob053
       LET sr[l_cnt].sfoasite = sr_s.sfoasite
       LET sr[l_cnt].l_key = sr_s.l_key
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr801_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr801_g01_rep_data()
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
          START REPORT asfr801_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr801_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr801_g01_rep
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
 
{<section id="asfr801_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr801_g01_rep(sr1)
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
DEFINE sr3 sr3_r     #子报表1 CHECK IN 项目
DEFINE sr4 sr3_r     #子报表2 CHECK OUT 项目
DEFINE sr5 sr4_r     #單身變更
DEFINE l_subrep05_show  LIKE type_t.chr1,
       l_subrep06_show  LIKE type_t.chr1,
       l_subrep07_show  LIKE type_t.chr1
DEFINE l_count          LIKE type_t.num5
DEFINE l_chk            LIKE type_t.num5
#底線寬度
DEFINE l_sfob003_btl        LIKE type_t.num20_6
DEFINE l_sfob003_desc_btl   LIKE type_t.num20_6
DEFINE l_sfob004_btl        LIKE type_t.num20_6
DEFINE l_sfob005_desc_btl   LIKE type_t.num20_6
DEFINE l_sfob006_btl        LIKE type_t.num20_6
DEFINE l_sfob007_btl        LIKE type_t.num20_6
DEFINE l_sfob007_desc_btl   LIKE type_t.num20_6
DEFINE l_sfob008_btl        LIKE type_t.num20_6
DEFINE l_sfob009_btl        LIKE type_t.num20_6
DEFINE l_sfob009_desc_btl   LIKE type_t.num20_6
DEFINE l_sfob010_btl        LIKE type_t.num20_6
DEFINE l_sfob011_btl        LIKE type_t.num20_6
DEFINE l_sfob011_desc_btl   LIKE type_t.num20_6
DEFINE l_sfob023_btl        LIKE type_t.num20_6
DEFINE l_sfob024_btl        LIKE type_t.num20_6
DEFINE l_sfob025_btl        LIKE type_t.num20_6
DEFINE l_sfob026_btl        LIKE type_t.num20_6
DEFINE l_sfob013_btl        LIKE type_t.num20_6
DEFINE l_sfob013_desc_btl   LIKE type_t.num20_6
DEFINE l_sfob012_btl        LIKE type_t.num20_6
DEFINE l_sfob014_btl        LIKE type_t.num20_6
DEFINE l_sfob015_btl        LIKE type_t.num20_6
DEFINE l_sfob016_btl        LIKE type_t.num20_6
DEFINE l_sfob017_btl        LIKE type_t.num20_6
DEFINE l_sfob019_btl        LIKE type_t.num20_6
DEFINE l_sfob018_btl        LIKE type_t.num20_6
DEFINE l_sfob052_btl        LIKE type_t.num20_6
DEFINE l_sfob020_btl        LIKE type_t.num20_6
DEFINE l_sfob053_btl        LIKE type_t.num20_6
DEFINE l_sfob054_btl        LIKE type_t.num20_6
DEFINE l_sfob021_btl        LIKE type_t.num20_6
DEFINE l_sfob022_btl        LIKE type_t.num20_6
#150525-00007#2 --- add start ---
DEFINE l_sfob905_show       LIKE type_t.chr1      
#150525-00007#2 --- add end   ---
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.sfoadocno,sr1.sfoa900,sr1.sfob002,sr1.sfob905
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
        BEFORE GROUP OF sr1.sfoadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfoadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfoaent=' ,sr1.sfoaent,'{+}sfoadocno=' ,sr1.sfoadocno,'{+}sfoa001=' ,sr1.sfoa001,'{+}sfoa900=' ,sr1.sfoa900         
            CALL cl_gr_init_apr(sr1.sfoadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfoadocno.before name="rep.b_group.sfoadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfoaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfoadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr801_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr801_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr801_g01_subrep01
           DECLARE asfr801_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr801_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr801_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr801_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr801_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfoadocno.after name="rep.b_group.sfoadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfoa900
 
           #add-point:rep.b_group.sfoa900.before name="rep.b_group.sfoa900.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfoa900.after name="rep.b_group.sfoa900.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfob002
 
           #add-point:rep.b_group.sfob002.before name="rep.b_group.sfob002.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfob002.after name="rep.b_group.sfob002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfob905
 
           #add-point:rep.b_group.sfob905.before name="rep.b_group.sfob905.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfob905.after name="rep.b_group.sfob905.after"
           
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
                sr1.sfoaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfoadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr801_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr801_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr801_g01_subrep02
           DECLARE asfr801_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr801_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr801_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr801_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr801_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          #單身子報表
          START REPORT asfr801_g01_subrep07
             #单身此笔变更类型为1.未变更3.单身新增4.单身删除时，不显示变更前资料
             LET sr5.l_show = 'N'
             #150525-00007#2 --- add start ---
             LET g_fix_show = 'N'
             LET g_std_show = 'N'
             LET g_tranin_show = 'N'
             LET g_tranout_show = 'N'
             #150525-00007#2 --- add end   ---
             IF sr1.sfob901 = '2' THEN
                LET sr5.l_show = 'Y'      #僅決定是否顯示變更前資料
             END IF
             IF NOT cl_null(sr1.sfob901) THEN
                LET sr5.sfob901 = sr1.sfob901
                LET sr5.l_sfob901_desc = sr1.l_sfob901_desc
             END IF
             LET sr5.l_sfob906_show = 'N'    #變更備註
             IF NOT cl_null(sr1.sfob906) THEN
                LET sr5.sfob906 = sr1.sfob906
                LET sr5.l_sfob906_show = 'Y'
             END IF
             LET sr5.l_sfob905_show = 'N'    #變更理由
             LET l_sfob905_show = 'N'      #150525-00007#2 add
             IF NOT cl_null(sr1.sfob905) THEN
                LET sr5.sfob905 = sr1.sfob905
                LET sr5.l_sfob905_desc = sr1.l_sfob905_desc
                LET sr5.l_sfob905_show = 'Y'
                LET l_sfob905_show = 'Y'      #150525-00007#2 add
             END IF
             LET l_sfob003_btl = 0
             LET l_sfob003_desc_btl = 0
             LET l_sfob004_btl = 0
             LET l_sfob005_desc_btl = 0
             LET l_sfob006_btl = 0
             LET l_sfob007_btl = 0
             LET l_sfob007_desc_btl = 0
             LET l_sfob008_btl = 0
             LET l_sfob009_btl = 0
             LET l_sfob009_desc_btl = 0
             LET l_sfob010_btl = 0
             LET l_sfob011_btl = 0
             LET l_sfob011_desc_btl = 0
             LET l_sfob023_btl = 0
             LET l_sfob024_btl = 0
             LET l_sfob025_btl = 0
             LET l_sfob026_btl = 0
             LET l_sfob013_btl = 0
             LET l_sfob013_desc_btl = 0
             LET l_sfob012_btl = 0
             LET l_sfob014_btl = 0
             LET l_sfob015_btl = 0
             LET l_sfob016_btl = 0
             LET l_sfob017_btl = 0
             LET l_sfob019_btl = 0
             LET l_sfob018_btl = 0
             LET l_sfob052_btl = 0
             LET l_sfob020_btl = 0
             LET l_sfob053_btl = 0
             LET l_sfob054_btl = 0
             LET l_sfob021_btl = 0
             LET l_sfob022_btl = 0
             LET l_subrep07_show ='Y'  
             IF sr1.sfob901 = '2' THEN
                LET l_count = 0
                #本站作業sfob003
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb003','0') RETURNING sr5.sfob003,l_cnt            
                LET l_sfob003_btl = 0.5
                LET l_sfob003_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_sfob003_btl = 0
                   LET l_sfob003_desc_btl = 0
                   LET sr5.sfob003 = NULL 
                   LET sr5.l_sfob003_desc =NULL 
                ELSE
                   CALL asfr801_g01_desc('2','221',sr5.sfob003) RETURNING sr5.l_sfob003_desc
                   LET l_count = l_count + 1
                END IF  
                
                #本站作業序sfob004     
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb004','0') RETURNING sr5.sfob004,l_cnt            
                LET l_sfob004_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob004_btl = 0
                   LET sr5.sfob004 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF  
                
                #群組性質sfob005
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb005','0') RETURNING sr5.sfob005,l_cnt            
                LET l_sfob005_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_sfob005_desc_btl = 0
                   LET sr5.sfob005 = NULL  
                   LET sr5.l_sfob005_desc =NULL  
                ELSE
                   CALL asfr801_g01_desc('1','1202',sr5.sfob005) RETURNING sr5.l_sfob005_desc
                   LET sr5.l_sfob005_desc = sr5.sfob005,'.',sr5.l_sfob005_desc
                   LET l_count = l_count + 1
                END IF  
                #群组sfob006 
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb006','0') RETURNING sr5.sfob006,l_cnt            
                LET l_sfob006_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob006_btl = 0
                   LET sr5.sfob006 = '' 
                ELSE
                   LET l_count = l_count + 1
                END IF 

                #上站作業sfob007
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb007','0') RETURNING sr5.sfob007,l_cnt            
                LET l_sfob007_btl = 0.5
                LET l_sfob007_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_sfob007_btl = 0
                   LET l_sfob007_desc_btl = 0
                   LET sr5.sfob007 = NULL  
                   LET sr5.l_sfob007_desc =NULL 
                ELSE
                   CALL asfr801_g01_desc('2','221',sr5.sfob007) RETURNING sr5.l_sfob007_desc
                   LET l_count = l_count + 1
                END IF  
                
                #上站作業序sfob008
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb008','0') RETURNING sr5.sfob008,l_cnt            
                LET l_sfob008_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob008_btl = 0
                   LET sr5.sfob008 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF 
   
                #下站作業sfob009
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb009','0') RETURNING sr5.sfob009,l_cnt            
                LET l_sfob009_btl = 0.5
                LET l_sfob009_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_sfob009_btl = 0
                   LET l_sfob009_desc_btl = 0
                   LET sr5.sfob009 = NULL 
                   LET sr5.l_sfob009_desc =NULL  
                ELSE
                   CALL asfr801_g01_desc('2','221',sr5.sfob009) RETURNING sr5.l_sfob009_desc
                   LET l_count = l_count + 1
                END IF  
                
                #下站作業序sfob010
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb010','0') RETURNING sr5.sfob010,l_cnt            
                LET l_sfob010_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob010_btl = 0
                   LET sr5.sfob010 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF 
                
                #工作站sfob011
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb011','0') RETURNING sr5.sfob011,l_cnt            
                LET l_sfob011_btl = 0.5
                LET l_sfob011_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_sfob011_btl = 0
                   LET l_sfob011_desc_btl = 0
                   LET sr5.sfob011 = NULL  
                   LET sr5.l_sfob011_desc =NULL 
                ELSE
                   CALL asfr801_g01_desc('3',' ',sr5.sfob011) RETURNING sr5.l_sfob011_desc
                   LET l_count = l_count + 1
                END IF  
                
                #固定工時sfob023
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb023','0') RETURNING sr5.sfob023,l_cnt            
                LET l_sfob023_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob023_btl = 0
                  #LET sr5.sfob023 = -1     #150525-00007#2 mark
                ELSE
                   LET l_count = l_count + 1
                   LET g_fix_show = 'Y'     #150525-00007#2 add
                END IF 
                #標準工時sfob024
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb024','0') RETURNING sr5.sfob024,l_cnt            
                LET l_sfob024_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob024_btl = 0
                  #LET sr5.sfob024 = -1      #150525-00007#2 mark
                ELSE
                   LET l_count = l_count + 1
                   LET g_std_show = 'Y'     #150525-00007#2 add
                END IF 
                #固定機時sfob025
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb025','0') RETURNING sr5.sfob025,l_cnt            
                LET l_sfob025_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob025_btl = 0
                  #LET sr5.sfob025 = -1       #150525-00007#2 mark
                ELSE
                   LET l_count = l_count + 1
                   LET g_fix_show = 'Y'     #150525-00007#2 add
                END IF 
                #標準機時sfob026
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb026','0') RETURNING sr5.sfob026,l_cnt            
                LET l_sfob026_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob026_btl = 0
                  #LET sr5.sfob026 = -1       #150525-00007#2 mark
                ELSE
                   LET l_count = l_count + 1
                   LET g_std_show = 'Y'     #150525-00007#2 add
                END IF 
                
                #委外加工廠商sfob013
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb013','0') RETURNING sr5.sfob013,l_cnt            
                LET l_sfob013_btl = 0.5
                LET l_sfob013_desc_btl = 0.5
                IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                   LET l_sfob013_btl = 0
                   LET l_sfob013_desc_btl = 0
                   LET sr5.sfob013 = NULL  
                   LET sr5.l_sfob013_desc = NULL 
                ELSE
                   CALL asfr801_g01_desc('4',' ',sr5.sfob013) RETURNING sr5.l_sfob013_desc
                   LET l_count = l_count + 1
                END IF  
                
                #委外否sfob012 
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb012','0') RETURNING sr5.sfob012,l_cnt            
                LET l_sfob012_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob012_btl = 0
                   LET sr5.sfob012 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF
                
                #MOVE IN sfob014
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb014','0') RETURNING sr5.sfob014,l_cnt            
                LET l_sfob014_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob014_btl = 0
                   LET sr5.sfob014 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF
                #CHECK IN sfob015
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb015','0') RETURNING sr5.sfob015,l_cnt            
                LET l_sfob015_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob015_btl = 0
                   LET sr5.sfob015 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF
                #報工 sfob016
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb016','0') RETURNING sr5.sfob016,l_cnt            
                LET l_sfob016_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob016_btl = 0
                   LET sr5.sfob016 = NULL 
                ELSE
                   LET l_count = l_count + 1
                END IF
                #PQC sfob017
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb017','0') RETURNING sr5.sfob017,l_cnt            
                LET l_sfob017_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob017_btl = 0
                   LET sr5.sfob017 = NULL 
                ELSE
                   LET l_count = l_count + 1
                END IF
                #MOVE OUT sfob019 
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb019','0') RETURNING sr5.sfob019,l_cnt            
                LET l_sfob019_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob019_btl = 0
                   LET sr5.sfob019 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF
                #CHECK OUT sfob018
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb018','0') RETURNING sr5.sfob018,l_cnt            
                LET l_sfob018_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob018_btl = 0
                   LET sr5.sfob018 = NULL  
                ELSE
                   LET l_count = l_count + 1
                END IF
                #轉入單位 sfob052
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb052','0') RETURNING sr5.sfob052,l_cnt            
                LET l_sfob052_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob052_btl = 0
                   LET sr5.sfob052 = NULL
                ELSE
                   LET l_count = l_count + 1
                   LET g_tranin_show = 'Y'     #150525-00007#2 add
                END IF
                #轉出單位 sfob020
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb020','0') RETURNING sr5.sfob020,l_cnt            
                LET l_sfob020_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob020_btl = 0
                   LET sr5.sfob020 = NULL 
                ELSE
                   LET l_count = l_count + 1
                   LET g_tranout_show = 'Y'    #150525-00007#2 add
                END IF
                
                #轉入轉換率分子 sfob053
                LET l_chk = 0 #計算是否分子分母都變動
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb053','0') RETURNING sr5.sfob053,l_cnt            
                LET l_sfob053_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob053_btl = 0
                   LET sr5.sfob053 = NULL 
                   LET sr5.l_sfob053_sfob054 = sr1.sfob053 USING '######'
                ELSE
                   LET sr5.l_sfob053_sfob054 = sr5.sfob053 USING '######'
                   LET l_chk = l_chk + 1
                   LET l_count = l_count + 1
                END IF
                
                #轉入轉換率分母 sfob054
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb054','0') RETURNING sr5.sfob054,l_cnt            
                LET l_sfob054_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob054_btl = 0
                   LET sr5.sfob054 = NULL  
                   LET sr5.l_sfob053_sfob054 = sr5.l_sfob053_sfob054,'/',sr1.sfob054 USING '######' CLIPPED
                ELSE
                   LET sr5.l_sfob053_sfob054 = sr5.l_sfob053_sfob054,'/',sr5.sfob054 USING '######' CLIPPED
                   LET l_chk = l_chk + 1
                   LET l_count = l_count + 1
                END IF
                IF l_chk = 0 THEN
                   LET sr5.l_sfob053_sfob054 = NULL  #150525-00007#2 add
                END IF
                #轉出轉換率分子 sfob021
                LET l_chk = 0
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb021','0') RETURNING sr5.sfob021,l_cnt            
                LET l_sfob021_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob021_btl = 0
                   LET sr5.sfob021 = NULL  
                   LET sr5.l_sfob021_sfob022= sr1.sfob021 USING '######'
                ELSE
                   LET sr5.l_sfob021_sfob022 = sr5.sfob021 USING '######'
                   LET l_chk = l_chk + 1
                   LET l_count = l_count + 1
                END IF
                #轉出轉換率分母 sfob022
                CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfcb022','0') RETURNING sr5.sfob022,l_cnt            
                LET l_sfob022_btl = 0.5             
                IF l_cnt = 0 OR cl_null(l_cnt) THEN 
                   LET l_sfob022_btl = 0
                   LET sr5.sfob022 = NULL 
                   LET sr5.l_sfob021_sfob022 = sr5.l_sfob021_sfob022,'/',sr1.sfob022 USING '######'
                ELSE
                   LET sr5.l_sfob021_sfob022 = sr5.l_sfob021_sfob022,'/',sr5.sfob022 USING '######'
                   LET l_chk = l_chk + 1
                   LET l_count = l_count + 1
                END IF
                IF l_chk = 0 THEN
                   LET sr5.l_sfob021_sfob022 = NULL   #150525-00007#2 add
                END IF
                IF l_count = 0 AND sr5.l_show = 'Y' THEN #僅決定是否顯示變更前資料
                   LET sr5.l_show ='N'
                END IF
                
                #150525-00007#2 --- add start ---                
                LET sr5.l_sfob003_sfob004 = sr5.sfob003
                IF NOT cl_null(sr5.sfob004) THEN
                   LET sr5.l_sfob003_sfob004 = sr5.sfob003,'/',sr5.sfob004
                END IF
                LET sr5.l_sfob007_sfob008 = sr5.sfob007
                IF NOT cl_null(sr5.sfob008) THEN
                   LET sr5.l_sfob007_sfob008 = sr5.sfob007,'/',sr5.sfob008
                END IF
                LET sr5.l_sfob009_sfob010 = sr5.sfob009
                IF NOT cl_null(sr5.sfob010) THEN
                   LET sr5.l_sfob009_sfob010 = sr5.sfob009,'/',sr5.sfob010
                END IF
                LET sr5.l_sfob012_sfob013 = sr5.sfob012
                IF NOT cl_null(sr5.sfob013) THEN
                   LET sr5.l_sfob012_sfob013 = sr5.sfob012,'/',sr5.sfob013
                END IF
                LET sr5.l_sfob021_sfob022 = sr5.sfob021 USING '######'
                IF NOT cl_null(sr5.sfob022) THEN
                   LET sr5.l_sfob021_sfob022 = sr5.l_sfob021_sfob022,'/',sr5.sfob022 USING '######'
                END IF
                LET sr5.l_sfob053_sfob054 = sr5.sfob053 USING '######'
                IF NOT cl_null(sr5.sfob054) THEN
                   LET sr5.l_sfob053_sfob054 = sr5.l_sfob053_sfob054,'/',sr5.sfob054 USING '######'
                END IF
                #150525-00007#2 --- add end   ---
             END IF
             
          OUTPUT TO REPORT asfr801_g01_subrep07(sr5.*)
          FINISH REPORT asfr801_g01_subrep07
          PRINTX l_subrep07_show
          PRINTX l_sfob003_btl
          PRINTX l_sfob003_desc_btl
          PRINTX l_sfob004_btl
          PRINTX l_sfob005_desc_btl
          PRINTX l_sfob006_btl
          PRINTX l_sfob007_btl
          PRINTX l_sfob007_desc_btl
          PRINTX l_sfob008_btl
          PRINTX l_sfob009_btl
          PRINTX l_sfob009_desc_btl
          PRINTX l_sfob010_btl
          PRINTX l_sfob011_btl
          PRINTX l_sfob011_desc_btl
          PRINTX l_sfob023_btl
          PRINTX l_sfob024_btl
          PRINTX l_sfob025_btl
          PRINTX l_sfob026_btl
          PRINTX l_sfob013_btl
          PRINTX l_sfob013_desc_btl
          PRINTX l_sfob012_btl
          PRINTX l_sfob014_btl
          PRINTX l_sfob015_btl
          PRINTX l_sfob016_btl
          PRINTX l_sfob017_btl
          PRINTX l_sfob019_btl
          PRINTX l_sfob018_btl
          PRINTX l_sfob052_btl
          PRINTX l_sfob020_btl
          PRINTX l_sfob053_btl
          PRINTX l_sfob054_btl
          PRINTX l_sfob021_btl
          PRINTX l_sfob022_btl
          PRINTX l_sfob905_show    #150525-00007#2 add
          ######################################
-----------子报表一：CHECK IN 项目------           
          LET g_sql = " SELECT DISTINCT sfodseq,sfod003,NULL,NULL,NULL,sfod004,NULL,NULL,NULL,sfod005,NULL,sfod006,NULL,sfod007,NULL,",
                       " sfod008,NULL,sfod901,NULL,NULL,NULL,sfod905,NULL,NULL,NULL,sfod906,NULL,'0','0','0','0','0','0','0','N' ",
                       " FROM sfod_t ",
                       " WHERE sfodent = ",g_enterprise CLIPPED,
                       " AND sfodsite = '",g_site CLIPPED,"' ",
                       " AND sfoddocno = '",sr1.sfoadocno CLIPPED,"' ",
                       " AND sfod001 = trim('",sr1.sfoa001 CLIPPED,"') ",
                       " AND sfod900 = trim('",sr1.sfoa900 CLIPPED,"') ",
                       " AND sfod002 = trim('",sr1.sfob002 CLIPPED,"') ",
                       " AND sfod009 = '1' "
                                 
           IF tm.chk = 'Y' AND tm.chk2 = 'Y' THEN 
           ELSE
              IF tm.chk = 'Y' AND tm.chk2 = 'N' THEN
                 LET g_sql = g_sql CLIPPED ," AND sfod901 <> '1' "
              END IF
              IF tm.chk = 'N' AND tm.chk2 = 'Y' THEN
                 LET g_sql = g_sql CLIPPED ," AND sfod901 <> '4' "
              END IF
              IF tm.chk = 'N' AND tm.chk2 = 'N' THEN
                 LET g_sql = g_sql CLIPPED ," AND sfod901 not in ('1','4') "
              END IF
           END IF

           LET g_sql = g_sql CLIPPED ," ORDER BY sfodseq "
       
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr801_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE asfr801_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT asfr801_g01_subrep05
           DECLARE asfr801_g01_repcur05 CURSOR FROM g_sql
           FOREACH asfr801_g01_repcur05 INTO sr3.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr801_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #项目说明：sfod003
              IF NOT cl_null(sr3.sfod003) THEN 
                CALL asfr801_g01_desc('2','223',sr3.sfod003) RETURNING sr3.l_sfod003_desc
              END IF
              #形态:sfod004
              IF NOT cl_null(sr3.sfod004) THEN 
                CALL asfr801_g01_desc('1','1201',sr3.sfod004) RETURNING sr3.l_sfod004_desc
                LET sr3.l_sfod004_desc = sr3.sfod004,'.',sr3.l_sfod004_desc
              END IF
              #变更类型:sfod901
              IF NOT cl_null(sr3.sfod901) THEN 
                CALL asfr801_g01_desc('1','5448',sr3.sfod901) RETURNING sr3.l_sfod901_desc
                LET sr3.l_sfod901_desc = sr3.sfod901,'.',sr3.l_sfod901_desc
              END IF
              #变更理由:sfod905
              IF NOT cl_null(sr3.sfod905) THEN 
                CALL asfr801_g01_desc('2',g_acc,sr3.sfod905) RETURNING sr3.l_sfod905_desc
                LET sr3.l_sfod905_desc = sr3.sfod905,'.',sr3.l_sfod905_desc
              END IF
              --------------变更前资料----------
              LET sr3.l_sfod003_btl = 0
              LET sr3.l_sfod003_desc_btl = 0
              LET sr3.l_sfod004_desc_btl = 0
              LET sr3.l_sfod005_btl = 0
              LET sr3.l_sfod006_btl = 0
              LET sr3.l_sfod007_btl = 0
              LET sr3.l_sfod008_btl = 0
              IF sr3.sfod901 = '2' THEN 
                 LET l_count = 0
                 LET sr3.l_show = 'N'   #150525-00007#2 add
                 #项目说明 sfod003
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod003',sr3.sfodseq) RETURNING sr3.l_sfod003,l_cnt            
                 LET sr3.l_sfod003_btl = 0.5
                 LET sr3.l_sfod003_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod003_btl = 0
                    LET sr3.l_sfod003_desc_btl = 0
                    LET sr3.l_sfod003 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF  
                 #形态 l_sfod004_desc_btl 
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod004',sr3.sfodseq) RETURNING sr3.l_sfod004,l_cnt            
                 LET sr3.l_sfod004_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod004_desc_btl = 0
                    LET sr3.l_sfod004 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                  
                 #下限 l_sfod005_btl
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod005',sr3.sfodseq) RETURNING sr3.l_sfod005,l_cnt            
                 LET sr3.l_sfod005_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod005_btl = 0
                    LET sr3.l_sfod005 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #上限 l_sfod006_btl  
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod006',sr3.sfodseq) RETURNING sr3.l_sfod006,l_cnt            
                 LET sr3.l_sfod006_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod006_btl = 0
                    LET sr3.l_sfod006 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #默认值 l_sfod007_btl  
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod007',sr3.sfodseq) RETURNING sr3.l_sfod007,l_cnt            
                 LET sr3.l_sfod007_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod007_btl = 0
                    LET sr3.l_sfod007 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #必要 l_sfod008_btl 
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod008',sr3.sfodseq) RETURNING sr3.l_sfod008,l_cnt            
                 LET sr3.l_sfod008_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod008_btl = 0
                    LET sr3.l_sfod008 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 IF l_count <> 0 THEN
                     LET sr3.l_show = 'Y'
                 END IF
                  
                 #项目说明：l_sfod003
                 IF NOT cl_null(sr3.l_sfod003) THEN 
                    CALL asfr801_g01_desc('2','223',sr3.l_sfod003) RETURNING sr3.l_sfod003_desc1
                 END IF
                 #形态:l_sfod004
                 IF NOT cl_null(sr3.l_sfod004) THEN 
                    CALL asfr801_g01_desc('1','1201',sr3.l_sfod004) RETURNING sr3.l_sfod004_desc1
                    LET sr3.l_sfod004_desc1 = sr3.l_sfod004,'.',sr3.l_sfod004_desc1
                 END IF
                 #变更类型:l_sfod901
                 IF NOT cl_null(sr3.l_sfod901) THEN 
                    CALL asfr801_g01_desc('1','5448',sr3.l_sfod901) RETURNING sr3.l_sfod901_desc1
                    LET sr3.l_sfod901_desc1 = sr3.l_sfod901,'.',sr3.l_sfod901_desc1
                 END IF
                 #变更理由:l_sfod905
                 IF NOT cl_null(sr3.l_sfod905) THEN 
                   CALL asfr801_g01_desc('2',g_acc,sr3.l_sfod905) RETURNING sr3.l_sfod905_desc1
                   LET sr3.l_sfod905_desc1 = sr3.l_sfod905,'.',sr3.l_sfod905_desc1
                 END IF
              END IF
              
           OUTPUT TO REPORT asfr801_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT asfr801_g01_subrep05
           
-----------子报表二：CHECK OUT 项目------    
          LET g_sql = " SELECT DISTINCT sfodseq,sfod003,NULL,NULL,NULL,sfod004,NULL,NULL,NULL,sfod005,NULL,sfod006,NULL,sfod007,NULL,",
                       " sfod008,NULL,sfod901,NULL,NULL,NULL,sfod905,NULL,NULL,NULL,sfod906,NULL,'0','0','0','0','0','0','0','N' ",
                       " FROM sfod_t ",
                       " WHERE sfodent = ",g_enterprise CLIPPED,
                       " AND sfodsite = '",g_site CLIPPED,"' ",
                       " AND sfoddocno = '",sr1.sfoadocno CLIPPED,"' ",
                       " AND sfod001 = trim('",sr1.sfoa001 CLIPPED,"') ",
                       " AND sfod900 = trim('",sr1.sfoa900 CLIPPED,"') ",
                       " AND sfod002 = trim('",sr1.sfob002 CLIPPED,"') ",
                       " AND sfod009 = '2' "
                                 
           IF tm.chk = 'Y' AND tm.chk2 = 'Y' THEN 
           ELSE
              IF tm.chk = 'Y' AND tm.chk2 = 'N' THEN
                 LET g_sql = g_sql CLIPPED ," AND sfod901 <> '1' "
              END IF
              IF tm.chk = 'N' AND tm.chk2 = 'Y' THEN
                 LET g_sql = g_sql CLIPPED ," AND sfod901 <> '4' "
              END IF
              IF tm.chk = 'N' AND tm.chk2 = 'N' THEN
                 LET g_sql = g_sql CLIPPED ," AND sfod901 not in ('1','4') "
              END IF
           END IF
           
           LET g_sql = g_sql CLIPPED ," ORDER BY sfodseq "
       
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr801_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE asfr801_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show
           START REPORT asfr801_g01_subrep06
           DECLARE asfr801_g01_repcur06 CURSOR FROM g_sql
           FOREACH asfr801_g01_repcur06 INTO sr4.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr801_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #项目说明：sfod003
              IF NOT cl_null(sr3.sfod003) THEN 
                CALL asfr801_g01_desc('2','223',sr3.sfod003) RETURNING sr3.l_sfod003_desc
              END IF
              #形态:sfod004
              IF NOT cl_null(sr3.sfod004) THEN 
                CALL asfr801_g01_desc('1','1201',sr3.sfod004) RETURNING sr3.l_sfod004_desc
                LET sr3.l_sfod004_desc = sr3.sfod004,'.',sr3.l_sfod004_desc
              END IF
              #变更类型:sfod901
              IF NOT cl_null(sr3.sfod901) THEN 
                CALL asfr801_g01_desc('1','5448',sr3.sfod901) RETURNING sr3.l_sfod901_desc
                LET sr3.l_sfod901_desc = sr3.sfod901,'.',sr3.l_sfod901_desc
              END IF
              #变更理由:sfod905
              IF NOT cl_null(sr3.sfod905) THEN 
                CALL asfr801_g01_desc('2',g_acc,sr3.sfod905) RETURNING sr3.l_sfod905_desc
                LET sr3.l_sfod905_desc = sr3.sfod905,'.',sr3.l_sfod905_desc
              END IF
              --------------变更前资料----------
              LET sr3.l_sfod003_btl = 0
              LET sr3.l_sfod003_desc_btl = 0
              LET sr3.l_sfod004_desc_btl = 0
              LET sr3.l_sfod005_btl = 0
              LET sr3.l_sfod006_btl = 0
              LET sr3.l_sfod007_btl = 0
              LET sr3.l_sfod008_btl = 0
              IF sr3.sfod901 = '2' THEN 
                 LET l_count = 0
                 LET sr3.l_show = 'N'   #150525-00007#2 add
                 #项目说明 sfod003
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod003',sr3.sfodseq) RETURNING sr3.l_sfod003,l_cnt            
                 LET sr3.l_sfod003_btl = 0.5
                 LET sr3.l_sfod003_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod003_btl = 0
                    LET sr3.l_sfod003_desc_btl = 0
                    LET sr3.l_sfod003 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF  
                 #形态 l_sfod004_desc_btl 
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod004',sr3.sfodseq) RETURNING sr3.l_sfod004,l_cnt            
                 LET sr3.l_sfod004_desc_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod004_desc_btl = 0
                    LET sr3.l_sfod004 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                  
                 #下限 l_sfod005_btl
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod005',sr3.sfodseq) RETURNING sr3.l_sfod005,l_cnt            
                 LET sr3.l_sfod005_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod005_btl = 0
                    LET sr3.l_sfod005 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #上限 l_sfod006_btl  
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod006',sr3.sfodseq) RETURNING sr3.l_sfod006,l_cnt            
                 LET sr3.l_sfod006_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod006_btl = 0
                    LET sr3.l_sfod006 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #默认值 l_sfod007_btl  
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod007',sr3.sfodseq) RETURNING sr3.l_sfod007,l_cnt            
                 LET sr3.l_sfod007_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod007_btl = 0
                    LET sr3.l_sfod007 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 #必要 l_sfod008_btl 
                 CALL asfr801_g01_chg(sr1.sfoaent,sr1.sfoadocno,sr1.sfoa001,sr1.sfob002,sr1.sfoa900,'sfod008',sr3.sfodseq) RETURNING sr3.l_sfod008,l_cnt            
                 LET sr3.l_sfod008_btl = 0.5
                 IF l_cnt = 0 OR cl_null(l_cnt) THEN                             
                    LET sr3.l_sfod008_btl = 0
                    LET sr3.l_sfod008 = NULL 
                 ELSE
                    LET l_count = l_count + 1
                 END IF                 
                 IF l_count <> 0 THEN
                     LET sr3.l_show = 'Y'
                 END IF
                  
                 #项目说明：l_sfod003
                 IF NOT cl_null(sr3.l_sfod003) THEN 
                    CALL asfr801_g01_desc('2','223',sr3.l_sfod003) RETURNING sr3.l_sfod003_desc1
                 END IF
                 #形态:l_sfod004
                 IF NOT cl_null(sr3.l_sfod004) THEN 
                    CALL asfr801_g01_desc('1','1201',sr3.l_sfod004) RETURNING sr3.l_sfod004_desc1
                    LET sr3.l_sfod004_desc1 = sr3.l_sfod004,'.',sr3.l_sfod004_desc1
                 END IF
                 #变更类型:l_sfod901
                 IF NOT cl_null(sr3.l_sfod901) THEN 
                    CALL asfr801_g01_desc('1','5448',sr3.l_sfod901) RETURNING sr3.l_sfod901_desc1
                    LET sr3.l_sfod901_desc1 = sr3.l_sfod901,'.',sr3.l_sfod901_desc1
                 END IF
                 #变更理由:l_sfod905
                 IF NOT cl_null(sr3.l_sfod905) THEN 
                   CALL asfr801_g01_desc('2',g_acc,sr3.l_sfod905) RETURNING sr3.l_sfod905_desc1
                   LET sr3.l_sfod905_desc1 = sr3.l_sfod905,'.',sr3.l_sfod905_desc1
                 END IF
              END IF
              
           OUTPUT TO REPORT asfr801_g01_subrep06(sr4.*)
           END FOREACH
           FINISH REPORT asfr801_g01_subrep06
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.sfoaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr801_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr801_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr801_g01_subrep03
           DECLARE asfr801_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr801_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr801_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr801_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr801_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfoadocno
 
           #add-point:rep.a_group.sfoadocno.before name="rep.a_group.sfoadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfoaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfoadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr801_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr801_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr801_g01_subrep04
           DECLARE asfr801_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr801_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr801_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr801_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr801_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfoadocno.after name="rep.a_group.sfoadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfoa900
 
           #add-point:rep.a_group.sfoa900.before name="rep.a_group.sfoa900.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfoa900.after name="rep.a_group.sfoa900.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfob002
 
           #add-point:rep.a_group.sfob002.before name="rep.a_group.sfob002.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfob002.after name="rep.a_group.sfob002.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfob905
 
           #add-point:rep.a_group.sfob905.before name="rep.a_group.sfob905.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfob905.after name="rep.a_group.sfob905.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr801_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr801_g01_subrep01(sr2)
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
PRIVATE REPORT asfr801_g01_subrep02(sr2)
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
PRIVATE REPORT asfr801_g01_subrep03(sr2)
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
PRIVATE REPORT asfr801_g01_subrep04(sr2)
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
 
{<section id="asfr801_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 获取变更前资料
# Memo...........:
# Usage..........: CALL asrfr801_g01_chg(p_sfoeent,p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoeseq2,p_sfoe001,p_sfoe002)
#                  RETURNING r_sfoe004,r_cnt
# Input parameter: p_srcfent      营运据点
#                : p_sfoedocno    工单单号
#                : p_sfoeseq      Run Card
#                : p_sfoeseq1     项次
#                : p_sfoe001      变更序
#                : p_sfoe002      变更栏位
#                : p_sfoeseq2     项序
# Return code....: r_sfoe004      变更前值
#                : r_cnt          条数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr801_g01_chg(p_sfoeent,p_sfoedocno,p_sfoeseq,p_sfoeseq1,p_sfoe001,p_sfoe002,p_sfoeseq2)
DEFINE p_sfoeent   LIKE sfoe_t.sfoeent   
DEFINE p_sfoedocno LIKE sfoe_t.sfoedocno #類型
DEFINE p_sfoeseq   LIKE sfoe_t.sfoeseq
DEFINE p_sfoeseq1  LIKE sfoe_t.sfoeseq1
DEFINE p_sfoeseq2  LIKE sfoe_t.sfoeseq2  
DEFINE p_sfoe001   LIKE sfoe_t.sfoe001   #變更序 
DEFINE p_sfoe002   LIKE sfoe_t.sfoe002   #變更欄位名稱
DEFINE r_cnt       LIKE type_t.num5
DEFINE r_sfoe004   LIKE sfoe_t.sfoe004   #變更前欄位數值

   LET r_sfoe004  = ''
   LET r_cnt = 0
      SELECT COUNT(*) INTO r_cnt
      FROM sfoe_t
      WHERE sfoeent = p_sfoeent AND sfoesite = g_site
         AND sfoedocno = p_sfoedocno
         AND sfoeseq = p_sfoeseq
         AND sfoeseq1 = p_sfoeseq1
         AND sfoeseq2 = p_sfoeseq2
         AND sfoe001 = p_sfoe001
         AND sfoe002 = p_sfoe002
         AND sfoe004 IS NOT NULL
      IF r_cnt ! =0 THEN 
         SELECT sfoe004 INTO r_sfoe004
           FROM sfoe_t
          WHERE sfoeent = p_sfoeent AND sfoesite = g_site
            AND sfoedocno = p_sfoedocno
            AND sfoeseq = p_sfoeseq
            AND sfoeseq1 = p_sfoeseq1
            AND sfoeseq2 = p_sfoeseq2
            AND sfoe001 = p_sfoe001
            AND sfoe002 = p_sfoe002
            AND sfoe004 IS NOT NULL
      END IF
 
   RETURN r_sfoe004,r_cnt
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: asfr801_g01_desc (p_class,p_num,p_target)
#                  RETURNING r_desc
# Input parameter: p_class   类别
#                : p_num     类别
#                : p_target  传参
# Return code....: r_desc   说明
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asfr801_g01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
   WHEN '1' #获取SCC码说明
      SELECT gzcbl004 INTO r_desc
        FROM gzcbl_t
       WHERE gzcbl001 = p_num
         AND gzcbl002 = p_target
         AND gzcbl003 = g_dlang
         
   WHEN '2' #获取ACC码说明
      SELECT oocql004 INTO r_desc
        FROM oocql_t
       WHERE oocql001 = p_num
         AND oocql002 = p_target
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise

   WHEN '3' #获取工作站名称
      SELECT ecaa002 INTO r_desc
        FROM ecaa_t
       WHERE ecaa001 = p_target
         AND ecaasite = g_site
         AND ecaaent = g_enterprise
         
   WHEN '4' #获取加工厂商名称
      SELECT pmaal004 INTO r_desc
        FROM pmaal_t
       WHERE pmaal001 = p_target
         AND pmaal002 = g_dlang
         AND pmaalent = g_enterprise
         
   END CASE
   
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
{<section id="asfr801_g01.other_report" readonly="Y" >}

PRIVATE REPORT asfr801_g01_subrep05(sr3)
    DEFINE sr3        sr3_r
    ORDER EXTERNAL BY sr3.sfodseq
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

PRIVATE REPORT asfr801_g01_subrep07(sr5)
    DEFINE sr5 sr4_r 
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
            #150525-00007#2 --- add start ---
            PRINTX g_fix_show      #固定 Label
            PRINTX g_std_show      #標準 Label
            PRINTX g_tranin_show   #轉入 Label
            PRINTX g_tranout_show  #轉出 Label
            #150525-00007#2 --- add end   ---
END REPORT

PRIVATE REPORT asfr801_g01_subrep06(sr4)
DEFINE sr4        sr3_r

   ORDER EXTERNAL BY sr4.sfodseq
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*

END REPORT

 
{</section>}
 
