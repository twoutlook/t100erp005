#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-08-20 18:09:45), PR版次:0007(2016-12-29 17:02:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: azzp510
#+ Description: 引導式指定企業資料複製工具
#+ Creator....: 00845(2015-08-19 17:52:25)
#+ Modifier...: 00845 -SD/PR- 01856
 
{</section>}
 
{<section id="azzp510.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: No.161207-00042 #1   by jrg542       修正 USING "<<<" 位數由3碼改為 USING "<<<<<<<<<" 8 碼 
#+ Modifier...: No.161229-00034 #1   by jrg542       修正 只要是跨DB , 可以導出資料
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
IMPORT FGL azz_azzp510_01  #步驟一 選擇作業
IMPORT FGL azz_azzp510_02  #步驟二 選定表格
IMPORT FGL azz_azzp510_03  #步驟三 選定匯出企業
IMPORT FGL azz_azzp510_04  #步驟四 選定匯入企業
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
GLOBALS "../../azz/4gl/azzp510.inc"
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
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

 TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)

   #end add-point
        wc               STRING
                     END RECORD

DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
DEFINE gwin_curr         ui.Window
DEFINE gfrm_curr         ui.Form

 TYPE type_master RECORD
       wc               STRING
       END RECORD
#模組變數(Module Variables)
DEFINE g_master type_master

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzp510.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE azzp510_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp510 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp510_init()
 
      #進入選單 Menu (='N')
      CALL azzp510_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzp510
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzp510_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG

   #add-point:get_buffer段其他欄位處理

   #end add-point
END FUNCTION

PRIVATE FUNCTION azzp510_init()

   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_ui_replace_sub_window(cl_ap_formpath("azz", "azzp510_01"), "main_grid01", "VBox", "vbox_1")
   CALL azzp510_01_init()    #azzp510_01的畫面預設

   CALL cl_ui_replace_sub_window(cl_ap_formpath("azz", "azzp510_02"), "main_grid02", "VBox", "vbox_1")
   CALL azzp510_02_init()    #azzp510_02的畫面預設

   CALL cl_ui_replace_sub_window(cl_ap_formpath("azz", "azzp510_03"), "main_grid03", "VBox", "vbox_1")
   CALL azzp510_03_init()    #azzp510_03的畫面預設

   CALL cl_ui_replace_sub_window(cl_ap_formpath("azz", "azzp510_04"), "main_grid04", "VBox", "vbox_1")
   CALL azzp510_04_init()    #azzp510_04的畫面預設

   #先將嵌入的畫面都隱藏
   #設定嵌入畫面的 顯示 與 隱藏
   CALL azzp510_set_vbox_visible('0')

END FUNCTION

PRIVATE FUNCTION azzp510_msgcentre_notify()

   DEFINE lc_state LIKE type_t.chr5

   INITIALIZE g_msgparam TO NULL

   #action-id與狀態填寫
   LET g_msgparam.state = "process"

   #add-point:msgcentre其他通知

   #end add-point

   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()

END FUNCTION

PRIVATE FUNCTION azzp510_process(ls_js)
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
#  DECLARE azzp510_process_cs CURSOR FROM ls_sql
#  FOREACH azzp510_process_cs INTO
   #add-point:process段process

   #end add-point
#  END FOREACH

   IF g_bgjob = "N" THEN
      CALL cl_ask_confirm3("std-00012","")
   ELSE
   END IF

   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp510_msgcentre_notify()

END FUNCTION

PRIVATE FUNCTION azzp510_transfer_argv(ls_js)
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

