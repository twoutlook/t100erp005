#該程式未解開Section, 採用最新樣板產出!
{<section id="afar500_g07.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-05-25 17:52:14), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: afar500_g07
#+ Description: ...
#+ Creator....: 02291(2015-10-10 09:35:38)
#+ Modifier...: 06821 -SD/PR- 00000
 
{</section>}
 
{<section id="afar500_g07.global" readonly="Y" >}
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
   fabaent LIKE faba_t.fabaent, 
   fabadocno LIKE faba_t.fabadocno, 
   fabadocdt LIKE faba_t.fabadocdt, 
   faba001 LIKE faba_t.faba001, 
   faba004 LIKE faba_t.faba004, 
   faba005 LIKE faba_t.faba005, 
   faba006 LIKE faba_t.faba006, 
   faba003 LIKE faba_t.faba003, 
   fabkseq LIKE fabk_t.fabkseq, 
   fabk001 LIKE fabk_t.fabk001, 
   fabk002 LIKE fabk_t.fabk002, 
   fabk005 LIKE fabk_t.fabk005, 
   fabk003 LIKE fabk_t.fabk003, 
   fabk006 LIKE fabk_t.fabk006, 
   fabk008 LIKE fabk_t.fabk008
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #condotion:where 
       a1 STRING,                  #資產中心 
       a2 STRING,                  #資產性質 
       a3 STRING                   #資產狀態
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
 
{<section id="afar500_g07.main" readonly="Y" >}
PUBLIC FUNCTION afar500_g07(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  condotion:where 
DEFINE  p_arg2 STRING                  #tm.a1  資產中心 
DEFINE  p_arg3 STRING                  #tm.a2  資產性質 
DEFINE  p_arg4 STRING                  #tm.a3  資產狀態
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
   
   LET g_rep_code = "afar500_g07"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL afar500_g07_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL afar500_g07_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL afar500_g07_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afar500_g07.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar500_g07_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT fabaent,fabadocno,fabadocdt,faba001,faba004,faba005,faba006,faba003,fabkseq, 
       fabk001,fabk002,fabk005,fabk003,fabk006,fabk008"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM faba_t,fabk_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY fabadocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_where = g_where," AND fabaent = '",g_enterprise,"' AND fabaent = fabkent AND fabadocno = fabkdocno "
   IF NOT cl_null(tm.a1) THEN
      LET g_where = g_where," AND fabasite = '",tm.a1,"'"
   END IF
   #资产性质
   IF NOT cl_null(tm.a2) THEN
      LET g_where = g_where," AND faba003 = '",tm.a2,"'"
   END IF
   #单据状态
   IF NOT cl_null(tm.a3) THEN
      LET g_where = g_where," AND fabastus = '",tm.a3,"'"
   END IF
   LET g_order = " ORDER BY fabadocno,fabkseq"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("faba_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afar500_g07_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE afar500_g07_curs CURSOR FOR afar500_g07_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afar500_g07.ins_data" readonly="Y" >}
PRIVATE FUNCTION afar500_g07_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   fabaent LIKE faba_t.fabaent, 
   fabadocno LIKE faba_t.fabadocno, 
   fabadocdt LIKE faba_t.fabadocdt, 
   faba001 LIKE faba_t.faba001, 
   faba004 LIKE faba_t.faba004, 
   faba005 LIKE faba_t.faba005, 
   faba006 LIKE faba_t.faba006, 
   faba003 LIKE faba_t.faba003, 
   fabkseq LIKE fabk_t.fabkseq, 
   fabk001 LIKE fabk_t.fabk001, 
   fabk002 LIKE fabk_t.fabk002, 
   fabk005 LIKE fabk_t.fabk005, 
   fabk003 LIKE fabk_t.fabk003, 
   fabk006 LIKE fabk_t.fabk006, 
   fabk008 LIKE fabk_t.fabk008
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
    FOREACH afar500_g07_curs INTO sr_s.*
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
       LET sr[l_cnt].fabaent = sr_s.fabaent
       LET sr[l_cnt].fabadocno = sr_s.fabadocno
       LET sr[l_cnt].fabadocdt = sr_s.fabadocdt
       LET sr[l_cnt].faba001 = sr_s.faba001
       LET sr[l_cnt].faba004 = sr_s.faba004
       LET sr[l_cnt].faba005 = sr_s.faba005
       LET sr[l_cnt].faba006 = sr_s.faba006
       LET sr[l_cnt].faba003 = sr_s.faba003
       LET sr[l_cnt].fabkseq = sr_s.fabkseq
       LET sr[l_cnt].fabk001 = sr_s.fabk001
       LET sr[l_cnt].fabk002 = sr_s.fabk002
       LET sr[l_cnt].fabk005 = sr_s.fabk005
       LET sr[l_cnt].fabk003 = sr_s.fabk003
       LET sr[l_cnt].fabk006 = sr_s.fabk006
       LET sr[l_cnt].fabk008 = sr_s.fabk008
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afar500_g07.rep_data" readonly="Y" >}
PRIVATE FUNCTION afar500_g07_rep_data()
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
          START REPORT afar500_g07_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT afar500_g07_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT afar500_g07_rep
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
 
{<section id="afar500_g07.rep" readonly="Y" >}
PRIVATE REPORT afar500_g07_rep(sr1)
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
DEFINE l_faba001_desc   LIKE type_t.chr80
DEFINE l_faba003_desc   LIKE type_t.chr80
DEFINE l_faba004_desc   LIKE type_t.chr500
DEFINE l_faba005_desc   LIKE type_t.chr500
DEFINE l_faah012_desc   LIKE type_t.chr500
DEFINE l_faah012        LIKE faah_t.faah012
DEFINE l_faah013        LIKE faah_t.faah013
DEFINE l_fabk005_sum    LIKE fabk_t.fabk005
DEFINE l_fabk006_sum    LIKE fabk_t.fabk006
DEFINE l_fabk008_desc   LIKE type_t.chr500
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.fabadocno,sr1.fabkseq
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
        BEFORE GROUP OF sr1.fabadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.fabadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'fabaent=' ,sr1.fabaent,'{+}fabadocno=' ,sr1.fabadocno         
            CALL cl_gr_init_apr(sr1.fabadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.fabadocno.before name="rep.b_group.fabadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.fabaent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g07_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g07_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT afar500_g07_subrep01
           DECLARE afar500_g07_repcur01 CURSOR FROM g_sql
           FOREACH afar500_g07_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g07_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT afar500_g07_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g07_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.fabadocno.after name="rep.b_group.fabadocno.after"
           LET l_faba001_desc = ''
           LET l_faba004_desc = ''
           LET l_faba003_desc = ''
           LET l_faba005_desc = ''
           
           
           SELECT ooag011 INTO l_faba001_desc
            FROM ooag_t
           WHERE ooagent = g_enterprise
             AND ooag001 = sr1.faba001
        
          SELECT ooag011 INTO l_faba004_desc
            FROM ooag_t
           WHERE ooagent = g_enterprise
             AND ooag001 = sr1.faba004
        
          SELECT gzcbl004 INTO l_faba003_desc
            FROM gzcbl_t
           WHERE gzcbl001 = '9910'
             AND gzcbl002 = sr1.faba003
             AND gzcbl003 = g_dlang
        
          SELECT ooefl003 INTO l_faba005_desc
            FROM ooefl_t
           WHERE ooeflent = g_enterprise
             AND ooefl001 = sr1.faba005
             AND ooefl002 = g_dlang

          LET l_faah012_desc = l_faah012,"  ",l_faah013
          LET l_faba001_desc = sr1.faba001,"  ",l_faba001_desc
          LET l_faba004_desc = sr1.faba004,"  ",l_faba004_desc,"  ",sr1.faba005,"  ",l_faba005_desc
          PRINTX l_faba001_desc,l_faba003_desc,l_faba004_desc
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.fabkseq
 
           #add-point:rep.b_group.fabkseq.before name="rep.b_group.fabkseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.fabkseq.after name="rep.b_group.fabkseq.after"
           
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
                sr1.fabaent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fabkseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g07_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g07_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT afar500_g07_subrep02
           DECLARE afar500_g07_repcur02 CURSOR FROM g_sql
           FOREACH afar500_g07_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g07_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT afar500_g07_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g07_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
           LET l_faah012_desc = ''
         
          SELECT faah012,faah013 INTO l_faah012,l_faah013
            FROM faah_t,fabk_t
           WHERE faahent = g_enterprise
             AND faah001 = fabk000
             AND faah003 = fabk001
             AND faah004 = fabk002
             AND fabkdocno = sr1.fabadocno
             AND fabkseq = sr1.fabkseq

          SELECT oocql004 INTO l_fabk008_desc FROM oocql_t 
           WHERE oocqlent= g_enterprise AND oocql001='3902' 
             AND oocql002=sr1.fabk008 AND oocql003=g_dlang
          
          LET l_faah012_desc = l_faah012,"  ",l_faah013
          IF NOT cl_null(sr1.fabk008) THEN LET l_fabk008_desc = sr1.fabk008,".",l_fabk008_desc END IF
          PRINTX l_faah012_desc,l_fabk008_desc
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
                sr1.fabaent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabadocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.fabkseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g07_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g07_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT afar500_g07_subrep03
           DECLARE afar500_g07_repcur03 CURSOR FROM g_sql
           FOREACH afar500_g07_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g07_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT afar500_g07_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g07_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fabadocno
 
           #add-point:rep.a_group.fabadocno.before name="rep.a_group.fabadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.fabaent CLIPPED ,"'", " AND  ooff003 = '", sr1.fabadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE afar500_g07_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE afar500_g07_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT afar500_g07_subrep04
           DECLARE afar500_g07_repcur04 CURSOR FROM g_sql
           FOREACH afar500_g07_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "afar500_g07_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT afar500_g07_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT afar500_g07_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.fabadocno.after name="rep.a_group.fabadocno.after"
           LET l_fabk005_sum = GROUP SUM(sr1.fabk005)
           PRINTX l_fabk005_sum
           LET l_fabk006_sum = GROUP SUM(sr1.fabk006)
           PRINTX l_fabk006_sum
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.fabkseq
 
           #add-point:rep.a_group.fabkseq.before name="rep.a_group.fabkseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.fabkseq.after name="rep.a_group.fabkseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="afar500_g07.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT afar500_g07_subrep01(sr2)
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
PRIVATE REPORT afar500_g07_subrep02(sr2)
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
PRIVATE REPORT afar500_g07_subrep03(sr2)
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
PRIVATE REPORT afar500_g07_subrep04(sr2)
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
 
{<section id="afar500_g07.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="afar500_g07.other_report" readonly="Y" >}

 
{</section>}
 
