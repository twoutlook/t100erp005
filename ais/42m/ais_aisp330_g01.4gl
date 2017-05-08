#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp330_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-25 15:18:50), PR版次:0001(2016-02-25 15:20:34)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aisp330_g01
#+ Description: ...
#+ Creator....: 06821(2016-02-22 17:23:16)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aisp330_g01.global" readonly="Y" >}
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
   isatent LIKE isat_t.isatent, 
   isatdocno LIKE isat_t.isatdocno, 
   isatcomp LIKE isat_t.isatcomp, 
   isatsite LIKE isat_t.isatsite, 
   isatseq LIKE isat_t.isatseq, 
   isat003 LIKE isat_t.isat003, 
   isat004 LIKE isat_t.isat004, 
   isat009 LIKE isat_t.isat009, 
   isat010 LIKE isat_t.isat010, 
   isat011 LIKE isat_t.isat011, 
   isat007 LIKE isat_t.isat007, 
   isat024 LIKE isat_t.isat024, 
   l_isahseq LIKE isah_t.isahseq, 
   l_isah004 LIKE isah_t.isah004, 
   l_isah006 LIKE isah_t.isah006, 
   l_isah101 LIKE isah_t.isah101, 
   l_isah113 LIKE isah_t.isah113, 
   isat113 LIKE isat_t.isat113, 
   isat022 LIKE isat_t.isat022, 
   isat114 LIKE isat_t.isat114, 
   isat115 LIKE isat_t.isat115, 
   l_year LIKE type_t.chr10, 
   l_mon LIKE type_t.chr10, 
   l_day LIKE type_t.chr10
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
DEFINE g_glaald LIKE glaa_t.glaald
#end add-point
 
{</section>}
 
{<section id="aisp330_g01.main" readonly="Y" >}
PUBLIC FUNCTION aisp330_g01(p_arg1)
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
   
   LET g_rep_code = "aisp330_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aisp330_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aisp330_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aisp330_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp330_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp330_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
 
#   #end add-point
#   LET g_select = " SELECT isatent,isatdocno,isatcomp,isatsite,isatseq,isat003,isat004,isat009,isat010, 
#       isat011,isat007,isat024,'','',NULL,'','',isat113,isat022,isat114,isat115,'','',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT isatent,isatdocno,isatcomp,isatsite,isatseq,isat003,isat004,isat009,isat010,
       isat011,isat007,isat024,isahseq,isah004,isah006,isah101,isah113,isat113,isat022,isat114,isat115,'','',''"
#   #end add-point
#    LET g_from = " FROM isat_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_from = " FROM isat_t,isah_t "         
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = g_where CLIPPED," AND isatent = ",g_enterprise," AND isatent = isahent AND isahcomp = isatcomp AND isah002 = isat004 AND isahdocno = isatdocno ",
                                  " AND isat014 = '11' AND isat025 = '11'"
