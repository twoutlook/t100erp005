#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr334_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-11-09 14:10:25), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: asfr334_g01
#+ Description: ...
#+ Creator....: 05423(2014-10-21 13:58:23)
#+ Modifier...: 08993 -SD/PR- 00000
 
{</section>}
 
{<section id="asfr334_g01.global" readonly="Y" >}
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
   sfgadocno LIKE sfga_t.sfgadocno, 
   sfgadocdt LIKE sfga_t.sfgadocdt, 
   sfga002 LIKE sfga_t.sfga002, 
   l_sfga002_desc LIKE type_t.chr30, 
   sfga003 LIKE sfga_t.sfga003, 
   l_sfga003_desc LIKE type_t.chr30, 
   sfga010 LIKE sfga_t.sfga010, 
   sfga004 LIKE sfga_t.sfga004, 
   sfga012 LIKE sfga_t.sfga012, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   sfga006 LIKE sfga_t.sfga006, 
   l_sfga006_desc LIKE type_t.chr30, 
   sfga007 LIKE sfga_t.sfga007, 
   sfga008 LIKE sfga_t.sfga008, 
   sfgaent LIKE sfga_t.sfgaent, 
   l_sfgadocno_desc LIKE type_t.chr50
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr1 STRING,                  #print subrep01 
       pr2 STRING                   #print subrep02
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
   sfgbseq  LIKE sfgb_t.sfgbseq,
   sfgb001  LIKE sfgb_t.sfgb001,
   l_sfgb001_desc  LIKE type_t.chr30,
   sfgb002  LIKE sfgb_t.sfgb002,
   sfgb003  LIKE sfgb_t.sfgb003
END RECORD
 TYPE sr4_r RECORD
   sfgcseq  LIKE sfgc_t.sfgcseq,
   sfgc001  LIKE sfgc_t.sfgc001,
   l_sfgc001_desc  LIKE type_t.chr30,
   sfgc002  LIKE sfgc_t.sfgc002,
   l_sfgc002_desc  LIKE type_t.chr30,
   sfgc003  LIKE sfgc_t.sfgc003,
   sfgc004  LIKE sfgc_t.sfgc004,
   l_sfgc004_desc  LIKE type_t.chr30,
   sfgc005  LIKE sfgc_t.sfgc005,
   l_sfgc005_desc  LIKE type_t.chr30
END RECORD
#end add-point
 
{</section>}
 
