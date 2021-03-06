#該程式已解開Section, 不再透過樣板產出!
{<section id="axct305_02.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000005
#+ 
#+ Filename...: axct305_02
#+ Description: axct306整批導入
#+ Creator....: 00537(2014/09/10)
#+ Modifier...: 00537(2014/09/10) -SD/PR- 08993
#+ Buildtype..: 應用 i01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axct305_02.global" >}
#161108-00013#1   2016/11/08 By 07024  與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
#161109-00085#23  2016/11/16 By 08993  整批調整系統星號寫法
 
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
PRIVATE TYPE type_g_xcdb_m RECORD
       xcdbcomp LIKE xcdb_t.xcdbcomp, 
   xcdbcomp_desc LIKE type_t.chr80, 
   xcdbld LIKE xcdb_t.xcdbld, 
   xcdbld_desc LIKE type_t.chr80, 
   format LIKE type_t.chr500, 
   char LIKE type_t.chr500, 
   dir LIKE type_t.chr500
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_xcdb_m        type_g_xcdb_m  #單頭變數宣告
DEFINE g_xcdb_m_t      type_g_xcdb_m  #單頭舊值宣告(系統還原用)
DEFINE g_xcdb_m_o      type_g_xcdb_m  #單頭舊值宣告(其他用途)
 
   DEFINE g_xcdbld_t LIKE xcdb_t.xcdbld
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_xcdbld LIKE xcdb_t.xcdbld,
      b_xcdb001 LIKE xcdb_t.xcdb001,
      b_xcdb002 LIKE xcdb_t.xcdb002,
      b_xcdb003 LIKE xcdb_t.xcdb003,
      b_xcdb004 LIKE xcdb_t.xcdb004,
      b_xcdb005 LIKE xcdb_t.xcdb005,
      b_xcdb006 LIKE xcdb_t.xcdb006,
      b_xcdb007 LIKE xcdb_t.xcdb007,
      b_xcdb008 LIKE xcdb_t.xcdb008,
      b_xcdb009 LIKE xcdb_t.xcdb009,
      b_xcdb010 LIKE xcdb_t.xcdb010
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
#161108-00013#1-s-mod
#DEFINE g_rec_b               LIKE type_t.num5              #單身筆數                         
#DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
#DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
#DEFINE gwin_curr             ui.Window                     #Current Window
#DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
#DEFINE g_page_action         STRING                        #page action
#DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
#DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
#DEFINE g_page                STRING                        #第幾頁
#DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_ch                  base.Channel                  #外串程式用
#DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
#DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
#DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
#DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
#DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
#DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
#DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
#DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
#DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
#DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
# 
##快速搜尋用
#DEFINE g_searchcol           STRING                        #查詢欄位代碼
#DEFINE g_searchstr           STRING                        #查詢欄位字串
#DEFINE g_order               STRING                        #查詢排序模式
# 
##Browser用
#DEFINE g_current_idx         LIKE type_t.num5              #Browser 所在筆數(當下page)
#DEFINE g_current_row         LIKE type_t.num5              #Browser 所在筆數(暫存用)
#DEFINE g_current_cnt         LIKE type_t.num5              #Browser 總筆數(當下page)
#DEFINE g_browser_idx         LIKE type_t.num5              #Browser 所在筆數(所有資料)
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser 總筆數(所有資料)  
#DEFINE g_row_index           LIKE type_t.num5              #階層樹狀用指標
DEFINE g_rec_b               LIKE type_t.num10              #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10              #page起始筆數
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
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)  
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
#161108-00013#1-e-mod 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axct305_02.main" >}
#+ 此段落由子樣板a27產生
#+ 資料輸入
PUBLIC FUNCTION axct305_02(--)
   #add-point:main段變數傳入

   #end add-point
   )
   #add-point:main段define

   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = "SELECT xcdbcomp,'',xcdbld,'','','','' FROM xcdb_t WHERE xcdbent= ? AND xcdbld=?  
       AND xcdb001=? AND xcdb002=? AND xcdb003=? AND xcdb004=? AND xcdb005=? AND xcdb006=? AND xcdb007=?  
       AND xcdb008=? AND xcdb009=? AND xcdb010=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct305_02_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT t0.xcdbcomp,t0.xcdbld",
               " FROM xcdb_t t0",
               " WHERE xcdbent = '" ||g_enterprise|| "' AND t0.xcdbld = ? AND t0.xcdb001 = ? AND t0.xcdb002 = ? AND t0.xcdb003 = ? AND t0.xcdb004 = ? AND t0.xcdb005 = ? AND t0.xcdb006 = ? AND t0.xcdb007 = ? AND t0.xcdb008 = ? AND t0.xcdb009 = ? AND t0.xcdb010 = ?"
   #add-point:SQL_define

   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axct305_02_master_referesh FROM g_sql
   
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axct305_02 WITH FORM cl_ap_formpath("axc","axct305_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL axct305_02_init()   
 
   #進入選單 Menu (="N")
   CALL axct305_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_axct305_02
 
   CLOSE axct305_02_cl
   
   
 
   #add-point:離開前
   LET INT_FLAG = FALSE
   LET g_action_choice= ''
   #end add-point
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="axct305_02.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct305_02_init()
   #add-point:init段define
   
   #end add-point
 
   #定義combobox狀態
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL axct305_02_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axct305_02_ui_dialog() 
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
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   
   
   
   #action default動作
   
   
   #add-point:ui_dialog段before dialog 

   #end add-point
 
#   WHILE li_exit = FALSE
      
      CALL axct305_02_browser_fill(g_wc,"")
      
      #判斷前一個動作是否為新增或複製, 若是的話切換到新增的筆數
      #IF g_state = "Y" THEN
      #   FOR li_idx = 1 TO g_browser.getLength()
      #      IF g_browser[li_idx].b_xcdbld = g_xcdbld_t
      #         AND g_browser[li_idx].b_xcdb001 = g_xcdb001_t
      #         AND g_browser[li_idx].b_xcdb002 = g_xcdb002_t
      #         AND g_browser[li_idx].b_xcdb003 = g_xcdb003_t
      #         AND g_browser[li_idx].b_xcdb004 = g_xcdb004_t
      #         AND g_browser[li_idx].b_xcdb005 = g_xcdb005_t
      #         AND g_browser[li_idx].b_xcdb006 = g_xcdb006_t
      #         AND g_browser[li_idx].b_xcdb007 = g_xcdb007_t
      #         AND g_browser[li_idx].b_xcdb008 = g_xcdb008_t
      #         AND g_browser[li_idx].b_xcdb009 = g_xcdb009_t
      #         AND g_browser[li_idx].b_xcdb010 = g_xcdb010_t
 
      #         THEN
      #         LET g_current_row = li_idx
      #         EXIT FOR
      #      END IF
      #   END FOR
      #   LET g_state = ""
      #END IF
    
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
                  
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
               
               #當每次點任一筆資料都會需要用到  
#               IF g_browser_cnt > 0 THEN
#                  CALL axct305_02_fetch("")   
#               END IF               
               #add-point:ui_dialog段 before menu
               CALL axct305_02_input('a')
               EXIT MENU
               #end add-point
			
               
            #第一筆資料
            ON ACTION first
               CALL axct305_02_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL axct305_02_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL axct305_02_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL axct305_02_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL axct305_02_fetch("L")  
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
            
            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
                  CALL axct305_02_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axct305_02_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CLEAR FORM
                  ELSE
                     CALL axct305_02_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
            
            
            
            #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axct305_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct305_02_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct305_02_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
          ON ACTION accept
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
             
          #放棄輸入
          ON ACTION cancel
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
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
                  CALL axct305_02_fetch("")      
                  
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array

            #end add-point
 
         
            BEFORE DIALOG
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL axct305_02_fetch("")   
               END IF               
               
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog

               #end add-point
            
         
            
            
            #第一筆資料
            ON ACTION first
               CALL axct305_02_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL axct305_02_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL axct305_02_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL axct305_02_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL axct305_02_fetch("L")  
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
               EXIT DIALOG
               
         
            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
                  CALL axct305_02_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axct305_02_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CLEAR FORM
                  ELSE
                     CALL axct305_02_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
            
            
 
            #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axct305_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct305_02_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct305_02_set_pk_array()
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
      
#   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.browser_fill" >}
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION axct305_02_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define

   #end add-point
   
   CLEAR FORM
   INITIALIZE g_xcdb_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "xcdbld,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,xcdb008,xcdb009,xcdb010"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   
   #add-point:browser_fill段wc控制

   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM xcdb_t ",
               "  ",
               "  ",
               " WHERE xcdbent = '" ||g_enterprise|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("xcdb_t")
                
   #add-point:browser_fill段cnt_sql

   #end add-point
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_browser_cnt 
      LET g_errparam.code   = 9035
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_browser_cnt = g_max_browse
   END IF
   
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   LET g_wc = p_wc
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   LET g_sql = " SELECT '',t0.xcdbld,t0.xcdb001,t0.xcdb002,t0.xcdb003,t0.xcdb004,t0.xcdb005,t0.xcdb006, 
       t0.xcdb007,t0.xcdb008,t0.xcdb009,t0.xcdb010",
               " FROM xcdb_t t0 ",
               "  ",
               
               " WHERE t0.xcdbent = '" ||g_enterprise|| "' AND ", g_wc, cl_sql_add_filter("xcdb_t")
   #add-point:browser_fill段fill_wc

   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre

   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcdb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xcdbld,g_browser[g_cnt].b_xcdb001, 
       g_browser[g_cnt].b_xcdb002,g_browser[g_cnt].b_xcdb003,g_browser[g_cnt].b_xcdb004,g_browser[g_cnt].b_xcdb005, 
       g_browser[g_cnt].b_xcdb006,g_browser[g_cnt].b_xcdb007,g_browser[g_cnt].b_xcdb008,g_browser[g_cnt].b_xcdb009, 
       g_browser[g_cnt].b_xcdb010
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
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axct305_02.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct305_02_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_xcdb_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON xcdbcomp,xcdbld,format,char,dir
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct
            
            #end add-point             
      
         #公用欄位開窗相關處理
         
      
         #一般欄位
                  #此段落由子樣板a01產生
         BEFORE FIELD xcdbcomp
            #add-point:BEFORE FIELD xcdbcomp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdbcomp
            
            #add-point:AFTER FIELD xcdbcomp
            
            #END add-point
            
 
         #Ctrlp:construct.c.xcdbcomp
         ON ACTION controlp INFIELD xcdbcomp
            #add-point:ON ACTION controlp INFIELD xcdbcomp
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdbld
            #add-point:BEFORE FIELD xcdbld
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdbld
            
            #add-point:AFTER FIELD xcdbld
            
            #END add-point
            
 
         #Ctrlp:construct.c.xcdbld
         ON ACTION controlp INFIELD xcdbld
            #add-point:ON ACTION controlp INFIELD xcdbld
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD format
            #add-point:BEFORE FIELD format
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD format
            
            #add-point:AFTER FIELD format
            
            #END add-point
            
 
         #Ctrlp:construct.c.format
         ON ACTION controlp INFIELD format
            #add-point:ON ACTION controlp INFIELD format
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD char
            #add-point:BEFORE FIELD char
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD char
            
            #add-point:AFTER FIELD char
            
            #END add-point
            
 
         #Ctrlp:construct.c.char
         ON ACTION controlp INFIELD char
            #add-point:ON ACTION controlp INFIELD char
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dir
            #add-point:BEFORE FIELD dir
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dir
            
            #add-point:AFTER FIELD dir
            
            #END add-point
            
 
         #Ctrlp:construct.c.dir
         ON ACTION controlp INFIELD dir
            #add-point:ON ACTION controlp INFIELD dir
            
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
 
{<section id="axct305_02.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct305_02_query()
   DEFINE ls_wc STRING
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
 
   INITIALIZE g_xcdb_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL axct305_02_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axct305_02_browser_fill(g_wc,"F")
      CALL axct305_02_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL axct305_02_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL axct305_02_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct305_02_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
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
 
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_current_idx 
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   
   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數
   
   
   CALL axct305_02_browser_fill(g_wc,p_fl)
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
#   LET g_xcdb_m.xcdbld = g_browser[g_current_idx].b_xcdbld
#   LET g_xcdb_m.xcdb001 = g_browser[g_current_idx].b_xcdb001
#   LET g_xcdb_m.xcdb002 = g_browser[g_current_idx].b_xcdb002
#   LET g_xcdb_m.xcdb003 = g_browser[g_current_idx].b_xcdb003
#   LET g_xcdb_m.xcdb004 = g_browser[g_current_idx].b_xcdb004
#   LET g_xcdb_m.xcdb005 = g_browser[g_current_idx].b_xcdb005
#   LET g_xcdb_m.xcdb006 = g_browser[g_current_idx].b_xcdb006
#   LET g_xcdb_m.xcdb007 = g_browser[g_current_idx].b_xcdb007
#   LET g_xcdb_m.xcdb008 = g_browser[g_current_idx].b_xcdb008
#   LET g_xcdb_m.xcdb009 = g_browser[g_current_idx].b_xcdb009
#   LET g_xcdb_m.xcdb010 = g_browser[g_current_idx].b_xcdb010
# 
#                       
#   #讀取單頭所有欄位資料
#   EXECUTE axct305_02_master_referesh USING g_xcdb_m.xcdbld,g_xcdb_m.xcdb001,g_xcdb_m.xcdb002,g_xcdb_m.xcdb003, 
#       g_xcdb_m.xcdb004,g_xcdb_m.xcdb005,g_xcdb_m.xcdb006,g_xcdb_m.xcdb007,g_xcdb_m.xcdb008,g_xcdb_m.xcdb009, 
#       g_xcdb_m.xcdb010 INTO g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld,g_xcdb_m.xcdbcomp_desc,g_xcdb_m.xcdbld_desc 
#
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "xcdb_t" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
# 
#      INITIALIZE g_xcdb_m.* TO NULL
#      RETURN
#   END IF
   
   #add-point:fetch段action控制

   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_xcdb_m_t.* = g_xcdb_m.*
   LET g_xcdb_m_o.* = g_xcdb_m.*
   
   
   #重新顯示
   CALL axct305_02_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct305_02_insert()
   #add-point:insert段define

   #end add-point    
   
   CLEAR FORM #清畫面欄位內容
#   INITIALIZE g_xcdb_m.* LIKE xcdb_t.*             #DEFAULT 設定
#   LET g_xcdbld_t = NULL
#   LET g_xcdb001_t = NULL
#   LET g_xcdb002_t = NULL
#   LET g_xcdb003_t = NULL
#   LET g_xcdb004_t = NULL
#   LET g_xcdb005_t = NULL
#   LET g_xcdb006_t = NULL
#   LET g_xcdb007_t = NULL
#   LET g_xcdb008_t = NULL
#   LET g_xcdb009_t = NULL
#   LET g_xcdb010_t = NULL
 
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值

      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL axct305_02_input("a")
      
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
         INITIALIZE g_xcdb_m.* TO NULL
         CALL axct305_02_show()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #將新增的資料併入搜尋條件中
   #LET g_state = "Y"
 
#   LET g_xcdbld_t = g_xcdb_m.xcdbld
#   LET g_xcdb001_t = g_xcdb_m.xcdb001
#   LET g_xcdb002_t = g_xcdb_m.xcdb002
#   LET g_xcdb003_t = g_xcdb_m.xcdb003
#   LET g_xcdb004_t = g_xcdb_m.xcdb004
#   LET g_xcdb005_t = g_xcdb_m.xcdb005
#   LET g_xcdb006_t = g_xcdb_m.xcdb006
#   LET g_xcdb007_t = g_xcdb_m.xcdb007
#   LET g_xcdb008_t = g_xcdb_m.xcdb008
#   LET g_xcdb009_t = g_xcdb_m.xcdb009
#   LET g_xcdb010_t = g_xcdb_m.xcdb010
# 
#   
#   LET g_current_idx = g_browser.getLength() + 1
#   LET g_browser[g_current_idx].b_xcdbld = g_xcdb_m.xcdbld
#   LET g_browser[g_current_idx].b_xcdb001 = g_xcdb_m.xcdb001
#   LET g_browser[g_current_idx].b_xcdb002 = g_xcdb_m.xcdb002
#   LET g_browser[g_current_idx].b_xcdb003 = g_xcdb_m.xcdb003
#   LET g_browser[g_current_idx].b_xcdb004 = g_xcdb_m.xcdb004
#   LET g_browser[g_current_idx].b_xcdb005 = g_xcdb_m.xcdb005
#   LET g_browser[g_current_idx].b_xcdb006 = g_xcdb_m.xcdb006
#   LET g_browser[g_current_idx].b_xcdb007 = g_xcdb_m.xcdb007
#   LET g_browser[g_current_idx].b_xcdb008 = g_xcdb_m.xcdb008
#   LET g_browser[g_current_idx].b_xcdb009 = g_xcdb_m.xcdb009
#   LET g_browser[g_current_idx].b_xcdb010 = g_xcdb_m.xcdb010
 
   
   LET g_current_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_current_cnt)
   
   #LET g_wc = "(",g_wc,  
   #           " OR ( xcdbent = '" ||g_enterprise|| "' AND",
   #           " xcdbld = '", g_xcdb_m.xcdbld CLIPPED, "' "
   #           ," AND xcdb001 = '", g_xcdb_m.xcdb001 CLIPPED, "' "
   #           ," AND xcdb002 = '", g_xcdb_m.xcdb002 CLIPPED, "' "
   #           ," AND xcdb003 = '", g_xcdb_m.xcdb003 CLIPPED, "' "
   #           ," AND xcdb004 = '", g_xcdb_m.xcdb004 CLIPPED, "' "
   #           ," AND xcdb005 = '", g_xcdb_m.xcdb005 CLIPPED, "' "
   #           ," AND xcdb006 = '", g_xcdb_m.xcdb006 CLIPPED, "' "
   #           ," AND xcdb007 = '", g_xcdb_m.xcdb007 CLIPPED, "' "
   #           ," AND xcdb008 = '", g_xcdb_m.xcdb008 CLIPPED, "' "
   #           ," AND xcdb009 = '", g_xcdb_m.xcdb009 CLIPPED, "' "
   #           ," AND xcdb010 = '", g_xcdb_m.xcdb010 CLIPPED, "' "
 
   #           , ")) "
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct305_02_modify()
   #add-point:modify段define

   #end add-point
   
   #先確定key值無遺漏
   IF g_xcdb_m.xcdbld IS NULL
 
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
#   LET g_xcdbld_t = g_xcdb_m.xcdbld
#   LET g_xcdb001_t = g_xcdb_m.xcdb001
#   LET g_xcdb002_t = g_xcdb_m.xcdb002
#   LET g_xcdb003_t = g_xcdb_m.xcdb003
#   LET g_xcdb004_t = g_xcdb_m.xcdb004
#   LET g_xcdb005_t = g_xcdb_m.xcdb005
#   LET g_xcdb006_t = g_xcdb_m.xcdb006
#   LET g_xcdb007_t = g_xcdb_m.xcdb007
#   LET g_xcdb008_t = g_xcdb_m.xcdb008
#   LET g_xcdb009_t = g_xcdb_m.xcdb009
#   LET g_xcdb010_t = g_xcdb_m.xcdb010
# 
#   
#   CALL s_transaction_begin()
#   
#   #先lock資料
#   OPEN axct305_02_cl USING g_enterprise,g_xcdb_m.xcdbld,g_xcdb_m.xcdb001,g_xcdb_m.xcdb002,g_xcdb_m.xcdb003,g_xcdb_m.xcdb004,g_xcdb_m.xcdb005,g_xcdb_m.xcdb006,g_xcdb_m.xcdb007,g_xcdb_m.xcdb008,g_xcdb_m.xcdb009,g_xcdb_m.xcdb010
#   IF STATUS THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "OPEN axct305_02_cl:" 
#      LET g_errparam.code   = STATUS 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      CLOSE axct305_02_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
# 
#   #顯示最新的資料
#   EXECUTE axct305_02_master_referesh USING g_xcdb_m.xcdbld,g_xcdb_m.xcdb001,g_xcdb_m.xcdb002,g_xcdb_m.xcdb003, 
#       g_xcdb_m.xcdb004,g_xcdb_m.xcdb005,g_xcdb_m.xcdb006,g_xcdb_m.xcdb007,g_xcdb_m.xcdb008,g_xcdb_m.xcdb009, 
#       g_xcdb_m.xcdb010 INTO g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld,g_xcdb_m.xcdbcomp_desc,g_xcdb_m.xcdbld_desc 
#
# 
#   #資料被他人LOCK, 或是sql執行時出現錯誤
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "xcdb_t" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
# 
#      CLOSE axct305_02_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
#   
#   
# 
#   #顯示資料
#   CALL axct305_02_show()
#   
#   WHILE TRUE
#      LET g_xcdb_m.xcdbld = g_xcdbld_t
#      LET g_xcdb_m.xcdb001 = g_xcdb001_t
#      LET g_xcdb_m.xcdb002 = g_xcdb002_t
#      LET g_xcdb_m.xcdb003 = g_xcdb003_t
#      LET g_xcdb_m.xcdb004 = g_xcdb004_t
#      LET g_xcdb_m.xcdb005 = g_xcdb005_t
#      LET g_xcdb_m.xcdb006 = g_xcdb006_t
#      LET g_xcdb_m.xcdb007 = g_xcdb007_t
#      LET g_xcdb_m.xcdb008 = g_xcdb008_t
#      LET g_xcdb_m.xcdb009 = g_xcdb009_t
#      LET g_xcdb_m.xcdb010 = g_xcdb010_t
 
      
      #寫入修改者/修改日期資訊
      
      
      #add-point:modify段修改前

      #end add-point
 
      #資料輸入
#      CALL axct305_02_input("u")     
 
      #add-point:modify段修改後

      #end add-point
      
#      IF INT_FLAG THEN
#         LET INT_FLAG = 0
#         LET g_xcdb_m.* = g_xcdb_m_t.*
#         CALL axct305_02_show()
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "" 
#         LET g_errparam.code   = 9001 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#         EXIT WHILE
#      END IF
# 
#      #若有modid跟moddt則進行update
# 
# 
#      EXIT WHILE
#      
#   END WHILE
#   
#   CLOSE axct305_02_cl
#   CALL s_transaction_end('Y','0')
# 
#   #流程通知預埋點-U(暫時無用)
#   #CALL cl_flow_notify(g_xcdb_m.xcdbld,"U")
#   
#   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="axct305_02.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct305_02_input(p_cmd)
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
   DEFINE ls_str          STRING
   DEFINE l_chr           LIKE type_t.chr1   
   DEFINE l_chr1          LIKE type_t.chr1  
   DEFINE l_num           LIKE type_t.num5
   #end add-point
 
   #切換至輸入畫面
   
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
   CALL axct305_02_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL axct305_02_set_no_entry(p_cmd)
   #add-point:資料輸入前

   #end add-point
   
   DISPLAY BY NAME g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld,g_xcdb_m.format,g_xcdb_m.char,g_xcdb_m.dir
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld,g_xcdb_m.format,g_xcdb_m.char,g_xcdb_m.dir 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #+ 此段落由子樣板a43產生
         ON ACTION browser
            LET g_action_choice="browser"
            IF cl_auth_chk_act("browser") THEN
               
               #add-point:ON ACTION browser
               CALL cl_client_browse_file() RETURNING g_xcdb_m.dir
               LET ls_str = g_xcdb_m.dir
               #抓取目录斜杆
               LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
               LET l_chr = ls_str.substring(l_num+1,l_num+1)                          #截取冒号后的字符 
               LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())   #判断是否为根目录
