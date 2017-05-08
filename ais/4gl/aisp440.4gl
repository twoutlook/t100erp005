#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp440.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-05-15 19:19:13), PR版次:0003(2015-06-29 19:02:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: aisp440
#+ Description: 空白發票產生作業
#+ Creator....: 04152(2015-03-17 17:26:59)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisp440.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150422-00012#1  2015/04/28 By Reanna 增加申報歸屬月份
#150624-00005#9  2015/06/26 By Jessy  處理排程相關程式
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
   #150624-00005#9-----s
   isaa001       LIKE isaa_t.isaa001, 
   isaa012       LIKE isaa_t.isaa012, 
   isaa013       LIKE isaa_t.isaa013, 
   isaa013_2     LIKE type_t.num5, 
   l_report_date LIKE type_t.num5,
   #150624-00005#9-----e 
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       isaa001 LIKE isaa_t.isaa001, 
   isaa001_desc LIKE type_t.chr80, 
   isaa012 LIKE isaa_t.isaa012, 
   isaa013 LIKE isaa_t.isaa013, 
   isaa013_2 LIKE type_t.num5, 
   l_report_date LIKE type_t.num5, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#150422-00012#1 add ------
DEFINE g_wc_isaosite STRING
DEFINE g_ooef017     LIKE ooef_t.ooef017
DEFINE g_ooef019     LIKE ooef_t.ooef019
DEFINE g_isaa007     LIKE isaa_t.isaa007
#150422-00012#1 add end---
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp440.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisp440_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp440 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp440_init()
 
      #進入選單 Menu (="N")
      CALL aisp440_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp440
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp440.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp440_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
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
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp440.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp440_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt        LIKE type_t.num10
   DEFINE l_isaa012    LIKE isaa_t.isaa012    #年度
   DEFINE l_isaa013    LIKE isaa_t.isaa013    #月份
   DEFINE l_day1       LIKE type_t.dat        #輸入的年月
   DEFINE l_day2       LIKE type_t.dat        #aisi010設定的年月
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aisp440_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.isaa001,g_master.isaa012,g_master.isaa013,g_master.isaa013_2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa001
            
            #add-point:AFTER FIELD isaa001 name="input.a.isaa001"
            IF NOT cl_null(g_master.isaa001) THEN
               #申報單位須存在aisi010裡面
               SELECT COUNT(*) INTO l_cnt
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_master.isaa001
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00193'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #150422-00012#1 add ------
               #用申報單位取得營運據點&相關資料
               CALL s_aisp440_get_site_info(g_master.isaa001) RETURNING g_wc_isaosite,g_ooef017,g_ooef019,g_isaa007
               CALL cl_set_comp_entry("isaa013_2",TRUE)
               IF g_isaa007 = 2 THEN
                  CALL cl_set_comp_entry("isaa013_2",FALSE)
               END IF
               #150422-00012#1 add end---
            END IF
            CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
            DISPLAY BY NAME g_master.isaa001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa001
            #add-point:BEFORE FIELD isaa001 name="input.b.isaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa001
            #add-point:ON CHANGE isaa001 name="input.g.isaa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.isaa012,"0","0","2099","1","azz-00087",1) THEN
               NEXT FIELD isaa012
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa012 name="input.a.isaa012"
            IF NOT cl_null(g_master.isaa012) THEN
               #年度不可小於aisi010的申報年度
               SELECT isaa012,isaa013 INTO l_isaa012,l_isaa013
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_master.isaa001
               IF NOT cl_null(l_isaa012) THEN
                  IF g_master.isaa012 < l_isaa012 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00190'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(l_isaa013) THEN
                     LET l_day1= MDY(g_master.isaa013,1,g_master.isaa012)
                     LET l_day2= MDY(l_isaa013,1,l_isaa012)
                     IF l_day1 <= l_day2 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ais-00191'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        NEXT FIELD isaa013
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa012
            #add-point:BEFORE FIELD isaa012 name="input.b.isaa012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa012
            #add-point:ON CHANGE isaa012 name="input.g.isaa012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.isaa013,"0","0","12","1","azz-00087",1) THEN
               NEXT FIELD isaa013
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa013 name="input.a.isaa013"
            IF NOT cl_null(g_master.isaa012) AND NOT cl_null(g_master.isaa013) THEN
               #年度不可小於aisi010的申報月份
               SELECT isaa012,isaa013 INTO l_isaa012,l_isaa013
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_master.isaa001
               IF NOT cl_null(l_isaa012) OR NOT cl_null(l_isaa013) THEN
                  LET l_day1= MDY(g_master.isaa013,1,g_master.isaa012)
                  LET l_day2= MDY(l_isaa013,1,l_isaa012)
                  IF l_day1 <= l_day2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00191'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa013
            #add-point:BEFORE FIELD isaa013 name="input.b.isaa013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa013
            #add-point:ON CHANGE isaa013 name="input.g.isaa013"
            IF NOT cl_null(g_master.isaa013) THEN
               #150422-00012#1 add ------
               #帶出申報所屬月份
               #若為按期申報>>結束月份為奇數則+1變偶數月
               IF g_isaa007 = 1 THEN
                  LET g_master.isaa013_2 = g_master.isaa013 + 1
                  IF g_master.isaa013 >= 12 THEN
                     LET g_master.isaa013_2 = 12
                  END IF
                  IF g_master.isaa013_2 MOD 2 = 0 THEN
                     LET g_master.l_report_date = g_master.isaa013_2
                  ELSE
                     LET g_master.l_report_date = g_master.isaa013_2 + 1
                  END IF
               ELSE
                  LET g_master.isaa013_2 = g_master.isaa013
                  IF g_master.isaa013 >= 12 THEN
                     LET g_master.isaa013_2 = 12
                  END IF
                  LET g_master.l_report_date = g_master.isaa013_2
               END IF
               DISPLAY BY NAME g_master.l_report_date
               #150422-00012#1 add end---
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa013_2
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.isaa013_2,"0","0","12","1","azz-00087",1) THEN
               NEXT FIELD isaa013_2
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa013_2 name="input.a.isaa013_2"
            IF NOT cl_null(g_master.isaa013) AND NOT cl_null(g_master.isaa013_2) THEN
               #月份不可小於起始月份
               IF g_master.isaa013 > g_master.isaa013_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00147'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #150422-00012#1 add ------
               #帶出申報所屬月份
               #若為按期申報>>結束月份為奇數則+1變偶數月
               IF g_isaa007 = 1 THEN
                  IF g_master.isaa013_2 MOD 2 = 0 THEN
                     LET g_master.l_report_date = g_master.isaa013_2
                  ELSE
                     LET g_master.l_report_date = g_master.isaa013_2 + 1
                  END IF
               ELSE
                  LET g_master.l_report_date = g_master.isaa013_2
               END IF
               DISPLAY BY NAME g_master.l_report_date
               #150422-00012#1 add end---
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa013_2
            #add-point:BEFORE FIELD isaa013_2 name="input.b.isaa013_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa013_2
            #add-point:ON CHANGE isaa013_2 name="input.g.isaa013_2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.isaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa001
            #add-point:ON ACTION controlp INFIELD isaa001 name="input.c.isaa001"
            #i開窗-申報單位代碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.isaa001
            LET g_qryparam.where = "isaastus = 'Y' "
            CALL q_isaa001()
            LET g_master.isaa001 = g_qryparam.return1
            DISPLAY BY NAME g_master.isaa001
            NEXT FIELD isaa001
            #END add-point
 
 
         #Ctrlp:input.c.isaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa012
            #add-point:ON ACTION controlp INFIELD isaa012 name="input.c.isaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa013
            #add-point:ON ACTION controlp INFIELD isaa013 name="input.c.isaa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaa013_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa013_2
            #add-point:ON ACTION controlp INFIELD isaa013_2 name="input.c.isaa013_2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
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
            CALL aisp440_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
 
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
            CALL aisp440_qbe_clear()
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
         CALL aisp440_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #150624-00005#9-----s
      LET lc_param.isaa001       = g_master.isaa001
      LET lc_param.isaa012       = g_master.isaa012
      LET lc_param.isaa013       = g_master.isaa013
      LET lc_param.isaa013_2     = g_master.isaa013_2 
      LET lc_param.l_report_date = g_master.l_report_date
      #150624-00005#9-----e
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
                 CALL aisp440_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp440_transfer_argv(ls_js)
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
 
