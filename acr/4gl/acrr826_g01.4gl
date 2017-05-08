#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr826_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-05-05 16:54:10), PR版次:0001(2016-05-05 17:50:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: acrr826_g01
#+ Description: ...
#+ Creator....: 02003(2016-02-17 15:29:53)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="acrr826_g01.global" readonly="Y" >}
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
   crdeent LIKE crde_t.crdeent, 
   l_sum_8 LIKE type_t.num20_6, 
   l_sum_7 LIKE type_t.num20_6, 
   crde007 LIKE crde_t.crde007, 
   l_sum0 LIKE type_t.num20_6, 
   l_sum6 LIKE type_t.num20_6, 
   l_sum5 LIKE type_t.num20_6, 
   l_sum4 LIKE type_t.num20_6, 
   l_sum3 LIKE type_t.num20_6, 
   l_sum2 LIKE type_t.num20_6, 
   l_sum1 LIKE type_t.num20_6
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       sel STRING,                  #统计类型 
       year LIKE crde_t.crde002,         #年度 
       mm LIKE crde_t.crde003,         #月份 
       crde LIKE crde_t.crde002,         #年度 
       week LIKE decb_t.decb003          #週別
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
   series STRING,
   x      STRING,
   y      like type_t.num20_6
END RECORD
#end add-point
 
{</section>}
 
