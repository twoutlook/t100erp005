#該程式未解開Section, 採用最新樣板產出!
{<section id="aglp850.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-12 11:08:04), PR版次:0001(2016-05-26 19:18:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000023
#+ Filename...: aglp850
#+ Description: 合併現金流量表間接法期末結轉作業
#+ Creator....: 06821(2016-05-11 17:35:46)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglp850.global" >}
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
       glemld LIKE glem_t.glemld, 
   glemld_desc LIKE type_t.chr80, 
   glem001 LIKE glem_t.glem001, 
   glem001_desc LIKE type_t.chr80, 
   glem002 LIKE glem_t.glem002, 
   glem003 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaa003     LIKE glaa_t.glaa003     #會計週期參照表
DEFINE g_glaa135     LIKE glaa_t.glaa135     #現流表間接法群組參照表號
DEFINE g_glaa004     LIKE glaa_t.glaa004     #會計科目參照表號
DEFINE g_max_period  LIKE glem_t.glem003     #最大期別
DEFINE g_glab005is   LIKE glab_t.glab005    
DEFINE g_glab005bs   LIKE glab_t.glab005
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglp850.main" >}
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
      CALL aglp850_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglp850 WITH FORM cl_ap_formpath("agl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aglp850_init()
 
      #進入選單 Menu (="N")
      CALL aglp850_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aglp850
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aglp850.init" >}
#+ 初始化作業
PRIVATE FUNCTION aglp850_init()
 
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
 
{<section id="aglp850.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglp850_ui_dialog()
 
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
         INPUT BY NAME g_master.glemld,g_master.glem001,g_master.glem002,g_master.glem003 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glemld
            
            #add-point:AFTER FIELD glemld name="input.a.glemld"
            #合併帳別
            LET g_master.glemld_desc = ' '
            DISPLAY BY NAME g_master.glemld_desc
            IF NOT cl_null(g_master.glemld) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glemld,g_master.glem001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.glemld = ''
                  LET g_master.glemld_desc = ''
                  DISPLAY BY NAME g_master.glemld,g_master.glemld_desc    
                  NEXT FIELD CURRENT
               END IF             
            END IF
            CALL s_desc_get_ld_desc(g_master.glemld) RETURNING g_master.glemld_desc
            DISPLAY BY NAME g_master.glemld,g_master.glemld_desc   
            
            #會計周期參照表
            SELECT glaa003,glaa135,glaa004 INTO g_glaa003,g_glaa135,g_glaa004 
             FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.glemld
            
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(g_glaa003,g_today,'','')
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
                      
            LET g_master.glem002 = l_glav002   #會計年度
            LET g_master.glem003 = 0           #會計期別
            DISPLAY BY NAME g_master.glem002,g_master.glem003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glemld
            #add-point:BEFORE FIELD glemld name="input.b.glemld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glemld
            #add-point:ON CHANGE glemld name="input.g.glemld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glem001
            
            #add-point:AFTER FIELD glem001 name="input.a.glem001"
            #上層公司
            LET g_master.glem001_desc = ' '
            DISPLAY BY NAME g_master.glem001_desc
            IF NOT cl_null(g_master.glem001) THEN
               CALL s_merge_ld_with_comp_chk(g_master.glemld,g_master.glem001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.glem001 = ''
                  LET g_master.glem001_desc = ''
                  DISPLAY BY NAME g_master.glem001,g_master.glem001_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.glem001_desc = s_desc_glda001_desc(g_master.glem001)
            DISPLAY BY NAME g_master.glem001,g_master.glem001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glem001
            #add-point:BEFORE FIELD glem001 name="input.b.glem001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glem001
            #add-point:ON CHANGE glem001 name="input.g.glem001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glem002
            #add-point:BEFORE FIELD glem002 name="input.b.glem002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glem002
            
            #add-point:AFTER FIELD glem002 name="input.a.glem002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glem002
            #add-point:ON CHANGE glem002 name="input.g.glem002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glem003
            #add-point:BEFORE FIELD glem003 name="input.b.glem003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glem003
            
            #add-point:AFTER FIELD glem003 name="input.a.glem003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glem003
            #add-point:ON CHANGE glem003 name="input.g.glem003"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glemld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glemld
            #add-point:ON ACTION controlp INFIELD glemld name="input.c.glemld"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glemld             #給予default值
            LET g_qryparam.arg1 = g_user                          #人員權限         
            LET g_qryparam.arg2 = g_dept                          #部門權限 
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",              
                                   "             WHERE gldbstus = 'Y' ",                                    
                                   "               AND gldbent = '",g_enterprise,"') "  
            CALL q_authorised_ld()                                #呼叫開窗
            LET g_master.glemld = g_qryparam.return1              
            CALL s_desc_get_ld_desc(g_master.glemld) RETURNING g_master.glemld_desc            
            DISPLAY BY NAME g_master.glemld,g_master.glemld_desc      
            NEXT FIELD glemld                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.glem001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glem001
            #add-point:ON ACTION controlp INFIELD glem001 name="input.c.glem001"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.glem001      #給予default值
            LET g_qryparam.where = " gldc009 = 'Y' AND gldbstus = 'Y' ",
                                   " AND gldcld = '",g_master.glemld,"' "  
            CALL q_gldc001()                                #呼叫開窗
            LET g_master.glem001 = g_qryparam.return1              
            CALL s_desc_glda001_desc(g_master.glem001) RETURNING g_master.glem001_desc
            DISPLAY BY NAME g_master.glem001,g_master.glem001_desc
            NEXT FIELD glem001                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.glem002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glem002
            #add-point:ON ACTION controlp INFIELD glem002 name="input.c.glem002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glem003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glem003
            #add-point:ON ACTION controlp INFIELD glem003 name="input.c.glem003"
            
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
            CALL aglp850_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL aglp850_qbe_clear()
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
            CALL aglp850_qbe_clear()
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
         CALL aglp850_init()
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
                 CALL aglp850_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aglp850_transfer_argv(ls_js)
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
 
{<section id="aglp850.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aglp850_transfer_argv(ls_js)
 
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
 
{<section id="aglp850.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aglp850_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ld_date       DATETIME YEAR TO SECOND
   DEFINE l_glem        RECORD               #agli564_去年最末期資料
            glement     LIKE glem_t.glement, #企業編號
            glemld	   LIKE glem_t.glemld,  #合併帳套
            glem001	   LIKE glem_t.glem001,	#上層公司
            glem002	   LIKE glem_t.glem002,	#年度
            glem003	   LIKE glem_t.glem003,	#期別
            glem004	   LIKE glem_t.glem004,	#群組編號
            glem005	   LIKE glem_t.glem005,	#科目編號
            glem006	   LIKE glem_t.glem006,	#記帳幣幣別
            glem007	   LIKE glem_t.glem007,	#期初借方金額(記帳幣)
            glem008	   LIKE glem_t.glem008,	#期初貸方金額(記帳幣)
            glem009	   LIKE glem_t.glem009,	#功能幣幣別
            glem010	   LIKE glem_t.glem010,	#期初借方金額(功能幣)
            glem011	   LIKE glem_t.glem011,	#期初貸方金額(功能幣)
            glem012	   LIKE glem_t.glem012,	#報告幣幣別
            glem013	   LIKE glem_t.glem013,	#期初借方金額(報告幣)
            glem014	   LIKE glem_t.glem014	#期初貸方金額(報告幣)
                        END RECORD
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_cnt1        LIKE type_t.num10
   DEFINE l_glem015     LIKE glem_t.glem015
   DEFINE l_glem016     LIKE glem_t.glem016
   DEFINE l_glem017     LIKE glem_t.glem017
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   CALL aglp850_create_tmp()
   
   #本期損益IS科目
   LET g_glab005is = NULL
   SELECT glab005 INTO g_glab005is 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = g_master.glemld 
      AND glab001 = '12' 
      AND glab002 = '9929'
      AND glab003 = '9929_03'
      
   #本期損益BS科目
   LET g_glab005bs = NULL
   SELECT glab005 INTO g_glab005bs 
     FROM glab_t
    WHERE glabent = g_enterprise
      AND glabld  = g_master.glemld 
      AND glab001 = '12' 
      AND glab002 = '9929'
      AND glab003 = '9929_04'
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(li_count+1)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aglp850_process_cs CURSOR FROM ls_sql
#  FOREACH aglp850_process_cs INTO
   #add-point:process段process name="process.process"
   LET g_success = TRUE
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   
   #檢查是否已存在相同合併帳套+年度+期別資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM glem_t 
    WHERE glement = g_enterprise
      AND glemld  = g_master.glemld   
      AND glem001 = g_master.glem001  
      AND glem002 = g_master.glem002
      AND glem003 = g_master.glem003
   
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt > 0 THEN
      #是否刪除已存在資料
      IF NOT cl_ask_confirm("anm-00294") THEN
         DISPLAY '' ,0 TO stagenow,stagecomplete   #失敗:清空進度條
         CALL cl_err_collect_show() 
         CALL s_transaction_end('N','0')
         RETURN
       END IF
   END IF
   
   #獲取現行會計週期最大期別
   LET g_max_period = ''
   SELECT MAX(glav006) INTO g_max_period FROM glav_t
   WHERE glavent = g_enterprise AND glav001 = g_glaa003 AND glav002 = g_master.glem002-1
   
   #寫入tmp table
   CALL aglp850_insert_tmp()
   
   LET ld_date = cl_get_current() 

   #先刪除同期別資料，後寫入
   DELETE FROM glem_t 
    WHERE glement = g_enterprise
      AND glemld  = g_master.glemld   
      AND glem001 = g_master.glem001  
      AND glem002 = g_master.glem002
      AND glem003 = g_master.glem003


   #彙總後寫入glem_t(從tmp table撈出彙總後資料)-------------------------------------
   LET l_cnt1 = 0
   INITIALIZE l_glem.* TO NULL
   LET ls_sql = " SELECT glement,glemld,glem001,glem002,glem003,glem004,glem005, ",
                "        glem006,SUM(glem007),SUM(glem008), ",
                "        glem009,SUM(glem010),SUM(glem011), ",
                "        glem012,SUM(glem013),SUM(glem014) ",
                "   FROM aglp850_tmp ",
                "  WHERE glement = ? ",
                "  GROUP BY glement,glemld,glem001,glem002,glem003,glem004,glem005,glem006,glem009,glem012 ",
                "  ORDER BY glement,glemld,glem001,glem002,glem003,glem004,glem005,glem006,glem009,glem012 "
                
   DECLARE aglp850_ins_pre CURSOR FROM ls_sql
   FOREACH aglp850_ins_pre USING g_enterprise INTO l_glem.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aglp850_ins_pre"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_glem.glem002 = g_master.glem002
      LET l_glem.glem003 = g_master.glem003
      LET l_glem015 = 0
      LET l_glem016 = 0
      LET l_glem017 = 0
      
      #寫入期初金額
      IF l_glem.glem008 = 0 THEN
         LET l_glem015 = l_glem.glem007
      ELSE
         LET l_glem015 = l_glem.glem008
      END IF
      
      IF l_glem.glem011 = 0 THEN
         LET l_glem016 = l_glem.glem010
      ELSE
         LET l_glem016 = l_glem.glem011
      END IF
      
      IF l_glem.glem014 = 0 THEN
         LET l_glem017 = l_glem.glem013
      ELSE
         LET l_glem017 = l_glem.glem014
      END IF 
      
      INSERT INTO glem_t(glement,glemld,glem001,glem002,glem003,glem004,
                         glem005,glem006,glem007,glem008,glem009,glem010,
                         glem011,glem012,glem013,glem014,glem015,glem016,glem017,
                         glemownid,glemowndp,glemcrtid,glemcrtdp,glemcrtdt,glemmodid,glemmoddt,glemstus) 
                  VALUES(l_glem.*,l_glem015,l_glem016,l_glem017,
                         g_user,g_dept,g_user,g_dept,ld_date,g_user,ld_date,'Y')
                         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aglp850_ins_pre_Wrong!"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      CALL cl_progress_no_window_ing("")       #每次執行推進
      LET l_cnt1 = l_cnt1 +1
   END FOREACH

   #無資料處理
   IF l_cnt1 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      DISPLAY '' ,0 TO stagenow,stagecomplete   #失敗:清空進度條
      CALL cl_err_collect_show() 
      CALL s_transaction_end('N','0')
      RETURN
   END IF

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
   CALL aglp850_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aglp850.get_buffer" >}
PRIVATE FUNCTION aglp850_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glemld = p_dialog.getFieldBuffer('glemld')
   LET g_master.glem001 = p_dialog.getFieldBuffer('glem001')
   LET g_master.glem002 = p_dialog.getFieldBuffer('glem002')
   LET g_master.glem003 = p_dialog.getFieldBuffer('glem003')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglp850.msgcentre_notify" >}
PRIVATE FUNCTION aglp850_msgcentre_notify()
 
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
 
{<section id="aglp850.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aglp850_qbe_clear()
# Date & Author..: 160511 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp850_qbe_clear()
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
   SELECT glaa003,glaa135,glaa004 INTO g_glaa003,g_glaa135,g_glaa004
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_glaald
   
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
             
   LET g_master.glem002 = l_glav002   #會計年度
   LET g_master.glem003 = 0           #會計期別
   DISPLAY BY NAME g_master.glem002,g_master.glem003
END FUNCTION

################################################################################
# Descriptions...: 臨時表
# Memo...........:
# Usage..........: CALL aglp850_create_tmp()
# Date & Author..: 160513 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp850_create_tmp()
   
   DROP TABLE aglp850_tmp;
   CREATE TEMP TABLE aglp850_tmp(
      glement     LIKE glem_t.glement,    #企業編號
      glemld	   LIKE glem_t.glemld,     #合併帳套
      glem001	   LIKE glem_t.glem001,	   #上層公司
      glem002	   LIKE glem_t.glem002,	   #年度
      glem003	   LIKE glem_t.glem003,	   #期別
      glem004	   LIKE glem_t.glem004,	   #群組編號
      glem005	   LIKE glem_t.glem005,	   #科目編號
      glem006	   LIKE glem_t.glem006,	   #幣別(記帳幣)
      glem007	   LIKE glem_t.glem007,	   #期初借方金額(記帳幣)
      glem008	   LIKE glem_t.glem008,	   #期初貸方金額(記帳幣)
      glem009	   LIKE glem_t.glem009,	   #幣別(功能幣)
      glem010	   LIKE glem_t.glem010,	   #期初借方金額(功能幣)
      glem011	   LIKE glem_t.glem011,	   #期初貸方金額(功能幣)
      glem012	   LIKE glem_t.glem012,	   #幣別(報告幣)
      glem013	   LIKE glem_t.glem013,	   #期初借方金額(報告幣)
      glem014	   LIKE glem_t.glem014     #期初貸方金額(報告幣)
                  )
END FUNCTION

################################################################################
# Descriptions...: 來源glem_t,寫入臨時表
# Memo...........:
# Usage..........: CALL aglp850_insert_tmp()
# Date & Author..: 160513 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglp850_insert_tmp()
DEFINE l_glac007  LIKE glac_t.glac007     #科目類別
DEFINE l_glej003  LIKE glej_t.glej003
DEFINE l_glej002  LIKE glej_t.glej002
DEFINE l_glei003  LIKE glei_t.glei003
DEFINE l_glem_cnt LIKE type_t.num10       #紀錄筆數
DEFINE l_gleb_cnt LIKE type_t.num10       #紀錄筆數
DEFINE l_tmp      RECORD
         glement  LIKE glem_t.glement,    #企業編號
         glemld	LIKE glem_t.glemld,     #合併帳套
         glem001	LIKE glem_t.glem001,	   #上層公司
         glem002	LIKE glem_t.glem002,	   #年度
         glem003	LIKE glem_t.glem003,	   #期別
         glem004	LIKE glem_t.glem004,	   #群組編號
         glem005	LIKE glem_t.glem005,	   #科目編號
         glem006	LIKE glem_t.glem006,	   #幣別(記帳幣)
         glem007	LIKE glem_t.glem007,	   #期初借方金額(記帳幣)
         glem008	LIKE glem_t.glem008,	   #期初貸方金額(記帳幣)
         glem009	LIKE glem_t.glem009,	   #幣別(功能幣)
         glem010	LIKE glem_t.glem010,	   #期初借方金額(功能幣)
         glem011	LIKE glem_t.glem011,	   #期初貸方金額(功能幣)
         glem012	LIKE glem_t.glem012,	   #幣別(報告幣)
         glem013	LIKE glem_t.glem013,	   #期初借方金額(報告幣)
         glem014	LIKE glem_t.glem014 	   #期初貸方金額(報告幣)
                  END RECORD
                  
   DELETE FROM aglp850_tmp

   #agli561_glem_t資料
   LET g_sql = " SELECT glement,glemld,glem001,glem002,glem003,glem004,glem005,glem006,",
               #判斷科目類別，如果是損益類，則金額給0
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = glem005) = '6' ",
               "             THEN 0 ELSE glem007 END, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = glem005) = '6' ",
               "             THEN 0 ELSE glem008 END, ",
               "        glem009, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = glem005) = '6' ",
               "             THEN 0 ELSE glem010 END, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = glem005) = '6' ",
               "             THEN 0 ELSE glem011 END, ",
               "        glem012,",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = glem005) = '6' ",
               "             THEN 0 ELSE glem013 END, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = glem005) = '6' ",
               "             THEN 0 ELSE glem014 END ",
               "   FROM glem_t ", 
               "  WHERE glement = ",g_enterprise," ",
               "    AND glemld = '",g_master.glemld,"' ",
               "    AND glem001 = '",g_master.glem001,"' ",
               "    AND glem002 = '",g_master.glem002-1,"' ",
               "    AND glem003 = '",g_max_period,"' ",
               "    AND glem004 = ? ",
               "    AND glem005 = ? ", 
               "  ORDER BY glement,glemld,glem001,glem002,glem003,glem004,glem005 "
   DECLARE aglp850_glem_ins_tmp_c CURSOR FROM g_sql
   
   #餘額檔_取得去年最末期資料
   LET g_sql = " SELECT glebent,glebld,gleb001,gleb003,gleb004, ",
               "        (SELECT DISTINCT glej002 FROM glej_t WHERE glejent = glebent ",
               "            AND glejld = glebld AND glej001 = gleb001 ",
               "            AND glej002 IN (SELECT glei002 FROM glei_t ",
               "                             WHERE gleient = glebent AND glei001 = '",g_glaa135,"' AND glei003 IN ('1','2','3','5')) ",
               "            AND glej003 = gleb005 AND rownum = 1), ",
               "        gleb005,gleb007,",
               #判斷科目類別，如果是損益類，則金額給0
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = gleb005) = '6' ",
               "             THEN 0 ELSE gleb008 END, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = gleb005) = '6' ",
               "             THEN 0 ELSE gleb009 END, ",
               "        gleb026, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = gleb005) = '6' ",
               "             THEN 0 ELSE gleb027 END, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = gleb005) = '6' ",
               "             THEN 0 ELSE gleb028 END, ",
               "        gleb029,",  
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = gleb005) = '6' ",
               "             THEN 0 ELSE gleb030 END, ",
               "        CASE WHEN (SELECT glac007 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = gleb005) = '6' ",
               "             THEN 0 ELSE gleb031 END ", 
               "   FROM gleb_t ", 
               "  WHERE glebent = ",g_enterprise," ",
               "    AND glebld = '",g_master.glemld,"' ",
               "    AND gleb001 = '",g_master.glem001,"' ",
               "    AND gleb003 = '",g_master.glem002-1,"' ",
               "    AND gleb004 = '",g_max_period,"' ",
               "    AND gleb005 = ? ", 
               "  ORDER BY glebent,glebld,gleb001,gleb003,gleb004,gleb005 "
   DECLARE aglp850_gleb_ins_tmp_c CURSOR FROM g_sql

   #glem_t筆數
   LET g_sql = " SELECT COUNT(*) FROM glem_t ", 
               "  WHERE glement = ",g_enterprise," ",
               "    AND glemld = '",g_master.glemld,"' ",
               "    AND glem001 = '",g_master.glem001,"' ",
               "    AND glem002 = '",g_master.glem002-1,"' ",
               "    AND glem003 = '",g_max_period,"' ",
               "    AND glem004 = ? ",
               "    AND glem005 = ? ", 
               "  ORDER BY glement,glemld,glem001,glem002,glem003,glem004,glem005 "
   DECLARE aglp850_glem_cnt_c CURSOR FROM g_sql

   #gleb_t筆數
   LET g_sql = " SELECT COUNT(*) FROM gleb_t ", 
               "  WHERE glebent = ",g_enterprise," ",
               "    AND glebld = '",g_master.glemld,"' ",
               "    AND gleb001 = '",g_master.glem001,"' ",
               "    AND gleb003 = '",g_master.glem002-1,"' ",
               "    AND gleb004 = '",g_max_period,"' ",
               "    AND gleb005 = ? ", 
               "  ORDER BY glebent,glebld,gleb001,gleb003,gleb004,gleb005 "
   DECLARE aglp850_gleb_cnt_c CURSOR FROM g_sql

   #agli561中設定且變動分類屬2/3/4/5/7的類型的科目/群組/變動分類--------------------------
   LET l_glej003 = ''
   LET l_glej002 = ''   
   LET l_glei003 = ''   
   LET g_sql = " SELECT glej003,glej002, ",
               "        (SELECT glei003 FROM glei_t ",
               "                     WHERE gleient = glejent AND glei001 = '",g_glaa135,"' ",
               "                       AND glei002 = glej002 )",
               "   FROM glej_t ", 
               "  WHERE glejent = ",g_enterprise," AND glejld = '",g_master.glemld,"' ",
               "    AND glej001 = '",g_master.glem001,"' ",
               "    AND glej002 IN (SELECT glei002 FROM glei_t ",
               "                     WHERE gleient = glejent AND glei001 = '",g_glaa135,"' ",
               "                       AND glei003 IN ('2','3','4','5','7')) "
   
   DECLARE aglp850_glej003_c CURSOR FROM g_sql
   FOREACH aglp850_glej003_c INTO l_glej003,l_glej002,l_glei003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aglp850_glej003_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF     
      
      INITIALIZE l_tmp.* TO NULL
      #類別為期末時，直接用餘額檔寫入
      IF l_glei003 = '7' THEN
         FOREACH aglp850_gleb_ins_tmp_c USING l_glej003 INTO l_tmp.* 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "FOREACH:aglp850_gleb_ins_tmp_c"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF
                   
            
            #損益類科目，金額給0
            IF (l_glej003 = g_glab005is) OR (l_glej003 = g_glab005bs) THEN
               LET l_tmp.glem007 = 0
               LET l_tmp.glem008 = 0
               LET l_tmp.glem010 = 0
               LET l_tmp.glem011 = 0
               LET l_tmp.glem013 = 0
               LET l_tmp.glem014 = 0
            END IF
            
            INSERT INTO aglp850_tmp VALUES(l_tmp.*)  
         END FOREACH   
      ELSE
         LET l_glem_cnt = 0
         LET l_gleb_cnt = 0
         EXECUTE aglp850_glem_cnt_c USING l_glej002,l_glej003 INTO l_glem_cnt
         EXECUTE aglp850_gleb_cnt_c USING l_glej003 INTO l_gleb_cnt
         
         IF l_glem_cnt + l_gleb_cnt = 0 THEN
            CONTINUE FOREACH
         END IF
         IF l_glem_cnt > 0 THEN
            #取開帳資料
            FOREACH aglp850_glem_ins_tmp_c USING l_glej002,l_glej003 INTO l_tmp.* 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "FOREACH:aglp850_glem_ins_tmp_c"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  EXIT FOREACH
               END IF
               
               #損益類科目，金額給0
               IF (l_glej003 = g_glab005is) OR (l_glej003 = g_glab005bs) THEN
                  LET l_tmp.glem007 = 0
                  LET l_tmp.glem008 = 0
                  LET l_tmp.glem010 = 0
                  LET l_tmp.glem011 = 0
                  LET l_tmp.glem013 = 0
                  LET l_tmp.glem014 = 0
               END IF
               
               INSERT INTO aglp850_tmp VALUES(l_tmp.*)  
            END FOREACH   
         ELSE
            #取餘額檔資料
            FOREACH aglp850_gleb_ins_tmp_c USING l_glej003 INTO l_tmp.* 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "FOREACH:aglp850_gleb_ins_tmp_c"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  EXIT FOREACH
               END IF
               
               #損益類科目，金額給0
               IF (l_glej003 = g_glab005is) OR (l_glej003 = g_glab005bs) THEN
                  LET l_tmp.glem007 = 0
                  LET l_tmp.glem008 = 0
                  LET l_tmp.glem010 = 0
                  LET l_tmp.glem011 = 0
                  LET l_tmp.glem013 = 0
                  LET l_tmp.glem014 = 0
               END IF
               
               INSERT INTO aglp850_tmp VALUES(l_tmp.*)  
            END FOREACH  
         END IF
      END IF 
   END FOREACH   

END FUNCTION

#end add-point
 
{</section>}
 