#               IF l_chr <> l_chr1  THEN         
#                  LET g_xcdb_m.dir = g_xcdb_m.dir||l_chr
#               ELSE
                  LET g_xcdb_m.dir = g_xcdb_m.dir
#               END IF 
               DISPLAY BY NAME g_xcdb_m.dir
               #END add-point
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION off
            LET g_action_choice="off"
            IF cl_auth_chk_act("off") THEN
               
               #add-point:ON ACTION off
               LET INT_FLAG = TRUE
               EXIT DIALOG 
               #END add-point
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION produce
            LET g_action_choice="produce"
            IF cl_auth_chk_act("produce") THEN
               
               #add-point:ON ACTION produce
               ACCEPT DIALOG
               #END add-point
            END IF
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前
            CALL cl_set_combo_scc('format','8915')
            #end add-point
   
                  #此段落由子樣板a02產生
         AFTER FIELD xcdbcomp
            
            #add-point:AFTER FIELD xcdbcomp
            IF NOT cl_null(g_xcdb_m.xcdbcomp) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xcdb_m_t.xcdbcomp IS NULL OR g_xcdb_m.xcdbcomp != g_xcdb_m_t.xcdbcomp)) THEN
                  IF NOT s_axc_chk_ld_comp(g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld) THEN
                     LET g_xcdb_m.xcdbcomp = g_xcdb_m_t.xcdbcomp
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdb_m.xcdbcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdb_m.xcdbcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdb_m.xcdbcomp_desc 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdbcomp
            #add-point:BEFORE FIELD xcdbcomp

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdbcomp
            #add-point:ON CHANGE xcdbcomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdbld
            
            #add-point:AFTER FIELD xcdbld
            IF NOT cl_null(g_xcdb_m.xcdbld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xcdb_m_t.xcdbld IS NULL OR g_xcdb_m.xcdbld != g_xcdb_m_t.xcdbld)) THEN
                  IF NOT s_axc_chk_ld_comp(g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld) THEN
                     LET g_xcdb_m.xcdbld = g_xcdb_m_t.xcdbld
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdb_m.xcdbld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdb_m.xcdbld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdb_m.xcdbld_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdbld
            #add-point:BEFORE FIELD xcdbld

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdbld
            #add-point:ON CHANGE xcdbld

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD format
            #add-point:BEFORE FIELD format

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD format
            
            #add-point:AFTER FIELD format

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE format
            #add-point:ON CHANGE format

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD char
            #add-point:BEFORE FIELD char

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD char
            
            #add-point:AFTER FIELD char

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE char
            #add-point:ON CHANGE char

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dir
            #add-point:BEFORE FIELD dir

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dir
            
            #add-point:AFTER FIELD dir

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dir
            #add-point:ON CHANGE dir

            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.xcdbcomp
         ON ACTION controlp INFIELD xcdbcomp
            #add-point:ON ACTION controlp INFIELD xcdbcomp
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdb_m.xcdbcomp             #給予default值

            #給予arg
            
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_xcdb_m.xcdbcomp = g_qryparam.return1              

            DISPLAY g_xcdb_m.xcdbcomp TO xcdbcomp              #

            NEXT FIELD xcdbcomp                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.xcdbld
         ON ACTION controlp INFIELD xcdbld
            #add-point:ON ACTION controlp INFIELD xcdbld
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdb_m.xcdbld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            IF g_xcdb_m.xcdbcomp IS NOT NULL THEN
               LET g_qryparam.where = " glaacomp = '",g_xcdb_m.xcdbcomp,"'"
            END IF
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcdb_m.xcdbld = g_qryparam.return1              

            DISPLAY g_xcdb_m.xcdbld TO xcdbld              #

            NEXT FIELD xcdbld                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.format
         ON ACTION controlp INFIELD format
            #add-point:ON ACTION controlp INFIELD format

            #END add-point
 
         #Ctrlp:input.c.char
         ON ACTION controlp INFIELD char
            #add-point:ON ACTION controlp INFIELD char

            #END add-point
 
         #Ctrlp:input.c.dir
         ON ACTION controlp INFIELD dir
            #add-point:ON ACTION controlp INFIELD dir

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
  
