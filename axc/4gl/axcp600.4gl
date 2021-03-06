#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp600.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-09-21 18:11:35), PR版次:0005(2017-02-13 16:31:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: axcp600
#+ Description: 成本月結作業
#+ Creator....: 05947(2015-09-17 17:11:00)
#+ Modifier...: 05947 -SD/PR- 07423
 
{</section>}
 
{<section id="axcp600.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#8   2016/04/21 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160905-00007#3   2016/09/05 By zhujing     调整系统中无ENT的SQL条件增加ent
#161019-00017#7   2016/10/19   By zhujing 据点组织开窗资料整批调整
#170210-00055#1   2017/02/13 By fionchen    調整取當期年度期別的最後一天時,應用畫面執行的現行成本年度取得  
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
       xcazld LIKE type_t.chr5, 
   xcazld_desc LIKE type_t.chr80, 
   comp LIKE type_t.chr10, 
   comp_desc LIKE type_t.chr80, 
   xcaz001 LIKE type_t.chr10, 
   xcaz001_desc LIKE type_t.chr80, 
   yy LIKE type_t.num5, 
   mm LIKE type_t.num5, 
   chk LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp600.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp600_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp600 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp600_init()
 
      #進入選單 Menu (="N")
      CALL axcp600_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp600
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp600.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp600_init()
 
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
   LET g_master.chk='N'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp600.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp600_ui_dialog()
 
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
         INPUT BY NAME g_master.xcazld,g_master.comp,g_master.xcaz001,g_master.yy,g_master.mm,g_master.chk  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL axcp600_default()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcazld
            
            #add-point:AFTER FIELD xcazld name="input.a.xcazld"
            IF NOT cl_null(g_master.xcazld) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xcazld
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.xcazld
                  CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaa001='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.xcazld_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_master.xcazld_desc                  
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcazld
            #add-point:BEFORE FIELD xcazld name="input.b.xcazld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcazld
            #add-point:ON CHANGE xcazld name="input.g.xcazld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD comp
            
            #add-point:AFTER FIELD comp name="input.a.comp"
            #161019-00017#7 add-S
            IF NOT cl_null(g_master.comp) THEN 
                INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.comp
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               IF cl_chk_exist("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               
            END IF
            #161019-00017#7 add-E
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.comp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.comp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.comp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD comp
            #add-point:BEFORE FIELD comp name="input.b.comp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE comp
            #add-point:ON CHANGE comp name="input.g.comp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcaz001
            
            #add-point:AFTER FIELD xcaz001 name="input.a.xcaz001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcaz001
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcaz001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcaz001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcaz001
            #add-point:BEFORE FIELD xcaz001 name="input.b.xcaz001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcaz001
            #add-point:ON CHANGE xcaz001 name="input.g.xcaz001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD yy
            #add-point:BEFORE FIELD yy name="input.b.yy"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD yy
            
            #add-point:AFTER FIELD yy name="input.a.yy"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE yy
            #add-point:ON CHANGE yy name="input.g.yy"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mm
            #add-point:BEFORE FIELD mm name="input.b.mm"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mm
            
            #add-point:AFTER FIELD mm name="input.a.mm"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mm
            #add-point:ON CHANGE mm name="input.g.mm"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcazld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcazld
            #add-point:ON ACTION controlp INFIELD xcazld name="input.c.xcazld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcazld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.xcazld = g_qryparam.return1              

            DISPLAY g_master.xcazld TO xcazld              #

            NEXT FIELD xcazld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.comp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD comp
            #add-point:ON ACTION controlp INFIELD comp name="input.c.comp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.comp             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooef001_2()                                #呼叫開窗

            LET g_master.comp = g_qryparam.return1              
            #LET g_master.ooef001 = g_qryparam.return2 
            DISPLAY g_master.comp TO comp              #
            #DISPLAY g_master.ooef001 TO ooef001 #组织编号
            NEXT FIELD comp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcaz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcaz001
            #add-point:ON ACTION controlp INFIELD xcaz001 name="input.c.xcaz001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcaz001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xcat001()                                #呼叫開窗

            LET g_master.xcaz001 = g_qryparam.return1              

            DISPLAY g_master.xcaz001 TO xcaz001              #

            NEXT FIELD xcaz001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.yy
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD yy
            #add-point:ON ACTION controlp INFIELD yy name="input.c.yy"
            
            #END add-point
 
 
         #Ctrlp:input.c.mm
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mm
            #add-point:ON ACTION controlp INFIELD mm name="input.c.mm"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
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
            CALL axcp600_get_buffer(l_dialog)
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
         CALL axcp600_init()
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
                 CALL axcp600_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp600_transfer_argv(ls_js)
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
 
{<section id="axcp600.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp600_transfer_argv(ls_js)
 
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
 
{<section id="axcp600.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp600_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
 DEFINE l_n           LIKE type_t.num5
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
#  DECLARE axcp600_process_cs CURSOR FROM ls_sql
#  FOREACH axcp600_process_cs INTO
   #add-point:process段process name="process.process"
 
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL axcp600_p()
      IF g_success = 'N' THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp600_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp600.get_buffer" >}
PRIVATE FUNCTION axcp600_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcazld = p_dialog.getFieldBuffer('xcazld')
   LET g_master.comp = p_dialog.getFieldBuffer('comp')
   LET g_master.xcaz001 = p_dialog.getFieldBuffer('xcaz001')
   LET g_master.yy = p_dialog.getFieldBuffer('yy')
   LET g_master.mm = p_dialog.getFieldBuffer('mm')
   LET g_master.chk = p_dialog.getFieldBuffer('chk')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp600.msgcentre_notify" >}
PRIVATE FUNCTION axcp600_msgcentre_notify()
 
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
 
{<section id="axcp600.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 设定预设值
################################################################################
PRIVATE FUNCTION axcp600_default()

   CALL s_axc_set_site_default() RETURNING g_master.comp,g_master.xcazld,g_master.yy,g_master.mm,g_master.xcaz001
   DISPLAY BY NAME g_master.comp,g_master.xcazld,g_master.yy,g_master.mm,g_master.xcaz001

END FUNCTION

################################################################################
# Descriptions...: 批处理逻辑
################################################################################
PRIVATE FUNCTION axcp600_p()
 
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_date        DATE
   DEFINE l_yy          LIKE glav_t.glav006
   DEFINE l_mm          LIKE type_t.num5
   DEFINE l_year        LIKE glav_t.glav002   #170210-00055#1 add
     
   CALL s_transaction_begin()
 
   LET g_success = 'Y'
   LET l_n=0
     
   
   #判断是否有该年度、期别的成本凭证没有抛转总账的，如果有则报错，月结不成功。
   SELECT COUNT(1) INTO l_n FROM xcea_t 
     WHERE xceastus='Y' AND (xcea101=' ' OR xcea101 IS NULL) AND xcea004=g_master.yy AND xcea005=g_master.mm
       AND xceaent = g_enterprise   #160905-00007#3 add
   IF l_n>0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00732'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   
   #如果月结成功，且账套是主账套并成本计算类型是该主账套设定的主成本计算类型则自动更新
   #aoos020上的成本关账日期为本年度期别的最后一天；
   #同时更新aoos020上的现行成本年度、期别为下一个期别
   SELECT COUNT(1) INTO l_n FROM glaa_t WHERE glaa014 = 'Y' AND glaald=g_master.xcazld AND glaa120=g_master.xcaz001
      AND glaaent = g_enterprise #160905-00007#3 add  
   IF l_n>0 THEN
      SELECT MAX(glav006) INTO l_yy FROM glav_t WHERE glav002=g_master.yy
         AND glavent = g_enterprise #160905-00007#3 add
      LET l_mm=g_master.mm
      LET l_year=g_master.yy        #170210-00055#1 add
      LET g_master.mm=g_master.mm+1
      IF g_master.mm>l_yy THEN
         LET g_master.yy=g_master.yy+1
         LET g_master.mm=g_master.mm-l_yy
         LET l_mm=l_yy
      END IF
      UPDATE ooab_t SET ooab002=g_master.yy WHERE ooab001 LIKE 'S_FIN-6010' AND ooabent=g_enterprise AND ooabsite=g_master.comp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE year:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
         RETURN
      END IF
      CALL cl_progress_no_window_ing("update year")   
      UPDATE ooab_t SET ooab002=g_master.mm WHERE ooab001 LIKE 'S_FIN-6011' AND ooabent=g_enterprise AND ooabsite=g_master.comp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE month:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
         RETURN
      END IF
      CALL cl_progress_no_window_ing("update month")   
     #SELECT MAX(glav004) INTO l_date FROM glav_t WHERE glav002=g_master.yy AND glav006=l_mm    #170210-00055#1 mark
      SELECT MAX(glav004) INTO l_date FROM glav_t WHERE glav002=l_year AND glav006=l_mm         #170210-00055#1 add
         AND glavent = g_enterprise #160905-00007#3 add
      IF NOT cl_null(l_date) THEN
         UPDATE ooab_t SET ooab002=l_date WHERE ooab001 LIKE 'S_FIN-6012' AND ooabent=g_enterprise AND ooabsite=g_master.comp
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "UPDATE day:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N'
            RETURN
         END IF
      END IF
      CALL cl_progress_no_window_ing("update last day")
   END IF
   
END FUNCTION

#end add-point
 
{</section>}
 
