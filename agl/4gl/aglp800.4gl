#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp800.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-03-14 15:53:32), PR版次:0001(2016-04-08 14:31:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: aglp800
#+ Description: 合併現金流量表直接法資料導入
#+ Creator....: 06821(2016-03-14 15:37:32)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglp800.global" >}
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
       glefld LIKE glef_t.glefld, 
   glefld_desc LIKE type_t.chr80, 
   glef001 LIKE glef_t.glef001, 
   glef001_desc LIKE type_t.chr80, 
   glef004 LIKE glef_t.glef004, 
   glef005 LIKE glef_t.glef005, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaa003   LIKE glaa_t.glaa003    #會計週期參照表
DEFINE g_glef      RECORD                 #主table(合併報表現流表直接法現金變動碼明細資料匯入檔)
         glefent	 LIKE glef_t.glefent,   #企業編號
         glefld	 LIKE glef_t.glefld,    #合併帳套
         glef001	 LIKE glef_t.glef001,   #上層公司
         glef002	 LIKE glef_t.glef002,   #個體公司
         glef003	 LIKE glef_t.glef003,   #個體帳套
         glef004	 LIKE glef_t.glef004,   #年度
         glef005	 LIKE glef_t.glef005,   #期別
         glef006	 LIKE glef_t.glef006,   #現金變動碼
         glef007	 LIKE glef_t.glef007,   #變動分類
         glef008	 LIKE glef_t.glef008,   #關係人
         glef009	 LIKE glef_t.glef009,   #幣別(記帳幣)
         glef010	 LIKE glef_t.glef010,   #匯率(記帳幣)
         glef011	 LIKE glef_t.glef011,   #金額(記帳幣)
         glef012	 LIKE glef_t.glef012,   #幣別(功能幣)
         glef013	 LIKE glef_t.glef013,   #匯率(功能幣)
         glef014	 LIKE glef_t.glef014,   #金額(功能幣)
         glef015	 LIKE glef_t.glef015,   #幣別(報告幣)
         glef016	 LIKE glef_t.glef016,   #匯率(報告幣)
         glef017	 LIKE glef_t.glef017,   #金額(報告幣)
         glef018	 LIKE glef_t.glef018    #資料來源
                   END RECORD
DEFINE g_glaa      RECORD                 #帳套相關設定資料
         glaa001	 LIKE glaa_t.glaa001,
         glaa015	 LIKE glaa_t.glaa015,
         glaa016	 LIKE glaa_t.glaa016,
         glaa019	 LIKE glaa_t.glaa019,
         glaa020	 LIKE glaa_t.glaa020,
         glaa005 	 LIKE glaa_t.glaa005 
                   END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglp800.main" >}
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
      CALL aglp800_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp800 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp800_init()
 
      #進入選單 Menu (="N")
      CALL aglp800_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp800
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp800.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp800_init()
 
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
 
