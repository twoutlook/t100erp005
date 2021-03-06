#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp530.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-12-22 21:43:47), PR版次:0002(2017-02-14 10:19:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgp530
#+ Description: 銷售預算轉採購預算
#+ Creator....: 02599(2016-12-21 14:42:33)
#+ Modifier...: 02599 -SD/PR- 05016
 
{</section>}
 
{<section id="abgp530.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161229-00040#1 2017/01/11  By Hans 計價方式 =1.依採購單價  取採購單價 ELSE
#                                   採購單價= 依預算料件銷售單價(abgt340) * 計價比率/100 採購單位=銷售單位 採購稅別=銷售稅別 採購幣別=銷售幣別 
            
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
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       bgcj002 LIKE bgcj_t.bgcj002, 
   bgcj002_desc LIKE type_t.chr80, 
   bgcj003 LIKE bgcj_t.bgcj003, 
   bgcj007 LIKE bgcj_t.bgcj007, 
   bgcj007_desc LIKE type_t.chr80, 
   lower LIKE type_t.chr500, 
   set_num LIKE type_t.chr500, 
   set_price LIKE type_t.chr500, 
   source LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp530.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abgp530_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp530 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp530_init()
 
      #進入選單 Menu (="N")
      CALL abgp530_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp530
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE abgp530_tmp01;
   DROP TABLE abgp530_tmp02;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp530.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp530_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success           LIKE type_t.num5
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
   CALL s_fin_create_account_center_tmp()
   CALL abgp530_create_tmp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgp530.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp530_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_site_str     STRING
   DEFINE l_bgaa006      LIKE bgaa_t.bgaa006
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET l_site_str = ''
   LET g_master.lower = 'Y'
   LET g_master.set_num = '1'
   LET g_master.set_price = '1'
   LET g_master.source = 'Y'
   LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgcj002,g_master.bgcj003,g_master.bgcj007,g_master.lower,g_master.set_num, 
             g_master.set_price,g_master.source 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj002
            
            #add-point:AFTER FIELD bgcj002 name="input.a.bgcj002"
            IF NOT cl_null(g_master.bgcj002) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.bgcj002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.bgcj002 = ''
                  LET g_master.bgcj002_desc = ''
                  DISPLAY BY NAME g_master.bgcj002_desc
                  NEXT FIELD CURRENT
               END IF
 
               #预算编号需是使用预测的（bgaa006=1.使用）
               SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent=g_enterprise AND bgaa001=g_master.bgcj002
               IF l_bgaa006 <> '1' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abg-00292'
                  LET g_errparam.extend = g_master.bgcj002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bgcj002 = ''
                  LET g_master.bgcj002_desc = ''
                  DISPLAY BY NAME g_master.bgcj002_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.bgcj002
            CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.bgcj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.bgcj002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj002
            #add-point:BEFORE FIELD bgcj002 name="input.b.bgcj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj002
            #add-point:ON CHANGE bgcj002 name="input.g.bgcj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003
            #add-point:BEFORE FIELD bgcj003 name="input.b.bgcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003
            
            #add-point:AFTER FIELD bgcj003 name="input.a.bgcj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj003
            #add-point:ON CHANGE bgcj003 name="input.g.bgcj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="input.a.bgcj007"
            IF NOT cl_null(g_master.bgcj007) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.bgcj007
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"                
               IF NOT cl_chk_exist("v_ooef001_24") THEN
                  #檢查失敗時後續處理
                  LET g_master.bgcj007 = ''
                  LET g_master.bgcj007 = ''
                  DISPLAY BY NAME g_master.bgcj007_desc
                  NEXT FIELD CURRENT
               END IF
               
               #2.檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_master.bgcj002,'',g_master.bgcj007,'01')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend =g_master.bgcj007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bgcj007 = ''
                  LET g_master.bgcj007 = ''
                  DISPLAY BY NAME g_master.bgcj007_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.bgcj007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.bgcj007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.bgcj007_desc
            
  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="input.b.bgcj007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj007
            #add-point:ON CHANGE bgcj007 name="input.g.bgcj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lower
            #add-point:BEFORE FIELD lower name="input.b.lower"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lower
            
            #add-point:AFTER FIELD lower name="input.a.lower"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lower
            #add-point:ON CHANGE lower name="input.g.lower"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD set_num
            #add-point:BEFORE FIELD set_num name="input.b.set_num"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD set_num
            
            #add-point:AFTER FIELD set_num name="input.a.set_num"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE set_num
            #add-point:ON CHANGE set_num name="input.g.set_num"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD set_price
            #add-point:BEFORE FIELD set_price name="input.b.set_price"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD set_price
            
            #add-point:AFTER FIELD set_price name="input.a.set_price"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE set_price
            #add-point:ON CHANGE set_price name="input.g.set_price"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD source
            #add-point:BEFORE FIELD source name="input.b.source"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD source
            
            #add-point:AFTER FIELD source name="input.a.source"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE source
            #add-point:ON CHANGE source name="input.g.source"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj002
            #add-point:ON ACTION controlp INFIELD bgcj002 name="input.c.bgcj002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.bgcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaa006='1' "
 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_master.bgcj002 = g_qryparam.return1              

            DISPLAY g_master.bgcj002 TO bgcj002              #

            NEXT FIELD bgcj002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003
            #add-point:ON ACTION controlp INFIELD bgcj003 name="input.c.bgcj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="input.c.bgcj007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.bgcj007             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " ooef205 = 'Y'"
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_master.bgcj002,'',g_user,'01') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_master.bgcj007 = g_qryparam.return1              
            #LET g_master.ooef001 = g_qryparam.return2 
            DISPLAY g_master.bgcj007 TO bgcj007              #
            #DISPLAY g_master.ooef001 TO ooef001 #组织编号
            NEXT FIELD bgcj007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.lower
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lower
            #add-point:ON ACTION controlp INFIELD lower name="input.c.lower"
            
            #END add-point
 
 
         #Ctrlp:input.c.set_num
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD set_num
            #add-point:ON ACTION controlp INFIELD set_num name="input.c.set_num"
            
            #END add-point
 
 
         #Ctrlp:input.c.set_price
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD set_price
            #add-point:ON ACTION controlp INFIELD set_price name="input.c.set_price"
            
            #END add-point
 
 
         #Ctrlp:input.c.source
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD source
            #add-point:ON ACTION controlp INFIELD source name="input.c.source"
            
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
            CALL abgp530_get_buffer(l_dialog)
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
         CALL abgp530_init()
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
                 CALL abgp530_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp530_transfer_argv(ls_js)
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
 
