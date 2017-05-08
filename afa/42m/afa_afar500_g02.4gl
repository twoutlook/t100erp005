#該程式未解開Section, 採用最新樣板產出!
{<section id="afar500_g02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-12-05 10:52:54), PR版次:0003(2016-12-05 11:04:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: afar500_g02
#+ Description: ...
#+ Creator....: 02003(2015-04-20 10:28:10)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="afar500_g02.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160923-00015#5 2016/12/5  By 07900  增加名称的列印
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
   fabg001 LIKE fabg_t.fabg001, 
   fabg002 LIKE fabg_t.fabg002, 
   fabg005 LIKE fabg_t.fabg005, 
   fabg004 LIKE fabg_t.fabg004, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   fabh001 LIKE fabh_t.fabh001, 
   fabh002 LIKE fabh_t.fabh002, 
   fabh007 LIKE fabh_t.fabh007, 
   fabh008 LIKE fabh_t.fabh008, 
   fabh009 LIKE fabh_t.fabh009, 
   fabh011 LIKE fabh_t.fabh011, 
   fabh012 LIKE fabh_t.fabh012, 
   fabh013 LIKE fabh_t.fabh013, 
   fabh014 LIKE fabh_t.fabh014, 
   fabh015 LIKE fabh_t.fabh015, 
   fabh016 LIKE fabh_t.fabh016, 
   fabg001_desc LIKE type_t.chr30, 
   fabg002_desc LIKE type_t.chr30, 
   fabg005_desc LIKE type_t.chr30, 
   fabhseq LIKE fabh_t.fabhseq, 
   fabgent LIKE fabg_t.fabgent, 
   faah013 LIKE type_t.chr50
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #查詢條件 
       a1 STRING,                  #資產中心 
       a2 STRING,                  #資產性質 
       a3 STRING,                  #單據狀態 
       a4 STRING                   #帳套
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
 
{<section id="afar500_g02.main" readonly="Y" >}
PUBLIC FUNCTION afar500_g02(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  查詢條件 
DEFINE  p_arg2 STRING                  #tm.a1  資產中心 
DEFINE  p_arg3 STRING                  #tm.a2  資產性質 
DEFINE  p_arg4 STRING                  #tm.a3  單據狀態 
DEFINE  p_arg5 STRING                  #tm.a4  帳套
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
   LET tm.a4 = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "afar500_g02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afar500_g02_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afar500_g02_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afar500_g02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afar500_g02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar500_g02_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT fabg001,fabg002,fabg005,fabg004,fabgdocdt,fabgdocno,fabh001,fabh002,fabh007, 
       fabh008,fabh009,fabh011,fabh012,fabh013,fabh014,fabh015,fabh016,NULL,NULL,NULL,fabhseq,fabgent, 
       NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT fabg001,fabg002,fabg005,fabg004,fabgdocdt,fabgdocno,fabh001,fabh002,fabh007,", 
                  "fabh008,CASE WHEN fabh018 = '2' THEN fabh009*(-1) ELSE fabh009 END ,fabh011,fabh012,fabh013,",
                  "CASE WHEN fabh018 = '2' THEN fabh014*(-1) ELSE fabh014 END ,fabh015,",
                  "CASE WHEN fabh018 = '2' THEN fabh016*(-1) ELSE fabh016 END,NULL,NULL,NULL,fabhseq,fabgent,NULL"
   #end add-point
    LET g_from = " FROM fabg_t,fabh_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = g_where," AND fabgent = '",g_enterprise,"' AND fabgent = fabhent AND fabgdocno = fabhdocno AND fabgld = fabhld "
   #资产中心
   IF NOT cl_null(tm.a1) THEN 
      LET g_where = g_where," AND fabgsite = '",tm.a1,"'"
   END IF 
   #资产性质
   IF NOT cl_null(tm.a2) THEN 
      LET g_where = g_where," AND fabg005 = '",tm.a2,"'"
   END IF 
   #单据状态
   IF NOT cl_null(tm.a3) THEN 
      LET g_where = g_where," AND fabgstus = '",tm.a3,"'"
   END IF 
   #帐套
   IF NOT cl_null(tm.a4) THEN 
      LET g_where = g_where," AND fabgld = '",tm.a4,"'"
   END IF 
   #end add-point
    LET g_order = " ORDER BY fabgdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = g_order,",fabhseq"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fabg_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afar500_g02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afar500_g02_curs CURSOR FOR afar500_g02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afar500_g02.ins_data" readonly="Y" >}
PRIVATE FUNCTION afar500_g02_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fabg001 LIKE fabg_t.fabg001, 
   fabg002 LIKE fabg_t.fabg002, 
   fabg005 LIKE fabg_t.fabg005, 
   fabg004 LIKE fabg_t.fabg004, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   fabh001 LIKE fabh_t.fabh001, 
   fabh002 LIKE fabh_t.fabh002, 
   fabh007 LIKE fabh_t.fabh007, 
   fabh008 LIKE fabh_t.fabh008, 
   fabh009 LIKE fabh_t.fabh009, 
   fabh011 LIKE fabh_t.fabh011, 
   fabh012 LIKE fabh_t.fabh012, 
   fabh013 LIKE fabh_t.fabh013, 
   fabh014 LIKE fabh_t.fabh014, 
   fabh015 LIKE fabh_t.fabh015, 
   fabh016 LIKE fabh_t.fabh016, 
   fabg001_desc LIKE type_t.chr30, 
   fabg002_desc LIKE type_t.chr30, 
   fabg005_desc LIKE type_t.chr30, 
   fabhseq LIKE fabh_t.fabhseq, 
   fabgent LIKE fabg_t.fabgent, 
   faah013 LIKE type_t.chr50
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_faah012   LIKE faah_t.faah012
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH afar500_g02_curs INTO sr_s.*
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
       LET l_faah012 = ''   #160923-00015#5 add
       SELECT faah013,faah012 INTO sr_s.faah013,l_faah012    #160923-00015#5 add faah012 
         FROM faah_t,fabh_t
        WHERE faahent = g_enterprise
          AND faah001 = fabh000 
          AND faah003 = fabh001 
          AND faah004 = fabh002
          AND fabhdocno = sr_s.fabgdocno
          AND fabhseq = sr_s.fabhseq
      LET sr_s.faah013 = l_faah012," ",sr_s.faah013 #160923-00015#5 add
       SELECT ooag011 INTO sr_s.fabg001_desc
         FROM ooag_t
        WHERE ooagent = g_enterprise
          AND ooag001 = sr_s.fabg001
       
       SELECT ooag011 INTO sr_s.fabg002_desc
         FROM ooag_t
        WHERE ooagent = g_enterprise
          AND ooag001 = sr_s.fabg002
          
       SELECT gzcbl004 INTO sr_s.fabg005_desc
         FROM gzcbl_t
        WHERE gzcbl001 = '9910'
          AND gzcbl002 = sr_s.fabg005
          AND gzcbl003 = g_lang
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fabg001 = sr_s.fabg001
       LET sr[l_cnt].fabg002 = sr_s.fabg002
       LET sr[l_cnt].fabg005 = sr_s.fabg005
       LET sr[l_cnt].fabg004 = sr_s.fabg004
       LET sr[l_cnt].fabgdocdt = sr_s.fabgdocdt
       LET sr[l_cnt].fabgdocno = sr_s.fabgdocno
       LET sr[l_cnt].fabh001 = sr_s.fabh001
       LET sr[l_cnt].fabh002 = sr_s.fabh002
       LET sr[l_cnt].fabh007 = sr_s.fabh007
       LET sr[l_cnt].fabh008 = sr_s.fabh008
       LET sr[l_cnt].fabh009 = sr_s.fabh009
       LET sr[l_cnt].fabh011 = sr_s.fabh011
       LET sr[l_cnt].fabh012 = sr_s.fabh012
       LET sr[l_cnt].fabh013 = sr_s.fabh013
       LET sr[l_cnt].fabh014 = sr_s.fabh014
       LET sr[l_cnt].fabh015 = sr_s.fabh015
       LET sr[l_cnt].fabh016 = sr_s.fabh016
       LET sr[l_cnt].fabg001_desc = sr_s.fabg001_desc
       LET sr[l_cnt].fabg002_desc = sr_s.fabg002_desc
       LET sr[l_cnt].fabg005_desc = sr_s.fabg005_desc
       LET sr[l_cnt].fabhseq = sr_s.fabhseq
       LET sr[l_cnt].fabgent = sr_s.fabgent
       LET sr[l_cnt].faah013 = sr_s.faah013
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afar500_g02.rep_data" readonly="Y" >}
PRIVATE FUNCTION afar500_g02_rep_data()
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
          START REPORT afar500_g02_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afar500_g02_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afar500_g02_rep
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
 
{<section id="afar500_g02.rep" readonly="Y" >}
PRIVATE REPORT afar500_g02_rep(sr1)
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
DEFINE l_fabh007_sum   LIKE fabh_t.fabh007
DEFINE l_fabh008_sum   LIKE fabh_t.fabh008
DEFINE l_fabh009_sum   LIKE fabh_t.fabh009
DEFINE l_fabh011_sum   LIKE fabh_t.fabh011
DEFINE l_fabh012_sum   LIKE fabh_t.fabh012
DEFINE l_fabh013_sum   LIKE fabh_t.fabh013
DEFINE l_fabh014_sum   LIKE fabh_t.fabh014
DEFINE l_fabh015_sum   LIKE fabh_t.fabh015
DEFINE l_fabh016_sum   LIKE fabh_t.fabh016
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.fabgdocno,sr1.fabhseq
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
        BEFORE GROUP OF sr1.fabgdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fabgdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fabgent=' ,sr1.fabgent,'{+}fabgdocno=' ,sr1.fabgdocno         
            CALL cl_gr_init_apr(sr1.fabgdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fabgdocno.before name="rep.b_group.fabgdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fabgent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabgdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g02_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g02_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afar500_g02_subrep01
           DECLARE afar500_g02_repcur01 CURSOR FROM g_sql
           FOREACH afar500_g02_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g02_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afar500_g02_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g02_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fabgdocno.after name="rep.b_group.fabgdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.fabhseq
 
           #add-point:rep.b_group.fabhseq.before name="rep.b_group.fabhseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.fabhseq.after name="rep.b_group.fabhseq.after"
           
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
                sr1.fabgent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabgdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fabhseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g02_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g02_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afar500_g02_subrep02
           DECLARE afar500_g02_repcur02 CURSOR FROM g_sql
           FOREACH afar500_g02_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g02_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afar500_g02_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g02_subrep02
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
                sr1.fabgent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabgdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fabhseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g02_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g02_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afar500_g02_subrep03
           DECLARE afar500_g02_repcur03 CURSOR FROM g_sql
           FOREACH afar500_g02_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g02_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afar500_g02_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g02_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fabgdocno
 
           #add-point:rep.a_group.fabgdocno.before name="rep.a_group.fabgdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fabgent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabgdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g02_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g02_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afar500_g02_subrep04
           DECLARE afar500_g02_repcur04 CURSOR FROM g_sql
           FOREACH afar500_g02_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g02_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afar500_g02_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g02_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fabgdocno.after name="rep.a_group.fabgdocno.after"
           LET l_fabh007_sum = GROUP SUM(sr1.fabh007)
           LET l_fabh008_sum = GROUP SUM(sr1.fabh008)
           LET l_fabh009_sum = GROUP SUM(sr1.fabh009)
           LET l_fabh011_sum = GROUP SUM(sr1.fabh011)
           LET l_fabh012_sum = GROUP SUM(sr1.fabh012)
           LET l_fabh013_sum = GROUP SUM(sr1.fabh013)
           LET l_fabh014_sum = GROUP SUM(sr1.fabh014)
           LET l_fabh015_sum = GROUP SUM(sr1.fabh015)
           LET l_fabh016_sum = GROUP SUM(sr1.fabh016)
           PRINTX l_fabh007_sum,l_fabh008_sum,l_fabh009_sum,l_fabh011_sum,l_fabh012_sum,l_fabh013_sum,l_fabh014_sum,l_fabh015_sum,l_fabh016_sum
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fabhseq
 
           #add-point:rep.a_group.fabhseq.before name="rep.a_group.fabhseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.fabhseq.after name="rep.a_group.fabhseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afar500_g02.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afar500_g02_subrep01(sr2)
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
PRIVATE REPORT afar500_g02_subrep02(sr2)
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
PRIVATE REPORT afar500_g02_subrep03(sr2)
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
PRIVATE REPORT afar500_g02_subrep04(sr2)
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
 
{<section id="afar500_g02.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afar500_g02.other_report" readonly="Y" >}

 
{</section>}
 
