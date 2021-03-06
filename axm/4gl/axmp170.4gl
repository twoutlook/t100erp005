#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp170.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-07-18 09:22:51), PR版次:0007(2016-12-07 08:47:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: axmp170
#+ Description: 銷售預測自動產生作業
#+ Creator....: 03079(2015-03-17 16:37:52)
#+ Modifier...: 06814 -SD/PR- 08993
 
{</section>}
 
{<section id="axmp170.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#53 2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160727-00019#23 2016/08/04 By 08742   系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                      Mod  axmp170_ooed004_t  --> axmp170_tmp01， axmp170_basic_data--> axmp170_tmp02
#                                      Mod  axmp170_time_group --> axmp170_tmp03， axmp170_item_t10--> axmp170_tmp04
#                                      Mod  axmp170_alpha_beta --> axmp170_tmp05， p170_fore_item_t--> axmp170_tmp06
#                                      Mod  axmp170_chkdate_t  --> axmp170_tmp07， axmp170_fore_data--> axmp170_tmp08
#161013-00051#1  2016/10/18  By shiun  整批調整據點組織開窗
#161109-00085#11 2016/11/10  By 08993  整批調整系統星號寫法
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
                        sel           LIKE type_t.chr1,
                        xmid004       LIKE xmid_t.xmid004,     #預測營運據點  
                        xmid004_desc  LIKE type_t.chr500,
                        xmid005       LIKE xmid_t.xmid005,     #銷售組織 
                        xmid005_desc  LIKE type_t.chr500,
                        xmid006       LIKE xmid_t.xmid006,     #業務員  
                        xmid006_desc  LIKE type_t.chr500,
                        xmid010       LIKE xmid_t.xmid010,     #通路  
                        xmid010_desc  LIKE type_t.chr500,      # 
                        xmid009       LIKE xmid_t.xmid009,     #客戶 
                        xmid009_desc  LIKE type_t.chr500,      # 
                        xmid007       LIKE xmid_t.xmid007,     #預測料號 
                        xmid007_desc  LIKE type_t.chr500,      #品名 
                        xmid007_desc_1 LIKE type_t.chr500,    #規格 
                        xmid008      LIKE xmid_t.xmid008,     #產品特徵  
                        xmid008_desc  LIKE type_t.chr500,
                        xmid014      LIKE xmid_t.xmid014,     #單位 
                        xmid014_desc LIKE type_t.chr500,      # 
                        xmid015_01   LIKE xmid_t.xmid015,     #預測數量  
                        bdate_01     LIKE xmic_t.xmic002,
                        edate_01     LIKE xmic_t.xmic002,
                        xmid015_02   LIKE xmid_t.xmid015,     #期別2數量  
                        bdate_02     LIKE xmic_t.xmic002,
                        edate_02     LIKE xmic_t.xmic002,
                        xmid015_03   LIKE xmid_t.xmid015,     #期別3數量  
                        bdate_03     LIKE xmic_t.xmic002,
                        edate_03     LIKE xmic_t.xmic002,
                        xmid015_04   LIKE xmid_t.xmid015,     #期別4數量  
                        bdate_04     LIKE xmic_t.xmic002,
                        edate_04     LIKE xmic_t.xmic002,
                        xmid015_05   LIKE xmid_t.xmid015,     #期別5數量 
                        bdate_05     LIKE xmic_t.xmic002,
                        edate_05     LIKE xmic_t.xmic002,
                        xmid015_06   LIKE xmid_t.xmid015,     #期別6數量  
                        bdate_06     LIKE xmic_t.xmic002,
                        edate_06     LIKE xmic_t.xmic002,
                        xmid015_07   LIKE xmid_t.xmid015,     #期別7數量  
                        bdate_07     LIKE xmic_t.xmic002,
                        edate_07     LIKE xmic_t.xmic002,
                        xmid015_08   LIKE xmid_t.xmid015,     #期別8數量  
                        bdate_08     LIKE xmic_t.xmic002,
                        edate_08     LIKE xmic_t.xmic002,
                        xmid015_09   LIKE xmid_t.xmid015,     #期別9數量  
                        bdate_09     LIKE xmic_t.xmic002,
                        edate_09     LIKE xmic_t.xmic002,
                        xmid015_10   LIKE xmid_t.xmid015,     #期別10數量  
                        bdate_10     LIKE xmic_t.xmic002,
                        edate_10     LIKE xmic_t.xmic002,
                        xmid015_11   LIKE xmid_t.xmid015,     #期別11數量  
                        bdate_11     LIKE xmic_t.xmic002,
                        edate_11     LIKE xmic_t.xmic002,
                        xmid015_12   LIKE xmid_t.xmid015,     #期別12數量 
                        bdate_12     LIKE xmic_t.xmic002,
                        edate_12     LIKE xmic_t.xmic002,                        
                        xmid015_13   LIKE xmid_t.xmid015,     #期別13數量  
                        bdate_13     LIKE xmic_t.xmic002,
                        edate_13     LIKE xmic_t.xmic002,
                        xmid015_14   LIKE xmid_t.xmid015,     #期別14數量  
                        bdate_14     LIKE xmic_t.xmic002,
                        edate_14     LIKE xmic_t.xmic002,
                        xmid015_15   LIKE xmid_t.xmid015,     #期別15數量 
                        bdate_15     LIKE xmic_t.xmic002,
                        edate_15     LIKE xmic_t.xmic002,
                        xmid015_16   LIKE xmid_t.xmid015,     #期別16數量  
                        bdate_16     LIKE xmic_t.xmic002,
                        edate_16     LIKE xmic_t.xmic002,
                        xmid015_17   LIKE xmid_t.xmid015,     #期別17數量  
                        bdate_17     LIKE xmic_t.xmic002,
                        edate_17     LIKE xmic_t.xmic002,
                        xmid015_18   LIKE xmid_t.xmid015,     #期別18數量  
                        bdate_18     LIKE xmic_t.xmic002,
                        edate_18     LIKE xmic_t.xmic002,
                        xmid015_19   LIKE xmid_t.xmid015,     #期別19數量  
                        bdate_19     LIKE xmic_t.xmic002,
                        edate_19     LIKE xmic_t.xmic002,
                        xmid015_20   LIKE xmid_t.xmid015,     #期別20數量  
                        bdate_20     LIKE xmic_t.xmic002,
                        edate_20     LIKE xmic_t.xmic002,
                        xmid015_21   LIKE xmid_t.xmid015,     #期別21數量  
                        bdate_21     LIKE xmic_t.xmic002,
                        edate_21     LIKE xmic_t.xmic002,
                        xmid015_22   LIKE xmid_t.xmid015,     #期別22數量  
                        bdate_22     LIKE xmic_t.xmic002,
                        edate_22     LIKE xmic_t.xmic002,
                        xmid015_23   LIKE xmid_t.xmid015,     #期別23數量  
                        bdate_23     LIKE xmic_t.xmic002,
                        edate_23     LIKE xmic_t.xmic002,
                        xmid015_24   LIKE xmid_t.xmid015,     #期別24數量  
                        bdate_24     LIKE xmic_t.xmic002,
                        edate_24     LIKE xmic_t.xmic002,
                        xmid015_s    LIKE xmid_t.xmid015      #總量  
                     END RECORD
TYPE type_master     RECORD
                        wc1          STRING,                  #營運據點 
                        wc2          STRING,                  #產品分類 
                        wc3          STRING,                  #銷售分群 
                        wc4          STRING,                  #預測料號  
                        wc5          STRING,                  #業務員 
                        wc6          STRING,                  #銷售組織 
                        wc7          STRING,                  #客戶 
                        wc8          STRING,                  #通路 
                        type_way     LIKE type_t.chr10,       #預測方式  
                        origin       LIKE type_t.chr10,       #參考資料來源  
                        bdate        LIKE type_t.dat,         #參考資料期間 
                        edate        LIKE type_t.dat,         # 
                        cycle        LIKE type_t.chr10,       #參考資料週期 
                        a1           LIKE type_t.num5,        #季節變動每季___期  
                        a2           LIKE type_t.num5,        #季節變動___季一循環 
                        xmic001      LIKE xmic_t.xmic001,     #預測編號 
                        xmic002      LIKE xmic_t.xmic002      #預測起始日  
                     END RECORD

DEFINE g_master type_master

DEFINE g_browser DYNAMIC ARRAY OF RECORD
                    b_show        LIKE type_t.chr100,     #外顯欄位 
                    b_pid         LIKE type_t.chr100,     #父節點id 
                    b_id          LIKE type_t.chr100,     #本身節點id 
                    b_exp         LIKE type_t.chr100,     #是否展開 
                    b_hasC        LIKE type_t.num5,       #是否有子節點 
                    b_isExp       LIKE type_t.num5,       #是否已展開 
                    b_expcode     LIKE type_t.num5,       #展開值 
                    b_ooed001     LIKE ooed_t.ooed001,    #組織類型  
                    b_ooed002     LIKE ooed_t.ooed002,    #最上層組織 
                    b_ooed003     LIKE ooed_t.ooed003,    #版本 
                    b_ooed004     LIKE ooed_t.ooed004,    #組織編號 
                    b_ooed005     LIKE ooed_t.ooed005     #上級組織編號 
                 END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp170.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL axmp170_create_temp_table() 
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp170 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmp170_init()   
 
      #進入選單 Menu (="N")
      CALL axmp170_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp170
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL axmp170_drop_temp_table() 
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp170.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmp170_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_i     LIKE type_t.num5
   DEFINE l_hide  STRING
   DEFINE l_index LIKE type_t.chr2
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('type_way','4048')     #預測方式  
   CALL cl_set_combo_scc('origin','4049')       #參考資料來源 
   CALL cl_set_combo_scc('cycle','4055')        #參考資料週期  

   LET g_master.type_way = '1'
   LET g_master.origin   = '1'
   LET g_master.cycle    = '3'
   LET g_master.bdate    = ''
   LET g_master.edate    = ''
   LET g_master.xmic002  = '' 
   
   #期別數量全部預設隱藏 
   LET l_hide = ''
   FOR l_i = 1 TO 24
      LET l_index = l_i USING '&&'
      IF l_i = 1 THEN
         LET l_hide = l_hide,"b_xmid015_",l_index
      ELSE
         LET l_hide = l_hide,",b_xmid015_",l_index
      END IF
   END FOR
   CALL cl_set_comp_visible(l_hide,FALSE)

   CALL axmp170_set_entry()
   CALL axmp170_set_no_entry()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp170.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp170_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt    LIKE type_t.num10
   DEFINE l_i      LIKE type_t.num10 
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmp170_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc1 ON xmdasite
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD xmdasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #mod--161013-00051#1 By shiun--(S)
#               CALL q_ooef001_12()
               CALL q_ooef001_1()
               #mod--161013-00051#1 By shiun--(E)
               DISPLAY g_qryparam.return1 TO xmdasite
               NEXT FIELD xmdasite

         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_master.wc2 ON imaa009
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009

         END CONSTRUCT

         CONSTRUCT BY NAME g_master.wc3 ON imaf111
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD imaf111
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcd111()
               DISPLAY g_qryparam.return1 TO imaf111
               NEXT FIELD imaf111

         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_master.wc4 ON imaf125
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD imaf125
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()
               DISPLAY g_qryparam.return1 TO imaf125
               NEXT FIELD imaf125

         END CONSTRUCT

         CONSTRUCT BY NAME g_master.wc5 ON xmda002
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD xmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO xmda002
               NEXT FIELD xmda002

         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_master.wc6 ON ooed004 
            BEFORE CONSTRUCT 
            
            ON ACTION controlp INFIELD ooed004 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = g_today
               CALL q_ooeg001_4()
               DISPLAY g_qryparam.return1 TO ooed004
               NEXT FIELD ooed004
            
         END CONSTRUCT 
         
         CONSTRUCT BY NAME g_master.wc7 ON xmda004
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD xmda004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = g_site
               CALL q_pmaa001_6()
               DISPLAY g_qryparam.return1 TO xmda004
               NEXT FIELD xmda004

         END CONSTRUCT

         CONSTRUCT BY NAME g_master.wc8 ON xmda023
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD xmda023
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160621-00003#3 20160627 modify by beckxie---S
			      #LET g_qryparam.arg1 = "275"
               #CALL q_oocq002()                           #呼叫開窗
               LET g_qryparam.arg1 = '1'
               CALL q_oojd001_1()
               #160621-00003#3 20160627 modify by beckxie---E
               DISPLAY g_qryparam.return1 TO xmda023
               NEXT FIELD xmda023
         END CONSTRUCT 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.type_way,g_master.origin,g_master.bdate,
                       g_master.edate,g_master.cycle,g_master.a1,
                       g_master.a2,g_master.xmic001,g_master.xmic002
               ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD type_way
               CALL axmp170_set_entry()
               CALL axmp170_set_no_entry()

            AFTER FIELD a1     #季節變動每季___期  
               IF NOT cl_null(g_master.a1) THEN
                  IF g_master.a1 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'aim-00003'     #輸入值必須大於0！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD a1
                  END IF
               END IF

            AFTER FIELD a2     #季節變動___季一循環 
               IF NOT cl_null(g_master.a2) THEN
                  IF g_master.a2 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'aim-00003'     #輸入值必須大於0！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD a2
                  END IF
               END IF

            AFTER FIELD xmic001
               IF NOT cl_null(g_master.xmic001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xmic001
                  LET g_errshow = TRUE   #160318-00025#53
                  LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"    #160318-00025#53              
                  IF NOT cl_chk_exist("v_xmia001") THEN
                     NEXT FIELD CURRENT
                  END IF 
                  
                  IF NOT cl_null(g_master.xmic002) THEN
                     IF NOT axmp170_xmic002_chk() THEN
                        NEXT FIELD xmic002
                     END IF
                  END IF
               END IF 
               
            AFTER FIELD xmic002
               IF NOT cl_null(g_master.xmic001) AND NOT cl_null(g_master.xmic002) THEN
                  IF NOT axmp170_xmic002_chk() THEN
                     NEXT FIELD xmic002
                  END IF
               END IF 

            ON ACTION controlp INFIELD xmic001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xmic001
               CALL q_xmia001_1()
               LET g_master.xmic001 = g_qryparam.return1
               DISPLAY BY NAME g_master.xmic001
               NEXT FIELD xmic001
         END INPUT 
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
               ATTRIBUTE(COUNT=g_detail_cnt,WITHOUT DEFAULTS,
                         INSERT ROW = FALSE,
                         DELETE ROW = FALSE,
                         APPEND ROW = FALSE)
            BEFORE INPUT
            BEFORE ROW 
               LET l_ac = DIALOG.getCurrentRow("s_detail1")

               CALL axmp170_show_hint() 
         END INPUT 
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
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
            CALL axmp170_filter()
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
            #檢查畫面上的條件選項是否有輸入完畢  
            #如果沒有全部輸入完，則不可查詢資料 
            IF cl_null(g_master.bdate) OR cl_null(g_master.edate) THEN
               EXIT DIALOG
            END IF

            IF g_master.type_way = '2' THEN
               IF cl_null(g_master.a1) OR cl_null(g_master.a2) THEN
                  EXIT DIALOG
               END IF
            END IF

            IF cl_null(g_master.xmic001) OR cl_null(g_master.xmic002) THEN
               EXIT DIALOG
            END IF 
            
            #檢查日期是否符合預測編號的設定 
            IF NOT axmp170_xmic002_chk() THEN
               NEXT FIELD xmic002
            END IF 
            #end add-point
            CALL axmp170_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axmp170_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_cnt = 0
            FOR l_i = 1 TO g_detail_d.getLength()
               IF g_detail_d[l_i].sel = 'Y' THEN
                  LET l_cnt = l_cnt + 1
               END IF
            END FOR

            IF l_cnt > 0 THEN
               CALL axmp170_create_axmt171()
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
 
{<section id="axmp170.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmp170_query()
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
   CALL axmp170_b_fill()
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
 
{<section id="axmp170.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmp170_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5 
   DEFINE l_xmia002       LIKE xmia_t.xmia002
   DEFINE l_hide          STRING
   DEFINE l_show          STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_index         LIKE type_t.chr2
   DEFINE l_xmid004       LIKE xmid_t.xmid004     #預測營運據點  (單頭)  
   DEFINE l_xmid005       LIKE xmid_t.xmid005     #銷售組織      (單頭)  
   DEFINE l_xmid006       LIKE xmid_t.xmid006     #業務員        (單頭)   
   DEFINE l_xmid007       LIKE xmid_t.xmid007
   DEFINE l_xmid008       LIKE xmid_t.xmid008
   DEFINE l_xmid009       LIKE xmid_t.xmid009
   DEFINE l_xmid010       LIKE xmid_t.xmid010
   DEFINE l_xmid011       LIKE xmid_t.xmid011
   DEFINE l_xmid015       LIKE xmid_t.xmid015 
   DEFINE l_bdate         LIKE xmic_t.xmic002
   DEFINE l_edate         LIKE xmic_t.xmic002
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #取得期別與日期區間資料 
   CALL axmp170_get_interval_group() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF

   #取得基礎資料 
   CALL axmp170_get_data() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF

   #計算最終公式 
   CALL axmp170_get_formula() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   
   
   #先將畫面上的欄位都先隱藏  
   LET l_hide = ''
   FOR l_i = 1 TO 24
      LET l_index = l_i USING '&&'
      IF l_i = 1 THEN
         LET l_hide = l_hide,"xmid015_",l_index
      ELSE
         LET l_hide = l_hide,",b_xmid015_",l_index
      END IF
   END FOR
   CALL cl_set_comp_visible(l_hide,FALSE)

   #取得axmi170的資料，顯示畫面上的數量欄位 
   LET l_xmia002 = ''
   SELECT xmia002 INTO l_xmia002
     FROM xmia_t
    WHERE xmiaent = g_enterprise
      AND xmia001 = g_master.xmic001
   IF cl_null(l_xmia002) THEN
      LET l_xmia002 = 0
   END IF

   LET l_show = ''
   FOR l_i = 1 TO l_xmia002
      LET l_index = l_i USING '&&' 
      IF l_i = 1 THEN
         LET l_show = l_show,"b_xmid015_",l_index
      ELSE
         LET l_show = l_show,",b_xmid015_",l_index
      END IF
   END FOR
   CALL cl_set_comp_visible(l_show,TRUE) 
   
   LET g_sql = "SELECT xmic004,'',xmic005,'',xmic006,'',xmid010,'',xmid009,'', ",
               "       imaa001,'','',xmid008,'',xmid014,'',qty,seq, ",
               "       bdate,edate ",
               "  FROM axmp170_tmp08 ",            #160727-00019#23 Mod  axmp170_fore_data--> axmp170_tmp08
               " WHERE ent = ? ",
               " ORDER BY xmic004,xmic005,xmic006,xmid010,xmid009, ",
               "          imaa001,xmid008,xmid014 " 
   #end add-point
 
   PREPARE axmp170_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmp170_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].xmid004,       g_detail_d[l_ac].xmid004_desc,g_detail_d[l_ac].xmid005,
      g_detail_d[l_ac].xmid005_desc,  g_detail_d[l_ac].xmid006,     g_detail_d[l_ac].xmid006_desc,
      g_detail_d[l_ac].xmid010,       g_detail_d[l_ac].xmid010_desc,g_detail_d[l_ac].xmid009,
      g_detail_d[l_ac].xmid009_desc,  g_detail_d[l_ac].xmid007,     g_detail_d[l_ac].xmid007_desc,
      g_detail_d[l_ac].xmid007_desc_1,g_detail_d[l_ac].xmid008,     g_detail_d[l_ac].xmid008_desc,
      g_detail_d[l_ac].xmid014,       g_detail_d[l_ac].xmid014_desc,l_xmid015,l_xmid011,l_bdate,l_edate
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
      LET g_detail_d[l_ac].sel = 'N'

      IF (g_detail_d[l_ac].xmid004 <> l_xmid004) OR
         (g_detail_d[l_ac].xmid005 <> l_xmid005) OR
         (g_detail_d[l_ac].xmid006 <> l_xmid006) OR
         (g_detail_d[l_ac].xmid007 <> l_xmid007) OR
         (g_detail_d[l_ac].xmid008 <> l_xmid008) OR
         (g_detail_d[l_ac].xmid009 <> l_xmid009) OR
         (g_detail_d[l_ac].xmid010 <> l_xmid010) THEN

      ELSE
         IF l_ac > 1 THEN
            LET l_ac = l_ac - 1
         END IF

         CALL axmp170_chk_xmid015(l_xmid011,l_ac,l_xmid015,l_bdate,l_edate) 
      END IF

      LET l_xmid004 = g_detail_d[l_ac].xmid004
      LET l_xmid005 = g_detail_d[l_ac].xmid005
      LET l_xmid006 = g_detail_d[l_ac].xmid006
      LET l_xmid007 = g_detail_d[l_ac].xmid007
      LET l_xmid008 = g_detail_d[l_ac].xmid008
      LET l_xmid009 = g_detail_d[l_ac].xmid009
      LET l_xmid010 = g_detail_d[l_ac].xmid010
      #end add-point
      
      CALL axmp170_detail_show()      
 
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
   FREE axmp170_sel
   
   LET l_ac = 1
   CALL axmp170_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp170.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmp170_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmp170.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmp170_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE r_success     LIKE type_t.num5
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   SELECT pmaal004 INTO g_detail_d[l_ac].xmid009_desc
     FROM pmaal_t
    WHERE pmaalent = g_enterprise
      AND pmaal001 = g_detail_d[l_ac].xmid009
      AND pmaal002 = g_dlang

  CALL s_desc_get_item_desc(g_detail_d[l_ac].xmid007)
        RETURNING g_detail_d[l_ac].xmid007_desc,
                  g_detail_d[l_ac].xmid007_desc_1

   SELECT oocal003 INTO g_detail_d[l_ac].xmid014_desc
     FROM oocal_t
    WHERE oocalent = g_enterprise
      AND oocal001 = g_detail_d[l_ac].xmid014
      AND oocal002 = g_dlang 
      
   SELECT ooefl003 INTO g_detail_d[l_ac].xmid004_desc
     FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = g_detail_d[l_ac].xmid004
      AND ooefl002 = g_dlang

   SELECT ooefl003 INTO g_detail_d[l_ac].xmid005_desc
     FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = g_detail_d[l_ac].xmid005
      AND ooefl002 = g_dlang

   SELECT ooag011 INTO g_detail_d[l_ac].xmid006_desc
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_detail_d[l_ac].xmid006
   #160621-00003#3 20160629 modify by beckxie---S
   #SELECT oocql004 INTO g_detail_d[l_ac].xmid010_desc
   #  FROM oocql_t
   # WHERE oocqlent = g_enterprise
   #   AND oocql001 = '275'
   #   AND oocql002 = g_detail_d[l_ac].xmid010
   #   AND oocql003 = g_dlang
   CALL s_desc_get_oojdl003_desc(g_detail_d[l_ac].xmid010) RETURNING g_detail_d[l_ac].xmid010_desc
   #160621-00003#3 20160629 modify by beckxie---E
   CALL s_feature_description(g_detail_d[l_ac].xmid007,g_detail_d[l_ac].xmid008)
                 RETURNING r_success,g_detail_d[l_ac].xmid008_desc
      
   CALL axmp170_show_hint()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp170.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axmp170_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL axmp170_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axmp170.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axmp170_filter_parser(ps_field)
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
 
{<section id="axmp170.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axmp170_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmp170_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp170.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axmp170_set_entry()
   CALL cl_set_comp_entry("a1,a2",TRUE) 
   
END FUNCTION

PRIVATE FUNCTION axmp170_set_no_entry()
   IF g_master.type_way = '1' THEN
      LET g_master.a1 = ''
      LET g_master.a2 = ''
      CALL cl_set_comp_entry("a1,a2",FALSE)
      DISPLAY BY NAME g_master.a1,g_master.a2
   END IF
END FUNCTION

PRIVATE FUNCTION axmp170_create_temp_table()
   DROP TABLE axmp170_tmp01;              #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
   CREATE TEMP TABLE axmp170_tmp01(       #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
      ooed004     LIKE ooed_t.ooed004
   ) 
   
   #基礎資料 
   DROP TABLE axmp170_tmp02;                  #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02
   CREATE TEMP TABLE axmp170_tmp02(           #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02
      xmic004        LIKE xmic_t.xmic004,     #營運據點 
      xmic005        LIKE xmic_t.xmic005,     #組織 
      xmid009        LIKE xmid_t.xmid009,     #客戶 
      xmid010        LIKE xmid_t.xmid010,     #通路 
      xmic006        LIKE xmic_t.xmic006,     #業務員 
      xmid007        LIKE xmid_t.xmid007,     #料號   
      xmid008        LIKE xmid_t.xmid008,     #產品特徵 
      xmic002        LIKE xmic_t.xmic002,     #日期 
      xmid014        LIKE xmid_t.xmid014,     #單位 
      xmid015        LIKE xmid_t.xmid015      #數量 
   )

   #此table是每一期的日期區間 
   DROP TABLE axmp170_tmp03;              #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
   CREATE TEMP TABLE axmp170_tmp03(       #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
      seq     LIKE type_t.num5,
      bdate   LIKE type_t.dat,
      edate   LIKE type_t.dat
   ) 
   
   #此table用來計算每個料所對應期別的數量總合 
   DROP TABLE axmp170_item_t1;
   CREATE TEMP TABLE axmp170_item_t1(
      xmic004  LIKE xmic_t.xmic004,      #營運據點 
      xmic005  LIKE xmic_t.xmic005,      #組織 
      xmid009  LIKE xmid_t.xmid009,      #客戶 
      xmid010  LIKE xmid_t.xmid010,      #通路 
      xmic006  LIKE xmic_t.xmic006,      #業務員 
      imaa001  LIKE imaa_t.imaa001,      #料號 key  
      xmid008  LIKE xmid_t.xmid008,      #產品特徵 
      seq      LIKE type_t.num5,         #期別 key   
      xmid014  LIKE xmid_t.xmid014,      #單位 
      qty      LIKE xmid_t.xmid015       #數量(基礎單位)  
   )

   #此table用來記錄每一季的數量總合 
   DROP TABLE axmp170_item_t2;
   CREATE TEMP TABLE axmp170_item_t2(
      xmic004  LIKE xmic_t.xmic004,      #營運據點 
      xmic005  LIKE xmic_t.xmic005,      #組織 
      xmid009  LIKE xmid_t.xmid009,      #客戶 
      xmid010  LIKE xmid_t.xmid010,      #通路 
      xmic006  LIKE xmic_t.xmic006,      #業務員 
      imaa001  LIKE imaa_t.imaa001,      #料號 
      xmid008  LIKE xmid_t.xmid008,      #產品特徵 
      seq      LIKE type_t.num10,        #期別(判斷銷售預測時，真正的期別)  
      bdate    LIKE type_t.dat,          #此期別開始日                    
      edate    LIKE type_t.dat,          #此期別結束日                    
      seq1     LIKE type_t.num5,         #年度 
      seq2     LIKE type_t.num5,         #季 的數字 
      xmid014  LIKE xmid_t.xmid014,      #單位 
      qty      LIKE xmid_t.xmid015       #數量 
   ) 
   
   #記錄K期移動總合 
   DROP TABLE axmp170_item_t3;
   CREATE TEMP TABLE axmp170_item_t3(
      xmic004  LIKE xmic_t.xmic004,      #營運據點 
      xmic005  LIKE xmic_t.xmic005,      #組織 
      xmid009  LIKE xmid_t.xmid009,      #客戶 
      xmid010  LIKE xmid_t.xmid010,      #通路 
      xmic006  LIKE xmic_t.xmic006,      #業務員 
      imaa001  LIKE imaa_t.imaa001,      #料號 
      xmid008  LIKE xmid_t.xmid008,      #產品特徵 
      seq1     LIKE type_t.num5,         #年度 
      seq2     LIKE type_t.num20_6,      #季 的數字       
      xmid014  LIKE xmid_t.xmid014,      #單位 
      qty      LIKE xmid_t.xmid015       #數量 
   )

   #記錄K期移動平均 
   DROP TABLE axmp170_item_t4;
   CREATE TEMP TABLE axmp170_item_t4(
      xmic004  LIKE xmic_t.xmic004,      #營運據點 
      xmic005  LIKE xmic_t.xmic005,      #組織 
      xmid009  LIKE xmid_t.xmid009,      #客戶 
      xmid010  LIKE xmid_t.xmid010,      #通路 
      xmic006  LIKE xmic_t.xmic006,      #業務員 
      imaa001  LIKE imaa_t.imaa001,      #料號 
      xmid008  LIKE xmid_t.xmid008,      #產品特徵 
      seq1     LIKE type_t.num5,         #年度 
      seq2     LIKE type_t.num20_6,      #季 的數字    
      xmid014  LIKE xmid_t.xmid014,      #單位 
      qty      LIKE xmid_t.xmid015       #數量 
   ) 
   
   #記錄中央移動平均數  
   DROP TABLE axmp170_item_t5;
   CREATE TEMP TABLE axmp170_item_t5(
      xmic004  LIKE xmic_t.xmic004,      #營運據點 
      xmic005  LIKE xmic_t.xmic005,      #組織 
      xmid009  LIKE xmid_t.xmid009,      #客戶 
      xmid010  LIKE xmid_t.xmid010,      #通路 
      xmic006  LIKE xmic_t.xmic006,      #業務員 
      imaa001  LIKE imaa_t.imaa001,      #料號 
      xmid008  LIKE xmid_t.xmid008,      #產品特徵 
      seq1     LIKE type_t.num5,         #年度 
      seq2     LIKE type_t.num20_6,      #季 的數字     
      xmid014  LIKE xmid_t.xmid014,      #單位 
      qty      LIKE xmid_t.xmid015       #數量 
   )

   #記錄季節不規則成分 
   DROP TABLE axmp170_item_t6;
   CREATE TEMP TABLE axmp170_item_t6(
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      seq1     LIKE type_t.num5,
      seq2     LIKE type_t.num5,
      xmid014  LIKE xmid_t.xmid014,
      qty      LIKE xmid_t.xmid015
   ) 
   
   #記錄季節因子  
   DROP TABLE axmp170_item_t7;
   CREATE TEMP TABLE axmp170_item_t7(
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      seq2     LIKE type_t.num5,
      xmid014  LIKE xmid_t.xmid014,
      qty      LIKE xmid_t.xmid015
   )

   #記錄季節指數  
   DROP TABLE axmp170_item_t8;
   CREATE TEMP TABLE axmp170_item_t8(
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      seq2     LIKE type_t.num5,
      xmid014  LIKE xmid_t.xmid014,
      qty      LIKE xmid_t.xmid015 
   ) 
   
   #記錄消除季節因子後的資料  
   DROP TABLE axmp170_item_t9;
   CREATE TEMP TABLE axmp170_item_t9(
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      seq1     LIKE type_t.num5,
      seq2     LIKE type_t.num5,
      xmid014  LIKE xmid_t.xmid014,
      qty      LIKE xmid_t.xmid015 
   )

   #記錄期別與數量  
   DROP TABLE axmp170_tmp04;           #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
   CREATE TEMP TABLE axmp170_tmp04(    #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      xmid014  LIKE xmid_t.xmid014,
      seq      LIKE type_t.num10,     #期別 
      qty      LIKE xmid_t.xmid015    #數量 
   ) 
   
   #記錄每一期的SStt  
   DROP TABLE axmp170_SStt;
   CREATE TEMP TABLE axmp170_SStt(
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      xmid014  LIKE xmid_t.xmid014,
      seq      LIKE type_t.num10,    #期別 
      sstt     LIKE xmid_t.xmid015   #SStt的值 
   )

   #記錄每一期的SSty  
   DROP TABLE axmp170_SSty;
   CREATE TEMP TABLE axmp170_SSty(
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      xmid014  LIKE xmid_t.xmid014,
      seq      LIKE type_t.num10,    #期別 
      ssty     LIKE xmid_t.xmid015,  #SSty的值 
      l_Ybar   LIKE xmid_t.xmid015,  # 
      l_tbar   LIKE xmid_t.xmid015   # 
   ) 
   
   #記錄斜率(β)與截距(α)  
   DROP TABLE axmp170_tmp05;           #160727-00019#23 Mod  axmp170_alpha_beta--> axmp170_tmp05
   CREATE TEMP TABLE axmp170_tmp05(    #160727-00019#23 Mod  axmp170_alpha_beta--> axmp170_tmp05
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      xmid014  LIKE xmid_t.xmid014,
      l_alpha  LIKE xmid_t.xmid015,
      l_beta   LIKE xmid_t.xmid015
   )

   #預料編號的各期起迄時間 
   DROP TABLE axmp170_tmp06;                #160727-00019#23 Mod  p170_fore_item_t--> axmp170_tmp06
   CREATE TEMP TABLE axmp170_tmp06(         #160727-00019#23 Mod  p170_fore_item_t--> axmp170_tmp06
      xmib002  LIKE xmib_t.xmib002,          #期別 
      xmib003  LIKE xmib_t.xmib003,
      bdate    LIKE type_t.dat,
      edate    LIKE type_t.dat
   ) 
   
   #用來判斷區間與別的判斷表 
   DROP TABLE axmp170_tmp07;                 #160727-00019#23 Mod  axmp170_chkdate_t--> axmp170_tmp07
   CREATE TEMP TABLE axmp170_tmp07(          #160727-00019#23 Mod  axmp170_chkdate_t--> axmp170_tmp07
      seq      LIKE type_t.num5,      #期別 
      bdate    LIKE type_t.dat,       #起始日 
      edate    LIKE type_t.dat        #截止日 
   ) 
   
   #未來的預測資料 
   DROP TABLE axmp170_tmp08;          #160727-00019#23 Mod  axmp170_fore_data--> axmp170_tmp08
   CREATE TEMP TABLE axmp170_tmp08(   #160727-00019#23 Mod  axmp170_fore_data--> axmp170_tmp08
      ent      LIKE xmic_t.xmicent,
      xmic004  LIKE xmic_t.xmic004,
      xmic005  LIKE xmic_t.xmic005,
      xmid009  LIKE xmid_t.xmid009,
      xmid010  LIKE xmid_t.xmid010,
      xmic006  LIKE xmic_t.xmic006,
      imaa001  LIKE imaa_t.imaa001,
      xmid008  LIKE xmid_t.xmid008,
      xmid014  LIKE xmid_t.xmid014,
      seq      LIKE type_t.num10,    #期別 
      bdate    LIKE type_t.dat,
      edate    LIKE type_t.dat,
      qty      LIKE xmid_t.xmid015   #預測數量  
   ) 
   
   
END FUNCTION

PRIVATE FUNCTION axmp170_drop_temp_table()
   DROP TABLE axmp170_tmp01;          #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
   DROP TABLE axmp170_tmp02;          #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02
   DROP TABLE axmp170_tmp03;          #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
   DROP TABLE axmp170_item_t1;
   DROP TABLE axmp170_item_t2;
   DROP TABLE axmp170_item_t3;
   DROP TABLE axmp170_item_t4;
   DROP TABLE axmp170_item_t5;
   DROP TABLE axmp170_item_t6;
   DROP TABLE axmp170_item_t7;
   DROP TABLE axmp170_item_t8;
   DROP TABLE axmp170_item_t9;
   DROP TABLE axmp170_tmp04;          #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
   DROP TABLE axmp170_SStt;
   DROP TABLE axmp170_SSty;
   DROP TABLE axmp170_tmp05;          #160727-00019#23 Mod  axmp170_alpha_beta--> axmp170_tmp05
   DROP TABLE axmp170_tmp06;          #160727-00019#23 Mod  p170_fore_item_t--> axmp170_tmp06
   DROP TABLE axmp170_tmp07;          #160727-00019#23 Mod  axmp170_chkdate_t--> axmp170_tmp07
   DROP TABLE axmp170_tmp08;          #160727-00019#23 Mod  axmp170_fore_data--> axmp170_tmp08
END FUNCTION

################################################################################
# Descriptions...: 檢查預測起始日是否正確 
# Memo...........:
# Usage..........: CALL axmp170_xmic002_chk()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success
#                : 
# Date & Author..: 2015/05/29 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_xmic002_chk()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_xmia003     LIKE xmia_t.xmia003     #預測起始日 
   DEFINE l_xmia016     LIKE xmia_t.xmia016     #預測起始日指定方式 
   DEFINE l_msg         STRING                  #用來組訊息的   
   DEFINE l_dd          LIKE xmia_t.xmia003     #用來取得「預測起始日」的「日」 
   DEFINE l_monday      LIKE xmic_t.xmic002     #用來取得輸入日期的該周星期一為幾號 
   DEFINE l_xmic002     LIKE xmic_t.xmic002     #計算完後的預測起始日 

   LET r_success = TRUE

   IF cl_null(g_master.xmic001) OR cl_null(g_master.xmic002) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #取得「預測起始日」與「預測起始日指定方式」 
   SELECT xmia003,xmia016 INTO l_xmia003,l_xmia016
     FROM xmia_t
    WHERE xmiaent = g_enterprise
      AND xmia001 = g_master.xmic001

   IF l_xmia016 = '1' THEN   #指定日  
      LET l_dd = DAY(g_master.xmic002) 
      IF l_xmia003 <> l_dd THEN
         #取得訊息「該預測編號的預測起始日期是：」 
         CALL cl_getmsg('axm-00247',g_lang) RETURNING l_msg
         #組合字串 
         LET l_msg = l_msg,l_xmia003

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_msg
         LET g_errparam.code   = 'axm-00169'     #起始日期的起始日需與預測編號的起始日一致    
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   IF l_xmia016 = '2' THEN   #指定週   
      #取得輸入日期的該周一為幾號  
      CALL s_date_get_monday(g_master.xmic002) RETURNING l_monday 
      
      CASE l_xmia003
         WHEN '0'
            LET l_xmic002 = l_monday - 1
         WHEN '1'
            LET l_xmic002 = l_monday
         WHEN '2'
            LET l_xmic002 = l_monday + 1
         WHEN '3'
            LET l_xmic002 = l_monday + 2
         WHEN '4'
            LET l_xmic002 = l_monday + 3
         WHEN '5'
            LET l_xmic002 = l_monday + 4
         WHEN '6'
            LET l_xmic002 = l_monday + 5
      END CASE

      IF g_master.xmic002 <> l_xmic002 THEN
         #取得訊息「該預測編號的預測周間是：」  
         CALL cl_getmsg('axm-00414',g_lang) RETURNING l_msg
         #組合字串 
         LET l_msg = l_msg,l_xmia003

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_msg
         LET g_errparam.code   = 'axm-00169'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得區間組別
# Memo...........:
# Usage..........: CALL axmp170_get_interval_group()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_interval_group()
   DEFINE l_start_day LIKE type_t.dat     #計算日期的區間開始日   
   DEFINE l_end_day   LIKE type_t.dat     #計算日期的區間結束日   
   DEFINE l_seq       LIKE type_t.num5
   DEFINE l_yy        LIKE type_t.num5    #年 
   DEFINE l_mm        LIKE type_t.num5    #月 
   DEFINE l_num       LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM axmp170_tmp03;           #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03

   #區間的判定如下
   #週：以月曆為主，每個星期日到星期六為一個區間 
   #旬：每月的1~10,11~20,21~月底  
   #月：每個月的1號到月底為區間 

   LET l_yy = YEAR(g_master.bdate)      #取得年份 
   LET l_mm = MONTH(g_master.bdate)     #取得月份  

   LET l_start_day = '' 
   CASE g_master.cycle
      WHEN '1'   #週   
         #先判斷本日為星期幾 
         LET l_num = WEEKDAY(g_master.bdate)
         #設定開始日為星期日
         CASE
            WHEN 0
               LET l_start_day = g_master.bdate
            OTHERWISE
               LET l_start_day = g_master.bdate - l_num
         END CASE

         LET l_end_day = l_start_day + 6
      WHEN '2'   #旬  
         #設定開始日為1,11,21
         CASE
            WHEN MDY(l_mm,1,l_yy) <= g_master.bdate <= MDY(l_mm,10,l_yy)
               LET l_start_day = MDY(l_mm,1,l_yy)
               LET l_end_day   = MDY(l_mm,10,l_yy)
            WHEN MDY(l_mm,11,l_yy) <= g_master.bdate <= MDY(l_mm,20,l_yy)
               LET l_start_day = MDY(l_mm,11,l_yy)
               LET l_end_day = MDY(l_mm,20,l_yy)
            WHEN MDY(l_mm,21,l_yy) <= g_master.bdate <= s_date_get_last_date(g_master.bdate)
               LET l_start_day = MDY(l_mm,21,l_yy) 
               LET l_end_day   = s_date_get_last_date(g_master.bdate)
         END CASE
      WHEN '3'   #月  
         #開始日為當月第一天 
         LET l_start_day = s_date_get_first_date(g_master.bdate)
         LET l_end_day   = s_date_get_last_date(g_master.bdate)
   END CASE

   LET l_seq = 1
   WHILE TRUE
      IF l_start_day > g_master.edate THEN
         EXIT WHILE
      END IF
      #161109-00085#11-mod-s
      #INSERT INTO axmp170_tmp03 VALUES(l_seq,l_start_day,l_end_day)         #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
      INSERT INTO axmp170_tmp03 (seq,bdate,edate)
      VALUES(l_seq,l_start_day,l_end_day)         #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
      #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins temp table time_group'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT WHILE
      END IF 
      
      #開始日都是從之前的結束日後一天開始算 
      SELECT ADD_MONTHS(l_end_day,0) + 1 INTO l_start_day FROM DUAL;
      CASE g_master.cycle
         WHEN '1'     #週  
            SELECT ADD_MONTHS(l_start_day,0) + 6 INTO l_end_day FROM DUAL;
         WHEN '2'     #旬  
            LET l_yy = YEAR(l_start_day)
            LET l_mm = MONTH(l_start_day)
            IF l_start_day < MDY(l_mm,20,l_yy)  THEN
               #上旬、中旬 直接加9天 
               SELECT ADD_MONTHS(l_start_day,0) + 9 INTO l_end_day FROM DUAL;
            ELSE
               #下旬有月底的問題，所以可能會是28,29,30,31 
               LET l_end_day = s_date_get_last_date(l_start_day)
            END IF
         WHEN '3'     #月  
            LET l_end_day = s_date_get_last_date(l_start_day)
      END CASE

      LET l_seq = l_seq + 1

   END WHILE

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 由畫面上的條件取得資料
# Memo...........:
# Usage..........: axmp170_get_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/04/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_data()
   DEFINE l_sql         STRING
   DEFINE l_xmia010     LIKE xmia_t.xmia010     #營運據點 
   DEFINE l_xmia011     LIKE xmia_t.xmia011     #預測組織  
   DEFINE l_xmia012     LIKE xmia_t.xmia012     #業務人員 
   DEFINE l_xmia013     LIKE xmia_t.xmia013     #客戶 
   DEFINE l_xmia014     LIKE xmia_t.xmia014     #通路 
   DEFINE l_xmia015     LIKE xmia_t.xmia015     #產品特徵 
   DEFINE l_basic_data  RECORD
                           xmic004     LIKE xmic_t.xmic004,     #營運據點 
                           xmic005     LIKE xmic_t.xmic005,     #組織 
                           xmid009     LIKE xmid_t.xmid009,     #客戶 
                           xmid010     LIKE xmid_t.xmid010,     #通路 
                           xmic006     LIKE xmic_t.xmic006,     #業務員 
                           xmid007     LIKE xmid_t.xmid007,     #料號   
                           xmid008     LIKE xmid_t.xmid008,     #產品特徵 
                           xmic002     LIKE xmic_t.xmic002,     #日期 
                           xmid014     LIKE xmid_t.xmid014,     #單位 
                           xmid015     LIKE xmid_t.xmid015      #數量 
                        END RECORD
   DEFINE l_imaa006     LIKE imaa_t.imaa006
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_success     LIKE type_t.num5 
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_xmic005     LIKE xmic_t.xmic005
   DEFINE l_ooed004_tmp LIKE ooed_t.ooed004
   DEFINE l_ooed002     LIKE ooed_t.ooed002
   DEFINE l_ooed004     LIKE ooed_t.ooed004
   DEFINE l_ooed005     LIKE ooed_t.ooed005 
   
   LET r_success = TRUE 
   
   DELETE FROM axmp170_tmp02;        #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02

   #取得預測編號在axmi170的資料 
   LET l_xmia010 = ''
   LET l_xmia011 = ''
   LET l_xmia012 = ''
   LET l_xmia013 = ''
   LET l_xmia014 = '' 
   LET l_xmia015 = ''
   SELECT xmia010,xmia011,xmia012,xmia013,xmia014,xmia015
     INTO l_xmia010,l_xmia011,l_xmia012,l_xmia013,l_xmia014,l_xmia015
     FROM xmia_t
    WHERE xmiaent = g_enterprise
      AND xmia001 = g_master.xmic001

   DELETE FROM axmp170_tmp01;                #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
   IF NOT cl_null(g_master.wc6) AND g_master.wc6 <> ' 1=1' THEN       #如果銷售組織有輸入查詢條件的話  
      CALL axmp170_get_ooed()
   END IF

   IF g_master.origin = '1' THEN      #1.訂單  
      #取得營運據點、銷售組織、客戶、通路、業務人員、料號、產品特徵、訂單日期    
      LET l_sql = "SELECT xmdasite,xmda003,xmda004,xmda023,xmda002, ",
                  "       xmdc001,xmdc002,xmdadocdt,xmdc006,xmdc007 ",
                  "  FROM xmda_t,xmdc_t ",
                  " WHERE xmdaent   = xmdcent ",
                  "   AND xmdadocno = xmdcdocno ",
                  "   AND xmdaent   = '",g_enterprise,"' ",
                  "   AND xmdadocdt BETWEEN '",g_master.bdate,"' ",
                  "                     AND '",g_master.edate,"' ",
                  "   AND xmdastus = 'Y' ",     #已確認 
                  "   AND ",g_master.wc1,             #營運據點  
                  "   AND ",g_master.wc5,             #業務員  
                  "   AND ",g_master.wc7,             #客戶 
                  "   AND ",g_master.wc8              #通路  

      #如果qbe中，組織有下條件，則temp table就會有資料  
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM axmp170_tmp01           #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
      IF l_cnt > 0 THEN
         LET l_sql = l_sql CLIPPED,
                     " AND xmda003 IN (SELECT ooed004 FROM axmp170_tmp01) "       #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
      END IF 
      
      #如果QBE的產品分類有輸入條件 
      IF NOT cl_null(g_master.wc2) AND g_master.wc2 <> ' 1=1' THEN
         LET l_sql = l_sql CLIPPED,
                     " AND xmdc001 IN (SELECT imaa001 ",
                     "                   FROM imaa_t ",
                     "                  WHERE imaaent = '",g_enterprise,"' ",
                     "                    AND ",g_master.wc2,") "
      END IF

      #如果QBE的銷售分群有輸入條件 
      IF NOT cl_null(g_master.wc3) AND g_master.wc3 <> ' 1=1' THEN
         LET l_sql = l_sql CLIPPED,
                     " AND xmdc001 IN (SELECT imaf001 ",
                     "                   FROM imaf_t ",
                     "                  WHERE imafent  = '",g_enterprise,"' ",
                     "                    AND imafsite = xmdasite ",
                     "                    AND ",g_master.wc3,") "
      END IF

      #用預測料號串aimm213的imaf125，取得imaf001後，再用imaf001串到訂單的料號 
      IF NOT cl_null(g_master.wc4) AND g_master.wc4 <> ' 1=1' THEN
         LET l_sql = l_sql CLIPPED,
                     " AND xmdc001 IN (SELECT imaf001 ",
                     "                   FROM imaf_t ",
                     "                  WHERE imafent = '",g_enterprise,"' ",
                     "                    AND imafsite = xmdasite ",
                     "                    AND ",g_master.wc4,") "
      END IF
   ELSE                               #2.出貨單  
      LET g_master.wc1 = cl_replace_str(g_master.wc1,'xmda','xmdk')
      LET g_master.wc5 = cl_replace_str(g_master.wc5,'xmda','xmdk')
      LET g_master.wc7 = cl_replace_str(g_master.wc7,'xmda','xmdk')
      LET g_master.wc8 = cl_replace_str(g_master.wc8,'xmda','xmdk') 
      
      LET l_sql = "SELECT xmdksite,xmdk004,xmdk007,xmdk030,xmdk003, ",
                  "       xmdl008,xmdl009,xmdkdocdt,xmdl017,xmdl018 ", 
                  "  FROM xmdk_t,xmdl_t ",
                  " WHERE xmdkent   = xmdlent ",
                  "   AND xmdkdocno = xmdldocno ",
                  "   AND xmdkent   = '",g_enterprise,"' ",
                  "   AND xmdkdocdt BETWEEN '",g_master.bdate,"' ",
                  "                     AND '",g_master.edate,"' ",
                  "   AND xmdkstus = 'S' ",     #已過帳  
                  "   AND xmdk000 IN ('1','2','3') ",      #1.出貨單,2.無訂單出貨,3.直送訂單出貨,4.出貨簽收單,5.出貨簽退單,6.銷退單,7.借貨還價單,8.借貨還量單
                  "   AND ",g_master.wc1,             #營運據點  
                  "   AND ",g_master.wc5,             #業務員  
                  "   AND ",g_master.wc7,             #客戶  
                  "   AND ",g_master.wc8              #通路  

      #如果qbe中，組織有下條件，則temp table就會有資料 
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM axmp170_tmp01          #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
      IF l_cnt > 0 THEN
         LET l_sql = l_sql CLIPPED,
                     " AND xmda003 IN (SELECT ooed004 FROM axmp170_tmp01) "       #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
      END IF


      #用預測料號串aimm213的imaf125，取得imaf001後，再用imaf001串到訂單的料號 
      IF NOT cl_null(g_master.wc4) THEN
         LET l_sql = l_sql CLIPPED,
                     " AND xmdl008 IN (SELECT imaf001 ",
                     "                   FROM imaf_t ",
                     "                  WHERE imafent = '",g_enterprise,"' ",
                     "                    AND imafsite = xmdksite ",
                     "                    AND ",g_master.wc4,") "
      END IF
   END IF 
   
   LET l_sql = l_sql CLIPPED,
               " ORDER BY xmdasite,xmda003,xmda004,xmda023,xmda002, ",
               "          xmdc001,xmdc002,xmdadocdt "

   PREPARE axmp170_get_basic_data_prep FROM l_sql
   DECLARE axmp170_get_basic_data_curs CURSOR FOR axmp170_get_basic_data_prep

   #取得營運據點、銷售組織、客戶、通路、業務人員、料號、產品特徵、訂單日期    
   INITIALIZE l_basic_data.* TO NULL 
   #161109-00085#11-mod-s
   #FOREACH axmp170_get_basic_data_curs INTO l_basic_data.*
   FOREACH axmp170_get_basic_data_curs INTO l_basic_data.xmic004,l_basic_data.xmic005,l_basic_data.xmid009,l_basic_data.xmid010,l_basic_data.xmic006,
                                            l_basic_data.xmid007,l_basic_data.xmid008,l_basic_data.xmic002,l_basic_data.xmid014,l_basic_data.xmid015              
   #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      IF l_xmia010 = 'N' THEN     #營運據點  
         LET l_basic_data.xmic004 = ' '
      END IF

      IF l_xmia011 = 'N' THEN     #預測組織 
         LET l_basic_data.xmic005 = ' '
      END IF

      IF l_xmia012 = 'N' THEN     #業務人員 
         LET l_basic_data.xmic006 = ' '
      END IF

      IF l_xmia013 = 'N' THEN     #客戶 
         LET l_basic_data.xmid009 = ' '
      END IF

      IF l_xmia014 = 'N' THEN     #通路 
         LET l_basic_data.xmid010 = ' '
      END IF 
      
      IF l_xmia015 = 'N' THEN     #產品特徵 
         LET l_basic_data.xmid008 = ' '
      END IF

      #取得料件的基礎單位 
      LET l_imaa006 = ''
      SELECT imaa006 INTO l_imaa006
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_basic_data.xmid007

      #如果單位一樣就不浪費時間做多餘的事 
      IF l_basic_data.xmid014 <> l_imaa006 THEN
         #將數量轉換為基礎單位的數量 
         CALL s_aooi250_convert_qty(l_basic_data.xmid007,l_basic_data.xmid014,l_imaa006,l_basic_data.xmid015)
              RETURNING l_success,l_basic_data.xmid015
      END IF

      
      #161109-00085#11-mod-s
      #INSERT INTO axmp170_tmp02 VALUES(l_basic_data.*)                     #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02    #161109-00085#11   mark
      INSERT INTO axmp170_tmp02(xmic004,xmic005,xmid009,xmid010,xmic006,xmid007,xmid008,xmic002,xmid014,xmid015)
                  VALUES(l_basic_data.xmic004,l_basic_data.xmic005,l_basic_data.xmid009,l_basic_data.xmid010,l_basic_data.xmic006,
                         l_basic_data.xmid007,l_basic_data.xmid008,l_basic_data.xmic002,l_basic_data.xmid014,l_basic_data.xmid015)      
      #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins basic data'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      INITIALIZE l_basic_data.* TO NULL
   END FOREACH  
   
   #如果預測編號的銷售組織有勾選 
   #需找預測點，若有則需更新組織，若無則不更動 
   IF l_xmia011 = 'Y' THEN     #預測組織 
      LET l_sql = "SELECT UNIQUE xmic005 ",
                  "  FROM axmp170_tmp02 ",                #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02
                  " ORDER BY xmic005 "
      PREPARE axmp170_xmic005_prep FROM l_sql
      DECLARE axmp170_xmic005_curs CURSOR WITH HOLD FOR axmp170_xmic005_prep

      FOREACH axmp170_xmic005_curs INTO l_xmic005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         LET l_ooed004_tmp = l_xmic005 
         
         #在這裡要往上找組織 
         LET l_sql = "SELECT ooed002,ooed004,ooed005 ",
                     "  FROM ooed_t ",
                     " WHERE ooedent = '",g_enterprise,"' ",
                     "   AND ooed004 = ? ",
                     "   AND ooed003 = (SELECT MAX(ooed003) FROM ooed_t ",
                     "                   WHERE ooedent = '",g_enterprise,"' ",
                     "                     AND ooed004 = ? ",
                     "                     AND ooed006 <= '",g_today,"' ",
                     "                     AND (ooed007 IS NULL OR ooed007 >= '",g_today,"')) ",
                     "   AND ooed006 <= '",g_today,"' ",
                     "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"') "
         PREPARE axmp170_pre_ooed_prep FROM l_sql
         #DECLARE axmp170_pre_ooed_curs CURSOR FOR axmp170_pre_ooed_prep 

         WHILE TRUE
            LET l_ooed002 = ''     #最上層組織  
            LET l_ooed004 = ''     #組織編號  
            LET l_ooed005 = ''     #上層組織  
            EXECUTE axmp170_pre_ooed_prep USING l_ooed004_tmp,l_ooed004_tmp
                                           INTO l_ooed002,l_ooed004,l_ooed005

            #檢查目前這一階的組織資料是否存在axmi171(xmij_t)且為預測點的資料(xmij002 = 'Y')   
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM xmij_t
             WHERE xmijent = g_enterprise
               AND xmij001 = l_ooed004     #銷售組織   
               AND xmij002 = 'Y'           #是否為預測點  

            IF cl_null(l_cnt) THEN
               LET l_cnt = 0
            END IF

            #如果目前的組織為預測點就離開 
            IF l_cnt > 0 THEN
               EXIT WHILE
            END IF

            #如果目前的組織不是預測點 
            #而且又是最上層組織的話，就不用再查了  
            IF l_ooed002 = l_ooed004 THEN
               EXIT WHILE
            END IF

            #為下一波檢查而準備， 也就是 目前的上層 
            LET l_ooed004_tmp = l_ooed005 
            
            IF cl_null(l_ooed004_tmp) then  
               #如果下一層是沒有資料的話，就不必再處理了 
               EXIT WHILE 
            END IF 

         END WHILE

         #如果數量大於0的話，代表在while之中有找到預測點 
         IF l_cnt > 0 THEN
            #將目前的銷售組織更新為預測點的組織 
            UPDATE axmp170_tmp02 SET xmic005 = l_ooed004          #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02
             WHERE xmic005 = l_xmic005
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'upd basic data'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF
         END IF
      END FOREACH
   END IF

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 依QBE條件取得axmi171的組織樹資料
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/04/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_ooed()
   DEFINE l_sql     STRING
   DEFINE l_n       LIKE type_t.num10
   DEFINE l_n2      LIKE type_t.num10
   DEFINE l_cnt     LIKE type_t.num10
   DEFINE l_pid     LIKE type_t.chr50

   DELETE FROM axmp170_tmp01;            #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01

   #取得銷售組織的最上層  
   LET l_sql = "SELECT UNIQUE ooed002,ooed003,ooed004,ooed005 ",
               "  FROM ooed_t ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed001 = '2' ",
               "   AND ",g_master.wc6, 
               "   AND ooed006 <= '",g_today,"' ", 
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"') ",
               " ORDER BY ooed002 "
   PREPARE axmp170_master_type_0 FROM l_sql
   DECLARE axmp170_master_type_curs_0 CURSOR FOR axmp170_master_type_0

   #取得目前的下階組織 
   LET l_sql = "SELECT UNIQUE ooed004,ooed003 ",
               "  FROM ooed_t ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed001 = '2' ",
               "   AND ooed006 <= '",g_today,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"') ",
               "   AND ooed002 = ? ",
               "   AND ooed003 = ? ", 
               "   AND ooed005 = ? ",
               "   AND ooed004 <> ooed005 ",
               " ORDER BY ooed004 "
   PREPARE axmp170_master_type_1 FROM l_sql
   DECLARE axmp170_master_type_curs_1 CURSOR FOR axmp170_master_type_1

   CALL g_browser.clear()

   LET l_n = 1

   #先找出最上層的母節點 
   FOREACH axmp170_master_type_curs_0 INTO g_browser[l_n].b_ooed002,
                                           g_browser[l_n].b_ooed003,
                                           g_browser[l_n].b_ooed004,
                                           g_browser[l_n].b_ooed005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #此處(LV-1) 
      LET g_browser[l_n].b_ooed002 = g_browser[l_n].b_ooed002
      LET g_browser[l_n].b_ooed004 = g_browser[l_n].b_ooed004
      LET g_browser[l_n].b_pid     = '0' CLIPPED
      LET g_browser[l_n].b_id      = l_n USING "<<<" 
      LET g_browser[l_n].b_exp     = TRUE
      LET g_browser[l_n].b_hasC    = TRUE
      LET g_browser[l_n].b_isExp   = TRUE

      #記錄第一層的節點編號 
      LET l_pid = g_browser[l_n].b_id CLIPPED
      LET l_n = l_n + 1
      LET g_cnt = l_n

      #找下一層的資料 
      FOREACH axmp170_master_type_curs_1 USING g_browser[l_n-1].b_ooed002,
                                               g_browser[l_n-1].b_ooed003,
                                               g_browser[l_n-1].b_ooed004
                                          INTO g_browser[g_cnt].b_ooed004,
                                               g_browser[g_cnt].b_ooed003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         LET g_browser[g_cnt].b_ooed002 = g_browser[l_n-1].b_ooed002
         LET g_browser[g_cnt].b_ooed004 = g_browser[g_cnt].b_ooed004
         LET g_browser[g_cnt].b_ooed005 = g_browser[l_n-1].b_ooed004
         LET g_browser[g_cnt].b_pid     = l_pid
         LET g_browser[g_cnt].b_id      = l_pid,".",g_cnt USING "<<<" 
         LET g_browser[g_cnt].b_exp     = TRUE
         LET g_browser[g_cnt].b_hasC    = axmp170_chk_hasC(g_cnt)
         IF g_browser[g_cnt].b_hasC = 1 THEN
            CALL axmp170_browser_expand(g_cnt)
            LET g_cnt = g_browser.getLength()    #因為上面的function會再取下階，所以要重取資料筆數  
         END IF
         LET g_cnt = g_cnt + 1

      END FOREACH
      LET l_n = g_browser.getLength()
   END FOREACH

   FOR l_n2 = 1 TO g_browser.getLength()
      IF g_browser[l_n2].b_isExp IS NULL THEN
         CALL axmp170_browser_expand(l_n2)
      END IF
   END FOR

   FOR l_n = 1 TO g_browser.getLength()
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM axmp170_tmp01             #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
       WHERE ooed004 = g_browser[l_n].b_ooed004
      IF l_cnt > 0 THEN
         CONTINUE FOR
      END IF
      #161109-00085#11-mod-s
      #INSERT INTO axmp170_tmp01 VALUES(g_browser[l_n].b_ooed004)          #160727-00019#23 Mod  axmp170_ooed004_t--> axmp170_tmp01
      INSERT INTO axmp170_tmp01 (ooed004) 
      VALUES(g_browser[l_n].b_ooed004)
      #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'insert tmp table'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOR
      END IF
   END FOR 
   
END FUNCTION

################################################################################
# Descriptions...: 檢查是否有下階節點
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/04/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_chk_hasC(pi_id)
   DEFINE pi_id     INTEGER
   DEFINE li_cnt    INTEGER
   DEFINE l_sql     STRING

   LET l_sql = "SELECT COUNT(*) FROM ooed_t ",
               " WHERE ooed004 <> ooed005 ",
               "   AND ooed001 = '2' ",
               "   AND ooed006 <= '",g_today,"' ",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"') ",
               "   AND ooed005 = ? ",
               "   AND ooed002 = ? ",
               "   AND ooed003 = ? "
   PREPARE axmp170_master_chk1 FROM l_sql
   EXECUTE axmp170_master_chk1 USING g_browser[pi_id].b_ooed004,
                                     g_browser[pi_id].b_ooed002,
                                     g_browser[pi_id].b_ooed003
                                INTO li_cnt
   FREE axmp170_master_chk1

   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 展開下階節點的資料
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/04/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_browser_expand(pi_id)
   DEFINE pi_id       LIKE type_t.num10
   DEFINE l_id        LIKE type_t.num10
   DEFINE l_cnt       LIKE type_t.num10
   DEFINE l_keyvalue  LIKE type_t.chr50
   DEFINE l_typevalue LIKE type_t.chr50
   DEFINE l_type      LIKE type_t.chr50
   DEFINE l_sql       STRING
   DEFINE ls_source   LIKE type_t.chr500
   DEFINE ls_exp_code LIKE type_t.chr500
   DEFINE l_return    LIKE type_t.num5

   #若已經展開，就不用再找下階資料 
   IF g_browser[pi_id].b_isExp = 1 THEN
      RETURN
   END IF

   LET g_browser[pi_id].b_isExp = 1     #設定為已展開 
   LET l_return = FALSE

   LET l_keyvalue = g_browser[pi_id].b_ooed004

   LET l_sql = "SELECT UNIQUE ooed004,ooed003 ",
               "  FROM ooed_t ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed005 = '",l_keyvalue,"' ",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed001 = '2' ",
               "   AND ooed006 <= '",g_today,"' ", 
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"') ",
               "   AND ooed002 = '",g_browser[pi_id].b_ooed002,"' ",
               "   AND ooed003 = '",g_browser[pi_id].b_ooed003,"' ",
               " ORDER BY ooed004 "
   PREPARE axmp170_tree_expand1 FROM l_sql
   DECLARE axmp170_tree_ex_cur1 CURSOR FOR axmp170_tree_expand1

   LET l_id = pi_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1

   FOREACH axmp170_tree_ex_cur1 INTO g_browser[l_id].b_ooed004,
                                     g_browser[l_id].b_ooed003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF cl_null(g_browser[l_id].b_ooed004) THEN
         EXIT FOREACH
      END IF

      #pid = 父節點id  
      LET g_browser[l_id].b_pid     = g_browser[pi_id].b_id 
      #id = 本身節點id(採流水號遞增) 
      LET g_browser[l_id].b_id      = g_browser[pi_id].b_id,".",l_cnt
      LET g_browser[l_id].b_exp     = TRUE
      LET g_browser[l_id].b_ooed005 = g_browser[pi_id].b_ooed004
      LET g_browser[l_id].b_ooed002 = g_browser[pi_id].b_ooed002

      #hasC = 確認該節點是否有下階 
      LET g_browser[l_id].b_hasC    = axmp170_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE

   END FOREACH

   LET l_cnt = l_cnt - 1

   #刪除空的資料 
   CALL g_browser.deleteElement(l_id) 
   
END FUNCTION

################################################################################
# Descriptions...: 取得最終公式
# Memo...........:
# Usage..........: CALL axmp170_get_formula()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_formula()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5


   LET r_success = TRUE

   IF g_master.type_way = '1' THEN      #預測方式1.簡單線性趨勢  
      #ming 20150624 add -------------------------(S) 
      #取得每一個日期區間的數量總合 
      CALL axmp170_get_time_group_data() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #ming 20150624 add -------------------------(E) 
      
      #消除季節因子 
      CALL axmp170_clear_season_index() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #排列期別 
      CALL axmp170_get_permutation() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #計算SStt與SSty  
      CALL axmp170_get_SStt() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #取得alpha與beta 
      CALL axmp170_get_alpha_beta() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #依user在畫面上設定的「預設起始日」開始，按axmi170的設定建立區間資料 
      CALL axmp170_get_fore_time() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #取得檢查區間的日期資料  
      CALL axmp170_get_chk_date() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #準備產生資料 
      CALL axmp170_produce_data() RETURNING l_success 
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE                                 #預測方式2.季節變動  
      #取得每一個日期區間的數量總合 
      CALL axmp170_get_time_group_data() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #取得每季的數量總合  
      CALL axmp170_get_season_data() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #計算K期移動總合 
      CALL axmp170_get_K_sum() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #取得K期移動平均 
      CALL axmp170_get_K_avg() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #取得中央移動平均 
      CALL axmp170_get_center_avg() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #計算季節不規則成分 
      CALL axmp170_get_season_abnormal() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #計算季節因子 
      CALL axmp170_get_season_factor() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #計算季節指數 
      CALL axmp170_get_season_index() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #消除季節因子 
      CALL axmp170_clear_season_index() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #排列期別 
      CALL axmp170_get_permutation() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #計算SStt與SSty  
      CALL axmp170_get_SStt() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #取得alpha與beta 
      CALL axmp170_get_alpha_beta() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF

      #依user在畫面上設定的「預設起始日」開始，按axmi170的設定建立區間資料 
      CALL axmp170_get_fore_time() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #取得檢查區間的日期資料  
      CALL axmp170_get_chk_date() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #準備產生資料 
      CALL axmp170_produce_data() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF 

   END IF

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_time_group_data()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_time_group_data()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_seq         LIKE type_t.num5
   DEFINE l_bdate       LIKE type_t.dat
   DEFINE l_edate       LIKE type_t.dat

   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           xmid007     LIKE xmid_t.xmid007,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           sum_xmid015 LIKE xmid_t.xmid015
                        END RECORD

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t1;

   #從第一期開始，找出其區間的資料後寫入另一table 
   LET l_sql = "SELECT seq,bdate,edate ",
               "  FROM axmp170_tmp03 ",             #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
               " ORDER BY seq "
   PREPARE axmp170_time_group_prep FROM l_sql
   DECLARE axmp170_time_group_curs CURSOR FOR axmp170_time_group_prep 
   
   #取得每一期的數量總合 
   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006,",
               "       xmid007,xmid008,xmid014,SUM(xmid015) ",
               "  FROM axmp170_tmp02 ",             #160727-00019#23 Mod  axmp170_basic_data--> axmp170_tmp02
               " WHERE xmic002 BETWEEN ? ",
               "                   AND ? ",
               " GROUP BY xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "          xmid007,xmid008,xmid014 "
   PREPARE axmp170_basic_data_prep FROM l_sql
   DECLARE axmp170_basic_data_curs CURSOR FOR axmp170_basic_data_prep

   LET l_seq   = ''
   LET l_bdate = ''
   LET l_edate = ''
   FOREACH axmp170_time_group_curs INTO l_seq,l_bdate,l_edate
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      INITIALIZE sr.* TO NULL      
      FOREACH axmp170_basic_data_curs USING l_bdate,l_edate 
                                       #161109-00085#11-s mod
#                                       INTO sr.*   #161109-00085#11-s mark
                                       INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                            sr.xmid007,sr.xmid008,sr.xmid014,sr.sum_xmid015
                                       #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         #將資料寫入每一期的數量總合檔 
         INSERT INTO axmp170_item_t1(xmic004,xmic005,xmid009,xmid010,
                                     xmic006,imaa001,xmid008,seq,xmid014,qty)
               VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                      sr.xmid007,sr.xmid008,l_seq,sr.xmid014,sr.sum_xmid015)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins item_t1'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         INITIALIZE sr.* TO NULL
      END FOREACH

   END FOREACH

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_season_data()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_season_data()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_begin       LIKE type_t.num5
   DEFINE l_end         LIKE type_t.num5
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           sum_qty     LIKE xmid_t.xmid015
                        END RECORD
   DEFINE l_max_seq     LIKE type_t.num5
   DEFINE l_seq1        LIKE type_t.num5     #類似年度的數字  
   DEFINE l_seq2        LIKE type_t.num5     #類似季的數字   
   DEFINE l_seq         LIKE type_t.num10
   DEFINE l_bdate       LIKE type_t.dat
   DEFINE l_edate       LIKE type_t.dat

   LET r_success = TRUE

   DELETE FROM axmp170_item_t2;

   LET l_begin = 1
   LET l_end   = g_master.a1

   LET l_max_seq = ''
   SELECT MAX(seq) INTO l_max_seq FROM axmp170_item_t1
   IF cl_null(l_max_seq) THEN
      LET l_max_seq = 0
   END IF 
   
   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010, ",
               "       xmic006,imaa001,xmid008,xmid014,sum(qty) ",
               "  FROM axmp170_item_t1 ",
               " WHERE seq BETWEEN ? ",
               "               AND ? ",
               " GROUP BY xmic004,xmic005,xmid009,xmid010, ",
               "          xmic006,imaa001,xmid008,xmid014 "
   PREPARE axmp170_sum_t1_prep FROM l_sql
   DECLARE axmp170_sum_t1_curs CURSOR FOR axmp170_sum_t1_prep

   LET l_seq  = 1
   LET l_seq1 = 1
   LET l_seq2 = 1

   WHILE TRUE
      INITIALIZE sr.* TO NULL

      IF l_begin > l_max_seq THEN
         EXIT WHILE
      END IF 
      
      LET l_bdate = ''
      LET l_edate = ''
      SELECT bdate INTO l_bdate
        FROM axmp170_tmp03        #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
       WHERE seq = l_begin

      SELECT edate INTO l_edate
        FROM axmp170_tmp03        #160727-00019#23 Mod  axmp170_time_group--> axmp170_tmp03
       WHERE seq = l_end

      FOREACH axmp170_sum_t1_curs USING l_begin,l_end
                                   #161109-00085#11-s mod
#                                   INTO sr.*   #161109-00085#11-s mark
                                   INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                        sr.imaa001,sr.xmid008,sr.xmid014,sr.sum_qty
                                   #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err() 
            
            LET r_success = FALSE
            EXIT WHILE
         END IF

         INSERT INTO axmp170_item_t2(xmic004,xmic005,xmid009,xmid010,xmic006,
                                     imaa001,xmid008,seq,bdate,edate,seq1,seq2,xmid014,qty)
                VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                       sr.imaa001,sr.xmid008,l_seq,l_bdate,l_edate,l_seq1,l_seq2,sr.xmid014,sr.sum_qty)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins item t2'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT WHILE
         END IF

      END FOREACH

      LET l_seq2 = l_seq2 + 1

      IF l_seq2 MOD g_master.a2 = 1 THEN
         LET l_seq1 = l_seq1 + 1
         LET l_seq2 = 1
      END IF
      
      LET l_seq = l_seq + 1

      LET l_begin = l_end + 1 
      LET l_end   = l_end + g_master.a1

   END WHILE

   RETURN r_success
      
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_K_sum()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_K_sum()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_max_seq     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_seq1        LIKE type_t.num5
   DEFINE l_seq2        LIKE type_t.num20_6
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,     #營運據點 
                           xmic005     LIKE xmic_t.xmic005,     #組織 
                           xmid009     LIKE xmid_t.xmid009,     #客戶 
                           xmid010     LIKE xmid_t.xmid010,     #通路  
                           xmic006     LIKE xmic_t.xmic006,     #業務員 
                           imaa001     LIKE imaa_t.imaa001,     #料號 
                           xmid008     LIKE xmid_t.xmid008,     #產品特徵 
                           xmid014     LIKE xmid_t.xmid014,     #單位 
                           qty         LIKE type_t.num20_6      #數量 
                        END RECORD
   DEFINE l_begin       LIKE type_t.num5
   DEFINE l_end         LIKE type_t.num5 
   DEFINE l_seq         LIKE type_t.num20_6
   DEFINE l_n           LIKE type_t.num5

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t3;

   #取得最大的期數 
   LET l_max_seq = ''
   SELECT MAX(seq) INTO l_max_seq FROM axmp170_item_t1 
   
   SELECT MOD(l_max_seq,g_master.a1) INTO l_seq FROM DUAL;
   IF l_seq = 0 THEN
      LET l_max_seq = l_max_seq / g_master.a1
   ELSE
      SELECT MAX(seq2) INTO l_n FROM axmp170_item_t2
      LET l_max_seq = (l_max_seq - 1) * l_n + l_seq
   END IF
   
   IF cl_null(l_max_seq) THEN
      LET l_max_seq = 0
   END IF 
   
   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010, ",
               "       xmic006,imaa001,xmid008,xmid014,SUM(qty) ",
               "  FROM axmp170_item_t2 ",
               " WHERE (((seq1 - 1) * ",g_master.a2,") + seq2) BETWEEN ? ",
               "                                                   AND ? ",
               " GROUP BY xmic004,xmic005,xmid009,xmid010, ",
               "          xmic006,imaa001,xmid008,xmid014 "
   PREPARE axmp170_get_K_sum_prep FROM l_sql
   DECLARE axmp170_get_K_sum_curs CURSOR FOR axmp170_get_K_sum_prep

   LET l_begin = 1
   LET l_end   = g_master.a2

   WHILE TRUE

      IF l_end > l_max_seq THEN
         EXIT WHILE
      END IF

      FOREACH axmp170_get_K_sum_curs USING l_begin,l_end
                                      #161109-00085#11-s mod
#                                      INTO sr.*   #161109-00085#11-s mark
                                      INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                           sr.imaa001,sr.xmid008,sr.xmid014,sr.qty
                                      #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE 
            EXIT WHILE
         END IF

         LET l_seq1 = ((l_begin + l_end) / 2) / g_master.a2 
         LET l_seq1 = l_seq1 + 1
         
         SELECT MOD(((l_begin + l_end) / 2),g_master.a2) INTO l_seq2 FROM DUAL;

         INSERT INTO axmp170_item_t3(xmic004,xmic005,xmid009,xmid010,
                                     xmic006,imaa001,xmid008,seq1,seq2,xmid014,qty)
                VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                       sr.imaa001,sr.xmid008,l_seq1,l_seq2,sr.xmid014,sr.qty)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins item_t3'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT WHILE
         END IF
      END FOREACH

      LET l_begin = l_begin + 1
      LET l_end   = l_end + 1
   END WHILE

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_K_avg()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_K_avg()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,     #營運據點 
                           xmic005     LIKE xmic_t.xmic005,     #組織 
                           xmid009     LIKE xmid_t.xmid009,     #客戶 
                           xmid010     LIKE xmid_t.xmid010,     #通路  
                           xmic006     LIKE xmic_t.xmic006,     #業務員 
                           imaa001     LIKE imaa_t.imaa001,     #料號 
                           xmid008     LIKE xmid_t.xmid008,     #產品特徵 
                           seq1        LIKE type_t.num5,
                           seq2        LIKE type_t.num20_6,
                           xmid014     LIKE xmid_t.xmid014,     #單位 
                           qty         LIKE xmid_t.xmid015      #數量 
                        END RECORD

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t4;

   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,seq1,seq2,xmid014,qty ",
               "  FROM axmp170_item_t3 ",
               " ORDER BY seq1,seq2 "
   PREPARE axmp170_get_K_avg_prep FROM l_sql
   DECLARE axmp170_get_K_avg_curs CURSOR FOR axmp170_get_K_avg_prep 
   #161109-00085#11-mod-s
   #FOREACH axmp170_get_K_avg_curs INTO sr.*
   FOREACH axmp170_get_K_avg_curs 
   INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
        sr.imaa001,sr.xmid008,sr.seq1,sr.seq2,sr.xmid014,sr.qty                 
   #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      LET sr.qty = sr.qty / g_master.a2

      INSERT INTO axmp170_item_t4(xmic004,xmic005,xmid009,xmid010,xmic006,
                                  imaa001,xmid008,seq1,seq2,xmid014,qty)
             VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                    sr.imaa001,sr.xmid008,sr.seq1,sr.seq2,sr.xmid014,sr.qty)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins item_t4'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

   END FOREACH 
   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_center_avg()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_center_avg()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_seq_array   DYNAMIC ARRAY OF RECORD
                           seq1       LIKE type_t.num5,
                           seq2       LIKE type_t.num20_6 
                        END RECORD
   DEFINE l_n           LIKE type_t.num5
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           qty         LIKE xmid_t.xmid015 
                        END RECORD
   DEFINE l_new_seq     LIKE type_t.num10
   DEFINE l_new_seq1    LIKE type_t.num10
   DEFINE l_new_seq2    LIKE type_t.num10
   DEFINE l_seq         LIKE type_t.num10

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t5;
   
   #如果K是奇數，結果就會跟K期移動總合一樣 
   IF g_master.a2 MOD 2 = 1 THEN
      #在這裡直接insert 一樣的資料即可 
      #161109-00085#11-mod-s
      #INSERT INTO axmp170_item_t5 SELECT * FROM axmp170_item_t4 WHERE 1=1
      INSERT INTO axmp170_item_t5 (xmic004,xmic005,xmid009,xmid010,xmic006,
                                   imaa001,xmid008,seq1,seq2,xmid014,
                                   qty)   
      SELECT xmic004,xmic005,xmid009,xmid010,xmic006,
             imaa001,xmid008,seq1,seq2,xmid014,
             qty           
        FROM axmp170_item_t4 WHERE 1=1
      #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins item_t5'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
      END IF
   ELSE

      CALL l_seq_array.clear()

      LET l_sql = "SELECT seq1,seq2 ",
                  "  FROM axmp170_item_t4 ",
                  " GROUP BY seq1,seq2 ",
                  " ORDER BY seq1,seq2 "
      PREPARE axmp170_order_t4_prep FROM l_sql
      DECLARE axmp170_order_t4_curs CURSOR FOR axmp170_order_t4_prep 
      
      LET l_n = 1
      #161109-00085#11-mod-s
      #FOREACH axmp170_order_t4_curs INTO l_seq_array[l_n].*
      FOREACH axmp170_order_t4_curs 
      INTO l_seq_array[l_n].seq1,l_seq_array[l_n].seq2
      #161109-00085#11-mod-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         LET l_n = l_n + 1

      END FOREACH

      CALL l_seq_array.deleteElement(l_n)
      LET l_n = l_n - 1

      FOR l_n = 1 TO l_seq_array.getLength() - 1
         LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
                     "       imaa001,xmid008,xmid014,SUM(qty) ",
                     "  FROM axmp170_item_t4 ",
                     " WHERE (((seq1-1)*",g_master.a2,")+seq2) BETWEEN (((",l_seq_array[l_n].seq1,"-1) * ",g_master.a2,")+",l_seq_array[l_n].seq2,") ",     
                     "                                             AND (((",l_seq_array[l_n+1].seq1,"-1) * ",g_master.a2,")+",l_seq_array[l_n+1].seq2,") ",  
                     " GROUP BY xmic004,xmic005,xmid009,xmid010,xmic006, ",
                     "          imaa001,xmid008,xmid014 "
         PREPARE axmp170_get_center_prep FROM l_sql
         DECLARE axmp170_get_center_curs CURSOR FOR axmp170_get_center_prep 
                  
         #161109-00085#11-mod-s
         #FOREACH axmp170_get_center_curs INTO sr.*
         FOREACH axmp170_get_center_curs
         INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
              sr.imaa001,sr.xmid008,sr.xmid014,sr.qty
         #161109-00085#11-mod-e
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF

            #將2維陣列的座標，轉換成1維的位置後相加  
            LET l_new_seq = ((l_seq_array[l_n].seq1 - 1) * g_master.a2) + l_seq_array[l_n].seq2 +
                            ((l_seq_array[l_n+1].seq1 - 1) * g_master.a2) + l_seq_array[l_n+1].seq2 
                            
            #前後相加除2後，就是中間值 
            LET l_new_seq = l_new_seq / 2

            #再將一維的數字轉換為2維 
            LET l_new_seq1 = (l_new_seq / g_master.a2) + 1   #如果不+1的話，第一列會是0   
            
            SELECT MOD(l_new_seq,g_master.a2) INTO l_new_seq2 FROM dual;

            IF l_new_seq2 = 0 THEN
               LET l_new_seq1 = l_new_seq1 - 1
               LET l_new_seq2 = g_master.a2
            END IF 
            
            #中央移動平均數，應該要把數字除2 
            LET sr.qty = sr.qty / 2

            INSERT INTO axmp170_item_t5(xmic004,xmic005,xmid009,xmid010,xmic006,
                                        imaa001,xmid008,seq1,seq2,xmid014,qty)
                   VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                          sr.imaa001,sr.xmid008,l_new_seq1,l_new_seq2,sr.xmid014,sr.qty)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins item_t5'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err() 
               
               LET r_success = FALSE
               EXIT FOREACH
            END IF
         END FOREACH
      END FOR

   END IF

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_season_abnormal()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_season_abnormal()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           qty         LIKE type_t.num20_6 
                        END RECORD
   DEFINE l_seq1        LIKE type_t.num20_6
   DEFINE l_seq2        LIKE type_t.num20_6 
   DEFINE l_t2_qty      LIKE type_t.num10

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t6;

   LET l_sql = "SELECT seq1,seq2 ",
               "  FROM axmp170_item_t5 ",
               " GROUP BY seq1,seq2 ",
               " ORDER BY seq1,seq2 "
   PREPARE axmp170_order_t5_prep FROM l_sql
   DECLARE axmp170_order_t5_curs CURSOR FOR axmp170_order_t5_prep 
   
   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,xmid014,qty ",
               "  FROM axmp170_item_t5 ",
               " WHERE seq1 = ? ",
               "   AND seq2 = ? "
   PREPARE axmp170_get_item_t5_prep FROM l_sql
   DECLARE axmp170_get_item_t5_curs CURSOR FOR axmp170_get_item_t5_prep

   FOREACH axmp170_order_t5_curs INTO l_seq1,l_seq2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      FOREACH axmp170_get_item_t5_curs USING l_seq1,l_seq2
                                        #161109-00085#11-s mod