#            IF p_cmd <> "u" THEN
#               #當p_cmd不為u代表為新增/複製
#               LET l_count = 1  
# 
#               #確定新增的資料不存在(不重複)
#               SELECT COUNT(*) INTO l_count FROM xcdb_t
#                WHERE xcdbent = g_enterprise AND xcdbld = g_xcdb_m.xcdbld
#                  AND xcdb001 = g_xcdb_m.xcdb001
#                  AND xcdb002 = g_xcdb_m.xcdb002
#                  AND xcdb003 = g_xcdb_m.xcdb003
#                  AND xcdb004 = g_xcdb_m.xcdb004
#                  AND xcdb005 = g_xcdb_m.xcdb005
#                  AND xcdb006 = g_xcdb_m.xcdb006
#                  AND xcdb007 = g_xcdb_m.xcdb007
#                  AND xcdb008 = g_xcdb_m.xcdb008
#                  AND xcdb009 = g_xcdb_m.xcdb009
#                  AND xcdb010 = g_xcdb_m.xcdb010
# 
#               IF l_count = 0 THEN
#               
#                  #add-point:單頭新增前

#                  #end add-point
#               
#                  #將新增的單頭資料寫入資料庫
#                  INSERT INTO xcdb_t (xcdbent,xcdbcomp,xcdbld)
#                  VALUES (g_enterprise,g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld) 
#                  
#                  #add-point:單頭新增中

