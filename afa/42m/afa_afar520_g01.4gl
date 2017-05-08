#該程式未解開Section, 採用最新樣板產出!
{<section id="afar520_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-01-11 16:56:04), PR版次:0001(2016-01-11 17:22:05)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: afar520_g01
#+ Description: ...
#+ Creator....: 02291(2015-11-25 16:31:33)
#+ Modifier...: 02291 -SD/PR- 02291
 
{</section>}
 
{<section id="afar520_g01.global" readonly="Y" >}
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
   fabrent LIKE fabr_t.fabrent, 
   l_order1 LIKE type_t.chr500, 
   l_fabr001_desc LIKE type_t.chr500, 
   l_fabrcomp_desc LIKE type_t.chr500, 
   fabr003 LIKE fabr_t.fabr003, 
   fabr004 LIKE fabr_t.fabr004, 
   fabr005 LIKE fabr_t.fabr005, 
   fabr006 LIKE fabr_t.fabr006, 
   fabr007 LIKE fabr_t.fabr007, 
   l_fabr014_desc LIKE type_t.chr500, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   l_fabr019_desc LIKE type_t.chr500, 
   fabr012 LIKE fabr_t.fabr012
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #condition:where 
       a1 LIKE type_t.chr1,         #包含資產標籤 
       a2 LIKE type_t.chr10,         #資產中心 
       a3 LIKE type_t.chr10          #法人組織
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
   fabt004 LIKE fabt_t.fabt004,
   fabt005 LIKE fabt_t.fabt005,
   fabt006 LIKE fabt_t.fabt006,
   fabt008 LIKE fabt_t.fabt008
END RECORD
#end add-point
 
{</section>}
 
{<section id="afar520_g01.main" readonly="Y" >}
PUBLIC FUNCTION afar520_g01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  condition:where 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a1  包含資產標籤 
DEFINE  p_arg3 LIKE type_t.chr10         #tm.a2  資產中心 
DEFINE  p_arg4 LIKE type_t.chr10         #tm.a3  法人組織
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "afar520_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afar520_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afar520_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afar520_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afar520_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar520_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT fabrent,trim(fabr003)||trim(fabr004),trim(fabr001)||'.'||trim(ooefl_t.ooefl003), 
       fabrcomp,trim(fabrcomp)||'.'||trim(ooefl_t.ooefl003),fabr003,fabr004,fabr005,fabr006,fabr007, 
       trim(fabr014)||'.'||trim(ooefl_t.ooefl003),faah012,faah013,trim(fabr019)||'.'||trim(ooefl_t.ooefl003), 
       fabr012"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT fabrent,trim(fabr003)||trim(fabr004),trim(fabr001)||' '||trim(t1.ooefl003),fabrcomp,trim(fabrcomp)||' '||trim(t2.ooefl003), 
       fabr003,fabr004,fabr005,fabr006,fabr007,trim(fabr014)||' '||trim(t3.ooefl003),faah012,faah013, 
       trim(fabr019)||' '||trim(t4.ooefl003),fabr012"
   #end add-point
    LET g_from = " FROM fabr_t,faah_t,ooefl_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM fabr_t LEFT OUTER JOIN faah_t ON faahent = fabrent AND faah003 = fabr005 ",
                "   AND faah004 = fabr006 AND faah001 = fabr007 ",
                " LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = fabrent AND t1.ooefl001 = fabr001 AND t1.ooefl002 = '",g_dlang,"'",
                " LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent = fabrent AND t2.ooefl001 = fabrcomp AND t2.ooefl002 = '",g_dlang,"'",
                " LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent = fabrent AND t3.ooefl001 = fabr014 AND t3.ooefl002 = '",g_dlang,"'",
                " LEFT OUTER JOIN ooefl_t t4 ON t4.ooeflent = fabrent AND t4.ooefl001 = fabr019 AND t4.ooefl002 = '",g_dlang,"'"
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
  #LET g_where = g_where CLIPPED," AND fabr001 = '",tm.a2,"' AND fabrcomp = '",tm.a3,"'"
   IF NOT cl_null(tm.a2) THEN
      LET g_where = g_where CLIPPED," AND fabr001 = '",tm.a2,"'"
   END IF
   IF NOT cl_null(tm.a3) THEN
      LET g_where = g_where CLIPPED," AND fabrcomp = '",tm.a3,"'"
   END IF
   #end add-point
    LET g_order = " ORDER BY fabr003,fabr004"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fabr_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afar520_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afar520_g01_curs CURSOR FOR afar520_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afar520_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afar520_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fabrent LIKE fabr_t.fabrent, 
   l_order1 LIKE type_t.chr500, 
   l_fabr001_desc LIKE type_t.chr500, 
   fabrcomp LIKE fabr_t.fabrcomp, 
   l_fabrcomp_desc LIKE type_t.chr500, 
   fabr003 LIKE fabr_t.fabr003, 
   fabr004 LIKE fabr_t.fabr004, 
   fabr005 LIKE fabr_t.fabr005, 
   fabr006 LIKE fabr_t.fabr006, 
   fabr007 LIKE fabr_t.fabr007, 
   l_fabr014_desc LIKE type_t.chr500, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   l_fabr019_desc LIKE type_t.chr500, 
   fabr012 LIKE fabr_t.fabr012
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
    FOREACH afar520_g01_curs INTO sr_s.*
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
       LET sr[l_cnt].fabrent = sr_s.fabrent
       LET sr[l_cnt].l_order1 = sr_s.l_order1
       LET sr[l_cnt].l_fabr001_desc = sr_s.l_fabr001_desc
       LET sr[l_cnt].l_fabrcomp_desc = sr_s.l_fabrcomp_desc
       LET sr[l_cnt].fabr003 = sr_s.fabr003
       LET sr[l_cnt].fabr004 = sr_s.fabr004
       LET sr[l_cnt].fabr005 = sr_s.fabr005
       LET sr[l_cnt].fabr006 = sr_s.fabr006
       LET sr[l_cnt].fabr007 = sr_s.fabr007
       LET sr[l_cnt].l_fabr014_desc = sr_s.l_fabr014_desc
       LET sr[l_cnt].faah012 = sr_s.faah012
       LET sr[l_cnt].faah013 = sr_s.faah013
       LET sr[l_cnt].l_fabr019_desc = sr_s.l_fabr019_desc
       LET sr[l_cnt].fabr012 = sr_s.fabr012
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afar520_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afar520_g01_rep_data()
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
          START REPORT afar520_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afar520_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afar520_g01_rep
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
 
{<section id="afar520_g01.rep" readonly="Y" >}
PRIVATE REPORT afar520_g01_rep(sr1)
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
DEFINE l_subrep05_show  LIKE type_t.chr1
DEFINE sr3 sr3_r
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.l_order1
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
        BEFORE GROUP OF sr1.l_order1
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_order1
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fabrent=' ,sr1.fabrent,'{+}fabr003=' ,sr1.fabr003,'{+}fabr004=' ,sr1.fabr004         
            CALL cl_gr_init_apr(sr1.l_order1)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order1.before name="rep.b_group.l_order1.before"
           LET g_sql = " SELECT fabt004,fabt005,fabt006,fabt008 FROM fabt_t WHERE fabtent = '",
                sr1.fabrent CLIPPED ,"'", " AND  fabt002 = '", sr1.fabr003 CLIPPED ,"' AND fabt003 = ",sr1.fabr004
 
           #add-point:rep.sub01.afsql

           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar520_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE afar520_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep05_show ="Y"
           END IF
           PRINTX l_subrep05_show
           START REPORT afar520_g01_subrep05
           DECLARE afar520_g01_repcur05 CURSOR FROM g_sql
           FOREACH afar520_g01_repcur05 INTO sr3.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar520_g01_repcur05:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach

              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afar520_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT afar520_g01_subrep05
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
        
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fabrent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order1 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar520_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afar520_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afar520_g01_subrep01
           DECLARE afar520_g01_repcur01 CURSOR FROM g_sql
           FOREACH afar520_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar520_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afar520_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afar520_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order1.after name="rep.b_group.l_order1.after"
           
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
                sr1.fabrent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order1 CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar520_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afar520_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afar520_g01_subrep02
           DECLARE afar520_g01_repcur02 CURSOR FROM g_sql
           FOREACH afar520_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar520_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afar520_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afar520_g01_subrep02
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
                sr1.fabrent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar520_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afar520_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afar520_g01_subrep03
           DECLARE afar520_g01_repcur03 CURSOR FROM g_sql
           FOREACH afar520_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar520_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afar520_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afar520_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order1
 
           #add-point:rep.a_group.l_order1.before name="rep.a_group.l_order1.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fabrent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order1 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar520_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afar520_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afar520_g01_subrep04
           DECLARE afar520_g01_repcur04 CURSOR FROM g_sql
           FOREACH afar520_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar520_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afar520_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afar520_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order1.after name="rep.a_group.l_order1.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afar520_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afar520_g01_subrep01(sr2)
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
PRIVATE REPORT afar520_g01_subrep02(sr2)
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
PRIVATE REPORT afar520_g01_subrep03(sr2)
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
PRIVATE REPORT afar520_g01_subrep04(sr2)
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
 
{<section id="afar520_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afar520_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 盘点标签
# Memo...........:
# Usage..........: CALL afar520_g01_subrep05(sr3)
# Modify.........:
################################################################################
PRIVATE REPORT afar520_g01_subrep05(sr3)
DEFINE  sr3  sr3_r    
    FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 
