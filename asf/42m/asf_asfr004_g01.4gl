#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr004_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-11-09 11:07:11), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: asfr004_g01
#+ Description: 工作站在製狀況表
#+ Creator....: 04441(2014-09-09 14:19:36)
#+ Modifier...: 08993 -SD/PR- 00000
 
{</section>}
 
{<section id="asfr004_g01.global" readonly="Y" >}
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
   sfcbent LIKE sfcb_t.sfcbent, 
   sfcb003 LIKE sfcb_t.sfcb003, 
   l_oocql004 LIKE type_t.chr30, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   l_ecaa002 LIKE type_t.chr30, 
   sfcb050 LIKE sfcb_t.sfcb050, 
   sfcb046 LIKE sfcb_t.sfcb046, 
   sfcb047 LIKE sfcb_t.sfcb047, 
   sfcb048 LIKE sfcb_t.sfcb048, 
   sfcb049 LIKE sfcb_t.sfcb049, 
   sfcb051 LIKE sfcb_t.sfcb051, 
   sfcb001 LIKE sfcb_t.sfcb001, 
   sfcb002 LIKE sfcb_t.sfcb002, 
   sfcbdocno LIKE sfcb_t.sfcbdocno
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #條件 
       chk LIKE type_t.chr1          #列印工單明細
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
TYPE sr3_r  RECORD  #子報表
    sfcbdocno       LIKE sfcb_t.sfcbdocno,
    sfaa010         LIKE sfaa_t.sfaa010,
    l_imaal003      LIKE imaal_t.imaal003,
    l_imaal004      LIKE imaal_t.imaal004,
    sfaa011         LIKE sfaa_t.sfaa011,
    sfaa013         LIKE sfaa_t.sfaa013,
    l_oocal003      LIKE oocql_t.oocql003,
    sfaa012         LIKE sfaa_t.sfaa012,
    sfcb050         LIKE sfcb_t.sfcb050, 
    sfcb046         LIKE sfcb_t.sfcb046, 
    sfcb047         LIKE sfcb_t.sfcb047, 
    sfcb048         LIKE sfcb_t.sfcb048, 
    sfcb049         LIKE sfcb_t.sfcb049, 
    sfcb051         LIKE sfcb_t.sfcb051,
    l_title_show    LIKE type_t.chr1,     #子報表title
    l_sfaa011_show  LIKE type_t.chr1      #產品特徵顯示否
END RECORD

#end add-point
 
{</section>}
 