#                  #end add-point
#                  
#                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcdb_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     CONTINUE DIALOG
#                  END IF
#                  
#                  
#                  
#                  #資料多語言用-增/改
#                  
#                  
#                  #add-point:單頭新增後

#                  #end add-point
#                  
#                  CALL s_transaction_end('Y','0')
#               ELSE
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend =  "g_xcdb_m.xcdbld" 
#                  LET g_errparam.code   = "std-00006" 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CALL s_transaction_end('N','0')
#               END IF 
#            ELSE
#               #add-point:單頭修改前

#               #end add-point
#               UPDATE xcdb_t SET (xcdbcomp,xcdbld) = (g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld)
#                WHERE xcdbent = g_enterprise AND xcdbld = g_xcdbld_t #
#                  AND xcdb001 = g_xcdb001_t
#                  AND xcdb002 = g_xcdb002_t
#                  AND xcdb003 = g_xcdb003_t
#                  AND xcdb004 = g_xcdb004_t
#                  AND xcdb005 = g_xcdb005_t
#                  AND xcdb006 = g_xcdb006_t
#                  AND xcdb007 = g_xcdb007_t
#                  AND xcdb008 = g_xcdb008_t
#                  AND xcdb009 = g_xcdb009_t
#                  AND xcdb010 = g_xcdb010_t
# 
#               #add-point:單頭修改中

#               #end add-point
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcdb_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     CALL s_transaction_end('N','0')
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcdb_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     CALL s_transaction_end('N','0')
#                  OTHERWISE
#                     
#                     #資料多語言用-增/改
#                     
#                     #add-point:單頭修改後

#                     #end add-point
#                     #紀錄資料更動
#                     LET g_log1 = util.JSON.stringify(g_xcdb_m_t)
#                     LET g_log2 = util.JSON.stringify(g_xcdb_m)
#                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                        CALL s_transaction_end('N','0')
#                     ELSE
#                        CALL s_transaction_end('Y','0')
#                     END IF
#               END CASE
#            END IF
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
   CALL axct305_02_ins_excel(g_xcdb_m.dir)
   CALL s_transaction_end('Y','0')
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct305_02_reproduce()
   DEFINE l_newno     LIKE xcdb_t.xcdbld 
   DEFINE l_oldno     LIKE xcdb_t.xcdbld 
   DEFINE l_newno02     LIKE xcdb_t.xcdb001 
   DEFINE l_oldno02     LIKE xcdb_t.xcdb001 
   DEFINE l_newno03     LIKE xcdb_t.xcdb002 
   DEFINE l_oldno03     LIKE xcdb_t.xcdb002 
   DEFINE l_newno04     LIKE xcdb_t.xcdb003 
   DEFINE l_oldno04     LIKE xcdb_t.xcdb003 
   DEFINE l_newno05     LIKE xcdb_t.xcdb004 
   DEFINE l_oldno05     LIKE xcdb_t.xcdb004 
   DEFINE l_newno06     LIKE xcdb_t.xcdb005 
   DEFINE l_oldno06     LIKE xcdb_t.xcdb005 
   DEFINE l_newno07     LIKE xcdb_t.xcdb006 
   DEFINE l_oldno07     LIKE xcdb_t.xcdb006 
   DEFINE l_newno08     LIKE xcdb_t.xcdb007 
   DEFINE l_oldno08     LIKE xcdb_t.xcdb007 
   DEFINE l_newno09     LIKE xcdb_t.xcdb008 
   DEFINE l_oldno09     LIKE xcdb_t.xcdb008 
   DEFINE l_newno10     LIKE xcdb_t.xcdb009 
   DEFINE l_oldno10     LIKE xcdb_t.xcdb009 
   DEFINE l_newno11     LIKE xcdb_t.xcdb010 
   DEFINE l_oldno11     LIKE xcdb_t.xcdb010 
 
   DEFINE l_master    RECORD LIKE xcdb_t.*
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define

   #end add-point   
   
   #切換畫面
   
   #先確定key值無遺漏
#   IF g_xcdb_m.xcdbld IS NULL
#      OR g_xcdb_m.xcdb001 IS NULL
#      OR g_xcdb_m.xcdb002 IS NULL
#      OR g_xcdb_m.xcdb003 IS NULL
#      OR g_xcdb_m.xcdb004 IS NULL
#      OR g_xcdb_m.xcdb005 IS NULL
#      OR g_xcdb_m.xcdb006 IS NULL
#      OR g_xcdb_m.xcdb007 IS NULL
#      OR g_xcdb_m.xcdb008 IS NULL
#      OR g_xcdb_m.xcdb009 IS NULL
#      OR g_xcdb_m.xcdb010 IS NULL
# 
#   THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "std-00003" 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
# 
#      RETURN
#   END IF
   
   #備份key值
#   LET g_xcdbld_t = g_xcdb_m.xcdbld
#   LET g_xcdb001_t = g_xcdb_m.xcdb001
#   LET g_xcdb002_t = g_xcdb_m.xcdb002
#   LET g_xcdb003_t = g_xcdb_m.xcdb003
#   LET g_xcdb004_t = g_xcdb_m.xcdb004
#   LET g_xcdb005_t = g_xcdb_m.xcdb005
#   LET g_xcdb006_t = g_xcdb_m.xcdb006
#   LET g_xcdb007_t = g_xcdb_m.xcdb007
#   LET g_xcdb008_t = g_xcdb_m.xcdb008
#   LET g_xcdb009_t = g_xcdb_m.xcdb009
#   LET g_xcdb010_t = g_xcdb_m.xcdb010
# 
#   
#   #清空key值
#   LET g_xcdb_m.xcdbld = ""
#   LET g_xcdb_m.xcdb001 = ""
#   LET g_xcdb_m.xcdb002 = ""
#   LET g_xcdb_m.xcdb003 = ""
#   LET g_xcdb_m.xcdb004 = ""
#   LET g_xcdb_m.xcdb005 = ""
#   LET g_xcdb_m.xcdb006 = ""
#   LET g_xcdb_m.xcdb007 = ""
#   LET g_xcdb_m.xcdb008 = ""
#   LET g_xcdb_m.xcdb009 = ""
#   LET g_xcdb_m.xcdb010 = ""
 
    
   CALL axct305_02_set_entry("a")
   CALL axct305_02_set_no_entry("a")
   
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前

   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #資料輸入
   CALL axct305_02_input("r")
 
   #清空key欄位的desc
      LET g_xcdb_m.xcdbld_desc = ''
   DISPLAY BY NAME g_xcdb_m.xcdbld_desc
 
   
   IF INT_FLAG THEN
      #取消
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      INITIALIZE g_xcdb_m.* TO NULL
      CALL axct305_02_show()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前

   #end add-point
   
   #add-point:單頭複製中

   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdb_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後

   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #將新增的資料併入搜尋條件中
   #LET g_state = "Y"
   
