#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp025.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-03-28 17:41:41), PR版次:0002(2016-10-21 10:37:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: abgp025
#+ Description: 預算批次確認作業
#+ Creator....: 03080(2016-03-28 16:23:13)
#+ Modifier...: 03080 -SD/PR- 08732
 
{</section>}
 
{<section id="abgp025.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161006-00005#10   161020 By 08732      組織類型與職能開窗調整
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
   bgbh001 LIKE type_t.chr10, 
   bgbh002 LIKE type_t.chr10, 
   l_stus LIKE type_t.chr10, 
   bgbh003 LIKE type_t.chr10, 
   bgbh003_desc LIKE type_t.chr80, 
   bgbh004 LIKE type_t.chr10,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       bgbh001 LIKE type_t.chr10, 
   bgbh002 LIKE type_t.chr10, 
   l_stus LIKE type_t.chr10, 
   bgbh003 LIKE type_t.chr10, 
   bgbh003_desc LIKE type_t.chr80, 
   bgbh004 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_bgaa012   LIKE bgaa_t.bgaa012
DEFINE g_bgaa008   LIKE bgaa_t.bgaa008
DEFINE g_userorga        STRING   #161006-00005#10   add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp025.main" >}
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
   CALL s_abgt025_create_tmp()   #預算調整用temp
   CALL s_abgp020_create_tmp()
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abgp025_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp025 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp025_init()
 
      #進入選單 Menu (="N")
      CALL abgp025_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp025
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp025.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp025_init()
 
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
   CALL cl_set_combo_scc_part('l_stus','13','Y,FC')
   #161006-00005#910  add ---s
   CALL s_fin_create_account_center_tmp()   
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_sons_str() RETURNING g_userorga
   CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   #161006-00005#10  add ---e
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgp025.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp025_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_orga      STRING              #161006-00005#10   add
   DEFINE l_cnt       LIKE type_t.num10   #161006-00005#10   add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL abgp025_qbeclear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgbh001,g_master.bgbh002,g_master.l_stus,g_master.bgbh003 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbh001
            #add-point:BEFORE FIELD bgbh001 name="input.b.bgbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbh001
            
            #add-point:AFTER FIELD bgbh001 name="input.a.bgbh001"
            IF NOT cl_null(g_master.bgbh001)THEN
               CALL abgp025_001002003_chk()RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_master.bgbh001 = ''
                  DISPLAY BY NAME g_master.bgbh001
                  NEXT FIELD bgbh001
               END IF
            END IF

            LET g_bgaa012 = NULL   LET g_bgaa008 = NULL
            SELECT bgaa012 ,bgaa008
              INTO g_bgaa012,g_bgaa008
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_master.bgbh001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbh001
            #add-point:ON CHANGE bgbh001 name="input.g.bgbh001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbh002
            #add-point:BEFORE FIELD bgbh002 name="input.b.bgbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbh002
            
            #add-point:AFTER FIELD bgbh002 name="input.a.bgbh002"
            IF NOT cl_null(g_master.bgbh002)THEN
               CALL abgp025_001002003_chk()RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_master.bgbh002 = ''
                  DISPLAY BY NAME g_master.bgbh002
                  NEXT FIELD bgbh002
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbh002
            #add-point:ON CHANGE bgbh002 name="input.g.bgbh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stus
            #add-point:BEFORE FIELD l_stus name="input.b.l_stus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stus
            
            #add-point:AFTER FIELD l_stus name="input.a.l_stus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_stus
            #add-point:ON CHANGE l_stus name="input.g.l_stus"
            CALL cl_set_comp_entry('bgbh003',TRUE)
            CASE 
               WHEN g_master.l_stus = 'Y'
                  LET g_master.bgbh003 = ''
                  DISPLAY BY NAME g_master.bgbh003       
                                    
               WHEN g_master.l_stus = 'FC'
                  LET g_master.bgbh003 = ''
                  SELECT bgaa011 INTO g_master.bgbh003 FROM bgaa_t
                   WHERE bgaaent = g_enterprise
                     AND bgaa001 = g_master.bgbh001
                  DISPLAY BY NAME g_master.bgbh003                     
                  CALL cl_set_comp_entry('bgbh003',FALSE)
            END CASE
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbh003
            
            #add-point:AFTER FIELD bgbh003 name="input.a.bgbh003"
            IF NOT cl_null(g_master.bgbh003)THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.bgbh003
               IF NOT cl_chk_exist("v_ooef001") THEN
                  LET g_master.bgbh003 = ''
                  DISPLAY BY NAME g_master.bgbh003
                  NEXT FIELD CURRENT
               END IF
            
               CALL abgp025_001002003_chk()RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_master.bgbh003 = ''
                  DISPLAY BY NAME g_master.bgbh003
                  NEXT FIELD bgbh003
               END IF
               
               #161006-00005#10   add---s               
               #call function 檢核輸入的組織是不是預算組織  有效否
               CALL s_abg_bgaj002_chk(g_master.bgbh003)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bgbh003 = ''
                  DISPLAY BY NAME g_master.bgbh003
                  NEXT FIELD CURRENT
               END IF
               
               #檢核輸入的預算組織  是不是存在預算編號底下的組織               
               CALL s_abg_site_chk(g_master.bgbh003)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bgbh003 = ''
                  DISPLAY BY NAME g_master.bgbh003
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_master.bgbh001) THEN
                  LET l_cnt = 0
                  SELECT count(1) INTO l_cnt FROM bgaj_t
                   WHERE bgajent = g_enterprise
                     AND bgaj001 = g_master.bgbh001
                     AND bgaj002 = g_master.bgbh003
                     AND bgajstus = 'Y'
                     
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "abg-00079"
                     LET g_errparam.extend = g_master.bgbh001,"+",g_master.bgbh003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgbh003 = ''
                     DISPLAY BY NAME g_master.bgbh003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #161006-00005#10   add---e
               
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbh003
            #add-point:BEFORE FIELD bgbh003 name="input.b.bgbh003"
            IF g_master.l_stus = 'FC' THEN
               NEXT FIELD bgbh004
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbh003
            #add-point:ON CHANGE bgbh003 name="input.g.bgbh003"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgbh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbh001
            #add-point:ON ACTION controlp INFIELD bgbh001 name="input.c.bgbh001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgbh001
            LET g_qryparam.default2 = g_master.bgbh002
            CALL q_bgbh001()
            LET g_master.bgbh001 = g_qryparam.return1
            LET g_master.bgbh002 = g_qryparam.return2
            DISPLAY BY NAME g_master.bgbh001
            NEXT FIELD bgbh001
            #END add-point
 
 
         #Ctrlp:input.c.bgbh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbh002
            #add-point:ON ACTION controlp INFIELD bgbh002 name="input.c.bgbh002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgbh001
            LET g_qryparam.default2 = g_master.bgbh002
            LET g_qryparam.where = "bgbh001 = '",g_master.bgbh001,"' "
            CALL q_bgbh001()
            LET g_master.bgbh001 = g_qryparam.return1
            LET g_master.bgbh002 = g_qryparam.return2
            DISPLAY BY NAME g_master.bgbh001
            NEXT FIELD bgbh001
            #END add-point
 
 
         #Ctrlp:input.c.l_stus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stus
            #add-point:ON ACTION controlp INFIELD l_stus name="input.c.l_stus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbh003
            #add-point:ON ACTION controlp INFIELD bgbh003 name="input.c.bgbh003"
            #161006-00005#10  add----s
            CALL s_fin_abg_center_sons_query(g_master.bgbh001,'','')  
            CALL s_fin_account_center_sons_str() RETURNING l_orga  
            CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            #161006-00005#10  add----e
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgbh003  #給予default值
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t WHERE bgajent = ooefent AND bgaj001 = '",g_master.bgbh001,"' ",
                                   "                AND bgajstus = 'Y') ",
                                   " AND ooef001 IN ", g_userorga," AND ooef001 IN ", l_orga   #161006-00005#10   add
            #CALL q_ooef001()     #161006-00005#10   mark
            CALL q_ooef001_77()   #161006-00005#10   add
            LET g_master.bgbh003 = g_qryparam.return1
            DISPLAY BY NAME g_master.bgbh003
            NEXT FIELD bgbh003
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bgbh004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbh004
            #add-point:BEFORE FIELD bgbh004 name="construct.b.bgbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbh004
            
            #add-point:AFTER FIELD bgbh004 name="construct.a.bgbh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbh004
            #add-point:ON ACTION controlp INFIELD bgbh004 name="construct.c.bgbh004"
            IF g_bgaa012 = 'Y' THEN       
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "glac001 = '",g_bgaa008,"' AND  glac003 <>'1' "              #glac001(會計科目參照表)/glac003(科>
                                      
               CALL aglt310_04()
               DISPLAY g_qryparam.return1 TO bgbh004
               NEXT FIELD bgbh004
            ELSE
               #抓取預算項目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " bgae006 = '",g_bgaa008,"' " #存在預算編號的預算項目參照表            "
               CALL q_bgae001()
               DISPLAY g_qryparam.return1 TO bgbh004
               NEXT FIELD bgbh004
            END IF
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
            CALL abgp025_get_buffer(l_dialog)
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
            CALL abgp025_qbeclear()
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
         CALL abgp025_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.bgbh001 = g_master.bgbh001
      LET lc_param.bgbh002 = g_master.bgbh002
      LET lc_param.l_stus  = g_master.l_stus
      LET lc_param.bgbh003 = g_master.bgbh003
      LET lc_param.bgbh004 = g_master.bgbh004 
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
                 CALL abgp025_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp025_transfer_argv(ls_js)
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
 
