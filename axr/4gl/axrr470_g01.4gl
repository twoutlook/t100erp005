#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr470_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-12-06 10:25:52), PR版次:0003(2016-12-06 10:29:29)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: axrr470_g01
#+ Description: ...
#+ Creator....: 06821(2016-01-27 13:35:08)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="axrr470_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#151008-00009#9  2016/07/07 By 03538     增加21:銷退沖抵類型
#161104-00049#3  2016/12/05 By 07900     報表輸出的【報表名稱】title,改為依單別名稱輸出
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
   xrepent LIKE xrep_t.xrepent, 
   xreqent LIKE xreq_t.xreqent, 
   xrep001 LIKE xrep_t.xrep001, 
   xrep002 LIKE xrep_t.xrep002, 
   xrepdocno LIKE xrep_t.xrepdocno, 
   xrepsite LIKE xrep_t.xrepsite, 
   l_xrepsite_desc LIKE type_t.chr500, 
   xrep004 LIKE xrep_t.xrep004, 
   xrepdocdt LIKE xrep_t.xrepdocdt, 
   xrepld LIKE xrep_t.xrepld, 
   l_xrepld_desc LIKE type_t.chr500, 
   xreqseq LIKE xreq_t.xreqseq, 
   xreq004 LIKE xreq_t.xreq004, 
   xreq006 LIKE xreq_t.xreq006, 
   xreq010 LIKE xreq_t.xreq010, 
   l_imaal003 LIKE type_t.chr500, 
   xreq008 LIKE xreq_t.xreq008, 
   xreq011 LIKE xreq_t.xreq011, 
   xreq013 LIKE xreq_t.xreq013, 
   l_xreq013_desc LIKE type_t.chr500, 
   xreq100 LIKE xreq_t.xreq100, 
   xreq101 LIKE xreq_t.xreq101, 
   xreq103 LIKE xreq_t.xreq103, 
   xreq113 LIKE xreq_t.xreq113
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
TYPE sr3_r    RECORD  #子報表01
     xreq100  LIKE xreq_t.xreq100, #幣別
     xreq103  LIKE xreq_t.xreq103, #原幣
     xreq113  LIKE xreq_t.xreq113  #本幣
              END RECORD
#end add-point
 
{</section>}
 