#   LET g_xcdbld_t = g_xcdb_m.xcdbld
#   LET g_xcdb001_t = g_xcdb_m.xcdb001
#   LET g_xcdb002_t = g_xcdb_m.xcdb002
#   LET g_xcdb003_t = g_xcdb_m.xcdb003
#   LET g_xcdb004_t = g_xcdb_m.xcdb004
#   LET g_xcdb005_t = g_xcdb_m.xcdb005
#   LET g_xcdb006_t = g_xcdb_m.xcdb006
#   LET g_xcdb007_t = g_xcdb_m.xcdb007
#   LET g_xcdb008_t = g_xcdb_m.xcdb008
#   LET g_xcdb009_t = g_xcdb_m.xcdb009
#   LET g_xcdb010_t = g_xcdb_m.xcdb010
# 
#   
#   LET g_current_idx = g_browser.getLength() + 1
#   LET g_browser[g_current_idx].b_xcdbld = g_xcdb_m.xcdbld
#   LET g_browser[g_current_idx].b_xcdb001 = g_xcdb_m.xcdb001
#   LET g_browser[g_current_idx].b_xcdb002 = g_xcdb_m.xcdb002
#   LET g_browser[g_current_idx].b_xcdb003 = g_xcdb_m.xcdb003
#   LET g_browser[g_current_idx].b_xcdb004 = g_xcdb_m.xcdb004
#   LET g_browser[g_current_idx].b_xcdb005 = g_xcdb_m.xcdb005
#   LET g_browser[g_current_idx].b_xcdb006 = g_xcdb_m.xcdb006
#   LET g_browser[g_current_idx].b_xcdb007 = g_xcdb_m.xcdb007
#   LET g_browser[g_current_idx].b_xcdb008 = g_xcdb_m.xcdb008
#   LET g_browser[g_current_idx].b_xcdb009 = g_xcdb_m.xcdb009
#   LET g_browser[g_current_idx].b_xcdb010 = g_xcdb_m.xcdb010
 
   
   LET g_current_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_current_cnt)
   
   #LET g_wc = "(",g_wc,  
   #           " OR (",
   #           " xcdbld = '", g_xcdb_m.xcdbld CLIPPED, "' "
   #           ," AND xcdb001 = '", g_xcdb_m.xcdb001 CLIPPED, "' "
   #           ," AND xcdb002 = '", g_xcdb_m.xcdb002 CLIPPED, "' "
   #           ," AND xcdb003 = '", g_xcdb_m.xcdb003 CLIPPED, "' "
   #           ," AND xcdb004 = '", g_xcdb_m.xcdb004 CLIPPED, "' "
   #           ," AND xcdb005 = '", g_xcdb_m.xcdb005 CLIPPED, "' "
   #           ," AND xcdb006 = '", g_xcdb_m.xcdb006 CLIPPED, "' "
   #           ," AND xcdb007 = '", g_xcdb_m.xcdb007 CLIPPED, "' "
   #           ," AND xcdb008 = '", g_xcdb_m.xcdb008 CLIPPED, "' "
   #           ," AND xcdb009 = '", g_xcdb_m.xcdb009 CLIPPED, "' "
   #           ," AND xcdb010 = '", g_xcdb_m.xcdb010 CLIPPED, "' "
 
   #           , ")) "
   
   #add-point:完成複製段落後

   #end add-point
                   
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.show" >}
#+ 資料顯示 
PRIVATE FUNCTION axct305_02_show()
   #add-point:show段define
   
   #end add-point  
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
   #帶出公用欄位reference值
   
    
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL axct305_02_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbcomp_desc,g_xcdb_m.xcdbld,g_xcdb_m.xcdbld_desc,g_xcdb_m.format, 
       g_xcdb_m.char,g_xcdb_m.dir
   
   #顯示狀態(stus)圖片
   
 
   #add-point:show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION axct305_02_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point  
   
   #先確定key值無遺漏
#   IF g_xcdb_m.xcdbld IS NULL
#   OR g_xcdb_m.xcdb001 IS NULL
#   OR g_xcdb_m.xcdb002 IS NULL
#   OR g_xcdb_m.xcdb003 IS NULL
#   OR g_xcdb_m.xcdb004 IS NULL
#   OR g_xcdb_m.xcdb005 IS NULL
#   OR g_xcdb_m.xcdb006 IS NULL
#   OR g_xcdb_m.xcdb007 IS NULL
#   OR g_xcdb_m.xcdb008 IS NULL
#   OR g_xcdb_m.xcdb009 IS NULL
#   OR g_xcdb_m.xcdb010 IS NULL
# 
#   THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "std-00003" 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#      RETURN
#   END IF
# 
#   CALL s_transaction_begin()
#    
#   LET g_xcdbld_t = g_xcdb_m.xcdbld
#   LET g_xcdb001_t = g_xcdb_m.xcdb001
#   LET g_xcdb002_t = g_xcdb_m.xcdb002
#   LET g_xcdb003_t = g_xcdb_m.xcdb003
#   LET g_xcdb004_t = g_xcdb_m.xcdb004
#   LET g_xcdb005_t = g_xcdb_m.xcdb005
#   LET g_xcdb006_t = g_xcdb_m.xcdb006
#   LET g_xcdb007_t = g_xcdb_m.xcdb007
#   LET g_xcdb008_t = g_xcdb_m.xcdb008
#   LET g_xcdb009_t = g_xcdb_m.xcdb009
#   LET g_xcdb010_t = g_xcdb_m.xcdb010
# 
#   
#   
# 
#   OPEN axct305_02_cl USING g_enterprise,g_xcdb_m.xcdbld,g_xcdb_m.xcdb001,g_xcdb_m.xcdb002,g_xcdb_m.xcdb003,g_xcdb_m.xcdb004,g_xcdb_m.xcdb005,g_xcdb_m.xcdb006,g_xcdb_m.xcdb007,g_xcdb_m.xcdb008,g_xcdb_m.xcdb009,g_xcdb_m.xcdb010
# 
#   IF STATUS THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "OPEN axct305_02_cl:" 
#      LET g_errparam.code   = STATUS 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      CLOSE axct305_02_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
# 
#   #顯示最新的資料
#   EXECUTE axct305_02_master_referesh USING g_xcdb_m.xcdbld,g_xcdb_m.xcdb001,g_xcdb_m.xcdb002,g_xcdb_m.xcdb003, 
#       g_xcdb_m.xcdb004,g_xcdb_m.xcdb005,g_xcdb_m.xcdb006,g_xcdb_m.xcdb007,g_xcdb_m.xcdb008,g_xcdb_m.xcdb009, 
#       g_xcdb_m.xcdb010 INTO g_xcdb_m.xcdbcomp,g_xcdb_m.xcdbld,g_xcdb_m.xcdbcomp_desc,g_xcdb_m.xcdbld_desc 
#
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = g_xcdb_m.xcdbld 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
# 
#      RETURN
#   END IF
#   
#   #將最新資料顯示到畫面上
#   CALL axct305_02_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前

      #end add-point
 
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL axct305_02_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
 
#      DELETE FROM xcdb_t 
#       WHERE xcdbent = g_enterprise AND xcdbld = g_xcdb_m.xcdbld 
#         AND xcdb001 = g_xcdb_m.xcdb001 
#         AND xcdb002 = g_xcdb_m.xcdb002 
#         AND xcdb003 = g_xcdb_m.xcdb003 
#         AND xcdb004 = g_xcdb_m.xcdb004 
#         AND xcdb005 = g_xcdb_m.xcdb005 
#         AND xcdb006 = g_xcdb_m.xcdb006 
#         AND xcdb007 = g_xcdb_m.xcdb007 
#         AND xcdb008 = g_xcdb_m.xcdb008 
#         AND xcdb009 = g_xcdb_m.xcdb009 
#         AND xcdb010 = g_xcdb_m.xcdb010 
 
 
      #add-point:單頭刪除中

      #end add-point
         
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xcdb_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#         CALL s_transaction_end('N','0')
#      END IF
  
      
      
      #add-point:單頭刪除後

      #end add-point
      
          
      CLEAR FORM
      #ALL axct305_02_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         CALL axct305_02_browser_fill(g_wc,"")
         CALL axct305_02_fetch("P")
      ELSE
         CALL axct305_02_browser_fill(" 1=1 ","F")
      END IF
      
   END IF
 
   CLOSE axct305_02_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xcdb_m.xcdbld,"D")
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct305_02_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define

   #end add-point     
 
