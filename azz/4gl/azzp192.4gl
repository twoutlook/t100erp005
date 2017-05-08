#該程式已解開Section, 不再透過樣板產出!
{<section id="azzp192.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000000
#+ 
#+ Filename...: azzp192
#+ Description: 在TEXTMODE檢視錯誤訊息使用
#+ Creator....: 01856(2014-11-13 10:18:04)
#+ Modifier...: 00000() -SD/PR- 01856
#+ Buildtype..: 應用 p01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="azzp192.global" >}
#1160531-00036 #1 2016/05/31 By jrg542  檢視錯誤訊息，程式中有使用但是azzi920 並沒有登入
 
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
DEFINE gc_prog       LIKE gzza_t.gzza001
DEFINE gi_gzzl_count LIKE type_t.num5 
DEFINE gi_type       LIKE type_t.num5  
DEFINE g_result      STRING
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="azzp192.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define

   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
   
   LET g_bgjob = "Y"
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   #160531-00036 #1 start
   LET gc_prog = g_argv[1]
   LET gi_type = g_argv[2]   #Show Type 0:顯示所有訊息
                             #          1:不顯示分析訊息,只顯示匯總資料
                             #          2:不顯示分析訊息,只顯示gzze_t不存在的項目(只查zh_TW/zh_CN/en_US)
   #160531-00036 #1 end 
   IF gi_type IS NULL THEN LET gi_type = 0 END IF
 
   # gzzl 是 link 的單身
   SELECT count(*) INTO gi_gzzl_count FROM gzzl_t WHERE gzzl001 = gc_prog 
   IF gi_gzzl_count <= 0 THEN
      DISPLAY gc_prog CLIPPED,' NOT Existed in Link Data!'
      EXIT PROGRAM
   ELSE
      IF NOT gi_type THEN
         DISPLAY ' '
         DISPLAY 'Analying.....',gc_prog
         DISPLAY ' '
      END IF
   END IF
 
   CALL azzp192_select() 
 
   LET g_result = g_result.trim()
   LET g_result = g_result.subString(1,g_result.getLength()-1)

   IF NOT gi_type THEN
      DISPLAY ' '
      DISPLAY 'Error Item List: '
      DISPLAY g_result
      DISPLAY ' '
   ELSE
      DISPLAY g_result
   END IF
   #end add-point
 
#   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
#     CALL azzp192_process(ls_js)
#   ELSE
      #畫面開啟 (identifier)
#      OPEN WINDOW w_azzp192 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
#      CALL cl_ui_init()
 
      #程式初始化
#      CALL azzp192_init()
 
      #進入選單 Menu (="N")
#      CALL azzp192_ui_dialog()
 
      #add-point:畫面關閉前

      #end add-point
      #畫面關閉
#      CLOSE WINDOW w_azzp192
#   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp192.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp192_init()
   #add-point:init段define
   
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
 
{<section id="azzp192.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp192_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define
   
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL azzp192_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            
            #end add-point
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL azzp192_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET lc_param.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION batch_execute
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE lc_param.* TO NULL
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
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #add-point:ui_dialog段exit dialog
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         #LET g_jobid = cl_schedule_get_jobid(g_prog)
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL azzp192_process(ls_js)
            WHEN g_schedule.gzpa003 = "1"
            #    CALL cl_schedule_update_data(g_jobid,ls_js)
                 LET ls_js = azzp192_transfer_argv(ls_js)
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
 
{<section id="azzp192.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp192_transfer_argv(ls_js)
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
 
   CALL util.JSON.parse(ls_js,la_param)
 
   LET la_cmdrun.prog = g_prog
   #add-point:transfer.argv段define
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="azzp192.process" >}
#+ 資料處理
PRIVATE FUNCTION azzp192_process(ls_js)
   DEFINE ls_js       STRING
   DEFINE lc_param    type_parameter
   DEFINE li_stus     LIKE type_t.num5
   DEFINE li_count    LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql      STRING             #主SQL
   #add-point:process段define
   
   #end add-point
 
   CALL util.JSON.parse(ls_js,lc_param)
 
   #add-point:process段前處理
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp192_process_cs CURSOR FROM ls_sql
#  FOREACH azzp192_process_cs INTO
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
   END IF
END FUNCTION
 
{</section>}
 
{<section id="azzp192.get_buffer" >}
PRIVATE FUNCTION azzp192_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp192.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: # 抓取 gzzl (Link資料) 自動串接所有有寫在 link 檔裡的 4ad
# Memo...........:
# Usage..........: CALL azzp192_select()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp192_select()
    DEFINE ls_subprog    STRING
   DEFINE ls_sub_ze     STRING
   DEFINE ls_sql        STRING
   DEFINE li_temp       LIKE type_t.num5
   DEFINE l_gzzl        RECORD
            gzzl002     LIKE gzzl_t.gzzl002,
            gzzl003     LIKE gzzl_t.gzzl003
                    END RECORD
 
   #抓取 gzzl (Link資料) 自動串接所有有寫在 link 檔裡的 4ad
   LET ls_sql = " SELECT gzzl002,gzzl003 FROM gzzl_t ",
                 " WHERE gzzl001='",gc_prog CLIPPED,"'"
 
   LET li_temp = 1
 
   PREPARE azzp192_gzzl_pre FROM ls_sql
   DECLARE azzp192_gzzl_cs CURSOR FOR azzp192_gzzl_pre
   FOREACH azzp192_gzzl_cs INTO l_gzzl.*
 
      LET ls_subprog = FGL_GETENV(UPSHIFT(l_gzzl.gzzl003 CLIPPED))
 
      LET ls_subprog = os.Path.join( os.Path.join(ls_subprog.trim(),"4gl"),
                                     l_gzzl.gzzl002 CLIPPED || ".4gl" )
      IF NOT gi_type THEN
         DISPLAY "Part ",li_temp CLIPPED," of ",gi_gzzl_count CLIPPED,"...",ls_subprog
      END IF
 
      CALL s_azzp192_get(ls_subprog) RETURNING ls_sub_ze
      CALL azzp192_fill(ls_sub_ze)
      LET li_temp = li_temp + 1
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp192_fill(ls_waitcut)
#                  RETURNING 回传参数
# Input parameter: ls_waitcut
# Return code....: 回传参数变量1  
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp192_fill(ls_waitcut)
   DEFINE ls_waitcut      STRING
   DEFINE lst_act         base.StringTokenizer
   DEFINE ls_act          STRING
   DEFINE li_array_length LIKE type_t.num5
   DEFINE li_i            LIKE type_t.num5
   DEFINE li_zecnt_tw     LIKE type_t.num5
   DEFINE li_zecnt_cn     LIKE type_t.num5
   DEFINE li_zecnt_us     LIKE type_t.num5
   DEFINE lc_gzze001      LIKE gzze_t.gzze001
 
   LET lst_act = base.StringTokenizer.create(ls_waitcut CLIPPED, ",")
 
   WHILE lst_act.hasMoreTokens()
      LET ls_act = lst_act.nextToken()
      LET ls_act = ls_act.trim(),","
      IF ls_act.subString(1,3) = "dzf" THEN CONTINUE WHILE END IF

      IF NOT g_result.getIndexOf(ls_act,1) THEN
         IF NOT gi_type THEN
            LET g_result = g_result,ls_act," "
         ELSE
            IF gi_type = 2 THEN
               LET lc_gzze001 = ls_act.subString(1,ls_act.getLength()-1)
               SELECT COUNT(1) INTO li_zecnt_tw FROM gzze_t WHERE gzze001 = lc_gzze001 AND gzze002 = 'zh_TW'
               SELECT COUNT(1) INTO li_zecnt_cn FROM gzze_t WHERE gzze001 = lc_gzze001 AND gzze002 = 'zh_CN'
              #SELECT COUNT(1) INTO li_zecnt_us FROM gzze_t WHERE gzze001 = lc_gzze001 AND gzze002 = 'en_US'
               IF NOT li_zecnt_tw OR NOT li_zecnt_cn THEN  #OR NOT li_zecnt_us THEN
                  LET g_result = g_result,"\n",ls_act.subString(1,ls_act.getLength()-1)," 欠"
               END IF
               IF NOT li_zecnt_tw THEN LET g_result = g_result," zh_TW." END IF
               IF NOT li_zecnt_cn THEN LET g_result = g_result," zh_CN." END IF
              #IF NOT li_zecnt_us THEN LET g_result = g_result," en_US." END IF
            ELSE
               LET g_result = g_result,"'",ls_act.subString(1,ls_act.getLength()-1),"', "
            END IF
         END IF
      END IF
   END WHILE
END FUNCTION

#end add-point
 
{</section>}
 
