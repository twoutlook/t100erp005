#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-01-27 10:53:27), PR版次:0001(2016-02-22 11:38:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aisr520
#+ Description: 電子發票證明聯列印(及補印)
#+ Creator....: 05016(2016-01-18 14:49:01)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="aisr520.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
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
       isat004 LIKE isat_t.isat004, 
   type LIKE type_t.chr500, 
   chk LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_isatdocno LIKE isat_t.isatdocno
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisr520.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由03開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[03]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisr520_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisr520 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisr520_init()
 
      #進入選單 Menu (="N")
      CALL aisr520_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisr520
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisr520.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisr520_init()
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
   CALL aisr520_default()
   IF NOT cl_null(g_argv[1]) THEN
      LET g_isatdocno      = g_argv[1]
      LET g_master.isat004 = g_argv[2]
      LET g_master.type    = '1'
      LET g_master.chk     = 'Y'
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisr520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr520_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
  
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
         INPUT BY NAME g_master.isat004,g_master.type,g_master.chk 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat004
            #add-point:BEFORE FIELD isat004 name="input.b.isat004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat004
            
            #add-point:AFTER FIELD isat004 name="input.a.isat004"
            IF NOT cl_null(g_master.isat004) THEN
                CALL aisr520_isat004_chk(g_master.isat004) RETURNING g_sub_success,g_errno 
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_master.isat004 = ''
                   NEXT FIELD CURRENT
                END IF           
                CALL aisr520_isat021_chk() RETURNING g_sub_success,g_errno 
                IF NOT g_sub_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD isat004
                END IF          
             END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isat004
            #add-point:ON CHANGE isat004 name="input.g.isat004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type name="input.b.type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type name="input.a.type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type
            #add-point:ON CHANGE type name="input.g.type"
            IF NOT cl_null(g_master.isat004) THEN  
               CALL aisr520_isat021_chk() RETURNING g_sub_success,g_errno 
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD isat004
               END IF          
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.isat004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat004
            #add-point:ON ACTION controlp INFIELD isat004 name="input.c.isat004"
            #IF NOT cl_null(g_isatdocno) THEN
            #   INITIALIZE g_qryparam.* TO NULL
            #   LET g_qryparam.state ='i'
            #   LET g_qryparam.reqry = FALSE
            #   LET g_qryparam.default1 = g_master.isat004
            #   LET g_qryparam.where = " isafdocno = '",g_isatdocno,"' "
            #   CALL q_isat004()
            #   LET g_master.isat004 = g_qryparam.return1
            #   NEXT FIELD isat004
            #END IF
            #END add-point
 
 
         #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               LET g_master.wc =" 1=1"
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
            CALL aisr520_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aisr520_get_buffer(l_dialog)
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
            CALL aisr520_default()
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
         CALL aisr520_init()
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
                 CALL aisr520_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisr520_transfer_argv(ls_js)
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
 