{<section id="axrr470_g01.main" readonly="Y" >}
PUBLIC FUNCTION axrr470_g01(p_arg1)
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
   
   LET g_rep_code = "axrr470_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL axrr470_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL axrr470_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL axrr470_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrr470_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr470_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT xrepent,xreqent,xrep001,xrep002,xrepdocno,xrepsite,'',xrep004,xrepdocdt,xrepld, 
       '',xreqseq,xreq004,xreq006,xreq010,'',xreq008,xreq011,xreq013,'',xreq100,xreq101,xreq103,xreq113" 
 
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM xrep_t,xreq_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM xrep_t ",
                " LEFT JOIN xreq_t ON xreqent = xrepent AND xrepdocno = xreqdocno AND xrepld = xreqld "
                
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
  #LET g_where = g_where CLIPPED," AND xreq003 IN ('2','4') "         #151008-00009#9 mark
   LET g_where = g_where CLIPPED," AND xreq003 IN ('2','4','21') "    #151008-00009#9 
   #end add-point
    LET g_order = " ORDER BY xrepdocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xrep_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
 
   #end add-point
   PREPARE axrr470_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE axrr470_g01_curs CURSOR FOR axrr470_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrr470_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrr470_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   xrepent LIKE xrep_t.xrepent, 
   xreqent LIKE xreq_t.xreqent, 
   xrep001 LIKE xrep_t.xrep001, 
   xrep002 LIKE xrep_t.xrep002, 
   xrepdocno LIKE xrep_t.xrepdocno, 
   xrepsite LIKE xrep_t.xrepsite, 
   l_xrepsite_desc LIKE type_t.chr500, 
   xrep004 LIKE xrep_t.xrep004, 
   xrepdocdt LIKE xrep_t.xrepdocdt, 
   xrepld LIKE xrep_t.xrepld, 
   l_xrepld_desc LIKE type_t.chr500, 
   xreqseq LIKE xreq_t.xreqseq, 
   xreq004 LIKE xreq_t.xreq004, 
   xreq006 LIKE xreq_t.xreq006, 
   xreq010 LIKE xreq_t.xreq010, 
   l_imaal003 LIKE type_t.chr500, 
   xreq008 LIKE xreq_t.xreq008, 
   xreq011 LIKE xreq_t.xreq011, 
   xreq013 LIKE xreq_t.xreq013, 
   l_xreq013_desc LIKE type_t.chr500, 
   xreq100 LIKE xreq_t.xreq100, 
   xreq101 LIKE xreq_t.xreq101, 
   xreq103 LIKE xreq_t.xreq103, 
   xreq113 LIKE xreq_t.xreq113
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
    FOREACH axrr470_g01_curs INTO sr_s.*
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
       #品名
       LET sr_s.l_imaal003 = ''
       SELECT imaal003 INTO sr_s.l_imaal003
         FROM imaal_t
        WHERE imaalent = g_enterprise AND imaal002 = g_lang AND imaal001 = sr_s.xreq010
       
       #科目說明
       LET sr_s.l_xreq013_desc = ''
       IF NOT cl_null(sr_s.xreq013) THEN
          LET sr_s.l_xreq013_desc = s_desc_get_account_desc(sr_s.xrepld,sr_s.xreq013)  
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       #帳務中心+說明
       LET sr_s.l_xrepsite_desc = sr_s.xrepsite,".",s_desc_get_department_desc(sr_s.xrepsite)
       
       #帳套+說明
       LET sr_s.l_xrepld_desc = sr_s.xrepld,".",s_desc_get_ld_desc(sr_s.xrepld)
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].xrepent = sr_s.xrepent
       LET sr[l_cnt].xreqent = sr_s.xreqent
       LET sr[l_cnt].xrep001 = sr_s.xrep001
       LET sr[l_cnt].xrep002 = sr_s.xrep002
       LET sr[l_cnt].xrepdocno = sr_s.xrepdocno
       LET sr[l_cnt].xrepsite = sr_s.xrepsite
       LET sr[l_cnt].l_xrepsite_desc = sr_s.l_xrepsite_desc
       LET sr[l_cnt].xrep004 = sr_s.xrep004
       LET sr[l_cnt].xrepdocdt = sr_s.xrepdocdt
       LET sr[l_cnt].xrepld = sr_s.xrepld
       LET sr[l_cnt].l_xrepld_desc = sr_s.l_xrepld_desc
       LET sr[l_cnt].xreqseq = sr_s.xreqseq
       LET sr[l_cnt].xreq004 = sr_s.xreq004
       LET sr[l_cnt].xreq006 = sr_s.xreq006
       LET sr[l_cnt].xreq010 = sr_s.xreq010
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].xreq008 = sr_s.xreq008
       LET sr[l_cnt].xreq011 = sr_s.xreq011
       LET sr[l_cnt].xreq013 = sr_s.xreq013
       LET sr[l_cnt].l_xreq013_desc = sr_s.l_xreq013_desc
       LET sr[l_cnt].xreq100 = sr_s.xreq100
       LET sr[l_cnt].xreq101 = sr_s.xreq101
       LET sr[l_cnt].xreq103 = sr_s.xreq103
       LET sr[l_cnt].xreq113 = sr_s.xreq113
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrr470_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrr470_g01_rep_data()
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
          START REPORT axrr470_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT axrr470_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT axrr470_g01_rep
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
 
