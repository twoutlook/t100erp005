#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp710.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-12-05 10:37:57), PR版次:0002(2016-12-14 17:28:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgp710
#+ Description: 產生人工預算
#+ Creator....: 06821(2016-12-02 17:49:25)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgp710.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#140306-00008#1  161214 By 06821  預算編號要卡控使用預測
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
       bggm002 LIKE type_t.chr10, 
   bggm002_desc LIKE type_t.chr80, 
   bggm003 LIKE type_t.chr10, 
   bggm006 LIKE type_t.chr10, 
   bggm006_desc LIKE type_t.chr80, 
   l_source LIKE type_t.chr500, 
   l_source1 LIKE type_t.chr500, 
   l_rate LIKE type_t.chr500, 
   l_rate1 LIKE type_t.chr500, 
   l_cover LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_o  type_master         
DEFINE g_bgai002   LIKE bgai_t.bgai002
DEFINE g_bgai008   LIKE bgai_t.bgai008
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp710.main" >}
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
      CALL abgp710_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp710 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp710_init()
 
      #進入選單 Menu (="N")
      CALL abgp710_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp710
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp710.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp710_init()
 
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
 
{<section id="abgp710.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp710_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_site_str  STRING
   DEFINE l_bgaa006   LIKE bgaa_t.bgaa006  #140306-00008#1 add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL abgp710_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bggm002,g_master.bggm003,g_master.bggm006,g_master.l_source,g_master.l_source1, 
             g_master.l_rate,g_master.l_rate1,g_master.l_cover 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm002
            
            #add-point:AFTER FIELD bggm002 name="input.a.bggm002"
            LET g_master.bggm002_desc = ''
            DISPLAY BY NAME g_master.bggm002_desc
            IF NOT cl_null(g_master.bggm002) THEN
               IF g_master.bggm002 != g_master_o.bggm002 OR cl_null(g_master_o.bggm002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.bggm002
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
                  IF cl_chk_exist("v_bgaa001") THEN
                     #140306-00008#1 --s add
                     #檢查是否使用預測,不使用才可執行
                     LET l_bgaa006 = ''
                     SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bggm002 AND bgaastus = 'Y'
                     IF l_bgaa006 <> '1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00292'
                        LET g_errparam.extend = g_master.bggm002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.bggm002 = g_master_o.bggm002
                        CALL s_desc_get_budget_desc(g_master.bggm002) RETURNING g_master.bggm002_desc
                        DISPLAY BY NAME g_master.bggm002_desc
                        NEXT FIELD CURRENT
                     END IF       
                     #140306-00008#1 --e add                     
                  
                     IF NOT cl_null(g_master.bggm006) THEN
                        #CALL s_abg2_bgai002_chk(g_master.bggm002,g_master.bggm006)       #140306-00008#1 mark
                        CALL s_abg2_bgai004_chk(g_master.bggm002,'',g_master.bggm006,'')  #140306-00008#1 add
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_master.bggm002," + ",g_master.bggm006
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_master.bggm002 = g_master_o.bggm002
                           CALL s_desc_get_budget_desc(g_master.bggm002) RETURNING g_master.bggm002_desc
                           DISPLAY BY NAME g_master.bggm002_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.bggm002 = g_master_o.bggm002
                     CALL s_desc_get_budget_desc(g_master.bggm002) RETURNING g_master.bggm002_desc
                     DISPLAY BY NAME g_master.bggm002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF    
            CALL s_desc_get_budget_desc(g_master.bggm002) RETURNING g_master.bggm002_desc
            DISPLAY BY NAME g_master.bggm002_desc       
            LET g_master_o.* = g_master.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm002
            #add-point:BEFORE FIELD bggm002 name="input.b.bggm002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm002
            #add-point:ON CHANGE bggm002 name="input.g.bggm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.bggm003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bggm003
            END IF 
 
 
 
            #add-point:AFTER FIELD bggm003 name="input.a.bggm003"
            IF NOT cl_null(g_master.bggm003) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm003
            #add-point:BEFORE FIELD bggm003 name="input.b.bggm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm003
            #add-point:ON CHANGE bggm003 name="input.g.bggm003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggm006
            
            #add-point:AFTER FIELD bggm006 name="input.a.bggm006"
            #預算組織
            LET g_master.bggm006_desc = ''
            DISPLAY BY NAME g_master.bggm006_desc
            IF NOT cl_null(g_master.bggm006) THEN
               IF g_master.bggm006 != g_master_o.bggm006 OR cl_null(g_master_o.bggm006) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.bggm006
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     LET g_master.bggm006 = g_master_o.bggm006
                     CALL s_desc_get_department_desc(g_master.bggm006) RETURNING g_master.bggm006_desc
                     DISPLAY BY NAME g_master.bggm006_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_abg2_bgai004_chk(g_master.bggm002,'',g_master.bggm006,'')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.bggm006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bggm006 = g_master_o.bggm006
                     CALL s_desc_get_department_desc(g_master.bggm006) RETURNING g_master.bggm006_desc
                     DISPLAY BY NAME g_master.bggm006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_master.bggm006_desc = s_desc_get_department_desc(g_master.bggm006)
            DISPLAY BY NAME g_master.bggm006_desc,g_master.bggm006
            LET g_master_o.* = g_master.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggm006
            #add-point:BEFORE FIELD bggm006 name="input.b.bggm006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggm006
            #add-point:ON CHANGE bggm006 name="input.g.bggm006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_source
            #add-point:BEFORE FIELD l_source name="input.b.l_source"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_source
            
            #add-point:AFTER FIELD l_source name="input.a.l_source"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_source
            #add-point:ON CHANGE l_source name="input.g.l_source"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_source1
            #add-point:BEFORE FIELD l_source1 name="input.b.l_source1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_source1
            
            #add-point:AFTER FIELD l_source1 name="input.a.l_source1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_source1
            #add-point:ON CHANGE l_source1 name="input.g.l_source1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate
            #add-point:BEFORE FIELD l_rate name="input.b.l_rate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate
            
            #add-point:AFTER FIELD l_rate name="input.a.l_rate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate
            #add-point:ON CHANGE l_rate name="input.g.l_rate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate1
            #add-point:BEFORE FIELD l_rate1 name="input.b.l_rate1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate1
            
            #add-point:AFTER FIELD l_rate1 name="input.a.l_rate1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate1
            #add-point:ON CHANGE l_rate1 name="input.g.l_rate1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cover
            #add-point:BEFORE FIELD l_cover name="input.b.l_cover"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cover
            
            #add-point:AFTER FIELD l_cover name="input.a.l_cover"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cover
            #add-point:ON CHANGE l_cover name="input.g.l_cover"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bggm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm002
            #add-point:ON ACTION controlp INFIELD bggm002 name="input.c.bggm002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bggm002
            #LET g_qryparam.where = "bgaastus = 'Y' "                                     #140306-00008#1 mark
            LET g_qryparam.where = "bgaastus = 'Y' AND bgaa006 = '1' "   #使用預測才可以開  #140306-00008#1 add
            CALL q_bgaa001()
            LET g_master.bggm002 = g_qryparam.return1
            CALL s_desc_get_budget_desc(g_master.bggm002) RETURNING g_master.bggm002_desc            
            NEXT FIELD bggm002
            #END add-point
 
 
         #Ctrlp:input.c.bggm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm003
            #add-point:ON ACTION controlp INFIELD bggm003 name="input.c.bggm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggm006
            #add-point:ON ACTION controlp INFIELD bggm006 name="input.c.bggm006"
            #預算組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bggm006
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t ",
                                   "              WHERE bgajent = ooefent AND bgajent = ",g_enterprise,
                                   "                AND bgaj001 = '",g_master.bggm002,"' AND bgajstus = 'Y') "
            CALL s_abg2_get_budget_site(g_master.bggm002,'',g_user,'') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",l_site_str
            CALL q_ooef001()
            LET g_master.bggm006 = g_qryparam.return1
            DISPLAY BY NAME g_master.bggm006
            NEXT FIELD bggm006
            #END add-point
 
 
         #Ctrlp:input.c.l_source
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_source
            #add-point:ON ACTION controlp INFIELD l_source name="input.c.l_source"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_source1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_source1
            #add-point:ON ACTION controlp INFIELD l_source1 name="input.c.l_source1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_rate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate
            #add-point:ON ACTION controlp INFIELD l_rate name="input.c.l_rate"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_rate1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate1
            #add-point:ON ACTION controlp INFIELD l_rate1 name="input.c.l_rate1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_cover
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cover
            #add-point:ON ACTION controlp INFIELD l_cover name="input.c.l_cover"
            
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
            CALL abgp710_get_buffer(l_dialog)
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
            CALL abgp710_qbe_clear()
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
         CALL abgp710_init()
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
                 CALL abgp710_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp710_transfer_argv(ls_js)
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
 
{<section id="abgp710.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp710_transfer_argv(ls_js)
 
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
 
{<section id="abgp710.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp710_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql         STRING
   DEFINE l_bggk003     LIKE bggk_t.bggk003     #預算起始期別
   DEFINE l_bggk004     LIKE bggk_t.bggk004     #預算終止期別                      
   DEFINE l_do          LIKE type_t.num5            
   DEFINE l_cnt         LIKE type_t.num5            
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #無選擇轉檔來源,不可執行
   IF g_master.l_source <> '1' AND g_master.l_source1 <> '1' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00259"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #取預算管理組織/樣表編號
   LET g_bgai002 = ''
   LET g_bgai008 = ''
   SELECT DISTINCT bgai002,bgai008 INTO g_bgai002,g_bgai008
     FROM bgai_t
    WHERE bgaient = g_enterprise
      AND bgai001 = g_master.bggm002
      AND bgai003 = g_user
      AND bgai004 = g_master.bggm006
      AND bgai005 IN ('06','00')
      AND bgaistus = 'Y'

   #取不到管理組織,則不可執行
   IF cl_null(g_bgai002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abg-00199'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   ELSE
      #取不到樣表,則不可執行
      IF cl_null(g_bgai008) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'abg-00136'
         LET g_errparam.extend = ''
         LET g_errparam.replace[1] = g_master.bggm002
         LET g_errparam.replace[2] = g_bgai002
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abgp710_process_cs CURSOR FROM ls_sql
#  FOREACH abgp710_process_cs INTO
   #add-point:process段process name="process.process"

   #abgt725用工需求預測 DECLARE 起始期別/終止期別
   LET l_sql = " SELECT UNIQUE bggk003,bggk004  ",
               "   FROM bggk_t ",
               "  WHERE bggkent = ",g_enterprise," AND bggk001 = '",g_master.bggm002,"' ",
               "    AND bggk002 = '",g_master.bggm006,"'  AND bggkstus = 'Y' "

   PREPARE sel_bggkp FROM l_sql
   DECLARE sel_bggkc CURSOR FOR sel_bggkp    
   #----------------------------------------------------------------------

   #寫入單頭前檢查,是否存在t730---------------------------------------------
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt
     FROM bggm_t 
    WHERE bggment = g_enterprise 
      AND bggm001 = '20'
      AND bggm002 = g_master.bggm002
      AND bggm003 = g_master.bggm003
      AND bggm004 = '2'
      AND bggm005 = '1'
      AND bggm006 = g_master.bggm006

   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      #是否存在t730,狀態已確認
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM bggm_t 
       WHERE bggment = g_enterprise 
         AND bggm001 = '20'
         AND bggm002 = g_master.bggm002
         AND bggm003 = g_master.bggm003
         AND bggm004 = '2'
         AND bggm005 = '1'
         AND bggm006 = g_master.bggm006
         AND bggmstus = 'Y'
         
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN
         #是: 不執行 ,提示"資料已存在人工預算主檔,且為已確認狀態,不可執行! "
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_master.bggm002,"+",g_master.bggm006,"+",g_master.bggm003
         LET g_errparam.code   = "abg-00283"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN
      ELSE
         #已存在資料但不執行覆蓋 ,提示"資料已存在人工預算主檔,不可執行! "
         IF g_master.l_cover = 'N' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = g_master.bggm002,"+",g_master.bggm006,"+",g_master.bggm003
            LET g_errparam.code   = "abg-00284"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN     
         END IF
      END IF
   END IF
   #----------------------------------------------------------------------

   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   LET g_success = TRUE
   LET l_do = 0
   
   
   #####用工需求預測(abgt725)--------------------------------
   #####################
   #架構:
   #step1.   先撈取用工需求預測abgt725
   #step2.   依期別為單位執行寫入 (來源t725期別為一個期間)
   #step3.   取工資方案資料檔
   #    3-1. 依工資方案,取用工需求明細檔(寫入單身bggn_t)
   #step4.   取工資項目,依用工需求明細檔項目繞迴圈 (寫入單身bggo_t)
   #    4-1. 工資項目取薪資標準,依abgi740撈取對應abgi760標準薪資
   #    4-2. 元件推算類型為2.計算公式的薪資基準
   #    4-3. 細項借貸方科目取abgi750
   #####################   
   #step1.先撈取用工需求預測abgt725
   IF g_master.l_source = '1' THEN
      LET l_bggk003 = ''
      LET l_bggk004 = ''
      FOREACH sel_bggkc INTO l_bggk003,l_bggk004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:sel_bggkc"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF

         #寫入單頭bggm_t 人工預算主檔
         CALL abgp710_ins_bggm(l_bggk003,l_bggk004) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET g_success = FALSE
            EXIT FOREACH
         END IF         
         LET l_do = l_do +1
      END FOREACH
   END IF
   
   
   #參考資料--------------------------------------------
   #IF g_master.l_source1 = '1' THEN
   #   
   #END IF
   
   #是否有資料執行
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'   #無資料產生
      LET g_errparam.extend = "INSERT INTO bggm_t IS NULL"
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')       
      CALL cl_err_collect_show()        
      RETURN
   END IF

   #commit or rollback      
   IF g_success THEN         
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_show()
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'   #失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')       
      CALL cl_err_collect_show()        
      CALL abgp710_qbe_clear()         
      RETURN      
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
   CALL abgp710_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp710.get_buffer" >}
PRIVATE FUNCTION abgp710_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bggm002 = p_dialog.getFieldBuffer('bggm002')
   LET g_master.bggm003 = p_dialog.getFieldBuffer('bggm003')
   LET g_master.bggm006 = p_dialog.getFieldBuffer('bggm006')
   LET g_master.l_source = p_dialog.getFieldBuffer('l_source')
   LET g_master.l_source1 = p_dialog.getFieldBuffer('l_source1')
   LET g_master.l_rate = p_dialog.getFieldBuffer('l_rate')
   LET g_master.l_rate1 = p_dialog.getFieldBuffer('l_rate1')
   LET g_master.l_cover = p_dialog.getFieldBuffer('l_cover')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp710.msgcentre_notify" >}
PRIVATE FUNCTION abgp710_msgcentre_notify()
 
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
 
{<section id="abgp710.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL abgp710_qbe_clear()
# Date & Author..: 161205 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp710_qbe_clear()
   CLEAR FORM
   INITIALIZE g_master.* TO NULL   #畫面變數清空
   LET g_master.l_source = '1'
   LET g_master.l_cover = 'N'
   
   DISPLAY BY NAME g_master.l_source,g_master.l_cover
END FUNCTION

################################################################################
# Descriptions...: 寫入單頭人工預算主檔
# Memo...........:
# Usage..........: CALL abgp710_ins_bggm(p_bggm007_s,p_bggm007_e)
#                  RETURNING 回传参数
# Input parameter: p_bggm007_s   起始期別
#                : p_bggm007_e   截止期別
# Return code....: r_success     成功否
# Date & Author..: 161206 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp710_ins_bggm(p_bggm007_s,p_bggm007_e)
DEFINE p_bggm007_s     LIKE bggm_t.bggm007
DEFINE p_bggm007_e     LIKE bggm_t.bggm007
DEFINE l_bggm          RECORD                 #人工預算主檔
         bggment       LIKE bggm_t.bggment,   #企業編號
         bggm001       LIKE bggm_t.bggm001,   #資料來源
         bggm002       LIKE bggm_t.bggm002,   #預算編號
         bggm003       LIKE bggm_t.bggm003,   #版本
         bggm004       LIKE bggm_t.bggm004,   #人工來源
         bggm005       LIKE bggm_t.bggm005,   #資料來源
         bggm006       LIKE bggm_t.bggm006,   #預算組織
         bggm007       LIKE bggm_t.bggm007,   #期別
         bggm008       LIKE bggm_t.bggm008,   #管理組織
         bggm009       LIKE bggm_t.bggm009,   #預算樣表
         bggm010       LIKE bggm_t.bggm010,   #憑單單號
         bggmstus      LIKE bggm_t.bggmstus,  #狀態碼
         bggmownid     LIKE bggm_t.bggmownid, #資料所有者
         bggmowndp     LIKE bggm_t.bggmowndp, #資料所屬部門
         bggmcrtid     LIKE bggm_t.bggmcrtid, #資料建立者
         bggmcrtdp     LIKE bggm_t.bggmcrtdp, #資料建立部門
         bggmcrtdt     LIKE bggm_t.bggmcrtdt, #資料創建日
         bggmmodid     LIKE bggm_t.bggmmodid, #資料修改者
         bggmmoddt     LIKE bggm_t.bggmmoddt, #最近修改日
         bggmcnfid     LIKE bggm_t.bggmcnfid, #資料確認者
         bggmcnfdt     LIKE bggm_t.bggmcnfdt  #資料確認日
                       END RECORD
DEFINE l_i             LIKE type_t.num10
DEFINE l_success       LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE

   #step2.依期別為單位執行寫入 (來源t725期別為一個期間)
   LET l_i = p_bggm007_s
   FOR l_i = p_bggm007_s TO p_bggm007_e
   
      INITIALIZE l_bggm.* TO NULL
      LET l_bggm.bggment    = g_enterprise     #企業編號
      LET l_bggm.bggm001    = '20'             #資料來源
      LET l_bggm.bggm002    = g_master.bggm002 #預算編號
      LET l_bggm.bggm003    = g_master.bggm003 #版本
      LET l_bggm.bggm004    = '2'              #人工來源
      LET l_bggm.bggm005    = '1'              #資料來源
      LET l_bggm.bggm006    = g_master.bggm006 #預算組織
      LET l_bggm.bggm007    = l_i              #期別
      LET l_bggm.bggm008    = g_bgai002        #管理組織
      LET l_bggm.bggm009    = g_bgai008        #預算樣表
      LET l_bggm.bggm010    = ''               #憑單單號
      LET l_bggm.bggmstus   = 'N'              #狀態碼
      LET l_bggm.bggmownid  = g_user           #資料所有者
      LET l_bggm.bggmowndp  = g_dept           #資料所屬部門
      LET l_bggm.bggmcrtid  = g_user           #資料建立者
      LET l_bggm.bggmcrtdp  = g_dept           #資料建立部門
      LET l_bggm.bggmcrtdt  = cl_get_current() #資料創建日
      LET l_bggm.bggmmodid  = ''               #資料修改者
      LET l_bggm.bggmmoddt  = ''               #最近修改日
      LET l_bggm.bggmcnfid  = ''               #資料確認者
      LET l_bggm.bggmcnfdt  = ''               #資料確認日
      
      #寫入前,先刪除
      DELETE FROM bggm_t 
       WHERE bggment = g_enterprise 
         AND bggm001 = '20'
         AND bggm002 = g_master.bggm002
         AND bggm003 = g_master.bggm003
         AND bggm004 = '2'
         AND bggm005 = '1'
         AND bggm006 = g_master.bggm006
         AND bggm007 = l_i
         AND bggmstus = 'N'
      
      #寫入單頭 bggm_t
      INSERT INTO bggm_t(bggment,bggm001,bggm002,bggm003,bggm004,
                         bggm005,bggm006,bggm007,bggm008,bggm009,
                         bggm010,bggmstus,bggmownid,bggmowndp,bggmcrtid,
                         bggmcrtdp,bggmcrtdt,bggmmodid,bggmmoddt,bggmcnfid,
                         bggmcnfdt)
                  VALUES(l_bggm.bggment,l_bggm.bggm001,l_bggm.bggm002,l_bggm.bggm003,l_bggm.bggm004,
                         l_bggm.bggm005,l_bggm.bggm006,l_bggm.bggm007,l_bggm.bggm008,l_bggm.bggm009,
                         l_bggm.bggm010,l_bggm.bggmstus,l_bggm.bggmownid,l_bggm.bggmowndp,l_bggm.bggmcrtid,
                         l_bggm.bggmcrtdp,l_bggm.bggmcrtdt,l_bggm.bggmmodid,l_bggm.bggmmoddt,l_bggm.bggmcnfid,
                         l_bggm.bggmcnfdt)                        
       
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INS_bggm_t_ERR"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOR
      END IF
      
      #寫入單身bggn_t 人工預算明細
      CALL abgp710_ins_bggn(p_bggm007_s,p_bggm007_e,l_bggm.bggm007) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         EXIT FOR
      END IF
      
   END FOR


   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 寫入單身人工預算明細
# Memo...........:
# Usage..........: CALL abgp710_ins_bggn(p_bggm007_s,p_bggm007_e,p_bggm007)
#                  RETURNING r_success
# Input parameter: p_bggm007_s 起始期別
#                : p_bggm007_e 截止期別
#                : p_bggm007   期別
# Return code....: r_success   成功否
# Date & Author..: 161206 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp710_ins_bggn(p_bggm007_s,p_bggm007_e,p_bggm007)
DEFINE p_bggm007_s     LIKE bggm_t.bggm007
DEFINE p_bggm007_e     LIKE bggm_t.bggm007
DEFINE p_bggm007       LIKE bggm_t.bggm007
#人工預算明細
DEFINE l_bggn          RECORD                
         bggnent       LIKE bggn_t.bggnent,  #企業編號
         bggn001       LIKE bggn_t.bggn001,  #資料來源
         bggn002       LIKE bggn_t.bggn002,  #預算編號
         bggn003       LIKE bggn_t.bggn003,  #版本
         bggn004       LIKE bggn_t.bggn004,  #人工來源
         bggn005       LIKE bggn_t.bggn005,  #資料來源
         bggn006       LIKE bggn_t.bggn006,  #預算組織
         bggn007       LIKE bggn_t.bggn007,  #期別
         bggnseq       LIKE bggn_t.bggnseq,  #項次
         bggn008       LIKE bggn_t.bggn008,  #管理組織
         bggn009       LIKE bggn_t.bggn009,  #預算樣表
         bggn010       LIKE bggn_t.bggn010,  #工資方案
         bggn011       LIKE bggn_t.bggn011,  #職級
         bggn012       LIKE bggn_t.bggn012,  #職等
         bggn013       LIKE bggn_t.bggn013,  #用工屬性
         bggn014       LIKE bggn_t.bggn014,  #人員
         bggn015       LIKE bggn_t.bggn015,  #部門
         bggn016       LIKE bggn_t.bggn016,  #成本利潤中心
         bggn017       LIKE bggn_t.bggn017,  #區域
         bggn018       LIKE bggn_t.bggn018,  #收付款供應商
         bggn019       LIKE bggn_t.bggn019,  #帳款客商
         bggn020       LIKE bggn_t.bggn020,  #客群
         bggn021       LIKE bggn_t.bggn021,  #產品類別
         bggn022       LIKE bggn_t.bggn022,  #專案編號
         bggn023       LIKE bggn_t.bggn023,  #WBS
         bggn024       LIKE bggn_t.bggn024,  #經營方式
         bggn025       LIKE bggn_t.bggn025,  #通路
         bggn026       LIKE bggn_t.bggn026,  #品牌
         bggn027       LIKE bggn_t.bggn027,  #自由核算項一
         bggn028       LIKE bggn_t.bggn028,  #自由核算項二
         bggn029       LIKE bggn_t.bggn029,  #自由核算項三
         bggn030       LIKE bggn_t.bggn030,  #自由核算項四
         bggn031       LIKE bggn_t.bggn031,  #自由核算項五
         bggn032       LIKE bggn_t.bggn032,  #自由核算項六
         bggn033       LIKE bggn_t.bggn033,  #自由核算項七
         bggn034       LIKE bggn_t.bggn034,  #自由核算項八
         bggn035       LIKE bggn_t.bggn035,  #自由核算項九
         bggn036       LIKE bggn_t.bggn036,  #自由核算項十
         bggn037       LIKE bggn_t.bggn037,  #參考人數
         bggn038       LIKE bggn_t.bggn038,  #用工人數
         bggnstus      LIKE bggn_t.bggnstus  #狀態碼
                       END RECORD
#用工需求主檔                       
DEFINE l_bggk          RECORD  
         bggkent       LIKE bggk_t.bggkent,  #企業編號
         bggk001       LIKE bggk_t.bggk001,  #預算編號
         bggk002       LIKE bggk_t.bggk002,  #預算組織
         bggk003       LIKE bggk_t.bggk003,  #預算起始期別
         bggk004       LIKE bggk_t.bggk004,  #預算終止期別
         bggk005       LIKE bggk_t.bggk005   #工資方案
                       END RECORD
#用工需求明細檔                       
DEFINE l_bggg          RECORD  
         bggg001       LIKE bggg_t.bggg001,  #預算編號
         bggg002       LIKE bggg_t.bggg002,  #預算組織
         bggg003       LIKE bggg_t.bggg003,  #職級
         bggg004       LIKE bggg_t.bggg004,  #職等
         bggg005       LIKE bggg_t.bggg005,  #用工屬性
         bggg007       LIKE bggg_t.bggg007,  #部門
         bggg008       LIKE bggg_t.bggg008,  #成本利潤中心
         bggg009       LIKE bggg_t.bggg009,  #區域
         bggg010       LIKE bggg_t.bggg010,  #收付款客商
         bggg011       LIKE bggg_t.bggg011,  #收款客商
         bggg012       LIKE bggg_t.bggg012,  #客群
         bggg013       LIKE bggg_t.bggg013,  #產品類別
         bggg014       LIKE bggg_t.bggg014,  #人員
         bggg015       LIKE bggg_t.bggg015,  #專案編號
         bggg016       LIKE bggg_t.bggg016,  #WBS
         bggg017       LIKE bggg_t.bggg017,  #經營方式 (NO USE)
         bggg018       LIKE bggg_t.bggg018,  #通路 (NO USE)
         bggg019       LIKE bggg_t.bggg019,  #品牌
         bggg020       LIKE bggg_t.bggg020,  #用工人數
         bggg021       LIKE bggg_t.bggg021,  #自由核算項一
         bggg022       LIKE bggg_t.bggg022,  #自由核算項二
         bggg023       LIKE bggg_t.bggg023,  #自由核算項三
         bggg024       LIKE bggg_t.bggg024,  #自由核算項四
         bggg025       LIKE bggg_t.bggg025,  #自由核算項五
         bggg026       LIKE bggg_t.bggg026,  #自由核算項六
         bggg027       LIKE bggg_t.bggg027,  #自由核算項七
         bggg028       LIKE bggg_t.bggg028,  #自由核算項八
         bggg029       LIKE bggg_t.bggg029,  #自由核算項九
         bggg030       LIKE bggg_t.bggg030,  #自由核算項十
         bggg031       LIKE bggg_t.bggg031,  #起始期別
         bgggseq       LIKE bggg_t.bgggseq,  #項次
         bgggseq1      LIKE bggg_t.bgggseq1, #項序
         bggg032       LIKE bggg_t.bggg032,  #終止期別
         bggg033       LIKE bggg_t.bggg033,  #經營方式
         bggg034       LIKE bggg_t.bggg034   #通路         
                       END RECORD           
#人工費用預算明細檔                       
DEFINE l_bggo          RECORD  
         bggoent       LIKE bggo_t.bggoent,  #企業編號
         bggo001       LIKE bggo_t.bggo001,  #資料來源
         bggo002       LIKE bggo_t.bggo002,  #預算編號
         bggo003       LIKE bggo_t.bggo003,  #版本
         bggo004       LIKE bggo_t.bggo004,  #管理組織
         bggo005       LIKE bggo_t.bggo005,  #人工來源
         bggo006       LIKE bggo_t.bggo006,  #資料來源
         bggo007       LIKE bggo_t.bggo007,  #預算組織
         bggo008       LIKE bggo_t.bggo008,  #期別
         bggoseq       LIKE bggo_t.bggoseq,  #項次
         bggoseq2      LIKE bggo_t.bggoseq2, #項序
         bggo009       LIKE bggo_t.bggo009,  #工資項目
         bggo010       LIKE bggo_t.bggo010,  #組合 key
         bggo011       LIKE bggo_t.bggo011,  #預算樣表
         bggo012       LIKE bggo_t.bggo012,  #人員
         bggo013       LIKE bggo_t.bggo013,  #部門
         bggo014       LIKE bggo_t.bggo014,  #成本利潤中心
         bggo015       LIKE bggo_t.bggo015,  #區域
         bggo016       LIKE bggo_t.bggo016,  #收付款供應商
         bggo017       LIKE bggo_t.bggo017,  #帳款客商
         bggo018       LIKE bggo_t.bggo018,  #客群
         bggo019       LIKE bggo_t.bggo019,  #產品類別
         bggo020       LIKE bggo_t.bggo020,  #專案編號
         bggo021       LIKE bggo_t.bggo021,  #WBS
         bggo022       LIKE bggo_t.bggo022,  #經營方式
         bggo023       LIKE bggo_t.bggo023,  #通路
         bggo024       LIKE bggo_t.bggo024,  #品牌
         bggo025       LIKE bggo_t.bggo025,  #自由核算項一
         bggo026       LIKE bggo_t.bggo026,  #自由核算項二
         bggo027       LIKE bggo_t.bggo027,  #自由核算項三
         bggo028       LIKE bggo_t.bggo028,  #自由核算項四
         bggo029       LIKE bggo_t.bggo029,  #自由核算項五
         bggo030       LIKE bggo_t.bggo030,  #自由核算項六
         bggo031       LIKE bggo_t.bggo031,  #自由核算項七
         bggo032       LIKE bggo_t.bggo032,  #自由核算項八
         bggo033       LIKE bggo_t.bggo033,  #自由核算項九
         bggo034       LIKE bggo_t.bggo034,  #自由核算項十
         bggo035       LIKE bggo_t.bggo035,  #用工人數
         bggo036       LIKE bggo_t.bggo036,  #薪資基準
         bggo037       LIKE bggo_t.bggo037,  #上層組織
         bggo038       LIKE bggo_t.bggo038,  #憑證單號
         bggo039       LIKE bggo_t.bggo039,  #借方預算細項
         bggo040       LIKE bggo_t.bggo040,  #貸方預算細項
         bggo041       LIKE bggo_t.bggo041,  #工資方案
         bggo042       LIKE bggo_t.bggo042,  #職級
         bggo043       LIKE bggo_t.bggo043,  #職等
         bggo044       LIKE bggo_t.bggo044,  #用工屬性         
         bggo100       LIKE bggo_t.bggo100,  #幣別
         bggo101       LIKE bggo_t.bggo101,  #匯率
         bggo103       LIKE bggo_t.bggo103,  #預算金額
         bggo104       LIKE bggo_t.bggo104,  #本層調整金額
         bggo105       LIKE bggo_t.bggo105,  #上層調整金額
         bggo106       LIKE bggo_t.bggo106,  #核准金額
         bggostus      LIKE bggo_t.bggostus  #狀態碼
                       END RECORD                      
DEFINE l_bggk005       LIKE bggk_t.bggk005   #工資方案
DEFINE l_bggb002       LIKE bggb_t.bggb002   #工資項目
DEFINE l_bggb003       LIKE bggb_t.bggb003   #工資來源
DEFINE l_bggoseq2      LIKE bggo_t.bggoseq2  #項序 
DEFINE l_bgaa003       LIKE bgaa_t.bgaa003   #預算幣別
DEFINE l_bgaa010       LIKE bgaa_t.bgaa010   #預算組織版本
DEFINE l_bgaa011       LIKE bgaa_t.bgaa011   #最上層組織
DEFINE l_sql           STRING
DEFINE l_array         DYNAMIC ARRAY OF RECORD
         chr           LIKE type_t.chr1000
                       END RECORD
DEFINE l_seq           LIKE bggn_t.bggnseq   #僅承接不使用                  
DEFINE l_bggnseq       LIKE bggn_t.bggnseq   
DEFINE l_do            LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   LET l_do = 0 

   #DECLARE 取用工需求明細檔-----------------------------------------------
   LET l_sql = " SELECT UNIQUE bggg001,bggg002,bggg003,bggg004,bggg005, ",
               "               bggg007,bggg008,bggg009,bggg010,bggg011, ",
               "               bggg012,bggg013,bggg014,bggg015,bggg016, ",
               "               bggg017,bggg018,bggg019,bggg020,bggg021, ",
               "               bggg022,bggg023,bggg024,bggg025,bggg026, ",
               "               bggg027,bggg028,bggg029,bggg030,bggg031, ",
               "               bgggseq,bgggseq1,bggg032,bggg033,bggg034  ",
               "   FROM bggk_t,bggg_t ",
               "  WHERE bggkent = ",g_enterprise," ",
               "    AND bggkent = bgggent AND bggk001 = bggg001 AND bggk002 = bggg002 ",
               "    AND bggk003 = bggg031 AND bggk004 = bggg032 ",
               "    AND bggk001 = '",g_master.bggm002,"' ",
               "    AND bggk002 = '",g_master.bggm006,"' ",
               "    AND bggk003 = '",p_bggm007_s,"' ",
               "    AND bggk004 = '",p_bggm007_e,"' ",
               "    AND bggk005 = ? ",
               "    AND bggkstus = 'Y' ",
               "  ORDER BY bggg001,bggg002,bggg031,bgggseq,bgggseq1,bggg032 "
               
   PREPARE sel_bgggp FROM l_sql
   DECLARE sel_bgggc CURSOR FOR sel_bgggp       
   
   #step3. 取工資方案資料檔
   LET l_sql = " SELECT UNIQUE bggbseq,bggb002,bggb003  ",
               "   FROM bggb_t ",
               "  WHERE bggbent = ",g_enterprise," ",
               "    AND bggb001 = ? ",
               "    AND bggbstus = 'Y' ",
               "  ORDER BY bggbseq "
               
   PREPARE sel_bggb002p FROM l_sql
   DECLARE sel_bggb002c CURSOR FOR sel_bggb002p    
   ###--------------------------------------------------------------------

   #前置動作---------------------------------------------------------------
   #寫入單身bggo_t前,先刪除
   DELETE FROM bggo_t 
    WHERE bggoent = g_enterprise 
      AND bggo001 = '20'
      AND bggo002 = g_master.bggm002
      AND bggo003 = g_master.bggm003
      AND bggo005 = '2'
      AND bggo006 = '1'
      AND bggo007 = g_master.bggm006
      AND bggo008 = p_bggm007

   #寫入單身bggn_t前,先刪除
   DELETE FROM bggn_t 
    WHERE bggnent = g_enterprise 
      AND bggn001 = '20'
      AND bggn002 = g_master.bggm002
      AND bggn003 = g_master.bggm003
      AND bggn004 = '2'
      AND bggn005 = '1'
      AND bggn006 = g_master.bggm006
      AND bggn007 = p_bggm007
      
   #預算幣別/預算組織版本/最上層組織
   LET l_bgaa003 = ''
   LET l_bgaa010 = ''
   LET l_bgaa011 = ''
   SELECT bgaa003,bgaa010,bgaa011 INTO l_bgaa003,l_bgaa010,l_bgaa011 
     FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bggm002       
   #----------------------------------------------------------------------
    
   #取工資方案-------------------------------------------------------------
   LET l_bggk005 = ''
   LET l_sql = " SELECT UNIQUE bggk005  ",
               "   FROM bggk_t ",
               "  WHERE bggkent = ",g_enterprise," ",
               "    AND bggk001 = '",g_master.bggm002,"' ",
               "    AND bggk002 = '",g_master.bggm006,"' ",
               "    AND bggk003 = '",p_bggm007_s,"' ",
               "    AND bggk004 = '",p_bggm007_e,"' ",
               "    AND bggkstus = 'Y' ",
               "  ORDER BY bggk005 "
   PREPARE sel_bggk005p FROM l_sql
   DECLARE sel_bggk005c CURSOR FOR sel_bggk005p        
   FOREACH sel_bggk005c INTO l_bggk005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:sel_bggk005c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #取用工需求明細檔---------------------------------------------------
      #step 3-1. 依工資方案,取用工需求明細檔(寫入單身bggn_t)
      LET l_bggnseq = 0
      INITIALIZE l_bggg.* TO NULL
      FOREACH sel_bgggc USING l_bggk005 INTO l_bggg.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:sel_bgggc"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         LET l_bggnseq = l_bggnseq +1

         INITIALIZE l_bggn.* TO NULL
         LET l_bggn.bggnent  = g_enterprise       #企業編號
         LET l_bggn.bggn001  = '20'               #資料來源
         LET l_bggn.bggn002  = g_master.bggm002   #預算編號
         LET l_bggn.bggn003  = g_master.bggm003   #版本
         LET l_bggn.bggn004  = '2'                #人工來源
         LET l_bggn.bggn005  = '1'                #資料來源
         LET l_bggn.bggn006  = g_master.bggm006   #預算組織
         LET l_bggn.bggn007  = p_bggm007          #期別
         LET l_bggn.bggnseq  = l_bggnseq          #項次
         LET l_bggn.bggn008  = g_bgai002          #管理組織
         LET l_bggn.bggn009  = g_bgai008          #預算樣表
         LET l_bggn.bggn010  = l_bggk005          #工資方案
         LET l_bggn.bggn011  = l_bggg.bggg003     #職級
         LET l_bggn.bggn012  = l_bggg.bggg004     #職等
         LET l_bggn.bggn013  = l_bggg.bggg005     #用工屬性
         LET l_bggn.bggn014  = l_bggg.bggg014     #人員
         LET l_bggn.bggn015  = l_bggg.bggg007     #部門
         LET l_bggn.bggn016  = l_bggg.bggg008     #成本利潤中心
         LET l_bggn.bggn017  = l_bggg.bggg009     #區域
         LET l_bggn.bggn018  = l_bggg.bggg010     #收付款供應商
         LET l_bggn.bggn019  = l_bggg.bggg011     #帳款客商
         LET l_bggn.bggn020  = l_bggg.bggg012     #客群
         LET l_bggn.bggn021  = l_bggg.bggg013     #產品類別
         LET l_bggn.bggn022  = l_bggg.bggg015     #專案編號
         LET l_bggn.bggn023  = l_bggg.bggg016     #WBS
         LET l_bggn.bggn024  = l_bggg.bggg033     #經營方式
         LET l_bggn.bggn025  = l_bggg.bggg034     #通路
         LET l_bggn.bggn026  = l_bggg.bggg019     #品牌
         LET l_bggn.bggn027  = l_bggg.bggg021     #自由核算項一
         LET l_bggn.bggn028  = l_bggg.bggg022     #自由核算項二
         LET l_bggn.bggn029  = l_bggg.bggg023     #自由核算項三
         LET l_bggn.bggn030  = l_bggg.bggg024     #自由核算項四
         LET l_bggn.bggn031  = l_bggg.bggg025     #自由核算項五
         LET l_bggn.bggn032  = l_bggg.bggg026     #自由核算項六
         LET l_bggn.bggn033  = l_bggg.bggg027     #自由核算項七
         LET l_bggn.bggn034  = l_bggg.bggg028     #自由核算項八
         LET l_bggn.bggn035  = l_bggg.bggg029     #自由核算項九
         LET l_bggn.bggn036  = l_bggg.bggg030     #自由核算項十
         LET l_bggn.bggn037  = 0                  #參考人數
         LET l_bggn.bggn038  = l_bggg.bggg020     #用工人數
         LET l_bggn.bggnstus = 'N'                #狀態碼
 
         #寫入單身 bggn_t
         INSERT INTO bggn_t(bggnent,bggn001,bggn002,bggn003,bggn004,
                            bggn005,bggn006,bggn007,bggnseq,bggn008,
                            bggn009,bggn010,bggn011,bggn012,bggn013,
                            bggn014,bggn015,bggn016,bggn017,bggn018,
                            bggn019,bggn020,bggn021,bggn022,bggn023,
                            bggn024,bggn025,bggn026,bggn027,bggn028,
                            bggn029,bggn030,bggn031,bggn032,bggn033,
                            bggn034,bggn035,bggn036,bggn037,bggn038,
                            bggnstus)
                     VALUES(l_bggn.bggnent,l_bggn.bggn001,l_bggn.bggn002,l_bggn.bggn003,l_bggn.bggn004,
                            l_bggn.bggn005,l_bggn.bggn006,l_bggn.bggn007,l_bggn.bggnseq,l_bggn.bggn008,
                            l_bggn.bggn009,l_bggn.bggn010,l_bggn.bggn011,l_bggn.bggn012,l_bggn.bggn013,
                            l_bggn.bggn014,l_bggn.bggn015,l_bggn.bggn016,l_bggn.bggn017,l_bggn.bggn018,
                            l_bggn.bggn019,l_bggn.bggn020,l_bggn.bggn021,l_bggn.bggn022,l_bggn.bggn023,
                            l_bggn.bggn024,l_bggn.bggn025,l_bggn.bggn026,l_bggn.bggn027,l_bggn.bggn028,
                            l_bggn.bggn029,l_bggn.bggn030,l_bggn.bggn031,l_bggn.bggn032,l_bggn.bggn033,
                            l_bggn.bggn034,l_bggn.bggn035,l_bggn.bggn036,l_bggn.bggn037,l_bggn.bggn038,
                            l_bggn.bggnstus)                        
          
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INS_bggn_t_ERR"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         ######## 

         #step4.取工資項目,依用工需求明細檔項目繞迴圈 (寫入單身bggo_t)
         LET l_bggoseq2 = 0
         LET l_bggb002 = ''
         LET l_bggb003 = ''
         FOREACH sel_bggb002c USING l_bggk005 INTO l_seq,l_bggb002,l_bggb003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "FOREACH:sel_bggb002c"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF    
            
            LET l_bggoseq2 = l_bggoseq2 +1
            
            #寫入單身bggo_t 人工費用預算明細檔----------------------------------------------------------------
            INITIALIZE l_bggo.* TO NULL
            LET l_bggo.bggoent  = l_bggn.bggnent  #企業編號
            LET l_bggo.bggo001  = l_bggn.bggn001  #資料來源
            LET l_bggo.bggo002  = l_bggn.bggn002  #預算編號
            LET l_bggo.bggo003  = l_bggn.bggn003  #版本
            LET l_bggo.bggo004  = l_bggn.bggn008  #管理組織
            LET l_bggo.bggo005  = l_bggn.bggn004  #人工來源
            LET l_bggo.bggo006  = l_bggn.bggn005  #資料來源
            LET l_bggo.bggo007  = l_bggn.bggn006  #預算組織
            LET l_bggo.bggo008  = l_bggn.bggn007  #期別
            LET l_bggo.bggoseq  = l_bggn.bggnseq  #項次
            LET l_bggo.bggoseq2 = l_bggoseq2      #項序
            LET l_bggo.bggo009  = l_bggb002       #工資項目 
            LET l_bggo.bggo011  = l_bggn.bggn009  #預算樣表
            LET l_bggo.bggo012  = l_bggn.bggn014  #人員
            LET l_bggo.bggo013  = l_bggn.bggn015  #部門
            LET l_bggo.bggo014  = l_bggn.bggn016  #成本利潤中心
            LET l_bggo.bggo015  = l_bggn.bggn017  #區域
            LET l_bggo.bggo016  = l_bggn.bggn018  #收付款供應商
            LET l_bggo.bggo017  = l_bggn.bggn019  #帳款客商
            LET l_bggo.bggo018  = l_bggn.bggn020  #客群
            LET l_bggo.bggo019  = l_bggn.bggn021  #產品類別
            LET l_bggo.bggo020  = l_bggn.bggn022  #專案編號
            LET l_bggo.bggo021  = l_bggn.bggn023  #WBS
            LET l_bggo.bggo022  = l_bggn.bggn024  #經營方式
            LET l_bggo.bggo023  = l_bggn.bggn025  #通路
            LET l_bggo.bggo024  = l_bggn.bggn026  #品牌
            LET l_bggo.bggo025  = l_bggn.bggn027  #自由核算項一
            LET l_bggo.bggo026  = l_bggn.bggn028  #自由核算項二
            LET l_bggo.bggo027  = l_bggn.bggn029  #自由核算項三
            LET l_bggo.bggo028  = l_bggn.bggn030  #自由核算項四
            LET l_bggo.bggo029  = l_bggn.bggn031  #自由核算項五
            LET l_bggo.bggo030  = l_bggn.bggn032  #自由核算項六
            LET l_bggo.bggo031  = l_bggn.bggn033  #自由核算項七
            LET l_bggo.bggo032  = l_bggn.bggn034  #自由核算項八
            LET l_bggo.bggo033  = l_bggn.bggn035  #自由核算項九
            LET l_bggo.bggo034  = l_bggn.bggn036  #自由核算項十
            LET l_bggo.bggo035  = l_bggn.bggn038  #用工人數
            LET l_bggo.bggo038  = ''              #憑證單號
            LET l_bggo.bggo041  = l_bggn.bggn010  #工資方案
            LET l_bggo.bggo042  = l_bggn.bggn011  #職級
            LET l_bggo.bggo043  = l_bggn.bggn012  #職等
            LET l_bggo.bggo044  = l_bggn.bggn013  #用工屬性                      
            
            #上層組織
            SELECT ooed005 INTO l_bggo.bggo037 FROM ooed_t
             WHERE ooedent = g_enterprise AND ooed001 = '4'
               AND ooed002 = l_bgaa011    AND ooed003 = l_bgaa010
               AND ooed004 = l_bggo.bggo007

            #step4-1. 工資項目取薪資標準,依abgi740撈取對應abgi760標準薪資
            #step4-2. 元件推算類型為2.計算公式的薪資基準
            #支付幣別及標準工資
            LET l_success = ''
            CALL s_abg2_get_salary_amt(l_bggo.bggo002,l_bggo.bggo007,l_bggk005,l_bggo.bggo009,l_bggn.bggn013,l_bggn.bggn011,l_bggn.bggn012) RETURNING l_success,l_bggo.bggo100,l_bggo.bggo036
            IF NOT l_success THEN
               LET r_success = FALSE
               RETURN r_success
            END IF

            #step4-3. 細項借貸方科目取abgi750
            #借方預算細項bggc005/貸方預算細項bggc006
            SELECT bggc005,bggc006 INTO l_bggo.bggo039,l_bggo.bggo040 FROM bggc_t
             WHERE bggcent = g_enterprise AND bggc001 = l_bggo.bggo002 
               AND bggc002 = l_bggo.bggo007 AND bggc003 = l_bggk005 AND bggc004 = l_bggb002

            #匯率取預算匯率維護檔abgi200
            CALL s_abg_get_bg_rate(l_bggo.bggo002,g_today,l_bggo.bggo100,l_bgaa003) RETURNING l_bggo.bggo101
            
            #預算金額
            LET l_bggo.bggo103 = l_bggo.bggo035 * l_bggo.bggo036
            CALL s_curr_round(l_bggo.bggo007,l_bggo.bggo100,l_bggo.bggo103,2) RETURNING l_bggo.bggo103
           
            LET l_bggo.bggo104  = 0               #本層調整金額
            LET l_bggo.bggo105  = 0               #上層調整金額
            LET l_bggo.bggo106  = l_bggo.bggo103  #核准金額
            LET l_bggo.bggostus = 'N'             #狀態碼
            
            #處理複合KEY
            CALL l_array.clear()
            LET l_array[1].chr  = l_bggo.bggo012  #人員
            LET l_array[2].chr  = l_bggo.bggo013  #部門
            LET l_array[3].chr  = l_bggo.bggo014  #成本利潤中心
            LET l_array[4].chr  = l_bggo.bggo015  #區域
            LET l_array[5].chr  = l_bggo.bggo016  #收付款供應商
            LET l_array[6].chr  = l_bggo.bggo017  #帳款客商
            LET l_array[7].chr  = l_bggo.bggo018  #客群
            LET l_array[8].chr  = l_bggo.bggo019  #產品類別
            LET l_array[9].chr  = l_bggo.bggo020  #專案編號
            LET l_array[10].chr = l_bggo.bggo021  #WBS
            LET l_array[11].chr = l_bggo.bggo022  #經營方式
            LET l_array[12].chr = l_bggo.bggo023  #通路          
            LET l_array[13].chr = l_bggo.bggo024  #品牌                    
            
            CALL s_abg2_get_bggo010(l_array)RETURNING l_bggo.bggo010  #組合 key

            #寫入單身 bggo_t
            INSERT INTO bggo_t(bggoent,bggo001,bggo002,bggo003,bggo004,bggo005,
                               bggo006,bggo007,bggo008,bggoseq,bggoseq2,bggo009,
                               bggo010,bggo011,bggo012,bggo013,bggo014,bggo015,
                               bggo016,bggo017,bggo018,bggo019,bggo020,bggo021,
                               bggo022,bggo023,bggo024,bggo025,bggo026,bggo027,
                               bggo028,bggo029,bggo030,bggo031,bggo032,bggo033,
                               bggo034,bggo035,bggo036,bggo037,bggo038,bggo039,
                               bggo040,bggo041,bggo042,bggo043,bggo044,bggo100,
                               bggo101,bggo103,bggo104,bggo105,bggo106,bggostus)
                        VALUES(l_bggo.bggoent,l_bggo.bggo001,l_bggo.bggo002,l_bggo.bggo003,l_bggo.bggo004,l_bggo.bggo005,
                               l_bggo.bggo006,l_bggo.bggo007,l_bggo.bggo008,l_bggo.bggoseq,l_bggo.bggoseq2,l_bggo.bggo009,
                               l_bggo.bggo010,l_bggo.bggo011,l_bggo.bggo012,l_bggo.bggo013,l_bggo.bggo014,l_bggo.bggo015,
                               l_bggo.bggo016,l_bggo.bggo017,l_bggo.bggo018,l_bggo.bggo019,l_bggo.bggo020,l_bggo.bggo021,
                               l_bggo.bggo022,l_bggo.bggo023,l_bggo.bggo024,l_bggo.bggo025,l_bggo.bggo026,l_bggo.bggo027,
                               l_bggo.bggo028,l_bggo.bggo029,l_bggo.bggo030,l_bggo.bggo031,l_bggo.bggo032,l_bggo.bggo033,
                               l_bggo.bggo034,l_bggo.bggo035,l_bggo.bggo036,l_bggo.bggo037,l_bggo.bggo038,l_bggo.bggo039,
                               l_bggo.bggo040,l_bggo.bggo041,l_bggo.bggo042,l_bggo.bggo043,l_bggo.bggo044,l_bggo.bggo100,
                               l_bggo.bggo101,l_bggo.bggo103,l_bggo.bggo104,l_bggo.bggo105,l_bggo.bggo106,l_bggo.bggostus)                        
             
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INS_bggo_t_ERR"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF            

            LET l_do = l_do + 1 
         END FOREACH
         #-----------------------------------------------------------------------------------------------
         
         IF NOT r_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END FOREACH
      
      IF NOT r_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   
   #是否有資料執行
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'   #無資料產生
      LET g_errparam.extend = "INSERT INTO bggo_t IS NULL"
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      LET r_success = FALSE
   END IF

   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