{<section id="aisr520.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisr520_transfer_argv(ls_js)
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
 
{<section id="aisr520.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisr520_process(ls_js)
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
   DEFINE l_sql        STRING
   DEFINE l_isat002    LIKE isat_t.isat002
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
#  IF cl_null(g_master.wc) THEN  ## 若是t類進來 會是傳字串參數的方式
#      CALL l_arg.clear()
#      LET l_token = base.StringTokenizer.create(ls_js,",")
#      LET l_cnt = 1
#      WHILE l_token.hasMoreTokens()
#            LET ls_next = l_token.nextToken()
#            LET l_arg[l_cnt] = ls_next
#            LET l_cnt = l_cnt + 1
#      END WHILE
#      CALL l_arg.deleteElement(l_cnt)
#      LET g_master.wc = l_arg[01]
#      LET g_master.chk = l_arg[02]   
#      LET g_master.type = l_arg[03]    
#      LET l_sql = " SELECT isat004,isat002 FROM isat_t WHERE isatent = '",g_enterprise,"' AND ",g_master.wc
#      PREPARE aisr520_isat004_prep01 FROM l_sql
#      EXECUTE aisr520_isat004_prep01 INTO g_master.isat004,l_isat002
#      IF l_isat002 <> 'Y' THEN 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'ais-00280'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         RETURN  
#      END IF         
#   ELSE
#   END IF   
   #印出前檢核
   IF NOT cl_null(g_isatdocno) THEN
      #T類呼叫針對發票號碼在檢核一次
      CALL aisr520_isat004_chk(g_master.isat004) RETURNING g_sub_success,g_errno 
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_master.isat004 = ''
         RETURN
      END IF           
   END IF
   CALL aisr520_isat021_chk2() RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #若為中奬發票列印(參數2='2'), 列印前, 彈出警語提醒 "補印不用收回原發票". 列印完成後不用將 isat021(列印次數)累加 1
   IF g_master.type = 2 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ais-00279'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()                
   END IF   
   #更新發票列印狀態      
   CALL aisr520_update()
   DISPLAY 'g_master.wc',l_arg[01]            
   DISPLAY 'g_master.chk',l_arg[02]
   DISPLAY 'g_master.type',l_arg[03]
   DISPLAY 'g_master.isat004:',g_master.isat004
   CALL aisr520_g01(' 1 =1' ,g_master.isat004,g_master.chk,g_master.type)   
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisr520_process_cs CURSOR FROM ls_sql
#  FOREACH aisr520_process_cs INTO
   #add-point:process段process name="process.process"
   
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
 
{<section id="aisr520.get_buffer" >}
PRIVATE FUNCTION aisr520_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.isat004 = p_dialog.getFieldBuffer('isat004')
   LET g_master.type = p_dialog.getFieldBuffer('type')
   LET g_master.chk = p_dialog.getFieldBuffer('chk')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr520.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL aisr520_default()
# Date & Author..: 2016/01/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_default()
   
   LET g_master.isat004 = ''
   LET g_master.type = 1
   LET g_master.chk = 'N'
   
   DISPLAY BY NAME g_master.isat004,g_master.type,g_master.chk

END FUNCTION

################################################################################
# Descriptions...: 發票號碼檢核
# Memo...........:
# Usage..........: CALL aisr520_isat004_chk(p_isat004)
# Date & Author..: 2016/01/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_isat004_chk(p_isat004)
DEFINE p_isat004    LIKE isat_t.isat004
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001
DEFINE l_isat002    LIKE isat_t.isat002
DEFINE l_isat206    LIKE isat_t.isat206
DEFINE l_isat204    LIKE isat_t.isat204
DEFINE l_isat115    LIKE isat_t.isat115
DEFINE l_isat026    LIKE isat_t.isat026
DEFINE l_isat014    LIKE isat_t.isat014
DEFINE l_isat025    LIKE isat_t.isat025
DEFINE l_isat006    LIKE isat_t.isat026
                    
   LET r_success = TRUE
   
   SELECT DISTINCT isat002,isat014,isat025,isat206,isat204,isat115,isat026,isat006
     INTO l_isat002,l_isat014,l_isat025,l_isat206,l_isat204,l_isat115,l_isat026,l_isat006
     FROM isat_t
    WHERE isatent = g_enterprise
      AND isat004 = p_isat004
      AND isat002 = 'Y'
      AND isat014 = '11'

   IF cl_null(l_isat115) THEN LET l_isat115 = 0 END IF

   CASE
      WHEN SQLCA.SQLCODE          LET r_success = FALSE LET r_errno = 'ais-00267'
      #WHEN l_isat002 <> 'Y'       LET r_success = FALSE LET r_errno = 'ais-00271'  #電子發票
      #WHEN l_isat014 <> '11'      LET r_success = FALSE LET r_errno = 'ais-00274'  #是否開立
      WHEN cl_null(l_isat026)     LET r_success = FALSE LET r_errno = 'ais-00275'  #列印電子發票證明聯條件不符，不可列印!!!
      WHEN l_isat025 = '12'       LET r_success = FALSE LET r_errno = 'ais-00272'  #此發票已作廢，不可列印
      WHEN l_isat025 = '23'       LET r_success = FALSE LET r_errno = 'ais-00273'  #此發票已註銷，不可列印
      WHEN NOT cl_null(l_isat206) LET r_success = FALSE LET r_errno = 'ais-00268'  #載具顯碼 ID
      WHEN NOT cl_null(l_isat204) LET r_success = FALSE LET r_errno = 'ais-00269'  #愛心碼
      WHEN l_isat115 = 0          LET r_success = FALSE LET r_errno = 'ais-00270'  #金額0
      WHEN cl_null(l_isat006)     LET r_success = FALSE LET r_errno = 'ais-00286'  #發票隨機碼
   END CASE
   
   RETURN r_success,r_errno
   



END FUNCTION

################################################################################
# Descriptions...: 列印次數
# Memo...........:
# Usage..........: CALL aisr520_isat021_chk()
# Date & Author..: 2016/01/19 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_isat021_chk()
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001
DEFINE l_isat021    LIKE isat_t.isat021
   
   LET r_success = TRUE

   SELECT isat021 INTO l_isat021
     FROM isat_t WHERE isatent = g_enterprise              
      AND isat115 > 0 AND isat004 = g_master.isat004
      AND isat206 IS NULL AND isat204 IS NULL
      AND isat002 = 'Y'
   
   IF g_master.type MATCHES '[01]'  THEN 
      IF l_isat021 <> 0 THEN　#一般列印列印次數必須=0
         LET g_master.type = 2
         LET r_success = FALSE
         LET r_errno = 'ais-00276'
      END IF
   ELSE
      IF l_isat021 = 0 THEN  #補印次數大於０才可列印
         LET g_master.type = 1 
         LET r_success = FALSE
         LET r_errno = 'ais-00277'
      END IF
   END IF
   
   RETURN r_success,r_errno
    

END FUNCTION

################################################################################
# Descriptions...: 更新列印次數
# Memo...........:
# Usage..........: CALL aisr520_update()
# Date & Author..: 2016/01/21 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_update()

   CASE g_master.type 
      WHEN 1 #若為發票列印(參數2='1'), 列印完成後將 isat021(列印次數) 累加 1     
         UPDATE isat_t 
           SET isat021 = isat021 + 1
         WHERE isatent = g_enterprise AND isat004 = g_master.isat004
     WHEN 2 #  若為中奬發票列印(參數2='2'), 列印前, 彈出警語提醒 "補印不用收回原發票". 列印完成後不用將 isat021(列印次數)累加 1

     WHEN 3 # 若為中奬發票列印(參數2='3'), 請將 isat021(列印次數) 設定為 1 及更新電子發票中獎清冊的發票列印碼為 Y, 再開始列印.
       UPDATE isat_t 
          SET isat021 = 1
        WHERE isatent = g_enterprise AND isat004 = g_master.isat004     
   END CASE   
           
END FUNCTION

################################################################################
# Descriptions...: 呼叫檢核
# Memo...........:
# Usage..........: CALL aisr520_isat021_chk()2
# Date & Author..: 2016/01/21 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr520_isat021_chk2()
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001
DEFINE l_isat021    LIKE isat_t.isat021 #列印次數
DEFINE l_isat026    LIKE isat_t.isat026 #發票使用類型
DEFINE l_isat204    LIKE isat_t.isat204
DEFINE l_isat206    LIKE isat_t.isat206
   
   LET r_success = TRUE

   SELECT isat021,isat026,isat204,isat206 INTO l_isat021,l_isat026,l_isat204,l_isat206
     FROM isat_t WHERE isatent = g_enterprise              
      AND isat115 > 0 AND isat004 = g_master.isat004
      AND isat002 = 'Y'
   
   CASE g_master.type
      WHEN 1 #1 : 表示要列印出電子發票證明聯 isat021(列印次數) 為 0  才可列印
         IF l_isat021 <> 0 AND (NOT cl_null(l_isat204) OR NOT cl_null(l_isat206) )THEN 
            LET r_success = FALSE LET r_errno = 'ais-00275' 
         END IF
         IF NOT cl_null(g_argv[1]) THEN 
            IF l_isat026 = '6' THEN
               IF l_isat021 <> 1 THEN
                  LET r_success = FALSE LET r_errno = 'ais-00275'
               END IF
            END IF                          
         END IF         
      WHEN 2 #2 : 表示要列印出電子發票證明聯(補印).isat021(列印次數) 為 > 0 才可列印
         IF l_isat021 <= 0 AND (NOT cl_null(l_isat204) OR NOT cl_null(l_isat206) ) THEN  
            LET r_success = FALSE LET r_errno = 'ais-00275' 
         END IF
      WHEN 3 # 3 : 表示要列印出中奬的電子發票證明聯 isat021(列印次數)為 0 且 isat206(載具顯碼)不為 null 而 isat204(愛心碼) 須為 null
         IF l_isat026 <> 6 THEN
            LET r_success = FALSE LET r_errno = 'ais-00275'           
         END IF         
         IF l_isat021 <> 0 THEN 
            LET r_success = FALSE LET r_errno = 'ais-00275'           
         END IF
         IF NOT cl_null(l_isat204) THEN 
            LET r_success = FALSE LET r_errno = 'ais-00275' 
         END IF
         IF cl_null(l_isat206) THEN 
            LET r_success = FALSE LET r_errno = 'ais-00275' 
         END IF
   END CASE 
   
   RETURN r_success,r_errno
    

END FUNCTION

#end add-point
 
{</section>}
 
