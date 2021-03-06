#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-01-18 14:24:17), PR版次:0005(2016-11-10 13:58:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: aisp510
#+ Description: 營業人分支機構配號檔及空白字軌匯出作業
#+ Creator....: 05016(2016-01-11 13:43:12)
#+ Modifier...: 05016 -SD/PR- 08171
 
{</section>}
 
{<section id="aisp510.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160516-00011#1  2016/05/16 By Hans     若目地資料夾不存在則建立該目錄
#161006-00005#26 2016/10/21 By Reanna   法人統編增加azzi800控卡
#161104-00024#10 2016/11/08 By 08171    程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#6  2016/11/10 By 08171    程式中INSERT時不可以用*的寫法，要一個一個欄位定義
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
      ooef002   LIKE type_t.chr500, 
      isae016   LIKE type_t.num5, 
      isae017   LIKE type_t.num5, 
      isae018   LIKE type_t.num5, 
      e0401     LIKE type_t.chr500, 
      e0402     LIKE type_t.chr500, 
      attection LIKE type_t.chr500, 
      stagenow  LIKE type_t.chr80,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       ooef002 LIKE type_t.chr20, 
   isae016 LIKE type_t.num5, 
   isae017 LIKE type_t.num5, 
   isae018 LIKE type_t.num5, 
   e0401 LIKE type_t.chr500, 
   e0402 LIKE type_t.chr500, 
   attection LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_isaa009     LIKE isaa_t.isaa009
DEFINE g_path_E0401  STRING
DEFINE g_path_E0402  STRING
DEFINE g_path        STRING
DEFINE g_wc_ooef017  STRING     #161006-00005#26
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp510.main" >}
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
      CALL aisp510_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp510 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp510_init()
 
      #進入選單 Menu (="N")
      CALL aisp510_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp510
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp510.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp510_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_path        STRING   
   DEFINE l_str         STRING
   DEFINE l_cmd         STRING 
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
   LET g_path = os.Path.join(os.Path.join(FGL_GETENV("TEMPDIR"),"eInvoice"),"UpCast")
   LET g_path_E0401 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2PMESSAGE"),"E0401"),"SRC") 
   LET g_path_E0402 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2PMESSAGE"),"E0402"),"SRC") 
   
   FOR l_i = 1 TO 2                                 
       CASE l_i
          WHEN 1   LET l_path = g_path_E0401
          WHEN 2   LET l_path = g_path_E0402
      END CASE
      IF NOT os.Path.exists(l_path) THEN
         #160516-00011#1---s---
         LET l_cmd = "cd tmp  " 
         RUN l_cmd
         CASE l_i
            WHEN 1
               LET l_cmd = "mkdir -p eInvoice/UpCast/B2PMESSAGE/E0401/SRC"                              
            WHEN 2 
               LET l_cmd = "mkdir -p eInvoice/UpCast/B2PMESSAGE/E0402/SRC"    
         END CASE          
         RUN l_cmd
         #LET l_str = l_str CLIPPED,"\n",l_path
         #160516-00011#1---e---
       END IF
   END FOR
   IF NOT cl_null(l_str) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-02917'
      LET g_errparam.extend =  l_str
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      EXIT PROGRAM
   END IF
   CALL s_fin_create_account_center_tmp()  #161006-00005#26
   CALl aisp510_default()   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp510_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.ooef002,g_master.isae016,g_master.isae017,g_master.isae018,g_master.e0401, 
             g_master.e0402 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooef002
            #add-point:BEFORE FIELD ooef002 name="input.b.ooef002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooef002
            
            #add-point:AFTER FIELD ooef002 name="input.a.ooef002"
            IF NOT cl_null(g_master.ooef002) THEN
                CALL aisp510_ooef002_chk() RETURNING g_sub_success,g_errno 
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_master.ooef002 = ''
                   NEXT FIELD CURRENT
                END IF
                #取得畫面上統編所屬法人(唯一)
                SELECT ooef001 INTO g_isaa009
                  FROM ooef_t  
                 WHERE ooefent = g_enterprise
                   AND ooef002 = g_master.ooef002
                   AND ooef003 = 'Y'
             END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooef002
            #add-point:ON CHANGE ooef002 name="input.g.ooef002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae016
            #add-point:BEFORE FIELD isae016 name="input.b.isae016"
       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae016
            
            #add-point:AFTER FIELD isae016 name="input.a.isae016"
            IF NOT cl_null(g_master.isae016) AND NOT cl_null(g_master.isae017) THEN
                CALL aisp510_get_isae018()            
                CALL aisp510_mon_chk() RETURNING g_sub_success,g_errno 
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_master.isae016 = ''
                   LET g_master.isae017 = ''
                   LET g_master.isae018 = ''
                   NEXT FIELD CURRENT
                END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae016
            #add-point:ON CHANGE isae016 name="input.g.isae016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae017
            #add-point:BEFORE FIELD isae017 name="input.b.isae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae017
            
            #add-point:AFTER FIELD isae017 name="input.a.isae017"
            IF NOT cl_null(g_master.isae016) AND NOT cl_null(g_master.isae017) THEN
                CALL aisp510_get_isae018()
                CALL aisp510_mon_chk() RETURNING g_sub_success,g_errno 
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_master.isae016 = ''
                   LET g_master.isae017 = ''
                   LET g_master.isae018 = ''
                   NEXT FIELD CURRENT
                END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae017
            #add-point:ON CHANGE isae017 name="input.g.isae017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isae018
            #add-point:BEFORE FIELD isae018 name="input.b.isae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isae018
            
            #add-point:AFTER FIELD isae018 name="input.a.isae018"
            IF NOT cl_null(g_master.isae016) AND NOT cl_null(g_master.isae017) AND NOT cl_null(g_master.isae018) THEN
                CALL aisp510_mon_chk() RETURNING g_sub_success,g_errno 
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_master.isae016 = ''
                   LET g_master.isae017 = ''
                   LET g_master.isae018 = ''
                   NEXT FIELD CURRENT
                END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isae018
            #add-point:ON CHANGE isae018 name="input.g.isae018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD e0401
            #add-point:BEFORE FIELD e0401 name="input.b.e0401"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD e0401
            
            #add-point:AFTER FIELD e0401 name="input.a.e0401"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE e0401
            #add-point:ON CHANGE e0401 name="input.g.e0401"
            IF g_master.e0401 = 'N' AND g_master.e0402 = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ais-00266'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_master.e0401 = 'Y'
               DISPLAY BY NAME g_master.e0401
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD e0402
            #add-point:BEFORE FIELD e0402 name="input.b.e0402"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD e0402
            
            #add-point:AFTER FIELD e0402 name="input.a.e0402"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE e0402
            #add-point:ON CHANGE e0402 name="input.g.e0402"
            IF g_master.e0401 = 'N' AND g_master.e0402 = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ais-00266'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_master.e0402 = 'Y'
               DISPLAY BY NAME g_master.e0402
            END IF
            #END add-point 
 
 
 
                     #Ctrlp:input.c.ooef002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooef002
            #add-point:ON ACTION controlp INFIELD ooef002 name="input.c.ooef002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.ooef002
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN (SELECT isaa001 FROM isaa_t WHERE isaaent = ",g_enterprise,
                                   "                                  AND (isaa009 = ooef001 OR isaa001 = ooef001 ))"
            LET g_qryparam.where = g_qryparam.where ," AND ooef001 IN ",g_wc_ooef017 CLIPPED  #161006-00005#26
            CALL q_ooef001_02()
            LET g_isaa009 = g_qryparam.return1
            LET g_master.ooef002 = g_qryparam.return2
            DISPLAY BY NAME g_master.ooef002
            NEXT FIELD ooef002
            #END add-point
 
 
         #Ctrlp:input.c.isae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae016
            #add-point:ON ACTION controlp INFIELD isae016 name="input.c.isae016"
            
            #END add-point
 
 
         #Ctrlp:input.c.isae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae017
            #add-point:ON ACTION controlp INFIELD isae017 name="input.c.isae017"
            
            #END add-point
 
 
         #Ctrlp:input.c.isae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isae018
            #add-point:ON ACTION controlp INFIELD isae018 name="input.c.isae018"
            
            #END add-point
 
 
         #Ctrlp:input.c.e0401
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD e0401
            #add-point:ON ACTION controlp INFIELD e0401 name="input.c.e0401"
            
            #END add-point
 
 
         #Ctrlp:input.c.e0402
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD e0402
            #add-point:ON ACTION controlp INFIELD e0402 name="input.c.e0402"
            
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
            CALL aisp510_get_buffer(l_dialog)
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
            CALL aisp510_default()
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
         CALL aisp510_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
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
                 CALL aisp510_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp510_transfer_argv(ls_js)
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
 
{<section id="aisp510.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp510_transfer_argv(ls_js)
 
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
 
{<section id="aisp510.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp510_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc      = lc_param.wc
      LET g_master.ooef002 = lc_param.ooef002
      LET g_master.isae016 = lc_param.isae016
      LET g_master.isae017 = lc_param.isae017
      LET g_master.isae018 = lc_param.isae018
      LET g_master.e0401 = lc_param.e0401
      LET g_master.e0402 = lc_param.e0402
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp510_process_cs CURSOR FROM ls_sql
#  FOREACH aisp510_process_cs INTO
   #add-point:process段process name="process.process"
   IF g_master.e0401 = 'Y' THEN   
      CALL aisp510_E0401()
   END IF
   IF g_master.e0402 = 'Y' THEN
      CALL aisp510_E0402()
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
   CALL aisp510_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp510.get_buffer" >}
PRIVATE FUNCTION aisp510_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.ooef002 = p_dialog.getFieldBuffer('ooef002')
   LET g_master.isae016 = p_dialog.getFieldBuffer('isae016')
   LET g_master.isae017 = p_dialog.getFieldBuffer('isae017')
   LET g_master.isae018 = p_dialog.getFieldBuffer('isae018')
   LET g_master.e0401 = p_dialog.getFieldBuffer('e0401')
   LET g_master.e0402 = p_dialog.getFieldBuffer('e0402')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp510.msgcentre_notify" >}
PRIVATE FUNCTION aisp510_msgcentre_notify()
 
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
 
{<section id="aisp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL aisp510_default()
# Date & Author..: 2016/1/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_default()
DEFINE l_str1  LIKE gzzd_t.gzzd005
DEFINE l_str2  LIKE gzzd_t.gzzd005
DEFINE l_str3  LIKE gzzd_t.gzzd005
DEFINE l_coution STRING

   LET g_master.ooef002 = ''
   LET g_master.isae016 = ''
   LET g_master.isae017 = ''
   LET g_master.isae018 = ''   
   LET g_master.e0401 = 'Y'
   LET g_master.e0402 = 'Y'
   SELECT gzzd005 INTO l_str1 FROM gzzd_t WHERE gzzd003 = 'lbl_str1' AND gzzd002 = g_dlang AND gzzd001 = 'aisp510'
   SELECT gzzd005 INTO l_str2 FROM gzzd_t WHERE gzzd003 = 'lbl_str2' AND gzzd002 = g_dlang AND gzzd001 = 'aisp510'
   SELECT gzzd005 INTO l_str3 FROM gzzd_t WHERE gzzd003 = 'lbl_str3' AND gzzd002 = g_dlang AND gzzd001 = 'aisp510'
   
   LET l_coution = l_str1,'\n','   ',l_str2,'\n','   ',l_str3
   LET g_master.attection = l_coution
   
   #161006-00005#26 add ------
   CALL s_fin_account_center_sons_query('3',g_site,g_today,'')
   CALL s_fin_account_center_comp_str() RETURNING g_wc_ooef017
   CALL s_fin_get_wc_str(g_wc_ooef017) RETURNING g_wc_ooef017
   #161006-00005#26 add end---
   
   DISPLAY BY NAME g_master.e0401,g_master.e0402,g_master.isae017,g_master.isae016,g_master.isae018,g_master.attection 

END FUNCTION

################################################################################
# Descriptions...: 法人編碼檢核
# Memo...........:
# Usage..........: CALL aisp510_ooef002_chk()
# Date & Author..: 2016/01/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_ooef002_chk()
DEFINE l_count    LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5
DEFINE r_errno    LIKE gzze_t.gzze001

   LET l_count = 0 LET r_success = TRUE

   #法人統編是否存在aisi010中
   SELECT COUNT(*) INTO l_count
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef002 = g_master.ooef002
      AND ooef003 = 'Y'
      AND ooef001 IN (SELECT isaa001 FROM isaa_t  
                       WHERE isaaent = g_enterprise
                         AND (isaa009 = ooef001 OR isaa001 = ooef001 )) 

  IF cl_null(l_count) THEN LET l_count = 0 END IF
  
  IF l_count = 0 THEN
     LET r_success = FALSE
     LET r_errno = 'ais-00259'
  END IF
  
  RETURN r_success,r_errno


END FUNCTION

################################################################################
# Descriptions...: 法人編碼發票年月檢核
# Memo...........:
# Usage..........: CALL aisp510_mon_chk()
# Date & Author..: 2016/01/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_mon_chk()
DEFINE l_count    LIKE type_t.num5
DEFINE r_success  LIKE type_t.num5
DEFINE r_errno    LIKE gzze_t.gzze001

   LET l_count = 0 LET r_success = TRUE
   
   #存aisi055中總機構底下的組織並且是電子發票
   SELECT COUNT(*) INTO l_count FROM isae_t
    WHERE isaeent = g_enterprise
      AND isae016 = g_master.isae016
      AND isae017 = g_master.isae017
      AND isae018 = g_master.isae018
      AND isae005 = 'Y'
      AND isaesite IN (SELECT isaa001 FROM isaa_t
                        WHERE isaaent = g_enterprise
                          AND (isaa009 = g_isaa009 OR isaa001 = g_isaa009))
   IF cl_null(l_count) THEN LET l_count = 0 END IF
  
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno = 'ais-00278'
   END IF
  
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 取得截止月份
# Memo...........:
# Usage..........: CALL aisp510_get_isae018()
# Date & Author..: 2016/01/03 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_get_isae018()

   SELECT DISTINCT isae018 INTO g_master.isae018
     FROM isae_t
    WHERE isaeent = g_enterprise
      AND isae016 = g_master.isae016
      AND isae017 = g_master.isae017
      AND isaecomp = g_isaa009 

   DISPLAY BY NAME g_master.isae018

END FUNCTION

################################################################################
# Descriptions...: 新增記錄檔
# Memo...........:
# Usage..........: CALL aisp510_insisav()
# Date & Author..: 201601/13 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_ins_isav_t(p_flag,p_type,p_isaosite,p_isav007,p_file_name,p_str)
DEFINE p_flag     LIKE type_t.chr1
DEFINE p_type     LIKE type_t.chr10
DEFINE p_isaosite LIKE isao_t.isaosite  #營運據點
DEFINE p_isav007  LIKE isav_t.isav007
DEFINE p_file_name     STRING
DEFINE l_date          DATETIME YEAR TO FRACTION(5)
#DEFINE l_isav  RECORD LIKE isav_t.* #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE l_isav RECORD  #電子發票匯出記錄檔
       isavent LIKE isav_t.isavent, #企業編號
       isavcomp LIKE isav_t.isavcomp, #法人
       isavsite LIKE isav_t.isavsite, #營運據點
       isavseq LIKE isav_t.isavseq, #發票歷程項次
       isav001 LIKE isav_t.isav001, #申報單位
       isav002 LIKE isav_t.isav002, #法人統編
       isav003 LIKE isav_t.isav003, #檔案格式
       isav004 LIKE isav_t.isav004, #匯出日期
       isav005 LIKE isav_t.isav005, #匯出時間
       isav006 LIKE isav_t.isav006, #發票編號
       isav007 LIKE isav_t.isav007, #發票號碼
       isav008 LIKE isav_t.isav008, #發票日期
       isav009 LIKE isav_t.isav009, #發票時間
       isav010 LIKE isav_t.isav010, #執行人員
       isav011 LIKE isav_t.isav011, #匯出xml檔名
       isav012 LIKE isav_t.isav012, #處理成功否
       isav013 LIKE isav_t.isav013  #訊息
END RECORD
#161104-00024#10 --e add
DEFINE p_str   STRING
DEFINE l_isav008 LIKE isav_t.isav008
   
   LET l_isav008 = MDY(g_master.isae017,1,g_master.isae016)
   LET l_date = cl_get_timestamp()
 
   LET l_isav.isavent  = g_enterprise
   LET l_isav.isavcomp = g_isaa009
   LET l_isav.isavsite = p_isaosite            
   LET l_isav.isavseq  = 0
   LET l_isav.isav001  = p_isaosite
   LET l_isav.isav002  = g_master.ooef002
   LET l_isav.isav003  = p_type
   LET l_isav.isav004  = g_today
   LET l_isav.isav005  = l_date
   LET l_isav.isav006  = ''
   LET l_isav.isav007  = p_isav007
   LET l_isav.isav008  = l_isav008
   LET l_isav.isav009  = ''
   LET l_isav.isav010  = g_user
   LET l_isav.isav011  = p_file_name
   LET l_isav.isav012  = p_flag
   LET l_isav.isav013  = p_str
   
  #INSERT INTO isav_t VALUES(l_isav.*) #161108-00017#6 mark
   #161108-00017#6 --s add
   INSERT INTO isav_t(isavent,isavcomp,isavsite,isavseq,isav001,
                      isav002,isav003,isav004,isav005,isav006,
                      isav007,isav008,isav009,isav010,isav011,
                      isav012,isav013)
   VALUES(l_isav.isavent,l_isav.isavcomp,l_isav.isavsite,l_isav.isavseq,l_isav.isav001,
          l_isav.isav002,l_isav.isav003,l_isav.isav004,l_isav.isav005,l_isav.isav006,
          l_isav.isav007,l_isav.isav008,l_isav.isav009,l_isav.isav010,l_isav.isav011,
          l_isav.isav012,l_isav.isav013)
   #161108-00017#6 --e add
   

END FUNCTION

################################################################################
# Descriptions...: 產生E0401分支機構配號檔
# Memo...........:
# Usage..........: CALL aisp510_E0401()
# Date & Author..: 2016/01/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_E0401()
DEFINE l_isao001      LIKE isao_t.isao001  #納稅人識別號
DEFINE l_isaosite     LIKE isao_t.isaosite
DEFINE l_isaecomp     LIKE isae_t.isaecomp 
DEFINE l_isac008      LIKE isac_t.isac008
DEFINE l_ooef002      CHAR(10) #分支機構之統一編號
DEFINE l_invoicetype  CHAR(2)  #發票類別
DEFINE l_month        STRING
DEFINE l_isae007      CHAR(2)  #發票字軌
DEFINE l_yearmonth    STRING   #畫面.月份(迄)
DEFINE l_isae009      CHAR(8)  #最大號
DEFINE l_isae010      CHAR(8)  #最小號
DEFINE l_gzzd005      LIKE gzzd_t.gzzd005
DEFINE l_flag         LIKE type_t.chr1

DEFINE l_str          STRING
DEFINE l_wstr         STRING
DEFINE l_sql          STRING
DEFINE l_path         STRING
DEFINE l_path_E0401   STRING
DEFINE ch              base.Channel
DEFINE ls_source_file  STRING
DEFINE l_file_name     STRING
DEFINE l_cmd           STRING
DEFINE l_exppath       STRING
DEFINE l_mesg          STRING

   LET l_flag = 'N'   
   LET l_path = os.Path.join(os.Path.join(FGL_GETENV("TEMPDIR"),"eInvoice"),"UpCast")
   LET l_path_E0401 = os.Path.join(os.Path.join(os.Path.join(l_path,"B2PMESSAGE"),"E0401"),"SRC") 
   
   
   LET l_sql = "   SELECT isao001,isaosite, isaecomp, isac008, isae007, MIN(isae009), MAX(isae010) ",
               "      FROM isae_t,isao_t,isac_t,ooef_t ",
               "     WHERE isaeent = isaoent AND isaeent = isacent AND isaeent = ooefent AND isaeent = '",g_enterprise,"' ",
               "       AND isae016 = '",g_master.isae016,"' AND isae017 = '",g_master.isae017,"' AND isae018 = '",g_master.isae018,"'  ",
               "       AND isaosite = isaesite AND isaesite = ooef001 AND isae005 = 'Y' ",
               "       AND ooef019 = isac001                                            ", 
               "       AND isao001 in (SELECT isaa002  ",
               "                         FROM isaa_t   ",
               "                        WHERE isaaent = '",g_enterprise,"'  AND isaa002 = isao001        ",
               "                         AND (isaa009 = '",g_isaa009,"' OR isaa001 ='",g_isaa009,"') )   ",                 
               "       AND isae004 = isac002                               ",
               "     GROUP BY isao001, isaosite, isaecomp, isac008,isae007 "

   PREPARE aisp510_e0401_prep_01 FROM l_sql
   DECLARE aisp510_e0401_curs_01 CURSOR FOR aisp510_e0401_prep_01
   FOREACH aisp510_e0401_curs_01 INTO l_isao001,l_isaosite,l_isaecomp,l_isac008,l_isae007,l_isae009,l_isae010                                 
      #取得分支機構之統一編號
      SELECT DISTINCT ooef002 INTO l_ooef002
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaosite 
       #取得發票類別
       SELECT gzcb003 INTO l_invoicetype
         FROM gzcb_t WHERE gzcb001 = '9734' AND gzcb002 = l_isac008
      
      CALL aisp510_field_chk('E0401',l_ooef002,l_invoicetype,l_isae007,l_isae009,l_isae010) 
         RETURNING g_sub_success,l_wstr
      IF NOT g_sub_success THEN 
         LET l_flag = 'N'
         CALL aisp510_ins_isav_t(l_flag,'E0401',' ',' ',' ',l_wstr)
         LET l_flag = 'Y'
         CONTINUE FOREACH
      END IF      
         
       LET l_yearmonth = g_master.isae016 - 1911 #發票期別
       LET l_month = g_master.isae018 #月
       LET l_month = l_month USING '&&'
       CASE l_month 
          WHEN 01  LET l_month = '02'
          WHEN 03  LET l_month = '04'
          WHEN 05  LET l_month = '06'
          WHEN 07  LET l_month = '08'
          WHEN 09  LET l_month = '10' 
          WHEN 11  LET l_month = '12'
       END CASE        
       LET l_yearmonth = l_yearmonth.trim() CLIPPED,l_month
       LET l_yearmonth = l_yearmonth.subString(1,5)
     
          
       #訊息類型+分支機構統一編號+發票期別+發票類別+發票號碼.xml
       #(例如 : E0401-28682266-10210-03-UP09790000.xml)
      LET l_file_name  = 'E0401' CLIPPED,'-',l_ooef002 CLIPPED,'-',l_yearmonth CLIPPED,'-',
                          l_invoicetype CLIPPED,'-',l_isae007 CLIPPED,l_isae009 
      LET l_file_name = l_file_name,'.XML'    
      LET ls_source_file = os.Path.join(l_path_E0401,l_file_name CLIPPED) #存放路徑          

      LET ch = base.Channel.create()     
         
      CALL ch.openFile(ls_source_file,"w")
      CALL ch.setDelimiter("")   
      
      LET l_str = '<?xml version="1.0" encoding="UTF-8"?>'
      CALL ch.write(l_str)
      LET l_str = '<BranchTrack xsi:schemaLocation="urn:GEINV:eInvoiceMessage:E0401:3.1 E0401.xsd" xmlns="urn:GEINV:eInvoiceMessage:E0401:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' #FUN-EC0040 add
      CALL ch.write(l_str)
      #發票資料
      LET l_str = '    <Main> '                                                     CALL ch.write(l_str)     
      LET l_str = "        <HeadBan>",g_master.ooef002 CLIPPED,"</HeadBan>"         CALL ch.write(l_str) #畫面.總公司統一編號
      LET l_str = "        <BranchBan>",l_ooef002 CLIPPED,"</BranchBan>"            CALL ch.write(l_str) #分支機構統一編號
      LET l_str = "        <InvoiceType>",l_invoicetype CLIPPED,"</InvoiceType>"    CALL ch.write(l_str) #發票類別
      LET l_str = "        <YearMonth>",l_yearmonth CLIPPED,"</YearMonth>"          CALL ch.write(l_str) #發票期別
      LET l_str = "        <InvoiceTrack>",l_isae007 CLIPPED,"</InvoiceTrack>"      CALL ch.write(l_str) #發票字軌
      LET l_str = "        <InvoiceBeginNo>",l_isae009 CLIPPED,"</InvoiceBeginNo>"  CALL ch.write(l_str) #發票起號
      LET l_str = "        <InvoiceEndNo>",l_isae010 CLIPPED,"</InvoiceEndNo>"      CALL ch.write(l_str) #發票迄號
      LET l_str = '    </Main> '                                                    CALL ch.write(l_str)
      #單身
      LET l_str = '    <Details> '                                                  CALL ch.write(l_str)
      LET l_sql = " SELECT isae009,isae010 ",
                  "   FROM isae_t ",
                  "  WHERE isaeent = '",g_enterprise,"'                    ",
                  "    AND isaecomp = '",l_isaecomp,"'                     ",
                  "    AND isaesite = '",l_isaosite,"'                     ",
                  "    AND isae016 = '",g_master.isae016,"'                ",
                  "    AND isae017 = '",g_master.isae017,"'                ",
                  "    AND isae018 = '",g_master.isae018,"'                ",
                  "    AND isae007 = '",l_isae007,"'                       " 
      PREPARE aisp510_e0401_prep_02 FROM l_sql
      DECLARE aisp510_e0401_curs_02 CURSOR FOR aisp510_e0401_prep_02
      FOREACH aisp510_e0401_curs_02 INTO l_isae009,l_isae010       
         LET l_str = "        <BranchTrackItem> "                                            CALL ch.write(l_str)
         LET l_str = "            <InvoiceBeginNo>",l_isae009 CLIPPED,"</InvoiceBeginNo>"    CALL ch.write(l_str)
         LET l_str = "            <InvoiceEndNo>", l_isae010 CLIPPED,"</InvoiceEndNo>"       CALL ch.write(l_str)
         LET l_str = "            <InvoiceBooklet>1</InvoiceBooklet>"                        CALL ch.write(l_str) 
         LET l_str = "        </BranchTrackItem>"                                            CALL ch.write(l_str) 
      END FOREACH
      LET l_str = '    </Details> '             CALL ch.write(l_str)
      LET l_str = '</BranchTrack> '             CALL ch.write(l_str)
      CALL ch.close()   
      IF os.Path.chrwx(l_file_name,511) THEN  END IF#chmod 777 => 7*8^2 +7*8^1 +7*8^      
      LET l_flag = 'Y'
      LET l_mesg = "Export E0401 xml file success." 
      CALL aisp510_ins_isav_t(l_flag,'E0401',l_isaosite,l_isae009,l_file_name,l_mesg)      
   END FOREACH
   IF l_flag = 'N' THEN
      CALL aisp510_field_chk('E0401',l_ooef002,l_invoicetype,l_isae007,l_isae009,l_isae010) 
         RETURNING g_sub_success,l_wstr
      CALL aisp510_ins_isav_t(l_flag,'E0401',' ',' ',' ',l_wstr)   
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 產生E0402 空白未使用字軌檔
# Memo...........:
# Usage..........: CALL aisp510_E0402()
# Date & Author..: 2016/01/13 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_E0402()
DEFINE l_str            STRING
DEFINE l_wstr           STRING
DEFINE l_sql            STRING
DEFINE l_path           STRING
DEFINE l_path_E0402     STRING
DEFINE l_wc_isaosite    STRING
DEFINE l_isaosite       LIKE isao_t.isaosite
DEFINE l_flag           LIKE type_t.chr1
DEFINE l_isao001        LIKE isao_t.isao001  #納稅人識別號   
DEFINE l_isaj004        LIKE isaj_t.isaj004  #發票類型
DEFINE l_isac008        LIKE isac_t.isac008  #發票連別
DEFINE l_ooef019        LIKE ooef_t.ooef019  #稅區
DEFINE l_ooef002        LIKE ooef_t.ooef002
DEFINE l_yearmonth      STRING   #畫面.月份(迄)
DEFINE l_month          STRING
DEFINE l_invoicetype    CHAR(2)   #發票類別
DEFINE l_track          CHAR(2) #發票字軌
DEFINE l_minisaj006     LIKE isaj_t.isaj006 #最小號
DEFINE l_minisaj006_str STRING
DEFINE l_maxisaj006     LIKE isaj_t.isaj006 
DEFINE l_gzzd005        LIKE gzzd_t.gzzd005
DEFINE l_maxisaj006_str STRING
DEFINE l_isae012        LIKE isae_t.isae012
DEFINE l_isae010        LIKE isae_t.isae010

DEFINE ch              base.Channel
DEFINE ls_source_file  STRING
DEFINE l_file_name     STRING
DEFINE l_cmd           STRING
DEFINE l_mesg          STRING

   LET l_flag = 'N'   
   LET l_path = os.Path.join(os.Path.join(FGL_GETENV("TEMPDIR"),"eInvoice"),"UpCast")
   LET l_path_E0402 = os.Path.join(os.Path.join(os.Path.join(l_path,"B2PMESSAGE"),"E0402"),"SRC") 
   
   LET l_sql = " SELECT isaosite,isao001,isaj004,SUBSTR(isaj006,1,2),MIN(isaj006),MAX(isaj006) ",
               "   FROM isao_t,isaj_t     ",
               "  WHERE isaoent = isajent  AND isaoent = '",g_enterprise,"'    ",
               "    AND isaosite = isajsite AND isajsite = isaosite            ",
               "    AND isao001 IN (SELECT isaa002 FROM isaa_t                 ",
               "                     WHERE isaaent = '",g_enterprise,"' AND isaa001 ='",g_isaa009,"')     ",  
               "    AND isaj001 = '1' AND isajstus = 'Y' AND isaj002 IS NULL AND isaj015 = 'D'            ",
               "    AND isaj019 = '",g_master.isae016,"'  AND isaj029 = 'Y'                               ",
               "    AND isaj020 BETWEEN '",g_master.isae017,"' AND  '",g_master.isae018,"'                ",
               "  GROUP BY isaosite,isao001,isaj004,SUBSTR(isaj006,1,2)                                   "
   PREPARE aisp510_e0402_prep_01 FROM l_sql
   DECLARE aisp510_e0402_curs_01 CURSOR FOR aisp510_e0402_prep_01
   FOREACH aisp510_e0402_curs_01 INTO l_isaosite,l_isao001,l_isaj004,l_track,l_minisaj006,l_maxisaj006
   
      #取得發票類別
      SELECT ooef002,ooef019 INTO l_ooef002,l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_isaosite
      SELECT isac008 INTO l_isac008 FROM isac_t WHERE isacent = g_enterprise AND isac001 = l_ooef019 AND isac002 = l_isaj004
      SELECT gzcb003 INTO l_invoicetype FROM gzcb_t WHERE gzcb001 = '9734' AND gzcb002 = l_isac008
      #發票最大最小號
      LET l_minisaj006_str = l_minisaj006
      LET l_minisaj006_str = l_minisaj006_str.subString(3,10)
      LET l_maxisaj006_str = l_maxisaj006
      LET l_maxisaj006_str = l_maxisaj006_str.subString(3,10)
      #發票期別
      LET l_yearmonth = g_master.isae016 - 1911 #發票期別
      LET l_month = g_master.isae018 #月
      LET l_month = l_month USING '&&'
      CASE l_month 
          WHEN 01  LET l_month = '02'  
          WHEN 03  LET l_month = '04' 
          WHEN 05  LET l_month = '06'
          WHEN 07  LET l_month = '08' 
          WHEN 09  LET l_month = '10'
          WHEN 11  LET l_month = '12'
       END CASE   
      LET l_yearmonth = l_yearmonth.trim() CLIPPED,l_month
      LET l_yearmonth = l_yearmonth.subString(1,5)
      #檢核
      CALL aisp510_field_chk('E0402',l_ooef002,l_invoicetype,l_track,l_minisaj006_str,l_maxisaj006_str) 
         RETURNING g_sub_success,l_wstr
      IF NOT g_sub_success THEN
         LET l_flag = 'N'
         CALL aisp510_ins_isav_t(l_flag,'E0402',' ',' ',' ',l_wstr)
         LET l_flag = 'Y'
         CONTINUE FOREACH
      END IF     
      #檔案名稱      
      LET l_file_name  = 'E0402' CLIPPED,'-',g_master.ooef002 CLIPPED,'-',l_yearmonth CLIPPED,'-',
                          l_invoicetype CLIPPED,'-',l_minisaj006 
      LET l_file_name = l_file_name,'.XML'    
      LET ls_source_file = os.Path.join(l_path_E0402,l_file_name CLIPPED) #存放路徑    
      #LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name CLIPPED) #存放路徑
      LET ch = base.Channel.create()      
      CALL ch.openFile(ls_source_file,"w")
      CALL ch.setDelimiter("")  
      LET l_str = '<?xml version="1.0" encoding="UTF-8"?>'           
      CALL ch.write(l_str)
      LET l_str = '<BranchTrackBlank xsi:schemaLocation="urn:GEINV:eInvoiceMessage:E0402:3.1 E0402.xsd" xmlns="urn:GEINV:eInvoiceMessage:E0402:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' #FUN-EC0040 add
      CALL ch.write(l_str)
      #發票資料
      LET l_str = '    <Main> '                                                                CALL ch.write(l_str)
      LET l_str = "        <HeadBan>",g_master.ooef002 CLIPPED,"</HeadBan>"                    CALL ch.write(l_str) #總公司統一編號
      LET l_str = "        <BranchBan>",l_ooef002 CLIPPED,"</BranchBan>"                       CALL ch.write(l_str)
      LET l_str = "        <InvoiceType>",l_invoicetype CLIPPED,"</InvoiceType>"               CALL ch.write(l_str)
      LET l_str = "        <YearMonth>",l_yearmonth CLIPPED,"</YearMonth>"                     CALL ch.write(l_str)
      LET l_str = "        <InvoiceTrack>",l_track CLIPPED,"</InvoiceTrack>"                   CALL ch.write(l_str) #發票字軌
      LET l_str = '    </Main> '                                                               CALL ch.write(l_str)                                                     
      LET l_str = '    <Details> '                                                             CALL ch.write(l_str)
      LET l_sql = " SELECT isae012,isae010 FROM isae_t            ",
                  "  WHERE isaeent = '",g_enterprise,"'           ",
                  "   AND isaesite IN ( SELECT isaosite FROM isaa_t,isao_t  ", 
                  "                      WHERE isaaent = isaoent AND isaoent = '",g_enterprise,"'  ",
                  "                        AND isaa002 = isao001 AND isaa001 ='",g_isaa009,"')     ",        
                  "    AND isae016 = '",g_master.isae016,"'                                        ",
                  "    AND isae017 = '",g_master.isae017,"'  AND isae018 = '",g_master.isae018,"'  ",               
                  "    AND isae005 = 'Y' AND isae007 = '",l_track,"'                               ",
                  "  ORDER BY isae012                                                              "
      PREPARE aisp510_getisae_prep01 FROM l_sql
      DECLARE aisp510_getisae_curs01 CURSOR FOR aisp510_getisae_prep01
      FOREACH aisp510_getisae_curs01 INTO l_isae012,l_isae010            
         LET l_str = '        <BranchTrackBlankItem> '                                            CALL ch.write(l_str)
         LET l_str = "            <InvoiceBeginNo>",l_isae012 CLIPPED,"</InvoiceBeginNo>"         CALL ch.write(l_str)
         LET l_str = "            <InvoiceEndNo>",l_isae010 CLIPPED,"</InvoiceEndNo>"             CALL ch.write(l_str)
         LET l_str = "        </BranchTrackBlankItem>"                                            CALL ch.write(l_str)
      END FOREACH
      LET l_str = '    </Details> '                                                               CALL ch.write(l_str)
      LET l_str = '</BranchTrackBlank>'                                                           CALL ch.write(l_str)
      CALL ch.close()
      LET l_flag = 'Y'
      LET l_mesg = "Export E0402 xml file success." 
      CALL aisp510_ins_isav_t(l_flag,'E0402',l_isaosite,l_minisaj006_str,l_file_name,l_mesg)
   END FOREACH
    IF l_flag = 'N' THEN
       CALL aisp510_field_chk('E0402',l_ooef002,l_invoicetype,l_track,l_minisaj006_str,l_maxisaj006_str) 
          RETURNING g_sub_success,l_wstr
       CALL aisp510_ins_isav_t(l_flag,'E0402',' ',' ',' ',l_wstr)   
   END IF

END FUNCTION

################################################################################
# Descriptions...: 欄位檢核
# Memo...........:
# Usage..........: CALL aisp510_field_chk(l_field)
# Date & Author..: 2016/02/01 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp510_field_chk(p_type,p_field)
DEFINE p_type LIKE type_t.chr10
DEFINE p_field RECORD
      ooef002    LIKE ooef_t.ooef002,
      gzcb003    LIKE gzcb_t.gzcb003,
      isae007    LIKE isae_t.isae007,
      isae009    LIKE isae_t.isae009,     
      isae010    LIKE isae_t.isae010
   END RECORD
DEFINE r_success LIKE type_t.num5
DEFINE r_msg     STRING

   LET r_success = TRUE
   LET r_msg = ''
   
   CASE p_type
      WHEN "E0401"    
         IF cl_null(p_field.ooef002) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:BranchBan(ooef002) is null."
            RETURN r_success,r_msg
         END IF

         IF cl_null(p_field.gzcb003) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceType(gzcb003) is null."
            RETURN r_success,r_msg
         END IF
         IF cl_null(p_field.isae007) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceTrack(isae007) is null."
            RETURN r_success,r_msg
         END IF
         IF cl_null(p_field.isae009) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceBeginNo(isae009) is null."
            RETURN r_success,r_msg
         END IF
         IF cl_null(p_field.isae010) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceEndNo(isae010) is null."
            RETURN r_success,r_msg
         END IF
      WHEN "E0402"     
         IF cl_null(p_field.ooef002) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:BranchBan(ooef002) is null."
            RETURN r_success,r_msg
         END IF

         IF cl_null(p_field.gzcb003) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceType(gzcb003) is null."
            RETURN r_success,r_msg
         END IF
         IF cl_null(p_field.isae007) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceTrack(isae007) is null."
            RETURN r_success,r_msg
         END IF
         IF cl_null(p_field.isae009) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceBeginNo(isae009) is null."
            RETURN r_success,r_msg
         END IF
         IF cl_null(p_field.isae010) THEN    
            LET r_success = FALSE
            LET r_msg = " Type:",p_type CLIPPED," Reason:InvoiceEndNo(isae010) is null."
            RETURN r_success,r_msg
         END IF
   END CASE
   
   RETURN r_success,r_msg

END FUNCTION

#end add-point
 
{</section>}
 
