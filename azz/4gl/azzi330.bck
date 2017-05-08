#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi330.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000063
#+ 
#+ Filename...: azzi330
#+ Description: 報表元件表頭設定作業
#+ Creator....: 02716(2014-09-23 13:37:48)
#+ Modifier...: 02716(2014-09-25 09:48:26) -SD/PR- 04010
#+ Buildtype..: 應用 i07 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="azzi330.global" >}
#+ Modifier...: No.161107-00014#1 16/11/14 Cynthia  新建入的報表元件代號也需異動
 
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
PRIVATE type type_g_gzgm_m        RECORD
       gzgm003 LIKE gzgm_t.gzgm003, 
   gzgm003_desc LIKE type_t.chr80, 
   gzgm002 LIKE gzgm_t.gzgm002
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzgm_d        RECORD
       gzgm001 LIKE type_t.chr500, 
   gzgm001_desc LIKE type_t.chr500, 
   gzgm004      LIKE gzgm_t.gzgm004,
   gzgmstus LIKE gzgm_t.gzgmstus
       END RECORD
PRIVATE TYPE type_g_gzgm2_d RECORD
       gzgmownid LIKE gzgm_t.gzgmownid, 
   gzgmownid_desc LIKE type_t.chr500, 
   gzgmowndp LIKE gzgm_t.gzgmowndp, 
   gzgmowndp_desc LIKE type_t.chr500, 
   gzgmcrtid LIKE gzgm_t.gzgmcrtid, 
   gzgmcrtid_desc LIKE type_t.chr500, 
   gzgmcrtdp LIKE gzgm_t.gzgmcrtdp, 
   gzgmcrtdp_desc LIKE type_t.chr500, 
   gzgmcrtdt DATETIME YEAR TO SECOND, 
   gzgmmodid LIKE gzgm_t.gzgmmodid, 
   gzgmmodid_desc LIKE type_t.chr500, 
   gzgmmoddt DATETIME YEAR TO SECOND, 
   gzgm001 LIKE gzgm_t.gzgm001
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_gzgm_m          type_g_gzgm_m
DEFINE g_gzgm_m_t        type_g_gzgm_m
DEFINE g_gzgm_m_o        type_g_gzgm_m
 
   DEFINE g_gzgm002_t LIKE gzgm_t.gzgm002
   DEFINE g_gzgm003_t LIKE gzgm_t.gzgm003 
 
DEFINE g_gzgm_d          DYNAMIC ARRAY OF type_g_gzgm_d
DEFINE g_gzgm_d_t        type_g_gzgm_d
DEFINE g_gzgm_d_o        type_g_gzgm_d
DEFINE g_gzgm2_d   DYNAMIC ARRAY OF type_g_gzgm2_d
DEFINE g_gzgm2_d_t type_g_gzgm2_d
DEFINE g_gzgm2_d_o type_g_gzgm2_d
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gzgm003 LIKE gzgm_t.gzgm003,  #141002 add
          b_gzgm002 LIKE gzgm_t.gzgm002
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
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
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
 
#add-point:自定義模組變數(Module Variable)
 TYPE type_g_gzde_d  RECORD
   gzde001 LIKE gzde_t.gzde001, 
   gzde001_desc LIKE gzdel_t.gzdel003
       END RECORD
DEFINE g_gzde_d DYNAMIC ARRAY OF type_g_gzde_d

DEFINE g_gzde_m  RECORD
       gzde002   LIKE gzde_t.gzde002
       END RECORD
       
DEFINE g_del_flag LIKE type_t.chr1                          #141110透過del_item()刪flag=1
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="azzi330.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = " SELECT gzgm003,'',gzgm002",  
                      " FROM gzgm_t",
                      " WHERE gzgm003=? AND gzgm002=?  FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi330_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.gzgm003,t0.gzgm002,t1.gzgjl003",
               " FROM gzgm_t t0",
                              " LEFT JOIN gzgjl_t t1 ON t1.gzgjl001=t0.gzgm003 AND t1.gzgjl002='"||g_lang||"' ",
 
               " WHERE t0.gzgm003 = ? AND t0.gzgm002 = ? "   #141002 add gzgm003
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define

   #end add-point
   PREPARE azzi330_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi330 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi330_init()   
 
      #進入選單 Menu (="N")
      CALL azzi330_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi330
      
   END IF 
   
   CLOSE azzi330_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="azzi330.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi330_init()
   #add-point:init段define
   
   #end add-point    
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
   IF FGL_GETENV("DGENV") = "s" THEN
      CALL cl_set_combo_module_reg("gzde002",1)
   ELSE
      CALL cl_set_combo_module("gzde002",1)
   END IF
   LET g_gzde_m.gzde002 ="AAP"
   DISPLAY g_gzde_m.gzde002 TO FORMONLY.gzde002
   CALL azzi330_get_gzde_data()
   CALL cl_set_combo_lang("gzgm_t.gzgm002")   
   #end add-point
   
   CALL azzi330_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi330.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi330_ui_dialog()
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
   
      CALL azzi330_browser_fill("")
 
      
      ##判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      #IF g_state = "Y" THEN
      #   FOR li_idx = 1 TO g_browser.getLength()
      #      IF g_browser[li_idx].b_gzgm002 = g_gzgm002_t
 
      #         THEN
      #         LET g_current_row = li_idx
      #         EXIT FOR
      #      END IF
      #   END FOR
      #   LET g_state = ""
      #END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_gzgm_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL azzi330_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_gzgm2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL azzi330_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         
         
         #報表元件清單
         DISPLAY ARRAY g_gzde_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL azzi330_ui_detailshow()

            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               
               #控制stus哪個按鈕可以按
               
            ON ACTION add_item
               IF l_ac IS NOT NULL THEN
                  CALL azzi330_add_gzgm(l_ac)            
               END IF
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF               
         END DISPLAY
         
     INPUT BY NAME g_gzde_m.gzde002
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF

         ON CHANGE gzde002
            CALL azzi330_get_gzde_data()
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgm002
           
            DISPLAY BY NAME g_gzgm_m.gzgm002             

      END INPUT
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
               CALL azzi330_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi330_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2

            #end add-point
 
         
         
         ON ACTION first
            CALL azzi330_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL azzi330_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL azzi330_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL azzi330_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL azzi330_fetch('L')
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
               NEXT FIELD gzgm001
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
               CALL azzi330_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL azzi330_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL azzi330_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi330_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi330_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         #140925 janet mark -(s)
#         ON ACTION add_item
#            LET g_action_choice="add_item"
#            IF cl_auth_chk_act("add_item") THEN
          #140925 janet mark -(s)      
               #add-point:ON ACTION add_item

               #END add-point
               
            #END IF  #140925 janet mark
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi330_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi330_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi330_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi330_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL azzi330_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi330_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi330_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
         ##表頭作業設定作業
         ON ACTION set_head
            CALL azzi330_01()
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)  ##141110 add
         
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
 