#   #end add-point
#    LET g_order = " ORDER BY isat004"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   LET g_order = " ORDER BY isat004,isahseq"
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("isat_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aisp330_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aisp330_g01_curs CURSOR FOR aisp330_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aisp330_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aisp330_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   isatent LIKE isat_t.isatent, 
   isatdocno LIKE isat_t.isatdocno, 
   isatcomp LIKE isat_t.isatcomp, 
   isatsite LIKE isat_t.isatsite, 
   isatseq LIKE isat_t.isatseq, 
   isat003 LIKE isat_t.isat003, 
   isat004 LIKE isat_t.isat004, 
   isat009 LIKE isat_t.isat009, 
   isat010 LIKE isat_t.isat010, 
   isat011 LIKE isat_t.isat011, 
   isat007 LIKE isat_t.isat007, 
   isat024 LIKE isat_t.isat024, 
   l_isahseq LIKE isah_t.isahseq, 
   l_isah004 LIKE isah_t.isah004, 
   l_isah006 LIKE isah_t.isah006, 
   l_isah101 LIKE isah_t.isah101, 
   l_isah113 LIKE isah_t.isah113, 
   isat113 LIKE isat_t.isat113, 
   isat022 LIKE isat_t.isat022, 
   isat114 LIKE isat_t.isat114, 
   isat115 LIKE isat_t.isat115, 
   l_year LIKE type_t.chr10, 
   l_mon LIKE type_t.chr10, 
   l_day LIKE type_t.chr10
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_comp    LIKE glaa_t.glaacomp
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_isaf101 LIKE isaf_t.isaf101
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aisp330_g01_curs INTO sr_s.*
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
       #帳套
       CALL s_fin_orga_get_comp_ld(sr_s.isatsite) RETURNING g_sub_success,g_errno,l_comp,g_glaald
       
       #本幣
       SELECT glaa001 INTO l_glaa001 
         FROM glaa_t 
        WHERE glaaent = g_enterprise AND glaald = g_glaald  
        
       #匯率
       SELECT isaf101 INTO l_isaf101 
         FROM isaf_t 
        WHERE isafent = g_enterprise AND isafcomp = sr_s.isatcomp AND isafdocno = sr_s.isatdocno

       #計算單價
       LET sr_s.l_isah101 = sr_s.l_isah101 * l_isaf101
       CALL s_curr_round_ld('1',g_glaald,l_glaa001,sr_s.l_isah101,2) RETURNING g_sub_success,g_errno,sr_s.l_isah101
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #民國年
       LET sr_s.l_year = (YEAR(sr_s.isat007))-1911
       LET sr_s.l_year = sr_s.l_year USING "&&&"
       #月
       LET sr_s.l_mon  = MONTH(sr_s.isat007) USING "&&"
       #日
       LET sr_s.l_day  = DAY(sr_s.isat007)
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].isatent = sr_s.isatent
       LET sr[l_cnt].isatdocno = sr_s.isatdocno
       LET sr[l_cnt].isatcomp = sr_s.isatcomp
       LET sr[l_cnt].isatsite = sr_s.isatsite
       LET sr[l_cnt].isatseq = sr_s.isatseq
       LET sr[l_cnt].isat003 = sr_s.isat003
       LET sr[l_cnt].isat004 = sr_s.isat004
       LET sr[l_cnt].isat009 = sr_s.isat009
       LET sr[l_cnt].isat010 = sr_s.isat010
       LET sr[l_cnt].isat011 = sr_s.isat011
       LET sr[l_cnt].isat007 = sr_s.isat007
       LET sr[l_cnt].isat024 = sr_s.isat024
       LET sr[l_cnt].l_isahseq = sr_s.l_isahseq
       LET sr[l_cnt].l_isah004 = sr_s.l_isah004
       LET sr[l_cnt].l_isah006 = sr_s.l_isah006
       LET sr[l_cnt].l_isah101 = sr_s.l_isah101
       LET sr[l_cnt].l_isah113 = sr_s.l_isah113
       LET sr[l_cnt].isat113 = sr_s.isat113
       LET sr[l_cnt].isat022 = sr_s.isat022
       LET sr[l_cnt].isat114 = sr_s.isat114
       LET sr[l_cnt].isat115 = sr_s.isat115
       LET sr[l_cnt].l_year = sr_s.l_year
       LET sr[l_cnt].l_mon = sr_s.l_mon
       LET sr[l_cnt].l_day = sr_s.l_day
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
 
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
 
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp330_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aisp330_g01_rep_data()
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
          START REPORT aisp330_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aisp330_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT aisp330_g01_rep
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
 