#                                        INTO sr.*   #161109-00085#11-s mark
                                        INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                             sr.imaa001,sr.xmid008,sr.xmid014,sr.qty
                                        #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err() 
            
            LET r_success = FALSE
            EXIT FOREACH
         END IF

         LET l_t2_qty = ''
         SELECT qty INTO l_t2_qty
           FROM axmp170_item_t2
          WHERE xmic004 = sr.xmic004
            AND xmic005 = sr.xmic005
            AND xmid009 = sr.xmid009
            AND xmid010 = sr.xmid010
            AND xmic006 = sr.xmic006
            AND imaa001 = sr.imaa001
            AND xmid008 = sr.xmid008
            AND xmid014 = sr.xmid014
            AND seq1    = l_seq1
            AND seq2    = l_seq2

         IF cl_null(l_t2_qty) THEN
            LET l_t2_qty = 0
         END IF

         INSERT INTO axmp170_item_t6(xmic004,xmic005,xmid009,xmid010,xmic006,
                                     imaa001,xmid008,seq1,seq2,xmid014,qty)
                VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                       sr.imaa001,sr.xmid008,l_seq1,l_seq2,sr.xmid014,l_t2_qty/sr.qty)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins item_t6' 
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

      END FOREACH

   END FOREACH

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_season_factor()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_season_factor()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           seq2        LIKE type_t.num5,
                           xmid014     LIKE xmid_t.xmid014,
                           qty         LIKE type_t.num20_6 
                        END RECORD

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t7;

   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,seq2,xmid014,SUM(qty) ",
               "  FROM axmp170_item_t6 ",
               " GROUP BY xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "          imaa001,xmid008,seq2,xmid014 ", 
               " ORDER BY xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "          imaa001,xmid008,seq2,xmid014 " 
   PREPARE axmp170_get_t6_prep FROM l_sql
   DECLARE axmp170_get_t6_curs CURSOR FOR axmp170_get_t6_prep

   INITIALIZE sr.* TO NULL 
   #161109-00085#11-mod-s
   #FOREACH axmp170_get_t6_curs INTO sr.*
   FOREACH axmp170_get_t6_curs
   INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
        sr.imaa001,sr.xmid008,sr.seq2,sr.xmid014,sr.qty
   #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #161109-00085#11-mod-s
      #INSERT INTO axmp170_item_t7 VALUES(sr.*)  #161109-00085#11   mark
      INSERT INTO axmp170_item_t7(xmic004,xmic005,xmid009,xmid010,xmic006,imaa001,xmid008,seq2,xmid014,qty) 
                  VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                         sr.imaa001,sr.xmid008,sr.seq2,sr.xmid014,sr.qty)
      #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins item_t7'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_season_index()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_season_index()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           qty         LIKE xmid_t.xmid015 
                        END RECORD
   DEFINE l_max_seq     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_total_qty   LIKE type_t.num20_6
   DEFINE l_index       LIKE type_t.num20_6

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t8;

   SELECT MAX(seq2) INTO l_max_seq
     FROM axmp170_item_t7 
     
   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,xmid014,qty ",
               "  FROM axmp170_item_t7 ",
               " WHERE seq2 = ? "
   PREPARE axmp170_get_t7_prep FROM l_sql
   DECLARE axmp170_get_t7_curs CURSOR FOR axmp170_get_t7_prep

   FOR l_n = 1 TO l_max_seq

      INITIALIZE sr.* TO NULL
      FOREACH axmp170_get_t7_curs USING l_n
                                   #161109-00085#11-s mod