{<section id="azzi330.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION azzi330_browser_search(p_type)
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
      LET g_wc = g_wc, " ORDER BY gzgm002"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL azzi330_browser_fill("F")
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi330_browser_fill(ps_page_action)
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
 
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "gzgm002"
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
      LET l_sub_sql = " SELECT UNIQUE gzgm003,gzgm002 ",   #141002 add gzgm003
 
                      " FROM gzgm_t ",
                      " ",
                      " ",
 
                      " WHERE  ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzgm_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE gzgm003,gzgm002 ",   #141002 add gzgm003
 
                      " FROM gzgm_t ",
                      " ",
                      " ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzgm_t")
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
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_gzgm_m.* TO NULL
      CALL g_gzgm_d.clear()        
      CALL g_gzgm2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_browser.getLength() + 1
      LET g_add_browse = ""
   END IF
 
   #依照t0.gzgm002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gzgm003,t0.gzgm002",    #141002 add gzgm003
                " FROM gzgm_t t0",
 
                
                " WHERE  ", l_wc," AND ",l_wc2, cl_sql_add_filter("gzgm_t")
 
   #add-point:browser_fill,sql_rank前

   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前

   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzgm_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   #CALL g_browser.clear()
   #LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_gzgm003,g_browser[g_cnt].b_gzgm002    #141002 add gzgm003
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
      INITIALIZE g_gzgm_m.* TO NULL
      CALL g_gzgm_d.clear()
      CALL g_gzgm2_d.clear()
 
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
   
   #add-point:browser_fill段結束前

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi330_ui_headershow()
   #add-point:ui_headershow段define

   #end add-point    
   
   LET g_gzgm_m.gzgm002 = g_browser[g_current_idx].b_gzgm002 
   LET g_gzgm_m.gzgm003 = g_browser[g_current_idx].b_gzgm003    #141002 add gzgm003
 
   EXECUTE azzi330_master_referesh USING g_gzgm_m.gzgm003,g_gzgm_m.gzgm002 INTO g_gzgm_m.gzgm003,g_gzgm_m.gzgm002,g_gzgm_m.gzgm003_desc    #141002 add gzgm003
 
   CALL azzi330_show()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi330_ui_detailshow()
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
 
