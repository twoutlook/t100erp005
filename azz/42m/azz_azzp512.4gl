#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp512.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-09-07 16:28:56), PR版次:0003(2016-03-31 19:45:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: azzp512
#+ Description: 相關文件存放路徑互換設定
#+ Creator....: 00845(2015-08-24 17:16:32)
#+ Modifier...: 00824 -SD/PR- 07025
 
{</section>}
 
{<section id="azzp512.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Modify.........: No.160330-00012#1 16/03/31 By catmoon 將CALL cl_progress_no_window_ing(參數)參數有中文的情形改由變數帶入
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
   ooaa002               LIKE ooaa_t.ooaa002,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       ooaa002 LIKE ooaa_t.ooaa002, 
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
 
{<section id="azzp512.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL azzp512_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp512 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp512_init()
 
      #進入選單 Menu (="N")
      CALL azzp512_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_azzp512
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp512.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp512_init()
 
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
   CALL cl_set_combo_scc("ooaa002","76")
   LET g_master.ooaa002 = cl_get_para(g_enterprise,"","E-SYS-0006")
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzp512.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp512_ui_dialog()
 
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
         
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT lc_param.ooaa002 FROM ooaa002
            ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL azzp512_get_buffer(l_dialog)
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
         CALL azzp512_init()
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
                 CALL azzp512_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp512_transfer_argv(ls_js)
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
 
{<section id="azzp512.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp512_transfer_argv(ls_js)
 
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
 
{<section id="azzp512.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp512_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE li_cnt        LIKE type_t.num10
   DEFINE li_loaa008    LIKE loaa_t.loaa008
   DEFINE ls_loaa       RECORD
                        loaa001     LIKE loaa_t.loaa001,
                        loaa006     LIKE loaa_t.loaa006,
                        loaa007     LIKE loaa_t.loaa007,
                        loaa009     LIKE loaa_t.loaa009,
                        loaa010     LIKE loaa_t.loaa010
                        END RECORD
   DEFINE ls_source     STRING
   DEFINE ls_target     STRING
   DEFINE ls_source_bak STRING
   DEFINE lb_loab008    BYTE
   DEFINE ls_error      LIKE type_t.chr1
   DEFINE ls_cnt        LIKE type_t.num5
   DEFINE ls_json       RECORD
                        column    STRING,
                        values    STRING
                        END RECORD
   DEFINE ls_str        STRING
   DEFINE ls_b          SMALLINT
   DEFINE ls_i          SMALLINT
   DEFINE ls_info       STRING #160330-00012#1 add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET li_loaa008 = cl_get_para(g_enterprise,g_site,"E-SYS-0006")   #取得目前的儲存類型
   IF lc_param.ooaa002 = li_loaa008 THEN   #同一型態的話不須再做轉換
      IF g_bgjob = "N" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00361"
         LET g_errparam.extend = "azz-00361"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF

      RETURN
   END IF
   
   LET ls_sql = "SELECT COUNT(*) FROM loaa_t ",
                " WHERE loaaent = ",g_enterprise,
                  " AND loaa008 = '",li_loaa008,"'",
                  " AND loaa011 = '1'"   #只針對一般檔案處理
   PREPARE azzp512_cnt_cs FROM ls_sql
   EXECUTE azzp512_cnt_cs INTO li_cnt
   FREE azzp512_cnt_cs
   
   #顯示筆數
   IF g_bgjob <> "Y" THEN
      DISPLAY li_cnt TO FORMONLY.l_totalcnt
      CALL cl_progress_bar_no_window(li_cnt)
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp512_process_cs CURSOR FROM ls_sql
#  FOREACH azzp512_process_cs INTO
   #add-point:process段process name="process.process"
   LET ls_error = "N"
   LET ls_sql = "SELECT loaa001,loaa006,loaa007,loaa009,loaa010 FROM loaa_t ",
                " WHERE loaaent = ",g_enterprise,
                  " AND loaa008 = '",li_loaa008,"'",
                  " AND loaa011 = '1'"   #只針對一般檔案處理
   DECLARE azzp512_process_cs CURSOR FROM ls_sql
   FOREACH azzp512_process_cs INTO ls_loaa.loaa001,ls_loaa.loaa006,ls_loaa.loaa007,ls_loaa.loaa009,ls_loaa.loaa010

      #取得JSON中的欄位值
      LET ls_str = ls_loaa.loaa001
      LET ls_str = ls_str.subString(2,ls_str.getLength()-1)   #去掉前後的[]
      
      #因為loaa001中有可能紀錄了不只一個欄位的資訊，目前只先截取一個欄位的資訊來顯示
      LET ls_b = 1
      FOR ls_i = ls_b TO ls_str.getLength()
         IF ls_str.subString(ls_i,ls_i) = "}" THEN
            LET ls_str = ls_str.subString(1,ls_i)
            EXIT FOR
         END IF
      END FOR
      
      CALL util.JSON.parse(ls_str,ls_json)

      IF g_bgjob <> "Y" THEN
        #CALL cl_progress_no_window_ing("讀取"||ls_json.values||"資料")        #160330-00012#1 mark
         LET ls_info = cl_getmsg_parm("azz-01003", g_lang,ls_json.values)     #160330-00012#1 add
         CALL cl_progress_no_window_ing(ls_info)                              #160330-00012#1 add
      END IF
      
      #依目前的儲存方式轉換成新的方式
      IF li_loaa008 = "1" THEN   #採用FileServer方式
         LET ls_source = os.Path.join(cl_get_para(g_enterprise,g_site,"E-SYS-0008"),ls_loaa.loaa009)
         LET ls_source_bak = os.Path.join(cl_get_para(g_enterprise,g_site,"E-SYS-0008"),ls_loaa.loaa009)

         LOCATE lb_loab008 IN FILE
         CALL lb_loab008.readFile(ls_source)

         SELECT COUNT(*) INTO ls_cnt FROM loab_t
          WHERE loabent = g_enterprise
            AND loab001 = ls_loaa.loaa001
            AND loab006 = ls_loaa.loaa006
            AND loab007 = ls_loaa.loaa007
         
         IF ls_cnt > 0 THEN
            UPDATE loab_t SET loab008 = lb_loab008
             WHERE loabent = g_enterprise
               AND loab001 = ls_loaa.loaa001
               AND loab006 = ls_loaa.loaa006
               AND loab007 = ls_loaa.loaa007
         ELSE
            INSERT INTO loab_t(loabent,loab001,loab006,loab007,loab008)
                        VALUES(g_enterprise,ls_loaa.loaa001,ls_loaa.loaa006,ls_loaa.loaa007,lb_loab008)
         END IF
         
         IF SQLCA.SQLCODE THEN
            LET ls_error = "Y"
         ELSE
            IF os.Path.rename(ls_source,ls_source_bak) THEN
            END IF
         END IF

         FREE lb_loab008
      ELSE
         LET ls_target = os.Path.join(cl_get_para(g_enterprise,g_site,"E-SYS-0008"),ls_loaa.loaa009)
         LOCATE lb_loab008 IN FILE
         SELECT loab008 INTO lb_loab008 FROM loab_t
          WHERE loabent = g_enterprise
            AND loab001 = ls_loaa.loaa001
            AND loab006 = ls_loaa.loaa006
            AND loab007 = ls_loaa.loaa007
         CALL lb_loab008.writeFile(ls_target)
         FREE lb_loab008
         
         IF os.Path.exists(ls_target) THEN   #若檔案已實際產出
            DELETE FROM loab_t
             WHERE loabent = g_enterprise
               AND loab001 = ls_loaa.loaa001
               AND loab006 = ls_loaa.loaa006
               AND loab007 = ls_loaa.loaa007

            IF SQLCA.SQLCODE THEN
               LET ls_error = "Y"
            END IF
         ELSE
            LET ls_error = "Y"
         END IF
      END IF
   END FOREACH

   #若無錯誤才更新相關附件檔案的儲存方式
   IF ls_error = "N" THEN
      UPDATE loaa_t SET loaa008 = lc_param.ooaa002
       WHERE loaaent = g_enterprise

      IF SQLCA.SQLCODE THEN
         LET ls_error = "Y"
      END IF
   END IF

   #若無錯誤才更新系統參數設定的儲存方式
   IF ls_error = "N" THEN
      UPDATE ooaa_t SET ooaa002 = lc_param.ooaa002
       WHERE ooaaent = g_enterprise
         AND ooaa001 = 'E-SYS-0006'

      IF SQLCA.SQLCODE THEN
         LET ls_error = "Y"
      END IF
   END IF
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF ls_error = "Y" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = ""
         LET g_errparam.extend = "INSERT loab:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      IF ls_error = "Y" THEN
         DISPLAY "error"
      ELSE
         DISPLAY "success"
      END IF
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp512_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp512.get_buffer" >}
PRIVATE FUNCTION azzp512_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp512.msgcentre_notify" >}
PRIVATE FUNCTION azzp512_msgcentre_notify()
 
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
 
{<section id="azzp512.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 