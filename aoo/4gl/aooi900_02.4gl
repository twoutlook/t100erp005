#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi900_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-04-11 10:03:19), PR版次:0005(2016-11-16 10:31:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000087
#+ Filename...: aooi900_02
#+ Description: 簽核關卡維護作業
#+ Creator....: 02716(2014-08-15 14:46:14)
#+ Modifier...: 04010 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi900_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#+ Modifier...: No.160323-00014#2 16/04/08 Cynthia  oojk改為gzgp
#161108-00012#2    2016/11/09 By 08734   g_browser_cnt 由num5改為num10
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
IMPORT FGL lib_cl_dlg
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
#單頭 type 宣告
 type type_g_gzgp_m        RECORD
       gzgp001 LIKE gzgp_t.gzgp001, 
   gzgp003 LIKE gzgp_t.gzgp003
       END RECORD
 
#單身 type 宣告
 TYPE type_g_gzgp_d        RECORD
       gzgpstus LIKE gzgp_t.gzgpstus, 
   gzgp002 LIKE gzgp_t.gzgp002, 
   gzgp004 LIKE gzgp_t.gzgp004, 
   gzgp005 LIKE gzgp_t.gzgp005
       END RECORD
 TYPE type_g_gzgp2_d RECORD
       gzgpownid LIKE gzgp_t.gzgpownid, 
   gzgpowndp LIKE gzgp_t.gzgpowndp, 
   gzgpcrtid LIKE gzgp_t.gzgpcrtid, 
   gzgpcrtdp LIKE gzgp_t.gzgpcrtdp, 
   gzgpcrtdt DATETIME YEAR TO SECOND, 
   gzgpmodid LIKE gzgp_t.gzgpmodid, 
   gzgpmoddt DATETIME YEAR TO SECOND, 
   gzgp002 LIKE gzgp_t.gzgp002
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_gzgp_m          type_g_gzgp_m
DEFINE g_gzgp_m_t        type_g_gzgp_m
DEFINE g_gzgp_m_o        type_g_gzgp_m
 
   DEFINE g_gzgp001_t LIKE gzgp_t.gzgp001
DEFINE g_gzgp003_t LIKE gzgp_t.gzgp003
 
 
DEFINE g_gzgp_d          DYNAMIC ARRAY OF type_g_gzgp_d
DEFINE g_gzgp_d_t        type_g_gzgp_d
DEFINE g_gzgp_d_o        type_g_gzgp_d
DEFINE g_gzgp2_d   DYNAMIC ARRAY OF type_g_gzgp2_d
DEFINE g_gzgp2_d_t type_g_gzgp2_d
DEFINE g_gzgp2_d_o type_g_gzgp2_d
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gzgp001 LIKE gzgp_t.gzgp001,
      b_gzgp003 LIKE gzgp_t.gzgp003
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
DEFINE g_rec_b               LIKE type_t.num10   #161108-00012#2 num5==》num10          
DEFINE l_ac                  LIKE type_t.num10   #161108-00012#2 num5==》num10   
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10   #161108-00012#2 num5==》num10        
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#2 num5==》num10
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#2 num5==》num10
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#2 num5==》num10
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
DEFINE g_gzgp003             LIKE gzgp_t.gzgp003           #140819 語言別
#end add-point
 
{</section>}
 
{<section id="aooi900_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="aooi900_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aooi900_02.other_dialog" >}

 
{</section>}
 
{<section id="aooi900_02.other_function" readonly="Y" >}

PUBLIC FUNCTION aooi900_02(--)
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


   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = " SELECT gzgp001,gzgp003", 
                      " FROM gzgp_t",
                      " WHERE gzgp001=? AND gzgp003=? FOR UPDATE"
   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi900_02_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.gzgp001,t0.gzgp003",
               " FROM gzgp_t t0",               
               " WHERE  t0.gzgp001 = ? AND t0.gzgp003 = ?"
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define

   #end add-point
   PREPARE aooi900_02_master_referesh FROM g_sql


   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi900_02 WITH FORM cl_ap_formpath("aoo","aooi900_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL aooi900_02_init()

   #進入選單 Menu (="N")
   CALL aooi900_02_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_aooi900_02




   #add-point:離開前

   #end add-point

END FUNCTION

################################################################################
# Descriptions...: 瀏覽頁簽資料初始化
# Memo...........:
# Usage..........: CALL aooi900_02_init (传入参数)
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_init()
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
  CALL cl_set_combo_lang("gzgp_t.gzgp003")  #140819 語言別
   #end add-point
   
   CALL aooi900_02_default_search()
END FUNCTION

################################################################################
# Descriptions...: 功能選單
# Memo...........:
# Usage..........: CALL aooi900_02_ui_dialog (传入参数)
#                  RETURNING 回传参数
# Input parameter:
#                : 
# Return code....: 
#                : 
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define

   #end add-point  
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      CALL aooi900_02_browser_fill("")
 
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_gzgp001 = g_gzgp001_t
               AND g_browser[li_idx].b_gzgp003 = g_gzgp003_t
 
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
          ##140819 janet add多語言 -(s)
         INPUT g_gzgp003 FROM gzgp_t.gzgp003 
           ATTRIBUTES(WITHOUT DEFAULTS)

           BEFORE INPUT                 
                DISPLAY g_gzgp003 TO gzgp_t.gzgp003
                
           ON CHANGE gzgp003
              LET g_gzgp_m.gzgp003 = g_gzgp003
              CALL aooi900_02_show()
           
         END INPUT 

         ##140819 janet add多語言 -(e)          
        
        
         DISPLAY ARRAY g_gzgp_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_gzgp003 = g_lang #140819 janet add
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL aooi900_02_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_gzgp2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL aooi900_02_ui_detailshow()
               
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
            LET g_gzgp003 = g_lang  #140819 janet add
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aooi900_02_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aooi900_02_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2

            #end add-point
 
         
         
         ON ACTION first
            CALL aooi900_02_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL aooi900_02_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL aooi900_02_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL aooi900_02_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL aooi900_02_fetch('L')
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
               NEXT FIELD gzgp002
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
               CALL aooi900_02_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aooi900_02_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL aooi900_02_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi900_02_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aooi900_02_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi900_02_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi900_02_insert()
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
               CALL aooi900_02_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi900_02_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL aooi900_02_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi900_02_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi900_02_set_pk_array()
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

################################################################################
# Descriptions...: 瀏覽頁簽資料搜尋
# Memo...........:
# Usage..........: CALL aooi900_02_browser_search (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_type
#                : 
# Return code....: 
#                : 
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_browser_search(p_type)
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
      LET g_wc = g_wc, " ORDER BY gzgp001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL aooi900_02_browser_fill("F")
   RETURN TRUE
 
END FUNCTION

################################################################################
# Descriptions...: 瀏覽頁簽資料填充
# Memo...........:
# Usage..........: CALL aooi900_02_browser_fill (传入参数)
#                  RETURNING 回传参数
# Input parameter: ps_page_action
#                : 
# Return code....: 
#                : 
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_browser_fill(ps_page_action)
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
      LET l_searchcol = "gzgp001"
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
      LET l_sub_sql = " SELECT UNIQUE gzgp001 ",
                      ", gzgp003 ",
 
                      " FROM gzgp_t ",
                      " ",
                      " ",
 
                      " WHERE  ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzgp_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE gzgp001 ",
                      ", gzgp003 ",
 
                      " FROM gzgp_t ",
                      " ",
                      " ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzgp_t")
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
 
   #依照t0.gzgp001,t0.gzgp003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gzgp001,t0.gzgp003",
                " FROM gzgp_t t0",
 
                
                " WHERE  ", l_wc," AND ",l_wc2, cl_sql_add_filter("gzgp_t")
 
   #add-point:browser_fill,sql_rank前

   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前

   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzgp_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_gzgp001,g_browser[g_cnt].b_gzgp003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      IF g_browser[g_cnt].b_gzgp003 IS NULL THEN
         LET g_browser[g_cnt].b_gzgp003 = g_lang
      ELSE
         LET g_gzgp003 = g_browser[g_cnt].b_gzgp003

      END IF
      #end add-point    
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_gzgp_m.* TO NULL
      CALL g_gzgp_d.clear()
      CALL g_gzgp2_d.clear()
 
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

################################################################################
# Descriptions...: 單頭資料重現
# Memo...........:
# Usage..........: CALL aooi900_02_ui_headershow (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_ui_headershow()
 
   LET g_gzgp_m.gzgp001 = g_browser[g_current_idx].b_gzgp001   
   LET g_gzgp_m.gzgp003 = g_browser[g_current_idx].b_gzgp003   
 
   EXECUTE aooi900_02_master_referesh USING g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 INTO g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 

   CALL aooi900_02_show()
END FUNCTION

################################################################################
# Descriptions...: 單身資料重新顯示
# Memo...........:
# Usage..........: CALL aooi900_02_ui_detailshow (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_ui_detailshow()
 

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)

   END IF
