{<section id="adzq999.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000015
#+ 
#+ Filename...: adzq999
#+ Description: adzq999測試-jay
#+ Creator....: 02785(2015-05-11 16:10:17)
#+ Modifier...: 02785(2015-05-11 16:10:17) -SD/PR- 00000()
 
{</section>}
 
{<section id="adzq999.global" >}
#應用 i07 樣板自動產生(Version:19)

 
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
PRIVATE type type_g_dzyd_m        RECORD
       dzyd001 LIKE dzyd_t.dzyd001
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dzyd_d        RECORD
       dzyd005 LIKE dzyd_t.dzyd005, 
   dzyd002 LIKE dzyd_t.dzyd002, 
   dzyd006 LIKE dzyd_t.dzyd006, 
   dzyd014 LIKE dzyd_t.dzyd014, 
   dzyd015 LIKE dzyd_t.dzyd015, 
   dzyd007 LIKE dzyd_t.dzyd007, 
   dzyd018 LIKE dzyd_t.dzyd018, 
   dzyd017 LIKE dzyd_t.dzyd017, 
   dzyd003 LIKE dzyd_t.dzyd003, 
   dzyd004 LIKE dzyd_t.dzyd004, 
   dzyd009 LIKE dzyd_t.dzyd009, 
   dzyd010 LIKE dzyd_t.dzyd010, 
   dzyd011 LIKE dzyd_t.dzyd011, 
   dzyd012 LIKE dzyd_t.dzyd012, 
   dzyd008 LIKE dzyd_t.dzyd008, 
   dzyd013 LIKE dzyd_t.dzyd013, 
   dzyd016 LIKE dzyd_t.dzyd016
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_dzyd_m          type_g_dzyd_m
DEFINE g_dzyd_m_t        type_g_dzyd_m
DEFINE g_dzyd_m_o        type_g_dzyd_m
DEFINE g_dzyd001_t LIKE dzyd_t.dzyd001
 
 
DEFINE g_dzyd_d          DYNAMIC ARRAY OF type_g_dzyd_d
DEFINE g_dzyd_d_t        type_g_dzyd_d
DEFINE g_dzyd_d_o        type_g_dzyd_d
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_dzyd001 LIKE dzyd_t.dzyd001
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_run_mode LIKE type_t.chr20 

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="adzq999.main" >}
#應用 a26 樣板自動產生(Version:4)
#+ 作業開始(主程式類型)
MAIN
   DEFINE lw_window   ui.Window,
          lf_form     ui.Form,
          ls_cfg_path STRING,
          ls_4st_path STRING,
          ls_4tb_path STRING,
          ls_img_path STRING
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()
 
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT dzyd001", 
                      " FROM dzyd_t",
                      " WHERE dzyd001=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE adzq999_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.dzyd001",
               " FROM dzyd_t t0",
               
               " WHERE  t0.dzyd001 = ?"
   #add-point:SQL_define
   
   #end add-point
   PREPARE adzq999_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzq999 WITH FORM cl_ap_formpath("adz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
     #CLOSE WINDOW screen

      #程式初始化
      CALL adzq999_init()   
      
     #CALL cl_ui_wintitle(1) #工具抬頭名稱
     #
     #CALL cl_load_4ad_interface(NULL)
     #
     #LET lw_window = ui.Window.getCurrent()
     #LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
     #CALL lw_window.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))
     #
     #LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
     #LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
     #CALL ui.Interface.loadStyles(ls_4st_path)

     #LET lf_form = lw_window.getForm()
     #LET ls_4tb_path = os.Path.JOIN(os.Path.JOIN(ls_cfg_path, "4tb"), "toolbar_designer.4tb")
     #CALL lf_form.loadToolBar(ls_4tb_path)
   
 
      #進入選單 Menu (="N")
      CALL adzq999_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adzq999
      
   END IF 
   
   CLOSE adzq999_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="adzq999.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzq999_init()
   #add-point:init段define
   
   #end add-point
   #add-point:init段define
   
   #end add-point   

   LET g_run_mode = ARG_VAL(2)
   LET g_run_mode = DOWNSHIFT(g_run_mode)
   IF NOT cl_null(g_run_mode) THEN
      DISPLAY "執行模式:",g_run_mode
   END IF
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   IF g_run_mode = "debug" THEN
      CALL cl_set_comp_visible("dzyd003,dzyd004,dzyd009,dzyd010,dzyd011,dzyd012,dzyd008,dzyd013,dzyd016",TRUE) 
   ELSE
      CALL cl_set_comp_visible("dzyd003,dzyd004,dzyd009,dzyd010,dzyd011,dzyd012,dzyd008,dzyd013,dzyd016",FALSE) 
   END IF
   
   CALL adzq999_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adzq999.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adzq999_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define
   
   #end add-point  
   #add-point:ui_dialog段define
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_dzyd_m.* TO NULL
         CALL g_dzyd_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adzq999_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_dzyd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL adzq999_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adzq999_ui_detailshow()
               
               #add-point:page1自定義行為
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL adzq999_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL adzq999_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adzq999_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adzq999_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzq999_idx_chk()
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adzq999_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzq999_idx_chk()
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adzq999_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzq999_idx_chk()
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adzq999_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzq999_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adzq999_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzq999_idx_chk()
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            #browser
            CALL g_export_node.clear()
            IF g_main_hidden = 1 THEN
               LET g_export_node[1] = base.typeInfo.create(g_browser)
               LET g_export_id[1]   = "s_browse"
               CALL cl_export_to_excel()
            #非browser
            ELSE
               LET g_export_node[1] = base.typeInfo.create(g_dzyd_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
            
         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
                CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD dzyd002
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL adzq999_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL adzq999_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL adzq999_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            CALL adzq999_insert()
            #add-point:ON ACTION insert
            
            #END add-point
               
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            CALL adzq999_query()
            #add-point:ON ACTION query
            
            #END add-point
            #應用 a59 樣板自動產生(Version:2)  
            CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
         

         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL adzq999_set_pk_array()
            CALL cl_doc()
            
         ON ACTION agendum
            CALL adzq999_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adzq999_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
         CONTINUE DIALOG
            
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adzq999_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define
   
   #end add-point
   #add-point:browser_search段define
   
   #end add-point   
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzq999_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   
   #end add-point
   #add-point:browser_fill段define
   
   #end add-point   
   
   #add-point:browser_fill段動作開始前
   
   #end add-point    
 
   LET l_searchcol = "dzyd001"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE dzyd001 ",
 
                      " FROM dzyd_t ",
                      " ",
                      " ",
 
                      " WHERE  ",l_wc, " AND ", l_wc2, cl_sql_add_filter("dzyd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE dzyd001 ",
 
                      " FROM dzyd_t ",
                      " ",
                      " ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("dzyd_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前
   
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
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
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_dzyd_m.* TO NULL
      CALL g_dzyd_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.dzyd001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.dzyd001",
                " FROM dzyd_t t0",
 
                
                " WHERE  ", l_wc," AND ",l_wc2, cl_sql_add_filter("dzyd_t")
 
   #add-point:browser_fill,sql_rank前
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"dzyd_t")             #WC重組
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   FOREACH browse_cur INTO g_browser[g_cnt].b_dzyd001 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'Foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point  
 
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_dzyd001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_dzyd_m.* TO NULL
      CALL g_dzyd_d.clear()
 
      #add-point:browser_fill段after_clear
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL adzq999_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
   
   FREE browse_pre
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adzq999_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point  
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_dzyd_m.dzyd001 = g_browser[g_current_idx].b_dzyd001   
 
   EXECUTE adzq999_master_referesh USING g_dzyd_m.dzyd001 INTO g_dzyd_m.dzyd001
   CALL adzq999_show()
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adzq999_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   #add-point:ui_detailshow段define
   
   #end add-point
   
   #add-point:ui_detailshow段before
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzq999_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point 
   #add-point:ui_browser_refresh段define
   
   #end add-point   
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzyd001 = g_dzyd_m.dzyd001 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adzq999_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point 
    #add-point:cs段define
   
   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_dzyd_m.* TO NULL
   CALL g_dzyd_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dzyd001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd001
            #add-point:BEFORE FIELD dzyd001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd001
            
            #add-point:AFTER FIELD dzyd001
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.dzyd001
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd001
            #add-point:ON ACTION controlp INFIELD dzyd001
            
            #END add-point
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON dzyd005,dzyd002,dzyd006,dzyd014,dzyd015,dzyd007,dzyd018,dzyd017,dzyd003, 
          dzyd004,dzyd009,dzyd010,dzyd011,dzyd012,dzyd008,dzyd013,dzyd016
           FROM s_detail1[1].dzyd005,s_detail1[1].dzyd002,s_detail1[1].dzyd006,s_detail1[1].dzyd014, 
               s_detail1[1].dzyd015,s_detail1[1].dzyd007,s_detail1[1].dzyd018,s_detail1[1].dzyd017,s_detail1[1].dzyd003, 
               s_detail1[1].dzyd004,s_detail1[1].dzyd009,s_detail1[1].dzyd010,s_detail1[1].dzyd011,s_detail1[1].dzyd012, 
               s_detail1[1].dzyd008,s_detail1[1].dzyd013,s_detail1[1].dzyd016
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd005
            #add-point:BEFORE FIELD dzyd005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd005
            
            #add-point:AFTER FIELD dzyd005
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd005
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd005
            #add-point:ON ACTION controlp INFIELD dzyd005
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd002
            #add-point:BEFORE FIELD dzyd002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd002
            
            #add-point:AFTER FIELD dzyd002
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd002
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd002
            #add-point:ON ACTION controlp INFIELD dzyd002
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd006
            #add-point:BEFORE FIELD dzyd006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd006
            
            #add-point:AFTER FIELD dzyd006
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd006
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd006
            #add-point:ON ACTION controlp INFIELD dzyd006
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd014
            #add-point:BEFORE FIELD dzyd014
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd014
            
            #add-point:AFTER FIELD dzyd014
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd014
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd014
            #add-point:ON ACTION controlp INFIELD dzyd014
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd015
            #add-point:BEFORE FIELD dzyd015
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd015
            
            #add-point:AFTER FIELD dzyd015
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd015
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd015
            #add-point:ON ACTION controlp INFIELD dzyd015
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd007
            #add-point:BEFORE FIELD dzyd007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd007
            
            #add-point:AFTER FIELD dzyd007
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd007
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd007
            #add-point:ON ACTION controlp INFIELD dzyd007
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd018
            #add-point:BEFORE FIELD dzyd018
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd018
            
            #add-point:AFTER FIELD dzyd018
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd018
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd018
            #add-point:ON ACTION controlp INFIELD dzyd018
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd017
            #add-point:BEFORE FIELD dzyd017
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd017
            
            #add-point:AFTER FIELD dzyd017
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd017
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd017
            #add-point:ON ACTION controlp INFIELD dzyd017
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd003
            #add-point:BEFORE FIELD dzyd003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd003
            
            #add-point:AFTER FIELD dzyd003
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd003
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd003
            #add-point:ON ACTION controlp INFIELD dzyd003
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd004
            #add-point:BEFORE FIELD dzyd004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd004
            
            #add-point:AFTER FIELD dzyd004
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd004
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd004
            #add-point:ON ACTION controlp INFIELD dzyd004
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd009
            #add-point:BEFORE FIELD dzyd009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd009
            
            #add-point:AFTER FIELD dzyd009
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd009
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd009
            #add-point:ON ACTION controlp INFIELD dzyd009
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd010
            #add-point:BEFORE FIELD dzyd010
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd010
            
            #add-point:AFTER FIELD dzyd010
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd010
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd010
            #add-point:ON ACTION controlp INFIELD dzyd010
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd011
            #add-point:BEFORE FIELD dzyd011
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd011
            
            #add-point:AFTER FIELD dzyd011
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd011
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd011
            #add-point:ON ACTION controlp INFIELD dzyd011
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd012
            #add-point:BEFORE FIELD dzyd012
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd012
            
            #add-point:AFTER FIELD dzyd012
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd012
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd012
            #add-point:ON ACTION controlp INFIELD dzyd012
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd008
            #add-point:BEFORE FIELD dzyd008
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd008
            
            #add-point:AFTER FIELD dzyd008
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd008
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd008
            #add-point:ON ACTION controlp INFIELD dzyd008
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd013
            #add-point:BEFORE FIELD dzyd013
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd013
            
            #add-point:AFTER FIELD dzyd013
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd013
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd013
            #add-point:ON ACTION controlp INFIELD dzyd013
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd016
            #add-point:BEFORE FIELD dzyd016
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd016
            
            #add-point:AFTER FIELD dzyd016
            
            #END add-point
            
            
 
         #Ctrlp:construct.c.page1.dzyd016
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd016
            #add-point:ON ACTION controlp INFIELD dzyd016
            
            #END add-point
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog
         
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   #add-point:cs段after_construct
   
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzq999_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   #add-point:query段define
   
   #end add-point   
 
   #add-point:query開始前
   
   #end add-point 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
   
   LET ls_wc = g_wc
 
   LET INT_FLAG = 0    
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_dzyd_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL adzq999_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adzq999_browser_fill(g_wc)
      CALL adzq999_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL adzq999_browser_fill("F")
   
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
      CALL adzq999_fetch("F") 
   END IF
   
   CALL adzq999_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzq999_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point
   #add-point:fetch段define
   
   #end add-point   
   
   #add-point:fetch段動作開始前
   
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL adzq999_browser_fill(p_flag)
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_dzyd_m.dzyd001 = g_browser[g_current_idx].b_dzyd001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adzq999_master_referesh USING g_dzyd_m.dzyd001 INTO g_dzyd_m.dzyd001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dzyd_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_dzyd_m.* TO NULL
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL adzq999_set_act_visible()
   CALL adzq999_set_act_no_visible()
 
   #保存單頭舊值
   LET g_dzyd_m_t.* = g_dzyd_m.*
   LET g_dzyd_m_o.* = g_dzyd_m.*
   
   #重新顯示   
   CALL adzq999_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.insert" >}
#+ 資料新增
PRIVATE FUNCTION adzq999_insert()
   #add-point:insert段define
   
   #end add-point
   #add-point:insert段define
   
   #end add-point   
   
   #add-point:insert段before
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_dzyd_d.clear()
 
 
   INITIALIZE g_dzyd_m.* LIKE dzyd_t.*             #DEFAULT 設定
   LET g_dzyd001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值
      
      #end add-point 
 
      CALL adzq999_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         LET INT_FLAG = 0
         LET g_dzyd_m.* = g_dzyd_m_t.*
         CALL adzq999_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_dzyd_m.* TO NULL
         INITIALIZE g_dzyd_d TO NULL
 
         CALL adzq999_show()
         RETURN
      END IF
    
      #CALL g_dzyd_d.clear()
 
      
      #add-point:單頭輸入後2
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL adzq999_set_act_visible()
   CALL adzq999_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_dzyd001_t = g_dzyd_m.dzyd001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzyd001 = '", g_dzyd_m.dzyd001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adzq999_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL adzq999_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adzq999_master_referesh USING g_dzyd_m.dzyd001 INTO g_dzyd_m.dzyd001
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dzyd_m.dzyd001
   
   #功能已完成,通報訊息中心
   CALL adzq999_msgcentre_notify('')
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.modify" >}
#+ 資料修改
PRIVATE FUNCTION adzq999_modify()
   #add-point:modify段define
   
   #end add-point  
   #add-point:modify段define
   
   #end add-point    
   
   IF g_dzyd_m.dzyd001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_dzyd001_t = g_dzyd_m.dzyd001
 
   CALL s_transaction_begin()
   
   OPEN adzq999_cl USING g_dzyd_m.dzyd001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adzq999_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE adzq999_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adzq999_master_referesh USING g_dzyd_m.dzyd001 INTO g_dzyd_m.dzyd001
   
   CALL s_transaction_end('Y','0')
 
   CALL adzq999_show()
   WHILE TRUE
      LET g_dzyd001_t = g_dzyd_m.dzyd001
 
 
      #add-point:modify段修改前
      
      #end add-point
      
      CALL adzq999_input("u")     #欄位更改
      
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzyd_m.* = g_dzyd_m_t.*
         CALL adzq999_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_dzyd_m.dzyd001 != g_dzyd001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         
         #end add-point
         
         #add-point:單頭(偽)修改中
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL adzq999_set_act_visible()
   CALL adzq999_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzyd001 = '", g_dzyd_m.dzyd001, "' "
 
   #填到對應位置
   CALL adzq999_browser_fill("")
 
   CALL adzq999_idx_chk()
 
   CLOSE adzq999_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adzq999_msgcentre_notify('')
   
END FUNCTION   
 
{</section>}
 
{<section id="adzq999.input" >}
#+ 資料輸入
PRIVATE FUNCTION adzq999_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define
   
   #end add-point
   #add-point:input段define
   
   #end add-point   
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dzyd_m.dzyd001
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT dzyd005,dzyd002,dzyd006,dzyd014,dzyd015,dzyd007,dzyd018,dzyd017,dzyd003, 
       dzyd004,dzyd009,dzyd010,dzyd011,dzyd012,dzyd008,dzyd013,dzyd016 FROM dzyd_t WHERE dzyd001=? AND  
       dzyd002=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adzq999_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adzq999_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL adzq999_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   
   #end add-point
 
   DISPLAY BY NAME g_dzyd_m.dzyd001
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adzq999.input.head" >}
   
      #單頭段
      INPUT BY NAME g_dzyd_m.dzyd001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd001
            #add-point:BEFORE FIELD dzyd001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd001
            
            #add-point:AFTER FIELD dzyd001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_dzyd_m.dzyd001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dzyd_m.dzyd001 != g_dzyd001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzyd_t WHERE "||"dzyd001 = '"||g_dzyd_m.dzyd001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd001
            #add-point:ON CHANGE dzyd001
            
            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.dzyd001
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd001
            #add-point:ON ACTION controlp INFIELD dzyd001
            
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
 
            #多語言處理
            
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_dzyd_m.dzyd001             
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               
               #end add-point
            
               UPDATE dzyd_t SET (dzyd001) = (g_dzyd_m.dzyd001)
                WHERE  dzyd001 = g_dzyd001_t
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzyd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzyd_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzyd_m.dzyd001
               LET gs_keys_bak[1] = g_dzyd001_t
               LET gs_keys[2] = g_dzyd_d[g_detail_idx].dzyd002
               LET gs_keys_bak[2] = g_dzyd_d_t.dzyd002
               CALL adzq999_update_b('dzyd_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_dzyd_m_t)
                     #LET g_log2 = util.JSON.stringify(g_dzyd_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
            ELSE    
               #add-point:單頭新增
               
               #end add-point
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL adzq999_detail_reproduce()
               END IF
            END IF
 
           LET g_dzyd001_t = g_dzyd_m.dzyd001
 
           
           IF g_dzyd_d.getLength() = 0 THEN
              NEXT FIELD dzyd002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="adzq999.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzyd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dzyd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adzq999_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adzq999_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN adzq999_cl USING g_dzyd_m.dzyd001                          
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN adzq999_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE adzq999_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_dzyd_d[l_ac].dzyd002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dzyd_d_t.* = g_dzyd_d[l_ac].*  #BACKUP
               LET g_dzyd_d_o.* = g_dzyd_d[l_ac].*  #BACKUP
               CALL adzq999_set_entry_b(l_cmd)
               #add-point:set_entry_b後
               
               #end add-point
               CALL adzq999_set_no_entry_b(l_cmd)
               OPEN adzq999_bcl USING g_dzyd_m.dzyd001,
 
                                                g_dzyd_d_t.dzyd002
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN adzq999_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzq999_bcl INTO g_dzyd_d[l_ac].dzyd005,g_dzyd_d[l_ac].dzyd002,g_dzyd_d[l_ac].dzyd006, 
                      g_dzyd_d[l_ac].dzyd014,g_dzyd_d[l_ac].dzyd015,g_dzyd_d[l_ac].dzyd007,g_dzyd_d[l_ac].dzyd018, 
                      g_dzyd_d[l_ac].dzyd017,g_dzyd_d[l_ac].dzyd003,g_dzyd_d[l_ac].dzyd004,g_dzyd_d[l_ac].dzyd009, 
                      g_dzyd_d[l_ac].dzyd010,g_dzyd_d[l_ac].dzyd011,g_dzyd_d[l_ac].dzyd012,g_dzyd_d[l_ac].dzyd008, 
                      g_dzyd_d[l_ac].dzyd013,g_dzyd_d[l_ac].dzyd016
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_dzyd_d_t.dzyd002 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL adzq999_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_dzyd_d_t.* TO NULL
            INITIALIZE g_dzyd_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzyd_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_dzyd_d_t.* = g_dzyd_d[l_ac].*     #新輸入資料
            LET g_dzyd_d_o.* = g_dzyd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzq999_set_entry_b(l_cmd)
            #add-point:set_entry_b後
            
            #end add-point
            CALL adzq999_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dzyd_d[li_reproduce_target].* = g_dzyd_d[li_reproduce].*
 
               LET g_dzyd_d[g_dzyd_d.getLength()].dzyd002 = NULL
 
            END IF
            
            #add-point:modify段before insert
            
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dzyd_t 
             WHERE  dzyd001 = g_dzyd_m.dzyd001
 
               AND dzyd002 = g_dzyd_d[l_ac].dzyd002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前
               
               #end add-point
               INSERT INTO dzyd_t
                           (
                            dzyd001,
                            dzyd002
                            ,dzyd005,dzyd006,dzyd014,dzyd015,dzyd007,dzyd018,dzyd017,dzyd003,dzyd004,dzyd009,dzyd010,dzyd011,dzyd012,dzyd008,dzyd013,dzyd016) 
                     VALUES(
                            g_dzyd_m.dzyd001,
                            g_dzyd_d[l_ac].dzyd002
                            ,g_dzyd_d[l_ac].dzyd005,g_dzyd_d[l_ac].dzyd006,g_dzyd_d[l_ac].dzyd014,g_dzyd_d[l_ac].dzyd015, 
                                g_dzyd_d[l_ac].dzyd007,g_dzyd_d[l_ac].dzyd018,g_dzyd_d[l_ac].dzyd017, 
                                g_dzyd_d[l_ac].dzyd003,g_dzyd_d[l_ac].dzyd004,g_dzyd_d[l_ac].dzyd009, 
                                g_dzyd_d[l_ac].dzyd010,g_dzyd_d[l_ac].dzyd011,g_dzyd_d[l_ac].dzyd012, 
                                g_dzyd_d[l_ac].dzyd008,g_dzyd_d[l_ac].dzyd013,g_dzyd_d[l_ac].dzyd016) 
 
               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_dzyd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dzyd_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF adzq999_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE adzq999_bcl
               LET l_count = g_dzyd_d.getLength()
            END IF 
            
            #add-point:單身刪除後
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_dzyd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd005
            #add-point:BEFORE FIELD dzyd005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd005
            
            #add-point:AFTER FIELD dzyd005
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd005
            #add-point:ON CHANGE dzyd005
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd002
            #add-point:BEFORE FIELD dzyd002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd002
            
            #add-point:AFTER FIELD dzyd002
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_dzyd_m.dzyd001 IS NOT NULL AND g_dzyd_d[g_detail_idx].dzyd002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dzyd_m.dzyd001 != g_dzyd001_t OR g_dzyd_d[g_detail_idx].dzyd002 != g_dzyd_d_t.dzyd002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzyd_t WHERE "||"dzyd001 = '"||g_dzyd_m.dzyd001 ||"' AND "|| "dzyd002 = '"||g_dzyd_d[g_detail_idx].dzyd002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd002
            #add-point:ON CHANGE dzyd002
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd006
            #add-point:BEFORE FIELD dzyd006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd006
            
            #add-point:AFTER FIELD dzyd006
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd006
            #add-point:ON CHANGE dzyd006
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd014
            #add-point:BEFORE FIELD dzyd014
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd014
            
            #add-point:AFTER FIELD dzyd014
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd014
            #add-point:ON CHANGE dzyd014
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd015
            #add-point:BEFORE FIELD dzyd015
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd015
            
            #add-point:AFTER FIELD dzyd015
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd015
            #add-point:ON CHANGE dzyd015
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd007
            #add-point:BEFORE FIELD dzyd007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd007
            
            #add-point:AFTER FIELD dzyd007
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd007
            #add-point:ON CHANGE dzyd007
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd018
            #add-point:BEFORE FIELD dzyd018
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd018
            
            #add-point:AFTER FIELD dzyd018
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd018
            #add-point:ON CHANGE dzyd018
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd017
            #add-point:BEFORE FIELD dzyd017
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd017
            
            #add-point:AFTER FIELD dzyd017
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd017
            #add-point:ON CHANGE dzyd017
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd003
            #add-point:BEFORE FIELD dzyd003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd003
            
            #add-point:AFTER FIELD dzyd003
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd003
            #add-point:ON CHANGE dzyd003
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd004
            #add-point:BEFORE FIELD dzyd004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd004
            
            #add-point:AFTER FIELD dzyd004
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd004
            #add-point:ON CHANGE dzyd004
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd009
            #add-point:BEFORE FIELD dzyd009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd009
            
            #add-point:AFTER FIELD dzyd009
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd009
            #add-point:ON CHANGE dzyd009
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd010
            #add-point:BEFORE FIELD dzyd010
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd010
            
            #add-point:AFTER FIELD dzyd010
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd010
            #add-point:ON CHANGE dzyd010
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd011
            #add-point:BEFORE FIELD dzyd011
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd011
            
            #add-point:AFTER FIELD dzyd011
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd011
            #add-point:ON CHANGE dzyd011
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd012
            #add-point:BEFORE FIELD dzyd012
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd012
            
            #add-point:AFTER FIELD dzyd012
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd012
            #add-point:ON CHANGE dzyd012
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd008
            #add-point:BEFORE FIELD dzyd008
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd008
            
            #add-point:AFTER FIELD dzyd008
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd008
            #add-point:ON CHANGE dzyd008
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd013
            #add-point:BEFORE FIELD dzyd013
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd013
            
            #add-point:AFTER FIELD dzyd013
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd013
            #add-point:ON CHANGE dzyd013
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD dzyd016
            #add-point:BEFORE FIELD dzyd016
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD dzyd016
            
            #add-point:AFTER FIELD dzyd016
            
            #END add-point
            
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE dzyd016
            #add-point:ON CHANGE dzyd016
            
            #END add-point 
 
 
                  #Ctrlp:input.c.page1.dzyd005
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd005
            #add-point:ON ACTION controlp INFIELD dzyd005
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd002
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd002
            #add-point:ON ACTION controlp INFIELD dzyd002
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd006
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd006
            #add-point:ON ACTION controlp INFIELD dzyd006
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd014
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd014
            #add-point:ON ACTION controlp INFIELD dzyd014
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd015
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd015
            #add-point:ON ACTION controlp INFIELD dzyd015
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd007
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd007
            #add-point:ON ACTION controlp INFIELD dzyd007
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd018
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd018
            #add-point:ON ACTION controlp INFIELD dzyd018
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd017
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd017
            #add-point:ON ACTION controlp INFIELD dzyd017
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd003
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd003
            #add-point:ON ACTION controlp INFIELD dzyd003
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd004
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd004
            #add-point:ON ACTION controlp INFIELD dzyd004
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd009
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd009
            #add-point:ON ACTION controlp INFIELD dzyd009
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd010
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd010
            #add-point:ON ACTION controlp INFIELD dzyd010
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd011
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd011
            #add-point:ON ACTION controlp INFIELD dzyd011
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd012
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd012
            #add-point:ON ACTION controlp INFIELD dzyd012
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd008
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd008
            #add-point:ON ACTION controlp INFIELD dzyd008
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd013
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd013
            #add-point:ON ACTION controlp INFIELD dzyd013
            
            #END add-point
 
         #Ctrlp:input.c.page1.dzyd016
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD dzyd016
            #add-point:ON ACTION controlp INFIELD dzyd016
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzyd_d[l_ac].* = g_dzyd_d_t.*
               CLOSE adzq999_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_dzyd_d[l_ac].dzyd002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_dzyd_d[l_ac].* = g_dzyd_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               
               #end add-point
         
               UPDATE dzyd_t SET (dzyd001,dzyd005,dzyd002,dzyd006,dzyd014,dzyd015,dzyd007,dzyd018,dzyd017, 
                   dzyd003,dzyd004,dzyd009,dzyd010,dzyd011,dzyd012,dzyd008,dzyd013,dzyd016) = (g_dzyd_m.dzyd001, 
                   g_dzyd_d[l_ac].dzyd005,g_dzyd_d[l_ac].dzyd002,g_dzyd_d[l_ac].dzyd006,g_dzyd_d[l_ac].dzyd014, 
                   g_dzyd_d[l_ac].dzyd015,g_dzyd_d[l_ac].dzyd007,g_dzyd_d[l_ac].dzyd018,g_dzyd_d[l_ac].dzyd017, 
                   g_dzyd_d[l_ac].dzyd003,g_dzyd_d[l_ac].dzyd004,g_dzyd_d[l_ac].dzyd009,g_dzyd_d[l_ac].dzyd010, 
                   g_dzyd_d[l_ac].dzyd011,g_dzyd_d[l_ac].dzyd012,g_dzyd_d[l_ac].dzyd008,g_dzyd_d[l_ac].dzyd013, 
                   g_dzyd_d[l_ac].dzyd016)
                WHERE  dzyd001 = g_dzyd_m.dzyd001 
 
                 AND dzyd002 = g_dzyd_d_t.dzyd002 #項次   
 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dzyd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "dzyd_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dzyd_m.dzyd001
               LET gs_keys_bak[1] = g_dzyd001_t
               LET gs_keys[2] = g_dzyd_d[g_detail_idx].dzyd002
               LET gs_keys_bak[2] = g_dzyd_d_t.dzyd002
               CALL adzq999_update_b('dzyd_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_dzyd_m),util.JSON.stringify(g_dzyd_d_t)
                     LET g_log2 = util.JSON.stringify(g_dzyd_m),util.JSON.stringify(g_dzyd_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #若Key欄位有變動
               LET ls_keys[01] = g_dzyd_m.dzyd001
 
               LET ls_keys[ls_keys.getLength()+1] = g_dzyd_d_t.dzyd002
 
               CALL adzq999_key_update_b(ls_keys)
               
               #add-point:單身修改後
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dzyd_d[l_ac].* = g_dzyd_d_t.*
               END IF
               CLOSE adzq999_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE adzq999_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_dzyd_d.getLength() = 0 THEN
               NEXT FIELD dzyd002
            END IF
            #add-point:input段after input 
            
            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_dzyd_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_dzyd_d.getLength()+1
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD dzyd001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dzyd005
 
            END CASE
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
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
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
 
 
   
   #add-point:input段after_input
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzq999_show()
   #add-point:show段define
   
   #end add-point
   #add-point:show段define
   
   #end add-point
   
   #add-point:show段之前
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL adzq999_b_fill(g_wc2) #第一階單身填充
      CALL adzq999_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL adzq999_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   DISPLAY BY NAME g_dzyd_m.dzyd001
 
   CALL adzq999_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION adzq999_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   #add-point:ref_show段define
   
   #end add-point 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dzyd_d.getLength()
      #add-point:ref_show段d_reference
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adzq999_reproduce()
   DEFINE l_newno     LIKE dzyd_t.dzyd001 
   DEFINE l_oldno     LIKE dzyd_t.dzyd001 
 
   DEFINE l_master    RECORD LIKE dzyd_t.*
   DEFINE l_detail    RECORD LIKE dzyd_t.*
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define
   
   #end add-point
   #add-point:reproduce段define
   
   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_dzyd_m.dzyd001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_dzyd001_t = g_dzyd_m.dzyd001
 
   
   LET g_dzyd_m.dzyd001 = ""
 
   LET g_master_insert = FALSE
   CALL adzq999_set_entry('a')
   CALL adzq999_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #清空key欄位的desc
   
   
   CALL adzq999_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_dzyd_m.* TO NULL
      INITIALIZE g_dzyd_d TO NULL
 
      CALL adzq999_show()
      LET INT_FLAG = 0
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL adzq999_set_act_visible()
   CALL adzq999_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_dzyd001_t = g_dzyd_m.dzyd001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " dzyd001 = '", g_dzyd_m.dzyd001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adzq999_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL adzq999_idx_chk()
   
   #add-point:完成複製段落後
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL adzq999_msgcentre_notify('')
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adzq999_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE dzyd_t.*
 
 
   #add-point:delete段define
   
   #end add-point    
   #add-point:delete段define
   
   #end add-point 
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adzq999_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE adzq999_detail AS ",
                "SELECT * FROM dzyd_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO adzq999_detail SELECT * FROM dzyd_t 
                                         WHERE  dzyd001 = g_dzyd001_t
 
   
   #將key修正為調整後   
   UPDATE adzq999_detail 
      #更新key欄位
      SET dzyd001 = g_dzyd_m.dzyd001
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO dzyd_t SELECT * FROM adzq999_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE adzq999_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_dzyd001_t = g_dzyd_m.dzyd001
 
   
   DROP TABLE adzq999_detail
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adzq999_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point     
   #add-point:delete段define
   
   #end add-point
   
   IF g_dzyd_m.dzyd001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN adzq999_cl USING g_dzyd_m.dzyd001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adzq999_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE adzq999_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adzq999_master_referesh USING g_dzyd_m.dzyd001 INTO g_dzyd_m.dzyd001
   
   CALL adzq999_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL adzq999_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
  
 
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM dzyd_t WHERE  dzyd001 = g_dzyd_m.dzyd001
 
                                                               
      #add-point:單身刪除中
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dzyd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE adzq999_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_dzyd_d.clear() 
 
     
      CALL adzq999_ui_browser_refresh()  
      #CALL adzq999_ui_headershow()  
      #CALL adzq999_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL adzq999_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL adzq999_browser_fill("F")
         CLEAR FORM
      END IF
       
   END IF
 
   CLOSE adzq999_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adzq999_msgcentre_notify('')
    
END FUNCTION
 
{</section>}
 
{<section id="adzq999.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adzq999_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   
   #end add-point     
   #add-point:b_fill段define
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_dzyd_d.clear()
 
 
   #add-point:b_fill段sql_before
   
   #end add-point
   
   LET g_sql = "SELECT  UNIQUE dzyd005,dzyd002,dzyd006,dzyd014,dzyd015,dzyd007,dzyd018,dzyd017,dzyd003, 
       dzyd004,dzyd009,dzyd010,dzyd011,dzyd012,dzyd008,dzyd013,dzyd016 FROM dzyd_t",   
               "",
               
               
               " WHERE dzyd001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("dzyd_t")
   END IF
   
   #add-point:b_fill段sql_after
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF adzq999_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY dzyd_t.dzyd002"
         #add-point:b_fill段fill_before
         
         #end add-point
         PREPARE adzq999_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adzq999_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_dzyd_m.dzyd001
                                               
      FOREACH b_fill_cs INTO g_dzyd_d[l_ac].dzyd005,g_dzyd_d[l_ac].dzyd002,g_dzyd_d[l_ac].dzyd006,g_dzyd_d[l_ac].dzyd014, 
          g_dzyd_d[l_ac].dzyd015,g_dzyd_d[l_ac].dzyd007,g_dzyd_d[l_ac].dzyd018,g_dzyd_d[l_ac].dzyd017, 
          g_dzyd_d[l_ac].dzyd003,g_dzyd_d[l_ac].dzyd004,g_dzyd_d[l_ac].dzyd009,g_dzyd_d[l_ac].dzyd010, 
          g_dzyd_d[l_ac].dzyd011,g_dzyd_d[l_ac].dzyd012,g_dzyd_d[l_ac].dzyd008,g_dzyd_d[l_ac].dzyd013, 
          g_dzyd_d[l_ac].dzyd016
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF 
            EXIT FOREACH
         END IF
      
         LET l_ac = l_ac + 1
         
      END FOREACH
 
            CALL g_dzyd_d.deleteElement(g_dzyd_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE adzq999_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adzq999_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   #add-point:idx_chk段define
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_dzyd_d.getLength() THEN
         LET g_detail_idx = g_dzyd_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_dzyd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dzyd_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adzq999_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define
   
   #end add-point
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_dzyd_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION adzq999_before_delete()
   #add-point:before_delete段define
   
   #end add-point 
   #add-point:before_delete段define
   
   #end add-point 
   #add-point:單筆刪除前
   
   #end add-point
   
   DELETE FROM dzyd_t
    WHERE  dzyd001 = g_dzyd_m.dzyd001 AND
 
          dzyd002 = g_dzyd_d_t.dzyd002
 
      
   #add-point:單筆刪除中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dzyd_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="adzq999.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adzq999_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
   #add-point:delete_b段define
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adzq999_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   #add-point:insert_b段define
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adzq999_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
   #end add-point     
   #add-point:update_b段define
   
   #end add-point 
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION adzq999_key_update_b(ps_keys_bak)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define
   
   #end add-point
   #add-point:update_b段define
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_dzyd_d[l_ac].dzyd002 = g_dzyd_d_t.dzyd002 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adzq999_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   #add-point:lock_b段define
   
   #end add-point
   
   #先刷新資料
   #CALL adzq999_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adzq999_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzq999_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
   #add-point:set_entry段define
   
   #end add-point 
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("dzyd001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzq999_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
   #add-point:set_no_entry段define
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("dzyd001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzq999_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段define
   
   #end add-point 
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adzq999_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry_b段
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adzq999_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adzq999_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adzq999_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adzq999.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adzq999_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adzq999.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adzq999_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point 
   #add-point:default_search段define
   
   #end add-point    
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " dzyd001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
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
 
{<section id="adzq999.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adzq999_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define
   
   #end add-point
   #add-point:fill_chk段define
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adzq999.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION adzq999_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   #add-point:modify_detail_chk段define
   
   #end add-point
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "dzyd005"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="adzq999.mask_functions" >}
 
{</section>}
 
{<section id="adzq999.state_change" >}
    
 
{</section>}
 
{<section id="adzq999.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION adzq999_set_pk_array()
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
   LET g_pk_array[1].values = g_dzyd_m.dzyd001
   LET g_pk_array[1].column = 'dzyd001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="adzq999.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:2)
PRIVATE FUNCTION adzq999_msgcentre_notify(lc_state)
   DEFINE lc_state LIKE type_t.chr5
   #add-point:msgcentre_notify段define
   
   #end add-point
   #add-point:msgcentre_notify段define
   
   #end add-point   
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   IF g_action_choice = "statechange" THEN
      LET g_msgparam.state = g_action_choice,":",lc_state
   ELSE
      LET g_msgparam.state = g_action_choice
   END IF
 
   #PK資料填寫
   CALL adzq999_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_dzyd_m)
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="adzq999.other_function" readonly="Y" >}

 
{</section>}
 
