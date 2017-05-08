{<section id="adzi520.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000010
#+ 
#+ Filename...: adzi520
#+ Description: section異動原因維護作業
#+ Creator....: 05292(2015-02-09 09:08:07)
#+ Modifier...: 05292(2015-02-09 09:08:07) -SD/PR- 05292(2015-02-09 11:51:34)
 
{</section>}
 
{<section id="adzi520.global" >}
#應用 i01 樣板自動產生(Version:8)

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_dzse_m RECORD
       dzse001 LIKE dzse_t.dzse001, 
   dzse002 LIKE dzse_t.dzse002, 
   dzseownid LIKE dzse_t.dzseownid, 
   dzseownid_desc LIKE type_t.chr80, 
   dzseowndp LIKE dzse_t.dzseowndp, 
   dzseowndp_desc LIKE type_t.chr80, 
   dzsecrtid LIKE dzse_t.dzsecrtid, 
   dzsecrtid_desc LIKE type_t.chr80, 
   dzsecrtdp LIKE dzse_t.dzsecrtdp, 
   dzsecrtdp_desc LIKE type_t.chr80, 
   dzsecrtdt LIKE dzse_t.dzsecrtdt, 
   dzsemodid LIKE dzse_t.dzsemodid, 
   dzsemodid_desc LIKE type_t.chr80, 
   dzsemoddt LIKE dzse_t.dzsemoddt
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_dzse_m        type_g_dzse_m  #單頭變數宣告
DEFINE g_dzse_m_t      type_g_dzse_m  #單頭舊值宣告(系統還原用)
DEFINE g_dzse_m_o      type_g_dzse_m  #單頭舊值宣告(其他用途)
 
   DEFINE g_dzse001_t LIKE dzse_t.dzse001
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_dzse001 LIKE dzse_t.dzse001
      END RECORD 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num5              #單身筆數                         
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num5              #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num5              #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num5              #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num5              #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC

#自定義變數
DEFINE g_argv1 STRING
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="adzi520.main" >}
#應用 a26 樣板自動產生(Version:3)
#+ 作業開始(主程式類型)
MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_4tb_path STRING,
          ls_img_path STRING,
          ln_cnt      INTEGER
 
   #自定義變數
   DEFINE ls_argv STRING

   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   CALL cl_tool_init()

   #客製或帳號為topstd不彈窗
   IF NOT cl_null(ARG_VAL(2)) THEN
      IF FGL_GETENV("DGENV") = "c" OR g_account = "topstd" THEN
         RETURN
      END IF
   END IF
 
   LET g_forupd_sql = "SELECT COUNT(*) FROM dzse_t WHERE dzse001= '" , ARG_VAL(2) , "' "
   PREPARE query_dzse_t FROM g_forupd_sql
   EXECUTE query_dzse_t INTO ln_cnt

   IF ln_cnt > 0 THEN
      return
   END IF
   
   LET g_forupd_sql = " SELECT dzse001,dzse002,dzseownid,'',dzseowndp,'',dzsecrtid,'',dzsecrtdp,'',dzsecrtdt, 
       dzsemodid,'',dzsemoddt", 
                      " FROM dzse_t",
                      " WHERE dzse001=? FOR UPDATE"
   
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adzi520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.dzse001,t0.dzse002,t0.dzseownid,t0.dzseowndp,t0.dzsecrtid,t0.dzsecrtdp, 
       t0.dzsecrtdt,t0.dzsemodid,t0.dzsemoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011", 
 
               " FROM dzse_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.dzseownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.dzseowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.dzsecrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.dzsecrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.dzsemodid  ",
 
               " WHERE  t0.dzse001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
 
   #end add-point
   PREPARE adzi520_master_referesh FROM g_sql
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi520 WITH FORM cl_ap_formpath("adz",g_code)
   
   CLOSE WINDOW screen

   #程式初始化
   CALL adzi520_init()   
 
   CALL cl_ui_wintitle(1) #工具抬頭名稱

   CALL cl_load_4ad_interface(NULL)

   LET lw_window = ui.Window.getCurrent()
   LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
   CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

   LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
   LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
   CALL ui.Interface.loadStyles(ls_4st_path)

   LET lf_form = lw_window.getForm()
   LET ls_4tb_path = os.Path.join(os.Path.join(ls_cfg_path, "4tb"), "toolbar_designer.4tb")
   CALL lf_form.loadToolBar(ls_4tb_path)

   #進入選單 Menu (="N")
   CALL adzi520_ui_dialog() 

 
 
   #畫面關閉
   CLOSE WINDOW w_adzi520
      
   CLOSE adzi520_cl
   
   
 
   
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="adzi520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi520_init()
   #add-point:init段define
 
   #end add-point
   #add-point:init段define
   
   #end add-point
   #定義combobox狀態
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL adzi520_default_search()

   IF NOT cl_null(ARG_VAL(2)) THEN 
      LET g_dzse_m.dzse001 = ARG_VAL(2)
      #LET g_actdefault = "modify"
      LET g_argv1 = ARG_VAL(2)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adzi520_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5        #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5        #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
             prog   STRING,                 #串查程式名稱
             param  DYNAMIC ARRAY OF STRING #傳遞變數
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   #add-point:ui_dialog段define
   
   #end add-point
   #add-point:ui_dialog段define
   
   #end add-point
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:2)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         CALL adzi520_insert()
      OTHERWISE
   END CASE
 
 
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
 
   WHILE li_exit = FALSE
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL adzi520_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL adzi520_fetch("")   
               END IF               
           
               IF NOT cl_null(g_argv1) THEN
                  IF g_browser_cnt > 0 THEN
                     LET g_action_choice="modify"
                     LET g_aw = ''
                     #CALL adzi520_query()
                     CALL adzi520_modify()
                  ELSE
                     LET g_action_choice="insert"
                     LET g_actdefault = ""
                     CALL adzi520_insert()

                  END IF
                  LET g_argv1 = ""
               END IF
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL adzi520_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL adzi520_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL adzi520_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL adzi520_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL adzi520_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden       
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
            
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL adzi520_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL adzi520_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adzi520_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL adzi520_modify()
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL adzi520_delete()
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            CALL adzi520_insert()
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            CALL adzi520_reproduce()
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            CALL adzi520_query()
            
            
            #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL adzi520_set_pk_array()
            
         ON ACTION agendum
            CALL adzi520_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adzi520_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
            
            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL adzi520_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               CALL adzi520_browser_fill(g_wc,"")
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL adzi520_fetch("")   
               END IF               
               
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
               
               #end add-point
            
 
 
         
            
            
            #第一筆資料
            ON ACTION first
               CALL adzi520_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL adzi520_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL adzi520_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL adzi520_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL adzi520_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #主頁摺疊
            ON ACTION mainhidden       
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
               
         
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            ON ACTION controls   
               IF g_header_hidden THEN
                  CALL gfrm_curr.setElementHidden("vb_master",0)
                  CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
                  LET g_header_hidden = 0     #visible
               ELSE
                  CALL gfrm_curr.setElementHidden("vb_master",1)
                  CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
                  LET g_header_hidden = 1     #hidden     
               END IF
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL adzi520_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL adzi520_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adzi520_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL adzi520_modify()
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL adzi520_delete()
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            CALL adzi520_insert()
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            CALL adzi520_reproduce()
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            CALL adzi520_query()
            
 
            #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL adzi520_set_pk_array()
            CALL cl_doc()
            
         ON ACTION agendum
            CALL adzi520_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adzi520_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog
      
      #end add-point
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.browser_fill" >}
#應用 a29 樣板自動產生(Version:3)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION adzi520_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   
   #end add-point
   #add-point:browser_fill段define
   
   #end add-point
   
   LET l_searchcol = "dzse001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM dzse_t ",
               "  ",
               "  ",
               " WHERE  ", 
               p_wc CLIPPED, cl_sql_add_filter("dzse_t")
                
   #add-point:browser_fill段cnt_sql
   
   #end add-point
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_dzse_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT '',t0.dzse001",
               " FROM dzse_t t0 ",
               "  ",
               
               " WHERE  ", ls_wc, cl_sql_add_filter("dzse_t")
   #add-point:browser_fill段fill_wc
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"dzse_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   #CALL g_browser.clear()
   #LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_dzse001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point
      
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      #CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx) #2015/04/13 by Hiko
   END IF
   
   IF cl_null(g_browser[g_cnt].b_dzse001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前
   #end add-point   
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="adzi520.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adzi520_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define
   
   #end add-point
   #add-point:cs段define
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_dzse_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON dzse001,dzse002,dzseownid,dzseowndp,dzsecrtid,dzsecrtdp,dzsecrtdt,dzsemodid, 
          dzsemoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:2)
         #共用欄位查詢處理  
         ##----<<dzsecrtdt>>----
         AFTER FIELD dzsecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dzsemoddt>>----
         AFTER FIELD dzsemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzsecnfdt>>----
         
         #----<<dzsepstdt>>----
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzse001
            #add-point:BEFORE FIELD dzse001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzse001
            
            #add-point:AFTER FIELD dzse001
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzse001
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzse001
            #add-point:ON ACTION controlp INFIELD dzse001
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzse002
            #add-point:BEFORE FIELD dzse002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzse002
            
            #add-point:AFTER FIELD dzse002
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzse002
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzse002
            #add-point:ON ACTION controlp INFIELD dzse002
            
            #END add-point
 
         #Ctrlp:construct.c.dzseownid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzseownid
            #add-point:ON ACTION controlp INFIELD dzseownid
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzseownid  #顯示到畫面上
            NEXT FIELD dzseownid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzseownid
            #add-point:BEFORE FIELD dzseownid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzseownid
            
            #add-point:AFTER FIELD dzseownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzseowndp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzseowndp
            #add-point:ON ACTION controlp INFIELD dzseowndp
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzseowndp  #顯示到畫面上
            NEXT FIELD dzseowndp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzseowndp
            #add-point:BEFORE FIELD dzseowndp
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzseowndp
            
            #add-point:AFTER FIELD dzseowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzsecrtid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzsecrtid
            #add-point:ON ACTION controlp INFIELD dzsecrtid
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzsecrtid  #顯示到畫面上
            NEXT FIELD dzsecrtid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzsecrtid
            #add-point:BEFORE FIELD dzsecrtid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzsecrtid
            
            #add-point:AFTER FIELD dzsecrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.dzsecrtdp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzsecrtdp
            #add-point:ON ACTION controlp INFIELD dzsecrtdp
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzsecrtdp  #顯示到畫面上
            NEXT FIELD dzsecrtdp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzsecrtdp
            #add-point:BEFORE FIELD dzsecrtdp
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzsecrtdp
            
            #add-point:AFTER FIELD dzsecrtdp
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzsecrtdt
            #add-point:BEFORE FIELD dzsecrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.dzsemodid
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzsemodid
            #add-point:ON ACTION controlp INFIELD dzsemodid
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzsemodid  #顯示到畫面上
            NEXT FIELD dzsemodid                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzsemodid
            #add-point:BEFORE FIELD dzsemodid
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzsemodid
            
            #add-point:AFTER FIELD dzsemodid
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzsemoddt
            #add-point:BEFORE FIELD dzsemoddt
            
            #END add-point
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="adzi520.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi520_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   #add-point:query段define
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_dzse_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.h_count
   CALL adzi520_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adzi520_browser_fill(g_wc,"F")
      CALL adzi520_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL adzi520_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL adzi520_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="adzi520.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi520_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point  
   #add-point:fetch段define
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
   
   LET g_browser_cnt = g_browser.getLength()
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_dzse_m.dzse001 = g_browser[g_current_idx].b_dzse001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE adzi520_master_referesh USING g_dzse_m.dzse001 INTO g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid, 
       g_dzse_m.dzseowndp,g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid, 
       g_dzse_m.dzsemoddt,g_dzse_m.dzseownid_desc,g_dzse_m.dzseowndp_desc,g_dzse_m.dzsecrtid_desc,g_dzse_m.dzsecrtdp_desc, 
       g_dzse_m.dzsemodid_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dzse_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      INITIALIZE g_dzse_m.* TO NULL
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL adzi520_set_act_visible()
   CALL adzi520_set_act_no_visible()
 
   #add-point:fetch段action控制
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_dzse_m_t.* = g_dzse_m.*
   LET g_dzse_m_o.* = g_dzse_m.*
   
   LET g_data_owner = g_dzse_m.dzseownid      
   LET g_data_dept  = g_dzse_m.dzseowndp
   
   #重新顯示
   CALL adzi520_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.insert" >}
