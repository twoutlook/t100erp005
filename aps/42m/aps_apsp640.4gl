#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp640.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-10-08 16:38:30), PR版次:0008(2016-12-02 19:19:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000168
#+ Filename...: apsp640
#+ Description: 採購變更整批調整作業
#+ Creator....: 04441(2014-05-08 10:37:28)
#+ Modifier...: 04441 -SD/PR- 08171
 
{</section>}
 
{<section id="apsp640.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151209-00022#5     2015/12/16 By earl     新增二次篩選功能
#160318-00025#50    2016/04/27 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160608-00013#3     2016/06/21 By ming     執行process時，先檢查有無新版本，有的話，跳出錯誤訊息「該APS版本：%1已有新一版本資料，請重新查詢後再進行處理」
#161109-00085#15    2016/11/15 By 08993    整批調整系統星號寫法
#161109-00085#61    2016/11/29 By 08171    整批調整系統星號寫法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
       sel               LIKE type_t.chr1,      #選擇
       pmdodocno         LIKE pmdo_t.pmdodocno, #採購單號
       pmdoseq           LIKE pmdo_t.pmdoseq,   #項次
       pmdoseq1          LIKE pmdo_t.pmdoseq1,  #項序
       pmdoseq2          LIKE pmdo_t.pmdoseq2,  #分批序
       pspc050           LIKE pspc_t.pspc050,   #料件編號
       pspc050_desc      LIKE type_t.chr80,     #品名
       pspc050_desc_desc LIKE type_t.chr80,     #規格
       pspc051           LIKE pspc_t.pspc051,   #產品特徵
       imaa009           LIKE imaa_t.imaa009,   #產品分類
       imaa009_desc      LIKE type_t.chr80,     #說明
       imaf141           LIKE imaf_t.imaf141,   #採購分類
       imaf141_desc      LIKE type_t.chr80,     #說明
       imaa006           LIKE imaa_t.imaa006,   #單位
       imaa006_desc      LIKE type_t.chr80,     #說明
       pmdo006           LIKE pmdo_t.pmdo006,   #原採購量
       pspc034           LIKE pspc_t.pspc034,   #建議量
       pmdo019           LIKE pmdo_t.pmdo019,   #已入庫量
       pmdo013           LIKE pmdo_t.pmdo013,   #原到廠日
       pspc045           LIKE pspc_t.pspc045,   #建議到廠日
       imaf142           LIKE imaf_t.imaf142,   #採購員
       imaf142_desc      LIKE type_t.chr80,     #全名
       imae012           LIKE imae_t.imae012,   #計畫員
       imae012_desc      LIKE type_t.chr80,     #全名
       pspc054           LIKE pspc_t.pspc054,   #已產生單據
       pspc055           LIKE pspc_t.pspc055,   #產生單號
       pspc056           LIKE pspc_t.pspc056,   #項次
       pspc001           LIKE pspc_t.pspc001,   #APS版本
       pspc002           LIKE pspc_t.pspc002,   #執行日期時間
       pspc004           LIKE pspc_t.pspc004    #APS虛擬單號
                     END RECORD
TYPE type_g_detail2_d RECORD
       pspa004           LIKE pspa_t.pspa004,   #供需日期
       pspa020           LIKE pspa_t.pspa020,   #類別
       pspa006           LIKE pspa_t.pspa006,   #單號
       pspa009           LIKE pspa_t.pspa009,   #供需數量
       count             LIKE pspa_t.pspa009    #預計結存
                     END RECORD
DEFINE g_detail_d_t    type_g_detail_d
DEFINE g_detail2_d     DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_d_t   type_g_detail2_d
DEFINE tm            RECORD
       wc1               STRING,                #QBE
       pspc001           LIKE pspc_t.pspc001,   #APS版本
       chk               LIKE type_t.chr1       #顯示已變更資料
                     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail2_idx        LIKE type_t.num5
DEFINE l_allow_insert       LIKE type_t.num5              #可新增否 
DEFINE l_allow_delete       LIKE type_t.num5              #可刪除否
DEFINE g_detail2_cnt        LIKE type_t.num5             #單身
DEFINE g_ooef008            LIKE ooef_t.ooef008
DEFINE g_ooef009            LIKE ooef_t.ooef009

#end add-point
 
{</section>}
 
{<section id="apsp640.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp640 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp640_init()   
 
      #進入選單 Menu (="N")
      CALL apsp640_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp640
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apsp640_tmp

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp640.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp640_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   LET g_errshow = 1
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   CALL cl_set_combo_scc('b_pspa020','5440')
   LET tm.chk  = 'N'
   LET g_detail_idx  = 1
   LET g_detail2_idx = 1

   CREATE TEMP TABLE apsp640_tmp(
       pmdodocno          VARCHAR(20),      #採購單號
       pmdoseq            INTEGER,        #項次
       pmdoseq1           INTEGER,       #項序
       pmdoseq2           INTEGER,       #分批序
       pspc050            VARCHAR(40),        #料件編號
       pspc034            DECIMAL(20,6),        #建議量
       pspc045            DATE,        #建議到廠日
       pspc001            VARCHAR(10),        #APS版本
       pspc002            VARCHAR(20),        #執行日期時間
       pspc004            VARCHAR(40)     #APS虛擬單號
   )
   
   LET g_ooef008 = ''
   LET g_ooef009 = ''
   SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp640.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp640_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_imaa009  LIKE imaa_t.imaa009
   DEFINE l_imaf141  LIKE imaf_t.imaf141
   DEFINE l_imaf142  LIKE imaf_t.imaf142
   DEFINE l_imae012  LIKE imae_t.imae012
   DEFINE l_pspc034  LIKE pspc_t.pspc034
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_detail2_cnt = g_detail2_d.getLength()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apsp640_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME tm.wc1 ON imae012,imaf142,pmdo013,pspc045,imaa009,imaf141,pspc050
	   
            BEFORE CONSTRUCT

            AFTER FIELD pmdo013                  #原到庫日
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)

            AFTER FIELD pspc045                  #建議到庫日期
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)

            ON ACTION controlp INFIELD imae012   #計畫員
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO imae012
               NEXT FIELD imae012

            ON ACTION controlp INFIELD imaf142   #採購員
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO imaf142
               NEXT FIELD imaf142

            ON ACTION controlp INFIELD imaa009   #產品分類
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009

            ON ACTION controlp INFIELD imaf141   #採購分類
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imce141()
               DISPLAY g_qryparam.return1 TO imaf141
               NEXT FIELD imaf141

            ON ACTION controlp INFIELD pspc050   #料件編號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO pspc050
               NEXT FIELD pspc050

         END CONSTRUCT

         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.pspc001,tm.chk
            ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT

            AFTER FIELD pspc001
               IF cl_null(tm.pspc001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00052'
                  LET g_errparam.extend = tm.pspc001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = tm.pspc001
                  LET g_errshow = TRUE   #160318-00025#50
                  LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"    #160318-00025#50
                  IF NOT cl_chk_exist("v_psca001") THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL apsp640_pspc001_ref()

            ON ACTION controlp INFIELD pspc001   #APS版本
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.pspc001
               LET g_qryparam.where = "pscasite = '",g_site,"'"
               CALL q_psca001()
               LET tm.pspc001 = g_qryparam.return1
               DISPLAY tm.pspc001 TO pspc001
               CALL apsp640_pspc001_ref()
               NEXT FIELD pspc001
         
            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT

         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                    INSERT ROW = FALSE,
                    DELETE ROW = FALSE,
                    APPEND ROW = FALSE)
            
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               CALL apsp640_fetch()
            
            ON CHANGE b_sel
               IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                  IF g_detail_d[g_detail_idx].pspc054 = 'Y' THEN
                     CALL cl_ask_pressanykey('aps-00109')
                     LET g_detail_d[g_detail_idx].sel = 'N'
                  END IF
                  IF g_detail_d[g_detail_idx].pspc034 < apsp640_count() THEN
                     CALL cl_ask_pressanykey('aps-00124')
                     LET g_detail_d[g_detail_idx].sel = 'N'
                  END IF
                  IF NOT apsp640_chk() THEN
                     CALL cl_ask_pressanykey('apm-00396')
                     LET g_detail_d[g_detail_idx].sel = 'N'
                  END IF
               END IF
               
 
            AFTER ROW
 
            AFTER INPUT
 
         END INPUT

         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail2_cnt)
            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail2_idx)
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].pspc054 = 'Y' THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               IF g_detail_d[li_idx].pspc034 < apsp640_count() THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               IF NOT apsp640_chk() THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].pspc054 = 'Y' THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               IF g_detail_d[li_idx].pspc034 < apsp640_count() THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               IF NOT apsp640_chk() THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apsp640_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL apsp640_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #151209-00022#5     2015/12/16 By earl  add s
            LET g_wc_filter = '1=1'
            CALL apsp640_b_fill()
            #151209-00022#5     2015/12/16 By earl  add e
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp640_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            DELETE FROM apsp640_tmp
            LET l_cnt = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = 'Y' THEN
                  LET l_cnt = l_cnt + 1
                  INSERT INTO apsp640_tmp VALUES(g_detail_d[li_idx].pmdodocno, #採購單號
                                                 g_detail_d[li_idx].pmdoseq,   #項次
                                                 g_detail_d[li_idx].pmdoseq1,  #項序
                                                 g_detail_d[li_idx].pmdoseq2,  #分批序
                                                 g_detail_d[li_idx].pspc050,   #料件編號
                                                 g_detail_d[li_idx].pspc034,   #建議量
                                                 g_detail_d[li_idx].pspc045,   #建議到廠日
                                                 g_detail_d[li_idx].pspc001,   #APS版本
                                                 g_detail_d[li_idx].pspc002,   #執行日期時間
                                                 g_detail_d[li_idx].pspc004)   #APS虛擬單號
               END IF
            END FOR
            IF l_cnt = 0 THEN
               CALL cl_ask_pressanykey('-400')
            ELSE
               CALL apsp640_batch_execute()
               CALL apsp640_b_fill()
            END IF

         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp640.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp640_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL apsp640_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp640.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp640_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_imaa006       LIKE imaa_t.imaa006
   DEFINE l_pmdo004       LIKE pmdo_t.pmdo004
   DEFINE ls_tmp          STRING
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_n1            LIKE type_t.num5
   DEFINE l_pspc002       LIKE pspc_t.pspc002
   DEFINE l_doclen        LIKE ooaa_t.ooaa002
   DEFINE l_imaf174       LIKE imaf_t.imaf174

   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET ls_wc = ""
   IF NOT cl_null(tm.pspc001) THEN
      LET ls_wc = ls_wc CLIPPED," AND pspc001 = '",tm.pspc001,"' "
   END IF

   IF tm.chk = 'N' THEN
      LET ls_wc = ls_wc CLIPPED," AND (pspc054 = 'N' OR pspc054 IS NULL) "
   END IF

   IF cl_null(tm.wc1) THEN
      LET tm.wc1 = '1=1'
   END IF

   #151209-00022#5     2015/12/16 By earl  add s
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = '1=1'
   END IF
   #151209-00022#5     2015/12/16 By earl  add e

   LET l_pspc002 = ''
   SELECT MAX(pspc002) INTO l_pspc002 FROM pspc_t
    WHERE pspcent = g_enterprise AND pspcsite = g_site AND pspc001 = tm.pspc001

   #取得單據流水號總長度(aoos010)
   LET l_doclen = cl_get_para(g_enterprise,g_site,'E-COM-0005')

   LET g_sql = " SELECT 'N',pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pspc050,'','',pspc051,",
               "        imaa009,'',imaf141,'',pspc014,'',pmdo006,pspc034,pmdo019,pmdo013,pspc045, ",
               "        imaf142,'',imae012,'',pspc054,pspc055,pspc056,pspc001,pspc002,pspc004 ",
               "   FROM pmdo_t,pspc_t ",
               "        LEFT OUTER JOIN imae_t ON imaeent = '",g_enterprise,"' AND imaesite = '",g_site,"' AND imae001 = pspc050 ",
               "        LEFT OUTER JOIN imaf_t ON imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf001 = pspc050 ",
               "        LEFT OUTER JOIN imaa_t ON imaaent = '",g_enterprise,"' AND imaa001 = pspc050 ",
               "  WHERE pmdoent = '",g_enterprise,"' AND pmdodocno = SUBSTR(pspc004,1,",l_doclen,") ",
               "    AND pmdoseq = SUBSTR(pspc004,",l_doclen,"+2,INSTR(pspc004,'-',",l_doclen,"+2,1)-",l_doclen,"-2) ",
               "    AND pmdoseq1= SUBSTR(pspc004,INSTR(pspc004,'-',",l_doclen,"+2,1)+1,INSTR(pspc004,'-',",l_doclen,"+2,2)-INSTR(pspc004,'-',",l_doclen,"+2,1)-1) ",
               "    AND pmdoseq2= SUBSTR(pspc004,INSTR(pspc004,'-',",l_doclen,"+2,2)+1,LENGTH(pspc004)) ",
               "    AND INSTR(pspc004,'-',",l_doclen,"+2,3) = 0 ",
               "    AND pspcent = ? AND pspcsite = '",g_site,"' AND pspc002 = '",l_pspc002,"' AND pspc007 = '0' ",ls_wc,
               "    AND ",tm.wc1 CLIPPED,
               "    AND ",g_wc_filter CLIPPED,   #151209-00022#5     2015/12/16 By earl  add
               "  ORDER BY pspc004 "

   #end add-point
 
   PREPARE apsp640_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp640_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
       g_detail_d[l_ac].sel,g_detail_d[l_ac].pmdodocno,g_detail_d[l_ac].pmdoseq,g_detail_d[l_ac].pmdoseq1,
       g_detail_d[l_ac].pmdoseq2,g_detail_d[l_ac].pspc050,g_detail_d[l_ac].pspc050_desc,g_detail_d[l_ac].pspc050_desc_desc,
       g_detail_d[l_ac].pspc051,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,g_detail_d[l_ac].imaf141,
       g_detail_d[l_ac].imaf141_desc,g_detail_d[l_ac].imaa006,g_detail_d[l_ac].imaa006_desc,g_detail_d[l_ac].pmdo006,
       g_detail_d[l_ac].pspc034,g_detail_d[l_ac].pmdo019,g_detail_d[l_ac].pmdo013,g_detail_d[l_ac].pspc045,
       g_detail_d[l_ac].imaf142,g_detail_d[l_ac].imaf142_desc,g_detail_d[l_ac].imae012,g_detail_d[l_ac].imae012_desc,
       g_detail_d[l_ac].pspc054,g_detail_d[l_ac].pspc055,g_detail_d[l_ac].pspc056,g_detail_d[l_ac].pspc001,
       g_detail_d[l_ac].pspc002,g_detail_d[l_ac].pspc004
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"

      #LET ls_tmp = g_detail_d[l_ac].pspc004
      #LET g_detail_d[l_ac].pmdodocno = ls_tmp.subString(1,ls_tmp.getIndexOf('-',1)-1)
      #LET l_n = ls_tmp.getIndexOf('-',1)+1
      #LET l_n1 = ls_tmp.getIndexOf('-',l_n)-1
      #LET g_detail_d[l_ac].pmdoseq = ls_tmp.subString(l_n,l_n1)
      #LET l_n = ls_tmp.getIndexOf('-',l_n)+1
      #LET l_n1 = ls_tmp.getIndexOf('-',l_n)-1
      #LET g_detail_d[l_ac].pmdoseq1 = ls_tmp.subString(l_n,l_n1)
      #LET l_n = ls_tmp.getIndexOf('-',l_n)+1
      #LET l_n1 = ls_tmp.getLength()
      #LET g_detail_d[l_ac].pmdoseq2 = ls_tmp.subString(l_n,l_n1)

      #存在採購單檢查
      LET l_n = ''
      SELECT COUNT(*) INTO l_n
        FROM pmdl_t
       WHERE pmdlent = g_enterprise
         AND pmdlsite = g_site
         AND pmdldocno = g_detail_d[l_ac].pmdodocno
         AND pmdlstus = 'Y'
      IF cl_null(l_n) OR l_n = 0 THEN 
         CONTINUE FOREACH
      END IF

      #建議到庫日與原預計到庫日不同，或是建議量與原採購量不時的資料才顯示
      IF g_detail_d[l_ac].pmdo013 = g_detail_d[l_ac].pspc045 AND 
         g_detail_d[l_ac].pmdo006 = g_detail_d[l_ac].pspc034 THEN
         CONTINUE FOREACH
      END IF

