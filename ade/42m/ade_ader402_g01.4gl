#該程式未解開Section, 採用最新樣板產出!
{<section id="ader402_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-06-20 00:00:00), PR版次:0001(2014-06-24 16:17:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000124
#+ Filename...: ader402_g01
#+ Description: 門店收銀繳款單
#+ Creator....: 02716(2014-04-21 10:21:29)
#+ Modifier...: 02716 -SD/PR- 04010
 
{</section>}
 
{<section id="ader402_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:10)
#add-point:註解 name="global.memo"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
##this is a test from janet
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   deag001 LIKE deag_t.deag001, 
   deag002 LIKE deag_t.deag002, 
   deag003 LIKE deag_t.deag003, 
   deag004 LIKE deag_t.deag004, 
   deagdocdt LIKE deag_t.deagdocdt, 
   deagdocno LIKE deag_t.deagdocno, 
   deagent LIKE deag_t.deagent, 
   deagsite LIKE deag_t.deagsite, 
   deagstus LIKE deag_t.deagstus, 
   deagunit LIKE deag_t.deagunit, 
   deah000 LIKE deah_t.deah000, 
   deah001 LIKE deah_t.deah001, 
   deah002 LIKE deah_t.deah002, 
   deah003 LIKE deah_t.deah003, 
   deah004 LIKE deah_t.deah004, 
   deah005 LIKE deah_t.deah005, 
   deah006 LIKE deah_t.deah006, 
   deah007 LIKE deah_t.deah007, 
   deah008 LIKE deah_t.deah008, 
   deah009 LIKE deah_t.deah009, 
   deah013 LIKE deah_t.deah013, 
   deahseq LIKE deah_t.deahseq, 
   oogd_t_oogd002 LIKE oogd_t.oogd002, 
   pcaal_t_pcaal003 LIKE pcaal_t.pcaal003, 
   pcab_t_pcab003 LIKE pcab_t.pcab003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_ooial_t_ooial003 LIKE ooial_t.ooial003, 
   x_gcafl_t_gcafl003 LIKE gcafl_t.gcafl003, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_ooail_t_ooail003 LIKE ooail_t.ooail003, 
   l_deagsite_ooefl003 LIKE type_t.chr1000, 
   l_deag004_pcab003 LIKE type_t.chr100
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING                   #
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
 
{<section id="ader402_g01.main" readonly="Y" >}
PUBLIC FUNCTION ader402_g01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc
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
   
   LET g_rep_code = "ader402_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ader402_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ader402_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ader402_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ader402_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ader402_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT deag001,deag002,deag003,deag004,deagdocdt,deagdocno,deagent,deagsite,deagstus, 
       deagunit,deah000,deah001,deah002,deah003,deah004,deah005,deah006,deah007,deah008,deah009,deah013, 
       deahseq,oogd_t.oogd002,pcaal_t.pcaal003,pcab_t.pcab003,ooefl_t.ooefl003,x.ooial_t_ooial003,x.gcafl_t_gcafl003, 
       x.oocql_t_oocql004,x.ooail_t_ooail003,trim(deagsite)||'.'||trim(ooefl_t.ooefl003),trim(deag004)||'.'||trim(pcab_t.pcab003)" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM deag_t LEFT OUTER JOIN ooefl_t ON ooefl_t.ooeflent = deag_t.deagent AND ooefl_t.ooefl001 = deag_t.deagsite AND ooefl_t.ooefl002 = '" , 
        '" ,g_dlang,"'" ,","'" ,"             LEFT OUTER JOIN pcab_t ON pcab_t.pcabent = deag_t.deagent AND pcab_t.pcab001 = deag_t.deag004             LEFT OUTER JOIN pcaal_t ON pcaal_t.pcaalent = deag_t.deagent AND pcaal_t.pcaalsite = deag_t.deagsite AND pcaal_t.pcaal001 = deag_t.deag003 AND pcaal_t.pcaal002 = '" , 
        '" ,g_dlang,"'" ,","'" ,"             LEFT OUTER JOIN oogd_t ON oogd_t.oogdent = deag_t.deagent AND oogd_t.oogdsite = deag_t.deagsite AND oogd_t.oogd001 = deag_t.deag002 LEFT OUTER JOIN ( SELECT deah_t.*, 
        ooial_t.ooial003 ooial_t_ooial003,gcafl_t.gcafl003 gcafl_t_gcafl003,oocql_t.oocql004 oocql_t_oocql004, 
        ooail_t.ooail003 ooail_t_ooail003 FROM deah_t LEFT OUTER JOIN ooail_t ON ooail_t.ooailent = deah_t.deahent AND ooail_t.ooail001 = deah_t.deah005 AND ooail_t.ooail002 = '" , 
        '" ,g_dlang,"'" ,","'" ,"             LEFT OUTER JOIN oocql_t ON oocql_t.oocqlent = deah_t.deahent AND oocql_t.oocql001 = '2071' AND oocql_t.oocql002 = deah_t.deah003 AND oocql_t.oocql003 = '" , 
        '" ,g_dlang,"'" ,","'" ,"             LEFT OUTER JOIN gcafl_t ON gcafl_t.gcaflent = deah_t.deahent AND gcafl_t.gcafl001 = deah_t.deah002 AND gcafl_t.gcafl002 = '" , 
        '" ,g_dlang,"'" ,","'" ,"             LEFT OUTER JOIN ooial_t ON ooial_t.ooialent = deah_t.deahent AND ooial_t.ooial001 = deah_t.deah001 AND ooial_t.ooial002 = '" , 
        '" ,g_dlang,"'" ,","'" ," ) x  ON deag_t.deagent = x.deahent AND deag_t.deagdocno = x.deahdocno" 
 
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY deagdocno,deahseq"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("deag_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ader402_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ader402_g01_curs CURSOR FOR ader402_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ader402_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ader402_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   deag001 LIKE deag_t.deag001, 
   deag002 LIKE deag_t.deag002, 
   deag003 LIKE deag_t.deag003, 
   deag004 LIKE deag_t.deag004, 
   deagdocdt LIKE deag_t.deagdocdt, 
   deagdocno LIKE deag_t.deagdocno, 
   deagent LIKE deag_t.deagent, 
   deagsite LIKE deag_t.deagsite, 
   deagstus LIKE deag_t.deagstus, 
   deagunit LIKE deag_t.deagunit, 
   deah000 LIKE deah_t.deah000, 
   deah001 LIKE deah_t.deah001, 
   deah002 LIKE deah_t.deah002, 
   deah003 LIKE deah_t.deah003, 
   deah004 LIKE deah_t.deah004, 
   deah005 LIKE deah_t.deah005, 
   deah006 LIKE deah_t.deah006, 
   deah007 LIKE deah_t.deah007, 
   deah008 LIKE deah_t.deah008, 
   deah009 LIKE deah_t.deah009, 
   deah013 LIKE deah_t.deah013, 
   deahseq LIKE deah_t.deahseq, 
   oogd_t_oogd002 LIKE oogd_t.oogd002, 
   pcaal_t_pcaal003 LIKE pcaal_t.pcaal003, 
   pcab_t_pcab003 LIKE pcab_t.pcab003, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   x_ooial_t_ooial003 LIKE ooial_t.ooial003, 
   x_gcafl_t_gcafl003 LIKE gcafl_t.gcafl003, 
   x_oocql_t_oocql004 LIKE oocql_t.oocql004, 
   x_ooail_t_ooail003 LIKE ooail_t.ooail003, 
   l_deagsite_ooefl003 LIKE type_t.chr1000, 
   l_deag004_pcab003 LIKE type_t.chr100
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
    FOREACH ader402_g01_curs INTO sr_s.*
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
       
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].deag001 = sr_s.deag001
       LET sr[l_cnt].deag002 = sr_s.deag002
       LET sr[l_cnt].deag003 = sr_s.deag003
       LET sr[l_cnt].deag004 = sr_s.deag004
       LET sr[l_cnt].deagdocdt = sr_s.deagdocdt
       LET sr[l_cnt].deagdocno = sr_s.deagdocno
       LET sr[l_cnt].deagent = sr_s.deagent
       LET sr[l_cnt].deagsite = sr_s.deagsite
       LET sr[l_cnt].deagstus = sr_s.deagstus
       LET sr[l_cnt].deagunit = sr_s.deagunit
       LET sr[l_cnt].deah000 = sr_s.deah000
       LET sr[l_cnt].deah001 = sr_s.deah001
       LET sr[l_cnt].deah002 = sr_s.deah002
       LET sr[l_cnt].deah003 = sr_s.deah003
       LET sr[l_cnt].deah004 = sr_s.deah004
       LET sr[l_cnt].deah005 = sr_s.deah005
       LET sr[l_cnt].deah006 = sr_s.deah006
       LET sr[l_cnt].deah007 = sr_s.deah007
       LET sr[l_cnt].deah008 = sr_s.deah008
       LET sr[l_cnt].deah009 = sr_s.deah009
       LET sr[l_cnt].deah013 = sr_s.deah013
       LET sr[l_cnt].deahseq = sr_s.deahseq
       LET sr[l_cnt].oogd_t_oogd002 = sr_s.oogd_t_oogd002
       LET sr[l_cnt].pcaal_t_pcaal003 = sr_s.pcaal_t_pcaal003
       LET sr[l_cnt].pcab_t_pcab003 = sr_s.pcab_t_pcab003
       LET sr[l_cnt].ooefl_t_ooefl003 = sr_s.ooefl_t_ooefl003
       LET sr[l_cnt].x_ooial_t_ooial003 = sr_s.x_ooial_t_ooial003
       LET sr[l_cnt].x_gcafl_t_gcafl003 = sr_s.x_gcafl_t_gcafl003
       LET sr[l_cnt].x_oocql_t_oocql004 = sr_s.x_oocql_t_oocql004
       LET sr[l_cnt].x_ooail_t_ooail003 = sr_s.x_ooail_t_ooail003
       LET sr[l_cnt].l_deagsite_ooefl003 = sr_s.l_deagsite_ooefl003
       LET sr[l_cnt].l_deag004_pcab003 = sr_s.l_deag004_pcab003
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ader402_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ader402_g01_rep_data()
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
          START REPORT ader402_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ader402_g01_rep(sr[l_i].*)
          END FOR
          FINISH REPORT ader402_g01_rep
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
 
{<section id="ader402_g01.rep" readonly="Y" >}
PRIVATE REPORT ader402_g01_rep(sr1)
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
    ORDER EXTERNAL BY sr1.deagdocno,sr1.deahseq
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
        BEFORE GROUP OF sr1.deagdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.deagdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'deagent=' ,sr1.deagent,'{+}deagdocno=' ,sr1.deagdocno         
            CALL cl_gr_init_apr(sr1.deagdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.deagdocno.before name="rep.b_group.deagdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                sr1.deagent CLIPPED ,"'", " AND  ooff002 = '", sr1.deagdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ader402_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ader402_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ader402_g01_subrep01
           DECLARE ader402_g01_repcur01 CURSOR FROM g_sql
           FOREACH ader402_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ader402_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ader402_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ader402_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.deagdocno.after name="rep.b_group.deagdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.deahseq
 
           #add-point:rep.b_group.deahseq.before name="rep.b_group.deahseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.deahseq.after name="rep.b_group.deahseq.after"
           
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
                sr1.deagent CLIPPED ,"'", " AND  ooff002 = '", sr1.deagdocno CLIPPED ,"'", " AND  ooff003 = '", 
                sr1.deahseq CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ader402_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ader402_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ader402_g01_subrep02
           DECLARE ader402_g01_repcur02 CURSOR FROM g_sql
           FOREACH ader402_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ader402_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ader402_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ader402_g01_subrep02
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
                sr1.deagent CLIPPED ,"'", " AND  ooff002 = '", sr1.deagdocno CLIPPED ,"'", " AND  ooff003 = '", 
                sr1.deahseq CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ader402_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ader402_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ader402_g01_subrep03
           DECLARE ader402_g01_repcur03 CURSOR FROM g_sql
           FOREACH ader402_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ader402_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ader402_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ader402_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.deagdocno
 
           #add-point:rep.a_group.deagdocno.before name="rep.a_group.deagdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
                sr1.deagent CLIPPED ,"'", " AND  ooff002 = '", sr1.deagdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ader402_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ader402_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ader402_g01_subrep04
           DECLARE ader402_g01_repcur04 CURSOR FROM g_sql
           FOREACH ader402_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ader402_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ader402_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ader402_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
 
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.deagdocno.after name="rep.a_group.deagdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.deahseq
 
           #add-point:rep.a_group.deahseq.before name="rep.a_group.deahseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.deahseq.after name="rep.a_group.deahseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ader402_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ader402_g01_subrep01(sr2)
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
PRIVATE REPORT ader402_g01_subrep02(sr2)
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
PRIVATE REPORT ader402_g01_subrep03(sr2)
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
PRIVATE REPORT ader402_g01_subrep04(sr2)
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
 
{<section id="ader402_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="ader402_g01.other_report" readonly="Y" >}

 
{</section>}
 