{<section id="aisp330_g01.rep" readonly="Y" >}
PRIVATE REPORT aisp330_g01_rep(sr1)
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
DEFINE l_skip         LIKE type_t.chr1    #跳頁
DEFINE l_next         LIKE type_t.chr1    #顯示接下頁
DEFINE l_lineno       LIKE type_t.num5    #筆數
DEFINE l_tot_cnt      LIKE type_t.num10   #總筆數
DEFINE l_isat022      LIKE type_t.chr1    #1.應稅/2.零稅/3.免稅
DEFINE l_isat115      LIKE isat_t.isat115 #總計金額
DEFINE l_word_isat115 STRING              #大寫字串
DEFINE l_cmd          STRING
DEFINE l_show_space1  LIKE type_t.chr1 
DEFINE l_show_space2  LIKE type_t.chr1
DEFINE l_show_space3  LIKE type_t.chr1
DEFINE l_show_space4  LIKE type_t.chr1
DEFINE l_show_space5  LIKE type_t.chr1
DEFINE l_show_space6  LIKE type_t.chr1
DEFINE l_show_space7  LIKE type_t.chr1
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.isat004,sr1.l_isahseq
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
        BEFORE GROUP OF sr1.isat004
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            LET g_rep_docno = sr1.isatdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
#            #end add-point:rep.header 
#            LET g_rep_docno = sr1.isat004
#            CALL cl_gr_init_pageheader() #表頭資訊
#            PRINTX g_grPageHeader.*
#            PRINTX g_grPageFooter.*
#            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
            LET g_doc_key = 'isatent=' ,sr1.isatent,'{+}isatcomp=' ,sr1.isatcomp,'{+}isatseq=' ,sr1.isatseq,'{+}isat003=' ,sr1.isat003,'{+}isat004=' ,sr1.isat004         
            CALL cl_gr_init_apr(sr1.isatdocno)