{<section id="asfr004_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr004_g01(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  條件 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.chk  列印工單明細
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.chk = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asfr004_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr004_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr004_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr004_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr004_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr004_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT sfcbent,sfcb003,'',sfcb004,sfcb011,'',SUM(sfcb050),SUM(sfcb046),SUM(sfcb047),SUM(sfcb048),SUM(sfcb049),SUM(sfcb051),sfcb001,sfcb002,sfcbdocno "

#   #end add-point
#   LET g_select = " SELECT sfcbent,sfcb003,NULL,sfcb004,sfcb011,NULL,sfcb050,sfcb046,sfcb047,sfcb048, 
#       sfcb049,sfcb051,sfcb001,sfcb002,sfcbdocno"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM sfcb_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_order = " GROUP BY sfcbent,sfcb003,sfcb004,sfcb011,sfcb001,sfcb002,sfcbdocno"

#   #end add-point
#    LET g_order = " ORDER BY sfcbent,sfcb003,sfcb004,sfcb011"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfcb_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr004_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr004_g01_curs CURSOR FOR asfr004_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr004_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr004_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfcbent LIKE sfcb_t.sfcbent, 
   sfcb003 LIKE sfcb_t.sfcb003, 
   l_oocql004 LIKE type_t.chr30, 
   sfcb004 LIKE sfcb_t.sfcb004, 
   sfcb011 LIKE sfcb_t.sfcb011, 
   l_ecaa002 LIKE type_t.chr30, 
   sfcb050 LIKE sfcb_t.sfcb050, 
   sfcb046 LIKE sfcb_t.sfcb046, 
   sfcb047 LIKE sfcb_t.sfcb047, 
   sfcb048 LIKE sfcb_t.sfcb048, 
   sfcb049 LIKE sfcb_t.sfcb049, 
   sfcb051 LIKE sfcb_t.sfcb051, 
   sfcb001 LIKE sfcb_t.sfcb001, 
   sfcb002 LIKE sfcb_t.sfcb002, 
   sfcbdocno LIKE sfcb_t.sfcbdocno
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #作業名稱
    LET g_sql = "SELECT oocql004 FROM oocql_t ",
                " WHERE oocqlent = '",g_enterprise,"' ",
                "   AND oocql001 = '221' ",
                "   AND oocql002 = ? ",
                "   AND oocql003 = '",g_dlang,"'"
    PREPARE asfr004_g01_oocql FROM g_sql

    #工作站名稱
    LET g_sql = "SELECT ecaa002 FROM ecaa_t ",
                " WHERE ecaaent = '",g_enterprise,"' ",
                "   AND ecaasite = '",g_site,"' ",
                "   AND ecaa001 = ? "
    PREPARE asfr004_g01_ecaa FROM g_sql

    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asfr004_g01_curs INTO sr_s.*
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
       EXECUTE asfr004_g01_oocql USING sr_s.sfcb003 INTO sr_s.l_oocql004

       EXECUTE asfr004_g01_ecaa USING sr_s.sfcb011 INTO sr_s.l_ecaa002


       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfcbent = sr_s.sfcbent
       LET sr[l_cnt].sfcb003 = sr_s.sfcb003
       LET sr[l_cnt].l_oocql004 = sr_s.l_oocql004
       LET sr[l_cnt].sfcb004 = sr_s.sfcb004
       LET sr[l_cnt].sfcb011 = sr_s.sfcb011
       LET sr[l_cnt].l_ecaa002 = sr_s.l_ecaa002
       LET sr[l_cnt].sfcb050 = sr_s.sfcb050
       LET sr[l_cnt].sfcb046 = sr_s.sfcb046
       LET sr[l_cnt].sfcb047 = sr_s.sfcb047
       LET sr[l_cnt].sfcb048 = sr_s.sfcb048
       LET sr[l_cnt].sfcb049 = sr_s.sfcb049
       LET sr[l_cnt].sfcb051 = sr_s.sfcb051
       LET sr[l_cnt].sfcb001 = sr_s.sfcb001
       LET sr[l_cnt].sfcb002 = sr_s.sfcb002
       LET sr[l_cnt].sfcbdocno = sr_s.sfcbdocno
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr004_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr004_g01_rep_data()
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
          START REPORT asfr004_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr004_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr004_g01_rep
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
 
{<section id="asfr004_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr004_g01_rep(sr1)
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
DEFINE l_flag           LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.sfcbent,sr1.sfcb003,sr1.sfcb004,sr1.sfcb011
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
        BEFORE GROUP OF sr1.sfcbent
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfcbent
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfcbent=' ,sr1.sfcbent,'{+}sfcbdocno=' ,sr1.sfcbdocno,'{+}sfcb001=' ,sr1.sfcb001,'{+}sfcb002=' ,sr1.sfcb002         
            CALL cl_gr_init_apr(sr1.sfcbent)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfcbent.before name="rep.b_group.sfcbent.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfcbent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfcbent CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr004_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr004_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr004_g01_subrep01
           DECLARE asfr004_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr004_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr004_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr004_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr004_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfcbent.after name="rep.b_group.sfcbent.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfcb003
 
           #add-point:rep.b_group.sfcb003.before name="rep.b_group.sfcb003.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfcb003.after name="rep.b_group.sfcb003.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfcb004
 
           #add-point:rep.b_group.sfcb004.before name="rep.b_group.sfcb004.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfcb004.after name="rep.b_group.sfcb004.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfcb011
 
           #add-point:rep.b_group.sfcb011.before name="rep.b_group.sfcb011.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.sfcb011.after name="rep.b_group.sfcb011.after"
           
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
                sr1.sfcbent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfcbent CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr004_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr004_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr004_g01_subrep02
           DECLARE asfr004_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr004_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr004_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr004_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr004_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"

          START REPORT asfr004_g01_subrep05
             IF tm.chk = 'Y' THEN
                LET l_flag = '0'
                LET g_sql = " SELECT sfcbdocno,sfaa010,imaal003,imaal004,sfaa011,sfaa013,oocal003,sfaa012, ",
                            "        sfcb050,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051,'','' ",
                            "  FROM sfcb_t,sfaa_t",
                            "  LEFT OUTER JOIN imaal_t ON imaalent = sfaaent AND imaal001 = sfaa010 AND imaal002 = '",g_dlang,"' ",
                            "  LEFT OUTER JOIN oocal_t ON oocalent = sfaaent AND oocal001 = sfaa013 AND oocal002 = '",g_dlang,"' ",
                            " WHERE sfcbent = '",sr1.sfcbent,"' AND sfcb003 = '",sr1.sfcb003 ,"' AND sfcb004 = '",sr1.sfcb004 ,"' AND sfcb011 = '",sr1.sfcb011 ,"' ",
                            "   AND sfaaent = sfcbent AND sfaadocno = sfcbdocno "," AND " ,tm.wc CLIPPED ,
                            "  ORDER BY sfcbdocno,sfcb002 "
                DECLARE asfr004_g01_subrep05 CURSOR FROM g_sql
                FOREACH asfr004_g01_subrep05 INTO sr3.*

                   IF l_flag = '0' THEN
                      LET sr3.l_title_show = 'Y'
                   ELSE
                      LET sr3.l_title_show = 'N'
                   END IF
                   LET l_flag = '1'

                   IF cl_null(sr3.sfaa011) THEN
                      LET sr3.l_sfaa011_show = 'N'
                   ELSE
                      LET sr3.l_sfaa011_show = 'Y'
                   END IF

                   OUTPUT TO REPORT asfr004_g01_subrep05(sr3.*)
                END FOREACH
             END IF
          FINISH REPORT asfr004_g01_subrep05
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.sfcbent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr004_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr004_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr004_g01_subrep03
           DECLARE asfr004_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr004_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr004_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr004_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr004_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfcbent
 
           #add-point:rep.a_group.sfcbent.before name="rep.a_group.sfcbent.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfcbent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfcbent CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr004_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr004_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr004_g01_subrep04
           DECLARE asfr004_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr004_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr004_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr004_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr004_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfcbent.after name="rep.a_group.sfcbent.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfcb003
 
           #add-point:rep.a_group.sfcb003.before name="rep.a_group.sfcb003.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfcb003.after name="rep.a_group.sfcb003.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfcb004
 
           #add-point:rep.a_group.sfcb004.before name="rep.a_group.sfcb004.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfcb004.after name="rep.a_group.sfcb004.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfcb011
 
           #add-point:rep.a_group.sfcb011.before name="rep.a_group.sfcb011.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.sfcb011.after name="rep.a_group.sfcb011.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr004_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr004_g01_subrep01(sr2)
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
PRIVATE REPORT asfr004_g01_subrep02(sr2)
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
PRIVATE REPORT asfr004_g01_subrep03(sr2)
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
PRIVATE REPORT asfr004_g01_subrep04(sr2)
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
 
{<section id="asfr004_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="asfr004_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 子報表
# Memo...........:
# Usage..........: CALL asfr004_g01_subrep05(sr3)
# Input parameter: sr3
# Return code....: no
# Date & Author..: 2014/09/11 By whitney
# Modify.........:
################################################################################
PRIVATE REPORT asfr004_g01_subrep05(sr3)
DEFINE sr3 sr3_r

   ORDER EXTERNAL BY sr3.sfcbdocno
      FORMAT
         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*

END REPORT

 
{</section>}
 