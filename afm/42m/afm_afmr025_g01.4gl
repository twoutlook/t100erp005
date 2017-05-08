#該程式未解開Section, 採用最新樣板產出!
{<section id="afmr025_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-10-11 09:32:23), PR版次:0001(2016-10-11 10:13:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000003
#+ Filename...: afmr025_g01
#+ Description: ...
#+ Creator....: 08171(2016-09-29 15:13:33)
#+ Modifier...: 08171 -SD/PR- 08171
 
{</section>}
 
{<section id="afmr025_g01.global" readonly="Y" >}
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
   fmagdocdt LIKE fmag_t.fmagdocdt, 
   fmagdocno LIKE fmag_t.fmagdocno, 
   fmagent LIKE fmag_t.fmagent, 
   fmagsite LIKE fmag_t.fmagsite, 
   fmagstus LIKE fmag_t.fmagstus, 
   l_fmagsite_desc LIKE type_t.chr100, 
   l_fmagstus LIKE type_t.chr30
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
TYPE sr5_r RECORD
   l_fmaiseq          LIKE fmai_t.fmaiseq, 
   l_fmai001          LIKE type_t.chr100, 
   l_glaacomp         LIKE type_t.chr100, 
   l_fmai002          LIKE type_t.chr100, 
   l_fmcf002          LIKE type_t.chr100, 
   l_fmcf003          LIKE type_t.chr500,
   fmah001            LIKE fmah_t.fmah001,
   fmah006            LIKE fmah_t.fmah006,
   l_fmai004          LIKE type_t.num20, 
   l_fmai001_desc     LIKE type_t.chr100,
   ooefl_t_ooefl003   LIKE ooefl_t.ooefl003,
   l_fmai003          LIKE fmai_t.fmai003, 
   x_fmaal_t_fmaal003 LIKE fmaal_t.fmaal003
END RECORD

TYPE sr6_r RECORD
   fmahseq        LIKE fmah_t.fmahseq,
   fmah001        LIKE fmah_t.fmah001, 
   l_fmah001_desc LIKE type_t.chr100,
   fmah002        LIKE fmah_t.fmah002, 
   l_fmah002_desc LIKE type_t.chr100,
   l_ooef001      LIKE type_t.chr100,
   l_ooef001_desc LIKE type_t.chr100,
   fmah003        LIKE fmah_t.fmah003, 
   fmah004        LIKE fmah_t.fmah004, 
   l_fmah005_desc LIKE type_t.chr100, 
   fmah006        LIKE fmah_t.fmah006, 
   fmah007        LIKE fmah_t.fmah007, 
   fmah008        LIKE fmah_t.fmah008, 
   fmah009        LIKE fmah_t.fmah009,
   l_fmah008      LIKE type_t.chr30, 
   l_fmah009      LIKE type_t.chr30,
   fmah010        LIKE fmah_t.fmah010
END RECORD
#end add-point
 
{</section>}
 
{<section id="afmr025_g01.main" readonly="Y" >}
PUBLIC FUNCTION afmr025_g01(p_arg1)
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
   
   LET g_rep_code = "afmr025_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afmr025_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afmr025_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afmr025_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afmr025_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmr025_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT fmagdocdt,fmagdocno,fmagent,fmagsite,fmagstus,'',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM fmag_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY fmagdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fmag_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afmr025_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afmr025_g01_curs CURSOR FOR afmr025_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afmr025_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afmr025_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fmagdocdt LIKE fmag_t.fmagdocdt, 
   fmagdocno LIKE fmag_t.fmagdocno, 
   fmagent LIKE fmag_t.fmagent, 
   fmagsite LIKE fmag_t.fmagsite, 
   fmagstus LIKE fmag_t.fmagstus, 
   l_fmagsite_desc LIKE type_t.chr100, 
   l_fmagstus LIKE type_t.chr30
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_fmagstus_desc LIKE type_t.chr30
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH afmr025_g01_curs INTO sr_s.*
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
       #資金中心+說明
       SELECT ooefl003 INTO sr_s.l_fmagsite_desc
       FROM ooefl_t 
       WHERE ooeflent = g_enterprise 
         AND ooefl001 = sr_s.fmagsite
         AND ooefl002 = g_dlang
       LET sr_s.l_fmagsite_desc = sr_s.fmagsite," ",sr_s.l_fmagsite_desc
       
       #單據狀態
       LET l_fmagstus_desc = s_desc_gzcbl004_desc(13,sr_s.fmagstus)
       LET sr_s.l_fmagstus = sr_s.fmagstus,"",l_fmagstus_desc
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fmagdocdt = sr_s.fmagdocdt
       LET sr[l_cnt].fmagdocno = sr_s.fmagdocno
       LET sr[l_cnt].fmagent = sr_s.fmagent
       LET sr[l_cnt].fmagsite = sr_s.fmagsite
       LET sr[l_cnt].fmagstus = sr_s.fmagstus
       LET sr[l_cnt].l_fmagsite_desc = sr_s.l_fmagsite_desc
       LET sr[l_cnt].l_fmagstus = sr_s.l_fmagstus
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
 
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmr025_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afmr025_g01_rep_data()
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
          START REPORT afmr025_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afmr025_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afmr025_g01_rep
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
 
{<section id="afmr025_g01.rep" readonly="Y" >}
PRIVATE REPORT afmr025_g01_rep(sr1)
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
DEFINE sr5 sr5_r
DEFINE sr6 sr6_r
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE l_subrep06_show  LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.fmagdocno
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
        BEFORE GROUP OF sr1.fmagdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fmagdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fmagent=' ,sr1.fmagent,'{+}fmagdocno=' ,sr1.fmagdocno         
            CALL cl_gr_init_apr(sr1.fmagdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fmagdocno.before name="rep.b_group.fmagdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fmagent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmagdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr025_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afmr025_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afmr025_g01_subrep01
           DECLARE afmr025_g01_repcur01 CURSOR FROM g_sql
           FOREACH afmr025_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr025_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afmr025_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afmr025_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fmagdocno.after name="rep.b_group.fmagdocno.after"
           
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
                sr1.fmagent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmagdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr025_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afmr025_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afmr025_g01_subrep02
           DECLARE afmr025_g01_repcur02 CURSOR FROM g_sql
           FOREACH afmr025_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr025_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afmr025_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afmr025_g01_subrep02
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
                sr1.fmagent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr025_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afmr025_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afmr025_g01_subrep03
           DECLARE afmr025_g01_repcur03 CURSOR FROM g_sql
           FOREACH afmr025_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr025_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afmr025_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afmr025_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmagdocno
 
           #add-point:rep.a_group.fmagdocno.before name="rep.a_group.fmagdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fmagent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmagdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr025_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afmr025_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afmr025_g01_subrep04
           DECLARE afmr025_g01_repcur04 CURSOR FROM g_sql
           FOREACH afmr025_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr025_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afmr025_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afmr025_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fmagdocno.after name="rep.a_group.fmagdocno.after"
           #單身1↓
           LET g_sql = " SELECT fmahseq,fmah001,(SELECT fmaal003 FROM fmaal_t WHERE fmaalent="||g_enterprise||" AND fmaal001=fmah001 AND fmaal002='"||g_dlang||"'),",
                       " fmah002,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=fmah002 AND ooefl002='"||g_dlang||"'),",
                       " (SELECT ooef017 FROM ooef_t WHERE ooefent = "||g_enterprise||" AND ooef001 = fmah002),",
                       " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=(SELECT ooef017 FROM ooef_t WHERE ooefent = "||g_enterprise||" AND ooef001 = fmah002) AND ooefl002='"||g_dlang||"'),",
                       " fmah003,fmah004,(SELECT nmabl003 FROM nmabl_t WHERE nmablent="||g_enterprise||" AND nmabl001=fmah005 AND nmabl002='"||g_dlang||"'),",
                       " fmah006,fmah007,fmah008,fmah009,'','',fmah010 ",
                       " FROM fmah_t ",
                       " WHERE fmahent = "||g_enterprise||" AND fmahdocno = '"||sr1.fmagdocno||"' "
                             
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep06_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr025_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE afmr025_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep06_show ="Y"
           END IF
           PRINTX l_subrep06_show        
           
           START REPORT afmr025_g01_subrep06
           DECLARE afmr025_g01_repcur06 CURSOR FROM g_sql
           FOREACH afmr025_g01_repcur06 INTO sr6.*
              IF STATUS THEN                  
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr025_g01_repcur06:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              
              LET sr6.l_fmah008 = sr6.fmah008
              LET sr6.l_fmah009 = sr6.fmah009
              #起止日期都為空
              IF NOT cl_null(sr6.fmah008) AND NOT cl_null(sr6.fmah009) THEN
                 LET sr6.l_fmah008 = sr6.fmah008,"~"
              ELSE
                 LET sr6.l_fmah008 = sr6.fmah008
              END IF 
              #止日期為空
              IF NOT cl_null(sr6.fmah008) AND cl_null(sr6.fmah009) THEN
                 LET sr6.l_fmah008 = sr6.fmah008,"~"
              END IF
              #起日期為空
              IF cl_null(sr6.fmah008) AND NOT cl_null(sr6.fmah009) THEN
                 LET sr6.l_fmah008 = "~"
              END IF
              
              OUTPUT TO REPORT afmr025_g01_subrep06(sr6.*)
           END FOREACH
           FINISH REPORT afmr025_g01_subrep06
           #單身1↑
           #單身2↓
           LET g_sql = " SELECT fmaiseq2,fmai001,",
                       " (SELECT glaacomp FROM glaa_t,ooef_t WHERE glaaent = ooefent AND glaacomp = ooef017 AND glaaent = "||g_enterprise||" AND ooef001 = fmai001 AND glaa014 = 'Y'),",
                       " fmai002,fmcf002,fmcf003,fmah001,fmah006,fmai004,",
                       " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=fmai001 AND ooefl002='"||g_dlang||"'),",
                       " (SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=(SELECT glaacomp FROM glaa_t,ooef_t WHERE glaaent = ooefent AND glaacomp = ooef017 AND glaaent = "||g_enterprise||" AND ooef001 = fmai001 AND glaa014 = 'Y') AND ooefl002='"||g_dlang||"'),fmai003,",
                       " (SELECT fmaal003 FROM fmaal_t WHERE fmaalent="||g_enterprise||" AND fmaal001=fmah001 AND fmaal002='"||g_dlang||"')",
                       " FROM fmai_t",
                       " LEFT JOIN fmcf_t on fmaient = fmcfent AND fmai002 = fmcfdocno AND fmai003 = fmcfseq  ",
                       " LEFT JOIN fmah_t on fmaient = fmahent AND fmaidocno = fmahdocno AND fmaiseq = fmahseq ",
                       " WHERE fmaient = "||g_enterprise||" AND fmaidocno = '"||sr1.fmagdocno||"'",
                       " ORDER BY fmaiseq2"
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmr025_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE afmr025_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show        
           
           START REPORT afmr025_g01_subrep05
           DECLARE afmr025_g01_repcur05 CURSOR FROM g_sql
           FOREACH afmr025_g01_repcur05 INTO sr5.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmr025_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              OUTPUT TO REPORT afmr025_g01_subrep05(sr5.*)
           END FOREACH
           FINISH REPORT afmr025_g01_subrep05
           #↑單身2
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afmr025_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afmr025_g01_subrep01(sr2)
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
PRIVATE REPORT afmr025_g01_subrep02(sr2)
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
PRIVATE REPORT afmr025_g01_subrep03(sr2)
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
PRIVATE REPORT afmr025_g01_subrep04(sr2)
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
 
{<section id="afmr025_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afmr025_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 單身1
# Memo...........:
# Usage..........: CALL afmr025_g01_subrep06(sr6)
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20161003 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT afmr025_g01_subrep06(sr6)
DEFINE sr6    sr6_r
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr6.*
END REPORT

################################################################################
# Descriptions...: 單身2
# Memo...........:
# Usage..........: CALL afmr025_g01_subrep05(sr5)
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160930 By 08171
# Modify.........:
################################################################################
PRIVATE REPORT afmr025_g01_subrep05(sr5)
DEFINE sr5    sr5_r
   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr5.*
END REPORT

 
{</section>}
 