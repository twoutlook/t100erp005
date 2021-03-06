#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp600.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2016-10-06 11:18:19), PR版次:0021(2016-12-29 15:21:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000272
#+ Filename...: apsp600
#+ Description: APS產生請購單作業
#+ Creator....: 04441(2014-04-28 10:56:41)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsp600.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#50 2016/04/26 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息 
#160512-00016#4  2016/05/20 by ming     增加欄位 保稅否 
#160601-00032#1  2016/06/06 by ming     把來源訂單(pspc018)放到庫存管理特徵pmdb054
#160608-00013#3  2016/06/20 By ming     執行process時，先檢查有無新版本，有的話，跳出錯誤訊息「該APS版本：%1已有新一版本資料，請重新查詢後再進行處理」 
#160902-00037#1  2016/09/26 By dorislai pspc002 的條件換用MAX(psea002)
#160825-00037#1  2016/10/06 By dorislai 多加上選項：將需求來源訂單放到庫存管理特徵，Y的時候，才把來源訂單(pspc018)放到庫存管理特徵(pmdb054)
#161202-00004#1  2016/12/29 By dorislai 新增在勾選資料時，將資料LCOK，若資料已被其他人LOCK，跳出錯誤訊息提示
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
       pspc050           LIKE pspc_t.pspc050,   #料件編號
       pspc050_desc      LIKE type_t.chr80,     #品名
       pspc050_desc_desc LIKE type_t.chr80,     #規格
       pspc051           LIKE pspc_t.pspc051,   #產品特徵
       pspc051_desc      LIKE type_t.chr500,
       #160512-00016#4 20160520 add by ming -----(S) 
       pspc062           LIKE pspc_t.pspc062,   #保稅否 
       #160512-00016#4 20160520 add by ming -----(E) 
       imaa009           LIKE imaa_t.imaa009,   #產品分類
       imaa009_desc      LIKE type_t.chr80,     #說明
       imaf141           LIKE imaf_t.imaf141,   #採購分類
       imaf141_desc      LIKE type_t.chr80,     #說明
       pspc034           LIKE pspc_t.pspc034,   #建議採購量 
       #ming 20150629 add -------------------------------------(S) 
       qty               LIKE pspc_t.pspc034,   #本次採購數量 
       #ming 20150629 add -------------------------------------(E) 
       #ming 151116-00010#1 20151117 add ----------------------(S) 
       imaf143           LIKE imaf_t.imaf143,   #採購單位 
       imaf143_desc      LIKE type_t.chr80,     #說明 
       #ming 151116-00010#1 20151117 add ----------------------(E) 
       pspc014           LIKE pspc_t.pspc014,   #單位
       pspc014_desc      LIKE type_t.chr80,     #說明
       pspc010           LIKE pspc_t.pspc010,   #建議行動日
       pspc045           LIKE pspc_t.pspc045,   #需求日
       pspc018           LIKE pspc_t.pspc018,   #需求單號
       imaf142           LIKE imaf_t.imaf142,   #採購員
       imaf142_desc      LIKE type_t.chr80,     #全名
       imae012           LIKE imae_t.imae012,   #計畫員
       imae012_desc      LIKE type_t.chr80,     #全名
       #ming 20150629 add ----------------------------------(S) 
       pspc061           LIKE pspc_t.pspc061,   #已轉數量 
       #ming 20150629 add ----------------------------------(E) 
       pspc055           LIKE pspc_t.pspc055,   #產生單號
       pspc056           LIKE pspc_t.pspc056,   #項次
       pspc004           LIKE pspc_t.pspc004,   #APS虛擬單號
       pspc001           LIKE pspc_t.pspc001,   #APS版本
       pspc001_desc      LIKE pscal_t.pscal003,
       pspc002           LIKE pspc_t.pspc002,   #執行日期時間 
       imaf016           LIKE imaf_t.imaf016,   #生命週期狀態 
       imaf016_desc      LIKE oocql_t.oocql004, #生命週期狀態 
       bmif009           LIKE bmif_t.bmif009,   #承認狀態 
       bmif009_desc      LIKE oocql_t.oocql004, #承認狀態  
       bmif012           LIKE bmif_t.bmif012    #承認文號 
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
       wc                STRING,                #QBE
       pspc001           LIKE pspc_t.pspc001,   #APS版本
       pspc001_desc      LIKE pscal_t.pscal003,
       ooba002           LIKE ooba_t.ooba002,   #請購單別
       ooba002_desc      LIKE oobal_t.oobal004,
       chk1              LIKE type_t.chr1,      #計畫員
       chk2              LIKE type_t.chr1,      #採購員
       chk3              LIKE type_t.chr1,      #產品分類
       chk4              LIKE type_t.chr1,      #採購分類
       chk5              LIKE type_t.chr1,      #將需求來源訂單放到庫存管理特徵  #160825-00037#1-add
       chk               LIKE type_t.chr1       #顯示已轉單資料
                     END RECORD

