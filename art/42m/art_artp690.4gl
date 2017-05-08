#該程式未解開Section, 採用最新樣板產出!
{<section id="artp690.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-08-23 17:02:06), PR版次:0005(2016-12-06 09:34:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: artp690
#+ Description: 前臺會員資料統計作業
#+ Creator....: 03247(2015-08-23 16:02:39)
#+ Modifier...: 03247 -SD/PR- 02749
 
{</section>}
 
{<section id="artp690.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
##160819-00054#24 2016/11/15 by lori    s_card_mmaq_upd增加參數,相關處理 
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   rtjadocdt             LIKE rtja_t.rtjadocdt,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtjasite LIKE type_t.chr500, 
   rtjadocdt LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artp690.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_aooi500_create_temp() RETURNING l_success
      #end add-point
      CALL artp690_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp690 WITH FORM cl_ap_formpath("art",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL artp690_init()
 
      #進入選單 Menu (="N")
      CALL artp690_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp690
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp690.init" >}
#+ 初始化作業
PRIVATE FUNCTION artp690_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artp690.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp690_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_rtjadocdt   LIKE rtja_t.rtjadocdt
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.rtjadocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjadocdt
            #add-point:BEFORE FIELD rtjadocdt name="input.b.rtjadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjadocdt
            
            #add-point:AFTER FIELD rtjadocdt name="input.a.rtjadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtjadocdt
            #add-point:ON CHANGE rtjadocdt name="input.g.rtjadocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjadocdt
            #add-point:ON ACTION controlp INFIELD rtjadocdt name="input.c.rtjadocdt"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtjasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjasite
            #add-point:ON ACTION controlp INFIELD rtjasite name="construct.c.rtjasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjasite  #顯示到畫面上
            NEXT FIELD rtjasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjasite
            #add-point:BEFORE FIELD rtjasite name="construct.b.rtjasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjasite
            
            #add-point:AFTER FIELD rtjasite name="construct.a.rtjasite"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL artp690_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET l_rtjadocdt = cl_get_para(g_enterprise,g_site,'S-CIR-0003')
            LET g_master.rtjadocdt = l_rtjadocdt - 1
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL artp690_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.rtjadocdt = g_master.rtjadocdt
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL artp690_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = artp690_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="artp690.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION artp690_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="artp690.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION artp690_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_rtja000     LIKE rtja_t.rtja000
   DEFINE l_rtja001     LIKE rtja_t.rtja001
   DEFINE l_rtja033     LIKE rtja_t.rtja033
   DEFINE l_rtjacrtdt   LIKE rtja_t.rtjacrtdt
   DEFINE l_rtjasite    LIKE rtja_t.rtjasite
   DEFINE l_rtja049     LIKE rtja_t.rtja049
   DEFINE l_rtja016     LIKE rtja_t.rtja016
   DEFINE l_rtjadocno   LIKE rtja_t.rtjadocno
   DEFINE l_rtja054     LIKE rtja_t.rtja054
   DEFINE l_rtja058     LIKE rtja_t.rtja058      #20160222 dongsz add
   DEFINE l_sql         STRING
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_date        DATETIME YEAR TO SECOND
   DEFINE l_where       STRING
   DEFINE l_rtjadocdt   LIKE rtja_t.rtjadocdt
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_msg         LIKE type_t.chr100    #160225-00040#18 2016/04/13 s983961--add
   DEFINE l_inaa105     LIKE inaa_t.inaa105   #160819-00054#24 161115 by lori add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF NOT cl_ask_confirm("lib-012") THEN
      RETURN
   END IF
   IF cl_null(lc_param.wc) THEN
      LET lc_param.wc = " 1=1"
   END IF
   IF cl_null(lc_param.rtjadocdt) THEN
      LET l_rtjadocdt = cl_get_para(g_enterprise,g_site,'S-CIR-0003')
      LET lc_param.rtjadocdt = l_rtjadocdt - 1
   END IF
   LET l_where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
   LET l_where = cl_replace_str(l_where,'ooef001','rtjasite')
   DISPLAY "l_where:",l_where
   LET lc_param.wc = lc_param.wc," AND ",l_where
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(2)   #160225-00040# 20160303 s983961--add
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE artp690_process_cs CURSOR FROM ls_sql
#  FOREACH artp690_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040# 20160303 s983961--add(s)
   LET l_msg = cl_getmsg('ast-00330',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040# 20160303 s983961--add(e)
   
   #160819-00054#24 161115 by lori add---(S)
   LET l_sql = "SELECT inaa105 FROM rtjb_t,rtdx_t,inaa_t ",
               " WHERE rtjbent = rtdxent AND rtjbsite = rtdxsite AND rtjb004 = rtdx001 ",
               "   AND rtdxent = inaaent AND rtdxsite = inaasite AND rtdx044 = inaa001 ",
               "   AND rtjbent = ",g_enterprise,
               "   AND rtjbdocno = ? ",
               " ORDER BY rtjbseq"
   PREPARE artp690_sel_inaa105_pre FROM l_sql
   DECLARE artp690_sel_inaa105_cur CURSOR FOR artp690_sel_inaa105_pre
   #160819-00054#24 161115 by lori add---(E)
   
   CALL cl_err_collect_init()
   LET l_cnt = 0
   CALL s_transaction_begin()
   LET l_sql = " SELECT rtja000,rtja001,rtja033,rtjacrtdt,rtjasite,rtja049,rtja016,rtjadocno,rtja054,rtja058 ",
               "   FROM rtja_t ",
               "  WHERE rtjaent = ",g_enterprise," ",
               #"    AND rtja032 = '2' ",
               "    AND rtja032 <> '1' ",         #20151117 dongsz add
               #"    AND rtja000 = 'artt610' ",   #20150921--mark by dongsz
               "    AND (rtja000 = 'artt610' OR rtja000 = 'artt700') ",    #20150921--add by dongsz
               "    AND rtja001 IS NOT NULL ",
               #"    AND (rtja054 IS NULL OR rtja054 = 'N') ",
               "    AND ",lc_param.wc,
               "    AND rtjadocdt = '",lc_param.rtjadocdt,"' "
   PREPARE artp690_sel_rtja_pre FROM l_sql
   DECLARE artp690_sel_rtja_cs  CURSOR WITH HOLD FOR artp690_sel_rtja_pre
   FOREACH artp690_sel_rtja_cs  INTO l_rtja000,l_rtja001,l_rtja033,l_rtjacrtdt,l_rtjasite,l_rtja049,
                                     l_rtja016,l_rtjadocno,l_rtja054,l_rtja058
      LET l_date = cl_get_current()
      #写积分异动档并更新卡积分
      IF cl_null(l_rtja054) OR l_rtja054 = 'N' THEN
         #CALL s_card_point_add(l_rtja001,'2','A',l_rtja033,l_rtjacrtdt,l_rtjasite,l_rtja049,l_rtja016,l_rtjasite,'','')
         CALL s_card_point_add(l_rtja001,'2','A',l_rtja033,lc_param.rtjadocdt,l_rtjasite,l_rtja049,l_rtja016,l_rtjasite,'','')
            RETURNING r_success
         IF NOT r_success THEN
            #CALL s_transaction_end('N','0')
            EXIT FOREACH
         END IF
         #回写rtjacnfdt
         #UPDATE rtja_t SET rtjacnfdt = l_date
         # WHERE rtjaent = g_enterprise
         #   AND rtjadocno = l_rtjadocno
         #回写rtja054
         UPDATE rtja_t SET rtja054 = 'Y'
          WHERE rtjaent = g_enterprise
            AND rtjadocno = l_rtjadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #CALL s_transaction_end('N','0')
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      #20151117--dongsz add--str---
      #更新会员信息(消费日，消费次数，消费金额)
      IF cl_null(l_rtja058) OR l_rtja058 = 'N' THEN
         #160819-00054#24 161115 by lori mark and add---(S)
         LET l_inaa105 = ''
         FOREACH artp690_sel_inaa105_cur USING l_rtjadocno
                                         INTO l_inaa105
            IF NOT cl_null(l_inaa105) THEN
               EXIT FOREACH
            END IF
         END FOREACH                                
         
         #CALL s_card_mmaq_upd2(l_rtja000,l_rtja001,l_rtja049,lc_param.rtjadocdt,l_rtja033)
         #   RETURNING r_success
         
         CALL s_card_mmaq_upd2(l_rtja000,l_rtja001,l_rtja049,lc_param.rtjadocdt,l_rtja033,
                               l_rtjasite,l_inaa105)
            RETURNING r_success
         #160819-00054#24 161115 by lori mark and add---(E)   
        
         IF NOT r_success THEN
            #CALL s_transaction_end('N','0')
            EXIT FOREACH
         END IF
         #回写rtja058
         UPDATE rtja_t SET rtja058 = 'Y'
          WHERE rtjaent = g_enterprise
            AND rtjadocno = l_rtjadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            #CALL s_transaction_end('N','0')
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      #20151117--dongsz add--end---
      #CALL s_transaction_end('Y','0')
      LET l_cnt = l_cnt + 1
   END FOREACH
   DISPLAY 'l_cnt:',l_cnt
   
   IF r_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF

   CALL cl_err_collect_show()
   
   #160225-00040# 20160303 s983961--add(s)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040# 20160303 s983961--add(e)
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      #CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL artp690_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="artp690.get_buffer" >}
PRIVATE FUNCTION artp690_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.rtjadocdt = p_dialog.getFieldBuffer('rtjadocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artp690.msgcentre_notify" >}
PRIVATE FUNCTION artp690_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="artp690.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 