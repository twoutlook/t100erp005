#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt510_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-08-21 11:42:12), PR版次:0001(2015-08-21 14:40:11)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: afmt510_g01
#+ Description: ...
#+ Creator....: 06821(2015-08-21 10:01:51)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="afmt510_g01.global" readonly="Y" >}
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
   fmmgent LIKE fmmg_t.fmmgent, 
   fmmgdocno LIKE fmmg_t.fmmgdocno, 
   fmmg004 LIKE fmmg_t.fmmg004, 
   fmmg006 LIKE fmmg_t.fmmg006, 
   l_fmmg006_desc LIKE type_t.chr500, 
   l_fmmg004_desc LIKE type_t.chr500, 
   fmmg009 LIKE fmmg_t.fmmg009, 
   fmmg008 LIKE fmmg_t.fmmg008, 
   fmmg001 LIKE fmmg_t.fmmg001, 
   l_fmmg004_fmmel003 LIKE type_t.chr500, 
   l_fmmg003_desc LIKE type_t.chr500, 
   fmmg005 LIKE fmmg_t.fmmg005, 
   fmmg007 LIKE fmmg_t.fmmg007, 
   l_fmmg004_desc_desc LIKE type_t.chr500, 
   l_fmmg003_fmmal003 LIKE type_t.chr500, 
   fmmg003 LIKE fmmg_t.fmmg003, 
   fmmgdocdt LIKE fmmg_t.fmmgdocdt, 
   fmmg002 LIKE fmmg_t.fmmg002, 
   l_fmmg002_ooefl003 LIKE type_t.chr500
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

#end add-point
 
{</section>}
 
{<section id="afmt510_g01.main" readonly="Y" >}
PUBLIC FUNCTION afmt510_g01(p_arg1)
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
   
   LET g_rep_code = "afmt510_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afmt510_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afmt510_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afmt510_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmt510_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT fmmgent,fmmgdocno,fmmg004,fmmg006,'','',fmmg009,fmmg008,fmmg001,trim(fmmg004)||'.'||trim(fmmel003), 
       '',fmmg005,fmmg007,'',trim(fmmg003)||'.'||trim(fmmal_t.fmmal003),fmmg003,fmmgdocdt,fmmg002,trim(fmmg002)||'.'||trim(ooefl_t.ooefl003)" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM fmmg_t LEFT OUTER JOIN fmmel_t ON fmmel_t.fmmel001 = fmmg_t.fmmg004 AND fmmel_t.fmmelent = fmmg_t.fmmgent AND fmmel_t.fmmel002 = '",g_dlang,"'" ,
                 "             LEFT OUTER JOIN ooefl_t ON ooefl_t.ooefl001 = fmmg_t.fmmg002 AND ooefl_t.ooeflent = fmmg_t.fmmgent AND ooefl_t.ooefl002 = '",g_dlang,"'" ,
                 "             LEFT OUTER JOIN fmmal_t ON fmmal_t.fmmal001 = fmmg_t.fmmg003 AND fmmal_t.fmmalent = fmmg_t.fmmgent AND fmmal_t.fmmal002 = '",g_dlang,"'"