{<section id="axrr470_g01.rep" readonly="Y" >}
PRIVATE REPORT axrr470_g01_rep(sr1)
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
DEFINE l_tot_xreq113   LIKE xreq_t.xreq113 #本幣總計
DEFINE sr3  sr3_r
DEFINE l_subrep05_show LIKE type_t.chr1
DEFINE l_oobxl003      LIKE oobxl_t.oobxl003  #161104-00049#3 add
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.xrepdocno,sr1.xreqseq
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
        BEFORE GROUP OF sr1.xrepdocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            CALL s_aooi200_fin_get_slip_desc(sr1.xrepdocno) RETURNING l_oobxl003 #161104-00049#3 add
            LET g_grPageHeader.title0201 = l_oobxl003                            #161104-00049#3 add
            #end add-point:rep.header 
            LET g_rep_docno = sr1.xrepdocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'xrepent=' ,sr1.xrepent,'{+}xrepdocno=' ,sr1.xrepdocno,'{+}xrepld=' ,sr1.xrepld         
            CALL cl_gr_init_apr(sr1.xrepdocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.xrepdocno.before name="rep.b_group.xrepdocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.xrepent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrepdocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr470_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE axrr470_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT axrr470_g01_subrep01
           DECLARE axrr470_g01_repcur01 CURSOR FROM g_sql
           FOREACH axrr470_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr470_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT axrr470_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT axrr470_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.xrepdocno.after name="rep.b_group.xrepdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.xreqseq
 
           #add-point:rep.b_group.xreqseq.before name="rep.b_group.xreqseq.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.xreqseq.after name="rep.b_group.xreqseq.after"
           
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
                sr1.xrepent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrepdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xreqseq CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr470_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE axrr470_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT axrr470_g01_subrep02
           DECLARE axrr470_g01_repcur02 CURSOR FROM g_sql
           FOREACH axrr470_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr470_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT axrr470_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT axrr470_g01_subrep02
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
                sr1.xrepent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrepdocno CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.xreqseq CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr470_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE axrr470_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT axrr470_g01_subrep03
           DECLARE axrr470_g01_repcur03 CURSOR FROM g_sql
           FOREACH axrr470_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr470_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT axrr470_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT axrr470_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xrepdocno
 
           #add-point:rep.a_group.xrepdocno.before name="rep.a_group.xrepdocno.before"
           #本幣總計
           LET l_tot_xreq113 = 0
           LET l_tot_xreq113 = GROUP SUM(sr1.xreq113)
           PRINTX l_tot_xreq113
           
           #各幣別小計
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep05_show = 'N'
              LET g_sql = "SELECT xreq100,SUM(xreq103),SUM(xreq113) ", 
                          "  FROM xreq_t ",
                          " WHERE xreqdocno = '",sr1.xrepdocno CLIPPED,"'",
                          "   AND xreqld  = '",sr1.xrepld  CLIPPED,"'",
                          "   AND xreqent = '",sr1.xrepent   CLIPPED,"'",
                          " GROUP BY xreq100 ",
                          " ORDER BY xreq100 "
                          
           LET l_sub_sql = " SELECT COUNT(*) FROM (",g_sql,")"
           PREPARE axrr470_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE axrr470_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN
              LET l_subrep05_show ="Y"
           END IF
           START REPORT axrr470_g01_subrep05
           DECLARE axrr470_g01_repcur05 CURSOR FROM g_sql
           FOREACH axrr470_g01_repcur05 INTO sr3.*
               OUTPUT TO REPORT axrr470_g01_subrep05(sr3.*)
           END FOREACH
           FINISH REPORT axrr470_g01_subrep05
           PRINTX l_subrep05_show
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
 
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.xrepent CLIPPED ,"'", " AND  ooff003 = '", sr1.xrepdocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE axrr470_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE axrr470_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT axrr470_g01_subrep04
           DECLARE axrr470_g01_repcur04 CURSOR FROM g_sql
           FOREACH axrr470_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "axrr470_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT axrr470_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT axrr470_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.xrepdocno.after name="rep.a_group.xrepdocno.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.xreqseq
 
           #add-point:rep.a_group.xreqseq.before name="rep.a_group.xreqseq.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.xreqseq.after name="rep.a_group.xreqseq.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="axrr470_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT axrr470_g01_subrep01(sr2)
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
PRIVATE REPORT axrr470_g01_subrep02(sr2)
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
PRIVATE REPORT axrr470_g01_subrep03(sr2)
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
PRIVATE REPORT axrr470_g01_subrep04(sr2)
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
 
{<section id="axrr470_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="axrr470_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 幣別小計
# Memo...........:
# Usage..........: CALL axrr470_g01_subrep05(sr3)
# Date & Author..: 160127 By Jessy
# Modify.........:
################################################################################
PRIVATE REPORT axrr470_g01_subrep05(sr3)
DEFINE sr3 sr3_r

   FORMAT
           
        ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 
