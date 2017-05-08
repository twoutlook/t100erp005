#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr710_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-16 15:49:45), PR版次:0001(2016-03-04 20:22:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: acrr710_g01
#+ Description: ...
#+ Creator....: 02159(2016-02-04 11:00:05)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="acrr710_g01.global" readonly="Y" >}
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
   crbadocno LIKE crba_t.crbadocno, 
   crbadocdt LIKE crba_t.crbadocdt, 
   crba004 LIKE crba_t.crba004, 
   crba006 LIKE crba_t.crba006, 
   crba008 LIKE crba_t.crba008, 
   crba001 LIKE crba_t.crba001, 
   l_crba001_ooag011 LIKE type_t.chr300, 
   crba009 LIKE crba_t.crba009, 
   crba010 LIKE crba_t.crba010, 
   l_crba009_crba010 LIKE type_t.chr100, 
   crba012 LIKE crba_t.crba012, 
   crba013 LIKE crba_t.crba013, 
   l_crba012_crba013 LIKE type_t.chr100, 
   crba016 LIKE crba_t.crba016, 
   crba017 LIKE crba_t.crba017, 
   crba021 LIKE crba_t.crba021, 
   l_imaal014 LIKE type_t.chr100, 
   crbbseq LIKE crbb_t.crbbseq, 
   crbb001 LIKE crbb_t.crbb001, 
   crbb002 LIKE crbb_t.crbb002, 
   crba002 LIKE crba_t.crba002, 
   crba003 LIKE crba_t.crba003, 
   crba011 LIKE crba_t.crba011, 
   crba005 LIKE crba_t.crba005, 
   crba007 LIKE crba_t.crba007, 
   crba014 LIKE crba_t.crba014, 
   crba015 LIKE crba_t.crba015, 
   crba018 LIKE crba_t.crba018, 
   crba019 LIKE crba_t.crba019, 
   crba020 LIKE crba_t.crba020, 
   crba022 LIKE crba_t.crba022, 
   crba023 LIKE crba_t.crba023, 
   crba024 LIKE crba_t.crba024, 
   crba025 LIKE crba_t.crba025, 
   crba026 LIKE crba_t.crba026, 
   crbaent LIKE crba_t.crbaent, 
   crbasite LIKE crba_t.crbasite, 
   crbastus LIKE crba_t.crbastus
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
#子報表05 #調查結果
TYPE sr3_r RECORD
   crbe001   LIKE crbe_t.crbe001
END RECORD
#子報表06 #處理對策
TYPE sr4_r RECORD
   crbe001   LIKE crbe_t.crbe001
END RECORD
#子報表07 #審核
TYPE sr5_r RECORD
   crbe001   LIKE crbe_t.crbe001
END RECORD
#子報表08 #核決
TYPE sr6_r RECORD
   crbe001   LIKE crbe_t.crbe001
END RECORD
#子報表09 #結案註記
TYPE sr7_r RECORD
   crbe001   LIKE crbe_t.crbe001
END RECORD
#end add-point
 
{</section>}
 
