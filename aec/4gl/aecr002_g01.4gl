#該程式未解開Section, 採用最新樣板產出!
{<section id="aecr002_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-12-16 16:58:56), PR版次:0001(2014-12-16 16:59:50)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: aecr002_g01
#+ Description: ...
#+ Creator....: 05423(2014-08-11 10:27:34)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aecr002_g01.global" readonly="Y" >}
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
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   l_sfaa050_sfaa051 LIKE type_t.chr30, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaaent LIKE sfaa_t.sfaaent, 
   l_imaal003 LIKE type_t.chr50, 
   l_imaal004 LIKE type_t.chr50, 
   sfaa061 LIKE sfaa_t.sfaa061
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       print STRING                   #print subreport
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
 TYPE sr3_r RECORD
   sfcb003 LIKE sfcb_t.sfcb003,
   sfcb004 LIKE sfcb_t.sfcb004,
   sfcb011 LIKE sfcb_t.sfcb011,
   l_sfcb028 LIKE type_t.chr30,
   sfcb033 LIKE sfcb_t.sfcb033,
   sfcb036 LIKE sfcb_t.sfcb036,
   l_sfcb033 LIKE type_t.chr30,
   sfcb028 LIKE sfcb_t.sfcb028,
   sfcb029 LIKE sfcb_t.sfcb029,
   sfcb030 LIKE sfcb_t.sfcb030,
   sfcb031 LIKE sfcb_t.sfcb031,
   sfcb032 LIKE sfcb_t.sfcb032,
   l_sfcb003_desc LIKE type_t.chr30,
   l_sfcb011_desc LIKE type_t.chr30,
   sfcb002 LIKE sfcb_t.sfcb002
END　RECORD
#end add-point
 
{</section>}
 
{<section id="aecr002_g01.main" readonly="Y" >}
PUBLIC FUNCTION aecr002_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.print  print subreport
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.print = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aecr002_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aecr002_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aecr002_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aecr002_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aecr002_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aecr002_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT UNIQUE sfaadocno,sfaa010,sfaa013,sfaa012,sfaa050,sfaa051,NULL,sfaa011,sfaaent,imaal003,imaal004,sfaa061 "
#   #end add-point
#   LET g_select = " SELECT sfaadocno,sfaa010,sfaa013,sfaa012,sfaa050,sfaa051,NULL,sfaa011,sfaaent,NULL, 
#       NULL,sfaa061"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM sfaa_t LEFT OUTER JOIN sfcb_t ON sfaa_t.sfaadocno = sfcb_t.sfcbdocno AND sfaa_t.sfaaent = sfcb_t.sfcbent AND sfaa_t.sfaasite = sfcb_t.sfcbsite 
                              LEFT OUTER JOIN imaal_t ON sfaa010 = imaal001 AND sfaaent = imaalent AND imaal002 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM sfaa_t,sfcb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sfaaent"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aecr002_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aecr002_g01_curs CURSOR FOR aecr002_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aecr002_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aecr002_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   l_sfaa050_sfaa051 LIKE type_t.chr30, 
   sfaa011 LIKE sfaa_t.sfaa011, 
   sfaaent LIKE sfaa_t.sfaaent, 
   l_imaal003 LIKE type_t.chr50, 
   l_imaal004 LIKE type_t.chr50, 
   sfaa061 LIKE sfaa_t.sfaa061
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
    FOREACH aecr002_g01_curs INTO sr_s.*
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
       LET sr_s.l_sfaa050_sfaa051 = sr_s.sfaa050 / (sr_s.sfaa050 + sr_s.sfaa051) *100, "%"
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
 
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfaadocno = sr_s.sfaadocno
       LET sr[l_cnt].sfaa010 = sr_s.sfaa010
       LET sr[l_cnt].sfaa013 = sr_s.sfaa013
       LET sr[l_cnt].sfaa012 = sr_s.sfaa012
       LET sr[l_cnt].sfaa050 = sr_s.sfaa050
       LET sr[l_cnt].sfaa051 = sr_s.sfaa051
       LET sr[l_cnt].l_sfaa050_sfaa051 = sr_s.l_sfaa050_sfaa051
       LET sr[l_cnt].sfaa011 = sr_s.sfaa011
       LET sr[l_cnt].sfaaent = sr_s.sfaaent
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].sfaa061 = sr_s.sfaa061
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aecr002_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aecr002_g01_rep_data()
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
          START REPORT aecr002_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aecr002_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aecr002_g01_rep
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
 