END FUNCTION

################################################################################
# Descriptions...: 瀏覽頁簽資料重新顯示
# Memo...........:
# Usage..........: CALL aooi900_02_ui_browser_refresh (传入参数)
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
  
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzgp001 = g_gzgp_m.gzgp001 
         AND g_browser[l_i].b_gzgp003 = g_gzgp_m.gzgp003 
 
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

################################################################################
# Descriptions...: QBE資料查詢
# Memo...........:
# Usage..........: CALL aooi900_02_construct (传入参数)
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 140819 By Janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_gzgp_m.* TO NULL
   CALL g_gzgp_d.clear()
   CALL g_gzgp2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外

   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzgp001,gzgp003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
                 #此段落由子樣板a01產生
         BEFORE FIELD gzgp001
            #add-point:BEFORE FIELD gzgp001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp001
            
            #add-point:AFTER FIELD gzgp001

            #END add-point
            
 
         #Ctrlp:construct.c.gzgp001
         ON ACTION controlp INFIELD gzgp001
            #add-point:ON ACTION controlp INFIELD gzgp001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp003
            #add-point:BEFORE FIELD gzgp003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp003
            
            #add-point:AFTER FIELD gzgp003

            #END add-point
            
 
         #Ctrlp:construct.c.gzgp003
         ON ACTION controlp INFIELD gzgp003
            #add-point:ON ACTION controlp INFIELD gzgp003

            #END add-point
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gzgpstus,gzgp002,gzgp004,gzgp005,gzgpownid,gzgpowndp,gzgpcrtid,gzgpcrtdp, 
          gzgpcrtdt,gzgpmodid,gzgpmoddt
           FROM s_detail1[1].gzgpstus,s_detail1[1].gzgp002,s_detail1[1].gzgp004,s_detail1[1].gzgp005, 
               s_detail2[1].gzgpownid,s_detail2[1].gzgpowndp,s_detail2[1].gzgpcrtid,s_detail2[1].gzgpcrtdp, 
               s_detail2[1].gzgpcrtdt,s_detail2[1].gzgpmodid,s_detail2[1].gzgpmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<gzgpcrtdt>>----
         AFTER FIELD gzgpcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzgpmoddt>>----
         AFTER FIELD gzgpmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzgpcnfdt>>----
         
         #----<<gzgppstdt>>----
 
 
           
         #單身一般欄位開窗相關處理
                  #此段落由子樣板a01產生
         BEFORE FIELD gzgpstus
            #add-point:BEFORE FIELD gzgpstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgpstus
            
            #add-point:AFTER FIELD gzgpstus

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzgpstus
         ON ACTION controlp INFIELD gzgpstus
            #add-point:ON ACTION controlp INFIELD gzgpstus

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp002
            #add-point:BEFORE FIELD gzgp002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp002
            
            #add-point:AFTER FIELD gzgp002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzgp002
         ON ACTION controlp INFIELD gzgp002
            #add-point:ON ACTION controlp INFIELD gzgp002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp004
            #add-point:BEFORE FIELD gzgp004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp004
            
            #add-point:AFTER FIELD gzgp004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzgp004
         ON ACTION controlp INFIELD gzgp004
            #add-point:ON ACTION controlp INFIELD gzgp004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp005
            #add-point:BEFORE FIELD gzgp005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp005
            
            #add-point:AFTER FIELD gzgp005

            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzgp005
         ON ACTION controlp INFIELD gzgp005
            #add-point:ON ACTION controlp INFIELD gzgp005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgpownid
            #add-point:BEFORE FIELD gzgpownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgpownid
            
            #add-point:AFTER FIELD gzgpownid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgpownid
         ON ACTION controlp INFIELD gzgpownid
            #add-point:ON ACTION controlp INFIELD gzgpownid

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgpowndp
            #add-point:BEFORE FIELD gzgpowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgpowndp
            
            #add-point:AFTER FIELD gzgpowndp

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgpowndp
         ON ACTION controlp INFIELD gzgpowndp
            #add-point:ON ACTION controlp INFIELD gzgpowndp

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgpcrtid
            #add-point:BEFORE FIELD gzgpcrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgpcrtid
            
            #add-point:AFTER FIELD gzgpcrtid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgpcrtid
         ON ACTION controlp INFIELD gzgpcrtid
            #add-point:ON ACTION controlp INFIELD gzgpcrtid

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgpcrtdp
            #add-point:BEFORE FIELD gzgpcrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgpcrtdp
            
            #add-point:AFTER FIELD gzgpcrtdp

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgpcrtdp
         ON ACTION controlp INFIELD gzgpcrtdp
            #add-point:ON ACTION controlp INFIELD gzgpcrtdp

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgpcrtdt
            #add-point:BEFORE FIELD gzgpcrtdt

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgpmodid
            #add-point:BEFORE FIELD gzgpmodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgpmodid
            
            #add-point:AFTER FIELD gzgpmodid

            #END add-point
            
 
         #Ctrlp:construct.c.page2.gzgpmodid
         ON ACTION controlp INFIELD gzgpmodid
            #add-point:ON ACTION controlp INFIELD gzgpmodid

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgpmoddt
            #add-point:BEFORE FIELD gzgpmoddt

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
         LET g_gzgp003 = GET_FLDBUF(gzgp003) 
 
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