PRIVATE FUNCTION azzp510_ui_dialog()
   DEFINE li_step  LIKE type_t.num5
   LET li_step = 1

   WHILE TRUE
      CASE li_step
         WHEN 1
            CALL azzp510_step1_chk() RETURNING li_step
         WHEN 2
            CALL azzp510_step2_chk() RETURNING li_step
         WHEN 3
            CALL azzp510_step3_chk() RETURNING li_step
         WHEN 4
            CALL azzp510_step4_chk() RETURNING li_step            
         WHEN 0
            EXIT WHILE
         OTHERWISE
            EXIT WHILE
      END CASE
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
PRIVATE FUNCTION azzp510_01_init()
   CALL cl_set_combo_module("gzzz005",1)

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
PRIVATE FUNCTION azzp510_02_init()

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
PRIVATE FUNCTION azzp510_03_init()
   LET g_expent = g_enterprise   #匯出企業
   LET g_exppath = FGL_GETENV("TEMPDIR")  #匯出路徑
   CALL cl_set_combo_ent("gzou001")
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
PRIVATE FUNCTION azzp510_04_init()
   LET g_impent = g_enterprise   #匯入企業
   IF cl_null(g_imppath) THEN
      LET g_imppath = FGL_GETENV("TEMPDIR")  #匯入路徑
   END IF
   CALL cl_set_combo_ent("l_gzou001")
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
PRIVATE FUNCTION azzp510_step1_chk()
   DEFINE li_idx LIKE type_t.num10
   
   #設定左方的流程圖
   CALL azzp510_set_step_img('1')

   #設定嵌入畫面的 顯示 與 隱藏
   CALL azzp510_set_vbox_visible('1')

   #設定下方的button的 顯示 與 隱藏
   CALL azzp510_set_act_visible('1')

   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         SUBDIALOG azz_azzp510_01.azzp510_01_construct
         SUBDIALOG azz_azzp510_01.azzp510_01_display_array

         
         ON ACTION step01
            #此action是為了讓button的圖片有顏色
            #LET g_action_choice = "step1"
            #EXIT DIALOG
            
         ON ACTION step02
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "next_step"
            EXIT DIALOG

         ON ACTION step03
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step3"
            EXIT DIALOG
           
         ON ACTION step04
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step4"
            EXIT DIALOG

         ON ACTION search       #搜尋並加入清單
            CALL azzp510_step1_query()

         ON ACTION qbeclear     #清空搜尋結果
            CALL g_step01.clear()

         ON ACTION export_detail1  #匯出搜尋結果
            LET g_action_choice="export_detail1"
            IF cl_auth_chk_act("export_detail1") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_step01)
               LET g_export_id[1]   = "s_detail1"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
         
         ON ACTION delete_chk #刪除所選
            FOR li_idx = 1 TO g_step01.getLength()
               IF g_step01[li_idx].chk = 'Y' THEN
                  CALL g_step01.deleteElement(li_idx)
                  LET li_idx = li_idx - 1
               END IF
            END FOR
         
         #選擇該筆
         ON ACTION sel
            LET g_step01[DIALOG.getCurrentRow("s_detail1")].chk = 'Y' 
         
         #取消該筆
         ON ACTION unsel
            LET g_step01[DIALOG.getCurrentRow("s_detail1")].chk = 'N' 
         
         #全選
         ON ACTION selall
            FOR li_idx = 1 TO g_step01.getLength()
               LET g_step01[li_idx].chk = 'Y' 
            END FOR
         
         #全不選
         ON ACTION selnone
            FOR li_idx = 1 TO g_step01.getLength()
               LET g_step01[li_idx].chk = 'N' 
            END FOR
            
         ON ACTION exit
            LET g_action_choice = "exit"
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION close
            LET g_action_choice = "close"
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION next_step
            LET g_action_choice = "next_step"
            EXIT DIALOG
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
         CONTINUE DIALOG

      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF

      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CASE g_action_choice
      WHEN "next_step"
         IF azzp510_step1_nextpage_chk() THEN
            RETURN 2   #檢查通過並填入值
         ELSE
            RETURN 1   #檢查未通過，停留在原位
         END IF
      WHEN "step1"
         RETURN 1
      WHEN "step2"
         RETURN 2
      WHEN "step3"
         RETURN 3
      WHEN "step4"
         RETURN 4   
      OTHERWISE
         RETURN 0
   END CASE

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
PRIVATE FUNCTION azzp510_step2_chk()
   DEFINE li_idx LIKE type_t.num10
   
   #檢查是否有step2資料, 沒有則返回
   #IF g_step02.getLength() = 0 THEN
   #   RETURN 1
   #END IF
   
   #設定左方的流程圖
   CALL azzp510_set_step_img('2')

   #設定嵌入畫面的 顯示 與 隱藏
   CALL azzp510_set_vbox_visible('2')

   #設定下方的button的 顯示 與 隱藏
   CALL azzp510_set_act_visible('2')
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         SUBDIALOG azz_azzp510_02.azzp510_02_construct
         SUBDIALOG azz_azzp510_02.azzp510_02_display_array
         
         ON ACTION step01
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step1"
            EXIT DIALOG
            
         ON ACTION step02
            #此action是為了讓button的圖片有顏色
            #LET g_action_choice = "step2"
            #EXIT DIALOG

         ON ACTION step03
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "next_step"
            EXIT DIALOG
           
         ON ACTION step04
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step4"
            EXIT DIALOG

         ON ACTION search       #搜尋並加入清單
            CALL azzp510_step2_query()

         ON ACTION qbeclear     #清空搜尋結果
            CALL g_step02.clear()

         #選擇該筆
         ON ACTION sel
            LET g_step02[DIALOG.getCurrentRow("s_detail2")].chk = 'Y' 
         
         #取消該筆
         ON ACTION unsel
            LET g_step02[DIALOG.getCurrentRow("s_detail2")].chk = 'N' 
         
         #全選
         ON ACTION selall
            FOR li_idx = 1 TO g_step02.getLength()
               LET g_step02[li_idx].chk = 'Y' 
            END FOR
         
         #全不選
         ON ACTION selnone
            FOR li_idx = 1 TO g_step02.getLength()
               LET g_step02[li_idx].chk = 'N' 
            END FOR

         ON ACTION export_detail1  #匯出搜尋結果
            LET g_action_choice="export_detail1"
            IF cl_auth_chk_act("export_detail1") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_step02)
               LET g_export_id[1]   = "s_detail2"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
         
         ON ACTION delete_chk #刪除所選
            FOR li_idx = 1 TO g_step02.getLength()
               IF g_step02[li_idx].chk = 'Y' THEN
                  CALL g_step02.deleteElement(li_idx)
                  LET li_idx = li_idx - 1
               END IF
            END FOR
         
         ON ACTION close
            LET g_action_choice = "close"
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET g_action_choice = "exit"
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION prev_step
            LET g_action_choice = "prev_step"
            EXIT DIALOG        
            
         ON ACTION next_step
            LET g_action_choice = "next_step"
            EXIT DIALOG
            
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
         CONTINUE DIALOG

      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF

      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CASE g_action_choice
      WHEN "prev_step"
         RETURN 1
      WHEN "next_step"
         IF azzp510_step2_nextpage_chk() THEN
            RETURN 3   #檢查通過並填入值
         ELSE
            RETURN 2   #檢查未通過，停留在原位
         END IF
      WHEN "step1"
         RETURN 1
      WHEN "step2"
         RETURN 2
      WHEN "step3"
         RETURN 3
      WHEN "step4"
         RETURN 4   
      OTHERWISE
         RETURN 0
   END CASE
   
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
PRIVATE FUNCTION azzp510_step3_chk()
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_cnt          LIKE type_t.num10
   DEFINE ls_ent          STRING
   DEFINE li_chk          LIKE type_t.num5
   DEFINE ls_time         STRING
   DEFINE ls_path         STRING
   DEFINE ls_cmd          STRING
   DEFINE ls_chk          STRING
   DEFINE ls_msg          STRING
   DEFINE ls_sql          STRING
   DEFINE ls_gzou003 LIKE gzou_t.gzou003
   
   #檢查是否有step2,3資料, 沒有則判斷返回1或2
   IF g_step02.getLength() = 0 THEN
      RETURN 1
   END IF
   IF g_step03_2.getLength() = 0 THEN
      RETURN 2
   END IF
   
   #設定左方的流程圖
   CALL azzp510_set_step_img('3')

   #設定嵌入畫面的 顯示 與 隱藏
   CALL azzp510_set_vbox_visible('3')

   #設定下方的button的 顯示 與 隱藏
   CALL azzp510_set_act_visible('3')
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         SUBDIALOG azz_azzp510_03.azzp510_03_input
         SUBDIALOG azz_azzp510_03.azzp510_03_display
         SUBDIALOG azz_azzp510_03.azzp510_03_display2
         
         ON ACTION step01
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step1"
            EXIT DIALOG
            
         ON ACTION step02
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step2"
            EXIT DIALOG

         ON ACTION step03
            #此action是為了讓button的圖片有顏色
            #LET g_action_choice = "step3"
            #EXIT DIALOG
           
         ON ACTION step04
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "next_step"
            EXIT DIALOG
            
         #匯出資料
         ON ACTION export_ent
            LET g_expent = GET_FLDBUF(gzou001)
            LET g_exppath = GET_FLDBUF(l_exppath)
            
            #抓取對應DB
            SELECT gzou003 INTO ls_gzou003 
              FROM gzou_t
             WHERE gzou001 = g_expent
            IF cl_null(ls_gzou003) THEN
               ERROR "找不到該企業代碼對應的資料庫!"
               RETURN 2
            END IF
            
            
            #檢查有沒有填
            IF cl_null(g_expent) THEN
               NEXT FIELD gzou001
            END IF
            IF cl_null(g_exppath) THEN
               NEXT FIELD l_exppath
            END IF
            
            #產生路徑
            LET ls_time = cl_get_current()
            LET ls_time = cl_str_replace(ls_time,' ','')
            LET ls_time = cl_str_replace(ls_time,':','')
            LET ls_time = cl_str_replace(ls_time,'-','')
            LET ls_path = g_exppath,'/azzp510_',g_user,'_',ls_time
            LET li_chk = os.Path.mkdir(ls_path) 
            IF NOT li_chk THEN
               DISPLAY "建立目錄(",ls_path,")失敗!"
            ELSE 
               DISPLAY "建立目錄(",ls_path,")成功!"
               LET g_nondata = ""
               FOR li_idx = 1 TO g_step03_2.getLength()
                  LET ls_ent = g_step03_2[li_idx].dzea001
                  LET ls_ent = ls_ent.subString(1,ls_ent.getIndexOf('_',1)-1),'ent'
                  
                  #檢查此ent是否有資料
                  LET li_cnt = 0
                  #161229-00034 start
                  #LET ls_sql = " SELECT COUNT(*) FROM ",g_step03_2[li_idx].dzea001,                      
                  LET ls_sql = " SELECT COUNT(*) FROM ",ls_gzou003,".",g_step03_2[li_idx].dzea001,
                  #161229-00034 end
                               "  WHERE  ",ls_ent," = ? "
                  PREPARE chkcnt_tbl FROM ls_sql
                  EXECUTE chkcnt_tbl USING g_expent INTO li_cnt
                  FREE chkcnt_tbl

                  #檢查是否有資料
                  IF li_cnt = 0 THEN
                     #無資料, 進行紀錄
                     LET g_nondata = g_nondata, g_step03_2[li_idx].dzea001, ","
                  ELSE
                     #有資料, 進行匯出
                     #LET ls_cmd = " unloadx dsdemo ",ls_path,"/",g_step03_2[li_idx].dzea001,".txt ",
                     LET ls_cmd = " unloadx ",ls_gzou003," ",ls_path,"/",g_step03_2[li_idx].dzea001,".txt ",
                                  " \"select * from ",g_step03_2[li_idx].dzea001,
                                  #" where ",ls_ent," = '",g_expent USING "<<<","'\""        #161207-00042 mark     
                                  " where ",ls_ent," = '",g_expent USING "<<<<<<<<<","'\""   #161207-00042 add    
                      DISPLAY "run:",ls_cmd
                     CALL cl_cmdrun_openpipe('',ls_cmd,true) RETURNING ls_chk,ls_msg
                  END IF
               END FOR
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'azz-00352'
               LET g_errparam.replace[1] = g_expent
               LET g_errparam.replace[2] = ls_path
               LET g_errparam.type = 2
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               
               IF NOT cl_null(g_nondata) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'azz-00511'
                  LET g_errparam.replace[1] = g_nondata
                  LET g_errparam.type = 2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               
               
               LET g_imppath = ls_path
            END IF


         ON ACTION close
            LET g_action_choice = "close"
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION prev_step
            LET g_action_choice = "prev_step"
            EXIT DIALOG        
            
         ON ACTION next_step
            LET g_action_choice = "next_step"
            EXIT DIALOG
            
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
         CONTINUE DIALOG

      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF

      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CASE g_action_choice
      WHEN "prev_step"
         RETURN 2
      WHEN "next_step"
         RETURN 4
      WHEN "step1"
         RETURN 1
      WHEN "step2"
         RETURN 2
      WHEN "step3"
         RETURN 3
      WHEN "step4"
         RETURN 4   
      OTHERWISE
         RETURN 0
   END CASE
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
PRIVATE FUNCTION azzp510_step4_chk()
   DEFINE lchannel_read           base.Channel
   DEFINE ls_readline   STRING
   DEFINE ls_cmd        STRING
   DEFINE li_idx        INTEGER
   DEFINE li_idx2       INTEGER
   DEFINE li_cnt        INTEGER
   DEFINE ls_sql        STRING
   DEFINE ls_ent        LIKE type_t.chr50
   DEFINE lb_cnt_chk    BOOLEAN
   DEFINE ls_tbl_name   LIKE gztz_t.gztz001
   DEFINE lr_gzda       RECORD
          gzda001 LIKE gzda_t.gzda001, #資料庫名稱
          gzda004 LIKE gzda_t.gzda004  #資料庫密碼
          END RECORD


   #設定左方的流程圖
   CALL azzp510_set_step_img('4')

   #設定嵌入畫面的 顯示 與 隱藏
   CALL azzp510_set_vbox_visible('4')

   #設定下方的button的 顯示 與 隱藏
   CALL azzp510_set_act_visible('4')
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         SUBDIALOG azz_azzp510_04.azzp510_04_input
         SUBDIALOG azz_azzp510_04.azzp510_04_display
         SUBDIALOG azz_azzp510_04.azzp510_04_display2
         
         ON ACTION step01
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step1"
            EXIT DIALOG
            
         ON ACTION step02
            #此action是為了讓button的圖片有顏色
            #LET g_action_choice = "step2"
            #EXIT DIALOG

         ON ACTION step03
            #此action是為了讓button的圖片有顏色
            LET g_action_choice = "step3"
            EXIT DIALOG
           
         ON ACTION step04
            #此action是為了讓button的圖片有顏色
            #LET g_action_choice = "step4"
            #EXIT DIALOG
         
         #匯入資料         
         ON ACTION import_ent
            IF azzp510_step4_load() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'azz-00355'
               LET g_errparam.type = 2
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL cl_set_act_visible("import_ent", FALSE)
            END IF
            
         #檢查表格是否有資料
         ON ACTION check_ent
            CALL cl_set_act_visible("import_ent", FALSE)
            CALL g_step04.clear()
            CALL g_step05.clear()
            #取得表格清單
            LET ls_cmd = "ls ", g_imppath, "/*.txt"
            DISPLAY ls_cmd
            LET lchannel_read = base.Channel.create()
            CALL lchannel_read.openPipe(ls_cmd,"r")
            #讀取表格檔案
            LET li_idx  = 1
            LET li_idx2 = 1
            LET lb_cnt_chk = TRUE
            WHILE TRUE
               LET ls_readline = lchannel_read.readLine()
               IF lchannel_read.isEof() THEN
                  EXIT WHILE
               END IF
               
               #替換掉路徑部分
               LET ls_readline = cl_str_replace(ls_readline,g_imppath,'')
               
               #取得表格名
               LET ls_tbl_name = ls_readline.subString(2,ls_readline.getIndexOf(".txt",1)-1)
               
               #檢查此表是否存在
               LET li_cnt = 0
               SELECT COUNT(*) INTO li_cnt FROM gztz_t 
                WHERE gztz001 = ls_tbl_name
                
               IF li_cnt = 0 THEN
                  DISPLAY "非表格檔案:",ls_tbl_name
               ELSE
                  LET g_step04[li_idx].dzea001 = ls_tbl_name
                  LET ls_ent = ls_readline.subString(2,ls_readline.getIndexOf("_t",1)-1), "ent"
                  
                  SELECT dzeal003 INTO g_step04[li_idx].dzea001_desc FROM dzeal_t 
                   WHERE dzeal001 = g_step04[li_idx].dzea001 AND dzeal002 = g_lang
                  
                  #先確認對應DB
                  SELECT gzou003 INTO lr_gzda.gzda001 FROM gzou_t
                   WHERE gzou001 = g_impent
                  
                  LET ls_sql = " SELECT COUNT(*) FROM ",lr_gzda.gzda001,".",g_step04[li_idx].dzea001,
                               "  WHERE ",ls_ent," = ?"
                  PREPARE chk_tbl FROM ls_sql
                  EXECUTE chk_tbl USING g_impent INTO g_step04[li_idx].cnt
                  IF g_step04[li_idx].cnt > 0 THEN
                     #不可匯入
                     LET g_step05[li_idx2].dzea001      = g_step04[li_idx].dzea001
                     LET g_step05[li_idx2].dzea001_desc = g_step04[li_idx].dzea001_desc
                     LET g_step05[li_idx2].cnt          = g_step04[li_idx].cnt
                     CALL g_step04.deleteElement(li_idx)
                     LET li_idx2 = li_idx2 + 1
                     #LET lb_cnt_chk = FALSE
                  ELSE
                     #可匯入
                     LET li_idx = li_idx + 1
                  END IF
                  FREE chk_tbl 
               END IF
            END WHILE
            
            #該目錄底下無資料
            IF g_step04.getLength() = 0 THEN
               #161207-00042 start
               INITIALIZE g_errparam TO NULL
               IF g_step05.getLength() = 0 THEN              
                  LET g_errparam.code = 'azz-00425'  #請指定正確目錄 
               ELSE
                  LET g_errparam.code = 'azz-00356'
               END IF 
               #161207-00042 end
               #INITIALIZE g_errparam TO NULL     #161207-00042   mark
               #LET g_errparam.code = 'azz-00356' #161207-00042   mark
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL cl_set_act_visible("import_ent", FALSE)
            ELSE
               CALL cl_set_act_visible("import_ent", TRUE)
            END IF
            
            #IF NOT lb_cnt_chk THEN
            #   #已存在資料
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'azz-00354'
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL cl_set_act_visible("import_ent", FALSE)
            #ELSE
            #   CALL cl_set_act_visible("import_ent", TRUE)
            #END IF
             

         ON ACTION close
            LET g_action_choice = "close"
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION prev_step
            LET g_action_choice = "prev_step"
            EXIT DIALOG            

         BEFORE DIALOG
            CALL cl_set_act_visible("import_ent", FALSE)

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
         CONTINUE DIALOG

      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF

      IF NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CASE g_action_choice
      WHEN "prev_step"
         RETURN 3
      WHEN "step1"
         RETURN 1
      WHEN "step2"
         RETURN 2
      WHEN "step3"
         RETURN 3
      WHEN "step4"
         RETURN 4   
      OTHERWISE
         RETURN 0
   END CASE
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
PRIVATE FUNCTION azzp510_set_step_img(li_page)
   DEFINE li_page  LIKE type_t.num5
   
   #將圖片設定為預設值
   CALL gfrm_curr.setElementImage("step01","32/step01.png")
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   CALL gfrm_curr.setElementImage("step04","32/step04.png")

   #文字顏色設定
   CALL gfrm_curr.setElementStyle("step01","menuitem")
   CALL gfrm_curr.setElementStyle("step02","menuitem")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   CALL gfrm_curr.setElementStyle("step04","menuitem")

   #設定圖片為亮燈的
   CASE li_page
      WHEN 1
         CALL gfrm_curr.setElementImage("step01","32/step01on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step01","menuitemfocus")
      WHEN 2
         CALL gfrm_curr.setElementImage("step02","32/step02on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step02","menuitemfocus")
      WHEN 3
         CALL gfrm_curr.setElementImage("step03","32/step03on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step03","menuitemfocus")
      WHEN 4
         CALL gfrm_curr.setElementImage("step04","32/step04on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step04","menuitemfocus")
   END CASE

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
PRIVATE FUNCTION azzp510_set_vbox_visible(li_page)
   DEFINE li_page  LIKE type_t.num5

   #設定嵌入畫面的 顯示 與 隱藏
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)
   CALL cl_set_comp_visible("main_vbox03",FALSE)
   CALL cl_set_comp_visible("main_vbox04",FALSE)

   CASE li_page
      WHEN 1
         CALL cl_set_comp_visible("main_vbox01",TRUE)
      WHEN 2
         CALL cl_set_comp_visible("main_vbox02",TRUE)
      WHEN 3
         CALL cl_set_comp_visible("main_vbox03",TRUE)
      WHEN 4
         CALL cl_set_comp_visible("main_vbox04",TRUE)
   END CASE
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
PRIVATE FUNCTION azzp510_set_act_visible(li_page)
   DEFINE li_page  LIKE type_t.num5
   
   #設定下方的button的 顯示 與 隱藏
   CALL cl_set_comp_visible("save",FALSE)              #儲存底稿
   CALL cl_set_comp_visible("back_step",FALSE)         #上一步
   CALL cl_set_comp_visible("next_step",FALSE)         #下一步
   CALL cl_set_comp_visible("continue",FALSE)          #處理其他資料
   CALL cl_set_comp_visible("open_apmt500",FALSE)      #採購單維護
   CALL cl_set_comp_visible("out_apmt500",FALSE)       #採購單列印
   CALL cl_set_comp_visible("over",FALSE)              #結束

   CASE li_page
      WHEN 1
         CALL cl_set_comp_visible("save",TRUE)         #儲存底稿
         CALL cl_set_comp_visible("next_step",TRUE)    #下一步
      WHEN 2
         CALL cl_set_comp_visible("back_step",TRUE)    #上一步
         CALL cl_set_comp_visible("next_step",TRUE)    #下一步
      WHEN 3
         CALL cl_set_comp_visible("back_step",TRUE)    #上一步
         CALL cl_set_comp_visible("next_step",TRUE)    #下一步
      WHEN 4
         CALL cl_set_comp_visible("continue",TRUE)     #處理其他資料
         CALL cl_set_comp_visible("open_apmt500",TRUE) #採購單維護
         CALL cl_set_comp_visible("out_apmt500",TRUE)  #採購單列印
         CALL cl_set_comp_visible("over",TRUE)         #結束
   END CASE
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
PRIVATE FUNCTION azzp510_step1_query()
   DEFINE ls_sql   STRING
   DEFINE l_ac     LIKE type_t.num5

   #先清空陣列
   CALL g_step01.clear()
   
   LET ls_sql = " SELECT 'N',gzzz001,gzzal003,gzzz005 ",
                " FROM gzzz_t ",
                " LEFT JOIN gzzal_t ON gzzal001 = gzzz001 AND gzzal002 = ?",
                " WHERE ",gs_step1_wc, 
                " ORDER BY gzzz001 "

   PREPARE azzp510_step1_pre FROM ls_sql
   DECLARE azzp510_step1_cs CURSOR FOR azzp510_step1_pre
   LET l_ac = 1
   
   OPEN azzp510_step1_cs USING g_lang
   
   FOREACH azzp510_step1_cs INTO g_step01[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1  
   END FOREACH
   CALL g_step01.deleteElement(l_ac)

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
PRIVATE FUNCTION azzp510_step2_query()
   DEFINE ls_sql STRING
   DEFINE l_ac   INTEGER
   DEFINE l_idx  INTEGER
   DEFINE l_app  INTEGER
   
   LET ls_sql = " SELECT 'N',dzea001,dzeal003 FROM dzea_t ",
                " LEFT JOIN dzeal_t ON dzeal001 = dzea001 AND dzeal002 = ? ",
                " WHERE ",gs_step2_wc
   
   PREPARE azzp510_step2_pre FROM ls_sql
   DECLARE azzp510_step2_cs CURSOR FOR azzp510_step2_pre
   
   LET l_app = g_step02.getLength()
   LET l_ac  = l_app + 1
   
   OPEN azzp510_step2_cs USING g_lang
   
   FOREACH azzp510_step2_cs INTO g_step02[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      FOR l_idx = 1 TO l_app 
         IF g_step02[l_ac].dzea001 = g_step02[l_idx].dzea001 THEN
            CALL g_step02.deleteElement(l_ac)
            LET l_ac = l_ac - 1
            EXIT FOR            
         END IF
      END FOR
      LET l_ac = l_ac + 1  
   END FOREACH
   CALL g_step02.deleteElement(l_ac)
   

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
PRIVATE FUNCTION azzp510_step1_nextpage_chk()
   DEFINE li_status  LIKE type_t.num5
   DEFINE li_anyone  LIKE type_t.num5
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE ls_gzzz001 STRING
   DEFINE ls_sql     STRING
   DEFINE l_ac       LIKE type_t.num5
   DEFINE lc_gzdg001 LIKE gzdg_t.gzdg001
   DEFINE ls_temptabid STRING

   LET li_status = TRUE
   #如果 g_step01沒有值，或沒有被勾選,則回傳FALSE
   IF g_step01.getLength() = 0 THEN
      LET li_status = TRUE #FALSE
      RETURN li_status
   END IF

   LET li_anyone = FALSE
   LET ls_gzzz001 = ""
   FOR li_cnt = 1 TO g_step01.getLength()
      IF g_step01[li_cnt].chk = "Y" THEN
         LET li_anyone = TRUE
         LET ls_gzzz001 = ls_gzzz001,"'",g_step01[li_cnt].gzzz001 CLIPPED,"',"
      END IF
   END FOR

   IF NOT li_anyone THEN
      #沒有任何一筆被勾選
      LET li_status = TRUE #FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "azz-00350"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN li_status
   END IF

   IF ls_gzzz001.getLength() > 1 THEN
      LET ls_gzzz001 = ls_gzzz001.subString(1,ls_gzzz001.getLength()-1)
   END IF

   #以下用多層的temp table抓取需要資料
   LET ls_temptabid = FGL_GETPID()
   LET ls_temptabid = "azzp510_det_tmp",ls_temptabid.trim()
   LET ls_sql = "DROP TABLE ",ls_temptabid
   PREPARE drop_tmp_tab_det_tmp_tbl FROM ls_sql
   EXECUTE drop_tmp_tab_det_tmp_tbl

   LET ls_sql = "CREATE TABLE ",ls_temptabid," AS ",
                "SELECT gzdg002,gzdg001 FROM gzdg_t WHERE 1=2 "
   PREPARE create_tmp_tab_det_tmp_tbl FROM ls_sql
   EXECUTE create_tmp_tab_det_tmp_tbl
   FREE create_tmp_tab_det_tmp_tbl

   LET ls_sql = "INSERT INTO ",ls_temptabid," SELECT gzdg002,gzdg001 FROM gzdg_t ",
                " WHERE gzdg001 IN ( ", #選出子程式
                    "SELECT gzzl002 FROM gzzl_t ",
                    " WHERE substr(gzzl002,1,3) <> 'cl_' ",
                      " AND substr(gzzl002,1,2) <> 'q_' ",
                      " AND substr(gzzl002,1,2) <> 'n_' ",
                      " AND gzzl001 IN ( ", #選出主程式
                       "SELECT gzzz002 FROM gzzz_t WHERE gzzz001 IN ( ", #選出作業
                            ls_gzzz001.trim()," ) ) ) ORDER BY gzdg002 "

   PREPARE insert_tmp_tab_det_tmp_tbl FROM ls_sql
   EXECUTE insert_tmp_tab_det_tmp_tbl
   FREE insert_tmp_tab_det_tmp_tbl

   LET ls_sql = "SELECT 'N',gzdg002,'','','','' FROM ",ls_temptabid," GROUP BY gzdg002 ORDER BY gzdg002"
   PREPARE azzp510_step1nxt_pre FROM ls_sql
   DECLARE azzp510_step1nxt_cs CURSOR FOR azzp510_step1nxt_pre

   LET ls_sql = "SELECT gzdg001 FROM ",ls_temptabid," WHERE gzdg002 = ? "
   PREPARE azzp510_step1_catch_gzdg001_pre FROM ls_sql
   DECLARE azzp510_step1_catch_gzdg001_cs CURSOR FOR azzp510_step1_catch_gzdg001_pre

   LET l_ac = 1
   FOREACH azzp510_step1nxt_cs INTO g_step02[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      WHILE TRUE
         FOREACH azzp510_step1_catch_gzdg001_cs USING g_step02[l_ac].dzea001 INTO lc_gzdg001
            IF g_step02[l_ac].gzza001 IS NULL THEN
               LET g_step02[l_ac].gzde001 = lc_gzdg001 CLIPPED
               IF g_step02[l_ac].gzde001 IS NOT NULL THEN
                  EXIT WHILE
               END IF
            END IF
         END FOREACH
         EXIT WHILE
      END WHILE

      #抓程式名稱
      CALL azzp510_step2_get_gzza001(g_step02[l_ac].gzde001,ls_gzzz001)
      RETURNING g_step02[l_ac].gzza001,g_step02[l_ac].gzza001_desc

      #抓表格名稱
      SELECT dzeal003 INTO g_step02[l_ac].dzea001_desc
        FROM dzeal_t
       WHERE dzeal001 = g_step02[l_ac].dzea001
         AND dzeal002 = g_lang
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_step02.deleteElement(l_ac)

   EXECUTE drop_tmp_tab_det_tmp_tbl
   FREE drop_tmp_tab_det_tmp_tbl

   RETURN li_status

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
PRIVATE FUNCTION azzp510_step2_get_gzza001(lc_gzde001,ls_gzzz001)
   DEFINE ls_sql      STRING
   DEFINE ls_gzzz001  STRING
   DEFINE lc_gzde001  LIKE gzde_t.gzde001
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzzal003 LIKE gzzal_t.gzzal003
   
   LET ls_sql = "SELECT gzzl001 FROM gzzl_t ",
                " WHERE gzzl002 = '",lc_gzde001 CLIPPED,"' ",
                  " AND gzzl001 IN ( ", #選出主程式
                   "SELECT gzzz002 FROM gzzz_t WHERE gzzz001 IN ( ", #選出作業
                            ls_gzzz001.trim()," ) ) "

   PREPARE azzp510_step2gzza001_pre FROM ls_sql
   DECLARE azzp510_step2gzza001_cs CURSOR FOR azzp510_step2gzza001_pre
   
   FOREACH azzp510_step2gzza001_cs INTO lc_gzza001
      IF lc_gzza001 IS NOT NULL AND lc_gzza001 <> " " THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   IF lc_gzza001 IS NOT NULL THEN
      SELECT gzzal003 INTO lc_gzzal003 FROM gzzal_t
       WHERE gzzal001 = lc_gzza001
         AND gzzal002 = g_lang
   END IF
   FREE azzp510_step2gzza001_cs
   RETURN lc_gzza001,lc_gzzal003
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
PRIVATE FUNCTION azzp510_step2_nextpage_chk()
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_idx2 LIKE type_t.num10
   DEFINE li_idx3 LIKE type_t.num10
   DEFINE ls_tbl  STRING
   DEFINE ls_ent  LIKE type_t.chr50

   LET li_idx2 = 1
   LET li_idx3 = 1
   
   CALL g_step03.clear()
   CALL g_step03_2.clear()

   #檢查表格是否有ent
   FOR li_idx = 1 TO g_step02.getLength()
      IF g_step02[li_idx].chk = "Y" THEN
         LET li_cnt = 0
         LET ls_tbl = g_step02[li_idx].dzea001
         LET ls_ent = ls_tbl.subString(1,ls_tbl.getIndexOf('_',1)-1), "ent"
         SELECT COUNT(*) INTO li_cnt FROM gztz_t 
          WHERE gztz001 = g_step02[li_idx].dzea001
            AND gztz002 = ls_ent
         IF li_cnt = 0 THEN
            #無ent
            LET g_step03[li_idx3].dzea001      = g_step02[li_idx].dzea001 
            LET g_step03[li_idx3].dzea001_desc = g_step02[li_idx].dzea001_desc 
            LET g_step03[li_idx3].reason       = "此表格不含enterprise!"
            LET li_idx3 = li_idx3 + 1
         ELSE
            #有ent
            LET g_step03_2[li_idx2].dzea001      = g_step02[li_idx].dzea001 
            LET g_step03_2[li_idx2].dzea001_desc = g_step02[li_idx].dzea001_desc 
            LET g_step03_2[li_idx2].reason       = "可匯出!"
            LET li_idx2 = li_idx2 + 1
         END IF
      END IF
   END FOR
   
   IF g_step03_2.getLength() > 0 THEN
      RETURN TRUE
   ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
      IF g_step03.getLength() = 0 THEN
         #無選取表格
         LET g_errparam.code   = "azz-00351"
      ELSE
         #選取的表格無ent
         LET g_errparam.code   = "azz-00349"
      END IF
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
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
PRIVATE FUNCTION azzp510_step4_load()
   DEFINE ls_tbl_tmp    STRING
   DEFINE ls_file       STRING
   DEFINE ls_tbl        STRING
   DEFINE ls_ent        STRING
   DEFINE lb_chk        BOOLEAN
   DEFINE ls_sql        STRING
   DEFINE ls_msg        STRING
   DEFINE ls_cmd        STRING
   DEFINE li_idx        LIKE type_t.num10
   DEFINE ls_field      STRING
   DEFINE lr_gzou       RECORD
          gzou001       LIKE gzou_t.gzou001, #企業代碼
          gzou003       LIKE gzou_t.gzou003  #資料庫名稱
          END RECORD
   DEFINE lr_gzda       RECORD
          gzda001       LIKE gzda_t.gzda001, #資料庫名稱
          gzda004       LIKE gzda_t.gzda004  #資料庫密碼
          END RECORD
   DEFINE lchannel_read  base.Channel

   DEFINE ls_title      STRING
      
   CALL s_transaction_begin()

   #先確認對應DB
   SELECT gzou003 INTO lr_gzda.gzda001 FROM gzou_t
    WHERE gzou001 = g_impent
    
   #撈取DB密碼
   #SELECT gzda004 INTO lr_gzda.gzda004 FROM gzda_t
   # WHERE gzda001 = lr_gzda.gzda001
    
   #解密
   #LET lr_gzda.gzda004 = cl_hashkey_base65_anti(lr_gzda.gzda004)
   
   #轉換到對應資料庫
   #CONNECT TO lr_gzda.gzda001 USER lr_gzda.gzda001 USING lr_gzda.gzda004

   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'azz-00369'
   LET g_errparam.replace[1] = g_enterprise
   LET g_errparam.replace[2] = lr_gzda.gzda001
   LET g_errparam.type = 2
   LET g_errparam.popup = TRUE
   CALL cl_err()

   #先命名temp table名稱
   LET ls_tbl_tmp = "azzp510_",FGL_GETPID() USING "<<<<<<<<<<"

   LET lb_chk = TRUE

   #逐表讀取/寫入
   FOR li_idx = 1 TO g_step04.getLength()

      #DELETE TEMP TABLE
      LET ls_sql = "DROP TABLE ",ls_tbl_tmp
      PREPARE del_tbl2 FROM ls_sql
      EXECUTE del_tbl2
      FREE del_tbl2
   
      #CREATE TEMP TABLE
      LET ls_tbl = g_step04[li_idx].dzea001
      LET ls_sql = "CREATE TABLE ",ls_tbl_tmp," AS ",
                   "SELECT * FROM ",ls_tbl," WHERE 1=2"
      PREPARE repro_tbl FROM ls_sql
      EXECUTE repro_tbl
      FREE repro_tbl
      
      #讀取sch取得欄位
      TRY
         LET lchannel_read = base.Channel.create()
         CALL lchannel_read.setDelimiter("")
         LET ls_file = g_imppath,'/',ls_tbl,".txt.sch"
         CALL lchannel_read.openFile(ls_file CLIPPED, "r" )
         LET ls_field = lchannel_read.readLine()
      CATCH
         DISPLAY 'INFO:無sch檔案, 採用全欄位模式!'
      END TRY
    
      #匯入
      LET ls_file = g_imppath,'/',ls_tbl,".txt"
      IF NOT cl_null(ls_field) THEN
         LET ls_sql = "INSERT INTO ",ls_tbl_tmp," (",ls_field,")"
      ELSE
         LET ls_sql = "INSERT INTO ",ls_tbl_tmp
      END IF
      
      LOAD FROM ls_file ls_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ls_tbl
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET lb_chk = FALSE
         #準備指定的問句
         LET ls_msg = cl_getmsg("azz-00510",g_lang)
         LET ls_title = cl_getmsg("azz-00510",g_lang)
         
         #執行開窗詢問
         IF NOT cl_ask_type1(ls_msg,ls_title) THEN
            LET lb_chk = FALSE
            EXIT FOR
         END IF
      END IF
      
      #LET ls_cmd = "cd ",g_imppath,"; "
      #            ,"export FGLSQLDEBUG=9; "
      #            ," load ",lr_gzda.gzda001," "
      #            ," ",lr_gzda.gzda004," "
      #            ," ",ls_tbl_tmp," "
      #            ," ",ls_tbl,".txt 2>&1 "
      #DISPLAY ls_cmd
      #CALL azzp510_cmdrun(ls_cmd) RETURNING lb_chk
      #IF lb_chk = FALSE THEN
      #   EXIT FOR
      #END IF

      
      #更新ent
      LET ls_ent = ls_tbl.subString(1,ls_tbl.getIndexOf("_",1)-1),'ent'
      LET ls_sql = "UPDATE ",ls_tbl_tmp," SET ",ls_ent," = ? "
      PREPARE upd_tbl FROM ls_sql
      EXECUTE upd_tbl USING g_impent
      FREE upd_tbl
      
      #寫回實際表中
      LET ls_sql = "INSERT /*+ APPEND */ INTO ",lr_gzda.gzda001,".",ls_tbl," SELECT * FROM ",ls_tbl_tmp
      PREPARE ins_tbl FROM ls_sql
      EXECUTE ins_tbl
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ls_tbl
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         #準備指定的問句
         LET ls_msg = cl_getmsg("azz-00510",g_lang)
         LET ls_title = cl_getmsg("azz-00510",g_lang)
         
         #執行開窗詢問
         IF NOT cl_ask_type1(ls_msg,ls_title) THEN
            LET lb_chk = FALSE
            EXIT FOR
         END IF
      END IF
      FREE ins_tbl
      
      #DELETE TEMP TABLE
      LET ls_sql = "DROP TABLE ",ls_tbl_tmp
      PREPARE del_tbl FROM ls_sql
      EXECUTE del_tbl
      FREE del_tbl
	  
   END FOR
   
   #確認是否有出錯, 決定寫入或返回
   IF lb_chk THEN
      CALL s_transaction_end('Y','0')
      RETURN TRUE
   ELSE
      CALL s_transaction_end('N','0')
      RETURN FALSE
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
PRIVATE FUNCTION azzp510_cmdrun(ps_cmd)
   DEFINE ps_cmd       STRING
   DEFINE l_chk        BOOLEAN        #是否執行成功
   DEFINE l_ch         base.Channel
   DEFINE l_buf        STRING
   DEFINE l_err        STRING

   LET l_chk = TRUE
   LET l_ch = base.Channel.create()
   CALL l_ch.setDelimiter("")
   CALL l_ch.openPipe(ps_cmd,"r")   #執行指令
   DISPLAY ps_cmd
   WHILE TRUE
      CALL l_ch.readLine() RETURNING l_buf
      IF l_ch.isEof() THEN
         EXIT WHILE
      END IF

      #有錯誤訊息
      IF l_buf.getIndexOf("sqlcode",1) THEN
         LET l_buf = cl_str_replace(l_buf,' ','')
         IF l_buf.getIndexOf("sqlcode:0",1) > 0 THEN
            LET l_chk = TRUE
         ELSE
            LET l_chk = FALSE
            LET l_err = l_buf.subString(l_buf.getIndexOf(":",1)+1,l_buf.getLength())
            INITIALIZE g_errparam TO NULL
            #LET g_errparam.extend = l_buf
            LET g_errparam.code   = l_err
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_chk = FALSE
         END IF
      END IF
   END WHILE
   CALL l_ch.close()
   
   RETURN l_chk
   
END FUNCTION

#end add-point
 
{</section>}
 