#   FOR l_i =1 TO g_browser.getLength()
#      IF g_browser[l_i].b_xcdbld = g_xcdb_m.xcdbld
#         AND g_browser[l_i].b_xcdb001 = g_xcdb_m.xcdb001
#         AND g_browser[l_i].b_xcdb002 = g_xcdb_m.xcdb002
#         AND g_browser[l_i].b_xcdb003 = g_xcdb_m.xcdb003
#         AND g_browser[l_i].b_xcdb004 = g_xcdb_m.xcdb004
#         AND g_browser[l_i].b_xcdb005 = g_xcdb_m.xcdb005
#         AND g_browser[l_i].b_xcdb006 = g_xcdb_m.xcdb006
#         AND g_browser[l_i].b_xcdb007 = g_xcdb_m.xcdb007
#         AND g_browser[l_i].b_xcdb008 = g_xcdb_m.xcdb008
#         AND g_browser[l_i].b_xcdb009 = g_xcdb_m.xcdb009
#         AND g_browser[l_i].b_xcdb010 = g_xcdb_m.xcdb010
# 
#         THEN
#         CALL g_browser.deleteElement(l_i)
#         LET g_header_cnt = g_header_cnt - 1
#       END IF
#   END FOR
   
   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct305_02_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define

   #end add-point     
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("xcdbld,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,xcdb008,xcdb009,xcdb010",TRUE)
      #add-point:set_entry段欄位控制

      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct305_02_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define

   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcdbld,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,xcdb008,xcdb009,xcdb010",FALSE)
      #add-point:set_no_entry段欄位控制

      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct305_02_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define

   #end add-point  
   
   #add-point:default_search段開始前

   #end add-point  
 
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcdbld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcdb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcdb002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcdb003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcdb004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xcdb005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " xcdb006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " xcdb007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " xcdb008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET ls_wc = ls_wc, " xcdb009 = '", g_argv[10], "' AND "
   END IF
   IF NOT cl_null(g_argv[11]) THEN
      LET ls_wc = ls_wc, " xcdb010 = '", g_argv[11], "' AND "
   END IF
 
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=1
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前

   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axct305_02.state_change" >}
   
 
{</section>}
 
{<section id="axct305_02.signature" >}
   
 
{</section>}
 
{<section id="axct305_02.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axct305_02_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
#   CALL g_pk_array.clear()
#   LET g_pk_array[1].values = g_xcdb_m.xcdbld
#   LET g_pk_array[1].column = 'xcdbld'
#   LET g_pk_array[2].values = g_xcdb_m.xcdb001
#   LET g_pk_array[2].column = 'xcdb001'
#   LET g_pk_array[3].values = g_xcdb_m.xcdb002
#   LET g_pk_array[3].column = 'xcdb002'
#   LET g_pk_array[4].values = g_xcdb_m.xcdb003
#   LET g_pk_array[4].column = 'xcdb003'
#   LET g_pk_array[5].values = g_xcdb_m.xcdb004
#   LET g_pk_array[5].column = 'xcdb004'
#   LET g_pk_array[6].values = g_xcdb_m.xcdb005
#   LET g_pk_array[6].column = 'xcdb005'
#   LET g_pk_array[7].values = g_xcdb_m.xcdb006
#   LET g_pk_array[7].column = 'xcdb006'
#   LET g_pk_array[8].values = g_xcdb_m.xcdb007
#   LET g_pk_array[8].column = 'xcdb007'
#   LET g_pk_array[9].values = g_xcdb_m.xcdb008
#   LET g_pk_array[9].column = 'xcdb008'
#   LET g_pk_array[10].values = g_xcdb_m.xcdb009
#   LET g_pk_array[10].column = 'xcdb009'
#   LET g_pk_array[11].values = g_xcdb_m.xcdb010
#   LET g_pk_array[11].column = 'xcdb010'
   
   #add-point:set_pk_array段之後

   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axct305_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axct305_02.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axct305_02_ins_excel(p_excelname)
DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlapp,iRes,iRow    LIKE type_t.num5
#161109-00085#23-s mod
#DEFINE l_xcdb      RECORD LIKE xcdb_t.*   #161109-00085#23-s mark
DEFINE l_xcdb      RECORD  #在製成本要素成本期初開帳檔
       xcdbent LIKE xcdb_t.xcdbent, #企業編號
       xcdbld LIKE xcdb_t.xcdbld, #帳套
       xcdbcomp LIKE xcdb_t.xcdbcomp, #法人組織
       xcdb001 LIKE xcdb_t.xcdb001, #帳套本位幣順序
       xcdb002 LIKE xcdb_t.xcdb002, #成本域
       xcdb003 LIKE xcdb_t.xcdb003, #成本計算類型
       xcdb004 LIKE xcdb_t.xcdb004, #年度
       xcdb005 LIKE xcdb_t.xcdb005, #期別
       xcdb006 LIKE xcdb_t.xcdb006, #工單編號
       xcdb007 LIKE xcdb_t.xcdb007, #元件編號
       xcdb008 LIKE xcdb_t.xcdb008, #特性
       xcdb009 LIKE xcdb_t.xcdb009, #批號
       xcdb010 LIKE xcdb_t.xcdb010, #成本次要素
       xcdb011 LIKE xcdb_t.xcdb011, #元件類型
       xcdb101 LIKE xcdb_t.xcdb101, #當月期末數量
       xcdb102 LIKE xcdb_t.xcdb102, #當月期末金額-金額合計
       xcdbownid LIKE xcdb_t.xcdbownid, #資料所有者
       xcdbowndp LIKE xcdb_t.xcdbowndp, #資料所屬部門
       xcdbcrtid LIKE xcdb_t.xcdbcrtid, #資料建立者
       xcdbcrtdp LIKE xcdb_t.xcdbcrtdp, #資料建立部門
       xcdbcrtdt LIKE xcdb_t.xcdbcrtdt, #資料創建日
       xcdbmodid LIKE xcdb_t.xcdbmodid, #資料修改者
       xcdbmoddt LIKE xcdb_t.xcdbmoddt, #最近修改日
       xcdbcnfid LIKE xcdb_t.xcdbcnfid, #資料確認者
       xcdbcnfdt LIKE xcdb_t.xcdbcnfdt, #資料確認日
       xcdbpstid LIKE xcdb_t.xcdbpstid, #資料過帳者
       xcdbpstdt LIKE xcdb_t.xcdbpstdt, #資料過帳日
       xcdbstus LIKE xcdb_t.xcdbstus, #狀態碼
       xcdbud001 LIKE xcdb_t.xcdbud001, #自定義欄位(文字)001
       xcdbud002 LIKE xcdb_t.xcdbud002, #自定義欄位(文字)002
       xcdbud003 LIKE xcdb_t.xcdbud003, #自定義欄位(文字)003
       xcdbud004 LIKE xcdb_t.xcdbud004, #自定義欄位(文字)004
       xcdbud005 LIKE xcdb_t.xcdbud005, #自定義欄位(文字)005
       xcdbud006 LIKE xcdb_t.xcdbud006, #自定義欄位(文字)006
       xcdbud007 LIKE xcdb_t.xcdbud007, #自定義欄位(文字)007
       xcdbud008 LIKE xcdb_t.xcdbud008, #自定義欄位(文字)008
       xcdbud009 LIKE xcdb_t.xcdbud009, #自定義欄位(文字)009
       xcdbud010 LIKE xcdb_t.xcdbud010, #自定義欄位(文字)010
       xcdbud011 LIKE xcdb_t.xcdbud011, #自定義欄位(數字)011
       xcdbud012 LIKE xcdb_t.xcdbud012, #自定義欄位(數字)012
       xcdbud013 LIKE xcdb_t.xcdbud013, #自定義欄位(數字)013
       xcdbud014 LIKE xcdb_t.xcdbud014, #自定義欄位(數字)014
       xcdbud015 LIKE xcdb_t.xcdbud015, #自定義欄位(數字)015
       xcdbud016 LIKE xcdb_t.xcdbud016, #自定義欄位(數字)016
       xcdbud017 LIKE xcdb_t.xcdbud017, #自定義欄位(數字)017
       xcdbud018 LIKE xcdb_t.xcdbud018, #自定義欄位(數字)018
       xcdbud019 LIKE xcdb_t.xcdbud019, #自定義欄位(數字)019
       xcdbud020 LIKE xcdb_t.xcdbud020, #自定義欄位(數字)020
       xcdbud021 LIKE xcdb_t.xcdbud021, #自定義欄位(日期時間)021
       xcdbud022 LIKE xcdb_t.xcdbud022, #自定義欄位(日期時間)022
       xcdbud023 LIKE xcdb_t.xcdbud023, #自定義欄位(日期時間)023
       xcdbud024 LIKE xcdb_t.xcdbud024, #自定義欄位(日期時間)024
       xcdbud025 LIKE xcdb_t.xcdbud025, #自定義欄位(日期時間)025
       xcdbud026 LIKE xcdb_t.xcdbud026, #自定義欄位(日期時間)026
       xcdbud027 LIKE xcdb_t.xcdbud027, #自定義欄位(日期時間)027
       xcdbud028 LIKE xcdb_t.xcdbud028, #自定義欄位(日期時間)028
       xcdbud029 LIKE xcdb_t.xcdbud029, #自定義欄位(日期時間)029
       xcdbud030 LIKE xcdb_t.xcdbud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#23-e mod
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_n         LIKE type_t.num5
#161109-00085#23-s mod
#DEFINE l_xcdb1      RECORD LIKE xcdb_t.*   #161109-00085#23-s mark
DEFINE l_xcdb1      RECORD  #在製成本要素成本期初開帳檔
       xcdbent LIKE xcdb_t.xcdbent, #企業編號
       xcdbld LIKE xcdb_t.xcdbld, #帳套
       xcdbcomp LIKE xcdb_t.xcdbcomp, #法人組織
       xcdb001 LIKE xcdb_t.xcdb001, #帳套本位幣順序
       xcdb002 LIKE xcdb_t.xcdb002, #成本域
       xcdb003 LIKE xcdb_t.xcdb003, #成本計算類型
       xcdb004 LIKE xcdb_t.xcdb004, #年度
       xcdb005 LIKE xcdb_t.xcdb005, #期別
       xcdb006 LIKE xcdb_t.xcdb006, #工單編號
       xcdb007 LIKE xcdb_t.xcdb007, #元件編號
       xcdb008 LIKE xcdb_t.xcdb008, #特性
       xcdb009 LIKE xcdb_t.xcdb009, #批號
       xcdb010 LIKE xcdb_t.xcdb010, #成本次要素
       xcdb011 LIKE xcdb_t.xcdb011, #元件類型
       xcdb101 LIKE xcdb_t.xcdb101, #當月期末數量
       xcdb102 LIKE xcdb_t.xcdb102, #當月期末金額-金額合計
       xcdbownid LIKE xcdb_t.xcdbownid, #資料所有者
       xcdbowndp LIKE xcdb_t.xcdbowndp, #資料所屬部門
       xcdbcrtid LIKE xcdb_t.xcdbcrtid, #資料建立者
       xcdbcrtdp LIKE xcdb_t.xcdbcrtdp, #資料建立部門
       xcdbcrtdt LIKE xcdb_t.xcdbcrtdt, #資料創建日
       xcdbmodid LIKE xcdb_t.xcdbmodid, #資料修改者
       xcdbmoddt LIKE xcdb_t.xcdbmoddt, #最近修改日
       xcdbcnfid LIKE xcdb_t.xcdbcnfid, #資料確認者
       xcdbcnfdt LIKE xcdb_t.xcdbcnfdt, #資料確認日
       xcdbpstid LIKE xcdb_t.xcdbpstid, #資料過帳者
       xcdbpstdt LIKE xcdb_t.xcdbpstdt, #資料過帳日
       xcdbstus LIKE xcdb_t.xcdbstus  #狀態碼
          END RECORD
#161109-00085#23-e mod
#161109-00085#23-s mod
#DEFINE l_xcdb2      RECORD LIKE xcdb_t.*   #161109-00085#23-s mark
DEFINE l_xcdb2      RECORD  #在製成本要素成本期初開帳檔
       xcdbent LIKE xcdb_t.xcdbent, #企業編號
       xcdbld LIKE xcdb_t.xcdbld, #帳套
       xcdbcomp LIKE xcdb_t.xcdbcomp, #法人組織
       xcdb001 LIKE xcdb_t.xcdb001, #帳套本位幣順序
       xcdb002 LIKE xcdb_t.xcdb002, #成本域
       xcdb003 LIKE xcdb_t.xcdb003, #成本計算類型
       xcdb004 LIKE xcdb_t.xcdb004, #年度
       xcdb005 LIKE xcdb_t.xcdb005, #期別
       xcdb006 LIKE xcdb_t.xcdb006, #工單編號
       xcdb007 LIKE xcdb_t.xcdb007, #元件編號
       xcdb008 LIKE xcdb_t.xcdb008, #特性
       xcdb009 LIKE xcdb_t.xcdb009, #批號
       xcdb010 LIKE xcdb_t.xcdb010, #成本次要素
       xcdb011 LIKE xcdb_t.xcdb011, #元件類型
       xcdb101 LIKE xcdb_t.xcdb101, #當月期末數量
       xcdb102 LIKE xcdb_t.xcdb102, #當月期末金額-金額合計
       xcdbownid LIKE xcdb_t.xcdbownid, #資料所有者
       xcdbowndp LIKE xcdb_t.xcdbowndp, #資料所屬部門
       xcdbcrtid LIKE xcdb_t.xcdbcrtid, #資料建立者
       xcdbcrtdp LIKE xcdb_t.xcdbcrtdp, #資料建立部門
       xcdbcrtdt LIKE xcdb_t.xcdbcrtdt, #資料創建日
       xcdbmodid LIKE xcdb_t.xcdbmodid, #資料修改者
       xcdbmoddt LIKE xcdb_t.xcdbmoddt, #最近修改日
       xcdbcnfid LIKE xcdb_t.xcdbcnfid, #資料確認者
       xcdbcnfdt LIKE xcdb_t.xcdbcnfdt, #資料確認日
       xcdbpstid LIKE xcdb_t.xcdbpstid, #資料過帳者
       xcdbpstdt LIKE xcdb_t.xcdbpstdt, #資料過帳日
       xcdbstus LIKE xcdb_t.xcdbstus  #狀態碼
          END RECORD
#161109-00085#23-e mod
DEFINE l_success   LIKE type_t.num5
DEFINE l_xcdb102_2  LIKE xcdb_t.xcdb102
DEFINE l_xcdb102_3  LIKE xcdb_t.xcdb102

   WHENEVER ERROR CONTINUE
   LET l_success = TRUE
   LET l_today= cl_get_current()
   LET l_count = LENGTH(p_excelname CLIPPED)
   #转换路径分隔符
   FOR li_i = 1 TO l_count
       IF p_excelname[li_i,li_i] ="/" THEN
          LET l_excelname = l_excelname CLIPPED,'\\'
       ELSE
          LET l_excelname = l_excelname CLIPPED,p_excelname[li_i,li_i]
       END IF
   END FOR

   CALL ui.interface.frontCall('WinCOM','CreateInstance',
                               ['Excel.Application'],[xlApp])
   IF xlApp <> -1 THEN
      CALL ui.interface.frontCall('WinCOM','CallMethod',
                                  [xlApp,'WorkBooks.Open',l_excelname],[iRes])
      IF iRes <> -1 THEN
         CALL ui.interface.frontCall('WinCOM','GetProperty',
              [xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
         IF iRow > 1 THEN
            FOR li_i = 2 TO iRow
                INITIALIZE l_xcdb.* TO NULL
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_xcdb.xcdbent])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_xcdb.xcdbcomp])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_xcdb.xcdbld])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_xcdb.xcdb004])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_xcdb.xcdb005])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_xcdb.xcdb003])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_xcdb.xcdb006])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_xcdb.xcdb007])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_xcdb.xcdb008])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_xcdb.xcdb009])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_xcdb.xcdb011])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_xcdb.xcdb010]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_xcdb.xcdb002])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_xcdb.xcdb101])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_xcdb.xcdb102])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_xcdb102_2]) 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_xcdb102_3]) 
                
                #如果excel中存在不在畫面上的法人或者帳套CONTINUE
                IF l_xcdb.xcdbld != g_xcdb_m.xcdbld OR l_xcdb.xcdbcomp != g_xcdb_m.xcdbcomp THEN
                  #CONTINUE FOR
                  #匯出畫面中帳套不一致的，提示檢核訊息，不予新增
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'axc-00514'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET l_success = FALSE
                   EXIT FOR
                END IF
                

                IF l_xcdb.xcdb009 IS NULL THEN  #批号可录入为空
                   LET l_xcdb.xcdb009 = ' '
                END IF
                IF l_xcdb.xcdb008 IS NULL THEN  #特性可录入为空
                   LET l_xcdb.xcdb008 = ' '
                END IF                
                #本位幣一   
                IF l_xcdb.xcdb102 IS NOT NULL THEN
                   LET l_xcdb.xcdb001 = '1'
                   #161109-00085#23-s mod