################################################################################
# Descriptions...: 資料查詢QBE功能準備
# Memo...........:
# Usage..........: CALL aooi900_02_query ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_query()
   DEFINE ls_wc STRING

   
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
   CALL g_gzgp_d.clear()
   CALL g_gzgp2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aooi900_02_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aooi900_02_browser_fill(g_wc)
      CALL aooi900_02_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aooi900_02_browser_fill("F")
   
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
      CALL aooi900_02_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
END FUNCTION

################################################################################
# Descriptions...: 指定PK後抓取單頭其他資料
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_flag
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_fetch(p_flag)
  DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
 
 
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
   
   CALL aooi900_02_browser_fill(p_flag)
   
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
   
   LET g_gzgp_m.gzgp001 = g_browser[g_current_idx].b_gzgp001
   LET g_gzgp_m.gzgp003 = g_browser[g_current_idx].b_gzgp003
   LET g_gzgp003 = g_browser[g_current_idx].b_gzgp003
   
   ##140819 add -(s)
   IF g_gzgp_m.gzgp003 IS NULL THEN
      LET g_gzgp_m.gzgp003 = g_lang
   END IF
   ##140819 add -(e)
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aooi900_02_master_referesh USING g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 INTO g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzgp_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_gzgp_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #保存單頭舊值
   LET g_gzgp_m_t.* = g_gzgp_m.*
   LET g_gzgp_m_o.* = g_gzgp_m.*
   
   #重新顯示   
   CALL aooi900_02_show()
 
   
END FUNCTION

################################################################################
# Descriptions...: 資料新增
# Memo...........:
# Usage..........: CALL aooi900_02_insert (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_insert()
   #清除相關資料
   CLEAR FORM                    
   CALL g_gzgp_d.clear()
   CALL g_gzgp2_d.clear()
 
 
   INITIALIZE g_gzgp_m.* LIKE gzgp_t.*             #DEFAULT 設定
   LET g_gzgp001_t = NULL
   LET g_gzgp003_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值

      #end add-point 
 
      CALL aooi900_02_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzgp_m.* = g_gzgp_m_t.*
         CALL aooi900_02_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      CALL g_gzgp_d.clear()
      CALL g_gzgp2_d.clear()
 
      
      #add-point:單頭輸入後2

      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_gzgp001_t = g_gzgp_m.gzgp001
   LET g_gzgp003_t = g_gzgp_m.gzgp003
 
   
   LET g_wc = "(",g_wc,  
              " OR (  ",
              " gzgp001 = '", g_gzgp_m.gzgp001 CLIPPED, "' "
              ," AND gzgp003 = '", g_gzgp_m.gzgp003 CLIPPED, "' "
 
              , ")) "
   
END FUNCTION

################################################################################
# Descriptions...: 資料修改
# Memo...........:
# Usage..........: CALL aooi900_02_modify (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_modify()
   IF g_gzgp_m.gzgp001 IS NULL
   OR g_gzgp_m.gzgp003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE aooi900_02_master_referesh USING g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 INTO g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 

 
   ERROR ""
  
   LET g_gzgp001_t = g_gzgp_m.gzgp001
   LET g_gzgp003_t = g_gzgp_m.gzgp003
 
   CALL s_transaction_begin()
   
   OPEN aooi900_02_cl USING g_gzgp_m.gzgp001
                                                       ,g_gzgp_m.gzgp003
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi900_02_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE aooi900_02_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH aooi900_02_cl INTO g_gzgp_m.gzgp001,g_gzgp_m.gzgp003
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_gzgp_m.gzgp001 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE aooi900_02_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL aooi900_02_show()
   WHILE TRUE
      LET g_gzgp001_t = g_gzgp_m.gzgp001
      LET g_gzgp003_t = g_gzgp_m.gzgp003
 
 
      #add-point:modify段修改前

      #end add-point
      
      CALL aooi900_02_input("u")     #欄位更改
      
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzgp_m.* = g_gzgp_m_t.*
         CALL aooi900_02_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_gzgp_m.gzgp001 != g_gzgp001_t 
      OR g_gzgp_m.gzgp003 != g_gzgp003_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前

         #end add-point
         
         #更新單頭key值
         UPDATE gzgp_t SET gzgp001 = g_gzgp_m.gzgp001
                                       , gzgp003 = g_gzgp_m.gzgp003
 
          WHERE  gzgp001 = g_gzgp001_t
            AND gzgp003 = g_gzgp003_t
 
         #add-point:單頭(偽)修改中

         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgp_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgp_t" 
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
   #IF NOT cl_log_modified_record(g_gzgp_m.gzgp001,g_site) THEN 
   #   CALL s_transaction_end('N','0')
   #END IF
 
   CLOSE aooi900_02_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_gzgp_m.gzgp001,'U')
 
   CALL aooi900_02_b_fill("1=1")
END FUNCTION

