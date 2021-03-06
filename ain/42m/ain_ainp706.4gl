#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp706.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-12-12 17:49:21), PR版次:0002(2017-01-10 16:07:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: ainp706
#+ Description: 入庫批次裝箱作業
#+ Creator....: 06137(2016-12-07 17:41:58)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="ainp706.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#170104-00068#3  2017/01/05 By 06137     3.1ainp706增加考虑子件特性<>8.委外代买的部分才产生装箱单，详见分镜，
#170104-00068#3  2017/01/10 By 06137     3.2ainp706增加背景排程作业，可以根据来源类型设置背景作业
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
 
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel             LIKE type_t.chr1,
     inbm008         LIKE inbm_t.inbm008,
     inbm001         LIKE inbm_t.inbm001,
     inbm001_desc    LIKE ooefl_t.ooefl003,
     inbm003         LIKE inbm_t.inbm003,
     inbm004         LIKE inbm_t.inbm004,
     docdt           LIKE inbm_t.inbmdocdt,
     inbm007         LIKE inbm_t.inbm007,
     inbm005         LIKE inbm_t.inbm005,   
     inbm005_desc    LIKE ooag_t.ooag011,
     inbm006         LIKE inbm_t.inbm006,
     inbm006_desc    LIKE ooefl_t.ooefl003,
     qty             LIKE inbp_t.inbp008,
     stus            LIKE inbm_t.inbmstus
                     END RECORD
                     
TYPE type_g_detail2_d RECORD   
     inbp003         LIKE inbp_t.inbp003,
     inbp004         LIKE inbp_t.inbp004,
     inbp005         LIKE inbp_t.inbp005,
     inbp005_desc    LIKE imaal_t.imaal003,
     inbp005_desc_1  LIKE imaal_t.imaal004,
     inbp006         LIKE inbp_t.inbp006,  
     inbp006_desc    LIKE type_t.chr500,     
     inbp007         LIKE inbp_t.inbp007,
     inbp007_desc    LIKE oocal_t.oocal003,
     inbp008         LIKE inbp_t.inbp008
                     END RECORD
DEFINE g_detail2_cnt         LIKE type_t.num5      
DEFINE g_detail2_d           DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_cnt1                LIKE type_t.num10     
DEFINE g_deteal_cnt          LIKE type_t.num10     
DEFINE g_aw                  STRING                        #確定當下點擊的單身 
DEFINE g_detail_d_t          type_g_detail_d
DEFINE g_slip_wc             STRING
DEFINE g_wc1                 STRING
DEFINE g_default_flag        LIKE type_t.num5
DEFINE g_tmp_ins_flag        LIKE type_t.num5
DEFINE g_log                 STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_inbm008    LIKE inbm_t.inbm008
DEFINE g_inbm003    LIKE inbm_t.inbm003
#end add-point
 
{</section>}
 