#            #end add-point:rep.apr.signstr.before   
#            LET g_doc_key = 'isatent=' ,sr1.isatent,'{+}isatcomp=' ,sr1.isatcomp,'{+}isatseq=' ,sr1.isatseq,'{+}isat003=' ,sr1.isat003,'{+}isat004=' ,sr1.isat004         
#            CALL cl_gr_init_apr(sr1.isat004)
#            #add-point:rep.apr.signstr name="rep.apr.signstr"
            LET l_lineno = 0
            LET l_isat022 = ''
            
            #單身總筆數
            LET l_cmd = " SELECT COUNT(*)  ",
                        "   FROM isat_t,isah_t ",  
                        "  WHERE isatent = ",g_enterprise,
                        "    AND isatent = isahent AND isahcomp = isatcomp AND isah002 = isat004 AND isahdocno = isatdocno ",
                        "    AND isat004 = '",sr1.isat004,"' AND isatcomp = '",sr1.isatcomp,"' ",
                        "    AND isat014 = '11' AND isat025 = '11'"
                        
            PREPARE aisp330_g01_body_cnt_pr FROM l_cmd
            EXECUTE aisp330_g01_body_cnt_pr INTO l_tot_cnt
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.isat004.before name="rep.b_group.isat004.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.isatent CLIPPED ,"'", " AND  ooff003 = '", sr1.isat004 CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp330_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aisp330_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aisp330_g01_subrep01
           DECLARE aisp330_g01_repcur01 CURSOR FROM g_sql
           FOREACH aisp330_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp330_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aisp330_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aisp330_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.isat004.after name="rep.b_group.isat004.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_isahseq
 
           #add-point:rep.b_group.l_isahseq.before name="rep.b_group.l_isahseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.l_isahseq.after name="rep.b_group.l_isahseq.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          #課稅別
          LET l_isat022 = sr1.isat022
          PRINTX l_isat022
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.isatent CLIPPED ,"'", " AND  ooff003 = '", sr1.isat004 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_isahseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp330_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aisp330_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aisp330_g01_subrep02
           DECLARE aisp330_g01_repcur02 CURSOR FROM g_sql
           FOREACH aisp330_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp330_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aisp330_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aisp330_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          #目前已列筆數
          LET l_lineno = l_lineno + 1
          PRINTX l_lineno
          
          #跳頁flag
          LET l_skip ='N' 
          LET l_next ='N'
          
          #補空格flag
          LET l_show_space1 = 'N'
          LET l_show_space2 = 'N'
          LET l_show_space3 = 'N'
          LET l_show_space4 = 'N'
          LET l_show_space5 = 'N'
          LET l_show_space6 = 'N'
          LET l_show_space7 = 'N'
          
          #七筆+接下頁> 跳頁
          IF l_lineno MOD 7 = 0 THEN
             LET l_skip ='Y'        #跳頁
             LET l_next ='Y'        #接下頁
             IF l_tot_cnt <= 8 THEN #若總筆數小於等於8,不用跳頁
                LET l_skip ='N'     #不用跳頁
                LET l_next ='N'     #不顯示接下頁
             END IF
          END IF
          
          #如果是最後一筆,補空格
          IF l_lineno = l_tot_cnt THEN
             CASE (l_lineno MOD 7)
                WHEN 1 #補7個
                   LET l_show_space1 = 'Y'
                   LET l_show_space2 = 'Y'
                   LET l_show_space3 = 'Y'
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y'
                   LET l_show_space6 = 'Y'
                   LET l_show_space7 = 'Y'
                WHEN 2 #補6個
                   LET l_show_space2 = 'Y'
                   LET l_show_space3 = 'Y'
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y'
                   LET l_show_space6 = 'Y'
                   LET l_show_space7 = 'Y'
                WHEN 3 #補5個
                   LET l_show_space3 = 'Y'
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y'
                   LET l_show_space6 = 'Y'
                   LET l_show_space7 = 'Y'
                WHEN 4 #補4個
                   LET l_show_space4 = 'Y'
                   LET l_show_space5 = 'Y'
                   LET l_show_space6 = 'Y'
                   LET l_show_space7 = 'Y'
                WHEN 5 #補3個
                   LET l_show_space5 = 'Y'
                   LET l_show_space6 = 'Y'
                   LET l_show_space7 = 'Y'
                WHEN 6 #補2個
                   LET l_show_space6 = 'Y'
                   LET l_show_space7 = 'Y'
                WHEN 0 #印7筆 + 一筆"接下頁"
                   LET l_show_space7 = 'Y'
             END CASE
          END IF
          
          PRINTX l_skip
          PRINTX l_next
          PRINTX l_show_space1
          PRINTX l_show_space2
          PRINTX l_show_space3
          PRINTX l_show_space4
          PRINTX l_show_space5
          PRINTX l_show_space6
          PRINTX l_show_space7
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
                sr1.isatent CLIPPED ,"'", " AND  ooff003 = '", sr1.isat004 CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.l_isahseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp330_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aisp330_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aisp330_g01_subrep03
           DECLARE aisp330_g01_repcur03 CURSOR FROM g_sql
           FOREACH aisp330_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp330_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aisp330_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aisp330_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.isat004
 
           #add-point:rep.a_group.isat004.before name="rep.a_group.isat004.before"
           #總計新台幣(大寫)
           LET l_isat115 = s_num_round('1',sr1.isat115,0)
           CALL s_num_to_chinese(l_isat115) RETURNING l_word_isat115
           PRINTX l_word_isat115
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.isatent CLIPPED ,"'", " AND  ooff003 = '", sr1.isat004 CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aisp330_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aisp330_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aisp330_g01_subrep04
           DECLARE aisp330_g01_repcur04 CURSOR FROM g_sql
           FOREACH aisp330_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aisp330_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aisp330_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aisp330_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.isat004.after name="rep.a_group.isat004.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_isahseq
 
           #add-point:rep.a_group.l_isahseq.before name="rep.a_group.l_isahseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.l_isahseq.after name="rep.a_group.l_isahseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aisp330_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aisp330_g01_subrep01(sr2)
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
PRIVATE REPORT aisp330_g01_subrep02(sr2)
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
PRIVATE REPORT aisp330_g01_subrep03(sr2)
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
PRIVATE REPORT aisp330_g01_subrep04(sr2)
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
 
{<section id="aisp330_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="aisp330_g01.other_report" readonly="Y" >}

 
{</section>}
 