#                   INSERT INTO xcdb_t VALUES l_xcdb.*   #161109-00085#23-s mark
                   INSERT INTO xcdb_t (xcdbent,xcdbld,xcdbcomp,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,
                                       xcdb008,xcdb009,xcdb010,xcdb011,xcdb101,xcdb102,xcdbownid,xcdbowndp,xcdbcrtid,xcdbcrtdp,
                                       xcdbcrtdt,xcdbmodid,xcdbmoddt,xcdbcnfid,xcdbcnfdt,xcdbpstid,xcdbpstdt,xcdbstus,xcdbud001,xcdbud002,
                                       xcdbud003,xcdbud004,xcdbud005,xcdbud006,xcdbud007,xcdbud008,xcdbud009,xcdbud010,xcdbud011,xcdbud012,
                                       xcdbud013,xcdbud014,xcdbud015,xcdbud016,xcdbud017,xcdbud018,xcdbud019,xcdbud020,xcdbud021,xcdbud022,
                                       xcdbud023,xcdbud024,xcdbud025,xcdbud026,xcdbud027,xcdbud028,xcdbud029,xcdbud030) 
                               VALUES (l_xcdb.xcdbent,l_xcdb.xcdbld,l_xcdb.xcdbcomp,l_xcdb.xcdb001,l_xcdb.xcdb002,
                                       l_xcdb.xcdb003,l_xcdb.xcdb004,l_xcdb.xcdb005,l_xcdb.xcdb006,l_xcdb.xcdb007,
                                       l_xcdb.xcdb008,l_xcdb.xcdb009,l_xcdb.xcdb010,l_xcdb.xcdb011,l_xcdb.xcdb101,
                                       l_xcdb.xcdb102,l_xcdb.xcdbownid,l_xcdb.xcdbowndp,l_xcdb.xcdbcrtid,l_xcdb.xcdbcrtdp,
                                       l_xcdb.xcdbcrtdt,l_xcdb.xcdbmodid,l_xcdb.xcdbmoddt,l_xcdb.xcdbcnfid,l_xcdb.xcdbcnfdt,
                                       l_xcdb.xcdbpstid,l_xcdb.xcdbpstdt,l_xcdb.xcdbstus,l_xcdb.xcdbud001,l_xcdb.xcdbud002,
                                       l_xcdb.xcdbud003,l_xcdb.xcdbud004,l_xcdb.xcdbud005,l_xcdb.xcdbud006,l_xcdb.xcdbud007,
                                       l_xcdb.xcdbud008,l_xcdb.xcdbud009,l_xcdb.xcdbud010,l_xcdb.xcdbud011,l_xcdb.xcdbud012,
                                       l_xcdb.xcdbud013,l_xcdb.xcdbud014,l_xcdb.xcdbud015,l_xcdb.xcdbud016,l_xcdb.xcdbud017,
                                       l_xcdb.xcdbud018,l_xcdb.xcdbud019,l_xcdb.xcdbud020,l_xcdb.xcdbud021,l_xcdb.xcdbud022,
                                       l_xcdb.xcdbud023,l_xcdb.xcdbud024,l_xcdb.xcdbud025,l_xcdb.xcdbud026,l_xcdb.xcdbud027,
                                       l_xcdb.xcdbud028,l_xcdb.xcdbud029,l_xcdb.xcdbud030)
                   #161109-00085#23-e mod
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins xcdb'
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET l_success = FALSE
                      EXIT FOR
                   END IF
                END IF
                #本位幣二  
                IF l_xcdb102_2 IS NOT NULL THEN
                   LET l_xcdb.xcdb001 = '2'
                   LET l_xcdb.xcdb102 = l_xcdb102_2
                   #161109-00085#23-s mod