#      LET l_imaa006 = ''
#      SELECT imaa006 INTO l_imaa006
#        FROM imaa_t
#       WHERE imaaent = g_enterprise
#         AND imaa001 = g_detail_d[l_ac].pspc050

      LET l_pmdo004 = ''
      SELECT pmdo004 INTO l_pmdo004
        FROM pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdosite = g_site
         AND pmdodocno = g_detail_d[l_ac].pmdodocno
         AND pmdoseq = g_detail_d[l_ac].pmdoseq
         AND pmdoseq1 = g_detail_d[l_ac].pmdoseq1
         AND pmdoseq2 = g_detail_d[l_ac].pmdoseq2

      IF NOT cl_null(g_detail_d[l_ac].pspc050) AND NOT cl_null(g_detail_d[l_ac].imaa006) AND
         NOT cl_null(l_pmdo004) AND NOT cl_null(g_detail_d[l_ac].pspc034) THEN
         CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,g_detail_d[l_ac].imaa006,l_pmdo004,g_detail_d[l_ac].pspc034)
              RETURNING l_success,g_detail_d[l_ac].pspc034
      END IF
      LET g_detail_d[l_ac].imaa006 = l_pmdo004

#      CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,g_detail_d[l_ac].imaa006,l_imaa006,g_detail_d[l_ac].pspc034)
#           RETURNING l_success,g_detail_d[l_ac].pspc034
#      CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,l_pmdo004,l_imaa006,g_detail_d[l_ac].pmdo006)
#           RETURNING l_success,g_detail_d[l_ac].pmdo006
#      CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,l_pmdo004,l_imaa006,g_detail_d[l_ac].pmdo019)
#           RETURNING l_success,g_detail_d[l_ac].pmdo019
#      LET g_detail_d[l_ac].imaa006 = l_imaa006

#      LET l_imaf174 = ''
#      SELECT (imaf171+imaf172+imaf173+imaf174) INTO l_imaf174
#        FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = g_detail_d[l_ac].pspc050
#      CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_detail_d[l_ac].pspc045,0,l_imaf174)
#           RETURNING g_detail_d[l_ac].pspc045

      #end add-point
      
      CALL apsp640_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apsp640_sel
   
   LET l_ac = 1
   CALL apsp640_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp640.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp640_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   
   CALL g_detail2_d.clear()

   LET g_sql = " SELECT UNIQUE pspa004,pspa020,pspa006,(pspa009*gzcb003),'' ",    
               "   FROM pspa_t LEFT OUTER JOIN gzcb_t ON gzcb001 = '5440' AND gzcb002 = pspa020 ",
               "  WHERE pspaent=? AND pspasite=? AND pspa001=? AND pspa002=? AND pspa012=? AND NVL(pspa013,' ')=NVL(?,' ') ",
               "  ORDER BY pspa004 "
 
   PREPARE apsp600_sel2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apsp600_sel2
   
   OPEN b_fill_curs2 USING g_enterprise,g_site,g_detail_d[g_detail_idx].pspc001,g_detail_d[g_detail_idx].pspc002,
                           g_detail_d[g_detail_idx].pspc050,g_detail_d[g_detail_idx].pspc051
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_detail2_d[l_ac].pspa004,g_detail2_d[l_ac].pspa020,
                             g_detail2_d[l_ac].pspa006,g_detail2_d[l_ac].pspa009,
                             g_detail2_d[l_ac].count
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF l_ac = 1 THEN
         LET g_detail2_d[l_ac].count = g_detail2_d[l_ac].pspa009
      ELSE
         LET g_detail2_d[l_ac].count = g_detail2_d[l_ac-1].count + g_detail2_d[l_ac].pspa009
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
 
 
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())   

   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsp640.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp640_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
 
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"

      #料號說明
      CALL s_desc_get_item_desc(g_detail_d[l_ac].pspc050) RETURNING g_detail_d[l_ac].pspc050_desc,g_detail_d[l_ac].pspc050_desc_desc

      #產品分類
      CALL s_desc_get_rtaxl003_desc(g_detail_d[l_ac].imaa009) RETURNING g_detail_d[l_ac].imaa009_desc

      #採購分類
      CALL s_desc_get_acc_desc('203',g_detail_d[l_ac].imaf141) RETURNING g_detail_d[l_ac].imaf141_desc

      #單位
      CALL s_desc_get_unit_desc(g_detail_d[l_ac].imaa006) RETURNING g_detail_d[l_ac].imaa006_desc

      #採購員
      CALL s_desc_get_person_desc(g_detail_d[l_ac].imaf142) RETURNING g_detail_d[l_ac].imaf142_desc

      #計畫員
      CALL s_desc_get_person_desc(g_detail_d[l_ac].imae012) RETURNING g_detail_d[l_ac].imae012_desc

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp640.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp640_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
{
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
}
   LET g_detail2_cnt = 1
   
   #151209-00022#5     2015/12/16 By earl  add s
   LET INT_FLAG = 0
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #add-point:ui_dialog段construct
      CONSTRUCT g_wc_filter ON pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,
	                            pspc050,pspc051,
                               imaa009,imaf141,
                               pmdo004,pmdo006,pspc034,pmdo019,pmdo013,
                               pspc045,
                               imaf142,imae012,pspc054
           FROM s_detail1[1].b_pmdodocno,s_detail1[1].b_pmdoseq,s_detail1[1].b_pmdoseq1,s_detail1[1].b_pmdoseq2,
                s_detail1[1].b_pspc050,s_detail1[1].b_pspc051,
                s_detail1[1].b_imaa009,s_detail1[1].b_imaf141,
                s_detail1[1].b_imaa006,s_detail1[1].b_pmdo006,s_detail1[1].b_pspc034,s_detail1[1].b_pmdo019,s_detail1[1].b_pmdo013,
                s_detail1[1].b_pspc045,
                s_detail1[1].b_imaf142,s_detail1[1].b_imae012,s_detail1[1].b_pspc054
	
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD b_pmdodocno  #採購單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdodocno  #顯示到畫面上
            NEXT FIELD b_pmdodocno                     #返回原欄位
            
         ON ACTION controlp INFIELD b_pspc050  #料件編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()
            DISPLAY g_qryparam.return1 TO b_pspc050
            NEXT FIELD b_pspc050
         
         ON ACTION controlp INFIELD b_imaa009  #產品分類
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO b_imaa009
            NEXT FIELD b_imaa009
         
         ON ACTION controlp INFIELD b_imaf141  #採購分類
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imce141()
            DISPLAY g_qryparam.return1 TO b_imaf141
            NEXT FIELD b_imaf141
            
         ON ACTION controlp INFIELD b_imaa006  #單位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()
            DISPLAY g_qryparam.return1 TO b_imaa006
            NEXT FIELD b_imaa006
         
         ON ACTION controlp INFIELD b_imaf142  #採購員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_imaf142
            NEXT FIELD b_imaf142
            
         ON ACTION controlp INFIELD b_imae012  #計畫員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_imae012
            NEXT FIELD b_imae012
         
      END CONSTRUCT
      
      BEFORE DIALOG
    
         ON ACTION accept
            ACCEPT DIALOG
         
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG
    
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      
   END DIALOG
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   #151209-00022#5     2015/12/16 By earl  add e
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp640_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp640.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp640_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="apsp640.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp640_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = apsp640_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp640.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 轉變更
# Memo...........:
# Usage..........: CALL apsp640_batch_execute()
# Input parameter: no
# Return code....: no
# Date & Author..: 140512 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_batch_execute()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE la_param  RECORD
    prog     STRING,
    param    DYNAMIC ARRAY OF STRING
             END RECORD