{<section id="aisp440.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp440_transfer_argv(ls_js)
 
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
 
{<section id="aisp440.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp440_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_write       LIKE type_t.chr1    #判斷是否寫入
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #150624-00005#9-----s
   #將傳遞參數變數傳回給畫面上的變數
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc            = lc_param.wc
      LET g_master.isaa001       = lc_param.isaa001
      LET g_master.isaa012       = lc_param.isaa012
      LET g_master.isaa013       = lc_param.isaa013
      LET g_master.isaa013_2     = lc_param.isaa013_2 
      LET g_master.l_report_date = lc_param.l_report_date
      CALL s_aisp440_get_site_info(g_master.isaa001) RETURNING g_wc_isaosite,g_ooef017,g_ooef019,g_isaa007
   END IF
   #150624-00005#9-----e
   
   IF cl_null(g_master.isaa001) OR cl_null(g_master.isaa012) OR
      cl_null(g_master.isaa013) OR cl_null(g_master.isaa013_2) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00332'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp440_process_cs CURSOR FROM ls_sql
#  FOREACH aisp440_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   LET g_success = 'Y'
   LET l_write = 'N'
   
   #抓取空白發票 #150422-00012#1 add l_report_date
   CALL s_aisp440_space_invoice(g_master.isaa001,g_master.isaa012,g_master.isaa013,g_master.isaa013_2,g_master.l_report_date)
        RETURNING g_sub_success,l_write
   IF NOT g_sub_success THEN
      LET g_success = 'N'
   END IF

   IF g_success = 'Y' THEN
      IF l_write = 'Y' THEN
         CALL s_transaction_end('Y','0')
         LET g_bgjob = "N"
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00230'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET g_bgjob = "Y"
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00187'   #單據產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET g_bgjob = "Y"
   END IF
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aisp440_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp440.get_buffer" >}
PRIVATE FUNCTION aisp440_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.isaa001 = p_dialog.getFieldBuffer('isaa001')
   LET g_master.isaa012 = p_dialog.getFieldBuffer('isaa012')
   LET g_master.isaa013 = p_dialog.getFieldBuffer('isaa013')
   LET g_master.isaa013_2 = p_dialog.getFieldBuffer('isaa013_2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp440.msgcentre_notify" >}
PRIVATE FUNCTION aisp440_msgcentre_notify()
 
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
 
{<section id="aisp440.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL aisp440_qbe_clear()
# Date & Author..: 2015/03/17 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp440_qbe_clear()
DEFINE l_cnt        LIKE type_t.num10
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL

   LET g_master.isaa001 = g_site
   #申報單位須存在aisi010裡面，沒有給空
   SELECT COUNT(*) INTO l_cnt
     FROM isaa_t
    WHERE isaaent = g_enterprise
      AND isaa001 = g_master.isaa001
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      LET g_master.isaa001 = ''
   ELSE
      #用申報單位取得營運據點&相關資料 #150422-00012#1 add
      CALL s_aisp440_get_site_info(g_master.isaa001) RETURNING g_wc_isaosite,g_ooef017,g_ooef019,g_isaa007
   END IF
   CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
   LET g_master.isaa012 = YEAR(g_today)
   
   #150422-00012#1 add ------
   CALL cl_set_comp_entry("isaa013_2",TRUE)
   IF g_isaa007 = 2 THEN
      CALL cl_set_comp_entry("isaa013_2",FALSE)
   END IF
   #150422-00012#1 add end---
   
   DISPLAY BY NAME g_master.isaa001,g_master.isaa001_desc,g_master.isaa012
   
END FUNCTION

#end add-point
 
{</section>}
 
