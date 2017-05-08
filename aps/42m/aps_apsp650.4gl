#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp650.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-12-16 17:29:07), PR版次:0005(2016-06-21 15:00:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000120
#+ Filename...: apsp650
#+ Description: 請購變更整批調整作業
#+ Creator....: 04441(2014-05-27 00:00:00)
#+ Modifier...: 04543 -SD/PR- 03079
 
{</section>}
 
{<section id="apsp650.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151209-00022#6     2015/12/16 By earl     新增二次篩選功能
#160318-00025#50    2016/04/27 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息 
#160608-00013#3     2016/06/21 By ming     執行process時，先檢查有無新版本，有的話，跳出錯誤訊息「該APS版本：%1已有新一版本資料，請重新查詢後再進行處理」
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
       pmdbdocno         LIKE pmdb_t.pmdbdocno, #請購單號
       pmdbseq           LIKE pmdb_t.pmdbseq,   #項次
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
       pmdb006           LIKE pmdb_t.pmdb006,   #原請購量
       pspc034           LIKE pspc_t.pspc034,   #建議請購量
       pmdb049           LIKE pmdb_t.pmdb049,   #已入庫量
       pmdb030           LIKE pmdb_t.pmdb030,   #原到廠日
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
DEFINE g_detail2_cnt         LIKE type_t.num5             #單身2
DEFINE g_ooef008            LIKE ooef_t.ooef008
DEFINE g_ooef009            LIKE ooef_t.ooef009
DEFINE g_ooef016            LIKE ooef_t.ooef016

#end add-point
 
{</section>}
 
{<section id="apsp650.main" >}
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
      OPEN WINDOW w_apsp650 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp650_init()   
 
      #進入選單 Menu (="N")
      CALL apsp650_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp650
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apsp650_tmp 

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp650.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp650_init()
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
   
   LET g_ooef008 = ''
   LET g_ooef009 = ''
   LET g_ooef016 = ''
   SELECT ooef008,ooef009,ooef016 INTO g_ooef008,g_ooef009,g_ooef016
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site

   CREATE TEMP TABLE apsp650_tmp( 
       pmdbdocno          VARCHAR(20),      #請購單號
       pmdbseq            INTEGER,        #項次
       pspc050            VARCHAR(40),        #料件編號
       pspc034            DECIMAL(20,6),        #建議請購量
       pspc045            DATE,        #建議到廠日
       pspc001            VARCHAR(10),        #APS版本
       pspc002            VARCHAR(20),        #執行日期時間
       pspc004            VARCHAR(40)     #APS虛擬單號
   )

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp650.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp650_ui_dialog()
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
         CALL apsp650_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME tm.wc1 ON imae012,imaf142,pmdb030,pspc045,imaa009,imaf141,pspc050
	   
            BEFORE CONSTRUCT

            AFTER FIELD pmdb030                  #原到庫日
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
               CALL apsp650_pspc001_ref()

            ON ACTION controlp INFIELD pspc001   #APS版本
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.pspc001
               LET g_qryparam.where = "pscasite = '",g_site,"'"
               CALL q_psca001()
               LET tm.pspc001 = g_qryparam.return1
               DISPLAY tm.pspc001 TO pspc001
               CALL apsp650_pspc001_ref()
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
               CALL apsp650_fetch()
            
            ON CHANGE b_sel
               IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                  IF g_detail_d[g_detail_idx].pspc054 = 'Y' THEN
                     CALL cl_ask_pressanykey('aps-00109')
                     LET g_detail_d[g_detail_idx].sel = 'N'
                  END IF
                  IF g_detail_d[g_detail_idx].pspc034 < g_detail_d[g_detail_idx].pmdb049 THEN
                     CALL cl_ask_pressanykey('aps-00100')
                     LET g_detail_d[g_detail_idx].sel = 'N'
                  END IF
                  IF NOT apsp650_chk() THEN
                     CALL cl_ask_pressanykey('apm-00247')
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
               IF g_detail_d[li_idx].pspc034 < g_detail_d[li_idx].pmdb049 THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               IF NOT apsp650_chk() THEN
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
               IF g_detail_d[li_idx].pspc034 < g_detail_d[li_idx].pmdb049 THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               IF NOT apsp650_chk() THEN
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
            CALL apsp650_filter()
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
            CALL apsp650_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #151209-00022#6     2015/12/16 By earl  add s
            LET g_wc_filter = '1=1'
            CALL apsp650_b_fill()
            #151209-00022#6     2015/12/16 By earl  add e
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp650_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            DELETE FROM apsp650_tmp
            LET l_cnt = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = 'Y' THEN
                  LET l_cnt = l_cnt + 1
                  INSERT INTO apsp650_tmp VALUES(g_detail_d[li_idx].pmdbdocno,  #請購單號
                                                 g_detail_d[li_idx].pmdbseq,    #項次
                                                 g_detail_d[li_idx].pspc050,    #料件編號
                                                 g_detail_d[li_idx].pspc034,    #建議請購量
                                                 g_detail_d[li_idx].pspc045,    #建議到廠日
                                                 g_detail_d[li_idx].pspc001,    #APS版本
                                                 g_detail_d[li_idx].pspc002,    #執行日期時間
                                                 g_detail_d[li_idx].pspc004)    #APS虛擬單號
               END IF
            END FOR
            IF l_cnt = 0 THEN
               CALL cl_ask_pressanykey('-400')
            ELSE
               CALL apsp650_batch_execute()
               CALL apsp650_b_fill()
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
 
{<section id="apsp650.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp650_query()
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
   CALL apsp650_b_fill()
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
 
{<section id="apsp650.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp650_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_imaa006       LIKE imaa_t.imaa006
   DEFINE l_pmdb007       LIKE pmdb_t.pmdb007
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

   #151209-00022#6     2015/12/16 By earl  add s
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = '1=1'
   END IF
   #151209-00022#6     2015/12/16 By earl  add e

   LET l_pspc002 = ''
   SELECT MAX(pspc002) INTO l_pspc002 FROM pspc_t
    WHERE pspcent = g_enterprise AND pspcsite = g_site AND pspc001 = tm.pspc001

   #取得單據流水號總長度(aoos010)
   LET l_doclen = cl_get_para(g_enterprise,g_site,'E-COM-0005')

   LET g_sql = " SELECT 'N',pmdbdocno,pmdbseq,pspc050,'','',pspc051,",
               "        imaa009,'',imaf141,'',pspc014,'',pmdb006,pspc034,pmdb049,pmdb030,pspc045, ",
               "        imaf142,'',imae012,'',pspc054,pspc055,pspc056,pspc001,pspc002,pspc004 ",
               "   FROM pmdb_t,pspc_t ",
               "        LEFT OUTER JOIN imae_t ON imaeent = '",g_enterprise,"' AND imaesite = '",g_site,"' AND imae001 = pspc050 ",
               "        LEFT OUTER JOIN imaf_t ON imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf001 = pspc050 ",
               "        LEFT OUTER JOIN imaa_t ON imaaent = '",g_enterprise,"' AND imaa001 = pspc050 ",
               "  WHERE pmdbent = '",g_enterprise,"' ",
               "    AND pmdbdocno = SUBSTR(pspc004,1,",l_doclen,") ",
               "    AND pmdbseq= SUBSTR(pspc004,",l_doclen,"+2,LENGTH(pspc004)-",l_doclen,"-1) ",
               "    AND INSTR(pspc004,'-',",l_doclen,"+2,1) = 0 ",
               "    AND pspcent = ? AND pspcsite = '",g_site,"' AND pspc002 = '",l_pspc002,"' AND pspc007 = '0' ",ls_wc,
               "    AND ",tm.wc1 CLIPPED,
               "    AND ",g_wc_filter CLIPPED,   #151209-00022#6     2015/12/16 By earl  add
               "  ORDER BY pspc004 "

   #end add-point
 
   PREPARE apsp650_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp650_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
       g_detail_d[l_ac].sel,g_detail_d[l_ac].pmdbdocno,g_detail_d[l_ac].pmdbseq,
       g_detail_d[l_ac].pspc050,g_detail_d[l_ac].pspc050_desc,g_detail_d[l_ac].pspc050_desc_desc,
       g_detail_d[l_ac].pspc051,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,g_detail_d[l_ac].imaf141,
       g_detail_d[l_ac].imaf141_desc,g_detail_d[l_ac].imaa006,g_detail_d[l_ac].imaa006_desc,g_detail_d[l_ac].pmdb006,
       g_detail_d[l_ac].pspc034,g_detail_d[l_ac].pmdb049,g_detail_d[l_ac].pmdb030,g_detail_d[l_ac].pspc045,
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
      #LET g_detail_d[l_ac].pmdbdocno = ls_tmp.subString(1,ls_tmp.getIndexOf('-',1)-1)
      #LET l_n = ls_tmp.getIndexOf('-',1)+1
      #LET l_n1 = ls_tmp.getLength()
      #LET g_detail_d[l_ac].pmdbseq = ls_tmp.subString(l_n,l_n1)

      #輸入的請購單號需存在[T:請購單單頭當]中，且單據狀態為(Y:已確認)，且不能結案
      LET l_n = ''
      SELECT COUNT(*) INTO l_n
        FROM pmda_t
       WHERE pmdaent = g_enterprise
         AND pmdasite = g_site
         AND pmdadocno = g_detail_d[l_ac].pmdbdocno
         AND pmdastus = 'Y'
      IF cl_null(l_n) OR l_n = 0 THEN
         CONTINUE FOREACH
      END IF

      #建議到庫日與原預計到庫日不同，或是建議量與原採購量不時的資料才顯示
      IF g_detail_d[l_ac].pmdb030 = g_detail_d[l_ac].pspc045 AND 
         g_detail_d[l_ac].pmdb006 = g_detail_d[l_ac].pspc034 THEN
         CONTINUE FOREACH
      END IF

#      LET l_imaa006 = ''
#      SELECT imaa006 INTO l_imaa006
#        FROM imaa_t
#       WHERE imaaent = g_enterprise
#         AND imaa001 = g_detail_d[l_ac].pspc050

      LET l_pmdb007 = ''
      SELECT pmdb007 INTO l_pmdb007
        FROM pmdb_t
       WHERE pmdbent = g_enterprise
         AND pmdbsite = g_site
         AND pmdbdocno = g_detail_d[l_ac].pmdbdocno
         AND pmdbseq = g_detail_d[l_ac].pmdbseq

      IF NOT cl_null(g_detail_d[l_ac].pspc050) AND NOT cl_null(l_pmdb007) AND
         NOT cl_null(g_detail_d[l_ac].imaa006) AND NOT cl_null(g_detail_d[l_ac].pspc034) THEN
         CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,g_detail_d[l_ac].imaa006,l_pmdb007,g_detail_d[l_ac].pspc034)
              RETURNING l_success,g_detail_d[l_ac].pspc034
      END IF
      LET g_detail_d[l_ac].imaa006 = l_pmdb007

#      IF NOT cl_null(g_detail_d[l_ac].pspc050) AND NOT cl_null(l_imaa006) THEN
#         IF NOT cl_null(g_detail_d[l_ac].imaa006) AND NOT cl_null(g_detail_d[l_ac].pspc034) THEN
#            CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,g_detail_d[l_ac].imaa006,l_imaa006,g_detail_d[l_ac].pspc034)
#                 RETURNING l_success,g_detail_d[l_ac].pspc034
#         END IF
#         IF NOT cl_null(l_pmdb007)  THEN
#            IF NOT cl_null(g_detail_d[l_ac].pmdb006) THEN
#               CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,l_pmdb007,l_imaa006,g_detail_d[l_ac].pmdb006)
#                    RETURNING l_success,g_detail_d[l_ac].pmdb006
#            END IF
#            IF NOT cl_null(g_detail_d[l_ac].pmdb049) THEN
#               CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,l_pmdb007,l_imaa006,g_detail_d[l_ac].pmdb049)
#                    RETURNING l_success,g_detail_d[l_ac].pmdb049
#            END IF
#         END IF
#      END IF
#      LET g_detail_d[l_ac].imaa006 = l_imaa006

#      LET l_imaf174 = ''
#      SELECT (imaf171+imaf172+imaf173+imaf174) INTO l_imaf174
#        FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = g_detail_d[l_ac].pspc050
#      IF cl_null(l_imaf174) THEN LET l_imaf174 = '0' END IF
#      IF NOT cl_null(g_ooef008) AND NOT cl_null(g_ooef009) AND NOT cl_null(g_detail_d[l_ac].pspc045) AND NOT cl_null(l_imaf174) THEN 
#         CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_detail_d[l_ac].pspc045,0,l_imaf174)
#              RETURNING g_detail_d[l_ac].pspc045
#      END IF


      #end add-point
      
      CALL apsp650_detail_show()      
 
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
   FREE apsp650_sel
   
   LET l_ac = 1
   CALL apsp650_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp650.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp650_fetch()
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
 
{<section id="apsp650.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp650_detail_show()
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
 
{<section id="apsp650.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp650_filter()
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
   
   #151209-00022#6     2015/12/16 By earl  add s
      LET INT_FLAG = 0
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #add-point:ui_dialog段construct
      CONSTRUCT g_wc_filter ON pmdbdocno,pmdbseq,
                               pspc050,pspc051,
                               imaa009,imaf141,pmdb007,
                               pmdb006,pspc034,pmdb049,pmdb030,pspc045,
                               imaf142,imae012,pspc054,pspc055,pspc056,
                               pspc001,pspc002,pspc004
           FROM s_detail1[1].b_pmdbdocno,s_detail1[1].b_pmdbseq,
                s_detail1[1].b_pspc050,s_detail1[1].b_pspc051,
                s_detail1[1].b_imaa009,s_detail1[1].b_imaf141,s_detail1[1].b_imaa006,
                s_detail1[1].b_pmdb006,s_detail1[1].b_pspc034,s_detail1[1].b_pmdb049,s_detail1[1].b_pmdb030,s_detail1[1].b_pspc045,
                s_detail1[1].b_imaf142,s_detail1[1].b_imae012,s_detail1[1].b_pspc054,s_detail1[1].b_pspc055,s_detail1[1].b_pspc056,
                s_detail1[1].b_pspc001,s_detail1[1].b_pspc002,s_detail1[1].b_pspc004
               
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD b_pmdbdocno  #請購單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdadocno()
            DISPLAY g_qryparam.return1 TO b_pmdbdocno
            NEXT FIELD b_pmdbdocno
            
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
            
         ON ACTION controlp INFIELD b_pspc055  #產生單號(變更單)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdadocno()
            DISPLAY g_qryparam.return1 TO b_pspc055
            NEXT FIELD b_pspc055
            
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
   #151209-00022#6     2015/12/16 By earl  add e
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp650_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp650.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp650_filter_parser(ps_field)
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
 
{<section id="apsp650.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp650_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsp650_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp650.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 轉變更
# Memo...........:
# Usage..........: CALL apsp650_batch_execute()
# Input parameter: no
# Return code....: no
# Date & Author..: 140512 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp650_batch_execute()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE la_param  RECORD
    prog     STRING,
    param    DYNAMIC ARRAY OF STRING
             END RECORD
DEFINE l_str          STRING               #開啟apmt410傳入的參數
DEFINE l_success      LIKE type_t.num5
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_pmdbdocno    LIKE pmdb_t.pmdbdocno
DEFINE l_pmdc  RECORD  #請購變更單單頭頭檔
    pmdcent    LIKE pmdc_t.pmdcent,    #企業編號
    pmdcsite   LIKE pmdc_t.pmdcsite,   #營運據點
    pmdcdocno  LIKE pmdc_t.pmdcdocno,  #請購單號
    pmdcdocdt  LIKE pmdc_t.pmdcdocdt,  #請購日期
    pmdcacti   LIKE pmdc_t.pmdcacti,   #請購單結案否
    pmdc001	   LIKE pmdc_t.pmdc001,	   #版次
    pmdc002	   LIKE pmdc_t.pmdc002,	   #請購人員
    pmdc003	   LIKE pmdc_t.pmdc003,	   #請購部門
    pmdc004	   LIKE pmdc_t.pmdc004,	   #單價為必要輸入
    pmdc005	   LIKE pmdc_t.pmdc005,	   #幣別
    pmdc006	   LIKE pmdc_t.pmdc006,	   #預算控管否
    pmdc007	   LIKE pmdc_t.pmdc007,	   #費用部門
    pmdc008	   LIKE pmdc_t.pmdc008,	   #請購總未稅金額
    pmdc009	   LIKE pmdc_t.pmdc009,	   #請購總含稅金額
    pmdc010	   LIKE pmdc_t.pmdc010,	   #稅別
    pmdc011	   LIKE pmdc_t.pmdc011,	   #稅率
    pmdc012	   LIKE pmdc_t.pmdc012,	   #單價含稅否
    pmdc020	   LIKE pmdc_t.pmdc020,	   #納入 MPS/MRP計算
    pmdc021	   LIKE pmdc_t.pmdc021,	   #運送方式
    pmdc022	   LIKE pmdc_t.pmdc022,	   #備註
    pmdc200	   LIKE pmdc_t.pmdc200,	   #來源類型
    pmdc201	   LIKE pmdc_t.pmdc201,	   #採購類型
    pmdc202	   LIKE pmdc_t.pmdc202,	   #所屬品類
    pmdc203	   LIKE pmdc_t.pmdc203,	   #需求組織
    pmdc204	   LIKE pmdc_t.pmdc204,	   #採購中心
    pmdc205	   LIKE pmdc_t.pmdc205,	   #配送中心
    pmdc206	   LIKE pmdc_t.pmdc206,	   #配送倉
    pmdc207	   LIKE pmdc_t.pmdc207,	   #到貨日期
    pmdc208	   LIKE pmdc_t.pmdc208,	   #包裝總數量
    pmdc900	   LIKE pmdc_t.pmdc900,	   #變更序
    pmdc901	   LIKE pmdc_t.pmdc901,	   #變更類型
    pmdc902	   LIKE pmdc_t.pmdc902,	   #變更日期
    pmdcownid  LIKE pmdc_t.pmdcownid,  #資料所有者
    pmdcowndp  LIKE pmdc_t.pmdcowndp,  #資料所屬部門
    pmdccrtid  LIKE pmdc_t.pmdccrtid,  #資料建立者
    pmdccrtdp  LIKE pmdc_t.pmdccrtdp,  #資料建立部門
    pmdccrtdt  LIKE pmdc_t.pmdccrtdt,  #資料創建日
    pmdcstus   LIKE pmdc_t.pmdcstus    #狀態碼
           END RECORD
DEFINE l_pmdd  RECORD  #請購變更單明細檔
    pmddent    LIKE pmdd_t.pmddent,    #企業編號
    pmddsite   LIKE pmdd_t.pmddsite,   #營運據點
    pmdddocno  LIKE pmdd_t.pmdddocno,  #請購單號
    pmddseq    LIKE pmdd_t.pmddseq,    #請購項次
    pmdd001    LIKE pmdd_t.pmdd001,    #來源單號
    pmdd002    LIKE pmdd_t.pmdd002,    #來源項次
    pmdd003    LIKE pmdd_t.pmdd003,    #來源項序
    pmdd004    LIKE pmdd_t.pmdd004,    #料件編號
    pmdd005    LIKE pmdd_t.pmdd005,    #產品特徵
    pmdd006    LIKE pmdd_t.pmdd006,    #需求數量
    pmdd007    LIKE pmdd_t.pmdd007,    #單位
    pmdd008    LIKE pmdd_t.pmdd008,    #參考數量
    pmdd009    LIKE pmdd_t.pmdd009,    #參考單位
    pmdd010    LIKE pmdd_t.pmdd010,    #計價數量
    pmdd011    LIKE pmdd_t.pmdd011,    #計價單位
    pmdd012    LIKE pmdd_t.pmdd012,    #包裝容器
    pmdd014    LIKE pmdd_t.pmdd014,    #供應商選擇方式
    pmdd015    LIKE pmdd_t.pmdd015,    #供應商編號
    pmdd016    LIKE pmdd_t.pmdd016,    #付款條件
    pmdd017    LIKE pmdd_t.pmdd017,    #交易條件
    pmdd018    LIKE pmdd_t.pmdd018,    #稅率
    pmdd019    LIKE pmdd_t.pmdd019,    #參考單價
    pmdd020    LIKE pmdd_t.pmdd020,    #參考未稅金額
    pmdd021    LIKE pmdd_t.pmdd021,    #參考含稅金額
    pmdd030    LIKE pmdd_t.pmdd030,    #需求日期
    pmdd031    LIKE pmdd_t.pmdd031,    #理由碼	
    pmdd032    LIKE pmdd_t.pmdd032,    #單身結案否
    pmdd033    LIKE pmdd_t.pmdd033,    #緊急度
    pmdd034    LIKE pmdd_t.pmdd034,    #專案編號
    pmdd035    LIKE pmdd_t.pmdd035,    #WBS
    pmdd036    LIKE pmdd_t.pmdd036,    #活動編號
    pmdd037    LIKE pmdd_t.pmdd037,    #收貨據點
    pmdd038    LIKE pmdd_t.pmdd038,    #收貨庫位
    pmdd039    LIKE pmdd_t.pmdd039,    #收貨儲位
    pmdd040    LIKE pmdd_t.pmdd040,    #no use
    pmdd041    LIKE pmdd_t.pmdd041,    #允許部份交貨
    pmdd042    LIKE pmdd_t.pmdd042,    #允許提前交貨
    pmdd043    LIKE pmdd_t.pmdd043,    #保稅
    pmdd044    LIKE pmdd_t.pmdd044,    #納入MRP
    pmdd045    LIKE pmdd_t.pmdd045,    #交期凍結否
    pmdd046    LIKE pmdd_t.pmdd046,    #費用部門
    pmdd048    LIKE pmdd_t.pmdd048,    #收貨時段
    pmdd049    LIKE pmdd_t.pmdd049,    #已轉採購量
    pmdd050    LIKE pmdd_t.pmdd050,    #備註
    pmdd200    LIKE pmdd_t.pmdd200,    #商品條碼
    pmdd201    LIKE pmdd_t.pmdd201,    #包裝單位
    pmdd202    LIKE pmdd_t.pmdd202,    #整包裝數
    pmdd203    LIKE pmdd_t.pmdd203,    #配送中心
    pmdd204    LIKE pmdd_t.pmdd204,    #配送倉庫
    pmdd205    LIKE pmdd_t.pmdd205,    #採購中心
    pmdd206    LIKE pmdd_t.pmdd206,    #採購員
    pmdd207    LIKE pmdd_t.pmdd207,    #採購類型
    pmdd208    LIKE pmdd_t.pmdd208,    #經營方式
    pmdd209    LIKE pmdd_t.pmdd209,    #結算方式
    pmdd210    LIKE pmdd_t.pmdd210,    #促銷開始日
    pmdd211    LIKE pmdd_t.pmdd211,    #促銷結束日
    pmdd212    LIKE pmdd_t.pmdd212,    #要貨件數
    pmdd250    LIKE pmdd_t.pmdd250,    #合理庫存
    pmdd251    LIKE pmdd_t.pmdd251,    #最高庫存
    pmdd252    LIKE pmdd_t.pmdd252,    #現有庫存
    pmdd253    LIKE pmdd_t.pmdd253,    #在途量
    pmdd254    LIKE pmdd_t.pmdd254,    #前一週銷量
    pmdd255    LIKE pmdd_t.pmdd255,    #前二週銷量
    pmdd256    LIKE pmdd_t.pmdd256,    #前三週銷量
    pmdd257    LIKE pmdd_t.pmdd257,    #前四週銷量
    pmdd258    LIKE pmdd_t.pmdd258,    #前五週銷量
    pmdd259    LIKE pmdd_t.pmdd259,    #週平均銷量
    pmdd900    LIKE pmdd_t.pmdd900,    #變更序
    pmdd901    LIKE pmdd_t.pmdd901     #變更類型
           END RECORD
DEFINE l_pspc  RECORD
    pspc045    LIKE pspc_t.pspc045,
    pspc034    LIKE pspc_t.pspc034,
    pspc001    LIKE pspc_t.pspc001,
    pspc002    LIKE pspc_t.pspc002,
    pspc004    LIKE pspc_t.pspc004
           END RECORD
DEFINE l_pmdb008      LIKE pmdb_t.pmdb008
DEFINE l_pmdb010      LIKE pmdb_t.pmdb010
DEFINE l_pmdb020      LIKE pmdb_t.pmdb020
DEFINE l_pmdb021      LIKE pmdb_t.pmdb021
DEFINE l_rate         LIKE ooan_t.ooan005
DEFINE l_money        LIKE xrcd_t.xrcd113
DEFINE l_xrcd104      LIKE xrcd_t.xrcd104
DEFINE l_xrcd113      LIKE xrcd_t.xrcd113
DEFINE l_xrcd114      LIKE xrcd_t.xrcd114
DEFINE l_xrcd115      LIKE xrcd_t.xrcd115 
   #160608-00013#3 20160621 add by ming -----(S)  
   DEFINE l_pspc002   LIKE pspc_t.pspc002 
   DEFINE l_max_pspc002 LIKE pspc_t.pspc002 
   #160608-00013#3 20160621 add by ming -----(E) 
 
   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
   END IF
   
   #160608-00013#3 20160621 add by ming -----(S) 
   LET l_pspc002 = '' 
   SELECT DISTINCT pspc002 INTO l_pspc002 
     FROM apsp650_tmp 
     
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
   CALL s_azzi902_get_gzzd('apsp650',"lbl_pmdbdocno") RETURNING g_coll_title[1],g_coll_title[1]  #請購單號
   LET l_success = TRUE
   LET l_tot_success = TRUE
   LET l_str = ''
   
   LET g_sql = " SELECT pmdbseq,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,pmdb007,pmdb008,pmdb009, ",
               "        pmdb010,pmdb011,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,pmdb018,pmdb019,pmdb020, ",
               "        pmdb021,pmdb030,pmdb031,pmdb032,pmdb033,pmdb034,pmdb035,pmdb036,pmdb037,pmdb038, ",
               "        pmdb039,pmdb040,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,pmdb046,pmdb048,pmdb049, ",
               "        pmdb050,pmdb200,pmdb201,pmdb202,pmdb203,pmdb204,pmdb205,pmdb206,pmdb207,pmdb208, ",
               "        pmdb209,pmdb210,pmdb211,pmdb212,pmdb250,pmdb251,pmdb252,pmdb253,pmdb254,pmdb255, ",
               "        pmdb256,pmdb257,pmdb258,pmdb259 ",
               "   FROM pmdb_t ",
               "  WHERE pmdbent = '",g_enterprise,"' AND pmdbdocno = ? "
   PREPARE apsp650_pmdb_sel FROM g_sql
   DECLARE apsp650_pmdb_curs CURSOR FOR apsp650_pmdb_sel
   
   LET l_pmdbdocno = ''
   DECLARE apsp650_cur CURSOR FOR
      SELECT DISTINCT pmdbdocno FROM apsp650_tmp
   FOREACH apsp650_cur INTO l_pmdbdocno
   
      IF NOT l_success THEN
         LET l_tot_success = FALSE
         LET l_success = TRUE
      END IF

      INITIALIZE l_pmdc.* TO NULL
      LET l_pmdc.pmdcent   = g_enterprise
      LET l_pmdc.pmdcsite  = g_site
      LET l_pmdc.pmdcdocno = l_pmdbdocno
      LET l_pmdc.pmdcdocdt = g_today
      LET l_pmdc.pmdcacti  = "N"
      LET l_pmdc.pmdcownid = g_user
      LET l_pmdc.pmdcowndp = g_dept
      LET l_pmdc.pmdccrtid = g_user
      LET l_pmdc.pmdccrtdp = g_dept 
      LET l_pmdc.pmdccrtdt = cl_get_current()
      LET l_pmdc.pmdcstus = "N"
      #[C:變更序] = [T:請購變更單單頭檔].[C:變更序]在加1
      LET l_pmdc.pmdc900 = "0"
      SELECT MAX(pmdc900)+1 INTO l_pmdc.pmdc900
        FROM pmdc_t
       WHERE pmdcent = g_enterprise
         AND pmdcdocno = l_pmdc.pmdcdocno
      IF cl_null(l_pmdc.pmdc900) OR l_pmdc.pmdc900 = 0 THEN
         LET l_pmdc.pmdc900 = 1
      END IF
      LET l_pmdc.pmdc004 = "N"
      LET l_pmdc.pmdc012 = "N"  
      LET l_pmdc.pmdc020 = "Y"
      LET l_pmdc.pmdc901 = 'Y'
      LET l_pmdc.pmdc902 = g_today

      SELECT UNIQUE pmda001,pmda002,pmda003,pmda004,pmda005,pmda006,pmda007,pmda008,pmda009,pmda010,
                    pmda011,pmda012,pmda020,pmda021,pmda022,pmda200,pmda201,pmda202,pmda203,pmda204,
                    pmda205,pmda206,pmda207,pmda208
        INTO l_pmdc.pmdc001,l_pmdc.pmdc002,l_pmdc.pmdc003,l_pmdc.pmdc004,l_pmdc.pmdc005,
             l_pmdc.pmdc006,l_pmdc.pmdc007,l_pmdc.pmdc008,l_pmdc.pmdc009,l_pmdc.pmdc010,
             l_pmdc.pmdc011,l_pmdc.pmdc012,l_pmdc.pmdc020,l_pmdc.pmdc021,l_pmdc.pmdc022,
             l_pmdc.pmdc200,l_pmdc.pmdc201,l_pmdc.pmdc202,l_pmdc.pmdc203,l_pmdc.pmdc204,
             l_pmdc.pmdc205,l_pmdc.pmdc206,l_pmdc.pmdc207,l_pmdc.pmdc208
      FROM pmda_t
      WHERE pmdaent = g_enterprise
        AND pmdadocno = l_pmdc.pmdcdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pmda_t'
         LET g_errparam.coll_vals[1] = l_pmdc.pmdcdocno
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF
        
      INSERT INTO pmdc_t(pmdcent,pmdcsite,pmdcdocno,pmdcdocdt,pmdcacti,pmdc001,pmdc002,pmdc003,pmdc004,pmdc005,
                         pmdc006,pmdc007,pmdc008,pmdc009,pmdc010,pmdc011,pmdc012,pmdc020,pmdc021,pmdc022,
                         pmdc200,pmdc201,pmdc202,pmdc203,pmdc204,pmdc205,pmdc206,pmdc207,pmdc208,pmdc900,
                         pmdc901,pmdc902,pmdcownid,pmdcowndp,pmdccrtid,pmdccrtdp,pmdccrtdt,pmdcstus)
                  VALUES(l_pmdc.pmdcent,l_pmdc.pmdcsite,l_pmdc.pmdcdocno,l_pmdc.pmdcdocdt,l_pmdc.pmdcacti,
                         l_pmdc.pmdc001,l_pmdc.pmdc002,l_pmdc.pmdc003,l_pmdc.pmdc004,l_pmdc.pmdc005,
                         l_pmdc.pmdc006,l_pmdc.pmdc007,l_pmdc.pmdc008,l_pmdc.pmdc009,l_pmdc.pmdc010,
                         l_pmdc.pmdc011,l_pmdc.pmdc012,l_pmdc.pmdc020,l_pmdc.pmdc021,l_pmdc.pmdc022,
                         l_pmdc.pmdc200,l_pmdc.pmdc201,l_pmdc.pmdc202,l_pmdc.pmdc203,l_pmdc.pmdc204,
                         l_pmdc.pmdc205,l_pmdc.pmdc206,l_pmdc.pmdc207,l_pmdc.pmdc208,l_pmdc.pmdc900,
                         l_pmdc.pmdc901,l_pmdc.pmdc902,l_pmdc.pmdcownid,l_pmdc.pmdcowndp,
                         l_pmdc.pmdccrtid,l_pmdc.pmdccrtdp,l_pmdc.pmdccrtdt,l_pmdc.pmdcstus)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pmdc_t'
         LET g_errparam.coll_vals[1] = l_pmdc.pmdcdocno
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF

      IF cl_null(l_str) THEN
         LET l_str = " (pmdcdocno = '",l_pmdc.pmdcdocno,"' AND pmdc900 = '",l_pmdc.pmdc900,"') "
      ELSE
         LET l_str = l_str," OR (pmdcdocno = '",l_pmdc.pmdcdocno,"' AND pmdc900 = '",l_pmdc.pmdc900,"') "
      END IF

      INITIALIZE l_pmdd.* TO NULL
	   LET l_pmdd.pmddent   = l_pmdc.pmdcent
	   LET l_pmdd.pmddsite  = l_pmdc.pmdcsite
	   LET l_pmdd.pmdddocno = l_pmdc.pmdcdocno
      LET l_pmdd.pmdd900   = l_pmdc.pmdc900
      LET l_pmdd.pmdd901   = '2'   #單身變更類型
      FOREACH apsp650_pmdb_curs USING l_pmdc.pmdcdocno 
         INTO l_pmdd.pmddseq,l_pmdd.pmdd001,l_pmdd.pmdd002,l_pmdd.pmdd003,l_pmdd.pmdd004,
              l_pmdd.pmdd005,l_pmdd.pmdd006,l_pmdd.pmdd007,l_pmdd.pmdd008,l_pmdd.pmdd009,
              l_pmdd.pmdd010,l_pmdd.pmdd011,l_pmdd.pmdd012,l_pmdd.pmdd014,l_pmdd.pmdd015,
              l_pmdd.pmdd016,l_pmdd.pmdd017,l_pmdd.pmdd018,l_pmdd.pmdd019,l_pmdd.pmdd020,
              l_pmdd.pmdd021,l_pmdd.pmdd030,l_pmdd.pmdd031,l_pmdd.pmdd032,l_pmdd.pmdd033,
              l_pmdd.pmdd034,l_pmdd.pmdd035,l_pmdd.pmdd036,l_pmdd.pmdd037,l_pmdd.pmdd038,
              l_pmdd.pmdd039,l_pmdd.pmdd040,l_pmdd.pmdd041,l_pmdd.pmdd042,l_pmdd.pmdd043,
              l_pmdd.pmdd044,l_pmdd.pmdd045,l_pmdd.pmdd046,l_pmdd.pmdd048,l_pmdd.pmdd049,
              l_pmdd.pmdd050,l_pmdd.pmdd200,l_pmdd.pmdd201,l_pmdd.pmdd202,l_pmdd.pmdd203,
              l_pmdd.pmdd204,l_pmdd.pmdd205,l_pmdd.pmdd206,l_pmdd.pmdd207,l_pmdd.pmdd208,
              l_pmdd.pmdd209,l_pmdd.pmdd210,l_pmdd.pmdd211,l_pmdd.pmdd212,l_pmdd.pmdd250,
              l_pmdd.pmdd251,l_pmdd.pmdd252,l_pmdd.pmdd253,l_pmdd.pmdd254,l_pmdd.pmdd255,
              l_pmdd.pmdd256,l_pmdd.pmdd257,l_pmdd.pmdd258,l_pmdd.pmdd259
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sel pmdb_t'
            LET g_errparam.coll_vals[1] = l_pmdc.pmdcdocno
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
                
         #若原請購單上該項次的[C:行狀態]的值為2、3、4時，
         #則將單身的pmdd901(單身變更類型)預設值"4:單身已經結案"，且pmdd032(單身結案否)的值預設為Y
         IF l_pmdd.pmdd032 MATCHES '[234]' THEN
            LET l_pmdd.pmdd901 = '4'   #單身變更類型
            LET l_pmdd.pmdd032 = 'Y'
         END IF
         
         INITIALIZE l_pspc.* TO NULL
         SELECT pspc045,pspc034,pspc001,pspc002,pspc004
           INTO l_pspc.pspc045,l_pspc.pspc034,l_pspc.pspc001,l_pspc.pspc002,l_pspc.pspc004
           FROM apsp650_tmp
          WHERE pmdbdocno = l_pmdd.pmdddocno AND pmdbseq = l_pmdd.pmddseq
         IF NOT cl_null(l_pspc.pspc045) AND l_pspc.pspc045 <> l_pmdd.pmdd030 THEN
            IF NOT apsp650_ins_pmde(l_pmdd.pmdddocno,l_pmdd.pmddseq,l_pmdc.pmdc900,'pmdb030',l_pmdd.pmdd901,l_pmdd.pmdd030,l_pspc.pspc045) THEN
               LET l_success = FALSE
               EXIT FOREACH
            ELSE
               LET l_pmdd.pmdd030 = l_pspc.pspc045
            END IF
         END IF
         IF NOT cl_null(l_pspc.pspc034) AND l_pmdd.pmdd006 <> l_pspc.pspc034 THEN
            IF NOT apsp650_ins_pmde(l_pmdd.pmdddocno,l_pmdd.pmddseq,l_pmdc.pmdc900,'pmdb006',l_pmdd.pmdd901,l_pmdd.pmdd006,l_pspc.pspc034) THEN
               LET l_success = FALSE
               EXIT FOREACH
            ELSE
               LET l_pmdd.pmdd006 = l_pspc.pspc034
            END IF
            IF NOT cl_null(l_pmdd.pmdd009) THEN
               CALL s_aooi250_convert_qty(l_pmdd.pmdd004,l_pmdd.pmdd007,l_pmdd.pmdd009,l_pspc.pspc034) RETURNING l_success,l_pmdb008
               IF NOT apsp650_ins_pmde(l_pmdd.pmdddocno,l_pmdd.pmddseq,l_pmdc.pmdc900,'pmdb008','1',l_pmdd.pmdd008,l_pmdb008) THEN
                  LET l_success = FALSE
                  EXIT FOREACH
               ELSE
                  LET l_pmdd.pmdd008 = l_pmdb008
               END IF
            END IF
            IF NOT cl_null(l_pmdd.pmdd011) THEN
               CALL s_aooi250_convert_qty(l_pmdd.pmdd004,l_pmdd.pmdd007,l_pmdd.pmdd011,l_pspc.pspc034) RETURNING l_success,l_pmdb010
               IF NOT apsp650_ins_pmde(l_pmdd.pmdddocno,l_pmdd.pmddseq,l_pmdc.pmdc900,'pmdb010','1',l_pmdd.pmdd010,l_pmdb010) THEN
                  LET l_success = FALSE
                  EXIT FOREACH
               ELSE
                  LET l_pmdd.pmdd010 = l_pmdb010
               END IF
               LET l_money = l_pmdd.pmdd019 * l_pmdd.pmdd010
               IF NOT cl_null(l_pmdc.pmdc005) THEN
                  CALL s_aooi160_get_exrate('1',g_site,g_today,l_pmdc.pmdc005,g_ooef016,0,'11') RETURNING l_rate
                  IF NOT cl_null(l_pmdc.pmdc010) AND NOT cl_null(l_money) AND NOT cl_null(l_pmdd.pmdd010) AND NOT cl_null(l_rate) THEN
                     CALL s_tax_count(g_site,l_pmdc.pmdc010,l_money,l_pmdd.pmdd010,l_pmdc.pmdc005,l_rate)
                          RETURNING l_pmdb020,l_xrcd104,l_pmdb021,l_xrcd113,l_xrcd114,l_xrcd115
                     IF NOT apsp650_ins_pmde(l_pmdd.pmdddocno,l_pmdd.pmddseq,l_pmdc.pmdc900,'pmdb020','1',l_pmdd.pmdd020,l_pmdb020) THEN
                        LET l_success = FALSE
                        EXIT FOREACH
                     ELSE
                        LET l_pmdd.pmdd020 = l_pmdb020
                     END IF
                     IF NOT apsp650_ins_pmde(l_pmdd.pmdddocno,l_pmdd.pmddseq,l_pmdc.pmdc900,'pmdb021','1',l_pmdd.pmdd021,l_pmdb021) THEN
                        LET l_success = FALSE
                        EXIT FOREACH
                     ELSE
                        LET l_pmdd.pmdd021 = l_pmdb021
                     END IF
                  END IF
               END IF
            END IF

            UPDATE pspc_t SET pspc054 = 'Y',
                              pspc055 = l_pmdd.pmdddocno,
                              pspc056 = l_pmdd.pmddseq
             WHERE pspcent = g_enterprise
               AND pspcsite = g_site
               AND pspc001 = l_pspc.pspc001
               AND pspc002 = l_pspc.pspc002
               AND pspc004 = l_pspc.pspc004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'upd pspc_t'
               LET g_errparam.coll_vals[1] = l_pmdc.pmdcdocno
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
         END IF

         INSERT INTO pmdd_t(pmddent,pmddsite,pmdddocno,pmddseq,pmdd001,pmdd002,pmdd003,pmdd004,pmdd005,
                            pmdd006,pmdd007,pmdd008,pmdd009,pmdd010,pmdd011,pmdd012,pmdd014,pmdd015,pmdd016,
                            pmdd017,pmdd018,pmdd019,pmdd020,pmdd021,pmdd030,pmdd031,pmdd032,pmdd033,pmdd034,
                            pmdd035,pmdd036,pmdd037,pmdd038,pmdd039,pmdd040,pmdd041,pmdd042,pmdd043,pmdd044,
                            pmdd045,pmdd046,pmdd048,pmdd049,pmdd050,pmdd200,pmdd201,pmdd202,pmdd203,pmdd204,
                            pmdd205,pmdd206,pmdd207,pmdd208,pmdd209,pmdd210,pmdd211,pmdd212,pmdd250,pmdd251,
                            pmdd252,pmdd253,pmdd254,pmdd255,pmdd256,pmdd257,pmdd258,pmdd259,pmdd900,pmdd901)
                     VALUES(l_pmdd.pmddent,l_pmdd.pmddsite,l_pmdd.pmdddocno,l_pmdd.pmddseq,
                            l_pmdd.pmdd001,l_pmdd.pmdd002,l_pmdd.pmdd003,l_pmdd.pmdd004,l_pmdd.pmdd005,
                            l_pmdd.pmdd006,l_pmdd.pmdd007,l_pmdd.pmdd008,l_pmdd.pmdd009,l_pmdd.pmdd010,
                            l_pmdd.pmdd011,l_pmdd.pmdd012,l_pmdd.pmdd014,l_pmdd.pmdd015,l_pmdd.pmdd016,
                            l_pmdd.pmdd017,l_pmdd.pmdd018,l_pmdd.pmdd019,l_pmdd.pmdd020,l_pmdd.pmdd021,
                            l_pmdd.pmdd030,l_pmdd.pmdd031,l_pmdd.pmdd032,l_pmdd.pmdd033,l_pmdd.pmdd034,
                            l_pmdd.pmdd035,l_pmdd.pmdd036,l_pmdd.pmdd037,l_pmdd.pmdd038,l_pmdd.pmdd039,
                            l_pmdd.pmdd040,l_pmdd.pmdd041,l_pmdd.pmdd042,l_pmdd.pmdd043,l_pmdd.pmdd044,
                            l_pmdd.pmdd045,l_pmdd.pmdd046,l_pmdd.pmdd048,l_pmdd.pmdd049,l_pmdd.pmdd050,
                            l_pmdd.pmdd200,l_pmdd.pmdd201,l_pmdd.pmdd202,l_pmdd.pmdd203,l_pmdd.pmdd204,
                            l_pmdd.pmdd205,l_pmdd.pmdd206,l_pmdd.pmdd207,l_pmdd.pmdd208,l_pmdd.pmdd209,
                            l_pmdd.pmdd210,l_pmdd.pmdd211,l_pmdd.pmdd212,l_pmdd.pmdd250,l_pmdd.pmdd251,
                            l_pmdd.pmdd252,l_pmdd.pmdd253,l_pmdd.pmdd254,l_pmdd.pmdd255,l_pmdd.pmdd256,
                            l_pmdd.pmdd257,l_pmdd.pmdd258,l_pmdd.pmdd259,l_pmdd.pmdd900,l_pmdd.pmdd901)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins pmdd_t'
            LET g_errparam.coll_vals[1] = l_pmdc.pmdcdocno
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH

      LET l_pmdbdocno = ''
   END FOREACH   

   CALL cl_err_collect_show()

   IF NOT l_success OR NOT l_tot_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      IF NOT cl_null(l_str) THEN
         LET la_param.prog = 'apmt410'
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
# Usage..........: CALL apsp650_pspc001_ref()
# Input parameter: no
# Return code....: no
# Date & Author..: 140702 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp650_pspc001_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = tm.pspc001
   CALL ap_ref_array2(g_ref_fields,"SELECT pscal003 FROM pscal_t WHERE pscalent='"||g_enterprise||"' AND pscalsite='"||g_site||"' AND pscal001=? AND pscal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   DISPLAY g_rtn_fields[1] TO pspc001_desc
END FUNCTION

################################################################################
# Descriptions...: 請購變更歷程檔
# Memo...........:
# Usage..........: CALL apsp650_ins_pmde(p_pmdbdocno,p_pmdbseq,p_pmdc900,p_pmde002,p_pmde003,p_pmde004,p_pmde005)
# Input parameter: p_pmdbdocno
#                : p_pmdbseq
#                : p_pmdc900   變更序
#                : p_pmde002   變更欄位
#                : p_pmde003   變更類型
#                : p_pmde004   變更前內容
#                : p_pmde005   變更後內容
# Return code....: TRUE OR FALSE
# Date & Author..: 140708 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp650_ins_pmde(p_pmdbdocno,p_pmdbseq,p_pmdc900,p_pmde002,p_pmde003,p_pmde004,p_pmde005)
DEFINE p_pmdbdocno LIKE pmdb_t.pmdbdocno
DEFINE p_pmdbseq   LIKE pmdb_t.pmdbseq
DEFINE p_pmdc900   LIKE pmdc_t.pmdc900   #變更序
DEFINE p_pmde002   LIKE pmde_t.pmde002   #變更欄位
DEFINE p_pmde003   LIKE pmde_t.pmde003   #變更類型
DEFINE p_pmde004   LIKE pmde_t.pmde004   #變更前內容
DEFINE p_pmde005   LIKE pmde_t.pmde005   #變更後內容
DEFINE l_pmde006   LIKE pmde_t.pmde006   #最後變更時間
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_pmde006 = cl_get_current()
   
   DELETE FROM pmde_t
    WHERE pmdeent = g_enterprise
      AND pmdedocno = p_pmdbdocno
      AND pmde001 = p_pmdc900
      AND pmdeseq = p_pmdbseq
      AND pmde002 = p_pmde002
   
   INSERT INTO pmde_t (pmdeent,pmdesite,pmdedocno,pmdeseq,pmde001,pmde002,pmde003,pmde004,pmde005,pmde006,pmde007,pmdeownid,pmdeowndp,pmdecrtid,pmdecrtdp,pmdecrtdt)
     VALUES (g_enterprise,g_site,p_pmdbdocno,p_pmdbseq,p_pmdc900,p_pmde002,p_pmde003,p_pmde004,p_pmde005,l_pmde006,'',g_user,g_dept,g_user,g_dept,l_pmde006)       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins pmde_t'
      LET g_errparam.coll_vals[1] = p_pmdbdocno
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 一張請購單有未確認的變更單存在
# Memo...........:
# Usage..........: CALL apsp650_chk()
#                  RETURNING r_success
# Input parameter: no
# Return code....: TRUE OR FALSE
# Date & Author..: 141016 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp650_chk()
DEFINE r_success  LIKE type_t.num5
DEFINE l_count    LIKE type_t.num5

   LET r_success = TRUE
   LET l_count = ''
   SELECT COUNT(pmdcdocno) INTO l_count
     FROM pmdc_t
    WHERE pmdcent = g_enterprise
      AND pmdcdocno = g_detail_d[g_detail_idx].pmdbdocno
      AND pmdcstus = 'N'
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      LET r_success = FALSE
   END IF
   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