#+ 資料新增
PRIVATE FUNCTION adzi520_insert()
   #add-point:insert段define
   
   #end add-point    
   #add-point:insert段define
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_dzse_m.* LIKE dzse_t.*             #DEFAULT 設定
   LET g_dzse001_t = NULL
 
   
   #add-point:insert段before
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
      LET g_dzse_m.dzseownid = g_user
      LET g_dzse_m.dzseowndp = g_dept
      LET g_dzse_m.dzsecrtid = g_user
      LET g_dzse_m.dzsecrtdp = g_dept 
      LET g_dzse_m.dzsecrtdt = cl_get_current()
      LET g_dzse_m.dzsemodid = g_user
      LET g_dzse_m.dzsemoddt = cl_get_current()
 
      #外部參數新增
      IF NOT cl_null(g_argv1) THEN
         LET g_dzse_m.dzse001 = g_argv1
      END IF 
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值
      
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL adzi520_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_dzse_m.* TO NULL
         CALL adzi520_show()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL adzi520_set_act_visible()
   CALL adzi520_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_dzse001_t = g_dzse_m.dzse001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzse001 = '", g_dzse_m.dzse001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adzi520_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adzi520_master_referesh USING g_dzse_m.dzse001 INTO g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid, 
       g_dzse_m.dzseowndp,g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid, 
       g_dzse_m.dzsemoddt,g_dzse_m.dzseownid_desc,g_dzse_m.dzseowndp_desc,g_dzse_m.dzsecrtid_desc,g_dzse_m.dzsecrtdp_desc, 
       g_dzse_m.dzsemodid_desc
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid,g_dzse_m.dzseownid_desc,g_dzse_m.dzseowndp, 
       g_dzse_m.dzseowndp_desc,g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtid_desc,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdp_desc, 
       g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid,g_dzse_m.dzsemodid_desc,g_dzse_m.dzsemoddt
 
   #add-point:新增結束後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.modify" >}
