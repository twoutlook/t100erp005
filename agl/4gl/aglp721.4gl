#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp721.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-01-21 13:44:03), PR版次:0001(2016-04-01 10:18:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aglp721
#+ Description: 合併報表關係人交易明細產生作業
#+ Creator....: 04152(2016-01-08 11:40:40)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aglp721.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
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
       glduld LIKE gldu_t.glduld, 
   glduld_desc LIKE type_t.chr80, 
   gldu001 LIKE gldu_t.gldu001, 
   gldu001_desc LIKE type_t.chr80, 
   gldu003 LIKE gldu_t.gldu003, 
   l_chk1 LIKE type_t.chr500, 
   gldu004 LIKE gldu_t.gldu004, 
   l_chk2 LIKE type_t.chr500, 
   l_chk3 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaa003        LIKE glaa_t.glaa003
DEFINE g_glaa138        LIKE glaa_t.glaa138
DEFINE g_em             LIKE glaa_t.glaa011              #取餘額實際期別
DEFINE g_pdate_e        LIKE glav_t.glav004              #實際期別最後一天
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglp721.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aglp721_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp721 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp721_init()
 
      #進入選單 Menu (="N")
      CALL aglp721_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp721
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp721.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp721_init()
 
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
   CALL cl_set_combo_scc("l_chk1","9998")
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglp721.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp721_ui_dialog()
 
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
   CALL aglp721_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glduld,g_master.gldu001,g_master.gldu003,g_master.l_chk1,g_master.gldu004, 
             g_master.l_chk2,g_master.l_chk3 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glduld
            
            #add-point:AFTER FIELD glduld name="input.a.glduld"
            #合併帳別
            LET g_master.glduld_desc = ' '
            DISPLAY BY NAME g_master.glduld_desc
            IF NOT cl_null(g_master.glduld) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glduld,g_master.gldu001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.glduld = ''
                  LET g_master.glduld_desc = ''
                  CALL aglp721_get_ld_info('1')
                  DISPLAY BY NAME g_master.glduld,g_master.glduld_desc
                  NEXT FIELD CURRENT
               END IF
               CALL aglp721_get_ld_info('1')
            END IF
            CALL s_desc_get_ld_desc(g_master.glduld) RETURNING g_master.glduld_desc
            DISPLAY BY NAME g_master.glduld,g_master.glduld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glduld
            #add-point:BEFORE FIELD glduld name="input.b.glduld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glduld
            #add-point:ON CHANGE glduld name="input.g.glduld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu001
            
            #add-point:AFTER FIELD gldu001 name="input.a.gldu001"
            #上層公司
            LET g_master.gldu001_desc = ' '
            DISPLAY BY NAME g_master.gldu001_desc
            IF NOT cl_null(g_master.gldu001) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glduld,g_master.gldu001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.gldu001 = ''
                  LET g_master.gldu001_desc = ''
                  DISPLAY BY NAME g_master.gldu001,g_master.gldu001_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.gldu001_desc = s_desc_glda001_desc(g_master.gldu001)
            DISPLAY BY NAME g_master.gldu001,g_master.gldu001_desc,g_master.glduld,g_master.glduld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu001
            #add-point:BEFORE FIELD gldu001 name="input.b.gldu001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu001
            #add-point:ON CHANGE gldu001 name="input.g.gldu001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.gldu003,"0","0","2099","1","azz-00087",1) THEN
               NEXT FIELD gldu003
            END IF 
 
 
 
            #add-point:AFTER FIELD gldu003 name="input.a.gldu003"
            IF NOT cl_null(g_master.gldu003) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu003
            #add-point:BEFORE FIELD gldu003 name="input.b.gldu003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu003
            #add-point:ON CHANGE gldu003 name="input.g.gldu003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk1
            #add-point:BEFORE FIELD l_chk1 name="input.b.l_chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk1
            
            #add-point:AFTER FIELD l_chk1 name="input.a.l_chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk1
            #add-point:ON CHANGE l_chk1 name="input.g.l_chk1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.gldu004,"0","0","13","1","azz-00087",1) THEN
               NEXT FIELD gldu004
            END IF 
 
 
 
            #add-point:AFTER FIELD gldu004 name="input.a.gldu004"
            IF NOT cl_null(g_master.gldu004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu004
            #add-point:BEFORE FIELD gldu004 name="input.b.gldu004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu004
            #add-point:ON CHANGE gldu004 name="input.g.gldu004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk2
            #add-point:BEFORE FIELD l_chk2 name="input.b.l_chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk2
            
            #add-point:AFTER FIELD l_chk2 name="input.a.l_chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk2
            #add-point:ON CHANGE l_chk2 name="input.g.l_chk2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk3
            #add-point:BEFORE FIELD l_chk3 name="input.b.l_chk3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk3
            
            #add-point:AFTER FIELD l_chk3 name="input.a.l_chk3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk3
            #add-point:ON CHANGE l_chk3 name="input.g.l_chk3"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glduld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glduld
            #add-point:ON ACTION controlp INFIELD glduld name="input.c.glduld"
            #合併帳別
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glduld
            CALL s_desc_get_ld_desc(g_master.glduld) RETURNING g_master.glduld_desc
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",
                                               " WHERE gldbstus = 'Y' ",
                                               "   AND gldbent = '",g_enterprise,"') "
            CALL q_authorised_ld()
            LET g_master.glduld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.glduld) RETURNING g_master.glduld_desc
            DISPLAY BY NAME g_master.glduld,g_master.glduld_desc
            NEXT FIELD glduld
            #END add-point
 
 
         #Ctrlp:input.c.gldu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu001
            #add-point:ON ACTION controlp INFIELD gldu001 name="input.c.gldu001"
            #上層公司
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gldu001
            LET g_qryparam.where = "gldc009 = 'Y' AND gldbstus = 'Y' ",
                                   " AND gldcld = '",g_master.glduld,"' "
            CALL q_gldc001()
            LET g_master.gldu001 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_master.gldu001) RETURNING g_master.gldu001_desc
            DISPLAY BY NAME g_master.gldu001,g_master.gldu001_desc
            NEXT FIELD gldu001
            #END add-point
 
 
         #Ctrlp:input.c.gldu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu003
            #add-point:ON ACTION controlp INFIELD gldu003 name="input.c.gldu003"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk1
            #add-point:ON ACTION controlp INFIELD l_chk1 name="input.c.l_chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldu004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu004
            #add-point:ON ACTION controlp INFIELD gldu004 name="input.c.gldu004"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk2
            #add-point:ON ACTION controlp INFIELD l_chk2 name="input.c.l_chk2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk3
            #add-point:ON ACTION controlp INFIELD l_chk3 name="input.c.l_chk3"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               #編制期別如果是1.季，則季別不可選0.無
               IF g_master.l_chk1 = "1" AND g_master.l_chk2 = "0" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00438'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD l_chk2
               END IF
               #編制期別如果是2.年，則半年不可選0.無
               IF g_master.l_chk1 = "2" AND g_master.l_chk3 = "0" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00439'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD l_chk3
               END IF
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
            CALL aglp721_get_buffer(l_dialog)
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
            CALL aglp721_qbe_clear()
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
         CALL aglp721_init()
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
                 CALL aglp721_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp721_transfer_argv(ls_js)
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
 