#                                   INTO sr.*   #161109-00085#11-s mark
                                   INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                        sr.imaa001,sr.xmid008,sr.xmid014,sr.qty
                                   #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         SELECT SUM(qty) INTO l_total_qty
           FROM axmp170_item_t7
          WHERE xmic004 = sr.xmic004
            AND xmic005 = sr.xmic005
            AND xmid009 = sr.xmid009
            AND xmid010 = sr.xmid010
            AND xmic006 = sr.xmic006
            AND imaa001 = sr.imaa001
            AND xmid008 = sr.xmid008
            AND xmid014 = sr.xmid014

         LET l_index= sr.qty / l_total_qty * g_master.a2 
         
         INSERT INTO axmp170_item_t8(xmic004,xmic005,xmid009,xmid010,xmic006,
                                     imaa001,xmid008,seq2,xmid014,qty)
                     VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                            sr.imaa001,sr.xmid008,l_n,sr.xmid014,l_index)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins item_t8'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH

   END FOR

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_clear_season_index()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_clear_season_index()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_seq1        LIKE type_t.num5
   DEFINE l_seq2        LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           qty         LIKE type_t.num20_6 
                        END RECORD
   DEFINE l_index_num   LIKE type_t.num20_6
   DEFINE l_new_qty     LIKE type_t.num20_6  
   #ming 20150624 add ------------------------(S) 
   DEFINE l_xmic004     LIKE xmic_t.xmic004
   DEFINE l_xmic005     LIKE xmic_t.xmic005
   DEFINE l_xmid009     LIKE xmid_t.xmid009
   DEFINE l_xmid010     LIKE xmid_t.xmid010
   DEFINE l_xmic006     LIKE xmic_t.xmic006
   DEFINE l_imaa001     LIKE imaa_t.imaa001
   DEFINE l_xmid008     LIKE xmid_t.xmid008
   DEFINE l_xmid014     LIKE xmid_t.xmid014
   DEFINE l_seq         LIKE type_t.num20_6
   DEFINE l_qty         LIKE type_t.num20_6
   #ming 20150624 add ------------------------(E) 

   LET r_success = TRUE 
   
   DELETE FROM axmp170_item_t9;

   LET l_sql = "SELECT DISTINCT seq1,seq2 ",
               "  FROM axmp170_item_t2 ",
               " ORDER BY seq1,seq2 "
   PREPARE axmp170_get_t2_order_prep FROM l_sql
   DECLARE axmp170_get_t2_order_curs CURSOR FOR axmp170_get_t2_order_prep 
   
   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,xmid014,qty ",
               "  FROM axmp170_item_t2 ",
               " WHERE seq1 = ? ",
               "   AND seq2 = ? "
   PREPARE axmp170_get_t2_data_prep FROM l_sql
   DECLARE axmp170_get_t2_data_curs CURSOR FOR axmp170_get_t2_data_prep

   IF g_master.type_way = '1' THEN
      #簡單線性趨勢   
      #直接把一開始的每季數量總合代入即可 
      #INSERT INTO axmp170_item_t9 SELECT * FROM axmp170_item_t2 WHERE 1=1 
      
      #ming 20150624 modify --------------------------------------------------(S) 
      #LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ", 
      #            "       imaa001,xmid008,seq1,seq2,xmid014,qty ", 
      #            "  FROM axmp170_item_t2 ", 
      #            " WHERE 1=1 " 
      #PREPARE axmp170_ins_t9_prep FROM l_sql 
      #DECLARE axmp170_ins_t9_curs CURSOR FOR axmp170_ins_t9_prep 
      #
      #FOREACH axmp170_ins_t9_curs INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010, 
      #                                 sr.xmic006,sr.imaa001,sr.xmid008,l_seq1,l_seq2, 
      #                                 sr.xmid014,sr.qty 
      #   INSERT INTO axmp170_item_t9(xmic004,xmic005,xmid009,xmid010,xmic006,
      #                            imaa001,xmid008,seq1,seq2,xmid014,qty) 
      #          VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006, 
      #                 sr.imaa001,sr.xmid008,l_seq1,l_seq2,sr.xmid014,sr.qty ) 
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.extend = 'ins item_t9'
      #      LET g_errparam.code   = SQLCA.sqlcode
      #      LET g_errparam.popup  = TRUE
      #      CALL cl_err()
      # 
      #      LET r_success = FALSE 
      #      EXIT FOREACH 
      #   END IF
      #END FOREACH 

      LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010, ",
                  "       xmic006,imaa001,xmid008,xmid014  ", 
                  "  FROM axmp170_item_t1 ",
                  " GROUP BY xmic004,xmic005,xmid009,xmid010, ",
                  "          xmic006,imaa001,xmid008,xmid014  ",
                  " ORDER BY xmic004,xmic005,xmid009,xmid010, ",
                  "          xmic006,imaa001,xmid008,xmid014  "
      PREPARE axmp170_group_t1_prep FROM l_sql
      DECLARE axmp170_group_t1_curs CURSOR FOR axmp170_group_t1_prep

      FOREACH axmp170_group_t1_curs INTO l_xmic004,l_xmic005,l_xmid009,l_xmid010,
                                         l_xmic006,l_imaa001,l_xmid008,l_xmid014
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         LET l_sql = "SELECT seq,qty ",
                     "  FROM axmp170_item_t1 ",
                     " WHERE xmic004 = '",l_xmic004,"' ",
                     "   AND xmic005 = '",l_xmic005,"' ",
                     "   AND xmid009 = '",l_xmid009,"' ",
                     "   AND xmid010 = '",l_xmid010,"' ",
                     "   AND xmic006 = '",l_xmic006,"' ",
                     "   AND imaa001 = '",l_imaa001,"' ", 
                     "   AND xmid008 = '",l_xmid008,"' ",
                     "   AND xmid014 = '",l_xmid014,"' ",
                     " ORDER BY seq "

         PREPARE axmp170_ins_t9_prep FROM l_sql
         DECLARE axmp170_ins_t9_curs CURSOR FOR axmp170_ins_t9_prep

         INITIALIZE sr.* TO NULL

         LET l_seq1 = 0
         LET l_seq2 = 1
         LET sr.xmic004 = l_xmic004
         LET sr.xmic005 = l_xmic005
         LET sr.xmid009 = l_xmid009
         LET sr.xmid010 = l_xmid010
         LET sr.xmic006 = l_xmic006
         LET sr.imaa001 = l_imaa001
         LET sr.xmid008 = l_xmid008
         LET sr.xmid014 = l_xmid014
         FOREACH axmp170_ins_t9_curs INTO l_seq,l_qty
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET r_success = FALSE 
               EXIT FOREACH
            END IF

            LET sr.qty = l_qty

            INSERT INTO axmp170_item_t9(xmic004,xmic005,xmid009,xmid010,xmic006,
                                     imaa001,xmid008,seq1,seq2,xmid014,qty)
                   VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                          sr.imaa001,sr.xmid008,l_seq1,l_seq2,sr.xmid014,sr.qty )
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins item_t9'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF

            LET l_seq2 = l_seq2 + 1

         END FOREACH

      END FOREACH

      #ming 20150624 modify --------------------------------------------------(E) 
            
      
   ELSE
      #季節變動 
      #利用季節指數算出資料 

      FOREACH axmp170_get_t2_order_curs INTO l_seq1,l_seq2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         FOREACH axmp170_get_t2_data_curs USING l_seq1,l_seq2
                                           #161109-00085#11-s mod
