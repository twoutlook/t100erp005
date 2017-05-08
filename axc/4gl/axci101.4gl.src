#該程式已解開Section, 不再透過樣板產出!
{<section id="axci101.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000044
#+ 
#+ Filename...: axci101
#+ Description: 
#+ Creator....: 03297(2014/07/30)
#+ Modifier...: 03297(2014/08/01) -SD/PR- 05599
#+ Buildtype..: 應用 i07 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axci101.global" >}
#160318-00025#8   16/04/21 By 07675  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160728-00025#2   16/08/10 By 02040  新加上標準成本分類欄位 
#161108-00013#1   16/11/08 By 07024  與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
#161222-00049#1   16/12/26 By charles4m 判斷若單頭歸屬法人的 S-FIN-6001 參數有啟用， [成本域類型] 為必填
 
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
PRIVATE type type_g_xcaz_m        RECORD
       xcazld LIKE xcaz_t.xcazld, 
   xcazld_desc LIKE type_t.chr80, 
   glaa014 LIKE type_t.chr500, 
   glaacomp LIKE type_t.chr80, 
   glaacomp_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcaz_d        RECORD
       xcazld LIKE xcaz_t.xcazld, 
   xcazstus LIKE xcaz_t.xcazstus, 
   xcaz001 LIKE xcaz_t.xcaz001, 
   xcazl003 LIKE xcazl_t.xcazl003, 
   xcaz002 LIKE xcaz_t.xcaz002, 
   xcaz003 LIKE xcaz_t.xcaz003, 
   xcaz004 LIKE xcaz_t.xcaz004, 
   xcaz005 LIKE xcaz_t.xcaz005, 
   xcaz006 LIKE xcaz_t.xcaz006, 
   xcaz010 LIKE xcaz_t.xcaz010,    #20150603 By dujuan add -- xcaz010 LIKE xcaz_t.xcaz010,
   xcaz011 LIKE xcaz_t.xcaz011,    #160728-00025#2 add
   xcaz011_desc LIKE type_t.chr80, #160728-00025#2 add
   xcaz009 LIKE xcaz_t.xcaz009, 
   xcaul003 LIKE xcaul_t.xcaul003,
   xcaz007 LIKE xcaz_t.xcaz007, 
   xcaz008 LIKE xcaz_t.xcaz008
       END RECORD
PRIVATE TYPE type_g_xcaz2_d RECORD
       xcaz001 LIKE xcaz_t.xcaz001, 
   xcazownid LIKE xcaz_t.xcazownid, 
   xcazownid_desc LIKE type_t.chr500, 
   xcazowndp LIKE xcaz_t.xcazowndp, 
   xcazowndp_desc LIKE type_t.chr500, 
   xcazcrtid LIKE xcaz_t.xcazcrtid, 
   xcazcrtid_desc LIKE type_t.chr500, 
   xcazcrtdp LIKE xcaz_t.xcazcrtdp, 
   xcazcrtdp_desc LIKE type_t.chr500, 
   xcazcrtdt DATETIME YEAR TO SECOND, 
   xcazmodid LIKE xcaz_t.xcazmodid, 
   xcazmodid_desc LIKE type_t.chr500, 
   xcazmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      xcazl001 LIKE xcazl_t.xcazl001,
      xcazl002 LIKE xcazl_t.xcazl002,
      xcazl003 LIKE xcazl_t.xcazl003
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_xcaz_m          type_g_xcaz_m
DEFINE g_xcaz_m_t        type_g_xcaz_m
DEFINE g_xcaz_m_o        type_g_xcaz_m
 
   DEFINE g_xcazld_t LIKE xcaz_t.xcazld
 
 
DEFINE g_xcaz_d          DYNAMIC ARRAY OF type_g_xcaz_d
DEFINE g_xcaz_d_t        type_g_xcaz_d
DEFINE g_xcaz_d_o        type_g_xcaz_d
DEFINE g_xcaz2_d   DYNAMIC ARRAY OF type_g_xcaz2_d
DEFINE g_xcaz2_d_t type_g_xcaz2_d
DEFINE g_xcaz2_d_o type_g_xcaz2_d
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcazld LIKE xcaz_t.xcazld
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
#161108-00013#1-s-mod
#DEFINE g_no_ask              LIKE type_t.num5        
#DEFINE g_rec_b               LIKE type_t.num5           
#DEFINE l_ac                  LIKE type_t.num5    
#DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
# 
#DEFINE g_pagestart           LIKE type_t.num5           
#DEFINE gwin_curr             ui.Window                     #Current Window
#DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_page_action         STRING                        #page action
#DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
#DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
#DEFINE g_page                STRING                        #第幾頁
#DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
# 
#DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
#DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數  
#DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
# 
#DEFINE g_searchcol           STRING                        #查詢欄位代碼
#DEFINE g_searchstr           STRING                        #查詢欄位字串
#DEFINE g_order               STRING                        #查詢排序欄位
#DEFINE g_state               STRING                        
#DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
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
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數
#161108-00013#1-e-mod
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_forupd_sql_lang     STRING
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axci101.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xcazld,'','','',''", 
                      " FROM xcaz_t",
                      " WHERE xcazent= ? AND xcazld=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci101_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xcazld,t1.glaal002",
               " FROM xcaz_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent='"||g_enterprise||"' AND t1.glaalld=t0.xcazld AND t1.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.xcazent = '" ||g_enterprise|| "' AND t0.xcazld = ?"
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axci101_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axci101 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axci101_init()   
 
      #進入選單 Menu (="N")
      CALL axci101_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axci101
      
   END IF 
   
   CLOSE axci101_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axci101.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axci101_init()
   #add-point:init段define
   
   #end add-point    
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xcaz002','8903') 
   CALL cl_set_combo_scc('xcaz003','8904') 
   CALL cl_set_combo_scc('xcaz004','8905') 
   CALL cl_set_combo_scc('xcaz005','8911') 
   CALL cl_set_combo_scc('xcaz006','8907') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
 
   #end add-point
   
   CALL axci101_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axci101.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axci101_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define
   
   #end add-point  
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   
   #add-point:ui_dialog段before dialog 
   
   
   #end add-point
   
   WHILE TRUE
   
      CALL axci101_browser_fill("")
 
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_xcazld = g_xcazld_t
 
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcaz_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axci101_ui_detailshow()
               
               #add-point:page1自定義行為
               
               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_xcaz2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axci101_ui_detailshow()
               
               #add-point:page1自定義行為
               
               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         
         #end add-point
         
         
         BEFORE DIALOG
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
               CALL axci101_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axci101_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2
            
            #end add-point
 
         
         
         ON ACTION first
            CALL axci101_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL axci101_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL axci101_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL axci101_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL axci101_fetch('L')
            LET g_current_row = g_current_idx
          
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
               NEXT FIELD xcaz001
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
               CALL axci101_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axci101_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL axci101_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axci101_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axci101_modify()
               #add-point:ON ACTION modify_detail
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axci101_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axci101_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axci101_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axci101_query()
               #add-point:ON ACTION query
               
               #END add-point
               
            END IF
 
 
         
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axci101_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axci101_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axci101_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="axci101.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axci101_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define
   
   #end add-point    
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "searchcol" 
      LET g_errparam.code   = "std-00005" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF 
   
   IF NOT cl_null(g_searchstr) THEN
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1"
   END IF         
   
   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY xcazld"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL axci101_browser_fill("F")
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axci101_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   
   #end add-point    
   
   #add-point:browser_fill段動作開始前
   
   #end add-point    
   
   CALL g_browser.clear()
 
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "xcazld"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
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
      LET l_sub_sql = " SELECT UNIQUE xcazld ",
 
                      " FROM xcaz_t ",
                      " ",
                      " LEFT JOIN xcazl_t ON xcaz001 = xcazl001 AND xcazl002 = '",g_dlang,"' ",
 
                      " WHERE xcazent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcaz_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcazld ",
 
                      " FROM xcaz_t ",
                      " ",
                      " LEFT JOIN xcazl_t ON xcaz001 = xcazl001 AND xcazl002 = '",g_dlang,"' ",
                      " WHERE xcazent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcaz_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前
   
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
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
   LET g_error_show = 0
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #依照t0.xcazld Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcazld",
                " FROM xcaz_t t0",
 
                
                " WHERE t0.xcazent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcaz_t")
 
   #add-point:browser_fill,sql_rank前
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcaz_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_xcazld 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
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
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcaz_m.* TO NULL
      CALL g_xcaz_d.clear()
      CALL g_xcaz2_d.clear()
 
      #add-point:browser_fill段after_clear
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
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
 