{<section id="acrr826_g01.main" readonly="Y" >}
PUBLIC FUNCTION acrr826_g01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.sel  统计类型 
DEFINE  p_arg3 LIKE crde_t.crde002         #tm.year  年度 
DEFINE  p_arg4 LIKE crde_t.crde003         #tm.mm  月份 
DEFINE  p_arg5 LIKE crde_t.crde002         #tm.crde  年度 
DEFINE  p_arg6 LIKE decb_t.decb003         #tm.week  週別
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.sel = p_arg2
   LET tm.year = p_arg3
   LET tm.mm = p_arg4
   LET tm.crde = p_arg5
   LET tm.week = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "acrr826_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL acrr826_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL acrr826_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL acrr826_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr826_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr826_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   CALL acrr826_g01_into_tmp()
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT crdeent,NULL,NULL,crde007,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT DISTINCT crdeent,NULL,NULL,crde007,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
   #end add-point
    LET g_from = " FROM crde_t,ooga_t,decb_t,rtab_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM acrr826_tmp "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE crde007 IS NOT NULL " 
   #end add-point
    LET g_order = " ORDER BY crdeent,crde007"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("crde_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE acrr826_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE acrr826_g01_curs CURSOR FOR acrr826_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr826_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr826_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   crdeent LIKE crde_t.crdeent, 
   l_sum_8 LIKE type_t.num20_6, 
   l_sum_7 LIKE type_t.num20_6, 
   crde007 LIKE crde_t.crde007, 
   l_sum0 LIKE type_t.num20_6, 
   l_sum6 LIKE type_t.num20_6, 
   l_sum5 LIKE type_t.num20_6, 
   l_sum4 LIKE type_t.num20_6, 
   l_sum3 LIKE type_t.num20_6, 
   l_sum2 LIKE type_t.num20_6, 
   l_sum1 LIKE type_t.num20_6
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
    FOREACH acrr826_g01_curs INTO sr_s.*
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
       IF tm.sel = '1' THEN 
          SELECT SUM(decb012) INTO sr_s.l_sum0
            FROM acrr826_tmp
           WHERE ooga002 = '0'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb012) INTO sr_s.l_sum1
            FROM acrr826_tmp
           WHERE ooga002 = '1'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb012) INTO sr_s.l_sum2
            FROM acrr826_tmp
           WHERE ooga002 = '2'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb012) INTO sr_s.l_sum3
            FROM acrr826_tmp
           WHERE ooga002 = '3'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb012) INTO sr_s.l_sum4
            FROM acrr826_tmp
           WHERE ooga002 = '4'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb012) INTO sr_s.l_sum5
            FROM acrr826_tmp
           WHERE ooga002 = '5'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb012) INTO sr_s.l_sum6
            FROM acrr826_tmp
           WHERE ooga002 = '6'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb012) INTO sr_s.l_sum_8
            FROM acrr826_tmp
           WHERE ooga002 IN('1','2','3','4','5','6','0')
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
       END IF 
       IF tm.sel = '2' THEN 
          SELECT SUM(decb013) INTO sr_s.l_sum0
            FROM acrr826_tmp
           WHERE ooga002 = '0'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb013) INTO sr_s.l_sum1
            FROM acrr826_tmp
           WHERE ooga002 = '1'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb013) INTO sr_s.l_sum2
            FROM acrr826_tmp
           WHERE ooga002 = '2'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb013) INTO sr_s.l_sum3
            FROM acrr826_tmp
           WHERE ooga002 = '3'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb013) INTO sr_s.l_sum4
            FROM acrr826_tmp
           WHERE ooga002 = '4'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb013) INTO sr_s.l_sum5
            FROM acrr826_tmp
           WHERE ooga002 = '5'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb013) INTO sr_s.l_sum6
            FROM acrr826_tmp
           WHERE ooga002 = '6'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb013) INTO sr_s.l_sum_8
            FROM acrr826_tmp
           WHERE ooga002 IN('1','2','3','4','5','6','0')
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
       END IF 
       IF tm.sel = '3' THEN 
          SELECT SUM(decb016_1) INTO sr_s.l_sum0
            FROM acrr826_tmp
           WHERE ooga002 = '0'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_1) INTO sr_s.l_sum1
            FROM acrr826_tmp
           WHERE ooga002 = '1'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_1) INTO sr_s.l_sum2
            FROM acrr826_tmp
           WHERE ooga002 = '2'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_1) INTO sr_s.l_sum3
            FROM acrr826_tmp
           WHERE ooga002 = '3'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_1) INTO sr_s.l_sum4
            FROM acrr826_tmp
           WHERE ooga002 = '4'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_1) INTO sr_s.l_sum5
            FROM acrr826_tmp
           WHERE ooga002 = '5'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_1) INTO sr_s.l_sum6
            FROM acrr826_tmp
           WHERE ooga002 = '6'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_1) INTO sr_s.l_sum_8
            FROM acrr826_tmp
           WHERE ooga002 IN('1','2','3','4','5','6','0')
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
       END IF 
       IF tm.sel = '4' THEN 
          SELECT SUM(decb016_2) INTO sr_s.l_sum0
            FROM acrr826_tmp
           WHERE ooga002 = '0'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_2) INTO sr_s.l_sum1
            FROM acrr826_tmp
           WHERE ooga002 = '1'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_2) INTO sr_s.l_sum2
            FROM acrr826_tmp
           WHERE ooga002 = '2'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_2) INTO sr_s.l_sum3
            FROM acrr826_tmp
           WHERE ooga002 = '3'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_2) INTO sr_s.l_sum4
            FROM acrr826_tmp
           WHERE ooga002 = '4'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_2) INTO sr_s.l_sum5
            FROM acrr826_tmp
           WHERE ooga002 = '5'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_2) INTO sr_s.l_sum6
            FROM acrr826_tmp
           WHERE ooga002 = '6'
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
          SELECT SUM(decb016_2) INTO sr_s.l_sum_8
            FROM acrr826_tmp
           WHERE ooga002 IN('1','2','3','4','5','6','0')
             AND crdeent = sr_s.crdeent
             AND crde007 = sr_s.crde007
       END IF 
       IF cl_null(sr_s.l_sum0) THEN
          LET sr_s.l_sum0 = 0
       END IF
       IF cl_null(sr_s.l_sum1) THEN
          LET sr_s.l_sum1 = 0
       END IF
       IF cl_null(sr_s.l_sum2) THEN
          LET sr_s.l_sum2 = 0
       END IF
       IF cl_null(sr_s.l_sum3) THEN
          LET sr_s.l_sum3 = 0
       END IF
       IF cl_null(sr_s.l_sum4) THEN
          LET sr_s.l_sum4 = 0
       END IF
       IF cl_null(sr_s.l_sum5) THEN
          LET sr_s.l_sum5 = 0
       END IF
       IF cl_null(sr_s.l_sum6) THEN
          LET sr_s.l_sum6 = 0
       END IF
       IF cl_null(sr_s.l_sum_8) THEN
          LET sr_s.l_sum_8 = 0
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].crdeent = sr_s.crdeent
       LET sr[l_cnt].l_sum_8 = sr_s.l_sum_8
       LET sr[l_cnt].l_sum_7 = sr_s.l_sum_7
       LET sr[l_cnt].crde007 = sr_s.crde007
       LET sr[l_cnt].l_sum0 = sr_s.l_sum0
       LET sr[l_cnt].l_sum6 = sr_s.l_sum6
       LET sr[l_cnt].l_sum5 = sr_s.l_sum5
       LET sr[l_cnt].l_sum4 = sr_s.l_sum4
       LET sr[l_cnt].l_sum3 = sr_s.l_sum3
       LET sr[l_cnt].l_sum2 = sr_s.l_sum2
       LET sr[l_cnt].l_sum1 = sr_s.l_sum1
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr826_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr826_g01_rep_data()
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
          START REPORT acrr826_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT acrr826_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT acrr826_g01_rep
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
 