{<section id="aecr002_g01.rep" readonly="Y" >}
PRIVATE REPORT aecr002_g01_rep(sr1)
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
DEFINE sr3 sr3_r
DEFINE l_subrep05_show LIKE type_t.chr1
DEFINE l_sfcb003  LIKE sfcb_t.sfcb003
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.sfaaent
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
        BEFORE GROUP OF sr1.sfaaent
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfaaent
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfaaent=' ,sr1.sfaaent,'{+}sfaadocno=' ,sr1.sfaadocno         
            CALL cl_gr_init_apr(sr1.sfaaent)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfaaent.before name="rep.b_group.sfaaent.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaaent CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aecr002_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aecr002_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aecr002_g01_subrep01
           DECLARE aecr002_g01_repcur01 CURSOR FROM g_sql
           FOREACH aecr002_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aecr002_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aecr002_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aecr002_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfaaent.after name="rep.b_group.sfaaent.after"
           
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
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaaent CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aecr002_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aecr002_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aecr002_g01_subrep02
           DECLARE aecr002_g01_repcur02 CURSOR FROM g_sql
           FOREACH aecr002_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aecr002_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aecr002_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aecr002_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          LET g_sql = "SELECT UNIQUE sfcb003,sfcb004,sfcb011,NULL,sfcb033,sfcb036,NULL,sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,(trim(sfcb_t.sfcb003)||'.'||trim(oocql_t.oocql004)),(trim(sfcb_t.sfcb011)||'.'||trim(ecaa_t.ecaa002)),sfcb002 ",
                      " FROM sfcb_t ",
                      " LEFT OUTER JOIN ecaa_t ON ecaa001 = sfcb011 AND ecaaent = sfcbent  AND ecaasite = sfcbsite ",
                      " LEFT OUTER JOIN oocql_t ON oocql001 = '221' AND oocql002 = sfcb003 AND oocqlent = sfcbent AND oocql003 = '",g_dlang,"' ",
                      " WHERE sfcbdocno = '",sr1.sfaadocno,"' AND sfcbent = '",sr1.sfaaent,"'",
                      " ORDER BY sfcb002 "
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aecr002_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE aecr002_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 AND tm.print = "Y" AND sr1.sfaa061 = "Y" THEN 
              LET l_subrep05_show ="Y"
           END IF
          PRINTX l_subrep05_show
          START REPORT aecr002_g01_subrep05
          DECLARE aecr002_g01_repcur05 CURSOR FROM g_sql
          FOREACH aecr002_g01_repcur05 INTO sr3.*
             LET sr3.l_sfcb028 = sr3.sfcb028+sr3.sfcb029+sr3.sfcb030+sr3.sfcb031+sr3.sfcb032
             LET sr3.l_sfcb033 = sr3.sfcb033/(sr3.sfcb033+sr3.sfcb036) *100, "%"
             IF sr3.l_sfcb003_desc = "." THEN
               LET sr3.l_sfcb003_desc = sr3.sfcb003
             END IF
             IF sr3.l_sfcb011_desc = "." THEN
               LET sr3.l_sfcb011_desc = sr3.sfcb011
             END IF
             
             OUTPUT TO REPORT aecr002_g01_subrep05(sr3.*)
          END FOREACH
          FINISH REPORT aecr002_g01_subrep05
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.sfaaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aecr002_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aecr002_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aecr002_g01_subrep03
           DECLARE aecr002_g01_repcur03 CURSOR FROM g_sql
           FOREACH aecr002_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aecr002_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aecr002_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aecr002_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfaaent
 
           #add-point:rep.a_group.sfaaent.before name="rep.a_group.sfaaent.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaaent CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aecr002_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aecr002_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aecr002_g01_subrep04
           DECLARE aecr002_g01_repcur04 CURSOR FROM g_sql
           FOREACH aecr002_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aecr002_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aecr002_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aecr002_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfaaent.after name="rep.a_group.sfaaent.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aecr002_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aecr002_g01_subrep01(sr2)
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
PRIVATE REPORT aecr002_g01_subrep02(sr2)
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
PRIVATE REPORT aecr002_g01_subrep03(sr2)
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
PRIVATE REPORT aecr002_g01_subrep04(sr2)
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
 
{<section id="aecr002_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aecr002_g01.other_report" readonly="Y" >}

PRIVATE REPORT aecr002_g01_subrep05(sr3)
DEFINE sr3          sr3_r
   FORMAT
           
        ON EVERY ROW

            PRINTX sr3.*
            
END REPORT

 
{</section>}
 