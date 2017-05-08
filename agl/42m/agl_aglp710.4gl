#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp710.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-11-30 09:52:46), PR版次:0001(2015-12-17 17:39:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aglp710
#+ Description: 合併報表結轉損益產生作業-依調整項目
#+ Creator....: 06821(2015-11-26 18:22:29)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglp710.global" >}
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
       gldpld LIKE gldp_t.gldpld, 
   gldpld_desc LIKE type_t.chr80, 
   gldp001 LIKE gldp_t.gldp001, 
   gldp001_desc LIKE type_t.chr80, 
   gldp003 LIKE gldp_t.gldp003, 
   l_glaa138 LIKE type_t.chr500, 
   gldp004 LIKE gldp_t.gldp004, 
   chk1 LIKE type_t.chr500, 
   chk2 LIKE type_t.chr500, 
   l_docno LIKE type_t.chr500, 
   gldpdocdt LIKE gldp_t.gldpdocdt, 
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
 
{<section id="aglp710.main" >}
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
      CALL aglp710_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp710 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp710_init()
 
      #進入選單 Menu (="N")
      CALL aglp710_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp710
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp710.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp710_init()
 
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
   CALL cl_set_combo_scc('l_glaa138','9998')
   CALL s_fin_continue_no_tmp()
   
   CALL s_merge_cre_gl_tmp_table() RETURNING g_sub_success
   IF NOT g_sub_success THEN
      RETURN
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglp710.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp710_ui_dialog()
 
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
         INPUT BY NAME g_master.gldpld,g_master.gldp001,g_master.gldp003,g_master.l_glaa138,g_master.gldp004, 
             g_master.chk1,g_master.chk2,g_master.l_docno,g_master.gldpdocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldpld
            
            #add-point:AFTER FIELD gldpld name="input.a.gldpld"
            #合併帳別
            LET g_master.gldpld_desc = ' '
            DISPLAY BY NAME g_master.gldpld_desc
            IF NOT cl_null(g_master.gldpld) THEN
               CALL s_merge_ld_with_comp_chk(g_master.gldpld,g_master.gldp001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.gldpld = ''
                  LET g_master.gldpld_desc = ''
                  DISPLAY BY NAME g_master.gldpld,g_master.gldpld_desc    
                  NEXT FIELD CURRENT
               END IF             
            END IF
            CALL aglp710_set_entry()
            CALL s_desc_get_ld_desc(g_master.gldpld) RETURNING g_master.gldpld_desc
            DISPLAY BY NAME g_master.gldpld,g_master.gldpld_desc     
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldpld
            #add-point:BEFORE FIELD gldpld name="input.b.gldpld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldpld
            #add-point:ON CHANGE gldpld name="input.g.gldpld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldp001
            
            #add-point:AFTER FIELD gldp001 name="input.a.gldp001"
            #上層公司
            LET g_master.gldp001_desc = ' '
            DISPLAY BY NAME g_master.gldp001_desc
            IF NOT cl_null(g_master.gldp001) THEN
               CALL s_merge_ld_with_comp_chk(g_master.gldpld,g_master.gldp001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.gldp001 = ''
                  LET g_master.gldp001_desc = ''
                  DISPLAY BY NAME g_master.gldp001,g_master.gldp001_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.gldp001_desc = s_desc_glda001_desc(g_master.gldp001)
            DISPLAY BY NAME g_master.gldp001,g_master.gldp001_desc,g_master.gldpld,g_master.gldpld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldp001
            #add-point:BEFORE FIELD gldp001 name="input.b.gldp001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldp001
            #add-point:ON CHANGE gldp001 name="input.g.gldp001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldp003
            #add-point:BEFORE FIELD gldp003 name="input.b.gldp003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldp003
            
            #add-point:AFTER FIELD gldp003 name="input.a.gldp003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldp003
            #add-point:ON CHANGE gldp003 name="input.g.gldp003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glaa138
            #add-point:BEFORE FIELD l_glaa138 name="input.b.l_glaa138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glaa138
            
            #add-point:AFTER FIELD l_glaa138 name="input.a.l_glaa138"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glaa138
            #add-point:ON CHANGE l_glaa138 name="input.g.l_glaa138"
            CALL aglp710_set_entry()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldp004
            #add-point:BEFORE FIELD gldp004 name="input.b.gldp004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldp004
            
            #add-point:AFTER FIELD gldp004 name="input.a.gldp004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldp004
            #add-point:ON CHANGE gldp004 name="input.g.gldp004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk1
            #add-point:BEFORE FIELD chk1 name="input.b.chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk1
            
            #add-point:AFTER FIELD chk1 name="input.a.chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk1
            #add-point:ON CHANGE chk1 name="input.g.chk1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk2
            #add-point:BEFORE FIELD chk2 name="input.b.chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk2
            
            #add-point:AFTER FIELD chk2 name="input.a.chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk2
            #add-point:ON CHANGE chk2 name="input.g.chk2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_docno
            #add-point:BEFORE FIELD l_docno name="input.b.l_docno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_docno
            
            #add-point:AFTER FIELD l_docno name="input.a.l_docno"
            IF NOT cl_null(g_master.l_docno) THEN
               IF NOT s_aooi200_fin_chk_docno(g_master.gldpld,'','',g_master.l_docno,g_today,'aglt508') THEN
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldpdocdt
            #add-point:BEFORE FIELD gldpdocdt name="input.b.gldpdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldpdocdt
            
            #add-point:AFTER FIELD gldpdocdt name="input.a.gldpdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldpdocdt
            #add-point:ON CHANGE gldpdocdt name="input.g.gldpdocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.gldpld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldpld
            #add-point:ON ACTION controlp INFIELD gldpld name="input.c.gldpld"
            #合併帳別
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL                                                
            LET g_qryparam.state = 'i'                                                     
            LET g_qryparam.reqry = FALSE                                                   
            LET g_qryparam.default1 = g_master.gldpld                                     
            LET g_qryparam.arg1 = g_user                                 #人員權限         
            LET g_qryparam.arg2 = g_dept                                 #部門權限         
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",              
                                               "  WHERE gldbstus = 'Y' ",                                    
                                               "   AND gldbent = '",g_enterprise,"') "                          
            CALL q_authorised_ld()                                                         
            LET g_master.gldpld = g_qryparam.return1                                      
            CALL s_desc_get_ld_desc(g_master.gldpld) RETURNING g_master.gldpld_desc 
            CALL aglp710_set_entry()              
            DISPLAY BY NAME g_master.gldpld,g_master.gldpld_desc                         
            NEXT FIELD gldpld        
            #END add-point
 
 
         #Ctrlp:input.c.gldp001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldp001
            #add-point:ON ACTION controlp INFIELD gldp001 name="input.c.gldp001"
            #上層公司
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gldp001
            LET g_qryparam.where = "gldc009 = 'Y' AND gldbstus = 'Y' ",
                                   " AND gldcld = '",g_master.gldpld,"' "  
            CALL q_gldc001()    
            LET g_master.gldp001 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_master.gldp001) RETURNING g_master.gldp001_desc
            DISPLAY BY NAME g_master.gldp001,g_master.gldp001_desc
            NEXT FIELD gldp001
            #END add-point
 
 
         #Ctrlp:input.c.gldp003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldp003
            #add-point:ON ACTION controlp INFIELD gldp003 name="input.c.gldp003"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glaa138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glaa138
            #add-point:ON ACTION controlp INFIELD l_glaa138 name="input.c.l_glaa138"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldp004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldp004
            #add-point:ON ACTION controlp INFIELD gldp004 name="input.c.gldp004"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk1
            #add-point:ON ACTION controlp INFIELD chk1 name="input.c.chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk2
            #add-point:ON ACTION controlp INFIELD chk2 name="input.c.chk2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_docno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_docno
            #add-point:ON ACTION controlp INFIELD l_docno name="input.c.l_docno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  =g_master.gldpld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_docno
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'aglt508'
            CALL q_ooba002_1()
            LET g_master.l_docno = g_qryparam.return1
            DISPLAY BY NAME g_master.l_docno
            NEXT FIELD l_docno
            #END add-point
 
 
         #Ctrlp:input.c.gldpdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldpdocdt
            #add-point:ON ACTION controlp INFIELD gldpdocdt name="input.c.gldpdocdt"
            
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
            CALL aglp710_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL aglp710_qbe_clear()
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
            CALL aglp710_qbe_clear()
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
         CALL aglp710_init()
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
                 CALL aglp710_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp710_transfer_argv(ls_js)
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
 
{<section id="aglp710.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp710_transfer_argv(ls_js)
 
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
 
{<section id="aglp710.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp710_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE g_gldpdocno   LIKE gldp_t.gldpdocno
   DEFINE l_glaa003     LIKE glaa_t.glaa003   #會計周期參照表
   DEFINE l_gldp004     LIKE gldp_t.gldp004   #期別
   DEFINE l_argv        LIKE gldp_t.gldp004   #編制合併期別抓取條件
   DEFINE l_gldpdocno   LIKE gldp_t.gldpdocno
   DEFINE l_docdt       LIKE gldp_t.gldpdocdt
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #取得會計參照表
   SELECT glaa003 INTO l_glaa003 FROM glaa_t  WHERE glaaent = g_enterprise AND glaald = g_master.gldpld
   
   #依編制合併期別抓取條件
   LET l_argv = ''
   CASE g_master.l_glaa138
      WHEN 0
         LET l_argv = g_master.gldp004
      WHEN 1
         LET l_argv = g_master.chk1
      WHEN 2
         LET l_argv = g_master.chk2
   END CASE
   CALL s_merge_get_glav006(l_glaa003,g_master.gldp003,g_master.l_glaa138,l_argv) RETURNING g_sub_success,g_errno,l_gldp004
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aglp710_process_cs CURSOR FROM ls_sql
#  FOREACH aglp710_process_cs INTO
   #add-point:process段process name="process.process"
   #LET ls_js = ''
   LET li_count = '0'
   CALL s_transaction_begin()
   CALL cl_err_collect_init()

   #該條件是否有資料處理
   SELECT COUNT(*) INTO li_count
    FROM gldq_t,gldp_t 
   WHERE gldqent = gldpent AND gldqdocno = gldpdocno  
     AND gldpent = g_enterprise AND gldpstus = 'Y' 
     AND gldpld  = g_master.gldpld 
     AND gldp001 IN (SELECT gldc002 FROM gldc_t WHERE gldcent = g_enterprise AND gldcld = g_master.gldpld AND gldc001 = g_master.gldp001)
     AND gldp003 = g_master.gldp003
     AND gldp004 = l_gldp004
     AND gldp005 = '1'                           #來源碼
     AND gldp006 IN ('U','V')                    #調整/沖銷類型
     AND gldq001 IN ( SELECT glac002 FROM glac_t WHERE glacent = g_enterprise AND glac003 <> '1' AND glac007 = '6' AND glac006 = '1' )                  
    
   IF li_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #若已存在相同合併帳別+上層公司+年度+期別資料，則彈窗詢問是否刪除
   LET li_count = '0'
   SELECT COUNT(*) INTO li_count
     FROM gldp_t 
    WHERE gldpent = g_enterprise AND gldpld = g_master.gldpld AND gldp001 = g_master.gldp001 
      AND gldp003 = g_master.gldp003 AND gldp004 = l_gldp004 AND gldp005 = '1' AND gldp006 = 'W'
      
   IF li_count > 0 THEN
      #是否刪除已存在傳票
      IF NOT cl_ask_confirm("agl-00396") THEN
         #NO-> RETURN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show() 
         RETURN
      ELSE  
         #YES-> DEL DATA
         LET ls_sql = " SELECT gldpdocno FROM gldp_t ",
                      "  WHERE gldpent = ",g_enterprise," AND gldpld = '",g_master.gldpld,"' AND gldp001 = '",g_master.gldp001,"' ",
                      "    AND gldp003 = '",g_master.gldp003,"' AND gldp004 = '",l_gldp004,"' AND gldp005 = '1' AND gldp006 = 'W' "
                      
         DECLARE aglp710_del_gldp_c CURSOR FROM ls_sql
         FOREACH aglp710_del_gldp_c INTO l_gldpdocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show() 
               EXIT FOREACH
               RETURN
            END IF
            
            #刪除計提投資收益檔單頭檔
            DELETE FROM gldp_t 
             WHERE gldpent = g_enterprise AND gldpdocno = l_gldpdocno
             
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "del gldp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show() 
               EXIT FOREACH
               RETURN
            ELSE
               #更新最大單號
               LET g_prog = 'aglt508'
               LET l_docdt = s_date_get_last_date(g_master.gldpdocdt)
               IF NOT s_aooi200_fin_del_docno(g_master.gldpld,l_gldpdocno,l_docdt) THEN
                  LET g_prog = 'aglp710' 
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show() 
                  EXIT FOREACH
                  RETURN
               END IF
               LET g_prog = 'aglp710'  
            
               #刪除計提投資收益檔單身
               DELETE FROM gldq_t 
                WHERE gldqent = g_enterprise AND gldqdocno = l_gldpdocno
                
               IF SQLCA.SQLcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "del gldq_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show() 
                  EXIT FOREACH
                  RETURN
               END IF
            END IF 
         END FOREACH  
      END IF
   END IF

   CALL s_merge_gen_gl(g_master.gldpld,g_master.gldp001,g_master.gldp003,l_gldp004,g_master.l_docno,g_master.gldpdocdt,'1','','aglp710')
        RETURNING g_sub_success,g_gldpdocno,g_gldpdocno
   
   IF g_sub_success THEN
      #寫入合併報表各公司執行階段記錄檔
      CALL s_merge_ins_glec(g_master.gldpld,g_master.gldp001,g_prog) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()         
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
         CALL cl_err_collect_show() 
      END IF 
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axr-00120' #傳票拋轉失敗
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show() 
      RETURN
   END IF
   
   #清空temptable
   CALL s_merge_drop_gl_tmp_table() RETURNING g_sub_success 
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
   CALL aglp710_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp710.get_buffer" >}
PRIVATE FUNCTION aglp710_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.gldpld = p_dialog.getFieldBuffer('gldpld')
   LET g_master.gldp001 = p_dialog.getFieldBuffer('gldp001')
   LET g_master.gldp003 = p_dialog.getFieldBuffer('gldp003')
   LET g_master.l_glaa138 = p_dialog.getFieldBuffer('l_glaa138')
   LET g_master.gldp004 = p_dialog.getFieldBuffer('gldp004')
   LET g_master.chk1 = p_dialog.getFieldBuffer('chk1')
   LET g_master.chk2 = p_dialog.getFieldBuffer('chk2')
   LET g_master.l_docno = p_dialog.getFieldBuffer('l_docno')
   LET g_master.gldpdocdt = p_dialog.getFieldBuffer('gldpdocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp710.msgcentre_notify" >}
PRIVATE FUNCTION aglp710_msgcentre_notify()
 
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
 
{<section id="aglp710.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aglp710_qbe_clear()
# Date & Author..: 151130 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp710_qbe_clear()
DEFINE l_glaacomp LIKE glaa_t.glaacomp
DEFINE l_glaald   LIKE glaa_t.glaald
DEFINE l_glaa138  LIKE glaa_t.glaa138

   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
   SELECT glaa138 INTO l_glaa138 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_glaald
   IF cl_null(l_glaa138) THEN LET l_glaa138 = '0' END IF
   
   LET g_master.gldp003 = YEAR(g_today)
   LET g_master.gldpdocdt = g_today
   LET g_master.chk1 = '0'
   LET g_master.chk2 = '0'
   LET g_master.l_glaa138 = l_glaa138
   CALL aglp710_set_entry()

   DISPLAY BY NAME g_master.gldp003,g_master.gldpdocdt,g_master.l_glaa138,g_master.chk1,g_master.chk2,g_master.gldp004
END FUNCTION

################################################################################
# Descriptions...: 依合併編制期別條件 開放期/季/年輸入
# Memo...........:
# Usage..........: CALL aglp710_set_entry()
# Date & Author..: 151130 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp710_set_entry()
   SELECT glaa138 INTO g_master.l_glaa138 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.gldpld
   IF cl_null(g_master.l_glaa138) THEN LET g_master.l_glaa138 = '0' END IF

   CALL cl_set_comp_entry("gldp004,chk1,chk2",TRUE)
   CASE g_master.l_glaa138
      WHEN 0
         LET g_master.chk1 = '0'
         LET g_master.chk2 = '0'
         LET g_master.gldp004 = MONTH(g_today)
         CALL cl_set_comp_entry("chk1,chk2",FALSE)
         CALL cl_set_comp_required("gldp004",TRUE)
      WHEN 1
         LET g_master.gldp004 = ''
         LET g_master.chk2 = '0'
         LET g_master.chk1 = '1'
         CALL cl_set_comp_entry("gldp004,chk2",FALSE)
         CALL cl_set_comp_required("chk1",TRUE)
      WHEN 2
         LET g_master.gldp004 = ''
         LET g_master.chk1 = '0'
         LET g_master.chk2 = '1'
         CALL cl_set_comp_entry("gldp004,chk1",FALSE)
         CALL cl_set_comp_required("chk2",TRUE)
   END CASE
   DISPLAY BY NAME g_master.l_glaa138,g_master.gldp004,g_master.chk1,g_master.chk2
END FUNCTION

#end add-point
 
{</section>}
 