#                                           INTO sr.*   #161109-00085#11-s mark
                                           INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                                sr.imaa001,sr.xmid008,sr.xmid014,sr.qty
                                           #161109-00085#11-e mod
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF

            #取得季節指數 
            SELECT qty INTO l_index_num
              FROM axmp170_item_t8
             WHERE xmic004 = sr.xmic004
               AND xmic005 = sr.xmic005
               AND xmid009 = sr.xmid009
               AND xmid010 = sr.xmid010
               AND xmic006 = sr.xmic006
               AND imaa001 = sr.imaa001 
               AND xmid008 = sr.xmid008
               AND xmid014 = sr.xmid014
               AND seq2    = l_seq2

            LET l_new_qty = sr.qty / l_index_num


            INSERT INTO axmp170_item_t9(xmic004,xmic005,xmid009,xmid010,xmic006,
                                        imaa001,xmid008,seq1,seq2,xmid014,qty)
                        VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                               sr.imaa001,sr.xmid008,l_seq1,l_seq2,sr.xmid014,l_new_qty)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins item_t9'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET r_success = FALSE
               EXIT FOREACH
            END IF
         END FOREACH
      END FOREACH

   END IF

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_permutation()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_permutation()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_seq1        LIKE type_t.num5
   DEFINE l_seq2        LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           qty         LIKE type_t.num20_6 
                        END RECORD
   DEFINE l_seq         LIKE type_t.num5

   LET r_success = TRUE 
   
   DELETE FROM axmp170_tmp04;           #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04

   LET l_sql  = "SELECT DISTINCT seq1,seq2 ",
                "  FROM axmp170_item_t9 ", 
                " ORDER BY seq1,seq2 " 
   PREPARE axmp170_order_t9_prep FROM l_sql
   DECLARE axmp170_order_t9_curs CURSOR FOR axmp170_order_t9_prep

   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,xmid014,qty ",
               "  FROM axmp170_item_t9 ",
               " WHERE seq1 = ? ", 
               "   AND seq2 = ? "
   PREPARE axmp170_get_t9_data_prep FROM l_sql
   DECLARE axmp170_get_t9_data_curs CURSOR FOR axmp170_get_t9_data_prep

   LET l_seq = 1
   FOREACH axmp170_order_t9_curs INTO l_seq1,l_seq2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      FOREACH axmp170_get_t9_data_curs USING l_seq1,l_seq2 
                                        #161109-00085#11-s mod