{<section id="aglp800.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp800_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_pdate_s   LIKE glav_t.glav004   
   DEFINE l_pdate_e   LIKE glav_t.glav004   
   DEFINE l_flag      LIKE type_t.chr1
   DEFINE l_errno     LIKE type_t.chr100
   DEFINE l_glav002   LIKE glav_t.glav002  
   DEFINE l_glav005   LIKE glav_t.glav005  
   DEFINE l_sdate_s   LIKE glav_t.glav004
   DEFINE l_sdate_e   LIKE glav_t.glav004
   DEFINE l_glav006   LIKE glav_t.glav006
   DEFINE l_glav007   LIKE glav_t.glav007
   DEFINE l_wdate_s   LIKE glav_t.glav004
   DEFINE l_wdate_e   LIKE glav_t.glav004
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glefld,g_master.glef001,g_master.glef004,g_master.glef005 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glefld
            
            #add-point:AFTER FIELD glefld name="input.a.glefld"
            #合併帳別
            LET g_master.glefld_desc = ' '
            DISPLAY BY NAME g_master.glefld_desc
            IF NOT cl_null(g_master.glefld) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glefld,g_master.glef001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.glefld = ''
                  LET g_master.glefld_desc = ''
                  DISPLAY BY NAME g_master.glefld,g_master.glefld_desc    
                  NEXT FIELD CURRENT
               END IF             
            END IF
            CALL s_desc_get_ld_desc(g_master.glefld) RETURNING g_master.glefld_desc
            DISPLAY BY NAME g_master.glefld,g_master.glefld_desc   

            #會計周期參照表
            SELECT glaa003 INTO g_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glefld
            
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(g_glaa003,g_today,'','')
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
                      
            LET g_master.glef004 = l_glav002   #會計年度
            LET g_master.glef005 = l_glav006   #會計期別
            DISPLAY BY NAME g_master.glef004,g_master.glef005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glefld
            #add-point:BEFORE FIELD glefld name="input.b.glefld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glefld
            #add-point:ON CHANGE glefld name="input.g.glefld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef001
            
            #add-point:AFTER FIELD glef001 name="input.a.glef001"
            #上層公司
            LET g_master.glef001_desc = ' '
            DISPLAY BY NAME g_master.glef001_desc
            IF NOT cl_null(g_master.glef001) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glefld,g_master.glef001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.glef001 = ''
                  LET g_master.glef001_desc = ''
                  DISPLAY BY NAME g_master.glef001,g_master.glef001_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.glef001_desc = s_desc_glda001_desc(g_master.glef001)
            DISPLAY BY NAME g_master.glef001,g_master.glef001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef001
            #add-point:BEFORE FIELD glef001 name="input.b.glef001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef001
            #add-point:ON CHANGE glef001 name="input.g.glef001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef004
            #add-point:BEFORE FIELD glef004 name="input.b.glef004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef004
            
            #add-point:AFTER FIELD glef004 name="input.a.glef004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef004
            #add-point:ON CHANGE glef004 name="input.g.glef004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glef005
            #add-point:BEFORE FIELD glef005 name="input.b.glef005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glef005
            
            #add-point:AFTER FIELD glef005 name="input.a.glef005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glef005
            #add-point:ON CHANGE glef005 name="input.g.glef005"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glefld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glefld
            #add-point:ON ACTION controlp INFIELD glefld name="input.c.glefld"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL                                                
            LET g_qryparam.state = 'i'                                                     
            LET g_qryparam.reqry = FALSE                                                   
            LET g_qryparam.default1 = g_master.glefld                                     
            LET g_qryparam.arg1 = g_user                                 #人員權限         
            LET g_qryparam.arg2 = g_dept                                 #部門權限         
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",              
                                   "             WHERE gldbstus = 'Y' ",                                    
                                   "               AND gldbent = '",g_enterprise,"') "                                               
            CALL q_authorised_ld()                                                         
            LET g_master.glefld = g_qryparam.return1                                      
            CALL s_desc_get_ld_desc(g_master.glefld) RETURNING g_master.glefld_desc            
            DISPLAY BY NAME g_master.glefld,g_master.glefld_desc                         
            NEXT FIELD glefld 
            #END add-point
 
 
         #Ctrlp:input.c.glef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef001
            #add-point:ON ACTION controlp INFIELD glef001 name="input.c.glef001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glef001
            LET g_qryparam.where = " gldc009 = 'Y' AND gldbstus = 'Y' ",
                                   " AND gldcld = '",g_master.glefld,"' "  
            CALL q_gldc001()    
            LET g_master.glef001 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_master.glef001) RETURNING g_master.glef001_desc
            DISPLAY BY NAME g_master.glef001,g_master.glef001_desc
            NEXT FIELD glef001

            #END add-point
 
 
         #Ctrlp:input.c.glef004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef004
            #add-point:ON ACTION controlp INFIELD glef004 name="input.c.glef004"
            
            #END add-point
 
 
         #Ctrlp:input.c.glef005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glef005
            #add-point:ON ACTION controlp INFIELD glef005 name="input.c.glef005"
            
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
            CALL aglp800_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL aglp800_qbe_clear()
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
            CALL aglp800_qbe_clear()
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
         CALL aglp800_init()
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
                 CALL aglp800_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp800_transfer_argv(ls_js)
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
 