################################################################################
# Descriptions...: 資料輸入
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_cmd
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10                #未取消的ARRAY CNT   #161108-00012#2 num5==》num10
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
   LET g_forupd_sql = "SELECT gzgpstus,gzgp002,gzgp004,gzgp005,gzgpownid,gzgpowndp,gzgpcrtid,gzgpcrtdp, 
       gzgpcrtdt,gzgpmodid,gzgpmoddt,gzgp002 FROM gzgp_t WHERE gzgp001=? AND gzgp003=? AND gzgp002=?  
       FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi900_02_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aooi900_02_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL aooi900_02_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
   DISPLAY BY NAME g_gzgp_m.gzgp001,g_gzgp_m.gzgp003
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #單頭段
      INPUT BY NAME g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 
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
          
                  #此段落由子樣板a01產生
         BEFORE FIELD gzgp001
            #add-point:BEFORE FIELD gzgp001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp001
            
            #add-point:AFTER FIELD gzgp001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_gzgp_m.gzgp001) AND NOT cl_null(g_gzgp_m.gzgp003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzgp_m.gzgp001 != g_gzgp001_t  OR g_gzgp_m.gzgp003 != g_gzgp003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgp_t WHERE "||"gzgp001 = '"||g_gzgp_m.gzgp001 ||"' AND "|| "gzgp003 = '"||g_gzgp_m.gzgp003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgp001
            #add-point:ON CHANGE gzgp001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp003
            #add-point:BEFORE FIELD gzgp003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp003
            
            #add-point:AFTER FIELD gzgp003
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_gzgp_m.gzgp001) AND NOT cl_null(g_gzgp_m.gzgp003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzgp_m.gzgp001 != g_gzgp001_t  OR g_gzgp_m.gzgp003 != g_gzgp003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgp_t WHERE "||"gzgp001 = '"||g_gzgp_m.gzgp001 ||"' AND "|| "gzgp003 = '"||g_gzgp_m.gzgp003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgp003
            #add-point:ON CHANGE gzgp003

            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.gzgp001
         ON ACTION controlp INFIELD gzgp001
            #add-point:ON ACTION controlp INFIELD gzgp001

            #END add-point
 
         #Ctrlp:input.c.gzgp003
         ON ACTION controlp INFIELD gzgp003
            #add-point:ON ACTION controlp INFIELD gzgp003

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
            
                

            DISPLAY BY NAME g_gzgp_m.gzgp001             
                            ,g_gzgp_m.gzgp003   
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前

               #end add-point
            
               UPDATE gzgp_t SET (gzgp001,gzgp003) = (g_gzgp_m.gzgp001,g_gzgp_m.gzgp003)
                WHERE  gzgp001 = g_gzgp001_t
                  AND gzgp003 = g_gzgp003_t
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgp_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgp_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzgp_m.gzgp001
               LET gs_keys_bak[1] = g_gzgp001_t
               LET gs_keys[2] = g_gzgp_m.gzgp003
               LET gs_keys_bak[2] = g_gzgp003_t
               LET gs_keys[3] = g_gzgp_d[g_detail_idx].gzgp002
               LET gs_keys_bak[3] = g_gzgp_d_t.gzgp002
               CALL aooi900_02_update_b('gzgp_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_gzgp001_t = g_gzgp_m.gzgp001
                     LET g_gzgp003_t = g_gzgp_m.gzgp003
 
                     #add-point:單頭修改後

                     #end add-point
                     
                     LET g_log1 = util.JSON.stringify(g_gzgp_m_t)
                     LET g_log2 = util.JSON.stringify(g_gzgp_m)
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
                  CALL aooi900_02_detail_reproduce()
               END IF
            END IF
           #controlp
                     
           LET g_gzgp001_t = g_gzgp_m.gzgp001
           LET g_gzgp003_t = g_gzgp_m.gzgp003
 
           
           #若單身還沒有輸入資料, 強制切換至單身
           #IF cl_null(g_gzgp_d[1].gzgp002) THEN
           #   CALL g_gzgp_d.deleteElement(1)
           #   NEXT FIELD gzgp002
           #END IF
           
           IF g_gzgp_d.getLength() = 0 THEN
              NEXT FIELD gzgp002
           END IF
 
      END INPUT

      #Page1 預設值產生於此處
      INPUT ARRAY g_gzgp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzgp_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi900_02_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF 
            CALL aooi900_02_set_seqaction_active("s_detail1", "up_seq", "down_seq") #140819 add
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            CALL aooi900_02_set_seqaction_active("s_detail1", "up_seq", "down_seq") #140819 add
            
         
            CALL s_transaction_begin()
            

            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_gzgp_d[l_ac].gzgp002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzgp_d_t.* = g_gzgp_d[l_ac].*  #BACKUP
               LET g_gzgp_d_o.* = g_gzgp_d[l_ac].*  #BACKUP
               CALL aooi900_02_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL aooi900_02_set_no_entry_b(l_cmd)
               OPEN aooi900_02_bcl USING g_gzgp_m.gzgp001,
                                                g_gzgp_m.gzgp003,
 
                                                g_gzgp_d_t.gzgp002
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aooi900_02_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi900_02_bcl INTO g_gzgp_d[l_ac].gzgpstus,g_gzgp_d[l_ac].gzgp002,g_gzgp_d[l_ac].gzgp004, 
                      g_gzgp_d[l_ac].gzgp005,g_gzgp2_d[l_ac].gzgpownid,g_gzgp2_d[l_ac].gzgpowndp,g_gzgp2_d[l_ac].gzgpcrtid, 
                      g_gzgp2_d[l_ac].gzgpcrtdp,g_gzgp2_d[l_ac].gzgpcrtdt,g_gzgp2_d[l_ac].gzgpmodid, 
                      g_gzgp2_d[l_ac].gzgpmoddt,g_gzgp2_d[l_ac].gzgp002
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gzgp_d_t.gzgp002 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL aooi900_02_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_gzgp_d_t.* TO NULL
            INITIALIZE g_gzgp_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzgp_d[l_ac].* TO NULL
            #公用欄位預設值
            #此段落由子樣板a14產生    
            #公用欄位新增給值
            LET g_gzgp2_d[l_ac].gzgpownid = g_user
            LET g_gzgp2_d[l_ac].gzgpowndp = g_dept
            LET g_gzgp2_d[l_ac].gzgpcrtid = g_user
            LET g_gzgp2_d[l_ac].gzgpcrtdp = g_dept 
            LET g_gzgp2_d[l_ac].gzgpcrtdt = cl_get_current()
            LET g_gzgp2_d[l_ac].gzgpmodid = ""
            LET g_gzgp2_d[l_ac].gzgpmoddt = ""
            LET g_gzgp_d[l_ac].gzgpstus = ""
 
  
            #一般欄位預設值
            SELECT MAX(gzgp002)+1 INTO g_gzgp_d[l_ac].gzgp002 FROM gzgp_t
             WHERE gzgp001 = g_gzgp_m.gzgp001 AND gzgp003 = g_gzgp_m.gzgp003
            IF g_gzgp_d[l_ac].gzgp002 IS NULL THEN
               LET g_gzgp_d[l_ac].gzgp002 = 1
            END IF
            ##控卡只能12關
            IF g_gzgp_d[l_ac].gzgp002 > 12 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = "aoo-00378"
               LET g_errparam.popup  = false
               CALL cl_err()   
               CANCEL INSERT              
            END IF
            
            
            LET g_gzgp_d[l_ac].gzgpstus = "Y"
            
            IF FGL_GETENV("DGENV") ="s" THEN
               #LET g_gzgp_d[l_ac].gzgp005 = "N"   #141002 客製 mark
               LET g_gzgp_d[l_ac].gzgp005 = "s"   #141002 客製 add
            ELSE
               #LET g_gzgp_d[l_ac].gzgp005 = "Y"   #141002 客製 mark
               LET g_gzgp_d[l_ac].gzgp005 = "c"   #141002 客製 add
            END IF
            #add-point:modify段before備份

            #end add-point
            LET g_gzgp_d_t.* = g_gzgp_d[l_ac].*     #新輸入資料
            LET g_gzgp_d_o.* = g_gzgp_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi900_02_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL aooi900_02_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzgp_d[li_reproduce_target].* = g_gzgp_d[li_reproduce].*
               LET g_gzgp2_d[li_reproduce_target].* = g_gzgp2_d[li_reproduce].*
 
               LET g_gzgp_d[g_gzgp_d.getLength()].gzgp002 = NULL
 
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
            SELECT COUNT(*) INTO l_count FROM gzgp_t 
             WHERE  gzgp001 = g_gzgp_m.gzgp001
               AND gzgp003 = g_gzgp_m.gzgp003
 
               AND gzgp002 = g_gzgp_d[l_ac].gzgp002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前
               #140819 add-(s)
               LET g_gzgp_d[l_ac].gzgpstus = 'Y'   
               IF FGL_GETENV("DGENV") ="s" THEN
                  #LET g_gzgp_d[l_ac].gzgp005 = 'N'   #141002 客製 mark 
                  LET g_gzgp_d[l_ac].gzgp005 = 's'   #141002 客製 add 
               ELSE
                  #LET g_gzgp_d[l_ac].gzgp005 = 'Y'   #141002 客製 mark
                  LET g_gzgp_d[l_ac].gzgp005 = 'c'   #141002 客製 add
               END IF
               #140819 add-(e)
               #end add-point
               INSERT INTO gzgp_t
                           (
                            gzgp001,gzgp003,
                            gzgp002
                            ,gzgpstus,gzgp004,gzgp005,gzgpownid,gzgpowndp,gzgpcrtid,gzgpcrtdp,gzgpcrtdt,gzgpmodid,gzgpmoddt) 
                     VALUES(
                            g_gzgp_m.gzgp001,g_gzgp_m.gzgp003,
                            g_gzgp_d[l_ac].gzgp002
                            ,g_gzgp_d[l_ac].gzgpstus,g_gzgp_d[l_ac].gzgp004,g_gzgp_d[l_ac].gzgp005,g_gzgp2_d[l_ac].gzgpownid, 
                                g_gzgp2_d[l_ac].gzgpowndp,g_gzgp2_d[l_ac].gzgpcrtid,g_gzgp2_d[l_ac].gzgpcrtdp, 
                                g_gzgp2_d[l_ac].gzgpcrtdt,g_gzgp2_d[l_ac].gzgpmodid,g_gzgp2_d[l_ac].gzgpmoddt) 

               #add-point:單身新增中

               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_gzgp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzgp_t" 
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
               IF aooi900_02_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
                  
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aooi900_02_bcl
               LET l_count = g_gzgp_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzgp_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
            
                  #此段落由子樣板a01產生
         BEFORE FIELD gzgpstus
            #add-point:BEFORE FIELD gzgpstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgpstus
            
            #add-point:AFTER FIELD gzgpstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgpstus
            #add-point:ON CHANGE gzgpstus

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp002
            #add-point:BEFORE FIELD gzgp002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp002
            
            #add-point:AFTER FIELD gzgp002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_gzgp_m.gzgp001 IS NOT NULL AND g_gzgp_m.gzgp003 IS NOT NULL AND g_gzgp_d[g_detail_idx].gzgp002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzgp_m.gzgp001 != g_gzgp001_t OR g_gzgp_m.gzgp003 != g_gzgp003_t OR g_gzgp_d[g_detail_idx].gzgp002 != g_gzgp_d_t.gzgp002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzgp_t WHERE "||"gzgp001 = '"||g_gzgp_m.gzgp001 ||"' AND "|| "gzgp003 = '"||g_gzgp_m.gzgp003 ||"' AND "|| "gzgp002 = '"||g_gzgp_d[g_detail_idx].gzgp002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgp002
            #add-point:ON CHANGE gzgp002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp004
            #add-point:BEFORE FIELD gzgp004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp004
            
            #add-point:AFTER FIELD gzgp004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgp004
            #add-point:ON CHANGE gzgp004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzgp005
            #add-point:BEFORE FIELD gzgp005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzgp005
            
            #add-point:AFTER FIELD gzgp005

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzgp005
            #add-point:ON CHANGE gzgp005

            #END add-point
 
 
                  #Ctrlp:input.c.page1.gzgpstus
         ON ACTION controlp INFIELD gzgpstus
            #add-point:ON ACTION controlp INFIELD gzgpstus

            #END add-point
 
         #Ctrlp:input.c.page1.gzgp002
         ON ACTION controlp INFIELD gzgp002
            #add-point:ON ACTION controlp INFIELD gzgp002

            #END add-point
 
         #Ctrlp:input.c.page1.gzgp004
         ON ACTION controlp INFIELD gzgp004
            #add-point:ON ACTION controlp INFIELD gzgp004

            #END add-point
 
         #Ctrlp:input.c.page1.gzgp005
         ON ACTION controlp INFIELD gzgp005
            #add-point:ON ACTION controlp INFIELD gzgp005

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_gzgp_d[l_ac].* = g_gzgp_d_t.*
               CLOSE aooi900_02_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzgp_d[l_ac].gzgp002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_gzgp_d[l_ac].* = g_gzgp_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gzgp2_d[l_ac].gzgpmodid = g_user 
               LET g_gzgp2_d[l_ac].gzgpmoddt = cl_get_current()
 
            
               #add-point:單身修改前

               #end add-point
         
               UPDATE gzgp_t SET (gzgp001,gzgp003,gzgpstus,gzgp002,gzgp004,gzgp005,gzgpownid,gzgpowndp, 
                   gzgpcrtid,gzgpcrtdp,gzgpcrtdt,gzgpmodid,gzgpmoddt) = (g_gzgp_m.gzgp001,g_gzgp_m.gzgp003, 
                   g_gzgp_d[l_ac].gzgpstus,g_gzgp_d[l_ac].gzgp002,g_gzgp_d[l_ac].gzgp004,g_gzgp_d[l_ac].gzgp005, 
                   g_gzgp2_d[l_ac].gzgpownid,g_gzgp2_d[l_ac].gzgpowndp,g_gzgp2_d[l_ac].gzgpcrtid,g_gzgp2_d[l_ac].gzgpcrtdp, 
                   g_gzgp2_d[l_ac].gzgpcrtdt,g_gzgp2_d[l_ac].gzgpmodid,g_gzgp2_d[l_ac].gzgpmoddt)
                WHERE  gzgp001 = g_gzgp_m.gzgp001 
                 AND gzgp003 = g_gzgp_m.gzgp003 
 
                 AND gzgp002 = g_gzgp_d_t.gzgp002 #項次   
 
                 
               #add-point:單身修改中

               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzgp_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gzgp_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzgp_m.gzgp001
               LET gs_keys_bak[1] = g_gzgp001_t
               LET gs_keys[2] = g_gzgp_m.gzgp003
               LET gs_keys_bak[2] = g_gzgp003_t
               LET gs_keys[3] = g_gzgp_d[g_detail_idx].gzgp002
               LET gs_keys_bak[3] = g_gzgp_d_t.gzgp002
               CALL aooi900_02_update_b('gzgp_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_gzgp_m),util.JSON.stringify(g_gzgp_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzgp_m),util.JSON.stringify(g_gzgp_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後

               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_gzgp_d.getLength() = 0 THEN
               NEXT FIELD gzgp002
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_gzgp_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzgp_d.getLength()+1
            
         ##140819 add -(s)
         ON ACTION up_seq  
            CALL aooi900_02_move_up_down("up")
            LET l_ac = DIALOG.getCurrentRow("s_detail1")

         ON ACTION down_seq
            CALL aooi900_02_move_up_down("down")
            LET l_ac = DIALOG.getCurrentRow("s_detail1")         
         
         ##140819 add -(e)  
      END INPUT
 
 
      
      DISPLAY ARRAY g_gzgp2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL aooi900_02_b_fill(g_wc2) 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL aooi900_02_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為

         #end add-point
         
      END DISPLAY
 
      
 
      
      #add-point:input段more_input

      #end add-point    
      
      BEFORE DIALOG
         #add-point:input段before_dialog
         LET g_curr_diag = ui.DIALOG.getCurrent()
         #end add-point 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD gzgp001
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzgpstus
               WHEN "s_detail2"
                  NEXT FIELD gzgpownid
 
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
END FUNCTION

################################################################################
# Descriptions...: 單頭資料重新顯示及單身資料重抓
# Memo...........:
# Usage..........: CALL aooi900_02_show ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_show()

   IF cl_null(g_gzgp003) THEN LET g_gzgp003 = g_lang END IF  ##140821 add

   IF g_bfill = "Y" THEN
      CALL aooi900_02_b_fill(g_wc2) #單身填充
      CALL aooi900_02_b_fill2('0') #單身填充
   END IF
   
   
 
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL aooi900_02_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   DISPLAY BY NAME g_gzgp_m.gzgp001,g_gzgp_m.gzgp003
   CALL aooi900_02_b_fill(g_wc2_table1)                 #單身
   CALL aooi900_02_b_fill2('0') #單身填充
 
   CALL aooi900_02_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
END FUNCTION

################################################################################
# Descriptions...: 帶出reference資料
# Memo...........:
# Usage..........: CALL aooi900_02_ref_show ()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define

   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzgp_d.getLength()
      #add-point:ref_show段d_reference

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gzgp2_d.getLength()
      #add-point:ref_show段d2_reference

      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂

   #end add-point
   
   LET l_ac = l_ac_t
END FUNCTION

################################################################################
# Descriptions...: 資料複製
# Memo...........:
# Usage..........: CALL aooi900_02_reproduce()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传
# Modify.........: 140819 By janet
################################################################################
PRIVATE FUNCTION aooi900_02_reproduce()
   DEFINE l_newno     LIKE gzgp_t.gzgp001 
   DEFINE l_oldno     LIKE gzgp_t.gzgp001 
   DEFINE l_newno02     LIKE gzgp_t.gzgp003 
   DEFINE l_oldno02     LIKE gzgp_t.gzgp003 
 
   DEFINE l_master    RECORD LIKE gzgp_t.*
   DEFINE l_detail    RECORD LIKE gzgp_t.*
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define

   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_gzgp_m.gzgp001 IS NULL
      OR g_gzgp_m.gzgp003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   LET g_gzgp001_t = g_gzgp_m.gzgp001
   LET g_gzgp003_t = g_gzgp_m.gzgp003
 
   
   LET g_gzgp_m.gzgp001 = ""
   LET g_gzgp_m.gzgp003 = ""
 
    
   CALL aooi900_02_set_entry('a')
   CALL aooi900_02_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前

   #end add-point
   
   CALL aooi900_02_input("r")
   
   
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_gzgp001_t = g_gzgp_m.gzgp001
   LET g_gzgp003_t = g_gzgp_m.gzgp003
 
   
   LET g_wc = "(", g_wc,  
              " OR (",
              " gzgp001 = '", g_gzgp_m.gzgp001 CLIPPED, "' "
              ," AND gzgp003 = '", g_gzgp_m.gzgp003 CLIPPED, "' "
 
              , ")) "
   
   #add-point:完成複製段落後

   #end add-point
END FUNCTION

################################################################################
# Descriptions...: 單身自動複製
# Memo...........:
# Usage..........: CALL aooi900_02_detail_reproduce (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_detail_reproduce()
  DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzgp_t.*
 
 
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aooi900_02_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aooi900_02_detail AS ",
                "SELECT * FROM gzgp_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aooi900_02_detail SELECT * FROM gzgp_t 
                                         WHERE  gzgp001 = g_gzgp001_t
                                         AND gzgp003 = g_gzgp003_t
 
   
   #將key修正為調整後   
   UPDATE aooi900_02_detail 
      #更新key欄位
      SET gzgp001 = g_gzgp_m.gzgp001
          , gzgp003 = g_gzgp_m.gzgp003
 
      #更新共用欄位
      #此段落由子樣板a13產生
       , gzgpownid = g_user
       , gzgpowndp = g_dept
       , gzgpcrtid = g_user
       , gzgpcrtdp = g_dept 
       , gzgpcrtdt = ld_date
       , gzgpmodid = "" 
       , gzgpmoddt = "" 
      #, gzgpstus = "Y"
 
 
                                       
  
   #將資料塞回原table   
   INSERT INTO gzgp_t SELECT * FROM aooi900_02_detail
   
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
   DROP TABLE aooi900_02_detail
   
   #add-point:單身複製後1

   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzgp001_t = g_gzgp_m.gzgp001
   LET g_gzgp003_t = g_gzgp_m.gzgp003
 
   
   DROP TABLE aooi900_02_detail
END FUNCTION

################################################################################
# Descriptions...: 資料刪除
# Memo...........:
# Usage..........: CALL aooi900_02_delete() (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   
   IF g_gzgp_m.gzgp001 IS NULL
   OR g_gzgp_m.gzgp003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE aooi900_02_master_referesh USING g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 INTO g_gzgp_m.gzgp001,g_gzgp_m.gzgp003 

   
   CALL aooi900_02_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN aooi900_02_cl USING g_gzgp_m.gzgp001
                                                       ,g_gzgp_m.gzgp003
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi900_02_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE aooi900_02_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH aooi900_02_cl INTO g_gzgp_m.gzgp001,g_gzgp_m.gzgp003
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_gzgp_m.gzgp001 
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
      CALL aooi900_02_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
 
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM gzgp_t WHERE  gzgp001 = g_gzgp_m.gzgp001
                                                               AND gzgp003 = g_gzgp_m.gzgp003
 
                                                               
      #add-point:單身刪除中

      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzgp_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 

      #end add-point
      
 
      
      CLEAR FORM
      CALL g_gzgp_d.clear() 
      CALL g_gzgp2_d.clear()       
 
     
      CALL aooi900_02_ui_browser_refresh()  
      CALL aooi900_02_ui_headershow()  
      CALL aooi900_02_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aooi900_02_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL aooi900_02_browser_fill("F")
      END IF
       
   END IF
 
   CLOSE aooi900_02_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_gzgp_m.gzgp001,'D')
END FUNCTION

################################################################################
# Descriptions...: 單身陣列填充
# Memo...........:
# Usage..........: CALL aooi900_02_b_fill(p_wc2)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_b_fill(p_wc2)
  DEFINE p_wc2      STRING
   #add-point:b_fill段define

   #end add-point     
 
   #先清空單身變數內容
   CALL g_gzgp_d.clear()
   CALL g_gzgp2_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE gzgpstus,gzgp002,gzgp004,gzgp005,gzgpownid,gzgpowndp,gzgpcrtid,gzgpcrtdp, 
       gzgpcrtdt,gzgpmodid,gzgpmoddt,gzgp002 FROM gzgp_t",   
               "",
               
               
               " WHERE gzgp001=? AND gzgp003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gzgp_t")
   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aooi900_02_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY gzgp_t.gzgp002"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE aooi900_02_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR aooi900_02_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_gzgp_m.gzgp001,g_gzgp_m.gzgp003
                                               
      FOREACH b_fill_cs INTO g_gzgp_d[l_ac].gzgpstus,g_gzgp_d[l_ac].gzgp002,g_gzgp_d[l_ac].gzgp004,g_gzgp_d[l_ac].gzgp005, 
          g_gzgp2_d[l_ac].gzgpownid,g_gzgp2_d[l_ac].gzgpowndp,g_gzgp2_d[l_ac].gzgpcrtid,g_gzgp2_d[l_ac].gzgpcrtdp, 
          g_gzgp2_d[l_ac].gzgpcrtdt,g_gzgp2_d[l_ac].gzgpmodid,g_gzgp2_d[l_ac].gzgpmoddt,g_gzgp2_d[l_ac].gzgp002 

                             
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
 
       CALL g_gzgp_d.deleteElement(g_gzgp_d.getLength())
      CALL g_gzgp2_d.deleteElement(g_gzgp2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE aooi900_02_pb  
END FUNCTION

################################################################################
# Descriptions...: 單身陣列填充2
# Memo...........:
# Usage..........: CALL aooi900_02_b_fill2(pi_idx)
#                  RETURNING 回传参数
# Input parameter: pi_idx
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_b_fill2(pi_idx)
  DEFINE pi_idx          LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#2 num5==》num10
   #add-point:b_fill2段define

   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後

   #end add-point
    
   LET l_ac = li_ac
END FUNCTION

################################################################################
# Descriptions...: 單身db資料刪除
# Memo...........:
# Usage..........: CALL aooi900_02_before_delete()
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_before_delete()
   #add-point:before_delete段define

   #end add-point 
   
   #add-point:單筆刪除前

   #end add-point
   
   DELETE FROM gzgp_t
    WHERE  gzgp001 = g_gzgp_m.gzgp001 AND
                              gzgp003 = g_gzgp_m.gzgp003 AND
 
          gzgp002 = g_gzgp_d_t.gzgp002
 
      
   #add-point:單筆刪除中

   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzgp_t" 
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

################################################################################
# Descriptions...: 刪除單身後其他table連動
# Memo...........:
# Usage..........: CALL aooi900_02_delete_b(ps_table,ps_keys_bak,ps_page)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_delete_b(ps_table,ps_keys_bak,ps_page)
  DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define

   #end add-point     
 
 
END FUNCTION

################################################################################
# Descriptions...: 新增單身後其他table連動
# Memo...........:
# Usage..........: CALL aooi900_02_insert_b(ps_table,ps_keys,ps_page)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define

   #end add-point     
   
 
END FUNCTION

################################################################################
# Descriptions...: 修改單身後其他table連動
# Memo...........:
# Usage..........: CALL aooi900_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10   #161108-00012#2 num5==》num10
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

################################################################################
# Descriptions...: 連動lock其他單身table資料
# Memo...........:
# Usage..........: CALL aooi900_02_lock_b(ps_table,ps_page)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_lock_b(ps_table,ps_page)
  DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL aooi900_02_b_fill()
   
 
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 連動unlock其他單身table資料
# Memo...........:
# Usage..........: CALL aooi900_02_unlock_b(ps_table,ps_page)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define

   #end add-point  
   
END FUNCTION

################################################################################
# Descriptions...: 單頭欄位開啟設定
# Memo...........:
# Usage..........: CALL aooi900_02_set_entry(p_cmd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define

   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzgp001,gzgp003",TRUE)
      #add-point:set_entry段欄位控制

      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後

   #end add-point 
END FUNCTION

################################################################################
# Descriptions...: 單頭欄位關閉設定
# Memo...........:
# Usage..........: CALL aooi900_02_set_no_entry(p_cmd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define

   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzgp001,gzgp003",FALSE)
      #add-point:set_no_entry段欄位控制

      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後

   #end add-point 
 
END FUNCTION

################################################################################
# Descriptions...: 單身欄位開啟設定
# Memo...........:
# Usage..........: CALL aooi900_02_set_entry_b(p_cmd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_set_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define

   #end add-point     
   
   #add-point:set_entry_b段

   #end add-point  
   
END FUNCTION

################################################################################
# Descriptions...: 單身欄位關閉設定
# Memo...........:
# Usage..........: CALL aooi900_02_set_no_entry_b(p_cmd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define

   #end add-point    
   
   #add-point:set_no_entry_b段

   #end add-point 
   
END FUNCTION

################################################################################
# Descriptions...: 外部參數搜尋
# Memo...........:
# Usage..........: CALL aooi900_02_default_search()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_default_search()
  DEFINE li_idx  LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE li_cnt  LIKE type_t.num10  #161108-00012#2 num5==》num10
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
      LET ls_wc = ls_wc, " gzgp001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gzgp003 = '", g_argv[02], "' AND "
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

################################################################################
# Descriptions...: 單身填充確認
# Memo...........:
# Usage..........: CALL aooi900_02_fill_chk(ps_idx)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_fill_chk(ps_idx)
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

################################################################################
# Descriptions...: 單身輸入判定
# Memo...........:
# Usage..........: CALL aooi900_02_modify_detail_chk(ps_record)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define

   #end add-point
   
   #add-point:modify_detail_chk段開始前

   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "gzgpstus"
      WHEN "s_detail2"
         LET ls_return = "gzgpownid"
 
      #add-point:modify_detail_chk段自訂page控制

      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前

   #end add-point
   
   RETURN ls_return
   
END FUNCTION

################################################################################
# Descriptions...: 給予pk_array內容
# Memo...........:
# Usage..........: CALL aooi900_02_set_pk_array()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_set_pk_array()
  #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_gzgp_m.gzgp001
   LET g_pk_array[1].column = 'gzgp001'
   LET g_pk_array[2].values = g_gzgp_m.gzgp003
   LET g_pk_array[2].column = 'gzgp003'
   
   #add-point:set_pk_array段之後

   #end add-point  
END FUNCTION

################################################################################
# Descriptions...: 調整上下順序
# Memo...........:
# Usage..........: CALL aooi900_02_move_up_down (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_move_up_down(ps_type)
   DEFINE ps_type    STRING
   DEFINE li_step    LIKE type_t.num5
   DEFINE li_idx     LIKE type_t.num10   #目前指定的位置  #161108-00012#2 num5==》num10
   DEFINE li_idx_p   LIKE type_t.num10   #目的位置  #161108-00012#2 num5==》num10
   DEFINE li_idx_t   LIKE type_t.num10   #暫時的位置(因為序號是key)  #161108-00012#2 num5==》num10
   DEFINE li_cur_idx LIKE type_t.num10   #for typelist2  #161108-00012#2 num5==》num10
   DEFINE ls_table   STRING
   DEFINE ls_key1    STRING
   DEFINE ls_key2    STRING
   DEFINE ls_key3    STRING
   DEFINE ls_key4    STRING             #140701 add
   DEFINE ls_seq     STRING

   IF ps_type = "up" THEN
      LET li_step = -1
   ELSE
      LET li_step = 1
   END IF

   LET li_idx = g_curr_diag.getCurrentRow("s_detail1")
   LET li_idx_p = li_idx + li_step

   LET g_sql = "SELECT MAX(gzgp002) + 1 FROM gzgp_t ",
              "  WHERE gzgp001 = '", g_gzgp_m.gzgp001,"' AND gzgp003 = '",g_gzgp_m.gzgp003,"'",
              "    AND gzgpstus ='Y'"  
              
   PREPARE change_gzgp_seq_tmploction_pre FROM g_sql
   EXECUTE change_gzgp_seq_tmploction_pre INTO li_idx_t
   IF li_idx_t IS NULL THEN
      LET li_idx_t = 1
   END IF 
   
   LET g_sql = " UPDATE gzgp_t SET gzgp002 = ?",
               "  WHERE gzgp001 = '", g_gzgp_m.gzgp001,"' AND gzgp003 = '",g_gzgp_m.gzgp003,"'",
               "    AND gzgpstus ='Y' AND gzgp002 = ?" 
   PREPARE change_gzgp_seq_pre FROM g_sql
   #先把目的位置的資料搬去最後一筆
   EXECUTE change_gzgp_seq_pre USING li_idx_t, li_idx_p
   #把指定位置的資料搬到目的位置
   EXECUTE change_gzgp_seq_pre USING li_idx_p, li_idx
   #再把暫時丟到最後一筆的資料放回指定位置
   EXECUTE change_gzgp_seq_pre USING li_idx, li_idx_t  


   CALL aooi900_02_b_fill(g_wc2) #單身填充
   
   #最後, 指標要跟著指定資料跑
   CALL g_curr_diag.setCurrentRow("s_detail1", li_cur_idx)
   
   #上下按鍵要跟著開關
   CALL aooi900_02_set_seqaction_active("s_detail1","up_seq", "down_seq")
END FUNCTION

################################################################################
# Descriptions...: 動態切換調整順序功能鍵
# Memo...........:
# Usage..........: CALL aooi900_02_set_seqaction_active(ps_upaction, ps_downaction)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_set_seqaction_active(ps_array,ps_upaction,ps_downaction)
   DEFINE ps_array        STRING
   DEFINE ps_upaction     STRING
   DEFINE ps_downaction   STRING
   DEFINE li_idx          LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE l_max_idx       LIKE type_t.num10  #161108-00012#2 num5==》num10

   IF g_curr_diag.getArrayLength(ps_array) = 0 THEN
      CALL g_curr_diag.setActionActive(ps_upaction, FALSE)
      CALL g_curr_diag.setActionActive(ps_downaction, FALSE)
   ELSE
      CALL g_curr_diag.setActionActive(ps_upaction, TRUE)
      CALL g_curr_diag.setActionActive(ps_downaction, TRUE)

      IF g_curr_diag.getCurrentRow(ps_array) = 1 THEN
         CALL g_curr_diag.setActionActive(ps_upaction, FALSE)
      END IF
      IF g_curr_diag.getCurrentRow(ps_array) = g_curr_diag.getArrayLength(ps_array) THEN
         CALL g_curr_diag.setActionActive(ps_downaction, FALSE)
      END IF
      LET li_idx = g_curr_diag.getCurrentRow(ps_array)  
   END IF
END FUNCTION

################################################################################
# Descriptions...: 整批維護刪除後的序號
# Memo...........:
# Usage..........: CALL aooi900_02_refresh_seq()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 140819 By janet
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi900_02_refresh_seq()
   DEFINE li_i       LIKE type_t.num5
   DEFINE li_idx_t   LIKE type_t.num10   #暫時的位置
   DEFINE ls_table   STRING
   DEFINE ls_key1    STRING
   DEFINE ls_key2    STRING
   DEFINE ls_key3    STRING 
   DEFINE ls_seq     STRING
   DEFINE l_sql      STRING   

   LET l_sql = "UPDATE gzgp_t SET gzgp002 = ?",
               " WHERE gzgp001 = '", g_gzgp_m.gzgp001,"' AND gzgp003 = '",g_gzgp_m.gzgp003,"'",
               "   AND gzgpstus ='Y' AND gzgp002 = ?"  

   PREPARE batch_refresh_seq_pre FROM l_sql

   #將序號調整為目前Table所視順序
   FOR li_i = 1 TO g_curr_diag.getArrayLength("s_detail1")
       #先搬去好遙遠的位置上排序, 這樣就不會重覆
       LET li_idx_t = li_i * 10000
       EXECUTE batch_refresh_seq_pre USING li_idx_t, g_gzgp_d[li_i].gzgp002
       LET g_gzgp_d[li_i].gzgp002 = li_idx_t          
   END FOR 
   
   #再跑一次讓序號還原
   FOR li_i = 1 TO g_curr_diag.getArrayLength("s_detail1")
       EXECUTE batch_refresh_seq_pre USING li_i, g_gzgp_d[li_i].gzgp002
   END FOR

   #重整
    CALL aooi900_02_b_fill(g_wc2) #單身填充
      
END FUNCTION

 
{</section>}
 