{<section id="acrr710_g01.main" readonly="Y" >}
PUBLIC FUNCTION acrr710_g01(p_arg1)
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
   
   LET g_rep_code = "acrr710_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL acrr710_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL acrr710_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL acrr710_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr710_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr710_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT crbadocno,crbadocdt,crba004,crba006,crba008,crba001,trim(crba001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = crba_t.crba001 AND ooag_t.ooagent = crba_t.crbaent)), 
       crba009,crba010,trim(crba009)||'.'||trim(crba010),crba012,crba013,trim(crba012)||'.'||trim(crba013), 
       crba016,crba017,crba021,'',crbbseq,crbb001,crbb002,crba002,crba003,crba011,crba005,crba007,crba014, 
       crba015,crba018,crba019,crba020,crba022,crba023,crba024,crba025,crba026,crbaent,crbasite,crbastus" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM crba_t LEFT OUTER JOIN ( SELECT crbb_t.* FROM crbb_t  ) x  ON crba_t.crbaent  
        = x.crbbent AND crba_t.crbadocno = x.crbbdocno"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY crbadocno,crbbseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("crba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE acrr710_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE acrr710_g01_curs CURSOR FOR acrr710_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr710_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr710_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   crbadocno LIKE crba_t.crbadocno, 
   crbadocdt LIKE crba_t.crbadocdt, 
   crba004 LIKE crba_t.crba004, 
   crba006 LIKE crba_t.crba006, 
   crba008 LIKE crba_t.crba008, 
   crba001 LIKE crba_t.crba001, 
   l_crba001_ooag011 LIKE type_t.chr300, 
   crba009 LIKE crba_t.crba009, 
   crba010 LIKE crba_t.crba010, 
   l_crba009_crba010 LIKE type_t.chr100, 
   crba012 LIKE crba_t.crba012, 
   crba013 LIKE crba_t.crba013, 
   l_crba012_crba013 LIKE type_t.chr100, 
   crba016 LIKE crba_t.crba016, 
   crba017 LIKE crba_t.crba017, 
   crba021 LIKE crba_t.crba021, 
   l_imaal014 LIKE type_t.chr100, 
   crbbseq LIKE crbb_t.crbbseq, 
   crbb001 LIKE crbb_t.crbb001, 
   crbb002 LIKE crbb_t.crbb002, 
   crba002 LIKE crba_t.crba002, 
   crba003 LIKE crba_t.crba003, 
   crba011 LIKE crba_t.crba011, 
   crba005 LIKE crba_t.crba005, 
   crba007 LIKE crba_t.crba007, 
   crba014 LIKE crba_t.crba014, 
   crba015 LIKE crba_t.crba015, 
   crba018 LIKE crba_t.crba018, 
   crba019 LIKE crba_t.crba019, 
   crba020 LIKE crba_t.crba020, 
   crba022 LIKE crba_t.crba022, 
   crba023 LIKE crba_t.crba023, 
   crba024 LIKE crba_t.crba024, 
   crba025 LIKE crba_t.crba025, 
   crba026 LIKE crba_t.crba026, 
   crbaent LIKE crba_t.crbaent, 
   crbasite LIKE crba_t.crbasite, 
   crbastus LIKE crba_t.crbastus
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
    FOREACH acrr710_g01_curs INTO sr_s.*
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
       #當前面編號為空時，清空編號.說明的字串(避免編號為空會只顯示一個 .)
       CALL acrr710_g01_initialize(sr_s.crba001,sr_s.l_crba001_ooag011) RETURNING sr_s.l_crba001_ooag011
       CALL acrr710_g01_initialize(sr_s.crba009,sr_s.l_crba009_crba010) RETURNING sr_s.l_crba009_crba010
       CALL acrr710_g01_initialize(sr_s.crba012,sr_s.l_crba012_crba013) RETURNING sr_s.l_crba012_crba013
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].crbadocno = sr_s.crbadocno
       LET sr[l_cnt].crbadocdt = sr_s.crbadocdt
       LET sr[l_cnt].crba004 = sr_s.crba004
       LET sr[l_cnt].crba006 = sr_s.crba006
       LET sr[l_cnt].crba008 = sr_s.crba008
       LET sr[l_cnt].crba001 = sr_s.crba001
       LET sr[l_cnt].l_crba001_ooag011 = sr_s.l_crba001_ooag011
       LET sr[l_cnt].crba009 = sr_s.crba009
       LET sr[l_cnt].crba010 = sr_s.crba010
       LET sr[l_cnt].l_crba009_crba010 = sr_s.l_crba009_crba010
       LET sr[l_cnt].crba012 = sr_s.crba012
       LET sr[l_cnt].crba013 = sr_s.crba013
       LET sr[l_cnt].l_crba012_crba013 = sr_s.l_crba012_crba013
       LET sr[l_cnt].crba016 = sr_s.crba016
       LET sr[l_cnt].crba017 = sr_s.crba017
       LET sr[l_cnt].crba021 = sr_s.crba021
       LET sr[l_cnt].l_imaal014 = sr_s.l_imaal014
       LET sr[l_cnt].crbbseq = sr_s.crbbseq
       LET sr[l_cnt].crbb001 = sr_s.crbb001
       LET sr[l_cnt].crbb002 = sr_s.crbb002
       LET sr[l_cnt].crba002 = sr_s.crba002
       LET sr[l_cnt].crba003 = sr_s.crba003
       LET sr[l_cnt].crba011 = sr_s.crba011
       LET sr[l_cnt].crba005 = sr_s.crba005
       LET sr[l_cnt].crba007 = sr_s.crba007
       LET sr[l_cnt].crba014 = sr_s.crba014
       LET sr[l_cnt].crba015 = sr_s.crba015
       LET sr[l_cnt].crba018 = sr_s.crba018
       LET sr[l_cnt].crba019 = sr_s.crba019
       LET sr[l_cnt].crba020 = sr_s.crba020
       LET sr[l_cnt].crba022 = sr_s.crba022
       LET sr[l_cnt].crba023 = sr_s.crba023
       LET sr[l_cnt].crba024 = sr_s.crba024
       LET sr[l_cnt].crba025 = sr_s.crba025
       LET sr[l_cnt].crba026 = sr_s.crba026
       LET sr[l_cnt].crbaent = sr_s.crbaent
       LET sr[l_cnt].crbasite = sr_s.crbasite
       LET sr[l_cnt].crbastus = sr_s.crbastus
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr710_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr710_g01_rep_data()
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
          START REPORT acrr710_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT acrr710_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT acrr710_g01_rep
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
 
