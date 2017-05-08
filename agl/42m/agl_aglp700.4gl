#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp700.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-03-11 11:46:27), PR版次:0004(2017-01-24 16:14:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: aglp700
#+ Description: 合併報表個體公司會計科目餘額匯入產生作業
#+ Creator....: 03080(2015-04-07 16:46:48)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aglp700.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160905-00007#4   2016/09/05  by 08172       调整系统中无ENT的SQL条件增加ent
#161128-00061#1   2016/11/29  by 02481       标准程式定义采用宣告模式,弃用.*写法
#170119-00046#1   170124      By albireo     glar來源邏輯修正
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
       l_gldnld LIKE type_t.chr500, 
   l_gldnld_desc LIKE type_t.chr80, 
   l_gldn001 LIKE type_t.chr500, 
   l_gldn001_desc LIKE type_t.chr80, 
   l_yy LIKE type_t.chr500, 
   l_mms LIKE type_t.chr500, 
   l_type LIKE type_t.chr1, 
   l_mme LIKE type_t.chr500, 
   l_chk1 LIKE type_t.chr1, 
   l_chk2 LIKE type_t.chr1, 
   l_docno LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_gldn_ar DYNAMIC ARRAY OF RECORD
          chr1      LIKE type_t.chr1000,
          dat       LIKE type_t.dat
          END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglp700.main" >}
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
      CALL aglp700_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp700 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp700_init()
 
      #進入選單 Menu (="N")
      CALL aglp700_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp700
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp700.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp700_init()
 
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
   CALL aglp700_create_tmp()
   CALL s_fin_set_comp_scc('l_yy','43')   #年度
   CALL s_fin_set_comp_scc('l_mme','111')  #期別
   CALL cl_set_combo_scc('l_type','9998')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglp700.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp700_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa024 LIKE glaa_t.glaa024
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_gldnld,g_master.l_gldn001,g_master.l_yy,g_master.l_mms,g_master.l_type, 
             g_master.l_mme,g_master.l_chk1,g_master.l_chk2,g_master.l_docno 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldnld
            
            #add-point:AFTER FIELD l_gldnld name="input.a.l_gldnld"
            IF NOT cl_null(g_master.l_gldnld)THEN
            
               CALL s_merge_ld_with_comp_chk(g_master.l_gldnld,g_master.l_gldn001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_gldnld = NULL
                  LET g_master.l_gldnld_desc = NULL
                  DISPLAY BY NAME g_master.l_gldnld,g_master.l_gldnld_desc
                  NEXT FIELD CURRENT
               END IF
               CALL aglp700_set_entry()
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldnld
            #add-point:BEFORE FIELD l_gldnld name="input.b.l_gldnld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldnld
            #add-point:ON CHANGE l_gldnld name="input.g.l_gldnld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn001
            
            #add-point:AFTER FIELD l_gldn001 name="input.a.l_gldn001"
            IF NOT cl_null(g_master.l_gldn001)THEN
               CALL s_merge_ld_with_comp_chk(g_master.l_gldnld,g_master.l_gldn001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_gldn001 = NULL
                  LET g_master.l_gldn001_desc = NULL
                  DISPLAY BY NAME g_master.l_gldn001,g_master.l_gldn001_desc
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn001
            #add-point:BEFORE FIELD l_gldn001 name="input.b.l_gldn001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn001
            #add-point:ON CHANGE l_gldn001 name="input.g.l_gldn001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_yy
            #add-point:BEFORE FIELD l_yy name="input.b.l_yy"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_yy
            
            #add-point:AFTER FIELD l_yy name="input.a.l_yy"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_yy
            #add-point:ON CHANGE l_yy name="input.g.l_yy"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_mms
            #add-point:BEFORE FIELD l_mms name="input.b.l_mms"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_mms
            
            #add-point:AFTER FIELD l_mms name="input.a.l_mms"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_mms
            #add-point:ON CHANGE l_mms name="input.g.l_mms"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_type
            #add-point:BEFORE FIELD l_type name="input.b.l_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_type
            
            #add-point:AFTER FIELD l_type name="input.a.l_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_type
            #add-point:ON CHANGE l_type name="input.g.l_type"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_mme
            #add-point:BEFORE FIELD l_mme name="input.b.l_mme"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_mme
            
            #add-point:AFTER FIELD l_mme name="input.a.l_mme"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_mme
            #add-point:ON CHANGE l_mme name="input.g.l_mme"
            
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
         BEFORE FIELD l_docno
            #add-point:BEFORE FIELD l_docno name="input.b.l_docno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_docno
            
            #add-point:AFTER FIELD l_docno name="input.a.l_docno"
            IF NOT cl_null(g_master.l_docno) THEN
               IF NOT s_aooi200_fin_chk_docno(g_master.l_gldnld,'','',g_master.l_docno,g_today,'aglt503') THEN
                  LET g_master.l_docno = NULL
                  DISPLAY BY NAME g_master.l_docno
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_docno
            #add-point:ON CHANGE l_docno name="input.g.l_docno"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_gldnld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldnld
            #add-point:ON ACTION controlp INFIELD l_gldnld name="input.c.l_gldnld"
            #上層公司
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_gldnld
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            LET g_qryparam.where = " glaald IN (SELECT gldbld FROM gldb_t WHERE gldbent = '",g_enterprise,"') "
            CALL q_authorised_ld()
            LET g_master.l_gldnld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.l_gldnld) RETURNING g_master.l_gldnld_desc
            DISPLAY BY NAME g_master.l_gldnld,g_master.l_gldnld_desc
            CALL aglp700_set_entry()
            NEXT FIELD l_gldnld
            #END add-point
 
 
         #Ctrlp:input.c.l_gldn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn001
            #add-point:ON ACTION controlp INFIELD l_gldn001 name="input.c.l_gldn001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_gldn001
            LET g_qryparam.where = " gldc009 = 'Y' "
            CALL q_gldc001()
            LET g_master.l_gldn001 = g_qryparam.return1
            DISPLAY BY NAME g_master.l_gldn001
            NEXT FIELD l_gldn001
            #END add-point
 
 
         #Ctrlp:input.c.l_yy
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_yy
            #add-point:ON ACTION controlp INFIELD l_yy name="input.c.l_yy"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_mms
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_mms
            #add-point:ON ACTION controlp INFIELD l_mms name="input.c.l_mms"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_type
            #add-point:ON ACTION controlp INFIELD l_type name="input.c.l_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_mme
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_mme
            #add-point:ON ACTION controlp INFIELD l_mme name="input.c.l_mme"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk1
            #add-point:ON ACTION controlp INFIELD l_chk1 name="input.c.l_chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk2
            #add-point:ON ACTION controlp INFIELD l_chk2 name="input.c.l_chk2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_docno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_docno
            #add-point:ON ACTION controlp INFIELD l_docno name="input.c.l_docno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  =g_master.l_gldnld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_docno
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'aglt503'
            CALL q_ooba002_1()
            LET g_master.l_docno = g_qryparam.return1
            DISPLAY BY NAME g_master.l_docno
            NEXT FIELD l_docno
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
            CALL aglp700_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL aglp700_qbe_clear()
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
            CALL aglp700_qbe_clear()
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
         CALL aglp700_init()
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
                 CALL aglp700_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp700_transfer_argv(ls_js)
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
 
{<section id="aglp700.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp700_transfer_argv(ls_js)
 
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
 
{<section id="aglp700.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp700_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
    #161128-00061#1----modify------begin-----------
   #DEFINE l_gldn   RECORD   LIKE gldn_t.*     #UPDATE用
   DEFINE l_gldn RECORD  #合併報表個體公司會計科目餘額檔
       gldnent LIKE gldn_t.gldnent, #企業編號
       gldnld LIKE gldn_t.gldnld, #帳套
       gldn001 LIKE gldn_t.gldn001, #上層公司編號
       gldn002 LIKE gldn_t.gldn002, #上層公司帳套
       gldn003 LIKE gldn_t.gldn003, #來源資料年度
       gldn004 LIKE gldn_t.gldn004, #來源資料期別
       gldn005 LIKE gldn_t.gldn005, #合併年度
       gldn006 LIKE gldn_t.gldn006, #合併期別
       gldn007 LIKE gldn_t.gldn007, #會計科目
       gldn008 LIKE gldn_t.gldn008, #組合要素(KEY)
       gldn009 LIKE gldn_t.gldn009, #幣別(記帳幣)
       gldn010 LIKE gldn_t.gldn010, #借方金額(記帳幣)
       gldn011 LIKE gldn_t.gldn011, #貸方金額(記帳幣)
       gldn012 LIKE gldn_t.gldn012, #借方筆數
       gldn013 LIKE gldn_t.gldn013, #貸方筆數
       gldn014 LIKE gldn_t.gldn014, #營運據點
       gldn015 LIKE gldn_t.gldn015, #部門
       gldn016 LIKE gldn_t.gldn016, #利潤/成本中心
       gldn017 LIKE gldn_t.gldn017, #區域
       gldn018 LIKE gldn_t.gldn018, #收付款客商
       gldn019 LIKE gldn_t.gldn019, #帳款客商
       gldn020 LIKE gldn_t.gldn020, #客群
       gldn021 LIKE gldn_t.gldn021, #產品類別
       gldn022 LIKE gldn_t.gldn022, #人員
       gldn024 LIKE gldn_t.gldn024, #專案編號
       gldn025 LIKE gldn_t.gldn025, #WBS
       gldn026 LIKE gldn_t.gldn026, #幣別(功能幣)
       gldn027 LIKE gldn_t.gldn027, #借方金額(功能幣)
       gldn028 LIKE gldn_t.gldn028, #貸方金額(功能幣)
       gldn029 LIKE gldn_t.gldn029, #幣別(報告幣)
       gldn030 LIKE gldn_t.gldn030, #借方金額(報告幣)
       gldn031 LIKE gldn_t.gldn031, #貸方金額(報告幣)
       gldn032 LIKE gldn_t.gldn032, #原始公司編號
       gldn033 LIKE gldn_t.gldn033, #原始公司帳套
       gldn034 LIKE gldn_t.gldn034, #匯率(記帳幣)
       gldn035 LIKE gldn_t.gldn035, #匯率(功能幣)
       gldn036 LIKE gldn_t.gldn036, #匯率(報告幣)
       gldn037 LIKE gldn_t.gldn037, #經營方式
       gldn038 LIKE gldn_t.gldn038, #渠道
       gldn039 LIKE gldn_t.gldn039, #品牌
       gldn040 LIKE gldn_t.gldn040, #下層公司
       gldn041 LIKE gldn_t.gldn041, #下層公司帳套
       gldn042 LIKE gldn_t.gldn042, #下層公司累計借方金額(記帳幣)
       gldn043 LIKE gldn_t.gldn043, #下層公司累計貸方金額(記帳幣)
       gldn044 LIKE gldn_t.gldn044, #下層公司累計借方金額(功能幣)
       gldn045 LIKE gldn_t.gldn045, #下層公司累計貸方金額(功能幣)
       gldn046 LIKE gldn_t.gldn046, #下層公司累計借方金額(報告幣)
       gldn047 LIKE gldn_t.gldn047  #下層公司累計貸方金額(報告幣)
       END RECORD
   #161128-00061#1----modify------end-----------
   DEFINE l_sql         STRING                #組SQL指令
   DEFINE l_glaa131     LIKE glaa_t.glaa131   #分層合併否
   DEFINE l_glaa001     LIKE glaa_t.glaa001   #合併帳記帳幣別
   DEFINE l_glaa015     LIKE glaa_t.glaa015   #合併帳功能幣啟用否
   DEFINE l_glaa016     LIKE glaa_t.glaa016   #合併帳功能幣別
   DEFINE l_glaa019     LIKE glaa_t.glaa019   #合併帳報告幣啟用否
   DEFINE l_glaa020     LIKE glaa_t.glaa020   #合併帳報告幣別
   DEFINE l_glaa132     LIKE glaa_t.glaa132   #合併帳平均匯率邏輯
   DEFINE l_glaas       RECORD
                        glaa001     LIKE glaa_t.glaa001,  #個體帳記帳幣別
                        glaa015     LIKE glaa_t.glaa015,  #個體帳功能幣啟用否
                        glaa016     LIKE glaa_t.glaa016,  #個體帳功能幣別
                        glaa019     LIKE glaa_t.glaa019,  #個體帳報告幣啟用否
                        glaa020     LIKE glaa_t.glaa020,  #個體帳報告幣別  
                        glaa003     LIKE glaa_t.glaa003   #個體帳會計周期參照表                        
                        END RECORD
   DEFINE l_node        RECORD                #單個結點的運算用變數
                        gldcld   LIKE gldc_t.gldcld,       #合併帳別
                        gldc001  LIKE gldc_t.gldc001,      #上層公司
                        gldc002  LIKE gldc_t.gldc002,      #下層公司
                        gldc003  LIKE gldc_t.gldc003,      #下層帳別
                        gldc009  LIKE gldc_t.gldc009       #代表為最頭
                        END RECORD
   DEFINE l_glda002     LIKE glda_t.glda002   #T100公司否
   DEFINE l_gldb002     LIKE gldb_t.gldb002
   DEFINE l_gldf        RECORD
                        gldf008   LIKE gldf_t.gldf008,
                        gldf009   LIKE gldf_t.gldf009,
                        gldf010   LIKE gldf_t.gldf010
                        END RECORD
   DEFINE l_count       LIKE type_t.num10
   #161128-00061#1----modify------begin-----------
   #DEFINE l_gldn_upd    RECORD   LIKE gldn_t.*     #UPDATE用
   DEFINE l_gldn_upd RECORD  #合併報表個體公司會計科目餘額檔
       gldnent LIKE gldn_t.gldnent, #企業編號
       gldnld LIKE gldn_t.gldnld, #帳套
       gldn001 LIKE gldn_t.gldn001, #上層公司編號
       gldn002 LIKE gldn_t.gldn002, #上層公司帳套
       gldn003 LIKE gldn_t.gldn003, #來源資料年度
       gldn004 LIKE gldn_t.gldn004, #來源資料期別
       gldn005 LIKE gldn_t.gldn005, #合併年度
       gldn006 LIKE gldn_t.gldn006, #合併期別
       gldn007 LIKE gldn_t.gldn007, #會計科目
       gldn008 LIKE gldn_t.gldn008, #組合要素(KEY)
       gldn009 LIKE gldn_t.gldn009, #幣別(記帳幣)
       gldn010 LIKE gldn_t.gldn010, #借方金額(記帳幣)
       gldn011 LIKE gldn_t.gldn011, #貸方金額(記帳幣)
       gldn012 LIKE gldn_t.gldn012, #借方筆數
       gldn013 LIKE gldn_t.gldn013, #貸方筆數
       gldn014 LIKE gldn_t.gldn014, #營運據點
       gldn015 LIKE gldn_t.gldn015, #部門
       gldn016 LIKE gldn_t.gldn016, #利潤/成本中心
       gldn017 LIKE gldn_t.gldn017, #區域
       gldn018 LIKE gldn_t.gldn018, #收付款客商
       gldn019 LIKE gldn_t.gldn019, #帳款客商
       gldn020 LIKE gldn_t.gldn020, #客群
       gldn021 LIKE gldn_t.gldn021, #產品類別
       gldn022 LIKE gldn_t.gldn022, #人員
       gldn024 LIKE gldn_t.gldn024, #專案編號
       gldn025 LIKE gldn_t.gldn025, #WBS
       gldn026 LIKE gldn_t.gldn026, #幣別(功能幣)
       gldn027 LIKE gldn_t.gldn027, #借方金額(功能幣)
       gldn028 LIKE gldn_t.gldn028, #貸方金額(功能幣)
       gldn029 LIKE gldn_t.gldn029, #幣別(報告幣)
       gldn030 LIKE gldn_t.gldn030, #借方金額(報告幣)
       gldn031 LIKE gldn_t.gldn031, #貸方金額(報告幣)
       gldn032 LIKE gldn_t.gldn032, #原始公司編號
       gldn033 LIKE gldn_t.gldn033, #原始公司帳套
       gldn034 LIKE gldn_t.gldn034, #匯率(記帳幣)
       gldn035 LIKE gldn_t.gldn035, #匯率(功能幣)
       gldn036 LIKE gldn_t.gldn036, #匯率(報告幣)
       gldn037 LIKE gldn_t.gldn037, #經營方式
       gldn038 LIKE gldn_t.gldn038, #渠道
       gldn039 LIKE gldn_t.gldn039, #品牌
       gldn040 LIKE gldn_t.gldn040, #下層公司
       gldn041 LIKE gldn_t.gldn041, #下層公司帳套
       gldn042 LIKE gldn_t.gldn042, #下層公司累計借方金額(記帳幣)
       gldn043 LIKE gldn_t.gldn043, #下層公司累計貸方金額(記帳幣)
       gldn044 LIKE gldn_t.gldn044, #下層公司累計借方金額(功能幣)
       gldn045 LIKE gldn_t.gldn045, #下層公司累計貸方金額(功能幣)
       gldn046 LIKE gldn_t.gldn046, #下層公司累計借方金額(報告幣)
       gldn047 LIKE gldn_t.gldn047  #下層公司累計貸方金額(報告幣)
       END RECORD
   #161128-00061#1----modify------end-----------
   DEFINE l_root        LIKE type_t.num10        
   DEFINE l_gldn007p    LIKE gldn_t.gldn007        #轉換前科目   
   DEFINE l_gldn010     LIKE gldn_t.gldn010        #借方金額暫存
   DEFINE l_gldn011     LIKE gldn_t.gldn011        #貸方金額暫存
   DEFINE l_gldn027     LIKE gldn_t.gldn028        #借方金額暫存
   DEFINE l_gldn028     LIKE gldn_t.gldn029        #貸方金額暫存
   DEFINE l_gldn030     LIKE gldn_t.gldn031        #借方金額暫存
   DEFINE l_gldn031     LIKE gldn_t.gldn032        #貸方金額暫存
   DEFINE l_gldn0102    LIKE gldn_t.gldn010        #借方金額暫存2
   DEFINE l_gldn0112    LIKE gldn_t.gldn011        #貸方金額暫存2
   DEFINE l_gldn0272    LIKE gldn_t.gldn028        #借方金額暫存2
   DEFINE l_gldn0282    LIKE gldn_t.gldn029        #貸方金額暫存2
   DEFINE l_gldn0302    LIKE gldn_t.gldn031        #借方金額暫存2
   DEFINE l_gldn0312    LIKE gldn_t.gldn032        #貸方金額暫存2
   DEFINE l_gldn010h    LIKE gldn_t.gldn010        #借方金額暫存(歷史金額)
   DEFINE l_gldn011h    LIKE gldn_t.gldn011        #貸方金額暫存(歷史金額)
   DEFINE l_gldn027h    LIKE gldn_t.gldn028        #借方金額暫存(歷史金額)
   DEFINE l_gldn028h    LIKE gldn_t.gldn029        #貸方金額暫存(歷史金額)
   DEFINE l_gldn030h    LIKE gldn_t.gldn031        #借方金額暫存(歷史金額)
   DEFINE l_gldn031h    LIKE gldn_t.gldn032        #貸方金額暫存(歷史金額)
   DEFINE l_gldn010ad   LIKE gldn_t.gldn010        #借方金額暫存(調整傳票)
   DEFINE l_gldn011ad   LIKE gldn_t.gldn011        #貸方金額暫存(調整傳票)
   DEFINE l_gldn027ad   LIKE gldn_t.gldn028        #借方金額暫存(調整傳票)
   DEFINE l_gldn028ad   LIKE gldn_t.gldn029        #貸方金額暫存(調整傳票)
   DEFINE l_gldn030ad   LIKE gldn_t.gldn031        #借方金額暫存(調整傳票)
   DEFINE l_gldn031ad   LIKE gldn_t.gldn032        #貸方金額暫存(調整傳票)
   DEFINE l_gldn010ce   LIKE gldn_t.gldn010        #借方金額暫存(帳結法CE傳票)
   DEFINE l_gldn011ce   LIKE gldn_t.gldn011        #貸方金額暫存(帳結法CE傳票)
   DEFINE l_gldn027ce   LIKE gldn_t.gldn028        #借方金額暫存(帳結法CE傳票)
   DEFINE l_gldn028ce   LIKE gldn_t.gldn029        #貸方金額暫存(帳結法CE傳票)
   DEFINE l_gldn030ce   LIKE gldn_t.gldn031        #借方金額暫存(帳結法CE傳票)
   DEFINE l_gldn031ce   LIKE gldn_t.gldn032        #貸方金額暫存(帳結法CE傳票)
   DEFINE l_gldn010l    LIKE gldn_t.gldn010        #借方金額暫存(累計額時)
   DEFINE l_gldn011l    LIKE gldn_t.gldn011        #貸方金額暫存(累計額時)
   DEFINE l_gldn027l    LIKE gldn_t.gldn028        #借方金額暫存(累計額時)
   DEFINE l_gldn028l    LIKE gldn_t.gldn029        #貸方金額暫存(累計額時)
   DEFINE l_gldn030l    LIKE gldn_t.gldn031        #借方金額暫存(累計額時)
   DEFINE l_gldn031l    LIKE gldn_t.gldn032        #貸方金額暫存(累計額時)
   DEFINE l_gldn010is    LIKE gldn_t.gldn010        #借方金額暫存(IS)
   DEFINE l_gldn011is    LIKE gldn_t.gldn011        #貸方金額暫存(IS)
   DEFINE l_gldn027is    LIKE gldn_t.gldn028        #借方金額暫存(IS)
   DEFINE l_gldn028is    LIKE gldn_t.gldn029        #貸方金額暫存(IS)
   DEFINE l_gldn030is    LIKE gldn_t.gldn031        #借方金額暫存(IS)
   DEFINE l_gldn031is    LIKE gldn_t.gldn032        #貸方金額暫存(IS)
   DEFINE l_sums        RECORD                     #總帳累積額
                        gldn010    LIKE gldn_t.gldn010,    
                        gldn011    LIKE gldn_t.gldn011,   
                        gldn027    LIKE gldn_t.gldn028,    
                        gldn028    LIKE gldn_t.gldn029,    
                        gldn030    LIKE gldn_t.gldn031,    
                        gldn031    LIKE gldn_t.gldn032     
                        END RECORD
   DEFINE l_sumt        RECORD                     #乘以匯率的累積額
                        gldn010    LIKE gldn_t.gldn010,    
                        gldn011    LIKE gldn_t.gldn011,   
                        gldn027    LIKE gldn_t.gldn028,    
                        gldn028    LIKE gldn_t.gldn029,    
                        gldn030    LIKE gldn_t.gldn031,    
                        gldn031    LIKE gldn_t.gldn032     
                        END RECORD
   DEFINE l_glaa133     LIKE glaa_t.glaa133        #非T100用     2.累計額時   
   DEFINE l_glaa006     LIKE glaa_t.glaa006        #1表結法      2.帳結法
   DEFINE l_strdat      LIKE type_t.dat
   DEFINE l_enddat      LIKE type_t.dat

   DEFINE l_item   RECORD 
                gldn007    LIKE gldn_t.gldn007,    #科目
                gldn014    LIKE gldn_t.gldn014,    #固定核算項
                gldn015    LIKE gldn_t.gldn015,
                gldn016    LIKE gldn_t.gldn016,
                gldn017    LIKE gldn_t.gldn017,
                gldn018    LIKE gldn_t.gldn018,
                gldn019    LIKE gldn_t.gldn019,
                gldn020    LIKE gldn_t.gldn020,
                gldn021    LIKE gldn_t.gldn021,
                gldn022    LIKE gldn_t.gldn022,
                gldn024    LIKE gldn_t.gldn024,
                gldn025    LIKE gldn_t.gldn025,
                gldn037    LIKE gldn_t.gldn037,
                gldn038    LIKE gldn_t.gldn038,
                gldn039    LIKE gldn_t.gldn039,
                key        LIKE gldn_t.gldn008     #複合KEY(有才會有值)
                END RECORD
   DEFINE l_yy  LIKE type_t.num5        #回朔時批次正在執行的年度
   DEFINE l_mm  LIKE type_t.num5        #回朔時批次正在執行的期別
   DEFINE l_gldn007is LIKE gldn_t.gldn007   #合併帳本期損益IS科目
   DEFINE l_gldn007ex LIKE gldn_t.gldn007   #合併帳換算調整科目
   DEFINE l_gldn007bs LIKE gldn_t.gldn007   #合併帳本期損益BS科目
   #161128-00061#1----modify------begin-----------
   #DEFINE l_gldp     RECORD LIKE gldp_t.*
   #DEFINE l_gldq     RECORD LIKE gldq_t.*
    DEFINE l_gldp RECORD  #調整與銷除傳票單頭檔
       gldpent LIKE gldp_t.gldpent, #企業編號
       gldpownid LIKE gldp_t.gldpownid, #資料所有者
       gldpowndp LIKE gldp_t.gldpowndp, #資料所屬部門
       gldpcrtid LIKE gldp_t.gldpcrtid, #資料建立者
       gldpcrtdp LIKE gldp_t.gldpcrtdp, #資料建立部門
       gldpcrtdt LIKE gldp_t.gldpcrtdt, #資料創建日
       gldpmodid LIKE gldp_t.gldpmodid, #資料修改者
       gldpmoddt LIKE gldp_t.gldpmoddt, #最近修改日
       gldpcnfid LIKE gldp_t.gldpcnfid, #資料確認者
       gldpcnfdt LIKE gldp_t.gldpcnfdt, #資料確認日
       gldppstid LIKE gldp_t.gldppstid, #資料過帳者
       gldppstdt LIKE gldp_t.gldppstdt, #資料過帳日
       gldpstus LIKE gldp_t.gldpstus, #狀態碼
       gldpdocno LIKE gldp_t.gldpdocno, #傳票編號
       gldpdocdt LIKE gldp_t.gldpdocdt, #單據日期
       gldpld LIKE gldp_t.gldpld, #合併帳套
       gldp001 LIKE gldp_t.gldp001, #上層公司/個體公司
       gldp002 LIKE gldp_t.gldp002, #帳套
       gldp003 LIKE gldp_t.gldp003, #會計年度
       gldp004 LIKE gldp_t.gldp004, #會計期別
       gldp005 LIKE gldp_t.gldp005, #來源碼
       gldp006 LIKE gldp_t.gldp006, #調整/沖銷類型
       gldp007 LIKE gldp_t.gldp007, #換匯差額調整否
       gldp008 LIKE gldp_t.gldp008, #幣別(記帳幣)
       gldp009 LIKE gldp_t.gldp009, #借方金額合計(記帳幣)
       gldp010 LIKE gldp_t.gldp010, #貸方金額合計(記帳幣)
       gldp011 LIKE gldp_t.gldp011, #幣別(功能幣)
       gldp012 LIKE gldp_t.gldp012, #借方金額合計(功能幣)
       gldp013 LIKE gldp_t.gldp013, #貸方金額合計(功能幣)
       gldp014 LIKE gldp_t.gldp014, #幣別(報告幣)
       gldp015 LIKE gldp_t.gldp015, #借方金額合計(報告幣)
       gldp016 LIKE gldp_t.gldp016  #貸方金額合計(報告幣)
       END RECORD
   DEFINE l_gldq RECORD  #調整與銷除傳票單身檔
       gldqent LIKE gldq_t.gldqent, #企業編號
       gldqdocno LIKE gldq_t.gldqdocno, #傳票編號
       gldqseq LIKE gldq_t.gldqseq, #項次
       gldq001 LIKE gldq_t.gldq001, #科目編號
       gldq003 LIKE gldq_t.gldq003, #營運據點
       gldq004 LIKE gldq_t.gldq004, #部門
       gldq005 LIKE gldq_t.gldq005, #利潤/成本中心
       gldq006 LIKE gldq_t.gldq006, #區域
       gldq007 LIKE gldq_t.gldq007, #收付款客商
       gldq008 LIKE gldq_t.gldq008, #帳款客商
       gldq009 LIKE gldq_t.gldq009, #客群
       gldq010 LIKE gldq_t.gldq010, #產品類別
       gldq011 LIKE gldq_t.gldq011, #經營方式
       gldq012 LIKE gldq_t.gldq012, #渠道
       gldq013 LIKE gldq_t.gldq013, #品牌
       gldq014 LIKE gldq_t.gldq014, #人員
       gldq015 LIKE gldq_t.gldq015, #專案編號
       gldq016 LIKE gldq_t.gldq016, #WBS
       gldq017 LIKE gldq_t.gldq017, #借方金額(記帳幣)
       gldq018 LIKE gldq_t.gldq018, #貸方金額(記帳幣)
       gldq019 LIKE gldq_t.gldq019, #借方金額(功能幣)
       gldq020 LIKE gldq_t.gldq020, #貸方金額(功能幣)
       gldq021 LIKE gldq_t.gldq021, #借方金額(報告幣)
       gldq022 LIKE gldq_t.gldq022, #貸方金額(報告幣)
       gldq023 LIKE gldq_t.gldq023  #摘要
       END RECORD

   #161128-00061#1----modify------end-----------
   
   DEFINE l_gldpdocno LIKE gldp_t.gldpdocno #傳票編號
   
   
   #albireo 151218-----s
   DEFINE l_success    LIKE type_t.num5
   #albireo 151218-----e
   
   #albireo 151221 151113-00002#20-----s
   DEFINE l_examtin         RECORD
               up_ld          LIKE gldt_t.gldtld,       #合併帳別(合併主體)
               up_comp        LIKE gldt_t.gldt001,      #上層公司
               dn_ld          LIKE gldt_t.gldtld,       #下層帳別
               dn_comp        LIKE gldt_t.gldt001,      #下層公司
               yy             LIKE gldt_t.gldt005,      #年度
               mm             LIKE gldt_t.gldt006,      #期別
               acc            LIKE gldt_t.gldt007,      #科目
               tabname        LIKE type_t.chr80,        #餘額來源table
               curr1          LIKE gldt_t.gldt009,      #幣別(記帳幣)         
               curr2          LIKE gldt_t.gldt009,      #幣別(功能幣)         
               curr3          LIKE gldt_t.gldt009,      #幣別(報告幣)         
               amt1           LIKE gldt_t.gldt010,      #借方換匯前金額(記帳幣)
               amt1_2         LIKE gldt_t.gldt010,      #貸方換匯前金額(記帳幣)
               amt2           LIKE gldt_t.gldt010,      #借方換匯前金額(功能幣)
               amt2_2         LIKE gldt_t.gldt010,      #貸方換匯前金額(功能幣)
               amt3           LIKE gldt_t.gldt010,      #借方換匯前金額(報告幣)
               amt3_2         LIKE gldt_t.gldt010,      #貸方換匯前金額(報告幣)
               type1          LIKE type_t.chr1,         #記帳幣換算類別
               type2          LIKE type_t.chr1,         #功能幣換算類別
               type3          LIKE type_t.chr1,         #報告幣換算類別
               source         LIKE type_t.chr1,          #來源A/對沖B               
               acc2           LIKE gldt_t.gldt007,      #albireo 160309
               act1           LIKE type_t.chr100,       #albireo 160309
               edat           LIKE type_t.dat           #albireo 160311
                    END RECORD
                   
   DEFINE ls_jsin   STRING
   DEFINE ls_jsout  STRING
   DEFINE l_examtout   RECORD
              r_amt1         LIKE gldt_t.gldt010,      #借方換匯後金額(記帳幣)         
              r_amt1_2       LIKE gldt_t.gldt010,      #貸方換匯後金額(記帳幣)     
              r_amt2         LIKE gldt_t.gldt010,      #借方換匯後金額(功能幣)         
              r_amt2_2       LIKE gldt_t.gldt010,      #貸方換匯後金額(功能幣)   
              r_amt3         LIKE gldt_t.gldt010,      #借方換匯後金額(報告幣)         
              r_amt3_2       LIKE gldt_t.gldt010,      #貸方換匯後金額(報告幣)              
              r_rate1        LIKE gldt_t.gldt033,      #匯率(記帳幣)   #albireo 160225
              r_rate2        LIKE gldt_t.gldt033,      #匯率(功能幣)   #albireo 160225
              r_rate3        LIKE gldt_t.gldt033       #匯率(報告幣)   #albireo 160225
                       END RECORD
   DEFINE l_gldn010_o        LIKE gldn_t.gldn010       #借方金額換匯前
   DEFINE l_gldn011_o        LIKE gldn_t.gldn011       #貸方金額換匯前
   DEFINE l_gldn027_o        LIKE gldn_t.gldn028       #借方金額換匯前
   DEFINE l_gldn028_o        LIKE gldn_t.gldn029       #貸方金額換匯前
   DEFINE l_gldn030_o        LIKE gldn_t.gldn031       #借方金額換匯前
   DEFINE l_gldn031_o        LIKE gldn_t.gldn032       #貸方金額換匯前  
   #albireo 151221 151113-00002-----e
   
   #albireo 160303-----s
   #借貸筆數
   DEFINE l_countd           LIKE type_t.num10
   DEFINE l_countc           LIKE type_t.num10
   DEFINE l_sumcountd        LIKE type_t.num10
   DEFINE l_sumcountc        LIKE type_t.num10
   #albireo 160303-----e
   DEFINE l_glaa134     LIKE glaa_t.glaa134   #albireo 160309
   DEFINE l_glaa003     LIKE glaa_t.glaa003   #會計周期參照表   #albireo 160311
   DEFINE l_argv      LIKE gldt_t.gldt006   #編制合併期別抓取條件
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
#  DECLARE aglp700_process_cs CURSOR FROM ls_sql
#  FOREACH aglp700_process_cs INTO
   #add-point:process段process name="process.process"
   #albireo 160311-----s
   #加入新的期間運算方式
   LET l_glaa003 = NULL
   SELECT glaa003 INTO l_glaa003 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master.l_gldnld
   
   #依編制合併期別抓取條件
   LET l_argv = ''
   CASE g_master.l_type
      WHEN 0
         LET l_argv = g_master.l_mme
      WHEN 1
         LET l_argv = g_master.l_chk1
      WHEN 2
         LET l_argv = g_master.l_chk2
   END CASE
   CALL s_merge_get_glav006(l_glaa003,g_master.l_yy,g_master.l_type,l_argv) RETURNING g_sub_success,g_errno,g_master.l_mme
   #albireo 160311-----e
  
  
  #-----declare prepare-----s
   #gldn資料抓取
   #161128-00061#1----modify------begin-----------
   #LET l_sql = "SELECT * FROM gldn_t ",
   LET l_sql = "SELECT gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,",
               "gldn009,gldn010,gldn011,gldn012,gldn013,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,",
               "gldn020,gldn021,gldn022,gldn024,gldn025,gldn026,gldn027,gldn028,gldn029,gldn030,gldn031,",
               "gldn032,gldn033,gldn034,gldn035,gldn036,gldn037,gldn038,gldn039,gldn040,gldn041,gldn042,",
               "gldn043,gldn044,gldn045,gldn046,gldn047 FROM gldn_t ",
   #161128-00061#1----modify------end-----------
               " WHERE gldnent = ",g_enterprise," ",
               "   AND gldnld = ? ",
               "   AND gldn001 = ? ",
               "   AND gldn005 = ? ",
               "   AND gldn006 = ? "
   PREPARE sel_gldnp1 FROM l_sql
   DECLARE sel_gldnc1 CURSOR FOR sel_gldnp1  

   #aglt501資料抓取
   LET l_sql = " SELECT DISTINCT gldh003,gldh008,gldh009,gldh010,gldh011,",
               "                 gldh012,gldh013,gldh014,gldh015,gldh019,",
               "                 gldh020,gldh021,gldh016,gldh017,gldh018,gldh007 ",
               "   FROM gldh_t,glfg_t           ",
               "  WHERE glfgent = ",g_enterprise,"  ",
               "    AND glfgent = gldhent       ",
               "    AND glfg001 = gldh001       ",
               "    AND glfg002 = gldh002       ",
               "    AND glfg005 = gldh005       ",
               "    AND glfg006 = gldh006       ",
               "    AND glfg005 = ?             ",
               "    AND glfg006 BETWEEN ? AND ? ",
               "    AND glfg001 = ?             ",
               "    AND glfg002 = ?             ",
               "    AND glfgstus = 'Y'          "   
   PREPARE sel_gldhp1n FROM l_sql
   DECLARE sel_gldhc1n CURSOR FOR sel_gldhp1n

   #aglt501資料抓取   (此科目+核算項,所有的年度期別)
   LET l_sql = " SELECT DISTINCT glfg005,glfg006",
               "   FROM gldh_t,glfg_t           ",
               "  WHERE glfgent = ",g_enterprise,"  ",
               "    AND glfgent = gldhent       ",
               "    AND glfg001 = gldh001       ",
               "    AND glfg002 = gldh002       ",
               "    AND glfg005 = gldh005       ",
               "    AND glfg006 = gldh006       ",
               "    AND glfg005 = ?             ",
               "    AND glfg006  BETWEEN ? AND ? ",
               "    AND glfg001 = ?             ",
               "    AND glfg002 = ?             ",
               "    AND gldh003 = ? ",
               "    AND gldh007 = ? ",    #有組合KEY用組合KEY
               "    AND glfgstus = 'Y'          ",
               " ORDER BY glfg005, glfg006"
   PREPARE sel_gldhp2n FROM l_sql
   DECLARE sel_gldhc2n CURSOR FOR sel_gldhp2n 

   # aglt501資料抓取 取此個體帳+ 科目+核算項 + 此年月 gldh 值
   LET l_sql = " SELECT SUM(gldh025),SUM(gldh026),SUM(gldh028),",
               "        SUM(gldh029),SUM(gldh031),SUM(gldh032) ",
               "   FROM gldh_t,glfg_t ",
               "  WHERE gldhent = ",g_enterprise," ",
               "    AND glfgent = gldhent       ",
               "    AND glfg001 = gldh001       ",
               "    AND glfg002 = gldh002       ",
               "    AND glfg005 = gldh005       ",
               "    AND glfg006 = gldh006       ",
               "    AND glfg005 = ?             ",
               "    AND glfg006 = ? ",
               "    AND glfg001 = ?             ",
               "    AND glfg002 = ?             ",
               "    AND gldh003 = ? ",
               "    AND gldh007 = ? ",
               "    AND glfgstus = 'Y'          " 
   PREPARE sel_gldhp3n FROM l_sql
   
   #albireo 160303-----s
   LET l_sql = " SELECT COUNT(*) ,",
               "   FROM gldh_t,glfg_t ",
               "  WHERE gldhent = ",g_enterprise," ",
               "    AND glfgent = gldhent       ",
               "    AND glfg001 = gldh001       ",
               "    AND glfg002 = gldh002       ",
               "    AND glfg005 = gldh005       ",
               "    AND glfg006 = gldh006       ",
               "    AND glfg005 = ?             ",
               "    AND glfg006 = ? ",
               "    AND glfg001 = ?             ",
               "    AND glfg002 = ?             ",
               "    AND gldh003 = ? ",
               "    AND gldh007 = ? ",
               "    AND gldh025 > 0 ",
               "    AND glfgstus = 'Y'          " 
   PREPARE sel_gldhp4d FROM l_sql
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM gldh_t,glfg_t ",
               "  WHERE gldhent = ",g_enterprise," ",
               "    AND glfgent = gldhent       ",
               "    AND glfg001 = gldh001       ",
               "    AND glfg002 = gldh002       ",
               "    AND glfg005 = gldh005       ",
               "    AND glfg006 = gldh006       ",
               "    AND glfg005 = ?             ",
               "    AND glfg006 = ? ",
               "    AND glfg001 = ?             ",
               "    AND glfg002 = ?             ",
               "    AND gldh003 = ? ",
               "    AND gldh007 = ? ",
               "    AND gldh026 > 0 ",
               "    AND glfgstus = 'Y'          " 
   PREPARE sel_gldhp4c FROM l_sql
   #albireo 160303-----e

   #判斷是否要UPDATE
   LET l_sql = " SELECT COUNT(*) FROM gldn_t ",
               "  WHERE gldnent = ? ",
               "    AND gldnld  = ? ",
               "    AND gldn001 = ? ",
               "    AND gldn002 = ? ",
               "    AND gldn003 = ? ",
               "    AND gldn004 = ? ",
               "    AND gldn005 = ? ",
               "    AND gldn006 = ? ",
               "    AND gldn007 = ? ",
               "    AND gldn008 = ? ",
               "    AND gldn032 = ? ",
               "    AND gldn033 = ? ",
               "    AND gldn040 = ? ",
               "    AND gldn041 = ? "
   PREPARE sel_gldncntp1 FROM l_sql      

   #抓取舊資料
      #161128-00061#1----modify------begin-----------
   #LET l_sql = "SELECT * FROM gldn_t ",
   LET l_sql = "SELECT gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,",
               "gldn009,gldn010,gldn011,gldn012,gldn013,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,",
               "gldn020,gldn021,gldn022,gldn024,gldn025,gldn026,gldn027,gldn028,gldn029,gldn030,gldn031,",
               "gldn032,gldn033,gldn034,gldn035,gldn036,gldn037,gldn038,gldn039,gldn040,gldn041,gldn042,",
               "gldn043,gldn044,gldn045,gldn046,gldn047 FROM gldn_t ",
   #161128-00061#1----modify------end-----------
               "  WHERE gldnent = ? ",
               "    AND gldnld  = ? ",
               "    AND gldn001 = ? ",
               "    AND gldn002 = ? ",
               "    AND gldn003 = ? ",
               "    AND gldn004 = ? ",
               "    AND gldn005 = ? ",
               "    AND gldn006 = ? ",
               "    AND gldn007 = ? ",
               "    AND gldn008 = ? ",
               "    AND gldn032 = ? ",
               "    AND gldn033 = ? ",
               "    AND gldn040 = ? ",
               "    AND gldn041 = ? "
   PREPARE sel_gldnp2 FROM l_sql 
   
   #抓累計額時的aglt501資料
   LET l_sql = " SELECT gldh025,gldh026,gldh028,gldh029,",
               "        gldh031,gldh032         ",
               "   FROM gldh_t,glfg_t           ",
               "  WHERE glfgent = ",g_enterprise,"  ",
               "    AND glfgent = gldhent       ",
               "    AND glfg001 = gldh001       ",
               "    AND glfg002 = gldh002       ",
               "    AND glfg005 = gldh005       ",
               "    AND glfg006 = gldh006       ",
               "    AND (glfg005*12+glfg006) = (",
                   "  SELECT MAX(glfg005*12+glfg006) FROM gldh_t,glfg_t ",
                   "  WHERE glfgent = ",g_enterprise,"  ",
                   "    AND glfgent = gldhent       ",
                   "    AND glfg001 = gldh001       ",
                   "    AND glfg002 = gldh002       ",
                   "    AND glfg005 = gldh005       ",
                   "    AND glfg006 = gldh006       ",
                   "    AND glfg005 = ? ",
                   "    AND glfg006 < ? ",
                   "    AND glfg001 = ?             ",
                   "    AND glfg002 = ?             ",
                   "    AND gldh003 = ? ",
                   "    AND gldh007 = ? ",
                   "    AND glfgstus = 'Y'          ",                   
               ") ",
               "    AND glfg001 = ?             ",
               "    AND glfg002 = ?             ",
               "    AND gldh003 = ? ",
               "    AND gldh007 = ? ",
               "    AND glfgstus = 'Y'          "  
   PREPARE sel_gldhp2 FROM l_sql
   
   #抓取上傳檔資料
   #FOREACH gleb 個體帳 (0~N月) 取 科目+核算項
   LET l_sql = " SELECT DISTINCT gleb005,gleb012,gleb013,gleb014,",
               "        gleb015,gleb016,gleb017,gleb018,",
               "        gleb019,gleb023,gleb024,gleb025,",
               "        gleb020,gleb021,gleb022,gleb006 ",
               "   FROM gleb_t                           ",
               "  WHERE glebent = ",g_enterprise,"       ",
               "    AND gleb003 = ?                      ",
               "    AND gleb004 BETWEEN ? AND ?          ",
               "    AND gleb001 = ?                      ",
               "    AND glebld  = ?                      "  
   PREPARE sel_glebp1n FROM l_sql
   DECLARE sel_glebc1n CURSOR FOR sel_glebp1n
   
   #FOREACH 個體帳+ 科目+核算項  取   年 月
   LET l_sql = " SELECT DISTINCT gleb003,gleb004 ",
               "   FROM gleb_t                           ",
               "  WHERE glebent = ",g_enterprise,"       ",
               "    AND gleb003 = ?                      ",
               "    AND gleb004 BETWEEN ? AND ?          ",
               "    AND gleb001 = ?                      ",
               "    AND glebld  = ?                      ",
               "    AND gleb005 = ? ",
               "    AND gleb006 = ? "
   PREPARE sel_glebp2n FROM l_sql
   DECLARE sel_glebc2n CURSOR FOR sel_glebp2n


   #取此個體帳+ 科目+核算項 + 此年月 gldh 值
   LET l_sql = " SELECT SUM(gleb008),SUM(gleb009),SUM(gleb027), ",
               "        SUM(gleb028),SUM(gleb030),SUM(gleb031) ",
               "   FROM gleb_t                           ",
               "  WHERE glebent = ",g_enterprise,"       ",
               "    AND gleb003 = ?                      ",
               "    AND gleb004 = ?          ",
               "    AND gleb001 = ?                      ",
               "    AND glebld  = ?                      ",
               "    AND gleb005 = ? ",
               "    AND gleb006 = ? "
   PREPARE sel_glebp3n FROM l_sql
   
   #albireo 160303-----s
   LET l_sql = " SELECT COUNT(*) , ",
               "   FROM gleb_t                           ",
               "  WHERE glebent = ",g_enterprise,"       ",
               "    AND gleb003 = ?                      ",
               "    AND gleb004 = ?          ",
               "    AND gleb001 = ?                      ",
               "    AND glebld  = ?                      ",
               "    AND gleb005 = ? ",
               "    AND gleb006 = ? ",
               "    AND gleb008 > 0 "
   PREPARE sel_glebp4d FROM l_sql 

   LET l_sql = " SELECT COUNT(*) , ",
               "   FROM gleb_t                           ",
               "  WHERE glebent = ",g_enterprise,"       ",
               "    AND gleb003 = ?                      ",
               "    AND gleb004 = ?          ",
               "    AND gleb001 = ?                      ",
               "    AND glebld  = ?                      ",
               "    AND gleb005 = ? ",
               "    AND gleb006 = ? ",
               "    AND gleb009 > 0 "
   PREPARE sel_glebp4c FROM l_sql 
   #albireo 160303-----e

   #抓agli511   #用合併科目抓匯率取用方式
   LET l_sql = "SELECT gldf008,gldf009,gldf010 FROM gldf_t ",
               " WHERE gldfent = ",g_enterprise," ",
               "   AND gldf001 = ? ",
               "   AND gldf002 = ? ",
               "   AND gldf003 = ? ",
               "   AND gldf004 = ? ",
               "   AND gldf007 = ? "
   PREPARE sel_gldfp2 FROM l_sql           
   DECLARE sel_gldfc2 CURSOR FOR sel_gldfp2
   

   #(FOREACH)             抓glar   總帳餘額檔 
   LET l_sql = " SELECT DISTINCT glar001,glar012,glar013,glar014,glar015, ",
               "        glar016,glar017,glar018,glar019,glar020,",
               #"        glar022,glar023,glar051,glar052,glar053,glar004 ",     #170119-00046#1 mark
               "        glar022,glar023,glar051,glar052,glar053  ",             #170119-00046#1
               "   FROM glar_t ",
               "  WHERE glarent = ",g_enterprise," ",
               #albireo 160223-----151113-00002#29 s
               "    AND glar001 IN (",
               "                     SELECT glac002 FROM glac_t,glaa_t ",
               "                      WHERE glacent = glaaent ",
               "                        AND glac001 = glaa004 ",
               "                        AND glacent = glarent ",
               "                        AND glac002 = glar001 ",
               "                        AND glaald = glarld ",
               "                        AND glac003 <> '1' ",
               "                   )",
               #albireo 160223-----151113-00002#29 e
               "    AND glar002 = ? ",
               "    AND glar003 BETWEEN ? AND ? ",
               "    AND glarld  = ? "
   PREPARE sel_glarp1n FROM l_sql           
   DECLARE sel_glarc1n CURSOR FOR sel_glarp1n

   #FOREACH 個體帳+ 科目+核算項  取   年 月
   LET l_sql = " SELECT DISTINCT glar002,glar003 ",
               "   FROM glar_t ",
               "  WHERE glarent = ",g_enterprise," ",
               "    AND glar002 = ? ",
               "    AND glar003 BETWEEN ? AND ? ",
               "    AND glarld  = ? ",
               "    AND glar001 = ? ",
               #"    AND glar004 = ? "    #170119-00046#1 mark
               #170119-00046#1-----s
               "    AND (COALESCE(glar012,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar013,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar014,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar015,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar016,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar017,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar018,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar019,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar020,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar022,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar023,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar051,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar052,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar053,' ') = COALESCE(?,' ') ) "
               #170119-00046#1-----e
   PREPARE sel_glarp2n FROM l_sql           
   DECLARE sel_glarc2n CURSOR FOR sel_glarp2n

 #   取此個體帳+ 科目+核算項 + 此年月 glar 值
   LET l_sql = " SELECT SUM(glar005),SUM(glar006),SUM(glar034), ",
               "        SUM(glar035),SUM(glar036),SUM(glar037), ",
               "        SUM(glar007),SUM(glar008) ",   #albireo 160303
               "   FROM glar_t ",
               "  WHERE glarent = ",g_enterprise," ",
               "    AND glar002 = ? ",
               "    AND glar003 = ? ",
               "    AND glarld  = ? ",
               "    AND glar001 = ? ",
               #"    AND glar004 = ? "   #170119-00046#1 mark
               #170119-00046#1-----s
               "    AND (COALESCE(glar012,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar013,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar014,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar015,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar016,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar017,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar018,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar019,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar020,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar022,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar023,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar051,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar052,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(glar053,' ') = COALESCE(?,' ') ) "
               #170119-00046#1-----e
   PREPARE sel_glarp3n FROM l_sql           
   
   
   #FOREACH gleb 個體帳 (0~N月) 取 科目+核算項
   #存在aglt502資料但不存在glar的
   LET l_sql = "   SELECT DISTINCT gldq001, gldq003,gldq004,gldq005, ",
               "                   gldq006,gldq007,gldq008,gldq009, ",
               "                   gldq010,gldq014,gldq015,gldq016, ",
               "                   gldq011,gldq012,gldq013,'' ",
               "     FROM gldq_t,gldp_t ",
               "    WHERE gldqent = gldpent ",
               "      AND gldqdocno = gldpdocno ",
               "      AND gldpent = ",g_enterprise," ",
               "      AND gldpstus = 'Y' ",
               "      AND gldp003  = ? ",
               "      AND gldp004  BETWEEN ? AND ? ",
               "      AND gldp001  = ? " ,
               "      AND gldp002  = ? ",
               "      AND gldp005 = '1' ",
               "      AND gldp006 = 'M' ",
               " AND NOT EXISTS( SELECT 1 FROM glar_t ",
               "  WHERE glar001 = gldq001 ",
               "    AND glarent = gldqent ",
               "    AND glar002 = gldp003 ",
               "    AND glar003 = gldp004 ",
               "    AND glarld  = gldp002 ",
               "    AND (COALESCE(glar012,' ') = COALESCE(gldq003,' ') ) ",
               "    AND (COALESCE(glar013,' ') = COALESCE(gldq004,' ') ) ",
               "    AND (COALESCE(glar014,' ') = COALESCE(gldq005,' ') ) ",
               "    AND (COALESCE(glar015,' ') = COALESCE(gldq006,' ') ) ",
               "    AND (COALESCE(glar016,' ') = COALESCE(gldq007,' ') ) ",
               "    AND (COALESCE(glar017,' ') = COALESCE(gldq008,' ') ) ",
               "    AND (COALESCE(glar018,' ') = COALESCE(gldq009,' ') ) ",
               "    AND (COALESCE(glar019,' ') = COALESCE(gldq010,' ') ) ",
               "    AND (COALESCE(glar020,' ') = COALESCE(gldq014,' ') ) ",
               "    AND (COALESCE(glar022,' ') = COALESCE(gldq015,' ') ) ",
               "    AND (COALESCE(glar023,' ') = COALESCE(gldq016,' ') ) ",
               "    AND (COALESCE(glar051,' ') = COALESCE(gldq011,' ') ) ",
               "    AND (COALESCE(glar052,' ') = COALESCE(gldq012,' ') ) ",
               "    AND (COALESCE(glar053,' ') = COALESCE(gldq013,' ') ) ",
               "               )"
   PREPARE sel_gldqp1n FROM l_sql
   DECLARE sel_gldqc1n CURSOR FOR sel_gldqp1n

   #FOREACH 個體帳+ 科目+核算項  取   年 月
   LET l_sql = "   SELECT DISTINCT gldp003,gldp004 ",
        "     FROM gldq_t,gldp_t ",
        "    WHERE gldqent = gldpent ",
        "      AND gldqdocno = gldpdocno ",
        "      AND gldpent = ",g_enterprise," ",
        "      AND gldpstus = 'Y' ",
        "      AND gldp003  = ? ",
        "      AND gldp004  BETWEEN ? AND ? ",
        "      AND gldp001  = ? " ,
        "      AND gldp002  = ? ",
        "      AND gldp005 = '1' ",
        "      AND gldp006 = 'M' ",
        "      AND gldq001 = ? ",
        "    AND (COALESCE(gldq003,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq004,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq005,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq006,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq007,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq008,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq009,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq010,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq014,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq015,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq016,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq011,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq012,' ') = COALESCE(?,' ') ) ",
        "    AND (COALESCE(gldq013,' ') = COALESCE(?,' ') ) ",                  
        " AND NOT EXISTS( SELECT 1 FROM glar_t ",
        "  WHERE glar001 = gldq001 ",
        "    AND glarent = gldqent ",
        "    AND glar002 = gldp003 ",
        "    AND glar003 = gldp004 ",
        "    AND glarld  = gldp002 ",
        "    AND (COALESCE(glar012,' ') = COALESCE(gldq003,' ') ) ",
        "    AND (COALESCE(glar013,' ') = COALESCE(gldq004,' ') ) ",
        "    AND (COALESCE(glar014,' ') = COALESCE(gldq005,' ') ) ",
        "    AND (COALESCE(glar015,' ') = COALESCE(gldq006,' ') ) ",
        "    AND (COALESCE(glar016,' ') = COALESCE(gldq007,' ') ) ",
        "    AND (COALESCE(glar017,' ') = COALESCE(gldq008,' ') ) ",
        "    AND (COALESCE(glar018,' ') = COALESCE(gldq009,' ') ) ",
        "    AND (COALESCE(glar019,' ') = COALESCE(gldq010,' ') ) ",
        "    AND (COALESCE(glar020,' ') = COALESCE(gldq014,' ') ) ",
        "    AND (COALESCE(glar022,' ') = COALESCE(gldq015,' ') ) ",
        "    AND (COALESCE(glar023,' ') = COALESCE(gldq016,' ') ) ",
        "    AND (COALESCE(glar051,' ') = COALESCE(gldq011,' ') ) ",
        "    AND (COALESCE(glar052,' ') = COALESCE(gldq012,' ') ) ",
        "    AND (COALESCE(glar053,' ') = COALESCE(gldq013,' ') ) ",
        "               )"
   PREPARE sel_gldqp2n FROM l_sql
   DECLARE sel_gldqc2n CURSOR FOR sel_gldqp2n

   #   取此個體帳+ 科目+核算項 + 此年月 gleb 值
   LET l_sql = "   SELECT SUM(gldq017),SUM(gldq018),SUM(gldq019), ",
               "          SUM(gldq020),SUM(gldq021),SUM(gldq022) ",
               "     FROM gldq_t,gldp_t ",
               "    WHERE gldqent = gldpent ",
               "      AND gldqdocno = gldpdocno ",
               "      AND gldpent = ",g_enterprise," ",
               "      AND gldpstus = 'Y' ",
               "      AND gldp003  = ? ",
               "      AND gldp004  = ? ",
               "      AND gldp001  = ? " ,
               "      AND gldp002  = ? ",
               "      AND gldp005 = '1' ",
               "      AND gldp006 = 'M' ",
               "      AND gldq001 = ? ",
               "    AND (COALESCE(gldq003,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq004,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq005,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq006,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq007,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq008,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq009,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq010,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq014,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq015,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq016,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq011,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq012,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq013,' ') = COALESCE(?,' ') ) ",                  
               " AND NOT EXISTS( SELECT 1 FROM glar_t ",
               "  WHERE glar001 = gldq001 ",
               "    AND glarent = gldqent ",
               "    AND glar002 = gldp003 ",
               "    AND glar003 = gldp004 ",
               "    AND glarld  = gldp002 ",
               "    AND (COALESCE(glar012,' ') = COALESCE(gldq003,' ') ) ",
               "    AND (COALESCE(glar013,' ') = COALESCE(gldq004,' ') ) ",
               "    AND (COALESCE(glar014,' ') = COALESCE(gldq005,' ') ) ",
               "    AND (COALESCE(glar015,' ') = COALESCE(gldq006,' ') ) ",
               "    AND (COALESCE(glar016,' ') = COALESCE(gldq007,' ') ) ",
               "    AND (COALESCE(glar017,' ') = COALESCE(gldq008,' ') ) ",
               "    AND (COALESCE(glar018,' ') = COALESCE(gldq009,' ') ) ",
               "    AND (COALESCE(glar019,' ') = COALESCE(gldq010,' ') ) ",
               "    AND (COALESCE(glar020,' ') = COALESCE(gldq014,' ') ) ",
               "    AND (COALESCE(glar022,' ') = COALESCE(gldq015,' ') ) ",
               "    AND (COALESCE(glar023,' ') = COALESCE(gldq016,' ') ) ",
               "    AND (COALESCE(glar051,' ') = COALESCE(gldq011,' ') ) ",
               "    AND (COALESCE(glar052,' ') = COALESCE(gldq012,' ') ) ",
               "    AND (COALESCE(glar053,' ') = COALESCE(gldq013,' ') ) ",
               "               )"
   PREPARE sel_gldqp3n FROM l_sql
   
   #albireo 160303-----s
   LET l_sql = "   SELECT COUNT(*) ",
               "     FROM gldq_t,gldp_t ",
               "    WHERE gldqent = gldpent ",
               "      AND gldqdocno = gldpdocno ",
               "      AND gldpent = ",g_enterprise," ",
               "      AND gldpstus = 'Y' ",
               "      AND gldp003  = ? ",
               "      AND gldp004  = ? ",
               "      AND gldp001  = ? " ,
               "      AND gldp002  = ? ",
               "      AND gldp005 = '1' ",
               "      AND gldp006 = 'M' ",
               "      AND gldq001 = ? ",
               "      AND gldq017 > 0 ",
               "    AND (COALESCE(gldq003,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq004,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq005,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq006,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq007,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq008,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq009,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq010,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq014,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq015,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq016,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq011,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq012,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq013,' ') = COALESCE(?,' ') ) ",                  
               " AND NOT EXISTS( SELECT 1 FROM glar_t ",
               "  WHERE glar001 = gldq001 ",
               "    AND glarent = gldqent ",
               "    AND glar002 = gldp003 ",
               "    AND glar003 = gldp004 ",
               "    AND glarld  = gldp002 ",
               "    AND (COALESCE(glar012,' ') = COALESCE(gldq003,' ') ) ",
               "    AND (COALESCE(glar013,' ') = COALESCE(gldq004,' ') ) ",
               "    AND (COALESCE(glar014,' ') = COALESCE(gldq005,' ') ) ",
               "    AND (COALESCE(glar015,' ') = COALESCE(gldq006,' ') ) ",
               "    AND (COALESCE(glar016,' ') = COALESCE(gldq007,' ') ) ",
               "    AND (COALESCE(glar017,' ') = COALESCE(gldq008,' ') ) ",
               "    AND (COALESCE(glar018,' ') = COALESCE(gldq009,' ') ) ",
               "    AND (COALESCE(glar019,' ') = COALESCE(gldq010,' ') ) ",
               "    AND (COALESCE(glar020,' ') = COALESCE(gldq014,' ') ) ",
               "    AND (COALESCE(glar022,' ') = COALESCE(gldq015,' ') ) ",
               "    AND (COALESCE(glar023,' ') = COALESCE(gldq016,' ') ) ",
               "    AND (COALESCE(glar051,' ') = COALESCE(gldq011,' ') ) ",
               "    AND (COALESCE(glar052,' ') = COALESCE(gldq012,' ') ) ",
               "    AND (COALESCE(glar053,' ') = COALESCE(gldq013,' ') ) ",
               "               )"
   PREPARE sel_gldqp4d FROM l_sql   
   
   LET l_sql = "   SELECT COUNT(*) ",
               "     FROM gldq_t,gldp_t ",
               "    WHERE gldqent = gldpent ",
               "      AND gldqdocno = gldpdocno ",
               "      AND gldpent = ",g_enterprise," ",
               "      AND gldpstus = 'Y' ",
               "      AND gldp003  = ? ",
               "      AND gldp004  = ? ",
               "      AND gldp001  = ? " ,
               "      AND gldp002  = ? ",
               "      AND gldp005 = '1' ",
               "      AND gldp006 = 'M' ",
               "      AND gldq001 = ? ",
               "      AND gldq018 > 0 ",
               "    AND (COALESCE(gldq003,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq004,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq005,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq006,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq007,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq008,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq009,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq010,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq014,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq015,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq016,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq011,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq012,' ') = COALESCE(?,' ') ) ",
               "    AND (COALESCE(gldq013,' ') = COALESCE(?,' ') ) ",                  
               " AND NOT EXISTS( SELECT 1 FROM glar_t ",
               "  WHERE glar001 = gldq001 ",
               "    AND glarent = gldqent ",
               "    AND glar002 = gldp003 ",
               "    AND glar003 = gldp004 ",
               "    AND glarld  = gldp002 ",
               "    AND (COALESCE(glar012,' ') = COALESCE(gldq003,' ') ) ",
               "    AND (COALESCE(glar013,' ') = COALESCE(gldq004,' ') ) ",
               "    AND (COALESCE(glar014,' ') = COALESCE(gldq005,' ') ) ",
               "    AND (COALESCE(glar015,' ') = COALESCE(gldq006,' ') ) ",
               "    AND (COALESCE(glar016,' ') = COALESCE(gldq007,' ') ) ",
               "    AND (COALESCE(glar017,' ') = COALESCE(gldq008,' ') ) ",
               "    AND (COALESCE(glar018,' ') = COALESCE(gldq009,' ') ) ",
               "    AND (COALESCE(glar019,' ') = COALESCE(gldq010,' ') ) ",
               "    AND (COALESCE(glar020,' ') = COALESCE(gldq014,' ') ) ",
               "    AND (COALESCE(glar022,' ') = COALESCE(gldq015,' ') ) ",
               "    AND (COALESCE(glar023,' ') = COALESCE(gldq016,' ') ) ",
               "    AND (COALESCE(glar051,' ') = COALESCE(gldq011,' ') ) ",
               "    AND (COALESCE(glar052,' ') = COALESCE(gldq012,' ') ) ",
               "    AND (COALESCE(glar053,' ') = COALESCE(gldq013,' ') ) ",
               "               )"
   PREPARE sel_gldqp4c FROM l_sql  
   #albireo 160303-----e
   #-----declare prepare-----e                                           
     
   #-----
   #CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   LET l_success = TRUE   #成功 中間有設定失敗最後要提示批次執行失敗  #albireo 151218
   
   #不包transaction    要留下現場給對帳人員看
   
   #刪除殘留的本期資料
   DELETE FROM gldn_t 
    WHERE gldnent = g_enterprise
      AND gldnld  = g_master.l_gldnld
      AND gldn001 = g_master.l_gldn001
      AND gldn005 = g_master.l_yy
      AND gldn006 = g_master.l_mme
      
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'del_gldn'
      CALL cl_err()
   END IF
   
   #albireo 160224-----s
   DELETE FROM gldq_t
    WHERE gldqent = g_enterprise
      AND gldqdocno IN (
                       SELECT gldpdocno FROM gldp_t
                        WHERE gldpent = g_enterprise
                          AND gldp006 IN ('8','9')
                          AND gldpld = g_master.l_gldnld
                          AND gldp001 = g_master.l_gldn001
                          AND gldp003 = g_master.l_yy
                          AND gldp004 = g_master.l_mme
                       )

   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'del_gldq'
      CALL cl_err()
   END IF


   DELETE FROM gldp_t
    WHERE gldpent = g_enterprise
      AND gldp006 IN ('8','9')
      AND gldpld = g_master.l_gldnld
      AND gldp001 = g_master.l_gldn001
      AND gldp003 = g_master.l_yy
      AND gldp004 = g_master.l_mme

   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'del_gldp'
      CALL cl_err()
   END IF

   #albireo 160224-----e
   
   #判斷輸入合併帳glaa131是分層合併Y 不分層合併N
   LET l_glaa131 = NULL
   LET l_glaa001 = NULL
   LET l_glaa015 = NULL
   LET l_glaa016 = NULL
   LET l_glaa019 = NULL
   LET l_glaa020 = NULL
   LET l_glaa132 = NULL
   SELECT glaa131,glaa001,glaa015,glaa016,
          glaa019,glaa020,glaa132
     INTO l_glaa131 ,l_glaa001,l_glaa015,l_glaa016,
          l_glaa019,l_glaa020,l_glaa132
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_master.l_gldnld
      
   IF cl_null(l_glaa131)THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = "glaald = ",g_master.l_gldnld," "
      CALL cl_err()
   END IF
   
   #幣別未啟用就設定為空
   IF l_glaa015 = 'N' THEN LET l_glaa016 = '' END IF
   IF l_glaa019 = 'N' THEN LET l_glaa020 = '' END IF
   
   #後面處理都抓截止期別
   #    前面做到2015  8      現在做2015  10 = gldn  2015  8   + 變動資料只含2015 10 讓USER自己查沒做2015 9
   #-----
   
   CASE
      WHEN l_glaa131 = 'Y'   
       #分層合併     
       #依起始(上層公司+合併帳)抓gldc 並且納入合併否='Y'
       #FOREACH gldcld  gldc001 gldc002 gldc003 gldc005    gldc009
       #        合併帳   上層    下層    下層帳   合併納入否  Y=頭
         LET l_sql = "SELECT gldcld,gldc001,gldc002,gldc003,gldc009 ",
                     "  FROM gldc_t ",
                     " WHERE gldcent = ",g_enterprise," ",
                     "   AND gldcld  = '",g_master.l_gldnld,"' ",
                     "   AND gldc001 = '",g_master.l_gldn001,"' ",
                     "   AND gldc005 = 'Y' "
       
      WHEN l_glaa131 = 'N'
       #不分層合併
       #依起始帳別上層公司往下展樹   遇到納入合併否= 'N'就不往下做
       #都寫個體的     要排除中間層的    gldc002 + gldc003  為單頭結點的
       #FOREACH gldcld     gldc001 gldc002 gldc003 gldc005    gldc009
       #        最頭合併帳 最頭公司   下層    下層帳   合併納入否  Y=最頭   
          DELETE FROM aglp700_tmp
          CALL aglp700_ins_node(g_master.l_gldnld,g_master.l_gldn001,'','Y')
          LET l_sql = "SELECT gldcld,gldc001,gldc002,gldc003,gldc009 ",
                     "  FROM aglp700_tmp "
   END CASE
   PREPARE sel_nodep1 FROM l_sql
   DECLARE sel_nodec1 CURSOR FOR sel_nodep1
   
   #albireo 151218-----s
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,")"
   PREPARE sel_nodep3 FROM l_sql
   LET l_count = NULL
   EXECUTE sel_nodep3 INTO l_count 
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   IF l_count = 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      CALL cl_err()
      LET l_success = FALSE
   END IF
   #albireo 151218-----e
   
   #-----
   FOREACH sel_nodec1 INTO l_node.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'sel_nodec1'
         CALL cl_err()
         EXIT FOREACH
      END IF
      #判斷下層公司 是否為T100 OR 非T100    (glda002= 'N'OR'Y')
      LET l_glda002 = NULL
      SELECT glda002 INTO l_glda002 FROM glda_t
       WHERE gldaent = g_enterprise
         AND glda001 = l_node.gldc002
      
      #判斷是否單頭
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM gldb_t
       WHERE gldbent = g_enterprise
         AND gldbld  = l_node.gldc003
         AND gldb001 = l_node.gldc002
         AND gldbstus = 'Y'
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count > 0 THEN
         LET l_root = TRUE
      ELSE 
         LET l_root = FALSE
      END IF
         
      INITIALIZE l_glaas.* TO NULL
    
      SELECT glaa001,glaa015,glaa016,
             glaa019,glaa020
        INTO l_glaas.*
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_node.gldc003 
      
      #非T100     抓aglt501資料
      IF l_glda002 = 'N' THEN
         #FOREACH gldh 個體帳 (0~N月) 取 科目+核算項
         FOREACH sel_gldhc1n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                   l_node.gldc002,l_node.gldc003       
                             INTO l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                  l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                  l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                  l_item.gldn037,l_item.gldn038,l_item.gldn039,l_item.key
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = 'sel_gldhc1n'
               CALL cl_err()
               EXIT FOREACH
            END IF 

            INITIALIZE l_gldn.* TO NULL

            #組複合KEY 抓合併科目  匯率轉換原則用
            CALL g_gldn_ar.clear()
            LET g_gldn_ar[1].chr1  = l_item.gldn014 
            LET g_gldn_ar[2].chr1  = l_item.gldn015 
            LET g_gldn_ar[3].chr1  = l_item.gldn016 
            LET g_gldn_ar[4].chr1  = l_item.gldn017 
            LET g_gldn_ar[5].chr1  = l_item.gldn018 
            LET g_gldn_ar[6].chr1  = l_item.gldn019 
            LET g_gldn_ar[7].chr1  = l_item.gldn020 
            LET g_gldn_ar[8].chr1  = l_item.gldn021 
            LET g_gldn_ar[12].chr1 = l_item.gldn022 
            LET g_gldn_ar[13].chr1 = l_item.gldn024 
            LET g_gldn_ar[14].chr1 = l_item.gldn025 
            LET g_gldn_ar[9].chr1  = l_item.gldn037 
            LET g_gldn_ar[10].chr1 = l_item.gldn038 
            LET g_gldn_ar[11].chr1 = l_item.gldn039 

            #抓取匯率轉換原則-----s
            LET l_gldn007p = l_item.gldn007
            CALL aglp700_get_item(g_master.l_gldn001,g_master.l_gldnld,
                                  l_node.gldc002,l_node.gldc003,l_item.gldn007,g_gldn_ar)
               RETURNING g_sub_success,l_gldn.gldn007,l_gldf.gldf008,l_gldf.gldf009,l_gldf.gldf010
            IF NOT g_sub_success THEN
               #抓不到轉換原則報錯
               LET l_success = FALSE
               #CONTINUE FOREACH  #後續還是要繼續檢查
            END IF             
            #抓取匯率轉換原則------e
               #LET l_累加總帳6個
               LET l_sums.gldn010 = 0    LET l_sums.gldn027 = 0    LET l_sums.gldn030 = 0 
               LET l_sums.gldn011 = 0    LET l_sums.gldn028 = 0    LET l_sums.gldn031 = 0 
               #LET l_累加*匯率6個            
               LET l_sumt.gldn010 = 0    LET l_sumt.gldn027 = 0    LET l_sumt.gldn030 = 0 
               LET l_sumt.gldn011 = 0    LET l_sumt.gldn028 = 0    LET l_sumt.gldn031 = 0 

               
                LET l_sumcountd = 0 
                LET l_sumcountc = 0
                #FOREACH 個體帳+ 科目+核算項  取   年 月
                FOREACH sel_gldhc2n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                          l_node.gldc002,l_node.gldc003,
                                          l_item.gldn007,l_item.key
                                    INTO l_yy,l_mm
                   IF SQLCA.SQLCODE THEN
                      INITIALIZE g_errparam.* TO NULL
                      LET g_errparam.code = SQLCA.SQLCODE
                      LET g_errparam.extend = 'sel_gldhc1n'
                      CALL cl_err()
                      EXIT FOREACH
                   END IF 
                   #   1.取此個體帳+ 科目+核算項 + 此年月 gldh 值
                   EXECUTE sel_gldhp3n USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                          l_item.gldn007,l_item.key
                                       INTO l_gldn010,l_gldn011,l_gldn027,l_gldn028,
                                            l_gldn030,l_gldn031
                   IF cl_null(l_gldn010)THEN LET l_gldn010 = 0 END IF
                   IF cl_null(l_gldn011)THEN LET l_gldn011 = 0 END IF
                   IF cl_null(l_gldn027)THEN LET l_gldn027 = 0 END IF
                   IF cl_null(l_gldn028)THEN LET l_gldn028 = 0 END IF
                   IF cl_null(l_gldn030)THEN LET l_gldn030 = 0 END IF
                   IF cl_null(l_gldn031)THEN LET l_gldn031 = 0 END IF

                   #albireo 160303-----s
                   EXECUTE sel_gldhp4d USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                       l_item.gldn007,l_item.key
                         INTO l_countd
                   EXECUTE sel_gldhp4c USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                            l_item.gldn007,l_item.key
                         INTO l_countc
                         
                   LET l_sumcountd  = l_sumcountd + l_countd
                   LET l_sumcountc  = l_sumcountc + l_countc
                   #albireo 160303-----e

                   #   2.判斷方式是否要扣前期
                   #處理glaa133  累計額時-----s
                   IF l_glaa133 = '2' THEN
                      #取本年前一次最大期
                      LET l_gldn010l = NULL    LET l_gldn011l = NULL
                      LET l_gldn027l = NULL    LET l_gldn028l = NULL
                      LET l_gldn030l = NULL    LET l_gldn031l = NULL
                      EXECUTE sel_gldhp2 USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                               l_item.gldn007,l_item.key,l_node.gldc002,l_node.gldc003,
                                               l_item.gldn007,l_item.key
                                         INTO l_gldn010l,l_gldn011l,l_gldn027l,l_gldn028l,
                                              l_gldn030l,l_gldn031l
                      IF cl_null(l_gldn010l)THEN LET l_gldn010l = 0 END IF
                      IF cl_null(l_gldn011l)THEN LET l_gldn011l = 0 END IF
                      IF cl_null(l_gldn027l)THEN LET l_gldn027l = 0 END IF
                      IF cl_null(l_gldn028l)THEN LET l_gldn028l = 0 END IF
                      IF cl_null(l_gldn030l)THEN LET l_gldn030l = 0 END IF
                      IF cl_null(l_gldn031l)THEN LET l_gldn031l = 0 END IF
                      
                      #本期減上期
                      LET l_gldn010 = l_gldn010 - l_gldn010l
                      LET l_gldn011 = l_gldn011 - l_gldn011l
                      LET l_gldn027 = l_gldn027 - l_gldn027l
                      LET l_gldn028 = l_gldn028 - l_gldn028l
                      LET l_gldn030 = l_gldn030 - l_gldn030l
                      LET l_gldn031 = l_gldn031 - l_gldn031l
                   END IF
                   #處理glaa133  累計額時-----e 
                   
                   #   4.l_累加總帳 = l_累加總帳+結果
                   LET l_sums.gldn010 = l_sums.gldn010 + l_gldn010
                   LET l_sums.gldn011 = l_sums.gldn011 + l_gldn011
                   LET l_sums.gldn027 = l_sums.gldn027 + l_gldn027
                   LET l_sums.gldn028 = l_sums.gldn028 + l_gldn028
                   LET l_sums.gldn030 = l_sums.gldn030 + l_gldn030
                   LET l_sums.gldn031 = l_sums.gldn031 + l_gldn031
                   
                   #151221 albireo-----s
                   #存舊值比較用
                   LET l_gldn010_o = l_gldn010         #換匯前金額(記帳幣)
                   LET l_gldn011_o = l_gldn011
                   LET l_gldn027_o = l_gldn027         #換匯前金額(功能幣)
                   LET l_gldn028_o = l_gldn028
                   LET l_gldn030_o = l_gldn030         #換匯前金額(報告幣)
                   LET l_gldn031_o = l_gldn031
                                      
                   #   #取匯率  傳入此年月
                   LET l_examtin.up_ld   = g_master.l_gldnld        #合併帳別(合併主體)
                   LET l_examtin.up_comp = g_master.l_gldn001         #上層公司
                   LET l_examtin.dn_ld   = l_node.gldc003    #下層帳別
                   LET l_examtin.dn_comp = l_node.gldc002    #下層公司
                   LET l_examtin.yy      = l_yy              #年度
                   LET l_examtin.mm      = l_mm              #期別
                   LET l_examtin.acc     = l_item.gldn007    #科目
                   LET l_examtin.tabname = 'gldn_t'          #餘額來源table
                   LET l_examtin.curr1   = l_glaas.glaa001   #幣別(記帳幣)         
                   LET l_examtin.curr2   = l_glaas.glaa016   #幣別(功能幣)         
                   LET l_examtin.curr3   = l_glaas.glaa020   #幣別(報告幣)         
                   LET l_examtin.amt1    = l_gldn010         #換匯前金額(記帳幣)
                   LET l_examtin.amt1_2  = l_gldn011
                   LET l_examtin.amt2    = l_gldn027         #換匯前金額(功能幣)
                   LET l_examtin.amt2_2  = l_gldn028
                   LET l_examtin.amt3    = l_gldn030         #換匯前金額(報告幣)
                   LET l_examtin.amt3_2  = l_gldn031
                   LET l_examtin.type1   = l_gldf.gldf008             #記帳幣換算類別
                   LET l_examtin.type2   = l_gldf.gldf009             #功能幣換算類別
                   LET l_examtin.type3   = l_gldf.gldf010             #報告幣換算類別
                   LET l_examtin.source  = ''           #來源A/對沖B
                   

                    #albireo 160309-----s
                    LET l_examtin.acc2 = l_item.gldn007
                    LET l_glaa134 = NULL
                    SELECT glaa134 INTO l_glaa134 FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald = l_node.gldc003
                    CASE
                       WHEN cl_null(l_glaa134) OR l_glaa134 = '0'
                          LET l_examtin.act1 = NULL
                       OTHERWISE
                          LET l_examtin.act1 = g_gldn_ar[l_glaa134].chr1
                    END CASE
                    #albireo 160309-----e
                    #albireo 160311-----s
                    CALL s_fin_date_get_lastday(l_node.gldc003,'',l_yy,g_master.l_mme,'')RETURNING  g_sub_success,l_examtin.edat 
                    #albireo 160311-----e
                    
                    LET ls_jsin = util.JSON.stringify(l_examtin)
                    CALL s_merge_get_examt(ls_jsin)RETURNING ls_jsout
                    CALL util.JSON.parse(ls_jsout,l_examtout)
                    LET l_gldn010 = l_examtout.r_amt1
                    LET l_gldn011 = l_examtout.r_amt1_2
                    LET l_gldn027 = l_examtout.r_amt2
                    LET l_gldn028 = l_examtout.r_amt2_2
                    LET l_gldn030 = l_examtout.r_amt3
                    LET l_gldn031 = l_examtout.r_amt3_2
                    #albireo 160225-----s
                    LET l_gldn.gldn034 = l_examtout.r_rate1
                    LET l_gldn.gldn035 = l_examtout.r_rate2
                    LET l_gldn.gldn036 = l_examtout.r_rate3
                    #albireo 160225-----e
                    
                    #計帳幣沒抓到匯率
                    IF (l_gldn010_o > 0 AND l_gldn010 = 0)
                       OR (l_gldn011_o > 0 AND l_gldn011 = 0) THEN
                       INITIALIZE g_errparam.* TO NULL
                       LET g_errparam.code = 'agl-00418'
                       LET g_errparam.replace[1] = l_node.gldc003
                       LET g_errparam.replace[2] = g_master.l_gldnld
                       LET g_errparam.replace[3] = cl_getmsg('agl-00419',g_dlang),"(",l_glaa001,")"
                       LET g_errparam.extend = ''
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET l_success = FALSE   
                    END IF
                    
                    #功能幣沒抓到匯率
                    IF l_glaa015 = 'Y' THEN
                       IF (l_gldn027_o > 0 AND l_gldn027 = 0)
                          OR (l_gldn028_o > 0 AND l_gldn028 = 0) THEN
                          INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00420',g_dlang),"(",l_glaa016,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF        

                    #報告幣沒抓到匯率
                    IF l_glaa019 = 'Y' THEN
                       IF (l_gldn030_o > 0 AND l_gldn030 = 0)
                          OR (l_gldn031_o > 0 AND l_gldn031 = 0) THEN
                         INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00421',g_dlang),"(",l_glaa020,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF                       

                   #   5.l_累加*匯率 = l_累加*匯率 + 結果 * 匯率 
                   LET l_sumt.gldn010 = l_sumt.gldn010 + l_gldn010 #* l_gldn.gldn034   #l_gldn010 已經*匯率  #albireo 151231
                   LET l_sumt.gldn011 = l_sumt.gldn011 + l_gldn011 #* l_gldn.gldn034
                   LET l_sumt.gldn027 = l_sumt.gldn027 + l_gldn027 #* l_gldn.gldn035
                   LET l_sumt.gldn028 = l_sumt.gldn028 + l_gldn028 #* l_gldn.gldn035
                   LET l_sumt.gldn030 = l_sumt.gldn030 + l_gldn030 #* l_gldn.gldn036
                   LET l_sumt.gldn031 = l_sumt.gldn031 + l_gldn031 #* l_gldn.gldn036
                END FOREACH
#             END IF    #albireo 151221 匯率改CALL 元件

             ##平均匯率後兩種模式-----s
             #依此種模式計算已經不用重記
             #LET l_累加*匯率 = l_累加總帳 * 匯率
             ##-----------------------e
             
             LET l_gldn.gldnent = g_enterprise
             LET l_gldn.gldnld  = g_master.l_gldnld
             LET l_gldn.gldn001 = g_master.l_gldn001
             
             #用合併帳+上層公司抓上層個體帳
             LET l_gldb002 = NULL
             SELECT gldb002 INTO l_gldb002 FROM gldb_t
              WHERE gldbent = g_enterprise
                AND gldb001 = g_master.l_gldn001
                AND gldbld  = g_master.l_gldnld
             LET l_gldn.gldn002 = l_gldb002   
             
             LET l_gldn.gldn003 = g_master.l_yy
             LET l_gldn.gldn004 = g_master.l_mme
             LET l_gldn.gldn005 = g_master.l_yy
             LET l_gldn.gldn006 = g_master.l_mme
             #LET l_gldn.gldn007 = l_item.gldn007
             #LET l_gldn.gldn008 =
             #合併帳別取本位幣別-----             
             LET l_gldn.gldn009 = l_glaa001 
             LET l_gldn.gldn026 = l_glaa016
             LET l_gldn.gldn029 = l_glaa020
             #-----
             LET l_gldn.gldn010 = l_sumt.gldn010
             LET l_gldn.gldn011 = l_sumt.gldn011
             #借貸筆數-----
             #albireo 回頭在處理
            #LET l_gldn.gldn012 = l_gldh.gldh022
            #LET l_gldn.gldn013 = l_gldh.gldh023
             #albireo 160303-----s
             LET l_gldn.gldn012 = l_sumcountd  
             LET l_gldn.gldn013 = l_sumcountc
             #albireo 160303-----e

             #-----
             LET l_gldn.gldn014 = l_item.gldn014
             LET l_gldn.gldn015 = l_item.gldn015
             LET l_gldn.gldn016 = l_item.gldn016
             LET l_gldn.gldn017 = l_item.gldn017
             LET l_gldn.gldn018 = l_item.gldn018
             LET l_gldn.gldn019 = l_item.gldn019
             LET l_gldn.gldn020 = l_item.gldn020
             LET l_gldn.gldn021 = l_item.gldn021
             LET l_gldn.gldn022 = l_item.gldn022
             LET l_gldn.gldn024 = l_item.gldn024
             LET l_gldn.gldn025 = l_item.gldn025
              
             LET l_gldn.gldn027 = l_sumt.gldn027
             LET l_gldn.gldn028 = l_sumt.gldn028
              
             LET l_gldn.gldn030 = l_sumt.gldn030
             LET l_gldn.gldn031 = l_sumt.gldn031
             LET l_gldn.gldn032 = l_node.gldc002
             LET l_gldn.gldn033 = l_node.gldc003
              
             LET l_gldn.gldn037 = l_item.gldn037
             LET l_gldn.gldn038 = l_item.gldn038
             LET l_gldn.gldn039 = l_item.gldn039
             LET l_gldn.gldn040 = l_node.gldc002
             LET l_gldn.gldn041 = l_node.gldc003

             #處理個體公司來源累計額-----s
             LET l_gldn.gldn042 = l_sums.gldn010 
             LET l_gldn.gldn043 = l_sums.gldn011
             LET l_gldn.gldn044 = l_sums.gldn027
             LET l_gldn.gldn045 = l_sums.gldn028
             LET l_gldn.gldn046 = l_sums.gldn030
             LET l_gldn.gldn047 = l_sums.gldn031
             #處理個體公司來源累計額-----e

             #借貸金額都為0 就不往下做
             IF l_gldn.gldn010 = 0 AND l_gldn.gldn011 = 0 AND l_gldn.gldn027 = 0
                AND l_gldn.gldn028 = 0 AND l_gldn.gldn030 = 0 AND l_gldn.gldn031 = 0 THEN
                CONTINUE FOREACH
             END IF
             #INSERT gldn_t
             
             CALL g_gldn_ar.clear()
             LET g_gldn_ar[1].chr1  = l_gldn.gldn014 
             LET g_gldn_ar[2].chr1  = l_gldn.gldn015 
             LET g_gldn_ar[3].chr1  = l_gldn.gldn016 
             LET g_gldn_ar[4].chr1  = l_gldn.gldn017 
             LET g_gldn_ar[5].chr1  = l_gldn.gldn018 
             LET g_gldn_ar[6].chr1  = l_gldn.gldn019 
             LET g_gldn_ar[7].chr1  = l_gldn.gldn020 
             LET g_gldn_ar[8].chr1  = l_gldn.gldn021 
             LET g_gldn_ar[12].chr1 = l_gldn.gldn022 
             LET g_gldn_ar[13].chr1 = l_gldn.gldn024 
             LET g_gldn_ar[14].chr1 = l_gldn.gldn025
             LET g_gldn_ar[9].chr1  = l_gldn.gldn037 
             LET g_gldn_ar[10].chr1 = l_gldn.gldn038 
             LET g_gldn_ar[11].chr1 = l_gldn.gldn039
             
             #核算項轉換復合KEY
             CALL s_merge_get_gldn008(g_gldn_ar)RETURNING l_gldn.gldn008
             IF cl_null(l_gldn.gldn007) THEN CONTINUE FOREACH END IF
             #161128-00061#1----modify------begin-----------
             #INSERT INTO gldn_t VALUES(l_gldn.*)
             INSERT INTO gldn_t (gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn009,
                                 gldn010,gldn011,gldn012,gldn013,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,
                                 gldn021,gldn022,gldn024,gldn025,gldn026,gldn027,gldn028,gldn029,gldn030,gldn031,gldn032,
                                 gldn033,gldn034,gldn035,gldn036,gldn037,gldn038,gldn039,gldn040,gldn041,gldn042,gldn043,
                                 gldn044,gldn045,gldn046,gldn047)
              VALUES(l_gldn.gldnent,l_gldn.gldnld,l_gldn.gldn001,l_gldn.gldn002,l_gldn.gldn003,l_gldn.gldn004,l_gldn.gldn005,l_gldn.gldn006,l_gldn.gldn007,l_gldn.gldn008,l_gldn.gldn009,
                     l_gldn.gldn010,l_gldn.gldn011,l_gldn.gldn012,l_gldn.gldn013,l_gldn.gldn014,l_gldn.gldn015,l_gldn.gldn016,l_gldn.gldn017,l_gldn.gldn018,l_gldn.gldn019,l_gldn.gldn020,
                     l_gldn.gldn021,l_gldn.gldn022,l_gldn.gldn024,l_gldn.gldn025,l_gldn.gldn026,l_gldn.gldn027,l_gldn.gldn028,l_gldn.gldn029,l_gldn.gldn030,l_gldn.gldn031,l_gldn.gldn032,
                     l_gldn.gldn033,l_gldn.gldn034,l_gldn.gldn035,l_gldn.gldn036,l_gldn.gldn037,l_gldn.gldn038,l_gldn.gldn039,l_gldn.gldn040,l_gldn.gldn041,l_gldn.gldn042,l_gldn.gldn043,
                     l_gldn.gldn044,l_gldn.gldn045,l_gldn.gldn046,l_gldn.gldn047)
             #161128-00061#1----modify------end-----------
             IF SQLCA.SQLCODE THEN
                INITIALIZE g_errparam.* TO NULL
                LET g_errparam.code = SQLCA.SQLCODE 
                LET g_errparam.extend = " INSERT gldn "
                CALL cl_err()
             END IF 
         END FOREACH
      END IF
             
      IF l_glda002 = 'Y' THEN  
      
         IF l_node.gldc009 = 'N' AND l_root THEN
         ELSE
            #T100       2.其他就為一般結點(包含此次最頭的結點)            
            #(FOREACH)             抓glar   總帳餘額檔 
            FOREACH sel_glarc1n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                      l_node.gldc003       
                                INTO l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                     l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                     l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                     l_item.gldn037,l_item.gldn038,l_item.gldn039,l_item.key
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = 'sel_glarc1n'
                  CALL cl_err()
                  EXIT FOREACH
               END IF 

               INITIALIZE l_gldn.* TO NULL

               #組複合KEY 抓合併科目  匯率轉換原則用
               CALL g_gldn_ar.clear()
               LET g_gldn_ar[1].chr1  = l_item.gldn014 
               LET g_gldn_ar[2].chr1  = l_item.gldn015 
               LET g_gldn_ar[3].chr1  = l_item.gldn016 
               LET g_gldn_ar[4].chr1  = l_item.gldn017 
               LET g_gldn_ar[5].chr1  = l_item.gldn018 
               LET g_gldn_ar[6].chr1  = l_item.gldn019 
               LET g_gldn_ar[7].chr1  = l_item.gldn020 
               LET g_gldn_ar[8].chr1  = l_item.gldn021 
               LET g_gldn_ar[12].chr1 = l_item.gldn022 
               LET g_gldn_ar[13].chr1 = l_item.gldn024 
               LET g_gldn_ar[14].chr1 = l_item.gldn025 
               LET g_gldn_ar[9].chr1  = l_item.gldn037 
               LET g_gldn_ar[10].chr1 = l_item.gldn038 
               LET g_gldn_ar[11].chr1 = l_item.gldn039 

               #抓取匯率轉換原則-----s
               LET l_gldn007p = l_item.gldn007
               CALL aglp700_get_item(g_master.l_gldn001,g_master.l_gldnld,
                                     l_node.gldc002,l_node.gldc003,l_item.gldn007,g_gldn_ar)
                  RETURNING g_sub_success,l_gldn.gldn007,l_gldf.gldf008,l_gldf.gldf009,l_gldf.gldf010
               IF NOT g_sub_success THEN
                  #抓不到轉換原則報錯
                  LET l_success = FALSE
                  #CONTINUE FOREACH   #後續還是要繼續檢查
               END IF                 
               #抓取匯率轉換原則------e
                  #LET l_累加總帳6個
                  LET l_sums.gldn010 = 0    LET l_sums.gldn027 = 0    LET l_sums.gldn030 = 0 
                  LET l_sums.gldn011 = 0    LET l_sums.gldn028 = 0    LET l_sums.gldn031 = 0 
                  #LET l_累加*匯率6個            
                  LET l_sumt.gldn010 = 0    LET l_sumt.gldn027 = 0    LET l_sumt.gldn030 = 0 
                  LET l_sumt.gldn011 = 0    LET l_sumt.gldn028 = 0    LET l_sumt.gldn031 = 0 

                   LET l_sumcountd = 0 LET l_sumcountc = 0 
                   #FOREACH 個體帳+ 科目+核算項  取   年 月
                   FOREACH sel_glarc2n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                             l_node.gldc003,
                                             #l_item.gldn007,l_item.key   #170119-00046#1 mark
                                             #170119-00046#1-----s
                                             l_item.gldn007,
                                             l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                             l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                             l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                             l_item.gldn037,l_item.gldn038,l_item.gldn039
                                             #170119-00046#1-----e
                                       INTO l_yy,l_mm
                      IF SQLCA.SQLCODE THEN
                         INITIALIZE g_errparam.* TO NULL
                         LET g_errparam.code = SQLCA.SQLCODE
                         LET g_errparam.extend = 'sel_glebc2n'
                         CALL cl_err()
                         EXIT FOREACH
                      END IF 
                      #   1.取此個體帳+ 科目+核算項 + 此年月 glar 值
                      EXECUTE sel_glarp3n USING l_yy,l_mm,l_node.gldc003,
                                                #l_item.gldn007,l_item.key   #170119-00046#1 mark
                                                #170119-00046#1-----s
                                                l_item.gldn007,
                                                l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                                l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                                l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                                l_item.gldn037,l_item.gldn038,l_item.gldn039
                                                #170119-00046#1-----e
                                          INTO l_gldn010,l_gldn011,l_gldn027,l_gldn028,
                                               l_gldn030,l_gldn031,
                                               l_countd,l_countc
                      IF cl_null(l_gldn010)THEN LET l_gldn010 = 0 END IF
                      IF cl_null(l_gldn011)THEN LET l_gldn011 = 0 END IF
                      IF cl_null(l_gldn027)THEN LET l_gldn027 = 0 END IF
                      IF cl_null(l_gldn028)THEN LET l_gldn028 = 0 END IF
                      IF cl_null(l_gldn030)THEN LET l_gldn030 = 0 END IF
                      IF cl_null(l_gldn031)THEN LET l_gldn031 = 0 END IF

                      #albireo 160303-----s
                      LET l_sumcountd = l_sumcountd + l_countd
                      LET l_sumcountc = l_sumcountc + l_countc
                      #albireo 160303-----e

                      #CE傳票
                      #此種狀況帳別設定 帳結法時   每一科目要多抓   CE傳票MONEY 回扣餘額檔
                      LET l_glaa006 = NULL
                      SELECT glaa006 INTO l_glaa006 FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaald  = l_node.gldc003 
                      #用個體帳取年度期別日期區間
                      LET l_glaas.glaa003 = NULL
                      SELECT glaa003 INTO l_glaas.glaa003 FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaald  = l_node.gldc003
                      IF l_glaa006 = '2' THEN
                         #表結法 把CE傳票抓出來
                         CALL s_fin_date_get_period_range(l_glaas.glaa003,g_master.l_yy,l_mm)
                            RETURNING l_strdat,l_enddat
                         LET l_sql = " SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                                     "        SUM(glaq043),SUM(glaq044) ",
                                     "   FROM glaq_t,glap_t ",
                                     " WHERE glaqent = glapent ",
                                     "   AND glaqdocno = glapdocno ",
                                     "   AND glaqld    = glaqld ",
                                     "   AND glapent = ",g_enterprise," ",
                                     "   AND glapstus = 'S' ",
                                     "   AND glapld = '",l_node.gldc003,"'",
                                     "   AND glaq002 = '",l_item.gldn007,"' ",
                                     "   AND glaq002 IN ( ",    #必須是損益類科目
                                     "       SELECT glac002 FROM glac_t    ",
                                     "        WHERE glacent = ",g_enterprise," ",
                                     "          AND glac003 <> '1' ",
                                     "          AND glac007 = '6' ",
                                     "          AND glac006 = '1' ",
                                     "                  ) ",
                                     "   AND glaq007 = 'CE' ",
                                     "   AND glaqdocdt BETWEEN '",l_strdat," AND '",l_enddat,"' "
                                     
                         #核算項組入
                         LET l_sql = l_sql," AND COALESCE(glaq017,' ') = COALESCE('",l_item.gldn014,"',' ') "            
                         LET l_sql = l_sql," AND COALESCE(glaq018,' ') = COALESCE('",l_item.gldn015,"',' ') "
                         LET l_sql = l_sql," AND COALESCE(glaq019,' ') = COALESCE('",l_item.gldn016,"',' ') "
                         LET l_sql = l_sql," AND COALESCE(glaq020,' ') = COALESCE('",l_item.gldn017,"',' ') "
                         LET l_sql = l_sql," AND COALESCE(glaq021,' ') = COALESCE('",l_item.gldn018,"',' ') "                  
                         LET l_sql = l_sql," AND COALESCE(glaq022,' ') = COALESCE('",l_item.gldn019,"',' ') "                 
                         LET l_sql = l_sql," AND COALESCE(glaq023,' ') = COALESCE('",l_item.gldn020,"',' ') "                 
                         LET l_sql = l_sql," AND COALESCE(glaq024,' ') = COALESCE('",l_item.gldn021,"',' ') "                 
                         LET l_sql = l_sql," AND COALESCE(glaq025,' ') = COALESCE('",l_item.gldn022,"',' ') "                  
                         LET l_sql = l_sql," AND COALESCE(glaq027,' ') = COALESCE('",l_item.gldn024,"',' ') "                                
                         LET l_sql = l_sql," AND COALESCE(glaq028,' ') = COALESCE('",l_item.gldn025,"',' ') "
                         LET l_sql = l_sql," AND COALESCE(glaq051,' ') = COALESCE('",l_item.gldn037,"',' ') "
                         LET l_sql = l_sql," AND COALESCE(glaq052,' ') = COALESCE('",l_item.gldn038,"',' ') "
                         LET l_sql = l_sql," AND COALESCE(glaq053,' ') = COALESCE('",l_item.gldn039,"',' ') "
                       
                         PREPARE sel_glaqp1 FROM l_sql
                         LET l_gldn010ce   = NULL        #借方金額暫存
                         LET l_gldn011ce   = NULL        #貸方金額暫存
                         LET l_gldn027ce   = NULL        #借方金額暫存
                         LET l_gldn028ce   = NULL        #貸方金額暫存
                         LET l_gldn030ce   = NULL        #借方金額暫存
                         LET l_gldn031ce   = NULL        #貸方金額暫存
                         EXECUTE sel_glaqp1 INTO l_gldn010ce,l_gldn011ce,l_gldn027ce,
                                                 l_gldn028ce,l_gldn030ce,l_gldn031ce

                         IF cl_null(l_gldn010ce)THEN LET l_gldn010ce = 0 END IF
                         IF cl_null(l_gldn011ce)THEN LET l_gldn011ce = 0 END IF
                         IF cl_null(l_gldn027ce)THEN LET l_gldn027ce = 0 END IF
                         IF cl_null(l_gldn028ce)THEN LET l_gldn028ce = 0 END IF
                         IF cl_null(l_gldn030ce)THEN LET l_gldn030ce = 0 END IF
                         IF cl_null(l_gldn031ce)THEN LET l_gldn031ce = 0 END IF
                         LET l_gldn010 = l_gldn010 - l_gldn010ce
                         LET l_gldn011 = l_gldn011 - l_gldn011ce
                         LET l_gldn027 = l_gldn027 - l_gldn027ce
                         LET l_gldn028 = l_gldn028 - l_gldn028ce
                         LET l_gldn030 = l_gldn030 - l_gldn030ce
                         LET l_gldn031 = l_gldn031 - l_gldn031ce               
                      END IF

                      #aglt502調整傳票-----s
                      LET l_sql = "SELECT SUM(gldq017),SUM(gldq018),SUM(gldq019),",
                                  "       SUM(gldq020),SUM(gldq021),SUM(gldq022) ",
                                  "  FROM gldq_t,gldp_t ",
                                  " WHERE gldqent = gldpent ",
                                  "   AND gldqdocno = gldpdocno ",
                                  "   AND gldpstus = 'Y' ",
                                  "   AND gldp003 = ",g_master.l_yy," ",
                                  "   AND gldp004 = ",g_master.l_mme," ",
                                  "   AND gldp001 = '",l_node.gldc002,"' ",
                                  "   AND gldp002 = '",l_node.gldc003,"' ",
                                  "   AND gldp005 = '1' ",
                                  "   AND gldp006 = 'M' ",
                                  "   AND gldq001 = '",l_item.gldn007,"' " 
                      LET l_sql = l_sql," AND COALESCE(gldq003,' ') = COALESCE('",l_item.gldn014,"',' ') "                   
                      LET l_sql = l_sql," AND COALESCE(gldq004,' ') = COALESCE('",l_item.gldn015,"',' ') "
                      LET l_sql = l_sql," AND COALESCE(gldq005,' ') = COALESCE('",l_item.gldn016,"',' ') "                 
                      LET l_sql = l_sql," AND COALESCE(gldq006,' ') = COALESCE('",l_item.gldn017,"',' ') "                  
                      LET l_sql = l_sql," AND COALESCE(gldq007,' ') = COALESCE('",l_item.gldn018,"',' ') "                   
                      LET l_sql = l_sql," AND COALESCE(gldq008,' ') = COALESCE('",l_item.gldn019,"',' ') "
                      LET l_sql = l_sql," AND COALESCE(gldq009,' ') = COALESCE('",l_item.gldn020,"',' ') "
                      LET l_sql = l_sql," AND COALESCE(gldq010,' ') = COALESCE('",l_item.gldn021,"',' ') "                 
                      LET l_sql = l_sql," AND COALESCE(gldq014,' ') = COALESCE('",l_item.gldn022,"',' ') "                  
                      LET l_sql = l_sql," AND COALESCE(gldq015,' ') = COALESCE('",l_item.gldn024,"',' ') "                                     
                      LET l_sql = l_sql," AND COALESCE(gldq016,' ') = COALESCE('",l_item.gldn025,"',' ') "
                      LET l_sql = l_sql," AND COALESCE(gldq011,' ') = COALESCE('",l_item.gldn037,"',' ') "
                      LET l_sql = l_sql," AND COALESCE(gldq012,' ') = COALESCE('",l_item.gldn038,"',' ') "
                      LET l_sql = l_sql," AND COALESCE(gldq013,' ') = COALESCE('",l_item.gldn039,"',' ') "                            
                      PREPARE sel_gldqp2 FROM l_sql
                      
                      LET l_gldn010ad   = NULL        #借方金額暫存
                      LET l_gldn011ad   = NULL        #貸方金額暫存
                      LET l_gldn027ad   = NULL        #借方金額暫存
                      LET l_gldn028ad   = NULL        #貸方金額暫存
                      LET l_gldn030ad   = NULL        #借方金額暫存
                      LET l_gldn031ad   = NULL        #貸方金額暫存
                      EXECUTE sel_gldqp2 INTO l_gldn010ad,l_gldn011ad,l_gldn027ad,
                                              l_gldn028ad,l_gldn030ad,l_gldn031ad
                      IF cl_null(l_gldn010ad)THEN LET l_gldn010ad = 0 END IF
                      IF cl_null(l_gldn011ad)THEN LET l_gldn011ad = 0 END IF
                      IF cl_null(l_gldn027ad)THEN LET l_gldn027ad = 0 END IF
                      IF cl_null(l_gldn028ad)THEN LET l_gldn028ad = 0 END IF
                      IF cl_null(l_gldn030ad)THEN LET l_gldn030ad = 0 END IF
                      IF cl_null(l_gldn031ad)THEN LET l_gldn031ad = 0 END IF
                      LET l_gldn010 = l_gldn010 + l_gldn010ad
                      LET l_gldn011 = l_gldn011 + l_gldn011ad
                      LET l_gldn027 = l_gldn027 + l_gldn027ad
                      LET l_gldn028 = l_gldn028 + l_gldn028ad
                      LET l_gldn030 = l_gldn030 + l_gldn030ad
                      LET l_gldn031 = l_gldn031 + l_gldn031ad                          
                      #aglt502調整傳票-----e

                      #  l_累加總帳 = l_累加總帳+結果
                      LET l_sums.gldn010 = l_sums.gldn010 + l_gldn010
                      LET l_sums.gldn011 = l_sums.gldn011 + l_gldn011
                      LET l_sums.gldn027 = l_sums.gldn027 + l_gldn027
                      LET l_sums.gldn028 = l_sums.gldn028 + l_gldn028
                      LET l_sums.gldn030 = l_sums.gldn030 + l_gldn030
                      LET l_sums.gldn031 = l_sums.gldn031 + l_gldn031
                   
                      #albireo 151231-----s
                      #存舊值比較用
                      LET l_gldn010_o = l_gldn010         #換匯前金額(記帳幣)
                      LET l_gldn011_o = l_gldn011
                      LET l_gldn027_o = l_gldn027         #換匯前金額(功能幣)
                      LET l_gldn028_o = l_gldn028
                      LET l_gldn030_o = l_gldn030         #換匯前金額(報告幣)
                      LET l_gldn031_o = l_gldn031      

                      LET l_examtin.up_ld   = g_master.l_gldnld        #合併帳別(合併主體)
                      LET l_examtin.up_comp = g_master.l_gldn001         #上層公司
                      LET l_examtin.dn_ld   = l_node.gldc003    #下層帳別
                      LET l_examtin.dn_comp = l_node.gldc002    #下層公司
                      LET l_examtin.yy      = l_yy              #年度
                      LET l_examtin.mm      = l_mm              #期別
                      LET l_examtin.acc     = l_item.gldn007    #科目
                      LET l_examtin.tabname = 'gldn_t'          #餘額來源table
                      LET l_examtin.curr1   = l_glaas.glaa001   #幣別(記帳幣)         
                      LET l_examtin.curr2   = l_glaas.glaa016   #幣別(功能幣)         
                      LET l_examtin.curr3   = l_glaas.glaa020   #幣別(報告幣)         
                      LET l_examtin.amt1    = l_gldn010         #換匯前金額(記帳幣)
                      LET l_examtin.amt1_2  = l_gldn011
                      LET l_examtin.amt2    = l_gldn027         #換匯前金額(功能幣)
                      LET l_examtin.amt2_2  = l_gldn028
                      LET l_examtin.amt3    = l_gldn030         #換匯前金額(報告幣)
                      LET l_examtin.amt3_2  = l_gldn031
                      LET l_examtin.type1   = l_gldf.gldf008             #記帳幣換算類別
                      LET l_examtin.type2   = l_gldf.gldf009             #功能幣換算類別
                      LET l_examtin.type3   = l_gldf.gldf010             #報告幣換算類別
                      LET l_examtin.source  = ''           #來源A/對沖B
                      

                      #albireo 160309-----s
                      LET l_examtin.acc2 = l_item.gldn007
                      LET l_glaa134 = NULL
                      SELECT glaa134 INTO l_glaa134 FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaald = l_node.gldc003
                      CASE
                         WHEN cl_null(l_glaa134) OR l_glaa134 = '0'
                            LET l_examtin.act1 = NULL
                         OTHERWISE
                            LET l_examtin.act1 = g_gldn_ar[l_glaa134].chr1
                      END CASE
                      #albireo 160309-----e
                      #albireo 160311-----s
                      CALL s_fin_date_get_lastday(l_node.gldc003,'',l_yy,g_master.l_mme,'')RETURNING  g_sub_success,l_examtin.edat 
                      #albireo 160311-----e
                      
                      LET ls_jsin = util.JSON.stringify(l_examtin)
                      CALL s_merge_get_examt(ls_jsin)RETURNING ls_jsout
                      CALL util.JSON.parse(ls_jsout,l_examtout)
                      LET l_gldn010 = l_examtout.r_amt1
                      LET l_gldn011 = l_examtout.r_amt1_2
                      LET l_gldn027 = l_examtout.r_amt2
                      LET l_gldn028 = l_examtout.r_amt2_2
                      LET l_gldn030 = l_examtout.r_amt3
                      LET l_gldn031 = l_examtout.r_amt3_2
                      #albireo 160225-----s
                      LET l_gldn.gldn034 = l_examtout.r_rate1
                      LET l_gldn.gldn035 = l_examtout.r_rate2
                      LET l_gldn.gldn036 = l_examtout.r_rate3
                      #albireo 160225-----e
                      
                     #計帳幣沒抓到匯率
                    IF (l_gldn010_o > 0 AND l_gldn010 = 0)
                       OR (l_gldn011_o > 0 AND l_gldn011 = 0) THEN
                       INITIALIZE g_errparam.* TO NULL
                       LET g_errparam.code = 'agl-00418'
                       LET g_errparam.replace[1] = l_node.gldc003
                       LET g_errparam.replace[2] = g_master.l_gldnld
                       LET g_errparam.replace[3] = cl_getmsg('agl-00419',g_dlang),"(",l_glaa001,")"
                       LET g_errparam.extend = ''
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET l_success = FALSE   
                    END IF
                    
                    #功能幣沒抓到匯率
                    IF l_glaa015 = 'Y' THEN
                       IF (l_gldn027_o > 0 AND l_gldn027 = 0)
                          OR (l_gldn028_o > 0 AND l_gldn028 = 0) THEN
                          INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00420',g_dlang),"(",l_glaa016,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF        

                    #報告幣沒抓到匯率
                    IF l_glaa019 = 'Y' THEN
                       IF (l_gldn030_o > 0 AND l_gldn030 = 0)
                          OR (l_gldn031_o > 0 AND l_gldn031 = 0) THEN
                         INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00421',g_dlang),"(",l_glaa020,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF                 
                      #albrieo 151231-----e
                      #   l_累加*匯率 = l_累加*匯率 + 結果 * 匯率 
                      LET l_sumt.gldn010 = l_sumt.gldn010 + l_gldn010 #* l_gldn.gldn034   #albireo 151231
                      LET l_sumt.gldn011 = l_sumt.gldn011 + l_gldn011 #* l_gldn.gldn034
                      LET l_sumt.gldn027 = l_sumt.gldn027 + l_gldn027 #* l_gldn.gldn035
                      LET l_sumt.gldn028 = l_sumt.gldn028 + l_gldn028 #* l_gldn.gldn035
                      LET l_sumt.gldn030 = l_sumt.gldn030 + l_gldn030 #* l_gldn.gldn036
                      LET l_sumt.gldn031 = l_sumt.gldn031 + l_gldn031 #* l_gldn.gldn036
                   END FOREACH
                
                LET l_gldn.gldnent = g_enterprise
                LET l_gldn.gldnld  = g_master.l_gldnld
                LET l_gldn.gldn001 = g_master.l_gldn001
                
                #用合併帳+上層公司抓上層個體帳
                LET l_gldb002 = NULL
                SELECT gldb002 INTO l_gldb002 FROM gldb_t
                 WHERE gldbent = g_enterprise
                   AND gldb001 = g_master.l_gldn001
                   AND gldbld  = g_master.l_gldnld
                LET l_gldn.gldn002 = l_gldb002   
                
                LET l_gldn.gldn003 = g_master.l_yy
                LET l_gldn.gldn004 = g_master.l_mme
                LET l_gldn.gldn005 = g_master.l_yy
                LET l_gldn.gldn006 = g_master.l_mme
                #LET l_gldn.gldn007 = l_item.gldn007
                #LET l_gldn.gldn008 =
                #合併帳別取本位幣別-----             
                LET l_gldn.gldn009 = l_glaa001 
                LET l_gldn.gldn026 = l_glaa016
                LET l_gldn.gldn029 = l_glaa020
                #-----
                LET l_gldn.gldn010 = l_sumt.gldn010
                LET l_gldn.gldn011 = l_sumt.gldn011
                #借貸筆數-----
                #albireo 回頭在處理
               #LET l_gldn.gldn012 = l_gldh.gldh022
               #LET l_gldn.gldn013 = l_gldh.gldh023
                LET l_gldn.gldn012 = l_sumcountd
                LET l_gldn.gldn013 = l_sumcountc
                #-----
                LET l_gldn.gldn014 = l_item.gldn014
                LET l_gldn.gldn015 = l_item.gldn015
                LET l_gldn.gldn016 = l_item.gldn016
                LET l_gldn.gldn017 = l_item.gldn017
                LET l_gldn.gldn018 = l_item.gldn018
                LET l_gldn.gldn019 = l_item.gldn019
                LET l_gldn.gldn020 = l_item.gldn020
                LET l_gldn.gldn021 = l_item.gldn021
                LET l_gldn.gldn022 = l_item.gldn022
                LET l_gldn.gldn024 = l_item.gldn024
                LET l_gldn.gldn025 = l_item.gldn025
                 
                LET l_gldn.gldn027 = l_sumt.gldn027
                LET l_gldn.gldn028 = l_sumt.gldn028
                 
                LET l_gldn.gldn030 = l_sumt.gldn030
                LET l_gldn.gldn031 = l_sumt.gldn031
                LET l_gldn.gldn032 = l_node.gldc002
                LET l_gldn.gldn033 = l_node.gldc003
                 
                LET l_gldn.gldn037 = l_item.gldn037
                LET l_gldn.gldn038 = l_item.gldn038
                LET l_gldn.gldn039 = l_item.gldn039
                LET l_gldn.gldn040 = l_node.gldc002
                LET l_gldn.gldn041 = l_node.gldc003

                #處理個體公司來源累計額-----s
                LET l_gldn.gldn042 = l_sums.gldn010 
                LET l_gldn.gldn043 = l_sums.gldn011
                LET l_gldn.gldn044 = l_sums.gldn027
                LET l_gldn.gldn045 = l_sums.gldn028
                LET l_gldn.gldn046 = l_sums.gldn030
                LET l_gldn.gldn047 = l_sums.gldn031
                #處理個體公司來源累計額-----e

                #借貸金額都為0 就不往下做
                IF l_gldn.gldn010 = 0 AND l_gldn.gldn011 = 0 AND l_gldn.gldn027 = 0
                   AND l_gldn.gldn028 = 0 AND l_gldn.gldn030 = 0 AND l_gldn.gldn031 = 0 THEN
                   CONTINUE FOREACH
                END IF
                #INSERT gldn_t
                CALL g_gldn_ar.clear()
                LET g_gldn_ar[1].chr1  = l_gldn.gldn014 
                LET g_gldn_ar[2].chr1  = l_gldn.gldn015 
                LET g_gldn_ar[3].chr1  = l_gldn.gldn016 
                LET g_gldn_ar[4].chr1  = l_gldn.gldn017 
                LET g_gldn_ar[5].chr1  = l_gldn.gldn018 
                LET g_gldn_ar[6].chr1  = l_gldn.gldn019 
                LET g_gldn_ar[7].chr1  = l_gldn.gldn020 
                LET g_gldn_ar[8].chr1  = l_gldn.gldn021 
                LET g_gldn_ar[12].chr1  = l_gldn.gldn022 
                LET g_gldn_ar[13].chr1 = l_gldn.gldn024 
                LET g_gldn_ar[14].chr1 = l_gldn.gldn025 
                LET g_gldn_ar[9].chr1 = l_gldn.gldn037 
                LET g_gldn_ar[10].chr1 = l_gldn.gldn038 
                LET g_gldn_ar[11].chr1 = l_gldn.gldn039 
                
                #核算項轉換復合KEY
                CALL s_merge_get_gldn008(g_gldn_ar)RETURNING l_gldn.gldn008
                IF cl_null(l_gldn.gldn007) THEN CONTINUE FOREACH END IF
               #161128-00061#1----modify------begin-----------
               #INSERT INTO gldn_t VALUES(l_gldn.*)
               INSERT INTO gldn_t (gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn009,
                                   gldn010,gldn011,gldn012,gldn013,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,
                                   gldn021,gldn022,gldn024,gldn025,gldn026,gldn027,gldn028,gldn029,gldn030,gldn031,gldn032,
                                   gldn033,gldn034,gldn035,gldn036,gldn037,gldn038,gldn039,gldn040,gldn041,gldn042,gldn043,
                                   gldn044,gldn045,gldn046,gldn047)
                VALUES(l_gldn.gldnent,l_gldn.gldnld,l_gldn.gldn001,l_gldn.gldn002,l_gldn.gldn003,l_gldn.gldn004,l_gldn.gldn005,l_gldn.gldn006,l_gldn.gldn007,l_gldn.gldn008,l_gldn.gldn009,
                       l_gldn.gldn010,l_gldn.gldn011,l_gldn.gldn012,l_gldn.gldn013,l_gldn.gldn014,l_gldn.gldn015,l_gldn.gldn016,l_gldn.gldn017,l_gldn.gldn018,l_gldn.gldn019,l_gldn.gldn020,
                       l_gldn.gldn021,l_gldn.gldn022,l_gldn.gldn024,l_gldn.gldn025,l_gldn.gldn026,l_gldn.gldn027,l_gldn.gldn028,l_gldn.gldn029,l_gldn.gldn030,l_gldn.gldn031,l_gldn.gldn032,
                       l_gldn.gldn033,l_gldn.gldn034,l_gldn.gldn035,l_gldn.gldn036,l_gldn.gldn037,l_gldn.gldn038,l_gldn.gldn039,l_gldn.gldn040,l_gldn.gldn041,l_gldn.gldn042,l_gldn.gldn043,
                       l_gldn.gldn044,l_gldn.gldn045,l_gldn.gldn046,l_gldn.gldn047)
               #161128-00061#1----modify------end-----------
                IF SQLCA.SQLCODE THEN
                   INITIALIZE g_errparam.* TO NULL
                   LET g_errparam.code = SQLCA.SQLCODE 
                   LET g_errparam.extend = " INSERT gldn "
                   CALL cl_err()
                END IF 
            END FOREACH
         
         END IF
      END IF
      
      IF l_node.gldc009 = 'N' AND l_root THEN
            #T100       1.gldn009 = 'N'   AND 有下階  = 合併帳
            #(FOREACH)             抓gleb   上傳檔   

            #FOREACH gleb 個體帳 (0~N月) 取 科目+核算項
            FOREACH sel_glebc1n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                      l_node.gldc002,l_node.gldc003       
                                INTO l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                     l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                     l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                     l_item.gldn037,l_item.gldn038,l_item.gldn039,l_item.key
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = 'sel_glebc1n'
                  CALL cl_err()
                  EXIT FOREACH
               END IF 

               INITIALIZE l_gldn.* TO NULL

               #組複合KEY 抓合併科目  匯率轉換原則用
               CALL g_gldn_ar.clear()
               LET g_gldn_ar[1].chr1  = l_item.gldn014 
               LET g_gldn_ar[2].chr1  = l_item.gldn015 
               LET g_gldn_ar[3].chr1  = l_item.gldn016 
               LET g_gldn_ar[4].chr1  = l_item.gldn017 
               LET g_gldn_ar[5].chr1  = l_item.gldn018 
               LET g_gldn_ar[6].chr1  = l_item.gldn019 
               LET g_gldn_ar[7].chr1  = l_item.gldn020 
               LET g_gldn_ar[8].chr1  = l_item.gldn021 
               LET g_gldn_ar[12].chr1 = l_item.gldn022 
               LET g_gldn_ar[13].chr1 = l_item.gldn024 
               LET g_gldn_ar[14].chr1 = l_item.gldn025 
               LET g_gldn_ar[9].chr1  = l_item.gldn037 
               LET g_gldn_ar[10].chr1 = l_item.gldn038 
               LET g_gldn_ar[11].chr1 = l_item.gldn039 

               #抓取匯率轉換原則-----s
               LET l_gldn007p = l_item.gldn007
               CALL aglp700_get_item(g_master.l_gldn001,g_master.l_gldnld,
                                     l_node.gldc002,l_node.gldc003,l_item.gldn007,g_gldn_ar)
                  RETURNING g_sub_success,l_gldn.gldn007,l_gldf.gldf008,l_gldf.gldf009,l_gldf.gldf010
               IF NOT g_sub_success THEN
                  LET l_success = FALSE
                  #CONTINUE FOREACH   #後續還是要繼續檢查
               END IF           
               #抓取匯率轉換原則------e

                  #LET l_累加總帳6個
                  LET l_sums.gldn010 = 0    LET l_sums.gldn027 = 0    LET l_sums.gldn030 = 0 
                  LET l_sums.gldn011 = 0    LET l_sums.gldn028 = 0    LET l_sums.gldn031 = 0 
                  #LET l_累加*匯率6個            
                  LET l_sumt.gldn010 = 0    LET l_sumt.gldn027 = 0    LET l_sumt.gldn030 = 0 
                  LET l_sumt.gldn011 = 0    LET l_sumt.gldn028 = 0    LET l_sumt.gldn031 = 0 

                   LET l_sumcountd = 0    LET l_sumcountc = 0 
                   #FOREACH 個體帳+ 科目+核算項  取   年 月
                   FOREACH sel_glebc2n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                             l_node.gldc002,l_node.gldc003,
                                             l_item.gldn007,l_item.key
                                       INTO l_yy,l_mm
                      IF SQLCA.SQLCODE THEN
                         INITIALIZE g_errparam.* TO NULL
                         LET g_errparam.code = SQLCA.SQLCODE
                         LET g_errparam.extend = 'sel_glebc2n'
                         CALL cl_err()
                         EXIT FOREACH
                      END IF 
                      #   1.取此個體帳+ 科目+核算項 + 此年月 gleb 值
                      EXECUTE sel_glebp3n USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                             l_item.gldn007,l_item.key
                                          INTO l_gldn010,l_gldn011,l_gldn027,l_gldn028,
                                               l_gldn030,l_gldn031
                      IF cl_null(l_gldn010)THEN LET l_gldn010 = 0 END IF
                      IF cl_null(l_gldn011)THEN LET l_gldn011 = 0 END IF
                      IF cl_null(l_gldn027)THEN LET l_gldn027 = 0 END IF
                      IF cl_null(l_gldn028)THEN LET l_gldn028 = 0 END IF
                      IF cl_null(l_gldn030)THEN LET l_gldn030 = 0 END IF
                      IF cl_null(l_gldn031)THEN LET l_gldn031 = 0 END IF

                      #albireo 160303-----s
                      EXECUTE sel_glebp4d USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                             l_item.gldn007,l_item.key
                                          INTO l_countd
                      EXECUTE sel_glebp4c USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                             l_item.gldn007,l_item.key
                                          INTO l_countc
                                          
                      LET l_sumcountd = l_sumcountd + l_countd
                      LET l_sumcountc = l_sumcountc + l_countc
                      #albireo 160303-----e
                      #  l_累加總帳 = l_累加總帳+結果
                      LET l_sums.gldn010 = l_sums.gldn010 + l_gldn010
                      LET l_sums.gldn011 = l_sums.gldn011 + l_gldn011
                      LET l_sums.gldn027 = l_sums.gldn027 + l_gldn027
                      LET l_sums.gldn028 = l_sums.gldn028 + l_gldn028
                      LET l_sums.gldn030 = l_sums.gldn030 + l_gldn030
                      LET l_sums.gldn031 = l_sums.gldn031 + l_gldn031
                   
                      #albireo 151231-----s
                      #存舊值比較用
                      LET l_gldn010_o = l_gldn010         #換匯前金額(記帳幣)
                      LET l_gldn011_o = l_gldn011
                      LET l_gldn027_o = l_gldn027         #換匯前金額(功能幣)
                      LET l_gldn028_o = l_gldn028
                      LET l_gldn030_o = l_gldn030         #換匯前金額(報告幣)
                      LET l_gldn031_o = l_gldn031

                      LET l_examtin.up_ld   = g_master.l_gldnld        #合併帳別(合併主體)
                      LET l_examtin.up_comp = g_master.l_gldn001         #上層公司
                      LET l_examtin.dn_ld   = l_node.gldc003    #下層帳別
                      LET l_examtin.dn_comp = l_node.gldc002    #下層公司
                      LET l_examtin.yy      = l_yy              #年度
                      LET l_examtin.mm      = l_mm              #期別
                      LET l_examtin.acc     = l_item.gldn007    #科目
                      LET l_examtin.tabname = 'gldn_t'          #餘額來源table
                      LET l_examtin.curr1   = l_glaas.glaa001   #幣別(記帳幣)         
                      LET l_examtin.curr2   = l_glaas.glaa016   #幣別(功能幣)         
                      LET l_examtin.curr3   = l_glaas.glaa020   #幣別(報告幣)         
                      LET l_examtin.amt1    = l_gldn010         #換匯前金額(記帳幣)
                      LET l_examtin.amt1_2  = l_gldn011
                      LET l_examtin.amt2    = l_gldn027         #換匯前金額(功能幣)
                      LET l_examtin.amt2_2  = l_gldn028
                      LET l_examtin.amt3    = l_gldn030         #換匯前金額(報告幣)
                      LET l_examtin.amt3_2  = l_gldn031
                      LET l_examtin.type1   = l_gldf.gldf008             #記帳幣換算類別
                      LET l_examtin.type2   = l_gldf.gldf009             #功能幣換算類別
                      LET l_examtin.type3   = l_gldf.gldf010             #報告幣換算類別
                      LET l_examtin.source  = ''           #來源A/對沖B
                      

                      #albireo 160309-----s
                      LET l_examtin.acc2 = l_item.gldn007
                      LET l_glaa134 = NULL
                      SELECT glaa134 INTO l_glaa134 FROM glaa_t
                       WHERE glaaent = g_enterprise
                         AND glaald = l_node.gldc003
                      CASE
                         WHEN cl_null(l_glaa134) OR l_glaa134 = '0'
                            LET l_examtin.act1 = NULL
                         OTHERWISE
                            LET l_examtin.act1 = g_gldn_ar[l_glaa134].chr1
                      END CASE
                      #albireo 160309-----e
                      #albireo 160311-----s
                      CALL s_fin_date_get_lastday(l_node.gldc003,'',l_yy,g_master.l_mme,'')RETURNING  g_sub_success,l_examtin.edat 
                      #albireo 160311-----e
                      
                      LET ls_jsin = util.JSON.stringify(l_examtin)
                      CALL s_merge_get_examt(ls_jsin)RETURNING ls_jsout
                      CALL util.JSON.parse(ls_jsout,l_examtout)
                      LET l_gldn010 = l_examtout.r_amt1
                      LET l_gldn011 = l_examtout.r_amt1_2
                      LET l_gldn027 = l_examtout.r_amt2
                      LET l_gldn028 = l_examtout.r_amt2_2
                      LET l_gldn030 = l_examtout.r_amt3
                      LET l_gldn031 = l_examtout.r_amt3_2
                      #albireo 160225-----s
                      LET l_gldn.gldn034 = l_examtout.r_rate1
                      LET l_gldn.gldn035 = l_examtout.r_rate2
                      LET l_gldn.gldn036 = l_examtout.r_rate3
                      #albireo 160225-----e
                      
                     #計帳幣沒抓到匯率
                    IF (l_gldn010_o > 0 AND l_gldn010 = 0)
                       OR (l_gldn011_o > 0 AND l_gldn011 = 0) THEN
                       INITIALIZE g_errparam.* TO NULL
                       LET g_errparam.code = 'agl-00418'
                       LET g_errparam.replace[1] = l_node.gldc003
                       LET g_errparam.replace[2] = g_master.l_gldnld
                       LET g_errparam.replace[3] = cl_getmsg('agl-00419',g_dlang),"(",l_glaa001,")"
                       LET g_errparam.extend = ''
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET l_success = FALSE   
                    END IF
                    
                    #功能幣沒抓到匯率
                    IF l_glaa015 = 'Y' THEN
                       IF (l_gldn027_o > 0 AND l_gldn027 = 0)
                          OR (l_gldn028_o > 0 AND l_gldn028 = 0) THEN
                          INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00420',g_dlang),"(",l_glaa016,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF        

                    #報告幣沒抓到匯率
                    IF l_glaa019 = 'Y' THEN
                       IF (l_gldn030_o > 0 AND l_gldn030 = 0)
                          OR (l_gldn031_o > 0 AND l_gldn031 = 0) THEN
                         INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00421',g_dlang),"(",l_glaa020,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF                                       
                      #albireo 151231-----e
                      #   l_累加*匯率 = l_累加*匯率 + 結果 * 匯率 
                      LET l_sumt.gldn010 = l_sumt.gldn010 + l_gldn010 #* l_gldn.gldn034
                      LET l_sumt.gldn011 = l_sumt.gldn011 + l_gldn011 #* l_gldn.gldn034
                      LET l_sumt.gldn027 = l_sumt.gldn027 + l_gldn027 #* l_gldn.gldn035
                      LET l_sumt.gldn028 = l_sumt.gldn028 + l_gldn028 #* l_gldn.gldn035
                      LET l_sumt.gldn030 = l_sumt.gldn030 + l_gldn030 #* l_gldn.gldn036
                      LET l_sumt.gldn031 = l_sumt.gldn031 + l_gldn031 #* l_gldn.gldn036   #albireo 151231 l_gldn031已含匯率
                   END FOREACH
                #END IF    151113-00002#20 mark

                ##平均匯率後兩種模式-----s
                #依此種模式計算已經不用重記
                #LET l_累加*匯率 = l_累加總帳 * 匯率
                ##-----------------------e
                
                LET l_gldn.gldnent = g_enterprise
                LET l_gldn.gldnld  = g_master.l_gldnld
                LET l_gldn.gldn001 = g_master.l_gldn001
                
                #用合併帳+上層公司抓上層個體帳
                LET l_gldb002 = NULL
                SELECT gldb002 INTO l_gldb002 FROM gldb_t
                 WHERE gldbent = g_enterprise
                   AND gldb001 = g_master.l_gldn001
                   AND gldbld  = g_master.l_gldnld
                LET l_gldn.gldn002 = l_gldb002   
                
                LET l_gldn.gldn003 = g_master.l_yy
                LET l_gldn.gldn004 = g_master.l_mme
                LET l_gldn.gldn005 = g_master.l_yy
                LET l_gldn.gldn006 = g_master.l_mme
                #LET l_gldn.gldn007 = l_item.gldn007
                #LET l_gldn.gldn008 =
                #合併帳別取本位幣別-----             
                LET l_gldn.gldn009 = l_glaa001 
                LET l_gldn.gldn026 = l_glaa016
                LET l_gldn.gldn029 = l_glaa020
                #-----
                LET l_gldn.gldn010 = l_sumt.gldn010
                LET l_gldn.gldn011 = l_sumt.gldn011
                #借貸筆數-----
                #albireo 回頭在處理
               #LET l_gldn.gldn012 = l_gldh.gldh022
               #LET l_gldn.gldn013 = l_gldh.gldh023
               
                LET l_gldn.gldn012 = l_sumcountd
                LET l_gldn.gldn013 = l_sumcountc
                #-----
                LET l_gldn.gldn014 = l_item.gldn014
                LET l_gldn.gldn015 = l_item.gldn015
                LET l_gldn.gldn016 = l_item.gldn016
                LET l_gldn.gldn017 = l_item.gldn017
                LET l_gldn.gldn018 = l_item.gldn018
                LET l_gldn.gldn019 = l_item.gldn019
                LET l_gldn.gldn020 = l_item.gldn020
                LET l_gldn.gldn021 = l_item.gldn021
                LET l_gldn.gldn022 = l_item.gldn022
                LET l_gldn.gldn024 = l_item.gldn024
                LET l_gldn.gldn025 = l_item.gldn025
                 
                LET l_gldn.gldn027 = l_sumt.gldn027
                LET l_gldn.gldn028 = l_sumt.gldn028
                 
                LET l_gldn.gldn030 = l_sumt.gldn030
                LET l_gldn.gldn031 = l_sumt.gldn031
                LET l_gldn.gldn032 = l_node.gldc002
                LET l_gldn.gldn033 = l_node.gldc003
                 
                LET l_gldn.gldn037 = l_item.gldn037
                LET l_gldn.gldn038 = l_item.gldn038
                LET l_gldn.gldn039 = l_item.gldn039
                LET l_gldn.gldn040 = l_node.gldc002
                LET l_gldn.gldn041 = l_node.gldc003

                #處理個體公司來源累計額-----s
                LET l_gldn.gldn042 = l_sums.gldn010 
                LET l_gldn.gldn043 = l_sums.gldn011
                LET l_gldn.gldn044 = l_sums.gldn027
                LET l_gldn.gldn045 = l_sums.gldn028
                LET l_gldn.gldn046 = l_sums.gldn030
                LET l_gldn.gldn047 = l_sums.gldn031
                #處理個體公司來源累計額-----e

                #借貸金額都為0 就不往下做
                IF l_gldn.gldn010 = 0 AND l_gldn.gldn011 = 0 AND l_gldn.gldn027 = 0
                   AND l_gldn.gldn028 = 0 AND l_gldn.gldn030 = 0 AND l_gldn.gldn031 = 0 THEN
                   CONTINUE FOREACH
                END IF
                #INSERT gldn_t
                CALL g_gldn_ar.clear()
                LET g_gldn_ar[1].chr1  = l_gldn.gldn014 
                LET g_gldn_ar[2].chr1  = l_gldn.gldn015 
                LET g_gldn_ar[3].chr1  = l_gldn.gldn016 
                LET g_gldn_ar[4].chr1  = l_gldn.gldn017 
                LET g_gldn_ar[5].chr1  = l_gldn.gldn018 
                LET g_gldn_ar[6].chr1  = l_gldn.gldn019 
                LET g_gldn_ar[7].chr1  = l_gldn.gldn020 
                LET g_gldn_ar[8].chr1  = l_gldn.gldn021 
                LET g_gldn_ar[12].chr1  = l_gldn.gldn022 
                LET g_gldn_ar[13].chr1 = l_gldn.gldn024 
                LET g_gldn_ar[14].chr1 = l_gldn.gldn025 
                LET g_gldn_ar[9].chr1 = l_gldn.gldn037 
                LET g_gldn_ar[10].chr1 = l_gldn.gldn038 
                LET g_gldn_ar[11].chr1 = l_gldn.gldn039 
                
                #核算項轉換復合KEY
                CALL s_merge_get_gldn008(g_gldn_ar)RETURNING l_gldn.gldn008
                IF cl_null(l_gldn.gldn007) THEN CONTINUE FOREACH END IF
               #161128-00061#1----modify------begin-----------
               #INSERT INTO gldn_t VALUES(l_gldn.*)
               INSERT INTO gldn_t (gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn009,
                                   gldn010,gldn011,gldn012,gldn013,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,
                                   gldn021,gldn022,gldn024,gldn025,gldn026,gldn027,gldn028,gldn029,gldn030,gldn031,gldn032,
                                   gldn033,gldn034,gldn035,gldn036,gldn037,gldn038,gldn039,gldn040,gldn041,gldn042,gldn043,
                                   gldn044,gldn045,gldn046,gldn047)
                VALUES(l_gldn.gldnent,l_gldn.gldnld,l_gldn.gldn001,l_gldn.gldn002,l_gldn.gldn003,l_gldn.gldn004,l_gldn.gldn005,l_gldn.gldn006,l_gldn.gldn007,l_gldn.gldn008,l_gldn.gldn009,
                       l_gldn.gldn010,l_gldn.gldn011,l_gldn.gldn012,l_gldn.gldn013,l_gldn.gldn014,l_gldn.gldn015,l_gldn.gldn016,l_gldn.gldn017,l_gldn.gldn018,l_gldn.gldn019,l_gldn.gldn020,
                       l_gldn.gldn021,l_gldn.gldn022,l_gldn.gldn024,l_gldn.gldn025,l_gldn.gldn026,l_gldn.gldn027,l_gldn.gldn028,l_gldn.gldn029,l_gldn.gldn030,l_gldn.gldn031,l_gldn.gldn032,
                       l_gldn.gldn033,l_gldn.gldn034,l_gldn.gldn035,l_gldn.gldn036,l_gldn.gldn037,l_gldn.gldn038,l_gldn.gldn039,l_gldn.gldn040,l_gldn.gldn041,l_gldn.gldn042,l_gldn.gldn043,
                       l_gldn.gldn044,l_gldn.gldn045,l_gldn.gldn046,l_gldn.gldn047)
               #161128-00061#1----modify------end-----------
                IF SQLCA.SQLCODE THEN
                   INITIALIZE g_errparam.* TO NULL
                   LET g_errparam.code = SQLCA.SQLCODE 
                   LET g_errparam.extend = " INSERT gldn "
                   CALL cl_err()
                END IF 
            END FOREACH
      END IF
       
      #T100 
      #(FOREACH)       #不含在glar中的aglt502個體調整傳票
     
      #FOREACH gleb 個體帳 (0~N月) 取 科目+核算項
      #存在aglt502資料但不存在glar的
      FOREACH sel_gldqc1n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                l_node.gldc002,l_node.gldc003       
                          INTO l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                               l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                               l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                               l_item.gldn037,l_item.gldn038,l_item.gldn039,l_item.key
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'sel_gldqc1n'
            CALL cl_err()
            EXIT FOREACH
         END IF 

         INITIALIZE l_gldn.* TO NULL

         #組複合KEY 抓合併科目  匯率轉換原則用
         CALL g_gldn_ar.clear()
         LET g_gldn_ar[1].chr1  = l_item.gldn014 
         LET g_gldn_ar[2].chr1  = l_item.gldn015 
         LET g_gldn_ar[3].chr1  = l_item.gldn016 
         LET g_gldn_ar[4].chr1  = l_item.gldn017 
         LET g_gldn_ar[5].chr1  = l_item.gldn018 
         LET g_gldn_ar[6].chr1  = l_item.gldn019 
         LET g_gldn_ar[7].chr1  = l_item.gldn020 
         LET g_gldn_ar[8].chr1  = l_item.gldn021 
         LET g_gldn_ar[12].chr1 = l_item.gldn022 
         LET g_gldn_ar[13].chr1 = l_item.gldn024 
         LET g_gldn_ar[14].chr1 = l_item.gldn025 
         LET g_gldn_ar[9].chr1  = l_item.gldn037 
         LET g_gldn_ar[10].chr1 = l_item.gldn038 
         LET g_gldn_ar[11].chr1 = l_item.gldn039 

         #抓取匯率轉換原則-----s
         LET l_gldn007p = l_item.gldn007
         CALL aglp700_get_item(g_master.l_gldn001,g_master.l_gldnld,
                               l_node.gldc002,l_node.gldc003,l_item.gldn007,g_gldn_ar)
            RETURNING g_sub_success,l_gldn.gldn007,l_gldf.gldf008,l_gldf.gldf009,l_gldf.gldf010
         IF NOT g_sub_success THEN
            #抓不到轉換原則報錯
            LET l_success = FALSE
            #CONTINUE FOREACH
         END IF          
         #抓取匯率轉換原則------e

 
            #LET l_累加總帳6個
            LET l_sums.gldn010 = 0    LET l_sums.gldn027 = 0    LET l_sums.gldn030 = 0 
            LET l_sums.gldn011 = 0    LET l_sums.gldn028 = 0    LET l_sums.gldn031 = 0 
            #LET l_累加*匯率6個            
            LET l_sumt.gldn010 = 0    LET l_sumt.gldn027 = 0    LET l_sumt.gldn030 = 0 
            LET l_sumt.gldn011 = 0    LET l_sumt.gldn028 = 0    LET l_sumt.gldn031 = 0 

             LET l_sumcountd = 0 LET l_sumcountc = 0
             #FOREACH 個體帳+ 科目+核算項  取   年 月
             FOREACH sel_gldqc2n USING g_master.l_yy,g_master.l_mms,g_master.l_mme,
                                       l_node.gldc002,l_node.gldc003,
                                       l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                       l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                       l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                       l_item.gldn037,l_item.gldn038,l_item.gldn039
                                 INTO l_yy,l_mm
                IF SQLCA.SQLCODE THEN
                   INITIALIZE g_errparam.* TO NULL
                   LET g_errparam.code = SQLCA.SQLCODE
                   LET g_errparam.extend = 'sel_gldqc2n'
                   CALL cl_err()
                   EXIT FOREACH
                END IF 
                #   1.取此個體帳+ 科目+核算項 + 此年月 gleb 值
                EXECUTE sel_gldqp3n USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                       l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                       l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                       l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                       l_item.gldn037,l_item.gldn038,l_item.gldn039
                                    INTO l_gldn010,l_gldn011,l_gldn027,l_gldn028,
                                         l_gldn030,l_gldn031
                IF cl_null(l_gldn010)THEN LET l_gldn010 = 0 END IF
                IF cl_null(l_gldn011)THEN LET l_gldn011 = 0 END IF
                IF cl_null(l_gldn027)THEN LET l_gldn027 = 0 END IF
                IF cl_null(l_gldn028)THEN LET l_gldn028 = 0 END IF
                IF cl_null(l_gldn030)THEN LET l_gldn030 = 0 END IF
                IF cl_null(l_gldn031)THEN LET l_gldn031 = 0 END IF

                #albireo 160303-----s
                EXECUTE sel_gldqp4d USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                       l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                       l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                       l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                       l_item.gldn037,l_item.gldn038,l_item.gldn039
                                    INTO l_countd
                EXECUTE sel_gldqp4c USING l_yy,l_mm,l_node.gldc002,l_node.gldc003,
                                       l_item.gldn007,l_item.gldn014,l_item.gldn015,l_item.gldn016,
                                       l_item.gldn017,l_item.gldn018,l_item.gldn019,l_item.gldn020,
                                       l_item.gldn021,l_item.gldn022,l_item.gldn024,l_item.gldn025,
                                       l_item.gldn037,l_item.gldn038,l_item.gldn039
                                    INTO l_countc
                LET l_sumcountd = l_sumcountd + l_countd
                LET l_sumcountc = l_sumcountc + l_countc
                #albireo 160303-----e
                
                #  l_累加總帳 = l_累加總帳+結果
                LET l_sums.gldn010 = l_sums.gldn010 + l_gldn010
                LET l_sums.gldn011 = l_sums.gldn011 + l_gldn011
                LET l_sums.gldn027 = l_sums.gldn027 + l_gldn027
                LET l_sums.gldn028 = l_sums.gldn028 + l_gldn028
                LET l_sums.gldn030 = l_sums.gldn030 + l_gldn030
                LET l_sums.gldn031 = l_sums.gldn031 + l_gldn031
             
                #albireo 151231-----s
                #存舊值比較用
                LET l_gldn010_o = l_gldn010         #換匯前金額(記帳幣)
                LET l_gldn011_o = l_gldn011
                LET l_gldn027_o = l_gldn027         #換匯前金額(功能幣)
                LET l_gldn028_o = l_gldn028
                LET l_gldn030_o = l_gldn030         #換匯前金額(報告幣)
                LET l_gldn031_o = l_gldn031  
                #   #取匯率  傳入此年月

                LET l_examtin.up_ld   = g_master.l_gldnld        #合併帳別(合併主體)
                LET l_examtin.up_comp = g_master.l_gldn001         #上層公司
                LET l_examtin.dn_ld   = l_node.gldc003    #下層帳別
                LET l_examtin.dn_comp = l_node.gldc002    #下層公司
                LET l_examtin.yy      = l_yy              #年度
                LET l_examtin.mm      = l_mm              #期別
                LET l_examtin.acc     = l_item.gldn007    #科目
                LET l_examtin.tabname = 'gldn_t'          #餘額來源table
                LET l_examtin.curr1   = l_glaas.glaa001   #幣別(記帳幣)         
                LET l_examtin.curr2   = l_glaas.glaa016   #幣別(功能幣)         
                LET l_examtin.curr3   = l_glaas.glaa020   #幣別(報告幣)         
                LET l_examtin.amt1    = l_gldn010         #換匯前金額(記帳幣)
                LET l_examtin.amt1_2  = l_gldn011
                LET l_examtin.amt2    = l_gldn027         #換匯前金額(功能幣)
                LET l_examtin.amt2_2  = l_gldn028
                LET l_examtin.amt3    = l_gldn030         #換匯前金額(報告幣)
                LET l_examtin.amt3_2  = l_gldn031
                LET l_examtin.type1   = l_gldf.gldf008             #記帳幣換算類別
                LET l_examtin.type2   = l_gldf.gldf009             #功能幣換算類別
                LET l_examtin.type3   = l_gldf.gldf010             #報告幣換算類別
                LET l_examtin.source  = ''           #來源A/對沖B
                

                #albireo 160309-----s
                LET l_examtin.acc2 = l_item.gldn007
                LET l_glaa134 = NULL
                SELECT glaa134 INTO l_glaa134 FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = l_node.gldc003
                CASE
                   WHEN cl_null(l_glaa134) OR l_glaa134 = '0'
                      LET l_examtin.act1 = NULL
                   OTHERWISE
                      LET l_examtin.act1 = g_gldn_ar[l_glaa134].chr1
                END CASE
                #albireo 160309-----e
                #albireo 160311-----s
                CALL s_fin_date_get_lastday(l_node.gldc003,'',l_yy,g_master.l_mme,'')RETURNING  g_sub_success,l_examtin.edat 
                #albireo 160311-----e
                
                LET ls_jsin = util.JSON.stringify(l_examtin)
                CALL s_merge_get_examt(ls_jsin)RETURNING ls_jsout
                CALL util.JSON.parse(ls_jsout,l_examtout)
                LET l_gldn010 = l_examtout.r_amt1
                LET l_gldn011 = l_examtout.r_amt1_2
                LET l_gldn027 = l_examtout.r_amt2
                LET l_gldn028 = l_examtout.r_amt2_2
                LET l_gldn030 = l_examtout.r_amt3
                LET l_gldn031 = l_examtout.r_amt3_2
                #albireo 160225-----s
                LET l_gldn.gldn034 = l_examtout.r_rate1
                LET l_gldn.gldn035 = l_examtout.r_rate2
                LET l_gldn.gldn036 = l_examtout.r_rate3
                #albireo 160225-----e
                
#計帳幣沒抓到匯率
                    IF (l_gldn010_o > 0 AND l_gldn010 = 0)
                       OR (l_gldn011_o > 0 AND l_gldn011 = 0) THEN
                       INITIALIZE g_errparam.* TO NULL
                       LET g_errparam.code = 'agl-00418'
                       LET g_errparam.replace[1] = l_node.gldc003
                       LET g_errparam.replace[2] = g_master.l_gldnld
                       LET g_errparam.replace[3] = cl_getmsg('agl-00419',g_dlang),"(",l_glaa001,")"
                       LET g_errparam.extend = ''
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET l_success = FALSE   
                    END IF
                    
                    #功能幣沒抓到匯率
                    IF l_glaa015 = 'Y' THEN
                       IF (l_gldn027_o > 0 AND l_gldn027 = 0)
                          OR (l_gldn028_o > 0 AND l_gldn028 = 0) THEN
                          INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00420',g_dlang),"(",l_glaa016,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF        

                    #報告幣沒抓到匯率
                    IF l_glaa019 = 'Y' THEN
                       IF (l_gldn030_o > 0 AND l_gldn030 = 0)
                          OR (l_gldn031_o > 0 AND l_gldn031 = 0) THEN
                         INITIALIZE g_errparam.* TO NULL
                          LET g_errparam.code = 'agl-00418'
                          LET g_errparam.replace[1] = l_node.gldc003
                          LET g_errparam.replace[2] = g_master.l_gldnld
                          LET g_errparam.replace[3] = cl_getmsg('agl-00421',g_dlang),"(",l_glaa020,")"
                          LET g_errparam.extend = ''
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          LET l_success = FALSE
                       END IF                 
                    END IF                 
                #albireo 151231-----e
                #   l_累加*匯率 = l_累加*匯率 + 結果 * 匯率 
                LET l_sumt.gldn010 = l_sumt.gldn010 + l_gldn010 #* l_gldn.gldn034
                LET l_sumt.gldn011 = l_sumt.gldn011 + l_gldn011 #* l_gldn.gldn034
                LET l_sumt.gldn027 = l_sumt.gldn027 + l_gldn027 #* l_gldn.gldn035
                LET l_sumt.gldn028 = l_sumt.gldn028 + l_gldn028 #* l_gldn.gldn035
                LET l_sumt.gldn030 = l_sumt.gldn030 + l_gldn030 #* l_gldn.gldn036
                LET l_sumt.gldn031 = l_sumt.gldn031 + l_gldn031 #* l_gldn.gldn036
             END FOREACH
          #END IF   151113-00002#20 mark

          ##平均匯率後兩種模式-----s
          #依此種模式計算已經不用重記
          #LET l_累加*匯率 = l_累加總帳 * 匯率
          ##-----------------------e
          
          LET l_gldn.gldnent = g_enterprise
          LET l_gldn.gldnld  = g_master.l_gldnld
          LET l_gldn.gldn001 = g_master.l_gldn001
          
          #用合併帳+上層公司抓上層個體帳
          LET l_gldb002 = NULL
          SELECT gldb002 INTO l_gldb002 FROM gldb_t
           WHERE gldbent = g_enterprise
             AND gldb001 = g_master.l_gldn001
             AND gldbld  = g_master.l_gldnld
          LET l_gldn.gldn002 = l_gldb002   
          
          LET l_gldn.gldn003 = g_master.l_yy
          LET l_gldn.gldn004 = g_master.l_mme
          LET l_gldn.gldn005 = g_master.l_yy
          LET l_gldn.gldn006 = g_master.l_mme
          #LET l_gldn.gldn007 = l_item.gldn007
          #LET l_gldn.gldn008 =
          #合併帳別取本位幣別-----             
          LET l_gldn.gldn009 = l_glaa001 
          LET l_gldn.gldn026 = l_glaa016
          LET l_gldn.gldn029 = l_glaa020
          #-----
          LET l_gldn.gldn010 = l_sumt.gldn010
          LET l_gldn.gldn011 = l_sumt.gldn011
          #借貸筆數-----
          #albireo 回頭在處理
         #LET l_gldn.gldn012 = l_gldh.gldh022
         #LET l_gldn.gldn013 = l_gldh.gldh023
         
          LET l_gldn.gldn012 = l_sumcountd
          LEt l_gldn.gldn013 = l_sumcountc
          #-----
          LET l_gldn.gldn014 = l_item.gldn014
          LET l_gldn.gldn015 = l_item.gldn015
          LET l_gldn.gldn016 = l_item.gldn016
          LET l_gldn.gldn017 = l_item.gldn017
          LET l_gldn.gldn018 = l_item.gldn018
          LET l_gldn.gldn019 = l_item.gldn019
          LET l_gldn.gldn020 = l_item.gldn020
          LET l_gldn.gldn021 = l_item.gldn021
          LET l_gldn.gldn022 = l_item.gldn022
          LET l_gldn.gldn024 = l_item.gldn024
          LET l_gldn.gldn025 = l_item.gldn025
           
          LET l_gldn.gldn027 = l_sumt.gldn027
          LET l_gldn.gldn028 = l_sumt.gldn028
           
          LET l_gldn.gldn030 = l_sumt.gldn030
          LET l_gldn.gldn031 = l_sumt.gldn031
          LET l_gldn.gldn032 = l_node.gldc002
          LET l_gldn.gldn033 = l_node.gldc003
           
          LET l_gldn.gldn037 = l_item.gldn037
          LET l_gldn.gldn038 = l_item.gldn038
          LET l_gldn.gldn039 = l_item.gldn039
          LET l_gldn.gldn040 = l_node.gldc002
          LET l_gldn.gldn041 = l_node.gldc003

          #處理個體公司來源累計額-----s
          LET l_gldn.gldn042 = l_sums.gldn010 
          LET l_gldn.gldn043 = l_sums.gldn011
          LET l_gldn.gldn044 = l_sums.gldn027
          LET l_gldn.gldn045 = l_sums.gldn028
          LET l_gldn.gldn046 = l_sums.gldn030
          LET l_gldn.gldn047 = l_sums.gldn031
          #處理個體公司來源累計額-----e

          #借貸金額都為0 就不往下做
          IF l_gldn.gldn010 = 0 AND l_gldn.gldn011 = 0 AND l_gldn.gldn027 = 0
             AND l_gldn.gldn028 = 0 AND l_gldn.gldn030 = 0 AND l_gldn.gldn031 = 0 THEN
             CONTINUE FOREACH
          END IF
          #INSERT gldn_t
                   CALL g_gldn_ar.clear()
         LET g_gldn_ar[1].chr1  = l_gldn.gldn014 
         LET g_gldn_ar[2].chr1  = l_gldn.gldn015 
         LET g_gldn_ar[3].chr1  = l_gldn.gldn016 
         LET g_gldn_ar[4].chr1  = l_gldn.gldn017 
         LET g_gldn_ar[5].chr1  = l_gldn.gldn018 
         LET g_gldn_ar[6].chr1  = l_gldn.gldn019 
         LET g_gldn_ar[7].chr1  = l_gldn.gldn020 
         LET g_gldn_ar[8].chr1  = l_gldn.gldn021 
         LET g_gldn_ar[12].chr1  = l_gldn.gldn022 
         LET g_gldn_ar[13].chr1 = l_gldn.gldn024 
         LET g_gldn_ar[14].chr1 = l_gldn.gldn025 
         LET g_gldn_ar[9].chr1 = l_gldn.gldn037 
         LET g_gldn_ar[10].chr1 = l_gldn.gldn038 
         LET g_gldn_ar[11].chr1 = l_gldn.gldn039 
         
         #核算項轉換復合KEY
         CALL s_merge_get_gldn008(g_gldn_ar)RETURNING l_gldn.gldn008
         IF cl_null(l_gldn.gldn007) THEN CONTINUE FOREACH END IF
           #161128-00061#1----modify------begin-----------
           #INSERT INTO gldn_t VALUES(l_gldn.*)
           INSERT INTO gldn_t (gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn009,
                               gldn010,gldn011,gldn012,gldn013,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,
                               gldn021,gldn022,gldn024,gldn025,gldn026,gldn027,gldn028,gldn029,gldn030,gldn031,gldn032,
                               gldn033,gldn034,gldn035,gldn036,gldn037,gldn038,gldn039,gldn040,gldn041,gldn042,gldn043,
                               gldn044,gldn045,gldn046,gldn047)
            VALUES(l_gldn.gldnent,l_gldn.gldnld,l_gldn.gldn001,l_gldn.gldn002,l_gldn.gldn003,l_gldn.gldn004,l_gldn.gldn005,l_gldn.gldn006,l_gldn.gldn007,l_gldn.gldn008,l_gldn.gldn009,
                   l_gldn.gldn010,l_gldn.gldn011,l_gldn.gldn012,l_gldn.gldn013,l_gldn.gldn014,l_gldn.gldn015,l_gldn.gldn016,l_gldn.gldn017,l_gldn.gldn018,l_gldn.gldn019,l_gldn.gldn020,
                   l_gldn.gldn021,l_gldn.gldn022,l_gldn.gldn024,l_gldn.gldn025,l_gldn.gldn026,l_gldn.gldn027,l_gldn.gldn028,l_gldn.gldn029,l_gldn.gldn030,l_gldn.gldn031,l_gldn.gldn032,
                   l_gldn.gldn033,l_gldn.gldn034,l_gldn.gldn035,l_gldn.gldn036,l_gldn.gldn037,l_gldn.gldn038,l_gldn.gldn039,l_gldn.gldn040,l_gldn.gldn041,l_gldn.gldn042,l_gldn.gldn043,
                   l_gldn.gldn044,l_gldn.gldn045,l_gldn.gldn046,l_gldn.gldn047)
           #161128-00061#1----modify------end-----------
             
          IF SQLCA.SQLCODE THEN
             INITIALIZE g_errparam.* TO NULL
             LET g_errparam.code = SQLCA.SQLCODE 
             LET g_errparam.extend = " INSERT gldn "
             CALL cl_err()
          END IF 
      END FOREACH
     
   END FOREACH
   
   #用產生的gldn在做後續動作
   
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM gldn_t
    WHERE gldnent = g_enterprise
      AND gldnld  = g_master.l_gldnld
      AND gldn001 = g_master.l_gldn001
      AND gldn005 = g_master.l_yy
      AND gldn006 = g_master.l_mme
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
                            
      #抓合併帳別設定的常用科目   本期損益IS   本期損益BS   換算調整
      LET l_gldn007ex = NULL
      LET l_gldn007is = NULL
      LET l_gldn007bs = NULL
      SELECT glab005 INTO l_gldn007ex 
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = g_master.l_gldnld
         AND glab001 = '12'   #SCC8301
         AND glab002 = '9929'
         AND glab003 = '9929_02'
         
      SELECT glab005 INTO l_gldn007is 
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = g_master.l_gldnld
         AND glab001 = '12'   #SCC8301
         AND glab002 = '9929'
         AND glab003 = '9929_03'

      SELECT glab005 INTO l_gldn007bs 
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = g_master.l_gldnld
         AND glab001 = '12'   #SCC8301
         AND glab002 = '9929'
         AND glab003 = '9929_04'
      #-----s
      #資產和損益的處理分開來,因為不一定會一致
      #看gldn_t中取資產時和取損益時 各會取到多少資料來決定
      #資產類科目折算價差
      #
      #資產類折算價差傳票取號
      #取號一定要有transaction
      CALL s_transaction_begin()
      CALL s_aooi200_fin_gen_docno(g_master.l_gldnld,'','',g_master.l_docno,g_today,'aglt503')
                 RETURNING g_sub_success,l_gldpdocno
      CALL s_transaction_end('Y','0')
      LET l_count = 0
      #FOREACH
      #依有資產類的個體公司+帳別抓出來
      LET l_sql = "SELECT DISTINCT gldn040,gldn041 FROM gldn_t ",
                  " WHERE gldnent = ",g_enterprise," ",
                  "   AND gldnld  = '",g_master.l_gldnld,"' ",
                  "   AND gldn001 = '",g_master.l_gldn001,"' ",
                  "   AND gldn005 = ",g_master.l_yy," ",
                  "   AND gldn006 = ",g_master.l_mme," ",
                  "   AND gldn007 IN (",
                  "                    SELECT glac002 FROM glac_t ",
                  "                            WHERE glacent = ", g_enterprise," ",
                  "                              AND glac007 <> '6' ",
                  "                              AND glac006 = '1' ",
                  "                              AND glac003 <> '1' ",
                  ")"
      PREPARE sel_gldnp3 FROM l_sql
      DECLARE sel_gldnc3 CURSOR WITH HOLD FOR sel_gldnp3
      FOREACH sel_gldnc3 INTO l_node.gldc002,l_node.gldc003
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'sel_gldnc2'
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET l_gldn010     = NULL        #借方金額暫存
         LET l_gldn011     = NULL        #貸方金額暫存
         LET l_gldn027     = NULL        #借方金額暫存
         LET l_gldn028     = NULL        #貸方金額暫存
         LET l_gldn030     = NULL        #借方金額暫存
         LET l_gldn031     = NULL        #貸方金額暫存
         LET l_gldn0102    = NULL        #借方金額暫存2
         LET l_gldn0112    = NULL        #貸方金額暫存2
         LET l_gldn0272    = NULL        #借方金額暫存2
         LET l_gldn0282    = NULL        #貸方金額暫存2
         LET l_gldn0302    = NULL        #借方金額暫存2
         LET l_gldn0312    = NULL        #貸方金額暫存2
         SELECT SUM(gldn010),SUM(gldn011),SUM(gldn027),
                SUM(gldn028),SUM(gldn030),SUM(gldn031)
           INTO l_gldn010,l_gldn011,l_gldn027,
                l_gldn028,l_gldn030,l_gldn031
           FROM gldn_t
          WHERE gldnent = g_enterprise
            AND gldnld  = g_master.l_gldnld
            AND gldn001 = g_master.l_gldn001
            AND gldn005 = g_master.l_yy
            AND gldn006 = g_master.l_mme 
            AND gldn007 IN (SELECT glac002 FROM glac_t
                             WHERE glacent = g_enterprise
                               AND glac007 <> '6'
                               AND glac006 = '1'
                               AND glac003 <> '1'
                               AND glac008 = '1')
            AND gldn040 = l_node.gldc002   #albireo 160309
            AND gldn041 = l_node.gldc003   #albireo 160309
         SELECT SUM(gldn010),SUM(gldn011),SUM(gldn027),
                SUM(gldn028),SUM(gldn030),SUM(gldn031)
           INTO l_gldn0102,l_gldn0112,l_gldn0272,
                l_gldn0282,l_gldn0302,l_gldn0312
           FROM gldn_t
          WHERE gldnent = g_enterprise
            AND gldnld  = g_master.l_gldnld
            AND gldn001 = g_master.l_gldn001
            AND gldn005 = g_master.l_yy
            AND gldn006 = g_master.l_mme 
            AND gldn007 IN (SELECT glac002 FROM glac_t
                             WHERE glacent = g_enterprise
                               AND glac007 <> '6'
                               AND glac006 = '1'
                               AND glac003 <> '1'
                               AND glac008 = '2')
            AND gldn040 = l_node.gldc002   #albireo 160309
            AND gldn041 = l_node.gldc003   #albireo 160309
         IF cl_null(l_gldn010)THEN LET l_gldn010 = 0 END IF
         IF cl_null(l_gldn011)THEN LET l_gldn011 = 0 END IF
         IF cl_null(l_gldn027)THEN LET l_gldn027 = 0 END IF
         IF cl_null(l_gldn028)THEN LET l_gldn028 = 0 END IF
         IF cl_null(l_gldn030)THEN LET l_gldn030 = 0 END IF
         IF cl_null(l_gldn031)THEN LET l_gldn031 = 0 END IF
         IF cl_null(l_gldn0102)THEN LET l_gldn0102 = 0 END IF
         IF cl_null(l_gldn0112)THEN LET l_gldn0112 = 0 END IF
         IF cl_null(l_gldn0272)THEN LET l_gldn0272 = 0 END IF
         IF cl_null(l_gldn0282)THEN LET l_gldn0282 = 0 END IF
         IF cl_null(l_gldn0302)THEN LET l_gldn0302 = 0 END IF
         IF cl_null(l_gldn0312)THEN LET l_gldn0312 = 0 END IF
         
         #借餘科目
         LET l_gldn010 = l_gldn010 - l_gldn011
         LET l_gldn027 = l_gldn027 - l_gldn028
         LET l_gldn030 = l_gldn030 - l_gldn031
         
         #貸餘科目
         LET l_gldn0102 = l_gldn0112 - l_gldn0102
         LET l_gldn0272 = l_gldn0282 - l_gldn0272
         LET l_gldn0302 = l_gldn0312 - l_gldn0302
         
         #借減貸   判斷餘額是+(借) - (貸)
         LET l_gldn010 = l_gldn010 - l_gldn0102
         LET l_gldn027 = l_gldn027 - l_gldn0272
         LET l_gldn030 = l_gldn030 - l_gldn0302
         
         INITIALIZE l_gldn.* TO NULL
         LET l_gldn.gldnent = g_enterprise
         LET l_gldn.gldnld  = g_master.l_gldnld
         LET l_gldn.gldn001 = g_master.l_gldn001
         
         #用合併帳+上層公司抓上層個體帳
         LET l_gldb002 = NULL
         SELECT gldb002 INTO l_gldb002 FROM gldb_t
          WHERE gldbent = g_enterprise
            AND gldb001 = g_master.l_gldn001
            AND gldbld  = g_master.l_gldnld
         LET l_gldn.gldn002 = l_gldb002   
         
         LET l_gldn.gldn003 = g_master.l_yy
         LET l_gldn.gldn004 = g_master.l_mme
         LET l_gldn.gldn005 = g_master.l_yy
         LET l_gldn.gldn006 = g_master.l_mme
         
         #抓合併帳的常用科目的調整科目
         LET l_gldn.gldn007 = l_gldn007ex
         IF cl_null(l_gldn007ex)THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = 'agl-00422'
            LET g_errparam.extend = ''
            CALL cl_err()
            LET l_success = FALSE
         END IF
         #LET l_gldn.gldn008 =
         #合併帳別取本位幣別-----             
         LET l_gldn.gldn009 = l_glaa001 
         LET l_gldn.gldn026 = l_glaa016
         LET l_gldn.gldn029 = l_glaa020
         #-----
         IF l_gldn010 > 0 THEN
            LET l_gldn.gldn010 = l_gldn010
            LET l_gldn.gldn011 = 0
         ELSE
            LET l_gldn.gldn010 = 0
            LET l_gldn.gldn011 = l_gldn010
         END IF
         #借貸筆數-----
         LET l_gldn.gldn012 = 1
         LET l_gldn.gldn013 = 1
         #-----
         LET l_gldn.gldn014 = NULL
         LET l_gldn.gldn015 = NULL
         LET l_gldn.gldn016 = NULL
         LET l_gldn.gldn017 = NULL
         LET l_gldn.gldn018 = NULL
         LET l_gldn.gldn019 = NULL
         LET l_gldn.gldn020 = NULL
         LET l_gldn.gldn021 = NULL
         LET l_gldn.gldn022 = NULL
         LET l_gldn.gldn024 = NULL
         LET l_gldn.gldn025 = NULL
         
         IF l_gldn027 > 0 THEN
            LET l_gldn.gldn027 = l_gldn027
            LET l_gldn.gldn028 = 0
         ELSE
            LET l_gldn.gldn027 = 0
            LET l_gldn.gldn028 = l_gldn027
         END IF
         
         IF l_gldn030 > 0 THEN
            LET l_gldn.gldn030 = l_gldn030
            LET l_gldn.gldn031 = 0
         ELSE
            LET l_gldn.gldn030 = 0
            LET l_gldn.gldn031 = l_gldn030
         END IF
         LET l_gldn.gldn032 = l_node.gldc002
         LET l_gldn.gldn033 = l_node.gldc003
         
         LET l_gldn.gldn037 = NULL
         LET l_gldn.gldn038 = NULL
         LET l_gldn.gldn039 = NULL
         LET l_gldn.gldn040 = l_node.gldc002
         LET l_gldn.gldn041 = l_node.gldc003
         
         #從此點之後insert or update 可匯總成1含式
         
         CALL g_gldn_ar.clear()
         LET g_gldn_ar[1].chr1  = l_gldn.gldn014 
         LET g_gldn_ar[2].chr1  = l_gldn.gldn015 
         LET g_gldn_ar[3].chr1  = l_gldn.gldn016 
         LET g_gldn_ar[4].chr1  = l_gldn.gldn017 
         LET g_gldn_ar[5].chr1  = l_gldn.gldn018 
         LET g_gldn_ar[6].chr1  = l_gldn.gldn019 
         LET g_gldn_ar[7].chr1  = l_gldn.gldn020 
         LET g_gldn_ar[8].chr1  = l_gldn.gldn021 
         LET g_gldn_ar[12].chr1  = l_gldn.gldn022 
         LET g_gldn_ar[13].chr1 = l_gldn.gldn024 
         LET g_gldn_ar[14].chr1 = l_gldn.gldn025 
         LET g_gldn_ar[9].chr1 = l_gldn.gldn037 
         LET g_gldn_ar[10].chr1 = l_gldn.gldn038 
         LET g_gldn_ar[11].chr1 = l_gldn.gldn039 
         
         #核算項轉換復合KEY
         CALL s_merge_get_gldn008(g_gldn_ar)RETURNING l_gldn.gldn008
         IF l_gldn.gldn010 = 0 AND l_gldn.gldn011 = 0 AND l_gldn.gldn027 = 0 
            AND l_gldn.gldn028 = 0 AND l_gldn.gldn030 = 0 AND l_gldn.gldn031 = 0 THEN
            CONTINUE FOREACH
         END IF
         
         #albireo 160225-----s
#         INSERT INTO gldn_t VALUES(l_gldn.*)
#         IF SQLCA.SQLCODE THEN
#            INITIALIZE g_errparam.* TO NULL
#            LET g_errparam.code = SQLCA.SQLCODE 
#            LET g_errparam.extend = " INSERT gldn "
#            CALL cl_err()         
#         END IF
         #albireo 160225-----e
         
         #產生傳票單身-----s

         #產生本期損益IS單身
         INITIALIZE l_gldq.* TO NULL
         LET l_gldq.gldqent = g_enterprise
         LET l_gldq.gldqdocno = l_gldpdocno
         LET l_gldq.gldqseq = NULL
         SELECT MAX(gldqseq)+1 INTO l_gldq.gldqseq FROM gldq_t
          WHERE gldqent = g_enterprise
            AND gldqdocno = l_gldpdocno
         IF cl_null(l_gldq.gldqseq)THEN LET l_gldq.gldqseq = 1 END IF
         LET l_gldq.gldq001 = l_gldn007is
         #LET l_gldq.gldq003 = l_gldn.gldn014
         LET l_gldq.gldq003 = g_site
         LET l_gldq.gldq004 = l_gldn.gldn015
         LET l_gldq.gldq005 = l_gldn.gldn016
         LET l_gldq.gldq006 = l_gldn.gldn017
         LET l_gldq.gldq007 = l_gldn.gldn018
         LET l_gldq.gldq008 = l_gldn.gldn019
         LET l_gldq.gldq009 = l_gldn.gldn020
         LET l_gldq.gldq010 = l_gldn.gldn021
         LET l_gldq.gldq011 = l_gldn.gldn037
         LET l_gldq.gldq012 = l_gldn.gldn038
         LET l_gldq.gldq013 = l_gldn.gldn039
         LET l_gldq.gldq014 = l_gldn.gldn022
         LET l_gldq.gldq015 = l_gldn.gldn024
         LET l_gldq.gldq016 = l_gldn.gldn025
         LET l_gldq.gldq017 = l_gldn.gldn010
         LET l_gldq.gldq018 = l_gldn.gldn011
         LET l_gldq.gldq019 = l_gldn.gldn027
         LET l_gldq.gldq020 = l_gldn.gldn028
         LET l_gldq.gldq021 = l_gldn.gldn030
         LET l_gldq.gldq022 = l_gldn.gldn031
         LET l_gldq.gldq023 = l_gldn.gldn040
         
         #161128-00061#1----modify------begin-----------
         #INSERT INTO gldq_t VALUES(l_gldq.*)
         INSERT INTO gldq_t (gldqent,gldqdocno,gldqseq,gldq001,gldq003,gldq004,gldq005,gldq006,gldq007,
                             gldq008,gldq009,gldq010,gldq011,gldq012,gldq013,gldq014,gldq015,gldq016,
                             gldq017,gldq018,gldq019,gldq020,gldq021,gldq022,gldq023)
          VALUES(l_gldq.gldqent,l_gldq.gldqdocno,l_gldq.gldqseq,l_gldq.gldq001,l_gldq.gldq003,l_gldq.gldq004,l_gldq.gldq005,l_gldq.gldq006,l_gldq.gldq007,
                 l_gldq.gldq008,l_gldq.gldq009,l_gldq.gldq010,l_gldq.gldq011,l_gldq.gldq012,l_gldq.gldq013,l_gldq.gldq014,l_gldq.gldq015,l_gldq.gldq016,
                 l_gldq.gldq017,l_gldq.gldq018,l_gldq.gldq019,l_gldq.gldq020,l_gldq.gldq021,l_gldq.gldq022,l_gldq.gldq023)
         #161128-00061#1----modify------end-----------
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.extend = " INSERT gldq "
            CALL cl_err()         
         END IF
         
         #產生換算調整科目單身
         #取項次
         LET l_gldq.gldqseq = NULL
         SELECT MAX(gldqseq)+1 INTO l_gldq.gldqseq FROM gldq_t
          WHERE gldqent = g_enterprise
            AND gldqdocno = l_gldpdocno
         IF cl_null(l_gldq.gldqseq)THEN LET l_gldq.gldqseq = 1 END IF
         LET l_gldq.gldq001 = l_gldn007ex
         #錢借貸顛倒
         LET l_gldq.gldq017 = l_gldn.gldn011
         LET l_gldq.gldq018 = l_gldn.gldn010
         LET l_gldq.gldq019 = l_gldn.gldn028
         LET l_gldq.gldq020 = l_gldn.gldn027
         LET l_gldq.gldq021 = l_gldn.gldn031
         LET l_gldq.gldq022 = l_gldn.gldn030
         #161128-00061#1----modify------begin-----------
         #INSERT INTO gldq_t VALUES(l_gldq.*)
         INSERT INTO gldq_t (gldqent,gldqdocno,gldqseq,gldq001,gldq003,gldq004,gldq005,gldq006,gldq007,
                             gldq008,gldq009,gldq010,gldq011,gldq012,gldq013,gldq014,gldq015,gldq016,
                             gldq017,gldq018,gldq019,gldq020,gldq021,gldq022,gldq023)
          VALUES(l_gldq.gldqent,l_gldq.gldqdocno,l_gldq.gldqseq,l_gldq.gldq001,l_gldq.gldq003,l_gldq.gldq004,l_gldq.gldq005,l_gldq.gldq006,l_gldq.gldq007,
                 l_gldq.gldq008,l_gldq.gldq009,l_gldq.gldq010,l_gldq.gldq011,l_gldq.gldq012,l_gldq.gldq013,l_gldq.gldq014,l_gldq.gldq015,l_gldq.gldq016,
                 l_gldq.gldq017,l_gldq.gldq018,l_gldq.gldq019,l_gldq.gldq020,l_gldq.gldq021,l_gldq.gldq022,l_gldq.gldq023)
         #161128-00061#1----modify------end-----------
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.extend = " INSERT gldq "
            CALL cl_err()         
         END IF         
         LET l_count = l_count + 1       
         #產生傳票單身-----e
      END FOREACH
      
      IF l_count > 0 THEN
         #產生的單頭
         INITIALIZE l_gldp.* TO NULL
         LET l_gldp.gldpent = g_enterprise
         LET l_gldp.gldpownid = g_user
         LET l_gldp.gldpowndp = g_dept
         LET l_gldp.gldpcrtid = g_user
         LET l_gldp.gldpcrtdp = g_dept
         LET l_gldp.gldpcrtdt = g_today
         LET l_gldp.gldpmodid = g_user
         LET l_gldp.gldpmoddt = g_today
         LET l_gldp.gldpcnfid = g_user
         LET l_gldp.gldpcnfdt = g_today
         LET l_gldp.gldpstus = 'Y'
         LET l_gldp.gldpdocno = l_gldpdocno
         LET l_gldp.gldpdocdt = g_today
         LET l_gldp.gldpld = l_gldn.gldnld
         LET l_gldp.gldp001 = l_gldn.gldn001
         LET l_gldp.gldp002 = l_gldn.gldn002
         LET l_gldp.gldp003 = l_gldn.gldn005
         LET l_gldp.gldp004 = l_gldn.gldn006
         LET l_gldp.gldp005 = '1'
         LET l_gldp.gldp006 = '8'
         LET l_gldp.gldp007 = 'Y'
         LET l_gldp.gldp008 = l_gldn.gldn009
         LET l_gldp.gldp011 = l_gldn.gldn026
         LET l_gldp.gldp014 = l_gldn.gldn029
         
         SELECT SUM(gldq017),SUM(gldq018),SUM(gldq019),
                SUM(gldq020),SUM(gldq021),SUM(gldq022)
           INTO l_gldp.gldp009,l_gldp.gldp010,l_gldp.gldp012,
                l_gldp.gldp013,l_gldp.gldp015,l_gldp.gldp016
           FROM gldq_t
          WHERE gldqent = g_enterprise
            AND gldqdocno = l_gldpdocno
         IF cl_null(l_gldp.gldp009)THEN LET l_gldp.gldp009 = 0 END IF
         IF cl_null(l_gldp.gldp010)THEN LET l_gldp.gldp010 = 0 END IF
         IF cl_null(l_gldp.gldp012)THEN LET l_gldp.gldp012 = 0 END IF
         IF cl_null(l_gldp.gldp013)THEN LET l_gldp.gldp013 = 0 END IF
         IF cl_null(l_gldp.gldp015)THEN LET l_gldp.gldp015 = 0 END IF
         IF cl_null(l_gldp.gldp016)THEN LET l_gldp.gldp016 = 0 END IF
                
         #161128-00061#1----modify------begin-----------        
         #INSERT INTO gldp_t VALUES(l_gldp.*)
          INSERT INTO gldp_t (gldpent,gldpownid,gldpowndp,gldpcrtid,gldpcrtdp,gldpcrtdt,gldpmodid,gldpmoddt,
                              gldpcnfid,gldpcnfdt,gldppstid,gldppstdt,gldpstus,gldpdocno,gldpdocdt,gldpld,
                              gldp001,gldp002,gldp003,gldp004,gldp005,gldp006,gldp007,gldp008,gldp009,gldp010,
                              gldp011,gldp012,gldp013,gldp014,gldp015,gldp016)
           VALUES(l_gldp.gldpent,l_gldp.gldpownid,l_gldp.gldpowndp,l_gldp.gldpcrtid,l_gldp.gldpcrtdp,l_gldp.gldpcrtdt,l_gldp.gldpmodid,l_gldp.gldpmoddt,
                  l_gldp.gldpcnfid,l_gldp.gldpcnfdt,l_gldp.gldppstid,l_gldp.gldppstdt,l_gldp.gldpstus,l_gldp.gldpdocno,l_gldp.gldpdocdt,l_gldp.gldpld,
                  l_gldp.gldp001,l_gldp.gldp002,l_gldp.gldp003,l_gldp.gldp004,l_gldp.gldp005,l_gldp.gldp006,l_gldp.gldp007,l_gldp.gldp008,l_gldp.gldp009,l_gldp.gldp010,
                  l_gldp.gldp011,l_gldp.gldp012,l_gldp.gldp013,l_gldp.gldp014,l_gldp.gldp015,l_gldp.gldp016)
         #161128-00061#1----modify------end-----------
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.extend = " INSERT gldp "
            CALL cl_err()         
         END IF 
      END IF
      #-----e
      
      #FOREACH
      #取損益類傳票號碼
      #取號   取號一定要有transaction
      CALL s_transaction_begin()
      CALL s_aooi200_fin_gen_docno(g_master.l_gldnld,'','',g_master.l_docno,g_today,'aglt503')
                 RETURNING g_sub_success,l_gldpdocno
      CALL s_transaction_end('Y','0')
      LET l_count = 0   #成功的單身INS
      #依有損益類的個體公司+帳別抓出來
      LET l_sql = "SELECT DISTINCT gldn040,gldn041 FROM gldn_t ",
                  " WHERE gldnent = ",g_enterprise," ",
                  "   AND gldnld  = '",g_master.l_gldnld,"' ",
                  "   AND gldn001 = '",g_master.l_gldn001,"' ",
                  "   AND gldn005 = ",g_master.l_yy," ",
                  "   AND gldn006 = ",g_master.l_mme," ",
                  "   AND gldn007 IN (",
                  "                    SELECT glac002 FROM glac_t ",
                  "                            WHERE glacent = ", g_enterprise," ",
                  "                              AND glac007 = '6' ",
                  "                              AND glac006 = '1' ",
                  "                              AND glac003 <> '1' ",
                  ")"
      PREPARE sel_gldnp4 FROM l_sql
      DECLARE sel_gldnc4 CURSOR WITH HOLD FOR sel_gldnp4
      FOREACH sel_gldnc4 INTO l_node.gldc002,l_node.gldc003
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'sel_gldnc2'
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET l_gldn010     = NULL        #借方金額暫存
         LET l_gldn011     = NULL        #貸方金額暫存
         LET l_gldn027     = NULL        #借方金額暫存
         LET l_gldn028     = NULL        #貸方金額暫存
         LET l_gldn030     = NULL        #借方金額暫存
         LET l_gldn031     = NULL        #貸方金額暫存
         LET l_gldn0102    = NULL        #借方金額暫存2
         LET l_gldn0112    = NULL        #貸方金額暫存2
         LET l_gldn0272    = NULL        #借方金額暫存2
         LET l_gldn0282    = NULL        #貸方金額暫存2
         LET l_gldn0302    = NULL        #借方金額暫存2
         LET l_gldn0312    = NULL        #貸方金額暫存2
         LET l_gldn010is   = NULL        #借方金額暫存IS
         LET l_gldn011is   = NULL        #貸方金額暫存IS
         LET l_gldn027is   = NULL        #借方金額暫存IS
         LET l_gldn028is   = NULL        #貸方金額暫存IS
         LET l_gldn030is   = NULL        #借方金額暫存IS
         LET l_gldn031is   = NULL        #貸方金額暫存IS
         SELECT SUM(gldn010),SUM(gldn011),SUM(gldn027),
                SUM(gldn028),SUM(gldn030),SUM(gldn031)
           INTO l_gldn010,l_gldn011,l_gldn027,
                l_gldn028,l_gldn030,l_gldn031
           FROM gldn_t
          WHERE gldnent = g_enterprise
            AND gldnld  = g_master.l_gldnld
            AND gldn001 = g_master.l_gldn001
            AND gldn005 = g_master.l_yy
            AND gldn006 = g_master.l_mme 
            AND gldn007 IN (SELECT glac002 FROM glac_t
                             WHERE glacent = g_enterprise
                               AND glac007 = '6'
                               AND glac006 = '1'
                               AND glac003 <> '1'
                               AND glac008 = '1')
            AND gldn040 = l_node.gldc002   #albireo 160309
            AND gldn041 = l_node.gldc003   #albireo 160309
         SELECT SUM(gldn010),SUM(gldn011),SUM(gldn027),
                SUM(gldn028),SUM(gldn030),SUM(gldn031)
           INTO l_gldn0102,l_gldn0112,l_gldn0272,
                l_gldn0282,l_gldn0302,l_gldn0312
           FROM gldn_t
          WHERE gldnent = g_enterprise
            AND gldnld  = g_master.l_gldnld
            AND gldn001 = g_master.l_gldn001
            AND gldn005 = g_master.l_yy
            AND gldn006 = g_master.l_mme 
            AND gldn007 IN (SELECT glac002 FROM glac_t
                             WHERE glacent = g_enterprise
                               AND glac007 = '6'
                               AND glac006 = '1'
                               AND glac003 <> '1'
                               AND glac008 = '2')
            AND gldn040 = l_node.gldc002   #albireo 160309
            AND gldn041 = l_node.gldc003   #albireo 160309
         IF cl_null(l_gldn010)THEN LET l_gldn010 = 0 END IF
         IF cl_null(l_gldn011)THEN LET l_gldn011 = 0 END IF
         IF cl_null(l_gldn027)THEN LET l_gldn027 = 0 END IF
         IF cl_null(l_gldn028)THEN LET l_gldn028 = 0 END IF
         IF cl_null(l_gldn030)THEN LET l_gldn030 = 0 END IF
         IF cl_null(l_gldn031)THEN LET l_gldn031 = 0 END IF
         IF cl_null(l_gldn0102)THEN LET l_gldn0102 = 0 END IF
         IF cl_null(l_gldn0112)THEN LET l_gldn0112 = 0 END IF
         IF cl_null(l_gldn0272)THEN LET l_gldn0272 = 0 END IF
         IF cl_null(l_gldn0282)THEN LET l_gldn0282 = 0 END IF
         IF cl_null(l_gldn0302)THEN LET l_gldn0302 = 0 END IF
         IF cl_null(l_gldn0312)THEN LET l_gldn0312 = 0 END IF
         
         #借餘科目(費用)
         LET l_gldn010 = l_gldn010 - l_gldn011
         LET l_gldn027 = l_gldn027 - l_gldn028
         LET l_gldn030 = l_gldn030 - l_gldn031
         
         #貸餘科目(收入)
         LET l_gldn0102 = l_gldn0112 - l_gldn0102
         LET l_gldn0272 = l_gldn0282 - l_gldn0272
         LET l_gldn0302 = l_gldn0312 - l_gldn0302
         
         #貸減借   (收入-費用) 
         LET l_gldn010 = l_gldn010 - l_gldn0102
         LET l_gldn027 = l_gldn027 - l_gldn0272
         LET l_gldn030 = l_gldn030 - l_gldn0302
         #怕客戶設定借餘貸餘時設定錯誤
         #損益類處理計算完以後 都取絕對值再作比較
         #原因:就是想看同一邊實際的差異不會有負負得正大量差異的狀況
         IF l_gldn010 < 0 THEN
            LET l_gldn010 = l_gldn010 * -1
         END IF
         IF l_gldn027 < 0 THEN
            LET l_gldn027 = l_gldn027 * -1
         END IF
         IF l_gldn030 < 0 THEN
            LET l_gldn030 = l_gldn030 * -1
         END IF
         
         #抓本期損益IS科目
         SELECT SUM(gldn010),SUM(gldn011),SUM(gldn027),
                SUM(gldn028),SUM(gldn030),SUM(gldn031)
           INTO l_gldn010is,l_gldn011is,l_gldn027is,
                l_gldn028is,l_gldn030is,l_gldn031is
           FROM gldn_t
          WHERE gldnent = g_enterprise
            AND gldnld  = g_master.l_gldnld
            AND gldn001 = g_master.l_gldn001
            AND gldn005 = g_master.l_yy
            AND gldn006 = g_master.l_mme 
            AND gldn007 = l_gldn007is
       
         IF cl_null(l_gldn010is)THEN LET l_gldn010is = 0 END IF
         IF cl_null(l_gldn011is)THEN LET l_gldn011is = 0 END IF
         IF cl_null(l_gldn027is)THEN LET l_gldn027is = 0 END IF
         IF cl_null(l_gldn028is)THEN LET l_gldn028is = 0 END IF
         IF cl_null(l_gldn030is)THEN LET l_gldn030is = 0 END IF
         IF cl_null(l_gldn031is)THEN LET l_gldn031is = 0 END IF         
         
         #本期損益IS科目理論上為貸餘
         LET l_gldn010is = l_gldn011is - l_gldn010is
         LET l_gldn027is = l_gldn028is - l_gldn027is
         LET l_gldn030is = l_gldn031is - l_gldn030is
         
         IF l_gldn010is < 0 THEN
            LET l_gldn010is = l_gldn010is * -1
         END IF
         IF l_gldn027is < 0 THEN
            LET l_gldn027is = l_gldn027is * -1
         END IF
         IF l_gldn030is < 0 THEN
            LET l_gldn030is = l_gldn030is * -1
         END IF
         
         #(收入費用) 與 換匯過的本期損益IS比較
         LEt l_gldn010 = l_gldn010 - l_gldn010is
         LET l_gldn027 = l_gldn027 - l_gldn027is
         LET l_gldn030 = l_gldn030 - l_gldn030is
         
         INITIALIZE l_gldn.* TO NULL
         LET l_gldn.gldnent = g_enterprise
         LET l_gldn.gldnld  = g_master.l_gldnld
         LET l_gldn.gldn001 = g_master.l_gldn001
         
         #用合併帳+上層公司抓上層個體帳
         LET l_gldb002 = NULL
         SELECT gldb002 INTO l_gldb002 FROM gldb_t
          WHERE gldbent = g_enterprise
            AND gldb001 = g_master.l_gldn001
            AND gldbld  = g_master.l_gldnld
         LET l_gldn.gldn002 = l_gldb002   
         
         LET l_gldn.gldn003 = g_master.l_yy
         LET l_gldn.gldn004 = g_master.l_mme
         LET l_gldn.gldn005 = g_master.l_yy
         LET l_gldn.gldn006 = g_master.l_mme
         
         #抓合併帳的常用科目的調整科目
         #LET l_gldn.gldn007 = l_gldh.gldh003
         
         #LET l_gldn.gldn008 =
         #合併帳別取本位幣別-----             
         LET l_gldn.gldn009 = l_glaa001 
         LET l_gldn.gldn026 = l_glaa016
         LET l_gldn.gldn029 = l_glaa020
         #-----
         IF l_gldn010 > 0 THEN
            LET l_gldn.gldn010 = l_gldn010
            LET l_gldn.gldn011 = 0
         ELSE
            LET l_gldn.gldn010 = 0
            LET l_gldn.gldn011 = l_gldn010
         END IF
         #借貸筆數-----
         LET l_gldn.gldn012 = 1
         LET l_gldn.gldn013 = 1
         #-----
         LET l_gldn.gldn014 = NULL
         LET l_gldn.gldn015 = NULL
         LET l_gldn.gldn016 = NULL
         LET l_gldn.gldn017 = NULL
         LET l_gldn.gldn018 = NULL
         LET l_gldn.gldn019 = NULL
         LET l_gldn.gldn020 = NULL
         LET l_gldn.gldn021 = NULL
         LET l_gldn.gldn022 = NULL
         LET l_gldn.gldn024 = NULL
         LET l_gldn.gldn025 = NULL
         
         IF l_gldn027 > 0 THEN
            LET l_gldn.gldn027 = l_gldn027
            LET l_gldn.gldn028 = 0
         ELSE
            LET l_gldn.gldn027 = 0
            LET l_gldn.gldn028 = l_gldn027
         END IF
         
         IF l_gldn030 > 0 THEN
            LET l_gldn.gldn030 = l_gldn030
            LET l_gldn.gldn031 = 0
         ELSE
            LET l_gldn.gldn030 = 0
            LET l_gldn.gldn031 = l_gldn030
         END IF
         LET l_gldn.gldn032 = l_node.gldc002
         LET l_gldn.gldn033 = l_node.gldc003
         
         LET l_gldn.gldn037 = NULL
         LET l_gldn.gldn038 = NULL
         LET l_gldn.gldn039 = NULL
         LET l_gldn.gldn040 = l_node.gldc002
         LET l_gldn.gldn041 = l_node.gldc003
         
         #從此點之後insert or update 可匯總成1含式
         
         CALL g_gldn_ar.clear()
         LET g_gldn_ar[1].chr1  = l_gldn.gldn014 
         LET g_gldn_ar[2].chr1  = l_gldn.gldn015 
         LET g_gldn_ar[3].chr1  = l_gldn.gldn016 
         LET g_gldn_ar[4].chr1  = l_gldn.gldn017 
         LET g_gldn_ar[5].chr1  = l_gldn.gldn018 
         LET g_gldn_ar[6].chr1  = l_gldn.gldn019 
         LET g_gldn_ar[7].chr1  = l_gldn.gldn020 
         LET g_gldn_ar[8].chr1  = l_gldn.gldn021 
         LET g_gldn_ar[12].chr1  = l_gldn.gldn022 
         LET g_gldn_ar[13].chr1 = l_gldn.gldn024 
         LET g_gldn_ar[14].chr1 = l_gldn.gldn025 
         LET g_gldn_ar[9].chr1 = l_gldn.gldn037 
         LET g_gldn_ar[10].chr1 = l_gldn.gldn038 
         LET g_gldn_ar[11].chr1 = l_gldn.gldn039 
         
         #核算項轉換復合KEY
         CALL s_merge_get_gldn008(g_gldn_ar)RETURNING l_gldn.gldn008
         
         #損益類不入合報 但要產生傳票
         #INSERT INTO gldn_t VALUES(l_gldn.*)
         #IF SQLCA.SQLCODE THEN
         #   INITIALIZE g_errparam.* TO NULL
         #   LET g_errparam.code = SQLCA.SQLCODE 
         #   LET g_errparam.extend = " INSERT gldn "
         #   CALL cl_err()         
         #END IF
         
         IF l_gldn.gldn010 = 0 AND l_gldn.gldn011 = 0 AND l_gldn.gldn027 = 0 
            AND l_gldn.gldn028 = 0 AND l_gldn.gldn030 = 0 AND l_gldn.gldn031 = 0 THEN
            CONTINUE FOREACH
         END IF
         
         #產生傳票 單身-----s

         #產生本期損益BS單身
         INITIALIZE l_gldq.* TO NULL
         LET l_gldq.gldqent = g_enterprise
         LET l_gldq.gldqdocno = l_gldpdocno
         LET l_gldq.gldqseq = NULL
         SELECT MAX(gldqseq)+1 INTO l_gldq.gldqseq FROM gldq_t
          WHERE gldqent = g_enterprise
            AND gldqdocno = l_gldpdocno
         IF cl_null(l_gldq.gldqseq)THEN LET l_gldq.gldqseq = 1 END IF
         LET l_gldq.gldq001 = l_gldn007bs
         #LET l_gldq.gldq003 = l_gldn.gldn014
         LET l_gldq.gldq003 = g_site
         LET l_gldq.gldq004 = l_gldn.gldn015
         LET l_gldq.gldq005 = l_gldn.gldn016
         LET l_gldq.gldq006 = l_gldn.gldn017
         LET l_gldq.gldq007 = l_gldn.gldn018
         LET l_gldq.gldq008 = l_gldn.gldn019
         LET l_gldq.gldq009 = l_gldn.gldn020
         LET l_gldq.gldq010 = l_gldn.gldn021
         LET l_gldq.gldq011 = l_gldn.gldn037
         LET l_gldq.gldq012 = l_gldn.gldn038
         LET l_gldq.gldq013 = l_gldn.gldn039
         LET l_gldq.gldq014 = l_gldn.gldn022
         LET l_gldq.gldq015 = l_gldn.gldn024
         LET l_gldq.gldq016 = l_gldn.gldn025
         LET l_gldq.gldq017 = l_gldn.gldn010
         LET l_gldq.gldq018 = l_gldn.gldn011
         LET l_gldq.gldq019 = l_gldn.gldn027
         LET l_gldq.gldq020 = l_gldn.gldn028
         LET l_gldq.gldq021 = l_gldn.gldn030
         LET l_gldq.gldq022 = l_gldn.gldn031
         LET l_gldq.gldq023 = l_gldn.gldn040
         
         #161128-00061#1----modify------begin-----------
         #INSERT INTO gldq_t VALUES(l_gldq.*)
         INSERT INTO gldq_t (gldqent,gldqdocno,gldqseq,gldq001,gldq003,gldq004,gldq005,gldq006,gldq007,
                             gldq008,gldq009,gldq010,gldq011,gldq012,gldq013,gldq014,gldq015,gldq016,
                             gldq017,gldq018,gldq019,gldq020,gldq021,gldq022,gldq023)
          VALUES(l_gldq.gldqent,l_gldq.gldqdocno,l_gldq.gldqseq,l_gldq.gldq001,l_gldq.gldq003,l_gldq.gldq004,l_gldq.gldq005,l_gldq.gldq006,l_gldq.gldq007,
                 l_gldq.gldq008,l_gldq.gldq009,l_gldq.gldq010,l_gldq.gldq011,l_gldq.gldq012,l_gldq.gldq013,l_gldq.gldq014,l_gldq.gldq015,l_gldq.gldq016,
                 l_gldq.gldq017,l_gldq.gldq018,l_gldq.gldq019,l_gldq.gldq020,l_gldq.gldq021,l_gldq.gldq022,l_gldq.gldq023)
         #161128-00061#1----modify------end-----------
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.extend = " INSERT gldq "
            CALL cl_err()         
         END IF
         
         #產生換算調整科目單身
         #取項次
         LET l_gldq.gldqseq = NULL
         SELECT MAX(gldqseq)+1 INTO l_gldq.gldqseq FROM gldq_t
          WHERE gldqent = g_enterprise
            AND gldqdocno = l_gldpdocno
         IF cl_null(l_gldq.gldqseq)THEN LET l_gldq.gldqseq = 1 END IF
         LET l_gldq.gldq001 = l_gldn007ex
         #錢借貸顛倒
         LET l_gldq.gldq017 = l_gldn.gldn011
         LET l_gldq.gldq018 = l_gldn.gldn010
         LET l_gldq.gldq019 = l_gldn.gldn028
         LET l_gldq.gldq020 = l_gldn.gldn027
         LET l_gldq.gldq021 = l_gldn.gldn031
         LET l_gldq.gldq022 = l_gldn.gldn030
         #161128-00061#1----modify------begin-----------
         #INSERT INTO gldq_t VALUES(l_gldq.*)
         INSERT INTO gldq_t (gldqent,gldqdocno,gldqseq,gldq001,gldq003,gldq004,gldq005,gldq006,gldq007,
                             gldq008,gldq009,gldq010,gldq011,gldq012,gldq013,gldq014,gldq015,gldq016,
                             gldq017,gldq018,gldq019,gldq020,gldq021,gldq022,gldq023)
          VALUES(l_gldq.gldqent,l_gldq.gldqdocno,l_gldq.gldqseq,l_gldq.gldq001,l_gldq.gldq003,l_gldq.gldq004,l_gldq.gldq005,l_gldq.gldq006,l_gldq.gldq007,
                 l_gldq.gldq008,l_gldq.gldq009,l_gldq.gldq010,l_gldq.gldq011,l_gldq.gldq012,l_gldq.gldq013,l_gldq.gldq014,l_gldq.gldq015,l_gldq.gldq016,
                 l_gldq.gldq017,l_gldq.gldq018,l_gldq.gldq019,l_gldq.gldq020,l_gldq.gldq021,l_gldq.gldq022,l_gldq.gldq023)
         #161128-00061#1----modify------end-----------
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.extend = " INSERT gldq "
            CALL cl_err()         
         END IF         
         LET l_count = l_count + 1 
         #產生傳票 單身-----e
      END FOREACH
      
      IF l_count > 0 THEN
         #產生傳票單頭
         INITIALIZE l_gldp.* TO NULL
         LET l_gldp.gldpent = g_enterprise
         LET l_gldp.gldpownid = g_user
         LET l_gldp.gldpowndp = g_dept
         LET l_gldp.gldpcrtid = g_user
         LET l_gldp.gldpcrtdp = g_dept
         LET l_gldp.gldpcrtdt = g_today
         LET l_gldp.gldpmodid = g_user
         LET l_gldp.gldpmoddt = g_today
         LET l_gldp.gldpcnfid = g_user
         LET l_gldp.gldpcnfdt = g_today
         LET l_gldp.gldpstus = 'Y'
         LET l_gldp.gldpdocno = l_gldpdocno
         LET l_gldp.gldpdocdt = g_today
         LET l_gldp.gldpld = l_gldn.gldnld
         LET l_gldp.gldp001 = l_gldn.gldn001
         LET l_gldp.gldp002 = l_gldn.gldn002
         LET l_gldp.gldp003 = l_gldn.gldn005
         LET l_gldp.gldp004 = l_gldn.gldn006
         LET l_gldp.gldp005 = '1'
         LET l_gldp.gldp006 = '9'
         LET l_gldp.gldp007 = 'Y'
         LET l_gldp.gldp008 = l_gldn.gldn009
         LET l_gldp.gldp011 = l_gldn.gldn026
         LET l_gldp.gldp014 = l_gldn.gldn029
         
         SELECT SUM(gldq017),SUM(gldq018),SUM(gldq019),
                SUM(gldq020),SUM(gldq021),SUM(gldq022)
           INTO l_gldp.gldp009,l_gldp.gldp010,l_gldp.gldp012,
                l_gldp.gldp013,l_gldp.gldp015,l_gldp.gldp016
           FROM gldq_t
          WHERE gldqent = g_enterprise
            AND gldqdocno = l_gldpdocno
         IF cl_null(l_gldp.gldp009)THEN LET l_gldp.gldp009 = 0 END IF
         IF cl_null(l_gldp.gldp010)THEN LET l_gldp.gldp010 = 0 END IF
         IF cl_null(l_gldp.gldp012)THEN LET l_gldp.gldp012 = 0 END IF
         IF cl_null(l_gldp.gldp013)THEN LET l_gldp.gldp013 = 0 END IF
         IF cl_null(l_gldp.gldp015)THEN LET l_gldp.gldp015 = 0 END IF
         IF cl_null(l_gldp.gldp016)THEN LET l_gldp.gldp016 = 0 END IF
                
         #161128-00061#1----modify------begin-----------        
         #INSERT INTO gldp_t VALUES(l_gldp.*)
          INSERT INTO gldp_t (gldpent,gldpownid,gldpowndp,gldpcrtid,gldpcrtdp,gldpcrtdt,gldpmodid,gldpmoddt,
                              gldpcnfid,gldpcnfdt,gldppstid,gldppstdt,gldpstus,gldpdocno,gldpdocdt,gldpld,
                              gldp001,gldp002,gldp003,gldp004,gldp005,gldp006,gldp007,gldp008,gldp009,gldp010,
                              gldp011,gldp012,gldp013,gldp014,gldp015,gldp016)
           VALUES(l_gldp.gldpent,l_gldp.gldpownid,l_gldp.gldpowndp,l_gldp.gldpcrtid,l_gldp.gldpcrtdp,l_gldp.gldpcrtdt,l_gldp.gldpmodid,l_gldp.gldpmoddt,
                  l_gldp.gldpcnfid,l_gldp.gldpcnfdt,l_gldp.gldppstid,l_gldp.gldppstdt,l_gldp.gldpstus,l_gldp.gldpdocno,l_gldp.gldpdocdt,l_gldp.gldpld,
                  l_gldp.gldp001,l_gldp.gldp002,l_gldp.gldp003,l_gldp.gldp004,l_gldp.gldp005,l_gldp.gldp006,l_gldp.gldp007,l_gldp.gldp008,l_gldp.gldp009,l_gldp.gldp010,
                  l_gldp.gldp011,l_gldp.gldp012,l_gldp.gldp013,l_gldp.gldp014,l_gldp.gldp015,l_gldp.gldp016)
         #161128-00061#1----modify------end-----------
       
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.extend = " INSERT gldp "
            CALL cl_err()         
         END IF 
      END IF
             
   END IF
   IF l_success THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'art-00730'
      LET g_errparam.extend = ''
      CALL cl_err()
      CALL s_merge_ins_glec(g_master.l_gldnld,g_master.l_gldn001,g_prog) RETURNING g_sub_success
   ELSE
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aim-00102'
      LET g_errparam.extend = ''
      CALL cl_err()
   END IF   
   CALL cl_err_collect_show()
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
   CALL aglp700_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp700.get_buffer" >}
PRIVATE FUNCTION aglp700_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_gldnld = p_dialog.getFieldBuffer('l_gldnld')
   LET g_master.l_gldn001 = p_dialog.getFieldBuffer('l_gldn001')
   LET g_master.l_yy = p_dialog.getFieldBuffer('l_yy')
   LET g_master.l_mms = p_dialog.getFieldBuffer('l_mms')
   LET g_master.l_type = p_dialog.getFieldBuffer('l_type')
   LET g_master.l_mme = p_dialog.getFieldBuffer('l_mme')
   LET g_master.l_chk1 = p_dialog.getFieldBuffer('l_chk1')
   LET g_master.l_chk2 = p_dialog.getFieldBuffer('l_chk2')
   LET g_master.l_docno = p_dialog.getFieldBuffer('l_docno')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp700.msgcentre_notify" >}
PRIVATE FUNCTION aglp700_msgcentre_notify()
 
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
 
{<section id="aglp700.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 用核算項組出復合KEY
# Date & Author..: 150409 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp700_get_gldn008(p_gldn_ar)
   DEFINE p_gldn_ar DYNAMIC ARRAY OF RECORD
          chr1       LIKE type_t.chr1000,
          dat       LIKE type_t.dat
          END RECORD
   DEFINE r_gldn008 LIKE gldn_t.gldn008
   #161128-00061#1----modify------begin-----------
   #DEFINE l_gldn    RECORD LIKE gldn_t.*
   DEFINE l_gldn RECORD  #合併報表個體公司會計科目餘額檔
       gldnent LIKE gldn_t.gldnent, #企業編號
       gldnld LIKE gldn_t.gldnld, #帳套
       gldn001 LIKE gldn_t.gldn001, #上層公司編號
       gldn002 LIKE gldn_t.gldn002, #上層公司帳套
       gldn003 LIKE gldn_t.gldn003, #來源資料年度
       gldn004 LIKE gldn_t.gldn004, #來源資料期別
       gldn005 LIKE gldn_t.gldn005, #合併年度
       gldn006 LIKE gldn_t.gldn006, #合併期別
       gldn007 LIKE gldn_t.gldn007, #會計科目
       gldn008 LIKE gldn_t.gldn008, #組合要素(KEY)
       gldn009 LIKE gldn_t.gldn009, #幣別(記帳幣)
       gldn010 LIKE gldn_t.gldn010, #借方金額(記帳幣)
       gldn011 LIKE gldn_t.gldn011, #貸方金額(記帳幣)
       gldn012 LIKE gldn_t.gldn012, #借方筆數
       gldn013 LIKE gldn_t.gldn013, #貸方筆數
       gldn014 LIKE gldn_t.gldn014, #營運據點
       gldn015 LIKE gldn_t.gldn015, #部門
       gldn016 LIKE gldn_t.gldn016, #利潤/成本中心
       gldn017 LIKE gldn_t.gldn017, #區域
       gldn018 LIKE gldn_t.gldn018, #收付款客商
       gldn019 LIKE gldn_t.gldn019, #帳款客商
       gldn020 LIKE gldn_t.gldn020, #客群
       gldn021 LIKE gldn_t.gldn021, #產品類別
       gldn022 LIKE gldn_t.gldn022, #人員
       gldn024 LIKE gldn_t.gldn024, #專案編號
       gldn025 LIKE gldn_t.gldn025, #WBS
       gldn026 LIKE gldn_t.gldn026, #幣別(功能幣)
       gldn027 LIKE gldn_t.gldn027, #借方金額(功能幣)
       gldn028 LIKE gldn_t.gldn028, #貸方金額(功能幣)
       gldn029 LIKE gldn_t.gldn029, #幣別(報告幣)
       gldn030 LIKE gldn_t.gldn030, #借方金額(報告幣)
       gldn031 LIKE gldn_t.gldn031, #貸方金額(報告幣)
       gldn032 LIKE gldn_t.gldn032, #原始公司編號
       gldn033 LIKE gldn_t.gldn033, #原始公司帳套
       gldn034 LIKE gldn_t.gldn034, #匯率(記帳幣)
       gldn035 LIKE gldn_t.gldn035, #匯率(功能幣)
       gldn036 LIKE gldn_t.gldn036, #匯率(報告幣)
       gldn037 LIKE gldn_t.gldn037, #經營方式
       gldn038 LIKE gldn_t.gldn038, #渠道
       gldn039 LIKE gldn_t.gldn039, #品牌
       gldn040 LIKE gldn_t.gldn040, #下層公司
       gldn041 LIKE gldn_t.gldn041, #下層公司帳套
       gldn042 LIKE gldn_t.gldn042, #下層公司累計借方金額(記帳幣)
       gldn043 LIKE gldn_t.gldn043, #下層公司累計貸方金額(記帳幣)
       gldn044 LIKE gldn_t.gldn044, #下層公司累計借方金額(功能幣)
       gldn045 LIKE gldn_t.gldn045, #下層公司累計貸方金額(功能幣)
       gldn046 LIKE gldn_t.gldn046, #下層公司累計借方金額(報告幣)
       gldn047 LIKE gldn_t.gldn047  #下層公司累計貸方金額(報告幣)
       END RECORD

   #161128-00061#1----modify------end-----------
   
   INITIALIZE l_gldn.* TO NULL
   LET r_gldn008 = NULL
   
   LET l_gldn.gldn014 = p_gldn_ar[1].chr1 
   LET l_gldn.gldn015 = p_gldn_ar[2].chr1 
   LET l_gldn.gldn016 = p_gldn_ar[3].chr1 
   LET l_gldn.gldn017 = p_gldn_ar[4].chr1 
   LET l_gldn.gldn018 = p_gldn_ar[5].chr1 
   LET l_gldn.gldn019 = p_gldn_ar[6].chr1 
   LET l_gldn.gldn020 = p_gldn_ar[7].chr1 
   LET l_gldn.gldn021 = p_gldn_ar[8].chr1 
   LET l_gldn.gldn022 = p_gldn_ar[12].chr1 
   LET l_gldn.gldn024 = p_gldn_ar[13].chr1
   LET l_gldn.gldn025 = p_gldn_ar[14].chr1
   LET l_gldn.gldn037 = p_gldn_ar[9].chr1
   LET l_gldn.gldn038 = p_gldn_ar[10].chr1
   LET l_gldn.gldn039 = p_gldn_ar[11].chr1
   
   LET r_gldn008 = "gldn014='",l_gldn.gldn014,"',",
                   "gldn015='",l_gldn.gldn015,"',",
                   "gldn016='",l_gldn.gldn016,"',",
                   "gldn017='",l_gldn.gldn017,"',",
                   "gldn018='",l_gldn.gldn018,"',",
                   "gldn019='",l_gldn.gldn019,"',",
                   "gldn020='",l_gldn.gldn020,"',",
                   "gldn021='",l_gldn.gldn021,"',",
                   "gldn022='",l_gldn.gldn022,"',",
                   "gldn024='",l_gldn.gldn024,"',",
                   "gldn025='",l_gldn.gldn025,"',",
                   "gldn037='",l_gldn.gldn037,"',",
                   "gldn038='",l_gldn.gldn038,"',",
                   "gldn039='",l_gldn.gldn039,"'"
                      
   RETURN r_gldn008
END FUNCTION

################################################################################
# Descriptions...: 科目轉換
# Memo...........:
# Input parameter: 
#                : p_gldn001      上層公司
#                : p_gldnld       合併帳別
#                : p_gldn040      下層公司
#                : p_gldn041      下層帳別
#                : p_gldn007p     來源科目
#                : p_gldn_ar      固定核算項的dynamic array
# Return code....: r_success
#                : r_gldn007      合併科目
#                : r_gldf008      記帳幣匯率取用方式 
#                : r_gldf009      功能幣匯率取用方式
#                : r_gldf010      報告幣匯率取用方式
# Date & Author..: 150409 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp700_get_item(p_gldn001,p_gldnld,p_gldn040,p_gldn041,p_gldn007p,p_gldn_ar)
   DEFINE p_gldn_ar DYNAMIC ARRAY OF RECORD   #核算項
          chr1       LIKE type_t.chr1000,
          dat       LIKE type_t.dat
          END RECORD
   DEFINE p_gldn001 LIKE gldn_t.gldn001
   DEFINE p_gldnld  LIKE gldn_t.gldnld
   DEFINE p_gldn040 LIKE gldn_t.gldn040
   DEFINE p_gldn041 LIKE gldn_t.gldn041
   DEFINE l_glaa134 LIKE glaa_t.glaa134      #選用哪一個核算項  為空時代表沒設定
   DEFINE l_gldf005 LIKE gldf_t.gldf005
   DEFINE l_sql     STRING
   DEFINE p_gldn007p LIKE gldn_t.gldn007
   DEFINE r_success  LIKE type_t.num5
   DEFINE r_gldn007  LIKE gldn_t.gldn007
   DEFINE r_gldf008  LIKE gldf_t.gldf008
   DEFINE r_gldf009  LIKE gldf_t.gldf009
   DEFINE r_gldf010  LIKE gldf_t.gldf010
   DEFINE l_gldf    RECORD 
                    gldf007   LIKE gldf_t.gldf007,
                    gldf008   LIKE gldf_t.gldf008,
                    gldf009   LIKE gldf_t.gldf009,
                    gldf010   LIKE gldf_t.gldf010
                    END RECORD
   
   LET r_success = TRUE
   #依傳入上層公司合併帳別/下層公司下層帳別+核算項(未設定給' ')/科目去抓agli511科目轉換設定
   LET l_glaa134 = NULL
   SELECT glaa134 INTO l_glaa134 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_gldn041
   CASE
      WHEN cl_null(l_glaa134) OR l_glaa134 = '0'
         LET l_gldf005 = NULL
      OTHERWISE
         LET l_gldf005 = p_gldn_ar[l_glaa134].chr1
   END CASE
   
   LET l_sql = "SELECT gldf007,gldf008,gldf009,gldf010 FROM gldf_t ",
               " WHERE gldfent = ",g_enterprise," ",
               "   AND gldf001 = '",p_gldn040,"' ",
               "   AND gldf002 = '",p_gldn041,"' ",
               "   AND gldf003 = '",p_gldn001,"' ",
               "   AND gldf004 = '",p_gldnld,"' ",
               "   AND gldf006 = '",p_gldn007p,"' "
    IF cl_null(l_glaa134)THEN
       LET l_sql = l_sql CLIPPED," AND gldf005 = ' ' "
    ELSE
       LET l_sql = l_sql CLIPPED," AND (gldf005 = '",l_gldf005,"' OR gldf005 = ' ') "
    END IF
    PREPARE sel_gldfp1 FROM l_sql
    EXECUTE sel_gldfp1 INTO l_gldf.*
  
    IF SQLCA.SQLCODE = 100 THEN
       LET r_success = FALSE
       INITIALIZE g_errparam.* TO NULL
       LET g_errparam.code = 'agl-00334'
       LET g_errparam.extend = cl_getmsg('agl-00410',g_dlang),':',p_gldn040,cl_getmsg('axc-00582',g_dlang),':',p_gldn007p
       CALL cl_err()
       RETURN r_success,r_gldn007,r_gldf008,r_gldf009,r_gldf010
    END IF
    
    LET r_gldn007 = l_gldf.gldf007
    LET r_gldf008 = l_gldf.gldf008
    LET r_gldf009 = l_gldf.gldf009
    LET r_gldf010 = l_gldf.gldf010
    
    RETURN r_success,r_gldn007,r_gldf008,r_gldf009,r_gldf010
  
END FUNCTION

################################################################################
# Descriptions...: 取匯率
# Memo...........:
# Input parameter: 
#                : p_gldf008      轉換科目設定記帳幣匯率取用方式
#                : p_gldf009      轉換科目設定功能幣匯率取用方式
#                : p_gldf010      轉換科目設定報告幣匯率取用方式
#                : p_glaa001s     來源帳別記帳幣
#                : p_glaa016s     來源帳別功能幣
#                : p_glaa020s     來源帳別報告幣
#                : p_glaa001t     合併帳別記帳幣
#                : p_glaa016t     合併帳別功能幣
#                : p_glaa020t     合併帳別報告幣
#                : p_glaa132      帳別平均匯率設定
#                : p_yys          來源年度
#                : p_mms          來源期別
#                : p_yyt          合併年度
#                : p_mmt          合併期別
# Return code....: r_success,r_errno
#                : r_exchange1    記帳幣匯率
#                : r_exchange2    功能幣匯率
#                : r_exchange3    報告幣匯率
# Date & Author..: 150409 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp700_get_exchange1(p_gldf008,p_gldf009,p_gldf010,p_glaa001s,p_glaa016s,p_glaa020s,p_glaa001t,p_glaa016t,p_glaa020t,p_glaa132,p_yys,p_mms,p_yyt,p_mmt)
   DEFINE p_gldf008   LIKE gldf_t.gldf008    #轉換科目設定記帳幣匯率取用方式
   DEFINE p_gldf009   LIKE gldf_t.gldf009    #轉換科目設定功能幣匯率取用方式
   DEFINE p_gldf010   LIKE gldf_t.gldf010    #轉換科目設定報告幣匯率取用方式
   DEFINE p_glaa001s  LIKE glaa_t.glaa001    #來源帳別記帳幣
   DEFINE p_glaa016s  LIKE glaa_t.glaa016    #來源帳別功能幣
   DEFINE p_glaa020s  LIKE glaa_t.glaa020    #來源帳別報告幣
   DEFINE p_glaa001t  LIKE glaa_t.glaa001    #合併帳別記帳幣
   DEFINE p_glaa016t  LIKE glaa_t.glaa016    #合併帳別功能幣
   DEFINE p_glaa020t  LIKE glaa_t.glaa020    #合併帳別報告幣
   DEFINE p_glaa132   LIKE glaa_t.glaa132    #帳別平均匯率設定
   DEFINE p_yys       LIKE type_t.num5       #來源年度
   DEFINE p_mms       LIKE type_t.num5       #來源期別
   DEFINE p_yyt       LIKE type_t.num5       #合併年度
   DEFINE p_mmt       LIKE type_t.num5       #合併期別
   
   DEFINE r_exchange1 LIKE type_t.num20_6    #記帳幣匯率
   DEFINE r_exchange2 LIKE type_t.num20_6    #功能幣匯率
   DEFINE r_exchange3 LIKE type_t.num20_6    #報告幣匯率
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   #EX-----s
   #(1) S: NTD     CNY     USD
   #        V       V       V
   #    T: USD     NTD     CNY
   
   #(2) S: NTD     CNY     USD
   #        V
   #    T: USD      X       X
   
   #(3) S: USD      X       X
   #    T: NTD     CNY     USD
   #       都用記帳幣轉換成其他兩個缺少的幣別
   #-------e
   
   #先處理幣別來源跟目的方邏輯
   #目的方資料
   #目的功能幣有值   來源功能幣沒值
   IF NOT cl_null(p_glaa016t) AND cl_null(p_glaa016s)THEN
      LET p_glaa016s = p_glaa001s
   END IF
   
   #目的報告幣有值   來源報告幣沒值
   IF NOT cl_null(p_glaa020t) AND cl_null(p_glaa020s)THEN
      LET p_glaa020s = p_glaa001s
   END IF   
   #-----
   #    S: NTD     CNY     USD
   #        V       V       V
   #    T: USD     NTD     CNY
   #-----
   
   #各依各的方式去做
   CALL aglp700_get_exchange2(p_glaa001s,p_glaa001t,p_gldf008,p_glaa132,p_yys,p_mms,p_yyt,p_mmt)
         RETURNING g_sub_success,g_errno,r_exchange1
         
   CALL aglp700_get_exchange2(p_glaa016s,p_glaa016t,p_gldf009,p_glaa132,p_yys,p_mms,p_yyt,p_mmt)
         RETURNING g_sub_success,g_errno,r_exchange2
         
   CALL aglp700_get_exchange2(p_glaa020s,p_glaa020t,p_gldf010,p_glaa132,p_yys,p_mms,p_yyt,p_mmt)
         RETURNING g_sub_success,g_errno,r_exchange3
   
   RETURN r_success,r_errno,r_exchange1,r_exchange2,r_exchange3
END FUNCTION

################################################################################
# Descriptions...: 來源幣別目的幣別方式得匯率
# Input parameter: 
#                : p_currs     來源幣別
#                : p_currt     目的幣別
#                : p_type      1.現時匯率 2.歷史匯率 3.平均匯率
#                : p_glaa132   1.當期異動*當月平均匯率
#                              2.當期科目餘額累計數*(本期平均匯率加總/期數)
#                              3.當期科目餘額累計數*最期末平均匯率
#                : p_yys       來源年度
#                : p_mms       來源期別
#                : p_yyt       合併年度
#                : p_mmt       合併期別
# Return code....: r_success,r_errno
#                : r_exchange  要回傳的匯率
# Memo...........:
# Date & Author..: 150410 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp700_get_exchange2(p_currs,p_currt,p_type,p_glaa132,p_yys,p_mms,p_yyt,p_mmt)
   DEFINE p_currs     LIKE glaa_t.glaa001    #來源幣別
   DEFINE p_currt     LIKE glaa_t.glaa001    #目的幣別
   DEFINE p_type      LIKE type_t.chr1       #1.現時匯率 2.歷史匯率 3.平均匯率
   DEFINE p_glaa132   LIKE glaa_t.glaa132    #1.當期異動*當月平均匯率
                                             #2.當期科目餘額累計數*(本期平均匯率加總/期數)
                                             #3.當期科目餘額累計數*最期末平均匯率
   DEFINE p_yys       LIKE type_t.num5       #來源年度
   DEFINE p_mms       LIKE type_t.num5       #來源期別
   DEFINE p_yyt       LIKE type_t.num5       #合併年度
   DEFINE p_mmt       LIKE type_t.num5       #合併期別
   DEFINE r_exchange  LIKE type_t.num20_6    #要回傳的匯率
   DEFINE r_success   LIKE type_t.num5        
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_gldo      RECORD
                      gldo005   LIKE gldo_t.gldo005,    #限時匯率
                      gldo006   LIKE gldo_t.gldo006,    #歷史匯率
                      gldo007   LIKE gldo_t.gldo007     #平均匯率
                      END RECORD
   DEFINE l_gldo2     RECORD
                      gldo007s  LIKE gldo_t.gldo007,    #平均匯率總合
                      gldocnt   LIKE type_t.num5        #抓出來的平均匯率筆數
                      END RECORD
   DEFINE l_sql       STRING
   
   LET r_success = TRUE
   LET r_errno   = NULL
   LET l_sql = "SELECT gldo005,gldo006,gldo007 FROM gldo_t ",
               " WHERE gldoent = ",g_enterprise," ",
               "   AND gldo001 = ? ",
               "   AND gldo002 = ? ",
               "   AND gldo003 = ? ",
               "   AND gldo004 = ? "
   PREPARE sel_gldop1 FROM l_sql
   LET l_sql = "SELECT SUM(gldo007),COUNT(*) FROM gldo_t ",
               " WHERE gldoent = ",g_enterprise," ",
               "   AND gldo001 = ? ",
               "   AND gldo002 = ? ",
               "   AND gldo003 = ? ",
               "   AND gldo004 <= ? "
   PREPARE sel_gldop2 FROM l_sql   
   
   CASE  
      WHEN p_type = '1'
         #現時匯率
         INITIALIZE l_gldo.* TO NULL
         EXECUTE sel_gldop1 USING p_yyt,p_mmt,p_currs,p_currt
            INTO l_gldo.*
         LET r_exchange = l_gldo.gldo005
      WHEN p_type = '2'
         #歷史匯率
         INITIALIZE l_gldo.* TO NULL
         EXECUTE sel_gldop1 USING p_yyt,p_mmt,p_currs,p_currt
            INTO l_gldo.*
         LET r_exchange = l_gldo.gldo006
      WHEN p_type ='3'
         #平均匯率
         CASE
            WHEN p_glaa132 = '1'   #1.當期異動*當月平均匯率
            
               INITIALIZE l_gldo.* TO NULL
               EXECUTE sel_gldop1 USING p_yyt,p_mmt,p_currs,p_currt
                  INTO l_gldo.*
               LET r_exchange = l_gldo.gldo007
               
            WHEN p_glaa132 = '2'  #當期科目餘額累計數*(本期平均匯率加總/期數)
               INITIALIZE l_gldo2.* TO NULL
               EXECUTE sel_gldop2 USING p_yyt,p_mmt,p_currs,p_currt
                  INTO l_gldo2.*
               IF NOT cl_null(l_gldo2.gldocnt)THEN
                  LET r_exchange = l_gldo2.gldo007s/l_gldo2.gldocnt            
               ELSE
                  LET r_exchange = 0 
               END IF
            WHEN p_glaa132 = '3'  #3.當期科目餘額累計數*最期末平均匯率
               INITIALIZE l_gldo.* TO NULL
               EXECUTE sel_gldop1 USING p_yys,p_mms,p_currs,p_currt
                  INTO l_gldo.*
               LET r_exchange = l_gldo.gldo007               
         END CASE
   END CASE
  
   IF cl_null(r_exchange)THEN LET r_exchange = 0 END IF
   IF SQLCA.SQLCODE = 100 AND p_type <> '2' THEN
      LET r_success = FALSE
      LET r_errno = 'agl-00335'
   END IF
   FREE sel_gldop1
   FREE sel_gldop2
   RETURN r_success,r_errno,r_exchange
END FUNCTION

################################################################################
# Descriptions...: 上下層合併帳+公司+科目+動態核算項
#                # 取歷史金額
# Usage..........:
# Input parameter: p_gldn001      上層公司
#                : p_gldnld       合併帳
#                : p_gldn040      下層公司
#                : p_gldn041      下層帳
#                : p_gldn007p     合併前科目
#                : p_type         1記帳2功能3報告
# Return code....: r_success,r_errno
#                : r_accountc     歷史金額借
#                : r_accountd     歷史金額貸
# Memo...........:
# Date & Author..: 150413 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp700_get_history_count(p_gldn001,p_gldnld,p_gldn040,p_gldn041,p_gldn007p,p_type,p_yy,p_mm)
   DEFINE p_gldn_ar DYNAMIC ARRAY OF RECORD   #核算項
          chr1        LIKE type_t.chr1000,
          dat        LIKE type_t.dat
          END RECORD
   DEFINE p_gldn001  LIKE gldn_t.gldn001
   DEFINE p_gldnld   LIKE gldn_t.gldnld
   DEFINE p_gldn040  LIKE gldn_t.gldn040
   DEFINE p_gldn041  LIKE gldn_t.gldn041
   DEFINE l_glaa134  LIKE glaa_t.glaa134      #選用哪一個核算項  為空時代表沒設定
   DEFINE p_gldn007p LIKE gldn_t.gldn007      #轉換前科目
   DEFINE p_type     LIKE type_t.chr10        #哪種幣
   DEFINE l_sql      STRING
   DEFINE r_success  LIKE type_t.num5         #成功否用於外層判斷有無取得歷史金額
   DEFINE r_errno    LIKE gzze_t.gzze001
   DEFINE r_accountc  LIKE type_t.num20_6      #歷史金額(借
   DEFINE r_accountd  LIKE type_t.num20_6      #歷史金額(代
   DEFINE l_gldi008   LIKE gldi_t.gldi008      #動態固定核算項
   DEFINE l_gldi      RECORD
                      gldi012   LIKE gldi_t.gldi012,
                      gldi013   LIKE gldi_t.gldi013,
                      gldi014   LIKE gldi_t.gldi014,
                      gldi015   LIKE gldi_t.gldi015,
                      gldi016   LIKE gldi_t.gldi016,
                      gldi017   LIKE gldi_t.gldi017
                      END RECORD
   DEFINE p_yy        LIKE type_t.num5         #抓取的期間年度
   DEFINE p_mm        LIKE type_t.num5         #抓取的期間其別
   DEFINE l_strdat    LIKE type_t.dat  
   DEFINE l_enddat    LIKE type_t.dat
   DEFINE l_glaa003   LIKE glaa_t.glaa003

   
   LET l_glaa003 = NULL
   SELECT glaa003 INTO l_glaa003 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_gldnld
   CALL s_fin_date_get_period_range(l_glaa003,p_yy,p_mm)
                     RETURNING l_strdat,l_enddat
   
   #agli513 的異動日期處理方式 
   #=>取異動日期小於目前批次期別的異動資料後累計(ex.2015/5則取小於2015/5/1)
   
   
   LET r_success = TRUE
   LET r_errno = NULL
   LET l_sql = "  SELECT SUM(gldi012),SUM(gldi013),SUM(gldi014), ",
               "         SUM(gldi015),SUM(gldi016),SUM(gldi017)  ",
               "    FROM gldi_t ",
               "   WHERE gldient = ",g_enterprise,
               "     AND gldi001 = '",p_gldn040,"'" ,
               "     AND gldi002 = '",p_gldn041,"' ",
               "     AND gldi003 = '",p_gldn001,"' ",
               "     AND gldi004 = '",p_gldnld,"' ",
               "     AND gldi008 = '",l_gldi008,"'",
               "     AND gldi009 = '",p_gldn007p,"' ",
               "     AND gldi011 < '",l_strdat,"' "
    PREPARE sel_gldip1 FROM l_sql
    
    EXECUTE sel_gldip1 INTO l_gldi.*
    
    CASE
       WHEN p_type = '1'
          LET r_accountc = l_gldi.gldi012
          LET r_accountd = l_gldi.gldi013
       WHEN p_type = '2'
          LET r_accountc = l_gldi.gldi014
          LET r_accountd = l_gldi.gldi015
       WHEN p_type = '3'
          LET r_accountc = l_gldi.gldi016
          LET r_accountd = l_gldi.gldi017
    END CASE
    
    IF cl_null(r_accountc)THEN LET r_accountc = 0 END IF
    IF cl_null(r_accountd)THEN LET r_accountd = 0 END IF
    
    IF r_accountc = 0 AND r_accountd = 0 THEN
       LET r_success = FALSE
    END IF
    RETURN r_success,r_errno,r_accountc,r_accountd
    
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Date & Author..: 150414 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp700_create_tmp()
   DROP TABLE aglp700_tmp
   CREATE TEMP TABLE aglp700_tmp(
       gldcld    VARCHAR(5),          #合併帳別
       gldc001   VARCHAR(10),         #上層公司
       gldc002   VARCHAR(10),         #下層公司
       gldc003   VARCHAR(5),         #下層個體帳
       gldc009   VARCHAR(1)     #最上層否
   );
END FUNCTION

################################################################################
# Descriptions...: 展結點 INS TEMP
# Memo...........:
# Usage..........: CALL aglp700_ins_node(p_gldbld,p_gldb001,p_gldb002)
# Input parameter: p_gldcld       合併帳別
#                : p_gldc001      上層公司
# Date & Author..: 150414 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp700_ins_node(p_gldbld,p_gldb001,p_gldb002,p_root)
   DEFINE p_gldbld   LIKE gldb_t.gldbld
   DEFINE p_gldb001  LIKE gldb_t.gldb001
   DEFINE p_gldb002  LIKE gldb_t.gldb002
   DEFINE p_root     LIKE type_t.chr1
   DEFINE l_node     DYNAMIC ARRAY OF RECORD
                     gldc002   LIKE gldc_t.gldc002,    #下層公司   
                     gldc003   LIKE gldc_t.gldc003     #下層帳別
                     END RECORD
   DEFINE l_sql      STRING
   DEFINE l_i        LIKE type_t.num10                 #array index
   DEFINE l_count    LIKE type_t.num10                 #判斷存在否
   DEFINE l_gldb002  LIKE gldb_t.gldb002
   DEFINE l_tmp      RECORD
                     gldcld   LIKE gldc_t.gldcld,     #合併帳別
                     gldc001  LIKE gldc_t.gldc001,    #上層公司
                     gldc002  LIKE gldc_t.gldc002,    #下層公司
                     gldc003  LIKE gldc_t.gldc003,    #下層個體帳
                     gldc009  LIKE gldc_t.gldc009     #最上層否   
                     END RECORD
                     
   IF cl_null(p_gldb002)THEN 
      LET p_gldb002 = NULL
      SELECT gldb002 INTO p_gldb002 FROM gldb_t
       WHERE gldbld =  p_gldbld
         AND gldb001 = p_gldb001
         AND gldbent = g_enterprise   #160905-00007#4  by 08172              
   END IF
   
   LET l_sql = " SELECT gldc002,gldc003 FROM gldc_t ",
               "  WHERE gldcent = ",g_enterprise," ",
               "    AND gldcld  = '",p_gldbld,"' ",
               "    AND gldc001 = '",p_gldb001,"' "  ,
               "    AND gldc005 = 'Y' "               
   PREPARE sel_gldcp3 FROM l_sql
   DECLARE sel_gldcc3 CURSOR FOR sel_gldcp3
   
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,")"
   PREPARE sel_gldccntp1 FROM l_sql
   
   LET l_count = NULL
   EXECUTE sel_gldccntp1 INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   INITIALIZE l_tmp.* TO NULL
   LET l_tmp.gldc002 = p_gldb001
   LET l_tmp.gldc003 = p_gldb002
   LET l_tmp.gldc009 = p_root   
   INSERT INTO aglp700_tmp VALUES(l_tmp.*)
   
   IF l_count > 0 THEN
      CALL l_node.clear()
      LET l_i = 1
      FOREACH sel_gldcc3 INTO l_node[l_i].*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'sel_gldcc3'
            CALL cl_err()
            EXIT FOREACH
         END IF
      END FOREACH
      
      FOR l_i = 1 TO l_node.getLength()
         LET l_gldb002 = NULL
         SELECT gldb002 INTO l_gldb002 FROM gldb_t
          WHERE gldbld = l_node[l_i].gldc003
            AND gldb001 = l_node[l_i].gldc002
            AND gldbent = g_enterprise   #160905-00007#4  by 08172 
         CALL aglp700_ins_node(l_node[l_i].gldc003,l_node[l_i].gldc002,l_gldb002,'N')
      END FOR
   END IF
   
   
END FUNCTION

PRIVATE FUNCTION aglp700_qbe_clear()
   LET g_master.l_yy = YEAR(g_today)
   LET g_master.l_mms = 0
   LET g_master.l_mme = MONTH(g_today)
   CALL aglp700_set_entry()
   DISPLAY BY NAME g_master.l_yy, g_master.l_mms, g_master.l_mme
END FUNCTION

PRIVATE FUNCTION aglp700_set_entry()
   SELECT glaa138 INTO g_master.l_type FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.l_gldnld
   IF cl_null(g_master.l_type) THEN LET g_master.l_type = '0' END IF

   CALL cl_set_comp_entry("l_mme,l_chk1,l_chk2",TRUE)
   CASE g_master.l_type
      WHEN 0
         LET g_master.l_chk1 = '0'
         LET g_master.l_chk2 = '0'
         LET g_master.l_mme = MONTH(g_today)
         CALL cl_set_comp_entry("l_chk1,l_chk2",FALSE)
      WHEN 1
         LET g_master.l_mme = ''
         LET g_master.l_chk2 = '0'
         LET g_master.l_chk1 = '1'
         CALL cl_set_comp_entry("l_mme,l_chk2",FALSE)
      WHEN 2
         LET g_master.l_mme = ''
         LET g_master.l_chk1 = '0'
         LET g_master.l_chk2 = '1'
         CALL cl_set_comp_entry("l_mme,l_chk1",FALSE)
   END CASE
   DISPLAY BY NAME g_master.l_type,g_master.l_mme,g_master.l_chk1,g_master.l_chk2
END FUNCTION

#end add-point
 
{</section>}
 
