#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp860.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-06-29 17:50:03), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000021
#+ Filename...: azzp860
#+ Description: 資料擁有單位整批更換作業
#+ Creator....: 00845(2016-06-28 13:16:55)
#+ Modifier...: 00824 -SD/PR- 00000
 
{</section>}
 
{<section id="azzp860.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#
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
       l_olduser LIKE type_t.chr500, 
   l_newuser LIKE type_t.chr500, 
   l_olddept LIKE type_t.chr500, 
   l_newdept LIKE type_t.chr500, 
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
 
{<section id="azzp860.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL azzp860_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp860 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp860_init()
 
      #進入選單 Menu (="N")
      CALL azzp860_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_azzp860
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp860.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp860_init()
 
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
 
{<section id="azzp860.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp860_ui_dialog()
 
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
         INPUT BY NAME g_master.l_olduser,g_master.l_newuser,g_master.l_olddept,g_master.l_newdept 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_olduser
            #add-point:BEFORE FIELD l_olduser name="input.b.l_olduser"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_olduser
            
            #add-point:AFTER FIELD l_olduser name="input.a.l_olduser"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_olduser
            #add-point:ON CHANGE l_olduser name="input.g.l_olduser"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_newuser
            #add-point:BEFORE FIELD l_newuser name="input.b.l_newuser"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_newuser
            
            #add-point:AFTER FIELD l_newuser name="input.a.l_newuser"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_newuser
            #add-point:ON CHANGE l_newuser name="input.g.l_newuser"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_olddept
            #add-point:BEFORE FIELD l_olddept name="input.b.l_olddept"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_olddept
            
            #add-point:AFTER FIELD l_olddept name="input.a.l_olddept"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_olddept
            #add-point:ON CHANGE l_olddept name="input.g.l_olddept"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_newdept
            #add-point:BEFORE FIELD l_newdept name="input.b.l_newdept"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_newdept
            
            #add-point:AFTER FIELD l_newdept name="input.a.l_newdept"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_newdept
            #add-point:ON CHANGE l_newdept name="input.g.l_newdept"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_olduser
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_olduser
            #add-point:ON ACTION controlp INFIELD l_olduser name="input.c.l_olduser"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.l_olduser             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_master.l_olduser = g_qryparam.return1              

            DISPLAY g_master.l_olduser TO l_olduser              #

            NEXT FIELD l_olduser                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.l_newuser
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_newuser
            #add-point:ON ACTION controlp INFIELD l_newuser name="input.c.l_newuser"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.l_newuser             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_master.l_newuser = g_qryparam.return1              

            DISPLAY g_master.l_newuser TO l_newuser              #

            NEXT FIELD l_newuser                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.l_olddept
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_olddept
            #add-point:ON ACTION controlp INFIELD l_olddept name="input.c.l_olddept"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.l_olddept             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooeg001_7()                                #呼叫開窗
 
            LET g_master.l_olddept = g_qryparam.return1              

            DISPLAY g_master.l_olddept TO l_olddept              #

            NEXT FIELD l_olddept                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.l_newdept
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_newdept
            #add-point:ON ACTION controlp INFIELD l_newdept name="input.c.l_newdept"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.l_newdept             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooeg001_7()                                #呼叫開窗
 
            LET g_master.l_newdept = g_qryparam.return1              

            DISPLAY g_master.l_newdept TO l_newdept              #

            NEXT FIELD l_newdept                          #返回原欄位



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
            CALL azzp860_get_buffer(l_dialog)
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
         CALL azzp860_init()
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
                 CALL azzp860_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp860_transfer_argv(ls_js)
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
 
{<section id="azzp860.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp860_transfer_argv(ls_js)
 
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
 
{<section id="azzp860.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp860_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_cnt           LIKE type_t.num5
   DEFINE ls_cnt2          LIKE type_t.num5
   DEFINE ls_ownid         LIKE dzeb_t.dzeb002
   DEFINE ls_owndp         LIKE dzeb_t.dzeb002
   DEFINE ls_err           LIKE type_t.chr1
   DEFINE ls_dzeb001       LIKE dzeb_t.dzeb001
   DEFINE ls_alt_trigger   LIKE type_t.chr1
   DEFINE ls_trigger_name  LIKE type_t.chr100
   DEFINE ls_status        LIKE type_t.chr20
   DEFINE ls_toggle        LIKE type_t.chr20
   DEFINE ls_str           STRING
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"

   #員工編號與部門編號最少要填一個
   #若有填員工編號或是部門編號，則新舊欄位都要填寫，否則會不知道怎麼置換
   IF cl_null(g_master.l_olduser) THEN
      IF cl_null(g_master.l_newuser) THEN
         IF cl_null(g_master.l_olddept) THEN
            #員工編號或部門編號最少須填寫一個
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = "azz-00392"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN
         ELSE
            IF cl_null(g_master.l_newdept) THEN
               #新舊欄位都須填寫資訊，否則會無法置換資料
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "azz-00393"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN
            ELSE
               IF g_master.l_olddept = g_master.l_newdept THEN
                  #要置換的資料一致，所以不往下處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "azz-00394"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  RETURN
               END IF
            END IF
         END IF
      ELSE
         #新舊欄位都須填寫資訊，否則會無法置換資料
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "azz-00393"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN
      END IF
   ELSE
      IF cl_null(g_master.l_newuser) THEN
         #新舊欄位都須填寫資訊，否則會無法置換資料
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = "azz-00393"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN
      ELSE
         IF g_master.l_olduser = g_master.l_newuser THEN
            #要置換的資料一致，所以不往下處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = "azz-00394"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN
         END IF

         IF (cl_null(g_master.l_olddept) AND NOT cl_null(g_master.l_newdept))
            OR (NOT cl_null(g_master.l_olddept) AND cl_null(g_master.l_newdept)) THEN

            #新舊欄位都須填寫資訊，否則會無法置換資料
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = "azz-00393"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN
         ELSE
            IF g_master.l_olddept = g_master.l_newdept THEN
               #要置換的資料一致，所以不往下處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "azz-00394"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN
            END IF
         END IF
      END IF
   END IF
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET ls_sql = "SELECT COUNT(DISTINCT gztz001) FROM gztz_t tz ",
                   " WHERE EXISTS (SELECT 1 FROM dzeb_t eb ",
                                  " WHERE eb.dzeb001 = tz.gztz001 AND eb.dzeb002 = tz.gztz002)",
                     " AND tz.gztz001 NOT LIKE 'dz%' ",
                     " AND (tz.gztz002 LIKE '%ownid' OR tz.gztz002 LIKE '%owndp')"
      PREPARE azzp860_get_count_pre FROM ls_sql
      EXECUTE azzp860_get_count_pre INTO ls_cnt

      CALL cl_progress_bar_no_window(ls_cnt)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp860_process_cs CURSOR FROM ls_sql
#  FOREACH azzp860_process_cs INTO
   #add-point:process段process name="process.process"

   CALL s_transaction_begin()

   LET ls_cnt2 = 0
   LET ls_err = "N"

   LET ls_sql = "SELECT DISTINCT gztz001 FROM gztz_t tz ",
                " WHERE EXISTS (SELECT 1 FROM dzeb_t eb ",
                               " WHERE eb.dzeb001 = tz.gztz001 AND eb.dzeb002 = tz.gztz002)",
                  " AND tz.gztz001 NOT LIKE 'dz%' ",
                  " AND (tz.gztz002 LIKE '%ownid' OR tz.gztz002 LIKE '%owndp')",
               "  ORDER BY tz.gztz001"
   DECLARE azzp860_process_cs CURSOR FROM ls_sql
   FOREACH azzp860_process_cs INTO ls_dzeb001
      #檢查表格是否有設trigger
      LET ls_alt_trigger = "N"
      LET ls_sql = "SELECT dts.trigger_name,dts.status,dos.status toggle ",
                    " FROM DBA_TRIGGERS dts ",
                    " LEFT OUTER JOIN dba_objects dos ",
                                 " ON dos.object_name = dts.trigger_name ",
                                " AND dos.owner       = dts.owner ",
                                " AND dos.object_type = 'TRIGGER'",
                   " WHERE dts.owner = '",UPSHIFT(g_dbs),"'",
                     " AND dts.table_name = '",UPSHIFT(ls_dzeb001),"'"

      PREPARE azzp860_get_trigger_pre FROM ls_sql
      EXECUTE azzp860_get_trigger_pre INTO ls_trigger_name,ls_status,ls_toggle
      
      #若有設trigger，但此trigger本身就是有問題(INVALID)的話，
      #因為可能會造成後續update資料的時候發生錯誤，
      #所以必須先將此trigger設成失效，待update完成後，再啟用該trigger，
      #但若是原本就可以正常執行的trigger，因為不會造成影響，所以就不異動
      IF ls_status = "ENABLED" AND ls_toggle = "INVALID" THEN
         LET ls_sql = "ALTER trigger ",ls_trigger_name," disable"
         PREPARE azzp860_alt_trigger_status_pre FROM ls_sql
         EXECUTE azzp860_alt_trigger_status_pre

         LET ls_alt_trigger = "Y"   #紀錄此trigger是否有被異動，若有後續須回復
      END IF
      
      #取得要update的欄位名稱
      SELECT dzeb002 INTO ls_ownid FROM dzeb_t WHERE dzeb001 = ls_dzeb001 AND dzeb002 LIKE '%ownid'
      SELECT dzeb002 INTO ls_owndp FROM dzeb_t WHERE dzeb001 = ls_dzeb001 AND dzeb002 LIKE '%owndp'

      LET ls_sql = NULL
      #若同時填了員工編號及部門編號的條件
      #註：有可能該員工原本同時負責多個部門的職務，但現在有異動
      #   例如：原本負責ABC三個部門，現在改為只有AB兩個部門，C部門則改為其他人負責，
      #         這種狀況，就應該同時下員工編號及C部門的部門編號為條件去做異動，才不會影響到其他的資料
      IF NOT cl_null(g_master.l_olduser) AND NOT cl_null(g_master.l_olddept) THEN
         LET ls_sql = "UPDATE ",ls_dzeb001 CLIPPED,
                        " SET ",ls_ownid CLIPPED," = '",g_master.l_newuser,"',",
                                ls_owndp CLIPPED," = '",g_master.l_newdept,"'",
                      " WHERE ",ls_ownid CLIPPED," = '",g_master.l_olduser,"'",
                        " AND ",ls_owndp CLIPPED," = '",g_master.l_olddept,"'"
      ELSE
         #若是只有填寫部門編號的條件
         IF cl_null(g_master.l_olduser) THEN
            IF NOT cl_null(g_master.l_olddept) THEN
               LET ls_sql = "UPDATE ",ls_dzeb001 CLIPPED,
                              " SET ",ls_owndp CLIPPED," = '",g_master.l_newdept,"'",
                            " WHERE ",ls_owndp CLIPPED," = '",g_master.l_olddept,"'"
            END IF
         ELSE
            #若是只有填寫員工編號的條件
            IF cl_null(g_master.l_olddept) THEN
               LET ls_sql = "UPDATE ",ls_dzeb001 CLIPPED,
                              " SET ",ls_ownid CLIPPED," = '",g_master.l_newuser,"'",
                            " WHERE ",ls_ownid CLIPPED," = '",g_master.l_olduser,"'"
            END IF
         END IF
      END IF
      
      IF NOT cl_null(ls_sql) THEN
         PREPARE azzp860_update_data_pre FROM ls_sql
         EXECUTE azzp860_update_data_pre
         IF SQLCA.SQLCODE THEN
            LET ls_err = "Y"
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            #若前面有異動trigger狀態，在離開前須將狀態回復
            IF ls_alt_trigger = "Y" THEN
               LET ls_sql = "ALTER trigger ",ls_trigger_name," enable"
               PREPARE azzp860_alt_trigger_back_1_pre FROM ls_sql
               EXECUTE azzp860_alt_trigger_back_1_pre
            END IF

            EXIT FOREACH
         END IF
      END IF
      
      #若前面有異動trigger狀態，在離開前須將狀態回復
      IF ls_alt_trigger = "Y" THEN
         LET ls_sql = "ALTER trigger ",ls_trigger_name," enable"
         PREPARE azzp860_alt_trigger_back_2_pre FROM ls_sql
         EXECUTE azzp860_alt_trigger_back_2_pre
      END IF

      IF g_bgjob <> "Y" THEN
         LET ls_cnt2 = ls_cnt2 + 1
         LET ls_str = "目前執行進度... ",ls_cnt2 USING '<<<<<'," / ",ls_cnt USING '<<<<<'," 表格名稱：",ls_dzeb001
         CALL cl_progress_no_window_ing(ls_str)
      END IF
   END FOREACH
   
   IF ls_err = "Y" THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
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
   CALL azzp860_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp860.get_buffer" >}
PRIVATE FUNCTION azzp860_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_olduser = p_dialog.getFieldBuffer('l_olduser')
   LET g_master.l_newuser = p_dialog.getFieldBuffer('l_newuser')
   LET g_master.l_olddept = p_dialog.getFieldBuffer('l_olddept')
   LET g_master.l_newdept = p_dialog.getFieldBuffer('l_newdept')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp860.msgcentre_notify" >}
PRIVATE FUNCTION azzp860_msgcentre_notify()
 
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
 
{<section id="azzp860.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
