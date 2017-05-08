#該程式未解開Section, 採用最新樣板產出!
{<section id="abcr002_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-01-09 11:08:17), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000001
#+ Filename...: abcr002_g01
#+ Description: 条码打印作业
#+ Creator....: 05384(2016-11-08 13:59:52)
#+ Modifier...: 04543 -SD/PR- 00000
 
{</section>}
 
{<section id="abcr002_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#161130-00009#1   2016/11/30 By pomelo    增加列印張數
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
   bcaa001 LIKE bcaa_t.bcaa001, 
   bcaa002 LIKE bcaa_t.bcaa002, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   imaf_t_imaf053 LIKE imaf_t.imaf053, 
   bcaa013 LIKE bcaa_t.bcaa013, 
   bcaa009 LIKE bcaa_t.bcaa009, 
   l_barcode_num LIKE type_t.chr1000
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       chk LIKE type_t.chr1,         #自行輸入 
       aa001 LIKE bcaa_t.bcaa001,         #條碼編號 
       aa002 LIKE bcaa_t.bcaa002,         #料件編號 
       aa013 LIKE bcaa_t.bcaa013,         #批次 
       aa009 LIKE bcaa_t.bcaa009,         #數量 
       num LIKE type_t.num10          #列印張數
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
 
{<section id="abcr002_g01.main" readonly="Y" >}
PUBLIC FUNCTION abcr002_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  自行輸入 
DEFINE  p_arg3 LIKE bcaa_t.bcaa001         #tm.aa001  條碼編號 
DEFINE  p_arg4 LIKE bcaa_t.bcaa002         #tm.aa002  料件編號 
DEFINE  p_arg5 LIKE bcaa_t.bcaa013         #tm.aa013  批次 
DEFINE  p_arg6 LIKE bcaa_t.bcaa009         #tm.aa009  數量 
DEFINE  p_arg7 LIKE type_t.num10         #tm.num  列印張數
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
   LET tm.aa001 = p_arg3
   LET tm.aa002 = p_arg4
   LET tm.aa013 = p_arg5
   LET tm.aa009 = p_arg6
   LET tm.num = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "abcr002_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL abcr002_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL abcr002_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL abcr002_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abcr002_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abcr002_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   IF tm.chk = 'Y' THEN
      LET g_select = " SELECT '",tm.aa001,"','",tm.aa002,"','','','','",tm.aa013,"','",tm.aa009,"' "
   ELSE
      LET g_select = " SELECT DISTINCT bcaa001,bcaa002,imaal003,imaal004,imaf_t.imaf053,bcaa013,bcaa009"
   END IF
#   #end add-point
#   LET g_select = " SELECT bcaa001,bcaa002,imaal003,imaal004,imaf_t.imaf053,bcaa013,bcaa009,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   IF tm.chk = 'Y' THEN
      LET g_from = " FROM dual "
   ELSE
      LET g_from = " FROM bcaa_t ",
                   " LEFT OUTER JOIN imaal_t ON imaalent = bcaaent AND imaal001 = bcaa002 AND imaal002 = '",g_dlang,"' ",
                   " LEFT OUTER JOIN imaf_t ON imafent = bcaaent AND imafsite = bcaasite AND imaf001 = bcaa002 "
   END IF
#   #end add-point
#    LET g_from = " FROM bcaa_t,imaal_t,imaf_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   IF tm.chk = 'Y' THEN
      LET g_where = " WHERE 1=1 "
   ELSE
      LET g_where = " WHERE " ,tm.wc CLIPPED 
   END IF
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED 
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   IF tm.chk = 'N' THEN
      LET g_order = " ORDER BY bcaa001"
   ELSE
      LET g_order = " "
   END IF
#   #end add-point
#    LET g_order = " ORDER BY bcaa001"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bcaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE abcr002_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE abcr002_g01_curs CURSOR FOR abcr002_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abcr002_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abcr002_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   bcaa001 LIKE bcaa_t.bcaa001, 
   bcaa002 LIKE bcaa_t.bcaa002, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   imaf_t_imaf053 LIKE imaf_t.imaf053, 
   bcaa013 LIKE bcaa_t.bcaa013, 
   bcaa009 LIKE bcaa_t.bcaa009, 
   l_barcode_num LIKE type_t.chr1000
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
    #161130-00009#1 By pomelo add(S)
    DEFINE l_n            LIKE type_t.num10
    DEFINE l_i            LIKE type_t.num10
    DEFINE l_str          STRING
    #161130-00009#1 By pomelo add(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH abcr002_g01_curs INTO sr_s.*
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
       IF tm.chk = 'Y' THEN
          CALL s_desc_get_item_desc(sr_s.bcaa002) RETURNING sr_s.imaal003,sr_s.imaal004
          SELECT imaf053 INTO sr_s.imaf_t_imaf053
            FROM imaf_t
           WHERE imafent = g_enterprise
             AND imafsite = g_site
             AND imaf001 = sr_s.bcaa002
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].bcaa001 = sr_s.bcaa001
       LET sr[l_cnt].bcaa002 = sr_s.bcaa002
       LET sr[l_cnt].imaal003 = sr_s.imaal003
       LET sr[l_cnt].imaal004 = sr_s.imaal004
       LET sr[l_cnt].imaf_t_imaf053 = sr_s.imaf_t_imaf053
       LET sr[l_cnt].bcaa013 = sr_s.bcaa013
       LET sr[l_cnt].bcaa009 = sr_s.bcaa009
       LET sr[l_cnt].l_barcode_num = sr_s.l_barcode_num
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       #161130-00009#1 By pomelo add(S)
       LET sr[l_cnt].l_barcode_num = sr_s.bcaa001,'1'
       LET l_n = l_cnt
       FOR l_i = 2 TO tm.num
          LET l_cnt = l_cnt + 1
          LET l_str = l_i
          LET sr[l_cnt].* = sr[l_n].*
          LET sr[l_cnt].l_barcode_num = sr_s.bcaa001,l_str
       END FOR
       #161130-00009#1 By pomelo add(E)
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abcr002_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abcr002_g01_rep_data()
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
          START REPORT abcr002_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT abcr002_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT abcr002_g01_rep
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
 
{<section id="abcr002_g01.rep" readonly="Y" >}
PRIVATE REPORT abcr002_g01_rep(sr1)
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

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_barcode_num
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
        BEFORE GROUP OF sr1.l_barcode_num
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_barcode_num
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'bcaa001=' ,sr1.bcaa001,'{+}bcaa002=' ,sr1.bcaa002         
            CALL cl_gr_init_apr(sr1.l_barcode_num)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_barcode_num.before name="rep.b_group.l_barcode_num.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
 
#           #end add-point:rep.sub01.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
#                sr1.bcaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_barcode_num CLIPPED ,"'"
# 
#           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abcr002_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE abcr002_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT abcr002_g01_subrep01
           DECLARE abcr002_g01_repcur01 CURSOR FROM g_sql
           FOREACH abcr002_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abcr002_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT abcr002_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT abcr002_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_barcode_num.after name="rep.b_group.l_barcode_num.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
 
#           #end add-point:rep.sub02.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
#                sr1.bcaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_barcode_num CLIPPED ,"'"
# 
#           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abcr002_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE abcr002_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT abcr002_g01_subrep02
           DECLARE abcr002_g01_repcur02 CURSOR FROM g_sql
           FOREACH abcr002_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abcr002_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT abcr002_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT abcr002_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
 
#           #end add-point:rep.sub03.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
#                sr1.bcaaent CLIPPED ,"'"
# 
#           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abcr002_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE abcr002_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT abcr002_g01_subrep03
           DECLARE abcr002_g01_repcur03 CURSOR FROM g_sql
           FOREACH abcr002_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abcr002_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT abcr002_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT abcr002_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_barcode_num
 
           #add-point:rep.a_group.l_barcode_num.before name="rep.a_group.l_barcode_num.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
 
#           #end add-point:rep.sub04.sql
# 
#           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
#                sr1.bcaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_barcode_num CLIPPED ,"'"
# 
#           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abcr002_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE abcr002_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT abcr002_g01_subrep04
           DECLARE abcr002_g01_repcur04 CURSOR FROM g_sql
           FOREACH abcr002_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abcr002_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT abcr002_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT abcr002_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_barcode_num.after name="rep.a_group.l_barcode_num.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="abcr002_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT abcr002_g01_subrep01(sr2)
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
PRIVATE REPORT abcr002_g01_subrep02(sr2)
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
PRIVATE REPORT abcr002_g01_subrep03(sr2)
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
PRIVATE REPORT abcr002_g01_subrep04(sr2)
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
 
{<section id="abcr002_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="abcr002_g01.other_report" readonly="Y" >}

 
{</section>}
 