#+ 資料修改
PRIVATE FUNCTION adzi520_modify()
   #add-point:modify段define
   
   #end add-point
   #add-point:modify段define
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_dzse_m.dzse001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_dzse001_t = g_dzse_m.dzse001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN adzi520_cl USING g_dzse_m.dzse001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adzi520_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE adzi520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adzi520_master_referesh USING g_dzse_m.dzse001 INTO g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid, 
       g_dzse_m.dzseowndp,g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid, 
       g_dzse_m.dzsemoddt,g_dzse_m.dzseownid_desc,g_dzse_m.dzseowndp_desc,g_dzse_m.dzsecrtid_desc,g_dzse_m.dzsecrtdp_desc, 
       g_dzse_m.dzsemodid_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dzse_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE adzi520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   #顯示資料
   CALL adzi520_show()
   
   WHILE TRUE
      LET g_dzse_m.dzse001 = g_dzse001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_dzse_m.dzsemodid = g_user 
LET g_dzse_m.dzsemoddt = cl_get_current()
LET g_dzse_m.dzsemodid_desc = cl_get_username(g_dzse_m.dzsemodid)
      
      #add-point:modify段修改前
      
      #end add-point
 
      #資料輸入
      CALL adzi520_input("u")     
 
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzse_m.* = g_dzse_m_t.*
         CALL adzi520_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE dzse_t SET (dzsemodid,dzsemoddt) = (g_dzse_m.dzsemodid,g_dzse_m.dzsemoddt)
       WHERE  dzse001 = g_dzse001_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL adzi520_set_act_visible()
   CALL adzi520_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzse001 = '", g_dzse_m.dzse001, "' "
 
   #填到對應位置
   CALL adzi520_browser_fill(g_wc,"")
 
   CLOSE adzi520_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U(暫時無用)
   #CALL cl_flow_notify(g_dzse_m.dzse001,"U")
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="adzi520.input" >}
#+ 資料輸入
PRIVATE FUNCTION adzi520_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num5        #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define
   
   #end add-point
   #add-point:input段define
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid,g_dzse_m.dzseownid_desc,g_dzse_m.dzseowndp, 
       g_dzse_m.dzseowndp_desc,g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtid_desc,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdp_desc, 
       g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid,g_dzse_m.dzsemodid_desc,g_dzse_m.dzsemoddt
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL adzi520_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL adzi520_set_no_entry(p_cmd)
   #add-point:資料輸入前
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_dzse_m.dzse001,g_dzse_m.dzse002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzse001
            #add-point:BEFORE FIELD dzse001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzse001
            
            #add-point:AFTER FIELD dzse001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_dzse_m.dzse001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dzse_m.dzse001 != g_dzse001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzse_t WHERE "||"dzse001 = '"||g_dzse_m.dzse001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzse001
            #add-point:ON CHANGE dzse001
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzse002
            #add-point:BEFORE FIELD dzse002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzse002
            
            #add-point:AFTER FIELD dzse002
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzse002
            #add-point:ON CHANGE dzse002
            
            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.dzse001
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzse001
            #add-point:ON ACTION controlp INFIELD dzse001
            
            #END add-point
 
         #Ctrlp:input.c.dzse002
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzse002
            #add-point:ON ACTION controlp INFIELD dzse002
            
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(*) INTO l_count FROM dzse_t
                WHERE  dzse001 = g_dzse_m.dzse001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO dzse_t (dzse001,dzse002,dzseownid,dzseowndp,dzsecrtid,dzsecrtdp,dzsecrtdt, 
                      dzsemodid,dzsemoddt)
                  VALUES (g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid,g_dzse_m.dzseowndp,g_dzse_m.dzsecrtid, 
                      g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid,g_dzse_m.dzsemoddt) 
                  
                  #add-point:單頭新增中
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzse_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =  "g_dzse_m.dzse001" 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               #add-point:單頭修改前
               
               #end add-point
               UPDATE dzse_t SET (dzse001,dzse002,dzseownid,dzseowndp,dzsecrtid,dzsecrtdp,dzsecrtdt, 
                   dzsemodid,dzsemoddt) = (g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid,g_dzse_m.dzseowndp, 
                   g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid,g_dzse_m.dzsemoddt) 
 
                WHERE  dzse001 = g_dzse001_t #
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzse_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzse_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     #add-point:單頭修改後
                     
                     #end add-point
                     #紀錄資料更動
                     LET g_log1 = util.JSON.stringify(g_dzse_m_t)
                     LET g_log2 = util.JSON.stringify(g_dzse_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input 
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog 
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input 
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adzi520_reproduce()
   DEFINE l_newno     LIKE dzse_t.dzse001 
   DEFINE l_oldno     LIKE dzse_t.dzse001 
 
   DEFINE l_master    RECORD LIKE dzse_t.*
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point   
   #add-point:reproduce段define
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_dzse_m.dzse001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_dzse001_t = g_dzse_m.dzse001
 
   
   #清空key值
   LET g_dzse_m.dzse001 = ""
 
    
   CALL adzi520_set_entry("a")
   CALL adzi520_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:4)    
      #公用欄位新增給值  
      LET g_dzse_m.dzseownid = g_user
      LET g_dzse_m.dzseowndp = g_dept
      LET g_dzse_m.dzsecrtid = g_user
      LET g_dzse_m.dzsecrtdp = g_dept 
      LET g_dzse_m.dzsecrtdt = cl_get_current()
      LET g_dzse_m.dzsemodid = g_user
      LET g_dzse_m.dzsemoddt = cl_get_current()
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL adzi520_input("r")
   
   IF INT_FLAG THEN
      #取消
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      INITIALIZE g_dzse_m.* TO NULL
      CALL adzi520_show()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前
   
   #end add-point
   
   #add-point:單頭複製中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dzse_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL adzi520_set_act_visible()
   CALL adzi520_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_dzse001_t = g_dzse_m.dzse001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzse001 = '", g_dzse_m.dzse001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adzi520_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
                   