DEFINE g_detail2_cnt        LIKE type_t.num5              #單身2 總筆數
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail2_idx        LIKE type_t.num5
DEFINE g_pspc002            LIKE pspc_t.pspc002   #161202-00004#1-add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="apsp600.main" >}
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
      OPEN WINDOW w_apsp600 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp600_init()   
 
      #進入選單 Menu (="N")
      CALL apsp600_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp600
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_apsp600_tmp_drop()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp600.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp600_init()
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
   
   CALL cl_set_combo_scc('b_pspa020','5440')
   
   LET tm.chk1 = 'N'
   LET tm.chk2 = 'N'
   LET tm.chk3 = 'N'
   LET tm.chk4 = 'N'
   LET tm.chk5 = 'N'  #160825-00037#1-add
   LET tm.chk  = 'N'
   LET g_detail_idx  = 1
   LET g_detail2_idx = 1

   CALL s_apsp600_tmp_create()

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp600.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp600_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE ls_return    STRING
   DEFINE ls_result    STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_qty_o      LIKE pspc_t.pspc034  #ming 20150629 add
   DEFINE l_pspc001_o  LIKE pspc_t.pspc001
   DEFINE l_ooba002_o  LIKE ooba_t.ooba002
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   #161202-00004#1-s-add
   DEFINE l_sql              STRING
   DEFINE l_pspc001          LIKE pspc_t.pspc001 
   DEFINE l_pspc002          LIKE pspc_t.pspc002
   DEFINE l_pspc004          LIKE pspc_t.pspc004
   #161202-00004#1-e-add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_detail2_cnt = g_detail2_d.getLength()
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #161202-00004#1-s-add
   CALL apsp600_cre_tmp()       
   CALL s_transaction_begin()
   #--檢查是否有被LOCK
   LET l_sql = " SELECT pspc001,pspc002,pspc004 FROM pspc_t ",
               "  WHERE pspcent = ? ",
               "    AND pspcsite='",g_site,"'",
               "    AND pspc001 = ? ",
               "    AND pspc002 = ? ",
               "    AND pspc004 = ? ",
               "    AND pspc007 = '1' ",  #建議單據(is_new)
               "   FOR UPDATE SKIP LOCKED"
   PREPARE apsp600_chk_lock_pre FROM l_sql
   DECLARE apsp600_chk_lock_curs CURSOR FOR apsp600_chk_lock_pre
   #--LOCK
   LET l_sql = " SELECT pspc001,pspc002,pspc004 FROM pspc_t ",
               "  WHERE pspcent = ? ",
               "    AND pspcsite='",g_site,"'",
               "    AND pspc001 = ? ",
               "    AND pspc002 = ? ",
               "    AND pspc004 = ? ",
               "    AND pspc007 = '1' ",  #建議單據(is_new)
               "   FOR UPDATE "
   DECLARE apsp600_lock_curs CURSOR FROM l_sql 
   #--抓取tmp存的資料
   LET l_sql = " SELECT pspc001,pspc002,pspc004  FROM apsp600_tmp "
   PREPARE apsp600_tmp_pre FROM l_sql
   DECLARE apsp600_tmp_curs CURSOR FOR apsp600_tmp_pre
   #161202-00004#1-e-add
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apsp600_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME tm.wc ON imae012,imaf142,pspc010,pspc045,imaa009,imaf141,pspc050
	   
            BEFORE CONSTRUCT

            AFTER FIELD pspc010                  #行動日
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)

            AFTER FIELD pspc045                  #需求日
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
         INPUT BY NAME tm.pspc001 ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
               LET l_pspc001_o = tm.pspc001
         
            AFTER FIELD pspc001
               IF cl_null(tm.pspc001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aps-00102'
                  LET g_errparam.extend = tm.pspc001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE
                  IF (tm.pspc001 <> l_pspc001_o) OR cl_null(l_pspc001_o) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = tm.pspc001
                     LET g_errshow = TRUE   #160318-00025#50
                     LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"    #160318-00025#50
                     IF NOT cl_chk_exist("v_psca001") THEN
                        LET tm.pspc001 = l_pspc001_o
                        CALL s_apsp600_pspc001_ref(tm.pspc001) RETURNING tm.pspc001_desc
                        DISPLAY BY NAME tm.pspc001,tm.pspc001_desc
                        NEXT FIELD CURRENT
                     END IF
                     CALL s_apsp600_pspc001_ref(tm.pspc001) RETURNING tm.pspc001_desc
                     DISPLAY BY NAME tm.pspc001_desc
                     LET l_pspc001_o = tm.pspc001
                  END IF
               END IF

            ON ACTION controlp INFIELD pspc001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.pspc001
               LET g_qryparam.where = " pscasite = '",g_site,"' "
               CALL q_psca001()
               LET tm.pspc001 = g_qryparam.return1
               CALL s_apsp600_pspc001_ref(tm.pspc001) RETURNING tm.pspc001_desc
               DISPLAY BY NAME tm.pspc001,tm.pspc001_desc
               NEXT FIELD pspc001

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT
         
         #INPUT BY NAME tm.ooba002,tm.chk1,tm.chk2,tm.chk3,tm.chk4,tm.chk        #160825-00037#1-s-mod
         INPUT BY NAME tm.ooba002,tm.chk1,tm.chk2,tm.chk3,tm.chk4,tm.chk5,tm.chk #160825-00037#1-e-mod
            ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
               LET l_ooba002_o = tm.ooba002

            AFTER FIELD ooba002
               LET tm.ooba002_desc = ''
               IF NOT cl_null(tm.ooba002) THEN
                  IF (tm.ooba002 <> l_ooba002_o) OR cl_null(l_ooba002_o) THEN
                     IF NOT s_apsp600_pmdadocno_chk(tm.ooba002) THEN
                        LET tm.ooba002 = l_ooba002_o
                        CALL s_aooi200_get_slip_desc(tm.ooba002) RETURNING tm.ooba002_desc
                        DISPLAY BY NAME tm.ooba002,tm.ooba002_desc
                        NEXT FIELD CURRENT
                     END IF
                     CALL s_aooi200_get_slip_desc(tm.ooba002) RETURNING tm.ooba002_desc
                     DISPLAY BY NAME tm.ooba002_desc
                     LET l_ooba002_o = tm.ooba002
                  END IF
               END IF

            ON ACTION controlp INFIELD ooba002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.ooba002
               LET g_qryparam.arg1 = l_ooef004
               LET g_qryparam.arg2 = 'apmt400'
               CALL q_ooba002_1()
               LET tm.ooba002 = g_qryparam.return1
               CALL s_aooi200_get_slip_desc(tm.ooba002) RETURNING tm.ooba002_desc
               DISPLAY BY NAME tm.ooba002,tm.ooba002_desc
               NEXT FIELD ooba002

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
               LET l_qty_o = g_detail_d[g_detail_idx].qty  #ming 20150630 add
               CALL apsp600_fetch()
            
            ON CHANGE b_sel
               #ming 20150629 modify --------------------------------------------------------------------(S) 
               #IF g_detail_d[g_detail_idx].sel = 'Y' AND NOT cl_null(g_detail_d[g_detail_idx].pspc056) THEN
               IF g_detail_d[g_detail_idx].sel = 'Y' AND
                  g_detail_d[g_detail_idx].pspc034 = g_detail_d[g_detail_idx].pspc061 THEN
               #ming 20150629 modify --------------------------------------------------------------------(E) 
                  CALL cl_ask_pressanykey('aps-00109')
                  LET g_detail_d[g_detail_idx].sel = 'N'
               END IF 
               #161202-00004#1-s-add
               IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                  LET l_pspc001 = ''
                  LET l_pspc002 = ''
                  LET l_pspc004 = ''
                  #檢查是否有被其他使用者使用中
                  EXECUTE apsp600_chk_lock_curs USING g_enterprise,tm.pspc001,g_pspc002,g_detail_d[g_detail_idx].pspc004 
                                                INTO l_pspc001,l_pspc002,l_pspc004
                  IF cl_null(l_pspc001) OR cl_null(l_pspc002) OR cl_null(l_pspc004) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'aps-00201'  #APS虛擬單號：%1，正在被其他使用者處理中
                     LET g_errparam.popup  = TRUE
                     LET g_errparam.replace[1] = g_detail_d[g_detail_idx].pspc004 
                     LET g_detail_d[g_detail_idx].sel = 'N'
                     CALL cl_err()
                     NEXT FIELD b_sel 
                  END IF
                  #寫入tmp
                  INSERT INTO apsp600_tmp VALUES(tm.pspc001,g_pspc002,g_detail_d[g_detail_idx].pspc004)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ins_tmp:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD b_sel
                  END IF
                  #LOCK資料
                  OPEN apsp600_lock_curs USING g_enterprise,tm.pspc001,g_pspc002,g_detail_d[g_detail_idx].pspc004
               ELSE
                  LET g_detail_d[g_detail_idx].sel = 'N'
                  DELETE FROM apsp600_tmp WHERE pspc001=tm.pspc001 AND pspc002=g_pspc002 AND pspc004=g_detail_d[g_detail_idx].pspc004
                  CALL s_transaction_end('Y','0')
                  CLOSE apsp600_lock_curs          #釋放所有LOCK
                  IF s_transaction_chk("N",0) THEN
                     CALL s_transaction_begin()
                  END IF 
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM apsp600_tmp
                   WHERE pspc001=tm.pspc001 AND pspc002=g_pspc002 
                  #重新LOCK
                  IF l_cnt > 0 THEN
                     LET l_pspc001 = ''
                     LET l_pspc002 = ''
                     LET l_pspc004 = ''
                     FOREACH apsp600_tmp_curs INTO l_pspc001,l_pspc002,l_pspc004
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "apsp600_tmp_curs:",SQLERRMESSAGE 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           EXIT FOREACH
                        END IF
                        OPEN apsp600_lock_curs USING g_enterprise,l_pspc001,l_pspc002,l_pspc004
                     END FOREACH
                  END IF
               END IF
               #161202-00004#1-e-add
            #ming 20150629 add -------------------------------(S)
            AFTER FIELD b_qty
               IF NOT cl_null(g_detail_d[g_detail_idx].qty) THEN
                  IF g_detail_d[g_detail_idx].qty <= 0 THEN
                     #數量不可小於等於0
                     IF g_detail_d[g_detail_idx].pspc034 <> g_detail_d[g_detail_idx].pspc061 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'ade-00016'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_detail_d[g_detail_idx].qty = l_qty_o
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #本次請購數量不可大於建議數量-已轉數量！
                  IF g_detail_d[g_detail_idx].qty >
                     (g_detail_d[g_detail_idx].pspc034 - g_detail_d[g_detail_idx].pspc061) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'aps-00137'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_detail_d[g_detail_idx].qty = l_qty_o
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET l_qty_o = g_detail_d[g_detail_idx].qty
            #ming 20150629 add -------------------------------(E) 
 
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
            CALL cl_err_collect_init()  #161202-00004#1-add
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               #161202-00004#1-s-add(搬下方的ming 20150629 modify)
               IF g_detail_d[li_idx].pspc034 = g_detail_d[li_idx].pspc061 THEN
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
               #161202-00004#1-e-add
               #161202-00004#1-s-add
               LET l_pspc001 = ''
               LET l_pspc002 = ''
               LET l_pspc004 = ''
               #檢查是否有被其他使用者使用中
               EXECUTE apsp600_chk_lock_curs USING g_enterprise,tm.pspc001,g_pspc002,g_detail_d[li_idx].pspc004 
                                             INTO l_pspc001,l_pspc002,l_pspc004
               IF cl_null(l_pspc001) OR cl_null(l_pspc002) OR cl_null(l_pspc004) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'aps-00201'  #APS虛擬單號：%1，正在被其他使用者處理中
                  LET g_errparam.popup  = TRUE
                  LET g_errparam.replace[1] = g_detail_d[li_idx].pspc004 
                  LET g_detail_d[li_idx].sel = 'N'
                  CALL cl_err()
               ELSE
                  #寫入tmp
                  INSERT INTO apsp600_tmp VALUES(tm.pspc001,g_pspc002,g_detail_d[li_idx].pspc004)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ins_tmp:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD b_sel
                  END IF
                  #LOCK資料
                  OPEN apsp600_lock_curs USING g_enterprise,tm.pspc001,g_pspc002,g_detail_d[li_idx].pspc004
               END IF
               #161202-00004#1-e-add
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            #FOR li_idx = 1 TO g_detail_d.getLength()  #161202-00004#1-mark
               #161202-00004#1-s-mark 移至上方
               ##ming 20150629 modify ----------------------------(S) 
               ##IF NOT cl_null(g_detail_d[li_idx].pspc056) THEN
               ##   LET g_detail_d[li_idx].sel = "N"
               ##END IF
               #IF g_detail_d[li_idx].pspc034 = g_detail_d[li_idx].pspc061 THEN
               #   LET g_detail_d[li_idx].sel = 'N'
               #END IF
               ##ming 20150629 modify ----------------------------(E) 
               #161202-00004#1-e-mark
            #END FOR  #161202-00004#1-mark
            CALL cl_err_collect_show()  #161202-00004#1-add
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               #161202-00004#1-s-add
               DELETE FROM apsp600_tmp WHERE pspc001=tm.pspc001 AND pspc002=g_pspc002 AND pspc004=g_detail_d[li_idx].pspc004
               #161202-00004#1-e-add
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            #161202-00004#1-s-add
            CALL s_transaction_end('Y','0')
            CLOSE apsp600_lock_curs          #釋放所有LOCK
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF 
            #161202-00004#1-e-add
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
               #ming 20150629 modify ---------------------------(S) 
               #IF NOT cl_null(g_detail_d[li_idx].pspc056) THEN
               #   LET g_detail_d[li_idx].sel = "N"
               #END IF
               IF g_detail_d[li_idx].pspc034 = g_detail_d[li_idx].pspc061 THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
               #ming 20150629 modify ---------------------------(E) 
               #161202-00004#1-s-add
               IF g_detail_d[li_idx].sel = 'Y' THEN
                  LET l_pspc001 = ''
                  LET l_pspc002 = ''
                  LET l_pspc004 = ''
                  #檢查是否有被其他使用者使用中
                  EXECUTE apsp600_chk_lock_curs USING g_enterprise,tm.pspc001,g_pspc002,g_detail_d[li_idx].pspc004 
                                                INTO l_pspc001,l_pspc002,l_pspc004
                  IF cl_null(l_pspc001) OR cl_null(l_pspc002) OR cl_null(l_pspc004) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'aps-00201'  #APS虛擬單號：%1，正在被其他使用者處理中
                     LET g_errparam.popup  = TRUE
                     LET g_errparam.replace[1] = g_detail_d[li_idx].pspc004 
                     LET g_detail_d[li_idx].sel = 'N'
                     CALL cl_err()
                     NEXT FIELD b_sel
                  END IF
                  #寫入tmp
                  INSERT INTO apsp600_tmp VALUES(tm.pspc001,g_pspc002,g_detail_d[li_idx].pspc004)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ins_tmp:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD b_sel
                  END IF
                  #LOCK資料
                  OPEN apsp600_lock_curs USING g_enterprise,tm.pspc001,g_pspc002,g_detail_d[li_idx].pspc004
               END IF
               #161202-00004#1-e-add
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
            #161202-00004#1-s-add
            CALL s_transaction_end('Y','0')
            CLOSE apsp600_lock_curs          #釋放所有LOCK
            FOR li_idx = 1 TO g_detail_d.getLength()
               #檢查是否存在tmp中
               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt FROM apsp600_tmp
                WHERE pspc001=tm.pspc001 AND pspc002=g_pspc002  AND pspc004=g_detail_d[li_idx].pspc004
               IF l_cnt > 0 THEN
                  #N->刪除資料；Y->重新LOCK
                  IF g_detail_d[li_idx].sel = "N" THEN
                     #檢查是否存在tmp中，存在的話需刪除tmp的資料(表示畫面上已經勾選掉了，但tmp資料沒刪掉)
                     DELETE FROM apsp600_tmp WHERE pspc001=tm.pspc001 AND pspc002=g_pspc002 AND pspc004=g_detail_d[li_idx].pspc004
                  ELSE
                     IF s_transaction_chk("N",0) THEN
                        CALL s_transaction_begin()
                     END IF  
                     #重新LOCK
                     OPEN apsp600_lock_curs USING g_enterprise,tm.pspc001,g_pspc002,g_detail_d[li_idx].pspc004
                  END IF
               END IF
            END FOR
            #161202-00004#1-e-add
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apsp600_filter()
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
            CALL apsp600_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            LET g_wc_filter   = " 1=1"
            LET g_wc_filter_t = " 1=1"
            CALL apsp600_b_fill()

            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp600_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL s_transaction_end('Y','0')  #161202-00004#1-add
            DELETE FROM s_apsp600_tmp
            LET l_cnt = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = 'Y' THEN
                  LET l_cnt = l_cnt + 1
                  INSERT INTO s_apsp600_tmp
                       VALUES(g_detail_d[li_idx].pspc001,g_detail_d[li_idx].pspc002,
                              g_detail_d[li_idx].pspc004,g_detail_d[li_idx].pspc014,
                              #160601-00032#1 20160606 add by ming -----(S) 
                              g_detail_d[li_idx].pspc018,
                              #160601-00032#1 20160606 add by ming -----(E) 
                              #ming 20150630 modify -------------------------(S)
                              #g_detail_d[li_idx].pspc034,g_detail_d[li_idx].pspc045,
                              g_detail_d[li_idx].qty,g_detail_d[li_idx].pspc045,
                              #ming 20150630 modify -------------------------(E)
                              g_detail_d[li_idx].pspc050,g_detail_d[li_idx].pspc051, 
                              #160512-00016#4 20160523 add by ming -----(S) 
                              g_detail_d[li_idx].pspc062, 
                              #160512-00016#4 20160523 add by ming -----(E) 
                              g_detail_d[li_idx].imaa009,g_detail_d[li_idx].imaf141,
                              g_detail_d[li_idx].imaf142,g_detail_d[li_idx].imae012)
               END IF
            END FOR
            IF l_cnt = 0 THEN
               CALL cl_ask_pressanykey('-400')
            ELSE
               IF cl_null(tm.ooba002) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00122'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD ooba002
               ELSE
                  CALL apsp600_process()
                  CALL apsp600_b_fill()
               END IF
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
 
{<section id="apsp600.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp600_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   #20151104 by stellar add ----- (S)
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   #20151104 by stellar add ----- (E)
   #end add-point
        
   LET g_error_show = 1
   CALL apsp600_b_fill()
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
 
{<section id="apsp600.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp600_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_imaa006       LIKE imaa_t.imaa006
   DEFINE l_imaf174       LIKE imaf_t.imaf174
   DEFINE l_bmif011       LIKE bmif_t.bmif011
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sql           STRING
#   DEFINE l_ooef008       LIKE ooef_t.ooef008
#   DEFINE l_ooef009       LIKE ooef_t.ooef009

   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #161202-00004#1-s-add
   #抓取執行日期時間
   SELECT MAX(pspc002) INTO g_pspc002
    FROM pspc_t
   WHERE pspcent = g_enterprise
     AND pspcsite= g_site
     AND pspc001 = tm.pspc001
     AND pspc007 = '1'
   #161202-00004#1-e-add
#   LET l_ooef008 = ''
#   LET l_ooef009 = ''
#   SELECT ooef008,ooef009
#     INTO l_ooef008,l_ooef009
#     FROM ooef_t
#    WHERE ooefent = g_enterprise
#      AND ooef001 = g_site

   IF cl_null(tm.wc) THEN LET tm.wc = '1=1' END IF
   IF cl_null(g_wc_filter) THEN LET g_wc_filter = " 1=1 " END IF  #151209-00022#2 by whitney add

   #ming 20150629 modify ------------------------------------(S) 
   #IF tm.chk = 'N' THEN
   #   LET tm.wc = tm.wc CLIPPED," AND (pspc054 = 'N' OR pspc054 IS NULL) "
   #END IF
   IF tm.chk = 'N' THEN
      LET tm.wc = tm.wc CLIPPED," AND (pspc034 > NVL(pspc061,0) ) "
   #ELSE
   #   LET tm.wc = tm.wc CLIPPED," AND (pspc034 = NVL(pspc061,0) ) "
   END IF
   #ming 20150629 modify ------------------------------------(E) 

   #ming 151116-00010#1 20151117 modify -----(S) 
   #160512-00016#4 20160523 modify by ming -----(S) 
   #LET g_sql = " SELECT 'N',pspc050,'','',pspc051,'',imaa009,'',imaf141,'',NVL(pspc034,0),'', ",
   LET g_sql = " SELECT 'N',pspc050,'','',pspc051,'',COALESCE(pspc062,'N'),imaa009,'',imaf141,'',NVL(pspc034,0),'', ",
   #160512-00016#4 20160523 modify by ming -----(E)    
               "        imaf143,(SELECT oocal003 FROM oocal_t ",
               "                  WHERE oocalent = '",g_enterprise,"' ",
               "                    AND oocal001 = imaf143 ",
               "                    AND oocal002 = '",g_dlang,"'), ",
               "        pspc014,'',pspc010,pspc045, ",
               "        pspc018,imaf142,'',imae012,'',NVL(pspc061,0),pspc055,pspc056,pspc004,pspc001,'',pspc002, ",
               "        '','','','','' ",
               "   FROM pspc_t ",
               "        LEFT OUTER JOIN imae_t ON imaeent = pspcent AND imaesite = pspcsite AND imae001 = pspc050 ",
               "        LEFT OUTER JOIN imaf_t ON imafent = pspcent AND imafsite = pspcsite AND imaf001 = pspc050 ",
               "        LEFT OUTER JOIN imaa_t ON imaaent = pspcent AND imaa001 = pspc050 ",
               "  WHERE pspcent = ? ",
               "    AND pspcsite = '",g_site,"' ",
               "    AND pspc001 = '",tm.pspc001,"' ",
               #160902-00037#1-s-add
               #"    AND pspc002 = (SELECT MAX(pspc002) FROM pspc_t WHERE pspcent = ",g_enterprise," AND pspcsite = '",g_site,"' AND pspc001 = '",tm.pspc001,"') ",
               "    AND pspc002 = (SELECT MAX(psea002) FROM psea_t WHERE pseaent = ",g_enterprise," AND pseasite = '",g_site,"' AND psea001 = '",tm.pspc001,"') ",
               #160902-00037#1-e-add
               "    AND pspc007 = '1' ",
               "    AND ",tm.wc CLIPPED,
               "    AND ",g_wc_filter CLIPPED,  #151209-00022#2 by whitney add
               "  ORDER BY pspc050 "
   #ming 151116-00010#1 20151117 modify -----(E) 

   #end add-point
 
   PREPARE apsp600_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp600_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].pspc050,g_detail_d[l_ac].pspc050_desc,g_detail_d[l_ac].pspc050_desc_desc,
   #160512-00016#4 20160523 modify by ming -----(S) 
   #g_detail_d[l_ac].pspc051,g_detail_d[l_ac].pspc051_desc,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc, 
   g_detail_d[l_ac].pspc051,g_detail_d[l_ac].pspc051_desc,
   g_detail_d[l_ac].pspc062,
   g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,
   #160512-00016#4 20160523 modify by ming -----(E) 
   g_detail_d[l_ac].imaf141,g_detail_d[l_ac].imaf141_desc,g_detail_d[l_ac].pspc034,g_detail_d[l_ac].qty,
   #ming 151116-00010#1 20151117 modify -----(S) 
   g_detail_d[l_ac].imaf143,g_detail_d[l_ac].imaf143_desc,
   #ming 151116-00010#1 20151117 modify -----(E) 
   g_detail_d[l_ac].pspc014,g_detail_d[l_ac].pspc014_desc,g_detail_d[l_ac].pspc010,g_detail_d[l_ac].pspc045,
   g_detail_d[l_ac].pspc018,g_detail_d[l_ac].imaf142,g_detail_d[l_ac].imaf142_desc,g_detail_d[l_ac].imae012,
   g_detail_d[l_ac].imae012_desc,g_detail_d[l_ac].pspc061,g_detail_d[l_ac].pspc055,g_detail_d[l_ac].pspc056,
   g_detail_d[l_ac].pspc004,g_detail_d[l_ac].pspc001,g_detail_d[l_ac].pspc001_desc,g_detail_d[l_ac].pspc002,
   g_detail_d[l_ac].imaf016,g_detail_d[l_ac].imaf016_desc,g_detail_d[l_ac].bmif009,
   g_detail_d[l_ac].bmif009_desc,g_detail_d[l_ac].bmif012
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

#      LET l_imaa006 = ''
#      SELECT imaa006 INTO l_imaa006
#        FROM imaa_t
#       WHERE imaaent = g_enterprise
#         AND imaa001 = g_detail_d[l_ac].pspc050
#      IF NOT cl_null(g_detail_d[l_ac].pspc050) AND NOT cl_null(g_detail_d[l_ac].pspc014) AND NOT cl_null(l_imaa006) AND NOT cl_null(g_detail_d[l_ac].pspc034) THEN
#         CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,g_detail_d[l_ac].pspc014,l_imaa006,g_detail_d[l_ac].pspc034)
#              RETURNING l_success,g_detail_d[l_ac].pspc034
#      END IF

#      LET l_imaf174 = ''
#      SELECT (imaf171+imaf172+imaf173+imaf174) INTO l_imaf174
#        FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = g_detail_d[l_ac].pspc050
#      IF cl_null(l_imaf174) OR l_imaf174 = 0 THEN
#         LET g_detail_d[l_ac].date = g_detail_d[l_ac].pspc045
#      ELSE
#         LET l_imaf174 = -l_imaf174
#         CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,g_detail_d[l_ac].pspc045,0,l_imaf174)
#              RETURNING g_detail_d[l_ac].date
#      END IF


      #取得料件生命週期 
      SELECT imaf016 INTO g_detail_d[l_ac].imaf016
        FROM imaf_t
       WHERE imafent  = g_enterprise 
         AND imafsite = g_site 
         AND imaf001  = g_detail_d[l_ac].pspc050

      #取得abmt410的承認資料 
      #先取得最後承認日期 
      LET l_bmif011 = ''
      SELECT MAX(bmif011) INTO l_bmif011
        FROM bmif_t
       WHERE bmifent = g_enterprise
         AND bmif001 = g_detail_d[l_ac].pspc050

      #檢查最後的日期是否有多筆以上 有的話要找最後修改的 才是真正的最後日期 
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM bmif_t
       WHERE bmifent = g_enterprise
         AND bmif001 = g_detail_d[l_ac].pspc050
         AND bmif011 = l_bmif011

      LET l_sql = "SELECT bmif009,bmif012 ",
                  "  FROM bmif_t ",
                  " WHERE bmifent = '",g_enterprise,"' ",
                  "   AND bmif001 = '",g_detail_d[l_ac].pspc050,"' ", 
                  "   AND bmif011 = '",l_bmif011,"' "
      IF l_cnt > 1 THEN
         LET l_sql = l_sql ," AND bmifmoddt = (SELECT MAX(bmifmoddt) ",
                            "                    FROM bmif_t ",
                            "                   WHERE bmifent = '",g_enterprise,"' ",
                            "                     AND bmif001 = '",g_detail_d[l_ac].pspc050,"' ",
                            "                     AND bmif011 = '",l_bmif011,"' ) "
      END IF

      PREPARE apsp600_get_bmif_prep FROM l_sql
      EXECUTE apsp600_get_bmif_prep INTO g_detail_d[l_ac].bmif009,
                                         g_detail_d[l_ac].bmif012  
      
      #151124-00006#1 20151124 mark by ming -----(S)       
      #由於數量已經是採購數量了，所以不必做數量的轉換 
      ##ming 151116-00010#1 20151117 add -----(S) 
      ##如果pspc_t的單位與採購單位都有值的話，才能做單位數量的轉換 
      #IF (NOT cl_null(g_detail_d[l_ac].imaf143)) AND
      #   (NOT cl_null(g_detail_d[l_ac].pspc014)) THEN
      #
      #   #轉換建議採購量 
      #   CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,
      #                              g_detail_d[l_ac].pspc014,
      #                              g_detail_d[l_ac].imaf143,
      #                              g_detail_d[l_ac].pspc034)
      #        RETURNING l_success,g_detail_d[l_ac].pspc034
      #
      #   #轉換已轉數量 
      #   CALL s_aooi250_convert_qty(g_detail_d[l_ac].pspc050,
      #                              g_detail_d[l_ac].pspc014,
      #                              g_detail_d[l_ac].imaf143,
      #                              g_detail_d[l_ac].pspc061)
      #        RETURNING l_success,g_detail_d[l_ac].pspc061
      #END IF
      #
      ##ming 151116-00010#1 20151117 add -----(E) 
      #151124-00006#1 20151124 mark by ming -----(E) 
      
      #ming 20150629 add ------------------------------------(S) 
      LET g_detail_d[l_ac].qty = g_detail_d[l_ac].pspc034 - g_detail_d[l_ac].pspc061
      #ming 20150629 add ------------------------------------(E)  
      
      #end add-point
      
      CALL apsp600_detail_show()      
 
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
   
   #ming 20150707 add -----------------------------(S) 
   IF g_detail_idx > l_ac -1 THEN
      LET g_detail_idx = l_ac - 1
   END IF
   #ming 20150707 add -----------------------------(E) 
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apsp600_sel
   
   LET l_ac = 1
   CALL apsp600_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   #161202-00004#1-s-add
   CALL s_transaction_end('Y','0')  
   IF s_transaction_chk("N",0) THEN
      CALL s_transaction_begin()
   END IF 
   #161202-00004#1-e-add
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp600.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp600_fetch()
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
   
   #20151104 by stellar add ----- (S)
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      LET g_detail_idx = l_ac
   END IF
   #20151104 by stellar add ----- (E)

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
 
{<section id="apsp600.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp600_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"

      #料號說明
      CALL s_desc_get_item_desc(g_detail_d[l_ac].pspc050) RETURNING g_detail_d[l_ac].pspc050_desc,g_detail_d[l_ac].pspc050_desc_desc

      #產品分類
      CALL s_desc_get_rtaxl003_desc(g_detail_d[l_ac].imaa009) RETURNING g_detail_d[l_ac].imaa009_desc

      #採購分類
      CALL s_desc_get_acc_desc('203',g_detail_d[l_ac].imaf141) RETURNING g_detail_d[l_ac].imaf141_desc

      #單位
      CALL s_desc_get_unit_desc(g_detail_d[l_ac].pspc014) RETURNING g_detail_d[l_ac].pspc014_desc

      #採購員
      CALL s_desc_get_person_desc(g_detail_d[l_ac].imaf142) RETURNING g_detail_d[l_ac].imaf142_desc

      #計畫員
      CALL s_desc_get_person_desc(g_detail_d[l_ac].imae012) RETURNING g_detail_d[l_ac].imae012_desc 
      
      #生命週期狀態 
      CALL s_desc_get_acc_desc('210',g_detail_d[l_ac].imaf016) RETURNING g_detail_d[l_ac].imaf016_desc 

      #承認狀態 
      CALL s_desc_get_acc_desc('1116',g_detail_d[l_ac].bmif009) RETURNING g_detail_d[l_ac].bmif009_desc 
      
      #APS版本
      CALL s_apsp600_pspc001_ref(g_detail_d[l_ac].pspc001) RETURNING g_detail_d[l_ac].pspc001_desc
      
      #產品特徵
      CALL s_feature_description(g_detail_d[l_ac].pspc050,g_detail_d[l_ac].pspc051)
           RETURNING l_success,g_detail_d[l_ac].pspc051_desc
      
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp600.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp600_filter()
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
   LET l_ac = 1
   LET g_detail_cnt = 1
   
   CONSTRUCT g_wc_filter ON pspc050,pspc051,imaa009,imaf141,pspc034,imaf143,pspc014,
                            pspc010,pspc045,pspc018,imaf142,imae012,pspc061,pspc055,
                            pspc056,pspc004,pspc001,pspc002,imaf016,bmif009,bmif012
        FROM s_detail1[1].b_pspc050,s_detail1[1].b_pspc051,s_detail1[1].b_imaa009,
             s_detail1[1].b_imaf141,s_detail1[1].b_pspc034,s_detail1[1].b_imaf143,
             s_detail1[1].b_pspc014,s_detail1[1].b_pspc010,s_detail1[1].b_pspc045,
             s_detail1[1].b_pspc018,s_detail1[1].b_imaf142,s_detail1[1].b_imae012,
             s_detail1[1].b_pspc061,s_detail1[1].b_pspc055,s_detail1[1].b_pspc056,
             s_detail1[1].b_pspc004,s_detail1[1].b_pspc001,s_detail1[1].b_pspc002,
             s_detail1[1].b_imaf016,s_detail1[1].b_bmif009,s_detail1[1].b_bmif012

      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_pspc050        #料件編號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaf001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_pspc050  #顯示到畫面上
         NEXT FIELD b_pspc050                     #返回原欄位    
         
      ON ACTION controlp INFIELD b_imaa009        #產品分類
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_rtax001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
         NEXT FIELD b_imaa009                     #返回原欄位
         
      ON ACTION controlp INFIELD b_imaf141        #採購分類
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imce141()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaf141  #顯示到畫面上
         NEXT FIELD b_imaf141                     #返回原欄位
       
      ON ACTION controlp INFIELD b_imaf143        #單位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooca001_1()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaf143  #顯示到畫面上
         NEXT FIELD b_imaf143                     #返回原欄位
       
      ON ACTION controlp INFIELD b_pspc014        #單位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooca001_1()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_pspc014  #顯示到畫面上
         NEXT FIELD b_pspc014                     #返回原欄位
       
      ON ACTION controlp INFIELD b_pspc018        #需求單號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pspc018()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_pspc018  #顯示到畫面上
         NEXT FIELD b_pspc018                     #返回原欄位
      
      ON ACTION controlp INFIELD b_imaf142        #採購員
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaf142  #顯示到畫面上
         NEXT FIELD b_imaf142                     #返回原欄位
         
      ON ACTION controlp INFIELD b_imae012        #計畫員
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imae012  #顯示到畫面上
         NEXT FIELD b_imae012                     #返回原欄位
       
      ON ACTION controlp INFIELD b_pspc055        #產生單號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pspc055()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_pspc055  #顯示到畫面上
         NEXT FIELD b_pspc055                     #返回原欄位
       
      ON ACTION controlp INFIELD b_pspc004        #APS虛擬單號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pspc004()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_pspc004  #顯示到畫面上
         NEXT FIELD b_pspc004                     #返回原欄位
       
      ON ACTION controlp INFIELD b_pspc001        #APS版本
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = " pscasite = '",g_site,"' "
         CALL q_psca001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_pspc001  #顯示到畫面上
         NEXT FIELD b_pspc001                     #返回原欄位
       
      ON ACTION controlp INFIELD b_imaf016        #生命週期狀態
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = '210'
         LET g_qryparam.where = " oocqstus = 'Y' "
         CALL q_oocq002()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaf016  #顯示到畫面上
         NEXT FIELD b_imaf016                     #返回原欄位
       
      ON ACTION controlp INFIELD b_bmif009        #承認狀態
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = "1116"
         CALL q_oocq002()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_bmif009  #顯示到畫面上
         NEXT FIELD b_bmif009                     #返回原欄位
       
      ON ACTION controlp INFIELD b_bmif012        #承認文號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = "1116"
         CALL q_bmia015()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_bmif012  #顯示到畫面上
         NEXT FIELD b_bmif012                     #返回原欄位
        
   END CONSTRUCT

   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp600_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp600.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp600_filter_parser(ps_field)
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
 
{<section id="apsp600.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp600_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsp600_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp600.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 轉請購
# Memo...........:
# Usage..........: CALL apsp600_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 140502 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp600_process()
DEFINE ls_js        STRING
DEFINE la_param  RECORD
    prog     STRING,
    param    DYNAMIC ARRAY OF STRING
             END RECORD
DEFINE l_success    LIKE type_t.num5
DEFINE l_str        STRING 
   #160608-00013#3 20160620 add by ming -----(S) 
   DEFINE l_pspc002     LIKE pspc_t.pspc002 
   DEFINE l_max_pspc002 LIKE pspc_t.pspc002 
   #160608-00013#3 20160620 add by ming -----(E) 

   #160608-00013#3 20160620 add by ming -----(S) 
   LET l_pspc002 = '' 
   SELECT DISTINCT pspc002 INTO l_pspc002 
     FROM s_apsp600_tmp; 
     
   LET l_max_pspc002 = '' 
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
   #160608-00013#3 20160620 add by ming -----(E) 

   LET l_success = TRUE
   LET l_str = ''
   CALL s_transaction_begin()
   
   #160825-00037#1-s-mod
   #CALL s_apsp600_batch_execute(tm.ooba002,'N',tm.chk1,tm.chk2,tm.chk3,tm.chk4) RETURNING l_success,l_str  
   CALL s_apsp600_batch_execute(tm.ooba002,'N',tm.chk1,tm.chk2,tm.chk3,tm.chk4,tm.chk5) RETURNING l_success,l_str  
   #160825-00037#1-e-mod
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
      IF NOT cl_null(l_str) THEN
         LET l_str = ' pmdadocno IN ( ',l_str,') '
         LET la_param.prog = 'apmt400'
         LET la_param.param[1] = ''
         LET la_param.param[2] = l_str
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
      END IF
   ELSE
      CALL s_transaction_end('N','0')
   END IF

   IF g_bgjob = "N" THEN
      #前景作業完成處理
      CALL cl_ask_confirm3("std-00012","")
   END IF

END FUNCTION

################################################################################
# Descriptions...: 建立tmp
# Memo...........:
# Usage..........: CALL apsp600_cre_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/29 By dorislai (#161202-00004#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp600_cre_tmp()
   DROP TABLE apsp600_tmp
   CREATE TEMP TABLE apsp600_tmp(
      pspc001   LIKE  pspc_t.pspc001,  #APS版本 
      pspc002   LIKE  pspc_t.pspc002,  #執行日期時間
      pspc004   LIKE  pspc_t.pspc004   #工單編號
   )
END FUNCTION

#end add-point
 
{</section>}
 
