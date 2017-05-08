#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp810.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-05-25 11:13:03), PR版次:0007(2016-12-01 08:57:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: apsp810
#+ Description: 集團MRP產生請購單作業
#+ Creator....: 03079(2014-12-05 10:48:45)
#+ Modifier...: 03079 -SD/PR- 08993
 
{</section>}
 
{<section id="apsp810.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#51 2016/04/27 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息 
#160512-00016#11 2016/05/25 by ming     增加欄位 psgb029 保稅否 
#160727-00019#15 2016/08/03 By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                       Mod   apsp810_psgb_tmp -->apsp810_tmp01
#160824-00034#1  2016/10/14 By dorislai 拿掉#160512-00016#11加的欄位(psgb029)
#161109-00085#17 2016/11/15 By 08993    整批調整系統星號寫法
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
                        sel               LIKE type_t.chr1,         #選擇 
                        psgb002           LIKE psgb_t.psgb002,      #料件編號 
                        psgb002_desc      LIKE imaal_t.imaal003,    #品名 
                        psgb002_desc_desc LIKE imaal_t.imaal004,    #規格 
                        psgb003           LIKE psgb_t.psgb003,      #產品特徵 
                        psgb003_desc      LIKE type_t.chr500,       #產品特徵說明 
                        #160824-00034#1-s-mark
                        ##160512-00016#11 20160525 add by ming -----(S) 
                        #psgb029           LIKE psgb_t.psgb029,      #保稅否 
                        ##160512-00016#11 20160525 add by ming -----(E) 
                        #160824-00034#1-e-mark
                        imaa009           LIKE imaa_t.imaa009,      #產品分類 
                        imaa009_desc      LIKE type_t.chr500,       #說明 
                        imaf141           LIKE imaf_t.imaf141,      #採購分類  
                        imaf141_desc      LIKE type_t.chr500,       #說明 
                        psgb021           LIKE psgb_t.psgb021,      #建議採購量 
                        imaa006           LIKE imaa_t.imaa006,      #單位 
                        imaa006_desc      LIKE type_t.chr500,       #單位說明 
                        pmdb006           LIKE pmdb_t.pmdb006,      #轉請購量 
                        psgb004           LIKE psgb_t.psgb004,      #需求日期 
                        imaf142           LIKE imaf_t.imaf142,      #採購員 
                        imaf142_desc      LIKE type_t.chr500,       #全名  
                        imae012           LIKE imae_t.imae012,      #計畫員  
                        imae012_desc      LIKE type_t.chr500,       #全名 
                        psgb027           LIKE psgb_t.psgb027       #已轉請購單 
                     END RECORD
DEFINE g_detail_d_t  type_g_detail_d 

DEFINE tm            RECORD
                        wc               STRING,                   #QBE   
                        psfa001          LIKE psfa_t.psfa001,      #集團MRP版本  
                        psfa001_desc     LIKE psfal_t.psfal003,
                        psfb003          LIKE psfb_t.psfb003,      #營運據點  
                        psfb003_desc     LIKE type_t.chr500,
                        ooba002          LIKE ooba_t.ooba002,      #請購單別   
                        check01          LIKE type_t.chr1,         #計畫員  
                        check02          LIKE type_t.chr1,         #採購員  
                        check03          LIKE type_t.chr1,         #產品分類  
                        check04          LIKE type_t.chr1,         #採購分類  
                        check05          LIKE type_t.chr1          #顯示已轉單資料  
                     END RECORD 
DEFINE tm_t          RECORD
                        psfa001          LIKE psfa_t.psfa001,      #集團MRP版本  
                        psfa001_desc     LIKE psfal_t.psfal003,
                        psfb003          LIKE psfb_t.psfb003,      #營運據點  
                        psfb003_desc     LIKE type_t.chr500,
                        ooba002          LIKE ooba_t.ooba002,      #請購單別   
                        check01          LIKE type_t.chr1,         #計畫員  
                        check02          LIKE type_t.chr1,         #採購員  
                        check03          LIKE type_t.chr1,         #產品分類  
                        check04          LIKE type_t.chr1,         #採購分類  
                        check05          LIKE type_t.chr1          #顯示已轉單資料  
                     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_detail_idx         LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apsp810.main" >}
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
   CALL apsp810_create_temp_table()
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp810 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsp810_init()   
 
      #進入選單 Menu (="N")
      CALL apsp810_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp810
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL apsp810_drop_temp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp810.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsp810_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET tm.check01 = 'N'     #計畫員  
   LET tm.check02 = 'N'     #採購員  
   LET tm.check03 = 'N'     #產品分類  
   LET tm.check04 = 'N'     #採購分類  
   LET tm.check05 = 'N'     #顯示已轉單資料  
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp810.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp810_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_ooef004     LIKE ooef_t.ooef004
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   DEFINE l_imae012     LIKE imae_t.imae012
   DEFINE l_imaf141     LIKE imaf_t.imaf141
   DEFINE l_imaf142     LIKE imaf_t.imaf142
   DEFINE l_imaa009     LIKE imaa_t.imaa009 
   DEFINE l_site        LIKE type_t.chr10
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
         CALL apsp810_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME tm.wc ON imae012,imaf142,psgb004,
                                    imaa009,imaf141,psgb002
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD imae012     #計畫員  
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO imae012
               NEXT FIELD imae012

            ON ACTION controlp INFIELD imaf142     #採購員 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO imaf142
               NEXT FIELD imaf142

            ON ACTION controlp INFIELD imaa009     #產品分類 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009

            ON ACTION controlp INFIELD imaf141     #採購分類 
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imce141()
               DISPLAY g_qryparam.return1 TO imaf141
               NEXT FIELD imaf141

            ON ACTION controlp INFIELD psgb002     #料件編號 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO psgb002
               NEXT FIELD psgb002

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.psfa001,tm.psfb003 ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT

            AFTER FIELD psfa001
               LET tm.psfa001_desc = ''
               DISPLAY BY NAME tm.psfa001_desc 
               
               IF cl_null(tm.psfa001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'aps-00129'     #請先輸入集團MRP版本！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(tm.psfa001) THEN
                  IF tm.psfa001 != tm_t.psfa001 OR cl_null(tm_t.psfa001) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = tm.psfa001
                     LET g_errshow = TRUE   #160318-00025#51
                     LET g_chkparam.err_str[1] = "aps-00092:sub-01302|apsi800|",cl_get_progname("apsi800",g_lang,"2"),"|:EXEPROGapsi800"    #160318-00025#51
                     IF NOT cl_chk_exist("v_psfa001") THEN
                        LET tm.psfa001 = tm_t.psfa001
                        CALL apsp810_psfa001_ref(tm.psfa001) RETURNING tm.psfa001_desc
                        DISPLAY BY NAME tm.psfa001_desc
                        NEXT FIELD CURRENT
                     END IF

                     LET tm.psfb003 = ''
                     LET tm.ooba002 = ''
                     LET tm_t.psfb003 = ''
                     LET tm_t.ooba002 = ''
                     LET tm.psfb003_desc = ''
                     DISPLAY BY NAME tm.psfb003,tm.ooba002,tm.psfb003_desc
                  END IF
               END IF
               
               LET tm_t.psfa001 = tm.psfa001
               
               CALL apsp810_psfa001_ref(tm.psfa001) RETURNING tm.psfa001_desc
               DISPLAY BY NAME tm.psfa001_desc

            AFTER FIELD psfb003
               LET tm.psfb003_desc = ''
               DISPLAY BY NAME tm.psfb003_desc 
               IF NOT cl_null(tm.psfb003) THEN
                  IF tm.psfb003 != tm_t.psfb003 OR cl_null(tm_t.psfb003) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = tm.psfa001     #集團MRP版本 
                     LET g_chkparam.arg2 = tm.psfb003     #營運據點 
                     IF NOT cl_chk_exist("v_psfb003") THEN
                        LET tm.psfb003 = tm_t.psfb003
                        CALL apsp810_psfb003_ref(tm.psfb003) RETURNING tm.psfb003_desc
                        DISPLAY BY NAME tm.psfb003_desc
                        NEXT FIELD CURRENT
                     END IF

                     LET tm.ooba002 = ''
                     DISPLAY BY NAME tm.ooba002
                  END IF
               END IF
               
               LET tm_t.psfb003 = tm.psfb003

               CALL apsp810_psfb003_ref(tm.psfb003) RETURNING tm.psfb003_desc
               DISPLAY BY NAME tm.psfb003_desc

            ON ACTION controlp INFIELD psfa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.psfa001
               CALL q_psfa001()
               LET tm.psfa001 = g_qryparam.return1
               DISPLAY BY NAME tm.psfa001
               CALL apsp810_psfa001_ref(tm.psfa001) RETURNING tm.psfa001_desc
               DISPLAY BY NAME tm.psfa001_desc 
               NEXT FIELD psfa001

            ON ACTION controlp INFIELD psfb003
               IF cl_null(tm.psfa001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'aps-00129'     #請先輸入集團MRP版本！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD psfa001
               END IF
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.psfb003
               LET g_qryparam.arg1 = tm.psfa001
               CALL q_psfb003()
               LET tm.psfb003 = g_qryparam.return1
               DISPLAY BY NAME tm.psfb003
               CALL apsp810_psfb003_ref(tm.psfb003) RETURNING tm.psfb003_desc
               DISPLAY BY NAME tm.psfb003_desc
               NEXT FIELD psfb003

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT 
         
         INPUT BY NAME tm.ooba002,tm.check01,tm.check02,
                       tm.check03,tm.check04,tm.check05
                       ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD ooba002
               IF NOT cl_null(tm.ooba002) THEN 
                  LET l_site = g_site
                  LET g_site = tm.psfb003
               
                  #檢核輸入的單據別是否可以被key人員對應的控制組使用  
                  CALL s_control_chk_doc('1',tm.ooba002,'3',g_user,g_dept,'','') RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN 
                     LET g_site = l_site
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(tm.psfb003,'',tm.ooba002,'apmt400') THEN 
                     LET g_site = l_site
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_site = l_site
               END IF

            ON ACTION controlp INFIELD ooba002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.ooba002 
               
               LET l_site = g_site
               LET g_site = tm.psfb003
               LET l_ooef004 = ''
               SELECT ooef004 INTO l_ooef004
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_site
               
               LET g_qryparam.arg1 = l_ooef004
               LET g_qryparam.arg2 = 'apmt400'
               CALL q_ooba002_1()
               LET g_site = l_site
               LET tm.ooba002 = g_qryparam.return1
               DISPLAY BY NAME tm.ooba002 
               NEXT FIELD ooba002

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF

         END INPUT

         INPUT ARRAY g_detail_d FROM s_detail1.*
               ATTRIBUTE(COUNT=g_detail_cnt,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS,
                         INSERT ROW = FALSE,
                         DELETE ROW = FALSE,
                         APPEND ROW = FALSE)
            BEFORE INPUT
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1") 
               
               CALL apsp810_set_entry_b('',g_detail_idx)
               CALL apsp810_set_no_entry_b('',g_detail_idx)

            ON CHANGE b_sel 
               IF g_detail_d[g_detail_idx].sel = 'Y' AND g_detail_d[g_detail_idx].psgb027 = 'Y' THEN
                  CALL cl_ask_pressanykey('aps-00109')
                  LET g_detail_d[g_detail_idx].sel = 'N'
               END IF 
               
            AFTER FIELD pmdb006
               IF NOT cl_null(g_detail_d[g_detail_idx].pmdb006) THEN
                  IF g_detail_d[g_detail_idx].pmdb006 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ade-00016'     #數量不可小於等於0   
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF

                  #ming 20141223 mark ----------------------------------------------------(S) 
                  #不做建議採購量的控卡 
                  #IF g_detail_d[g_detail_idx].pmdb006 > g_detail_d[g_detail_idx].psgb021 THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.code   = 'aps-00131'     #數量不可大於建議採購量！  
                  #   LET g_errparam.popup  = TRUE
                  #   CALL cl_err()
                  #
                  #   NEXT FIELD CURRENT
                  #END IF
                  #ming 20141223 mark ----------------------------------------------------(E)
               END IF

            AFTER ROW

            AFTER INPUT
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
               IF g_detail_d[li_idx].psgb027 = 'Y' THEN
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                  IF g_detail_d[li_idx].psgb027 = 'Y' THEN
                     LET g_detail_d[li_idx].sel = 'N'
                  END IF
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
            CALL apsp810_filter()
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
            IF cl_null(tm.psfa001) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'aps-00129'    #請先輸入集團MRP版本！  
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD psfa001
            END IF

            IF cl_null(tm.psfb003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'agl-00291'   #營運據點不可為空！ 
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD psfb003
            END IF
            
            IF cl_null(tm.ooba002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'agl-00122'     #傳入單別為空  
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               NEXT FIELD ooba002
            END IF 
            #end add-point
            CALL apsp810_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            LET g_wc_filter   = " 1=1"
            LET g_wc_filter_t = " 1=1"
            CALL apsp810_b_fill()
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apsp810_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            DELETE FROM apsp810_tmp01;         #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01
            LET l_cnt = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = 'N' THEN
                  CONTINUE FOR
               END IF
               LET l_cnt = l_cnt + 1

               #計畫員 
               LET l_imae012 = ''
               IF tm.check01 = 'Y' THEN
                  LET l_imae012 = g_detail_d[li_idx].imae012
               END IF

               #採購員 
               LET l_imaf142 = ''
               IF tm.check02 = 'Y' THEN
                  LET l_imaf142 = g_detail_d[li_idx].imaf142
               END IF

               #產品分類  
               LET l_imaa009 = ''
               IF tm.check03 = 'Y' THEN
                  LET l_imaa009 = g_detail_d[li_idx].imaa009
               END IF

               #採購分類  
               LET l_imaf141 = ''
               IF tm.check04 = 'Y' THEN
                  LET l_imaf141 = g_detail_d[li_idx].imaf141
               END IF
               
               #160824-00034#1-s-mod
               ##160512-00016#11 20160525 modify by ming -----(S) 
               ##INSERT INTO apsp810_psgb_tmp(psgb002,psgb003,imaa009,imaf141,psgb021,
               ##                             imaa006,pmdb006,psgb004,imaf142,imae012)
               ##     VALUES(g_detail_d[li_idx].psgb002,g_detail_d[li_idx].psgb003,l_imaa009,
               ##            l_imaf141,g_detail_d[li_idx].psgb021,g_detail_d[li_idx].imaa006,
               ##            g_detail_d[li_idx].pmdb006,g_detail_d[li_idx].psgb004,l_imaf142,
               ##            l_imae012)
               #INSERT INTO apsp810_tmp01(psgb002,psgb003,psgb029,imaa009,imaf141,psgb021,       #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01
               #                             imaa006,pmdb006,psgb004,imaf142,imae012)
               #     VALUES(g_detail_d[li_idx].psgb002,g_detail_d[li_idx].psgb003,
               #            g_detail_d[li_idx].psgb029, 
               #            l_imaa009,
               #            l_imaf141,g_detail_d[li_idx].psgb021,g_detail_d[li_idx].imaa006,
               #            g_detail_d[li_idx].pmdb006,g_detail_d[li_idx].psgb004,l_imaf142,
               #            l_imae012)
               ##160512-00016#11 20160525 modify by ming -----(E) 
               INSERT INTO apsp810_tmp01(psgb002,psgb003,imaa009,imaf141,psgb021,       #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01
                                            imaa006,pmdb006,psgb004,imaf142,imae012)
                    VALUES(g_detail_d[li_idx].psgb002,g_detail_d[li_idx].psgb003,
                           l_imaa009,
                           l_imaf141,g_detail_d[li_idx].psgb021,g_detail_d[li_idx].imaa006,
                           g_detail_d[li_idx].pmdb006,g_detail_d[li_idx].psgb004,l_imaf142,
                           l_imae012)
               #160824-00034#1-e-mod
            END FOR
            IF l_cnt = 0 THEN
               CALL cl_ask_pressanykey('-400')
            ELSE
               IF cl_null(tm.ooba002) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agl-00122'     #傳入單別為空  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD ooba002
               END IF 
               
               IF cl_null(tm.psfa001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'aps-00129'    #請先輸入集團MRP版本！  
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD psfa001
               END IF

               IF cl_null(tm.psfb003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'agl-00291'   #營運據點不可為空！ 
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD psfb003
               END IF

               CALL apsp810_batch_execute()
               CALL apsp810_b_fill()
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
 
{<section id="apsp810.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsp810_query()
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
   CALL apsp810_b_fill()
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
 
{<section id="apsp810.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsp810_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1 " END IF
   IF cl_null(g_wc_filter) THEN LET g_wc_filter = " 1=1 " END IF  #151209-00022#8 by whitney add

   LET ls_wc = ''
   IF tm.check05 = 'N' THEN
      LET ls_wc = " (psgb027 = 'N' OR psgb027 IS NULL) "
   ELSE
      LET ls_wc = " 1=1 "
   END IF

   #160512-00016#11 20160525 modify by ming -----(S) 
   #增加欄位 psgb029 , 順便調整一點效能 
   #LET g_sql = "SELECT 'N',psgb002,'','',psgb003,'',imaa009,'',imaf141,'',psgb021,imaa006,'', ",
   #            "       '',psgb004,imaf142,'',imae012,'',psgb027 ", 
   LET g_sql = "SELECT 'N',psgb002,(SELECT imaal003 FROM imaal_t ", 
               "                     WHERE imaalent = '",g_enterprise,"' ", 
               "                       AND imaal001 = psgb002 ", 
               "                       AND imaal002 = '",g_dlang,"' ), ", 
               "                   (SELECT imaal004 FROM imaal_t ", 
               "                     WHERE imaalent = '",g_enterprise,"' ", 
               "                       AND imaal001 = psgb002 ", 
               "                       AND imaal002 = '",g_dlang,"' ), ", 
               #160824-00034#1-s-mod
               #"       psgb003,'',COALESCE(psgb029,'N'), ", 
               "       psgb003,'', ", 
               #160824-00034#1-e-mod
               "       imaa009,(SELECT rtaxl003 FROM rtaxl_t ", 
               "                 WHERE rtaxlent = '",g_enterprise,"' ", 
               "                   AND rtaxl001 = imaa009 ", 
               "                   AND rtaxl002 = '",g_dlang,"' ), ", 
               "       imaf141,(SELECT oocql004 FROM oocql_t ", 
               "                 WHERE oocqlent = '",g_enterprise,"' ", 
               "                   AND oocql001 = '203' ", 
               "                   AND oocql002 = imaf141 ", 
               "                   AND oocql003 = '",g_dlang,"' ), ", 
               "       psgb021,imaa006,(SELECT oocal003 FROM oocal_t ", 
               "                         WHERE oocalent = '",g_enterprise,"' ", 
               "                           AND oocal001 = imaa006 ", 
               "                           AND oocal002 = '",g_dlang,"' ), ",
               "       '',psgb004,imaf142,(SELECT ooag011 FROM ooag_t ", 
               "                            WHERE ooagent = '",g_enterprise,"' ", 
               "                              AND ooag001 = imaf142 ), ", 
               "       imae012,(SELECT ooag011 FROM ooag_t ", 
               "                 WHERE ooagent = '",g_enterprise,"' ", 
               "                   AND ooag001 = imae012 ), ", 
               "       psgb027 ",
   #160512-00016#11 20160525 modify by ming -----(E) 
               "  FROM psgb_t LEFT OUTER JOIN imae_t ON imaeent  = '",g_enterprise,"' ",
               "                                    AND imaesite = '",tm.psfb003,"' ",
               "                                    AND imae001  = psgb002 ",
               "              LEFT OUTER JOIN imaf_t ON imafent  = '",g_enterprise,"' ",
               "                                    AND imafsite = '",tm.psfb003,"' ",
               "                                    AND imaf001  = psgb002 ",
               "              LEFT OUTER JOIN imaa_t ON imaaent  = '",g_enterprise,"' ",
               "                                    AND imaa001  = psgb002 ",
               " WHERE psgbent  = ? ",
               "   AND psgb001  = '",tm.psfa001,"' ",     #MRP版本  
               "   AND psgbsite = '",tm.psfb003,"' ",    #營運據點  
               "   AND psgb021  > 0 ",
               "   AND ",tm.wc CLIPPED,
               "   AND ",ls_wc CLIPPED,
               "   AND ",g_wc_filter CLIPPED,  #151209-00022#8 by whitney add
               " ORDER BY psgb002 "
   #end add-point
 
   PREPARE apsp810_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsp810_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].psgb002,g_detail_d[l_ac].psgb002_desc,g_detail_d[l_ac].psgb002_desc_desc,
      #160512-00016#11 20160525 modify by ming -----(S) 
      #g_detail_d[l_ac].psgb003,g_detail_d[l_ac].psgb003_desc,g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,g_detail_d[l_ac].imaf141,
      g_detail_d[l_ac].psgb003,g_detail_d[l_ac].psgb003_desc, 
      #g_detail_d[l_ac].psgb029, #160824-00034#1-mark
      g_detail_d[l_ac].imaa009,g_detail_d[l_ac].imaa009_desc,g_detail_d[l_ac].imaf141,
      #160512-00016#11 20160525 modify by ming -----(E) 
      g_detail_d[l_ac].imaf141_desc,g_detail_d[l_ac].psgb021,g_detail_d[l_ac].imaa006,g_detail_d[l_ac].imaa006_desc,
      g_detail_d[l_ac].pmdb006,g_detail_d[l_ac].psgb004,g_detail_d[l_ac].imaf142,g_detail_d[l_ac].imaf142_desc,
      g_detail_d[l_ac].imae012,g_detail_d[l_ac].imae012_desc,g_detail_d[l_ac].psgb027
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
      #在這裡的錯誤訊息都不要出現 
      CALL cl_err_collect_init()
      #控制組的檢查       
      CALL s_control_check_item(g_detail_d[l_ac].psgb002,'3',tm.psfb003,g_user,g_dept,tm.ooba002) 
           RETURNING l_success 
      
      IF NOT l_success THEN
         CONTINUE FOREACH
      END IF
      
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
      
      #轉請購量預設為建議採購量 
      LET g_detail_d[l_ac].pmdb006 = g_detail_d[l_ac].psgb021
      #end add-point
      
      CALL apsp810_detail_show()      
 
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
   FREE apsp810_sel
   
   LET l_ac = 1
   CALL apsp810_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp810.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsp810_fetch()
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
 
{<section id="apsp810.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsp810_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   #160512-00016#11 20160525 mark -----(S) 
   #效能調整，所以移到b_fill中的主sql中了 
   ##取品名 規格 
   #CALL s_desc_get_item_desc(g_detail_d[l_ac].psgb002)
   #     RETURNING g_detail_d[l_ac].psgb002_desc,
   #               g_detail_d[l_ac].psgb002_desc_desc
   #
   ##取得產品分類說明 
   #CALL s_desc_get_rtaxl003_desc(g_detail_d[l_ac].imaa009)
   #     RETURNING g_detail_d[l_ac].imaa009_desc 
   #160512-00016#11 20160525 mark -----(E) 
        
   #取得產品特徵說明 
   CALL s_feature_description(g_detail_d[l_ac].psgb002,g_detail_d[l_ac].psgb003)
        RETURNING l_success,g_detail_d[l_ac].psgb003_desc

   #160512-00016#11 20160525 mark by ming -----(S) 
   #效能調整，所以移到b_fill中的主sql中了
   ##取得採購分類說明 
   #CALL s_desc_get_acc_desc('203',g_detail_d[l_ac].imaf141)
   #     RETURNING g_detail_d[l_ac].imaf141_desc
   #
   ##取得單位說明 
   #CALL s_desc_get_unit_desc(g_detail_d[l_ac].imaa006)
   #     RETURNING g_detail_d[l_ac].imaa006_desc
   #
   ##取得採購員姓名 
   #CALL s_desc_get_person_desc(g_detail_d[l_ac].imaf142)
   #     RETURNING g_detail_d[l_ac].imaf142_desc
   #
   ##取得計畫員姓名 
   #CALL s_desc_get_person_desc(g_detail_d[l_ac].imae012)
   #     RETURNING g_detail_d[l_ac].imae012_desc 
   #160512-00016#11 20160525 mark by ming -----(E) 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsp810.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsp810_filter()
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
   
   #160824-00034#1-s-mod
   ##160512-00016#11 20160525 modify by ming -----(S) 
   ##CONSTRUCT g_wc_filter ON psgb002,psgb003,imaa009,imaf141,psgb021,imaa006, 
   #CONSTRUCT g_wc_filter ON psgb002,psgb003,psgb029,imaa009,imaf141,psgb021,imaa006, 
   ##160512-00016#11 20160525 modify by ming -----(E) 
   #                         pmdb006,psgb004,imaf142,imae012,psgb027
   #     #160512-00016#11 20160525 modify by ming -----(S) 
   #     #FROM s_detail1[1].b_psgb002,s_detail1[1].b_psgb003,s_detail1[1].b_imaa009,s_detail1[1].b_imaf141,
   #     FROM s_detail1[1].b_psgb002,s_detail1[1].b_psgb003, 
   #          s_detail1[1].b_psgb029, 
   #          s_detail1[1].b_imaa009,s_detail1[1].b_imaf141,
   #     #160512-00016#11 20160525 modify by ming -----(E) 
   #          s_detail1[1].b_psgb021,s_detail1[1].b_imaa006,s_detail1[1].b_pmdb006,s_detail1[1].b_psgb004,
   #          s_detail1[1].b_imaf142,s_detail1[1].b_imae012,s_detail1[1].b_psgb027
   #CONSTRUCT g_wc_filter ON psgb002,psgb003,imaa009,imaf141,psgb021,imaa006, 
   CONSTRUCT g_wc_filter ON psgb002,psgb003,imaa009,imaf141,psgb021,imaa006, 
                            pmdb006,psgb004,imaf142,imae012,psgb027
        FROM s_detail1[1].b_psgb002,s_detail1[1].b_psgb003, 
             s_detail1[1].b_imaa009,s_detail1[1].b_imaf141,
             s_detail1[1].b_psgb021,s_detail1[1].b_imaa006,s_detail1[1].b_pmdb006,s_detail1[1].b_psgb004,
             s_detail1[1].b_imaf142,s_detail1[1].b_imae012,s_detail1[1].b_psgb027
   #160824-00034#1-e-mod
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_psgb002        #料件編號
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_imaf001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_psgb002  #顯示到畫面上
         NEXT FIELD b_psgb002                     #返回原欄位    
         
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
       
      ON ACTION controlp INFIELD b_imaa006        #單位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooca001_1()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_imaa006  #顯示到畫面上
         NEXT FIELD b_imaa006                     #返回原欄位
       
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
       
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apsp810_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apsp810.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsp810_filter_parser(ps_field)
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
 
{<section id="apsp810.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsp810_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsp810_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsp810.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_psfa001_ref(p_psfal001)
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/12/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_psfa001_ref(p_psfal001)
   DEFINE p_psfal001     LIKE psfal_t.psfal001
   DEFINE r_psfal003     LIKE psfal_t.psfal003

   LET r_psfal003 = ''
   SELECT psfal003 INTO r_psfal003
     FROM psfal_t
    WHERE psfalent = g_enterprise
      AND psfal001 = p_psfal001

   RETURN r_psfal003
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_psfb003_ref(p_psfb003)
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/12/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_psfb003_ref(p_psfb003)
   DEFINE p_psfb003     LIKE psfb_t.psfb003
   DEFINE r_ooefl003    LIKE ooefl_t.ooefl003

   LET r_ooefl003 = ''
   SELECT ooefl003 INTO r_ooefl003
     FROM ooefl_t
    WHERE ooeflent = g_enterprise
      AND ooefl001 = p_psfb003
      AND ooefl002 = g_dlang

   RETURN r_ooefl003
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_create_temp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/12/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_create_temp_table()
   CREATE TEMP TABLE apsp810_tmp01(           #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01
      psgb002         VARCHAR(40),          #料件編號  
      psgb003         VARCHAR(256),          #產品特徵 
      #psgb029        LIKE psgb_t.psgb029,     #保稅否     #160512-00016#11 20160525 add by ming #160824-00034#1-mark
      imaa009         VARCHAR(10),          #產品分類 
      imaf141         VARCHAR(10),          #採購分類 
      psgb021         DECIMAL(20,6),          #建議採購量 
      imaa006         VARCHAR(10),          #單位 
      pmdb006         DECIMAL(20,6),          #轉請購量 
      psgb004         DATE,          #需求日期 
      imaf142         VARCHAR(20),          #採購員  
      imae012         VARCHAR(20)     #計畫員 
   )
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_drop_temp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/12/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_drop_temp_table()
   DROP TABLE apsp810_tmp01;        #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_batch_execute()
# Date & Author..: 2014/12/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_batch_execute()
   DEFINE ls_js             STRING
   DEFINE lc_param          type_parameter
   DEFINE la_param          RECORD
                               prog     STRING,
                               param    DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE l_sql             STRING
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_tot_success     LIKE type_t.num5
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_str             STRING
   DEFINE l_pmdadocno       LIKE pmda_t.pmdadocno     #請購單單號 
   DEFINE l_psgb            RECORD
                               psgb002     LIKE psgb_t.psgb002,
                               psgb003     LIKE psgb_t.psgb003,
                               #160824-00034#1-s-mark
                               ##160512-00016#11 20160525 add by ming -----(S) 
                               #psgb029     LIKE psgb_t.psgb029, 
                               ##160512-00016#11 20160525 add by ming -----(E) 
                               #160824-00034#1-e-mark
                               psgb021     LIKE psgb_t.psgb021,
                               imaa006     LIKE imaa_t.imaa006,
                               pmdb006     LIKE pmdb_t.pmdb006,
                               psgb004     LIKE psgb_t.psgb004
                            END RECORD
   DEFINE l_ima             RECORD
                               imaa009     LIKE imaa_t.imaa009,
                               imaf141     LIKE imaf_t.imaf141,
                               imaf142     LIKE imaf_t.imaf142,
                               imae012     LIKE imae_t.imae012
                            END RECORD 
   DEFINE l_site            LIKE type_t.chr10

   CALL util.JSON.parse(ls_js,lc_param) 
   
   CALL s_transaction_begin()
   LET l_tot_success = TRUE
   LET l_success     = TRUE
   LET l_str         = ''
   CALL cl_err_collect_init()

   IF tm.check01 = 'N' AND tm.check02 = 'N' AND
      tm.check03 = 'N' AND tm.check04 = 'N' THEN
      #全部匯總成一張請購單 
      CALL apsp810_ins_pmda() RETURNING l_pmdadocno,l_tot_success
      IF l_tot_success THEN
         LET l_str = " '",l_pmdadocno,"' "
         INITIALIZE l_psgb.* TO NULL
         #160824-00034#1-s-mod
         ##160512-00016#11 20160525 modify by ming -----(S) 
         ##DECLARE apsp810_psgb_curs CURSOR FOR SELECT psgb002,psgb003,psgb021,
         ##                                            imaa006,pmdb006,psgb004
         ##                                       FROM apsp810_psgb_tmp
         #DECLARE apsp810_psgb_curs CURSOR FOR SELECT psgb002,psgb003,psgb029,psgb021,
         #                                            imaa006,pmdb006,psgb004
         #                                       FROM apsp810_tmp01          #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01                                  
         ##160512-00016#11 20160525 modify by ming -----(E) 
         DECLARE apsp810_psgb_curs CURSOR FOR SELECT psgb002,psgb003,psgb021,
                                                     imaa006,pmdb006,psgb004
                                                FROM apsp810_tmp01          #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01    
         #160824-00034#1-e-mod
         #161109-00085#17-s mod
#         FOREACH apsp810_psgb_curs INTO l_psgb.*   #161109-00085#17-s mark
         FOREACH apsp810_psgb_curs INTO l_psgb.psgb002,l_psgb.psgb003,l_psgb.psgb021,l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004
         #161109-00085#17-e mod
            IF NOT l_success THEN
               LET l_tot_success = FALSE
               LET l_success     = TRUE
            END IF
            #160824-00034#1-s-mod
            ##160512-00016#11 20160525 modify by ming -----(S) 
            ##CALL apsp810_ins_pmdb(l_pmdadocno,l_psgb.psgb002,l_psgb.psgb003,
            ##                      l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004)
            ##     RETURNING l_success
            #CALL apsp810_ins_pmdb(l_pmdadocno,l_psgb.psgb002,l_psgb.psgb003,
            #                      l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004, 
            #                      l_psgb.psgb029)
            #     RETURNING l_success     
            ##160512-00016#11 20160525 modify by ming -----(E) 
            CALL apsp810_ins_pmdb(l_pmdadocno,l_psgb.psgb002,l_psgb.psgb003,
                                  l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004)
                 RETURNING l_success 
            #160824-00034#1-e-mod
            INITIALIZE l_psgb.* TO NULL
         END FOREACH
      END IF
   ELSE
      #依勾選的條件匯總 
      INITIALIZE l_ima.* TO NULL 
      DECLARE apsp810_ima_curs CURSOR FOR SELECT imaa009,imaf141,imaf142,imae012
                                            FROM apsp810_tmp01            #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01
                                           GROUP BY imaa009,imaf141,imaf142,imae012
      #161109-00085#17-s mod
#      FOREACH apsp810_ima_curs INTO l_ima.*   #161109-00085#17-s mark
      FOREACH apsp810_ima_curs INTO l_ima.imaa009,l_ima.imaf141,l_ima.imaf142,l_ima.imae012
      #161109-00085#17-e mod
         IF NOT l_success THEN
            LET l_tot_success = FALSE
            LET l_success     = TRUE
         END IF
         CALL apsp810_ins_pmda() RETURNING l_pmdadocno,l_success
         IF NOT l_success THEN
            INITIALIZE l_ima.* TO NULL
            CONTINUE FOREACH
         END IF

         IF cl_null(l_str) THEN
            LET l_str = " '",l_pmdadocno,"' "
         ELSE
            LET l_str = l_str,","," '",l_pmdadocno,"' "
         END IF
         
         #160824-00034#1-s-mod
         ##160512-00016#11 20160525 modify by ming -----(S) 
         ##LET l_sql = "SELECT psgb002,psgb003,psgb021,imaa006,pmdb006,psgb004 ",
         ##            "  FROM apsp810_psgb_tmp ",
         ##            " WHERE 1=1 " 
         #LET l_sql = "SELECT psgb002,psgb003,psgb029,psgb021,imaa006,pmdb006,psgb004 ",
         #            "  FROM apsp810_tmp01 ",              #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01   
         #            " WHERE 1=1 " 
         ##160512-00016#11 20160525 modify by ming -----(E) 
         LET l_sql = "SELECT psgb002,psgb003,psgb021,imaa006,pmdb006,psgb004 ",
                     "  FROM apsp810_tmp01 ",              #160727-00019#15 Mod   apsp810_psgb_tmp -->apsp810_tmp01   
                     " WHERE 1=1 " 
         #160824-00034#1-e-mod
         IF NOT cl_null(l_ima.imae012) THEN
            LET l_sql = l_sql CLIPPED," AND imae012 = '",l_ima.imae012,"' "
         END IF
         IF NOT cl_null(l_ima.imaf141) THEN
            LET l_sql = l_sql CLIPPED," AND imaf141 = '",l_ima.imaf141,"' "
         END IF 
         IF NOT cl_null(l_ima.imaf142) THEN
            LET l_sql = l_sql CLIPPED," AND imaf142 = '",l_ima.imaf142,"' "
         END IF
         IF NOT cl_null(l_ima.imaa009) THEN
            LET l_sql = l_sql CLIPPED," AND imaa009 = '",l_ima.imaa009,"' "
         END IF
         PREPARE apsp810_psgb_plus_prep FROM l_sql
         DECLARE apsp810_psgb_plus_curs CURSOR FOR apsp810_psgb_plus_prep
         
         #161109-00085#17-s mod
#         FOREACH apsp810_psgb_plus_curs INTO l_psgb.*   #161109-00085#17-s mark
         FOREACH apsp810_psgb_plus_curs INTO l_psgb.psgb002,l_psgb.psgb003,l_psgb.psgb021,l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004
         #161109-00085#17-e mod
            IF NOT l_success THEN
               LET l_tot_success = FALSE
               LET l_success     = TRUE
            END IF
            
            #160824-00034#1-s-mod
            ##160512-00016#11 20160525 modify by ming -----(S) 
            ##CALL apsp810_ins_pmdb(l_pmdadocno,l_psgb.psgb002,l_psgb.psgb003,
            ##                      l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004)
            ##     RETURNING l_success 
            #CALL apsp810_ins_pmdb(l_pmdadocno,l_psgb.psgb002,l_psgb.psgb003,
            #                      l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004, 
            #                      l_psgb.psgb029)
            #     RETURNING l_success      
            ##160512-00016#11 20160525 modify by ming -----(E) 
            CALL apsp810_ins_pmdb(l_pmdadocno,l_psgb.psgb002,l_psgb.psgb003,
                                  l_psgb.imaa006,l_psgb.pmdb006,l_psgb.psgb004)
                 RETURNING l_success  
            #160824-00034#1-e-mod
         END FOREACH

         INITIALIZE l_ima.* TO NULL
      END FOREACH
   END IF

   CALL cl_err_collect_show()

   IF NOT l_success THEN
      LET l_tot_success = FALSE
   END IF 
   
   IF l_tot_success THEN
      CALL s_transaction_end('Y','0')
      IF NOT cl_null(l_str) THEN 
         ##記錄azzi800的預設營運據點編號 
         #SELECT gzxa007 INTO l_site
         #  FROM gzxa_t
         # WHERE gzxaent = g_enterprise
         #   AND gzxa001 = g_account
         #
         ##更換營運據點 
         #UPDATE gzxa_t SET gzxa007 = tm.psfb003
         # WHERE gzxaent = g_enterprise
         #   AND gzxa001 = g_account 
         
         #切換營運據點 
         CALL FGL_SETENV("T100CROSSSITEBYPROG",tm.psfb003)
            
         LET l_str = " pmdadocno IN ( ",l_str," ) "
         LET la_param.prog = 'apmt400'
         LET la_param.param[1] = ''
         LET la_param.param[2] = l_str
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js) 
         ##還原營運據點 
         #UPDATE gzxa_t SET gzxa007 = l_site
         # WHERE gzxaent = g_enterprise
         #   AND gzxa001 = g_account
         
         #還原營運據點          
         CALL FGL_SETENV("T100CROSSSITEBYPROG","")
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
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_ins_pmda()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/12/09 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_ins_pmda()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   #mod--161109-00085#17 By 08993--(s)
#   DEFINE l_pmda         RECORD LIKE pmda_t.*   #mark--161109-00085#17 By 08993--(s)
   DEFINE l_pmda         RECORD  #請購單單頭頭檔
       pmdaent LIKE pmda_t.pmdaent, #企業編號
       pmdaownid LIKE pmda_t.pmdaownid, #資料所有者
       pmdaowndp LIKE pmda_t.pmdaowndp, #資料所屬部門
       pmdacrtid LIKE pmda_t.pmdacrtid, #資料建立者
       pmdacrtdp LIKE pmda_t.pmdacrtdp, #資料建立部門
       pmdacrtdt LIKE pmda_t.pmdacrtdt, #資料創建日
       pmdamodid LIKE pmda_t.pmdamodid, #資料修改者
       pmdamoddt LIKE pmda_t.pmdamoddt, #最近修改日
       pmdacnfid LIKE pmda_t.pmdacnfid, #資料確認者
       pmdacnfdt LIKE pmda_t.pmdacnfdt, #資料確認日
       pmdapstid LIKE pmda_t.pmdapstid, #資料過帳者
       pmdapstdt LIKE pmda_t.pmdapstdt, #資料過帳日
       pmdastus LIKE pmda_t.pmdastus, #狀態碼
       pmdasite LIKE pmda_t.pmdasite, #營運據點
       pmdadocno LIKE pmda_t.pmdadocno, #請購單號
       pmdadocdt LIKE pmda_t.pmdadocdt, #請購日期
       pmda001 LIKE pmda_t.pmda001, #版次
       pmda002 LIKE pmda_t.pmda002, #請購人員
       pmda003 LIKE pmda_t.pmda003, #請購部門
       pmda004 LIKE pmda_t.pmda004, #單價為必要輸入
       pmda005 LIKE pmda_t.pmda005, #幣別
       pmda006 LIKE pmda_t.pmda006, #No Use
       pmda007 LIKE pmda_t.pmda007, #費用部門
       pmda008 LIKE pmda_t.pmda008, #請購總未稅金額
       pmda009 LIKE pmda_t.pmda009, #請購總含稅金額
       pmda010 LIKE pmda_t.pmda010, #稅別
       pmda011 LIKE pmda_t.pmda011, #稅率
       pmda012 LIKE pmda_t.pmda012, #單價含稅否
       pmda020 LIKE pmda_t.pmda020, #納入APS計算
       pmda021 LIKE pmda_t.pmda021, #運送方式
       pmda022 LIKE pmda_t.pmda022, #備註
       pmda200 LIKE pmda_t.pmda200, #來源類型
       pmda201 LIKE pmda_t.pmda201, #採購方式
       pmda202 LIKE pmda_t.pmda202, #所屬品類
       pmda203 LIKE pmda_t.pmda203, #需求組織
       pmda204 LIKE pmda_t.pmda204, #採購中心
       pmda205 LIKE pmda_t.pmda205, #配送中心
       pmda206 LIKE pmda_t.pmda206, #配送倉
       pmda207 LIKE pmda_t.pmda207, #到貨日期
       pmda208 LIKE pmda_t.pmda208, #包裝總數量
       pmda900 LIKE pmda_t.pmda900, #保留欄位str
       pmda999 LIKE pmda_t.pmda999, #保留欄位end
       pmdaud001 LIKE pmda_t.pmdaud001, #自定義欄位(文字)001
       pmdaud002 LIKE pmda_t.pmdaud002, #自定義欄位(文字)002
       pmdaud003 LIKE pmda_t.pmdaud003, #自定義欄位(文字)003
       pmdaud004 LIKE pmda_t.pmdaud004, #自定義欄位(文字)004
       pmdaud005 LIKE pmda_t.pmdaud005, #自定義欄位(文字)005
       pmdaud006 LIKE pmda_t.pmdaud006, #自定義欄位(文字)006
       pmdaud007 LIKE pmda_t.pmdaud007, #自定義欄位(文字)007
       pmdaud008 LIKE pmda_t.pmdaud008, #自定義欄位(文字)008
       pmdaud009 LIKE pmda_t.pmdaud009, #自定義欄位(文字)009
       pmdaud010 LIKE pmda_t.pmdaud010, #自定義欄位(文字)010
       pmdaud011 LIKE pmda_t.pmdaud011, #自定義欄位(數字)011
       pmdaud012 LIKE pmda_t.pmdaud012, #自定義欄位(數字)012
       pmdaud013 LIKE pmda_t.pmdaud013, #自定義欄位(數字)013
       pmdaud014 LIKE pmda_t.pmdaud014, #自定義欄位(數字)014
       pmdaud015 LIKE pmda_t.pmdaud015, #自定義欄位(數字)015
       pmdaud016 LIKE pmda_t.pmdaud016, #自定義欄位(數字)016
       pmdaud017 LIKE pmda_t.pmdaud017, #自定義欄位(數字)017
       pmdaud018 LIKE pmda_t.pmdaud018, #自定義欄位(數字)018
       pmdaud019 LIKE pmda_t.pmdaud019, #自定義欄位(數字)019
       pmdaud020 LIKE pmda_t.pmdaud020, #自定義欄位(數字)020
       pmdaud021 LIKE pmda_t.pmdaud021, #自定義欄位(日期時間)021
       pmdaud022 LIKE pmda_t.pmdaud022, #自定義欄位(日期時間)022
       pmdaud023 LIKE pmda_t.pmdaud023, #自定義欄位(日期時間)023
       pmdaud024 LIKE pmda_t.pmdaud024, #自定義欄位(日期時間)024
       pmdaud025 LIKE pmda_t.pmdaud025, #自定義欄位(日期時間)025
       pmdaud026 LIKE pmda_t.pmdaud026, #自定義欄位(日期時間)026
       pmdaud027 LIKE pmda_t.pmdaud027, #自定義欄位(日期時間)027
       pmdaud028 LIKE pmda_t.pmdaud028, #自定義欄位(日期時間)028
       pmdaud029 LIKE pmda_t.pmdaud029, #自定義欄位(日期時間)029
       pmdaud030 LIKE pmda_t.pmdaud030, #自定義欄位(日期時間)030
       pmda023 LIKE pmda_t.pmda023, #留置原因
       pmda024 LIKE pmda_t.pmda024, #送貨地址
       pmda025 LIKE pmda_t.pmda025, #帳款地址
       pmda209 LIKE pmda_t.pmda209, #包裝總金額
       pmda210 LIKE pmda_t.pmda210, #品種數
       pmda211 LIKE pmda_t.pmda211, #需求時間
       pmda027 LIKE pmda_t.pmda027, #前端單號
       pmda028 LIKE pmda_t.pmda028  #前端類型
               END RECORD
   #mod--161109-00085#17 By 08993--(e)
   DEFINE l_pmda010_desc LIKE type_t.chr500
   DEFINE l_pmda011      LIKE pmda_t.pmda011
   DEFINE l_pmda012      LIKE pmda_t.pmda012
   DEFINE l_oodb011      LIKE oodb_t.oodb011

   LET r_success = TRUE
   INITIALIZE l_pmda.* TO NULL

   #取單號 
   CALL s_aooi200_gen_docno(tm.psfb003,tm.ooba002,g_today,'apmt400')
        RETURNING l_success,l_pmda.pmdadocno

   #取單別預設值  
   #單價為必要輸入 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda004',l_pmda.pmda004)
        RETURNING l_pmda.pmda004

   #幣別 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda005',l_pmda.pmda005)
        RETURNING l_pmda.pmda005

   #預算控管否 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda006',l_pmda.pmda006)
        RETURNING l_pmda.pmda006 
   #如果單別沒有預設值，就給 N 
   IF cl_null(l_pmda.pmda006) THEN
      LET l_pmda.pmda006 = 'N'
   END IF     

   #費用部門  
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda007',l_pmda.pmda007)
        RETURNING l_pmda.pmda007

   #請購總未稅金額 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda008',l_pmda.pmda008)
        RETURNING l_pmda.pmda008

   #請購總含稅金額 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda009',l_pmda.pmda009)
        RETURNING l_pmda.pmda009

   #稅別 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda010',l_pmda.pmda010)
        RETURNING l_pmda.pmda010

   #稅率 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda011',l_pmda.pmda011)
        RETURNING l_pmda.pmda011

   #單價含稅否 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda012',l_pmda.pmda012)
        RETURNING l_pmda.pmda012  
   #如果單別沒有預設值，就給 N
   IF cl_null(l_pmda.pmda012) THEN
      LET l_pmda.pmda012 = 'N'
   END IF

   #納入 MPS/MRP計算 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda020',l_pmda.pmda020)
        RETURNING l_pmda.pmda020

   #運送方式  
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda021',l_pmda.pmda021)
        RETURNING l_pmda.pmda021

   #備註 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda022',l_pmda.pmda022)
        RETURNING l_pmda.pmda022

   #來源類型 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda200',l_pmda.pmda200)
        RETURNING l_pmda.pmda200

   #採購方式 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda201',l_pmda.pmda201)
        RETURNING l_pmda.pmda201

   #所屬品類 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda202',l_pmda.pmda202)
        RETURNING l_pmda.pmda202

   #需求組織 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda203',l_pmda.pmda203)
        RETURNING l_pmda.pmda203

   #採購中心 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda204',l_pmda.pmda204)
        RETURNING l_pmda.pmda204

   #配送中心 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda205',l_pmda.pmda205)
        RETURNING l_pmda.pmda205

   #配送倉 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda206',l_pmda.pmda206)
        RETURNING l_pmda.pmda206

   #到貨日期 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda207',l_pmda.pmda207)
        RETURNING l_pmda.pmda207

   #包裝總數量 
   CALL s_aooi200_get_doc_default(tm.psfb003,'1',tm.ooba002,'pmda208',l_pmda.pmda208)
        RETURNING l_pmda.pmda208

   LET l_pmda.pmdaent   = g_enterprise
   LET l_pmda.pmdasite  = tm.psfb003
   LET l_pmda.pmdadocdt = g_today
   LET l_pmda.pmdacrtdt = cl_get_current()
   LET l_pmda.pmdastus  = 'N'
   LET l_pmda.pmda001   = '0'           #版次  
   LET l_pmda.pmda002   = g_user
   LET l_pmda.pmda003   = g_dept
   IF cl_null(l_pmda.pmda004) THEN
      LET l_pmda.pmda004 = 'N'
   END IF
   IF cl_null(l_pmda.pmda007) THEN
      LET l_pmda.pmda007 = g_dept
   END IF 
   IF NOT cl_null(l_pmda.pmda010) THEN
      CALL s_tax_chk(tm.psfb003,l_pmda.pmda010)
           RETURNING l_success,l_pmda010_desc,l_pmda012,l_pmda011,l_oodb011
      IF cl_null(l_pmda.pmda011) THEN
         LET l_pmda.pmda011 = l_pmda011
      END IF
      IF cl_null(l_pmda.pmda012) THEN
         LET l_pmda.pmda012 = l_pmda012
      END IF
   END IF
   IF cl_null(l_pmda.pmda020) THEN
      LET l_pmda.pmda020 = 'Y'
   END IF
   LET l_pmda.pmdaownid = g_user
   LET l_pmda.pmdaowndp = g_dept
   LET l_pmda.pmdacrtid = g_user
   LET l_pmda.pmdacrtdp = g_dept
   
   #mod--161109-00085#17 By 08993--(s)
#   INSERT INTO pmda_t VALUES l_pmda.*   #mark--161109-00085#17 By 08993--(s)
   INSERT INTO pmda_t (pmdaent,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt,pmdamodid,pmdamoddt,pmdacnfid,pmdacnfdt,
                       pmdapstid,pmdapstdt,pmdastus,pmdasite,pmdadocno,pmdadocdt,pmda001,pmda002,pmda003,pmda004,
                       pmda005,pmda006,pmda007,pmda008,pmda009,pmda010,pmda011,pmda012,pmda020,pmda021,
                       pmda022,pmda200,pmda201,pmda202,pmda203,pmda204,pmda205,pmda206,pmda207,pmda208,
                       pmda900,pmda999,pmdaud001,pmdaud002,pmdaud003,pmdaud004,pmdaud005,pmdaud006,pmdaud007,pmdaud008,
                       pmdaud009,pmdaud010,pmdaud011,pmdaud012,pmdaud013,pmdaud014,pmdaud015,pmdaud016,pmdaud017,pmdaud018,
                       pmdaud019,pmdaud020,pmdaud021,pmdaud022,pmdaud023,pmdaud024,pmdaud025,pmdaud026,pmdaud027,pmdaud028,
                       pmdaud029,pmdaud030,pmda023,pmda024,pmda025,pmda209,pmda210,pmda211,pmda027,pmda028) 
               VALUES (l_pmda.pmdaent,l_pmda.pmdaownid,l_pmda.pmdaowndp,l_pmda.pmdacrtid,l_pmda.pmdacrtdp,
                       l_pmda.pmdacrtdt,l_pmda.pmdamodid,l_pmda.pmdamoddt,l_pmda.pmdacnfid,l_pmda.pmdacnfdt,
                       l_pmda.pmdapstid,l_pmda.pmdapstdt,l_pmda.pmdastus,l_pmda.pmdasite,l_pmda.pmdadocno,
                       l_pmda.pmdadocdt,l_pmda.pmda001,l_pmda.pmda002,l_pmda.pmda003,l_pmda.pmda004,
                       l_pmda.pmda005,l_pmda.pmda006,l_pmda.pmda007,l_pmda.pmda008,l_pmda.pmda009,
                       l_pmda.pmda010,l_pmda.pmda011,l_pmda.pmda012,l_pmda.pmda020,l_pmda.pmda021,
                       l_pmda.pmda022,l_pmda.pmda200,l_pmda.pmda201,l_pmda.pmda202,l_pmda.pmda203,
                       l_pmda.pmda204,l_pmda.pmda205,l_pmda.pmda206,l_pmda.pmda207,l_pmda.pmda208,
                       l_pmda.pmda900,l_pmda.pmda999,l_pmda.pmdaud001,l_pmda.pmdaud002,l_pmda.pmdaud003,
                       l_pmda.pmdaud004,l_pmda.pmdaud005,l_pmda.pmdaud006,l_pmda.pmdaud007,l_pmda.pmdaud008,
                       l_pmda.pmdaud009,l_pmda.pmdaud010,l_pmda.pmdaud011,l_pmda.pmdaud012,l_pmda.pmdaud013,
                       l_pmda.pmdaud014,l_pmda.pmdaud015,l_pmda.pmdaud016,l_pmda.pmdaud017,l_pmda.pmdaud018,
                       l_pmda.pmdaud019,l_pmda.pmdaud020,l_pmda.pmdaud021,l_pmda.pmdaud022,l_pmda.pmdaud023,
                       l_pmda.pmdaud024,l_pmda.pmdaud025,l_pmda.pmdaud026,l_pmda.pmdaud027,l_pmda.pmdaud028,
                       l_pmda.pmdaud029,l_pmda.pmdaud030,l_pmda.pmda023,l_pmda.pmda024,l_pmda.pmda025,
                       l_pmda.pmda209,l_pmda.pmda210,l_pmda.pmda211,l_pmda.pmda027,l_pmda.pmda028)
   #mod--161109-00085#17 By 08993--(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'ins pmda_t'
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF 
   
   RETURN l_pmda.pmdadocno,r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_ins_pmdb(p_pmdadocno,p_psgb002,p_psgb003,p_imaa006,p_pmdb006,p_psgb004)
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/12/09 By ming
# Modify.........: p_psgb029 by dorislai-mark (#160824-00034#1)
################################################################################
PRIVATE FUNCTION apsp810_ins_pmdb(p_pmdadocno,p_psgb002,p_psgb003,p_imaa006,p_pmdb006,p_psgb004)
   DEFINE p_pmdadocno     LIKE pmda_t.pmdadocno     #請購單號 
   DEFINE p_psgb002       LIKE psgb_t.psgb002       #料件編號 
   DEFINE p_psgb003       LIKE psgb_t.psgb003       #產品特徵 
   DEFINE p_imaa006       LIKE imaa_t.imaa006       #單位 
   DEFINE p_pmdb006       LIKE pmdb_t.pmdb006       #轉請購量 
   DEFINE p_psgb004       LIKE psgb_t.psgb004       #需求日期 
   #160824-00034#1-s-mark
   ##160512-00016#11 20160525 modify by ming -----(S) 
   #DEFINE p_psgb029       LIKE psgb_t.psgb029       #保稅否  
   ##160512-00016#11 20160525 modify by ming -----(E) 
   #160824-00034#1-e-mark
   DEFINE r_success       LIKE type_t.num5
   #mod--161109-00085#17 By 08993--(s)
#   DEFINE l_pmdb          RECORD LIKE pmdb_t.*   #mark--161109-00085#17 By 08993--(s)
   DEFINE l_pmdb          RECORD  #請購單明細檔
       pmdbent LIKE pmdb_t.pmdbent, #企業編號
       pmdbsite LIKE pmdb_t.pmdbsite, #營運據點
       pmdbdocno LIKE pmdb_t.pmdbdocno, #請購單號
       pmdbseq LIKE pmdb_t.pmdbseq, #項次
       pmdb001 LIKE pmdb_t.pmdb001, #來源單號
       pmdb002 LIKE pmdb_t.pmdb002, #來源項次
       pmdb003 LIKE pmdb_t.pmdb003, #來源項序
       pmdb004 LIKE pmdb_t.pmdb004, #料件編號
       pmdb005 LIKE pmdb_t.pmdb005, #產品特徵
       pmdb006 LIKE pmdb_t.pmdb006, #需求數量
       pmdb007 LIKE pmdb_t.pmdb007, #單位
       pmdb008 LIKE pmdb_t.pmdb008, #參考數量
       pmdb009 LIKE pmdb_t.pmdb009, #參考單位
       pmdb010 LIKE pmdb_t.pmdb010, #計價數量
       pmdb011 LIKE pmdb_t.pmdb011, #計價單位
       pmdb012 LIKE pmdb_t.pmdb012, #包裝容器
       pmdb014 LIKE pmdb_t.pmdb014, #供應商選擇
       pmdb015 LIKE pmdb_t.pmdb015, #供應商編號
       pmdb016 LIKE pmdb_t.pmdb016, #付款條件
       pmdb017 LIKE pmdb_t.pmdb017, #交易條件
       pmdb018 LIKE pmdb_t.pmdb018, #稅率
       pmdb019 LIKE pmdb_t.pmdb019, #參考單價
       pmdb020 LIKE pmdb_t.pmdb020, #參考未稅金額
       pmdb021 LIKE pmdb_t.pmdb021, #參考含稅金額
       pmdb030 LIKE pmdb_t.pmdb030, #需求日期
       pmdb031 LIKE pmdb_t.pmdb031, #理由碼
       pmdb032 LIKE pmdb_t.pmdb032, #行狀態
       pmdb033 LIKE pmdb_t.pmdb033, #緊急度
       pmdb034 LIKE pmdb_t.pmdb034, #專案編號
       pmdb035 LIKE pmdb_t.pmdb035, #WBS
       pmdb036 LIKE pmdb_t.pmdb036, #活動編號
       pmdb037 LIKE pmdb_t.pmdb037, #收貨據點
       pmdb038 LIKE pmdb_t.pmdb038, #收貨庫位
       pmdb039 LIKE pmdb_t.pmdb039, #收貨儲位
       pmdb040 LIKE pmdb_t.pmdb040, #no use
       pmdb041 LIKE pmdb_t.pmdb041, #允許部份交貨
       pmdb042 LIKE pmdb_t.pmdb042, #允許提前交貨
       pmdb043 LIKE pmdb_t.pmdb043, #保稅
       pmdb044 LIKE pmdb_t.pmdb044, #納入APS
       pmdb045 LIKE pmdb_t.pmdb045, #交期凍結否
       pmdb046 LIKE pmdb_t.pmdb046, #費用部門
       pmdb048 LIKE pmdb_t.pmdb048, #收貨時段
       pmdb049 LIKE pmdb_t.pmdb049, #已轉採購量
       pmdb050 LIKE pmdb_t.pmdb050, #備註
       pmdb051 LIKE pmdb_t.pmdb051, #結案/留置理由碼
       pmdb200 LIKE pmdb_t.pmdb200, #商品條碼
       pmdb201 LIKE pmdb_t.pmdb201, #包裝單位
       pmdb202 LIKE pmdb_t.pmdb202, #件裝數
       pmdb203 LIKE pmdb_t.pmdb203, #配送中心
       pmdb204 LIKE pmdb_t.pmdb204, #配送倉庫
       pmdb205 LIKE pmdb_t.pmdb205, #採購中心
       pmdb206 LIKE pmdb_t.pmdb206, #採購員
       pmdb207 LIKE pmdb_t.pmdb207, #採購方式
       pmdb208 LIKE pmdb_t.pmdb208, #經營方式
       pmdb209 LIKE pmdb_t.pmdb209, #結算方式
       pmdb210 LIKE pmdb_t.pmdb210, #促銷開始日
       pmdb211 LIKE pmdb_t.pmdb211, #促銷結束日
       pmdb212 LIKE pmdb_t.pmdb212, #要貨件數
       pmdb250 LIKE pmdb_t.pmdb250, #合理庫存
       pmdb251 LIKE pmdb_t.pmdb251, #最高庫存
       pmdb252 LIKE pmdb_t.pmdb252, #現有庫存
       pmdb253 LIKE pmdb_t.pmdb253, #入庫在途量
       pmdb254 LIKE pmdb_t.pmdb254, #前一週銷量
       pmdb255 LIKE pmdb_t.pmdb255, #前二週銷量
       pmdb256 LIKE pmdb_t.pmdb256, #前三週銷量
       pmdb257 LIKE pmdb_t.pmdb257, #前四週銷量
       pmdb258 LIKE pmdb_t.pmdb258, #要貨在途量
       pmdb259 LIKE pmdb_t.pmdb259, #週平均銷量
       pmdb900 LIKE pmdb_t.pmdb900, #保留欄位str
       pmdb999 LIKE pmdb_t.pmdb999, #保留欄位end
       pmdbud001 LIKE pmdb_t.pmdbud001, #自定義欄位(文字)001
       pmdbud002 LIKE pmdb_t.pmdbud002, #自定義欄位(文字)002
       pmdbud003 LIKE pmdb_t.pmdbud003, #自定義欄位(文字)003
       pmdbud004 LIKE pmdb_t.pmdbud004, #自定義欄位(文字)004
       pmdbud005 LIKE pmdb_t.pmdbud005, #自定義欄位(文字)005
       pmdbud006 LIKE pmdb_t.pmdbud006, #自定義欄位(文字)006
       pmdbud007 LIKE pmdb_t.pmdbud007, #自定義欄位(文字)007
       pmdbud008 LIKE pmdb_t.pmdbud008, #自定義欄位(文字)008
       pmdbud009 LIKE pmdb_t.pmdbud009, #自定義欄位(文字)009
       pmdbud010 LIKE pmdb_t.pmdbud010, #自定義欄位(文字)010
       pmdbud011 LIKE pmdb_t.pmdbud011, #自定義欄位(數字)011
       pmdbud012 LIKE pmdb_t.pmdbud012, #自定義欄位(數字)012
       pmdbud013 LIKE pmdb_t.pmdbud013, #自定義欄位(數字)013
       pmdbud014 LIKE pmdb_t.pmdbud014, #自定義欄位(數字)014
       pmdbud015 LIKE pmdb_t.pmdbud015, #自定義欄位(數字)015
       pmdbud016 LIKE pmdb_t.pmdbud016, #自定義欄位(數字)016
       pmdbud017 LIKE pmdb_t.pmdbud017, #自定義欄位(數字)017
       pmdbud018 LIKE pmdb_t.pmdbud018, #自定義欄位(數字)018
       pmdbud019 LIKE pmdb_t.pmdbud019, #自定義欄位(數字)019
       pmdbud020 LIKE pmdb_t.pmdbud020, #自定義欄位(數字)020
       pmdbud021 LIKE pmdb_t.pmdbud021, #自定義欄位(日期時間)021
       pmdbud022 LIKE pmdb_t.pmdbud022, #自定義欄位(日期時間)022
       pmdbud023 LIKE pmdb_t.pmdbud023, #自定義欄位(日期時間)023
       pmdbud024 LIKE pmdb_t.pmdbud024, #自定義欄位(日期時間)024
       pmdbud025 LIKE pmdb_t.pmdbud025, #自定義欄位(日期時間)025
       pmdbud026 LIKE pmdb_t.pmdbud026, #自定義欄位(日期時間)026
       pmdbud027 LIKE pmdb_t.pmdbud027, #自定義欄位(日期時間)027
       pmdbud028 LIKE pmdb_t.pmdbud028, #自定義欄位(日期時間)028
       pmdbud029 LIKE pmdb_t.pmdbud029, #自定義欄位(日期時間)029
       pmdbud030 LIKE pmdb_t.pmdbud030, #自定義欄位(日期時間)030
       pmdb260 LIKE pmdb_t.pmdb260, #收貨部門
       pmdb052 LIKE pmdb_t.pmdb052, #來源分批序
       pmdb227 LIKE pmdb_t.pmdb227, #補貨規格說明
       pmdb053 LIKE pmdb_t.pmdb053, #預算細項
       pmdb213 LIKE pmdb_t.pmdb213, #參考進價
       pmdb054 LIKE pmdb_t.pmdb054, #庫存管理特徵
       pmdb214 LIKE pmdb_t.pmdb214  #需求時間
               END RECORD
   #mod--161109-00085#17 By 08993--(e)
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_time1         LIKE type_t.num5
   DEFINE l_time2         LIKE type_t.num5
   DEFINE l_imaf175       LIKE imaf_t.imaf175

   LET r_success = TRUE
   INITIALIZE l_pmdb.* TO NULL

   LET l_pmdb.pmdbent   = g_enterprise
   LET l_pmdb.pmdbsite  = tm.psfb003 
   LET l_pmdb.pmdbdocno = p_pmdadocno
   LET l_pmdb.pmdb001   = tm.psfa001      #來源單號==>集團MRP版本 
   LET l_pmdb.pmdb004   = p_psgb002       #料件編號 
   LET l_pmdb.pmdb005   = p_psgb003       #產品特徵 
   LET l_pmdb.pmdb006   = p_pmdb006       #需求數量 
   LET l_pmdb.pmdb007   = p_imaa006       #單位 
   LET l_pmdb.pmdb014   = '1'             #供應商選擇 
   LET l_pmdb.pmdb019   = "0"             #參考單價
   LET l_pmdb.pmdb030   = p_psgb004       #需求日期
   LET l_pmdb.pmdb032   = "1"             #行狀態
   LET l_pmdb.pmdb033   = "1"             #緊急度 
   LET l_pmdb.pmdb041   = "Y"             #允許部份交貨
   LET l_pmdb.pmdb042   = "Y"             #允許提前交貨
   ##160512-00016#11 20160525 modify by ming -----(S)  #160824-00034#1-mark
   LET l_pmdb.pmdb043   = "N"             #保稅         #160824-00034#1-remark
   #LET l_pmdb.pmdb043   = p_psgb029       #保稅        #160824-00034#1-s-mark
   #IF cl_null(l_pmdb.pmdb043) THEN 
   #    LET l_pmdb.pmdb043 = 'N' 
   #END IF 
   ##160512-00016#11 20160525 modify by ming -----(E)   #160824-00034#1-e-mark
   LET l_pmdb.pmdb044   = "Y"             #納入MRP
   LET l_pmdb.pmdb045   = "Y"             #交期凍結否
   LET l_pmdb.pmdb049   = 0               #已轉採購量 

   #料件據點進銷存檔設置的參考單位、採購計價單位
   SELECT imaf015,imaf144 INTO l_pmdb.pmdb009,l_pmdb.pmdb011 FROM imaf_t
    WHERE imafent = g_enterprise AND imafsite = g_site
      AND imaf001 = l_pmdb.pmdb004
   #參考數量由交易數量乘上交易單位與參考單位的換算率做預設
   IF NOT cl_null(l_pmdb.pmdb009) THEN
      CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb009,l_pmdb.pmdb006)
           RETURNING l_success,l_pmdb.pmdb008
   END IF
   #計價數量由交易數量乘上交易單位與計價單位的換算率做預設
   IF NOT cl_null(l_pmdb.pmdb011) THEN
      CALL s_aooi250_convert_qty(l_pmdb.pmdb004,l_pmdb.pmdb007,l_pmdb.pmdb011,l_pmdb.pmdb006)
           RETURNING l_success,l_pmdb.pmdb010
   END IF

   IF NOT cl_null(l_pmdb.pmdb030) THEN
      LET l_time1 = l_pmdb.pmdb030 - g_today  #需求日期 - g_today
      LET l_time2 = 0                         #[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數
      SELECT (imaf171+imaf172+imaf173+imaf174),imaf175 INTO l_time2,l_imaf175 FROM imaf_t
        WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdb.pmdb004

      #1.若輸入的需求日期 - g_today >[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數時，則[C:緊急度] = '1'(一般) 
      IF l_time1 >= l_time2 THEN
         LET l_pmdb.pmdb033 = '1'
      END IF

      #2.若輸入的需求日期 - g_today <[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數，
      #   且需求日期 - g_today >[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '2'(緊急)
      IF l_time1 < l_time2 AND l_time1 >= l_imaf175 THEN
         LET l_pmdb.pmdb033 = '2'
      END IF

      #3.若輸入的需求日期 - g_today <[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '3'(特急)
      IF l_time1 < l_imaf175 THEN
         LET l_pmdb.pmdb033 = '3'
      END IF

   END IF

   SELECT MAX(pmdbseq) + 1 INTO l_pmdb.pmdbseq
     FROM pmdb_t
    WHERE pmdbent   = g_enterprise
      AND pmdbsite  = tm.psfb003
      AND pmdbdocno = p_pmdadocno
   IF cl_null(l_pmdb.pmdbseq) OR l_pmdb.pmdbseq = 0 THEN
      LET l_pmdb.pmdbseq = 1
   END IF
   
   #mod--161109-00085#17 By 08993--(s)
#   INSERT INTO pmdb_t VALUES l_pmdb.*   #mark--161109-00085#17 By 08993--(s)
   INSERT INTO pmdb_t(pmdbent,pmdbsite,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb004,pmdb005,pmdb006,
                      pmdb007,pmdb008,pmdb009,pmdb010,pmdb011,pmdb012,pmdb014,pmdb015,pmdb016,pmdb017,
                      pmdb018,pmdb019,pmdb020,pmdb021,pmdb030,pmdb031,pmdb032,pmdb033,pmdb034,pmdb035,
                      pmdb036,pmdb037,pmdb038,pmdb039,pmdb040,pmdb041,pmdb042,pmdb043,pmdb044,pmdb045,
                      pmdb046,pmdb048,pmdb049,pmdb050,pmdb051,pmdb200,pmdb201,pmdb202,pmdb203,pmdb204,
                      pmdb205,pmdb206,pmdb207,pmdb208,pmdb209,pmdb210,pmdb211,pmdb212,pmdb250,pmdb251,
                      pmdb252,pmdb253,pmdb254,pmdb255,pmdb256,pmdb257,pmdb258,pmdb259,pmdb900,pmdb999,
                      pmdbud001,pmdbud002,pmdbud003,pmdbud004,pmdbud005,pmdbud006,pmdbud007,pmdbud008,pmdbud009,pmdbud010,
                      pmdbud011,pmdbud012,pmdbud013,pmdbud014,pmdbud015,pmdbud016,pmdbud017,pmdbud018,pmdbud019,pmdbud020,
                      pmdbud021,pmdbud022,pmdbud023,pmdbud024,pmdbud025,pmdbud026,pmdbud027,pmdbud028,pmdbud029,pmdbud030,
                      pmdb260,pmdb052,pmdb227,pmdb053,pmdb213,pmdb054,pmdb214) 
               VALUES(l_pmdb.pmdbent,l_pmdb.pmdbsite,l_pmdb.pmdbdocno,l_pmdb.pmdbseq,l_pmdb.pmdb001,
                      l_pmdb.pmdb002,l_pmdb.pmdb003,l_pmdb.pmdb004,l_pmdb.pmdb005,l_pmdb.pmdb006,
                      l_pmdb.pmdb007,l_pmdb.pmdb008,l_pmdb.pmdb009,l_pmdb.pmdb010,l_pmdb.pmdb011,
                      l_pmdb.pmdb012,l_pmdb.pmdb014,l_pmdb.pmdb015,l_pmdb.pmdb016,l_pmdb.pmdb017,
                      l_pmdb.pmdb018,l_pmdb.pmdb019,l_pmdb.pmdb020,l_pmdb.pmdb021,l_pmdb.pmdb030,
                      l_pmdb.pmdb031,l_pmdb.pmdb032,l_pmdb.pmdb033,l_pmdb.pmdb034,l_pmdb.pmdb035,
                      l_pmdb.pmdb036,l_pmdb.pmdb037,l_pmdb.pmdb038,l_pmdb.pmdb039,l_pmdb.pmdb040,
                      l_pmdb.pmdb041,l_pmdb.pmdb042,l_pmdb.pmdb043,l_pmdb.pmdb044,l_pmdb.pmdb045,
                      l_pmdb.pmdb046,l_pmdb.pmdb048,l_pmdb.pmdb049,l_pmdb.pmdb050,l_pmdb.pmdb051,
                      l_pmdb.pmdb200,l_pmdb.pmdb201,l_pmdb.pmdb202,l_pmdb.pmdb203,l_pmdb.pmdb204,
                      l_pmdb.pmdb205,l_pmdb.pmdb206,l_pmdb.pmdb207,l_pmdb.pmdb208,l_pmdb.pmdb209,
                      l_pmdb.pmdb210,l_pmdb.pmdb211,l_pmdb.pmdb212,l_pmdb.pmdb250,l_pmdb.pmdb251,
                      l_pmdb.pmdb252,l_pmdb.pmdb253,l_pmdb.pmdb254,l_pmdb.pmdb255,l_pmdb.pmdb256,
                      l_pmdb.pmdb257,l_pmdb.pmdb258,l_pmdb.pmdb259,l_pmdb.pmdb900,l_pmdb.pmdb999,
                      l_pmdb.pmdbud001,l_pmdb.pmdbud002,l_pmdb.pmdbud003,l_pmdb.pmdbud004,l_pmdb.pmdbud005,
                      l_pmdb.pmdbud006,l_pmdb.pmdbud007,l_pmdb.pmdbud008,l_pmdb.pmdbud009,l_pmdb.pmdbud010,
                      l_pmdb.pmdbud011,l_pmdb.pmdbud012,l_pmdb.pmdbud013,l_pmdb.pmdbud014,l_pmdb.pmdbud015,
                      l_pmdb.pmdbud016,l_pmdb.pmdbud017,l_pmdb.pmdbud018,l_pmdb.pmdbud019,l_pmdb.pmdbud020,
                      l_pmdb.pmdbud021,l_pmdb.pmdbud022,l_pmdb.pmdbud023,l_pmdb.pmdbud024,l_pmdb.pmdbud025,
                      l_pmdb.pmdbud026,l_pmdb.pmdbud027,l_pmdb.pmdbud028,l_pmdb.pmdbud029,l_pmdb.pmdbud030,
                      l_pmdb.pmdb260,l_pmdb.pmdb052,l_pmdb.pmdb227,l_pmdb.pmdb053,l_pmdb.pmdb213,
                      l_pmdb.pmdb054,l_pmdb.pmdb214)
   #mod--161109-00085#17 By 08993--(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'ins pmdb_t'
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
   ELSE
      UPDATE psgb_t SET psgb027 = 'Y'
       WHERE psgbent = g_enterprise
         AND psgb001 = tm.psfa001
         AND psgb002 = p_psgb002
         AND psgb003 = p_psgb003
         AND psgb004 = p_psgb004
         AND psgbsite = tm.psfb003 
         #AND psgb029  = p_psgb029     #160512-00016#11 20160525 add by ming   #160824-00034#1-mark
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'upd psgb_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_set_entry_b(p_cmd,p_ac)
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/12/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_set_entry_b(p_cmd,p_ac)
   DEFINE p_cmd     LIKE type_t.chr1
   DEFINE p_ac      LIKE type_t.num5

   CALL cl_set_comp_entry("b_pmdb006",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL apsp810_set_no_entry_b(p_cmd,p_ac)
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/12/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp810_set_no_entry_b(p_cmd,p_ac)
   DEFINE p_cmd     LIKE type_t.chr1
   DEFINE p_ac      LIKE type_t.num5

   IF g_detail_d[p_ac].psgb027 = 'Y' THEN
      CALL cl_set_comp_entry("b_pmdb006",FALSE)
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