END FUNCTION
 
{</section>}
 
{<section id="adzi520.show" >}
#+ 資料顯示 
PRIVATE FUNCTION adzi520_show()
   #add-point:show段define
   
   #end add-point  
   #add-point:show段define
   
   #end add-point
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:3)
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL adzi520_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid,g_dzse_m.dzseownid_desc,g_dzse_m.dzseowndp, 
       g_dzse_m.dzseowndp_desc,g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtid_desc,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdp_desc, 
       g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid,g_dzse_m.dzsemodid_desc,g_dzse_m.dzsemoddt
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION adzi520_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point  
   #add-point:delete段define
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_dzse_m.dzse001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_dzse001_t = g_dzse_m.dzse001
 
   
   
 
   OPEN adzi520_cl USING g_dzse_m.dzse001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adzi520_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE adzi520_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adzi520_master_referesh USING g_dzse_m.dzse001 INTO g_dzse_m.dzse001,g_dzse_m.dzse002,g_dzse_m.dzseownid, 
       g_dzse_m.dzseowndp,g_dzse_m.dzsecrtid,g_dzse_m.dzsecrtdp,g_dzse_m.dzsecrtdt,g_dzse_m.dzsemodid, 
       g_dzse_m.dzsemoddt,g_dzse_m.dzseownid_desc,g_dzse_m.dzseowndp_desc,g_dzse_m.dzsecrtid_desc,g_dzse_m.dzsecrtdp_desc, 
       g_dzse_m.dzsemodid_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_dzse_m.dzse001 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #將最新資料顯示到畫面上
   CALL adzi520_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL adzi520_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
      DELETE FROM dzse_t 
       WHERE  dzse001 = g_dzse_m.dzse001 
 
 
      #add-point:單頭刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dzse_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
  
      
      
      #add-point:單頭刪除後
      
      #end add-point
      
          
      CLEAR FORM
      CALL adzi520_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL adzi520_browser_fill(g_wc,"")
         CALL adzi520_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      
   END IF
 
   CLOSE adzi520_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_dzse_m.dzse001,"D")
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi520_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   #add-point:ui_browser_refresh段define
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzse001 = g_dzse_m.dzse001
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="adzi520.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi520_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define
   
   #end add-point     
   #add-point:set_entry段define
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("dzse001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi520_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define
   
   #end add-point     
   #add-point:set_no_entry段define
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("dzse001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzi520.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adzi520_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段define
   
   #end add-point  
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adzi520.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adzi520_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adzi520.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adzi520_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   DEFINE i STRING
   LET i=ARG_VAL(2) CLIPPED
   #end add-point  
   #add-point:default_search段define
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前
 
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(i) THEN
      LET ls_wc = ls_wc, " dzse001 = '", i, "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF


END FUNCTION
 
{</section>}
 
{<section id="adzi520.state_change" >}
   
 
{</section>}
 
{<section id="adzi520.signature" >}
   
 
{</section>}
 
{<section id="adzi520.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION adzi520_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_dzse_m.dzse001
   LET g_pk_array[1].column = 'dzse001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="adzi520.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="adzi520.other_function" readonly="Y" >}

 
{</section>}
 