{<section id="acrr826_g01.rep" readonly="Y" >}
PRIVATE REPORT acrr826_g01_rep(sr1)
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
DEFINE l_sum1         LIKE type_t.num20_6
DEFINE l_sum2         LIKE type_t.num20_6
DEFINE l_sum3         LIKE type_t.num20_6
DEFINE l_sum4         LIKE type_t.num20_6
DEFINE l_sum5         LIKE type_t.num20_6
DEFINE l_sum6         LIKE type_t.num20_6
DEFINE l_sum7         LIKE type_t.num20_6
DEFINE l_sum8         LIKE type_t.num20_6
DEFINE sr3            sr3_r
DEFINE l_i            LIKE type_t.num10
DEFINE i              LIKE type_t.num10
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER EXTERNAL BY sr1.crdeent,sr1.crde007
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
        BEFORE GROUP OF sr1.crdeent
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.crdeent
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'crdeent=' ,sr1.crdeent         
            CALL cl_gr_init_apr(sr1.crdeent)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.crdeent.before name="rep.b_group.crdeent.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.crdeent CLIPPED ,"'", " AND  ooff003 = '", sr1.crdeent CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr826_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE acrr826_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT acrr826_g01_subrep01
           DECLARE acrr826_g01_repcur01 CURSOR FROM g_sql
           FOREACH acrr826_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr826_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT acrr826_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT acrr826_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.crdeent.after name="rep.b_group.crdeent.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.crde007
 
           #add-point:rep.b_group.crde007.before name="rep.b_group.crde007.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.crde007.after name="rep.b_group.crde007.after"
           
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
                sr1.crdeent CLIPPED ,"'", " AND  ooff003 = '", sr1.crdeent CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.crde007 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr826_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE acrr826_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT acrr826_g01_subrep02
           DECLARE acrr826_g01_repcur02 CURSOR FROM g_sql
           FOREACH acrr826_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr826_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT acrr826_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT acrr826_g01_subrep02
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
                sr1.crdeent CLIPPED ,"'", " AND  ooff003 = '", sr1.crdeent CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.crde007 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr826_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE acrr826_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT acrr826_g01_subrep03
           DECLARE acrr826_g01_repcur03 CURSOR FROM g_sql
           FOREACH acrr826_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr826_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT acrr826_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT acrr826_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.crdeent
 
           #add-point:rep.a_group.crdeent.before name="rep.a_group.crdeent.before"
           LET l_sum1 = GROUP SUM(sr1.l_sum1)
           LET l_sum2 = GROUP SUM(sr1.l_sum2)
           LET l_sum3 = GROUP SUM(sr1.l_sum3)
           LET l_sum4 = GROUP SUM(sr1.l_sum4)
           LET l_sum5 = GROUP SUM(sr1.l_sum5)
           LET l_sum6 = GROUP SUM(sr1.l_sum6)
           LET l_sum7 = GROUP SUM(sr1.l_sum0)
           LET l_sum8 = GROUP SUM(sr1.l_sum_8)
           PRINTX l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6,l_sum7,l_sum8
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.crdeent CLIPPED ,"'", " AND  ooff003 = '", sr1.crdeent CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE acrr826_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE acrr826_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT acrr826_g01_subrep04
           DECLARE acrr826_g01_repcur04 CURSOR FROM g_sql
           FOREACH acrr826_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "acrr826_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT acrr826_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT acrr826_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           START REPORT acrr826_g01_subrep05
              LET sr3.series = "A类会员"
              FOR l_i = 1 TO 7
                 CASE l_i
                      WHEN '1'     LET sr3.x = "星期一"
                                   LET sr3.y = sr1.l_sum1
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'A' THEN 
                                         LET sr3.y = sr[i].l_sum1
                                      END IF 
                                   END FOR
                      WHEN '2'     LET sr3.x = "星期二"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'A' THEN 
                                         LET sr3.y = sr[i].l_sum2
                                      END IF 
                                   END FOR
                      WHEN '3'     LET sr3.x = "星期三"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'A' THEN 
                                         LET sr3.y = sr[i].l_sum3
                                      END IF 
                                   END FOR
                      WHEN '4'     LET sr3.x = "星期四"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'A' THEN 
                                         LET sr3.y = sr[i].l_sum4
                                      END IF 
                                   END FOR
                      WHEN '5'     LET sr3.x = "星期五"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'A' THEN 
                                         LET sr3.y = sr[i].l_sum5
                                      END IF 
                                   END FOR
                      WHEN '6'     LET sr3.x = "星期六"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'A' THEN 
                                         LET sr3.y = sr[i].l_sum6
                                      END IF 
                                   END FOR
                      WHEN '7'     LET sr3.x = "星期日"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'A' THEN 
                                         LET sr3.y = sr[i].l_sum0
                                      END IF 
                                   END FOR
                 END CASE 
                 IF cl_null(sr3.y) THEN 
                    LET sr3.y = 0
                 END IF 
                 OUTPUT TO REPORT acrr826_g01_subrep05(sr3.*)
              END FOR
              LET sr3.series = "B类会员"
              FOR l_i = 1 TO 7
                 CASE l_i
                      WHEN '1'     LET sr3.x = "星期一"
                                   LET sr3.y = sr1.l_sum1
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'B' THEN 
                                         LET sr3.y = sr[i].l_sum1
                                      END IF 
                                   END FOR
                      WHEN '2'     LET sr3.x = "星期二"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'B' THEN 
                                         LET sr3.y = sr[i].l_sum2
                                      END IF 
                                   END FOR
                      WHEN '3'     LET sr3.x = "星期三"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'B' THEN 
                                         LET sr3.y = sr[i].l_sum3
                                      END IF 
                                   END FOR
                      WHEN '4'     LET sr3.x = "星期四"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'B' THEN 
                                         LET sr3.y = sr[i].l_sum4
                                      END IF 
                                   END FOR
                      WHEN '5'     LET sr3.x = "星期五"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'B' THEN 
                                         LET sr3.y = sr[i].l_sum5
                                      END IF 
                                   END FOR
                      WHEN '6'     LET sr3.x = "星期六"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'B' THEN 
                                         LET sr3.y = sr[i].l_sum6
                                      END IF 
                                   END FOR
                      WHEN '7'     LET sr3.x = "星期日"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'B' THEN 
                                         LET sr3.y = sr[i].l_sum0
                                      END IF 
                                   END FOR
                 END CASE 
                 IF cl_null(sr3.y) THEN 
                    LET sr3.y = 0
                 END IF 
                 OUTPUT TO REPORT acrr826_g01_subrep05(sr3.*)
              END FOR
              LET sr3.series = "C类会员"
              FOR l_i = 1 TO 7
                 CASE l_i
                      WHEN '1'     LET sr3.x = "星期一"
                                   LET sr3.y = sr1.l_sum1
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'C' THEN 
                                         LET sr3.y = sr[i].l_sum1
                                      END IF 
                                   END FOR
                      WHEN '2'     LET sr3.x = "星期二"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'C' THEN 
                                         LET sr3.y = sr[i].l_sum2
                                      END IF 
                                   END FOR
                      WHEN '3'     LET sr3.x = "星期三"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'C' THEN 
                                         LET sr3.y = sr[i].l_sum3
                                      END IF 
                                   END FOR
                      WHEN '4'     LET sr3.x = "星期四"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'C' THEN 
                                         LET sr3.y = sr[i].l_sum4
                                      END IF 
                                   END FOR
                      WHEN '5'     LET sr3.x = "星期五"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'C' THEN 
                                         LET sr3.y = sr[i].l_sum5
                                      END IF 
                                   END FOR
                      WHEN '6'     LET sr3.x = "星期六"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'C' THEN 
                                         LET sr3.y = sr[i].l_sum6
                                      END IF 
                                   END FOR
                      WHEN '7'     LET sr3.x = "星期日"
                                   FOR i = 1 TO sr.getLength()
                                      IF sr[i].crde007 = 'C' THEN 
                                         LET sr3.y = sr[i].l_sum0
                                      END IF 
                                   END FOR
                 END CASE 
                 IF cl_null(sr3.y) THEN 
                    LET sr3.y = 0
                 END IF 
                 OUTPUT TO REPORT acrr826_g01_subrep05(sr3.*)
              END FOR
           FINISH REPORT acrr826_g01_subrep05
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.crdeent.after name="rep.a_group.crdeent.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.crde007
 
           #add-point:rep.a_group.crde007.before name="rep.a_group.crde007.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.crde007.after name="rep.a_group.crde007.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="acrr826_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT acrr826_g01_subrep01(sr2)
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
PRIVATE REPORT acrr826_g01_subrep02(sr2)
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
PRIVATE REPORT acrr826_g01_subrep03(sr2)
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
PRIVATE REPORT acrr826_g01_subrep04(sr2)
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
 