#                   INSERT INTO xcdb_t VALUES l_xcdb.*   #161109-00085#23-s mark
                   INSERT INTO xcdb_t (xcdbent,xcdbld,xcdbcomp,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,
                                       xcdb008,xcdb009,xcdb010,xcdb011,xcdb101,xcdb102,xcdbownid,xcdbowndp,xcdbcrtid,xcdbcrtdp,
                                       xcdbcrtdt,xcdbmodid,xcdbmoddt,xcdbcnfid,xcdbcnfdt,xcdbpstid,xcdbpstdt,xcdbstus,xcdbud001,xcdbud002,
                                       xcdbud003,xcdbud004,xcdbud005,xcdbud006,xcdbud007,xcdbud008,xcdbud009,xcdbud010,xcdbud011,xcdbud012,
                                       xcdbud013,xcdbud014,xcdbud015,xcdbud016,xcdbud017,xcdbud018,xcdbud019,xcdbud020,xcdbud021,xcdbud022,
                                       xcdbud023,xcdbud024,xcdbud025,xcdbud026,xcdbud027,xcdbud028,xcdbud029,xcdbud030) 
                               VALUES (l_xcdb.xcdbent,l_xcdb.xcdbld,l_xcdb.xcdbcomp,l_xcdb.xcdb001,l_xcdb.xcdb002,
                                       l_xcdb.xcdb003,l_xcdb.xcdb004,l_xcdb.xcdb005,l_xcdb.xcdb006,l_xcdb.xcdb007,
                                       l_xcdb.xcdb008,l_xcdb.xcdb009,l_xcdb.xcdb010,l_xcdb.xcdb011,l_xcdb.xcdb101,
                                       l_xcdb.xcdb102,l_xcdb.xcdbownid,l_xcdb.xcdbowndp,l_xcdb.xcdbcrtid,l_xcdb.xcdbcrtdp,
                                       l_xcdb.xcdbcrtdt,l_xcdb.xcdbmodid,l_xcdb.xcdbmoddt,l_xcdb.xcdbcnfid,l_xcdb.xcdbcnfdt,
                                       l_xcdb.xcdbpstid,l_xcdb.xcdbpstdt,l_xcdb.xcdbstus,l_xcdb.xcdbud001,l_xcdb.xcdbud002,
                                       l_xcdb.xcdbud003,l_xcdb.xcdbud004,l_xcdb.xcdbud005,l_xcdb.xcdbud006,l_xcdb.xcdbud007,
                                       l_xcdb.xcdbud008,l_xcdb.xcdbud009,l_xcdb.xcdbud010,l_xcdb.xcdbud011,l_xcdb.xcdbud012,
                                       l_xcdb.xcdbud013,l_xcdb.xcdbud014,l_xcdb.xcdbud015,l_xcdb.xcdbud016,l_xcdb.xcdbud017,
                                       l_xcdb.xcdbud018,l_xcdb.xcdbud019,l_xcdb.xcdbud020,l_xcdb.xcdbud021,l_xcdb.xcdbud022,
                                       l_xcdb.xcdbud023,l_xcdb.xcdbud024,l_xcdb.xcdbud025,l_xcdb.xcdbud026,l_xcdb.xcdbud027,
                                       l_xcdb.xcdbud028,l_xcdb.xcdbud029,l_xcdb.xcdbud030)
                   #161109-00085#23-e mod
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins xcdb'
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET l_success = FALSE
                      EXIT FOR
                   END IF
                END IF
                #本位幣三  
                IF l_xcdb102_3 IS NOT NULL THEN
                   LET l_xcdb.xcdb001 = '3'
                   LET l_xcdb.xcdb102 = l_xcdb102_3
                   #161109-00085#23-s mod
#                   INSERT INTO xcdb_t VALUES l_xcdb.*   #161109-00085#23-s mark
                   INSERT INTO xcdb_t (xcdbent,xcdbld,xcdbcomp,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,
                                       xcdb008,xcdb009,xcdb010,xcdb011,xcdb101,xcdb102,xcdbownid,xcdbowndp,xcdbcrtid,xcdbcrtdp,
                                       xcdbcrtdt,xcdbmodid,xcdbmoddt,xcdbcnfid,xcdbcnfdt,xcdbpstid,xcdbpstdt,xcdbstus,xcdbud001,xcdbud002,
                                       xcdbud003,xcdbud004,xcdbud005,xcdbud006,xcdbud007,xcdbud008,xcdbud009,xcdbud010,xcdbud011,xcdbud012,
                                       xcdbud013,xcdbud014,xcdbud015,xcdbud016,xcdbud017,xcdbud018,xcdbud019,xcdbud020,xcdbud021,xcdbud022,
                                       xcdbud023,xcdbud024,xcdbud025,xcdbud026,xcdbud027,xcdbud028,xcdbud029,xcdbud030) 
                               VALUES (l_xcdb.xcdbent,l_xcdb.xcdbld,l_xcdb.xcdbcomp,l_xcdb.xcdb001,l_xcdb.xcdb002,
                                       l_xcdb.xcdb003,l_xcdb.xcdb004,l_xcdb.xcdb005,l_xcdb.xcdb006,l_xcdb.xcdb007,
                                       l_xcdb.xcdb008,l_xcdb.xcdb009,l_xcdb.xcdb010,l_xcdb.xcdb011,l_xcdb.xcdb101,
                                       l_xcdb.xcdb102,l_xcdb.xcdbownid,l_xcdb.xcdbowndp,l_xcdb.xcdbcrtid,l_xcdb.xcdbcrtdp,
                                       l_xcdb.xcdbcrtdt,l_xcdb.xcdbmodid,l_xcdb.xcdbmoddt,l_xcdb.xcdbcnfid,l_xcdb.xcdbcnfdt,
                                       l_xcdb.xcdbpstid,l_xcdb.xcdbpstdt,l_xcdb.xcdbstus,l_xcdb.xcdbud001,l_xcdb.xcdbud002,
                                       l_xcdb.xcdbud003,l_xcdb.xcdbud004,l_xcdb.xcdbud005,l_xcdb.xcdbud006,l_xcdb.xcdbud007,
                                       l_xcdb.xcdbud008,l_xcdb.xcdbud009,l_xcdb.xcdbud010,l_xcdb.xcdbud011,l_xcdb.xcdbud012,
                                       l_xcdb.xcdbud013,l_xcdb.xcdbud014,l_xcdb.xcdbud015,l_xcdb.xcdbud016,l_xcdb.xcdbud017,
                                       l_xcdb.xcdbud018,l_xcdb.xcdbud019,l_xcdb.xcdbud020,l_xcdb.xcdbud021,l_xcdb.xcdbud022,
                                       l_xcdb.xcdbud023,l_xcdb.xcdbud024,l_xcdb.xcdbud025,l_xcdb.xcdbud026,l_xcdb.xcdbud027,
                                       l_xcdb.xcdbud028,l_xcdb.xcdbud029,l_xcdb.xcdbud030)
                   #161109-00085#23-e mod
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins xcdb'
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET l_success = FALSE
                      EXIT FOR
                   END IF
                END IF
            END FOR
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00387'
         LET g_errparam.extend = ''   #NO FILE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00387'
      LET g_errparam.extend = ''  #NO EXCEL
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF

   IF l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00253'
      LET g_errparam.extend = '' 
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      LET g_action_choice= 'exit'
      CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
      CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])   
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = '' 
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      LET g_action_choice= 'exit'
      CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
      CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes]) 
   END IF
END FUNCTION

 
{</section>}
 
