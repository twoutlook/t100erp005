#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp751.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-12-01 17:55:54), PR版次:0002(2016-11-29 11:12:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aglp751
#+ Description: 合併後資料上傳作業
#+ Creator....: 06821(2015-12-01 17:39:04)
#+ Modifier...: 06821 -SD/PR- 02481
 
{</section>}
 
{<section id="aglp751.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161128-00061#1   2016/11/29  by 02481  标准程式定义采用宣告模式,弃用.*写法
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
       glebld LIKE gleb_t.glebld, 
   glebld_desc LIKE type_t.chr80, 
   gleb001 LIKE gleb_t.gleb001, 
   gleb001_desc LIKE type_t.chr80, 
   gleb003 LIKE gleb_t.gleb003, 
   l_glaa138 LIKE type_t.chr500, 
   gleb004 LIKE gleb_t.gleb004, 
   chk1 LIKE type_t.chr500, 
   chk2 LIKE type_t.chr500, 
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
 
{<section id="aglp751.main" >}
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
      CALL aglp751_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp751 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp751_init()
 
      #進入選單 Menu (="N")
      CALL aglp751_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp751
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp751.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp751_init()
 
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
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglp751.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp751_ui_dialog()
 
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
   CALL aglp751_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glebld,g_master.gleb001,g_master.gleb003,g_master.l_glaa138,g_master.gleb004, 
             g_master.chk1,g_master.chk2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glebld
            
            #add-point:AFTER FIELD glebld name="input.a.glebld"
            #合併帳別
            LET g_master.glebld_desc = ' '
            DISPLAY BY NAME g_master.glebld_desc
            IF NOT cl_null(g_master.glebld) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glebld,g_master.gleb001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.glebld = ''
                  LET g_master.glebld_desc = ''
                  DISPLAY BY NAME g_master.glebld,g_master.glebld_desc    
                  NEXT FIELD CURRENT
               END IF             
            END IF
            CALL aglp751_set_entry()
            CALL s_desc_get_ld_desc(g_master.glebld) RETURNING g_master.glebld_desc
            DISPLAY BY NAME g_master.glebld,g_master.glebld_desc  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glebld
            #add-point:BEFORE FIELD glebld name="input.b.glebld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glebld
            #add-point:ON CHANGE glebld name="input.g.glebld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gleb001
            
            #add-point:AFTER FIELD gleb001 name="input.a.gleb001"
            #上層公司
            LET g_master.gleb001_desc = ' '
            DISPLAY BY NAME g_master.gleb001_desc
            IF NOT cl_null(g_master.gleb001) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glebld,g_master.gleb001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.gleb001 = ''
                  LET g_master.gleb001_desc = ''
                  DISPLAY BY NAME g_master.gleb001,g_master.gleb001_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.gleb001_desc = s_desc_glda001_desc(g_master.gleb001)
            DISPLAY BY NAME g_master.gleb001,g_master.gleb001_desc,g_master.glebld,g_master.glebld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gleb001
            #add-point:BEFORE FIELD gleb001 name="input.b.gleb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gleb001
            #add-point:ON CHANGE gleb001 name="input.g.gleb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gleb003
            #add-point:BEFORE FIELD gleb003 name="input.b.gleb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gleb003
            
            #add-point:AFTER FIELD gleb003 name="input.a.gleb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gleb003
            #add-point:ON CHANGE gleb003 name="input.g.gleb003"
            
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
            CALL aglp751_set_entry()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gleb004
            #add-point:BEFORE FIELD gleb004 name="input.b.gleb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gleb004
            
            #add-point:AFTER FIELD gleb004 name="input.a.gleb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gleb004
            #add-point:ON CHANGE gleb004 name="input.g.gleb004"
            
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
 
 
 
                     #Ctrlp:input.c.glebld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glebld
            #add-point:ON ACTION controlp INFIELD glebld name="input.c.glebld"
            #合併帳別
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL                                                
            LET g_qryparam.state = 'i'                                                     
            LET g_qryparam.reqry = FALSE                                                   
            LET g_qryparam.default1 = g_master.glebld                                     
            LET g_qryparam.arg1 = g_user                                 #人員權限         
            LET g_qryparam.arg2 = g_dept                                 #部門權限         
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",              
                                               "  WHERE gldbstus = 'Y' ",                                    
                                               "   AND gldbent = '",g_enterprise,"') "                          
            CALL q_authorised_ld()                                                         
            LET g_master.glebld = g_qryparam.return1                                      
            CALL s_desc_get_ld_desc(g_master.glebld) RETURNING g_master.glebld_desc 
            CALL aglp751_set_entry()            
            DISPLAY BY NAME g_master.glebld,g_master.glebld_desc                         
            NEXT FIELD glebld                                                             

            #END add-point
 
 
         #Ctrlp:input.c.gleb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gleb001
            #add-point:ON ACTION controlp INFIELD gleb001 name="input.c.gleb001"
            #上層公司
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gleb001
            LET g_qryparam.where = "gldc009 = 'Y' AND gldbstus = 'Y' ",
                                   " AND gldcld = '",g_master.glebld,"' "  
            CALL q_gldc001()    
            LET g_master.gleb001 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_master.gleb001) RETURNING g_master.gleb001_desc
            DISPLAY BY NAME g_master.gleb001,g_master.gleb001_desc
            NEXT FIELD gleb001
            #END add-point
 
 
         #Ctrlp:input.c.gleb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gleb003
            #add-point:ON ACTION controlp INFIELD gleb003 name="input.c.gleb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glaa138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glaa138
            #add-point:ON ACTION controlp INFIELD l_glaa138 name="input.c.l_glaa138"
            
            #END add-point
 
 
         #Ctrlp:input.c.gleb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gleb004
            #add-point:ON ACTION controlp INFIELD gleb004 name="input.c.gleb004"
            
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
            CALL aglp751_get_buffer(l_dialog)
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
            CALL aglp751_qbe_clear()
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
         CALL aglp751_init()
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
                 CALL aglp751_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp751_transfer_argv(ls_js)
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
 