#                                        INTO sr.*   #161109-00085#11-s mark
                                        INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                             sr.imaa001,sr.xmid008,sr.xmid014,sr.qty
                                        #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         INSERT INTO axmp170_tmp04(xmic004,xmic005,xmid009,xmid010,xmic006,          #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
                                      imaa001,xmid008,xmid014,seq,qty) 
                VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                       sr.imaa001,sr.xmid008,sr.xmid014,l_seq,sr.qty )
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins item_t10'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH
      LET l_seq = l_seq + 1
   END FOREACH

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_SStt()
#                  RETURNING r_success
# Return code....: r_success 
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_SStt()
    DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_t           LIKE type_t.num5
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014,
                           qty         LIKE type_t.num20_6 
                        END RECORD 
   DEFINE l_tcount      LIKE type_t.num10           #計算筆數 
   DEFINE l_tsum        LIKE type_t.num20_6         #計算期別總合 
   DEFINE l_Ybar1       LIKE type_t.num20_6
   DEFINE l_tbar1       LIKE type_t.num20_6
   DEFINE l_sstt        LIKE type_t.num20_6
   DEFINE l_ssty        LIKE type_t.num20_6
   DEFINE l_Yt          LIKE type_t.num20_6 

   LET r_success = TRUE 
   
   DELETE FROM axmp170_SStt;
   DELETE FROM axmp170_SSty;

   LET l_sql = "SELECT DISTINCT seq ",
               "  FROM axmp170_tmp04 ",         #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
               " ORDER BY seq " 
   PREPARE axmp170_order_t10_prep FROM l_sql 
   DECLARE axmp170_order_t10_curs CURSOR FOR axmp170_order_t10_prep

   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,xmid014,qty ",
               "  FROM axmp170_tmp04 ",          #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
               " WHERE seq = ? "
   PREPARE axmp170_get_t10_group_prep FROM l_sql
   DECLARE axmp170_get_t10_group_curs CURSOR FOR axmp170_get_t10_group_prep

   FOREACH axmp170_order_t10_curs INTO l_t
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      FOREACH axmp170_get_t10_group_curs USING l_t
                                          #161109-00085#11-s mod
