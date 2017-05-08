#該程式未解開Section, 採用最新樣板產出!
{<section id="ammp200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-10-28 10:55:08), PR版次:0002(2016-10-28 10:58:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: ammp200
#+ Description: 會員晉級資料產生批次作業
#+ Creator....: 02749(2016-09-21 13:38:14)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="ammp200.global" >}
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
       l_date LIKE type_t.chr500, 
       l_del  LIKE type_t.chr500, 
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       l_date LIKE type_t.chr500, 
   l_del LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_err_exit       LIKE type_t.num5   #處理過程有錯誤時為TRUE,表示應程式中止
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ammp200.main" >}
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
   LET g_err_exit = FALSE
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
      CALL ammp200_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammp200 WITH FORM cl_ap_formpath("amm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ammp200_init()
 
      #進入選單 Menu (="N")
      CALL ammp200_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ammp200
   END IF
 
   #add-point:作業離開前 name="main.exit"
   IF g_err_exit THEN
      CALL cl_ap_exitprogram("1")
   END IF
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ammp200.init" >}
#+ 初始化作業
PRIVATE FUNCTION ammp200_init()
 
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
 
{<section id="ammp200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ammp200_ui_dialog()
 
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
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_date,g_master.l_del 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_date
            #add-point:BEFORE FIELD l_date name="input.b.l_date"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_date
            
            #add-point:AFTER FIELD l_date name="input.a.l_date"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_date
            #add-point:ON CHANGE l_date name="input.g.l_date"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_del
            #add-point:BEFORE FIELD l_del name="input.b.l_del"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_del
            
            #add-point:AFTER FIELD l_del name="input.a.l_del"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_del
            #add-point:ON CHANGE l_del name="input.g.l_del"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_date
            #add-point:ON ACTION controlp INFIELD l_date name="input.c.l_date"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_del
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_del
            #add-point:ON ACTION controlp INFIELD l_del name="input.c.l_del"
            
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
            CALL ammp200_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.l_date = g_today - 1
            DISPLAY g_master.l_date TO l_date
            
            LET g_master.l_del = 'N'
            DISPLAY g_master.l_del TO l_del
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
         CALL ammp200_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.l_date = g_master.l_date
      LET lc_param.l_del = g_master.l_del
      LET lc_param.wc = g_master.wc
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
                 CALL ammp200_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ammp200_transfer_argv(ls_js)
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
 
{<section id="ammp200.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ammp200_transfer_argv(ls_js)
 
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
 
{<section id="ammp200.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ammp200_process(ls_js)
 
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
   DEFINE l_session_id  LIKE type_t.num20 
   DEFINE l_msg         STRING    
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
      LET li_count = 4
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ammp200_process_cs CURSOR FROM ls_sql
#  FOREACH ammp200_process_cs INTO
   #add-point:process段process name="process.process"
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "SessionId: ",l_session_id  
   
   DROP TABLE ammp200_tmp_01;
   
   CREATE TEMP TABLE ammp200_tmp_01(
      exist_type      VARCHAR(10),
      imaa001         VARCHAR(40));
      
   CALL s_transaction_begin()
   #1.資料刪除重新產生=Y：統計日期中已有累計至會員卡資料,批次中止並提示錯誤
   #                             皆未累計至會員卡資料,將資料刪除並重新產生
   IF g_bgjob <> "Y" THEN
     LET l_msg = cl_getmsg('amm-00785',g_lang)
     CALL cl_progress_no_window_ing(l_msg)
   END IF   
   IF lc_param.l_del = 'Y' THEN   
      LET g_sql = "SELECT COUNT(*) FROM mmdo_t ",
                  " WHERE mmdoent = ",g_enterprise," AND mmdo003 = ? AND mmdo013 = 'Y' "
      PREPARE ammp200_cnt_mmdo FROM g_sql   
      
      LET l_cnt = 0 
      EXECUTE ammp200_cnt_mmdo USING lc_param.l_date
                               INTO l_cnt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "EXECUTE ammp200_cnt_mmdo"    
         CALL cl_err()
         
         LET g_err_exit = TRUE 
      END IF

      IF l_cnt > 0 THEN
         #已有資料累計至會員卡資料檔,不允許刪除會員晉級資料重新產生
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "amm-00783"
         LET g_errparam.extend = lc_param.l_date  
         CALL cl_err() 
         
         LET g_err_exit = TRUE  
      ELSE
         DELETE FROM mmdo_t WHERE mmdoent = g_enterprise AND mmdo003 = lc_param.l_date
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "DELETE FROM mmdo_t"    
            CALL cl_err() 
            
            LET g_err_exit = TRUE 
         END IF         
      END IF   
   END IF
   
   #2.將ammi200設定的會員晉級商品範圍的部份產生納入晉級的商品清單整理至temp talbe
   IF g_err_exit THEN
      IF g_bgjob <> "Y" THEN        
        LET l_msg = cl_getmsg('std-00024',g_lang)
        CALL cl_progress_no_window_ing(l_msg)
      END IF 
   ELSE   
      IF g_bgjob <> "Y" THEN
        LET l_msg = cl_getmsg('amm-00786',g_lang)
        CALL cl_progress_no_window_ing(l_msg)
      END IF    
      LET g_sql = "INSERT INTO ammp200_tmp_01(exist_type,imaa001) ",
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #商品編號
                  "WHERE mmdnent = imaaent AND mmdn002 = '4' AND mmdn003 = imaa001         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #商品品類 
                  "WHERE mmdnent = imaaent AND mmdn002 = '5' AND mmdn003 = imaa009         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #產地分類
                  "WHERE mmdnent = imaaent AND mmdn002 = '6' AND mmdn003 = imaa122         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #價格帶
                  "WHERE mmdnent = imaaent AND mmdn002 = '7' AND mmdn003 = imaa131         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #品牌 
                  "WHERE mmdnent = imaaent AND mmdn002 = '8' AND mmdn003 = imaa126         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #系列
                  "WHERE mmdnent = imaaent AND mmdn002 = '9' AND mmdn003 = imaa127         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #型別
                  "WHERE mmdnent = imaaent AND mmdn002 = 'A' AND mmdn003 = imaa128         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #功能
                  "WHERE mmdnent = imaaent AND mmdn002 = 'B' AND mmdn003 = imaa129         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性一
                  "WHERE mmdnent = imaaent AND mmdn002 = 'C' AND mmdn003 = imaa132         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性二
                  "WHERE mmdnent = imaaent AND mmdn002 = 'D' AND mmdn003 = imaa133         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性三
                  "WHERE mmdnent = imaaent AND mmdn002 = 'E' AND mmdn003 = imaa134         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性四
                  "WHERE mmdnent = imaaent AND mmdn002 = 'F' AND mmdn003 = imaa135         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性五
                  "WHERE mmdnent = imaaent AND mmdn002 = 'G' AND mmdn003 = imaa136         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性六
                  "WHERE mmdnent = imaaent AND mmdn002 = 'H' AND mmdn003 = imaa137         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性七
                  "WHERE mmdnent = imaaent AND mmdn002 = 'I' AND mmdn003 = imaa138         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性八
                  "WHERE mmdnent = imaaent AND mmdn002 = 'J' AND mmdn003 = imaa139         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性九
                  "WHERE mmdnent = imaaent AND mmdn002 = 'K' AND mmdn003 = imaa140         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  ",   
                  "UNION ALL                                                               ",   
                  "SELECT mmdn001,imaa001 FROM mmdn_t,imaa_t                               ",   #其他屬性十 
                  "WHERE mmdnent = imaaent AND mmdn002 = 'L' AND mmdn003 = imaa141         ",   
                  "  AND mmdnent = ",g_enterprise," AND mmdnstus = 'Y' AND imaastus = 'Y'  "    
      PREPARE ammp200_ins_tmp FROM g_sql
      EXECUTE ammp200_ins_tmp   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT ammp200_tmp_01"    
         CALL cl_err() 
            
         LET g_err_exit = TRUE 
      END IF
      
       LET l_cnt = 0 
       SELECT COUNT(*) INTO l_cnt FROM ammp200_tmp_01 WHERE exist_type = '1'      
   END IF
   
   #3.取銷售整合檔的商品銷售數據,僅擷取rtja000 IN ('artt600','artt610','artt700') 
   #  寫入mmdo_t 比對是否已存在資料,如果已存在則略過
   IF g_err_exit THEN
      IF g_bgjob <> "Y" THEN        
        LET l_msg = cl_getmsg('std-00024',g_lang)
        CALL cl_progress_no_window_ing(l_msg)
      END IF 
   ELSE   
       IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('amm-00787',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
       END IF
       
       LET g_sql = "INSERT INTO mmdo_t(mmdoent,                                 ",
                   "                   mmdo001,mmdo002,mmdo003,mmdo004,mmdo005, ",
                   "                   mmdo006,mmdo007,mmdo008,mmdo009,mmdo010, ",
                   "                   mmdo011,mmdo012,mmdo013)                 ",
                   "SELECT rtjaent,                                             ",
                  #"       rtjadocno,rtjbseq,rtjadocdt,rtjasite,rrtja002,       ",   #160819-00054#10 161028 by lori mark
                   "       rtjadocno,rtjbseq,rtjadocdt,rtjasite,                ",
                   #160819-00054#10 161028 by lori add---(S)
                   "      (CASE WHEN rtja001 IS NULL THEN rtja002               ",
                   "            ELSE (SELECT mmaq003 FROM mmaq_t                ",
                   "                   WHERE mmaqent = rtjaent                  ",
                   "                    AND mmaq001 = rtja001)                  ",
                   "        END),                                               ",
                   #160819-00054#10 161028 by lori add---(E)
                   "       rtja001  ,rtjb004,rtjb021  ,rtjb029,rtja000,         ",
                   "       rtjb001  ,rtjb002,'N'                                ",
                   "  FROM rtjb_t,rtja_t                                        ",
                   " WHERE rtjbent = rtjaent AND rtjbdocno = rtjadocno          ",
                   "   AND rtjaent = ",g_enterprise, 
                   "   AND rtjadocdt = '",lc_param.l_date,"' ",
                   "   AND rtja000 IN ('artt600','artt610','artt700') ",
                   "   AND rtja001 IS NOT NULL                        "
       IF l_cnt > 0 THEN
          LET g_sql = g_sql,       
                   "   AND EXISTS(SELECT 1 FROM ammp200_tmp_01 WHERE exist_type = '1' AND imaa001 = rtjb004) "
       END IF
       
       LET g_sql = g_sql,              
                   "   AND NOT EXISTS(SELECT 1 FROM ammp200_tmp_01 WHERE exist_type = '-1' AND imaa001 = rtjb004) ",
                   "   AND NOT EXISTS(SELECT 1 FROM mmdo_t WHERE mmdoent = rtjbent AND mmdo001 = rtjbdocno AND mmdo002 = rtjbseq) "
       PREPARE ammp200_ins_mmdo FROM g_sql
       EXECUTE ammp200_ins_mmdo   
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "INSERT mmdo_t"    
          CALL cl_err() 
       
          IF g_bgjob <> "Y" THEN        
            LET l_msg = cl_getmsg('std-00024',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
          END IF 
         
          LET g_err_exit = TRUE 
       END IF
   END IF
   
   #4.存檔
   IF g_err_exit THEN
      IF g_bgjob <> "Y" THEN        
        LET l_msg = cl_getmsg('std-00024',g_lang)
        CALL cl_progress_no_window_ing(l_msg)
        
      END IF 
      
      CALL s_transaction_end('N',1) 
   ELSE    
       IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('std-00012',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
       END IF
       
       CALL s_transaction_end('Y',1)
   END IF
   
   DROP TABLE ammp200_tmp_01;
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
   CALL ammp200_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ammp200.get_buffer" >}
PRIVATE FUNCTION ammp200_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_date = p_dialog.getFieldBuffer('l_date')
   LET g_master.l_del = p_dialog.getFieldBuffer('l_del')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammp200.msgcentre_notify" >}
PRIVATE FUNCTION ammp200_msgcentre_notify()
 
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
 
{<section id="ammp200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
