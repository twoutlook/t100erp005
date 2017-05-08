#該程式未解開Section, 採用最新樣板產出!
{<section id="anmr820.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-10-22 18:57:55), PR版次:0004(2016-10-24 15:10:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: anmr820
#+ Description: 銀行調匯會計帳務列印
#+ Creator....: 02159(2015-10-22 18:25:40)
#+ Modifier...: 02159 -SD/PR- 08729
 
{</section>}
 
{<section id="anmr820.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#45 2016/04/19 by 07959     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160816-00012#1  2016/08/23 By 01531     账务中心/法人/账套权限控管
#161021-00050#2  2016/10/24 By 08729     處理組織開窗
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
       nmdesite LIKE nmde_t.nmdesite, 
   nmdesite_desc LIKE type_t.chr80, 
   nmdeld LIKE nmde_t.nmdeld, 
   nmdeld_desc LIKE type_t.chr80, 
   nmde001 LIKE nmde_t.nmde001, 
   nmde002 LIKE nmde_t.nmde002,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_nmdeld STRING
DEFINE g_nmdecomp         LIKE nmde_t.nmdecomp
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmr820.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL anmr820_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmr820 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmr820_init()
 
      #進入選單 Menu (="N")
      CALL anmr820_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmr820
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmr820.init" >}
#+ 初始化作業
PRIVATE FUNCTION anmr820_init()
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
   IF cl_null(g_master.nmdesite) THEN
      LET g_master.nmdesite = g_site
      CALL s_fin_orga_get_comp_ld(g_master.nmdesite) RETURNING g_sub_success,g_errno,g_nmdecomp,g_master.nmdeld
      CALL s_desc_get_ld_desc(g_master.nmdeld)RETURNING g_master.nmdeld_desc
      CALL s_desc_get_department_desc(g_master.nmdesite)RETURNING g_master.nmdesite_desc
      DISPLAY BY NAME g_master.nmdeld,g_master.nmdesite,g_master.nmdesite_desc,g_master.nmdeld_desc
   END IF
   IF g_master.nmde001 = 0 THEN 
      LET g_master.nmde001 =  YEAR(cl_get_para(g_enterprise,g_nmdecomp,'S-FIN-2007')) 
      LET g_master.nmde002 =  MONTH(cl_get_para(g_enterprise,g_nmdecomp,'S-FIN-2007')) 
   END IF
   DISPLAY BY NAME g_master.nmde001,g_master.nmde002
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.nmdesite,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_nmdeld
   CALL s_fin_get_wc_str(g_wc_nmdeld) RETURNING g_wc_nmdeld   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmr820.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmr820_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_origin_str       STRING
   
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.nmdesite,g_master.nmdeld,g_master.nmde001,g_master.nmde002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdesite
            
            #add-point:AFTER FIELD nmdesite name="input.a.nmdesite"
            LET g_master.nmdeld_desc = ''
            LET g_master.nmdesite_desc = ''
            DISPLAY BY NAME g_master.nmdesite_desc,g_master.nmdeld_desc
            IF NOT cl_null(g_master.nmdesite) THEN
               
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.nmdesite
               #160318-00025#45  2016/04/26  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#45  2016/04/26  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooef001") THEN
                  #檢查失敗時後續處理
                  LET g_master.nmdesite = ''
                  LET g_master.nmdesite_desc = ''
                  DISPLAY BY NAME g_master.nmdesite_desc,g_master.nmdesite
                  NEXT FIELD CURRENT
               END IF

               CALL s_fin_account_center_with_ld_chk(g_master.nmdesite,g_master.nmdeld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #失敗給回預設
                  LET g_master.nmdesite = ''
                  LET g_master.nmdesite_desc = ''
                  DISPLAY BY NAME g_master.nmdesite_desc,g_master.nmdeld_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_fin_orga_get_comp_ld(g_master.nmdesite) RETURNING g_sub_success,g_errno,g_nmdecomp,g_master.nmdeld
            CALL s_fin_account_center_sons_query('3',g_master.nmdesite,g_today,'')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_nmdeld
            CALL s_fin_get_wc_str(g_wc_nmdeld) RETURNING g_wc_nmdeld
            CALL s_desc_get_ld_desc(g_master.nmdeld)RETURNING g_master.nmdeld_desc
            CALL s_desc_get_department_desc(g_master.nmdesite)RETURNING g_master.nmdesite_desc
            DISPLAY BY NAME g_master.nmdeld,g_master.nmdesite,g_master.nmdesite_desc,g_master.nmdeld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdesite
            #add-point:BEFORE FIELD nmdesite name="input.b.nmdesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdesite
            #add-point:ON CHANGE nmdesite name="input.g.nmdesite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdeld
            
            #add-point:AFTER FIELD nmdeld name="input.a.nmdeld"
            LET g_master.nmdeld_desc = ''
            DISPLAY BY NAME g_master.nmdeld_desc
            IF NOT cl_null(g_master.nmdeld) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.nmdesite,g_master.nmdeld,g_user,'3','N','',g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.nmdeld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_ld_desc(g_master.nmdeld)RETURNING g_master.nmdeld_desc
            DISPLAY BY NAME g_master.nmdeld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdeld
            #add-point:BEFORE FIELD nmdeld name="input.b.nmdeld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdeld
            #add-point:ON CHANGE nmdeld name="input.g.nmdeld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde001
            #add-point:BEFORE FIELD nmde001 name="input.b.nmde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde001
            
            #add-point:AFTER FIELD nmde001 name="input.a.nmde001"
            IF NOT cl_null(g_master.nmde001) THEN
               IF NOT s_fin_date_chk_year(g_master.nmde001) THEN
                  LET g_master.nmde001 = ''
                  DISPLAY BY NAME g_master.nmde001
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_master.nmde001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmde001
            #add-point:ON CHANGE nmde001 name="input.g.nmde001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmde002
            #add-point:BEFORE FIELD nmde002 name="input.b.nmde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmde002
            
            #add-point:AFTER FIELD nmde002 name="input.a.nmde002"
            IF NOT cl_null(g_master.nmde002) THEN
               IF g_master.nmde002 < 1 OR g_master.nmde002 > 13 THEN
                  LET g_master.nmde002= ''
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
         ON CHANGE nmde002
            #add-point:ON CHANGE nmde002 name="input.g.nmde002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.nmdesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdesite
            #add-point:ON ACTION controlp INFIELD nmdesite name="input.c.nmdesite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.nmdesite             #給予default值
            #LET g_qryparam.where = " ooef201 = 'Y' " #160816-00012#1 
            #CALL q_ooef001()                              #呼叫開窗  #161021-00050#2 mark
            CALL q_ooef001_46()                       #161021-00050#2 add
            LET g_master.nmdesite = g_qryparam.return1
            CALL s_fin_orga_get_comp_ld(g_master.nmdesite) RETURNING g_sub_success,g_errno,g_nmdecomp,g_master.nmdeld
            CALL s_desc_get_ld_desc(g_master.nmdeld)RETURNING g_master.nmdeld_desc
            CALL s_desc_get_department_desc(g_master.nmdesite)RETURNING g_master.nmdesite_desc
            DISPLAY BY NAME g_master.nmdeld,g_master.nmdeld_desc,
                            g_master.nmdesite,g_master.nmdesite_desc
            NEXT FIELD nmdesite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.nmdeld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdeld
            #add-point:ON ACTION controlp INFIELD nmdeld name="input.c.nmdeld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.nmdeld             #給予default值
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_master.nmdesite,g_today,'1')
            #取得帳務組織下所屬成員之帳別
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL anmr820_change_to_sql(l_origin_str) RETURNING l_origin_str
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                #呼叫開窗
            LET g_master.nmdeld = g_qryparam.return1
            DISPLAY g_master.nmdeld TO nmdeld
            CALL s_desc_get_ld_desc(g_master.nmdeld)RETURNING g_master.nmdeld_desc
            DISPLAY BY NAME g_master.nmdeld_desc
            NEXT FIELD nmdeld                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.nmde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde001
            #add-point:ON ACTION controlp INFIELD nmde001 name="input.c.nmde001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmde002
            #add-point:ON ACTION controlp INFIELD nmde002 name="input.c.nmde002"
            
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
            CALL anmr820_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL anmr820_get_buffer(l_dialog)
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
            IF cl_null(g_master.nmdesite) THEN
               LET g_master.nmdesite = g_site
               CALL s_fin_orga_get_comp_ld(g_master.nmdesite) RETURNING g_sub_success,g_errno,g_nmdecomp,g_master.nmdeld
               CALL s_desc_get_ld_desc(g_master.nmdeld)RETURNING g_master.nmdeld_desc
               CALL s_desc_get_department_desc(g_master.nmdesite)RETURNING g_master.nmdesite_desc
               DISPLAY BY NAME g_master.nmdeld,g_master.nmdesite,g_master.nmdesite_desc,g_master.nmdeld_desc
            END IF
            IF g_master.nmde001 = 0 THEN 
               LET g_master.nmde001 =  YEAR(cl_get_para(g_enterprise,g_nmdecomp,'S-FIN-2007')) 
               LET g_master.nmde002 =  MONTH(cl_get_para(g_enterprise,g_nmdecomp,'S-FIN-2007')) 
            END IF
            DISPLAY BY NAME g_master.nmde001,g_master.nmde002
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_master.nmdesite,g_today,'')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_nmdeld
            CALL s_fin_get_wc_str(g_wc_nmdeld) RETURNING g_wc_nmdeld            
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
         CALL anmr820_init()
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
                 CALL anmr820_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = anmr820_transfer_argv(ls_js)
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
 
{<section id="anmr820.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION anmr820_transfer_argv(ls_js)
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
 
{<section id="anmr820.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION anmr820_process(ls_js)
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
#  DECLARE anmr820_process_cs CURSOR FROM ls_sql
#  FOREACH anmr820_process_cs INTO
   #add-point:process段process name="process.process"
   IF cl_null(g_master.nmdesite) THEN  ## 若是t類進來 會是傳字串參數的方式
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      DISPLAY 'ls_jstoken:',ls_js
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         LET l_arg[l_cnt] = ls_next
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET g_master.wc = l_arg[01]
   ELSE
      LET g_master.wc = "1=1"
      LET g_master.wc = g_master.wc CLIPPED," AND nmdesite='",g_master.nmdesite,"' AND nmdeld='",g_master.nmdeld,"'",
                                            " AND nmde001='",g_master.nmde001,"' AND nmde002='",g_master.nmde002,"'"         
   END IF

   #END IF
   CALL anmr820_g01(g_master.wc) #CALL報表元件
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
 
{<section id="anmr820.get_buffer" >}
PRIVATE FUNCTION anmr820_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.nmdesite = p_dialog.getFieldBuffer('nmdesite')
   LET g_master.nmdeld = p_dialog.getFieldBuffer('nmdeld')
   LET g_master.nmde001 = p_dialog.getFieldBuffer('nmde001')
   LET g_master.nmde002 = p_dialog.getFieldBuffer('nmde002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmr820.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: # 將取回的字串轉換為SQL條件
# Memo...........:
# Usage..........: CALL anmr820_change_to_sql(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc
# Return code....: r_wc
# Date & Author..: 2015/10/22 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION anmr820_change_to_sql(p_wc)
   DEFINE p_wc       STRING
DEFINE r_wc       STRING
DEFINE tok        base.StringTokenizer
DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

#end add-point
 
{</section>}
 