#                                          INTO sr.*   #161109-00085#11-s mark
                                          INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                                               sr.imaa001,sr.xmid008,sr.xmid014,sr.qty
                                          #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         LET l_tsum = ''
         SELECT SUM(seq) INTO l_tsum 
           FROM axmp170_tmp04            #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
          WHERE xmic004 = sr.xmic004
            AND xmic005 = sr.xmic005
            AND xmid009 = sr.xmid009
            AND xmid010 = sr.xmid010
            AND xmic006 = sr.xmic006
            AND imaa001 = sr.imaa001
            AND xmid008 = sr.xmid008
            AND xmid014 = sr.xmid014
         IF cl_null(l_tsum) THEN
            LET l_tsum = 0
         END IF 

         LET l_tcount = ''
         SELECT COUNT(*) INTO l_tcount
           FROM axmp170_tmp04           #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
          WHERE xmic004 = sr.xmic004
            AND xmic005 = sr.xmic005
            AND xmid009 = sr.xmid009
            AND xmid010 = sr.xmid010
            AND xmic006 = sr.xmic006 
            AND imaa001 = sr.imaa001 
            AND xmid008 = sr.xmid008
            AND xmid014 = sr.xmid014
         IF cl_null(l_tcount) THEN 
            LET l_tcount = 0
         END IF 
         
         IF l_tcount = 0 THEN
            RETURN r_success
         END IF

         LET l_tbar1 = l_tsum / l_tcount     #取得期別的平均值  

         #計算SStt 
         SELECT POWER((l_t - l_tbar1),2) INTO l_sstt
           FROM DUAL; 

         INSERT INTO axmp170_SStt(xmic004,xmic005,xmid009,xmid010,xmic006,
                                  imaa001,xmid008,xmid014,seq,sstt)
                VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                       sr.imaa001,sr.xmid008,sr.xmid014,l_t,l_sstt)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins SStt'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         #準備計算SSty  
         LET l_Yt = ''
         SELECT SUM(qty) INTO l_Yt
           FROM axmp170_tmp04            #160727-00019#23 Mod  axmp170_item_t10--> axmp170_tmp04
          WHERE xmic004 = sr.xmic004
            AND xmic005 = sr.xmic005
            AND xmid009 = sr.xmid009
            AND xmid010 = sr.xmid010
            AND xmic006 = sr.xmic006
            AND imaa001 = sr.imaa001
            AND xmid008 = sr.xmid008
            AND xmid014 = sr.xmid014
         IF cl_null(l_Yt) THEN
            LET l_Yt = 0
         END IF

         LET l_Ybar1 = l_Yt / l_tcount 

         LET l_ssty = (sr.qty - l_Ybar1) * (l_t - l_tbar1) 

         INSERT INTO axmp170_SSty(xmic004,xmic005,xmid009,xmid010,xmic006,
                                  imaa001,xmid008,xmid014,seq,ssty,l_Ybar,l_tbar)
                VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                       sr.imaa001,sr.xmid008,sr.xmid014,l_t,l_ssty,l_Ybar1,l_tbar1) 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins SSty'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

      END FOREACH
   END FOREACH

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_alpha_beta()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_alpha_beta()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014
                        END RECORD
   DEFINE l_Ybar1       LIKE type_t.num20_6
   DEFINE l_tbar1       LIKE type_t.num20_6
   DEFINE l_alpha       LIKE type_t.num20_6
   DEFINE l_beta        LIKE type_t.num20_6
   DEFINE l_sum_sstt    LIKE type_t.num20_6
   DEFINE l_sum_ssty    LIKE type_t.num20_6 

   LET r_success = TRUE 
   
   DELETE FROM axmp170_tmp05;             #160727-00019#23 Mod  axmp170_alpha_beta--> axmp170_tmp05

   LET l_sql = "SELECT DISTINCT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "                imaa001,xmid008,xmid014 ",
               "  FROM axmp170_SStt "
   PREPARE axmp170_get_group_prep FROM l_sql
   DECLARE axmp170_get_group_curs CURSOR FOR axmp170_get_group_prep 
   
   INITIALIZE sr.* TO NULL
   #161109-00085#11-mod-s
   #FOREACH axmp170_get_group_curs INTO sr.*
   FOREACH axmp170_get_group_curs
   INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
        sr.imaa001,sr.xmid008,sr.xmid014
   #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      LET l_sum_sstt = 0
      SELECT SUM(sstt) INTO l_sum_sstt
        FROM axmp170_SStt
       WHERE xmic004 = sr.xmic004
         AND xmic005 = sr.xmic005
         AND xmid009 = sr.xmid009
         AND xmid010 = sr.xmid010
         AND xmic006 = sr.xmic006
         AND imaa001 = sr.imaa001
         AND xmid008 = sr.xmid008
         AND xmid014 = sr.xmid014
      IF cl_null(l_sum_sstt) THEN
         LET l_sum_sstt = 0
      END IF 
      
      LET l_sum_ssty = 0
      SELECT SUM(ssty) INTO l_sum_ssty
        FROM axmp170_SSty
       WHERE xmic004 = sr.xmic004
         AND xmic005 = sr.xmic005
         AND xmid009 = sr.xmid009
         AND xmid010 = sr.xmid010
         AND xmic006 = sr.xmic006
         AND imaa001 = sr.imaa001
         AND xmid008 = sr.xmid008
         AND xmid014 = sr.xmid014
      IF cl_null(l_sum_ssty) THEN
         LET l_sum_ssty = 0
      END IF

      LET l_beta = l_sum_ssty / l_sum_sstt

      SELECT DISTINCT l_Ybar,l_tbar INTO l_Ybar1,l_tbar1 
        FROM axmp170_SSty
       WHERE xmic004 = sr.xmic004
         AND xmic005 = sr.xmic005
         AND xmid009 = sr.xmid009
         AND xmid010 = sr.xmid010
         AND xmic006 = sr.xmic006
         AND imaa001 = sr.imaa001
         AND xmid008 = sr.xmid008
         AND xmid014 = sr.xmid014

      LET l_alpha = l_Ybar1 - (l_beta * l_tbar1) 
      
      INSERT INTO axmp170_tmp05(xmic004,xmic005,xmid009,xmid010,xmic006,             #160727-00019#23 Mod  axmp170_alpha_beta--> axmp170_tmp05
                                     imaa001,xmid008,xmid014,l_alpha,l_beta)
                  VALUES(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                         sr.imaa001,sr.xmid008,sr.xmid014,l_alpha,l_beta)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins alpha_beta'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

   END FOREACH

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_fore_time()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2015/05/19 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_fore_time()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sq          STRING
   DEFINE l_xmib002     LIKE xmib_t.xmib002
   DEFINE l_xmib003     LIKE xmib_t.xmib003
   DEFINE l_start_day   LIKE type_t.dat     #區間開始日   
   DEFINE l_end_day     LIKE type_t.dat     #區間結束日   
   DEFINE l_sql         STRING 
   DEFINE l_yy          LIKE type_t.num5
   DEFINE l_mm          LIKE type_t.num5
   DEFINE l_a           LIKE type_t.num5
   DEFINE l_new_day     LIKE type_t.dat
   

   LET r_success = TRUE 
   
   DELETE FROM axmp170_tmp06;             #160727-00019#23 Mod  p170_fore_item_t--> axmp170_tmp06

   LET l_sql = "SELECT xmib002,xmib003 ",
               "  FROM xmib_t ",
               " WHERE xmibent = '",g_enterprise,"' ",
               "   AND xmib001 = '",g_master.xmic001,"' ",
               " ORDER BY xmib002 "
   PREPARE axmp170_xmib_prep FROM l_sql
   DECLARE axmp170_xmib_curs CURSOR FOR axmp170_xmib_prep 
   
   LET l_start_day = ''
   LET l_end_day   = ''

   FOREACH axmp170_xmib_curs INTO l_xmib002,l_xmib003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF 
      
      IF cl_null(l_start_day) THEN
         LET l_start_day = g_master.xmic002
      ELSE
         #LET l_start_day = l_end_day + 1 
         SELECT ADD_MONTHS(l_end_day,0)+1 INTO l_start_day FROM dual;
      END IF

      CASE l_xmib003
         WHEN '0'     #天  
            SELECT ADD_MONTHS(l_start_day,0)+1-1 INTO l_end_day FROM dual;
         WHEN '1'     #週   
            SELECT ADD_MONTHS(l_start_day,0)+7-1 INTO l_end_day FROM dual;
         WHEN '2'     #旬 
            SELECT ADD_MONTHS(l_start_day,0)+10-1 INTO l_end_day FROM dual;
         WHEN '3'     #月  
            LET l_yy = YEAR(l_start_day)
            LET l_mm = MONTH(l_start_day)
            LET l_new_day = MDY(l_mm,1,l_yy)
            SELECT ADD_MONTHS(l_start_day,0) - ADD_MONTHS(l_new_day,0) INTO l_a
              FROM dual;
            IF l_a = 0 THEN
               #如果是1號的話，就直接取月底 
               LET l_end_day = s_date_get_last_date(l_start_day)
            ELSE
               #如果不是1號的話，就看目前是幾號，直接+1個月 
               SELECT ADD_MONTHS(l_start_day,1)-1 INTO l_end_day FROM dual;
            END IF
      END CASE

      INSERT INTO axmp170_tmp06(xmib002,xmib003,bdate,edate)           #160727-00019#23 Mod  p170_fore_item_t--> axmp170_tmp06
                  VALUES(l_xmib002,l_xmib003,l_start_day,l_end_day)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins fore_item_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF 
      
   END FOREACH

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_chk_date()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success
# Date & Author..: 2015/06/05 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_chk_date()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_seq         LIKE type_t.num10
   DEFINE l_start_day   LIKE type_t.dat
   DEFINE l_end_day     LIKE type_t.dat
   DEFINE l_bdate       LIKE type_t.dat
   DEFINE l_edate       LIKE type_t.dat
   DEFINE l_last_day    LIKE type_t.dat
   DEFINE l_i           LIKE type_t.num5      #用來跑迴圈的 
   DEFINE l_run         LIKE type_t.num5      #用來跑迴圈的  
   DEFINE l_yy          LIKE type_t.num5      #年 
   DEFINE l_mm          LIKE type_t.num5      #月 

   LET r_success = TRUE 
   
   DELETE FROM axmp170_tmp07;        #160727-00019#23 Mod  axmp170_chkdate_t--> axmp170_tmp07         

   #預設為簡單線性，只要run一次即可 
   LET l_run = 1
   IF g_master.type_way = '2' THEN
      #如果是季節變動，則要看每季幾期來決定每季的起始、截止日 
      LET l_run = g_master.a1
   END IF

   #取得預測編號的最後一期的結束日 
   LET l_last_day = ''
   SELECT MAX(edate) INTO l_last_day
     FROM axmp170_tmp06            #160727-00019#23 Mod  p170_fore_item_t--> axmp170_tmp06

   #要產生比預測編號最後一期的結束日還大的期別資料  
   LET l_seq = 1  
   LET l_start_day = ''
   LET l_end_day   = ''
   LET l_bdate     = ''
   LET l_edate     = ''
   WHILE TRUE
      #取得區間的起始日 
      IF cl_null(l_start_day) THEN
         #LET l_start_day = g_master.xmic002 
         LET l_start_day = g_master.bdate
      ELSE
         SELECT ADD_MONTHS(l_end_day,0)+1 INTO l_start_day FROM dual;
      END IF

      #如果這一個區間的起始日，已經超過了要預測的最後一期結束日，就不用再做了 
      IF l_start_day > l_last_day THEN
         EXIT WHILE
      END IF

      FOR l_i = 1 TO l_run
         IF cl_null(l_bdate) THEN
            LET l_bdate = l_start_day
         ELSE
            SELECT ADD_MONTHS(l_edate,0)+1 INTO l_bdate FROM dual;
         END IF 
         
         CASE g_master.cycle
            WHEN '1'     #週  
               SELECT ADD_MONTHS(l_bdate,0) + 6 INTO l_edate FROM dual;
            WHEN '2'     #旬  
               LET l_yy = YEAR(l_bdate)
               LET l_mm = MONTH(l_bdate)
               IF l_bdate < MDY(l_mm,20,l_yy) THEN
                  #上旬、中旬 直接加9天 
                  SELECT ADD_MONTHS(l_bdate,0) + 9 INTO l_edate FROM dual;
               ELSE
                  #下旬會有月底的問題 所以可能會是28、29、30、31  
                  LET l_edate = s_date_get_last_date(l_bdate)
               END IF
            WHEN '3'     #月  
               LET l_edate = s_date_get_last_date(l_bdate)
         END CASE

         LET l_end_day = l_edate

      END FOR

      INSERT INTO axmp170_tmp07(seq,bdate,edate)              #160727-00019#23 Mod  axmp170_chkdate_t--> axmp170_tmp07
                  VALUES(l_seq,l_start_day,l_end_day)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins chkdate'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         LET r_success = FALSE
         EXIT WHILE
      END IF

      LET l_seq = l_seq + 1

   END WHILE

   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_produce_data()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success