{<section id="ainp706.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE li_p01_status    LIKE type_t.num5
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #170104-00068#3 Add By ken 170110(S)
      LET ls_js = g_argv[01]
      DISPLAY "ls_js:",ls_js
      CALL ainp706_create_tmp() RETURNING l_success
      CALL ainp706_bgjob_process(ls_js)
      LET li_p01_status = 1
      CALL cl_schedule_exec_call(li_p01_status)
      LET g_msgparam.state = "process"
      CALL cl_msgcentre_notify()      
      #CALL ainp706_drop_tmp() RETURNING l_success      
      #170104-00068#3 Add By ken 170110(E)
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp706 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainp706_init()   
 
      #進入選單 Menu (="N")
      CALL ainp706_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp706
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL ainp706_drop_tmp() RETURNING l_success
   display "ainp706 finish "   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp706.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ainp706_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_session_id    LIKE type_t.num20
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_inbm008','6968')
   CALL cl_set_combo_scc_part('l_stus','6982','N,Y')
   CALL cl_set_combo_scc_part('b_inbm003','6977','5,6,7,8')
   CALL ainp706_create_tmp() RETURNING l_success  
   
   
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "------------------------------"
   DISPLAY "SessionId: ",l_session_id   
   DISPLAY "------------------------------"     
   LET g_default_flag = TRUE
   LET g_tmp_ins_flag = TRUE    #如果為TRUE  則將查詢的資料寫入tmp，FALSE的話直接從tmp查詢顯示
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp706.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp706_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt    LIKE type_t.num10
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ainp706_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.* 
            ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,DELETE ROW = FALSE, APPEND ROW = FALSE)         

            BEFORE INPUT
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               CALL ainp706_set_entry()
               CALL ainp706_set_no_entry()               
               
    
            BEFORE ROW
               #顯示單身筆數
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               IF g_detail_idx > g_detail_d.getLength() THEN
                  LET g_detail_idx = g_detail_d.getLength()
               END IF
               IF g_detail_idx = 0 AND g_detail_d.getLength() <> 0 THEN
                  LET g_detail_idx = 1
               END IF
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               CALL ainp706_fetch()
               CALL ainp706_set_entry()
               CALL ainp706_set_no_entry()  

         ON CHANGE l_sel
            UPDATE ainp706_tmp SET sel = g_detail_d[g_detail_idx].sel 
             WHERE inbm003 = g_detail_d[g_detail_idx].inbm003
               AND inbm004 = g_detail_d[g_detail_idx].inbm004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update ainp706_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
             

                         
         END INPUT
         DISPLAY ARRAY g_detail2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 2
               CALL cl_set_act_visible("filter",FALSE)
               
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            IF g_default_flag THEN
               CALL ainp706_b_fill()   
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            UPDATE ainp706_tmp SET sel = 'Y' 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update ainp706_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            UPDATE ainp706_tmp SET sel = 'N' 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update ainp706_tmp'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF          
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN            
                  UPDATE ainp706_tmp SET sel = 'Y' 
                   WHERE inbm003 = g_detail_d[li_idx].inbm003
                     AND inbm004 = g_detail_d[li_idx].inbm004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'update ainp706_tmp'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               END IF
            END FOR           
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN                  
                  UPDATE ainp706_tmp SET sel = 'N' 
                   WHERE inbm003 = g_detail_d[li_idx].inbm003
                     AND inbm004 = g_detail_d[li_idx].inbm004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'update ainp706_tmp'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               END IF
            END FOR                  
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainp706_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL ainp706_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL ainp706_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION query_1
            CALL ainp706_construct()
            CALL ainp706_set_entry()
            CALL ainp706_set_no_entry()            
            
         ON ACTION batch_execute 
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt
              FROM ainp706_tmp 
             WHERE sel='Y'
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00858'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()               
               CONTINUE DIALOG 
            END IF
            CALL cl_err_collect_init() 
            CALL s_transaction_begin()
            IF NOT ainp706_process() THEN
               CALL s_transaction_end('N','0')            
            ELSE
               CALL s_transaction_end('Y','1')            
            END IF
            CALL cl_err_collect_show()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainp706.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ainp706_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL ainp706_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp706.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainp706_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   DEFINE l_sql3          STRING
   DEFINE l_sql4          STRING
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_inbm003       LIKE inbm_t.inbm003
   DEFINE l_inbm004       LIKE inbm_t.inbm004
   DEFINE l_stus          LIKE inbm_t.inbmstus
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN
      LET g_wc = ' 1=1'
   END IF
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = ' 1=1'
   END IF   
      
   #檢查是否存在裝箱單明細的語法(並且裝箱單狀態非作廢)
   LET l_sql = " SELECT COUNT(1) FROM inbm_t,inbp_t ",
               "  WHERE inbment = inbpent ",
               "    AND inbmdocno = inbpdocno ",
               "    AND inbment = ",g_enterprise,
               "    AND inbmstus != 'X' ",
               "    AND inbp002 = ? "
   PREPARE ainp706_inbp_cnt FROM l_sql
   
   #檢查是否存在apmt571
   LET l_sql = " SELECT COUNT(1) FROM pmds_t ",
               "  WHERE pmdsent = ",g_enterprise,
               "    AND pmds000='12' ",
               "    AND pmdsstus != 'X' ",
               "    AND pmds006=? "
   PREPARE ainp706_apmt571_cnt FROM l_sql
   
   #檢查是否存在apmt570
   LET l_sql = " SELECT COUNT(1) FROM pmds_t ",
               "  WHERE pmdsent = ",g_enterprise,
               "    AND pmds000='6' ",
               "    AND pmdsstus != 'X' ",
               "    AND pmds006=? "
   PREPARE ainp706_apmt570_cnt FROM l_sql
   
   #(aint513)檢查調撥單狀態是否為撥入確認或結案
   LET l_sql = " SELECT COUNT(1) FROM indc_t ",
               "  WHERE indcent = ",g_enterprise,
               "    AND indc199 = '3' AND indc000 = '2' ",
               "    AND indcstus IN ('P','C') ",
               "    AND indcdocno = ? "
   PREPARE ainp706_aint513_cnt FROM l_sql
   
   #(adbt600)查詢狀態是否已過帳
   LET l_sql = " SELECT COUNT(1) FROM xmdk_t ",
               "  WHERE xmdkent = ",g_enterprise,
               "    AND xmdk000 = '6' ",
               "    AND xmdkstus = 'S' ",
               "    AND xmdkdocno = ? "
   PREPARE ainp706_adbt600_cnt FROM l_sql
   
   #Update 拋單狀態(tmp)
   LET l_sql = "Update ainp706_tmp ",
               "   SET stus = 'Y' ",
               " WHERE inbm003 = ? ",
               "   AND inbm004 = ? "
   PREPARE ainp706_upd_tmp FROM l_sql
   
   #apmt521
   LET l_sql1 ="        SELECT pmdsent inbment,'3' inbm008,pmds007 inbm001,pmaal003 inbm001_desc,'5' inbm003, ",
               "               pmdsdocno inbm004,pmdsdocdt docdt, ",
               "               pmds045 inbm007,pmds002 inbm005,pmds003 inbm006,COALESCE(SUM(pmdt020),0) qty ",
               "          FROM pmds_t x1 LEFT JOIN pmaal_t ON pmdsent = pmaalent AND pmds007 = pmaal001 AND pmaal002 ='"||g_dlang||"', ",
               "               pmdt_t ",
               "         WHERE pmdsent = pmdtent ",
               "           AND pmdsdocno = pmdtdocno ",
               "           AND pmds000 ='8' AND pmdsstus <>'X' AND pmdsstus<>'N' ",
               "           AND pmdt005 <> '8' "   #170104-00068#3 Add By Ken 170105
                IF g_default_flag THEN
                   LET l_sql1 = l_sql1 , "AND NOT EXISTS(SELECT 1 FROM inbp_t WHERE pmdsent=inbpent AND pmdsdocno=inbp002) ",
                                         "AND NOT EXISTS(SELECT 1 FROM pmds_t t1 WHERE x1.pmdsent=t1.pmdsent AND x1.pmdsdocno=t1.pmds006 AND t1.pmds000='12' ) "
                END IF
                LET l_sql1 = l_sql1 ,               
               "      GROUP BY pmdsent,pmds007,pmaal003,pmdsdocno,pmdsdocdt,pmds045,pmds002,pmds003 "
               
   #apmt520
   LET l_sql2 ="        SELECT pmdsent inbment,'3' inbm008,pmds007 inbm001,pmaal003 inbm001_desc,'8' inbm003, ",
               "               pmdsdocno inbm004,pmdsdocdt docdt, ",
               "               pmds045 inbm007,pmds002 inbm005,pmds003 inbm006,COALESCE(SUM(pmdt020),0) qty ",
               "          FROM pmds_t x1 LEFT JOIN pmaal_t ON pmdsent = pmaalent AND pmds007 = pmaal001 AND pmaal002 ='"||g_dlang||"', ",
               "               pmdt_t ",
               "         WHERE pmdsent = pmdtent ",
               "           AND pmdsdocno = pmdtdocno ",
               "           AND pmds000 ='1' AND pmdsstus <>'X' AND pmdsstus<>'N' ",
               "           AND pmdt005 <> '8' "   #170104-00068#3 Add By Ken 170105
                IF g_default_flag THEN
                   LET l_sql2 = l_sql2 , "AND NOT EXISTS(SELECT 1 FROM inbp_t WHERE pmdsent=inbpent AND pmdsdocno=inbp002) ",
                                         "AND NOT EXISTS(SELECT 1 FROM pmds_t t1 WHERE x1.pmdsent=t1.pmdsent AND x1.pmdsdocno=t1.pmds006 AND t1.pmds000='6' ) "
                END IF
                LET l_sql2 = l_sql2 ,               
               "      GROUP BY pmdsent,pmds007,pmaal003,pmdsdocno,pmdsdocdt,pmds045,pmds002,pmds003 "
   #aint513
   LET l_sql3 ="        SELECT indcent inbment,'1' inbm008,indc005 inbm001,ooefl003 inbm001_desc,'6' inbm003, ",
               "               indcdocno inbm004,indcdocdt docdt, ",
               "               indc008 inbm007,indc004 inbm005,indc101 inbm006,COALESCE(SUM(indd021),0) qty ",
               "          FROM indc_t LEFT JOIN ooefl_t ON indcent = ooeflent AND indc005 = ooefl001 AND ooefl002 ='"||g_dlang||"', ",
               "               indd_t ",
               "         WHERE indcent = inddent ",
               "           AND indcdocno = indddocno ",
               "           AND indc199 = '3' AND indcstus<>'X' AND indcstus<>'N' ",
               "           AND indc000 = '2' "
                IF g_default_flag THEN
                   LET l_sql3 = l_sql3 , "AND NOT EXISTS(SELECT 1 FROM inbp_t WHERE indcent=inbpent AND indcdocno=inbp002) ",
                                         "AND indcstus<>'C' AND indcstus<>'P' "
                END IF
                LET l_sql3 = l_sql3 ,                
               "      GROUP BY indcent,indc005,ooefl003,indcdocno,indcdocdt,indc008,indc004,indc101 "
               
   #adbt600
   LET l_sql4 ="        SELECT xmdkent inbment, '2' inbm008,xmdk007 inbm001,pmaal003 inbm001_desc,'7' inbm003, ",
               "               xmdkdocno inbm004,xmdkdocdt docdt, ",
               "               xmdk054 inbm007,xmdk003 inbm005,xmdk004 inbm006,COALESCE(SUM(xmdl059),0) qty ",
               "          FROM xmdk_t LEFT JOIN pmaal_t ON xmdkent = pmaalent AND xmdk007 = pmaal001 AND pmaal002 ='"||g_dlang||"', ",
               "               xmdl_t ",
               "         WHERE xmdkent = xmdlent ",
               "           AND xmdkdocno = xmdldocno ",
               "           AND xmdk000 = '6' AND xmdkstus<>'X' AND xmdkstus<>'N' "
                IF g_default_flag THEN
                   LET l_sql4 = l_sql4 , "AND NOT EXISTS(SELECT 1 FROM inbp_t WHERE xmdkent=inbpent AND xmdkdocno=inbp002) ",
                                         "AND xmdkstus<>'S' "
                END IF
                LET l_sql4 = l_sql4 ,                
               "        GROUP BY xmdkent,xmdk007,pmaal003,xmdkdocno,xmdkdocdt,xmdk054,xmdk003,xmdk004 "
   
   LET g_sql = "SELECT inbment,'N',    inbm008, inbm001,inbm001_desc,   inbm003, ",
               "       inbm004,docdt,  inbm007,inbm005,        ooag011, ",
               "       inbm006,ooefl003,COALESCE(qty,0),'N' ",
               "  FROM ",
               " (" ,l_sql1,
               " UNION ",l_sql2," UNION ",l_sql3," UNION ",l_sql4, 
               "  ) ",
               " LEFT JOIN ooag_t ON inbment = ooagent AND inbm005 = ooag001 ",
               " LEFT JOIN ooefl_t ON inbment = ooeflent AND inbm006 = ooefl001 AND ooefl002 ='"||g_dlang||"' ", 
               " WHERE inbment = ",g_enterprise,
               "   AND ",g_wc CLIPPED,
               " ORDER BY inbm003,inbm001,inbm004 "
   #DISPLAY "g_sql:",g_sql
   IF g_tmp_ins_flag THEN
      CALL ainp706_ins_tmp(g_sql) 
   END IF
      
   IF NOT g_default_flag THEN
      #查詢顯示前先把tmp table的拋單狀態寫入
      LET l_sql = "SELECT inbm003,inbm004 ",
                  "  FROM ainp706_tmp ",
                  " ORDER BY inbm003,inbm004 "
      PREPARE ainp706_inbm_pre FROM l_sql
      DECLARE ainp706_inbm_cur CURSOR FOR ainp706_inbm_pre 
      FOREACH ainp706_inbm_cur INTO l_inbm003,l_inbm004
         #檢查是否存在aint701裝箱單
         LET l_cnt = 0
         EXECUTE ainp706_inbp_cnt USING l_inbm004 INTO l_cnt
         IF l_cnt > 0 THEN
            EXECUTE ainp706_upd_tmp USING l_inbm003,l_inbm004
         ELSE
            LET l_cnt = 0         
            CASE WHEN l_inbm003 = '5' #apmt521檢查是否已有後置apmt571單據  
                    EXECUTE ainp706_apmt571_cnt USING l_inbm004 INTO l_cnt
                    IF l_cnt > 0 THEN
                       EXECUTE ainp706_upd_tmp USING l_inbm003,l_inbm004        
                    END IF
                 WHEN l_inbm003 = '8' #apmt520檢查是否已有後置apmt570單據  
                    EXECUTE ainp706_apmt570_cnt USING l_inbm004 INTO l_cnt
                    IF l_cnt > 0 THEN
                       EXECUTE ainp706_upd_tmp USING l_inbm003,l_inbm004       
                    END IF
                 WHEN l_inbm003 = '6' #aint513檢查調撥單狀態是否為撥入確認或結案 
                    EXECUTE ainp706_aint513_cnt USING l_inbm004 INTO l_cnt
                    IF l_cnt > 0 THEN
                       EXECUTE ainp706_upd_tmp USING l_inbm003,l_inbm004        
                    END IF
                 WHEN l_inbm003 = '7' #(adbt600)查詢狀態是否已過帳
                    EXECUTE ainp706_adbt600_cnt USING l_inbm004 INTO l_cnt
                    IF l_cnt > 0 THEN
                       EXECUTE ainp706_upd_tmp USING l_inbm003,l_inbm004        
                    END IF
            END CASE                 
         END IF   
      END FOREACH
   END IF
   
   #將符合tmp中的單號寫入明細tmp
   #apmt521,apmt520
   LET l_sql = "SELECT pmdtent inbpent,pmdtdocno inbp002,pmdtseq inbp003,imay003 inbp004,pmdt006 inbp005, ",
               "       pmdt007 inbp006,pmdt019 inbp007,  COALESCE(pmdt020,0) inbp008 ",
               "  FROM pmdt_t ",
               "  LEFT JOIN imay_t ON imayent=pmdtent AND imay001=pmdt006 AND imay019=pmdt007 ",
               " WHERE pmdtent = ",g_enterprise,
               "   AND pmdt005 <> '8' "   #170104-00068#3 Add By Ken 170105

   #aint513
   LET l_sql1 = "SELECT inddent inbpent,indddocno inbp002,inddseq inbp003,indd003 inbp004,indd002 inbp005, ",
                "       indd004 inbp006,indd006 inbp007,  COALESCE(indd021,0) inbp008 ",
                "  FROM indd_t ",
                " WHERE inddent = ",g_enterprise

   #adbt600
   LET l_sql2 = "SELECT xmdlent inbpent,xmdldocno inbp002,xmdlseq inbp003,imay003 inbp004,xmdl008 inbp005, ",
                "       xmdl009 inbp006,xmdl017 inbp007,  COALESCE(xmdl059,0) inbp008 ",
                "  FROM xmdl_t ",
                "  LEFT JOIN imay_t ON imayent=xmdlent AND imay001=xmdl008 AND imay019=xmdl009 ",
                " WHERE xmdlent = ",g_enterprise
       
   LET g_sql = "SELECT inbpent,inbp002,inbp003,inbp004,inbp005, ",
               "       imaal003,imaal004,inbp006,'',inbp007, ",
               "       oocal003,COALESCE(inbp008,0) ",
               "  FROM ",
               " (" ,l_sql,
               " UNION ",l_sql1," UNION ",l_sql2,
               "  ) ",
               " LEFT JOIN imaal_t ON imaalent=inbpent AND imaal001=inbp005 AND imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t ON oocalent=inbpent AND oocal001=inbp007 AND oocal002='"||g_dlang||"' ",
               " WHERE inbpent = ",g_enterprise,
               "   AND EXISTS(SELECT 1 FROM ainp706_tmp WHERE inbment=inbpent AND inbm004=inbp002 AND ",g_wc2 CLIPPED,") ",
               " ORDER BY inbp002,inbp003 "
   #DISPLAY "g_sql:",g_sql
   IF g_tmp_ins_flag THEN   
      CALL ainp706_ins_tmp_02(g_sql)
   END IF
    
   IF g_default_flag THEN
      LET g_default_flag = FALSE
   END IF
   
   #170104-00068#3 Add By Ken 170110(S)
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM ainp706_tmp
   DISPLAY "ainp706_tmp_cnt:",l_cnt
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM ainp706_tmp_02
   DISPLAY "ainp706_tmp_02_cnt:",l_cnt   
   IF g_bgjob = "Y" THEN      
     UPDATE ainp706_tmp
        SET sel = 'Y'
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'Update ainp706_tmp'
        LET g_errparam.popup = TRUE
        CALL cl_err()
        DISPLAY "Error:Update ainp706_tmp"
     END IF         
     RETURN
   END IF
   #170104-00068#3 Add By Ken 170110(E)
   
   LET g_sql = "SELECT sel,inbm008,inbm001,inbm001_desc,inbm003, ",
               "       inbm004,docdt,inbm007,inbm005,inbm005_desc, ",
               "       inbm006,inbm006_desc,qty,stus ",
               "  FROM ainp706_tmp ",
               " WHERE inbment = ? ",
               "   AND ",g_wc2 CLIPPED,
               " ORDER BY inbm003,inbm001,inbm004 "               
   #end add-point
 
   PREPARE ainp706_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainp706_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
     g_detail_d[l_ac].sel         ,     g_detail_d[l_ac].inbm008     ,     g_detail_d[l_ac].inbm001     , g_detail_d[l_ac].inbm001_desc,    
     g_detail_d[l_ac].inbm003     ,     g_detail_d[l_ac].inbm004     ,     g_detail_d[l_ac].docdt       ,     
     g_detail_d[l_ac].inbm007     ,     g_detail_d[l_ac].inbm005     ,     g_detail_d[l_ac].inbm005_desc,     
     g_detail_d[l_ac].inbm006     ,     g_detail_d[l_ac].inbm006_desc,     g_detail_d[l_ac].qty         ,g_detail_d[l_ac].stus     
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
 
      #end add-point
      
      CALL ainp706_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   LET g_detail_idx = l_ac - 1
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE ainp706_sel
   
   LET l_ac = 1
   CALL ainp706_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp706.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainp706_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_sql           STRING
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   DEFINE l_success       LIKE type_t.num10
   DEFINE l_cnt           LIKE type_t.num10
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   IF g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
     
   LET g_sql = "SELECT inbp003,inbp004,inbp005, ",
               "       inbp005_desc,inbp005_desc_1, ",
               "       inbp006,inbp007,inbp007_desc,inbp008 ",
               "  FROM ainp706_tmp_02",
               " WHERE inbpent = ? ",
               "   AND inbp002 = '",g_detail_d[g_detail_idx].inbm004,"' ",
               " ORDER BY inbp002,inbp003 "   
   PREPARE ainp706_fetch_pre FROM g_sql
   DECLARE ainp706_fetch_cs CURSOR FOR ainp706_fetch_pre
   
   #DISPLAY "ainp706_fetch_cs[SQL] ",g_sql
   
   LET l_ac = 1  
   FOREACH ainp706_fetch_cs USING g_enterprise INTO 
         g_detail2_d[l_ac].inbp003      , g_detail2_d[l_ac].inbp004        , g_detail2_d[l_ac].inbp005      ,
         g_detail2_d[l_ac].inbp005_desc , g_detail2_d[l_ac].inbp005_desc_1 , g_detail2_d[l_ac].inbp006      ,
         g_detail2_d[l_ac].inbp007      , g_detail2_d[l_ac].inbp007_desc   , g_detail2_d[l_ac].inbp008      
         
      CALL s_feature_description(g_detail2_d[l_ac].inbp005,g_detail2_d[l_ac].inbp006) 
           RETURNING l_success,g_detail2_d[l_ac].inbp006_desc   
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF   
   END FOREACH   
   
   CALL g_detail2_d.deleteElement(l_ac)
   LET g_detail2_cnt = l_ac - 1 
   DISPLAY g_detail2_cnt TO FORMONLY.cnt  
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="ainp706.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainp706_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp706.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION ainp706_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL ainp706_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="ainp706.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION ainp706_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="ainp706.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION ainp706_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = ainp706_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ainp706.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 查詢按鈕的功能
# Memo...........:
# Usage..........: CALL ainp706_construct()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/08 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_construct()
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   CLEAR FORM
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_wc 
             ON inbm008,inbm001,inbm003,inbm004,docdt,inbm007,inbm005,inbm006
           FROM b_inbm008,b_inbm001,b_inbm003,b_inbm004,l_docdt,b_inbm007,b_inbm005,b_inbm006
         BEFORE CONSTRUCT
            CALL cl_set_act_visible("filter",FALSE)

         ON ACTION controlp INFIELD b_inbm001
            LET g_inbm008 = GET_FLDBUF(b_inbm008)
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_inbm008) THEN
               CASE WHEN g_inbm008 = '1' 
			              LET g_qryparam.where = " ooef201 = 'Y' "
                       CALL q_ooef001()                           #呼叫開窗               
                    WHEN g_inbm008 = '2' 
			              LET g_qryparam.arg1 = 'ALL'
                       CALL q_pmaa001_6()                           #呼叫開窗                                           
                    WHEN g_inbm008 = '3'
                       CALL q_pmaa001_3()                           #呼叫開窗                    
               END CASE           
            END IF           
            DISPLAY g_qryparam.return1 TO b_inbm001
            NEXT FIELD b_inbm001                     
         
         ON ACTION controlp INFIELD b_inbm004  
            LET g_inbm003 = GET_FLDBUF(b_inbm003)         
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CASE WHEN g_inbm003 = '5' #apmt521
                    LET g_qryparam.arg1 = "('8')"
                    LET g_qryparam.where = " pmdsstus IN ('Y','S') "
                    CALL q_pmdsdocno_13()
                 WHEN g_inbm003 = '6' #aint513                         
			           LET g_qryparam.where = "indc199 = '3' AND indcstus<>'X' AND indcstus<>'N' ",
                                           "AND indc000 = '2' "
                    CALL q_indcdocno()                  
                 WHEN g_inbm003 = '7' #adbt600
			           LET g_qryparam.arg1 = '6'   #出貨簽收單
			           LET g_qryparam.where = " xmdkstus<>'X' AND xmdkstus<>'N' "
                    CALL q_xmdkdocno_22()
                 WHEN g_inbm003 = '8' #apmt520
                    LET g_qryparam.arg1 = "('1')"
                    LET g_qryparam.where = " pmdsstus IN ('Y','S') "
                    CALL q_pmdsdocno_13()                 
            END CASE
            DISPLAY g_qryparam.return1 TO b_inbm004           
            NEXT FIELD b_inbm004
                     
         ON ACTION controlp INFIELD b_inbm005            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inbm005    #顯示到畫面上
            NEXT FIELD b_inbm005   
                      
         ON ACTION controlp INFIELD b_inbm006
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE			   
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inbm006  #顯示到畫面上
            NEXT FIELD b_inbm006                     #返回原欄位
            
         AFTER CONSTRUCT
      
      END CONSTRUCT
      
      CONSTRUCT g_wc2
             ON stus FROM l_stus
      END CONSTRUCT

      BEFORE DIALOG
         LET g_detail_d[1].sel = ""
         DISPLAY ARRAY g_detail_d TO s_detail1.*
            BEFORE DISPLAY
            LET l_ac = 1
               EXIT DISPLAY
         END DISPLAY
         #LET g_detail2_d[1].xmdlseq = ""
         #DISPLAY ARRAY g_detail2_d TO s_detail2.*
         #   BEFORE DISPLAY
         #      EXIT DISPLAY
         #END DISPLAY
         
      ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前
            #end add-point
            CALL ainp706_query()
           
            ACCEPT DIALOG 
                          
      #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
   END DIALOG 
