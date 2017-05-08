#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp171.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(1900-01-01 00:00:00), PR版次:0001(2015-11-12 14:23:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: azzp171
#+ Description: 將lib程式碼分析(分析lib參數)存入db
#+ Creator....: 02667(2015-11-10 15:52:52)
#+ Modifier...: 00000 -SD/PR- 02667
 
{</section>}
 
{<section id="azzp171.global" >}
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
       stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE gr_gzwa      RECORD LIKE gzwa_t.*
DEFINE gr_gzwb      DYNAMIC ARRAY OF RECORD 
       gzwb006 LIKE gzwb_t.gzwb006,
       gzwb007 LIKE gzwb_t.gzwb007,
       gzwb008 LIKE gzwb_t.gzwb008,
       gzwb009 LIKE gzwb_t.gzwb009,
       gzwb010 LIKE gzwb_t.gzwb010
       END RECORD

DEFINE gr_gzwb_desc DYNAMIC ARRAY OF RECORD 
       gzwb009 LIKE gzwb_t.gzwb009,
       gzwb010 LIKE gzwb_t.gzwb010
       END RECORD
       
DEFINE gr_gzwb_type DYNAMIC ARRAY OF RECORD 
       gzwb008 LIKE gzwb_t.gzwb008,
       gzwb010 LIKE gzwb_t.gzwb010
       END RECORD

DEFINE gr_gzwb_type_global DYNAMIC ARRAY OF RECORD 
       gzwb008 LIKE gzwb_t.gzwb008,
       gzwb010 LIKE gzwb_t.gzwb010
       END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="azzp171.main" >}
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
   LET g_bgjob = "Y"
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL azzp171_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp171 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp171_init()
 
      #進入選單 Menu (="N")
      CALL azzp171_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_azzp171
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp171.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp171_init()
 
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
 
