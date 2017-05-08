#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr470.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-01-28 10:31:25), PR版次:0004(2016-10-28 11:09:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: axrr470
#+ Description: 各期遞延沖轉列印
#+ Creator....: 06821(2016-01-27 10:57:21)
#+ Modifier...: 06821 -SD/PR- 08729
 
{</section>}
 
{<section id="axrr470.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160811-00009#5   2016/08/18  By 01531    账务中心/法人/账套权限控管
#161021-00050#7   2016/10/28  By 08729    處理組織開窗
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
   DEFINE gi_hiden_rep_temp    LIKE type_t.num5             
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
       xrepsite LIKE xrep_t.xrepsite, 
   xrepsite_desc LIKE type_t.chr80, 
   xrepld LIKE xrep_t.xrepld, 
   xrepld_desc LIKE type_t.chr80, 
   xrep001 LIKE xrep_t.xrep001, 
   xrep002 LIKE xrep_t.xrep002,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_xrepld      STRING
DEFINE g_glaacomp       LIKE glaa_t.glaacomp
DEFINE g_glaa003        LIKE glaa_t.glaa003
DEFINE xrepsite_t       LIKE xrep_t.xrepsite  #161021-00050#7 add
DEFINE xrepld_t         LIKE xrep_t.xrepld    #161021-00050#7 add
DEFINE g_comp           LIKE xrep_t.xrepcomp  #161021-00050#7 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrr470.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axrr470_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrr470 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrr470_init()
 
      #進入選單 Menu (="N")
      CALL axrr470_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrr470
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrr470.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrr470_init()
   #add-point:init段define name="init.define"
   
   #end add-point
   #add-point:init段define (客製用) name="init.define_customerization"
   
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
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔
   CALL axrr470_set_def()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrr470.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr470_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_errno        LIKE type_t.chr100
   DEFINE l_glav002      LIKE glav_t.glav002
   DEFINE l_glav005      LIKE glav_t.glav005
   DEFINE l_sdate_s      LIKE glav_t.glav004
   DEFINE l_sdate_e      LIKE glav_t.glav004
   DEFINE l_glav006      LIKE glav_t.glav006
   DEFINE l_pdate_s      LIKE glav_t.glav004   #當期起始日
   DEFINE l_pdate_e      LIKE glav_t.glav004   #當期截止日
   DEFINE l_glav007      LIKE glav_t.glav007
   DEFINE l_wdate_s      LIKE glav_t.glav004
   DEFINE l_wdate_e      LIKE glav_t.glav004
   DEFINE l_success      LIKE type_t.num5      #161021-00050#7
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET xrepsite_t = g_master.xrepsite #161021-00050#7 add
   LET xrepld_t = g_master.xrepld #161021-00050#7 add
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrepsite,g_master.xrepld,g_master.xrep001,g_master.xrep002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.wc = "1=1"
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrepsite
            
            #add-point:AFTER FIELD xrepsite name="input.a.xrepsite"
            #帳務中心
            LET g_master.xrepsite_desc = ''
            IF NOT cl_null(g_master.xrepsite) THEN
               #161021-00050#7-add(s)
               IF g_master.xrepsite != xrepsite_t THEN 
                  CALL s_fin_orga_get_comp_ld(g_master.xrepsite) RETURNING l_success,g_errno,g_comp,g_master.xrepld
               END IF
               #161021-00050#7-add(e)
               #以目前的資料重展結構,避免[帳套]有值時會比對錯誤,在s_fin_account_center_with_ld_chk做勾稽時會依據這個結構做是否有符合的帳套
               CALL s_fin_account_center_sons_query('3',g_master.xrepsite,g_today,'1')
               #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次
               #避免USER 在帳務中心跟帳套卡住走不了 增加對帳套有資料的處理
               IF NOT cl_null(g_master.xrepld) THEN   
                  CALL s_fin_account_center_with_ld_chk(g_master.xrepsite,g_master.xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     #勾稽失敗:目前的帳套不在這個帳務中心下 因此預設值給帳務中心的主帳套
                     CALL s_fin_orga_get_comp_ld(g_master.xrepsite) RETURNING g_sub_success,g_errno,g_glaacomp,g_master.xrepld
                     #判斷這個主帳套使用者是否有權限
                     CALL s_fin_account_center_with_ld_chk(g_master.xrepsite,g_master.xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  END IF
                  #判斷完成後 若勾稽失敗則回復舊值
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_master.xrepsite = ''          #161021-00050#7 mark
                     #LET g_master.xrepld   = ''          #161021-00050#7 mark
                     LET g_master.xrepsite = xrepsite_t   #161021-00050#7 add
                     LET g_master.xrepld = xrepld_t       #161021-00050#7 add
                     CALL s_desc_get_department_desc(g_master.xrepsite) RETURNING g_master.xrepsite_desc
                     CALL s_desc_get_ld_desc(g_master.xrepld) RETURNING g_master.xrepld_desc
                     DISPLAY BY NAME g_master.xrepsite_desc,g_master.xrepld_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_desc_get_ld_desc(g_master.xrepld) RETURNING g_master.xrepld_desc
                  DISPLAY BY NAME g_master.xrepld_desc
               END IF
               #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次
               CALL s_fin_account_center_with_ld_chk(g_master.xrepsite,g_master.xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #LET g_master.xrepsite = ''          #161021-00050#7 mark
                  LET g_master.xrepsite = xrepsite_t   #161021-00050#7 add
                  LET g_master.xrepld = xrepld_t       #161021-00050#7 add
                  CALL s_desc_get_department_desc(g_master.xrepsite) RETURNING g_master.xrepsite_desc
                  DISPLAY BY NAME g_master.xrepsite_desc
                  CALL s_desc_get_ld_desc(g_master.xrepld) RETURNING g_master.xrepld_desc   #161021-00050#7 add
                  DISPLAY BY NAME g_master.xrepld_desc                                       #161021-00050#7 add
                  NEXT FIELD CURRENT
               END IF
               #依據正確的資料再重展一次結構
               CALL s_fin_account_center_sons_query('3',g_master.xrepsite,g_today,'1')  
               CALL s_fin_account_center_ld_str() RETURNING g_wc_xrepld
               CALL s_fin_get_wc_str(g_wc_xrepld) RETURNING g_wc_xrepld
            END IF
            CALL s_desc_get_department_desc(g_master.xrepsite) RETURNING g_master.xrepsite_desc                    
            DISPLAY BY NAME g_master.xrepsite_desc
            CALL s_desc_get_ld_desc(g_master.xrepld) RETURNING g_master.xrepld_desc   #161021-00050#7 add
            DISPLAY BY NAME g_master.xrepld_desc                                       #161021-00050#7 ad
            LET xrepsite_t = g_master.xrepsite  #161021-00050#7 add
            LET xrepld_t   = g_master.xrepld    #161021-00050#7 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrepsite
            #add-point:BEFORE FIELD xrepsite name="input.b.xrepsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrepsite
            #add-point:ON CHANGE xrepsite name="input.g.xrepsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrepld
            
            #add-point:AFTER FIELD xrepld name="input.a.xrepld"
            IF NOT cl_null(g_master.xrepld) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.xrepsite,g_master.xrepld,g_user,'3','N',g_wc_xrepld,g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.xrepld = ''
                  CALL s_desc_get_ld_desc(g_master.xrepld) RETURNING g_master.xrepld_desc
                  DISPLAY BY NAME g_master.xrepld,g_master.xrepld_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_ld_desc(g_master.xrepld) RETURNING g_master.xrepld_desc
               CALL s_ld_sel_glaa(g_master.xrepld,'glaa003') RETURNING  g_sub_success,g_glaa003
               #抓取會計週期參照表之年度期別
               CALL s_get_accdate(g_glaa003,g_today,'','')
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               LET g_master.xrep001 = l_glav002
               LET g_master.xrep002 = l_glav006
               DISPLAY BY NAME g_master.xrepld_desc,g_master.xrep001,g_master.xrep002
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrepld
            #add-point:BEFORE FIELD xrepld name="input.b.xrepld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrepld
            #add-point:ON CHANGE xrepld name="input.g.xrepld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrep001
            #add-point:BEFORE FIELD xrep001 name="input.b.xrep001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrep001
            
            #add-point:AFTER FIELD xrep001 name="input.a.xrep001"
            IF NOT cl_null(g_master.xrep001) THEN
               IF NOT s_fin_date_chk_year(g_master.xrep001) THEN
                  LET g_master.xrep001 = ''
                  DISPLAY BY NAME g_master.xrep001
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_master.xrep001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrep001
            #add-point:ON CHANGE xrep001 name="input.g.xrep001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrep002
            #add-point:BEFORE FIELD xrep002 name="input.b.xrep002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrep002
            
            #add-point:AFTER FIELD xrep002 name="input.a.xrep002"
            IF NOT cl_null(g_master.xrep002) THEN
               IF g_master.xrep002 < 1 OR g_master.xrep002 > 13 THEN
                  LET g_master.xrep002= ''
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00106'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrep002
            #add-point:ON CHANGE xrep002 name="input.g.xrep002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrepsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrepsite
            #add-point:ON ACTION controlp INFIELD xrepsite name="input.c.xrepsite"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrepsite
            #CALL q_ooef001()     #161021-00050#7 mark
            CALL q_ooef001_46()   #161021-00050#7 add 
            LET g_master.xrepsite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.xrepsite) RETURNING g_master.xrepsite_desc
            DISPLAY g_master.xrepsite,g_master.xrepsite_desc TO xrepsite,xrepsite_desc
            NEXT FIELD xrepsite
            #END add-point
 
 
         #Ctrlp:input.c.xrepld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrepld
            #add-point:ON ACTION controlp INFIELD xrepld name="input.c.xrepld"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            CALL s_fin_account_center_sons_query('3',g_master.xrepsite,g_today,'1')
#160811-00009#5 mod s---           
#            CALL s_fin_account_center_ld_str() RETURNING g_wc_xrepld
#            CALL s_fin_get_wc_str(g_wc_xrepld) RETURNING g_wc_xrepld
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc   
#160811-00009#5 mod e---
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrepld
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_xrepld CLIPPED," " #160811-00009#5
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,"" #160811-00009#5 
            CALL q_authorised_ld()
            LET g_master.xrepld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.xrepld) RETURNING g_master.xrepld_desc
            DISPLAY BY NAME g_master.xrepld,g_master.xrepld_desc
            NEXT FIELD xrepld   
            #END add-point
 
 
         #Ctrlp:input.c.xrep001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrep001
            #add-point:ON ACTION controlp INFIELD xrep001 name="input.c.xrep001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrep002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrep002
            #add-point:ON ACTION controlp INFIELD xrep002 name="input.c.xrep002"
            
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL axrr470_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axrr470_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET g_master.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後 name="ui_dialog.qbe_select"
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION output
            LET g_action_choice = "output"
            ACCEPT DIALOG
 
         ON ACTION quickprint
            LET g_action_choice = "quickprint"
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            CALL axrr470_set_def()
            LET g_master.wc = "1=1"
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         ON ACTION rpt_replang
            CALL cl_gr_set_dlang()
 
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
         CALL axrr470_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
 
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
                 CALL axrr470_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrr470_transfer_argv(ls_js)
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
         LET gi_hiden_rep_temp = FALSE   #報表樣板設定
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrr470.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrr470_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axrr470.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrr470_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_r01_status LIKE type_t.num5
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   ##cmdrun使用的陣列 
   #add-point:process段define name="process.define"
   
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
 
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axrr470_process_cs CURSOR FROM ls_sql
#  FOREACH axrr470_process_cs INTO
   #add-point:process段process name="process.process"
   IF cl_null(g_master.wc) THEN  ## 若是t類進來 會是傳字串參數的方式
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
            LET ls_next = l_token.nextToken()
            LET l_arg[l_cnt] = ls_next
            LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET g_master.wc = l_arg[01]
   ELSE
      LET g_master.wc = g_master.wc CLIPPED, " AND xrepent = '",g_enterprise,"' AND xrepsite = '",g_master.xrepsite,"' AND xrepld  ='",g_master.xrepld,"' ",   
                                             " AND xrep001 = '",g_master.xrep001,"' AND xrep002 = '",g_master.xrep002,"' "
   END IF

   CALL axrr470_g01(g_master.wc)
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axrr470.get_buffer" >}
PRIVATE FUNCTION axrr470_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.xrepsite = p_dialog.getFieldBuffer('xrepsite')
   LET g_master.xrepld = p_dialog.getFieldBuffer('xrepld')
   LET g_master.xrep001 = p_dialog.getFieldBuffer('xrep001')
   LET g_master.xrep002 = p_dialog.getFieldBuffer('xrep002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrr470.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL axrr470_set_def()
# Date & Author..: 160127 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION axrr470_set_def()
DEFINE l_flag         LIKE type_t.chr1
DEFINE l_errno        LIKE type_t.chr100
DEFINE l_glav002      LIKE glav_t.glav002
DEFINE l_glav005      LIKE glav_t.glav005
DEFINE l_sdate_s      LIKE glav_t.glav004
DEFINE l_sdate_e      LIKE glav_t.glav004
DEFINE l_glav006      LIKE glav_t.glav006
DEFINE l_pdate_s      LIKE glav_t.glav004   #當期起始日
DEFINE l_pdate_e      LIKE glav_t.glav004   #當期截止日
DEFINE l_glav007      LIKE glav_t.glav007
DEFINE l_wdate_s      LIKE glav_t.glav004
DEFINE l_wdate_e      LIKE glav_t.glav004


   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_glaacomp,g_master.xrepld
   #判斷這個主帳套使用者是否有權限
   CALL s_fin_account_center_with_ld_chk(g_site,g_master.xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
   LET g_master.xrepsite = g_site
   LET g_master.xrepsite_desc = s_desc_get_department_desc(g_master.xrepsite)  
   LET g_master.xrepld_desc = s_desc_get_ld_desc(g_master.xrepld)
   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.xrepsite,g_today,'1')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrepld
   CALL s_fin_get_wc_str(g_wc_xrepld) RETURNING g_wc_xrepld
   
   CALL s_ld_sel_glaa(g_master.xrepld,'glaa003') RETURNING g_sub_success,g_glaa003

   #抓取會計週期參照表之年度期別
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
             
   LET g_master.xrep001 = l_glav002
   LET g_master.xrep002 = l_glav006
   
   DISPLAY g_master.xrepsite,g_master.xrepsite_desc,g_master.xrepld,g_master.xrepld_desc,g_master.xrep001,g_master.xrep002
        TO b_xrepsite,xrepsite_desc,b_xrepld,xrepld_desc,b_xrep001,b_xrep002
   
END FUNCTION

#end add-point
 
{</section>}
 
