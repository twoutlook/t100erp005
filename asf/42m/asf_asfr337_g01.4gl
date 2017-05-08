#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr337_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-11-09 14:49:10), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: asfr337_g01
#+ Description: ...
#+ Creator....: 05423(2014-10-22 11:26:28)
#+ Modifier...: 08993 -SD/PR- 00000
 
{</section>}
 
{<section id="asfr337_g01.global" readonly="Y" >}
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
   sfhadocno LIKE sfha_t.sfhadocno, 
   sfhadocdt LIKE sfha_t.sfhadocdt, 
   sfha002 LIKE sfha_t.sfha002, 
   l_sfha002_desc LIKE type_t.chr30, 
   sfha003 LIKE sfha_t.sfha003, 
   l_sfha003_desc LIKE type_t.chr30, 
   sfha009 LIKE sfha_t.sfha009, 
   sfha004 LIKE sfha_t.sfha004, 
   sfha005 LIKE sfha_t.sfha005, 
   l_sfha004_sfha005 LIKE type_t.chr30, 
   sfha013 LIKE sfha_t.sfha013, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   sfha006 LIKE sfha_t.sfha006, 
   l_sfha006_desc LIKE type_t.chr30, 
   sfha007 LIKE sfha_t.sfha007, 
   sfha008 LIKE sfha_t.sfha008, 
   sfha016 LIKE sfha_t.sfha016, 
   l_sfha016_desc LIKE type_t.chr30, 
   sfhaent LIKE sfha_t.sfhaent
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
   sfhbseq  LIKE sfhb_t.sfhbseq,
   sfhb001  LIKE sfhb_t.sfhb001,
   imaal003 LIKE imaal_t.imaal003,
   imaal004 LIKE imaal_t.imaal004,
   sfhb002  LIKE sfhb_t.sfhb002,
   sfhb008  LIKE sfhb_t.sfhb008,
   sfhb010  LIKE sfhb_t.sfhb010,
   sfhb007  LIKE sfhb_t.sfhb007,
   l_sfhb007_desc LIKE type_t.chr30,
   sfhb009  LIKE sfhb_t.sfhb009,
   l_sfhb009_desc LIKE type_t.chr30,
   sfhb003  LIKE sfhb_t.sfhb003,
   l_sfhb003_desc LIKE type_t.chr30,
   sfhb004  LIKE sfhb_t.sfhb004,
   l_sfhb004_desc LIKE type_t.chr30,
   sfhb005  LIKE sfhb_t.sfhb005,
   sfhb006  LIKE sfhb_t.sfhb006
END RECORD

TYPE sr4_r RECORD
   sfhcseq  LIKE sfhc_t.sfhcseq,
   sfhcseq1 LIKE sfhc_t.sfhcseq1,
   sfhc001  LIKE sfhc_t.sfhc001,
   imaal003 LIKE imaal_t.imaal003,
   imaal004 LIKE imaal_t.imaal004,
   sfhc002  LIKE sfhc_t.sfhc002,
   sfhc008  LIKE sfhc_t.sfhc008,
   sfhc010  LIKE sfhc_t.sfhc010,
   sfhc007  LIKE sfhc_t.sfhc007,
   l_sfhc007_desc LIKE type_t.chr30,
   sfhc009  LIKE sfhc_t.sfhc009,
   l_sfhc009_desc LIKE type_t.chr30,
   sfhc003  LIKE sfhc_t.sfhc003,
   l_sfhc003_desc LIKE type_t.chr30,
   sfhc004  LIKE sfhc_t.sfhc004,
   l_sfhc004_desc LIKE type_t.chr30,
   sfhc005  LIKE sfhc_t.sfhc005,
   sfhc006  LIKE sfhc_t.sfhc006
END RECORD

#end add-point
 
{</section>}
 
