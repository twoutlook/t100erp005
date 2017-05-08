#+ Version..: T6-ERP-1.00.00 Build-000049
#+ 
#+ Filename...: azzi102
#+ Buildtype..: 應用 i07 樣板自動產生
#+ Memo.......: 
#+ 以上段落由子樣板a00產生
 
 
{<point name="global.memo" />}
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
{<point name="global.import" />}
#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
{<Module define>}
 
#單頭 type 宣告
PRIVATE type type_g_gztw_m        RECORD
       gztw001 LIKE gztw_t.gztw001, 
   gztv003 LIKE type_t.chr100
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gztw_d        RECORD
       gztwstus LIKE gztw_t.gztwstus, 
   gztw002 LIKE gztw_t.gztw002, 
   gztx004 LIKE type_t.chr80, 
   gztwmodid LIKE gztw_t.gztwmodid, 
   gztwmodid_desc LIKE type_t.chr80, 
   gztwmoddt LIKE gztw_t.gztwmoddt, 
   gztwownid LIKE gztw_t.gztwownid, 
   gztwownid_desc LIKE type_t.chr80, 
   gztwowndp LIKE gztw_t.gztwowndp, 
   gztwowndp_desc LIKE type_t.chr80, 
   gztwcrtid LIKE gztw_t.gztwcrtid, 
   gztwcrtid_desc LIKE type_t.chr80, 
   gztwcrtdp LIKE gztw_t.gztwcrtdp, 
   gztwcrtdp_desc LIKE type_t.chr80, 
   gztwcrtdt LIKE gztw_t.gztwcrtdt
       END RECORD
 
 
DEFINE g_master_multi_table_t    RECORD
      gztw001 LIKE gztw_t.gztw001,
      gztv003 LIKE gztv_t.gztv003
      END RECORD
DEFINE g_detail_multi_table_t    RECORD
      gztx001 LIKE gztx_t.gztx001,
      gztx002 LIKE gztx_t.gztx002,
      gztx003 LIKE gztx_t.gztx003,
      gztx004 LIKE gztx_t.gztx004
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_gztw_m          type_g_gztw_m
DEFINE g_gztw_m_t        type_g_gztw_m
 
DEFINE g_gztw001_t     LIKE gztw_t.gztw001
 
 
DEFINE g_gztw_d          DYNAMIC ARRAY OF type_g_gztw_d
DEFINE g_gztw_d_t        type_g_gztw_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gztw001 LIKE gztw_t.gztw001,
   b_gztw001_desc LIKE type_t.chr80
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
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
 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
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
 
{</Module define>}
 
#add-point:自定義模組變數(Module Variable)
{<point name="global.variable"/>}
#end add-point
 
#+ 此段落由子樣板a26產生
#+ 作業開始 
MAIN
   #add-point:main段define
   {<point name="main.define"/>}
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化
   {<point name="main.init" />}
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   LET g_forupd_sql = "SELECT gztw001,'' FROM gztw_t WHERE gztw001=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE azzi102_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
   
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi102 WITH FORM cl_ap_formpath("azz",g_code)
 
      #程式初始化
      CALL azzi102_init()   
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #進入選單 Menu (="N")
      CALL azzi102_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_azzi102
      
   END IF 
   
   CLOSE azzi102_cl
   
   
 
   #add-point:作業離開前
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
    
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi102_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point    
   
   #add-point:畫面資料初始化
   {<point name="init.init"/>}
   #end add-point
   
   
   
   
   CALL azzi102_default_search()
    