{<section id="azzp171.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp171_ui_dialog()
 
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
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL azzp171_get_buffer(l_dialog)
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
         CALL azzp171_init()
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
                 CALL azzp171_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp171_transfer_argv(ls_js)
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
 
{<section id="azzp171.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp171_transfer_argv(ls_js)
 
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
 
{<section id="azzp171.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp171_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_prog       STRING
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
#  DECLARE azzp171_process_cs CURSOR FROM ls_sql
#  FOREACH azzp171_process_cs INTO
   #add-point:process段process name="process.process"
   
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
      LET ls_prog = g_argv[1]
      DISPLAY 'INFO:開始解析',g_argv[1]
      CALL azzp171_4gl_analyze(ls_prog)
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp171_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp171.get_buffer" >}
PRIVATE FUNCTION azzp171_get_buffer(p_dialog)
 
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
 
{<section id="azzp171.msgcentre_notify" >}
PRIVATE FUNCTION azzp171_msgcentre_notify()
 
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
 
{<section id="azzp171.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp171_4gl_analyze(ps_prog)
   DEFINE ps_prog           STRING
   DEFINE lchannel_read     base.Channel
   DEFINE ls_readline       STRING
   DEFINE ls_text           STRING
   DEFINE ls_file_path      STRING
   DEFINE lb_chk            BOOLEAN
   
   #初始化
   INITIALIZE gr_gzwa TO NULL
   INITIALIZE gr_gzwb TO NULL
   
   #先檢查檔案是否存在
   LET lb_chk = FALSE
   CALL azzp171_chk_file(ps_prog) RETURNING lb_chk,ls_file_path
   IF NOT lb_chk THEN
      RETURN 
   END IF
   
   LET lchannel_read = base.Channel.create()
   CALL lchannel_read.openFile(ls_file_path CLIPPED, "r" )
   CALL lchannel_read.setDelimiter("")

   #讀取及轉換
   WHILE TRUE
      LET ls_readline = lchannel_read.readLine()
      LET ls_text = ls_readline.toLowercase()
      IF lchannel_read.isEof() THEN 
         EXIT WHILE 
      END IF

      #現行版本(gzwa005) 對應T100-ERP版次
      IF ls_text.getIndexOf("version",1) THEN 
         LET gr_gzwa.gzwa005 = ls_text.subString(ls_text.getIndexOf("t100-erp-",1)+9,ls_text.getIndexOf("SD版次",1)-1)
      END IF
      
      #遇到註解段
      IF ls_text.getIndexOf("############################################################",1) THEN
         CALL azzp171_get_info(ps_prog,lchannel_read) 
         RETURNING lchannel_read
      END IF 
      
   END WHILE
   CALL lchannel_read.close()
   DISPLAY "INFO:檔案分析完成!"
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp171_chk_file(ps_prog)
   DEFINE ps_prog             LIKE gzde_t.gzde001
   DEFINE ls_path             STRING 
   DEFINE ls_gzde002          LIKE gzde_t.gzde002 #模組 
   DEFINE ls_gzde008          LIKE gzde_t.gzde008 #客製否
   DEFINE ls_module           STRING

   #先確認是否為客製
   SELECT gzde002,gzde008 INTO ls_gzde002,ls_gzde008 
     FROM gzde_t 
    WHERE gzde001 = ps_prog
   IF SQLCA.sqlcode THEN
      DISPLAY '找不到',ps_prog,'相關資料!'
      RETURN FALSE, ''
   END IF
   
   #4gl程式編號(gzwa001)
   LET gr_gzwa.gzwa001 = ps_prog 
   
   #客製(gzwa003)
   LET gr_gzwa.gzwa003 = ls_gzde008
   
   #組出路徑並檢查
   LET ls_path = os.Path.join(FGL_GETENV(ls_gzde002),"4gl")
   LET ls_path = os.Path.join(ls_path,ps_prog||".4gl")
 
   DISPLAY "INFO:分析檔案:",ls_path
   IF NOT os.Path.exists(ls_path) THEN 
      RETURN FALSE, ''
   END IF  
   
   RETURN TRUE, ls_path
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp171_get_info(ps_prog,pchannel_read)
   DEFINE ps_prog           STRING 
   DEFINE pchannel_read     base.Channel
   DEFINE ls_tmp            STRING 
   DEFINE li_tmp            LIKE type_t.num5 
   DEFINE ls_readline       STRING
   DEFINE ls_text           STRING
   DEFINE li_param_idx      LIKE type_t.num5
   DEFINE li_param_idx2     LIKE type_t.num5
   DEFINE li_idx            LIKE type_t.num5
   DEFINE li_idx2           LIKE type_t.num5
   DEFINE ls_inputs         STRING
   DEFINE lb_retrun_chk     BOOLEAN
   
   LET li_param_idx  = 1
   LET li_param_idx2 = 1
   
   WHILE TRUE
      LET ls_readline = pchannel_read.readLine()
      LET ls_text = ls_readline.toLowercase()
   
      ############################單頭段############################
      #函式編號(gzwa002)
      IF ls_text.getIndexOf('public function',1)  OR
         ls_text.getIndexOf('private function',1) THEN 
         #函式編號(gzwa002)
         LET gr_gzwa.gzwa002 = ls_text.subString(ls_text.getIndexOf('function',1)+9,ls_text.getIndexOf('(',1)-1)
         DISPLAY "INFO:開始解析函式(",gr_gzwa.gzwa002,")"
         
         #內部函式區別碼(gzwa004) 1-private,0-public
         IF ls_text.getIndexOf('public function',1)  > 1 THEN
            LET gr_gzwa.gzwa004 = 0
         ELSE
            LET gr_gzwa.gzwa004 = 1
         END IF
      END IF
      
      #函式目的(gzwa006) Descriptions
      IF ls_text.getIndexOf("# descriptions...:",1) THEN 
         LET gr_gzwa.gzwa006 = ls_text.subString(ls_text.getIndexOf("descriptions...:",1)+16,ls_text.getLength())
      END IF
      
      #其他說明(gzwa007) Memo
      IF ls_text.getIndexOf("# memo...........:",1) THEN 
         LET gr_gzwa.gzwa007 = ls_text.subString(ls_text.getIndexOf("memo...........:",1)+16,ls_text.getLength())
      END IF
      
      ############################單身段############################
      #Input參數
      IF ls_text.getIndexOf("# input parameter:",1) THEN 
         WHILE TRUE

            #名稱
            LET li_tmp = ls_text.getIndexOf(":",1)+1
            LET ls_tmp = ls_text.subString(li_tmp,ls_text.getIndexOf(" ",li_tmp+3))
            LET gr_gzwb_desc[li_param_idx].gzwb010 = ls_tmp.trim()
            
            #說明
            LET li_tmp = ls_text.getIndexOf(":",1)+1
            LET li_tmp = ls_text.getIndexOf(" ",li_tmp+4)
            LET ls_tmp = ls_text.subString(li_tmp,ls_text.getLength())
            LET gr_gzwb_desc[li_param_idx].gzwb009 = ls_tmp.trim()
            
            LET li_param_idx = li_param_idx + 1  
            LET ls_readline = pchannel_read.readLine()
            LET ls_text = ls_readline.toLowercase()
              
            IF ls_text.getIndexOf("#                :",1) = 0 THEN
               EXIT WHILE
            END IF
         END WHILE               
      END IF

      #Output參數
      IF ls_text.getIndexOf("# return code....:",1) THEN 
         WHILE TRUE

            #名稱
            LET li_tmp = ls_text.getIndexOf(":",1)+1
            LET ls_tmp = ls_text.subString(li_tmp,ls_text.getIndexOf(" ",li_tmp+3))
            LET gr_gzwb_desc[li_param_idx].gzwb010 = ls_tmp.trim()
            
            #說明
            LET li_tmp = ls_text.getIndexOf(":",1)+1
            LET li_tmp = ls_text.getIndexOf(" ",li_tmp+4)
            LET ls_tmp = ls_text.subString(li_tmp,ls_text.getLength())
            LET gr_gzwb_desc[li_param_idx].gzwb009 = ls_tmp.trim()
            
            LET li_param_idx = li_param_idx + 1  
            LET ls_readline = pchannel_read.readLine()
            LET ls_text = ls_readline.toLowercase()
              
            IF ls_text.getIndexOf("#                :",1) = 0 THEN
               EXIT WHILE
            END IF
         END WHILE    
         
      END IF
      
      #global變數
      IF ls_text.getIndexOf('define',1) THEN
         CALL azzp171_gzwb_type(ls_text,'g')
      END IF
	  
      #FUNCTION段開始, 抓取傳入參數
      IF ls_text.getIndexOf('public function',1)  OR
         ls_text.getIndexOf('private function',1) THEN 
         
		 LET lb_retrun_chk = TRUE
		 
         #先取得傳入參數清單
         LET ls_inputs = ls_text.subString(ls_text.getIndexOf('(',1)+1,ls_text.getIndexOf(')',1)-1)
         CALL azzp171_gzwb_io(ls_inputs,'i')
         WHILE TRUE
            
            LET ls_readline = pchannel_read.readLine()
            LET ls_text = ls_readline.toLowercase()
            
			#LOCAL變數
            IF ls_text.getIndexOf('define',1) THEN
               CALL azzp171_gzwb_type(ls_text,'l')
            END IF
            
            IF ls_text.getIndexOf(' return ',1) AND lb_retrun_chk THEN
               LET ls_inputs = ls_text.subString(ls_text.getIndexOf('return ',1)+7,ls_text.getLength())
               
               #如果中間包含空白則截斷
               IF ls_inputs.getIndexOf(' ',1) THEN
                  LET ls_inputs = ls_inputs.subString(1,ls_inputs.getIndexOf(' ',1)-1)
               END IF
               
               CALL azzp171_gzwb_io(ls_inputs,'o')
			   LET lb_retrun_chk = FALSE
            END IF
            
            IF ls_text.getIndexOf('end function', 1) THEN 
               EXIT WHILE 
            END IF
         END WHILE    
      END IF
      
      #處理完function宣告則離開
      IF ls_text.getIndexOf('end function', 1) THEN 
         EXIT WHILE 
      END IF
   
   END WHILE
   
   #組合資訊
   FOR li_idx = 1 TO gr_gzwb.getLength()
      
      #找出型態(gzwb008)
      FOR li_idx2 = 1 TO gr_gzwb_type.getLength()
         IF gr_gzwb[li_idx].gzwb010 = gr_gzwb_type[li_idx2].gzwb010 THEN
            LET gr_gzwb[li_idx].gzwb008 = gr_gzwb_type[li_idx2].gzwb008
            EXIT FOR
         END IF
      END FOR
	  
	  #如果找不到可能是全域變數
	  IF cl_null(gr_gzwb[li_idx].gzwb008) THEN
         FOR li_idx2 = 1 TO gr_gzwb_type_global.getLength()
            IF gr_gzwb[li_idx].gzwb010 = gr_gzwb_type_global[li_idx2].gzwb010 THEN
               LET gr_gzwb[li_idx].gzwb008 = gr_gzwb_type_global[li_idx2].gzwb008
               EXIT FOR
            END IF
         END FOR
	  END IF
      
      #找出說明(gzwb009)
      FOR li_idx2 = 1 TO gr_gzwb_desc.getLength()
         IF gr_gzwb[li_idx].gzwb010 = gr_gzwb_desc[li_idx2].gzwb010 THEN
            LET gr_gzwb[li_idx].gzwb009 = gr_gzwb_desc[li_idx2].gzwb009
            EXIT FOR
         END IF
      END FOR
      #DISPLAY '傳入傳出:',gr_gzwb[li_idx].gzwb006
      #DISPLAY '  序號  :',gr_gzwb[li_idx].gzwb007
      #DISPLAY '  型態  :',gr_gzwb[li_idx].gzwb008
      #DISPLAY '  說明  :',gr_gzwb[li_idx].gzwb009
      #DISPLAY '  名稱  :',gr_gzwb[li_idx].gzwb010
      #DISPLAY '--------------------------------------'
   END FOR
   
   
   #呼叫寫入段
   CALL azzp171_save()
   #DISPLAY '--------------------------------------------'
   #DISPLAY '函式編號:',gr_gzwa.gzwa002
   #DISPLAY '內部函式區別碼:',gr_gzwa.gzwa004
   #DISPLAY '函式目的:',gr_gzwa.gzwa006
   #DISPLAY '其他說明:',gr_gzwa.gzwa007
   #DISPLAY '--------------------------------------------'

   #清空單身以及單頭function名稱
   LET gr_gzwa.gzwa002 = ''
   LET gr_gzwa.gzwa004 = ''
   INITIALIZE gr_gzwb       TO NULL
   INITIALIZE gr_gzwb_desc  TO NULL
   INITIALIZE gr_gzwb_type  TO NULL
   
   RETURN pchannel_read
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp171_gzwb_io(ps_list,ps_type)
   DEFINE ps_list     STRING
   DEFINE ps_type     STRING
   DEFINE lst_token   base.StringTokenizer
   DEFINE ls_token    STRING 
   DEFINE li_idx      INTEGER
   
   #RETRUN TRUE / FALSE不處理
   IF ps_type = 'o' AND (ps_list = 'true' OR ps_list = 'false') THEN
      RETURN
   END IF
   
   LET lst_token = base.StringTokenizer.create(ps_list, ',')
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
      #輸入(i)/輸出(o)
      LET gr_gzwb[gr_gzwb.getLength()+1].gzwb006 = ps_type
      
      #序號
      LET gr_gzwb[gr_gzwb.getLength()].gzwb007 = gr_gzwb.getLength()

      #名稱
      LET gr_gzwb[gr_gzwb.getLength()].gzwb010 = ls_token.trim()
   END WHILE
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp171_gzwb_type(ps_define,ps_type)
   DEFINE ps_define STRING
   DEFINE ps_type   STRING
   DEFINE ls_define STRING
   DEFINE li_idx    INTEGER 
   DEFINE ls_type   STRING
   DEFINE ps_source,ps_old,ps_new STRING
   DEFINE l_buf base.StringBuffer

   LET l_buf = base.StringBuffer.create()
   CALL l_buf.append(ps_define)
   
   IF ps_type = 'g' THEN
      LET li_idx = gr_gzwb_type_global.getLength()+1
   ELSE
      LET li_idx = gr_gzwb_type.getLength()+1
   END IF
   
   #先去掉define
   CALL l_buf.replace('define ', '', 1)
   LET ls_define = l_buf.toString()
   LET ls_define = ls_define.trimLeft()
   
   #先抓變數名稱
   LET gr_gzwb_type[li_idx].gzwb010 = 
       ls_define.subString(1,ls_define.getIndexOf(' ',1))
   
   #後抓變數型態
   #開始切截(先拿掉define)
   LET ls_define = cl_replace_str(ps_define,'define','')
   #拿掉變數
   LET ls_define = cl_replace_str(ls_define,gr_gzwb_type[li_idx].gzwb010,'')
   #拿掉LIKE
   LET ls_define = cl_replace_str(ls_define,'like','')
   
   #拿掉註解
   IF ls_define.getIndexOf('#',1) THEN
      LET ls_define = ls_define.subString(1,ls_define.getIndexOf('#',1)-1)
   END IF
   
   #拿掉逗點
   IF ls_define.getIndexOf(',',1) THEN
      LET ls_define = cl_replace_str(ls_define,',','')
   END IF
   
   #拿掉type_t.
   IF ls_define.getIndexOf('type_t.',1) THEN
      LET ls_define = cl_replace_str(ls_define,'type_t.','')
   END IF
   
   #拿掉tab
   IF ls_define.getIndexOf('    ',1) THEN
      LET ls_define = cl_replace_str(ls_define,'	','')
   END IF
   
   #拿掉空白
   LET ls_define = ls_define.trim()
   
   #儲存型態
   IF ps_type = 'g' THEN
      LET gr_gzwb_type_global[li_idx].gzwb008 = ls_define
   ELSE
      LET gr_gzwb_type[li_idx].gzwb008 = ls_define
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp171_save()
   DEFINE li_idx INTEGER
   DEFINE li_cnt INTEGER
   
   #修改人資訊
   LET gr_gzwa.gzwacrtdt = cl_get_current()
   LET gr_gzwa.gzwacrtdp = g_dept  
   LET gr_gzwa.gzwacrtid = g_user  
   LET gr_gzwa.gzwaowndp = g_dept
   LET gr_gzwa.gzwaownid = g_user  
   LET gr_gzwa.gzwamoddt = cl_get_current()
   LET gr_gzwa.gzwamodid = g_user 
   
   #先檢查是否已存在
   SELECT COUNT(*) INTO li_cnt 
     FROM gzwa_t
    WHERE gzwa001 = gr_gzwa.gzwa001 
      AND gzwa002 = gr_gzwa.gzwa002
    
   #準備寫入單頭    
   IF li_cnt <> 0 THEN
      UPDATE gzwa_t
         SET gzwa001   = gr_gzwa.gzwa001,   gzwa002   = gr_gzwa.gzwa002,
             gzwa003   = gr_gzwa.gzwa003,   gzwa004   = gr_gzwa.gzwa004,
             gzwa005   = gr_gzwa.gzwa005,   gzwa006   = gr_gzwa.gzwa006,
             gzwa007   = gr_gzwa.gzwa007,   gzwamodid = gr_gzwa.gzwamodid,
             gzwamoddt = gr_gzwa.gzwamoddt, gzwaownid = gr_gzwa.gzwaownid,
             gzwaowndp = gr_gzwa.gzwaowndp
       WHERE gzwa001   = gr_gzwa.gzwa001 
	      AND gzwa002   = gr_gzwa.gzwa002
   ELSE
      INSERT INTO gzwa_t(gzwa001,gzwa002,gzwa003,gzwa004,
                         gzwa005,gzwa006,gzwa007,
                         gzwamodid,gzwamoddt,gzwaownid,
                         gzwaowndp,gzwacrtid,gzwacrtdp,gzwacrtdt)
                  VALUES(gr_gzwa.gzwa001,gr_gzwa.gzwa002,gr_gzwa.gzwa003,gr_gzwa.gzwa004,
                         gr_gzwa.gzwa005,gr_gzwa.gzwa006,gr_gzwa.gzwa007,
                         gr_gzwa.gzwamodid,gr_gzwa.gzwamoddt,gr_gzwa.gzwaownid,
                         gr_gzwa.gzwaowndp,gr_gzwa.gzwacrtid,gr_gzwa.gzwacrtdp,gr_gzwa.gzwacrtdt)
   END IF

   #準備寫入單身
   FOR li_idx = 1 TO gr_gzwb.getLength()
        
       SELECT COUNT(*) INTO li_cnt FROM gzwb_t
        WHERE gzwb001 = gr_gzwa.gzwa001 
          AND gzwb002 = gr_gzwa.gzwa002
          AND gzwb006 = gr_gzwb[li_idx].gzwb006  
          AND gzwb007 = gr_gzwb[li_idx].gzwb007

       IF li_cnt <> 0 THEN
          UPDATE gzwb_t
             SET gzwb001 = gr_gzwa.gzwa001, 
			        gzwb002 = gr_gzwa.gzwa002,
                 gzwb006 = gr_gzwb[li_idx].gzwb006,
                 gzwb007 = gr_gzwb[li_idx].gzwb007,
                 gzwb008 = gr_gzwb[li_idx].gzwb008,
                 gzwb009 = gr_gzwb[li_idx].gzwb009
           WHERE gzwb001 = gr_gzwa.gzwa001 
             AND gzwb002 = gr_gzwa.gzwa002
             AND gzwb006 = gr_gzwb[li_idx].gzwb006 
             AND gzwb007 = gr_gzwb[li_idx].gzwb007

       ELSE 
          INSERT INTO gzwb_t(gzwb001,gzwb002,gzwb006,gzwb007,gzwb008,gzwb009,gzwb010)
          VALUES(gr_gzwa.gzwa001,gr_gzwa.gzwa002,
                 gr_gzwb[li_idx].gzwb006,gr_gzwb[li_idx].gzwb007,
                 gr_gzwb[li_idx].gzwb008,gr_gzwb[li_idx].gzwb009,
                 gr_gzwb[li_idx].gzwb010)

       END IF  
   END FOR 
   
END FUNCTION

#end add-point
 
{</section>}
 