{<section id="azzi330.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi330_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzgm002 = g_gzgm_m.gzgm002 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser.getLength()
   #IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
   #   LET g_current_row = g_browser_cnt
   #END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi330_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   DEFINE l_cnt       LIKE type_t.num5
   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_gzgm_m.* TO NULL
   CALL g_gzgm_d.clear()
   CALL g_gzgm2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外

   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzgm003,gzgm002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
                 #此段落由子樣板a01產生
         BEFORE FIELD gzgm003
            #add-point:BEFORE FIELD gzgm003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgm003
            
            #add-point:AFTER FIELD gzgm003

            #END add-point
            
 
         #Ctrlp:construct.c.gzgm003
         ON ACTION controlp INFIELD gzgm003
            #add-point:ON ACTION controlp INFIELD gzgm003
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            CALL q_gzgj001()
            LET g_gzgm_m.gzgm003 = g_qryparam.return1
            LET g_gzgm_m.gzgm003_desc = g_qryparam.return2
            DISPLAY g_gzgm_m.gzgm003 TO gzgm003
            DISPLAY g_gzgm_m.gzgm003_desc TO gzgm003_desc
            ###  ### end ###
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgm002
            #add-point:BEFORE FIELD gzgm002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgm002
            
            #add-point:AFTER FIELD gzgm002

            #END add-point
            
 
         #Ctrlp:construct.c.gzgm002
         ON ACTION controlp INFIELD gzgm002
            #add-point:ON ACTION controlp INFIELD gzgm002

            #END add-point
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gzgm001,gzgm004,gzgmstus,gzgmownid,gzgmowndp,gzgmcrtid,gzgmcrtdp,gzgmcrtdt,gzgmmodid, 
          gzgmmoddt
           FROM s_detail1[1].gzgm001,s_detail1[1].gzgm004,s_detail1[1].gzgmstus,s_detail2[1].gzgmownid,s_detail2[1].gzgmowndp, 
               s_detail2[1].gzgmcrtid,s_detail2[1].gzgmcrtdp,s_detail2[1].gzgmcrtdt,s_detail2[1].gzgmmodid, 
               s_detail2[1].gzgmmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<gzgmcrtdt>>----
         AFTER FIELD gzgmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzgmmoddt>>----
         AFTER FIELD gzgmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzgmcnfdt>>----
         
         #----<<gzgmpstdt>>----
 
 
           
         #單身一般欄位開窗相關處理
                  #此段落由子樣板a01產生
         BEFORE FIELD gzgm001
            #add-point:BEFORE FIELD gzgm001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgm001
            
            #add-point:AFTER FIELD gzgm001
           
               LET l_cnt = 0
               SELECT COUNT(gzde001) INTO l_cnt FROM gzde_t
               # WHERE gzdestus ='Y' ANd gzde001 = g_gzgm_d[1].gzgm001 AND gzde005='G'                 #141104 mark
                WHERE gzdestus ='Y' ANd gzde001 = g_gzgm_d[1].gzgm001 AND (gzde005='G' OR gzde005='X') #141104 add
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "azz-00698"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()            
                  NEXT FIELD CURRENT
               END IF
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzgm001
         ON ACTION controlp INFIELD gzgm001
            #add-point:ON ACTION controlp INFIELD gzgm001
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzge001_4()
            LET g_gzgm_d[1].gzgm001 = g_qryparam.return1
            LET g_gzgm_d[1].gzgm001_desc = g_qryparam.return2
            DISPLAY g_gzgm_d[1].gzgm001 TO gzgm001
            DISPLAY g_gzgm_d[1].gzgm001_desc TO gzgm001_desc
            ###  ### end ###
            #END add-point
 
          #此段落由子樣板a01產生
         BEFORE FIELD gzgm004
            #add-point:BEFORE FIELD gzgmstus
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgm004
            
            #add-point:AFTER FIELD gzgmstus
 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmstus
            #add-point:BEFORE FIELD gzgmstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgmstus
            
            #add-point:AFTER FIELD gzgmstus

            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzgmstus
         ON ACTION controlp INFIELD gzgmstus
            #add-point:ON ACTION controlp INFIELD gzgmstus

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmownid
            #add-point:BEFORE FIELD gzgmownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgmownid
            
            #add-point:AFTER FIELD gzgmownid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgmownid
         ON ACTION controlp INFIELD gzgmownid
            #add-point:ON ACTION controlp INFIELD gzgmownid

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmowndp
            #add-point:BEFORE FIELD gzgmowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgmowndp
            
            #add-point:AFTER FIELD gzgmowndp

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgmowndp
         ON ACTION controlp INFIELD gzgmowndp
            #add-point:ON ACTION controlp INFIELD gzgmowndp

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmcrtid
            #add-point:BEFORE FIELD gzgmcrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgmcrtid
            
            #add-point:AFTER FIELD gzgmcrtid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgmcrtid
         ON ACTION controlp INFIELD gzgmcrtid
            #add-point:ON ACTION controlp INFIELD gzgmcrtid

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmcrtdp
            #add-point:BEFORE FIELD gzgmcrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgmcrtdp
            
            #add-point:AFTER FIELD gzgmcrtdp

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgmcrtdp
         ON ACTION controlp INFIELD gzgmcrtdp
            #add-point:ON ACTION controlp INFIELD gzgmcrtdp

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmcrtdt
            #add-point:BEFORE FIELD gzgmcrtdt

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmmodid
            #add-point:BEFORE FIELD gzgmmodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgmmodid
            
            #add-point:AFTER FIELD gzgmmodid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgmmodid
         ON ACTION controlp INFIELD gzgmmodid
            #add-point:ON ACTION controlp INFIELD gzgmmodid

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmmoddt
            #add-point:BEFORE FIELD gzgmmoddt

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
 
{<section id="azzi330.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi330_query()
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
   CALL g_gzgm_d.clear()
   CALL g_gzgm2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL azzi330_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi330_browser_fill(g_wc)
      CALL azzi330_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL azzi330_browser_fill("F")
   
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
      CALL azzi330_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi330_fetch(p_flag)
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
   
   CALL azzi330_browser_fill(p_flag)
   
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
   
   LET g_gzgm_m.gzgm002 = g_browser[g_current_idx].b_gzgm002
   LET g_gzgm_m.gzgm003 = g_browser[g_current_idx].b_gzgm003  #141001 add
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi330_master_referesh USING g_gzgm_m.gzgm003,g_gzgm_m.gzgm002 INTO g_gzgm_m.gzgm003,g_gzgm_m.gzgm002,g_gzgm_m.gzgm003_desc  #141002 add gegm003
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzgm_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_gzgm_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_dept =   
   
   #保存單頭舊值
   LET g_gzgm_m_t.* = g_gzgm_m.*
   LET g_gzgm_m_o.* = g_gzgm_m.*
   
   #重新顯示   
   CALL azzi330_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi330_insert()
   #add-point:insert段define
   
   #end add-point    
   
   #add-point:insert段before
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gzgm_d.clear()
   CALL g_gzgm2_d.clear()
 
 
   INITIALIZE g_gzgm_m.* LIKE gzgm_t.*             #DEFAULT 設定
   LET g_gzgm002_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值
      
      #end add-point 
 
      CALL azzi330_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzgm_m.* = g_gzgm_m_t.*
         CALL azzi330_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gzgm_m.* TO NULL
         INITIALIZE g_gzgm_d TO NULL
         INITIALIZE g_gzgm2_d TO NULL
 
         CALL azzi330_show()
         RETURN
      END IF
    
      #CALL g_gzgm_d.clear()
      #CALL g_gzgm2_d.clear()
 
      
      #add-point:單頭輸入後2
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzgm002_t = g_gzgm_m.gzgm002
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzgm002 = '", g_gzgm_m.gzgm002 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi330_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi330_modify()
   #add-point:modify段define

   #end add-point    
   
   IF g_gzgm_m.gzgm002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE azzi330_master_referesh USING g_gzgm_m.gzgm003 ,g_gzgm_m.gzgm002 INTO g_gzgm_m.gzgm003,g_gzgm_m.gzgm002,g_gzgm_m.gzgm003_desc 
 
 
   ERROR ""
  
   LET g_gzgm002_t = g_gzgm_m.gzgm002
   LET g_gzgm003_t = g_gzgm_m.gzgm003
 
   CALL s_transaction_begin()
   
   OPEN azzi330_cl USING g_gzgm_m.gzgm003,g_gzgm_m.gzgm002
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi330_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi330_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH azzi330_cl INTO g_gzgm_m.gzgm003,g_gzgm_m.gzgm003_desc,g_gzgm_m.gzgm002
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_gzgm_m.gzgm002 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE azzi330_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL azzi330_show()
   WHILE TRUE
      LET g_gzgm002_t = g_gzgm_m.gzgm002
      LET g_gzgm003_t = g_gzgm_m.gzgm003
 
      #add-point:modify段修改前

      #end add-point
      
      CALL azzi330_input("u")     #欄位更改
      
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzgm_m.* = g_gzgm_m_t.*
         CALL azzi330_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_gzgm_m.gzgm002 != g_gzgm002_t AND g_gzgm_m.gzgm003 != g_gzgm003_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前

         #end add-point
         
         #更新單頭key值
         UPDATE gzgm_t SET gzgm002 = g_gzgm_m.gzgm002 ,gzgm003 = g_gzgm_m.gzgm003
 
          WHERE  gzgm002 = g_gzgm002_t AND gzgm003 = g_gzgm003_t
 
         #add-point:單頭(偽)修改中

         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgm_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgm_t" 
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
   #IF NOT cl_log_modified_record(g_gzgm_m.gzgm002,g_site) THEN 
   #   CALL s_transaction_end('N','0')
   #END IF
 
   CLOSE azzi330_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_gzgm_m.gzgm002,'U')
 
   #CALL azzi330_b_fill("1=1")
   
END FUNCTION   
 
{</section>}
 
{<section id="azzi330.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi330_input(p_cmd)
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
   DEFINE l_save_flag            LIKE type_t.chr1   #161107-00014#1 add
   #end add-point    
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzgm_m.gzgm003,g_gzgm_m.gzgm003_desc,g_gzgm_m.gzgm002
   
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
   LET g_forupd_sql = "SELECT gzgm001,gzgm004,gzgmstus,gzgmownid,gzgmowndp,gzgmcrtid,gzgmcrtdp,gzgmcrtdt,gzgmmodid, 
       gzgmmoddt,gzgm001 FROM gzgm_t WHERE gzgm002=? AND gzgm001=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi330_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi330_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL azzi330_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
   DISPLAY BY NAME g_gzgm_m.gzgm003,g_gzgm_m.gzgm002
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前
   #140924
   DISPLAY BY NAME g_gzde_m.gzde002
   LET l_save_flag = "N"   #161107-00014#1 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi330.input.head" >}
   
      #單頭段
      INPUT BY NAME g_gzgm_m.gzgm003,g_gzgm_m.gzgm002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前
            LET g_del_flag = 0 
            #end add-point
          
                  #此段落由子樣板a02產生
         AFTER FIELD gzgm003
            
            #add-point:AFTER FIELD gzgm003
            #確認資料無重複
            LET l_cnt = 0
            SELECT COUNT(gzgj001) INTO l_cnt FROM gzgj_t
             WHERE gzgj001 = g_gzgm_m.gzgm003 AND gzgjstus ='Y' #AND gzgj002 = g_gzgm_m.gzgm002
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "azz-00699"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()               
               NEXT FIELD CURRENT               
            END IF  
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzgm_m.gzgm003
            CALL ap_ref_array2(g_ref_fields,"SELECT gzgjl003 FROM gzgjl_t WHERE gzgjl001=? AND gzgjl002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzgm_m.gzgm003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzgm_m.gzgm003_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgm003
            #add-point:BEFORE FIELD gzgm003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gzgm003
            #add-point:ON CHANGE gzgm003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgm002
            #add-point:BEFORE FIELD gzgm002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgm002
            
            #add-point:AFTER FIELD gzgm002
            #此段落由子樣板a05產生
          
            
            #140925 janet mark -(s)
#            IF  NOT cl_null(g_gzgm_m.gzgm002) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzgm_m.gzgm002 != g_gzgm002_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgm_t WHERE "||"gzgm002 = '"||g_gzgm_m.gzgm002 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
             #140925 janet mark -(e)


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgm002
            #add-point:ON CHANGE gzgm002
            #確認資料無重複
            LET l_cnt = 0
            SELECT COUNT(gzgj001) INTO l_cnt FROM gzgj_t
             WHERE gzgj001 = g_gzgm_m.gzgm003 AND gzgjstus ='Y' AND gzgj002 = g_gzgm_m.gzgm002
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "azz-00699"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()               
               NEXT FIELD CURRENT             
            END IF  
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.gzgm003
         ON ACTION controlp INFIELD gzgm003
            #add-point:ON ACTION controlp INFIELD gzgm003
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            CALL q_gzgj001()
            LET g_gzgm_m.gzgm003 = g_qryparam.return1
            LET g_gzgm_m.gzgm003_desc = g_qryparam.return2
            DISPLAY g_gzgm_m.gzgm003 TO gzgm003
            DISPLAY g_gzgm_m.gzgm003_desc TO gzgm003_desc
            ###  ### end ###

            #END add-point
 
         #Ctrlp:input.c.gzgm002
         ON ACTION controlp INFIELD gzgm002
            #add-point:ON ACTION controlp INFIELD gzgm002

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
            DISPLAY BY NAME g_gzgm_m.gzgm002             
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               #141106 add -(s)
               LET l_cnt = 0
               IF g_gzgm_m.gzgm003 IS NOT NULL AND g_gzgm_m.gzgm002 IS NOT NULL THEN
                  SELECT COUNT(*) INTO l_cnt FROM gzgk_t
                   WHERE gzgkstus ='Y' AND gzgk001 = g_gzgm_m.gzgm003 
                     AND gzgk002 = g_gzgm_m.gzgm002
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "azz-00710" 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()                     
                  END IF                  
               END IF
               #141106 add -(e)
               #end add-point
            
               UPDATE gzgm_t SET (gzgm003,gzgm002) = (g_gzgm_m.gzgm003,g_gzgm_m.gzgm002)
                WHERE  gzgm002 = g_gzgm002_t
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgm_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgm_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzgm_m.gzgm002
               LET gs_keys_bak[1] = g_gzgm002_t
               LET gs_keys[2] = g_gzgm_d[g_detail_idx].gzgm001
               LET gs_keys_bak[2] = g_gzgm_d_t.gzgm001
               CALL azzi330_update_b('gzgm_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_gzgm002_t = g_gzgm_m.gzgm002
 
                     #add-point:單頭修改後

                     #end add-point
                     
                     LET g_log1 = util.JSON.stringify(g_gzgm_m_t)
                     LET g_log2 = util.JSON.stringify(g_gzgm_m)
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
                  CALL azzi330_detail_reproduce()
               END IF
            END IF
           #controlp
                     
           LET g_gzgm002_t = g_gzgm_m.gzgm002
 
           
           #若單身還沒有輸入資料, 強制切換至單身
           #IF cl_null(g_gzgm_d[1].gzgm001) THEN
           #   CALL g_gzgm_d.deleteElement(1)
           #   NEXT FIELD gzgm001
           #END IF
           #140925 janet mark -(s)
#           IF g_gzgm_d.getLength() = 0 THEN
#              NEXT FIELD gzgm001
#           END IF
           #140925 jaent mark -(e)
      END INPUT
 
{</section>}
 
{<section id="azzi330.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzgm_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         #+ 此段落由子樣板a43產生
         ON ACTION del_item
            LET g_action_choice="del_item"
            IF cl_auth_chk_act("del_item") THEN
               
               #add-point:ON ACTION del_item
                CALL azzi330_del_gzgm(l_ac)
               #END add-point
            END IF
 
 
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzgm_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi330_b_fill(g_wc2) 
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
               OPEN azzi330_cl USING 
                                g_gzgm_m.gzgm003, g_gzgm_m.gzgm002
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi330_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE azzi330_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_gzgm_d[l_ac].gzgm001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzgm_d_t.* = g_gzgm_d[l_ac].*  #BACKUP
               LET g_gzgm_d_o.* = g_gzgm_d[l_ac].*  #BACKUP
               CALL azzi330_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL azzi330_set_no_entry_b(l_cmd)
               OPEN azzi330_bcl USING g_gzgm_m.gzgm002,
 
                                                g_gzgm_d_t.gzgm001
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi330_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi330_bcl INTO g_gzgm_d[l_ac].gzgm001,g_gzgm_d[l_ac].gzgm004,g_gzgm_d[l_ac].gzgmstus,g_gzgm2_d[l_ac].gzgmownid, 
                      g_gzgm2_d[l_ac].gzgmowndp,g_gzgm2_d[l_ac].gzgmcrtid,g_gzgm2_d[l_ac].gzgmcrtdp, 
                      g_gzgm2_d[l_ac].gzgmcrtdt,g_gzgm2_d[l_ac].gzgmmodid,g_gzgm2_d[l_ac].gzgmmoddt, 
                      g_gzgm2_d[l_ac].gzgm001
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gzgm_d_t.gzgm001 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL azzi330_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_gzgm_d_t.* TO NULL
            INITIALIZE g_gzgm_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzgm_d[l_ac].* TO NULL
            #公用欄位預設值
            #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_gzgm2_d[l_ac].gzgmownid = g_user
      LET g_gzgm2_d[l_ac].gzgmowndp = g_dept
      LET g_gzgm2_d[l_ac].gzgmcrtid = g_user
      LET g_gzgm2_d[l_ac].gzgmcrtdp = g_dept 
      LET g_gzgm2_d[l_ac].gzgmcrtdt = cl_get_current()
      LET g_gzgm2_d[l_ac].gzgmmodid = ""
      LET g_gzgm2_d[l_ac].gzgmmoddt = ""
      LET g_gzgm_d[l_ac].gzgmstus = ""
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份
            #確認資料無重複
            LET l_cnt = 0
            SELECT COUNT(gzgj001) INTO l_cnt FROM gzgj_t
             WHERE gzgj001 = g_gzgm_m.gzgm003 AND gzgjstus ='Y' AND gzgj002 = g_gzgm_m.gzgm002
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "azz-00699"
               LET g_errparam.extend = ""
               LET g_errparam.popup = FALSE
               CALL cl_err()               
               EXIT DIALOG          
            END IF  
            
            LET g_gzgm_d[l_ac].gzgmstus ="Y"##140925 janet add
            #LET g_gzgm_d[l_ac].gzgm004 ="N"   #141002 客製 mark
            LET g_gzgm_d[l_ac].gzgm004 ="s"   #141002 客製 add
            IF FGL_GETENV("DGENV") ="c" THEN
               #LET g_gzgm_d[l_ac].gzgm004 ="Y"   #141002 客製 mark
               LET g_gzgm_d[l_ac].gzgm004 ="c"   #141002 客製 add
            END IF
            #end add-point
            LET g_gzgm_d_t.* = g_gzgm_d[l_ac].*     #新輸入資料
            LET g_gzgm_d_o.* = g_gzgm_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi330_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL azzi330_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzgm_d[li_reproduce_target].* = g_gzgm_d[li_reproduce].*
               LET g_gzgm2_d[li_reproduce_target].* = g_gzgm2_d[li_reproduce].*
 
               LET g_gzgm_d[g_gzgm_d.getLength()].gzgm001 = NULL
 
            END IF
            
            #add-point:modify段before insert
            #140925 janet add -(s)
#            IF g_gzgm_d[l_ac].gzgm001 IS NULL THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'INSERT' 
#               LET g_errparam.code   = "std-00006" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               INITIALIZE g_gzgm_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT               
#            END IF
            #140925 janet add -(e)
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
            SELECT COUNT(*) INTO l_count FROM gzgm_t 
             WHERE  gzgm002 = g_gzgm_m.gzgm002
 
               AND gzgm001 = g_gzgm_d[l_ac].gzgm001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
               INSERT INTO gzgm_t
                           (
                            gzgm003,gzgm002,
                            gzgm001,gzgm004
                            ,gzgmstus,gzgmownid,gzgmowndp,gzgmcrtid,gzgmcrtdp,gzgmcrtdt,gzgmmodid,gzgmmoddt) 
                     VALUES(
                            g_gzgm_m.gzgm003,g_gzgm_m.gzgm002,
                            g_gzgm_d[l_ac].gzgm001,g_gzgm_d[l_ac].gzgm004
                            ,g_gzgm_d[l_ac].gzgmstus,g_gzgm2_d[l_ac].gzgmownid,g_gzgm2_d[l_ac].gzgmowndp, 
                                g_gzgm2_d[l_ac].gzgmcrtid,g_gzgm2_d[l_ac].gzgmcrtdp,g_gzgm2_d[l_ac].gzgmcrtdt, 
                                g_gzgm2_d[l_ac].gzgmmodid,g_gzgm2_d[l_ac].gzgmmoddt)
               #add-point:單身新增中

               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_gzgm_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgm_t" 
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
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後
            LET g_gzgm_d[l_ac].gzgmstus ="Y"##140925 janet add
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
               IF azzi330_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE azzi330_bcl
               LET l_count = g_gzgm_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzgm_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a02產生
         AFTER FIELD gzgm001
            
            #add-point:AFTER FIELD gzgm001
            #此段落由子樣板a05產生
            #確認資料無重複
            #140925 janet mark -(s)
#            IF  g_gzgm_m.gzgm002 IS NOT NULL AND g_gzgm_d[g_detail_idx].gzgm001 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzgm_m.gzgm002 != g_gzgm002_t OR g_gzgm_d[g_detail_idx].gzgm001 != g_gzgm_d_t.gzgm001)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgm_t WHERE "||"gzgm002 = '"||g_gzgm_m.gzgm002 ||"' AND "|| "gzgm001 = '"||g_gzgm_d[g_detail_idx].gzgm001 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #140925 janet mark -(e)   
           IF g_gzgm_d[l_ac].gzgm001 IS NOT NULL AND NOT cl_null(g_gzgm_d[l_ac].gzgm001) THEN             
               LET l_cnt = 0
               SELECT COUNT(gzde001) INTO l_cnt FROM gzde_t
                #WHERE gzdestus ='Y' AND gzde001 = g_gzgm_d[l_ac].gzgm001 AND gzde005='G'  #141104 mark
                WHERE gzdestus ='Y' AND gzde001 = g_gzgm_d[l_ac].gzgm001 AND (gzde005='G' OR gzde005='X')   #141104 add
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "azz-00698"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()            
                  NEXT FIELD CURRENT
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzgm_d[l_ac].gzgm001
            CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzgm_d[l_ac].gzgm001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzgm_d[l_ac].gzgm001_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgm001
            #add-point:BEFORE FIELD gzgm001

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gzgm001
            #add-point:ON CHANGE gzgm001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgmstus
            #add-point:BEFORE FIELD gzgmstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgmstus
            
            #add-point:AFTER FIELD gzgmstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgmstus
            #add-point:ON CHANGE gzgmstus

            #END add-point
 
          #此段落由子樣板a01產生
         BEFORE FIELD gzgm004
            #add-point:BEFORE FIELD gzgm004
            #LET g_gzgm_d[l_ac].gzgm004 ="Y"   #141002 客製 mark
            LET g_gzgm_d[l_ac].gzgm004 ="s"   #141002 客製 add
            IF FGL_GETENV("DGENV")="c" THEN
               #LET g_gzgm_d[l_ac].gzgm004 ="Y"   #141002 客製 mark
               LET g_gzgm_d[l_ac].gzgm004 ="c"   #141002 客製 add         
            END IF
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgm004
            
            #add-point:AFTER FIELD gzgm004
            #LET g_gzgm_d[l_ac].gzgm004 ="Y"   #141002 客製 mark
            LET g_gzgm_d[l_ac].gzgm004 ="s"   #141002 客製 add
            IF FGL_GETENV("DGENV")="c" THEN
               #LET g_gzgm_d[l_ac].gzgm004 ="Y"   #141002 客製 mark
               LET g_gzgm_d[l_ac].gzgm004 ="c"   #141002 客製 add 
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgm004
            #add-point:ON CHANGE gzgm004
            #LET g_gzgm_d[l_ac].gzgm004 ="Y"   #141002 客製 mark
            LET g_gzgm_d[l_ac].gzgm004 ="s"   #141002 客製 add
            IF FGL_GETENV("DGENV")="c" THEN
               #LET g_gzgm_d[l_ac].gzgm004 ="Y"   #141002 客製 mark
               LET g_gzgm_d[l_ac].gzgm004 ="c"   #141002 客製 add
            END IF
            #END add-point
 
 
 
                  #Ctrlp:input.c.page1.gzgm001
         ON ACTION controlp INFIELD gzgm001
            #add-point:ON ACTION controlp INFIELD gzgm001
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.default2 = ""
            LET g_qryparam.where = "1=1"
            CALL q_dzge001_4()
            LET g_gzgm_d[l_ac].gzgm001 = g_qryparam.return1
            LET g_gzgm_d[l_ac].gzgm001_desc = g_qryparam.return2
            DISPLAY g_gzgm_d[l_ac].gzgm001 TO gzgm001
            DISPLAY g_gzgm_d[l_ac].gzgm001_desc TO gzgm001_desc
            ###  ### end ###


            #END add-point
 
         #Ctrlp:input.c.page1.gzgmstus
         ON ACTION controlp INFIELD gzgmstus
            #add-point:ON ACTION controlp INFIELD gzgmstus

 
 
 
         ON ROW CHANGE
            ##141110 add -(s)
            ##透過del_item()刪資料，不需進update段
            IF g_del_flag = 1 THEN
               EXIT DIALOG             
            END IF
            ##141110 add -(e)
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_gzgm_d[l_ac].* = g_gzgm_d_t.*
               CLOSE azzi330_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzgm_d[l_ac].gzgm001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_gzgm_d[l_ac].* = g_gzgm_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gzgm2_d[l_ac].gzgmmodid = g_user 
LET g_gzgm2_d[l_ac].gzgmmoddt = cl_get_current()
LET g_gzgm2_d[l_ac].gzgmmodid_desc = cl_get_username(g_gzgm2_d[l_ac].gzgmmodid)
            
               #add-point:單身修改前

               #end add-point
         
               UPDATE gzgm_t SET (gzgm002,gzgm001,gzgm004,gzgmstus,gzgmownid,gzgmowndp,gzgmcrtid,gzgmcrtdp,gzgmcrtdt, 
                   gzgmmodid,gzgmmoddt) = (g_gzgm_m.gzgm002,g_gzgm_d[l_ac].gzgm001,g_gzgm_d[l_ac].gzgm004,g_gzgm_d[l_ac].gzgmstus, 
                   g_gzgm2_d[l_ac].gzgmownid,g_gzgm2_d[l_ac].gzgmowndp,g_gzgm2_d[l_ac].gzgmcrtid,g_gzgm2_d[l_ac].gzgmcrtdp, 
                   g_gzgm2_d[l_ac].gzgmcrtdt,g_gzgm2_d[l_ac].gzgmmodid,g_gzgm2_d[l_ac].gzgmmoddt)
                WHERE  gzgm002 = g_gzgm_m.gzgm002 
 
                 AND gzgm001 = g_gzgm_d_t.gzgm001 #項次   
 
                 
               #add-point:單身修改中

               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgm_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gzgm_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzgm_m.gzgm002
               LET gs_keys_bak[1] = g_gzgm002_t
               LET gs_keys[2] = g_gzgm_d[g_detail_idx].gzgm001
               LET gs_keys_bak[2] = g_gzgm_d_t.gzgm001
               CALL azzi330_update_b('gzgm_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_gzgm_m),util.JSON.stringify(g_gzgm_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzgm_m),util.JSON.stringify(g_gzgm_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後

               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            ##141002因為要能切換至左邊list，所以此處不判斷陣列筆數
#            IF g_gzgm_d.getLength() = 0 THEN
#               NEXT FIELD gzgm001
#            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_gzgm_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzgm_d.getLength()+1
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_gzgm2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL azzi330_b_fill(g_wc2) 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL azzi330_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為

         #end add-point
         
      END DISPLAY
 
      
 
      
      #add-point:input段more_input
      #報表元件清單單頭
      INPUT BY NAME g_gzde_m.gzde002
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF

         ON CHANGE gzde002
            CALL azzi330_get_gzde_data()
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgm002
           
            DISPLAY BY NAME g_gzgm_m.gzgm002             

      END INPUT
       #報表元件清單單身
         DISPLAY ARRAY g_gzde_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               #多選
               CALL DIALOG.setSelectionMode("s_detail3", 1)
               CALL azzi330_ui_detailshow()

            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               
               #控制stus哪個按鈕可以按
               
            ON ACTION add_item
               IF l_ac IS NOT NULL THEN
                  CALL azzi330_add_gzgm(l_ac)            
               END IF
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF               
               
         END DISPLAY
         
         
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog
         LET g_curr_diag = ui.Dialog.getCurrent()   #140925 janet
         #end add-point 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD gzgm002
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzgm001
               WHEN "s_detail2"
                  NEXT FIELD gzgmownid
 
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
         LET l_save_flag = "Y"   #161107-00014#1 add
         #161107-00014#1 mark(s)
#         ##完成後修改4rp
#         IF g_gzgm_m.gzgm003 IS NOT NULL AND g_gzgm_m.gzgm002 IS NOT NULL THEN
#            CALL s_azzi330_repheader_chk(g_gzgm_m.gzgm003,g_gzgm_m.gzgm002)
#            IF cl_ask_confirm('azz-00711') THEN
#               CALL s_azzi330_4rp_progress(g_gzgm_m.gzgm003,g_gzgm_m.gzgm002)
#            END IF
#         END IF
         #161107-00014#1 mark(e)
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
   #161107-00014#1 add(s)
   ##完成後修改4rp
   IF l_save_flag = "Y" THEN
      IF g_gzgm_m.gzgm003 IS NOT NULL AND g_gzgm_m.gzgm002 IS NOT NULL THEN
         CALL s_azzi330_repheader_chk(g_gzgm_m.gzgm003,g_gzgm_m.gzgm002)
         IF cl_ask_confirm('azz-00711') THEN
            CALL s_azzi330_4rp_progress(g_gzgm_m.gzgm003,g_gzgm_m.gzgm002)
         END IF
      END IF
   END IF
   #161107-00014#1 add(e)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi330_show()
   #add-point:show段define
   
   #end add-point
   
   #add-point:show段之前
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL azzi330_b_fill(g_wc2) #單身填充
      CALL azzi330_b_fill2('0') #單身填充
   END IF
   
   
 
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL azzi330_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   DISPLAY BY NAME g_gzgm_m.gzgm003,g_gzgm_m.gzgm003_desc,g_gzgm_m.gzgm002
   CALL azzi330_b_fill(g_wc2_table1)                 #單身
   CALL azzi330_b_fill2('0') #單身填充
 
   CALL azzi330_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION azzi330_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzgm_d.getLength()
      #add-point:ref_show段d_reference
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gzgm2_d.getLength()
      #add-point:ref_show段d2_reference
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi330_reproduce()
   DEFINE l_newno     LIKE gzgm_t.gzgm002 
   DEFINE l_oldno     LIKE gzgm_t.gzgm002 
 
   DEFINE l_master    RECORD LIKE gzgm_t.*
   DEFINE l_detail    RECORD LIKE gzgm_t.*
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_gzgm_m.gzgm002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   LET g_gzgm002_t = g_gzgm_m.gzgm002
 
   
   LET g_gzgm_m.gzgm002 = ""
 
    
   CALL azzi330_set_entry('a')
   CALL azzi330_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   CALL azzi330_input("r")
   
   
    
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_gzgm_m.* TO NULL
      INITIALIZE g_gzgm_d TO NULL
      INITIALIZE g_gzgm2_d TO NULL
 
      CALL azzi330_show()
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzgm002_t = g_gzgm_m.gzgm002
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzgm002 = '", g_gzgm_m.gzgm002 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi330_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi330_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzgm_t.*
 
 
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi330_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE azzi330_detail AS ",
                "SELECT * FROM gzgm_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi330_detail SELECT * FROM gzgm_t 
                                         WHERE  gzgm002 = g_gzgm002_t
 
   
   #將key修正為調整後   
   UPDATE azzi330_detail 
      #更新key欄位
      SET gzgm002 = g_gzgm_m.gzgm002
 
      #更新共用欄位
      #此段落由子樣板a13產生
       , gzgmownid = g_user
       , gzgmowndp = g_dept
       , gzgmcrtid = g_user
       , gzgmcrtdp = g_dept 
       , gzgmcrtdt = ld_date
       , gzgmmodid = "" 
       , gzgmmoddt = "" 
      #, gzgmstus = "Y"
 
 
                                       
   #將資料塞回原table   
   INSERT INTO gzgm_t SELECT * FROM azzi330_detail
   
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
   DROP TABLE azzi330_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzgm002_t = g_gzgm_m.gzgm002
 
   
   DROP TABLE azzi330_detail
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi330_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   
   IF g_gzgm_m.gzgm002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE azzi330_master_referesh USING g_gzgm_m.gzgm003,g_gzgm_m.gzgm002 INTO g_gzgm_m.gzgm003,g_gzgm_m.gzgm002,g_gzgm_m.gzgm003_desc 
 
   
   CALL azzi330_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN azzi330_cl USING g_gzgm_m.gzgm003,g_gzgm_m.gzgm002
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi330_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi330_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH azzi330_cl INTO g_gzgm_m.gzgm003,g_gzgm_m.gzgm003_desc,g_gzgm_m.gzgm002
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_gzgm_m.gzgm002 
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
      CALL azzi330_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
 
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM gzgm_t WHERE  gzgm002 = g_gzgm_m.gzgm002
 
                                                               
      #add-point:單身刪除中

      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzgm_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 

      #end add-point
      
 
      
      CLEAR FORM
      CALL g_gzgm_d.clear() 
      CALL g_gzgm2_d.clear()       
 
     
      CALL azzi330_ui_browser_refresh()  
      CALL azzi330_ui_headershow()  
      CALL azzi330_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL azzi330_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL azzi330_browser_fill("F")
         CLEAR FORM
      END IF
       
   END IF
 
   CLOSE azzi330_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_gzgm_m.gzgm002,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi330.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi330_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define

   #end add-point     
 
   #先清空單身變數內容
   CALL g_gzgm_d.clear()
   CALL g_gzgm2_d.clear()
 
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT  UNIQUE gzgm001,gzgm004,gzgmstus,gzgmownid,gzgmowndp,gzgmcrtid,gzgmcrtdp,gzgmcrtdt,gzgmmodid, 
       gzgmmoddt,gzgm001,t1.gzdel003 ,t2.oofa011 ,t3.ooefl003 ,t4.oofa011 ,t5.ooefl003 ,t6.oofa011 FROM gzgm_t", 
          
               "",
               
                              " LEFT JOIN gzdel_t t1 ON t1.gzdel001=gzgm001 AND t1.gzdel002='"||g_lang||"' ",
               " LEFT JOIN oofa_t t2 ON t2.oofaent='"||g_enterprise||"' AND t2.oofa002='2' AND t2.oofa003=gzgmownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=gzgmowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t4 ON t4.oofaent='"||g_enterprise||"' AND t4.oofa002='2' AND t4.oofa003=gzgmcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=gzgmcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t6 ON t6.oofaent='"||g_enterprise||"' AND t6.oofa002='2' AND t6.oofa003=gzgmmodid  ",
 
               " WHERE gzgm002=? AND gzgm003 =? "  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gzgm_t")
   END IF
   #end add-point
   
#   LET g_sql = "SELECT  UNIQUE gzgm001,gzgmstus,gzgmownid,gzgmowndp,gzgmcrtid,gzgmcrtdp,gzgmcrtdt,gzgmmodid, 
#       gzgmmoddt,gzgm001,t1.gzgdl002 ,t2.oofa011 ,t3.ooefl003 ,t4.oofa011 ,t5.ooefl003 ,t6.oofa011 FROM gzgm_t", 
#          
#               "",
#               
#                              " LEFT JOIN gzgdl_t t1 ON t1.gzgdl000=gzgm001 AND t1.gzgdl001='"||g_lang||"' ",
#               " LEFT JOIN oofa_t t2 ON t2.oofaent='"||g_enterprise||"' AND t2.oofa002='2' AND t2.oofa003=gzgmownid  ",
#               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=gzgmowndp AND t3.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN oofa_t t4 ON t4.oofaent='"||g_enterprise||"' AND t4.oofa002='2' AND t4.oofa003=gzgmcrtid  ",
#               " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=gzgmcrtdp AND t5.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN oofa_t t6 ON t6.oofaent='"||g_enterprise||"' AND t6.oofa002='2' AND t6.oofa003=gzgmmodid  ",
# 
#               " WHERE gzgm002=?"  
# 
#   IF NOT cl_null(g_wc2_table1) THEN
#      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gzgm_t")
#   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF azzi330_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY gzgm_t.gzgm001"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE azzi330_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR azzi330_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_gzgm_m.gzgm002,g_gzgm_m.gzgm003
                                               
      FOREACH b_fill_cs INTO g_gzgm_d[l_ac].gzgm001,g_gzgm_d[l_ac].gzgm004,g_gzgm_d[l_ac].gzgmstus,g_gzgm2_d[l_ac].gzgmownid, 
          g_gzgm2_d[l_ac].gzgmowndp,g_gzgm2_d[l_ac].gzgmcrtid,g_gzgm2_d[l_ac].gzgmcrtdp,g_gzgm2_d[l_ac].gzgmcrtdt, 
          g_gzgm2_d[l_ac].gzgmmodid,g_gzgm2_d[l_ac].gzgmmoddt,g_gzgm2_d[l_ac].gzgm001,g_gzgm_d[l_ac].gzgm001_desc, 
          g_gzgm2_d[l_ac].gzgmownid_desc,g_gzgm2_d[l_ac].gzgmowndp_desc,g_gzgm2_d[l_ac].gzgmcrtid_desc, 
          g_gzgm2_d[l_ac].gzgmcrtdp_desc,g_gzgm2_d[l_ac].gzgmmodid_desc
                             
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
 
            CALL g_gzgm_d.deleteElement(g_gzgm_d.getLength())
      CALL g_gzgm2_d.deleteElement(g_gzgm2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE azzi330_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi330_b_fill2(pi_idx)
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
 
{<section id="azzi330.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION azzi330_before_delete()
   #add-point:before_delete段define
   
   #end add-point 
   
   #add-point:單筆刪除前
   
   #end add-point
   
   DELETE FROM gzgm_t
    WHERE  gzgm002 = g_gzgm_m.gzgm002 AND
 
          gzgm001 = g_gzgm_d_t.gzgm001
 
      
   #add-point:單筆刪除中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzgm_t" 
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
 
{<section id="azzi330.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi330_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define

   #end add-point     
 
 
   RETURN TRUE
END FUNCTION
 
{</section>}
 
{<section id="azzi330.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi330_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi330_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="azzi330.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi330_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL azzi330_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi330_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi330_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzgm002",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi330_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzgm002",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi330_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi330_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   #add-point:set_no_entry_b段
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi330_default_search()
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
      LET ls_wc = ls_wc, " gzgm002 = '", g_argv[01], "' AND "
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
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi330_fill_chk(ps_idx)
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
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi330.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION azzi330_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "gzgm001"
      WHEN "s_detail2"
         LET ls_return = "gzgmownid"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi330.state_change" >}
    
 
{</section>}
 
{<section id="azzi330.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION azzi330_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_gzgm_m.gzgm002
   LET g_pk_array[1].column = 'gzgm002'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi330.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 存入報表元件表頭設定檔
# Memo...........:
# Usage..........: CALL azzi330_add_gzgm (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140924 By janet
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi330_add_gzgm(ps_idx)
  DEFINE ps_idx          LIKE type_t.num5
  DEFINE l_gzgmownid     LIKE gzgm_t.gzgmownid
  DEFINE l_gzgmowndp     LIKE gzgm_t.gzgmowndp
  DEFINE l_gzgmcrtid     LIKE gzgm_t.gzgmcrtid
  DEFINE l_gzgmcrtdp     LIKE gzgm_t.gzgmcrtdp
  DEFINE l_gzgmcrtdt     LIKE gzgm_t.gzgmcrtdt
  DEFINE l_gzgmmodid     LIKE gzgm_t.gzgmmodid
  DEFINE l_gzgmmoddt     LIKE gzgm_t.gzgmmoddt 
  DEFINE l_gzgmstus      LIKE gzgm_t.gzgmstus 
  DEFINE l_cnt           LIKE type_t.num5
  DEFINE p_wc2           STRING
  DEFINE pi_idx          LIKE type_t.num5
  DEFINE l_gzgm004       LIKE gzgm_t.gzgm004
 
  LET l_gzgmownid = g_user
  LET l_gzgmowndp = g_dept
  LET l_gzgmcrtid = g_user
  LET l_gzgmcrtdp = g_dept 
  LET l_gzgmcrtdt = cl_get_current()
  LET l_gzgmmodid = ""
  LET l_gzgmmoddt = ""
  LET l_gzgmstus = "Y"
 # LET l_gzgm004 = "N" #141020 mark
  LET l_gzgm004 = "s"  #141020 add
  IF FGL_GETENV("DGENV")="c" THEN
     #LET l_gzgm004 = "Y"   #141002 客製 mark
     LET l_gzgm004 = "c"   #141002 客製 add     
  END IF   
  IF s_transaction_chk("N",0) THEN
     CALL s_transaction_begin()
  END IF
 
  ##是否存在
  FOR pi_idx = 1 TO g_gzde_d.getLength()
   IF g_curr_diag.isRowSelected("s_detail3", pi_idx) THEN  
        LET l_cnt = 0      
        SELECT COUNT(gzgm001) INTO l_cnt FROM gzgm_t
         WHERE gzgm001 = g_gzde_d[pi_idx].gzde001  AND gzgm002 = g_gzgm_m.gzgm002

        IF l_cnt = 0 THEN       
            INSERT INTO gzgm_t
                        (gzgm003,gzgm002,gzgm001,gzgm004
                         ,gzgmstus,gzgmownid,gzgmowndp,gzgmcrtid,gzgmcrtdp,gzgmcrtdt,gzgmmodid,gzgmmoddt) 
                  VALUES(
                         g_gzgm_m.gzgm003,g_gzgm_m.gzgm002,
                         g_gzde_d[pi_idx].gzde001,l_gzgm004,l_gzgmstus,l_gzgmownid,l_gzgmowndp, l_gzgmcrtid,l_gzgmcrtdp,l_gzgmcrtdt, 
                             l_gzgmmodid,l_gzgmmoddt)
             IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgm_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
       
               CALL s_transaction_end('N','0')
             END IF 
             CALL s_transaction_end('Y','0')              
        ELSE
            #已存在 update
            UPDATE gzgm_t SET (gzgm003,gzgm004,gzgmstus,gzgmmodid,gzgmmoddt) =
                              (g_gzgm_m.gzgm003,l_gzgm004,l_gzgmstus,l_gzgmmodid,l_gzgmmoddt)
            WHERE gzgm001 = g_gzde_d[pi_idx].gzde001  AND gzgm002 = g_gzgm_m.gzgm002                  
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgm_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgm_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               
           END CASE   
           CALL s_transaction_end('Y','0')           
        END IF
   END IF
  END FOR
  #重整單身
  LET p_wc2 = "1=1"

  CALL azzi330_b_fill(p_wc2)
END FUNCTION

################################################################################
# Descriptions...: 抓出同模組的GR報表元件
# Memo...........:
# Usage..........: CALL azzi330_get_gzde_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140924 By janet
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi330_get_gzde_data()
   DEFINE l_i          LIKE type_t.num5

   CALL g_gzde_d.clear()
   LET g_sql = " SELECT gzde001,gzdel003 FROM gzde_t ",
               "   LEFT JOIN gzdel_t ON gzdel001 = gzde001 AND gzdel002 ='",g_lang,"'",
               #"  WHERE gzde002 ='",g_gzde_m.gzde002,"' AND gzde005='G' AND gzdestus ='Y'",  #141104 mark
               "  WHERE gzde002 ='",g_gzde_m.gzde002,"' AND (gzde005='G' OR gzde005='X') AND gzdestus ='Y'",   #141104 add
               "   ORDER BY gzdel001 "
   PREPARE get_gzde_pre FROM g_sql
   DECLARE get_gzde_cur CURSOR FOR get_gzde_pre
   LET l_i = 1
   FOREACH get_gzde_cur INTO g_gzde_d[l_i].*
      LET l_i = l_i + 1
   END FOREACH
   CALL g_gzde_d.deleteElement(l_i)
END FUNCTION

################################################################################
# Descriptions...: 刪除gzgm裡報表元件資料
# Memo...........:
# Usage..........: CALL azzi330_del_gzgm (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140925 By janet
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi330_del_gzgm(ps_idx)
  DEFINE ps_idx        LIKE type_t.num5
  DEFINE l_cnt           LIKE type_t.num5
  DEFINE p_wc2           STRING

  SELECT COUNT(gzgm001) INTO l_cnt FROM gzgm_t
   #WHERE gzgm001 = g_gzde_d[ps_idx].gzde001  AND gzgm002 = g_gzgm_m.gzgm002  #141110 mark
   WHERE gzgm001 = g_gzgm_d[ps_idx].gzgm001  AND gzgm002 = g_gzgm_m.gzgm002   #141110 add
  LET g_del_flag = 0
  IF l_cnt > 0 THEN 
     IF s_transaction_chk("N",0) THEN
        CALL s_transaction_begin()
     END IF  
     #DELETE FROM gzgm_t WHERE gzgm001 = g_gzde_d[ps_idx].gzde001  AND gzgm002 = g_gzgm_m.gzgm002  #141110 mark
     DELETE FROM gzgm_t WHERE gzgm001 = g_gzgm_d[ps_idx].gzgm001  AND gzgm002 = g_gzgm_m.gzgm002   #141110 add
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzgm_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF  
      LET g_del_flag = 1
      CALL s_transaction_end('Y','0')      
  END IF
  #重整單身
  LET p_wc2 = "1=1"

  CALL azzi330_b_fill(p_wc2)
END FUNCTION

 
{</section>}
 