{<section id="acrr710_g01.rep" readonly="Y" >}
PRIVATE REPORT acrr710_g01_rep(sr1)
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
DEFINE l_crba001_desc   LIKE type_t.chr100   #表尾主辦
DEFINE l_crbacnfid_desc LIKE type_t.chr100   #表尾審核
DEFINE sr3                sr3_r
DEFINE sr4                sr4_r
DEFINE sr5                sr5_r
DEFINE sr6                sr6_r
DEFINE sr7                sr7_r
DEFINE l_detail_show      LIKE type_t.chr5
DEFINE l_subrep05_show    LIKE type_t.chr5
DEFINE l_subrep06_show    LIKE type_t.chr5
DEFINE l_subrep07_show    LIKE type_t.chr5
DEFINE l_subrep08_show    LIKE type_t.chr5
DEFINE l_subrep09_show    LIKE type_t.chr5
DEFINE l_sql_cnt          STRING
DEFINE l_count            LIKE type_t.num5
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.crbadocno,sr1.crbbseq
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
        BEFORE GROUP OF sr1.crbadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.crbadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'crbaent=' ,sr1.crbaent,'{+}crbadocno=' ,sr1.crbadocno         
            CALL cl_gr_init_apr(sr1.crbadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.crbadocno.before name="rep.b_group.crbadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.crbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.crbadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr710_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE acrr710_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT acrr710_g01_subrep01
           DECLARE acrr710_g01_repcur01 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr710_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT acrr710_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT acrr710_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.crbadocno.after name="rep.b_group.crbadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.crbbseq
 
           #add-point:rep.b_group.crbbseq.before name="rep.b_group.crbbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.crbbseq.after name="rep.b_group.crbbseq.after"
           
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
                sr1.crbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.crbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.crbbseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr710_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE acrr710_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT acrr710_g01_subrep02
           DECLARE acrr710_g01_repcur02 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr710_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT acrr710_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT acrr710_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.crbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.crbadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.crbbseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr710_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE acrr710_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT acrr710_g01_subrep03
           DECLARE acrr710_g01_repcur03 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr710_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT acrr710_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT acrr710_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.crbadocno
 
           #add-point:rep.a_group.crbadocno.before name="rep.a_group.crbadocno.before"
           #抱怨內容
           LET l_count = 0
           LET l_detail_show = 'N'
           SELECT COUNT(crbb001) INTO l_count 
             FROM crbb_t 
            WHERE crbbent = g_enterprise
              AND crbbdocno = sr1.crbadocno
           IF l_count > 0 THEN 
              LET l_detail_show = 'Y'              
           END IF
           PRINTX l_detail_show           
           #取表尾主辦與審核欄位
           LET l_crba001_desc = ''
           LET l_crbacnfid_desc = ''
           SELECT crba001,crbacnfid INTO l_crba001_desc,l_crbacnfid_desc
             FROM crba_t
            WHERE crbaent = g_enterprise
              AND crbadocno = sr1.crbadocno
           IF cl_null(l_crba001_desc) THEN 
              LET l_crba001_desc = '' 
           ELSE
              LET l_crba001_desc = l_crba001_desc,'.',s_desc_get_person_desc(l_crba001_desc)           
           END IF
           IF cl_null(l_crbacnfid_desc) THEN 
              LET l_crbacnfid_desc = '' 
           ELSE
              LET l_crbacnfid_desc = l_crbacnfid_desc,'.',s_desc_get_person_desc(l_crbacnfid_desc)           
           END IF
           PRINTX l_crba001_desc,l_crbacnfid_desc
           
           #調查結果
           LET l_count = 0
           LET l_sql_cnt = ''
           LET l_subrep05_show = 'N'
           LET g_sql = " SELECT crbe001 FROM crbe_t ",
		                 "  WHERE crbeent = ",g_enterprise,
					        "    AND crbedocno = '",sr1.crbadocno,"'",
					        "    AND crbe000 = '2' "
           LET l_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE acrr710_g01_subrep05_cnt_pre FROM l_sql_cnt          
           EXECUTE acrr710_g01_subrep05_cnt_pre INTO l_count
           FREE acrr710_g01_subrep05_cnt_pre            
           IF l_count > 0 THEN 
              LET l_subrep05_show = 'Y'              
           END IF
           PRINTX l_subrep05_show
           START REPORT acrr710_g01_subrep05
           DECLARE acrr710_g01_repcur05 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur05 INTO sr3.*
              
              OUTPUT TO REPORT acrr710_g01_subrep05(sr3.*,sr1.crbadocno)
              
           END FOREACH                      
           FINISH REPORT acrr710_g01_subrep05
           #處理對策
           LET l_count = 0
           LET l_sql_cnt = ''
           LET l_subrep06_show = 'N'           
           LET g_sql = " SELECT crbe001 FROM crbe_t ",
		                 "  WHERE crbeent = ",g_enterprise,
					        "    AND crbedocno = '",sr1.crbadocno,"'",
					        "    AND crbe000 = '3' "
           LET l_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE acrr710_g01_subrep06_cnt_pre FROM l_sql_cnt          
           EXECUTE acrr710_g01_subrep06_cnt_pre INTO l_count
           FREE acrr710_g01_subrep06_cnt_pre            
           IF l_count > 0 THEN 
              LET l_subrep06_show = 'Y' 
           END IF
           PRINTX l_subrep06_show           
           START REPORT acrr710_g01_subrep06
           DECLARE acrr710_g01_repcur06 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur06 INTO sr4.*

              OUTPUT TO REPORT acrr710_g01_subrep06(sr4.*,sr1.crbadocno)

           END FOREACH                      
           FINISH REPORT acrr710_g01_subrep06
           #審核
           LET l_count = 0
           LET l_sql_cnt = ''
           LET l_subrep07_show = 'N'           
           LET g_sql = " SELECT crbe001 FROM crbe_t ",
		                 "  WHERE crbeent = ",g_enterprise,
					        "    AND crbedocno = '",sr1.crbadocno,"'",
					        "    AND crbe000 = '4' "
           LET l_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE acrr710_g01_subrep07_cnt_pre FROM l_sql_cnt          
           EXECUTE acrr710_g01_subrep07_cnt_pre INTO l_count
           FREE acrr710_g01_subrep07_cnt_pre            
           IF l_count > 0 THEN 
              LET l_subrep07_show = 'Y' 
           END IF
           PRINTX l_subrep07_show
           START REPORT acrr710_g01_subrep07
           DECLARE acrr710_g01_repcur07 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur07 INTO sr5.*

              OUTPUT TO REPORT acrr710_g01_subrep07(sr5.*,sr1.crbadocno)

           END FOREACH                      
           FINISH REPORT acrr710_g01_subrep07
           #核決
           LET l_count = 0
           LET l_sql_cnt = ''
           LET l_subrep08_show = 'N'           
           LET g_sql = " SELECT crbe001 FROM crbe_t ",
		                 "  WHERE crbeent = ",g_enterprise,
					        "    AND crbedocno = '",sr1.crbadocno,"'",
					        "    AND crbe000 = '5' "
           LET l_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE acrr710_g01_subrep08_cnt_pre FROM l_sql_cnt          
           EXECUTE acrr710_g01_subrep08_cnt_pre INTO l_count
           FREE acrr710_g01_subrep08_cnt_pre            
           IF l_count > 0 THEN 
              LET l_subrep08_show = 'Y' 
           END IF
           PRINT l_subrep08_show            
           START REPORT acrr710_g01_subrep08
           DECLARE acrr710_g01_repcur08 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur08 INTO sr6.*

              OUTPUT TO REPORT acrr710_g01_subrep08(sr6.*,sr1.crbadocno)
              
           END FOREACH                      
           FINISH REPORT acrr710_g01_subrep08
           #結案備註
           LET l_count = 0
           LET l_sql_cnt = ''
           LET l_subrep09_show = 'N'           
           LET g_sql = " SELECT crbe001 FROM crbe_t ",
		                 "  WHERE crbeent = ",g_enterprise,
					        "    AND crbedocno = '",sr1.crbadocno,"'",
					        "    AND crbe000 = '6' "
           LET l_sql_cnt = " SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE acrr710_g01_subrep09_cnt_pre FROM l_sql_cnt          
           EXECUTE acrr710_g01_subrep09_cnt_pre INTO l_count
           FREE acrr710_g01_subrep09_cnt_pre            
           IF l_count > 0 THEN 
              LET l_subrep09_show = 'Y' 
           END IF
           PRINT l_subrep09_show
           START REPORT acrr710_g01_subrep09
           DECLARE acrr710_g01_repcur09 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur09 INTO sr7.*

              OUTPUT TO REPORT acrr710_g01_subrep09(sr7.*,sr1.crbadocno)

           END FOREACH                      
           FINISH REPORT acrr710_g01_subrep09           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.crbaent CLIPPED ,"'", " AND  ooff003 = '", sr1.crbadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr710_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE acrr710_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT acrr710_g01_subrep04
           DECLARE acrr710_g01_repcur04 CURSOR FROM g_sql
           FOREACH acrr710_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr710_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT acrr710_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT acrr710_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
 
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.crbadocno.after name="rep.a_group.crbadocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.crbbseq
 
           #add-point:rep.a_group.crbbseq.before name="rep.a_group.crbbseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.crbbseq.after name="rep.a_group.crbbseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
 
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="acrr710_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT acrr710_g01_subrep01(sr2)
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
PRIVATE REPORT acrr710_g01_subrep02(sr2)
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
PRIVATE REPORT acrr710_g01_subrep03(sr2)
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
PRIVATE REPORT acrr710_g01_subrep04(sr2)
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
 
{<section id="acrr710_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 是否要顯示.說明
# Memo...........:
# Usage..........: CALL acrr710_g01_initialize(p_arg,p_exp)
#                  RETURNING r_exp
# Input parameter: p_arg    編號
#                : p_exp    說明
# Return code....: r_exp    顯示值
# Date & Author..: 2016/02/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr710_g01_initialize(p_arg,p_exp)
DEFINE p_arg   STRING
DEFINE p_exp   STRING
DEFINE r_exp   STRING

 INITIALIZE r_exp TO NULL
   IF cl_null(p_arg) OR p_exp = '.' THEN
      LET r_exp = p_arg
   ELSE
      LET r_exp = p_exp
   END IF
 RETURN r_exp
END FUNCTION

 
{</section>}
 
{<section id="acrr710_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 調查結果
# Memo...........:
# Usage..........: CALL acrr710_g01_subrep05(sr3,p_docno)
# Input parameter: sr3      
#                : p_docno  客訴單號單號
# Date & Author..: 2016/02/16 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT acrr710_g01_subrep05(sr3,p_docno)
DEFINE sr3 sr3_r
DEFINE p_docno        LIKE crba_t.crbadocno
DEFINE l_crbc001_desc LIKE type_t.chr100
DEFINE l_crbc002_desc LIKE type_t.chr100
    
    FORMAT
            
        ON EVERY ROW
           
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
        
        ON LAST ROW
        
           LET l_crbc001_desc = ''
           LET l_crbc002_desc = ''
           SELECT crbc001,crbc002 INTO l_crbc001_desc,l_crbc002_desc
             FROM crbc_t
            WHERE crbcent = g_enterprise
              AND crbcdocno = p_docno
			  AND crbc000 = '2' #調查結果

           IF cl_null(l_crbc001_desc) THEN 
              LET l_crbc001_desc = ''              
           ELSE
              LET l_crbc001_desc = l_crbc001_desc,'.',s_desc_get_person_desc(l_crbc001_desc)
           END IF

           IF cl_null(l_crbc002_desc) THEN 
              LET l_crbc002_desc = '' 
           ELSE
              LET l_crbc002_desc = l_crbc002_desc,'.',s_desc_get_person_desc(l_crbc002_desc)
           END IF
           
           
        PRINTX l_crbc001_desc,l_crbc002_desc
END REPORT

################################################################################
# Descriptions...: 處理對策
# Memo...........:
# Usage..........: CALL acrr710_g01_subrep06(sr4,p_docno)
# Input parameter: sr4      
#                : p_docno  客訴單號單號
# Date & Author..: 2016/02/16 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT acrr710_g01_subrep06(sr4,p_docno)
DEFINE sr4 sr4_r
DEFINE p_docno        LIKE crba_t.crbadocno
DEFINE l_crbc001_desc LIKE type_t.chr100
DEFINE l_crbc002_desc LIKE type_t.chr100  
    
    FORMAT 
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr4.*
        ON LAST ROW
           LET l_crbc001_desc = ''
           LET l_crbc002_desc = ''
           SELECT crbc001,crbc002 INTO l_crbc001_desc,l_crbc002_desc
             FROM crbc_t
            WHERE crbcent = g_enterprise
              AND crbcdocno = p_docno
			  AND crbc000 = '3' #處理對策

           IF cl_null(l_crbc001_desc) THEN 
              LET l_crbc001_desc = '' 
           ELSE
              LET l_crbc001_desc = l_crbc001_desc,'.',s_desc_get_person_desc(l_crbc001_desc)           
           END IF

           IF cl_null(l_crbc002_desc) THEN 
              LET l_crbc002_desc = '' 
           ELSE
              LET l_crbc002_desc = l_crbc002_desc,'.',s_desc_get_person_desc(l_crbc002_desc)           
           END IF
           
           
        PRINTX l_crbc001_desc,l_crbc002_desc
END REPORT

################################################################################
# Descriptions...: 審核
# Memo...........:
# Usage..........: CALL acrr710_g01_subrep07(sr5,p_docno)
# Input parameter: sr5      
#                : p_docno  客訴單號單號
# Date & Author..: 2016/02/16 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT acrr710_g01_subrep07(sr5,p_docno)
DEFINE sr5 sr5_r
DEFINE p_docno        LIKE crba_t.crbadocno
DEFINE l_crbc001_desc LIKE type_t.chr100
DEFINE l_crbc002_desc LIKE type_t.chr100  
    
    FORMAT 
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
        ON LAST ROW
           LET l_crbc001_desc = ''
           LET l_crbc002_desc = ''
           SELECT crbc001,crbc002 INTO l_crbc001_desc,l_crbc002_desc
             FROM crbc_t
            WHERE crbcent = g_enterprise
              AND crbcdocno = p_docno
			  AND crbc000 = '4' #審核

           IF cl_null(l_crbc001_desc) THEN 
              LET l_crbc001_desc = '' 
           ELSE
              LET l_crbc001_desc = l_crbc001_desc,'.',s_desc_get_person_desc(l_crbc001_desc)           
           END IF

           IF cl_null(l_crbc002_desc) THEN 
              LET l_crbc002_desc = '' 
           ELSE
              LET l_crbc002_desc = l_crbc002_desc,'.',s_desc_get_person_desc(l_crbc002_desc)           
           END IF
           
           
        PRINTX l_crbc001_desc,l_crbc002_desc
END REPORT

################################################################################
# Descriptions...: 核決
# Memo...........:
# Usage..........: CALL acrr710_g01_subrep08(sr6,p_docno)
# Input parameter: sr6      
#                : p_docno  客訴單號單號
# Date & Author..: 2016/02/16 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT acrr710_g01_subrep08(sr6,p_docno)
DEFINE sr6 sr6_r
DEFINE p_docno        LIKE crba_t.crbadocno
DEFINE l_crbc001_desc LIKE type_t.chr100
DEFINE l_crbc002_desc LIKE type_t.chr100  
    
    FORMAT 
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
        ON LAST ROW
           LET l_crbc001_desc = ''
           LET l_crbc002_desc = ''
           SELECT crbc001,crbc002 INTO l_crbc001_desc,l_crbc002_desc
             FROM crbc_t
            WHERE crbcent = g_enterprise
              AND crbcdocno = p_docno
			  AND crbc000 = '5' #核決

           IF cl_null(l_crbc001_desc) THEN 
              LET l_crbc001_desc = '' 
           ELSE
              LET l_crbc001_desc = l_crbc001_desc,'.',s_desc_get_person_desc(l_crbc001_desc)           
           END IF

           IF cl_null(l_crbc002_desc) THEN 
              LET l_crbc002_desc = '' 
           ELSE
              LET l_crbc002_desc = l_crbc002_desc,'.',s_desc_get_person_desc(l_crbc002_desc)           
           END IF
           
           
        PRINTX l_crbc001_desc,l_crbc002_desc
END REPORT

################################################################################
# Descriptions...: 結案備註
# Memo...........:
# Usage..........: CALL acrr710_g01_subrep09(sr7,p_docno)
# Input parameter: sr7      
#                : p_docno  客訴單號單號
# Date & Author..: 2016/02/16 By sakura
# Modify.........:
################################################################################
PRIVATE REPORT acrr710_g01_subrep09(sr7,p_docno)
DEFINE sr7 sr7_r
DEFINE p_docno        LIKE crba_t.crbadocno
DEFINE l_crbc001_desc LIKE type_t.chr100
DEFINE l_crbc002_desc LIKE type_t.chr100  
    
    FORMAT 
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr7.*
        ON LAST ROW
           LET l_crbc001_desc = ''
           LET l_crbc002_desc = ''
           SELECT crbc001,crbc002 INTO l_crbc001_desc,l_crbc002_desc
             FROM crbc_t
            WHERE crbcent = g_enterprise
              AND crbcdocno = p_docno
			  AND crbc000 = '6' #結案備註

           IF cl_null(l_crbc001_desc) THEN 
              LET l_crbc001_desc = '' 
           ELSE
              LET l_crbc001_desc = l_crbc001_desc,'.',s_desc_get_person_desc(l_crbc001_desc)           
           END IF

           IF cl_null(l_crbc002_desc) THEN 
              LET l_crbc002_desc = '' 
           ELSE
              LET l_crbc002_desc = l_crbc002_desc,'.',s_desc_get_person_desc(l_crbc002_desc)           
           END IF
           
           
        PRINTX l_crbc001_desc,l_crbc002_desc
END REPORT

 
{</section>}
 