{<section id="axci101.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axci101_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_xcaz_m.xcazld = g_browser[g_current_idx].b_xcazld   
 
   EXECUTE axci101_master_referesh USING g_xcaz_m.xcazld INTO g_xcaz_m.xcazld,g_xcaz_m.xcazld_desc
   CALL axci101_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axci101_ui_detailshow()
   #add-point:ui_detailshow段define

   #end add-point    
   
   #add-point:ui_detailshow段before

   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more
     
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after

   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axci101_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xcazld = g_xcaz_m.xcazld 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axci101_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcaz_m.* TO NULL
   CALL g_xcaz_d.clear()
   CALL g_xcaz2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外

   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcazld
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
                 #Ctrlp:construct.c.xcazld
         ON ACTION controlp INFIELD xcazld
            #add-point:ON ACTION controlp INFIELD xcazld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcazld  #顯示到畫面上             
            NEXT FIELD xcazld                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazld
            #add-point:BEFORE FIELD xcazld

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazld
            
            #add-point:AFTER FIELD xcazld

            #END add-point
            
 
         #Ctrlp:construct.c.glaacomp
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp
            #此段落由子樣板a08產生
            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001_2()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO glaacomp  #顯示到畫面上
#            NEXT FIELD glaacomp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp
           
            #END add-point
            
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcazstus,xcaz001,xcazl003,xcaz002,xcaz003,xcaz004,xcaz005,xcaz006,xcaz009, 
          xcaz007,xcaz008,xcazownid,xcazowndp,xcazcrtid,xcazcrtdp,xcazcrtdt,xcazmodid,xcazmoddt
           FROM s_detail1[1].xcazstus,s_detail1[1].xcaz001,s_detail1[1].xcazl003,s_detail1[1].xcaz002, 
               s_detail1[1].xcaz003,s_detail1[1].xcaz004,s_detail1[1].xcaz005,s_detail1[1].xcaz006,s_detail1[1].xcaz009, 
               s_detail1[1].xcaz007,s_detail1[1].xcaz008,s_detail2[1].xcazownid,s_detail2[1].xcazowndp, 
               s_detail2[1].xcazcrtid,s_detail2[1].xcazcrtdp,s_detail2[1].xcazcrtdt,s_detail2[1].xcazmodid, 
               s_detail2[1].xcazmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<xcazcrtdt>>----
         AFTER FIELD xcazcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcazmoddt>>----
         AFTER FIELD xcazmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcazcnfdt>>----
         
         #----<<xcazpstdt>>----
 
 
           
         #單身一般欄位開窗相關處理
                  #此段落由子樣板a01產生
         BEFORE FIELD xcazstus
            #add-point:BEFORE FIELD xcazstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazstus
            
            #add-point:AFTER FIELD xcazstus

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcazstus
         ON ACTION controlp INFIELD xcazstus
            #add-point:ON ACTION controlp INFIELD xcazstus

            #END add-point
 
         #Ctrlp:construct.c.page1.xcaz001
         ON ACTION controlp INFIELD xcaz001
            #add-point:ON ACTION controlp INFIELD xcaz001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcaz001  #顯示到畫面上            
            NEXT FIELD xcaz001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz001
            #add-point:BEFORE FIELD xcaz001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz001
            
            #add-point:AFTER FIELD xcaz001
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazl003
            #add-point:BEFORE FIELD xcazl003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazl003
            
            #add-point:AFTER FIELD xcazl003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcazl003
         ON ACTION controlp INFIELD xcazl003
            #add-point:ON ACTION controlp INFIELD xcazl003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz002
            #add-point:BEFORE FIELD xcaz002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz002
            
            #add-point:AFTER FIELD xcaz002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcaz002
         ON ACTION controlp INFIELD xcaz002
            #add-point:ON ACTION controlp INFIELD xcaz002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz003
            #add-point:BEFORE FIELD xcaz003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz003
            
            #add-point:AFTER FIELD xcaz003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcaz003
         ON ACTION controlp INFIELD xcaz003
            #add-point:ON ACTION controlp INFIELD xcaz003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz004
            #add-point:BEFORE FIELD xcaz004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz004
            
            #add-point:AFTER FIELD xcaz004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcaz004
         ON ACTION controlp INFIELD xcaz004
            #add-point:ON ACTION controlp INFIELD xcaz004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz005
            #add-point:BEFORE FIELD xcaz005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz005
            
            #add-point:AFTER FIELD xcaz005

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcaz005
         ON ACTION controlp INFIELD xcaz005
            #add-point:ON ACTION controlp INFIELD xcaz005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz006
            #add-point:BEFORE FIELD xcaz006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz006
            
            #add-point:AFTER FIELD xcaz006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcaz006
         ON ACTION controlp INFIELD xcaz006
            #add-point:ON ACTION controlp INFIELD xcaz006

            #END add-point
 
         #Ctrlp:construct.c.page1.xcaz009
         ON ACTION controlp INFIELD xcaz009
            #add-point:ON ACTION controlp INFIELD xcaz009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcaz009  #顯示到畫面上
            NEXT FIELD xcaz009                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz009
            #add-point:BEFORE FIELD xcaz009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz009
            
            #add-point:AFTER FIELD xcaz009

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz007
            #add-point:BEFORE FIELD xcaz007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz007
            
            #add-point:AFTER FIELD xcaz007

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcaz007
         ON ACTION controlp INFIELD xcaz007
            #add-point:ON ACTION controlp INFIELD xcaz007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz008
            #add-point:BEFORE FIELD xcaz008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz008
            
            #add-point:AFTER FIELD xcaz008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcaz008
         ON ACTION controlp INFIELD xcaz008
            #add-point:ON ACTION controlp INFIELD xcaz008

            #END add-point
 
         #Ctrlp:construct.c.page2.xcazownid
         ON ACTION controlp INFIELD xcazownid
            #add-point:ON ACTION controlp INFIELD xcazownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcazownid  #顯示到畫面上
            NEXT FIELD xcazownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazownid
            #add-point:BEFORE FIELD xcazownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazownid
            
            #add-point:AFTER FIELD xcazownid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcazowndp
         ON ACTION controlp INFIELD xcazowndp
            #add-point:ON ACTION controlp INFIELD xcazowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcazowndp  #顯示到畫面上
            NEXT FIELD xcazowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazowndp
            #add-point:BEFORE FIELD xcazowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazowndp
            
            #add-point:AFTER FIELD xcazowndp

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcazcrtid
         ON ACTION controlp INFIELD xcazcrtid
            #add-point:ON ACTION controlp INFIELD xcazcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcazcrtid  #顯示到畫面上
            NEXT FIELD xcazcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazcrtid
            #add-point:BEFORE FIELD xcazcrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazcrtid
            
            #add-point:AFTER FIELD xcazcrtid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcazcrtdp
         ON ACTION controlp INFIELD xcazcrtdp
            #add-point:ON ACTION controlp INFIELD xcazcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcazcrtdp  #顯示到畫面上
            NEXT FIELD xcazcrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazcrtdp
            #add-point:BEFORE FIELD xcazcrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazcrtdp
            
            #add-point:AFTER FIELD xcazcrtdp

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazcrtdt
            #add-point:BEFORE FIELD xcazcrtdt

            #END add-point
 
         #Ctrlp:construct.c.page2.xcazmodid
         ON ACTION controlp INFIELD xcazmodid
            #add-point:ON ACTION controlp INFIELD xcazmodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcazmodid  #顯示到畫面上
            NEXT FIELD xcazmodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazmodid
            #add-point:BEFORE FIELD xcazmodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazmodid
            
            #add-point:AFTER FIELD xcazmodid

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazmoddt
            #add-point:BEFORE FIELD xcazmoddt




        #160728-00025#2-s-add
         ON ACTION controlp INFIELD xcaz011           
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcaz011  #顯示到畫面上
            NEXT FIELD xcaz011
        #160728-00025#2-e-add
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
 
{<section id="axci101.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axci101_query()
   DEFINE ls_wc STRING
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
   CALL g_xcaz_d.clear()
   CALL g_xcaz2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axci101_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axci101_browser_fill(g_wc)
      CALL axci101_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axci101_browser_fill("F")
   
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
      CALL axci101_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axci101_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
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
   
   CALL axci101_browser_fill(p_flag)
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xcaz_m.xcazld = g_browser[g_current_idx].b_xcazld
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axci101_master_referesh USING g_xcaz_m.xcazld INTO g_xcaz_m.xcazld,g_xcaz_m.xcazld_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcaz_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_xcaz_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #保存單頭舊值
   LET g_xcaz_m_t.* = g_xcaz_m.*
   LET g_xcaz_m_o.* = g_xcaz_m.*
   
   #重新顯示   
   CALL axci101_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.insert" >}
#+ 資料新增
PRIVATE FUNCTION axci101_insert()
   #add-point:insert段define
   
   #end add-point    
   
   #add-point:insert段before
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcaz_d.clear()
   CALL g_xcaz2_d.clear()
 
 
   INITIALIZE g_xcaz_m.* LIKE xcaz_t.*             #DEFAULT 設定
   LET g_xcazld_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_xcaz_m.glaa014 = "N"
 
     
      #add-point:單頭預設值
      
      #end add-point 
 
      CALL axci101_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcaz_m.* = g_xcaz_m_t.*
         CALL axci101_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      CALL g_xcaz_d.clear()
      CALL g_xcaz2_d.clear()
 
      
      #add-point:單頭輸入後2
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_xcazld_t = g_xcaz_m.xcazld
 
   
   LET g_wc = "(",g_wc,  
              " OR ( xcazent = '" ||g_enterprise|| "' AND ",
              " xcazld = '", g_xcaz_m.xcazld CLIPPED, "' "
 
              , ")) "
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.modify" >}
#+ 資料修改
PRIVATE FUNCTION axci101_modify()
   #add-point:modify段define
   
   #end add-point    
   
   IF g_xcaz_m.xcazld IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE axci101_master_referesh USING g_xcaz_m.xcazld INTO g_xcaz_m.xcazld,g_xcaz_m.xcazld_desc
 
   ERROR ""
  
   LET g_xcazld_t = g_xcaz_m.xcazld
 
   CALL s_transaction_begin()
   
   OPEN axci101_cl USING g_enterprise,g_xcaz_m.xcazld
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci101_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axci101_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axci101_cl INTO g_xcaz_m.xcazld,g_xcaz_m.xcazld_desc,g_xcaz_m.glaa014,g_xcaz_m.glaacomp,g_xcaz_m.glaacomp_desc 
 
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xcaz_m.xcazld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE axci101_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL axci101_show()
   WHILE TRUE
      LET g_xcazld_t = g_xcaz_m.xcazld
 
 
      #add-point:modify段修改前
      
      #end add-point
      
      CALL axci101_input("u")     #欄位更改
      
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcaz_m.* = g_xcaz_m_t.*
         CALL axci101_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_xcaz_m.xcazld != g_xcazld_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         
         #end add-point
         
         #更新單頭key值
         UPDATE xcaz_t SET xcazld = g_xcaz_m.xcazld
 
          WHERE xcazent = g_enterprise AND xcazld = g_xcazld_t
 
         #add-point:單頭(偽)修改中
         
         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcaz_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcaz_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
 
 
         
         #add-point:單頭(偽)修改後
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   #IF NOT cl_log_modified_record(g_xcaz_m.xcazld,g_site) THEN 
   #   CALL s_transaction_end('N','0')
   #END IF
 
   CLOSE axci101_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xcaz_m.xcazld,'U')
 
   CALL axci101_b_fill("1=1")
   
END FUNCTION   
 
{</section>}
 
{<section id="axci101.input" >}
#+ 資料輸入
PRIVATE FUNCTION axci101_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_xcatstus            LIKE type_t.chr1
   #end add-point    
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
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
   LET g_forupd_sql = "SELECT xcazld,xcazstus,xcaz001,xcaz002,xcaz003,xcaz004,xcaz005,xcaz006,xcaz010,xcaz009, 
       xcaz007,xcaz008,xcaz001,xcazownid,xcazowndp,xcazcrtid,xcazcrtdp,xcazcrtdt,xcazmodid,xcazmoddt  
       FROM xcaz_t WHERE xcazent=? AND xcazld=? AND xcaz001=? FOR UPDATE"    #20150604 By dujuan add -- xcaz010,
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci101_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axci101_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL axci101_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
   DISPLAY BY NAME g_xcaz_m.xcazld,g_xcaz_m.glaacomp
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axci101.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcaz_m.xcazld,g_xcaz_m.glaacomp 
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
          
                  #此段落由子樣板a02產生
         AFTER FIELD xcazld
            
            #add-point:AFTER FIELD xcazld
            IF NOT cl_null(g_xcaz_m.xcazld) THEN 
               
               
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcaz_m.xcazld
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME                   
                  CALL s_ld_chk_authorization(g_user,g_xcaz_m.xcazld) RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_xcaz_m.xcazld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xcaz_m.xcazld = ''
                    #CALL axct202_show_ref()
                     NEXT FIELD CURRENT
                  END IF 
                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcaz_m.xcazld = g_xcaz_m_t.xcazld
                 #CALL axct202_show_ref()
                  NEXT FIELD CURRENT
               END IF
            
               
            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcaz_m.xcazld
#            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcaz_m.xcazld_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcaz_m.xcazld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcaz_m.xcazld) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcaz_m.xcazld != g_xcazld_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcaz_t WHERE "||"xcazent = '" ||g_enterprise|| "' AND "||"xcazld = '"||g_xcaz_m.xcazld ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcaz_m.glaacomp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcaz_m.glaacomp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcaz_m.glaacomp_desc
            CALL axci101_comp_glaa014(g_xcaz_m.xcazld) 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazld
            #add-point:BEFORE FIELD xcazld
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcazld
            #add-point:ON CHANGE xcazld
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xcaz_m.glaacomp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xcaz_m.glaacomp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xcaz_m.glaacomp_desc
#

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp
            
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.xcazld
         ON ACTION controlp INFIELD xcazld
            #add-point:ON ACTION controlp INFIELD xcazld
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcaz_m.xcazld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcaz_m.xcazld = g_qryparam.return1              

            DISPLAY g_xcaz_m.xcazld TO xcazld              #
            CALL axci101_comp_glaa014(g_xcaz_m.xcazld)
            NEXT FIELD xcazld                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.glaacomp
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp
            
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
            
                
            CALL cl_showmsg()
            DISPLAY BY NAME g_xcaz_m.xcazld             
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               
               #end add-point
            
               UPDATE xcaz_t SET (xcazld) = (g_xcaz_m.xcazld)
                WHERE xcazent = g_enterprise AND xcazld = g_xcazld_t
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcaz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcaz_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcaz_m.xcazld
               LET gs_keys_bak[1] = g_xcazld_t
               LET gs_keys[2] = g_xcaz_d[g_detail_idx].xcaz001
               LET gs_keys_bak[2] = g_xcaz_d_t.xcaz001
               CALL axci101_update_b('xcaz_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_xcazld_t = g_xcaz_m.xcazld
 
                     #add-point:單頭修改後
                     
                     #end add-point
                     
                     LET g_log1 = util.JSON.stringify(g_xcaz_m_t)
                     LET g_log2 = util.JSON.stringify(g_xcaz_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            
            ELSE    
               #add-point:單頭新增
               
               #end add-point
                                 
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axci101_detail_reproduce()
               END IF
            END IF
           #controlp
                     
           LET g_xcazld_t = g_xcaz_m.xcazld
 
           
           #若單身還沒有輸入資料, 強制切換至單身
           #IF cl_null(g_xcaz_d[1].xcaz001) THEN
           #   CALL g_xcaz_d.deleteElement(1)
           #   NEXT FIELD xcaz001
           #END IF
           
           IF g_xcaz_d.getLength() = 0 THEN
              NEXT FIELD xcaz001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axci101.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcaz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         #+ 此段落由子樣板a43產生
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               IF NOT cl_null(g_xcaz_d[l_ac].xcaz001)  THEN
                  CALL n_xcazl(g_xcaz_m.xcazld,g_xcaz_d[l_ac].xcaz001)
                  CALL axci101_get_xcat(g_xcaz_d[l_ac].xcaz001,g_xcaz_d[l_ac].xcaz009,l_ac)
               END IF          {#ADP版次:1#}
               #END add-point
            END IF
 
 
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcaz_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axci101_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axci101_cl USING g_enterprise,
                                               g_xcaz_m.xcazld
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci101_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axci101_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcaz_d[l_ac].xcaz001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcaz_d_t.* = g_xcaz_d[l_ac].*  #BACKUP
               LET g_xcaz_d_o.* = g_xcaz_d[l_ac].*  #BACKUP
               CALL axci101_set_entry_b(l_cmd)
               #add-point:set_entry_b後
               #axci100无效资料不可修改
               SELECT xcatstus INTO l_xcatstus FROM xcat_t 
               WHERE xcat001= g_xcaz_d[l_ac].xcaz001
                 AND xcatent = g_enterprise
              IF l_xcatstus <> g_xcaz_d[l_ac].xcazstus THEN
                 IF l_xcatstus = 'N' THEN
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = ''              
                    LET g_errparam.code   = "axc-00527" 
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    LET g_xcaz_d[l_ac].xcazstus = g_xcaz_d_t.xcazstus
                    RETURN
                 END IF
              END IF
              #有年期不可修改
              IF NOT cl_null(g_xcaz_d[l_ac].xcaz007) OR NOT cl_null(g_xcaz_d[l_ac].xcaz008) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  "axc-00525"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
#                  CANCEL DELETE
                  RETURN
               END IF
               #end add-point
               CALL axci101_set_no_entry_b(l_cmd)
               OPEN axci101_bcl USING g_enterprise,g_xcaz_m.xcazld,
 
                                                g_xcaz_d_t.xcaz001
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axci101_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci101_bcl INTO g_xcaz_d[l_ac].xcazld,g_xcaz_d[l_ac].xcazstus,g_xcaz_d[l_ac].xcaz001, 
                      g_xcaz_d[l_ac].xcaz002,g_xcaz_d[l_ac].xcaz003,g_xcaz_d[l_ac].xcaz004,g_xcaz_d[l_ac].xcaz005, 
                      g_xcaz_d[l_ac].xcaz006,g_xcaz_d[l_ac].xcaz010,g_xcaz_d[l_ac].xcaz009,g_xcaz_d[l_ac].xcaz007,g_xcaz_d[l_ac].xcaz008, 
                      g_xcaz2_d[l_ac].xcaz001,g_xcaz2_d[l_ac].xcazownid,g_xcaz2_d[l_ac].xcazowndp,g_xcaz2_d[l_ac].xcazcrtid, 
                      g_xcaz2_d[l_ac].xcazcrtdp,g_xcaz2_d[l_ac].xcazcrtdt,g_xcaz2_d[l_ac].xcazmodid, 
                      g_xcaz2_d[l_ac].xcazmoddt   #20150607 By dujuan add -- g_xcaz_d[l_ac].xcaz010,
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcaz_d_t.xcaz001 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axci101_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            LET g_detail_multi_table_t.xcazl001 = g_xcaz_d[l_ac].xcaz001
LET g_detail_multi_table_t.xcazl002 = g_dlang
LET g_detail_multi_table_t.xcazl003 = g_xcaz_d[l_ac].xcazl003
 
        
         BEFORE INSERT
            
            INITIALIZE g_xcaz_d_t.* TO NULL
            INITIALIZE g_xcaz_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcaz_d[l_ac].* TO NULL
            #公用欄位預設值
            #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_xcaz2_d[l_ac].xcazownid = g_user
      LET g_xcaz2_d[l_ac].xcazowndp = g_dept
      LET g_xcaz2_d[l_ac].xcazcrtid = g_user
      LET g_xcaz2_d[l_ac].xcazcrtdp = g_dept 
      LET g_xcaz2_d[l_ac].xcazcrtdt = cl_get_current()
      LET g_xcaz2_d[l_ac].xcazmodid = ""
      LET g_xcaz2_d[l_ac].xcazmoddt = ""
      LET g_xcaz_d[l_ac].xcazstus = ""
 
  
            #一般欄位預設值
                  LET g_xcaz_d[l_ac].xcazstus = "Y"
      LET g_xcaz_d[l_ac].xcaz004 = "1"
      LET g_xcaz_d[l_ac].xcaz010 = "N"  #20150604 BY dujuan  给xcaz010默认值N
            
            #add-point:modify段before備份

            #end add-point
            LET g_xcaz_d_t.* = g_xcaz_d[l_ac].*     #新輸入資料
            LET g_xcaz_d_o.* = g_xcaz_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axci101_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axci101_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcaz_d[li_reproduce_target].* = g_xcaz_d[li_reproduce].*
               LET g_xcaz2_d[li_reproduce_target].* = g_xcaz2_d[li_reproduce].*
 
               LET g_xcaz_d[g_xcaz_d.getLength()].xcaz001 = NULL
 
            END IF
            LET g_detail_multi_table_t.xcazl001 = g_xcaz_d[l_ac].xcaz001
LET g_detail_multi_table_t.xcazl002 = g_dlang
LET g_detail_multi_table_t.xcazl003 = g_xcaz_d[l_ac].xcazl003
 
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
            SELECT COUNT(*) INTO l_count FROM xcaz_t 
             WHERE xcazent = g_enterprise AND xcazld = g_xcaz_m.xcazld
 
               AND xcaz001 = g_xcaz_d[l_ac].xcaz001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前
               IF cl_null(g_xcaz_d[l_ac].xcaz007) THEN LET g_xcaz_d[l_ac].xcaz007=' ' END IF
               IF cl_null(g_xcaz_d[l_ac].xcaz008) THEN LET g_xcaz_d[l_ac].xcaz008=' ' END IF
               #end add-point
               INSERT INTO xcaz_t
                           (xcazent,
                            xcazld,
                            xcaz001
                            ,xcazstus,xcaz002,xcaz003,xcaz004,xcaz005,xcaz006,xcaz010,xcaz011,xcaz009,xcaz007,xcaz008,xcazownid,xcazowndp,xcazcrtid,xcazcrtdp,xcazcrtdt,xcazmodid,xcazmoddt) #20150603 By dujuan add -- xcaz010,#160728-00025#2 add xcaz011
                     VALUES(g_enterprise,
                            g_xcaz_m.xcazld,
                            g_xcaz_d[l_ac].xcaz001
                            ,g_xcaz_d[l_ac].xcazstus,g_xcaz_d[l_ac].xcaz002,g_xcaz_d[l_ac].xcaz003,g_xcaz_d[l_ac].xcaz004, 
                                g_xcaz_d[l_ac].xcaz005,g_xcaz_d[l_ac].xcaz006,g_xcaz_d[l_ac].xcaz010,g_xcaz_d[l_ac].xcaz011,g_xcaz_d[l_ac].xcaz009, #20150603 By dujuan add -- g_xcaz_d[l_ac].xcaz010,#160728-00025#2 add xcaz011
                                g_xcaz_d[l_ac].xcaz007,g_xcaz_d[l_ac].xcaz008,g_xcaz2_d[l_ac].xcazownid, 
                                g_xcaz2_d[l_ac].xcazowndp,g_xcaz2_d[l_ac].xcazcrtid,g_xcaz2_d[l_ac].xcazcrtdp, 
                                g_xcaz2_d[l_ac].xcazcrtdt,g_xcaz2_d[l_ac].xcazmodid,g_xcaz2_d[l_ac].xcazmoddt) 
 
               #add-point:單身新增中

               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xcaz_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcaz_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xcaz_d[l_ac].xcaz001 = g_detail_multi_table_t.xcazl001 AND
         g_xcaz_d[l_ac].xcazl003 = g_detail_multi_table_t.xcazl003 THEN
         ELSE
                    
            LET l_var_keys[01] = g_xcaz_d[l_ac].xcaz001
            LET l_field_keys[01] = 'xcazl001'
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'xcazl002'
            LET l_var_keys[03] = g_xcaz_m.xcazld
            LET l_field_keys[03] = 'xcazlld' 
            LET l_vars[01] = g_xcaz_d[l_ac].xcazl003
            LET l_fields[01] = 'xcazl003'
            LET l_vars[02] = g_enterprise 
            LET l_fields[02] = 'xcazlent'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.xcazl001
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xcazl002                     
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xcazl_t')
         END IF 
 
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
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
               IF NOT cl_null(g_xcaz_d[l_ac].xcaz007) OR NOT cl_null(g_xcaz_d[l_ac].xcaz008) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  "axc-00525"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
#                  CANCEL DELETE
                  RETURN
               END IF
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
               IF axci101_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
                  CALL s_transaction_begin()
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'xcazl001'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.xcazl001
                  LET l_field_keys[02] = 'xcazlld'
                  LET l_var_keys_bak[02] = g_xcaz_m.xcazld
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xcazl_t')
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axci101_bcl
               LET l_count = g_xcaz_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               IF g_rec_b = 0 THEN
                  RETURN
               END IF               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcaz_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a01產生
         BEFORE FIELD xcazstus
            #add-point:BEFORE FIELD xcazstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazstus
            
            #add-point:AFTER FIELD xcazstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcazstus
            #add-point:ON CHANGE xcazstus

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz001
            #add-point:BEFORE FIELD xcaz001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz001
            
            #add-point:AFTER FIELD xcaz001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcaz_m.xcazld IS NOT NULL AND g_xcaz_d[g_detail_idx].xcaz001 IS NOT NULL THEN 
               
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcaz_m.xcazld != g_xcazld_t OR g_xcaz_d[g_detail_idx].xcaz001 != g_xcaz_d_t.xcaz001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcaz_t WHERE "||"xcazent = '" ||g_enterprise|| "' AND "||"xcazld = '"||g_xcaz_m.xcazld ||"' AND "|| "xcaz001 = '"||g_xcaz_d[g_detail_idx].xcaz001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_xcaz_d[g_detail_idx].xcaz001) THEN 
#此段落由子樣板a19產生
               #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcaz_d[g_detail_idx].xcaz001
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_xcat001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_xcaz_d[g_detail_idx].xcaz001 = g_xcaz_d_t.xcaz001
                     NEXT FIELD CURRENT
                  END IF
               
                 
               END IF 
               CALL axci101_get_xcat(g_xcaz_d[g_detail_idx].xcaz001,g_xcaz_d[g_detail_idx].xcaz009,g_detail_idx) 
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz001
            #add-point:ON CHANGE xcaz001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcazl003
            #add-point:BEFORE FIELD xcazl003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcazl003
            
            #add-point:AFTER FIELD xcazl003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcazl003
            #add-point:ON CHANGE xcazl003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz002
            #add-point:BEFORE FIELD xcaz002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz002
            
            #add-point:AFTER FIELD xcaz002

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz002
            #add-point:ON CHANGE xcaz002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz003
            #add-point:BEFORE FIELD xcaz003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz003
            
            #add-point:AFTER FIELD xcaz003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz003
            #add-point:ON CHANGE xcaz003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz004
            #add-point:BEFORE FIELD xcaz004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz004
            
            #add-point:AFTER FIELD xcaz004

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz004
            #add-point:ON CHANGE xcaz004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz005
            #add-point:BEFORE FIELD xcaz005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz005
            
            #add-point:AFTER FIELD xcaz005

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz005
            #add-point:ON CHANGE xcaz005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz006
            #add-point:BEFORE FIELD xcaz006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz006
            
            #add-point:AFTER FIELD xcaz006

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz006
            #add-point:ON CHANGE xcaz006
            #160728-00025#2-s-add
            CALL axci101_set_entry_b(l_cmd)
            CALL axci101_set_no_entry_b(l_cmd)
            #160728-00025#2-e-add
            #END add-point
        
         #此段落由子樣板a02產生
         AFTER FIELD xcaz010
            
            #add-point:AFTER FIELD xcaz010
    
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz010
            #add-point:BEFORE FIELD xcaz010
 
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz010
            #add-point:ON CHANGE xcaz010
 
            #END add-point
 
        
         #此段落由子樣板a02產生
         AFTER FIELD xcaz009
            
            #add-point:AFTER FIELD xcaz009
            IF NOT cl_null(g_xcaz_d[l_ac].xcaz009) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcaz_d[l_ac].xcaz009
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcau001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcaz_d[l_ac].xcaz009 = g_xcaz_d_t.xcaz009
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz009
            #add-point:BEFORE FIELD xcaz009

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz009
            #add-point:ON CHANGE xcaz009

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz007
            #add-point:BEFORE FIELD xcaz007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz007
            
            #add-point:AFTER FIELD xcaz007

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz007
            #add-point:ON CHANGE xcaz007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcaz008
            #add-point:BEFORE FIELD xcaz008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcaz008
            
            #add-point:AFTER FIELD xcaz008

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcaz008
            #add-point:ON CHANGE xcaz008

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xcazstus
         ON ACTION controlp INFIELD xcazstus
            #add-point:ON ACTION controlp INFIELD xcazstus

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz001
         ON ACTION controlp INFIELD xcaz001
            #add-point:ON ACTION controlp INFIELD xcaz001
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcaz_d[l_ac].xcaz001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcaz_d[l_ac].xcaz001 = g_qryparam.return1              

            DISPLAY g_xcaz_d[l_ac].xcaz001 TO xcaz001              #
            CALL axci101_get_xcat(g_xcaz_d[l_ac].xcaz001,g_xcaz_d[l_ac].xcaz009,l_ac)
            NEXT FIELD xcaz001                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xcazl003
         ON ACTION controlp INFIELD xcazl003
            #add-point:ON ACTION controlp INFIELD xcazl003

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz002
         ON ACTION controlp INFIELD xcaz002
            #add-point:ON ACTION controlp INFIELD xcaz002

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz003
         ON ACTION controlp INFIELD xcaz003
            #add-point:ON ACTION controlp INFIELD xcaz003

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz004
         ON ACTION controlp INFIELD xcaz004
            #add-point:ON ACTION controlp INFIELD xcaz004

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz005
         ON ACTION controlp INFIELD xcaz005
            #add-point:ON ACTION controlp INFIELD xcaz005

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz006
         ON ACTION controlp INFIELD xcaz006
            #add-point:ON ACTION controlp INFIELD xcaz006

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz009
         ON ACTION controlp INFIELD xcaz009
            #add-point:ON ACTION controlp INFIELD xcaz009
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcaz_d[l_ac].xcaz009             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #            
            CALL q_xcau001()                                #呼叫開窗
            LET g_xcaz_d[l_ac].xcaz009 = g_qryparam.return1              
            DISPLAY g_xcaz_d[l_ac].xcaz009 TO xcaz009              #
            NEXT FIELD xcaz009                          #返回原欄位




        #160728-00025#2-s-add
         ON ACTION controlp INFIELD xcaz011          
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcaz_d[l_ac].xcaz011
            LET g_qryparam.arg1 = "" # 
            CALL q_xcaa001()                       #呼叫開窗
            LET g_xcaz_d[l_ac].xcaz011 = g_qryparam.return1 
            DISPLAY g_xcaz_d[l_ac].xcaz011 TO xcaz011   #顯示到畫面上
            CALL axci101_xcaz011_desc(g_xcaz_d[l_ac].xcaz011) RETURNING g_xcaz_d[l_ac].xcaz011_desc
            DISPLAY BY NAME g_xcaz_d[l_ac].xcaz011_desc
            NEXT FIELD xcaz011
            
            
         AFTER FIELD xcaz011  
           IF NOT cl_null(g_xcaz_d[l_ac].xcaz011) THEN
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL
              #設定g_chkparam.*的參數
              LET g_chkparam.arg1 = g_xcaz_d[l_ac].xcaz011
              LET g_errshow = TRUE #是否開窗
              LET g_chkparam.err_str[1] = "axc-00063:sub-01302|axci001|",cl_get_progname("axci001",g_lang,"2"),"|:EXEPROGaxci001"
              #呼叫檢查存在並帶值的library
              IF NOT cl_chk_exist("v_xcaa001_01") THEN                 
                 LET g_xcaz_d[l_ac].xcaz011 = ''
                 CALL axci101_xcaz011_desc(g_xcaz_d[l_ac].xcaz011) RETURNING g_xcaz_d[l_ac].xcaz011_desc
                 DISPLAY BY NAME g_xcaz_d[l_ac].xcaz011_desc                 
                 NEXT FIELD xcaz011
              END IF
           END IF
           CALL axci101_xcaz011_desc(g_xcaz_d[l_ac].xcaz011) RETURNING g_xcaz_d[l_ac].xcaz011_desc
           DISPLAY BY NAME g_xcaz_d[l_ac].xcaz011_desc
        #160728-00025#2-e-add

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz007
         ON ACTION controlp INFIELD xcaz007
            #add-point:ON ACTION controlp INFIELD xcaz007

            #END add-point
 
         #Ctrlp:input.c.page1.xcaz008
         ON ACTION controlp INFIELD xcaz008
            #add-point:ON ACTION controlp INFIELD xcaz008

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcaz_d[l_ac].* = g_xcaz_d_t.*
               CLOSE axci101_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcaz_d[l_ac].xcaz001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xcaz_d[l_ac].* = g_xcaz_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcaz2_d[l_ac].xcazmodid = g_user 
LET g_xcaz2_d[l_ac].xcazmoddt = cl_get_current()
 
            
               #add-point:單身修改前
               IF NOT cl_null(g_xcaz_d[l_ac].xcaz007) OR NOT cl_null(g_xcaz_d[l_ac].xcaz008) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  "axc-00525"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_xcaz_d[l_ac].* = g_xcaz_d_t.*
                  
                  RETURN 
               END IF
               
               #161222-00049#1 ---add (s)--- 若舊資料有空值也須強制使用者給值
                IF cl_get_para(g_enterprise,g_xcaz_m.glaacomp,'S-FIN-6001') = 'Y' THEN
                   IF cl_null(g_xcaz_d[l_ac].xcaz005) THEN
                      NEXT FIELD xcaz005
                   END IF
                END IF 
               #161222-00049#1 ---add (e)---
               #end add-point
         
               UPDATE xcaz_t SET (xcazld,xcazstus,xcaz001,xcaz002,xcaz003,xcaz004,xcaz005,xcaz006,xcaz010,xcaz011,xcaz009, #20150604 By dujuan add -- xcaz010,#160728-00025#2 add xcaz011
                   xcaz007,xcaz008,xcazownid,xcazowndp,xcazcrtid,xcazcrtdp,xcazcrtdt,xcazmodid,xcazmoddt) = (g_xcaz_m.xcazld, 
                   g_xcaz_d[l_ac].xcazstus,g_xcaz_d[l_ac].xcaz001,g_xcaz_d[l_ac].xcaz002,g_xcaz_d[l_ac].xcaz003, 
                   g_xcaz_d[l_ac].xcaz004,g_xcaz_d[l_ac].xcaz005,g_xcaz_d[l_ac].xcaz006,g_xcaz_d[l_ac].xcaz010,g_xcaz_d[l_ac].xcaz011,g_xcaz_d[l_ac].xcaz009, #20150604 By dujuan add -- g_xcaz_d[l_ac].xcaz010,#160728-00025#2 add xcaz011
                   g_xcaz_d[l_ac].xcaz007,g_xcaz_d[l_ac].xcaz008,g_xcaz2_d[l_ac].xcazownid,g_xcaz2_d[l_ac].xcazowndp, 
                   g_xcaz2_d[l_ac].xcazcrtid,g_xcaz2_d[l_ac].xcazcrtdp,g_xcaz2_d[l_ac].xcazcrtdt,g_xcaz2_d[l_ac].xcazmodid, 
                   g_xcaz2_d[l_ac].xcazmoddt)
                WHERE xcazent = g_enterprise AND xcazld = g_xcaz_m.xcazld 
 
                 AND xcaz001 = g_xcaz_d_t.xcaz001 #項次   
 
                 
               #add-point:單身修改中

               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcaz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcaz_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcaz_m.xcazld
               LET gs_keys_bak[1] = g_xcazld_t
               LET gs_keys[2] = g_xcaz_d[g_detail_idx].xcaz001
               LET gs_keys_bak[2] = g_xcaz_d_t.xcaz001
               CALL axci101_update_b('xcaz_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xcaz_d[l_ac].xcaz001 = g_detail_multi_table_t.xcazl001 AND
         g_xcaz_d[l_ac].xcazl003 = g_detail_multi_table_t.xcazl003 THEN
         ELSE 
            LET l_var_keys[01] = g_xcaz_d[l_ac].xcaz001
            LET l_field_keys[01] = 'xcazl001'
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'xcazl002'
            LET l_vars[01] = g_xcaz_d[l_ac].xcazl003
            LET l_fields[01] = 'xcazl003'
            LET l_vars[02] = g_enterprise 
            LET l_fields[02] = 'xcazlent'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.xcazl001
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xcazl002
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xcazl_t')
         END IF 
 
                     LET g_log1 = util.JSON.stringify(g_xcaz_m),util.JSON.stringify(g_xcaz_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcaz_m),util.JSON.stringify(g_xcaz_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後

               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcaz_d.getLength() = 0 THEN
               NEXT FIELD xcaz001
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcaz_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcaz_d.getLength()+1
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcaz2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axci101_b_fill(g_wc2) 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL axci101_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為

         #end add-point
         
      END DISPLAY
 
      
 
      
      #add-point:input段more_input

      #end add-point    
      
      BEFORE DIALOG
         #add-point:input段before_dialog

         #end add-point 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcazld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                 #NEXT FIELD xcazld  140805
                  NEXT FIELD xcazstus
               WHEN "s_detail2"
                  NEXT FIELD xcaz001_2
 
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
   
   #add-point:input段after_input

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axci101_show()
   #add-point:show段define
   
   #end add-point
   
   #add-point:show段之前
   
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axci101_b_fill(g_wc2) #單身填充
      CALL axci101_b_fill2('0') #單身填充
   END IF
   
   
 
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL axci101_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   DISPLAY BY NAME g_xcaz_m.xcazld,g_xcaz_m.xcazld_desc,g_xcaz_m.glaa014,g_xcaz_m.glaacomp,g_xcaz_m.glaacomp_desc 
 
   CALL axci101_b_fill(g_wc2_table1)                 #單身
   CALL axci101_b_fill2('0') #單身填充
 
   CALL axci101_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axci101_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   CALL axci101_comp_glaa014(g_xcaz_m.xcazld) 
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcaz_d.getLength()
      #add-point:ref_show段d_reference
      CALL axci101_get_xcat(g_xcaz_d[l_ac].xcaz001,g_xcaz_d[l_ac].xcaz009,l_ac)
   
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcaz2_d.getLength()
      #add-point:ref_show段d2_reference
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axci101_reproduce()
   DEFINE l_newno     LIKE xcaz_t.xcazld 
   DEFINE l_oldno     LIKE xcaz_t.xcazld 
 
   DEFINE l_master    RECORD LIKE xcaz_t.*
   DEFINE l_detail    RECORD LIKE xcaz_t.*
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcaz_m.xcazld IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   LET g_xcazld_t = g_xcaz_m.xcazld
 
   
   LET g_xcaz_m.xcazld = ""
 
    
   CALL axci101_set_entry('a')
   CALL axci101_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   CALL axci101_input("r")
   
      LET g_xcaz_m.xcazld_desc = ''
   DISPLAY BY NAME g_xcaz_m.xcazld_desc
 
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_xcazld_t = g_xcaz_m.xcazld
 
   
   LET g_wc = "(", g_wc,  
              " OR (",
              " xcazld = '", g_xcaz_m.xcazld CLIPPED, "' "
 
              , ")) "
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axci101_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcaz_t.*
 
 
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axci101_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axci101_detail AS ",
                "SELECT * FROM xcaz_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axci101_detail SELECT * FROM xcaz_t 
                                         WHERE xcazent = g_enterprise AND xcazld = g_xcazld_t
 
   
   #將key修正為調整後   
   UPDATE axci101_detail 
      #更新key欄位
      SET xcazld = g_xcaz_m.xcazld
 
      #更新共用欄位
      #此段落由子樣板a13產生
       , xcazownid = g_user
       , xcazowndp = g_dept
       , xcazcrtid = g_user
       , xcazcrtdp = g_dept 
       , xcazcrtdt = ld_date
       , xcazmodid = "" 
       , xcazmoddt = "" 
      #, xcazstus = "Y"
 
 
                                       
  
   #將資料塞回原table   
   INSERT INTO xcaz_t SELECT * FROM axci101_detail
   
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
   DROP TABLE axci101_detail
   
   #add-point:單身複製後1

   #end add-point
 
 
   
 
   
   #多語言複製段落
      #此段落由子樣板a38產生
   #單身多語言複製
   DROP TABLE axci101_detail_lang
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axci101_detail_lang AS ",
                "SELECT * FROM xcazl_t "
   PREPARE repro_xcazl_t FROM ls_sql
   EXECUTE repro_xcazl_t
   FREE repro_xcazl_t
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axci101_detail_lang SELECT * FROM xcazl_t 
                                            #WHERE xcazlent = g_enterprise AND xcazl001 = g_xcazld_t
                                             WHERE xcazlent = g_enterprise AND xcazlld = g_xcazld_t
 
   
   #將key修正為調整後   
   UPDATE axci101_detail_lang 
      #更新key欄位
     #SET xcazl001 = g_xcaz_m.xcazld
      SET xcazlld  = g_xcaz_m.xcazld
 
  
   #將資料塞回原table   
   INSERT INTO xcazl_t SELECT * FROM axci101_detail_lang
   
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
   DROP TABLE axci101_detail_lang
   
   #add-point:單身複製後1

   #end add-point
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcazld_t = g_xcaz_m.xcazld
 
   
   DROP TABLE axci101_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axci101_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   DEFINE  l_xcazlld       LIKE xcaz_t.xcazld
   #end add-point     
   
   IF g_xcaz_m.xcazld IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE axci101_master_referesh USING g_xcaz_m.xcazld INTO g_xcaz_m.xcazld,g_xcaz_m.xcazld_desc
   
   CALL axci101_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN axci101_cl USING g_enterprise,g_xcaz_m.xcazld
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci101_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axci101_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axci101_cl INTO g_xcaz_m.xcazld,g_xcaz_m.xcazld_desc,g_xcaz_m.glaa014,g_xcaz_m.glaacomp,g_xcaz_m.glaacomp_desc 
 
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xcaz_m.xcazld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL axci101_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
 
      #add-point:單身刪除前
 
      #end add-point
      
      DELETE FROM xcaz_t WHERE xcazent = g_enterprise AND xcazld = g_xcaz_m.xcazld
 
                                                               
      #add-point:單身刪除中
      INITIALIZE l_var_keys_bak TO NULL 
      INITIALIZE l_field_keys TO NULL       
      LET l_field_keys[01] = 'xcazlld'
      LET l_var_keys_bak[01] = g_xcaz_m.xcazld
      CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xcazl_t')
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcaz_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      
      #end add-point
      
 
      
      CLEAR FORM
      CALL g_xcaz_d.clear() 
      CALL g_xcaz2_d.clear()       
 
     
      CALL axci101_ui_browser_refresh()  
      CALL axci101_ui_headershow()  
      CALL axci101_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axci101_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL axci101_browser_fill("F")
      END IF
       
   END IF
 
   CLOSE axci101_cl   
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xcaz_m.xcazld,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="axci101.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axci101_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define

   #end add-point     
 
   #先清空單身變數內容
   CALL g_xcaz_d.clear()
   CALL g_xcaz2_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xcazld,xcazstus,xcaz001,xcaz002,xcaz003,xcaz004,xcaz005,xcaz006,xcaz010,xcaz011,xcaz009,                   
                xcaz007,xcaz008,xcaz001,xcazownid,xcazowndp,xcazcrtid,xcazcrtdp,xcazcrtdt,xcazmodid,xcazmoddt, 
                t1.oofa011 ,t2.ooefl003 ,t3.oofa011 ,t4.ooefl003 ,t5.oofa011,t6.xcaal003 FROM xcaz_t",   
               " LEFT JOIN xcazl_t ON xcazlent = '"||g_enterprise||"' AND xcaz001 = xcazl001 AND xcazl002 = '",g_dlang,"'",               
               " LEFT JOIN oofa_t t1 ON t1.oofaent='"||g_enterprise||"' AND t1.oofa002='2' AND t1.oofa003=xcazownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=xcazowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t3 ON t3.oofaent='"||g_enterprise||"' AND t3.oofa002='2' AND t3.oofa003=xcazcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=xcazcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent='"||g_enterprise||"' AND t5.oofa002='2' AND t5.oofa003=xcazmodid  ",
               " LEFT JOIN xcaal_t t6 ON t6.xcaalent = '"||g_enterprise||"' AND t6.xcaal001=xcaz011 AND t6.xcaal002 = '",g_dlang,"'",       #160728-00025#2 add
               " WHERE xcazent= ? AND xcazld=?"     #20150603 By dujuan add -- xcaz010 #160728-00025#2 add xcaz011
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcaz_t")
   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axci101_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcaz_t.xcaz001"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axci101_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axci101_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xcaz_m.xcazld
                                               
      FOREACH b_fill_cs INTO g_xcaz_d[l_ac].xcazld,g_xcaz_d[l_ac].xcazstus,g_xcaz_d[l_ac].xcaz001,g_xcaz_d[l_ac].xcaz002, 
          g_xcaz_d[l_ac].xcaz003,g_xcaz_d[l_ac].xcaz004,g_xcaz_d[l_ac].xcaz005,g_xcaz_d[l_ac].xcaz006,g_xcaz_d[l_ac].xcaz010, #20150603 By dujuan add -- g_xcaz_d[l_ac].xcaz010, 
          g_xcaz_d[l_ac].xcaz011,                                                                                             #160728-00025#2 add 
          g_xcaz_d[l_ac].xcaz009,g_xcaz_d[l_ac].xcaz007,g_xcaz_d[l_ac].xcaz008,g_xcaz2_d[l_ac].xcaz001, 
          g_xcaz2_d[l_ac].xcazownid,g_xcaz2_d[l_ac].xcazowndp,g_xcaz2_d[l_ac].xcazcrtid,g_xcaz2_d[l_ac].xcazcrtdp, 
          g_xcaz2_d[l_ac].xcazcrtdt,g_xcaz2_d[l_ac].xcazmodid,g_xcaz2_d[l_ac].xcazmoddt,g_xcaz2_d[l_ac].xcazownid_desc, 
          g_xcaz2_d[l_ac].xcazowndp_desc,g_xcaz2_d[l_ac].xcazcrtid_desc,g_xcaz2_d[l_ac].xcazcrtdp_desc, 
          g_xcaz2_d[l_ac].xcazmodid_desc,g_xcaz_d[l_ac].xcaz011_desc                       #160728-00025#2 add xcaz011_desc
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         IF cl_null(g_xcaz_d[l_ac].xcaz010) THEN
            LET g_xcaz_d[l_ac].xcaz010 = 'N'
         END IF
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
 
            CALL g_xcaz_d.deleteElement(g_xcaz_d.getLength())
      CALL g_xcaz2_d.deleteElement(g_xcaz2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axci101_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axci101_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axci101_before_delete()
   #add-point:before_delete段define
   
   #end add-point 
   
   #add-point:單筆刪除前
   
   #end add-point
   
   DELETE FROM xcaz_t
    WHERE xcazent = g_enterprise AND xcazld = g_xcaz_m.xcazld AND
 
          xcaz001 = g_xcaz_d_t.xcaz001
 
      
   #add-point:單筆刪除中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcaz_t" 
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
 
{<section id="axci101.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axci101_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axci101_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axci101_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
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
 
{<section id="axci101.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axci101_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL axci101_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axci101_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axci101_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcazld",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axci101_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcazld",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axci101_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcaz001,xcaz009",TRUE)       
   END IF
   CALL cl_set_comp_entry("xcaz011",TRUE)       #160728-00025#2 add
   
  #161222-00049#1 ---add (s)--- 
   IF cl_get_para(g_enterprise,g_xcaz_m.glaacomp,'S-FIN-6001') = 'Y' THEN
      CALL cl_set_comp_required('xcaz005',TRUE)
   END IF 
  #161222-00049#1 ---add (e)---
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axci101_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   #add-point:set_no_entry_b段
   CALL cl_set_comp_entry("xcazl003,xcaz007,xcaz008",FALSE)
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("xcaz001",FALSE)       
   END IF
   #160728-00025#2-s-add
   IF g_xcaz_d[l_ac].xcaz006 <> '1' THEN
      CALL cl_set_comp_entry("xcaz011",FALSE)
   END IF   
   #160728-00025#2-e-add
   #161222-00049#1 ---add (s)--- 
   IF cl_get_para(g_enterprise,g_xcaz_m.glaacomp,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_required('xcaz005',FALSE)
   END IF 
  #161222-00049#1 ---add (e)---
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axci101_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcazld = '", g_argv[01], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
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
 
{<section id="axci101.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axci101_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
 
 
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="axci101.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axci101_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xcazld"
      WHEN "s_detail2"
         LET ls_return = "xcaz001_2"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axci101.state_change" >}
    
 
{</section>}
 
{<section id="axci101.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axci101_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xcaz_m.xcazld
   LET g_pk_array[1].column = 'xcazld'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axci101.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axci101_comp_glaa014 (p_ld)
#                  RETURNING l_comp,l_glaa014
# Input parameter: 传入参数变量1   账套
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   归属法人
#                : 回传参数变量2   主账套
# Date & Author..: 日期 By 作者    fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axci101_comp_glaa014(p_ld)
DEFINE p_ld       LIKE xcaz_t.xcazld
#DEFINE l_glaacomp LIKE glaa_t.glaacomp
#DEFINE l_glaa014  LIKE glaa_t.glaa014
#DEFINE l_ooefl003 LIKE ooefl_t.ooefl003
#DEFINE l_sql      STRING 
#
#   LET l_sql= " SELECT glaacomp,glaa014,ooefl003 FROM glaa_t t0",
#              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.glaacomp AND t1.ooefl002='"||g_dlang||"' ",    
#              "  WHERE glaaent='"||g_enterprise||"' AND glaald=? "
#   
#   PREPARE axci101_comp_glaa014 FROM l_sql
#   EXECUTE axci101_comp_glaa014 USING p_ld INTO l_glaacomp,l_glaa014,l_ooefl003
#   RETURN l_glaacomp,l_glaa014,l_ooefl003 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcaz_m.xcazld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcaz_m.xcazld_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa014 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_xcaz_m.glaacomp = g_rtn_fields[1]   
   LET g_xcaz_m.glaa014  = g_rtn_fields[2]   
   DISPLAY BY NAME g_xcaz_m.glaacomp,g_xcaz_m.glaa014
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcaz_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcaz_m.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xcaz_m.glaacomp_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: 取成本类型设置
# Usage..........: CALL axci101_get_xcat (p_xcat001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者    fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axci101_get_xcat(p_xcat001,p_xcaz009,p_ac)
DEFINE p_xcat001  LIKE xcaz_t.xcaz001
DEFINE p_xcaz009 LIKE xcaz_t.xcaz009
DEFINE p_ac       LIKE type_t.num5   
#DEFINE l_xcatl003 LIKE xcatl_t.xcatl003
#DEFINE l_xcat002  LIKE xcat_t.xcat002
#DEFINE l_xcat003  LIKE xcat_t.xcat003
#DEFINE l_xcat004  LIKE xcat_t.xcat004
#DEFINE l_xcat005  LIKE xcat_t.xcat005
#DEFINE l_sql      STRING 
#
#   LET l_sql= " SELECT xcatl003,xcat002,xcat003,xcat004,xcat005",
#              "   FROM xcat_t t0",
#                              " LEFT JOIN xcatl_t t1 ON t1.xcatlent='"||g_enterprise||"' AND t1.xcatl001=t0.xcat001 AND t1.xcatl002='"||g_dlang||"' ",                
#              "  WHERE t0.xcatent='"||g_enterprise||"' AND t0.xcat001=? "
#             
#   
#   PREPARE axci101_get_xcat FROM l_sql
#   EXECUTE axci101_get_xcat USING p_xcat001 INTO l_xcatl003,l_xcat002,l_xcat003,l_xcat004,l_xcat005 
#   RETURN l_xcatl003,l_xcat002,l_xcat003,l_xcat004,l_xcat005
   
   INITIALIZE g_ref_fields TO NULL   
   LET g_ref_fields[1] = p_xcat001
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"'  AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcaz_d[p_ac].xcazl003 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcaz_d[p_ac].xcazl003   
   
   INITIALIZE g_ref_fields TO NULL   
   LET g_ref_fields[1] = p_xcat001
   CALL ap_ref_array2(g_ref_fields,"SELECT xcat002,xcat003,xcat004,xcat005 FROM xcat_t WHERE xcatent='"||g_enterprise||"' AND xcat001=? ","") RETURNING g_rtn_fields
   LET g_xcaz_d[p_ac].xcaz002 = g_rtn_fields[1]
   LET g_xcaz_d[p_ac].xcaz003 = g_rtn_fields[2]
   LET g_xcaz_d[p_ac].xcaz004 = g_rtn_fields[3]
   LET g_xcaz_d[p_ac].xcaz006 = g_rtn_fields[4]
   DISPLAY BY NAME g_xcaz_d[p_ac].xcaz002,g_xcaz_d[p_ac].xcaz003,g_xcaz_d[p_ac].xcaz004,g_xcaz_d[p_ac].xcaz006
   
   INITIALIZE g_ref_fields TO NULL   
   LET g_ref_fields[1] = p_xcaz009
   CALL ap_ref_array2(g_ref_fields,"SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"'  AND xcaul001=? AND xcaul002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcaz_d[p_ac].xcaul003 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcaz_d[p_ac].xcaul003  
END FUNCTION

################################################################################
# Descriptions...: 標準成本分料說明
# Memo...........:
# Usage..........: CALL axci101_xcaz011_desc(p_xcaz011)
#                  RETURNING r_xcaal003
# Input parameter: 
# Return code....: 
# Date & Author..: #160728-00025#2 160810 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axci101_xcaz011_desc(p_xcaz011)
DEFINE p_xcaz011  LIKE xcaz_t.xcaz011
DEFINE r_xcaal003 LIKE xcaal_t.xcaal003

  LET r_xcaal003 = ''
  SELECT xcaal003 INTO r_xcaal003
    FROM xcaal_t
   WHERE xcaalent = g_enterprise
     AND xcaal001 = p_xcaz011
     AND xcaal002 = g_dlang

  RETURN r_xcaal003

END FUNCTION

 
{</section>}
 
