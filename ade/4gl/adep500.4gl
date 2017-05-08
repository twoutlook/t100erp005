#該程式未解開Section, 採用最新樣板產出!
{<section id="adep500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-12-22 19:29:11), PR版次:0004(2017-01-03 09:54:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: adep500
#+ Description: 日結關帳作業
#+ Creator....: 01533(2015-03-24 14:52:19)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="adep500.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161216-00004#4 2016/12/22 by sakura 增加集團參數(跨門店操作E-CIR-0078)設定處理
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
        ooabsite LIKE type_t.chr10,   #161216-00004#4 by sakura add
        ooab002 LIKE type_t.dat,      #161216-00004#4 by sakura add
        ooab002_1 LIKE type_t.dat,    #161216-00004#4 by sakura add
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       ooef001 LIKE ooef_t.ooef001, 
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
DEFINE g_para                LIKE type_t.chr5   #161216-00004#4 by sakura add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adep500.main" >}
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
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep500_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep500 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep500_init()
 
      #進入選單 Menu (="N")
      CALL adep500_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi500_drop_temp() RETURNING l_success 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep500
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep500.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep500_init()
 
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
   #161216-00004#4 by sakura add(S)
   LET g_para = ''
   LET g_para = cl_get_para(g_enterprise,"","E-CIR-0078")
   IF cl_null(g_para) THEN
      LET g_para = 'N'
   END IF
   IF g_para = "N" THEN
      CALL cl_set_comp_visible("group_qbe",FALSE)
   ELSE
      CALL cl_set_comp_visible("lbl_ooabsite,ooabsite,ooabsite_desc,lbl_ooab002,ooab002",FALSE)
   END IF
   DISPLAY '跨門店操作(E-CIR-0078)：',g_para
   #161216-00004#4 by sakura add(E)
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adep500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep500_ui_dialog()
 
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
               
               CALL cl_get_para(g_enterprise,g_master.ooabsite,'S-CIR-0001') RETURNING g_master.ooab002
               DISPLAY BY NAME g_master.ooab002
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF  
            CALL adep500_ooabsite_ref()
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
            IF g_para = 'N' THEN   #161216-00004#4 by sakura add
               IF NOT cl_null(g_master.ooab002_1) THEN          
                  IF g_master.ooab002_1 < g_master.ooab002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00342'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD ooab002_1
                  END IF 
                 CALL cl_get_para(g_enterprise,g_master.ooabsite,'S-MFG-0031') RETURNING l_ooab002
                  IF NOT cl_null(l_ooab002) THEN
                     LET l_date =  l_ooab002   
                     IF g_master.ooab002_1 > l_date THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ain-00534'                   
                        LET g_errparam.extend = ''
                        LET g_errparam.replace[1] =l_ooab002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        NEXT FIELD ooab002_1
                     END IF
                  END IF
               END IF
            END IF   #161216-00004#4 by sakura add
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
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON ooef001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooef001
            #add-point:BEFORE FIELD ooef001 name="construct.b.ooef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooef001
            
            #add-point:AFTER FIELD ooef001 name="construct.a.ooef001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooef001
            #add-point:ON ACTION controlp INFIELD ooef001 name="construct.c.ooef001"
            #161216-00004#4 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #程式會異動的主資料為deba_t，故在這邊替換為debasite
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooef001  #顯示到畫面上
            NEXT FIELD ooef001                     #返回原欄位
            #161216-00004#4 by sakura add(E)
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
            CALL adep500_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            IF g_para = "N" THEN   #161216-00004#4 by sakura add
               CALL s_aooi500_default(g_prog,'ooabsite',g_site)
                   RETURNING l_success,g_master.ooabsite
               CALL adep500_ooabsite_ref()
            END IF   #161216-00004#4 by sakura add
            CALL cl_get_para(g_enterprise,g_master.ooabsite,'S-CIR-0001') RETURNING g_master.ooab002
            DISPLAY BY NAME g_master.ooabsite,g_master.ooab002
            CALL cl_get_para(g_enterprise,g_master.ooabsite,'S-MFG-0031') RETURNING l_ooab002
            
            #161216-00004#4 by sakura add(S)
            IF g_para = "Y" THEN 
               CALL s_aooi500_default(g_prog,'ooabsite',g_site)
                   RETURNING l_success,g_master.ooef001
               DISPLAY BY NAME g_master.ooef001
            END IF
            #161216-00004#4 by sakura add(E)
            
            IF g_today >= g_master.ooab002 AND g_today <= l_ooab002 THEN
               LET g_master.ooab002_1 = g_today
               DISPLAY BY NAME g_master.ooab002_1
            ELSE
               LET g_master.ooab002_1 = ''
               DISPLAY BY NAME g_master.ooab002_1
            END IF
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
         CALL adep500_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #161216-00004#4 by sakura add(S)
      LET lc_param.ooabsite = g_master.ooabsite
      LET lc_param.ooab002 = g_master.ooab002
      LET lc_param.ooab002_1 = g_master.ooab002_1
      #161216-00004#4 by sakura add(E)      
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
                 CALL adep500_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep500_transfer_argv(ls_js)
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
 
{<section id="adep500.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep500_transfer_argv(ls_js)
 
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
 
{<section id="adep500.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep500_process(ls_js)
 
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
   DEFINE l_loop        LIKE type_t.num5   #160225-00040#4 Add By Ken 160314
   DEFINE l_msg         STRING             #160225-00040#4 Add By Ken 160314
   #161216-00004#4 by sakura add(S)
   DEFINE l_sql         STRING
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_ooabsite    LIKE ooab_t.ooabsite
   DEFINE l_off         LIKE type_t.dat
   DEFINE l_stock_off   LIKE type_t.dat
   DEFINE l_colname_1   STRING
   DEFINE l_colname_2   STRING   
   DEFINE l_comment_1   STRING
   DEFINE l_comment_2   STRING   
   DEFINE l_where       STRING
   #161216-00004#4 by sakura add(E)
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #161216-00004#4 by sakura add(S)
   #檢查是否有輸入必要條件 
   IF cl_null(lc_param.ooab002_1) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00186'   #"日結關帳日期"不能為空值！
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN      
   END IF
   IF g_para = 'Y' THEN
      IF cl_null(lc_param.wc) OR lc_param.wc = " 1=1" OR lc_param.wc = "ooef001 like '%'"THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ade-00188"   #營運組織不可為空或「*」！
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END IF
   #161216-00004#4 by sakura add(E)
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #161216-00004#4 by sakura mark(S)
      ##160225-00040#4 Add By Ken 160314(S)
      ##LET l_loop = 2
      #CALL cl_progress_bar_no_window(l_loop)
      ##160225-00040#4 Add By Ken 160314(E)
      #161216-00004#4 by sakura mark(E)
      
      #161216-00004#4 by sakura add(S)
      IF g_para = 'Y' THEN
         LET l_where = s_aooi500_sql_where(g_prog,'ooabsite')
         LET l_where = cl_replace_str(l_where,"ooabsite","ooef001")
         LET l_sql = "SELECT COUNT(ooef001) ",
                     "  FROM ooef_t ",
                     " WHERE ooefent = ",g_enterprise,
                     "   AND ",lc_param.wc,
                     "   AND ",l_where
                     
         PREPARE adep500_cnt_ooef001 FROM l_sql
         LET l_cnt = 0
         EXECUTE adep500_cnt_ooef001 INTO l_cnt
         LET l_loop = l_cnt + 2
      ELSE
         LET l_loop = 2 
      END IF
      CALL cl_progress_bar_no_window(l_loop)
      #161216-00004#4 by sakura add(E)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep500_process_cs CURSOR FROM ls_sql
#  FOREACH adep500_process_cs INTO
   #add-point:process段process name="process.process"
   #161216-00004#4 by sakura -----------------------------------------mark(S)
   ##160225-00040#4 Add By Ken 160314(S)   更新日結關帳日期
   #LET l_msg = cl_getmsg('ade-00166',g_lang)
   #CALL cl_progress_no_window_ing(l_msg)
   ##160225-00040#4 Add By Ken 160314(e)
   #
   #LET l_moddt = cl_get_current()
   #UPDATE ooab_t
   #  SET ooab002 = g_master.ooab002_1,
   #      ooabmodid = g_user,
   #      ooabmoddt = l_moddt
   #WHERE ooabent = g_enterprise AND ooabsite = g_master.ooabsite AND ooab001 = 'S-CIR-0001'
   #
   ##160225-00040#4 Add By Ken 160314(S)
   #LET l_msg = cl_getmsg('ade-00167',g_lang)
   #CALL cl_progress_no_window_ing(l_msg)
   ##160225-00040#4 Add By Ken 160314(E)
   #161216-00004#4 by sakura -----------------------------------------mark(E)
   
   #161216-00004#4 by sakura -----------------------------------------add(S)
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('ade-00166',g_lang)
      CALL cl_progress_no_window_ing(l_msg)
   END IF
   CALL cl_err_collect_init()   
   IF g_para = 'Y' THEN
      LET l_moddt = cl_get_current()
      
      #匯總訊息增加顯示欄位:營運組織
      CALL s_azzi902_get_gzzd(g_prog,"lbl_ooabsite") RETURNING l_colname_1, l_comment_1
      LET g_coll_title[1] = l_colname_1
      #匯總訊息增加顯示欄位:日結關帳日期
      CALL s_azzi902_get_gzzd(g_prog,"lbl_ooab002_1") RETURNING l_colname_2, l_comment_2
      LET g_coll_title[2] = l_colname_2
      
      LET l_where = s_aooi500_sql_where(g_prog,'ooabsite')
      LET l_where = cl_replace_str(l_where,"ooabsite","ooef001")
      LET l_sql = "SELECT ooef001 ",
                  "  FROM ooef_t ",
                  " WHERE ooefent = ",g_enterprise,
                  "   AND ",lc_param.wc,
                  "   AND ",l_where
      PREPARE adep500_ooef001_prep1 FROM l_sql
      DECLARE adep500_ooef001_cur1 CURSOR WITH HOLD FOR adep500_ooef001_prep1
      
      FOREACH adep500_ooef001_cur1 INTO l_ooabsite    
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE
            LET g_errparam.coll_vals[1] = ""
            LET g_errparam.coll_vals[2] = ""            
            CALL cl_err()
            EXIT FOREACH
         END IF
         CALL s_transaction_begin()
         
         IF g_bgjob <> "Y" THEN
            LET l_msg = l_ooabsite,cl_getmsg('ade-00166',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         
         LET l_off = ''
         LET l_stock_off = ''
         CALL cl_get_para(g_enterprise,l_ooabsite,'S-CIR-0001') RETURNING l_off         #門店日結關帳日期
         CALL cl_get_para(g_enterprise,l_ooabsite,'S-MFG-0031') RETURNING l_stock_off   #庫存關帳日期
         #DISPLAY '門店日結關帳日期：',l_off,'庫存關帳日期：',l_stock_off
         #檢查"門店日結關帳日期"是否有設定
         IF cl_null(l_off) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ade-00184'   #"門店日結關帳日期"未設定！
            LET g_errparam.extend = ''
            LET g_errparam.coll_vals[1] = l_ooabsite
            LET g_errparam.coll_vals[2] = lc_param.ooab002_1            
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH             
         END IF
         IF lc_param.ooab002_1 < l_off THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00342'   #輸入關帳日期不可小於當前關帳日期！
            LET g_errparam.extend = ''
            LET g_errparam.coll_vals[1] = l_ooabsite
            LET g_errparam.coll_vals[2] = lc_param.ooab002_1
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH               
         END IF         
         #檢查"庫存關帳日期"是否有設定
         IF cl_null(l_stock_off) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ade-00185'   #"庫存關帳日期"未設定！
            LET g_errparam.extend = ''
            LET g_errparam.coll_vals[1] = l_ooabsite
            LET g_errparam.coll_vals[2] = lc_param.ooab002_1            
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH         
         END IF
         IF lc_param.ooab002_1 > l_stock_off THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00534'   #輸入的關帳日期不可大於庫存關帳日期！               
            LET g_errparam.extend = ''
            LET g_errparam.replace[1] = l_stock_off
            LET g_errparam.coll_vals[1] = l_ooabsite
            LET g_errparam.coll_vals[2] = lc_param.ooab002_1            
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH
         END IF
         #更新日結關帳日期
         UPDATE ooab_t 
           SET ooab002 = lc_param.ooab002_1,
               ooabmodid = g_user,
               ooabmoddt = l_moddt
         WHERE ooabent = g_enterprise 
           AND ooabsite = l_ooabsite
           AND ooab001 = 'S-CIR-0001'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code   = 'sub-00034'   #資料更新失敗                  
            LET g_errparam.extend = ""
            LET g_errparam.coll_vals[1] = l_ooabsite
            LET g_errparam.coll_vals[2] = lc_param.ooab002_1            
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH
         ELSE
            CALL s_transaction_end('Y','0')
            CONTINUE FOREACH
         END IF         
      END FOREACH
   ELSE
      LET l_moddt = cl_get_current()
      UPDATE ooab_t 
         SET ooab002 = lc_param.ooab002_1,
             ooabmodid = g_user,
             ooabmoddt = l_moddt 
       WHERE ooabent = g_enterprise 
         AND ooabsite = lc_param.ooabsite 
         AND ooab001 = 'S-CIR-0001'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code   = 'sub-00034'   #資料更新失敗                  
         LET g_errparam.extend = ""
         LET g_errparam.coll_vals[1] = lc_param.ooabsite
         LET g_errparam.coll_vals[2] = lc_param.ooab002_1         
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF         
   END IF
   
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('std-00012',g_lang)   
      DISPLAY l_msg ,100
           TO stagenow,stagecomplete
      CALL ui.Interface.refresh()
   END IF   
   CALL cl_err_collect_show()
   #161216-00004#4 by sakura -----------------------------------------add
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
   CALL adep500_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep500.get_buffer" >}
PRIVATE FUNCTION adep500_get_buffer(p_dialog)
 
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
 
{<section id="adep500.msgcentre_notify" >}
PRIVATE FUNCTION adep500_msgcentre_notify()
 
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
 
{<section id="adep500.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION adep500_ooabsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.ooabsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.ooabsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.ooabsite_desc
END FUNCTION

#end add-point
 
{</section>}
 
