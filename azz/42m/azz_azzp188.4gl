#該程式已解開Section, 不再透過樣板產出!
{<section id="azzp188.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000000
#+ 
#+ Filename...: azzp188
#+ Description: 檢查程式增刪改查表格清單
#+ Creator....: 00845(2015-08-17 16:31:26)
#+ Modifier...: 00000() -SD/PR- 02667
 
{</section>}
 
{<section id="azzp188.global" >}
#應用 p01 樣板自動產生(Version:10)

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目

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
   #add-point:自定背景執行須傳遞的參數(Module Variable)
   
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE lc_current DATETIME YEAR TO SECOND
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="azzp188.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define 
   DEFINE ls_compose    STRING
   DEFINE ls_filename   STRING
   #end add-point 
   #add-point:main段define (客製用)

   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")

   LET ls_filename = g_argv[1]
   LET g_t100debug = FGL_GETENV("T100DEBUG")
   LET lc_current = cl_get_current()
 
   CALL azzp188_select(ls_filename)

 

 
   DISPLAY "INFO: 更新程式對實體表格處理關係資料完成"
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp188.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp188_init()
   #add-point:init段define 
   
   #end add-point
   #add-point:init段define (客製用)
   
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzp188.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp188_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define 
   
   #end add-point
   #add-point:ui_dialog段define (客製用)
   
   #end add-point
   
   #add-point:ui_dialog段before dialog
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
         #add-point:ui_dialog段construct
         
         #end add-point
         #add-point:ui_dialog段input
         
         #end add-point
         #add-point:ui_dialog段自定義display array
 
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL azzp188_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action
         
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
         CALL azzp188_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog
      
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
                 CALL azzp188_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp188_transfer_argv(ls_js)
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
 
         #add-point:ui_dialog段after schedule
         
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
 
{<section id="azzp188.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp188_transfer_argv(ls_js)
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define 
   
   #end add-point
   #add-point:transfer_agrv段define (客製用)
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="azzp188.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp188_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define 
   
   #end add-point
   #add-point:process段define (客製用)
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp188_process_cs CURSOR FROM ls_sql
#  FOREACH azzp188_process_cs INTO
   #add-point:process段process
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp188_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp188.get_buffer" >}
PRIVATE FUNCTION azzp188_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp188.msgcentre_notify" >}
PRIVATE FUNCTION azzp188_msgcentre_notify()
 
   DEFINE lc_state LIKE type_t.chr5
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp188.other_function" >}
#add-point:自定義元件(Function)

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
PRIVATE FUNCTION azzp188_select(ls_prog)
   DEFINE ls_prog        STRING
   DEFINE lc_gzza001     LIKE gzza_t.gzza001  #程式編號
   DEFINE lc_gzza003     LIKE gzza_t.gzza003  #歸屬模組  gzde002
   DEFINE lc_gzza011     LIKE gzza_t.gzza011  #客製      gzde008
   DEFINE lp_prog        base.Channel
   DEFINE lc_analy       LIKE type_t.chr1000
   DEFINE ls_analy       STRING
   DEFINE li_i,li_j      LIKE type_t.num5
   DEFINE li_length      LIKE type_t.num5
   DEFINE li_lineno      LIKE type_t.num5
   DEFINE li_cnt         LIKE type_t.num5

   LET li_lineno = 11

   #確認程式路徑
   IF ls_prog = " " OR ls_prog IS NULL THEN
      IF g_t100debug >= 3 THEN
         DISPLAY "Error: 傳入的參數為空或不存在"
      END IF
      RETURN
   ELSE
      LET lc_gzza001 = ls_prog.trim()
   END IF

   SELECT gzza003,gzza011 INTO lc_gzza003,lc_gzza011 FROM gzza_t
    WHERE gzza001 = lc_gzza001 AND gzzastus = "Y"
   IF SQLCA.SQLCODE THEN
      SELECT gzde002,gzde008 INTO lc_gzza003,lc_gzza011 FROM gzde_t
       WHERE gzde001 = lc_gzza001 AND gzdestus = "Y"
   END IF
   IF lc_gzza003 = " " OR lc_gzza003 IS NULL THEN
      IF g_t100debug >= 3 THEN
         DISPLAY "Error: 傳入的參數(",ls_prog,") 在azzi900/901查無資料:",SQLCA.SQLCODE
      END IF
      RETURN
   END IF

   #檢查gzdg_t資料,若存在則清空
   SELECT COUNT(*) INTO li_cnt FROM gzdg_t WHERE gzdg001 = lc_gzza001
   IF li_cnt > 0 THEN
      DELETE FROM gzdg_t WHERE gzdg001 = lc_gzza001
   END IF

   IF lc_gzza011 IS NOT NULL AND lc_gzza011 = "Y" THEN
      IF lc_gzza003 = "LIB" OR lc_gzza003 = "SUB" OR lc_gzza003 = "QRY" OR lc_gzza003 = "LNG" THEN
         IF lc_gzza003[1,1] <> "C" THEN
            LET lc_gzza003 = "C",lc_gzza003 CLIPPED
         END IF
      ELSE
         IF lc_gzza003[1,1] <> "C" THEN
            LET lc_gzza003 = "C",lc_gzza003[2,LENGTH(lc_gzza003)]
         END IF
      END IF
   END IF
   LET ls_prog = ls_prog,".4gl"
   LET ls_prog = os.Path.join(os.Path.join(FGL_GETENV(lc_gzza003),"4gl"),ls_prog)

   IF g_t100debug >= 6 THEN
      DISPLAY "INFO: 掃描檔案:",ls_prog
   END IF

   #安全機制的action id需要以合法的方式補到別支作業
   IF NOT os.Path.exists(ls_prog) THEN
      RETURN
   END IF

   LET lp_prog = base.Channel.create()
   CALL lp_prog.openFile(ls_prog,"r")

   WHILE lp_prog.read([lc_analy])
      LET li_lineno = li_lineno + 1
      LET ls_analy = DOWNSHIFT(lc_analy)
      LET ls_analy = ls_analy.trim()

      # 先判斷本行行頭是否以 # 或 -- 為開頭, 如果是就放棄這個找下個
      # 補上 { 符號   請勿在行首放大括號
      IF ls_analy.subString(1,1) = "#" OR ls_analy.subString(1,2) = "--" OR
         ls_analy.subString(1,1) = "{" THEN
         CONTINUE WHILE
      END IF

      #抓 SELECT
      CALL ls_analy.getIndexOf("select ",1) RETURNING li_i
      IF li_i > 0 THEN  # azzp188_line_chknomemo  Check select前是否有註解
         IF azzp188_line_chknomemo(ls_analy, li_i) THEN
            LET li_lineno = 0
            LET ls_analy = ls_analy.subString(li_i,ls_analy.getLength())
            LET li_j = ls_analy.getIndexOf("from ",1)
            #刪去有 'into temp'
            IF ls_analy.getIndexOf("into temp",li_j) THEN
               LET ls_analy = ls_analy.subString(1,ls_analy.getIndexOf("into temp",li_j)-1)
            END IF
            IF li_j > 0 THEN
               IF azzp188_line_chknomemo(ls_analy,li_j) THEN
                  LET ls_analy = ls_analy.subString(ls_analy.getIndexOf("from ",1)+4,ls_analy.getLength())
                  LET ls_analy = ls_analy.trim()
                  CALL azzp188_getfile(lc_gzza001,"S",ls_analy.trim())
               END IF
            END IF
         END IF
         CONTINUE WHILE
      END IF

      #抓 UPDATE
      CALL ls_analy.getIndexOf("update ",1) RETURNING li_i
      IF li_i > 0 THEN  # azzp188_line_chknomemo  Check select前是否有註解
         IF azzp188_line_chknomemo(ls_analy, li_i) THEN
            LET li_lineno = 10
            LET ls_analy = ls_analy.subString(li_i+6,ls_analy.getLength())
            IF ls_analy.getIndexOf("set ",1) THEN
               LET ls_analy = ls_analy.subString(1,ls_analy.getIndexOf("set ",1)-1)
            END IF
            IF ls_analy.getIndexOf("_t",2) THEN
               CALL azzp188_getfile(lc_gzza001,"U",ls_analy.trim())
            END IF
         END IF
         CONTINUE WHILE
      END IF

      #抓 INSERT
      CALL ls_analy.getIndexOf("insert ",1) RETURNING li_i
      IF ls_analy.getIndexOf(" into ",1) AND
         li_i > 0 THEN  # azzp188_line_chknomemo  Check select前是否有註解
         IF azzp188_line_chknomemo(ls_analy, li_i) THEN
            LET li_lineno = 10
            LET ls_analy = ls_analy.subString(li_i+6,ls_analy.getLength())
            LET ls_analy = ls_analy.trim()
            IF ls_analy.getIndexOf("into ",1) THEN
               LET ls_analy = ls_analy.subString(ls_analy.getIndexOf("into ",1)+4,ls_analy.getLength())
            END IF
            IF ls_analy.getIndexOf("_t",2) THEN
               CALL azzp188_getfile(lc_gzza001,"I",ls_analy.trim())
            END IF
         END IF
         CONTINUE WHILE
      END IF

      #抓 DELETE
      CALL ls_analy.getIndexOf("delete ",1) RETURNING li_i
      IF ls_analy.getIndexOf(" from ",1) AND
         li_i > 0 THEN  # azzp188_line_chknomemo  Check select前是否有註解
         IF azzp188_line_chknomemo(ls_analy, li_i) THEN
            LET li_lineno = 10
            LET ls_analy = ls_analy.subString(li_i+6,ls_analy.getLength())
            LET ls_analy = ls_analy.trim()
            IF ls_analy.getIndexOf("from ",1) THEN
               LET ls_analy = ls_analy.subString(ls_analy.getIndexOf("from ",1)+4,ls_analy.getLength())
            END IF
            IF ls_analy.getIndexOf("_t",2) THEN
               CALL azzp188_getfile(lc_gzza001,"D",ls_analy.trim())
            END IF
         END IF
         CONTINUE WHILE
      END IF

      #抓 CREATE TEMP TABLE
      CALL ls_analy.getIndexOf("table ",1) RETURNING li_i
      IF ls_analy.getIndexOf("create ",1) AND ls_analy.getIndexOf("temp ",1) AND
         li_i > 0 THEN  # azzp188_line_chknomemo  Check select前是否有註解
         IF azzp188_line_chknomemo(ls_analy, li_i) THEN
            LET li_lineno = 10
            LET ls_analy = ls_analy.subString(li_i+5,ls_analy.getLength())
            LET ls_analy = ls_analy.trim()
            IF ls_analy.getIndexOf("_t",2) THEN
               CALL azzp188_getfile(lc_gzza001,"T",ls_analy.trim())
            END IF
         END IF
         CONTINUE WHILE
      END IF

      #抓 INTO TEMP
      CALL ls_analy.getIndexOf("into ",1) RETURNING li_i
      IF ls_analy.getIndexOf("temp ",1) AND
         li_i > 0 THEN  # azzp188_line_chknomemo  Check select前是否有註解
         IF azzp188_line_chknomemo(ls_analy, li_i) THEN
            LET li_lineno = 10
            LET ls_analy = ls_analy.subString(li_i+4,ls_analy.getLength())
            LET ls_analy = ls_analy.trim()
            IF ls_analy.getIndexOf("_t",2) THEN
               CALL azzp188_getfile(lc_gzza001,"T",ls_analy.trim())
            END IF
         END IF
         CONTINUE WHILE
      END IF

      #抓cl_multitable, 多語言相關
      CALL ls_analy.getIndexOf("cl_multitable(",1) RETURNING li_i
      IF li_i > 0 THEN 
         IF azzp188_line_chknomemo(ls_analy, li_i) THEN
            LET li_lineno = 10
            LET ls_analy = ls_analy.subString(li_i+69,ls_analy.getLength())
            LET ls_analy = ls_analy.trim()
            IF ls_analy.getIndexOf("_t",2) THEN
               CALL azzp188_getfile(lc_gzza001,"I",ls_analy.trim())
            END IF
         END IF
         CONTINUE WHILE
      END IF

      IF li_lineno <= 10 AND li_lineno >0 THEN
         LET li_i = ls_analy.getIndexOf("from ",1)
         LET li_j = ls_analy.getIndexOf("join ",1)
         IF li_i > 0 OR li_j > 0 THEN
            IF azzp188_line_chknomemo(ls_analy,li_i) THEN
               LET ls_analy = ls_analy.subString(li_i+4,ls_analy.getLength())
               CALL azzp188_getfile(lc_gzza001,"S",ls_analy.trim())
            END IF
         END IF
      END IF

   END WHILE

   CALL lp_prog.close()

END FUNCTION

################################################################################
#+ 分析檔案內容
################################################################################
PRIVATE FUNCTION azzp188_getfile(lc_gzza001,lc_type,ls_analy)
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzdg002  LIKE gzdg_t.gzdg002
   DEFINE lc_type     LIKE type_t.chr1
   DEFINE ls_analy    STRING
   DEFINE ls_tableid  STRING
   DEFINE ls_gztz001  LIKE gztz_t.gztz001
   DEFINE li_i,li_j   LIKE type_t.num5

   WHILE TRUE
      IF NOT ls_analy.getIndexOf("_t",1) THEN
         EXIT WHILE
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      IF li_i > 10 THEN
         LET ls_analy = ls_analy.subString(li_i-10, ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境1 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf(",",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+1, ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境2 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf(".",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+1, ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境3 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf("(",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+1,ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境4 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf('"',1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+1,ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境5 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf(":",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+1,ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境6 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf("'",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+1,ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境7 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf("where",1)
      IF li_j > li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(1,li_j-1)
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境8 變更後:",ls_analy
         END IF
      END IF

      LET li_j = ls_analy.getIndexOf("#",1)
      IF li_j > 0 THEN
         LET ls_analy = ls_analy.subString(1,li_j-1)
         LET ls_analy = ls_analy.trimRight()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境9 變更後:",ls_analy
         END IF
      END IF

      LET li_j = ls_analy.getIndexOf("--",1)
      IF li_j > 0 THEN
         LET ls_analy = ls_analy.subString(1,li_j-1)
         LET ls_analy = ls_analy.trimRight()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境10 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf("OUTER ",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+5,ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境11 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf("join ",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+4,ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境12 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET li_j = ls_analy.getIndexOf(" ",1)
      IF li_j < li_i AND li_j != 0 THEN
         LET ls_analy = ls_analy.subString(li_j+1, ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境13 變更後:",ls_analy
         END IF
      END IF

      LET li_i = ls_analy.getIndexOf("_t",1)
      LET ls_tableid = ls_analy.subString(1,li_i+1)
      IF g_t100debug >= 9 THEN
         DISPLAY "INFO: 收入tableid==",ls_tableid
      END IF

      IF ls_analy.getLength() > li_i+1 THEN
         LET ls_analy = ls_analy.subString(li_i+1,ls_analy.getLength())
         LET ls_analy = ls_analy.trim()
         IF g_t100debug >= 9 THEN
            DISPLAY "INFO: 情境14 變更後:",ls_analy
         END IF
      END IF

	  #確定該表存在
	  LET ls_gztz001 = ls_tableid.trim()
	  SELECT COUNT(*) INTO li_j FROM gztz_t
	   WHERE gztz001 = ls_gztz001
	  IF li_j = 0 OR lc_type = "T" THEN
	     DISPLAY "表格(",ls_gztz001,")不存在!"
		 EXIT WHILE
	  END IF

      # 比對是否已經有加進來的
      LET li_j = 0
      LET lc_gzdg002 = ls_tableid.trim()
      SELECT COUNT(*) INTO li_j FROM gzdg_t
       WHERE gzdg001 = lc_gzza001 AND gzdg002 = lc_gzdg002 AND gzdg003 = lc_type
      IF li_j = 0 THEN
         INSERT INTO gzdg_t (gzdg001,gzdg002,gzdg003,gzdg004)
         VALUES(lc_gzza001,lc_gzdg002,lc_type,lc_current)
      END IF

      IF ls_analy.getLength() <= li_i+1 THEN
         EXIT WHILE
      END IF

   END WHILE

END FUNCTION

################################################################################
#+ 檢查是否為註解行
################################################################################
PRIVATE FUNCTION azzp188_line_chknomemo(ls_analy,li_i)

   DEFINE ls_analy     STRING
   DEFINE ls_tmp       STRING
   DEFINE li_i         LIKE type_t.num10

   LET ls_tmp = ls_analy.subString(1,li_i)
   IF ls_tmp.getIndexOf("#",1) THEN
      RETURN FALSE
   END IF
   IF ls_tmp.getIndexOf("--",1) THEN
      RETURN FALSE
   END IF

   RETURN TRUE

END FUNCTION

#end add-point
 
{</section>}
 