DEFINE l_success      LIKE type_t.num5
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_pmdodocno    LIKE pmdo_t.pmdodocno
DEFINE l_pmee  RECORD  #採購變更單頭檔
    pmeeent	   LIKE pmee_t.pmeeent,    #企業編號
    pmeesite   LIKE pmee_t.pmeesite,   #營運據點
    pmeedocno  LIKE pmee_t.pmeedocno,  #採購變更單號
    pmeedocdt  LIKE pmee_t.pmeedocdt,  #採購變更日期
    pmee001	   LIKE pmee_t.pmee001,	   #版次
    pmee002	   LIKE pmee_t.pmee002,	   #採購人員
    pmee003	   LIKE pmee_t.pmee003,	   #採購部門
    pmee004	   LIKE pmee_t.pmee004,	   #供應商編號
    pmee005	   LIKE pmee_t.pmee005,	   #採購性質
    pmee006	   LIKE pmee_t.pmee006,	   #多角性質
    pmee007	   LIKE pmee_t.pmee007,	   #資料來源
    pmee008	   LIKE pmee_t.pmee008,	   #來源單號
    pmee009	   LIKE pmee_t.pmee009,	   #付款條件
    pmee010	   LIKE pmee_t.pmee010,	   #交易條件
    pmee011	   LIKE pmee_t.pmee011,	   #稅別
    pmee012	   LIKE pmee_t.pmee012,	   #稅率
    pmee013	   LIKE pmee_t.pmee013,	   #單價含稅否
    pmee015	   LIKE pmee_t.pmee015,	   #幣別
    pmee016	   LIKE pmee_t.pmee016,	   #匯率
    pmee017	   LIKE pmee_t.pmee017,	   #取價方式
    pmee018	   LIKE pmee_t.pmee018,	   #付款優惠條件
    pmee019	   LIKE pmee_t.pmee019,	   #納入 MPS/MRP計算
    pmee020	   LIKE pmee_t.pmee020,	   #運送方式
    pmee021	   LIKE pmee_t.pmee021,	   #付款供應商
    pmee022	   LIKE pmee_t.pmee022,	   #送貨供應商
    pmee023	   LIKE pmee_t.pmee023,	   #採購分類一
    pmee024	   LIKE pmee_t.pmee024,	   #採購分類二
    pmee025	   LIKE pmee_t.pmee025,	   #送貨地址
    pmee026	   LIKE pmee_t.pmee026,	   #帳款地址
    pmee027	   LIKE pmee_t.pmee027,	   #供應商連絡人
    pmee028	   LIKE pmee_t.pmee028,	   #一次性交易對象識別碼
    pmee029	   LIKE pmee_t.pmee029,	   #收貨部門
    pmee030	   LIKE pmee_t.pmee030,	   #多角貿易已拋轉
    pmee031	   LIKE pmee_t.pmee031,	   #多角來源單號
    pmee032	   LIKE pmee_t.pmee032,	   #最終客戶
    pmee033	   LIKE pmee_t.pmee033,	   #發票類型
    pmee040	   LIKE pmee_t.pmee040,	   #採購總未稅金額
    pmee041	   LIKE pmee_t.pmee041,	   #採購總含稅金額
    pmee042	   LIKE pmee_t.pmee042,	   #採購總稅額
    pmee043	   LIKE pmee_t.pmee043,	   #留置原因
    pmee044	   LIKE pmee_t.pmee044,	   #備註
    pmee046	   LIKE pmee_t.pmee046,	   #預付款發票開立方式
    pmee047	   LIKE pmee_t.pmee047,	   #物流結案
    pmee048	   LIKE pmee_t.pmee048,	   #帳流結案
    pmee049	   LIKE pmee_t.pmee049,	   #金流結案
    pmee050	   LIKE pmee_t.pmee050,	   #多角最終站否
    pmee051	   LIKE pmee_t.pmee051,	   #多角流程代碼
    pmee052	   LIKE pmee_t.pmee052,	   #最終供應商
    pmee053	   LIKE pmee_t.pmee053,	   #兩角目的據點
    pmee054	   LIKE pmee_t.pmee054,	   #內外購
    pmee055	   LIKE pmee_t.pmee055,	   #匯率計算基準
    pmee900	   LIKE pmee_t.pmee900,	   #變更序
    pmee901	   LIKE pmee_t.pmee901,	   #變更類型
    pmee902	   LIKE pmee_t.pmee902,	   #變更日期
    pmeeownid  LIKE pmee_t.pmeeownid,  #資料所有者
    pmeeowndp  LIKE pmee_t.pmeeowndp,  #資料所屬部門
    pmeecrtid  LIKE pmee_t.pmeecrtid,  #資料建立者
    pmeecrtdp  LIKE pmee_t.pmeecrtdp,  #資料建立部門
    pmeecrtdt  LIKE pmee_t.pmeecrtdt,  #資料創建日
    pmeestus   LIKE pmee_t.pmeestus,   #狀態碼
    pmeeacti   LIKE pmee_t.pmeeacti    #採購單結案否
           END RECORD