{<section id="asfr334_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr334_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr1  print subrep01 
DEFINE  p_arg3 STRING                  #tm.pr2  print subrep02
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr1 = p_arg2
   LET tm.pr2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asfr334_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr334_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr334_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr334_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr334_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr334_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT sfgadocno,sfgadocdt,sfga002,(trim(sfga_t.sfga002)||'.'||trim(ooag_t.ooag011)),sfga003,(trim(sfga_t.sfga003)||'.'||trim(ooefl_t.ooefl003)),sfga010,sfga004,sfaa010,imaal003, 
       imaal004,sfga006,(trim(sfga_t.sfga006)||'.'||trim(oocql_t.oocql004)),sfga007,sfga008,sfgaent,(trim(sfga_t.sfga004)||'/'||trim(sfga_t.sfga005))"
#   #end add-point
#   LET g_select = " SELECT sfgadocno,sfgadocdt,sfga002,NULL,sfga003,NULL,sfga010,sfga004,sfga012,imaal003, 
#       imaal004,sfga006,NULL,sfga007,sfga008,sfgaent,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM sfga_t ",
                "             LEFT OUTER JOIN ooag_t ON ooag001 = sfga002 AND ooagent = sfgaent ",
                "             LEFT OUTER JOIN sfaa_t ON sfaadocno = sfga004 AND sfaaent = sfgaent AND sfaasite = sfgasite ",
                "             LEFT OUTER JOIN imaal_t ON sfaa010 = imaal001 AND sfaaent = imaalent AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN ooefl_t ON ooefl001 = sfga003 AND ooeflent = sfgaent AND ooefl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN oocql_t ON oocql001 = '221' AND oocql002 = sfga006 AND oocqlent = sfgaent AND oocql003 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM sfga_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sfgadocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfga_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr334_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr334_g01_curs CURSOR FOR asfr334_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr334_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr334_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfgadocno LIKE sfga_t.sfgadocno, 
   sfgadocdt LIKE sfga_t.sfgadocdt, 
   sfga002 LIKE sfga_t.sfga002, 
   l_sfga002_desc LIKE type_t.chr30, 
   sfga003 LIKE sfga_t.sfga003, 
   l_sfga003_desc LIKE type_t.chr30, 
   sfga010 LIKE sfga_t.sfga010, 
   sfga004 LIKE sfga_t.sfga004, 
   sfga012 LIKE sfga_t.sfga012, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   sfga006 LIKE sfga_t.sfga006, 
   l_sfga006_desc LIKE type_t.chr30, 
   sfga007 LIKE sfga_t.sfga007, 
   sfga008 LIKE sfga_t.sfga008, 
   sfgaent LIKE sfga_t.sfgaent, 
   l_sfgadocno_desc LIKE type_t.chr50
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
    FOREACH asfr334_g01_curs INTO sr_s.*
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
       IF cl_null(sr_s.sfga002) THEN
         LET sr_s.l_sfga002_desc = NULL
       END IF
       IF cl_null(sr_s.sfga003) THEN
         LET sr_s.l_sfga003_desc = NULL
       END IF
       IF cl_null(sr_s.sfga006) THEN
         LET sr_s.l_sfga006_desc = NULL
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfgadocno = sr_s.sfgadocno
       LET sr[l_cnt].sfgadocdt = sr_s.sfgadocdt
       LET sr[l_cnt].sfga002 = sr_s.sfga002
       LET sr[l_cnt].l_sfga002_desc = sr_s.l_sfga002_desc
       LET sr[l_cnt].sfga003 = sr_s.sfga003
       LET sr[l_cnt].l_sfga003_desc = sr_s.l_sfga003_desc
       LET sr[l_cnt].sfga010 = sr_s.sfga010
       LET sr[l_cnt].sfga004 = sr_s.sfga004
       LET sr[l_cnt].sfga012 = sr_s.sfga012
       LET sr[l_cnt].imaal003 = sr_s.imaal003
       LET sr[l_cnt].imaal004 = sr_s.imaal004
       LET sr[l_cnt].sfga006 = sr_s.sfga006
       LET sr[l_cnt].l_sfga006_desc = sr_s.l_sfga006_desc
       LET sr[l_cnt].sfga007 = sr_s.sfga007
       LET sr[l_cnt].sfga008 = sr_s.sfga008
       LET sr[l_cnt].sfgaent = sr_s.sfgaent
       LET sr[l_cnt].l_sfgadocno_desc = sr_s.l_sfgadocno_desc
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr334_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr334_g01_rep_data()
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
          START REPORT asfr334_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr334_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr334_g01_rep
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
 
{<section id="asfr334_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr334_g01_rep(sr1)
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
DEFINE l_subrep05_show  LIKE type_t.chr1,
       l_subrep06_show  LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.sfgadocno
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
        BEFORE GROUP OF sr1.sfgadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfgadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfgaent=' ,sr1.sfgaent,'{+}sfgadocno=' ,sr1.sfgadocno         
            CALL cl_gr_init_apr(sr1.sfgadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfgadocno.before name="rep.b_group.sfgadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfgaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfgadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr334_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr334_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr334_g01_subrep01
           DECLARE asfr334_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr334_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr334_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr334_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr334_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfgadocno.after name="rep.b_group.sfgadocno.after"
           
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
                sr1.sfgaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfgadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr334_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr334_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr334_g01_subrep02
           DECLARE asfr334_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr334_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr334_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr334_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr334_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
----------------------子報表一：列印異常原因
          LET l_subrep05_show = "N"
          LET g_sql = "SELECT UNIQUE sfgbseq,sfgb001,NULL,sfgb002,sfgb003 ",
                      " FROM sfgb_t ",
                      " WHERE sfgbdocno = '",sr1.sfgadocno ,"' AND sfgbent = '",sr1.sfgaent ,"' ",
                      " ORDER BY sfgbseq "
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE asfr334_g01_repcur05_cnt_pre FROM l_sub_sql
          EXECUTE asfr334_g01_repcur05_cnt_pre INTO l_cnt
          IF l_cnt > 0 AND tm.pr1 = 'Y'THEN 
            LET l_subrep05_show ="Y"
          ELSE 
            LET l_subrep05_show = "N"
          END IF
          PRINTX l_subrep05_show
          START REPORT asfr334_g01_subrep05
          DECLARE asfr334_g01_repcur05 CURSOR FROM g_sql
          FOREACH asfr334_g01_repcur05 INTO sr3.*
             IF NOT cl_null(sr3.sfgb001) THEN
               CALL asfr334_g01_desc('2','1053',sr3.sfgb001) RETURNING sr3.l_sfgb001_desc
               --LET sr3.l_sfgb001_desc = sr3.sfgb001,".",sr3.l_sfgb001_desc
             END IF           
             OUTPUT TO REPORT asfr334_g01_subrep05(sr3.*)

          END FOREACH
          FINISH REPORT asfr334_g01_subrep05

----------------------子報表二：列印判定結果
          LET l_subrep06_show = "N"
          LET g_sql = "SELECT UNIQUE sfgcseq,sfgc001,NULL,sfgc002,NULL,sfgc003,sfgc004,NULL,sfgc005,(trim(sfgc_t.sfgc005)||'.'||trim(ooefl_t.ooefl003)) ",
                      " FROM sfgc_t LEFT OUTER JOIN ooefl_t ON ooefl001 = sfgc005 AND ooeflent = sfgcent AND ooefl002 = '",g_dlang,"' ",
                      " WHERE sfgcdocno = '",sr1.sfgadocno ,"' AND sfgcent = '",sr1.sfgaent ,"' ",
                      " ORDER BY sfgcseq "
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE asfr334_g01_repcur06_cnt_pre FROM l_sub_sql
          EXECUTE asfr334_g01_repcur06_cnt_pre INTO l_cnt
          IF l_cnt > 0 AND tm.pr2 = 'Y'THEN 
            LET l_subrep06_show ="Y"
          ELSE 
            LET l_subrep06_show = "N"
          END IF
          PRINTX l_subrep06_show
          START REPORT asfr334_g01_subrep06
          DECLARE asfr334_g01_repcur06 CURSOR FROM g_sql
          FOREACH asfr334_g01_repcur06 INTO sr4.*
             IF NOT cl_null(sr4.sfgc001) THEN
               CALL asfr334_g01_desc('2','1053',sr4.sfgc001) RETURNING sr4.l_sfgc001_desc
               --LET sr4.l_sfgc001_desc = sr4.sfgc001,".",sr4.l_sfgc001_desc
             END IF           
             IF NOT cl_null(sr4.sfgc002) THEN
               CALL asfr334_g01_desc('1','5417',sr4.sfgc002) RETURNING sr4.l_sfgc002_desc
               LET sr4.l_sfgc002_desc = sr4.sfgc002,".",sr4.l_sfgc002_desc
             END IF           
             IF NOT cl_null(sr4.sfgc004) THEN
               CALL asfr334_g01_desc('1','5418',sr4.sfgc004) RETURNING sr4.l_sfgc004_desc
               LET sr4.l_sfgc004_desc = sr4.sfgc004,".",sr4.l_sfgc004_desc
             END IF
             IF cl_null(sr4.sfgc005) THEN
               LET sr4.l_sfgc005_desc = NULL
             END IF
             OUTPUT TO REPORT asfr334_g01_subrep06(sr4.*)

          END FOREACH
          FINISH REPORT asfr334_g01_subrep06
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.sfgaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr334_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr334_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr334_g01_subrep03
           DECLARE asfr334_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr334_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr334_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr334_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr334_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfgadocno
 
           #add-point:rep.a_group.sfgadocno.before name="rep.a_group.sfgadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfgaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfgadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr334_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr334_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr334_g01_subrep04
           DECLARE asfr334_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr334_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr334_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr334_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr334_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfgadocno.after name="rep.a_group.sfgadocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr334_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr334_g01_subrep01(sr2)
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
PRIVATE REPORT asfr334_g01_subrep02(sr2)
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
PRIVATE REPORT asfr334_g01_subrep03(sr2)
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
PRIVATE REPORT asfr334_g01_subrep04(sr2)
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
 
{<section id="asfr334_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION asfr334_g01_desc(p_class,p_num,p_target)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
   WHEN '1' 
      SELECT gzcbl004 INTO r_desc
        FROM gzcbl_t
       WHERE gzcbl001 = p_num
         AND gzcbl002 = p_target
         AND gzcbl003 = g_dlang
         
   WHEN '2'
      SELECT oocql004 INTO r_desc
        FROM oocql_t
       WHERE oocql001 = p_num
         AND oocql002 = p_target
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise
   END CASE
   
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
{<section id="asfr334_g01.other_report" readonly="Y" >}

PRIVATE REPORT asfr334_g01_subrep05(sr3)
DEFINE sr3          sr3_r
ORDER EXTERNAL BY sr3.sfgbseq

   FORMAT
        FIRST PAGE HEADER
            PRINTX g_grNumFmt.*
           
        ON EVERY ROW
            
            PRINTX sr3.*
            
END REPORT

PRIVATE REPORT asfr334_g01_subrep06(sr4)
DEFINE sr4           sr4_r
ORDER EXTERNAL BY sr4.sfgcseq

   FORMAT
        FIRST PAGE HEADER
            PRINTX g_grNumFmt.*
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
            
END REPORT

 
{</section>}
 