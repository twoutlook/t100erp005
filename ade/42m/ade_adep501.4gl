#該程式未解開Section, 採用最新樣板產出!
{<section id="adep501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-07-16 09:59:13), PR版次:0004(2016-12-19 20:13:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: adep501
#+ Description: 營業日期關帳作業
#+ Creator....: 06137(2015-07-15 14:36:08)
#+ Modifier...: 06137 -SD/PR- 08172
 
{</section>}
 
{<section id="adep501.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161206-00005#2    2016/12/07   by 02481  若aoos020参数S-CIR-2037勾选，则呼叫pos服务，检查门店日结是否有上传
#161216-00023#1    2016/12/16   by 08172  营运日期关账的逻辑，目前判断的日期给值不正确，改为ooab002现有营业日期
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
     ooabsite           LIKE ooab_t.ooabsite,
     ooab002            LIKE type_t.dat,
     ooab002_1          LIKE type_t.dat,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       ooabsite LIKE type_t.chr10, 
   ooabsite_desc LIKE type_t.chr80, 
   ooab002 LIKE type_t.dat, 
   ooab002_1 LIKE type_t.dat, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adep501.main" >}
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
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep501_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep501 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep501_init()
 
      #進入選單 Menu (="N")
      CALL adep501_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi500_drop_temp() RETURNING l_success 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep501
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep501.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep501_init()
 
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
 
{<section id="adep501.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep501_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE  l_errno   LIKE type_t.chr10
   DEFINE l_ooab002  LIKE type_t.dat
   DEFINE l_date     LIKE type_t.dat
   DEFINE l_cnt      LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.ooabsite,g_master.ooab002,g_master.ooab002_1 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooabsite
            
            #add-point:AFTER FIELD ooabsite name="input.a.ooabsite"
            IF NOT cl_null(g_master.ooabsite) THEN  
              CALL s_aooi500_chk(g_prog,'ooabsite',g_master.ooabsite,g_site) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_master.ooabsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
           
                  NEXT FIELD CURRENT
               END IF
               
               CALL cl_get_para(g_enterprise,g_master.ooabsite,'S-CIR-0003') RETURNING g_master.ooab002
               DISPLAY BY NAME g_master.ooab002
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF  
            CALL adep501_ooabsite_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooabsite
            #add-point:BEFORE FIELD ooabsite name="input.b.ooabsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooabsite
            #add-point:ON CHANGE ooabsite name="input.g.ooabsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooab002
            #add-point:BEFORE FIELD ooab002 name="input.b.ooab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooab002
            
            #add-point:AFTER FIELD ooab002 name="input.a.ooab002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooab002
            #add-point:ON CHANGE ooab002 name="input.g.ooab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooab002_1
            #add-point:BEFORE FIELD ooab002_1 name="input.b.ooab002_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooab002_1
            
            #add-point:AFTER FIELD ooab002_1 name="input.a.ooab002_1"
            IF NOT cl_null(g_master.ooab002_1) THEN          
               IF NOT adep501_deba_chk(g_master.ooabsite,g_master.ooab002_1) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'ade-00146'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_master.ooab002_1
                  CALL cl_err()
                  NEXT FIELD CURRENT               
               END IF          
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooab002_1
            #add-point:ON CHANGE ooab002_1 name="input.g.ooab002_1"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.ooabsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooabsite
            #add-point:ON ACTION controlp INFIELD ooabsite name="input.c.ooabsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.ooabsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
 
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'ooabsite',g_site,'i')
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_master.ooabsite = g_qryparam.return1              

            DISPLAY g_master.ooabsite TO ooabsite              #

            NEXT FIELD ooabsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooab002
            #add-point:ON ACTION controlp INFIELD ooab002 name="input.c.ooab002"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooab002_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooab002_1
            #add-point:ON ACTION controlp INFIELD ooab002_1 name="input.c.ooab002_1"
            
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
            CALL adep501_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL s_aooi500_default(g_prog,'ooabsite',g_site)
                RETURNING l_success,g_master.ooabsite
            CALL adep501_ooabsite_ref()
            CALL cl_get_para(g_enterprise,g_master.ooabsite,'S-CIR-0003') RETURNING g_master.ooab002
            DISPLAY BY NAME g_master.ooabsite,g_master.ooab002
            LET g_master.ooab002_1 = g_today
            DISPLAY BY NAME g_master.ooab002_1            
            #CALL cl_get_para(g_enterprise,g_master.ooabsite,'S-MFG-0031') RETURNING l_ooab002
            #IF g_today >= g_master.ooab002 AND g_today <= l_ooab002 THEN
            #   LET g_master.ooab002_1 = g_today
            #   DISPLAY BY NAME g_master.ooab002_1
            #ELSE
            #   LET g_master.ooab002_1 = ''
            #   DISPLAY BY NAME g_master.ooab002_1
            #END IF
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
         CALL adep501_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.ooabsite = g_master.ooabsite
      LET lc_param.ooab002 = g_master.ooab002
      LET lc_param.ooab002_1 = g_master.ooab002_1
      LET lc_param.wc = g_master.wc
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
                 CALL adep501_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep501_transfer_argv(ls_js)
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
 
{<section id="adep501.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep501_transfer_argv(ls_js)
 
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
 
{<section id="adep501.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep501_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_moddt       DATETIME YEAR TO SECOND
   DEFINE l_loop        LIKE type_t.num5   #160225-00040#18 Add By Ken 160314
   DEFINE l_msg         STRING             #160225-00040#18 Add By Ken 160314  
   DEFINE l_checkpos    LIKE type_t.chr1   #161206-00005#2--add 
   DEFINE l_flag        LIKE type_t.chr1   #161206-00005#2--add 失败则返回
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #160225-00040#4 Add By Ken 160314(S)
      LET l_loop = 2
      CALL cl_progress_bar_no_window(l_loop)  
      #160225-00040#4 Add By Ken 160314(E)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep501_process_cs CURSOR FROM ls_sql
#  FOREACH adep501_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040#4 Add By Ken 160314(S)   更新日結關帳日期
   LET l_msg = cl_getmsg('ade-00168',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#4 Add By Ken 160314(e)   
   
   #如果傳入參數營業日期為空時，用原營業日期+1
   IF cl_null(lc_param.ooab002_1) THEN   
      LET lc_param.ooab002_1 = lc_param.ooab002 + 1
   END IF   
   
   #161206-00005#2---add--begin-------------
   #若aoos020参数S-CIR-2037勾选，则呼叫pos服务，检查门店日结是否有上传
   #参数=Y 需呼叫POS 服务。若返回值等于N，则不继续往下走逻辑
   #参数=N 则不呼叫POS服务。走原来逻辑
   LET l_checkpos = cl_get_para(g_enterprise,g_site,'S-CIR-2037')
   IF l_checkpos = 'Y' THEN
      LET l_flag = 'Y'
      CALL cl_err_collect_init()
      #161216-00023#1 -s by 08172
#      IF NOT s_check_pos_upload_json('i',lc_param.ooabsite,lc_param.ooab002_1) THEN
      IF NOT s_check_pos_upload_json('i',lc_param.ooabsite,lc_param.ooab002_1-1) THEN
      #161216-00023#1 -e by 08172
         LET l_flag = 'N'
      END IF
      CALL cl_err_collect_show()
      IF l_flag = 'N' THEN
         #add by 08172 -S
         LET l_msg = cl_getmsg('ade-00167',g_lang)
         CALL cl_progress_no_window_ing(l_msg) 
         #add by 08172 -E
         RETURN
      END IF
   END IF
   #161206-00005#2---add--end---------------
   IF adep501_deba_chk(lc_param.ooabsite,lc_param.ooab002_1) THEN   #先檢查大於等於要變更的營業日期有沒有日結資料  如有的話不可變更營業日期
      LET l_moddt = cl_get_current()
      UPDATE ooab_t 
        SET ooab002 = lc_param.ooab002_1,
            ooabmodid = g_user,
            ooabmoddt = l_moddt 
      WHERE ooabent = g_enterprise 
        AND ooabsite = lc_param.ooabsite 
        AND ooab001 = 'S-CIR-0003'
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  'ade-00146'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_master.ooab002_1
      CALL cl_err()              
   END IF
   
   #160225-00040#4 Add By Ken 160314(S)
   LET l_msg = cl_getmsg('ade-00167',g_lang)
   CALL cl_progress_no_window_ing(l_msg) 
   #160225-00040#4 Add By Ken 160314(E)
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
   CALL adep501_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep501.get_buffer" >}
PRIVATE FUNCTION adep501_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.ooabsite = p_dialog.getFieldBuffer('ooabsite')
   LET g_master.ooab002 = p_dialog.getFieldBuffer('ooab002')
   LET g_master.ooab002_1 = p_dialog.getFieldBuffer('ooab002_1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adep501.msgcentre_notify" >}
PRIVATE FUNCTION adep501_msgcentre_notify()
 
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
 
{<section id="adep501.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 取營業據點說明
# Memo...........:
# Usage..........: CALL adep501_ooabsite_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/07/15 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep501_ooabsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.ooabsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.ooabsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.ooabsite_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查是否有日結資料
# Memo...........:
# Usage..........: CALL adep501_deba_chk(p_ooabsite,p_ooab002_1)
#                  RETURNING r_success
# Input parameter: p_ooabsite     營運組織
#                : p_ooab002_1    新營業日期
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/07/15 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep501_deba_chk(p_ooabsite,p_ooab002_1)
DEFINE p_ooabsite            LIKE ooab_t.ooabsite
DEFINE p_ooab002_1           LIKE ooab_t.ooab002
DEFINE l_cnt                 LIKE type_t.num5
DEFINE r_success             LIKE type_t.num5

   LET l_cnt = 0
   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt 
     FROM deba_t 
    WHERE debaent = g_enterprise 
      AND debasite = p_ooabsite 
      AND deba002 >= p_ooab002_1
      
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF

   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