DEFINE l_str          STRING               #開啟apmt510傳入的參數 
   #160608-00013#3 20160621 add by ming -----(S) 
   DEFINE l_max_pspc002 LIKE pspc_t.pspc002 
   DEFINE l_pspc002     LIKE pspc_t.pspc002 
   #160608-00013#3 20160621 add by ming -----(E) 

   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
   END IF
   
   #160608-00013#3 20160621 add by ming -----(S) 
   SELECT DISTINCT pspc002 INTO l_pspc002 
     FROM apsp640_tmp 
   
   SELECT MAX(pspc002) INTO l_max_pspc002 
     FROM pspc_t 
    WHERE pspcent  = g_enterprise 
      AND pspcsite = g_site  
      AND pspc001  = tm.pspc001  
   IF l_pspc002 <> l_max_pspc002 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'aps-00189' 
      LET g_errparam.popup  = TRUE 
      LET g_errparam.replace[1] = tm.pspc001 
      CALL cl_err() 
      
      RETURN 
   END IF 
   #160608-00013#3 20160621 add by ming -----(E) 

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('apsp640',"lbl_pmdodocno") RETURNING g_coll_title[1],g_coll_title[1]  #採購單號
   LET l_success = TRUE
   LET l_tot_success = TRUE
   LET l_str = ''

   LET l_pmdodocno = ''
   DECLARE apsp640_cur CURSOR FOR
      SELECT DISTINCT pmdodocno FROM apsp640_tmp
   FOREACH apsp640_cur INTO l_pmdodocno
      IF NOT l_success THEN
         LET l_tot_success = FALSE
         LET l_success = TRUE
      END IF
      
      INITIALIZE l_pmee.* TO NULL
      LET l_pmee.pmeeent   = g_enterprise
      LET l_pmee.pmeesite  = g_site
      LET l_pmee.pmeedocno = l_pmdodocno
      #版本=採購單的版本+1
      #版本 = 目前[T:採購單單頭檔].[C:版本]加1
      SELECT MAX(pmdl001)+1 INTO l_pmee.pmee001
        FROM pmdl_t
       WHERE pmdlent = g_enterprise
         AND pmdldocno = l_pmee.pmeedocno
      IF cl_null(l_pmee.pmee001) THEN
         LET l_pmee.pmee001 = 1
      END IF
      LET l_pmee.pmee005   = "1"  #1.一般採購
      LET l_pmee.pmee006   = "1"  #1.一般交易
      LET l_pmee.pmee007   = "1"  #1.無
      LET l_pmee.pmee019   = "Y"
      LET l_pmee.pmee030   = "N"
      LET l_pmee.pmee040   = "0"
      LET l_pmee.pmee041   = "0"
      LET l_pmee.pmee042   = "0"
      LET l_pmee.pmee046   = "1"  #1.不開立發票
      LET l_pmee.pmee047   = "N"
      LET l_pmee.pmee048   = "N"
      LET l_pmee.pmee049   = "N"
      LET l_pmee.pmee054   = "1"  #1.內購
      LET l_pmee.pmee055   = "1"  #1.依採購日匯率
      LET l_pmee.pmee901   = "N"
      LET l_pmee.pmee902   = g_today
      #變更序=採購變更單的變更序最大值+1
      SELECT MAX(pmee900)+1 INTO l_pmee.pmee900
        FROM pmee_t
       WHERE pmeeent = g_enterprise
         AND pmeedocno = l_pmee.pmeedocno
      IF cl_null(l_pmee.pmee900) THEN
         LET l_pmee.pmee900 = 1
      END IF
      LET l_pmee.pmeeownid = g_user
      LET l_pmee.pmeeowndp = g_dept
      LET l_pmee.pmeecrtid = g_user
      LET l_pmee.pmeecrtdp = g_dept 
      LET l_pmee.pmeecrtdt = cl_get_current()
      LET l_pmee.pmeestus  = "N"
      LET l_pmee.pmeeacti  = "N"

      #抓取採購單單頭資料
      SELECT pmdldocdt,pmdl002,pmdl003,pmdl004,pmdl005,pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
             pmdl011  ,pmdl012,pmdl013,pmdl015,pmdl016,pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
             pmdl022  ,pmdl023,pmdl024,pmdl025,pmdl026,pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
             pmdl032  ,pmdl033,pmdl040,pmdl041,pmdl042,pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
             pmdl049  ,pmdl050,pmdl051,pmdl052,pmdl053,pmdl054,pmdl055
        INTO l_pmee.pmeedocdt,l_pmee.pmee002,l_pmee.pmee003,l_pmee.pmee004,l_pmee.pmee005,
             l_pmee.pmee006  ,l_pmee.pmee007,l_pmee.pmee008,l_pmee.pmee009,l_pmee.pmee010,
             l_pmee.pmee011  ,l_pmee.pmee012,l_pmee.pmee013,l_pmee.pmee015,l_pmee.pmee016,
             l_pmee.pmee017  ,l_pmee.pmee018,l_pmee.pmee019,l_pmee.pmee020,l_pmee.pmee021,
             l_pmee.pmee022  ,l_pmee.pmee023,l_pmee.pmee024,l_pmee.pmee025,l_pmee.pmee026,
             l_pmee.pmee027  ,l_pmee.pmee028,l_pmee.pmee029,l_pmee.pmee030,l_pmee.pmee031,
             l_pmee.pmee032  ,l_pmee.pmee033,l_pmee.pmee040,l_pmee.pmee041,l_pmee.pmee042,
             l_pmee.pmee043  ,l_pmee.pmee044,l_pmee.pmee046,l_pmee.pmee047,l_pmee.pmee048,
             l_pmee.pmee049  ,l_pmee.pmee050,l_pmee.pmee051,l_pmee.pmee052,l_pmee.pmee053,
             l_pmee.pmee054  ,l_pmee.pmee055
        FROM pmdl_t
       WHERE pmdlent = g_enterprise
         AND pmdldocno = l_pmee.pmeedocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pmdl_t'
         LET g_errparam.coll_vals[1] = l_pmee.pmeedocno
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF

      INSERT INTO pmee_t(pmeeent,pmeesite,pmeedocno,pmeedocdt,
         pmee001,pmee002,pmee003,pmee004,pmee005,pmee006,pmee007,pmee008,pmee009,pmee010,
         pmee011,pmee012,pmee013,pmee015,pmee016,pmee017,pmee018,pmee019,pmee020,pmee021,
         pmee022,pmee023,pmee024,pmee025,pmee026,pmee027,pmee028,pmee029,pmee030,pmee031,
         pmee032,pmee033,pmee040,pmee041,pmee042,pmee043,pmee044,pmee046,pmee047,pmee048,
         pmee049,pmee050,pmee051,pmee052,pmee053,pmee054,pmee055,pmee900,pmee901,pmee902,
         pmeeownid,pmeeowndp,pmeecrtid,pmeecrtdp,pmeecrtdt,pmeestus,pmeeacti)
       VALUES(l_pmee.pmeeent,l_pmee.pmeesite,l_pmee.pmeedocno,l_pmee.pmeedocdt,
              l_pmee.pmee001,l_pmee.pmee002,l_pmee.pmee003,l_pmee.pmee004,l_pmee.pmee005,
              l_pmee.pmee006,l_pmee.pmee007,l_pmee.pmee008,l_pmee.pmee009,l_pmee.pmee010,
              l_pmee.pmee011,l_pmee.pmee012,l_pmee.pmee013,l_pmee.pmee015,l_pmee.pmee016,
              l_pmee.pmee017,l_pmee.pmee018,l_pmee.pmee019,l_pmee.pmee020,l_pmee.pmee021,
              l_pmee.pmee022,l_pmee.pmee023,l_pmee.pmee024,l_pmee.pmee025,l_pmee.pmee026,
              l_pmee.pmee027,l_pmee.pmee028,l_pmee.pmee029,l_pmee.pmee030,l_pmee.pmee031,
              l_pmee.pmee032,l_pmee.pmee033,l_pmee.pmee040,l_pmee.pmee041,l_pmee.pmee042,
              l_pmee.pmee043,l_pmee.pmee044,l_pmee.pmee046,l_pmee.pmee047,l_pmee.pmee048,
              l_pmee.pmee049,l_pmee.pmee050,l_pmee.pmee051,l_pmee.pmee052,l_pmee.pmee053,
              l_pmee.pmee054,l_pmee.pmee055,l_pmee.pmee900,l_pmee.pmee901,l_pmee.pmee902,
              l_pmee.pmeeownid,l_pmee.pmeeowndp,l_pmee.pmeecrtid,l_pmee.pmeecrtdp,
              l_pmee.pmeecrtdt,l_pmee.pmeestus,l_pmee.pmeeacti)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pmee_t'
         LET g_errparam.coll_vals[1] = l_pmee.pmeedocno
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF

      IF cl_null(l_str) THEN
         LET l_str = " (pmeedocno = '",l_pmee.pmeedocno,"' AND pmee900 = '",l_pmee.pmee900,"') "
      ELSE
         LET l_str = l_str," OR (pmeedocno = '",l_pmee.pmeedocno,"' AND pmee900 = '",l_pmee.pmee900,"') "
      END IF

      CALL apsp640_ins_pmef(l_pmee.pmeedocno,l_pmee.pmee900) RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF
      
      CALL apsp640_ins_pmei(l_pmee.pmeedocno,l_pmee.pmee900) RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF

      CALL apsp640_ins_pmej(l_pmee.pmeedocno,l_pmee.pmee900) RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF

      CALL apsp640_ins_pmeg(l_pmee.pmeedocno,l_pmee.pmee900,l_pmee.pmee015,l_pmee.pmee016) RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF

      LET l_pmdodocno = ''
   END FOREACH

   CALL cl_err_collect_show()

   IF NOT l_success OR NOT l_tot_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      IF NOT cl_null(l_str) THEN
         LET la_param.prog = 'apmt510'
         LET la_param.param[1] = ''
         LET la_param.param[2] = ''
         LET la_param.param[3] = l_str
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
      END IF
   END IF

   IF g_bgjob = "N" THEN
      #前景作業完成處理
      CALL cl_ask_confirm3("std-00012","")
   END IF

END FUNCTION