#   #end add-point
#    LET g_from = " FROM fmmg_t,fmmel_t,fmmal_t,ooefl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY fmmgdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("fmmg_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afmt510_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afmt510_g01_curs CURSOR FOR afmt510_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afmt510_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afmt510_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fmmgent LIKE fmmg_t.fmmgent, 
   fmmgdocno LIKE fmmg_t.fmmgdocno, 
   fmmg004 LIKE fmmg_t.fmmg004, 
   fmmg006 LIKE fmmg_t.fmmg006, 
   l_fmmg006_desc LIKE type_t.chr500, 
   l_fmmg004_desc LIKE type_t.chr500, 
   fmmg009 LIKE fmmg_t.fmmg009, 
   fmmg008 LIKE fmmg_t.fmmg008, 
   fmmg001 LIKE fmmg_t.fmmg001, 
   l_fmmg004_fmmel003 LIKE type_t.chr500, 
   l_fmmg003_desc LIKE type_t.chr500, 
   fmmg005 LIKE fmmg_t.fmmg005, 
   fmmg007 LIKE fmmg_t.fmmg007, 
   l_fmmg004_desc_desc LIKE type_t.chr500, 
   l_fmmg003_fmmal003 LIKE type_t.chr500, 
   fmmg003 LIKE fmmg_t.fmmg003, 
   fmmgdocdt LIKE fmmg_t.fmmgdocdt, 
   fmmg002 LIKE fmmg_t.fmmg002, 
   l_fmmg002_ooefl003 LIKE type_t.chr500
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_fmmg003_desc      LIKE type_t.chr500
DEFINE l_fmmg004_desc      LIKE type_t.chr500
DEFINE l_fmmg004_desc_desc LIKE type_t.chr500
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH afmt510_g01_curs INTO sr_s.*
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
       #資金帳戶 / 三方監管帳戶       
       LET l_fmmg004_desc = NULL
       LET l_fmmg004_desc_desc = NULL
       SELECT fmmf003,fmmf005 INTO l_fmmg004_desc,l_fmmg004_desc_desc
         FROM fmmf_t
        WHERE fmmfent = sr_s.fmmgent
          AND fmmf001 = sr_s.fmmg002
          AND fmmf002 = sr_s.fmmg004   
          
       LET sr_s.l_fmmg004_desc = l_fmmg004_desc
       LET sr_s.l_fmmg004_desc_desc = l_fmmg004_desc_desc       
       
       #預算項目
       CALL s_desc_get_budget_desc(sr_s.fmmg006) RETURNING sr_s.l_fmmg006_desc
       LET sr_s.l_fmmg006_desc = sr_s.fmmg006,".",sr_s.l_fmmg006_desc
       
       #費用處理方式
       LET l_fmmg003_desc = NULL
       SELECT fmma003 INTO l_fmmg003_desc 
         FROM fmma_t
        WHERE fmmaent = sr_s.fmmgent
          AND fmma001 = sr_s.fmmg003
       
       IF NOT cl_null(l_fmmg003_desc)THEN            
          LET sr_s.l_fmmg003_desc = l_fmmg003_desc,":",s_desc_gzcbl004_desc('8802',l_fmmg003_desc)
       END IF
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].fmmgent = sr_s.fmmgent
       LET sr[l_cnt].fmmgdocno = sr_s.fmmgdocno
       LET sr[l_cnt].fmmg004 = sr_s.fmmg004
       LET sr[l_cnt].fmmg006 = sr_s.fmmg006
       LET sr[l_cnt].l_fmmg006_desc = sr_s.l_fmmg006_desc
       LET sr[l_cnt].l_fmmg004_desc = sr_s.l_fmmg004_desc
       LET sr[l_cnt].fmmg009 = sr_s.fmmg009
       LET sr[l_cnt].fmmg008 = sr_s.fmmg008
       LET sr[l_cnt].fmmg001 = sr_s.fmmg001
       LET sr[l_cnt].l_fmmg004_fmmel003 = sr_s.l_fmmg004_fmmel003
       LET sr[l_cnt].l_fmmg003_desc = sr_s.l_fmmg003_desc
       LET sr[l_cnt].fmmg005 = sr_s.fmmg005
       LET sr[l_cnt].fmmg007 = sr_s.fmmg007
       LET sr[l_cnt].l_fmmg004_desc_desc = sr_s.l_fmmg004_desc_desc
       LET sr[l_cnt].l_fmmg003_fmmal003 = sr_s.l_fmmg003_fmmal003
       LET sr[l_cnt].fmmg003 = sr_s.fmmg003
       LET sr[l_cnt].fmmgdocdt = sr_s.fmmgdocdt
       LET sr[l_cnt].fmmg002 = sr_s.fmmg002
       LET sr[l_cnt].l_fmmg002_ooefl003 = sr_s.l_fmmg002_ooefl003
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt510_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afmt510_g01_rep_data()
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
          START REPORT afmt510_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afmt510_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afmt510_g01_rep
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
 
{<section id="afmt510_g01.rep" readonly="Y" >}
PRIVATE REPORT afmt510_g01_rep(sr1)
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
    ORDER  BY sr1.fmmgdocno
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
        BEFORE GROUP OF sr1.fmmgdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fmmgdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fmmgent=' ,sr1.fmmgent,'{+}fmmgdocno=' ,sr1.fmmgdocno         
            CALL cl_gr_init_apr(sr1.fmmgdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fmmgdocno.before name="rep.b_group.fmmgdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fmmgent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmgdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt510_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afmt510_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afmt510_g01_subrep01
           DECLARE afmt510_g01_repcur01 CURSOR FROM g_sql
           FOREACH afmt510_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt510_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afmt510_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afmt510_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fmmgdocno.after name="rep.b_group.fmmgdocno.after"
           
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
                sr1.fmmgent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmgdocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt510_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afmt510_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afmt510_g01_subrep02
           DECLARE afmt510_g01_repcur02 CURSOR FROM g_sql
           FOREACH afmt510_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt510_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afmt510_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afmt510_g01_subrep02
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
                sr1.fmmgent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt510_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afmt510_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afmt510_g01_subrep03
           DECLARE afmt510_g01_repcur03 CURSOR FROM g_sql
           FOREACH afmt510_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt510_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afmt510_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afmt510_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fmmgdocno
 
           #add-point:rep.a_group.fmmgdocno.before name="rep.a_group.fmmgdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fmmgent CLIPPED ,"'", " AND  ooff003 = '", sr1.fmmgdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afmt510_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afmt510_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afmt510_g01_subrep04
           DECLARE afmt510_g01_repcur04 CURSOR FROM g_sql
           FOREACH afmt510_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afmt510_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afmt510_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afmt510_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fmmgdocno.after name="rep.a_group.fmmgdocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afmt510_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afmt510_g01_subrep01(sr2)
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
PRIVATE REPORT afmt510_g01_subrep02(sr2)
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
PRIVATE REPORT afmt510_g01_subrep03(sr2)
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
PRIVATE REPORT afmt510_g01_subrep04(sr2)
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
 
{<section id="afmt510_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afmt510_g01.other_report" readonly="Y" >}

 
{</section>}
 