# Date & Author..: 2015/06/05 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_produce_data()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE sr            RECORD
                           xmic004     LIKE xmic_t.xmic004,
                           xmic005     LIKE xmic_t.xmic005,
                           xmid009     LIKE xmid_t.xmid009,
                           xmid010     LIKE xmid_t.xmid010,
                           xmic006     LIKE xmic_t.xmic006,
                           imaa001     LIKE imaa_t.imaa001,
                           xmid008     LIKE xmid_t.xmid008,
                           xmid014     LIKE xmid_t.xmid014
                        END RECORD
   DEFINE l_group       RECORD
                           xmib002     LIKE xmib_t.xmib002,
                           xmib003     LIKE xmib_t.xmib003,
                           bdate       LIKE type_t.dat,
                           edate       LIKE type_t.dat
                        END RECORD
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_qty         LIKE type_t.num20_6

   LET r_success = TRUE 
   
   DELETE FROM axmp170_tmp08;            #160727-00019#23 Mod  axmp170_fore_data--> axmp170_tmp08

   LET l_sql = "SELECT xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "       imaa001,xmid008,xmid014 ",
               "  FROM axmp170_SStt ",
               " GROUP BY xmic004,xmic005,xmid009,xmid010,xmic006, ", 
               "          imaa001,xmid008,xmid014 ",
               " ORDER BY xmic004,xmic005,xmid009,xmid010,xmic006, ",
               "          imaa001,xmid008,xmid014 "
   PREPARE axmp170_data_group_prep FROM l_sql
   DECLARE axmp170_data_group_curs CURSOR FOR axmp170_data_group_prep

   LET l_sql = "SELECT xmib002,xmib003,bdate,edate ",
               "  FROM axmp170_tmp06 ",     #160727-00019#23 Mod  p170_fore_item_t--> axmp170_tmp06
               " ORDER BY xmib002 "        #照期別排應該就夠了  
   PREPARE axmp170_get_fore_item_order_prep FROM l_sql
   DECLARE axmp170_get_fore_item_order_curs CURSOR FOR axmp170_get_fore_item_order_prep
   
   #161109-00085#11-mod-s
   #FOREACH axmp170_data_group_curs INTO sr.*
   FOREACH axmp170_data_group_curs
   INTO sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
        sr.imaa001,sr.xmid008,sr.xmid014
   #161109-00085#11-mod-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #161109-00085#11-mod-s
      #FOREACH axmp170_get_fore_item_order_curs INTO l_group.*
      FOREACH axmp170_get_fore_item_order_curs
      INTO l_group.xmib002,l_group.xmib003,l_group.bdate,l_group.edate
      #161109-00085#11-mod-e      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         #取得預測數量        
         CALL axmp170_get_qty(sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                              sr.imaa001,sr.xmid008,sr.xmid014,l_group.bdate,l_group.edate)
              RETURNING l_success,l_qty
         IF NOT l_success THEN
            LET r_success = FALSE
            EXIT FOREACH
         END IF

         #在這裡要寫入確切的資料到temp table  
         INSERT INTO axmp170_tmp08(ent,xmic004,xmic005,xmid009,xmid010,xmic006,                #160727-00019#23 Mod  axmp170_fore_data--> axmp170_tmp08
                                       imaa001,xmid008,xmid014,seq,bdate,edate,qty)
                     VALUES(g_enterprise,sr.xmic004,sr.xmic005,sr.xmid009,sr.xmid010,sr.xmic006,
                            sr.imaa001,sr.xmid008,sr.xmid014,l_group.xmib002,
                            l_group.bdate,l_group.edate,l_qty)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins fore data'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err() 
            
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH

   END FOREACH

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_get_qty(p_xmic004,p_xmic005,p_xmid009,p_xmid010,p_xmic006,p_imaa001,p_xmid008,p_xmid014,p_bdate,p_edate)
#                  RETURNING r_success,r_qty
# Input parameter: 
#                : 
# Return code....: r_success
#                : r_qty 
# Date & Author..: 2015/06/05 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_get_qty(p_xmic004,p_xmic005,p_xmid009,p_xmid010,p_xmic006,p_imaa001,p_xmid008,p_xmid014,p_bdate,p_edate)
   DEFINE p_xmic004     LIKE xmic_t.xmic004
   DEFINE p_xmic005     LIKE xmic_t.xmic005
   DEFINE p_xmid009     LIKE xmid_t.xmid009
   DEFINE p_xmid010     LIKE xmid_t.xmid010
   DEFINE p_xmic006     LIKE xmic_t.xmic006
   DEFINE p_imaa001     LIKE imaa_t.imaa001
   DEFINE p_xmid008     LIKE xmid_t.xmid008
   DEFINE p_xmid014     LIKE xmid_t.xmid014
   DEFINE p_bdate       LIKE type_t.dat
   DEFINE p_edate       LIKE type_t.dat
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_qty         LIKE type_t.num20_6
   DEFINE l_tg          RECORD
                           seq         LIKE type_t.num5,
                           bdate       LIKE type_t.dat,
                           edate       LIKE type_t.dat
                        END RECORD
   DEFINE l_a           LIKE type_t.num20_6     #截距α  
   DEFINE l_b           LIKE type_t.num20_6     #斜率β  
   DEFINE l_season_num  LIKE type_t.num20_6     #季節指數  
   DEFINE l_day_num     LIKE type_t.num10       #總天數 
   DEFINE l_low_num     LIKE type_t.num10       #本期天數  
   DEFINE l_up_num      LIKE type_t.num10
   DEFINE l_n           LIKE type_t.num10
   DEFINE l_seq2        LIKE type_t.num10
   DEFINE l_sql         STRING
   DEFINE l_qty         LIKE type_t.num20_6  
   #ming 20150625 add ---------------------------------(S) 
   DEFINE l_next_s_day  LIKE type_t.dat           #判斷下一波要日期的計算日要從何時開始 
   #ming 20150625 add ---------------------------------(E) 
   
   LET r_success = TRUE
   LET r_qty = 0 
   
   #ming 20150625 add ---------------------------------(S) 
   LET l_next_s_day = p_bdate
   #如果預測的資料如下 
   #7/1 ~ 7/1    
   #7/2 ~ 7/2 
   #7/3 ~ 8/2    #這裡應該是算7月的  29/31 與8月的 2/31  
   #ming 20150625 add ---------------------------------(E) 

   #取得要處理的天數 
   LET l_day_num = 0
   SELECT (ADD_MONTHS(p_edate,0) - ADD_MONTHS(p_bdate,0)) + 1 INTO l_day_num
     FROM dual;

   #取得斜率與截距 
   LET l_a = ''
   LET l_b = ''
   SELECT l_alpha,l_beta INTO l_a,l_b
     FROM axmp170_tmp05              #160727-00019#23 Mod  axmp170_alpha_beta--> axmp170_tmp05
    WHERE xmic004 = p_xmic004
      AND xmic005 = p_xmic005
      AND xmid009 = p_xmid009
      AND xmid010 = p_xmid010
      AND xmic006 = p_xmic006
      AND imaa001 = p_imaa001
      AND xmid008 = p_xmid008
      AND xmid014 = p_xmid014
   IF cl_null(l_a) THEN
      LET l_a = 0
   END IF
   IF cl_null(l_b) THEN
      LET l_b = 0
   END IF 
   
   LET l_sql = "SELECT seq,bdate,edate ",
               "  FROM axmp170_tmp07 ",            #160727-00019#23 Mod  axmp170_chkdate_t--> axmp170_tmp07
               " WHERE edate >= '",p_bdate,"' ",
               " ORDER BY seq "
   PREPARE axmp170_get_chkdate_order_prep FROM l_sql
   DECLARE axmp170_get_chkdate_order_curs CURSOR FOR axmp170_get_chkdate_order_prep

   LET l_n   = 1
   LET l_qty = 0
   #161109-00085#11-mod-s
   #FOREACH axmp170_get_chkdate_order_curs INTO l_tg.*
   FOREACH axmp170_get_chkdate_order_curs
   INTO l_tg.seq,l_tg.bdate,l_tg.edate 
   #161109-00085#11-mod-e 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #分母的天數  
      CASE g_master.cycle
         WHEN '1'
            LET l_low_num = 7
            IF g_master.type_way = '2' THEN
               LET l_low_num = l_low_num * g_master.a1
            END IF
         WHEN '2'
            LET l_low_num = 10
            IF g_master.type_way = '2' THEN
               LET l_low_num = l_low_num * g_master.a1
            END IF
         WHEN '3'
            SELECT (ADD_MONTHS(l_tg.edate,0) - ADD_MONTHS(l_tg.bdate,0)) + 1 INTO l_low_num
              FROM dual;
      END CASE 
      
      #ming 20150625 add ---------------------(S) 
      #分子  
      IF p_edate >= l_tg.edate THEN
         SELECT (ADD_MONTHS(l_tg.edate,0) - ADD_MONTHS(l_next_s_day,0)) + 1 INTO l_up_num
           FROM dual;
      ELSE
         SELECT (ADD_MONTHS(p_edate,0) - ADD_MONTHS(l_next_s_day,0)) + 1 INTO l_up_num
           FROM dual;
      END IF

      #下一波的開始日 
      SELECT ADD_MONTHS(l_tg.edate,0) + 1 INTO l_next_s_day FROM dual; 
      
      LET l_day_num = l_day_num - l_up_num 
      #ming 20150625 add ---------------------(E) 

      ##如果此區間的天數，超過要處理的天數 
      #IF l_low_num >= l_day_num THEN
      #   LET l_up_num = l_day_num    #就直接丟到分子  
      #   LET l_day_num = 0
      #ELSE
      #   IF l_n = 1 THEN
      #      SELECT (ADD_MONTHS(l_tg.edate,0) - ADD_MONTHS(p_bdate,0)) + 1 INTO l_up_num
      #        FROM dual;
      #      IF (l_day_num - l_up_num) > 0 THEN
      #         LET l_day_num = l_day_num - l_up_num
      #      ELSE
      #         #這裡可能是多寫的 
      #         LET l_up_num = l_day_num 
      #         LET l_day_num = 0
      #      END IF
      #   END IF
      #END IF


      #預設季節指數為1 
      LET l_season_num = 1
      IF g_master.type_way = '2' THEN
         #如果是季節變動的話，要另外去找季節指數 
         LET l_seq2 = ''
         SELECT MOD(l_tg.seq,g_master.a2) INTO l_seq2 FROM dual;

         IF l_seq2 = 0 THEN
            LET l_seq2 = 4
         END IF

         SELECT qty INTO l_season_num
           FROM axmp170_item_t8
          WHERE xmic004 = p_xmic004
            AND xmic005 = p_xmic005
            AND xmid009 = p_xmid009
            AND xmid010 = p_xmid010
            AND xmic006 = p_xmic006
            AND imaa001 = p_imaa001
            AND xmid008 = p_xmid008
            AND xmid014 = p_xmid014 
            AND seq2    = l_seq2
      END IF

      LET l_qty = l_qty + (((l_a + l_b * l_tg.seq) * (l_up_num / l_low_num)) * l_season_num )

      IF l_day_num = 0 THEN
         EXIT FOREACH
      END IF

      LET l_n = l_n + 1

   END FOREACH

   LET r_qty = l_qty

   RETURN r_success,r_qty 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_chk_xmid015(p_xmid011,p_ac,p_xmid015,p_bdate,p_edate)
# Input parameter: 
#                : 
# Date & Author..: 2015/06/05 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_chk_xmid015(p_xmid011,p_ac,p_xmid015,p_bdate,p_edate)
   DEFINE p_xmid011     LIKE xmid_t.xmid011
   DEFINE p_ac          LIKE type_t.num5
   DEFINE p_xmid015     LIKE xmid_t.xmid015 
   DEFINE p_bdate       LIKE xmic_t.xmic002
   DEFINE p_edate       LIKE xmic_t.xmic002

   CASE p_xmid011
      WHEN 1
         LET g_detail_d[p_ac].xmid015_01 = p_xmid015 
         LET g_detail_d[p_ac].bdate_01 = p_bdate
         LET g_detail_d[p_ac].edate_01 = p_edate
      WHEN 2
         LET g_detail_d[p_ac].xmid015_02 = p_xmid015 
         LET g_detail_d[p_ac].bdate_02 = p_bdate
         LET g_detail_d[p_ac].edate_02 = p_edate
      WHEN 3
         LET g_detail_d[p_ac].xmid015_03 = p_xmid015 
         LET g_detail_d[p_ac].bdate_03 = p_bdate
         LET g_detail_d[p_ac].edate_03 = p_edate
      WHEN 4
         LET g_detail_d[p_ac].xmid015_04 = p_xmid015 
         LET g_detail_d[p_ac].bdate_04 = p_bdate
         LET g_detail_d[p_ac].edate_04 = p_edate
      WHEN 5
         LET g_detail_d[p_ac].xmid015_05 = p_xmid015 
         LET g_detail_d[p_ac].bdate_05 = p_bdate
         LET g_detail_d[p_ac].edate_05 = p_edate
      WHEN 6
         LET g_detail_d[p_ac].xmid015_06 = p_xmid015 
         LET g_detail_d[p_ac].bdate_06 = p_bdate
         LET g_detail_d[p_ac].edate_06 = p_edate
      WHEN 7
         LET g_detail_d[p_ac].xmid015_07 = p_xmid015 
         LET g_detail_d[p_ac].bdate_07 = p_bdate
         LET g_detail_d[p_ac].edate_07 = p_edate
      WHEN 8
         LET g_detail_d[p_ac].xmid015_08 = p_xmid015 
         LET g_detail_d[p_ac].bdate_08 = p_bdate
         LET g_detail_d[p_ac].edate_08 = p_edate
      WHEN 9
         LET g_detail_d[p_ac].xmid015_09 = p_xmid015 
         LET g_detail_d[p_ac].bdate_09 = p_bdate
         LET g_detail_d[p_ac].edate_09 = p_edate
      WHEN 10
         LET g_detail_d[p_ac].xmid015_10 = p_xmid015 
         LET g_detail_d[p_ac].bdate_10 = p_bdate
         LET g_detail_d[p_ac].edate_10 = p_edate
      WHEN 11
         LET g_detail_d[p_ac].xmid015_11 = p_xmid015 
         LET g_detail_d[p_ac].bdate_11 = p_bdate
         LET g_detail_d[p_ac].edate_11 = p_edate
      WHEN 12
         LET g_detail_d[p_ac].xmid015_12 = p_xmid015  
         LET g_detail_d[p_ac].bdate_12 = p_bdate
         LET g_detail_d[p_ac].edate_12 = p_edate
      WHEN 13
         LET g_detail_d[p_ac].xmid015_13 = p_xmid015 
         LET g_detail_d[p_ac].bdate_13 = p_bdate
         LET g_detail_d[p_ac].edate_13 = p_edate
      WHEN 14
         LET g_detail_d[p_ac].xmid015_14 = p_xmid015 
         LET g_detail_d[p_ac].bdate_14 = p_bdate
         LET g_detail_d[p_ac].edate_14 = p_edate
      WHEN 15
         LET g_detail_d[p_ac].xmid015_15 = p_xmid015 
         LET g_detail_d[p_ac].bdate_15 = p_bdate
         LET g_detail_d[p_ac].edate_15 = p_edate
      WHEN 16
         LET g_detail_d[p_ac].xmid015_16 = p_xmid015 
         LET g_detail_d[p_ac].bdate_16 = p_bdate
         LET g_detail_d[p_ac].edate_16 = p_edate
      WHEN 17
         LET g_detail_d[p_ac].xmid015_17 = p_xmid015 
         LET g_detail_d[p_ac].bdate_17 = p_bdate
         LET g_detail_d[p_ac].edate_17 = p_edate
      WHEN 18
         LET g_detail_d[p_ac].xmid015_18 = p_xmid015 
         LET g_detail_d[p_ac].bdate_18 = p_bdate
         LET g_detail_d[p_ac].edate_18 = p_edate
      WHEN 19
         LET g_detail_d[p_ac].xmid015_19 = p_xmid015 
         LET g_detail_d[p_ac].bdate_19 = p_bdate
         LET g_detail_d[p_ac].edate_19 = p_edate
      WHEN 20
         LET g_detail_d[p_ac].xmid015_20 = p_xmid015 
         LET g_detail_d[p_ac].bdate_20 = p_bdate
         LET g_detail_d[p_ac].edate_20 = p_edate
      WHEN 21
         LET g_detail_d[p_ac].xmid015_21 = p_xmid015 
         LET g_detail_d[p_ac].bdate_21 = p_bdate
         LET g_detail_d[p_ac].edate_21 = p_edate
      WHEN 22
         LET g_detail_d[p_ac].xmid015_22 = p_xmid015 
         LET g_detail_d[p_ac].bdate_22 = p_bdate
         LET g_detail_d[p_ac].edate_22 = p_edate
      WHEN 23
         LET g_detail_d[p_ac].xmid015_23 = p_xmid015 
         LET g_detail_d[p_ac].bdate_23 = p_bdate
         LET g_detail_d[p_ac].edate_23 = p_edate
      WHEN 24
         LET g_detail_d[p_ac].xmid015_24 = p_xmid015 
         LET g_detail_d[p_ac].bdate_24 = p_bdate
         LET g_detail_d[p_ac].edate_24 = p_edate
   END CASE

   IF cl_null(g_detail_d[p_ac].xmid015_s) THEN
      LET g_detail_d[p_ac].xmid015_s = 0
   END IF 
   
   LET g_detail_d[p_ac].xmid015_s = g_detail_d[p_ac].xmid015_s + p_xmid015
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_show_hint()
# Date & Author..: 2015/06/05 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_show_hint()
   DEFINE l_str          STRING

   CALL s_hint_show_set_comments('b_xmid015_01','')
   CALL s_hint_show_set_comments('b_xmid015_02','')
   CALL s_hint_show_set_comments('b_xmid015_03','')
   CALL s_hint_show_set_comments('b_xmid015_04','')
   CALL s_hint_show_set_comments('b_xmid015_05','')
   CALL s_hint_show_set_comments('b_xmid015_06','')
   CALL s_hint_show_set_comments('b_xmid015_07','')
   CALL s_hint_show_set_comments('b_xmid015_08','')
   CALL s_hint_show_set_comments('b_xmid015_09','')
   CALL s_hint_show_set_comments('b_xmid015_10','')
   CALL s_hint_show_set_comments('b_xmid015_11','')
   CALL s_hint_show_set_comments('b_xmid015_12','')
   CALL s_hint_show_set_comments('b_xmid015_13','')
   CALL s_hint_show_set_comments('b_xmid015_14','')
   CALL s_hint_show_set_comments('b_xmid015_15','')
   CALL s_hint_show_set_comments('b_xmid015_16','')
   CALL s_hint_show_set_comments('b_xmid015_17','')
   CALL s_hint_show_set_comments('b_xmid015_18','')
   CALL s_hint_show_set_comments('b_xmid015_19','')
   CALL s_hint_show_set_comments('b_xmid015_20','')
   CALL s_hint_show_set_comments('b_xmid015_21','')
   CALL s_hint_show_set_comments('b_xmid015_22','')
   CALL s_hint_show_set_comments('b_xmid015_23','')
   CALL s_hint_show_set_comments('b_xmid015_24','')

   IF NOT cl_null(g_detail_d[l_ac].xmid015_01) THEN
      LET l_str = g_detail_d[l_ac].bdate_01,'~',g_detail_d[l_ac].edate_01
      CALL s_hint_show_set_comments('b_xmid015_01',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_02) THEN
      LET l_str = g_detail_d[l_ac].bdate_02,'~',g_detail_d[l_ac].edate_02
      CALL s_hint_show_set_comments('b_xmid015_02',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_03) THEN
      LET l_str = g_detail_d[l_ac].bdate_03,'~',g_detail_d[l_ac].edate_03
      CALL s_hint_show_set_comments('b_xmid015_03',l_str)
   END IF 
   
   IF NOT cl_null(g_detail_d[l_ac].xmid015_04) THEN
      LET l_str = g_detail_d[l_ac].bdate_04,'~',g_detail_d[l_ac].edate_04
      CALL s_hint_show_set_comments('b_xmid015_04',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_05) THEN
      LET l_str = g_detail_d[l_ac].bdate_05,'~',g_detail_d[l_ac].edate_05
      CALL s_hint_show_set_comments('b_xmid015_05',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_06) THEN
      LET l_str = g_detail_d[l_ac].bdate_06,'~',g_detail_d[l_ac].edate_06
      CALL s_hint_show_set_comments('b_xmid015_06',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_07) THEN
      LET l_str = g_detail_d[l_ac].bdate_07,'~',g_detail_d[l_ac].edate_07
      CALL s_hint_show_set_comments('b_xmid015_07',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_08) THEN
      LET l_str = g_detail_d[l_ac].bdate_08,'~',g_detail_d[l_ac].edate_08
      CALL s_hint_show_set_comments('b_xmid015_08',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_09) THEN
      LET l_str = g_detail_d[l_ac].bdate_09,'~',g_detail_d[l_ac].edate_09
      CALL s_hint_show_set_comments('b_xmid015_09',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_10) THEN
      LET l_str = g_detail_d[l_ac].bdate_10,'~',g_detail_d[l_ac].edate_10
      CALL s_hint_show_set_comments('b_xmid015_10',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_11) THEN
      LET l_str = g_detail_d[l_ac].bdate_11,'~',g_detail_d[l_ac].edate_11
      CALL s_hint_show_set_comments('b_xmid015_11',l_str)
   END IF 
   
   IF NOT cl_null(g_detail_d[l_ac].xmid015_12) THEN
      LET l_str = g_detail_d[l_ac].bdate_12,'~',g_detail_d[l_ac].edate_12
      CALL s_hint_show_set_comments('b_xmid015_12',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_13) THEN
      LET l_str = g_detail_d[l_ac].bdate_13,'~',g_detail_d[l_ac].edate_13
      CALL s_hint_show_set_comments('b_xmid015_13',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_14) THEN
      LET l_str = g_detail_d[l_ac].bdate_14,'~',g_detail_d[l_ac].edate_14
      CALL s_hint_show_set_comments('b_xmid015_14',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_15) THEN
      LET l_str = g_detail_d[l_ac].bdate_15,'~',g_detail_d[l_ac].edate_15
      CALL s_hint_show_set_comments('b_xmid015_15',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_16) THEN
      LET l_str = g_detail_d[l_ac].bdate_16,'~',g_detail_d[l_ac].edate_16
      CALL s_hint_show_set_comments('b_xmid015_16',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_17) THEN
      LET l_str = g_detail_d[l_ac].bdate_17,'~',g_detail_d[l_ac].edate_17
      CALL s_hint_show_set_comments('b_xmid015_17',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_18) THEN
      LET l_str = g_detail_d[l_ac].bdate_18,'~',g_detail_d[l_ac].edate_18
      CALL s_hint_show_set_comments('b_xmid015_18',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_19) THEN
      LET l_str = g_detail_d[l_ac].bdate_19,'~',g_detail_d[l_ac].edate_19
      CALL s_hint_show_set_comments('b_xmid015_19',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_20) THEN
      LET l_str = g_detail_d[l_ac].bdate_20,'~',g_detail_d[l_ac].edate_20
      CALL s_hint_show_set_comments('b_xmid015_20',l_str)
   END IF 
   
   IF NOT cl_null(g_detail_d[l_ac].xmid015_21) THEN
      LET l_str = g_detail_d[l_ac].bdate_21,'~',g_detail_d[l_ac].edate_21
      CALL s_hint_show_set_comments('b_xmid015_21',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_22) THEN
      LET l_str = g_detail_d[l_ac].bdate_22,'~',g_detail_d[l_ac].edate_22
      CALL s_hint_show_set_comments('b_xmid015_22',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_23) THEN
      LET l_str = g_detail_d[l_ac].bdate_23,'~',g_detail_d[l_ac].edate_23
      CALL s_hint_show_set_comments('b_xmid015_23',l_str)
   END IF

   IF NOT cl_null(g_detail_d[l_ac].xmid015_24) THEN
      LET l_str = g_detail_d[l_ac].bdate_24,'~',g_detail_d[l_ac].edate_24
      CALL s_hint_show_set_comments('b_xmid015_24',l_str)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmp170_create_axmt171()