END FUNCTION

################################################################################
# Descriptions...: 欄位輸入控制
# Memo...........:
# Usage..........: CALL ainp706_set_entry()
# Date & Author..: 2016/12/08 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_set_entry()
   CALL cl_set_comp_entry('b_inbm008',TRUE)
   CALL cl_set_comp_entry('b_inbm001',TRUE)
   CALL cl_set_comp_entry('b_inbm003',TRUE)
   CALL cl_set_comp_entry('b_inbm004',TRUE)
   CALL cl_set_comp_entry('l_docdt',TRUE)   
   CALL cl_set_comp_entry('b_inbm007',TRUE)      
   CALL cl_set_comp_entry('b_inbm005',TRUE)
   CALL cl_set_comp_entry('b_inbm006',TRUE)
   CALL cl_set_comp_entry('l_qty',TRUE) 
END FUNCTION

################################################################################
# Descriptions...: 欄位輸入控制
# Memo...........:
# Usage..........: CALL ainp706_set_no_entry()
# Date & Author..: 2016/12/08 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_set_no_entry()
   CALL cl_set_comp_entry('b_inbm008',FALSE)
   CALL cl_set_comp_entry('b_inbm001',FALSE)
   CALL cl_set_comp_entry('b_inbm003',FALSE)
   CALL cl_set_comp_entry('b_inbm004',FALSE)
   CALL cl_set_comp_entry('l_docdt',FALSE)   
   CALL cl_set_comp_entry('b_inbm007',FALSE)      
   CALL cl_set_comp_entry('b_inbm005',FALSE)
   CALL cl_set_comp_entry('b_inbm006',FALSE)
   CALL cl_set_comp_entry('l_qty',FALSE)