{<section id="abgp025.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp025_transfer_argv(ls_js)
 
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
 
{<section id="abgp025.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp025_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql        STRING
   DEFINE l_bgbh004    LIKE bgbh_t.bgbh004
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_do         LIKE type_t.num5
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
#  DECLARE abgp025_process_cs CURSOR FROM ls_sql
#  FOREACH abgp025_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_sql = " SELECT bgbh004 FROM bgbh_t ",
               "  WHERE bgbhent = ",g_enterprise," ",
               "    AND bgbh001 = '",lc_param.bgbh001,"' ",
               "    AND bgbh002 = '",lc_param.bgbh002,"' ",
               "    AND bgbh003 = '",lc_param.bgbh003,"'",
               "    AND ",lc_param.wc CLIPPED,
               "    AND bgbh006 = '2' "
               
   CASE
      WHEN lc_param.l_stus = 'Y'
         LET l_sql = l_sql CLIPPED," AND bgbhstus = 'N' "
      WHEN lc_param.l_stus = 'FC'
         LET l_sql = l_sql CLIPPED," AND bgbhstus = 'Y' "        
   END CASE
   PREPARE sel_bgbhp1 FROM l_sql
   DECLARE sel_bgbhc1 CURSOR FOR sel_bgbhp1
   
   LET l_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_do = FALSE
   FOREACH sel_bgbhc1 INTO l_bgbh004
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      CASE
         WHEN lc_param.l_stus = 'Y'
            CALL s_abgt025_conf_chk(lc_param.bgbh001,lc_param.bgbh002,lc_param.bgbh003,l_bgbh004,'2')
               RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = FALSE        
            END IF
            
            IF l_success THEN
               CALL s_abgt025_conf_upd(lc_param.bgbh001,lc_param.bgbh002,lc_param.bgbh003,l_bgbh004,'2')
                  RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET l_success = FALSE        
               END IF
            END IF
         WHEN lc_param.l_stus = 'FC'
            CALL s_abgt025_finalconf_chk(lc_param.bgbh001,lc_param.bgbh002,lc_param.bgbh003,l_bgbh004,'2')
               RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = FALSE        
            END IF     
            IF l_success THEN
               CALL s_abgt025_finalconf_upd(lc_param.bgbh001,lc_param.bgbh002,lc_param.bgbh003,l_bgbh004,'2')
                  RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET l_success = FALSE        
               END IF                      
            END IF 
                     
      END CASE
      
      LET l_do = TRUE
   END FOREACH
   
   IF NOT l_do THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   
   IF l_success THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aim-00102'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   CALL cl_err_collect_show()
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
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
   CALL abgp025_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp025.get_buffer" >}
PRIVATE FUNCTION abgp025_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgbh001 = p_dialog.getFieldBuffer('bgbh001')
   LET g_master.bgbh002 = p_dialog.getFieldBuffer('bgbh002')
   LET g_master.l_stus = p_dialog.getFieldBuffer('l_stus')
   LET g_master.bgbh003 = p_dialog.getFieldBuffer('bgbh003')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp025.msgcentre_notify" >}
PRIVATE FUNCTION abgp025_msgcentre_notify()
 
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
 
{<section id="abgp025.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION abgp025_qbeclear()
   LET g_master.l_stus = 'Y'
   LET g_master.bgbh001 = ''
   LET g_master.bgbh002 = ''
   LET g_master.bgbh003 = ''
   DISPLAY BY NAME g_master.l_stus,g_master.bgbh001,g_master.bgbh002,g_master.bgbh003
   CALL cl_set_comp_entry('bgbh003',TRUE)
END FUNCTION

PRIVATE FUNCTION abgp025_001002003_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_count     LIKE type_t.num10
   
   
   LET r_success = TRUE
   LET r_errno = ''
   IF NOT cl_null(g_master.bgbh001)THEN
      CALL s_abg_bgaa001_chk(g_master.bgbh001)RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno = g_errno
         RETURN r_success,r_errno
      END IF
   END IF
   IF NOT cl_null(g_master.bgbh003)THEN
     
   END IF
   
   IF NOT cl_null(g_master.bgbh001) AND NOT cl_null(g_master.bgbh002)THEN
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM bgbh_t
       WHERE bgbhent = g_enterprise
         AND bgbh001 = g_master.bgbh001
         AND bgbh002 = g_master.bgbh002
         AND bgbh006 = '2'
         AND bgbhstus <> 'X'
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno  = 'abg-00125'
      END IF
   END IF
   
   IF NOT cl_null(g_master.bgbh001) AND NOT cl_null(g_master.bgbh002) AND NOT cl_null(g_master.bgbh003)THEN

   END IF   
   RETURN r_success,r_errno
END FUNCTION

#end add-point
 
{</section>}
 
