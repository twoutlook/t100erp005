#該程式未解開Section, 採用最新樣板產出!
{<section id="abmr500_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2017-02-13 15:50:26), PR版次:0004(2017-02-13 19:56:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000087
#+ Filename...: abmr500_g01
#+ Description: ...
#+ Creator....: 05423(2014-09-03 14:41:21)
#+ Modifier...: 07804 -SD/PR- 07804
 
{</section>}
 
{<section id="abmr500_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#170209-00032#1   2017/02/13  By Ann_Huang  調整顯示子報表(subrep05、subrep06)寫法,讓對應T類程式列印時可以顯示出單身
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
   bmkadocno LIKE bmka_t.bmkadocno, 
   bmkadocdt LIKE bmka_t.bmkadocdt, 
   l_bmka001_bmjal003 LIKE type_t.chr30, 
   l_bmka007_bmka008 LIKE type_t.chr30, 
   bmka013 LIKE bmka_t.bmka013, 
   bmka005 LIKE bmka_t.bmka005, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   bmka006 LIKE bmka_t.bmka006, 
   l_bmka002_ooag011 LIKE type_t.chr30, 
   l_bmka003_ooefl003 LIKE type_t.chr30, 
   l_pmka009_pmaal003 LIKE type_t.chr30, 
   bmkbseq LIKE bmkb_t.bmkbseq, 
   bmkb001 LIKE bmkb_t.bmkb001, 
   l_bmkb001_desc LIKE type_t.chr30, 
   bmkbseq1 LIKE bmkb_t.bmkbseq1, 
   bmkb002 LIKE bmkb_t.bmkb002, 
   l_bmkb002_desc LIKE type_t.chr30, 
   bmkb003 LIKE bmkb_t.bmkb003, 
   bmkb004 LIKE bmkb_t.bmkb004, 
   bmkaent LIKE bmka_t.bmkaent
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr1 STRING,                  #print subrep1 
       pr2 STRING,                  #print subrep2 
       pr3 STRING                   #print subrep3
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
   bmkcseq LIKE bmkc_t.bmkcseq,
   l_bmkc001_gzcbl004 LIKE type_t.chr30,
   l_bmkc002_oocql004 LIKE type_t.chr30,
   bmkc003 LIKE bmkc_t.bmkc003,
   bmkc004 LIKE bmkc_t.bmkc004
END RECORD
TYPE sr4_r RECORD
   bmkdseq LIKE bmkd_t.bmkdseq,
   bmkd001 LIKE bmkd_t.bmkd001,
   l_bmkd001_desc LIKE type_t.chr30,
   bmkdseq1 LIKE bmkd_t.bmkdseq1,
   bmkd002 LIKE bmkd_t.bmkd002,
   l_bmkd002_desc LIKE type_t.chr30,
   bmkd003 LIKE bmkd_t.bmkd003,
   bmkd004 LIKE bmkd_t.bmkd004
END RECORD
#end add-point
 
{</section>}
 
{<section id="abmr500_g01.main" readonly="Y" >}
PUBLIC FUNCTION abmr500_g01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr1  print subrep1 
DEFINE  p_arg3 STRING                  #tm.pr2  print subrep2 
DEFINE  p_arg4 STRING                  #tm.pr3  print subrep3
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr1 = p_arg2
   LET tm.pr2 = p_arg3
   LET tm.pr3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "abmr500_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL abmr500_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL abmr500_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL abmr500_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abmr500_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmr500_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT UNIQUE bmkadocno,bmkadocdt,(trim(bmka001)||'.'||trim(bmjal_t.bmjal003)),(trim(bmka007)||'.'||trim(oocql_t.oocql004)||'/'||trim(bmka008)),bmka013,bmka005, 
       imaal_t.imaal003,imaal_t.imaal004,bmka006,(trim(bmka002)||'.'||trim(ooag_t.ooag011)),(trim(bmka003)||'.'||trim(ooefl_t.ooefl003)),(trim(bmka009)||'.'||trim(pmaal_t.pmaal003)),bmkbseq,bmkb001,NULL,bmkbseq1,bmkb002, 
       NULL,bmkb003,bmkb004,bmkaent"
#   #end add-point
#   LET g_select = " SELECT bmkadocno,bmkadocdt,NULL,(trim(bmka007)||'/'||trim(bmka008)),bmka013,bmka005, 
#       imaal_t.imaal003,imaal_t.imaal004,bmka006,NULL,NULL,NULL,bmkbseq,bmkb001,NULL,bmkbseq1,bmkb002, 
#       NULL,bmkb003,bmkb004,bmkaent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM bmka_t LEFT OUTER JOIN bmkb_t ON bmkaent = bmkbent AND bmkadocno = bmkbdocno
                               LEFT OUTER JOIN oocql_t ON bmka007 = oocql002 AND oocql001 = '221' AND bmkaent = oocqlent AND oocql003 = '",g_dlang,"' 
                               LEFT OUTER JOIN imaal_t ON bmka005 = imaal001 AND bmkaent = imaalent AND imaal002 = '",g_dlang,"'
                               LEFT OUTER JOIN bmjal_t ON bmka001 = bmjal001 AND bmkaent = bmjalent AND bmjal002 = '",g_dlang,"'
                               LEFT OUTER JOIN ooag_t ON bmka002 = ooag001 AND bmkaent = ooagent
                               LEFT OUTER JOIN ooefl_t ON bmka003 = ooefl001 AND bmkaent = ooeflent AND ooefl002 = '",g_dlang,"'
                               LEFT OUTER JOIN pmaal_t ON bmka009 = pmaal001 AND bmkaent = pmaalent AND pmaal002 = '",g_dlang,"'"
#   #end add-point
#    LET g_from = " FROM bmka_t,bmkb_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
#    LET g_order = " ORDER BY bmkadocno,bmkb_t.bmkbseq,bmkb_t.bmkbseq1 "
   #end add-point
    LET g_order = " ORDER BY bmkadocno,bmkbseq,bmkbseq1"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bmka_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE abmr500_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE abmr500_g01_curs CURSOR FOR abmr500_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abmr500_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abmr500_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   bmkadocno LIKE bmka_t.bmkadocno, 
   bmkadocdt LIKE bmka_t.bmkadocdt, 
   l_bmka001_bmjal003 LIKE type_t.chr30, 
   l_bmka007_bmka008 LIKE type_t.chr30, 
   bmka013 LIKE bmka_t.bmka013, 
   bmka005 LIKE bmka_t.bmka005, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   bmka006 LIKE bmka_t.bmka006, 
   l_bmka002_ooag011 LIKE type_t.chr30, 
   l_bmka003_ooefl003 LIKE type_t.chr30, 
   l_pmka009_pmaal003 LIKE type_t.chr30, 
   bmkbseq LIKE bmkb_t.bmkbseq, 
   bmkb001 LIKE bmkb_t.bmkb001, 
   l_bmkb001_desc LIKE type_t.chr30, 
   bmkbseq1 LIKE bmkb_t.bmkbseq1, 
   bmkb002 LIKE bmkb_t.bmkb002, 
   l_bmkb002_desc LIKE type_t.chr30, 
   bmkb003 LIKE bmkb_t.bmkb003, 
   bmkb004 LIKE bmkb_t.bmkb004, 
   bmkaent LIKE bmka_t.bmkaent
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
    FOREACH abmr500_g01_curs INTO sr_s.*
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
       CALL abmr500_g01_desc('1117',sr_s.bmkb001) RETURNING sr_s.l_bmkb001_desc
       CALL abmr500_g01_desc('1118',sr_s.bmkb002) RETURNING sr_s.l_bmkb002_desc

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].bmkadocno = sr_s.bmkadocno
       LET sr[l_cnt].bmkadocdt = sr_s.bmkadocdt
       LET sr[l_cnt].l_bmka001_bmjal003 = sr_s.l_bmka001_bmjal003
       LET sr[l_cnt].l_bmka007_bmka008 = sr_s.l_bmka007_bmka008
       LET sr[l_cnt].bmka013 = sr_s.bmka013
       LET sr[l_cnt].bmka005 = sr_s.bmka005
       LET sr[l_cnt].imaal_t_imaal003 = sr_s.imaal_t_imaal003
       LET sr[l_cnt].imaal_t_imaal004 = sr_s.imaal_t_imaal004
       LET sr[l_cnt].bmka006 = sr_s.bmka006
       LET sr[l_cnt].l_bmka002_ooag011 = sr_s.l_bmka002_ooag011
       LET sr[l_cnt].l_bmka003_ooefl003 = sr_s.l_bmka003_ooefl003
       LET sr[l_cnt].l_pmka009_pmaal003 = sr_s.l_pmka009_pmaal003
       LET sr[l_cnt].bmkbseq = sr_s.bmkbseq
       LET sr[l_cnt].bmkb001 = sr_s.bmkb001
       LET sr[l_cnt].l_bmkb001_desc = sr_s.l_bmkb001_desc
       LET sr[l_cnt].bmkbseq1 = sr_s.bmkbseq1
       LET sr[l_cnt].bmkb002 = sr_s.bmkb002
       LET sr[l_cnt].l_bmkb002_desc = sr_s.l_bmkb002_desc
       LET sr[l_cnt].bmkb003 = sr_s.bmkb003
       LET sr[l_cnt].bmkb004 = sr_s.bmkb004
       LET sr[l_cnt].bmkaent = sr_s.bmkaent
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmr500_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abmr500_g01_rep_data()
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
          START REPORT abmr500_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT abmr500_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT abmr500_g01_rep
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
 
{<section id="abmr500_g01.rep" readonly="Y" >}
PRIVATE REPORT abmr500_g01_rep(sr1)
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
DEFINE sr4 sr4_r
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_subrep06_show  LIKE type_t.chr1

#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.bmkadocno,sr1.bmkbseq,sr1.bmkbseq1
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
        BEFORE GROUP OF sr1.bmkadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.bmkadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'bmkaent=' ,sr1.bmkaent,'{+}bmkadocno=' ,sr1.bmkadocno         
            CALL cl_gr_init_apr(sr1.bmkadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.bmkadocno.before name="rep.b_group.bmkadocno.before"

           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.bmkaent CLIPPED ,"'", " AND  ooff003 = '", sr1.bmkadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abmr500_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE abmr500_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT abmr500_g01_subrep01
           DECLARE abmr500_g01_repcur01 CURSOR FROM g_sql
           FOREACH abmr500_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abmr500_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT abmr500_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT abmr500_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.bmkadocno.after name="rep.b_group.bmkadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.bmkbseq
 
           #add-point:rep.b_group.bmkbseq.before name="rep.b_group.bmkbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.bmkbseq.after name="rep.b_group.bmkbseq.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.bmkbseq1
 
           #add-point:rep.b_group.bmkbseq1.before name="rep.b_group.bmkbseq1.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.bmkbseq1.after name="rep.b_group.bmkbseq1.after"
           
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
                sr1.bmkaent CLIPPED ,"'", " AND  ooff003 = '", sr1.bmkadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abmr500_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE abmr500_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT abmr500_g01_subrep02
           DECLARE abmr500_g01_repcur02 CURSOR FROM g_sql
           FOREACH abmr500_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abmr500_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT abmr500_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT abmr500_g01_subrep02
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
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.bmkaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abmr500_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE abmr500_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT abmr500_g01_subrep03
           DECLARE abmr500_g01_repcur03 CURSOR FROM g_sql
           FOREACH abmr500_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abmr500_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT abmr500_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT abmr500_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.bmkadocno
 
           #add-point:rep.a_group.bmkadocno.before name="rep.a_group.bmkadocno.before"
          #子報表：現存資料影響處理
         #START REPORT abmr500_g01_subrep05   #170209-00032#1 mark
          LET g_sql = "SELECT UNIQUE bmkcseq,(trim(bmkc001)||'.'||trim(gzcbl_t.gzcbl004)),(trim(bmkc002)||'.'||trim(oocql_t.oocql004)),bmkc003,bmkc004",
                      " FROM bmkc_t LEFT OUTER JOIN gzcbl_t ON bmkc001 = gzcbl002 AND gzcbl001 = '5446' AND gzcbl003 = '",g_dlang,"'
                                    LEFT OUTER JOIN oocql_t ON bmkc002 = oocql002 AND oocql001 = '1121' AND bmkcent = oocqlent AND oocql003 = '",g_dlang,"'",
                      " WHERE bmkcdocno = '",sr1.bmkadocno CLIPPED ,"' AND bmkcent = '",sr1.bmkaent CLIPPED,"' ",
                      " ORDER BY bmkcseq "
          #170209-00032#1-(S)-add            
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep05_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE abmr500_g01_repcur05_cnt_pre FROM l_sub_sql
          EXECUTE abmr500_g01_repcur05_cnt_pre INTO l_cnt
          IF (l_cnt > 0) AND (tm.pr2 = 'Y') THEN 
             LET l_subrep05_show ="Y"
          END IF
          PRINTX l_subrep05_show
          START REPORT abmr500_g01_subrep05
          #170209-00032#1-(E)-add
          DECLARE abmr500_g01_repcur05 CURSOR FROM g_sql
          FOREACH abmr500_g01_repcur05 INTO sr3.*
             IF sr3.l_bmkc001_gzcbl004 = '.' THEN LET sr3.l_bmkc001_gzcbl004 = NULL END IF
             IF sr3.l_bmkc002_oocql004 = '.' THEN LET sr3.l_bmkc002_oocql004 = NULL END IF
             OUTPUT TO REPORT abmr500_g01_subrep05(sr3.*)
          END FOREACH
          FINISH REPORT abmr500_g01_subrep05
          #子報表：變更影響事項
         #START REPORT abmr500_g01_subrep06   #170209-00032#1 mark
          LET g_sql = "SELECT UNIQUE bmkdseq,bmkd001,NULL,bmkdseq1,bmkd002,NULL,bmkd003,bmkd004",
                      " FROM bmkd_t ",
                      " WHERE bmkddocno = '",sr1.bmkadocno CLIPPED ,"' AND bmkdent = '",sr1.bmkaent CLIPPED,"' ",
                      " ORDER BY bmkdseq,bmkdseq1 "
          #170209-00032#1-(S)-add
          LET l_cnt = 0
          LET l_sub_sql = ""
          LET l_subrep06_show ="N"
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE abmr500_g01_repcur06_cnt_pre FROM l_sub_sql
          EXECUTE abmr500_g01_repcur06_cnt_pre INTO l_cnt
          IF (l_cnt > 0) AND (tm.pr3 = 'Y') THEN 
             LET l_subrep06_show ="Y"
          END IF
          PRINTX l_subrep06_show
          START REPORT abmr500_g01_subrep06  
          #170209-00032#1-(E)-add
          DECLARE abmr500_g01_repcur06 CURSOR FROM g_sql
          FOREACH abmr500_g01_repcur06 INTO sr4.*
             CALL abmr500_g01_desc('1119',sr4.bmkd001) RETURNING sr4.l_bmkd001_desc
             CALL abmr500_g01_desc('1120',sr4.bmkd002) RETURNING sr4.l_bmkd002_desc
             OUTPUT TO REPORT abmr500_g01_subrep06(sr4.*)
          END FOREACH
          FINISH REPORT abmr500_g01_subrep06
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.bmkaent CLIPPED ,"'", " AND  ooff003 = '", sr1.bmkadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE abmr500_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE abmr500_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT abmr500_g01_subrep04
           DECLARE abmr500_g01_repcur04 CURSOR FROM g_sql
           FOREACH abmr500_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "abmr500_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT abmr500_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT abmr500_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.bmkadocno.after name="rep.a_group.bmkadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.bmkbseq
 
           #add-point:rep.a_group.bmkbseq.before name="rep.a_group.bmkbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.bmkbseq.after name="rep.a_group.bmkbseq.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.bmkbseq1
 
           #add-point:rep.a_group.bmkbseq1.before name="rep.a_group.bmkbseq1.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.bmkbseq1.after name="rep.a_group.bmkbseq1.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="abmr500_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT abmr500_g01_subrep01(sr2)
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
PRIVATE REPORT abmr500_g01_subrep02(sr2)
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
PRIVATE REPORT abmr500_g01_subrep03(sr2)
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
PRIVATE REPORT abmr500_g01_subrep04(sr2)
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
 
{<section id="abmr500_g01.other_function" readonly="Y" >}
#获取说明oocql004
PRIVATE FUNCTION abmr500_g01_desc(p_num,p_target)

DEFINE p_num    LIKE type_t.num5
DEFINE p_target LIKE type_t.chr10
DEFINE r_desc   LIKE type_t.chr30

SELECT oocql004 INTO r_desc
FROM oocql_t
WHERE oocql001 = p_num
AND oocql002 = p_target
AND oocql003 = g_dlang
AND oocqlent = g_enterprise

IF cl_null(p_target) THEN
   LET r_desc = p_target
ELSE
   LET r_desc = p_target CLIPPED, '.' , r_desc CLIPPED
END IF

RETURN r_desc
END FUNCTION

 
{</section>}
 
{<section id="abmr500_g01.other_report" readonly="Y" >}

PRIVATE REPORT abmr500_g01_subrep05(sr3)
DEFINE sr3          sr3_r
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

PRIVATE REPORT abmr500_g01_subrep06(sr4)
DEFINE sr4          sr4_r
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
 
END REPORT

 
{</section>}
 