{<section id="aglp800.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp800_transfer_argv(ls_js)
 
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
 
{<section id="aglp800.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp800_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_glbc        RECORD                   #來源table
            glbc004	   LIKE glbc_t.glbc004,	    #現金變動碼
            glbc005	   LIKE glbc_t.glbc005,	    #關係人
            glbc009	   LIKE glbc_t.glbc009,	    #本幣金額
            glbc012	   LIKE glbc_t.glbc012,	    #金額(本位幣二)
            glbc014	   LIKE glbc_t.glbc014	    #金額(本位幣三)
                        END RECORD
   DEFINE l_glee        RECORD                   #來源table
            glee006	   LIKE glee_t.glee006,     #現金變動碼(轉換後)
            glee007	   LIKE glee_t.glee007,     #記帳幣換算類別	
            glee008	   LIKE glee_t.glee008,     #功能幣換算類別	
            glee009	   LIKE glee_t.glee009      #報告幣換算類別   
                        END RECORD
   DEFINE l_sql1        STRING
   DEFINE ls_js1        STRING
   DEFINE lc_param1     RECORD
            up_ld       LIKE gldt_t.gldtld,       #合併帳別(合併主體)
            up_comp     LIKE gldt_t.gldt001,      #上層公司
            dn_ld       LIKE gldt_t.gldtld,       #下層帳別
            dn_comp     LIKE gldt_t.gldt001,      #下層公司
            yy          LIKE gldt_t.gldt005,      #年度
            mm          LIKE gldt_t.gldt006,      #期別
            acc         LIKE gldt_t.gldt007,      #現金變動碼
            curr1       LIKE gldt_t.gldt009,      #幣別(記帳幣)         
            curr2       LIKE gldt_t.gldt009,      #幣別(功能幣)         
            curr3       LIKE gldt_t.gldt009,      #幣別(報告幣)         
            amt1        LIKE gldt_t.gldt010,      #換匯前金額(記帳幣)
            amt2        LIKE gldt_t.gldt010,      #換匯前金額(功能幣)
            amt3        LIKE gldt_t.gldt010       #換匯前金額(報告幣)
                        END RECORD
   DEFINE lc_param2     RECORD
            r_amt1      LIKE gldt_t.gldt010,      #換匯後金額(記帳幣)          
            r_amt2      LIKE gldt_t.gldt010,      #換匯後金額(功能幣)           
            r_amt3      LIKE gldt_t.gldt010,      #換匯後金額(報告幣)            
            r_rate1     LIKE gldt_t.gldt033,      #換匯後匯率(記帳幣)  
            r_rate2     LIKE gldt_t.gldt033,      #換匯後匯率(功能幣)  
            r_rate3     LIKE gldt_t.gldt033       #換匯後匯率(報告幣)  
                        END RECORD
   DEFINE l_gldc002     LIKE gldc_t.gldc002
   DEFINE l_gldc003     LIKE gldc_t.gldc003
   DEFINE l_glbc010     LIKE glbc_t.glbc010
   DEFINE l_cnt         LIKE type_t.num10
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
      LET li_count = 0
      SELECT COUNT(*) INTO li_count 
        FROM gldc_t 
       WHERE gldcent = g_enterprise
         AND gldcld = g_master.glefld
         AND gldc001 = g_master.glef001
         AND gldc005 = 'Y' 
      IF cl_null(li_count)THEN LET li_count = 0 END IF
      CALL cl_progress_bar_no_window(li_count+1)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aglp800_process_cs CURSOR FROM ls_sql
#  FOREACH aglp800_process_cs INTO
   #add-point:process段process name="process.process"
   LET g_success = TRUE
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   
   #帳套相關資訊
   INITIALIZE g_glaa.* TO NULL
   SELECT glaa001,glaa015,glaa016,glaa019,glaa020,glaa005
     INTO g_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_master.glefld
   
   #檢查是否存在
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM glef_t 
    WHERE glefent = g_enterprise
      AND glefld  = g_master.glefld   
      AND glef001 = g_master.glef001  
      AND glef004 = g_master.glef004
      AND glef005 = g_master.glef005
   
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt > 0 THEN
      #是否刪除已存在資料
      IF NOT cl_ask_confirm("anm-00294") THEN
         DISPLAY '' ,0 TO stagenow,stagecomplete   #失敗:清空進度條
         CALL cl_err_collect_show() 
         CALL s_transaction_end('N','0')
         RETURN
      ELSE  
         #YES--
         DELETE FROM glef_t 
          WHERE glefent = g_enterprise
            AND glefld  = g_master.glefld   
            AND glef001 = g_master.glef001  
            AND glef004 = g_master.glef004
            AND glef005 = g_master.glef005
       END IF
   END IF
   
   #依輸入條件「合併帳別」+「上層公司」展出所有下階公司--------------------
   LET l_gldc002 = ''
   LET ls_sql = " SELECT gldc002 FROM gldc_t ", #下層公司
                "  WHERE gldcent = ",g_enterprise," ",
                "    AND gldcld = '",g_master.glefld,"' ",
                "    AND gldc001 = '",g_master.glef001,"' ",
                "    AND gldc005 = 'Y' ",
                "  ORDER BY gldc002 "
                
   DECLARE aglp800_gldc_c CURSOR FROM ls_sql
   FOREACH aglp800_gldc_c INTO l_gldc002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #個體公司帳套
      LET l_gldc003 = ''
      CALL s_merge_get_gl_ld(g_master.glefld,l_gldc002) RETURNING l_gldc003
      
      #取得下層公司之「現金變動碼明細檔(glbc_t)」資料進行資料寫入glef_t---------------
      INITIALIZE l_glbc.* TO NULL
      LET l_sql1 = "SELECT DISTINCT glbc004,glbc005,SUM(CASE WHEN glbc003 = '2' THEN glbc009*-1 ELSE glbc009 END), ",
                   "                                SUM(CASE WHEN glbc003 = '2' THEN glbc012*-1 ELSE glbc012 END), ",
                   "                                SUM(CASE WHEN glbc003 = '2' THEN glbc014*-1 ELSE glbc014 END)  ",
                   "  FROM glbc_t ",
                   " WHERE glbcent = ",g_enterprise," ",
                   "   AND glbcld = '",l_gldc003,"' ",
                   "   AND glbc001 = '",g_master.glef004,"' ",
                   "   AND glbc002 = '",g_master.glef005,"' ",
                   " GROUP BY glbc004,glbc005 ",
                   " ORDER BY glbc004,glbc005 "
       
      DECLARE aglp800_glbc_c1 CURSOR FROM l_sql1
      FOREACH aglp800_glbc_c1 INTO l_glbc.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         IF cl_null(l_glbc.glbc009) THEN LET l_glbc.glbc009 = 0 END IF
         IF cl_null(l_glbc.glbc012) THEN LET l_glbc.glbc012 = 0 END IF
         IF cl_null(l_glbc.glbc014) THEN LET l_glbc.glbc014 = 0 END IF
         
         #資料來源
         LET l_glbc010 = ''
         SELECT glbc010 INTO l_glbc010 
           FROM glbc_t 
          WHERE glbcent = g_enterprise
            AND glbcld = l_gldc003
            AND glbc001 = g_master.glef004
            AND glbc002 = g_master.glef005
            AND glbc004 = l_glbc.glbc004
            AND glbc005 = l_glbc.glbc005
          
         #根據換算類別設定取得換匯資料---------------------------------------
         #取得轉換後現金變動碼(glee006)/記帳幣換算類別(glee007)/功能幣換算類別(glee008)/報告幣換算類別(glee009)
         INITIALIZE l_glee.* TO NULL
         SELECT glee006,glee007,glee008,glee009 
           INTO l_glee.*
           FROM glee_t
          WHERE gleeent = g_enterprise
            AND glee001 = l_gldc003          #帳別/合併帳別(轉換前)
            AND glee002 = l_gldc002          #公司編號(轉換前)
            AND glee003 = g_master.glefld    #合併帳別(轉換後)
            AND glee004 = g_master.glef001   #公司編號(轉換後)
            AND glee005 = l_glbc.glbc004     #現金變動碼(轉換前)
         
         #未設定agli551,不繼續寫入
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00440'
            LET g_errparam.extend = l_glbc.glbc004
            LET g_errparam.replace[1] = l_gldc003
            LET g_errparam.replace[2] = l_gldc002
            LET g_errparam.replace[3] = g_master.glefld
            LET g_errparam.replace[4] = g_master.glef001          
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            CONTINUE FOREACH
         END IF
         
         INITIALIZE g_glef.* TO NULL
         LET g_glef.glefent  = g_enterprise      #企業編號
         LET g_glef.glefld	  = g_master.glefld   #合併帳套
         LET g_glef.glef001  = g_master.glef001  #上層公司
         LET g_glef.glef002  = l_gldc002         #個體公司
         LET g_glef.glef003  = l_gldc003         #個體帳套
         LET g_glef.glef004  = g_master.glef004  #年度
         LET g_glef.glef005  = g_master.glef005  #期別
         LET g_glef.glef006  = l_glee.glee006    #現金變動碼
         
         SELECT nmai003 INTO g_glef.glef007      #變動分類
           FROM nmai_t 
          WHERE nmaient = g_enterprise AND nmai001 = g_glaa.glaa005 AND nmai002 = g_glef.glef006         
             
         LET g_glef.glef008  = l_glbc.glbc005    #關係人
         IF cl_null(g_glef.glef008) THEN LET g_glef.glef008 = " " END IF
         LET g_glef.glef009  = g_glaa.glaa001    #幣別(記帳幣)
         LET g_glef.glef010  = '1'	             #匯率(記帳幣)
         LET g_glef.glef013  = '1'               #匯率(功能幣)
         LET g_glef.glef016  = '1'               #匯率(報告幣)
         LET g_glef.glef018  = l_glbc010         #資料來源
         
         LET g_glef.glef011  = l_glbc.glbc009    #金額(記帳幣)
         CALL s_curr_round_ld('1',g_master.glefld,g_glaa.glaa001,g_glef.glef011,2) RETURNING g_sub_success,g_errno,g_glef.glef011   
         
         IF g_glaa.glaa015 = 'Y' THEN 
            LET g_glef.glef012 = g_glaa.glaa016  #幣別(功能幣)
            LET g_glef.glef014 = l_glbc.glbc012  #金額(功能幣)
            CALL s_curr_round_ld('1',g_master.glefld,g_glaa.glaa016,g_glef.glef014,2) RETURNING g_sub_success,g_errno,g_glef.glef014   
         ELSE
            LET g_glef.glef014 = '0'             #金額(功能幣)
         END IF
         
         IF g_glaa.glaa019 = 'Y' THEN 
            LET g_glef.glef015 = g_glaa.glaa020  #幣別(報告幣)
            LET g_glef.glef017 = l_glbc.glbc014  #金額(報告幣)
            CALL s_curr_round_ld('1',g_master.glefld,g_glaa.glaa020,g_glef.glef017,2) RETURNING g_sub_success,g_errno,g_glef.glef017
         ELSE
            LET g_glef.glef017 = '0'             #金額(功能幣)
         END IF

         #合併帳別與公司帳別不同,則需要換匯--------------------------------
         IF g_master.glefld <> l_gldc003 THEN
            INITIALIZE lc_param1.* TO NULL
            LET lc_param1.up_ld   = g_glef.glefld     #合併帳別(合併主體)
            LET lc_param1.up_comp = g_glef.glef001    #上層公司
            LET lc_param1.dn_ld   = g_glef.glef003    #下層帳別
            LET lc_param1.dn_comp = g_glef.glef002    #下層公司
            LET lc_param1.yy      = g_glef.glef004    #年度
            LET lc_param1.mm      = g_glef.glef005    #期別
            LET lc_param1.acc     = g_glef.glef006    #現金變動碼
            LET lc_param1.curr1   = g_glef.glef009    #幣別(記帳幣)         
            LET lc_param1.curr2   = g_glef.glef012    #幣別(功能幣)         
            LET lc_param1.curr3   = g_glef.glef015    #幣別(報告幣)         
            LET lc_param1.amt1    = g_glef.glef011    #換匯前金額(記帳幣)
            LET lc_param1.amt2    = g_glef.glef014    #換匯前金額(功能幣)
            LET lc_param1.amt3    = g_glef.glef017    #換匯前金額(報告幣)
            LET ls_js1 = util.JSON.stringify(lc_param1)      
            CALL s_merge_get_examt(ls_js1) RETURNING ls_js1  
            CALL util.JSON.parse(ls_js1,lc_param2)
            LET g_glef.glef010  = lc_param2.r_rate1  #匯率(記帳幣)
            LET g_glef.glef013  = lc_param2.r_rate2  #匯率(功能幣)
            LET g_glef.glef016  = lc_param2.r_rate3  #匯率(報告幣)
            LET g_glef.glef011  = lc_param2.r_amt1   #金額(記帳幣)
            LET g_glef.glef014  = lc_param2.r_amt2   #金額(記帳幣)
            LET g_glef.glef017  = lc_param2.r_amt3   #金額(記帳幣)
         END IF
         
         INSERT INTO glef_t(glefent,glefld,glef001,glef002,glef003,glef004,glef005,
                            glef006,glef007,glef008,glef009,glef010,glef011,glef012,
                            glef013,glef014,glef015,glef016,glef017,glef018) 
                     VALUES(g_glef.*)

         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins glef_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH
      
      CALL cl_progress_no_window_ing("")       #每次執行推進
   END FOREACH
   
   IF g_success THEN
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_show() 
      CALL cl_progress_no_window_ing("")       #成功:最後一次次執行推進
   ELSE
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show()   
      DISPLAY '' ,0 TO stagenow,stagecomplete  #失敗:清空進度條      
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
   CALL aglp800_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp800.get_buffer" >}
PRIVATE FUNCTION aglp800_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glefld = p_dialog.getFieldBuffer('glefld')
   LET g_master.glef001 = p_dialog.getFieldBuffer('glef001')
   LET g_master.glef004 = p_dialog.getFieldBuffer('glef004')
   LET g_master.glef005 = p_dialog.getFieldBuffer('glef005')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp800.msgcentre_notify" >}
PRIVATE FUNCTION aglp800_msgcentre_notify()
 
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
 
{<section id="aglp800.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aglp800_qbe_clear()
# Date & Author..: 160314 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp800_qbe_clear()
DEFINE l_glaacomp  LIKE glaa_t.glaacomp   #法人
DEFINE l_glaald    LIKE glaa_t.glaald     #帳套
DEFINE l_pdate_s   LIKE glav_t.glav004   
DEFINE l_pdate_e   LIKE glav_t.glav004   
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_errno     LIKE type_t.chr100
DEFINE l_glav002   LIKE glav_t.glav002  
DEFINE l_glav005   LIKE glav_t.glav005  
DEFINE l_sdate_s   LIKE glav_t.glav004
DEFINE l_sdate_e   LIKE glav_t.glav004
DEFINE l_glav006   LIKE glav_t.glav006
DEFINE l_glav007   LIKE glav_t.glav007
DEFINE l_wdate_s   LIKE glav_t.glav004
DEFINE l_wdate_e   LIKE glav_t.glav004 


   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
   SELECT glaa003 INTO g_glaa003 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_glaald
   
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
             
   LET g_master.glef004 = l_glav002   #會計年度
   LET g_master.glef005 = l_glav006   #會計期別
   
   DISPLAY BY NAME g_master.glef004,g_master.glef005
END FUNCTION

#end add-point
 
{</section>}
 