{<section id="aglp751.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp751_transfer_argv(ls_js)
 
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
 
{<section id="aglp751.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp751_process(ls_js)
 
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
   #DEFINE l_gleb      RECORD LIKE gleb_t.*  #主要TABLE
   #DEFINE l_glea      RECORD LIKE glea_t.*  #來源TABLE  
    DEFINE l_gleb RECORD  #合併報表上層公司上傳餘額檔
       glebent LIKE gleb_t.glebent, #企業編號
       glebld LIKE gleb_t.glebld, #合併帳套
       gleb001 LIKE gleb_t.gleb001, #上層公司編號
       gleb002 LIKE gleb_t.gleb002, #上層公司帳套
       gleb003 LIKE gleb_t.gleb003, #年度
       gleb004 LIKE gleb_t.gleb004, #期別
       gleb005 LIKE gleb_t.gleb005, #會計科目
       gleb006 LIKE gleb_t.gleb006, #組合要素(key)
       gleb007 LIKE gleb_t.gleb007, #幣別(記帳幣)
       gleb008 LIKE gleb_t.gleb008, #借方金額(記帳幣)
       gleb009 LIKE gleb_t.gleb009, #貸方金額(記帳幣)
       gleb010 LIKE gleb_t.gleb010, #借方筆數
       gleb011 LIKE gleb_t.gleb011, #貸方筆數
       gleb012 LIKE gleb_t.gleb012, #營運據點
       gleb013 LIKE gleb_t.gleb013, #部門
       gleb014 LIKE gleb_t.gleb014, #利潤/成本中心
       gleb015 LIKE gleb_t.gleb015, #區域
       gleb016 LIKE gleb_t.gleb016, #收付款客商
       gleb017 LIKE gleb_t.gleb017, #帳款客商
       gleb018 LIKE gleb_t.gleb018, #客群
       gleb019 LIKE gleb_t.gleb019, #產品類別
       gleb020 LIKE gleb_t.gleb020, #經營方式
       gleb021 LIKE gleb_t.gleb021, #渠道
       gleb022 LIKE gleb_t.gleb022, #品牌
       gleb023 LIKE gleb_t.gleb023, #人員
       gleb024 LIKE gleb_t.gleb024, #專案編號
       gleb025 LIKE gleb_t.gleb025, #WBS
       gleb026 LIKE gleb_t.gleb026, #幣別(功能幣)
       gleb027 LIKE gleb_t.gleb027, #借方金額(功能幣)
       gleb028 LIKE gleb_t.gleb028, #貸方金額(功能幣)
       gleb029 LIKE gleb_t.gleb029, #幣別(報告幣)
       gleb030 LIKE gleb_t.gleb030, #借方金額(報告幣)
       gleb031 LIKE gleb_t.gleb031, #貸方金額(報告幣)
       gleb032 LIKE gleb_t.gleb032, #原始公司編號
       gleb033 LIKE gleb_t.gleb033, #原始公司帳套
       gleb034 LIKE gleb_t.gleb034, #匯率(記帳幣)
       gleb035 LIKE gleb_t.gleb035, #匯率(功能幣)
       gleb036 LIKE gleb_t.gleb036  #匯率(報告幣)
       END RECORD
   DEFINE l_glea RECORD  #合併報表合併後各期科目餘額檔
       gleaent LIKE glea_t.gleaent, #企業編號
       gleald LIKE glea_t.gleald, #合併帳套
       glea001 LIKE glea_t.glea001, #上層公司編號
       glea002 LIKE glea_t.glea002, #上層公司帳套
       glea003 LIKE glea_t.glea003, #年度
       glea004 LIKE glea_t.glea004, #期別
       glea005 LIKE glea_t.glea005, #會計科目
       glea006 LIKE glea_t.glea006, #組合要素(key)
       glea007 LIKE glea_t.glea007, #幣別(記帳幣)
       glea008 LIKE glea_t.glea008, #借方金額(記帳幣)
       glea009 LIKE glea_t.glea009, #貸方金額(記帳幣)
       glea010 LIKE glea_t.glea010, #借方筆數
       glea011 LIKE glea_t.glea011, #貸方筆數
       glea012 LIKE glea_t.glea012, #營運據點
       glea013 LIKE glea_t.glea013, #部門
       glea014 LIKE glea_t.glea014, #利潤/成本中心
       glea015 LIKE glea_t.glea015, #區域
       glea016 LIKE glea_t.glea016, #收付款客商
       glea017 LIKE glea_t.glea017, #帳款客商
       glea018 LIKE glea_t.glea018, #客群
       glea019 LIKE glea_t.glea019, #產品類別
       glea020 LIKE glea_t.glea020, #經營方式
       glea021 LIKE glea_t.glea021, #渠道
       glea022 LIKE glea_t.glea022, #品牌
       glea023 LIKE glea_t.glea023, #人員
       glea024 LIKE glea_t.glea024, #專案編號
       glea025 LIKE glea_t.glea025, #WBS
       glea026 LIKE glea_t.glea026, #幣別(功能幣)
       glea027 LIKE glea_t.glea027, #借方金額(功能幣)
       glea028 LIKE glea_t.glea028, #貸方金額(功能幣)
       glea029 LIKE glea_t.glea029, #幣別(報告幣)
       glea030 LIKE glea_t.glea030, #借方金額(報告幣)
       glea031 LIKE glea_t.glea031, #貸方金額(報告幣)
       glea032 LIKE glea_t.glea032, #原始公司編號
       glea033 LIKE glea_t.glea033, #原始公司帳套
       glea034 LIKE glea_t.glea034, #匯率(記帳幣)
       glea035 LIKE glea_t.glea035, #匯率(功能幣)
       glea036 LIKE glea_t.glea036  #匯率(報告幣)
       END RECORD

   #161128-00061#1----modify------end-----------   
   DEFINE l_glaa003   LIKE glaa_t.glaa003   #會計周期參照表
   DEFINE l_gleb004   LIKE gleb_t.gleb004   #期別
   DEFINE l_argv      LIKE gleb_t.gleb004   #編制合併期別抓取條件
   DEFINE l_cnt       LIKE type_t.num10 
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #取得會計參照表
   SELECT glaa003 INTO l_glaa003 FROM glaa_t  WHERE glaaent = g_enterprise AND glaald = g_master.glebld
   
   #依編制合併期別抓取條件
   LET l_argv = ''
   CASE g_master.l_glaa138
      WHEN 0
         LET l_argv = g_master.gleb004
      WHEN 1
         LET l_argv = g_master.chk1
      WHEN 2
         LET l_argv = g_master.chk2
   END CASE
   CALL s_merge_get_glav006(l_glaa003,g_master.gleb003,g_master.l_glaa138,l_argv) RETURNING g_sub_success,g_errno,l_gleb004
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(li_count+1)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aglp751_process_cs CURSOR FROM ls_sql
#  FOREACH aglp751_process_cs INTO
   #add-point:process段process name="process.process"
   LET g_success = 'Y'
   CALL s_transaction_begin()
   CALL cl_err_collect_init()

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM glea_t 
    WHERE gleaent = g_enterprise AND gleald = g_master.glebld AND glea001 = g_master.gleb001
      AND glea003 = g_master.gleb003 AND glea004 =l_gleb004
      
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      #寫入合併報表各公司執行階段記錄檔
      CALL s_merge_ins_glec(g_master.glebld,g_master.gleb001,g_prog) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')        
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
      DISPLAY '' ,0 TO stagenow,stagecomplete   #失敗:清空進度條
      CALL cl_err_collect_show()
      RETURN 
   END IF

   INITIALIZE l_gleb.* TO NULL
   INITIALIZE l_glea.* TO NULL
   #161128-00061#1----modify------begin-----------
   #LET ls_sql = "  SELECT * FROM glea_t ",
   LET ls_sql = "  SELECT gleaent,gleald,glea001,glea002,glea003,glea004,glea005,glea006,glea007,glea008,glea009,glea010,",
                "glea011,glea012,glea013,glea014,glea015,glea016,glea017,glea018,glea019,glea020,glea021,glea022,glea023,",
                "glea024,glea025,glea026,glea027,glea028,glea029,glea030,glea031,glea032,glea033,glea034,glea035,glea036 FROM glea_t ",
   #161128-00061#1----modify------end-----------
                "   WHERE gleaent = ",g_enterprise," AND gleald = '",g_master.glebld,"' AND glea001 = '",g_master.gleb001,"' ",
                "     AND glea003 = '",g_master.gleb003,"' AND glea004 ='",l_gleb004,"' "
               
   DECLARE sel_gleac CURSOR FROM ls_sql
   FOREACH sel_gleac INTO l_glea.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
      LET l_gleb.glebent = g_enterprise   #key
      LET l_gleb.glebld = l_glea.gleald 
      LET l_gleb.gleb001 = l_glea.glea001
      LET l_gleb.gleb002 = l_glea.glea002
      LET l_gleb.gleb003 = l_glea.glea003
      LET l_gleb.gleb004 = l_glea.glea004
      LET l_gleb.gleb005 = l_glea.glea005
      LET l_gleb.gleb006 = l_glea.glea006
      LET l_gleb.gleb007 = l_glea.glea007
      LET l_gleb.gleb008 = l_glea.glea008
      LET l_gleb.gleb009 = l_glea.glea009
      LET l_gleb.gleb010 = l_glea.glea010      
      LET l_gleb.gleb011 = l_glea.glea011
      LET l_gleb.gleb012 = l_glea.glea012 #核算項 
      LET l_gleb.gleb013 = l_glea.glea013
      LET l_gleb.gleb014 = l_glea.glea014  
      LET l_gleb.gleb015 = l_glea.glea015 
      LET l_gleb.gleb016 = l_glea.glea016
      LET l_gleb.gleb017 = l_glea.glea017
      LET l_gleb.gleb018 = l_glea.glea018
      LET l_gleb.gleb019 = l_glea.glea019
      LET l_gleb.gleb020 = l_glea.glea020
      LET l_gleb.gleb021 = l_glea.glea021
      LET l_gleb.gleb022 = l_glea.glea022
      LET l_gleb.gleb023 = l_glea.glea023
      LET l_gleb.gleb024 = l_glea.glea024
      LET l_gleb.gleb025 = l_glea.glea025
      LET l_gleb.gleb026 = l_glea.glea026
      LET l_gleb.gleb027 = l_glea.glea027
      LET l_gleb.gleb028 = l_glea.glea028
      LET l_gleb.gleb029 = l_glea.glea029
      LET l_gleb.gleb030 = l_glea.glea030
      LET l_gleb.gleb031 = l_glea.glea031
      LET l_gleb.gleb032 = l_glea.glea032
      LET l_gleb.gleb033 = l_glea.glea033
      LET l_gleb.gleb034 = l_glea.glea034
      LET l_gleb.gleb035 = l_glea.glea035
      LET l_gleb.gleb036 = l_glea.glea036

      IF cl_null(l_gleb.gleb008) THEN LET l_gleb.gleb008 = 0 END IF
      IF cl_null(l_gleb.gleb009) THEN LET l_gleb.gleb009 = 0 END IF
      IF cl_null(l_gleb.gleb027) THEN LET l_gleb.gleb027 = 0 END IF
      IF cl_null(l_gleb.gleb028) THEN LET l_gleb.gleb028 = 0 END IF
      IF cl_null(l_gleb.gleb030) THEN LET l_gleb.gleb030 = 0 END IF
      IF cl_null(l_gleb.gleb031) THEN LET l_gleb.gleb031 = 0 END IF
      
      IF cl_null(l_gleb.gleb012) THEN LET l_gleb.gleb012 = ' ' END IF
      IF cl_null(l_gleb.gleb013) THEN LET l_gleb.gleb013 = ' ' END IF
      IF cl_null(l_gleb.gleb014) THEN LET l_gleb.gleb014 = ' ' END IF  
      IF cl_null(l_gleb.gleb015) THEN LET l_gleb.gleb015 = ' ' END IF 
      IF cl_null(l_gleb.gleb016) THEN LET l_gleb.gleb016 = ' ' END IF
      IF cl_null(l_gleb.gleb017) THEN LET l_gleb.gleb017 = ' ' END IF
      IF cl_null(l_gleb.gleb018) THEN LET l_gleb.gleb018 = ' ' END IF
      IF cl_null(l_gleb.gleb019) THEN LET l_gleb.gleb019 = ' ' END IF
      IF cl_null(l_gleb.gleb020) THEN LET l_gleb.gleb020 = ' ' END IF
      IF cl_null(l_gleb.gleb021) THEN LET l_gleb.gleb021 = ' ' END IF
      IF cl_null(l_gleb.gleb022) THEN LET l_gleb.gleb022 = ' ' END IF
      IF cl_null(l_gleb.gleb023) THEN LET l_gleb.gleb023 = ' ' END IF
      IF cl_null(l_gleb.gleb024) THEN LET l_gleb.gleb024 = ' ' END IF
      IF cl_null(l_gleb.gleb025) THEN LET l_gleb.gleb025 = ' ' END IF

      #先刪除
      DELETE FROM gleb_t
       WHERE glebent = g_enterprise   AND glebld = l_gleb.glebld 
         AND gleb001 = l_gleb.gleb001 AND gleb002 = l_gleb.gleb002 
         AND gleb003 = l_gleb.gleb003 AND gleb004 = l_gleb.gleb004 
         AND gleb005 = l_gleb.gleb005 AND gleb006 = l_gleb.gleb006 
         AND gleb032 = l_gleb.gleb032 AND gleb033 = l_gleb.gleb033
         
      #寫入gleb_t
      #161128-00061#1----modify------begin-----------
      #INSERT INTO gleb_t VALUES(l_gleb.*)
      INSERT INTO gleb_t (glebent,glebld,gleb001,gleb002,gleb003,gleb004,gleb005,gleb006,gleb007,gleb008,gleb009,
                          gleb010,gleb011,gleb012,gleb013,gleb014,gleb015,gleb016,gleb017,gleb018,gleb019,gleb020,
                          gleb021,gleb022,gleb023,gleb024,gleb025,gleb026,gleb027,gleb028,gleb029,gleb030,gleb031,
                          gleb032,gleb033,gleb034,gleb035,gleb036)
       VALUES(l_gleb.glebent,l_gleb.glebld,l_gleb.gleb001,l_gleb.gleb002,l_gleb.gleb003,l_gleb.gleb004,l_gleb.gleb005,l_gleb.gleb006,l_gleb.gleb007,l_gleb.gleb008,l_gleb.gleb009,
              l_gleb.gleb010,l_gleb.gleb011,l_gleb.gleb012,l_gleb.gleb013,l_gleb.gleb014,l_gleb.gleb015,l_gleb.gleb016,l_gleb.gleb017,l_gleb.gleb018,l_gleb.gleb019,l_gleb.gleb020,
              l_gleb.gleb021,l_gleb.gleb022,l_gleb.gleb023,l_gleb.gleb024,l_gleb.gleb025,l_gleb.gleb026,l_gleb.gleb027,l_gleb.gleb028,l_gleb.gleb029,l_gleb.gleb030,l_gleb.gleb031,
              l_gleb.gleb032,l_gleb.gleb033,l_gleb.gleb034,l_gleb.gleb035,l_gleb.gleb036)
      #161128-00061#1----modify------end-----------
      
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins gleb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      CALL cl_progress_no_window_ing("")       #成功:執行推進
   END FOREACH

   IF g_success = 'Y' THEN
      #寫入合併報表各公司執行階段記錄檔
      CALL s_merge_ins_glec(g_master.glebld,g_master.gleb001,g_prog) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()    
         DISPLAY '' ,0 TO stagenow,stagecomplete   #失敗:清空進度條          
      ELSE
         CALL s_transaction_end('Y','0')
         CALL cl_err_collect_show() 
         CALL cl_progress_no_window_ing("")       #成功:執行推進
      END IF 
   ELSE
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show()   
      DISPLAY '' ,0 TO stagenow,stagecomplete   #失敗:清空進度條 
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
   CALL aglp751_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp751.get_buffer" >}
PRIVATE FUNCTION aglp751_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glebld = p_dialog.getFieldBuffer('glebld')
   LET g_master.gleb001 = p_dialog.getFieldBuffer('gleb001')
   LET g_master.gleb003 = p_dialog.getFieldBuffer('gleb003')
   LET g_master.l_glaa138 = p_dialog.getFieldBuffer('l_glaa138')
   LET g_master.gleb004 = p_dialog.getFieldBuffer('gleb004')
   LET g_master.chk1 = p_dialog.getFieldBuffer('chk1')
   LET g_master.chk2 = p_dialog.getFieldBuffer('chk2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp751.msgcentre_notify" >}
PRIVATE FUNCTION aglp751_msgcentre_notify()
 
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
 
{<section id="aglp751.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aglp751_qbe_clear()
# Date & Author..: 151117 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp751_qbe_clear()
DEFINE l_glaacomp LIKE glaa_t.glaacomp
DEFINE l_glaald   LIKE glaa_t.glaald
DEFINE l_glaa138  LIKE glaa_t.glaa138

   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
   SELECT glaa138 INTO l_glaa138 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_glaald
   IF cl_null(l_glaa138) THEN LET l_glaa138 = '0' END IF
   
   LET g_master.gleb003 = YEAR(g_today)
   LET g_master.chk1 = '0'
   LET g_master.chk2 = '0'
   LET g_master.l_glaa138 = l_glaa138
   CALL aglp751_set_entry()

   DISPLAY BY NAME g_master.gleb003,g_master.l_glaa138,g_master.chk1,g_master.chk2,g_master.gleb004
END FUNCTION
################################################################################
# Descriptions...: 依合併編制期別條件 開放期/季/年輸入
# Memo...........:
# Usage..........: CALL aglp751_set_entry()
# Date & Author..: 151118 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp751_set_entry()
   SELECT glaa138 INTO g_master.l_glaa138 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glebld
   IF cl_null(g_master.l_glaa138) THEN LET g_master.l_glaa138 = '0' END IF

   CALL cl_set_comp_entry("gleb004,chk1,chk2",TRUE)
   CASE g_master.l_glaa138
      WHEN 0
         LET g_master.chk1 = '0'
         LET g_master.chk2 = '0'
         LET g_master.gleb004 = MONTH(g_today)
         CALL cl_set_comp_entry("chk1,chk2",FALSE)
         CALL cl_set_comp_required("gleb004",TRUE)
      WHEN 1
         LET g_master.gleb004 = ''
         LET g_master.chk2 = '0'
         LET g_master.chk1 = '1'
         CALL cl_set_comp_entry("gleb004,chk2",FALSE)
         CALL cl_set_comp_required("chk1",TRUE)
      WHEN 2
         LET g_master.gleb004 = ''
         LET g_master.chk1 = '0'
         LET g_master.chk2 = '1'
         CALL cl_set_comp_entry("gleb004,chk1",FALSE)
         CALL cl_set_comp_required("chk2",TRUE)
   END CASE
   DISPLAY BY NAME g_master.l_glaa138,g_master.gleb004,g_master.chk1,g_master.chk2
END FUNCTION

#end add-point
 
{</section>}
 