################################################################################
# Descriptions...: APS版本说明
# Memo...........:
# Usage..........: CALL apsp640_pspc001_ref()
# Input parameter: no
# Return code....: no
# Date & Author..: 140702 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_pspc001_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = tm.pspc001
   CALL ap_ref_array2(g_ref_fields,"SELECT pscal003 FROM pscal_t WHERE pscalent='"||g_enterprise||"' AND pscalsite='"||g_site||"' AND pscal001=? AND pscal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   DISPLAY g_rtn_fields[1] TO pspc001_desc
END FUNCTION

################################################################################
# Descriptions...: 採購變更多帳期預付款檔
# Memo...........:
# Usage..........: CALL apsp640_ins_pmef(p_pmeedocno,p_pmee900)
# Input parameter: p_pmeedocno
#                : p_pmee900
# Return code....: TRUE OR FALSE
# Date & Author..: 140707 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_ins_pmef(p_pmeedocno,p_pmee900)
DEFINE p_pmeedocno  LIKE pmee_t.pmeedocno
DEFINE p_pmee900    LIKE pmee_t.pmee900
DEFINE r_success    LIKE type_t.num5
DEFINE l_pmef  RECORD
    pmefent    LIKE pmef_t.pmefent,    #企業編號
    pmefsite   LIKE pmef_t.pmefsite,   #營運據點
    pmefdocno  LIKE pmef_t.pmefdocno,  #採購變更單號
    pmef001	   LIKE pmef_t.pmef001,	   #期別
    pmef002	   LIKE pmef_t.pmef002,	   #付款條件
    pmef003	   LIKE pmef_t.pmef003,	   #預計應付款日
    pmef004	   LIKE pmef_t.pmef004,	   #預計票據到期日
    pmef005	   LIKE pmef_t.pmef005,	   #未稅金額
    pmef006	   LIKE pmef_t.pmef006,	   #含稅金額
    pmef007	   LIKE pmef_t.pmef007,	   #應付帳款單號
    pmef008	   LIKE pmef_t.pmef008,	   #主帳套立帳未稅金額
    pmef009	   LIKE pmef_t.pmef009,	   #主帳套立帳含稅金額
    pmef014	   LIKE pmef_t.pmef014,	   #帳款類型
    pmef900	   LIKE pmef_t.pmef900,    #變更序
    pmef901	   LIKE pmef_t.pmef901	   #變更類型
           END RECORD

   LET r_success = TRUE
   INITIALIZE l_pmef.* TO NULL
   LET l_pmef.pmefent   = g_enterprise
   LET l_pmef.pmefsite  = g_site
   LET l_pmef.pmefdocno = p_pmeedocno
   LET l_pmef.pmef900 = p_pmee900
   LET l_pmef.pmef901 = '1'  #未變更
   
   DECLARE apsp640_sel_pmdm_cur CURSOR FOR
      SELECT pmdm001,pmdm002,pmdm003,pmdm004,pmdm005,pmdm006,pmdm007,pmdm008,pmdm009,pmdm014
        FROM pmdm_t
       WHERE pmdment = g_enterprise
         AND pmdmdocno = p_pmeedocno
   FOREACH apsp640_sel_pmdm_cur INTO l_pmef.pmef001,l_pmef.pmef002,l_pmef.pmef003,l_pmef.pmef004,l_pmef.pmef005,
                                     l_pmef.pmef006,l_pmef.pmef007,l_pmef.pmef008,l_pmef.pmef009,l_pmef.pmef014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pmdm_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      INSERT INTO pmef_t
                  (pmefent,pmefsite,pmefdocno,pmef001,pmef002,pmef003,pmef004,
                   pmef005,pmef006,pmef007,pmef008,pmef009,pmef014,pmef900,pmef901)
            VALUES(l_pmef.pmefent,l_pmef.pmefsite,l_pmef.pmefdocno,l_pmef.pmef001,l_pmef.pmef002,
                   l_pmef.pmef003,l_pmef.pmef004,l_pmef.pmef005,l_pmef.pmef006,l_pmef.pmef007,
                   l_pmef.pmef008,l_pmef.pmef009,l_pmef.pmef014,l_pmef.pmef900,l_pmef.pmef901)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pmef_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 採購變更單身明細檔
# Memo...........:
# Usage..........: CALL apsp640_ins_pmeg(p_pmeedocno,p_pmee900,p_pmee015,p_pmee016)
# Input parameter: p_pmeedocno
#                : p_pmee900
#                : p_pmee015
#                : p_pmee016
# Return code....: TRUE OR FALSE
# Date & Author..: 140707 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_ins_pmeg(p_pmeedocno,p_pmee900,p_pmee015,p_pmee016)
DEFINE p_pmeedocno  LIKE pmee_t.pmeedocno
DEFINE p_pmee900    LIKE pmee_t.pmee900
DEFINE p_pmee015    LIKE pmee_t.pmee015
DEFINE p_pmee016    LIKE pmee_t.pmee016
DEFINE r_success    LIKE type_t.num5
DEFINE l_pmeg  RECORD
    pmegent    LIKE pmeg_t.pmegent,    #企業編號
    pmegsite   LIKE pmeg_t.pmegsite,   #營運據點
    pmegdocno  LIKE pmeg_t.pmegdocno,  #採購變更單號
    pmegseq    LIKE pmeg_t.pmegseq,    #項次
    pmeg001    LIKE pmeg_t.pmeg001,    #料件編號
    pmeg002    LIKE pmeg_t.pmeg002,    #產品特徵
    pmeg003    LIKE pmeg_t.pmeg003,    #包裝容器
    pmeg004    LIKE pmeg_t.pmeg004,    #作業編號
    pmeg005    LIKE pmeg_t.pmeg005,    #製程序
    pmeg006    LIKE pmeg_t.pmeg006,    #採購單位
    pmeg007    LIKE pmeg_t.pmeg007,    #採購數量
    pmeg008    LIKE pmeg_t.pmeg008,    #參考單位
    pmeg009    LIKE pmeg_t.pmeg009,    #參考數量
    pmeg010    LIKE pmeg_t.pmeg010,    #計價單位
    pmeg011    LIKE pmeg_t.pmeg011,    #計價數量
    pmeg012    LIKE pmeg_t.pmeg012,    #出貨日期
    pmeg013    LIKE pmeg_t.pmeg013,    #到廠日期
    pmeg014    LIKE pmeg_t.pmeg014,    #到庫日期
    pmeg015    LIKE pmeg_t.pmeg015,    #單價
    pmeg016    LIKE pmeg_t.pmeg016,    #稅別
    pmeg017    LIKE pmeg_t.pmeg017,    #稅率
    pmeg019    LIKE pmeg_t.pmeg019,    #子件特性
    pmeg020    LIKE pmeg_t.pmeg020,    #急料
    pmeg021    LIKE pmeg_t.pmeg021,    #保稅
    pmeg022    LIKE pmeg_t.pmeg022,    #部分交貨
    pmegunit   LIKE pmeg_t.pmegunit,   #收貨據點
    pmegorga   LIKE pmeg_t.pmegorga,   #付款據點
    pmeg023    LIKE pmeg_t.pmeg023,    #送貨供應商
    pmeg024    LIKE pmeg_t.pmeg024,    #多交期
    pmeg025    LIKE pmeg_t.pmeg025,    #收貨地址代碼
    pmeg026    LIKE pmeg_t.pmeg026,    #帳款地址代碼
    pmeg027    LIKE pmeg_t.pmeg027,    #供應商料號
    pmeg028    LIKE pmeg_t.pmeg028,    #限定庫位
    pmeg029    LIKE pmeg_t.pmeg029,    #限定儲位
    pmeg030    LIKE pmeg_t.pmeg030,    #限定批號
    pmeg031    LIKE pmeg_t.pmeg031,    #運輸方式
    pmeg032    LIKE pmeg_t.pmeg032,    #取貨模式
    pmeg033    LIKE pmeg_t.pmeg033,    #備品率
    pmeg034    LIKE pmeg_t.pmeg034,    #No use
    pmeg035    LIKE pmeg_t.pmeg035,    #價格核決
    pmeg036    LIKE pmeg_t.pmeg036,    #專案編號
    pmeg037    LIKE pmeg_t.pmeg037,    #WBS編號
    pmeg038    LIKE pmeg_t.pmeg038,    #活動編號
    pmeg039    LIKE pmeg_t.pmeg039,    #費用原因
    pmeg040    LIKE pmeg_t.pmeg040,    #取價來源
    pmeg041    LIKE pmeg_t.pmeg041,    #價格參考單號
    pmeg042    LIKE pmeg_t.pmeg042,    #價格參考項次
    pmeg043    LIKE pmeg_t.pmeg043,    #取出價格
    pmeg044    LIKE pmeg_t.pmeg044,    #價差比
    pmeg045    LIKE pmeg_t.pmeg045,    #行狀態
    pmeg046    LIKE pmeg_t.pmeg046,    #未稅金額
    pmeg047    LIKE pmeg_t.pmeg047,    #含稅金額
    pmeg048    LIKE pmeg_t.pmeg048,    #稅額
    pmeg049    LIKE pmeg_t.pmeg049,    #理由碼
    pmeg050    LIKE pmeg_t.pmeg050,    #備註
    pmeg051    LIKE pmeg_t.pmeg051,    #結案理由碼
    pmeg052    LIKE pmeg_t.pmeg052,    #檢驗否
    pmeg900    LIKE pmeg_t.pmeg900,    #變更序
    pmeg901    LIKE pmeg_t.pmeg901     #變更類型
           END RECORD
DEFINE l_pmeg_b  RECORD
    pmeg007    LIKE pmeg_t.pmeg007,
    pmeg009    LIKE pmeg_t.pmeg009,
    pmeg011    LIKE pmeg_t.pmeg011,
    pmeg046    LIKE pmeg_t.pmeg046,
    pmeg047    LIKE pmeg_t.pmeg047,
    pmeg048    LIKE pmeg_t.pmeg048
           END RECORD
DEFINE l_success    LIKE type_t.num5

   LET r_success = TRUE
   INITIALIZE l_pmeg.* TO NULL
   LET l_pmeg.pmegent   = g_enterprise
   LET l_pmeg.pmegsite  = g_site
   LET l_pmeg.pmegdocno = p_pmeedocno
   LET l_pmeg.pmeg900   = p_pmee900
   LET l_pmeg.pmeg901   = '2'   #未變更

   DECLARE apsp640_sel_pmdn_cur CURSOR FOR
      SELECT pmdnseq,pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,pmdn006,pmdn007,pmdn008,pmdn009,
             pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn016,pmdn017,pmdn019,pmdn020,
             pmdn021,pmdn022,pmdnunit,pmdnorga,pmdn023,pmdn024,pmdn025,pmdn026,pmdn027,pmdn028,
             pmdn029,pmdn030,pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,pmdn036,pmdn037,pmdn038,
             pmdn039,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,pmdn046,pmdn047,pmdn048,
             pmdn049,pmdn050,pmdn051,pmdn052
        FROM pmdn_t
       WHERE pmdnent = g_enterprise
         AND pmdndocno = p_pmeedocno
   FOREACH apsp640_sel_pmdn_cur INTO l_pmeg.pmegseq,l_pmeg.pmeg001,l_pmeg.pmeg002,l_pmeg.pmeg003,l_pmeg.pmeg004,
                                     l_pmeg.pmeg005,l_pmeg.pmeg006,l_pmeg.pmeg007,l_pmeg.pmeg008,l_pmeg.pmeg009,
                                     l_pmeg.pmeg010,l_pmeg.pmeg011,l_pmeg.pmeg012,l_pmeg.pmeg013,l_pmeg.pmeg014,
                                     l_pmeg.pmeg015,l_pmeg.pmeg016,l_pmeg.pmeg017,l_pmeg.pmeg019,l_pmeg.pmeg020,
                                     l_pmeg.pmeg021,l_pmeg.pmeg022,l_pmeg.pmegunit,l_pmeg.pmegorga,l_pmeg.pmeg023,
                                     l_pmeg.pmeg024,l_pmeg.pmeg025,l_pmeg.pmeg026,l_pmeg.pmeg027,l_pmeg.pmeg028,
                                     l_pmeg.pmeg029,l_pmeg.pmeg030,l_pmeg.pmeg031,l_pmeg.pmeg032,l_pmeg.pmeg033,
                                     l_pmeg.pmeg034,l_pmeg.pmeg035,l_pmeg.pmeg036,l_pmeg.pmeg037,l_pmeg.pmeg038,
                                     l_pmeg.pmeg039,l_pmeg.pmeg040,l_pmeg.pmeg041,l_pmeg.pmeg042,l_pmeg.pmeg043,
                                     l_pmeg.pmeg044,l_pmeg.pmeg045,l_pmeg.pmeg046,l_pmeg.pmeg047,l_pmeg.pmeg048,
                                     l_pmeg.pmeg049,l_pmeg.pmeg050,l_pmeg.pmeg051,l_pmeg.pmeg052     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pmdn_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      IF NOT apsp640_ins_pmeh(p_pmeedocno,p_pmee900,l_pmeg.pmegseq,l_pmeg.pmeg015,p_pmee015,p_pmee016) THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      INITIALIZE l_pmeg_b.* TO NULL
      SELECT SUM(pmeh006),SUM(pmeh032),SUM(pmeh033),SUM(pmeh034)
        INTO l_pmeg_b.pmeg007,l_pmeg_b.pmeg046,l_pmeg_b.pmeg047,l_pmeg_b.pmeg048
        FROM pmeh_t
       WHERE pmehent   = l_pmeg.pmegent
         AND pmehdocno = l_pmeg.pmegdocno
         AND pmehseq   = l_pmeg.pmegseq
         AND pmeh900   = l_pmeg.pmeg900
      IF cl_null(l_pmeg.pmeg007) THEN
         LET l_pmeg.pmeg007 = 0
      END IF
      IF l_pmeg.pmeg007 <> l_pmeg_b.pmeg007 THEN
         IF NOT s_apmt510_ins_pmek(l_pmeg.pmegseq,0,0,"pmdn007",'2',l_pmeg.pmeg007,l_pmeg_b.pmeg007,l_pmeg.pmegdocno,l_pmeg.pmeg900,'') THEN      
            LET r_success = FALSE
            EXIT FOREACH
         ELSE
            LET l_pmeg.pmeg007 = l_pmeg_b.pmeg007
         END IF
         IF NOT cl_null(l_pmeg.pmeg008) THEN
            CALL s_aooi250_convert_qty(l_pmeg.pmeg001,l_pmeg.pmeg006,l_pmeg.pmeg008,l_pmeg_b.pmeg007) RETURNING l_success,l_pmeg_b.pmeg009
            IF NOT s_apmt510_ins_pmek(l_pmeg.pmegseq,0,0,"pmdn009",'2',l_pmeg.pmeg009,l_pmeg_b.pmeg009,l_pmeg.pmegdocno,l_pmeg.pmeg900,'') THEN      
               LET r_success = FALSE
               EXIT FOREACH
            ELSE
               LET l_pmeg.pmeg009 = l_pmeg_b.pmeg009
            END IF
         END IF
         IF NOT cl_null(l_pmeg.pmeg010) THEN
            CALL s_aooi250_convert_qty(l_pmeg.pmeg001,l_pmeg.pmeg006,l_pmeg.pmeg010,l_pmeg_b.pmeg007) RETURNING l_success,l_pmeg_b.pmeg011
            IF NOT s_apmt510_ins_pmek(l_pmeg.pmegseq,0,0,"pmdn011",'2',l_pmeg.pmeg011,l_pmeg_b.pmeg011,l_pmeg.pmegdocno,l_pmeg.pmeg900,'') THEN      
               LET r_success = FALSE
               EXIT FOREACH
            ELSE
               LET l_pmeg.pmeg011 = l_pmeg_b.pmeg011
            END IF
         END IF
         UPDATE pmeh_t SET pmeh005 = l_pmeg.pmeg007
          WHERE pmehent   = l_pmeg.pmegent
            AND pmehdocno = l_pmeg.pmegdocno
            AND pmehseq   = l_pmeg.pmegseq
            AND pmeh900   = l_pmeg.pmeg900
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd pmeh_t'
            LET g_errparam.coll_vals[1] = p_pmeedocno
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      IF NOT s_apmt510_ins_pmek(l_pmeg.pmegseq,0,0,"pmdn046",'2',l_pmeg.pmeg046,l_pmeg_b.pmeg046,l_pmeg.pmegdocno,l_pmeg.pmeg900,'') THEN      
         LET r_success = FALSE
         EXIT FOREACH
      ELSE
         LET l_pmeg.pmeg046 = l_pmeg_b.pmeg046
      END IF
      IF NOT s_apmt510_ins_pmek(l_pmeg.pmegseq,0,0,"pmdn046",'2',l_pmeg.pmeg047,l_pmeg_b.pmeg047,l_pmeg.pmegdocno,l_pmeg.pmeg900,'') THEN      
         LET r_success = FALSE
         EXIT FOREACH
      ELSE
         LET l_pmeg.pmeg047 = l_pmeg_b.pmeg047
      END IF
      IF NOT s_apmt510_ins_pmek(l_pmeg.pmegseq,0,0,"pmdn046",'2',l_pmeg.pmeg048,l_pmeg_b.pmeg048,l_pmeg.pmegdocno,l_pmeg.pmeg900,'') THEN      
         LET r_success = FALSE
         EXIT FOREACH
      ELSE
         LET l_pmeg.pmeg048 = l_pmeg_b.pmeg048
      END IF

      INSERT INTO pmeg_t(pmegent,pmegsite,pmegdocno,pmegseq,pmeg001,pmeg002,pmeg003,pmeg004,pmeg005,pmeg006,
                         pmeg007,pmeg008,pmeg009,pmeg010,pmeg011,pmeg012,pmeg013,pmeg014,pmeg015,pmeg016,
                         pmeg017,pmeg019,pmeg020,pmeg021,pmeg022,pmegunit,pmegorga,pmeg023,pmeg024,pmeg025,
                         pmeg026,pmeg027,pmeg028,pmeg029,pmeg030,pmeg031,pmeg032,pmeg033,pmeg034,pmeg035,
                         pmeg036,pmeg037,pmeg038,pmeg039,pmeg040,pmeg041,pmeg042,pmeg043,pmeg044,pmeg045,
                         pmeg046,pmeg047,pmeg048,pmeg049,pmeg050,pmeg051,pmeg052,pmeg900,pmeg901)
                  VALUES(l_pmeg.pmegent,l_pmeg.pmegsite,l_pmeg.pmegdocno,l_pmeg.pmegseq,l_pmeg.pmeg001,
                         l_pmeg.pmeg002,l_pmeg.pmeg003,l_pmeg.pmeg004,l_pmeg.pmeg005,l_pmeg.pmeg006,
                         l_pmeg.pmeg007,l_pmeg.pmeg008,l_pmeg.pmeg009,l_pmeg.pmeg010,l_pmeg.pmeg011,
                         l_pmeg.pmeg012,l_pmeg.pmeg013,l_pmeg.pmeg014,l_pmeg.pmeg015,l_pmeg.pmeg016,
                         l_pmeg.pmeg017,l_pmeg.pmeg019,l_pmeg.pmeg020,l_pmeg.pmeg021,l_pmeg.pmeg022,
                         l_pmeg.pmegunit,l_pmeg.pmegorga,l_pmeg.pmeg023,l_pmeg.pmeg024,l_pmeg.pmeg025,
                         l_pmeg.pmeg026,l_pmeg.pmeg027,l_pmeg.pmeg028,l_pmeg.pmeg029,l_pmeg.pmeg030,
                         l_pmeg.pmeg031,l_pmeg.pmeg032,l_pmeg.pmeg033,l_pmeg.pmeg034,l_pmeg.pmeg035,
                         l_pmeg.pmeg036,l_pmeg.pmeg037,l_pmeg.pmeg038,l_pmeg.pmeg039,l_pmeg.pmeg040,
                         l_pmeg.pmeg041,l_pmeg.pmeg042,l_pmeg.pmeg043,l_pmeg.pmeg044,l_pmeg.pmeg045,
                         l_pmeg.pmeg046,l_pmeg.pmeg047,l_pmeg.pmeg048,l_pmeg.pmeg049,l_pmeg.pmeg050,
                         l_pmeg.pmeg051,l_pmeg.pmeg052,l_pmeg.pmeg900,l_pmeg.pmeg901)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pmeg_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   RETURN r_success        

END FUNCTION

################################################################################
# Descriptions...: 採購變更關聯單據明細檔
# Memo...........:
# Usage..........: CALL apsp640_ins_pmei(p_pmeedocno,p_pmee900)
# Input parameter: p_pmeedocno
#                : p_pmee900
# Return code....: TRUE OR FALSE
# Date & Author..: 140707 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_ins_pmei(p_pmeedocno,p_pmee900)
DEFINE p_pmeedocno  LIKE pmee_t.pmeedocno
DEFINE p_pmee900    LIKE pmee_t.pmee900
DEFINE r_success    LIKE type_t.num5
DEFINE l_pmei  RECORD
    pmeient    LIKE pmei_t.pmeient,    #企業編號
    pmeisite   LIKE pmei_t.pmeisite,   #營運據點
    pmeidocno  LIKE pmei_t.pmeidocno,  #採購變更單號
    pmeiseq    LIKE pmei_t.pmeiseq,    #採購項次
    pmeiseq1   LIKE pmei_t.pmeiseq1,   #項序
    pmei001	   LIKE pmei_t.pmei001,	   #料件編號
    pmei002	   LIKE pmei_t.pmei002,	   #產品特徵
    pmei003	   LIKE pmei_t.pmei003,	   #來源單號
    pmei004	   LIKE pmei_t.pmei004,	   #來源項次
    pmei005	   LIKE pmei_t.pmei005,	   #來源項序
    pmei006	   LIKE pmei_t.pmei006,	   #來源分批序
    pmei007	   LIKE pmei_t.pmei007,	   #來源料號
    pmei008	   LIKE pmei_t.pmei008,	   #來源產品特徵
    pmei009	   LIKE pmei_t.pmei009,	   #來源作業編號
    pmei010	   LIKE pmei_t.pmei010,	   #來源製程序
    pmei011	   LIKE pmei_t.pmei011,	   #來源BOM特性
    pmei012	   LIKE pmei_t.pmei012,	   #來源生產控制組
    pmei021	   LIKE pmei_t.pmei021,	   #沖銷順序
    pmei022	   LIKE pmei_t.pmei022,	   #需求單位
    pmei023	   LIKE pmei_t.pmei023,	   #需求數量
    pmei024	   LIKE pmei_t.pmei024,	   #折合採購量
    pmei025	   LIKE pmei_t.pmei025,	   #已收貨量
    pmei026	   LIKE pmei_t.pmei026,	   #已入庫量
    pmei900	   LIKE pmei_t.pmei900,	   #變更序
    pmei901	   LIKE pmei_t.pmei901	   #變更類型
           END RECORD

   LET r_success = TRUE
   INITIALIZE l_pmei.* TO NULL
   LET l_pmei.pmeient   = g_enterprise
   LET l_pmei.pmeisite  = g_site
   LET l_pmei.pmeidocno = p_pmeedocno
   LET l_pmei.pmei900   = p_pmee900
   LET l_pmei.pmei901   = 1  #未變更

   DECLARE apsp640_cur_4 CURSOR FOR
      SELECT pmdpseq,pmdpseq1,pmdp001,pmdp002,pmdp003,pmdp004,pmdp005,pmdp006,pmdp007,pmdp008,
             pmdp009,pmdp010,pmdp011,pmdp012,pmdp021,pmdp022,pmdp023,pmdp024,pmdp025,pmdp026
        FROM pmdp_t
       WHERE pmdpent = g_enterprise
         AND pmdpdocno = p_pmeedocno
   FOREACH apsp640_cur_4 INTO l_pmei.pmeiseq,l_pmei.pmeiseq1,l_pmei.pmei001,l_pmei.pmei002,l_pmei.pmei003,
                              l_pmei.pmei004,l_pmei.pmei005,l_pmei.pmei006,l_pmei.pmei007,l_pmei.pmei008,
                              l_pmei.pmei009,l_pmei.pmei010,l_pmei.pmei011,l_pmei.pmei012,l_pmei.pmei021,
                              l_pmei.pmei022,l_pmei.pmei023,l_pmei.pmei024,l_pmei.pmei025,l_pmei.pmei026
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pmdp_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      INSERT INTO pmei_t(pmeient,pmeisite,pmeidocno,pmeiseq,pmeiseq1,
                         pmei001,pmei002,pmei003,pmei004,pmei005,pmei006,pmei007,pmei008,pmei009,pmei010,
                         pmei011,pmei012,pmei021,pmei022,pmei023,pmei024,pmei025,pmei026,pmei900,pmei901)
                  VALUES(l_pmei.pmeient,l_pmei.pmeisite,l_pmei.pmeidocno,l_pmei.pmeiseq,l_pmei.pmeiseq1,
                         l_pmei.pmei001,l_pmei.pmei002 ,l_pmei.pmei003  ,l_pmei.pmei004,l_pmei.pmei005,
                         l_pmei.pmei006,l_pmei.pmei007 ,l_pmei.pmei008  ,l_pmei.pmei009,l_pmei.pmei010,
                         l_pmei.pmei011,l_pmei.pmei012 ,l_pmei.pmei021  ,l_pmei.pmei022,l_pmei.pmei023,
                         l_pmei.pmei024,l_pmei.pmei025 ,l_pmei.pmei026  ,l_pmei.pmei900,l_pmei.pmei901)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pmei_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
   END FOREACH   

   RETURN r_success   

END FUNCTION

################################################################################
# Descriptions...: 採購變更多交期匯總檔
# Memo...........:
# Usage..........: CALL apsp640_ins_pmej(p_pmeedocno,p_pmee900)
# Input parameter: p_pmeedocno
#                : p_pmee900
# Return code....: TRUE OR FALSE
# Date & Author..: 140707 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_ins_pmej(p_pmeedocno,p_pmee900)
DEFINE p_pmeedocno  LIKE pmee_t.pmeedocno
DEFINE p_pmee900    LIKE pmee_t.pmee900
DEFINE r_success    LIKE type_t.num5
DEFINE l_pmej  RECORD
    pmejent    LIKE pmej_t.pmejent,    #企業編號
    pmejsite   LIKE pmej_t.pmejsite,   #營運據點
    pmejdocno  LIKE pmej_t.pmejdocno,  #採購變更單號
    pmejseq	   LIKE pmej_t.pmejseq,	   #採購項次
    pmej001	   LIKE pmej_t.pmej001,	   #分批序
    pmej002	   LIKE pmej_t.pmej002,	   #分批數量
    pmej003	   LIKE pmej_t.pmej003,	   #交貨日期
    pmej004	   LIKE pmej_t.pmej004,	   #到廠日期
    pmej005	   LIKE pmej_t.pmej005,	   #到庫日期
    pmej006	   LIKE pmej_t.pmej006,	   #收貨時段
    pmej007	   LIKE pmej_t.pmej007,	   #MRP凍結否
    pmej008	   LIKE pmej_t.pmej008,	   #交期類型
    pmej900	   LIKE pmej_t.pmej900,	   #變更序
    pmej901	   LIKE pmej_t.pmej901	   #變更類型
           END RECORD

   LET r_success = TRUE
   INITIALIZE l_pmej.* TO NULL
   LET l_pmej.pmejent   = g_enterprise
   LET l_pmej.pmejsite  = g_site
   LET l_pmej.pmejdocno = p_pmeedocno
   LET l_pmej.pmej900   = p_pmee900
   LET l_pmej.pmej901   = '1'  #未變更

   DECLARE apsp640_cur_5 CURSOR FOR
      SELECT pmdqseq,pmdqseq2,pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,pmdq007,pmdq008
        FROM pmdq_t
       WHERE pmdqent = g_enterprise
         AND pmdqdocno = p_pmeedocno
   FOREACH apsp640_cur_5 INTO l_pmej.pmejseq,l_pmej.pmej001,l_pmej.pmej002,l_pmej.pmej003,
                              l_pmej.pmej004,l_pmej.pmej005,l_pmej.pmej006,l_pmej.pmej007,l_pmej.pmej008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pmdq_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      INSERT INTO pmej_t(pmejent,pmejsite,pmejdocno,pmejseq,pmej001,pmej002,pmej003,
                         pmej004,pmej005,pmej006,pmej007,pmej008,pmej900)
                 VALUES (l_pmej.pmejent,l_pmej.pmejsite,l_pmej.pmejdocno,l_pmej.pmejseq,
                         l_pmej.pmej001,l_pmej.pmej002,l_pmej.pmej003,l_pmej.pmej004,l_pmej.pmej005,
                         l_pmej.pmej006,l_pmej.pmej007,l_pmej.pmej008,l_pmej.pmej900)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pmej_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

   END FOREACH

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 採購變更交期明細檔
# Memo...........:
# Usage..........: CALL apsp640_ins_pmeh(p_pmeedocno,p_pmee900,p_pmegseq,p_pmeg015,p_pmee015,p_pmee016)
# Input parameter: p_pmeedocno
#                : p_pmee900
#                : p_pmegseq
#                : p_pmeg015
#                : p_pmee015
#                : p_pmee016
# Return code....: TRUE OR FALSE
# Date & Author..: 140707 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_ins_pmeh(p_pmeedocno,p_pmee900,p_pmegseq,p_pmeg015,p_pmee015,p_pmee016)
DEFINE p_pmeedocno  LIKE pmee_t.pmeedocno
DEFINE p_pmee900    LIKE pmee_t.pmee900
DEFINE p_pmegseq    LIKE pmeg_t.pmegseq
DEFINE p_pmeg015    LIKE pmeg_t.pmeg015
DEFINE p_pmee015    LIKE pmee_t.pmee015
DEFINE p_pmee016    LIKE pmee_t.pmee016
DEFINE r_success    LIKE type_t.num5
#mod--161109-00085#15 By 08993--(s)
#DEFINE l_pmeh  RECORD LIKE pmeh_t.*   #mark--161109-00085#15 By 08993--(s)
DEFINE l_pmeh RECORD  #採購變更交期明細檔
       pmehent LIKE pmeh_t.pmehent, #企業編號
       pmehsite LIKE pmeh_t.pmehsite, #營運據點
       pmehdocno LIKE pmeh_t.pmehdocno, #採購變更單號
       pmehseq LIKE pmeh_t.pmehseq, #採購項次
       pmehseq1 LIKE pmeh_t.pmehseq1, #項序
       pmehseq2 LIKE pmeh_t.pmehseq2, #分批序
       pmeh001 LIKE pmeh_t.pmeh001, #料件編號
       pmeh002 LIKE pmeh_t.pmeh002, #產品特徵
       pmeh003 LIKE pmeh_t.pmeh003, #子件特性
       pmeh004 LIKE pmeh_t.pmeh004, #採購單位
       pmeh005 LIKE pmeh_t.pmeh005, #採購總數量
       pmeh006 LIKE pmeh_t.pmeh006, #分批採購數量
       pmeh007 LIKE pmeh_t.pmeh007, #摺合主件數量
       pmeh008 LIKE pmeh_t.pmeh008, #QPA
       pmeh009 LIKE pmeh_t.pmeh009, #交期類型
       pmeh010 LIKE pmeh_t.pmeh010, #收貨時段
       pmeh011 LIKE pmeh_t.pmeh011, #出貨日期
       pmeh012 LIKE pmeh_t.pmeh012, #到廠日期
       pmeh013 LIKE pmeh_t.pmeh013, #到庫日期
       pmeh014 LIKE pmeh_t.pmeh014, #MRP交期凍結
       pmeh015 LIKE pmeh_t.pmeh015, #已收貨量
       pmeh016 LIKE pmeh_t.pmeh016, #驗退量
       pmeh017 LIKE pmeh_t.pmeh017, #倉退換貨量
       pmeh019 LIKE pmeh_t.pmeh019, #已入庫量
       pmeh020 LIKE pmeh_t.pmeh020, #VMI請款量
       pmeh021 LIKE pmeh_t.pmeh021, #交貨狀態
       pmeh022 LIKE pmeh_t.pmeh022, #參考價格
       pmeh023 LIKE pmeh_t.pmeh023, #稅別
       pmeh024 LIKE pmeh_t.pmeh024, #稅率
       pmeh025 LIKE pmeh_t.pmeh025, #電子採購單號
       pmeh026 LIKE pmeh_t.pmeh026, #最近修改人員
       pmeh027 LIKE pmeh_t.pmeh027, #最近修改時間
       pmeh028 LIKE pmeh_t.pmeh028, #分批參考單位
       pmeh029 LIKE pmeh_t.pmeh029, #分批參考數量
       pmeh030 LIKE pmeh_t.pmeh030, #分批計價單位
       pmeh031 LIKE pmeh_t.pmeh031, #分批計價數量
       pmeh032 LIKE pmeh_t.pmeh032, #分批未稅金額
       pmeh033 LIKE pmeh_t.pmeh033, #分批含稅金額
       pmeh034 LIKE pmeh_t.pmeh034, #分批稅額
       pmeh035 LIKE pmeh_t.pmeh035, #初始營運據點
       pmeh036 LIKE pmeh_t.pmeh036, #初始來源單號
       pmeh037 LIKE pmeh_t.pmeh037, #初始來源項次
       pmeh038 LIKE pmeh_t.pmeh038, #初始項序
       pmeh039 LIKE pmeh_t.pmeh039, #初始分批序
       pmeh040 LIKE pmeh_t.pmeh040, #倉退量
       pmeh900 LIKE pmeh_t.pmeh900, #變更序
       pmeh901 LIKE pmeh_t.pmeh901, #變更類型
       pmeh200 LIKE pmeh_t.pmeh200, #分批包裝單位
       pmeh201 LIKE pmeh_t.pmeh201  #分批包裝數量
END RECORD
#mod--161109-00085#15 By 08993--(e)
#DEFINE l_pmeh  RECORD
#    pmehent    LIKE pmeh_t.pmehent,    #企業編號
#    pmehsite   LIKE pmeh_t.pmehsite,   #營運據點
#    pmehdocno  LIKE pmeh_t.pmehdocno,  #採購變更單號
#    pmehseq    LIKE pmeh_t.pmehseq,    #採購項次
#    pmehseq1   LIKE pmeh_t.pmehseq1,   #項序
#    pmehseq2   LIKE pmeh_t.pmehseq2,   #分批序
#    pmeh001	   LIKE pmeh_t.pmeh001,	  #料件編號
#    pmeh002	   LIKE pmeh_t.pmeh002,	  #產品特徵
#    pmeh003	   LIKE pmeh_t.pmeh003,	  #子件特性
#    pmeh004	   LIKE pmeh_t.pmeh004,	  #採購單位
#    pmeh005	   LIKE pmeh_t.pmeh005,	  #採購總數量
#    pmeh006	   LIKE pmeh_t.pmeh006,	  #分批採購數量
#    pmeh007	   LIKE pmeh_t.pmeh007,	  #折合主件數量
#    pmeh008	   LIKE pmeh_t.pmeh008,	  #QPA
#    pmeh009	   LIKE pmeh_t.pmeh009,	  #交期類型
#    pmeh010	   LIKE pmeh_t.pmeh010,	  #收貨時段
#    pmeh011	   LIKE pmeh_t.pmeh011,	  #出貨日期
#    pmeh012	   LIKE pmeh_t.pmeh012,	  #到廠日期
#    pmeh013	   LIKE pmeh_t.pmeh013,	  #到庫日期
#    pmeh014	   LIKE pmeh_t.pmeh014,	  #MRP交期凍結
#    pmeh015	   LIKE pmeh_t.pmeh015,	  #已收貨量
#    pmeh016	   LIKE pmeh_t.pmeh016,	  #驗退量
#    pmeh017	   LIKE pmeh_t.pmeh017,	  #倉退換貨量
#    pmeh019	   LIKE pmeh_t.pmeh019,	  #已入庫量
#    pmeh020	   LIKE pmeh_t.pmeh020,	  #VMI請款量
#    pmeh021	   LIKE pmeh_t.pmeh021,	  #交貨狀態
#    pmeh022	   LIKE pmeh_t.pmeh022,	  #參考價格
#    pmeh023	   LIKE pmeh_t.pmeh023,	  #稅別
#    pmeh024	   LIKE pmeh_t.pmeh024,	  #稅率
#    pmeh025	   LIKE pmeh_t.pmeh025,	  #電子採購單號
#    pmeh026	   LIKE pmeh_t.pmeh026,	  #最近修改人員
#    pmeh027	   LIKE pmeh_t.pmeh027,	  #最近修改時間
#    pmeh028	   LIKE pmeh_t.pmeh028,	  #分批參考單位
#    pmeh029	   LIKE pmeh_t.pmeh029,	  #分批參考數量
#    pmeh030	   LIKE pmeh_t.pmeh030,	  #分批計價單位
#    pmeh031	   LIKE pmeh_t.pmeh031,	  #分批計價數量
#    pmeh032	   LIKE pmeh_t.pmeh032,	  #分批未稅金額
#    pmeh033	   LIKE pmeh_t.pmeh033,	  #分批含稅金額
#    pmeh034	   LIKE pmeh_t.pmeh034,	  #分批稅額
#    pmeh035	   LIKE pmeh_t.pmeh035,	  #初始營運據點
#    pmeh036	   LIKE pmeh_t.pmeh036,	  #初始來源單號
#    pmeh037	   LIKE pmeh_t.pmeh037,	  #初始來源項次
#    pmeh038	   LIKE pmeh_t.pmeh038,	  #初始項序
#    pmeh039	   LIKE pmeh_t.pmeh039,	  #初始分批序
#    pmeh040	   LIKE pmeh_t.pmeh040,	  #倉退量
#    pmeh900	   LIKE pmeh_t.pmeh900,	  #變更序
#    pmeh901	   LIKE pmeh_t.pmeh901 	  #變更類型
#           END RECORD
DEFINE l_pspc  RECORD
    pspc050    LIKE pspc_t.pspc050,
    pspc034    LIKE pspc_t.pspc034,
    pspc045    LIKE pspc_t.pspc045,
    pspc001    LIKE pspc_t.pspc001,
    pspc002    LIKE pspc_t.pspc002,
    pspc004    LIKE pspc_t.pspc004 
           END RECORD
DEFINE l_imaf173    LIKE imaf_t.imaf173
DEFINE l_imaf174    LIKE imaf_t.imaf174
DEFINE l_money      LIKE xrcd_t.xrcd113
DEFINE l_xrcd113    LIKE xrcd_t.xrcd113
DEFINE l_xrcd114    LIKE xrcd_t.xrcd114
DEFINE l_xrcd115    LIKE xrcd_t.xrcd115
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.chr1

   LET r_success = TRUE
   INITIALIZE l_pmeh.* TO NULL
   LET l_pmeh.pmehent   = g_enterprise
   LET l_pmeh.pmehsite  = g_site
   LET l_pmeh.pmehdocno = p_pmeedocno
   LET l_pmeh.pmehseq   = p_pmegseq
   LET l_pmeh.pmeh900   = p_pmee900
   LET l_pmeh.pmeh901   = '2'  #資料本身就存在採購單中，且行狀態不是結案狀態，則更新為單身修改

   DECLARE apsp640_cur_3 CURSOR FOR
      SELECT pmdoseq1,pmdoseq2,pmdo001,pmdo002,pmdo003,pmdo004,pmdo005,pmdo006,pmdo007,
             pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,pmdo016,pmdo017,
             pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,pmdo026,pmdo027,pmdo028,
             pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo035,pmdo036,pmdo037,pmdo038,
             pmdo039,pmdo040
        FROM pmdo_t
       WHERE pmdoent   = g_enterprise
         AND pmdodocno = p_pmeedocno
         AND pmdoseq   = p_pmegseq
   FOREACH apsp640_cur_3 INTO l_pmeh.pmehseq1,l_pmeh.pmehseq2,l_pmeh.pmeh001,l_pmeh.pmeh002,
                              l_pmeh.pmeh003,l_pmeh.pmeh004,l_pmeh.pmeh005,l_pmeh.pmeh006,l_pmeh.pmeh007,
                              l_pmeh.pmeh008,l_pmeh.pmeh009,l_pmeh.pmeh010,l_pmeh.pmeh011,l_pmeh.pmeh012,
                              l_pmeh.pmeh013,l_pmeh.pmeh014,l_pmeh.pmeh015,l_pmeh.pmeh016,l_pmeh.pmeh017,
                              l_pmeh.pmeh019,l_pmeh.pmeh020,l_pmeh.pmeh021,l_pmeh.pmeh022,l_pmeh.pmeh023,
                              l_pmeh.pmeh024,l_pmeh.pmeh025,l_pmeh.pmeh026,l_pmeh.pmeh027,l_pmeh.pmeh028,
                              l_pmeh.pmeh029,l_pmeh.pmeh030,l_pmeh.pmeh031,l_pmeh.pmeh032,l_pmeh.pmeh033,
                              l_pmeh.pmeh034,l_pmeh.pmeh035,l_pmeh.pmeh036,l_pmeh.pmeh037,l_pmeh.pmeh038,
                              l_pmeh.pmeh039,l_pmeh.pmeh040
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pmdo_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_flag = '1'

      INITIALIZE l_pspc.* TO NULL
      SELECT pspc050,pspc034,pspc045,pspc001,pspc002,pspc004
        INTO l_pspc.pspc050,l_pspc.pspc034,l_pspc.pspc045,l_pspc.pspc001,l_pspc.pspc002,l_pspc.pspc004
        FROM apsp640_tmp
       WHERE pmdodocno = p_pmeedocno AND pmdoseq = l_pmeh.pmehseq
         AND pmdoseq1 = l_pmeh.pmehseq1 AND pmdoseq2 = l_pmeh.pmehseq2
      
      IF NOT cl_null(l_pspc.pspc045) AND l_pmeh.pmeh013 <> l_pspc.pspc045 THEN
         LET l_flag = '0'
         LET l_pmeh.pmeh013 = l_pspc.pspc045
         LET l_imaf173 = ''
         LET l_imaf174 = ''
         SELECT (imaf173*(-1)),(imaf174*(-1)) INTO l_imaf173,l_imaf174
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_pspc.pspc050
         CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmeh.pmeh013,0,l_imaf174)
              RETURNING l_pmeh.pmeh012
         CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmeh.pmeh013,0,(l_imaf173+l_imaf174))
              RETURNING l_pmeh.pmeh011
      END IF

      IF NOT cl_null(l_pspc.pspc034) AND l_pmeh.pmeh006 <> l_pspc.pspc034 THEN
         LET l_flag = '0'
         LET l_pmeh.pmeh006 = l_pspc.pspc034
         IF NOT cl_null(l_pmeh.pmeh028) THEN
            CALL s_aooi250_convert_qty(l_pmeh.pmeh001,l_pmeh.pmeh004,l_pmeh.pmeh028,l_pmeh.pmeh006) RETURNING l_success,l_pmeh.pmeh029
         END IF
         IF NOT cl_null(l_pmeh.pmeh030) THEN
            CALL s_aooi250_convert_qty(l_pmeh.pmeh001,l_pmeh.pmeh004,l_pmeh.pmeh030,l_pmeh.pmeh006) RETURNING l_success,l_pmeh.pmeh031
            LET l_money = p_pmeg015*l_pmeh.pmeh031
            IF NOT cl_null(l_pmeh.pmeh023) AND NOT cl_null(l_money) AND NOT cl_null(l_pmeh.pmeh031) AND NOT cl_null(p_pmee015) AND NOT cl_null(p_pmee016) THEN
               CALL s_tax_count(g_site,l_pmeh.pmeh023,l_money,l_pmeh.pmeh031,p_pmee015,p_pmee016)
                    RETURNING l_pmeh.pmeh032,l_pmeh.pmeh034,l_pmeh.pmeh033,l_xrcd113,l_xrcd114,l_xrcd115
            END IF
         END IF
      END IF
      
      INSERT INTO pmeh_t(pmehent,pmehsite,pmehdocno,pmehseq,pmehseq1,pmehseq2,pmeh001,pmeh002,pmeh003,pmeh004,
                         pmeh005,pmeh006,pmeh007,pmeh008,pmeh009,pmeh010,pmeh011,pmeh012,pmeh013,pmeh014,
                         pmeh015,pmeh016,pmeh017,pmeh019,pmeh020,pmeh021,pmeh022,pmeh023,pmeh024,pmeh025,
                         pmeh026,pmeh027,pmeh028,pmeh029,pmeh030,pmeh031,pmeh032,pmeh033,pmeh034,pmeh035,
                         pmeh036,pmeh037,pmeh038,pmeh039,pmeh040,pmeh900,pmeh901)
                  VALUES(l_pmeh.pmehent,l_pmeh.pmehsite,l_pmeh.pmehdocno,l_pmeh.pmehseq,l_pmeh.pmehseq1,
                         l_pmeh.pmehseq2,l_pmeh.pmeh001,l_pmeh.pmeh002,l_pmeh.pmeh003,l_pmeh.pmeh004,
                         l_pmeh.pmeh005,l_pmeh.pmeh006,l_pmeh.pmeh007,l_pmeh.pmeh008,l_pmeh.pmeh009,
                         l_pmeh.pmeh010,l_pmeh.pmeh011,l_pmeh.pmeh012,l_pmeh.pmeh013,l_pmeh.pmeh014,
                         l_pmeh.pmeh015,l_pmeh.pmeh016,l_pmeh.pmeh017,l_pmeh.pmeh019,l_pmeh.pmeh020,
                         l_pmeh.pmeh021,l_pmeh.pmeh022,l_pmeh.pmeh023,l_pmeh.pmeh024,l_pmeh.pmeh025,
                         l_pmeh.pmeh026,l_pmeh.pmeh027,l_pmeh.pmeh028,l_pmeh.pmeh029,l_pmeh.pmeh030,
                         l_pmeh.pmeh031,l_pmeh.pmeh032,l_pmeh.pmeh033,l_pmeh.pmeh034,l_pmeh.pmeh035,
                         l_pmeh.pmeh036,l_pmeh.pmeh037,l_pmeh.pmeh038,l_pmeh.pmeh039,l_pmeh.pmeh040,
                         l_pmeh.pmeh900,l_pmeh.pmeh901)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pmeh_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      IF l_flag = '0' THEN
          #mod--161109-00085#15 By 08993--(s)