{<section id="aglp721.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp721_transfer_argv(ls_js)
 
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
 
{<section id="aglp721.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp721_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_write       LIKE type_t.chr1    #判斷是否寫入
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
#  DECLARE aglp721_process_cs CURSOR FROM ls_sql
#  FOREACH aglp721_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   LET g_success = 'Y'
   LET l_write = 'N'
   CALL aglp721_get_ld_info('2')
   
   #先看看有沒有資料存在，若有則詢問是否重新產生??
   LET l_sql = "SELECT COUNT(*)",
               "  FROM gldu_t",
               " WHERE glduent  = ",g_enterprise,
               "   AND glduld = '",g_master.glduld,"'",
               "   AND gldu001 = '",g_master.gldu001,"'",
               "   AND gldu003 = ",g_master.gldu003,
               "   AND gldu004 = ",g_em
   PREPARE gldu_pb1 FROM l_sql
   EXECUTE gldu_pb1 INTO l_cnt
   IF l_cnt > 0 THEN
      IF NOT cl_ask_confirm('afm-00111') THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         LET l_sql = " DELETE FROM gldu_t",
                     " WHERE glduent  = ",g_enterprise,
                     "   AND glduld = '",g_master.glduld,"'",
                     "   AND gldu001 = '",g_master.gldu001,"'",
                     "   AND gldu003 = ",g_master.gldu003,
                     "   AND gldu004 = ",g_em
         PREPARE gldu_pb2 FROM l_sql
         EXECUTE gldu_pb2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.sqlerr = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
      END IF
   END IF
   
   IF g_success = 'Y' THEN
      CALL s_aglp721_ins_gldu(g_master.glduld,g_master.gldu001,g_master.gldu003,g_master.gldu004,g_master.l_chk1,g_master.l_chk2,g_master.l_chk3)
           RETURNING g_sub_success,l_write
      IF NOT g_sub_success THEN
         LET g_success = 'N'
      END IF
   END IF

   IF g_success = 'Y' THEN
      IF l_write = 'Y' THEN
         CALL s_transaction_end('Y','0')
         LET g_bgjob = "N"
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00230'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET g_bgjob = "Y"
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00187'   #單據產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET g_bgjob = "Y"
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
   CALL aglp721_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp721.get_buffer" >}
PRIVATE FUNCTION aglp721_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glduld = p_dialog.getFieldBuffer('glduld')
   LET g_master.gldu001 = p_dialog.getFieldBuffer('gldu001')
   LET g_master.gldu003 = p_dialog.getFieldBuffer('gldu003')
   LET g_master.l_chk1 = p_dialog.getFieldBuffer('l_chk1')
   LET g_master.gldu004 = p_dialog.getFieldBuffer('gldu004')
   LET g_master.l_chk2 = p_dialog.getFieldBuffer('l_chk2')
   LET g_master.l_chk3 = p_dialog.getFieldBuffer('l_chk3')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp721.msgcentre_notify" >}
PRIVATE FUNCTION aglp721_msgcentre_notify()
 
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
 
{<section id="aglp721.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL aglp721_qbe_clear()
# Date & Author..: 2016/01/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp721_qbe_clear()

   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   
   CALL cl_set_comp_entry("gldu004,l_chk2,l_chk3",TRUE)
   LET g_master.l_chk2 = '0'
   LET g_master.l_chk3 = '0'
   LET g_master.gldu003 = YEAR(g_today)
   LET g_master.gldu004 = MONTH(g_today)
   DISPLAY BY NAME g_master.l_chk2,g_master.l_chk3,g_master.gldu003,g_master.gldu004 
   
END FUNCTION

################################################################################
# Descriptions...: 取得合併帳別的相關資訊
# Memo...........:
# Usage..........: CALL aglp721_get_ld_info(p_type)
# Date & Author..: 2016/01/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp721_get_ld_info(p_type)
DEFINE p_type          LIKE type_t.chr1      #1:取參數+帶預設(期別)/2.只取參數
#以下僅承接不使用 ------
DEFINE l_pdate_s       LIKE glav_t.glav004
DEFINE l_pdate_e       LIKE glav_t.glav004
DEFINE l_flag          LIKE type_t.chr1
DEFINE l_errno         LIKE type_t.chr100
DEFINE l_glav002       LIKE glav_t.glav002
DEFINE l_glav005       LIKE glav_t.glav005
DEFINE l_sdate_s       LIKE glav_t.glav004
DEFINE l_sdate_e       LIKE glav_t.glav004
DEFINE l_glav006       LIKE glav_t.glav006
DEFINE l_glav007       LIKE glav_t.glav007
DEFINE l_wdate_s       LIKE glav_t.glav004
DEFINE l_wdate_e       LIKE glav_t.glav004
#以下僅承接不使用 end---
   
   CALL s_ld_sel_glaa(g_master.glduld,'glaa003|glaa138') RETURNING g_sub_success,g_glaa003,g_glaa138
   
   IF p_type = '1' THEN
      #依帳別取得今天日期對應的會計年度期別當預設
      LET g_master.l_chk1 = g_glaa138
      CALL aglp721_set_entry()
      IF g_master.l_chk1 = '0' AND NOT cl_null(g_glaa003) THEN
         #依年度+期別取得會計週期起迄日
         CALL s_get_accdate(g_glaa003,g_today,'','')
         RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                   l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
         LET g_master.gldu003 = l_glav002   #會計年度
         IF cl_null(g_master.gldu004) THEN
            LET g_master.gldu004 = l_glav006   #會計期別
         END IF
         DISPLAY BY NAME g_master.gldu003,g_master.gldu004
      END IF
   ELSE
      #依畫面輸入條件取得撈取餘額條件期別
      LET g_em = ''
      LET g_pdate_e = ''
      CASE
         WHEN g_master.l_chk1 = '0'  #期
            LET g_em = g_master.gldu004
         WHEN g_master.l_chk1 = '1'  #季
            CALL s_merge_get_glav006(g_glaa003,g_master.gldu003,'1',g_master.l_chk2) RETURNING g_sub_success,g_errno,g_em
         WHEN g_master.l_chk1 = '2'  #半年
            CALL s_merge_get_glav006(g_glaa003,g_master.gldu003,'2',g_master.l_chk3) RETURNING g_sub_success,g_errno,g_em
      END CASE
      #依年度+期別取得會計週期起迄日
      CALL s_get_accdate(g_glaa003,'',g_master.gldu003,g_em)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e
  END IF
END FUNCTION

################################################################################
# Descriptions...: 控制日期欄位隱顯
# Memo...........:
# Usage..........: CALL aglp721_set_entry()
# Date & Author..: 2016/01/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp721_set_entry()
   CALL cl_set_comp_entry("gldu004,l_chk2,l_chk3",FALSE)
   CASE g_master.l_chk1
      WHEN '0' 
         CALL cl_set_comp_entry("gldu004",TRUE)
         LET g_master.l_chk2 = '0'
         LET g_master.l_chk3 = '0'
      WHEN '1' 
         CALL cl_set_comp_entry("l_chk2",TRUE)
         LET g_master.l_chk3 = '0'
         LET g_master.gldu004 = ''
      WHEN '2' 
         CALL cl_set_comp_entry("l_chk3",TRUE)
         LET g_master.l_chk2 = '0'
         LET g_master.gldu004 = ''
   END CASE  
   DISPLAY BY NAME g_master.l_chk2,g_master.l_chk3,g_master.gldu004
END FUNCTION

#end add-point
 
{</section>}
 