{<section id="acrr826_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 插入临时表
# Memo...........:
# Usage..........: CALL acrr826_g01_into_tmp()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2016/02/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr826_g01_into_tmp()
DEFINE l_sql   STRING 

   DROP TABLE acrr826_tmp;
   CREATE TEMP TABLE acrr826_tmp(
   crdeent   LIKE crde_t.crdeent,
   ooga002   LIKE ooga_t.ooga002,
   crde007   LIKE crde_t.crde007,    #ABC分类
   decb012   LIKE decb_t.decb012,    #应收金额
   decb016_1   LIKE decb_t.decb016,  #客单量
   decb016_2   LIKE decb_t.decb012,  #客单价
   decb013   LIKE decb_t.decb013     #毛利
   );
   
   LET l_sql = " INSERT INTO acrr826_tmp ",
               " SELECT DISTINCT crdeent,ooga002,crde007,decb012,(decb007/decb016) decb016_1,(decb012/decb016) decb016_2,decb013 ",
               "   FROM crde_t, ooga_t, decb_t, rtab_t",
               "  WHERE ",tm.wc CLIPPED,
               "    AND ",s_aooi500_sql_where(g_prog,'decbsite'),
               "    AND decbent = rtabent AND decbsite = rtab002 ",
               "    AND decbent = crdeent AND decb005 = crde001 ",
               "    AND decbent = oogaent AND ooga001 = decb002 ",
               "    AND crde002 = ",tm.year," AND crde003 = ",tm.mm," ",
               "    AND decbent = ",g_enterprise,
               "    AND crde004 = decb006 ",
               "    AND to_char(decb002,'YYYY') = trim('",tm.crde,"') ",
               "    AND decb003 = ",tm.week," ",
               #"    AND crde003 = decb004 ",
               "    AND decb016 <> 0 ",
               "    AND crde007 IS NOT NULL "         
   PREPARE ins_tmp FROM l_sql
   EXECUTE ins_tmp

END FUNCTION

 
{</section>}
 
{<section id="acrr826_g01.other_report" readonly="Y" >}

################################################################################

################################################################################
PRIVATE REPORT acrr826_g01_subrep05(sr3)
DEFINE  sr3  sr3_r
 
    FORMAT
    
       ON EVERY ROW
 
            PRINTX sr3.*
END REPORT

 
{</section>}
 