END FUNCTION
 
 
#+ 功能選單
PRIVATE FUNCTION azzi102_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point  
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
   CALL gfrm_curr.setElementHidden("mainlayout",1)
   CALL gfrm_curr.setElementHidden("worksheet",0)
   LET g_main_hidden = 1
   
   #add-point:ui_dialog段before dialog 
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point
   
   WHILE TRUE
   
      CALL azzi102_browser_fill("")
 
      CALL lib_cl_dlg.cl_query_bef_disp()
      CALL lib_cl_dlg.cl_relate_bef_disp()
      CALL cl_notice()
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_gztw001 = g_gztw001_t
 
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
         
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               
               IF g_current_idx > g_browser.getLength() THEN
                  LEt g_current_idx = g_browser.getLength()
               END IF 
               
               CALL azzi102_fetch('') # reload data
               #CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
               LET g_detail_idx = 1
               CALL azzi102_ui_detailshow() #Setting the current row 
         
         END DISPLAY
        
         DISPLAY ARRAY g_gztw_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL azzi102_ui_detailshow()
               
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
               
         END DISPLAY
        
 
         
         SUBDIALOG lib_cl_dlg.dlg_qryplan
         SUBDIALOG lib_cl_dlg.dlg_relateapps 
      
         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point
         
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
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
               CALL azzi102_fetch('') # reload data
            END IF
            #CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            LET g_detail_idx = 1
            CALL azzi102_ui_detailshow() #Setting the current row 
            
            #若無資料則關閉相關功能
            IF g_browser_cnt = 0 THEN
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
            ELSE
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
            END IF
            
            #add-point:ui_dialog段before dialog2
            {<point name="ui_dialog.before_dialog2"/>}
            #end add-point
 
         #ACTION表單列
         ON ACTION filter
            CALL azzi102_filter()
            EXIT DIALOG
         
         ON ACTION first
            CALL azzi102_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL azzi102_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL azzi102_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL azzi102_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL azzi102_fetch('L')
            LET g_current_row = g_current_idx
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT WHILE     
          
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT WHILE
          
         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            
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
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL azzi102_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL azzi102_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL azzi102_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION exporttoexcel
 
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN 
               #add-point:ON ACTION exporttoexcel
               {<point name="menu.exporttoexcel" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL azzi102_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL azzi102_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION related_document
 
            LET g_action_choice="related_document"
            IF cl_auth_chk_act("related_document") THEN 
               #add-point:ON ACTION related_document
               {<point name="menu.related_document" />}
               #END add-point
                EXIT DIALOG
            END IF
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
            
      END DIALOG
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION azzi102_browser_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #end add-point    
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      CALL cl_err("searchcol","std-00005",0)
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
      LET g_wc = g_wc, " ORDER BY gztw001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL azzi102_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE
 
END FUNCTION
 
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi102_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point    
   
   CALL g_browser.clear()
 
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "gztw001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE gztw001 ",
 
                      " FROM gztw_t ",
                      " LEFT JOIN gztv_t ON gztw001 = gztv001 AND gztv002 = '",g_lang,"' ",
                      " LEFT JOIN gztx_t ON gztw001 = gztx001 AND gztw002 = gztx002 AND gztx003 = '",g_lang,"' ",
                      " WHERE  ",l_wc, " AND ", l_wc2 
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE gztw001 ",
 
                      " FROM gztw_t ",
                      " LEFT JOIN gztv_t ON gztw001 = gztv001 AND gztv002 = '",g_lang,"' ",
                      " LEFT JOIN gztx_t ON gztw001 = gztx001 AND gztw002 = gztx002 AND gztx003 = '",g_lang,"' ",
                      " WHERE  ",l_wc CLIPPED
 
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      CALL cl_err(g_browser_cnt,'9035',1)
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #LET g_page_action = ps_page_action          # Keep Action
   IF ps_page_action = "first" OR              
      ps_page_action = "prev"  OR
      ps_page_action = "next"  OR
      ps_page_action = "last"  THEN
      LET g_page_action = ps_page_action        #g_page_action 這個會影響 browser 下面四個button 的判斷 
   END IF
   
   CASE ps_page_action
      WHEN "F" 
         LET g_pagestart = 1
          
      WHEN "P"  
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
             LET g_pagestart = 1
         END IF
          
      WHEN "N"  
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
         
   END CASE
   
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
 
      #依照gztw001,'' Browser欄位定義(取代原本bs_sql功能)
      LET l_sub_sql  = "SELECT DISTINCT gztw001,'' ",
                       " FROM gztw_t ",
                       " ",
                       " WHERE  ", g_wc," AND ",g_wc2
 
   ELSE
      #單身無輸入資料
      LET l_sub_sql  = "SELECT DISTINCT gztw001,'' ",
                       " FROM gztw_t ",
                       " WHERE  ", g_wc
                 
   END IF
   
   LET l_sql_rank = "SELECT gztw001,'',DENSE_RANK() OVER(ORDER BY gztw001 ",g_order,") AS RANK ",
                    " FROM (",l_sub_sql,") "
                       
   #定義翻頁CURSOR
   LET g_sql= " SELECT gztw001,'' FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
              " AND RANK<",g_pagestart+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
                
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_gztw001,g_browser[g_cnt].b_gztw001_desc    
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_gztw001
      CALL ap_ref_array2(g_ref_fields,"SELECT gztv003 FROM gztv_t WHERE gztv001=? AND gztv002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_gztw001_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_browser[g_cnt].b_gztw001_desc
 
      
      #add-point:browser_fill段reference
      {<point name="browser_fill.reference"/>}
      #end add-point    
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND g_wc THEN
      INITIALIZE g_gztw_m.* TO NULL
      CALL g_gztw_d.clear()
 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   CALL azzi102_fetch('')
   
   FREE browse_pre
   
END FUNCTION
 
 
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi102_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point    
   
   LET g_gztw_m.gztw001 = g_browser[g_current_idx].b_gztw001   
 
    SELECT UNIQUE gztw001
 INTO g_gztw_m.gztw001
 FROM gztw_t
 WHERE gztw001 = g_gztw_m.gztw001
   CALL azzi102_show()
   
END FUNCTION
 
 
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi102_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point    
   
   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point 
   
END FUNCTION
 
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi102_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gztw001 = g_gztw_m.gztw001 
 
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
 
 
#+ QBE資料查詢
PRIVATE FUNCTION azzi102_construct()
 
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_gztw_m.* TO NULL
   CALL g_gztw_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gztw001
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.head.before_construct"/>}
            #end add-point 
            
        #---------------------------<  Master  >---------------------------
         #----<<gztw001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztw001
            #add-point:BEFORE FIELD gztw001
            {<point name="construct.b.gztw001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztw001
            
            #add-point:AFTER FIELD gztw001
            {<point name="construct.a.gztw001" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gztw001
#         ON ACTION controlp INFIELD gztw001
            #add-point:ON ACTION controlp INFIELD gztw001
            {<point name="construct.c.gztw001" />}
            #END add-point
 
         #----<<gztv003>>----
 
         
      END CONSTRUCT
 
      #單身可以混搭多頁簽
      CONSTRUCT g_wc2 ON gztwstus,gztw002,gztwmodid,gztwmoddt,gztwownid,gztwowndp,gztwcrtid,gztwcrtdp,gztwcrtdt
 
         FROM s_detail1[1].gztwstus,s_detail1[1].gztw002,s_detail1[1].gztwmodid,s_detail1[1].gztwmoddt,s_detail1[1].gztwownid,s_detail1[1].gztwowndp,s_detail1[1].gztwcrtid,s_detail1[1].gztwcrtdp,s_detail1[1].gztwcrtdt
 
                      
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point 
            
            #公用欄位開窗相關處理
            #此段落由子樣板a11產生---
         ##----<<gztwownid>>----
         #ON ACTION controlp INFIELD gztwownid
         #   CALL q_common('gztw_t','gztwownid',TRUE,FALSE,g_gztw_d[1].gztwownid) RETURNING ls_return
         #   DISPLAY ls_return TO gztwownid
         #   NEXT FIELD gztwownid  
         #
         ##----<<gztwowndp>>----
         #ON ACTION controlp INFIELD gztwowndp
         #   CALL q_common('gztw_t','gztwowndp',TRUE,FALSE,g_gztw_d[1].gztwowndp) RETURNING ls_return
         #   DISPLAY ls_return TO gztwowndp
         #   NEXT FIELD gztwowndp
         #
         ##----<<gztwcrtid>>----
         #ON ACTION controlp INFIELD gztwcrtid
         #   CALL q_common('gztw_t','gztwcrtid',TRUE,FALSE,g_gztw_d[1].gztwcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO gztwcrtid
         #   NEXT FIELD gztwcrtid
         #
         ##----<<gztwcrtdp>>----
         #ON ACTION controlp INFIELD gztwcrtdp
         #   CALL q_common('gztw_t','gztwcrtdp',TRUE,FALSE,g_gztw_d[1].gztwcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO gztwcrtdp
         #   NEXT FIELD gztwcrtdp
         #
         ##----<<gztwmodid>>----
         #ON ACTION controlp INFIELD gztwmodid
         #   CALL q_common('gztw_t','gztwmodid',TRUE,FALSE,g_gztw_d[1].gztwmodid) RETURNING ls_return
         #   DISPLAY ls_return TO gztwmodid
         #   NEXT FIELD gztwmodid
         #
         ##----<<gztwcnfid>>----
         ##ON ACTION controlp INFIELD gztwcnfid
         ##   CALL q_common('gztw_t','gztwcnfid',TRUE,FALSE,g_gztw_d[1].gztwcnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO gztwcnfid
         ##   NEXT FIELD gztwcnfid
         #
         ##----<<gztwpstid>>----
         ##ON ACTION controlp INFIELD gztwpstid
         ##   CALL q_common('gztw_t','gztwpstid',TRUE,FALSE,g_gztw_d[1].gztwpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO gztwpstid
         ##   NEXT FIELD gztwpstid
         
         ##----<<gztwcrtdt>>----
         AFTER FIELD gztwcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gztwmoddt>>----
         AFTER FIELD gztwmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gztwcnfdt>>----
         #AFTER FIELD gztwcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gztwpstdt>>----
         #AFTER FIELD gztwpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
          
            #---------------------<  Detail: page1  >---------------------
         #----<<gztwstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztwstus
            #add-point:BEFORE FIELD gztwstus
            {<point name="construct.b.page1.gztwstus" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwstus
            
            #add-point:AFTER FIELD gztwstus
            {<point name="construct.a.page1.gztwstus" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gztwstus
#         ON ACTION controlp INFIELD gztwstus
            #add-point:ON ACTION controlp INFIELD gztwstus
            {<point name="construct.c.page1.gztwstus" />}
            #END add-point
 
         #----<<gztw002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztw002
            #add-point:BEFORE FIELD gztw002
            {<point name="construct.b.page1.gztw002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztw002
            
            #add-point:AFTER FIELD gztw002
            {<point name="construct.a.page1.gztw002" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gztw002
#         ON ACTION controlp INFIELD gztw002
            #add-point:ON ACTION controlp INFIELD gztw002
            {<point name="construct.c.page1.gztw002" />}
            #END add-point
 
         #----<<gztwmodid>>----
         #Ctrlp:construct.c.page1.gztwmodid
         ON ACTION controlp INFIELD gztwmodid
            #add-point:ON ACTION controlp INFIELD gztwmodid
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztwmodid  #顯示到畫面上

            NEXT FIELD gztwmodid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwmodid
            #add-point:BEFORE FIELD gztwmodid
            {<point name="construct.b.page1.gztwmodid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwmodid
            
            #add-point:AFTER FIELD gztwmodid
            {<point name="construct.a.page1.gztwmodid" />}
            #END add-point
            
 
         #----<<gztwmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztwmoddt
            #add-point:BEFORE FIELD gztwmoddt
            {<point name="construct.b.page1.gztwmoddt" />}
            #END add-point
 
         #----<<gztwownid>>----
         #Ctrlp:construct.c.page1.gztwownid
         ON ACTION controlp INFIELD gztwownid
            #add-point:ON ACTION controlp INFIELD gztwownid
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztwownid  #顯示到畫面上

            NEXT FIELD gztwownid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwownid
            #add-point:BEFORE FIELD gztwownid
            {<point name="construct.b.page1.gztwownid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwownid
            
            #add-point:AFTER FIELD gztwownid
            {<point name="construct.a.page1.gztwownid" />}
            #END add-point
            
 
         #----<<gztwowndp>>----
         #Ctrlp:construct.c.page1.gztwowndp
         ON ACTION controlp INFIELD gztwowndp
            #add-point:ON ACTION controlp INFIELD gztwowndp
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztwowndp  #顯示到畫面上

            NEXT FIELD gztwowndp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwowndp
            #add-point:BEFORE FIELD gztwowndp
            {<point name="construct.b.page1.gztwowndp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwowndp
            
            #add-point:AFTER FIELD gztwowndp
            {<point name="construct.a.page1.gztwowndp" />}
            #END add-point
            
 
         #----<<gztwcrtid>>----
         #Ctrlp:construct.c.page1.gztwcrtid
         ON ACTION controlp INFIELD gztwcrtid
            #add-point:ON ACTION controlp INFIELD gztwcrtid
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztwcrtid  #顯示到畫面上

            NEXT FIELD gztwcrtid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwcrtid
            #add-point:BEFORE FIELD gztwcrtid
            {<point name="construct.b.page1.gztwcrtid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwcrtid
            
            #add-point:AFTER FIELD gztwcrtid
            {<point name="construct.a.page1.gztwcrtid" />}
            #END add-point
            
 
         #----<<gztwcrtdp>>----
         #Ctrlp:construct.c.page1.gztwcrtdp
         ON ACTION controlp INFIELD gztwcrtdp
            #add-point:ON ACTION controlp INFIELD gztwcrtdp
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gztwcrtdp  #顯示到畫面上

            NEXT FIELD gztwcrtdp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwcrtdp
            #add-point:BEFORE FIELD gztwcrtdp
            {<point name="construct.b.page1.gztwcrtdp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwcrtdp
            
            #add-point:AFTER FIELD gztwcrtdp
            {<point name="construct.a.page1.gztwcrtdp" />}
            #END add-point
            
 
         #----<<gztwcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztwcrtdt
            #add-point:BEFORE FIELD gztwcrtdt
            {<point name="construct.b.page1.gztwcrtdt" />}
            #END add-point
 
   
 
          
      END CONSTRUCT
  
      #add-point:cs段more_construct
      {<point name="cs.more_construct"/>}
      #end add-point
 
      BEFORE DIALOG
         #add-point:ui_dialog段b_dialog
         {<point name="cs.before_dialog"/>}
         #end add-point
      
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list() RETURNING lc_qbe_sn
         CALL cl_qbe_display_condition(lc_qbe_sn)
 
      ON ACTION qbe_save       #條件儲存
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
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
 
#+ filter過濾功能
PRIVATE FUNCTION azzi102_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define
   {<point name="filter.define"/>}
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON gztw001
                          FROM s_browse[1].b_gztw001
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
               DISPLAY azzi102_filter_parser('gztw001') TO s_browse[1].b_gztw001
 
      END CONSTRUCT
 
      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
         #end add-point  
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
END FUNCTION
 
#+ filter過濾功能
PRIVATE FUNCTION azzi102_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   {<point name="filter_parser.define"/>}
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
 
 
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi102_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
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
   CALL g_gztw_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL azzi102_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi102_browser_fill(g_wc)
      CALL azzi102_fetch("")
      RETURN
   END IF
   
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
 
   CALL azzi102_browser_fill("F")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      CALL azzi102_browser_fill("F")
   END IF
   
   #第二層助記碼搜尋
   IF g_browser_cnt = 0 THEN
 
      LET g_wc = cl_mcode_parser(ls_wc,'gztv_t','gztv004','gztw_t','gztw001','1','')
      
      IF NOT cl_null(g_wc) THEN
         CALL azzi102_browser_fill("F")
      END IF
      
   END IF
   
   IF g_browser_cnt = 0 THEN
      CALL cl_err("","-100",1)
      CLEAR FORM
   ELSE
      CALL azzi102_fetch("F") 
   END IF
   
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi102_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point    
 
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
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
   
   #該樣板不需此段落CALL azzi102_browser_fill(p_flag)
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
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
   
   LET g_gztw_m.gztw001 = g_browser[g_current_idx].b_gztw001
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE gztw001
 INTO g_gztw_m.gztw001
 FROM gztw_t
 WHERE gztw001 = g_gztw_m.gztw001
   IF SQLCA.sqlcode THEN
      CALL cl_err("gztw_t",SQLCA.sqlcode,1)
      INITIALIZE g_gztw_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL azzi102_show()
 
END FUNCTION
 
 
#+ 資料新增
PRIVATE FUNCTION azzi102_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gztw_d.clear()
 
 
   INITIALIZE g_gztw_m.* LIKE gztw_t.*             #DEFAULT 設定
   LET g_gztw001_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point 
 
      CALL azzi102_input("a")
      
      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gztw_m.* = g_gztw_m_t.*
         CALL azzi102_show()
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
      
      CALL g_gztw_d.clear()
 
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   LET g_state = "Y"
   
   LET g_gztw001_t = g_gztw_m.gztw001
 
   
   LET g_wc = g_wc,  
              " OR (  ",
              " gztw001 = '", g_gztw_m.gztw001 CLIPPED, "' "
 
              , ") "
   
END FUNCTION
 
 
#+ 資料修改
PRIVATE FUNCTION azzi102_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point    
   
   IF g_gztw_m.gztw001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
   
    SELECT UNIQUE gztw001
 INTO g_gztw_m.gztw001
 FROM gztw_t
 WHERE gztw001 = g_gztw_m.gztw001
 
   ERROR ""
  
   LET g_gztw001_t = g_gztw_m.gztw001
 
   CALL s_transaction_begin()
   
   OPEN azzi102_cl USING g_gztw_m.gztw001
 
   IF STATUS THEN
      CALL cl_err("OPEN azzi102_cl:", STATUS, 1)
      CLOSE azzi102_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH azzi102_cl INTO g_gztw_m.gztw001,g_gztw_m.gztv003
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_gztw_m.gztw001,SQLCA.sqlcode,0)
      CLOSE azzi102_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL azzi102_show()
   WHILE TRUE
      LET g_gztw001_t = g_gztw_m.gztw001
 
 
      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point
      
      CALL azzi102_input("u")     #欄位更改
      
      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gztw_m.* = g_gztw_m_t.*
         CALL azzi102_show()
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_gztw_m.gztw001 != g_gztw001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         {<point name="modify.b_key_update"/>}
         #end add-point
         
         #更新單頭key值
         UPDATE gztw_t SET gztw001 = g_gztw_m.gztw001
 
          WHERE  gztw001 = g_gztw001_t
 
          IF SQLCA.sqlcode THEN
             CALL cl_err("gztw_t",SQLCA.sqlcode,1) 
             CALL s_transaction_end('N','0')
             CONTINUE WHILE
         END IF
         
         #add-point:單頭(偽)修改後
         {<point name="modify.a_key_update"/>}
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_used_modified_record(g_gztw_m.gztw001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE azzi102_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_gztw_m.gztw001,'U')
 
   CALL azzi102_b_fill("1=1")
   
END FUNCTION   
 
 
#+ 資料輸入
PRIVATE FUNCTION azzi102_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   #end add-point    
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_forupd_sql = "SELECT gztwstus,gztw002,'',gztwmodid,'',gztwmoddt,gztwownid,'',gztwowndp,'',gztwcrtid,'',gztwcrtdp,'',gztwcrtdt FROM gztw_t WHERE gztw001=? AND gztw002=? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE azzi102_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi102_set_entry(p_cmd)
   CALL azzi102_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gztw_m.gztw001,g_gztw_m.gztv003
   
   #add-point:進入修改段前
   {<point name="input.before_input"/>}
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_gztw_m.gztw001,g_gztw_m.gztv003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
 
         ON ACTION update_item
 
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN 
               #add-point:ON ACTION update_item
               {<point name="input.master_input.update_item" />}
               #END add-point
            END IF
 
         
         BEFORE INPUT
            
            LET g_master_multi_table_t.gztw001 = g_gztw_m.gztw001
LET g_master_multi_table_t.gztv003 = g_gztw_m.gztv003
 
          
         #---------------------------<  Master  >---------------------------
         #----<<gztw001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztw001
            #add-point:BEFORE FIELD gztw001
            {<point name="input.b.gztw001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztw001
            
            #add-point:AFTER FIELD gztw001
#此段落由子樣板a05產生
            IF  NOT cl_null(g_gztw_m.gztw001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_gztw_m.gztw001 != g_gztw001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gztw_t WHERE "||"gztw001 = '"||g_gztw_m.gztw001 ||"'",'std-00004',0) THEN 
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gztw001
            #add-point:ON CHANGE gztw001
            {<point name="input.g.gztw001" />}
            #END add-point
 
         #----<<gztv003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztv003
            #add-point:BEFORE FIELD gztv003
            {<point name="input.b.gztv003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztv003
            
            #add-point:AFTER FIELD gztv003
            {<point name="input.a.gztv003" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gztv003
            #add-point:ON CHANGE gztv003
            {<point name="input.g.gztv003" />}
            #END add-point
 
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<gztw001>>----
         #Ctrlp:input.c.gztw001
#         ON ACTION controlp INFIELD gztw001
            #add-point:ON ACTION controlp INFIELD gztw001
            {<point name="input.c.gztw001" />}
            #END add-point
 
         #----<<gztv003>>----
         #Ctrlp:input.c.gztv003
#         ON ACTION controlp INFIELD gztv003
            #add-point:ON ACTION controlp INFIELD gztv003
            {<point name="input.c.gztv003" />}
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            CALL s_transaction_begin()
 
            #多語言處理
                     INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gztw_m.gztw001 = g_master_multi_table_t.gztw001 AND
         g_gztw_m.gztv003 = g_master_multi_table_t.gztv003 THEN
         ELSE 
            LET l_var_keys[01] = g_gztw_m.gztw001
            LET l_field_keys[01] = 'gztv001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gztw001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gztv002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gztw_m.gztv003
            LET l_fields[01] = 'gztv003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gztv_t')
         END IF 
 
                
            CALL cl_showmsg()
            DISPLAY BY NAME g_gztw_m.gztw001             
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               {<point name="input.head.b_update"/>}
               #end add-point
            
               UPDATE gztw_t SET (gztw001) = (g_gztw_m.gztw001)
                WHERE  gztw001 = g_gztw001_t
 
               IF SQLCA.sqlcode THEN
                  CALL cl_err("g_gztw_m",SQLCA.sqlcode,1)  
                  CALL s_transaction_end('N','0')
               ELSE
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gztw_m.gztw001 = g_master_multi_table_t.gztw001 AND
         g_gztw_m.gztv003 = g_master_multi_table_t.gztv003 THEN
         ELSE 
            LET l_var_keys[01] = g_gztw_m.gztw001
            LET l_field_keys[01] = 'gztv001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gztw001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gztv002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gztw_m.gztv003
            LET l_fields[01] = 'gztv003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gztv_t')
         END IF 
 
                  LET g_gztw001_t = g_gztw_m.gztw001
 
                  #add-point:單頭修改後
                  {<point name="input.head.a_update"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
            
            
            ELSE    
               #add-point:單頭新增
               {<point name="input.head.a_insert"/>}
               #end add-point
            END IF
           #controlp
           
           #若單身還沒有輸入資料, 強制切換至單身
           IF cl_null(g_gztw_d[1].gztw002) THEN
              NEXT FIELD gztw002
           END IF
 
      END INPUT
    
      #Page1 預設值產生於此處
      INPUT ARRAY g_gztw_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
 
         ON ACTION update_item
 
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN 
               #add-point:ON ACTION update_item
               {<point name="input.detail_input.page1.update_item" />}
               #END add-point
            END IF
 
 
         BEFORE INPUT
		    IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gztw_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi102_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN azzi102_cl USING 
                                               g_gztw_m.gztw001
 
                                               
               IF STATUS THEN
                  CALL cl_err("OPEN azzi102_cl:", STATUS, 1)
                  CLOSE azzi102_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_gztw_d[l_ac].gztw002) 
 
            THEN
               LET l_cmd='u'
               LET g_gztw_d_t.* = g_gztw_d[l_ac].*  #BACKUP
               OPEN azzi102_bcl USING g_gztw_m.gztw001,
 
                                                g_gztw_d_t.gztw002
 
               IF STATUS THEN
                  CALL cl_err("OPEN azzi102_bcl:", STATUS, 1)
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi102_bcl INTO g_gztw_d[l_ac].gztwstus,g_gztw_d[l_ac].gztw002,g_gztw_d[l_ac].gztx004,g_gztw_d[l_ac].gztwmodid,g_gztw_d[l_ac].gztwmodid_desc,g_gztw_d[l_ac].gztwmoddt,g_gztw_d[l_ac].gztwownid,g_gztw_d[l_ac].gztwownid_desc,g_gztw_d[l_ac].gztwowndp,g_gztw_d[l_ac].gztwowndp_desc,g_gztw_d[l_ac].gztwcrtid,g_gztw_d[l_ac].gztwcrtid_desc,g_gztw_d[l_ac].gztwcrtdp,g_gztw_d[l_ac].gztwcrtdp_desc,g_gztw_d[l_ac].gztwcrtdt
                  IF SQLCA.sqlcode THEN
                      CALL cl_err(g_gztw_d_t.gztw002,SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  END IF
                  CALL azzi102_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body.before_row"/>}
            #end add-point  
            LET g_detail_multi_table_t.gztx001 = g_gztw_m.gztw001
LET g_detail_multi_table_t.gztx002 = g_gztw_d[l_ac].gztw002
LET g_detail_multi_table_t.gztx003 = g_dlang
LET g_detail_multi_table_t.gztx004 = g_gztw_d[l_ac].gztx004
 
        
         BEFORE INSERT
		    
            INITIALIZE g_gztw_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gztw_d[l_ac].* TO NULL
            
            #公用欄位預設值
            #此段落由子樣板a14產生    
      LET g_gztw_d[l_ac].gztwownid = g_user
      LET g_gztw_d[l_ac].gztwowndp = g_dept
      LET g_gztw_d[l_ac].gztwcrtid = g_user
      LET g_gztw_d[l_ac].gztwcrtdp = g_dept 
      LET g_gztw_d[l_ac].gztwcrtdt = cl_get_current()
      #LET g_gztw_d[l_ac].gztwmodid = g_user
      #LET g_gztw_d[l_ac].gztwmoddt = cl_get_current()
      #LET g_gztw_d[l_ac].gztwstus = "Y"
 
  
            
            #一般欄位預設值
            
            
            
            LET g_gztw_d_t.* = g_gztw_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi102_set_entry_b()
            CALL azzi102_set_no_entry_b()
            LET g_detail_multi_table_t.gztx001 = g_gztw_m.gztw001
LET g_detail_multi_table_t.gztx002 = g_gztw_d[l_ac].gztw002
LET g_detail_multi_table_t.gztx003 = g_dlang
LET g_detail_multi_table_t.gztx004 = g_gztw_d[l_ac].gztx004
 
            #add-point:modify段before insert
            {<point name="input.body.before_insert"/>}
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM gztw_t 
             WHERE  gztw001 = g_gztw_m.gztw001
 
               AND gztw002 = g_gztw_d[l_ac].gztw002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               
               CALL s_transaction_begin()
            
               #add-point:單身新增前
               {<point name="input.body.b_insert"/>}
               #end add-point
               
               INSERT INTO gztw_t
                           (
                            gztw001,
                            gztw002
                            ,gztwstus,gztwmodid,gztwmoddt,gztwownid,gztwowndp,gztwcrtid,gztwcrtdp,gztwcrtdt) 
                     VALUES(
                            g_gztw_m.gztw001,
                            g_gztw_d[l_ac].gztw002
                            ,g_gztw_d[l_ac].gztwstus,g_gztw_d[l_ac].gztwmodid,g_gztw_d[l_ac].gztwmoddt,g_gztw_d[l_ac].gztwownid,g_gztw_d[l_ac].gztwowndp,g_gztw_d[l_ac].gztwcrtid,g_gztw_d[l_ac].gztwcrtdp,g_gztw_d[l_ac].gztwcrtdt)
               
               LET p_cmd = 'u'
            ELSE    
               CALL cl_err('INSERT',"std-00006",1)
               INITIALIZE g_gztw_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               CALL cl_err("gztw_t",SQLCA.sqlcode,1)  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gztw_m.gztw001 = g_detail_multi_table_t.gztx001 AND
         g_gztw_d[l_ac].gztw002 = g_detail_multi_table_t.gztx002 AND
         g_gztw_d[l_ac].gztx004 = g_detail_multi_table_t.gztx004 THEN
         ELSE 
            LET l_var_keys[01] = g_gztw_m.gztw001
            LET l_field_keys[01] = 'gztx001'
            LET l_var_keys[02] = g_gztw_d[l_ac].gztw002
            LET l_field_keys[02] = 'gztx002'
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'gztx003'
            LET l_vars[01] = g_gztw_d[l_ac].gztx004
            LET l_fields[01] = 'gztx004'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gztx001
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gztx002
            LET l_var_keys_bak[03] = g_detail_multi_table_t.gztx003
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gztx_t')
         END IF 
 
               #add-point:input段-after_insert
               {<point name="input.body.a_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後
            {<point name="input.body.after_insert"/>}
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_gztw_d_t.gztw002) 
 
               THEN
               
               #add-point:單身刪除前
               {<point name="input.body.b_delete"/>}
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  CALL cl_err("", -263, 1)
                  CANCEL DELETE
               END IF
               IF azzi102_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE azzi102_bcl
               LET l_count = g_gztw_d.getLength()
            END IF 
            
            #add-point:單身刪除後
            {<point name="input.body.a_delete"/>}
            #end add-point
              
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            {<point name="input.body.after_delete"/>}
            #end add-point
            CALL azzi102_delete_b(l_count) 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<gztwstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztwstus
            #add-point:BEFORE FIELD gztwstus
            {<point name="input.b.page1.gztwstus" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwstus
            
            #add-point:AFTER FIELD gztwstus
            {<point name="input.a.page1.gztwstus" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gztwstus
            #add-point:ON CHANGE gztwstus
            {<point name="input.g.page1.gztwstus" />}
            #END add-point
 
         #----<<gztw002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztw002
            #add-point:BEFORE FIELD gztw002
            {<point name="input.b.page1.gztw002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztw002
            
            #add-point:AFTER FIELD gztw002
#此段落由子樣板a05產生
            IF  NOT cl_null(g_gztw_m.gztw001) AND NOT cl_null(g_gztw_d[l_ac].gztw002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_gztw_m.gztw001 != g_gztw001_t  OR g_gztw_d[l_ac].gztw002 != g_gztw_d_t.gztw002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gztw_t WHERE "||"gztw001 = '"||g_gztw_m.gztw001 ||"' AND "|| "gztw002 = '"||g_gztw_d[l_ac].gztw002 ||"'",'std-00004',0) THEN 
                  END IF
               END IF
            END IF



#此段落由子樣板a05產生
            IF  NOT cl_null(g_gztw_m.gztw001) AND NOT cl_null(g_gztw_d[l_ac].gztw002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_gztw_m.gztw001 != g_gztw001_t OR g_gztw_d[l_ac].gztw002 != g_gztw_d_t.gztw002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gztw_t WHERE "||"gztw001 = '"||g_gztw_m.gztw001 ||"' AND "|| "gztw002 = '"||g_gztw_d[l_ac].gztw002 ||"'",'std-00004',0) THEN 
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gztw002
            #add-point:ON CHANGE gztw002
            {<point name="input.g.page1.gztw002" />}
            #END add-point
 
         #----<<gztwmodid>>----
         #此段落由子樣板a02產生
         AFTER FIELD gztwmodid
            
            #add-point:AFTER FIELD gztwmodid

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwmodid_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwmodid
            #add-point:BEFORE FIELD gztwmodid
            {<point name="input.b.page1.gztwmodid" />}
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gztwmodid
            #add-point:ON CHANGE gztwmodid
            {<point name="input.g.page1.gztwmodid" />}
            #END add-point
 
         #----<<gztwmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztwmoddt
            #add-point:BEFORE FIELD gztwmoddt
            {<point name="input.b.page1.gztwmoddt" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwmoddt
            
            #add-point:AFTER FIELD gztwmoddt
            {<point name="input.a.page1.gztwmoddt" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gztwmoddt
            #add-point:ON CHANGE gztwmoddt
            {<point name="input.g.page1.gztwmoddt" />}
            #END add-point
 
         #----<<gztwownid>>----
         #此段落由子樣板a02產生
         AFTER FIELD gztwownid
            
            #add-point:AFTER FIELD gztwownid

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwownid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwownid_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwownid
            #add-point:BEFORE FIELD gztwownid
            {<point name="input.b.page1.gztwownid" />}
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gztwownid
            #add-point:ON CHANGE gztwownid
            {<point name="input.g.page1.gztwownid" />}
            #END add-point
 
         #----<<gztwowndp>>----
         #此段落由子樣板a02產生
         AFTER FIELD gztwowndp
            
            #add-point:AFTER FIELD gztwowndp

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwowndp_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwowndp
            #add-point:BEFORE FIELD gztwowndp
            {<point name="input.b.page1.gztwowndp" />}
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gztwowndp
            #add-point:ON CHANGE gztwowndp
            {<point name="input.g.page1.gztwowndp" />}
            #END add-point
 
         #----<<gztwcrtid>>----
         #此段落由子樣板a02產生
         AFTER FIELD gztwcrtid
            
            #add-point:AFTER FIELD gztwcrtid

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwcrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwcrtid_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwcrtid
            #add-point:BEFORE FIELD gztwcrtid
            {<point name="input.b.page1.gztwcrtid" />}
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gztwcrtid
            #add-point:ON CHANGE gztwcrtid
            {<point name="input.g.page1.gztwcrtid" />}
            #END add-point
 
         #----<<gztwcrtdp>>----
         #此段落由子樣板a02產生
         AFTER FIELD gztwcrtdp
            
            #add-point:AFTER FIELD gztwcrtdp

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwcrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwcrtdp_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gztwcrtdp
            #add-point:BEFORE FIELD gztwcrtdp
            {<point name="input.b.page1.gztwcrtdp" />}
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gztwcrtdp
            #add-point:ON CHANGE gztwcrtdp
            {<point name="input.g.page1.gztwcrtdp" />}
            #END add-point
 
         #----<<gztwcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gztwcrtdt
            #add-point:BEFORE FIELD gztwcrtdt
            {<point name="input.b.page1.gztwcrtdt" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gztwcrtdt
            
            #add-point:AFTER FIELD gztwcrtdt
            {<point name="input.a.page1.gztwcrtdt" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gztwcrtdt
            #add-point:ON CHANGE gztwcrtdt
            {<point name="input.g.page1.gztwcrtdt" />}
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<gztwstus>>----
         #Ctrlp:input.c.page1.gztwstus
#         ON ACTION controlp INFIELD gztwstus
            #add-point:ON ACTION controlp INFIELD gztwstus
            {<point name="input.c.page1.gztwstus" />}
            #END add-point
 
         #----<<gztw002>>----
         #Ctrlp:input.c.page1.gztw002
#         ON ACTION controlp INFIELD gztw002
            #add-point:ON ACTION controlp INFIELD gztw002
            {<point name="input.c.page1.gztw002" />}
            #END add-point
 
         #----<<gztwmodid>>----
         #Ctrlp:input.c.page1.gztwmodid
#         ON ACTION controlp INFIELD gztwmodid
            #add-point:ON ACTION controlp INFIELD gztwmodid
            {<point name="input.c.page1.gztwmodid" />}
            #END add-point
 
         #----<<gztwmoddt>>----
         #Ctrlp:input.c.page1.gztwmoddt
#         ON ACTION controlp INFIELD gztwmoddt
            #add-point:ON ACTION controlp INFIELD gztwmoddt
            {<point name="input.c.page1.gztwmoddt" />}
            #END add-point
 
         #----<<gztwownid>>----
         #Ctrlp:input.c.page1.gztwownid
#         ON ACTION controlp INFIELD gztwownid
            #add-point:ON ACTION controlp INFIELD gztwownid
            {<point name="input.c.page1.gztwownid" />}
            #END add-point
 
         #----<<gztwowndp>>----
         #Ctrlp:input.c.page1.gztwowndp
#         ON ACTION controlp INFIELD gztwowndp
            #add-point:ON ACTION controlp INFIELD gztwowndp
            {<point name="input.c.page1.gztwowndp" />}
            #END add-point
 
         #----<<gztwcrtid>>----
         #Ctrlp:input.c.page1.gztwcrtid
#         ON ACTION controlp INFIELD gztwcrtid
            #add-point:ON ACTION controlp INFIELD gztwcrtid
            {<point name="input.c.page1.gztwcrtid" />}
            #END add-point
 
         #----<<gztwcrtdp>>----
         #Ctrlp:input.c.page1.gztwcrtdp
#         ON ACTION controlp INFIELD gztwcrtdp
            #add-point:ON ACTION controlp INFIELD gztwcrtdp
            {<point name="input.c.page1.gztwcrtdp" />}
            #END add-point
 
         #----<<gztwcrtdt>>----
         #Ctrlp:input.c.page1.gztwcrtdt
#         ON ACTION controlp INFIELD gztwcrtdt
            #add-point:ON ACTION controlp INFIELD gztwcrtdt
            {<point name="input.c.page1.gztwcrtdt" />}
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_gztw_d[l_ac].* = g_gztw_d_t.*
               CLOSE azzi102_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_gztw_d[l_ac].gztw002,-263,1)
               LET g_gztw_d[l_ac].* = g_gztw_d_t.*
            ELSE
            
               #add-point:單身修改前
               {<point name="input.body.b_update"/>}
               #end add-point
         
               UPDATE gztw_t SET (gztw001,gztwstus,gztw002,gztwmodid,gztwmoddt,gztwownid,gztwowndp,gztwcrtid,gztwcrtdp,gztwcrtdt) = (g_gztw_m.gztw001,g_gztw_d[l_ac].gztwstus,g_gztw_d[l_ac].gztw002,g_gztw_d[l_ac].gztwmodid,g_gztw_d[l_ac].gztwmoddt,g_gztw_d[l_ac].gztwownid,g_gztw_d[l_ac].gztwowndp,g_gztw_d[l_ac].gztwcrtid,g_gztw_d[l_ac].gztwcrtdp,g_gztw_d[l_ac].gztwcrtdt)
                WHERE  gztw001 = g_gztw_m.gztw001 
 
                 AND gztw002 = g_gztw_d_t.gztw002 #項次   
 
                      
               IF SQLCA.sqlcode THEN
                  CALL cl_err("gztw_t",SQLCA.sqlcode,1)   
                  LET g_gztw_d[l_ac].* = g_gztw_d_t.*
               ELSE
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_gztw_m.gztw001 = g_detail_multi_table_t.gztx001 AND
         g_gztw_d[l_ac].gztw002 = g_detail_multi_table_t.gztx002 AND
         g_gztw_d[l_ac].gztx004 = g_detail_multi_table_t.gztx004 THEN
         ELSE 
            LET l_var_keys[01] = g_gztw_m.gztw001
            LET l_field_keys[01] = 'gztx001'
            LET l_var_keys[02] = g_gztw_d[l_ac].gztw002
            LET l_field_keys[02] = 'gztx002'
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'gztx003'
            LET l_vars[01] = g_gztw_d[l_ac].gztx004
            LET l_fields[01] = 'gztx004'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.gztx001
            LET l_var_keys_bak[02] = g_detail_multi_table_t.gztx002
            LET l_var_keys_bak[03] = g_detail_multi_table_t.gztx003
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gztx_t')
         END IF 
 
               END IF
               
               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
            END IF
 
         AFTER INPUT
            #add-point:input段after input 
            {<point name="input.body.after_input"/>}
            #end add-point    
      END INPUT
 
 
      
      
      BEFORE DIALOG
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD gztw001
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET g_action_choice="exit"
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
END FUNCTION
 
 
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi102_show()
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point
   
   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point
   
   
 
   LET g_gztw_m_t.* = g_gztw_m.*      #保存單頭舊值
   
   DISPLAY BY NAME g_gztw_m.gztw001,g_gztw_m.gztv003
   CALL azzi102_b_fill(g_wc2)                 #單身
 
   CALL azzi102_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point   
   
END FUNCTION
 
 
#+ 帶出reference資料
PRIVATE FUNCTION azzi102_ref_show()
   {<Local define>}
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   {</Local define>}
   #add-point:ref_show段define
   {<point name="ref_show.define"/>}
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gztw_m.gztw001
   CALL ap_ref_array2(g_ref_fields," SELECT gztv003 FROM gztv_t WHERE gztv001 = ? AND gztv002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gztw_m.gztv003 = g_rtn_fields[1] 
   DISPLAY BY NAME g_gztw_m.gztv003
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gztw_d.getLength()
      #add-point:ref_show段d_reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwownid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwcrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gztw_d[l_ac].gztwcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gztw_d[l_ac].gztwcrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gztw_d[l_ac].gztwcrtdp_desc

      #end add-point
   END FOR
   
 
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
 
#+ 資料複製
PRIVATE FUNCTION azzi102_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE gztw_t.gztw001 
   DEFINE l_oldno     LIKE gztw_t.gztw001 
 
   DEFINE l_master    RECORD LIKE gztw_t.*
   DEFINE l_detail    RECORD LIKE gztw_t.*
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_gztw_m.gztw001 IS NULL
 
      THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
   
   LET g_gztw001_t = g_gztw_m.gztw001
 
    
   CALL azzi102_set_entry('a')
   CALL azzi102_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   
 
   INPUT l_newno #FROM 
 
    FROM gztw001 
 
         
         AFTER FIELD gztw001 
            #add-point:AFTER FIELD gztw001
            {<point name="reproduce.gztw001" />}
            #END add-point
         
 
         
      #add-point:複製段落開窗/欄位控管/自定義action
      {<point name="reproduce.action" />}
      #end add-point
         
      BEFORE INPUT
         #add-point:複製段落Before input
         {<point name="reproduce.before_input" />}
         #end add-point
            
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
         IF l_newno IS NULL 
 
            THEN
         CALL cl_err("Reproduce","std-00006",1) 
         NEXT FIELD gztw001 
         END IF
         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM gztw_t 
          WHERE  gztw001 = l_newno
 
         IF l_cnt > 0 THEN
            CALL cl_err("Reproduce","std-00006",1)
            #NEXT FIELD gztw001 
         END IF
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT
   END INPUT
   
   IF INT_FLAG OR l_newno IS NULL THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   LET g_sql = "SELECT * FROM gztw_t WHERE  ",
               " gztw001 = '",g_gztw_m.gztw001,"'"
 
   DECLARE azzi102_reproduce CURSOR FROM g_sql
 
   FOREACH azzi102_reproduce INTO l_detail.*
   
      #add-point:單身複製前
      {<point name="reproduce.body.b_insert"/>}
      #end add-point
   
      LET l_detail.gztw001 = l_newno
 
      
      #公用欄位給予預設值
      #此段落由子樣板a13產生
      LET l_detail.gztwownid = g_user
      LET l_detail.gztwowndp = g_dept
      LET l_detail.gztwcrtid = g_user
      LET l_detail.gztwcrtdp = g_dept 
      LET l_detail.gztwcrtdt = cl_get_current()
      #LET l_detail.gztwmodid = g_user
      #LET l_detail.gztwmoddt = cl_get_current()
      #LET l_detail.gztwstus = "Y"
 
 
 
      INSERT INTO gztw_t VALUES (l_detail.*) #複製單身
      IF SQLCA.sqlcode THEN
         CALL cl_err('Insert error!',SQLCA.sqlcode,1)
         CALL s_transaction_end('N','0')
         RETURN
      END IF
  
      #add-point:單身複製後
      {<point name="reproduce.body.a_insert"/>}
      #end add-point
   END FOREACH
 
   CALL s_transaction_end('Y','0')
   ERROR 'ROW(',l_newno,') O.K'
   CLOSE azzi102_reproduce
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " gztw001 = '", l_newno CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point
   
END FUNCTION
 
#+ 資料刪除
PRIVATE FUNCTION azzi102_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   #end add-point     
   
   IF g_gztw_m.gztw001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
 
    SELECT UNIQUE gztw001
 INTO g_gztw_m.gztw001
 FROM gztw_t
 WHERE gztw001 = g_gztw_m.gztw001
   CALL s_transaction_begin()
   
   LET g_master_multi_table_t.gztw001 = g_gztw_m.gztw001
LET g_master_multi_table_t.gztv003 = g_gztw_m.gztv003
 
 
   OPEN azzi102_cl USING g_gztw_m.gztw001
 
   IF STATUS THEN
      CALL cl_err("OPEN azzi102_cl:", STATUS, 1)
      CLOSE azzi102_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH azzi102_cl INTO g_gztw_m.gztw001,g_gztw_m.gztv003
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_gztw_m.gztw001,SQLCA.sqlcode,0)
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   CALL azzi102_show()
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      INITIALIZE g_doc.* TO NULL         
      LET g_doc.column1 = "gztw001"       
      LET g_doc.value1 = g_gztw_m.gztw001     
      CALL cl_del_doc()    
 
      #add-point:單身刪除前
      {<point name="delete.body.b_delete"/>}
      #end add-point
      
      DELETE FROM gztw_t WHERE  gztw001 = g_gztw_m.gztw001
 
      IF SQLCA.sqlcode THEN
         CALL cl_err("gztw_t",SQLCA.sqlcode,0)
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      {<point name="delete.body.a_delete"/>}
      #end add-point
      
      CLEAR FORM
      CALL g_gztw_d.clear() 
 
     
      CALL azzi102_ui_browser_refresh()  
      CALL azzi102_ui_headershow()  
      CALL azzi102_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL azzi102_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL azzi102_browser_fill("F")
      END IF
       
   END IF
 
   CLOSE azzi102_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_gztw_m.gztw001,'D')
    
END FUNCTION
 
 
#+ 單身陣列填充
PRIVATE FUNCTION azzi102_b_fill(p_wc2)
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point     
 
   #先清空單身變數內容
   CALL g_gztw_d.clear()
 
 
   #add-point:b_fill段define
   {<point name="b_fill.sql_before"/>}
   #end add-point
   
   LET g_sql = "SELECT gztwstus,gztw002,'',gztwmodid,'',gztwmoddt,gztwownid,'',gztwowndp,'',gztwcrtid,'',gztwcrtdp,'',gztwcrtdt FROM gztw_t WHERE gztw001=?"   
 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY gztw001,gztw002"
 
   PREPARE azzi102_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR azzi102_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs USING g_gztw_m.gztw001
 
                                            
   FOREACH b_fill_cs INTO g_gztw_d[l_ac].gztwstus,g_gztw_d[l_ac].gztw002,g_gztw_d[l_ac].gztx004,g_gztw_d[l_ac].gztwmodid,g_gztw_d[l_ac].gztwmodid_desc,g_gztw_d[l_ac].gztwmoddt,g_gztw_d[l_ac].gztwownid,g_gztw_d[l_ac].gztwownid_desc,g_gztw_d[l_ac].gztwowndp,g_gztw_d[l_ac].gztwowndp_desc,g_gztw_d[l_ac].gztwcrtid,g_gztw_d[l_ac].gztwcrtid_desc,g_gztw_d[l_ac].gztwcrtdp,g_gztw_d[l_ac].gztwcrtdp_desc,g_gztw_d[l_ac].gztwcrtdt
 
                          
      IF SQLCA.sqlcode THEN
         CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
                        
      #add-point:b_fill段資料填充
      {<point name="b_fill.fill"/>}
      #end add-point
 
      #帶出公用欄位reference值
      #此段落由子樣板a12產生
      #LET g_gztw_d[l_ac].gztwownid_desc = cl_get_username(g_gztw_d[l_ac].gztwownid)
      #LET g_gztw_d[l_ac].gztwowndp_desc = cl_get_deptname(g_gztw_d[l_ac].gztwowndp)
      #LET g_gztw_d[l_ac].gztwcrtid_desc = cl_get_username(g_gztw_d[l_ac].gztwcrtid)
      #LET g_gztw_d[l_ac].gztwcrtdp_desc = cl_get_deptname(g_gztw_d[l_ac].gztwcrtdp)
      #LET g_gztw_d[l_ac].gztwmodid_desc = cl_get_username(g_gztw_d[l_ac].gztwmodid)
      ##LET g_gztw_d[l_ac].gztwcnfid_desc = cl_get_deptname(g_gztw_d[l_ac].gztwcnfid)
      ##LET g_gztw_d[l_ac].gztwpstid_desc = cl_get_deptname(g_gztw_d[l_ac].gztwpstid)
      
 
 
      
 
   
 
     
      #add-point:單身資料抓取
      {<point name="bfill.foreach"/>}
      #end add-point
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_gztw_d.deleteElement(l_ac)
 
 
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE azzi102_pb   
   
END FUNCTION
 
 
#+ 單身db資料刪除
PRIVATE FUNCTION azzi102_before_delete()
   #add-point:before_delete段define
   {<point name="before_delete.define"/>}
   #end add-point 
   
   #add-point:單筆刪除前
   {<point name="delete.body.b_single_delete"/>}
   #end add-point
   
   DELETE FROM gztw_t
    WHERE  gztw001 = g_gztw_m.gztw001 AND
 
          gztw002 = g_gztw_d_t.gztw002
 
          
   IF SQLCA.sqlcode THEN
      CALL cl_err("gztw_t",SQLCA.sqlcode,1)
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後
   {<point name="delete.body.a_single_delete"/>}
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
 
#+ 刪除單身db資料後畫面頁簽連動
PRIVATE FUNCTION azzi102_delete_b(p_total)
   {<Local define>}
   DEFINE p_total LIKE type_t.num5
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point     
 
 
 
   IF p_total = g_gztw_d.getLength() THEN
      CALL g_gztw_d.deleteElement(l_ac)
   END IF 
   
END FUNCTION
 
 
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi102_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1  
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gztw001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point 
   END IF
   
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi102_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("gztw001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point 
   END IF
   
END FUNCTION
 
 
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi102_set_entry_b()
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point     
   #add-point:set_entry_b段
   {<point name="set_entry_b.set_entry_b"/>}
   #end add-point  
END FUNCTION
 
 
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi102_set_no_entry_b()
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point    
   #add-point:set_no_entry_b段
   {<point name="set_no_entry_b.set_no_entry_b段"/>}
   #end add-point     
END FUNCTION
 
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION azzi102_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point  
   
   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " gztw001 = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point  
 
END FUNCTION
 
    
 
{<point name="other.function"/>}
 
 