END FUNCTION

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL ainp706_create_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/12/09 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_create_tmp()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT ainp706_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE TEMP TABLE ainp706_tmp(
     inbment          SMALLINT,
     sel              VARCHAR(1),
     inbm008          VARCHAR(10),
     inbm001          VARCHAR(10),
     inbm001_desc     VARCHAR(500),
     inbm003          VARCHAR(10),
     inbm004          VARCHAR(20),
     docdt            DATE,
     inbm007          VARCHAR(255),
     inbm005          VARCHAR(20),   
     inbm005_desc     VARCHAR(255),
     inbm006          VARCHAR(10),
     inbm006_desc     VARCHAR(500),
     qty              VARCHAR(20),
     stus             VARCHAR(10)
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ainp706_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #建index
   CREATE INDEX ainp706_tmp_n01 on ainp706_tmp(inbment,inbm004)
   IF SQLCA.SQLcode THEN       
      LET g_log = "CREATE INDEX ainp706_tmp_n01 on ainp706_tmp(inbment,inbm004) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
      DISPLAY g_log 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX ainp706_tmp_n01"  
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
      
   CREATE TEMP TABLE ainp706_tmp_02(
     inbpent          SMALLINT,
     inbp002          VARCHAR(20),
     inbp003          INTEGER,
     inbp004          VARCHAR(40),
     inbp005          VARCHAR(40),
     inbp005_desc     VARCHAR(255),
     inbp005_desc_1   VARCHAR(255),
     inbp006          VARCHAR(30),  
     inbp006_desc     VARCHAR(500),     
     inbp007          VARCHAR(10),
     inbp007_desc     VARCHAR(500),
     inbp008          DECIMAL(20,6)
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ainp706_tmp_02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   
   #建index
   CREATE INDEX ainp706_tmp_02_n01 on ainp706_tmp_02(inbpent,inbp002)
   IF SQLCA.SQLcode THEN       
      LET g_log = "CREATE INDEX ainp706_tmp_01 on ainp706_tmp(inbment,inbm004) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
      DISPLAY g_log 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX ainp706_tmp_01"  
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存表
# Memo...........:
# Usage..........: CALL ainp706_drop_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_drop_tmp()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE ainp706_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop ainp706_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE ainp706_tmp_02

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop ainp706_tmp_02'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF   
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 寫入暫存表
# Memo...........:
# Usage..........: CALL ainp706_ins_tmp(p_sql)
# Input parameter: p_sql          SQL語法
# Date & Author..: 2016/12/09 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_ins_tmp(p_sql)
   DEFINE p_sql          STRING
   DEFINE l_sql          STRING
   
   #清空临时表
    TRUNCATE TABLE ainp706_tmp
    TRUNCATE TABLE ainp706_tmp_02    
   #数据插入临时表
    LET l_sql = " INSERT INTO ainp706_tmp ",p_sql         
    PREPARE ins_tmp FROM l_sql
    EXECUTE ins_tmp 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'ins ainp706_tmp'
       LET g_errparam.popup = TRUE
       CALL cl_err()
    END IF
END FUNCTION

################################################################################
# Descriptions...: 寫入明細暫存表
# Memo...........:
# Usage..........: CALL ainp706_ins_tmp(p_sql)
# Input parameter: p_sql          SQL語法
# Date & Author..: 2016/12/12 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_ins_tmp_02(p_sql)
DEFINE p_sql          STRING
DEFINE l_sql          STRING
   
   #数据插入临时表
    LET l_sql = " INSERT INTO ainp706_tmp_02 ",p_sql         
    PREPARE ins_tmp_02 FROM l_sql
    EXECUTE ins_tmp_02 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'ins ainp706_tmp_02'
       LET g_errparam.popup = TRUE
       CALL cl_err()
    END IF
END FUNCTION

################################################################################
# Descriptions...: 產生裝箱單
# Memo...........:
# Usage..........: CALL ainp706_process()
#                  RETURNING r_success 
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/12/12 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_process()
DEFINE l_sql            STRING
DEFINE l_inbm           RECORD
       inbment          LIKE inbm_t.inbment,
       inbmsite         LIKE inbm_t.inbmsite,
       inbmunit         LIKE inbm_t.inbmunit,
       inbmdocno        LIKE inbm_t.inbmdocno,
       inbmdocdt        LIKE inbm_t.inbmdocdt,
       inbm001          LIKE inbm_t.inbm001,
       inbm002          LIKE inbm_t.inbm002,
       inbm003          LIKE inbm_t.inbm003,
       inbm004          LIKE inbm_t.inbm004,
       inbm005          LIKE inbm_t.inbm005,
       inbm006          LIKE inbm_t.inbm006,
       inbm007          LIKE inbm_t.inbm007,
       inbm008          LIKE inbm_t.inbm008,
       inbmstus         LIKE inbm_t.inbmstus,
       inbmownid        LIKE inbm_t.inbmownid,
       inbmowndp        LIKE inbm_t.inbmowndp,
       inbmcrtid        LIKE inbm_t.inbmcrtid,
       inbmcrtdp        LIKE inbm_t.inbmcrtdp,
       inbmcrtdt        LIKE inbm_t.inbmcrtdt
                        END RECORD
DEFINE l_inbp           RECORD
       inbpent          LIKE inbp_t.inbpent, 
       inbpsite         LIKE inbp_t.inbpsite, 
       inbpdocno        LIKE inbp_t.inbpdocno, 
       inbpseq          LIKE inbp_t.inbpseq, 
       inbp001          LIKE inbp_t.inbp001, 
       inbp002          LIKE inbp_t.inbp002, 
       inbp003          LIKE inbp_t.inbp003, 
       inbp004          LIKE inbp_t.inbp004, 
       inbp005          LIKE inbp_t.inbp005, 
       inbp006          LIKE inbp_t.inbp006, 
       inbp007          LIKE inbp_t.inbp007, 
       inbp008          LIKE inbp_t.inbp008, 
       inbp009          LIKE inbp_t.inbp009, 
       inbp010          LIKE inbp_t.inbp010, 
       inbp011          LIKE inbp_t.inbp011, 
       inbp012          LIKE inbp_t.inbp012
                        END RECORD   
DEFINE l_inbment        LIKE inbm_t.inbment
DEFINE l_inbm001        LIKE inbm_t.inbm001
DEFINE l_inbm002        LIKE inbm_t.inbm002
DEFINE l_inbm003        LIKE inbm_t.inbm003
DEFINE l_inbm004        LIKE inbm_t.inbm004
DEFINE l_inbm005        LIKE inbm_t.inbm005
DEFINE l_inbm006        LIKE inbm_t.inbm006
DEFINE l_inbm007        LIKE inbm_t.inbm007
DEFINE l_inbm008        LIKE inbm_t.inbm008
DEFINE l_inbp003        LIKE inbp_t.inbp003
DEFINE l_inbp004        LIKE inbp_t.inbp004
DEFINE l_inbp005        LIKE inbp_t.inbp005
DEFINE l_inbp006        LIKE inbp_t.inbp006
DEFINE l_inbp007        LIKE inbp_t.inbp007
DEFINE l_inbp008        LIKE inbp_t.inbp008
DEFINE l_slip           STRING      #單別 
DEFINE l_success        LIKE type_t.num5
DEFINE l_cnt            LIKE type_t.num10
DEFINE l_stus_y         LIKE type_t.num10
DEFINE l_stus_n         LIKE type_t.num10
DEFINE l_inbmdocno      LIKE inbm_t.inbmdocno
DEFINE l_session_id     LIKE type_t.num20   
DEFINE l_session_id_str STRING
DEFINE l_i              LIKE type_t.num10
DEFINE l_sql_cnt        STRING
DEFINE l_docno_str      STRING
DEFINE l_docno_str1     STRING

DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "------------------------------"
   DISPLAY "SessionId: ",l_session_id   
   DISPLAY "------------------------------"   
   
   INITIALIZE l_inbm.* TO NULL
   INITIALIZE l_inbp.* TO NULL   
   
   LET l_stus_y = 0
   LET l_stus_n = 0
   #檢查勾選的是否都是已拋單(如都已拋單，則報錯)
   LET l_sql = " SELECT COALESCE(SUM(CASE stus WHEN 'Y' THEN 1 END),0)stus_y, ",
               "        COALESCE(SUM(CASE stus WHEN 'N' THEN 1 END),0)stus_n  ",
               "   FROM ainp706_tmp ",
               "  WHERE sel='Y' "
   PREPARE ainp706_check_cnt FROM l_sql
   EXECUTE ainp706_check_cnt INTO l_stus_y,l_stus_n
   IF l_stus_y > 0 AND l_stus_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00857'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      LET r_success = FALSE
      RETURN r_success
   END IF
 
   #取明細資料
   LET l_sql = " SELECT inbp003,inbp004,inbp005,inbp006,inbp007, ",
               "        inbp008 ",
               "   FROM ainp706_tmp_02 ", 
               "  WHERE inbpent = ? ",
               "    AND inbp002 = ? ",
               "  ORDER BY inbp003 "
   PREPARE ainp706_inbp_sel FROM l_sql
   DECLARE ainp706_inbp_sel_cur CURSOR FOR ainp706_inbp_sel

   #明細項次+1
   LET l_sql = " SELECT MAX(inbpseq)+1 ",
               "   FROM inbp_t ",
               "  WHERE inbpent = ",g_enterprise,
               "    AND inbpdocno = ? "
   PREPARE ainp706_inbpseq_sel FROM l_sql
         
   #取單頭資料
   LET l_sql = " SELECT DISTINCT inbment,inbm001,inbm003,inbm004, ",
               "        inbm005,inbm006,inbm007,inbm008 ",
               "   FROM ainp706_tmp t1,ainp706_tmp_02 t2 ", 
               "  WHERE t1.inbment=t2.inbpent and t1.inbm004=t2.inbp002 ",
               "    AND t1.sel='Y' AND stus='N' ",
               "  ORDER BY inbm003,inbm001,inbm004 "
   PREPARE ainp706_inbm_sel FROM l_sql
   DECLARE ainp706_inbm_sel_cur CURSOR FOR ainp706_inbm_sel
   FOREACH ainp706_inbm_sel_cur INTO l_inbment,l_inbm001,l_inbm003,l_inbm004,l_inbm005,l_inbm006,l_inbm007,l_inbm008
     INITIALIZE l_inbm.* TO NULL 

     #取單別
     LET l_success = ''
     CALL s_arti200_get_def_doc_type(g_site,'aint701','2')
        RETURNING l_success,l_slip
     IF l_success = FALSE THEN
        LET r_success = FALSE
        EXIT FOREACH         
     END IF    
       
     #先用假單號寫db
     LET l_session_id_str = l_session_id
     LET l_sql = " SELECT MAX(inbmdocno)  ",
                 "   FROM inbm_t  ",
                 "  WHERE inbment = ",g_enterprise,
                 "    AND inbmdocno LIKE ","'%",l_session_id_str,"%'"
      
     PREPARE ainp706_inbmdocno_max_sel FROM l_sql
     EXECUTE ainp706_inbmdocno_max_sel INTO l_inbmdocno
     #轉成字串解析
     LET l_docno_str = l_inbmdocno
     
     IF cl_null(l_docno_str) THEN
        LET l_inbm.inbmdocno = l_session_id_str.trim() CLIPPED,"_0001" #USING "#####"
     ELSE
        FOR l_i =1 TO l_docno_str.getlength()
           IF l_docno_str.subString(l_i,l_i) = '_' THEN
              LET l_docno_str1 = l_docno_str.subString(l_i+1,l_docno_str.getlength())+1 USING "&&&&"
              DISPLAY "l_docno_str1:",l_docno_str1
              EXIT FOR
           END IF
        END FOR
        LET l_inbm.inbmdocno = l_session_id_str.trim() CLIPPED,'_',l_docno_str1.trim() USING "&&&&"
     END IF     
     LET l_inbm.inbment    = l_inbment
     LET l_inbm.inbmdocdt  = g_today     
     LET l_inbm.inbmsite   = g_site              #营运据点
     LET l_inbm.inbmunit   = g_site              #配送中心    
     LET l_inbm.inbm001    = l_inbm001           #需求对象      
     LET l_inbm.inbm002    = ''                  #需求单号
     LET l_inbm.inbm003    = l_inbm003
     LET l_inbm.inbm004    = l_inbm004           #来源单号
     LET l_inbm.inbm005    = g_user              #装箱人员
     LET l_inbm.inbm006    = g_dept              #装箱部门
     LET l_inbm.inbm007    = l_inbm007           #備註 
     LET l_inbm.inbm008    = l_inbm008           #需求对象类型
     LET l_inbm.inbmstus   = 'N'
     LET l_inbm.inbmownid  = g_user              #資料所有者 
     LET l_inbm.inbmowndp  = g_dept              #資料所屬部門
     LET l_inbm.inbmcrtid  = g_user              #資料建立者 
     LET l_inbm.inbmcrtdp  = g_dept              #資料建立部門
     LET l_inbm.inbmcrtdt  = cl_get_current()    #資料創建日     
     INSERT INTO inbm_t(inbment,  inbmdocno, inbmsite, inbmunit, inbmdocdt, 
                        inbm001,  inbm002,   inbm003,  inbm004,  inbm005, 
                        inbm006,  inbm007,   inbm008,  
                        inbmownid,inbmowndp, inbmcrtid,inbmcrtdp,inbmcrtdt,
                        inbmstus)                      
           VALUES(l_inbm.inbment,  l_inbm.inbmdocno, l_inbm.inbmsite, l_inbm.inbmunit, l_inbm.inbmdocdt, 
                  l_inbm.inbm001,  l_inbm.inbm002,   l_inbm.inbm003,  l_inbm.inbm004,  l_inbm.inbm005, 
                  l_inbm.inbm006,  l_inbm.inbm007,   l_inbm.inbm008,  
                  l_inbm.inbmownid,l_inbm.inbmowndp, l_inbm.inbmcrtid,l_inbm.inbmcrtdp,l_inbm.inbmcrtdt,
                  l_inbm.inbmstus)
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = 'Insert inbm_t'
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET r_success = FALSE
        EXIT FOREACH         
     END IF

     #寫入明細資料
     FOREACH ainp706_inbp_sel_cur USING l_inbment,l_inbm004
                                  INTO l_inbp003,l_inbp004,l_inbp005,l_inbp006,l_inbp007,l_inbp008
        INITIALIZE l_inbp.* TO NULL                                            
        LET l_inbp.inbpent   = l_inbment
        LET l_inbp.inbpsite  = l_inbm.inbmsite
        LET l_inbp.inbpdocno = l_inbm.inbmdocno
        EXECUTE ainp706_inbpseq_sel USING l_inbm.inbmdocno INTO l_inbp.inbpseq
        IF cl_null(l_inbp.inbpseq) THEN
           LET l_inbp.inbpseq = 1
        END IF
        LET l_inbp.inbp001   = l_inbm003
        LET l_inbp.inbp002   = l_inbm004
        LET l_inbp.inbp003   = l_inbp003
        LET l_inbp.inbp004   = l_inbp004
        LET l_inbp.inbp005   = l_inbp005
        LET l_inbp.inbp006   = l_inbp006
        LET l_inbp.inbp007   = l_inbp007
        LET l_inbp.inbp008   = l_inbp008
        LET l_inbp.inbp009   = 0
        LET l_inbp.inbp010   = ''
        LET l_inbp.inbp011   = ''         
        LET l_inbp.inbp012   = ''
                
        INSERT INTO inbp_t(inbpent,  inbpdocno, inbpsite, inbpseq,  inbp001,  inbp002,   
                           inbp003,  inbp004,   inbp005,  inbp006,  inbp007,   
                           inbp008,  inbp009,   inbp010,  inbp011,  inbp012)                      
              VALUES(l_inbp.inbpent,  l_inbp.inbpdocno, l_inbp.inbpsite, l_inbp.inbpseq,   l_inbp.inbp001,  l_inbp.inbp002,   
                     l_inbp.inbp003,  l_inbp.inbp004,   l_inbp.inbp005,  l_inbp.inbp006,   l_inbp.inbp007,   
                     l_inbp.inbp008,  l_inbp.inbp009,   l_inbp.inbp010,  l_inbp.inbp011,   l_inbp.inbp012)                      
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'Insert inbp_t'
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           EXIT FOREACH         
        END IF                               
     END FOREACH  
   END FOREACH
   #將此次新增的假單號改成真的單號
   #更新docno
   IF NOT cl_null(l_session_id_str) THEN
      LET l_sql = " SELECT DISTINCT inbmdocno ",
                 "   FROM inbm_t  ",
                 "  WHERE inbment = ",g_enterprise,
                 "    AND inbmdocno LIKE ","'%",l_session_id_str,"%'",
                 "  ORDER BY inbm003,inbm001,inbm004 "
      PREPARE ainp706_docno_sel_pre FROM l_sql
      DECLARE ainp706_docno_sel_cur CURSOR FOR ainp706_docno_sel_pre
      LET l_inbmdocno = ''
      
      FOREACH ainp706_docno_sel_cur INTO l_inbmdocno
      
         LET l_success = ''
         LET l_inbm.inbmdocno = ''
         CALL s_aooi200_gen_docno(g_site,l_slip,g_today,'aint701')
            RETURNING l_success,l_inbm.inbmdocno
         IF l_success = FALSE THEN        
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00003'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF     
         
         #update inbmdocno
         UPDATE inbm_t SET inbmdocno = l_inbm.inbmdocno
          WHERE inbment = g_enterprise
            AND inbmdocno = l_inbmdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd inbmdocno error'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH         
         END IF
         #update inbpdocno
         UPDATE inbp_t SET inbpdocno = l_inbm.inbmdocno
          WHERE inbpent = g_enterprise
            AND inbpdocno = l_inbmdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd inbpdocno error'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH         
         END IF
         DISPLAY "########inbmdocno:",l_inbm.inbmdocno
      END FOREACH
   END IF   
   
   IF g_bgjob != "Y" THEN
      LET g_tmp_ins_flag = FALSE
      CALL ainp706_b_fill()  
      LET g_tmp_ins_flag = TRUE
   END IF
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 背景排程處理段
# Memo...........:
# Usage..........: CALL ainp706_bgjob_process(p_wc)
# Input parameter: ls_js           傳入條件
# Return code....: 
# Date & Author..: 2017/01/10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp706_bgjob_process(ls_js)
DEFINE p_wc             STRING
DEFINE l_success        LIKE type_t.num10
DEFINE ls_js            STRING
DEFINE lc_param         type_parameter

   LET g_tmp_ins_flag = TRUE  
   LET g_default_flag = TRUE

   CALL util.JSON.parse(ls_js,lc_param)

   IF cl_null(lc_param.wc) THEN
      LET lc_param.wc = ' 1=1'
   END IF   
   
   DISPLAY "g_wc:",lc_param.wc
   
   LET g_wc = lc_param.wc
   LET g_wc2 = "stus = 'N'"
   DISPLAY "g_wc2:",g_wc2
   
   CALL ainp706_b_fill()
   DISPLAY "ainp706_bill"
   CALL s_transaction_begin()
   DISPLAY "ainp706_process_start"
   IF NOT ainp706_process() THEN
      CALL s_transaction_end('N','0')         
   ELSE
      CALL s_transaction_end('Y','1')            
   END IF
   DISPLAY "ainp706_process_end"
   
   
END FUNCTION

#end add-point
 
{</section>}
 