#         IF NOT s_apmt510_pmeh_ins_pmek(l_pmeh.*) THEN   #mark--161109-00085#15 By 08993--(s)
          IF NOT s_apmt510_pmeh_ins_pmek(l_pmeh.pmehent,l_pmeh.pmehsite,l_pmeh.pmehdocno,l_pmeh.pmehseq,l_pmeh.pmehseq1,
                                         l_pmeh.pmehseq2,l_pmeh.pmeh001,l_pmeh.pmeh002,l_pmeh.pmeh003,l_pmeh.pmeh004,
                                         l_pmeh.pmeh005,l_pmeh.pmeh006,l_pmeh.pmeh007,l_pmeh.pmeh008,l_pmeh.pmeh009,
                                         l_pmeh.pmeh010,l_pmeh.pmeh011,l_pmeh.pmeh012,l_pmeh.pmeh013,l_pmeh.pmeh014,
                                         l_pmeh.pmeh015,l_pmeh.pmeh016,l_pmeh.pmeh017,l_pmeh.pmeh019,l_pmeh.pmeh020,
                                         l_pmeh.pmeh021,l_pmeh.pmeh022,l_pmeh.pmeh023,l_pmeh.pmeh024,l_pmeh.pmeh025,
                                         l_pmeh.pmeh026,l_pmeh.pmeh027,l_pmeh.pmeh028,l_pmeh.pmeh029,l_pmeh.pmeh030,
                                         l_pmeh.pmeh031,l_pmeh.pmeh032,l_pmeh.pmeh033,l_pmeh.pmeh034,l_pmeh.pmeh035,
                                         l_pmeh.pmeh036,l_pmeh.pmeh037,l_pmeh.pmeh038,l_pmeh.pmeh039,l_pmeh.pmeh040,
                                         l_pmeh.pmeh900,l_pmeh.pmeh901,l_pmeh.pmeh200,l_pmeh.pmeh201) THEN  
          #mod--161109-00085#15 By 08993--(e)           
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF

      UPDATE pspc_t SET pspc054 = 'Y',
                        pspc055 = l_pmeh.pmehdocno,
                        pspc056 = l_pmeh.pmehseq
       WHERE pspcent = g_enterprise
         AND pspcsite = g_site
         AND pspc001 = l_pspc.pspc001
         AND pspc002 = l_pspc.pspc002
         AND pspc004 = l_pspc.pspc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd pspc_t'
         LET g_errparam.coll_vals[1] = p_pmeedocno
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
     
   END FOREACH   

   RETURN r_success   