{<section id="asfr337_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr337_g01(p_arg1,p_arg2,p_arg3)
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
   
   LET g_rep_code = "asfr337_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr337_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr337_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr337_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr337_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr337_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT sfhadocno,sfhadocdt,sfha002,(trim(sfha_t.sfha002)||'.'||trim(ooag_t.ooag011)),sfha003,(trim(sfha_t.sfha003)||'.'||trim(ooefl_t.ooefl003)),sfha009,sfha004,sfha005,(trim(sfha004)||'/'||trim(sfha005)), 
       sfaa010,imaal003,imaal004,sfha006,(trim(sfha_t.sfha006)||'.'||trim(oocql_t.oocql004)),sfha007,sfha008,sfha016,NULL,sfhaent"
#   #end add-point
#   LET g_select = " SELECT sfhadocno,sfhadocdt,sfha002,NULL,sfha003,NULL,sfha009,sfha004,sfha005,(trim(sfha004)||'/'||trim(sfha005)), 
#       sfha013,imaal003,imaal004,sfha006,NULL,sfha007,sfha008,sfha016,NULL,sfhaent"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM sfha_t LEFT OUTER JOIN sfaa_t ON sfaadocno = sfha004 AND sfaaent = sfhaent AND sfaasite = sfhasite ",
                "              LEFT OUTER JOIN ooag_t ON ooag001 = sfha002 AND ooagent = sfhaent ",
                "              LEFT OUTER JOIN imaal_t ON sfaa010 = imaal001 AND sfaaent = imaalent AND imaal002 = '",g_dlang,"' ",
                "              LEFT OUTER JOIN ooefl_t ON ooefl001 = sfha003 AND ooeflent = sfhaent AND ooefl002 = '",g_dlang,"' ",
                "              LEFT OUTER JOIN oocql_t ON oocql001 = '221' AND oocql002 = sfha006 AND oocqlent = sfhaent AND oocql003 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM sfha_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sfhadocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfha_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE asfr337_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr337_g01_curs CURSOR FOR asfr337_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr337_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr337_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfhadocno LIKE sfha_t.sfhadocno, 
   sfhadocdt LIKE sfha_t.sfhadocdt, 
   sfha002 LIKE sfha_t.sfha002, 
   l_sfha002_desc LIKE type_t.chr30, 
   sfha003 LIKE sfha_t.sfha003, 
   l_sfha003_desc LIKE type_t.chr30, 
   sfha009 LIKE sfha_t.sfha009, 
   sfha004 LIKE sfha_t.sfha004, 
   sfha005 LIKE sfha_t.sfha005, 
   l_sfha004_sfha005 LIKE type_t.chr30, 
   sfha013 LIKE sfha_t.sfha013, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   sfha006 LIKE sfha_t.sfha006, 
   l_sfha006_desc LIKE type_t.chr30, 
   sfha007 LIKE sfha_t.sfha007, 
   sfha008 LIKE sfha_t.sfha008, 
   sfha016 LIKE sfha_t.sfha016, 
   l_sfha016_desc LIKE type_t.chr30, 
   sfhaent LIKE sfha_t.sfhaent
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sfha005  LIKE type_t.chr30
DEFINE l_sfha006  LIKE type_t.chr30
DEFINE l_sfha007  LIKE type_t.chr30
DEFINE l_sffb009  LIKE type_t.chr30
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asfr337_g01_curs INTO sr_s.*
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
#       CALL s_asft335_default_sffb056('3',sr_s.sfha004,sr_s.sfha005,sr_s.sfha006,sr_s.sfha007)
#       RETURNING sr_s.sfha013,l_sfha005,l_sfha006,l_sfha007,l_sffb009
#       SELECT imaal003,imaal004 INTO sr_s.imaal003,sr_s.imaal004
#       FROM imaal_t
#       WHERE imaal001 = sr_s.sfha013 AND imaalent = g_enterprise AND imaal002 = g_dlang
       IF NOT cl_null(sr_s.sfha016) THEN
         CALL asfr337_g01_desc('2','1125',sr_s.sfha016) RETURNING sr_s.l_sfha016_desc
         LET sr_s.l_sfha016_desc = sr_s.sfha016,".",sr_s.l_sfha016_desc
       END IF
       IF cl_null(sr_s.sfha002) THEN
         LET sr_s.l_sfha002_desc = NULL
       END IF
       IF cl_null(sr_s.sfha003) THEN
         LET sr_s.l_sfha003_desc = NULL
       END IF
       IF cl_null(sr_s.sfha006) THEN
         LET sr_s.l_sfha006_desc = NULL
       END IF
       IF sr_s.l_sfha004_sfha005 = '/' THEN
         LET sr_s.l_sfha004_sfha005 = NULL
       END IF   
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfhadocno = sr_s.sfhadocno
       LET sr[l_cnt].sfhadocdt = sr_s.sfhadocdt
       LET sr[l_cnt].sfha002 = sr_s.sfha002
       LET sr[l_cnt].l_sfha002_desc = sr_s.l_sfha002_desc
       LET sr[l_cnt].sfha003 = sr_s.sfha003
       LET sr[l_cnt].l_sfha003_desc = sr_s.l_sfha003_desc
       LET sr[l_cnt].sfha009 = sr_s.sfha009
       LET sr[l_cnt].sfha004 = sr_s.sfha004
       LET sr[l_cnt].sfha005 = sr_s.sfha005
       LET sr[l_cnt].l_sfha004_sfha005 = sr_s.l_sfha004_sfha005
       LET sr[l_cnt].sfha013 = sr_s.sfha013
       LET sr[l_cnt].imaal003 = sr_s.imaal003
       LET sr[l_cnt].imaal004 = sr_s.imaal004
       LET sr[l_cnt].sfha006 = sr_s.sfha006
       LET sr[l_cnt].l_sfha006_desc = sr_s.l_sfha006_desc
       LET sr[l_cnt].sfha007 = sr_s.sfha007
       LET sr[l_cnt].sfha008 = sr_s.sfha008
       LET sr[l_cnt].sfha016 = sr_s.sfha016
       LET sr[l_cnt].l_sfha016_desc = sr_s.l_sfha016_desc
       LET sr[l_cnt].sfhaent = sr_s.sfhaent
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr337_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr337_g01_rep_data()
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
          START REPORT asfr337_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr337_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr337_g01_rep
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
 
{<section id="asfr337_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr337_g01_rep(sr1)
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
    ORDER  BY sr1.sfhadocno
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
        BEFORE GROUP OF sr1.sfhadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfhadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfhaent=' ,sr1.sfhaent,'{+}sfhadocno=' ,sr1.sfhadocno         
            CALL cl_gr_init_apr(sr1.sfhadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfhadocno.before name="rep.b_group.sfhadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfhaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfhadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr337_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr337_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr337_g01_subrep01
           DECLARE asfr337_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr337_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr337_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr337_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr337_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfhadocno.after name="rep.b_group.sfhadocno.after"
           
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
                sr1.sfhaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfhadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr337_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr337_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr337_g01_subrep02
           DECLARE asfr337_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr337_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr337_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr337_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr337_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
----------------------子報表一：列印入庫申請
          LET l_subrep05_show = "N"
          LET g_sql = "SELECT UNIQUE sfhbseq,sfhb001,imaal003,imaal004,sfhb002,sfhb008,sfhb010,sfhb007,NULL,sfhb009,NULL,sfhb003,(trim(sfhb_t.sfhb003)||'.'||trim(inayl003)),",
                      "sfhb004,(trim(sfhb_t.sfhb004)||'.'||trim(inab_t.inab003)),sfhb005,sfhb006",
                      " FROM sfhb_t LEFT OUTER JOIN imaal_t ON imaal001 = sfhb001 AND imaalent = sfhbent AND imaal002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN inayl_t ON inayl001 = sfhb003 AND inaylent = sfhbent AND inayl002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN inab_t ON inab001 = sfhb003 AND inab002 = sfhb004 AND inabent = sfhbent AND inabsite = sfhbsite ",
                      " WHERE sfhbdocno = '",sr1.sfhadocno ,"' AND sfhbent = '",sr1.sfhaent ,"' ",
                      " ORDER BY sfhbseq "
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE asfr337_g01_repcur05_cnt_pre FROM l_sub_sql
          EXECUTE asfr337_g01_repcur05_cnt_pre INTO l_cnt
          IF l_cnt > 0 AND tm.pr1 = 'Y'THEN 
            LET l_subrep05_show ="Y"
          ELSE 
            LET l_subrep05_show = "N"
          END IF
          PRINTX l_subrep05_show
          START REPORT asfr337_g01_subrep05
          DECLARE asfr337_g01_repcur05 CURSOR FROM g_sql
          FOREACH asfr337_g01_repcur05 INTO sr3.*
             IF NOT cl_null(sr3.sfhb007) THEN
               CALL asfr337_g01_desc('3','',sr3.sfhb007) RETURNING sr3.l_sfhb007_desc
             END IF
             IF NOT cl_null(sr3.sfhb009) THEN
               CALL asfr337_g01_desc('3','',sr3.sfhb009) RETURNING sr3.l_sfhb009_desc
             END IF
             IF cl_null(sr3.sfhb003) THEN
               LET sr3.l_sfhb003_desc = NULL
             END IF
             IF cl_null(sr3.sfhb004) THEN
               LET sr3.l_sfhb004_desc = NULL
             END IF
          
             OUTPUT TO REPORT asfr337_g01_subrep05(sr3.*)

          END FOREACH
          FINISH REPORT asfr337_g01_subrep05
          
----------------------子報表二：列印入庫明細
          LET l_subrep06_show = "N"
          LET g_sql = "SELECT UNIQUE sfhcseq,sfhcseq1,sfhc001,imaal003,imaal004,sfhc002,sfhc008,sfhc010,sfhc007,NULL,sfhc009,NULL,sfhc003,(trim(sfhc_t.sfhc003)||'.'||trim(inayl003)),",
                      "sfhc004,(trim(sfhc_t.sfhc004)||'.'||trim(inab_t.inab003)),sfhc005,sfhc006",
                      " FROM sfhc_t LEFT OUTER JOIN imaal_t ON imaal001 = sfhc001 AND imaalent = sfhcent AND imaal002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN inayl_t ON inayl001 = sfhc003 AND inaylent = sfhcent AND inayl002 = '",g_dlang,"' ",
                      "             LEFT OUTER JOIN inab_t ON inab001 = sfhc003 AND inab002 = sfhc004 AND inabent = sfhcent AND inabsite = sfhcsite ",
                      " WHERE sfhcdocno = '",sr1.sfhadocno ,"' AND sfhcent = '",sr1.sfhaent ,"' ",
                      " ORDER BY sfhcseq,sfhcseq1 "
          LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
          PREPARE asfr337_g01_repcur06_cnt_pre FROM l_sub_sql
          EXECUTE asfr337_g01_repcur06_cnt_pre INTO l_cnt
          IF l_cnt > 0 AND tm.pr2 = 'Y'THEN 
            LET l_subrep06_show ="Y"
          ELSE 
            LET l_subrep06_show = "N"
          END IF
          PRINTX l_subrep06_show

          START REPORT asfr337_g01_subrep06
          DECLARE asfr337_g01_repcur06 CURSOR FROM g_sql
          FOREACH asfr337_g01_repcur06 INTO sr4.*
             IF NOT cl_null(sr4.sfhc007) THEN
               CALL asfr337_g01_desc('3','',sr4.sfhc007) RETURNING sr4.l_sfhc007_desc
             END IF
             IF NOT cl_null(sr4.sfhc009) THEN
               CALL asfr337_g01_desc('3','',sr4.sfhc009) RETURNING sr4.l_sfhc009_desc
             END IF
             IF cl_null(sr4.sfhc003) THEN
               LET sr4.l_sfhc003_desc = NULL
             END IF
             IF cl_null(sr4.sfhc004) THEN
               LET sr4.l_sfhc004_desc = NULL
             END IF
             OUTPUT TO REPORT asfr337_g01_subrep06(sr4.*)

          END FOREACH
          FINISH REPORT asfr337_g01_subrep06
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.sfhaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr337_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr337_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr337_g01_subrep03
           DECLARE asfr337_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr337_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr337_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr337_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr337_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfhadocno
 
           #add-point:rep.a_group.sfhadocno.before name="rep.a_group.sfhadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfhaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfhadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr337_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr337_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr337_g01_subrep04
           DECLARE asfr337_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr337_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr337_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr337_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr337_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfhadocno.after name="rep.a_group.sfhadocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr337_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr337_g01_subrep01(sr2)
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
PRIVATE REPORT asfr337_g01_subrep02(sr2)
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
PRIVATE REPORT asfr337_g01_subrep03(sr2)
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
PRIVATE REPORT asfr337_g01_subrep04(sr2)
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
 
{<section id="asfr337_g01.other_function" readonly="Y" >}

PRIVATE FUNCTION asfr337_g01_desc(p_class,p_num,p_target)
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

   WHEN '3'
      SELECT oocal003 INTO r_desc
        FROM oocal_t
       WHERE oocal001 = p_target
         AND oocal002 = g_dlang
         AND oocalent = g_enterprise
         
   END CASE
   
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
{<section id="asfr337_g01.other_report" readonly="Y" >}

PRIVATE REPORT asfr337_g01_subrep05(sr3)
DEFINE sr3        sr3_r
DEFINE l_sfhb002_show   LIKE type_t.chr1
   ORDER EXTERNAL BY sr3.sfhbseq
   FORMAT
        FIRST PAGE HEADER   
            PRINTX g_grNumFmt.*
            
        ON EVERY ROW
            IF cl_null(sr3.sfhb002) THEN
               LET l_sfhb002_show = 'N'  
            ELSE               
               LET l_sfhb002_show = 'Y'  
            END IF
            PRINTX l_sfhb002_show
            PRINTX sr3.*
            
END REPORT

PRIVATE REPORT asfr337_g01_subrep06(sr4)
DEFINE sr4        sr4_r
DEFINE l_sfhc002_show   LIKE type_t.chr1
   ORDER EXTERNAL BY sr4.sfhcseq,sr4.sfhcseq1
   FORMAT
        FIRST PAGE HEADER   
            PRINTX g_grNumFmt.*   
            
        ON EVERY ROW
            IF cl_null(sr4.sfhc002) THEN
               LET l_sfhc002_show = 'N'  
            ELSE               
               LET l_sfhc002_show = 'Y'  
            END IF
            PRINTX l_sfhc002_show
            
            PRINTX sr4.*
            
END REPORT

 
{</section>}
 