# Date & Author..: 2015/06/05 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp170_create_axmt171()
   DEFINE l_i         LIKE type_t.num10
   DEFINE l_head      RECORD
                         xmic004     LIKE xmic_t.xmic004,     #預測營運據點 (xmid004)  
                         xmic005     LIKE xmic_t.xmic005,     #預測組織     (xmid005)  
                         xmic006     LIKE xmic_t.xmic006      #業務員       (xmid006)  
                      END RECORD
   DEFINE l_body      RECORD
                         xmid007     LIKE xmid_t.xmid007,     #預料料號 
                         xmid008     LIKE xmid_t.xmid008,     #產品特徵 
                         xmid009     LIKE xmid_t.xmid009,     #客戶 
                         xmid010     LIKE xmid_t.xmid010,     #通路  
                         xmid014     LIKE xmid_t.xmid014      #單位  
                      END RECORD
   DEFINE l_xmic      RECORD
                         xmic001     LIKE xmic_t.xmic001,     #預測編號 
                         xmic002     LIKE xmic_t.xmic002,     #預測起始日 
                         xmic003     LIKE xmic_t.xmic003,     #版本 
                         xmic004     LIKE xmic_t.xmic004,     #預測營運據點 
                         xmic005     LIKE xmic_t.xmic005,     #預測組織 
                         xmic006     LIKE xmic_t.xmic006,     #業務員 
                         xmic007     LIKE xmic_t.xmic007      #幣別 
                      END RECORD
   DEFINE l_xmiccrtdt LIKE xmic_t.xmiccrtdt
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_seq       LIKE type_t.num10
   DEFINE l_qty       LIKE xmid_t.xmid015
   DEFINE l_bdate     LIKE type_t.dat
   DEFINE l_edate     LIKE type_t.dat
   DEFINE l_xmid      RECORD
                         xmident     LIKE xmid_t.xmident,     #企業編號 
                         xmid001     LIKE xmid_t.xmid001,     #預測編號 
                         xmid002     LIKE xmid_t.xmid002,     #預測起始日 
                         xmid003     LIKE xmid_t.xmid003,     #版本 
                         xmid004     LIKE xmid_t.xmid004,     #預測營運據點 
                         xmid005     LIKE xmid_t.xmid005,     #銷售組織 
                         xmid006     LIKE xmid_t.xmid006,     #業務員 
                         xmid007     LIKE xmid_t.xmid007,     #預測料號 
                         xmid008     LIKE xmid_t.xmid008,     #產品特徵 
                         xmid009     LIKE xmid_t.xmid009,     #客戶  
                         xmid010     LIKE xmid_t.xmid010,     #通路 
                         xmid011     LIKE xmid_t.xmid011,     #期別 
                         xmid012     LIKE xmid_t.xmid012,     #起始日期 
                         xmid013     LIKE xmid_t.xmid013,     #截止日期 
                         xmid014     LIKE xmid_t.xmid014,     #單位  
                         xmid015     LIKE xmid_t.xmid015,     #預測數量 
                         xmid016     LIKE xmid_t.xmid016,     #調整量 
                         xmid017     LIKE xmid_t.xmid017,     #總數量  
                         xmid018     LIKE xmid_t.xmid018,     #單價 
                         xmid019     LIKE xmid_t.xmid019,     #金額 
                         xmid020     LIKE xmid_t.xmid020,     #調整金額 
                         xmid021     LIKE xmid_t.xmid021      #總金額 
                      END RECORD
   DEFINE l_xmia008   LIKE xmia_t.xmia008
   DEFINE l_pmab084   LIKE pmab_t.pmab084
   DEFINE l_pmab087   LIKE pmab_t.pmab087
   DEFINE l_pmab103   LIKE pmab_t.pmab103
   DEFINE l_source    LIKE xmdc_t.xmdc040
   DEFINE l_docno     LIKE xmdc_t.xmdcdocno
   DEFINE l_seq1      LIKE xmdc_t.xmdcseq 
   
   #ming 20150626 add ----------------------(S) 
   DEFINE la_param    RECORD
                         prog   STRING,
                         param  DYNAMIC ARRAY OF STRING
                      END RECORD
   DEFINE ls_js       STRING
   DEFINE l_where     STRING
   #ming 20150626 add ----------------------(E) 

   LET l_success = TRUE
   
   #ming 20150626 add ------------------(S) 
   LET l_where = ' '
   #ming 20150626 add ------------------(E) 

   CALL s_transaction_begin()

   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR
      END IF

      INITIALIZE l_head.* TO NULL

      LET l_head.xmic004 = g_detail_d[l_i].xmid004
      LET l_head.xmic005 = g_detail_d[l_i].xmid005
      LET l_head.xmic006 = g_detail_d[l_i].xmid006

      INITIALIZE l_body.* TO NULL

      LET l_body.xmid007 = g_detail_d[l_i].xmid007
      LET l_body.xmid008 = g_detail_d[l_i].xmid008
      LET l_body.xmid009 = g_detail_d[l_i].xmid009
      LET l_body.xmid010 = g_detail_d[l_i].xmid010
      LET l_body.xmid014 = g_detail_d[l_i].xmid014

      #產生單頭 
      INITIALIZE l_xmic.* TO NULL

      LET l_xmic.xmic001 = g_master.xmic001
      LET l_xmic.xmic002 = g_master.xmic002 
      
      LET l_xmic.xmic004 = l_head.xmic004
      LET l_xmic.xmic005 = l_head.xmic005
      LET l_xmic.xmic006 = l_head.xmic006

      #計算版本 
      SELECT MAX(xmic003) + 1 INTO l_xmic.xmic003
        FROM xmic_t
       WHERE xmicent = g_enterprise
         AND xmic001 = l_xmic.xmic001
         AND xmic002 = l_xmic.xmic002
         AND xmic004 = l_xmic.xmic004
         AND xmic005 = l_xmic.xmic005
         AND xmic006 = l_xmic.xmic006

      IF cl_null(l_xmic.xmic003) THEN
         LET l_xmic.xmic003 = 1
      END IF 
      
      #ming 20150626 add ------------------(S) 
      IF cl_null(l_where) THEN
         LET l_where = "    (xmic003 = '",l_xmic.xmic003,"' ",
                       " AND xmic004 = '",l_xmic.xmic004,"' ",
                       " AND xmic005 = '",l_xmic.xmic005,"' ",
                       " AND xmic006 = '",l_xmic.xmic006,"') "

      ELSE
         LET l_where = l_where," OR ",
                       "    (xmic003 = '",l_xmic.xmic003,"' ",
                       " AND xmic004 = '",l_xmic.xmic004,"' ",
                       " AND xmic005 = '",l_xmic.xmic005,"' ",
                       " AND xmic006 = '",l_xmic.xmic006,"') "
      END IF
      #ming 20150626 add ------------------(E) 

      #幣別是由axmi170而來 
      SELECT xmia004 INTO l_xmic.xmic007
        FROM xmia_t
       WHERE xmiaent = g_enterprise
         AND xmia001 = l_xmic.xmic001

      LET l_xmiccrtdt = cl_get_current()
      INSERT INTO xmic_t (xmicent,xmic001,xmic002,xmic003,xmic004,
                          xmic005,xmic006,xmic007,xmicstus,xmicownid,
                          xmicowndp,xmiccrtid,xmiccrtdp,xmiccrtdt,
                          xmicmodid,xmicmoddt,xmiccnfid,xmiccnfdt)
               VALUES (g_enterprise,l_xmic.xmic001,l_xmic.xmic002,
                       l_xmic.xmic003,l_xmic.xmic004,l_xmic.xmic005,
                       l_xmic.xmic006,l_xmic.xmic007,'N',g_user,g_dept,
                       g_user,g_dept,l_xmiccrtdt,g_user,l_xmiccrtdt,'','')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins xmic'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET l_success = FALSE
         EXIT FOR
      END IF

      #準備寫入單身  
      LET l_sql = "SELECT seq,qty,bdate,edate ",
                  "  FROM axmp170_tmp08 ",           #160727-00019#23 Mod  axmp170_fore_data--> axmp170_tmp08
                  " WHERE ent = '",g_enterprise,"' ",
                  "   AND xmic004 = '",l_head.xmic004,"' ",
                  "   AND xmic005 = '",l_head.xmic005,"' ",
                  "   AND xmid009 = '",l_body.xmid009,"' ",
                  "   AND xmid010 = '",l_body.xmid010,"' ",
                  "   AND xmic006 = '",l_head.xmic006,"' ",
                  "   AND imaa001 = '",l_body.xmid007,"' ",
                  "   AND xmid008 = '",l_body.xmid008,"' ",
                  "   AND xmid014 = '",l_body.xmid014,"' ",
                  " ORDER BY seq "
      PREPARE axmp170_get_fore_data_prep FROM l_sql
      DECLARE axmp170_get_fore_data_curs CURSOR FOR axmp170_get_fore_data_prep

      FOREACH axmp170_get_fore_data_curs INTO l_seq,l_qty,l_bdate,l_edate
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET l_success = FALSE
            EXIT FOREACH
         END IF

         INITIALIZE l_xmid.* TO NULL

         LET l_xmid.xmident = g_enterprise
         LET l_xmid.xmid001 = l_xmic.xmic001
         LET l_xmid.xmid002 = l_xmic.xmic002
         LET l_xmid.xmid003 = l_xmic.xmic003
         LET l_xmid.xmid004 = l_xmic.xmic004
         LET l_xmid.xmid005 = l_xmic.xmic005
         LET l_xmid.xmid006 = l_xmic.xmic006
         LET l_xmid.xmid007 = l_body.xmid007
         LET l_xmid.xmid008 = l_body.xmid008
         LET l_xmid.xmid009 = l_body.xmid009
         LET l_xmid.xmid010 = l_body.xmid010
         LET l_xmid.xmid011 = l_seq
         LET l_xmid.xmid012 = l_bdate
         LET l_xmid.xmid013 = l_edate
         LET l_xmid.xmid014 = l_body.xmid014
         LET l_xmid.xmid015 = l_qty 
         #調整量預設0 
         LET l_xmid.xmid016 = 0
         LET l_xmid.xmid017 = l_xmid.xmid015 + l_xmid.xmid016

         #單價依axmi170所設定的取價方式自動取價 
         SELECT xmia008 INTO l_xmia008
           FROM xmia_t
          WHERE xmiaent = g_enterprise
            AND xmia001 = l_xmic.xmic001

         #由客戶資料中取得稅別等資料 
         SELECT pmab084,pmab087,pmab103
           INTO l_pmab084,l_pmab087,l_pmab103
           FROM pmab_t
          WHERE pmabent = g_enterprise
            AND pmabsite = g_site
            AND pmab001 = l_xmid.xmid009

         IF NOT cl_null(l_xmia008) AND NOT cl_null(l_pmab084) AND
            NOT cl_null(l_pmab087) AND NOT cl_null(l_pmab103) AND 
            NOT cl_null(l_xmid.xmid010) THEN
            CALL s_sale_price_get(l_xmia008,l_xmid.xmid009,l_xmid.xmid007,l_xmid.xmid008,
                                  l_xmic.xmic007,l_pmab084,l_pmab087,l_pmab103,l_xmid.xmid010,
                                  '',l_xmid.xmid012,l_xmid.xmid014,l_xmid.xmid015,g_site,'1','1')
                 RETURNING l_source,l_xmid.xmid018,l_docno,l_seq1
         END IF

         IF cl_null(l_xmid.xmid018) THEN
            LET l_xmid.xmid018 = 0
         END IF

         #單價*數量 
         LET l_xmid.xmid019 = l_xmid.xmid017 * l_xmid.xmid018
         #調整金額預設0  
         LET l_xmid.xmid020 = 0
         LET l_xmid.xmid021 = l_xmid.xmid019 + l_xmid.xmid020

         INSERT INTO xmid_t(xmident,xmid001,xmid002,xmid003,xmid004,xmid005, 
                            xmid006,xmid007,xmid008,xmid009,xmid010,xmid011, 
                            xmid012,xmid013,xmid014,xmid015,xmid016,xmid017, 
                            xmid018,xmid019,xmid020,xmid021)
                     #161109-00085#11-s mod
#                     VALUES(l_xmid.*)   #161109-00085#11-s mark
                     VALUES(l_xmid.xmident,l_xmid.xmid001,l_xmid.xmid002,l_xmid.xmid003,l_xmid.xmid004,
                            l_xmid.xmid005,l_xmid.xmid006,l_xmid.xmid007,l_xmid.xmid008,l_xmid.xmid009,
                            l_xmid.xmid010,l_xmid.xmid011,l_xmid.xmid012,l_xmid.xmid013,l_xmid.xmid014,
                            l_xmid.xmid015,l_xmid.xmid016,l_xmid.xmid017,l_xmid.xmid018,l_xmid.xmid019,
                            l_xmid.xmid020,l_xmid.xmid021)
                     #161109-00085#11-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins xmid'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            LET l_success = FALSE 
            EXIT FOREACH
         END IF

      END FOREACH

      IF NOT l_success THEN
         EXIT FOR
      END IF

   END FOR

   IF l_success THEN
      CALL s_transaction_end('Y','0') 
      
      #ming 20150626 add -----------------------------(S) 
      #資料產生成功，是否開啟銷售預測維護作業？ 
      IF cl_ask_confirm('axm-00696') THEN
         LET la_param.prog = 'axmt171'
         LET la_param.param[1] = g_master.xmic001
         LET la_param.param[2] = g_master.xmic002
         LET la_param.param[3] = ' '
         LET la_param.param[4] = ' '
         LET la_param.param[5] = ' '
         LET la_param.param[6] = ' '
         LET la_param.param[7] = l_where
         LET ls_js = util.JSON.stringify( la_param )

         CALL cl_cmdrun(ls_js)
      END IF
      #ming 20150626 add -----------------------------(E) 
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
END FUNCTION

#end add-point
 
{</section>}
 