END FUNCTION

################################################################################
# Descriptions...: 可收貨量=採購量pmdo006-收貨量pmdo015+驗退量pmdo016+倉退換貨量pmdo017
# Memo...........:
# Usage..........: CALL apsp640_count()
#                  RETURNING r_num
# Input parameter: no
# Return code....: r_num
# Date & Author..: 141008 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_count()
DEFINE l_num      LIKE pmdo_t.pmdo006

   LET l_num = 0
   SELECT (pmdo015-pmdo016-pmdo017) INTO l_num FROM pmdo_t
    WHERE pmdoent   = g_enterprise
      AND pmdodocno = g_detail_d[g_detail_idx].pmdodocno
      AND pmdoseq   = g_detail_d[g_detail_idx].pmdoseq
      AND pmdoseq1  = g_detail_d[g_detail_idx].pmdoseq1
      AND pmdoseq2  = g_detail_d[g_detail_idx].pmdoseq2

   RETURN l_num

END FUNCTION

################################################################################
# Descriptions...: 採購單號存在兩未確認的變更單內
# Memo...........:
# Usage..........: CALL apsp640_chk()
#                  RETURNING r_success
# Input parameter: no
# Return code....: TRUE OR FALSE
# Date & Author..: 141016 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp640_chk()
DEFINE r_success  LIKE type_t.num5
DEFINE l_count    LIKE type_t.num5

   LET r_success = TRUE
   LET l_count = 0
   SELECT COUNT(pmeedocno) INTO l_count
     FROM pmee_t
    WHERE pmeeent = g_enterprise
      AND pmeedocno = g_detail_d[g_detail_idx].pmdodocno
      AND pmeestus = 'N'
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      LET r_success = FALSE
   END IF
   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