{<section id="abgp530.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp530_transfer_argv(ls_js)
 
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
 
{<section id="abgp530.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp530_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.chr1
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
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abgp530_process_cs CURSOR FROM ls_sql
#  FOREACH abgp530_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      CALL abgp530_p() RETURNING l_success,l_flag
      
      IF l_success = TRUE THEN 
         IF l_flag = 'N' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.code   = 'axc-00530' 
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')  
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      CALL abgp530_p() RETURNING l_success,l_flag
      
      IF l_success = TRUE THEN 
         IF l_flag = 'N' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.code   = 'axc-00530' 
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')  
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL abgp530_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp530.get_buffer" >}
PRIVATE FUNCTION abgp530_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgcj002 = p_dialog.getFieldBuffer('bgcj002')
   LET g_master.bgcj003 = p_dialog.getFieldBuffer('bgcj003')
   LET g_master.bgcj007 = p_dialog.getFieldBuffer('bgcj007')
   LET g_master.lower = p_dialog.getFieldBuffer('lower')
   LET g_master.set_num = p_dialog.getFieldBuffer('set_num')
   LET g_master.set_price = p_dialog.getFieldBuffer('set_price')
   LET g_master.source = p_dialog.getFieldBuffer('source')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp530.msgcentre_notify" >}
PRIVATE FUNCTION abgp530_msgcentre_notify()
 
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
 
{<section id="abgp530.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 创建临时表
PRIVATE FUNCTION abgp530_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE abgp530_tmp01;
   CREATE TEMP TABLE abgp530_tmp01(
   bgcj007     LIKE bgcj_t.bgcj007, #预算组织
   bgcj008     LIKE bgcj_t.bgcj008, #期别
   bgcj009     LIKE bgcj_t.bgcj009, #料号
   bgcj037     LIKE bgcj_t.bgcj037, #销售单位
   bgcj045     LIKE bgcj_t.bgcj045, #销售数量
   bgeg037     LIKE bgeg_t.bgeg037, #采购单位
   cqty        LIKE bgcj_t.bgcj038 #转成采购量
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE abgp530_tmp02;
   CREATE TEMP TABLE abgp530_tmp02(
   bgcj007     LIKE bgcj_t.bgcj007, #预算组织
   bgcj008     LIKE bgcj_t.bgcj008, #期别
   bgcj009     LIKE bgcj_t.bgcj009, #料号
   bgcj016     LIKE bgcj_t.bgcj016, #供应商
   bgeg037     LIKE bgeg_t.bgeg037, #采购单位
   mm          LIKE bgcj_t.bgcj008, #提前采购期别
   cqty        LIKE bgcj_t.bgcj038, #采购量
   cqty2       LIKE bgcj_t.bgcj038, #提前采购量
   cqty3       LIKE bgcj_t.bgcj038, #最终采购数量
   bgec004     LIKE bgec_t.bgec004, #内采组织
   kind        LIKE type_t.chr1     #来源：1、内采；2、外采；3.其余外采
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# p处理逻辑
PRIVATE FUNCTION abgp530_p()
   DEFINE l_sql           STRING
   DEFINE l_site_str      STRING
   DEFINE l_cqty          LIKE bgcj_t.bgcj038
   DEFINE l_cqty1         LIKE bgcj_t.bgcj038
   DEFINE l_cqty2         LIKE bgcj_t.bgcj038
   DEFINE l_cqty3         LIKE bgcj_t.bgcj038
   DEFINE l_cqty_i        LIKE bgcj_t.bgcj038
   DEFINE l_cqty_w        LIKE bgcj_t.bgcj038
   DEFINE l_num_i         LIKE bgcj_t.bgcj038
   DEFINE l_num_w         LIKE bgcj_t.bgcj038
   DEFINE l_cqty_s        LIKE bgcj_t.bgcj038
   DEFINE l_bgea005       LIKE bgea_t.bgea005
   DEFINE l_bgea016       LIKE bgea_t.bgea016
   DEFINE l_bgea017       LIKE bgea_t.bgea017
   DEFINE l_bgea018       LIKE bgea_t.bgea018
   DEFINE l_bgea019       LIKE bgea_t.bgea019
   DEFINE l_bgea020       LIKE bgea_t.bgea020
   DEFINE l_bgea021       LIKE bgea_t.bgea021
   DEFINE l_bgea023       LIKE bgea_t.bgea023
   DEFINE l_bgea024       LIKE bgea_t.bgea024
   DEFINE l_bgas004       LIKE bgas_t.bgas004
   DEFINE l_bged006       LIKE bged_t.bged006 
   DEFINE l_bged007       LIKE bged_t.bged007
   DEFINE l_bgec004       LIKE bgec_t.bgec004
   DEFINE l_bgec006       LIKE bgec_t.bgec006
   DEFINE l_bgde004       LIKE bgde_t.bgde004
   DEFINE l_bgde007       LIKE bgde_t.bgde007
   DEFINE l_bgde008       LIKE bgde_t.bgde008
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_mm_max        LIKE type_t.num5
   DEFINE l_bgaa002       LIKE bgaa_t.bgaa002
   DEFINE l_bgaa003       LIKE bgaa_t.bgaa003
   DEFINE l_bgaa010       LIKE bgaa_t.bgaa010
   DEFINE l_bgaa011       LIKE bgaa_t.bgaa011
   DEFINE l_ooef019       LIKE ooef_t.ooef019
   DEFINE l_ooef024       LIKE ooef_t.ooef024
   DEFINE l_bgar001       LIKE bgar_t.bgar001
   DEFINE l_bgai002       LIKE bgai_t.bgai002
   DEFINE l_bgai008       LIKE bgai_t.bgai008
   DEFINE l_bgcb004       LIKE bgcb_t.bgcb004
   DEFINE l_bgcb006       LIKE bgcb_t.bgcb006
   DEFINE l_bgcb007       LIKE bgcb_t.bgcb007
   DEFINE l_bgca003       LIKE bgca_t.bgca003
   DEFINE r_xrcd113       LIKE xrcd_t.xrcd113
   DEFINE r_xrcd114       LIKE xrcd_t.xrcd114
   DEFINE r_xrcd115       LIKE xrcd_t.xrcd115
   DEFINE l_bgee006       LIKE bgee_t.bgee006
   DEFINE l_bgee007       LIKE bgee_t.bgee007
   DEFINE l_bgee009       LIKE bgee_t.bgee009 
   DEFINE l_bgee003       LIKE bgee_t.bgee003    #161229-00040#1 
   DEFINE l_bgee013       LIKE bgee_t.bgee013    #161229-00040#1 
   DEFINE l_bgee014       LIKE bgee_t.bgee014    #161229-00040#1 
   DEFINE l_bgcj035       LIKE bgcj_t.bgcj035    #161229-00040#1 
   DEFINE l_bgcj100       LIKE bgcj_t.bgcj100    #161229-00040#1 
   DEFINE l_bgcj037       LIKE bgcj_t.bgcj037    #161229-00040#1 
   DEFINE l_bgcj039       LIKE bgcj_t.bgcj039    #161229-00040#1 
   DEFINE l_price         LIKE bgeg_t.bgeg039
   DEFINE l_bgef005       LIKE bgef_t.bgef005
   DEFINE l_bgef006       LIKE bgef_t.bgef006
   DEFINE l_bgap003       LIKE bgap_t.bgap003
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_bgegseq       LIKE bgeg_t.bgegseq
   DEFINE l_bgeg039       LIKE bgeg_t.bgeg039
   DEFINE l_tmp           RECORD
          bgcj007         LIKE bgcj_t.bgcj007, #预算组织
          bgcj008         LIKE bgcj_t.bgcj008, #期别
          bgcj009         LIKE bgcj_t.bgcj009, #料号
          bgcj037         LIKE bgcj_t.bgcj037, #销售单位
          bgcj045         LIKE bgcj_t.bgcj045, #销售数量
          bgeg037         LIKE bgeg_t.bgeg037, #采购单位
          cqty            LIKE bgcj_t.bgcj038 #转成采购量
                          END RECORD
   DEFINE l_tmp1          RECORD
          bgcj007         LIKE bgcj_t.bgcj007, #预算组织
          bgcj008         LIKE bgcj_t.bgcj008, #期别
          bgcj009         LIKE bgcj_t.bgcj009, #料号
          bgcj016         LIKE bgcj_t.bgcj016, #供应商
          bgeg037         LIKE bgeg_t.bgeg037, #采购单位
          mm              LIKE bgcj_t.bgcj008, #提前采购期别
          cqty            LIKE bgcj_t.bgcj038, #采购量
          cqty2           LIKE bgcj_t.bgcj038, #提前采购量
          cqty3           LIKE bgcj_t.bgcj038, #当前总采购量
          bgec004         LIKE bgec_t.bgec004  #内采组织
                          END RECORD
   DEFINE l_bgeg          RECORD  #採購預算主檔
                          bgegent     LIKE bgeg_t.bgegent, #企業編號
                          bgeg001     LIKE bgeg_t.bgeg001, #來源作業
                          bgeg002     LIKE bgeg_t.bgeg002, #預算編號
                          bgeg003     LIKE bgeg_t.bgeg003, #版本
                          bgeg004     LIKE bgeg_t.bgeg004, #管理組織
                          bgeg005     LIKE bgeg_t.bgeg005, #採購來源
                          bgeg006     LIKE bgeg_t.bgeg006, #資料類型
                          bgeg007     LIKE bgeg_t.bgeg007, #預算組織
                          bgeg008     LIKE bgeg_t.bgeg008, #預算期別
                          bgeg009     LIKE bgeg_t.bgeg009, #預算料件
                          bgeg010     LIKE bgeg_t.bgeg010, #組合KEY
                          bgegseq     LIKE bgeg_t.bgegseq, #項次
                          bgeg011     LIKE bgeg_t.bgeg011, #預算樣表
                          bgeg012     LIKE bgeg_t.bgeg012, #人員
                          bgeg013     LIKE bgeg_t.bgeg013, #部門
                          bgeg014     LIKE bgeg_t.bgeg014, #成本利潤中心
                          bgeg015     LIKE bgeg_t.bgeg015, #區域
                          bgeg016     LIKE bgeg_t.bgeg016, #供應商代碼
                          bgeg017     LIKE bgeg_t.bgeg017, #付款對象
                          bgeg018     LIKE bgeg_t.bgeg018, #客群
                          bgeg019     LIKE bgeg_t.bgeg019, #產品類別
                          bgeg020     LIKE bgeg_t.bgeg020, #專案編號
                          bgeg021     LIKE bgeg_t.bgeg021, #WBS
                          bgeg022     LIKE bgeg_t.bgeg022, #經營方式
                          bgeg023     LIKE bgeg_t.bgeg023, #通路
                          bgeg024     LIKE bgeg_t.bgeg024, #品牌
                          bgeg025     LIKE bgeg_t.bgeg025, #自由核算項一
                          bgeg026     LIKE bgeg_t.bgeg026, #自由核算項二
                          bgeg027     LIKE bgeg_t.bgeg027, #自由核算項三
                          bgeg028     LIKE bgeg_t.bgeg028, #自由核算項四
                          bgeg029     LIKE bgeg_t.bgeg029, #自由核算項五
                          bgeg030     LIKE bgeg_t.bgeg030, #自由核算項六
                          bgeg031     LIKE bgeg_t.bgeg031, #自由核算項七
                          bgeg032     LIKE bgeg_t.bgeg032, #自由核算項八
                          bgeg033     LIKE bgeg_t.bgeg033, #自由核算項九
                          bgeg034     LIKE bgeg_t.bgeg034, #自由核算項十
                          bgeg035     LIKE bgeg_t.bgeg035, #稅別
                          bgeg036     LIKE bgeg_t.bgeg036, #含稅否
                          bgeg037     LIKE bgeg_t.bgeg037, #採購單位
                          bgeg038     LIKE bgeg_t.bgeg038, #交易數量
                          bgeg039     LIKE bgeg_t.bgeg039, #單價
                          bgeg040     LIKE bgeg_t.bgeg040, #原幣採購金額
                          bgeg041     LIKE bgeg_t.bgeg041, #本層調整數量
                          bgeg042     LIKE bgeg_t.bgeg042, #本層調整單價
                          bgeg043     LIKE bgeg_t.bgeg043, #上層調整數量
                          bgeg044     LIKE bgeg_t.bgeg044, #上層調整單價
                          bgeg045     LIKE bgeg_t.bgeg045, #核准數量
                          bgeg046     LIKE bgeg_t.bgeg046, #核准單價
                          bgeg047     LIKE bgeg_t.bgeg047, #上層組織
                          bgeg048     LIKE bgeg_t.bgeg048, #轉憑單號
                          bgeg049     LIKE bgeg_t.bgeg049, #預算細項
                          bgeg050     LIKE bgeg_t.bgeg050, #編製起點
                          bgeg051     LIKE bgeg_t.bgeg051, #內部採購單拋轉否
                          bgeg100     LIKE bgeg_t.bgeg100, #交易幣別
                          bgeg101     LIKE bgeg_t.bgeg101, #匯率
                          bgeg102     LIKE bgeg_t.bgeg102, #核准原幣採購金額
                          bgeg103     LIKE bgeg_t.bgeg103, #核准原幣未稅金額
                          bgeg104     LIKE bgeg_t.bgeg104, #核准原幣稅額
                          bgeg105     LIKE bgeg_t.bgeg105, #核准原幣含稅金額
                          bgegstus    LIKE bgeg_t.bgegstus, #狀態碼
                          bgegownid   LIKE bgeg_t.bgegownid, #資料所有者
                          bgegowndp   LIKE bgeg_t.bgegowndp, #資料所屬部門
                          bgegcrtid   LIKE bgeg_t.bgegcrtid, #資料建立者
                          bgegcrtdp   LIKE bgeg_t.bgegcrtdp, #資料建立部門
                          bgegcrtdt   LIKE bgeg_t.bgegcrtdt, #資料創建日
                          bgegmodid   LIKE bgeg_t.bgegmodid, #資料修改者
                          bgegmoddt   LIKE bgeg_t.bgegmoddt, #最近修改日
                          bgegcnfid   LIKE bgeg_t.bgegcnfid, #資料確認者
                          bgegcnfdt   LIKE bgeg_t.bgegcnfdt, #資料確認日
                          bgegud001   LIKE bgeg_t.bgegud001, #自定義欄位(文字)001
                          bgegud002   LIKE bgeg_t.bgegud002, #自定義欄位(文字)002
                          bgegud003   LIKE bgeg_t.bgegud003, #自定義欄位(文字)003
                          bgegud004   LIKE bgeg_t.bgegud004, #自定義欄位(文字)004
                          bgegud005   LIKE bgeg_t.bgegud005, #自定義欄位(文字)005
                          bgegud006   LIKE bgeg_t.bgegud006, #自定義欄位(文字)006
                          bgegud007   LIKE bgeg_t.bgegud007, #自定義欄位(文字)007
                          bgegud008   LIKE bgeg_t.bgegud008, #自定義欄位(文字)008
                          bgegud009   LIKE bgeg_t.bgegud009, #自定義欄位(文字)009
                          bgegud010   LIKE bgeg_t.bgegud010, #自定義欄位(文字)010
                          bgegud011   LIKE bgeg_t.bgegud011, #自定義欄位(數字)011
                          bgegud012   LIKE bgeg_t.bgegud012, #自定義欄位(數字)012
                          bgegud013   LIKE bgeg_t.bgegud013, #自定義欄位(數字)013
                          bgegud014   LIKE bgeg_t.bgegud014, #自定義欄位(數字)014
                          bgegud015   LIKE bgeg_t.bgegud015, #自定義欄位(數字)015
                          bgegud016   LIKE bgeg_t.bgegud016, #自定義欄位(數字)016
                          bgegud017   LIKE bgeg_t.bgegud017, #自定義欄位(數字)017
                          bgegud018   LIKE bgeg_t.bgegud018, #自定義欄位(數字)018
                          bgegud019   LIKE bgeg_t.bgegud019, #自定義欄位(數字)019
                          bgegud020   LIKE bgeg_t.bgegud020, #自定義欄位(數字)020
                          bgegud021   LIKE bgeg_t.bgegud021, #自定義欄位(日期時間)021
                          bgegud022   LIKE bgeg_t.bgegud022, #自定義欄位(日期時間)022
                          bgegud023   LIKE bgeg_t.bgegud023, #自定義欄位(日期時間)023
                          bgegud024   LIKE bgeg_t.bgegud024, #自定義欄位(日期時間)024
                          bgegud025   LIKE bgeg_t.bgegud025, #自定義欄位(日期時間)025
                          bgegud026   LIKE bgeg_t.bgegud026, #自定義欄位(日期時間)026
                          bgegud027   LIKE bgeg_t.bgegud027, #自定義欄位(日期時間)027
                          bgegud028   LIKE bgeg_t.bgegud028, #自定義欄位(日期時間)028
                          bgegud029   LIKE bgeg_t.bgegud029, #自定義欄位(日期時間)029
                          bgegud030   LIKE bgeg_t.bgegud030  #自定義欄位(日期時間)030
                          END RECORD
   DEFINE l_bgal          RECORD
                          bgal005     LIKE bgal_t.bgal005,
                          bgal006     LIKE bgal_t.bgal006,
                          bgal007     LIKE bgal_t.bgal007,
                          bgal008     LIKE bgal_t.bgal008,
                          bgal009     LIKE bgal_t.bgal009,
                          bgal010     LIKE bgal_t.bgal010,
                          bgal011     LIKE bgal_t.bgal011,
                          bgal012     LIKE bgal_t.bgal012,
                          bgal013     LIKE bgal_t.bgal013,
                          bgal014     LIKE bgal_t.bgal014,
                          bgal025     LIKE bgal_t.bgal025,
                          bgal026     LIKE bgal_t.bgal026,
                          bgal027     LIKE bgal_t.bgal027
                          END RECORD
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_flag          LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_day           LIKE type_t.num5
   DEFINE l_date          LIKE type_t.dat
   DEFINE l_i             LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_success = TRUE
   LET r_flag = 'N'
   
   #检查预算编号+版本+预算组织+来源3.销售预算，是否已存在与abgt510中，如果存在，不可以抛转
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM bgeg_t
    WHERE bgegent=g_enterprise AND bgeg001='20'
      AND bgeg002=g_master.bgcj002 AND bgeg003=g_master.bgcj003
      AND bgeg007=g_master.bgcj007 AND bgeg005='3'
      AND bgegstus<>'X'
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abg-00317'
      LET g_errparam.extend = g_master.bgcj002,' + ',g_master.bgcj003," + ",g_master.bgcj007
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success,r_flag
   END IF
   
   LET l_bgeg.bgegent = g_enterprise
   LET l_bgeg.bgeg001 = '20'
   LET l_bgeg.bgeg002 = g_master.bgcj002
   LET l_bgeg.bgeg003 = g_master.bgcj003
   LET l_bgeg.bgeg005 = '3' #来源：3.销售预算
   LET l_bgeg.bgeg006 = '1'
   LET l_bgeg.bgeg025 = ' '
   LET l_bgeg.bgeg026 = ' '
   LET l_bgeg.bgeg027 = ' '
   LET l_bgeg.bgeg028 = ' '
   LET l_bgeg.bgeg029 = ' '
   LET l_bgeg.bgeg030 = ' '
   LET l_bgeg.bgeg031 = ' '
   LET l_bgeg.bgeg032 = ' '
   LET l_bgeg.bgeg033 = ' '
   LET l_bgeg.bgeg034 = ' '
   LET l_bgeg.bgeg041 = 0
   LET l_bgeg.bgeg042 = 0
   LET l_bgeg.bgeg043 = 0
   LET l_bgeg.bgeg044 = 0
   LET l_bgeg.bgeg048 = ''
   LET l_bgeg.bgeg050 = 1
   LET l_bgeg.bgeg051 = 'N'
   LET l_bgeg.bgegstus = 'Y'
   LET l_bgeg.bgegownid = g_user
   LET l_bgeg.bgegowndp = g_dept
   LET l_bgeg.bgegcrtid = g_user
   LET l_bgeg.bgegcrtdp = g_dept 
   LET l_bgeg.bgegcrtdt = cl_get_current()
   LET l_bgeg.bgegmodid = g_user
   LET l_bgeg.bgegmoddt = cl_get_current()
   
   CALL s_abg2_get_site(g_master.bgcj002,g_master.bgcj007,'03') RETURNING l_site_str   
   #abgi010预算组织版本/最上层组织/预算币别
   LET l_bgaa010 = ''     
   LET l_bgaa011 = ''
   LET l_bgaa003 = ''  
   SELECT bgaa010,bgaa011,bgaa003,bgaa002
     INTO l_bgaa010,l_bgaa011,l_bgaa003,l_bgaa002
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgcj002 
             
   #抓取abgt340中符合条件的预算组织和预算料件   
   LET l_sql = "SELECT DISTINCT bgcj007,bgcj009 FROM bgcj_t ",
               " WHERE bgcjent = ",g_enterprise,
               "   AND bgcj001 = '20'",
               "   AND bgcj002 = '",g_master.bgcj002,"'",
               "   AND bgcj003 = '",g_master.bgcj003,"'",
               "   AND bgcj005 <> '4'",
               "   AND bgcj006 = '1' ",
               "   AND bgcjstus = 'FC' "
   IF g_master.lower = 'Y' THEN   #含下層組織
      LET l_sql=l_sql," AND (bgcj007 = '",g_master.bgcj007,"' OR bgcj007 IN ",l_site_str,") "
   ELSE
      LET l_sql=l_sql," AND bgcj007 = '",g_master.bgcj007,"' "
   END IF
   LET l_sql=l_sql," GROUP BY bgcj007,bgcj009 ",
                   " ORDER BY bgcj007,bgcj009 "
   PREPARE abgp530_p_pre FROM l_sql
   DECLARE abgp530_p_cs CURSOR FOR abgp530_p_pre
   
   #通过预算组织+预算料件，按照期别和采购单位汇总采购数量
   LET l_sql = "SELECT bgcj008,bgcj037,SUM(bgcj045) FROM bgcj_t ",
               " WHERE bgcjent = ",g_enterprise,
               "   AND bgcj001 = '20'",
               "   AND bgcj002 = '",g_master.bgcj002,"'",
               "   AND bgcj003 = '",g_master.bgcj003,"'",
               "   AND bgcj005 <> '4'",
               "   AND bgcj006 = '1' ",
               "   AND bgcjstus = 'FC' ",
               "   AND bgcj007 = ? ",
               "   AND bgcj009 = ? ",   
               " GROUP BY bgcj008,bgcj037 ",
               " ORDER BY bgcj008,bgcj037 ASC"
   PREPARE abgp530_p_pre1 FROM l_sql
   DECLARE abgp530_p_cs1 CURSOR FOR abgp530_p_pre1
   
   #抓取abgt420生产期初库存
   LET l_sql = "SELECT bgde004,bgde008,SUM(bgde007) ",
               "  FROM bgde_t ",
               " WHERE bgdeent = ",g_enterprise,
               "   AND bgde001 = '",g_master.bgcj002,"'",
               "   AND bgde002 = ? ",
               "   AND bgde004 = ? ",
               " GROUP BY bgde004,bgde008",
               " ORDER BY bgde004,bgde008 "
   PREPARE abgp530_p_pre2 FROM l_sql
   DECLARE abgp530_p_cs2 CURSOR FOR abgp530_p_pre2
   
   #根据提前采购设置再推算一次采购量
   LET l_sql = "SELECT bgcj008,bgcj007,bgcj009,bgeg037,SUM(cqty) ",
               "  FROM abgp530_tmp01 ",
               " GROUP BY bgcj008,bgcj007,bgcj009,bgeg037 ",
               " ORDER BY bgcj008 DESC,bgcj007,bgcj009,bgeg037 "
   PREPARE abgp530_p_pre3 FROM l_sql
   DECLARE abgp530_p_cs3 CURSOR FOR abgp530_p_pre3
   
   #往abgt510赛资料
   LET l_sql = "SELECT DISTINCT bgcj007,bgcj009,bgcj016,bgeg037,bgec004 ",
               "  FROM abgp530_tmp02 ",
               " ORDER BY bgcj007,bgcj009,bgcj016,bgeg037,bgec004 "
   PREPARE abgp530_p_pre4 FROM l_sql
   DECLARE abgp530_p_cs4 CURSOR FOR abgp530_p_pre4
   
   LET l_sql = "SELECT SUM(cqty3) ",
               "  FROM abgp530_tmp02 ",
               " WHERE bgcj007 = ? AND bgcj009 = ? AND bgcj016 = ? ",
               "   AND bgeg037 = ? AND bgec004 = ? AND bgcj008 = ? "
   PREPARE abgp530_p_pre8 FROM l_sql
   
   #抓取内采组织
   LET l_sql = "SELECT DISTINCT bgec004,bgec006 ",
               "  FROM bgec_t ",
               " WHERE bgecent = ",g_enterprise,
               "   AND bgec001 = '",g_master.bgcj002,"'",
               "   AND bgec002 = ? ",
               "   AND bgec003 = ? "
   PREPARE abgp530_p_pre5 FROM l_sql
   DECLARE abgp530_p_cs5 CURSOR FOR abgp530_p_pre5
   
   #抓外部供应商
   LET l_sql = "SELECT DISTINCT bgef005,bgef006 ",
               "  FROM bgef_t ",
               " WHERE bgefent = ",g_enterprise,
               "   AND bgef001 = '",g_master.bgcj002,"'",
               "   AND bgef002 = ? ",
               "   AND bgef003 = ? ",
               "   AND bgef004 = ? "
   PREPARE abgp530_p_pre6 FROM l_sql
   DECLARE abgp530_p_cs6 CURSOR FOR abgp530_p_pre6
   
   #abgi510抓取影响因子编号/影响百分比/影响数量
   LET l_sql = "SELECT DISTINCT bgcb004,bgcb006,bgcb007 ",
               "  FROM bgcb_t ",
               " WHERE bgcbent = ",g_enterprise,
               "   AND bgcb001 = '",g_master.bgcj002,"'",
               "   AND bgcb002 = ? ",
               "   AND bgcb008 = ? ",
               "   AND bgcb005 = ? ",
               "   AND bgcb010 = '2' "
   PREPARE abgp530_p_pre7 FROM l_sql
   DECLARE abgp530_p_cs7 CURSOR FOR abgp530_p_pre7            
   
   DELETE FROM abgp530_tmp01;
   
   #1.计算出预算料件每期的采购数量，存入临时tmp01
   #抓取符合条件的预算组织和预算料号
   FOREACH abgp530_p_cs INTO l_tmp.bgcj007,l_tmp.bgcj009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp530_p_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
      #当含下层组织时，检查下层组织，要判断预算编号+版本+预算组织是否已抛转产生采购预算，如果已产生，不可重复抛转 
      IF g_master.lower = 'Y' AND l_tmp.bgcj007 <> g_master.bgcj007 THEN
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM bgeg_t
          WHERE bgegent=g_enterprise AND bgeg001='20'
            AND bgeg002=g_master.bgcj002 AND bgeg003=g_master.bgcj003
            AND bgeg007=l_tmp.bgcj007 AND bgeg005='3'
            AND bgegstus<>'X'
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF 
         IF l_cnt > 0 THEN
            CONTINUE FOREACH
         END IF
      END IF
      
      #采购单位
      LET l_bgea016 = ''
      SELECT bgea016 INTO l_bgea016
        FROM bgea_t
       WHERE bgeaent = g_enterprise
         AND bgea001 = g_master.bgcj002
         AND bgea002 = l_tmp.bgcj007
         AND bgea003 = l_tmp.bgcj009
      LET l_tmp.bgeg037 = l_bgea016
      
      #抓取期初开账库存数量
      LET l_cqty_s = 0
      FOREACH abgp530_p_cs2 USING l_tmp.bgcj007,l_tmp.bgcj009 INTO l_bgde004,l_bgde008,l_bgde007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgp510_p_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF
         #将料件期初开账单位的数量换算成采购单位的数量
         LET l_cqty1 = 0
         CALL s_aooi250_convert_qty(l_bgde004,l_bgde008,l_bgea016,l_bgde007) RETURNING l_success,l_cqty1 
         
         #累计期初库存数量
         LET l_cqty_s = l_cqty_s + l_cqty1
      END FOREACH
      #逐期抓取采购数量
      FOREACH abgp530_p_cs1 USING l_tmp.bgcj007,l_tmp.bgcj009 INTO l_tmp.bgcj008,l_tmp.bgcj037,l_tmp.bgcj045
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgp530_p_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF
      
         #将销售单位的数量换算成采购单位的数量
         LET l_tmp.cqty = 0
         CALL s_aooi250_convert_qty(l_tmp.bgcj009,l_tmp.bgcj037,l_bgea016,l_tmp.bgcj045) RETURNING l_success,l_tmp.cqty
         
         
         #转采购数量=销售数量对换的采购数量 - 期初库存数量兑换的采购数量
         #当有期初库存，扣除期初库存
         IF l_cqty_s > 0 THEN
            IF l_tmp.cqty > l_cqty_s THEN
               LET l_tmp.cqty = l_tmp.cqty - l_cqty_s
               LET l_cqty_s = 0
            ELSE
               LET l_cqty_s = l_cqty_s - l_tmp.cqty
               LET l_tmp.cqty = 0
            END IF
         END IF
         
         #当销售数量-期初库存数量<=0 时，表示库存充足，采购量给0
         IF l_tmp.cqty <=0 THEN
            LET l_tmp.cqty = 0
            #将重新计算的采购数量插入到临时表中
            INSERT INTO abgp530_tmp01(bgcj007,bgcj008,bgcj009,bgcj037,bgcj045,bgeg037,cqty) 
            VALUES(l_tmp.bgcj007,l_tmp.bgcj008,l_tmp.bgcj009,l_tmp.bgcj037,l_tmp.bgcj045,l_tmp.bgeg037,l_tmp.cqty)
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins abgp530_tmp01'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF 
            CONTINUE FOREACH
         END IF
      
         #最小采购量/采购损耗率
         LET l_bgea021 = 0    LET l_bgea024 = 0
         SELECT bgea021,bgea024 INTO l_bgea021,l_bgea024
           FROM bgea_t
          WHERE bgeaent = g_enterprise
            AND bgea001 = g_master.bgcj002
            AND bgea002 = l_tmp.bgcj007
            AND bgea003 = l_tmp.bgcj009 
            
         IF cl_null(l_bgea021) THEN LET l_bgea021 = 0 END IF   
         IF cl_null(l_bgea024) THEN LET l_bgea024 = 0 END IF
         
         LET l_tmp.cqty = l_tmp.cqty * (1 + l_bgea024 / 100)
         
         IF l_tmp.cqty > 0 AND l_tmp.cqty < l_bgea021 THEN 
            LET l_tmp.cqty = l_bgea021
         END IF
         #将重新计算的采购数量插入到临时表中
         INSERT INTO abgp530_tmp01(bgcj007,bgcj008,bgcj009,bgcj037,bgcj045,bgeg037,cqty) 
         VALUES(l_tmp.bgcj007,l_tmp.bgcj008,l_tmp.bgcj009,l_tmp.bgcj037,l_tmp.bgcj045,l_tmp.bgeg037,l_tmp.cqty)
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins abgp530_tmp01'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
      END FOREACH
   END FOREACH
      
   #2.根据提前采购设置再推算一次采购量
   INITIALIZE l_tmp1.* TO NULL
   DELETE FROM abgp530_tmp02;
   #最大期别
   SELECT MAX(bgcj008) INTO l_mm_max FROM abgp530_tmp01
   
   FOREACH abgp530_p_cs3 INTO l_tmp1.bgcj008,l_tmp1.bgcj007,l_tmp1.bgcj009,l_tmp1.bgeg037,l_cqty
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp530_p_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
      
      #abgi170抓内采比率/主要供应商 
      LET l_bgea023 = ''     LET l_bgea017 = ''
      SELECT bgea023,bgea017  
        INTO l_bgea023,l_bgea017 
        FROM bgea_t
       WHERE bgeaent = g_enterprise
         AND bgea001 = g_master.bgcj002
         AND bgea002 = l_tmp1.bgcj007
         AND bgea003 = l_tmp1.bgcj009
      IF cl_null(l_bgea023) THEN LET l_bgea023 = 0 END IF
      
      #abgi165抓取主分群码
      LET l_bgas004 = ''
      SELECT bgas004 INTO l_bgas004
        FROM bgas_t
       WHERE bgasent = g_enterprise
         AND bgas001 = l_tmp1.bgcj009
         
      #是否维护了内采组织讯息   
      LET l_n = 0
      SELECT COUNT(1) INTO l_n
        FROM bgec_t
       WHERE bgecent = g_enterprise
         AND bgec001 = g_master.bgcj002
         AND bgec002 = l_tmp1.bgcj007
         AND bgec003 = l_tmp1.bgcj009
            
      #如果维护了内采比率并且维护了内采组织讯息,则有内部采购,需要按比率计算内采数量
      #否则没有内采,全部是外采
      LET l_num_i = 0
      IF l_bgea023 > 0 AND l_n > 0 THEN
         #内采组织/内采比例
         FOREACH abgp530_p_cs5 USING l_tmp1.bgcj007,l_tmp1.bgcj009 INTO l_bgec004,l_bgec006
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp530_p_cs5'
               LET g_errparam.popup = TRUE
               CALL cl_err()
             
               LET r_success = FALSE
            END IF
            IF cl_null(l_bgec006) OR l_bgec006 = 0 THEN 
               CONTINUE FOREACH
            END IF
            #内采组织对应采购比例
            LET l_tmp1.cqty = l_cqty * l_bgec006 / 100
            LET l_tmp1.cqty = s_num_round('4',l_tmp1.cqty,0)
            #累计内采数量
            LET l_num_i = l_num_i + l_tmp1.cqty
            
            #内采组织对应交易对象
            LET l_ooef024 = ''
            SELECT ooef024 INTO l_ooef024
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = l_bgec004
            IF cl_null(l_ooef024) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aic-00113'
               LET g_errparam.extend = ''
               LET g_errparam.replace[1] = l_bgec004
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            #abgi150预算交易对象
            LET l_tmp1.bgcj016 = ''
            SELECT bgar001 INTO l_tmp1.bgcj016
              FROM bgar_t
             WHERE bgarent = g_enterprise
               AND bgar002 = l_ooef024
               
            #abgi540抓取提前期别,提前采购比率
            #先通过预算料件抓取,若抓不到再通过主分群码抓取
            LET l_bged006 = ''
            LET l_bged007 = ''
            SELECT bged006,bged007 INTO l_bged006,l_bged007
              FROM bged_t
             WHERE bgedent = g_enterprise
               AND bged001 = g_master.bgcj002
               AND bged002 = l_tmp1.bgcj007
               AND bged003 = l_tmp1.bgcj016
               AND bged005 = l_tmp1.bgcj009
               
            IF cl_null(l_bged006) AND cl_null(l_bged007) THEN 
               #按照主分群码抓取
               SELECT bged006,bged007 INTO l_bged006,l_bged007
                 FROM bged_t
                WHERE bgedent = g_enterprise
                  AND bged001 = g_master.bgcj002
                  AND bged002 = l_tmp1.bgcj007
                  AND bged003 = l_tmp1.bgcj016
                  AND bged004 = l_bgas004
            END IF
            #若抓不到值或者有值但是没有维护提前采购比率,算作不提前,不需要再重新推算采购数量
            #反之，重新推算采购数量
            IF NOT cl_null(l_bged007) AND NOT cl_null(l_bged006) THEN 
               #提前期别
               LET l_tmp1.mm = l_tmp1.bgcj008 + l_bged006
               #抓取提前期别的采购量
               LET l_cqty2 = 0
               SELECT cqty2 INTO l_cqty2 FROM abgp530_tmp02
                WHERE bgcj007 = l_tmp1.bgcj007
                  AND bgcj008 = l_tmp1.mm
                  AND bgcj009 = l_tmp1.bgcj009
                  AND bgcj016 = l_tmp1.bgcj016
                  AND bgeg037 = l_tmp1.bgeg037
                  AND bgec004 = l_bgec004
                  AND kind = '1'
               IF cl_null(l_cqty2) THEN LET l_cqty2 = 0 END IF
               #提前采购设置若设置1.剩余期别不处理,当l_tmp1.mm > l_mm_max时,会抓不到资料,则不再考量未来期的采购量,提前采购量l_cqty2=0
               #若选择2.按最后一期的采购量计算,则按最后一期l_mm_max的采购量来给计算提前采购量l_cqty2
               IF g_master.set_num = '2' AND l_cqty2 = 0 THEN
                  SELECT cqty2 INTO l_cqty2 FROM abgp530_tmp02
                   WHERE bgcj007 = l_tmp1.bgcj007
                     AND bgcj008 = l_mm_max
                     AND bgcj009 = l_tmp1.bgcj009
                     AND bgcj016 = l_tmp1.bgcj016
                     AND bgeg037 = l_tmp1.bgeg037
                     AND bgec004 = l_bgec004
                     AND kind = '1'
                  IF cl_null(l_cqty2) THEN LET l_cqty2 = 0 END IF
               END IF
               #当期提前采购数量
               LET l_tmp1.cqty2 = l_tmp1.cqty * l_bged007 /100
               LET l_tmp1.cqty2 = s_num_round('4',l_tmp1.cqty2,0)               
               #当期总采购量 = 采购量 - 当期提前采购数量 + 提前采购期别的提前采购量
               LET l_tmp1.cqty3 = l_tmp1.cqty - l_tmp1.cqty2 + l_cqty2
               LET l_tmp1.mm = l_bged006
               INSERT INTO abgp530_tmp02(bgcj007,bgcj008,bgcj009,bgcj016,bgeg037,mm,cqty,cqty2,cqty3,bgec004,kind)
               VALUES(l_tmp1.bgcj007,l_tmp1.bgcj008,l_tmp1.bgcj009,l_tmp1.bgcj016,l_tmp1.bgeg037,
                      l_tmp1.mm,l_tmp1.cqty,l_tmp1.cqty2,l_tmp1.cqty3,l_bgec004,'1')
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp530_tmp02'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
            ELSE
               #提前期别
               LET l_tmp1.mm = 0
               #提前采购数量
               LET l_tmp1.cqty2 = 0
               #当期总采购量 = 采购量 
               LET l_tmp1.cqty3 = l_tmp1.cqty
               INSERT INTO abgp530_tmp02(bgcj007,bgcj008,bgcj009,bgcj016,bgeg037,mm,cqty,cqty2,cqty3,bgec004,kind)
               VALUES(l_tmp1.bgcj007,l_tmp1.bgcj008,l_tmp1.bgcj009,l_tmp1.bgcj016,l_tmp1.bgeg037,
                      l_tmp1.mm,l_tmp1.cqty,l_tmp1.cqty2,l_tmp1.cqty3,l_bgec004,'1')
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp530_tmp02'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
            END IF
         END FOREACH
      END IF
      #外采数量 = 总采购数量 - 内采数量
      LET l_cqty_w = l_cqty * (1 - l_bgea023/100) 
      LET l_cqty_w = s_num_round('4',l_cqty_w,0)
      LET l_num_w = 0
      IF l_cqty_w > 0 THEN
         #供应商/采购比率
         FOREACH abgp530_p_cs6 USING l_tmp1.bgcj007,l_tmp1.bgcj008,l_tmp1.bgcj009 INTO l_tmp1.bgcj016,l_bgef006  
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp530_p_cs6'
               LET g_errparam.popup = TRUE
               CALL cl_err()
             
               LET r_success = FALSE
            END IF
            
            IF cl_null(l_bgef006) THEN 
               CONTINUE FOREACH
            END IF
            #外采供应商对应采购比例
            LET l_tmp1.cqty = l_cqty_w * l_bgef006 / 100
            LET l_tmp1.cqty = s_num_round('4',l_tmp1.cqty,0)
            #累计外采数量
            LET l_num_w = l_num_w + l_tmp1.cqty
            
            LET l_bgec004 = ' ' #外部采购时存空格
            
            #abgi540抓取提前期别,提前采购比率
            #先通过预算料件抓取,若抓不到再通过主分群码抓取
            LET l_bged006 = ''
            LET l_bged007 = ''
            SELECT bged006,bged007 INTO l_bged006,l_bged007
              FROM bged_t
             WHERE bgedent = g_enterprise
               AND bged001 = g_master.bgcj002
               AND bged002 = l_tmp1.bgcj007
               AND bged003 = l_tmp1.bgcj016
               AND bged005 = l_tmp1.bgcj009
               
            IF cl_null(l_bged006) AND cl_null(l_bged007) THEN 
               #按照主分群码抓取
               SELECT bged006,bged007 INTO l_bged006,l_bged007
                 FROM bged_t
                WHERE bgedent = g_enterprise
                  AND bged001 = g_master.bgcj002
                  AND bged002 = l_tmp1.bgcj007
                  AND bged003 = l_tmp1.bgcj016
                  AND bged004 = l_bgas004
            END IF
            #若抓不到值或者有值但是没有维护提前采购比率,算作不提前,不需要再重新推算采购数量
            #反之，重新推算采购数量
            IF NOT cl_null(l_bged007) AND NOT cl_null(l_bged006) THEN 
               #提前期别
               LET l_tmp1.mm = l_tmp1.bgcj008 + l_bged006
               #抓取提前期别的采购量
               LET l_cqty2 = 0
               SELECT cqty2 INTO l_cqty2 FROM abgp530_tmp02
                WHERE bgcj007 = l_tmp1.bgcj007
                  AND bgcj008 = l_tmp1.mm
                  AND bgcj009 = l_tmp1.bgcj009
                  AND bgcj016 = l_tmp1.bgcj016
                  AND bgeg037 = l_tmp1.bgeg037
                  AND bgec004 = l_bgec004
                  AND kind = '2'
               IF cl_null(l_cqty2) THEN LET l_cqty2 = 0 END IF
               #提前采购设置若设置1.剩余期别不处理,当l_tmp1.mm > l_mm_max时,会抓不到资料,则不再考量未来期的采购量,提前采购量l_cqty2=0
               #若选择2.按最后一期的采购量计算,则按最后一期l_mm_max的提前采购量l_cqty2
               IF g_master.set_num = '2' AND l_cqty2 = 0 THEN
                  SELECT cqty2 INTO l_cqty2 FROM abgp530_tmp02
                   WHERE bgcj007 = l_tmp1.bgcj007
                     AND bgcj008 = l_mm_max
                     AND bgcj009 = l_tmp1.bgcj009
                     AND bgcj016 = l_tmp1.bgcj016
                     AND bgeg037 = l_tmp1.bgeg037
                     AND bgec004 = l_bgec004
                     AND kind = '2'
                  IF cl_null(l_cqty2) THEN LET l_cqty2 = 0 END IF
               END IF
               #当期提前采购数量
               LET l_tmp1.cqty2 = l_tmp1.cqty * l_bged007 /100
               LET l_tmp1.cqty2 = s_num_round('4',l_tmp1.cqty2,0)    
               #当期总采购量=采购量 - 当期提前采购数量 + 提前期别的提前采购量 
               LET l_tmp1.cqty3 = l_tmp1.cqty - l_tmp1.cqty2 + l_cqty2
               LET l_tmp1.mm = l_bged006
               INSERT INTO abgp530_tmp02(bgcj007,bgcj008,bgcj009,bgcj016,bgeg037,mm,cqty,cqty2,cqty3,bgec004,kind)
               VALUES(l_tmp1.bgcj007,l_tmp1.bgcj008,l_tmp1.bgcj009,l_tmp1.bgcj016,l_tmp1.bgeg037,
                      l_tmp1.mm,l_tmp1.cqty,l_tmp1.cqty2,l_tmp1.cqty3,l_bgec004,'2')
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp530_tmp02'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF  
            ELSE
               #提前期别
               LET l_tmp1.mm = 0
               #提前采购数量
               LET l_tmp1.cqty2 = 0
               #当期总采购量=采购量 
               LET l_tmp1.cqty3 = l_tmp1.cqty 
               INSERT INTO abgp530_tmp02(bgcj007,bgcj008,bgcj009,bgcj016,bgeg037,mm,cqty,cqty2,cqty3,bgec004,kind)
               VALUES(l_tmp1.bgcj007,l_tmp1.bgcj008,l_tmp1.bgcj009,l_tmp1.bgcj016,l_tmp1.bgeg037,
                      l_tmp1.mm,l_tmp1.cqty,l_tmp1.cqty2,l_tmp1.cqty3,l_bgec004,'2')
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp530_tmp02'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF 
            END IF
         END FOREACH
      END IF
      
      #如果扣除内采和外采的数量,还有剩余,那全部计入外采
      LET l_cqty_s = l_cqty - l_num_i - l_num_w
      IF l_cqty_s > 0 THEN
         #客商等于abgi170中料件的主要供应商            
         # 若 abgi170 未建檔主供應商: 警訊:未建供應商無法產生採購單 
         IF cl_null(l_bgea017) THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_bgea017
            LET g_errparam.code   = 'abg-00315'
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         #供应商
         LET l_tmp1.bgcj016 = l_bgea017
         #采购数量
         LET l_tmp1.cqty = l_cqty_s
         
         LET l_bgec004 = ' ' #外部采购时存空格
         
         #abgi540抓取提前期别,提前采购比率
         #先通过预算料件抓取,若抓不到再通过主分群码抓取
         LET l_bged006 = ''
         LET l_bged007 = ''
         SELECT bged006,bged007 INTO l_bged006,l_bged007
           FROM bged_t
          WHERE bgedent = g_enterprise
            AND bged001 = g_master.bgcj002
            AND bged002 = l_tmp1.bgcj007
            AND bged003 = l_tmp1.bgcj016
            AND bged005 = l_tmp1.bgcj009
               
         IF cl_null(l_bged006) AND cl_null(l_bged007) THEN 
            #按照主分群码抓取
            SELECT bged006,bged007 INTO l_bged006,l_bged007
              FROM bged_t
             WHERE bgedent = g_enterprise
               AND bged001 = g_master.bgcj002
               AND bged002 = l_tmp1.bgcj007
               AND bged003 = l_tmp1.bgcj016
               AND bged004 = l_bgas004
         END IF
         #若抓不到值或者有值但是没有维护提前采购比率,算作不提前,不需要再重新推算采购数量
         #反之，重新推算采购数量
         IF NOT cl_null(l_bged007) AND NOT cl_null(l_bged006) THEN
            #提前期别
            LET l_tmp1.mm = l_tmp1.bgcj008 + l_bged006
            #抓取提前期别的采购量
            LET l_cqty2 = 0
            SELECT cqty2 INTO l_cqty2 FROM abgp530_tmp02
             WHERE bgcj007 = l_tmp1.bgcj007
               AND bgcj008 = l_tmp1.mm
               AND bgcj009 = l_tmp1.bgcj009
               AND bgcj016 = l_tmp1.bgcj016
               AND bgeg037 = l_tmp1.bgeg037
               AND bgec004 = l_bgec004
               AND kind = '3'
            IF cl_null(l_cqty2) THEN LET l_cqty2 = 0 END IF
            #提前采购设置若设置1.剩余期别不处理,当l_tmp1.mm > l_mm_max时,会抓不到资料,则不再考量未来期的采购量,提前采购量l_cqty2=0
            #若选择2.按最后一期的采购量计算,则按最后一期l_mm_max的提前采购量l_cqty2
            IF g_master.set_num = '2' AND l_cqty2 = 0 THEN
               SELECT cqty2 INTO l_cqty2 FROM abgp530_tmp02
                WHERE bgcj007 = l_tmp1.bgcj007
                  AND bgcj008 = l_mm_max
                  AND bgcj009 = l_tmp1.bgcj009
                  AND bgcj016 = l_tmp1.bgcj016
                  AND bgeg037 = l_tmp1.bgeg037
                  AND bgec004 = l_bgec004
                  AND kind = '3'
               IF cl_null(l_cqty2) THEN LET l_cqty2 = 0 END IF
            END IF
            #当期提前采购数量
            LET l_tmp1.cqty2 = l_tmp1.cqty * l_bged007 /100
            LET l_tmp1.cqty2 = s_num_round('4',l_tmp1.cqty2,0)  
            #当期总采购量 = 采购量 - 当期提前采购数量 + 提前期别的提前采购量 
            LET l_tmp1.cqty3 = l_tmp1.cqty - l_tmp1.cqty2 + l_cqty2 
            LET l_tmp1.mm = l_bged006
            INSERT INTO abgp530_tmp02(bgcj007,bgcj008,bgcj009,bgcj016,bgeg037,mm,cqty,cqty2,cqty3,bgec004,kind)
            VALUES(l_tmp1.bgcj007,l_tmp1.bgcj008,l_tmp1.bgcj009,l_tmp1.bgcj016,l_tmp1.bgeg037,
                   l_tmp1.mm,l_tmp1.cqty,l_tmp1.cqty2,l_tmp1.cqty3,l_bgec004,'3')
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins abgp530_tmp02'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         ELSE
            #提前期别
            LET l_tmp1.mm = 0
            #提前采购数量
            LET l_tmp1.cqty2 = 0
            #当期总采购量 = 采购量 
            LET l_tmp1.cqty3 = l_tmp1.cqty
            INSERT INTO abgp530_tmp02(bgcj007,bgcj008,bgcj009,bgcj016,bgeg037,mm,cqty,cqty2,cqty3,bgec004,kind)
            VALUES(l_tmp1.bgcj007,l_tmp1.bgcj008,l_tmp1.bgcj009,l_tmp1.bgcj016,l_tmp1.bgeg037,
                   l_tmp1.mm,l_tmp1.cqty,l_tmp1.cqty2,l_tmp1.cqty3,l_bgec004,'3')
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins abgp530_tmp02'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF
      END IF
   END FOREACH
   
   #3.开始往abgt510塞资料   
   LET l_cqty_s = 0 #采购数量
   LET l_bgegseq = 1
   FOREACH abgp530_p_cs4 INTO l_bgeg.bgeg007,l_bgeg.bgeg009,l_bgeg.bgeg016,l_bgeg.bgeg037,l_bgec004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp530_p_cs4'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
         
      #abgi165销售分类/厂牌/主要供应商
      LET l_bgeg.bgeg019 = ''     
      LET l_bgeg.bgeg024 = '' 
      SELECT bgas009,bgas010
        INTO l_bgeg.bgeg019,l_bgeg.bgeg024
        FROM bgas_t
       WHERE bgasent = g_enterprise
         AND bgas001 = l_bgeg.bgeg009
            
      #abgi170抓内采比率/稅別/币别/采购单价/采购单位/采购预算细项/主要供应商 
      LET l_bgea023 = ''     LET l_bgea018 = ''    
      LET l_bgea020 = ''     LET l_bgea019 = ''
      LET l_bgea005 = ''     LET l_bgea017 = ''
      SELECT bgea023,bgea018,bgea019,bgea020,bgea005,bgea017  
        INTO l_bgea023,l_bgea018,l_bgea019,l_bgea020,l_bgea005,l_bgea017 
        FROM bgea_t
       WHERE bgeaent = g_enterprise
         AND bgea001 = g_master.bgcj002
         AND bgea002 = l_bgeg.bgeg007
         AND bgea003 = l_bgeg.bgeg009
         
      #当预算细项没有值时，提示报错不可录入
      IF cl_null(l_bgea005) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_bgeg.bgeg007,'+',l_bgeg.bgeg009
         LET g_errparam.code   = 'abg-00204' 
         LET g_errparam.popup  = TRUE                  
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      #预算细项
      LET l_bgeg.bgeg049 = l_bgea005
      IF cl_null(l_bgea023) THEN LET l_bgea023 = 0 END IF
      
      #abgi090预算管理组织/可编制预算细项/样表编号
      LET l_bgeg.bgeg004 = ' '
      LET l_bgeg.bgeg011 = ''
      CALL s_abg2_get_bgai002(l_bgeg.bgeg002,l_bgeg.bgeg007,'03') 
         RETURNING l_bgeg.bgeg004,l_bgeg.bgeg011
      IF cl_null(l_bgeg.bgeg004) THEN 
         LET l_bgeg.bgeg004 = ' '
      END IF         
      
      #抓取组织的上层组织
      LET l_bgeg.bgeg047=''
      SELECT ooed005 INTO l_bgeg.bgeg047
        FROM ooed_t
       WHERE ooedent = g_enterprise
         AND ooed001 = '4'
         AND ooed002 = l_bgaa011
         AND ooed003 = l_bgaa010
         AND ooed004 = l_bgeg.bgeg007
      IF cl_null(l_bgeg.bgeg047) THEN 
         LET l_bgeg.bgeg047 = g_master.bgcj007
      END IF

      INITIALIZE l_bgal.* TO NULL   
      SELECT bgal005,bgal006,bgal007,bgal008,bgal009,bgal010,
             bgal011,bgal012,bgal013,bgal014,bgal025,bgal026,bgal027
        INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,
             l_bgal.bgal009,l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,
             l_bgal.bgal013,l_bgal.bgal014,l_bgal.bgal025,l_bgal.bgal026,
             l_bgal.bgal027
        FROM bgal_t
       WHERE bgalent = g_enterprise
         AND bgal001 = l_bgeg.bgeg002
         AND bgal002 = l_bgeg.bgeg007
         AND bgal003 = l_bgeg.bgeg049 
         
      #内采组织对应交易对象/税区
      LET l_ooef024 = ''    LET l_ooef019 = ''
      #内采组织
      IF NOT cl_null(l_bgec004) THEN
         SELECT ooef024,ooef019 INTO l_ooef024,l_ooef019
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_bgec004
            
         #人员/部门   
         LET l_bgeg.bgeg012 = ''    
         LET l_bgeg.bgeg013 = ''    
         SELECT pmab031,pmab059 INTO l_bgeg.bgeg012,l_bgeg.bgeg013
           FROM pmab_t
          WHERE pmabent = g_enterprise
            AND pmabsite = l_bgec004
            AND pmab001 = l_ooef024
      
         #区域/客群/经营方式
         LET l_bgeg.bgeg015 = ''    
         LET l_bgeg.bgeg018 = ''
         LET l_bgeg.bgeg022 = ''
         SELECT pmaa241,pmaa090,pmaa092 INTO l_bgeg.bgeg015,l_bgeg.bgeg018,l_bgeg.bgeg022
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = l_ooef024
            
         #abgi150采购通路
         LET l_bgeg.bgeg023 = ''
         SELECT bgaq010 INTO l_bgeg.bgeg023
           FROM bgaq_t
          WHERE bgaqent = g_enterprise
            AND bgaq001 = l_bgeg.bgeg016
            AND bgaq002 = '2'
            AND bgaqsite = l_bgec004
      ELSE
         #税区
         LET l_ooef019 = ''
         SELECT ooef019 INTO l_ooef019
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_bgeg.bgeg007
            
         #abgi150抓取参考交易对象，即实际交易对象
         LET l_bgap003 = ''
         SELECT bgap003 INTO l_bgap003
           FROM bgap_t
          WHERE bgapent = g_enterprise
            AND bgap001 = l_bgef005
            
         #如果bgap003没有值,抓取单身对应对象,抓第一笔
         IF cl_null(l_bgap003) THEN 
            SELECT bgar002 INTO l_bgap003
              FROM bgar_t
             WHERE bgarent = g_enterprise
               AND bgar001 = l_bgef005
               AND rownum = 1
         END IF
            
         #人员/部门   
         LET l_bgeg.bgeg012 = ''    
         LET l_bgeg.bgeg013 = ''    
         SELECT pmab031,pmab059 INTO l_bgeg.bgeg012,l_bgeg.bgeg013
           FROM pmab_t
          WHERE pmabent = g_enterprise
            AND pmabsite = l_bgeg.bgeg007
            AND pmab001 = l_bgap003
         
         #区域/客群/经营方式
         LET l_bgeg.bgeg015 = ''    
         LET l_bgeg.bgeg018 = ''
         LET l_bgeg.bgeg022 = ''
         SELECT pmaa241,pmaa090,pmaa092 INTO l_bgeg.bgeg015,l_bgeg.bgeg018,l_bgeg.bgeg022 
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = l_bgap003
            
         #abgi150采购通路
         LET l_bgeg.bgeg023 = ''
         SELECT bgaq010 INTO l_bgeg.bgeg023
           FROM bgaq_t
          WHERE bgaqent = g_enterprise
            AND bgaq001 = l_bgeg.bgeg016
            AND bgaq002 = '2'
            AND bgaqsite = l_bgeg.bgeg007
      END IF    
      #成本利润中心
      LET l_bgeg.bgeg014 = ''               
      SELECT ooeg004 INTO l_bgeg.bgeg014
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_bgeg.bgeg013
         
      #账款对象
      LET l_bgeg.bgeg017 = l_bgeg.bgeg016
         
      #取价方式
      #标准价格,取abgi170  稅別,币别,采购单价 
      #预测价格,取abgi520  稅別,币别,采购单价 
      #若abgi520取不到值,则还是抓abgi170的资料
      IF g_master.set_price = '1' THEN 
         LET l_bgeg.bgeg035 = l_bgea018
         LET l_bgeg039 = l_bgea020
         LET l_bgeg.bgeg100 = l_bgea019
      END IF
            
      IF g_master.set_price = '2' THEN 
         #abgi520币别/税别/单价
         LET l_bgee006 = ''
         LET l_bgee007 = ''
         LET l_bgee009 = ''                                    
         SELECT bgee006,bgee007,bgee009                
           INTO l_bgee006,l_bgee007,l_bgee009  
           FROM bgee_t
          WHERE bgeeent = g_enterprise
            AND bgee001 = g_master.bgcj002
            AND bgee002 = l_bgeg.bgeg007
            AND bgee003 = l_bgeg.bgeg009
            AND bgee004 = l_bgeg.bgeg016
         LET l_bgeg.bgeg035 = l_bgee007
         LET l_bgeg039 = l_bgee009 
         LET l_bgeg.bgeg100 = l_bgee006        
         IF cl_null(l_bgeg.bgeg035) THEN LET l_bgeg.bgeg035 = l_bgea018 END IF
         IF cl_null(l_bgeg039) THEN LET l_bgeg039 = l_bgea020 END IF
         IF cl_null(l_bgeg.bgeg100) THEN LET l_bgeg.bgeg100 = l_bgea019 END IF
      END IF
      IF cl_null(l_bgeg039) THEN LET l_bgeg039 = 0 END IF
                   
      #含税否
      LET l_bgeg.bgeg036 = ''
      SELECT oodb005 INTO l_bgeg.bgeg036
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = l_ooef019
         AND oodb002 = l_bgeg.bgeg035
               
      #依据abgi110设置
      #人员
      IF l_bgal.bgal012 = 'N' THEN 
         LET l_bgeg.bgeg012 = ' '
      END IF
      
      #部门
      IF l_bgal.bgal005 = 'N' THEN 
         LET l_bgeg.bgeg013 = ' '
      END IF
      
      #成本利润中心
      IF l_bgal.bgal006 = 'N' THEN 
         LET l_bgeg.bgeg014 = ' '
      END IF
      
      #区域
      IF l_bgal.bgal007 = 'N' THEN 
         LET l_bgeg.bgeg015 = ' '
      END IF
      
      #收付款客商
      IF l_bgal.bgal008 = 'N' THEN 
         LET l_bgeg.bgeg016 = ' '
      END IF
      
      #账款客商
      IF l_bgal.bgal009 = 'N' THEN 
         LET l_bgeg.bgeg017 = ' '
      END IF
      
      #客群
      IF l_bgal.bgal010 = 'N' THEN 
         LET l_bgeg.bgeg018 = ' '
      END IF
      
      #产品类别
      IF l_bgal.bgal011 = 'N' THEN 
         LET l_bgeg.bgeg019 = ' '
      END IF
      
      #经营方式
      IF l_bgal.bgal025 = 'N' THEN 
         LET l_bgeg.bgeg022 = ' '
      END IF
      
      #通路
      IF l_bgal.bgal026 = 'N' THEN 
         LET l_bgeg.bgeg023 = ' '
      END IF
      
      #品牌
      IF l_bgal.bgal027 = 'N' THEN 
         LET l_bgeg.bgeg024 = ' '
      END IF
      
      IF cl_null(l_bgeg.bgeg012) THEN LET l_bgeg.bgeg012 = ' ' END IF
      IF cl_null(l_bgeg.bgeg013) THEN LET l_bgeg.bgeg013 = ' ' END IF
      IF cl_null(l_bgeg.bgeg014) THEN LET l_bgeg.bgeg014 = ' ' END IF
      IF cl_null(l_bgeg.bgeg015) THEN LET l_bgeg.bgeg015 = ' ' END IF
      IF cl_null(l_bgeg.bgeg016) THEN LET l_bgeg.bgeg016 = ' ' END IF
      IF cl_null(l_bgeg.bgeg017) THEN LET l_bgeg.bgeg017 = ' ' END IF
      IF cl_null(l_bgeg.bgeg018) THEN LET l_bgeg.bgeg018 = ' ' END IF
      IF cl_null(l_bgeg.bgeg019) THEN LET l_bgeg.bgeg019 = ' ' END IF
      IF cl_null(l_bgeg.bgeg020) THEN LET l_bgeg.bgeg020 = ' ' END IF
      IF cl_null(l_bgeg.bgeg021) THEN LET l_bgeg.bgeg021 = ' ' END IF
      IF cl_null(l_bgeg.bgeg022) THEN LET l_bgeg.bgeg022 = ' ' END IF
      IF cl_null(l_bgeg.bgeg023) THEN LET l_bgeg.bgeg023 = ' ' END IF
      IF cl_null(l_bgeg.bgeg024) THEN LET l_bgeg.bgeg024 = ' ' END IF
      #固定核算项--end--
         
      #组合key bgeg010
      LET l_bgeg.bgeg010 = "bgeg013=",l_bgeg.bgeg013,"/",
                           "bgeg014=",l_bgeg.bgeg014,"/",
                           "bgeg015=",l_bgeg.bgeg015,"/",
                           "bgeg016=",l_bgeg.bgeg016,"/",
                           "bgeg017=",l_bgeg.bgeg017,"/",
                           "bgeg018=",l_bgeg.bgeg018,"/",
                           "bgeg019=",l_bgeg.bgeg019,"/",
                           "bgeg022=",l_bgeg.bgeg022,"/",
                           "bgeg023=",l_bgeg.bgeg023,"/",
                           "bgeg024=",l_bgeg.bgeg024,"/",
                           "bgeg012=",l_bgeg.bgeg012,"/",
                           "bgeg020=",l_bgeg.bgeg020,"/",
                           "bgeg021=",l_bgeg.bgeg021,""
      #项次
      LET l_bgeg.bgegseq = l_bgegseq
      #逐期抓取金额
      FOR l_i = 1 TO l_mm_max 
         LET l_bgeg.bgeg008 = l_i
         #项次
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt
           FROM bgeg_t
          WHERE bgegent = g_enterprise
            AND bgeg001 = l_bgeg.bgeg001
            AND bgeg002 = l_bgeg.bgeg002
            AND bgeg003 = l_bgeg.bgeg003
            AND bgeg004 = l_bgeg.bgeg004
            AND bgeg005 = l_bgeg.bgeg005
            AND bgeg006 = l_bgeg.bgeg006
            AND bgeg007 = l_bgeg.bgeg007
            AND bgeg008 = l_bgeg.bgeg008
            AND bgeg009 = l_bgeg.bgeg009
            AND bgeg010 = l_bgeg.bgeg010
            AND bgegseq = l_bgegseq
         IF l_cnt > 0 THEN
            SELECT MAX(bgegseq)+1 INTO l_bgeg.bgegseq
              FROM bgeg_t
             WHERE bgegent = g_enterprise
               AND bgeg001 = l_bgeg.bgeg001
               AND bgeg002 = l_bgeg.bgeg002
               AND bgeg003 = l_bgeg.bgeg003
               AND bgeg004 = l_bgeg.bgeg004
               AND bgeg005 = l_bgeg.bgeg005
               AND bgeg006 = l_bgeg.bgeg006
               AND bgeg007 = l_bgeg.bgeg007
               AND bgeg008 = l_bgeg.bgeg008
               AND bgeg009 = l_bgeg.bgeg009
               AND bgeg010 = l_bgeg.bgeg010
         END IF
      
         #汇率
         IF NOT cl_null(l_bgeg.bgeg100) AND NOT cl_null(l_bgaa003) THEN 
            #CALL s_date_get_max_day(l_bgaa002,l_bgeg.bgeg008) RETURNING l_day #161229-00040#1
            #LET l_date=MDY(l_bgeg.bgeg008,l_day,l_bgaa002)                    #161229-00040#1
            CALL s_abg2_get_max_bgac002(l_bgaa002,l_bgeg.bgeg008) RETURNING l_date            
            CALL s_abg_get_bg_rate(g_master.bgcj002,l_date,l_bgeg.bgeg100,l_bgaa003)
            RETURNING l_bgeg.bgeg101
         ELSE
            LET l_bgeg.bgeg101 = 1
         END IF
         
         #抓取数量
         LET l_bgeg.bgeg038=NULL
         EXECUTE abgp530_p_pre8 
           USING l_bgeg.bgeg007,l_bgeg.bgeg009,l_bgeg.bgeg016,l_bgeg.bgeg037,l_bgec004,l_bgeg.bgeg008
            INTO l_bgeg.bgeg038
         #当有提前采购是，抓取提前采购数量
         IF cl_null(l_bgeg.bgeg038) THEN
            #提前期别
            LET l_bged006 = 0
            SELECT DISTINCT mm INTO l_bged006 FROM abgp530_tmp02
             WHERE bgcj007=l_bgeg.bgeg007
               AND bgcj009=l_bgeg.bgeg009
               AND bgcj016=l_bgeg.bgeg016
               AND bgeg037=l_bgeg.bgeg037
               AND bgec004=l_bgec004
            #提前采购期的提前采购量
            LET l_cqty2 = 0         
            SELECT SUM(cqty2) INTO l_cqty2 FROM abgp530_tmp02
             WHERE bgcj007=l_bgeg.bgeg007
               AND bgcj008=l_bgeg.bgeg008 + l_bged006
               AND bgcj009=l_bgeg.bgeg009
               AND bgcj016=l_bgeg.bgeg016
               AND bgeg037=l_bgeg.bgeg037
               AND bgec004=l_bgec004
            IF NOT cl_null(l_cqty2) THEN
               LET l_bgeg.bgeg038 = l_cqty2
            END IF   
         END IF
         
         IF NOT cl_null(l_bgeg.bgeg038) THEN
            #161229-00040#1 ---s--- 單價
            IF g_master.set_price = '2' THEN 
               #abgi520
               LET l_bgee013 = '' LET l_bgee003 = '' LET l_bgee014 = ''                                   
               SELECT bgee006,bgee007,bgee009,bgee003,bgee013,bgee014                        
                 INTO l_bgee006,l_bgee007,l_bgee009,l_bgee003,l_bgee013,l_bgee014  
                 FROM bgee_t
                WHERE bgeeent = g_enterprise
                  AND bgee001 = g_master.bgcj002
                  AND bgee002 = l_bgeg.bgeg007
                  AND bgee003 = l_bgeg.bgeg009
                  AND bgee004 = l_bgeg.bgeg016
               IF l_bgee013 = '1' THEN
                  LET l_bgeg039 = l_bgee009
                  LET l_bgeg.bgeg035 = l_bgee007
                  LET l_bgeg.bgeg100 = l_bgee006                  
               ELSE
                  SELECT MIN(bgcj039)     #取abgt340料件之相關資料
                    INTO l_bgcj039 FROM bgcj_t
                   WHERE bgcjent = g_enterprise 
                     AND bgcj001 = '20'
                     AND bgcj002 = g_master.bgcj002 AND bgcj003 = g_master.bgcj003
                     AND bgcj005 <> '4'             AND bgcj006 = '1' 
                     AND bgcj007 = l_bgeg.bgeg007   AND bgcjstus = 'FC' 
                     AND bgcj008 = l_i 
                     AND bgcj009 = l_bgeg.bgeg009     
                  LET l_bgeg039 = l_bgee014 * l_bgee003      
                  LET l_bgeg.bgeg035 = '' #稅別
                  LET l_bgeg.bgeg100 = '' #幣別 
                  LET l_bgeg.bgeg037 = '' #單位                    
               END IF
               IF cl_null(l_bgeg.bgeg035) THEN LET l_bgeg.bgeg035 = l_bgea018 END IF
               IF cl_null(l_bgeg039) THEN LET l_bgeg039 = l_bgea020 END IF 
               IF cl_null(l_bgeg.bgeg100) THEN LET l_bgeg.bgeg100 = l_bgea019 END IF              
            END IF
            #161229-00040#1---e---                  
            #单价
            LET l_bgeg.bgeg039 = l_bgeg039
            #若考虑影响因子
            #根据影响因子计算单价
            IF g_master.source = 'Y' THEN 
               #影响因子/影响程度/影响数量
               LET l_bgcb004 = ''    LET l_bgcb006 = ''
               LET l_bgcb007 = ''    LET l_price = 0
               FOREACH abgp530_p_cs7 USING l_bgeg.bgeg007,l_bgeg.bgeg009,l_bgeg.bgeg008 INTO l_bgcb004,l_bgcb006,l_bgcb007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'abgp530_p_cs7'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                   
                     LET r_success = FALSE
                  END IF
                  IF cl_null(l_bgcb006) THEN LET l_bgcb006 = 0 END IF
                  IF cl_null(l_bgcb007) THEN LET l_bgcb007 = 0 END IF
                  #影响方式
                  LET l_bgca003 = ''
                  SELECT bgca003 INTO l_bgca003
                    FROM bgca_t
                   WHERE bgcaent = g_enterprise
                     AND bgca001 = l_bgcb004
                  
                  #变动率
                  IF l_bgca003 = '1' THEN 
                     IF cl_null(l_price) THEN 
                        LET l_price = l_bgeg.bgeg039 * l_bgcb006/100
                     ELSE
                        LET l_price = l_price + l_bgeg.bgeg039 * l_bgcb006/100
                     END IF
                  END IF
                  #变动量
                  IF l_bgca003 = '2' THEN 
                     IF cl_null(l_price) THEN 
                        LET l_price = l_bgcb007
                     ELSE
                        LET l_price = l_price + l_bgcb007
                     END IF
                  END IF 
               END FOREACH
               LET l_bgeg.bgeg039 = l_bgeg.bgeg039 + l_price
            END IF
         ELSE
            LET l_bgeg.bgeg038 = 0
            LET l_bgeg.bgeg039 = 0
         END IF
         
         LET l_bgeg.bgeg040 = l_bgeg.bgeg038 * l_bgeg.bgeg039               
         LET l_bgeg.bgeg045 = l_bgeg.bgeg038
         LET l_bgeg.bgeg046 = l_bgeg.bgeg039
         LET l_bgeg.bgeg102 = l_bgeg.bgeg040
         #未税金额、税额、含税金额
         CALL s_tax_count(l_bgeg.bgeg007,l_bgeg.bgeg035,l_bgeg.bgeg102,0,l_bgeg.bgeg100,l_bgeg.bgeg101)
         RETURNING l_bgeg.bgeg103,l_bgeg.bgeg104,l_bgeg.bgeg103,r_xrcd113,r_xrcd114,r_xrcd115
            
         INSERT INTO bgeg_t(bgegent,bgeg001,bgeg002,bgeg003,
                            bgeg004,bgeg005,bgeg006,bgeg007,
                            bgeg008,bgeg009,bgeg010,bgegseq,
                            bgeg011,bgeg012,bgeg013,bgeg014,
                            bgeg015,bgeg016,bgeg017,bgeg018,
                            bgeg019,bgeg020,bgeg021,bgeg022,
                            bgeg023,bgeg024,bgeg025,bgeg026,
                            bgeg027,bgeg028,bgeg029,bgeg030,
                            bgeg031,bgeg032,bgeg033,bgeg034,
                            bgeg035,bgeg036,bgeg037,bgeg038,
                            bgeg039,bgeg040,bgeg041,bgeg042,
                            bgeg043,bgeg044,bgeg045,bgeg046,
                            bgeg047,bgeg048,bgeg049,bgeg050,
                            bgeg051,bgeg100,bgeg101,bgeg102,
                            bgeg103,bgeg104,bgeg105,bgegstus,
                            bgegownid,bgegowndp,bgegcrtid,bgegcrtdp,bgegcrtdt,
                            bgegmodid,bgegmoddt,bgegcnfid,bgegcnfdt)
         VALUES(l_bgeg.bgegent,l_bgeg.bgeg001,l_bgeg.bgeg002,l_bgeg.bgeg003,
                l_bgeg.bgeg004,l_bgeg.bgeg005,l_bgeg.bgeg006,l_bgeg.bgeg007,
                l_bgeg.bgeg008,l_bgeg.bgeg009,l_bgeg.bgeg010,l_bgeg.bgegseq,
                l_bgeg.bgeg011,l_bgeg.bgeg012,l_bgeg.bgeg013,l_bgeg.bgeg014,
                l_bgeg.bgeg015,l_bgeg.bgeg016,l_bgeg.bgeg017,l_bgeg.bgeg018,
                l_bgeg.bgeg019,l_bgeg.bgeg020,l_bgeg.bgeg021,l_bgeg.bgeg022,
                l_bgeg.bgeg023,l_bgeg.bgeg024,l_bgeg.bgeg025,l_bgeg.bgeg026,
                l_bgeg.bgeg027,l_bgeg.bgeg028,l_bgeg.bgeg029,l_bgeg.bgeg030,
                l_bgeg.bgeg031,l_bgeg.bgeg032,l_bgeg.bgeg033,l_bgeg.bgeg034,
                l_bgeg.bgeg035,l_bgeg.bgeg036,l_bgeg.bgeg037,l_bgeg.bgeg038,
                l_bgeg.bgeg039,l_bgeg.bgeg040,l_bgeg.bgeg041,l_bgeg.bgeg042,
                l_bgeg.bgeg043,l_bgeg.bgeg044,l_bgeg.bgeg045,l_bgeg.bgeg046,
                l_bgeg.bgeg047,l_bgeg.bgeg048,l_bgeg.bgeg049,l_bgeg.bgeg050,
                l_bgeg.bgeg051,l_bgeg.bgeg100,l_bgeg.bgeg101,l_bgeg.bgeg102,
                l_bgeg.bgeg103,l_bgeg.bgeg104,l_bgeg.bgeg105,l_bgeg.bgegstus,
                l_bgeg.bgegownid,l_bgeg.bgegowndp,l_bgeg.bgegcrtid,l_bgeg.bgegcrtdp,l_bgeg.bgegcrtdt,
                l_bgeg.bgegmodid,l_bgeg.bgegmoddt,l_bgeg.bgegcnfid,l_bgeg.bgegcnfdt)
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins bgeg_t'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         LET r_flag = 'Y'
      END FOR
      LET l_bgegseq = l_bgegseq + 1
   END FOREACH
   
   RETURN r_success,r_flag
END FUNCTION

#end add-point
 
{</section>}
 
