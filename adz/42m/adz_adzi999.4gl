#+ Version..: T100-ERP-1.00.00(版次:1) Build-000067
#+ 
#+ Filename...: adzi999
#+ Description: min test
#+ Creator....: 00378(2013/10/21)
#+ Modifier...: 00378(2013/10/21)
#+ Buildtype..: 應用 i07 樣板自動產生
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
PRIVATE type type_g_dzdl_m        RECORD
       dzdl001 LIKE dzdl_t.dzdl001, 
   dzdl002 LIKE dzdl_t.dzdl002, 
   dzdl003 LIKE dzdl_t.dzdl003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dzdl_d        RECORD
       dzdl004 LIKE dzdl_t.dzdl004, 
   dzdl005 LIKE dzdl_t.dzdl005, 
   dzdl006 LIKE dzdl_t.dzdl006, 
   dzdl006_name LIKE type_t.chr80,   
   dzdl007 LIKE dzdl_t.dzdl007, 
   dzdl008 LIKE dzdl_t.dzdl008, 
   dzdl008_name LIKE type_t.chr80,   
   dzdl009 LIKE dzdl_t.dzdl009, 
   dzdl010 LIKE dzdl_t.dzdl010, 
   dzdl010_name LIKE type_t.chr80,   
   dzdl011 LIKE dzdl_t.dzdl011, 
   dzdl012 LIKE dzdl_t.dzdl012, 
   dzdl012_name LIKE type_t.chr80,   
   dzdl013 LIKE dzdl_t.dzdl013, 
   dzdl014 LIKE dzdl_t.dzdl014, 
   dzdlstus LIKE dzdl_t.dzdlstus, 
   dzdlownid LIKE dzdl_t.dzdlownid, 
   dzdlownid_desc LIKE type_t.chr80, 
   dzdlowndp LIKE dzdl_t.dzdlowndp, 
   dzdlowndp_desc LIKE type_t.chr80, 
   dzdlcrtid LIKE dzdl_t.dzdlcrtid, 
   dzdlcrtid_desc LIKE type_t.chr80, 
   dzdlcrtdp LIKE dzdl_t.dzdlcrtdp, 
   dzdlcrtdp_desc LIKE type_t.chr80, 
   dzdlcrtdt DATETIME YEAR TO SECOND, 
   dzdlmodid LIKE dzdl_t.dzdlmodid, 
   dzdlmodid_desc LIKE type_t.chr80, 
   dzdlmoddt DATETIME YEAR TO SECOND, 
   dzdlcnfid LIKE dzdl_t.dzdlcnfid, 
   dzdlcnfid_desc LIKE type_t.chr80, 
   dzdlcnfdt LIKE dzdl_t.dzdlcnfdt
       END RECORD
 
 
#無單頭append欄位定義
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_dzdl_m          type_g_dzdl_m
DEFINE g_dzdl_m_t        type_g_dzdl_m
 
DEFINE g_dzdl001_t     LIKE dzdl_t.dzdl001
 
 
DEFINE g_dzdl_d          DYNAMIC ARRAY OF type_g_dzdl_d
DEFINE g_dzdl_d_t        type_g_dzdl_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
       b_dzdl001 LIKE dzdl_t.dzdl001,
       b_dzdl001_name LIKE gzzal_t.gzzal003,
       b_dzdl002 LIKE dzdl_t.dzdl002,
       b_dzdl003 LIKE dzdl_t.dzdl003
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
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
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
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_dzdl001_name        LIKE gzzal_t.gzzal003
 
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
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")
 
   #add-point:作業初始化
   {<point name="main.init" />}
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   {<point name="main.define_sql" />}
   #end add-point
   LET g_forupd_sql = "SELECT dzdl001,dzdl002,dzdl003 FROM dzdl_t WHERE dzdl001=? FOR UPDATE"
   #add-point:SQL_define
   {<point name="main.after_define_sql"/>}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE adzi999_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi999 WITH FORM cl_ap_formpath("adz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adzi999_init()   
 
      #進入選單 Menu (="N")
      CALL adzi999_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_adzi999
      
   END IF 
   
   CLOSE adzi999_cl
   
   
 
   #add-point:作業離開前
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
    
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi999_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point    
  
   LET g_bfill = "Y"
   
   
   LET g_error_show = 1
   #add-point:畫面資料初始化
   {<point name="init.init"/>}
   #end add-point
   
   CALL adzi999_default_search()

   CALL cl_set_combo_scc('dzdl002','114')
   CALL cl_set_combo_scc('dzdl007','120')
   CALL cl_set_combo_scc('dzdl009','121')
   CALL cl_set_combo_scc('dzdl011','122')
   CALL cl_set_combo_scc('dzdl013','133')
    
END FUNCTION
 
 
#+ 功能選單
PRIVATE FUNCTION adzi999_ui_dialog()
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
   
      CALL adzi999_browser_fill("")
 
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_dzdl001 = g_dzdl001_t
 
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
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL adzi999_fetch('') # reload data
               LET g_detail_idx = 1
               CALL adzi999_ui_detailshow() #Setting the current row 
         
         END DISPLAY
        
         DISPLAY ARRAY g_dzdl_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL adzi999_ui_detailshow()
               
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
               
         END DISPLAY
        
 
         
         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point
         
        #SUBDIALOG lib_cl_dlg.dlg_qryplan
        #SUBDIALOG lib_cl_dlg.dlg_relateapps 
         
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
               CALL adzi999_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adzi999_ui_detailshow() #Setting the current row 
            
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
            CALL adzi999_filter()
            EXIT DIALOG
         
         ON ACTION first
            CALL adzi999_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL adzi999_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL adzi999_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL adzi999_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL adzi999_fetch('L')
            LET g_current_row = g_current_idx
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
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
            
         
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL adzi999_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL adzi999_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL adzi999_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL adzi999_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL adzi999_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
 
         
         
         
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
 
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adzi999_browser_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #end add-point    
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00005"
      LET g_errparam.extend = "searchcol"
      LET g_errparam.popup = FALSE
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
      LET g_wc = g_wc, " ORDER BY dzdl001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL adzi999_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE
 
END FUNCTION
 
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi999_browser_fill(ps_page_action)
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
   
   #add-point:browser_fill段動作開始前
   {<point name="browser_fill.before_browser_fill"/>}
   #end add-point    
   
   CALL g_browser.clear()
 
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "dzdl001"
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
      LET l_sub_sql = " SELECT UNIQUE dzdl001 ",
 
                      " FROM dzdl_t ",
                      " ",
                      " ",
                      " WHERE  ",l_wc, " AND ", l_wc2 
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE dzdl001 ",
 
                      " FROM dzdl_t ",
                      " ",
                      " ",
                      " WHERE  ",l_wc CLIPPED
 
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '9035'
      LET g_errparam.extend = g_browser_cnt
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   LET g_error_show = 0
 
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
 
      #依照dzdl001 Browser欄位定義(取代原本bs_sql功能)
      LET l_sub_sql  = "SELECT DISTINCT dzdl001 ",
                       " FROM dzdl_t ",
                       " ",
                       " WHERE  ", g_wc," AND ",g_wc2
 
   ELSE
      #單身無輸入資料
      LET l_sub_sql  = "SELECT DISTINCT dzdl001 ",
                       " FROM dzdl_t ",
                       " WHERE  ", g_wc
                 
   END IF
   
   LET l_sql_rank = "SELECT dzdl001,DENSE_RANK() OVER(ORDER BY dzdl001 ",g_order,") AS RANK ",
                    " FROM (",l_sub_sql,") "
                       
   #定義翻頁CURSOR
   LET g_sql= " SELECT dzdl001 FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
              " AND RANK<",g_pagestart+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
                
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_dzdl001    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      {<point name="browser_fill.reference"/>}
      SELECT UNIQUE dzdl002,dzdl003 INTO g_browser[g_cnt].b_dzdl002,g_browser[g_cnt].b_dzdl003 FROM dzdl_t
       WHERE dzdl001 = g_browser[g_cnt].b_dzdl001

      CALL adzi999_get_dzdl001_name(g_browser[g_cnt].b_dzdl001,g_browser[g_cnt].b_dzdl002) RETURNING g_browser[g_cnt].b_dzdl001_name
      #end add-point    
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND g_wc THEN
      INITIALIZE g_dzdl_m.* TO NULL
      CALL g_dzdl_d.clear()
 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   CALL adzi999_fetch('')
   
   FREE browse_pre
   
END FUNCTION
 
 
#+ 單頭資料重新顯示
PRIVATE FUNCTION adzi999_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point    
   
   LET g_dzdl_m.dzdl001 = g_browser[g_current_idx].b_dzdl001   
 
    SELECT UNIQUE dzdl001,dzdl002,dzdl003
 INTO g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
 FROM dzdl_t
 WHERE dzdl001 = g_dzdl_m.dzdl001
   CALL adzi999_show()
   
END FUNCTION
 
 
#+ 單身資料重新顯示
PRIVATE FUNCTION adzi999_ui_detailshow()
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
PRIVATE FUNCTION adzi999_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzdl001 = g_dzdl_m.dzdl001 
 
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
PRIVATE FUNCTION adzi999_construct()
 
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
   INITIALIZE g_dzdl_m.* TO NULL
   CALL g_dzdl_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dzdl001,dzdl002,dzdl003
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.head.before_construct"/>}
            #end add-point 
            
        #---------------------------<  Master  >---------------------------
         #----<<dzdl001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl001
            #add-point:BEFORE FIELD dzdl001
            {<point name="construct.b.dzdl001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl001
            
            #add-point:AFTER FIELD dzdl001
            {<point name="construct.a.dzdl001" />}
            #END add-point
            
 
         #Ctrlp:construct.c.dzdl001
#         ON ACTION controlp INFIELD dzdl001
            #add-point:ON ACTION controlp INFIELD dzdl001
            {<point name="construct.c.dzdl001" />}
            #END add-point
 
         #----<<dzdl002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl002
            #add-point:BEFORE FIELD dzdl002
            {<point name="construct.b.dzdl002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl002
            
            #add-point:AFTER FIELD dzdl002
            {<point name="construct.a.dzdl002" />}
            #END add-point
            
 
         #Ctrlp:construct.c.dzdl002
#         ON ACTION controlp INFIELD dzdl002
            #add-point:ON ACTION controlp INFIELD dzdl002
            {<point name="construct.c.dzdl002" />}
            #END add-point
 
         #----<<dzdl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl003
            #add-point:BEFORE FIELD dzdl003
            {<point name="construct.b.dzdl003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl003
            
            #add-point:AFTER FIELD dzdl003
            {<point name="construct.a.dzdl003" />}
            #END add-point
            
 
         #Ctrlp:construct.c.dzdl003
#         ON ACTION controlp INFIELD dzdl003
            #add-point:ON ACTION controlp INFIELD dzdl003
            {<point name="construct.c.dzdl003" />}
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身可以混搭多頁簽
      CONSTRUCT g_wc2 ON dzdl004,dzdl005,dzdl006,dzdl007,dzdl008,dzdl009,dzdl010,dzdl011,dzdl012,dzdl013,dzdl014,dzdlstus,dzdlownid,dzdlowndp,dzdlcrtid,dzdlcrtdp,dzdlcrtdt,dzdlmodid,dzdlmoddt,dzdlcnfid,dzdlcnfdt
 
         FROM s_detail1[1].dzdl004,s_detail1[1].dzdl005,s_detail1[1].dzdl006,s_detail1[1].dzdl007,s_detail1[1].dzdl008,s_detail1[1].dzdl009,s_detail1[1].dzdl010,s_detail1[1].dzdl011,s_detail1[1].dzdl012,s_detail1[1].dzdl013,s_detail1[1].dzdl014,s_detail1[1].dzdlstus,s_detail1[1].dzdlownid,s_detail1[1].dzdlowndp,s_detail1[1].dzdlcrtid,s_detail1[1].dzdlcrtdp,s_detail1[1].dzdlcrtdt,s_detail1[1].dzdlmodid,s_detail1[1].dzdlmoddt,s_detail1[1].dzdlcnfid,s_detail1[1].dzdlcnfdt
 
                      
         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point 
            
            #公用欄位開窗相關處理
            #此段落由子樣板a11產生
         ##----<<dzdlownid>>----
         #ON ACTION controlp INFIELD dzdlownid
         #   CALL q_common('dzdl_t','dzdlownid',TRUE,FALSE,g_dzdl_d[1].dzdlownid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdlownid
         #   NEXT FIELD dzdlownid  
         #
         ##----<<dzdlowndp>>----
         #ON ACTION controlp INFIELD dzdlowndp
         #   CALL q_common('dzdl_t','dzdlowndp',TRUE,FALSE,g_dzdl_d[1].dzdlowndp) RETURNING ls_return
         #   DISPLAY ls_return TO dzdlowndp
         #   NEXT FIELD dzdlowndp
         #
         ##----<<dzdlcrtid>>----
         #ON ACTION controlp INFIELD dzdlcrtid
         #   CALL q_common('dzdl_t','dzdlcrtid',TRUE,FALSE,g_dzdl_d[1].dzdlcrtid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdlcrtid
         #   NEXT FIELD dzdlcrtid
         #
         ##----<<dzdlcrtdp>>----
         #ON ACTION controlp INFIELD dzdlcrtdp
         #   CALL q_common('dzdl_t','dzdlcrtdp',TRUE,FALSE,g_dzdl_d[1].dzdlcrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO dzdlcrtdp
         #   NEXT FIELD dzdlcrtdp
         #
         ##----<<dzdlmodid>>----
         #ON ACTION controlp INFIELD dzdlmodid
         #   CALL q_common('dzdl_t','dzdlmodid',TRUE,FALSE,g_dzdl_d[1].dzdlmodid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdlmodid
         #   NEXT FIELD dzdlmodid
         #
         ##----<<dzdlcnfid>>----
         #ON ACTION controlp INFIELD dzdlcnfid
         #   CALL q_common('dzdl_t','dzdlcnfid',TRUE,FALSE,g_dzdl_d[1].dzdlcnfid) RETURNING ls_return
         #   DISPLAY ls_return TO dzdlcnfid
         #   NEXT FIELD dzdlcnfid
         #
         ##----<<dzdlpstid>>----
         ##ON ACTION controlp INFIELD dzdlpstid
         ##   CALL q_common('dzdl_t','dzdlpstid',TRUE,FALSE,g_dzdl_d[1].dzdlpstid) RETURNING ls_return
         ##   DISPLAY ls_return TO dzdlpstid
         ##   NEXT FIELD dzdlpstid
         
         ##----<<dzdlcrtdt>>----
         AFTER FIELD dzdlcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdlmoddt>>----
         AFTER FIELD dzdlmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdlcnfdt>>----
         AFTER FIELD dzdlcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dzdlpstdt>>----
         #AFTER FIELD dzdlpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
          
            #---------------------<  Detail: page1  >---------------------
         #----<<dzdl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl004
            #add-point:BEFORE FIELD dzdl004
            {<point name="construct.b.page1.dzdl004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl004
            
            #add-point:AFTER FIELD dzdl004
            {<point name="construct.a.page1.dzdl004" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl004
#         ON ACTION controlp INFIELD dzdl004
            #add-point:ON ACTION controlp INFIELD dzdl004
            {<point name="construct.c.page1.dzdl004" />}
            #END add-point
 
         #----<<dzdl005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl005
            #add-point:BEFORE FIELD dzdl005
            {<point name="construct.b.page1.dzdl005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl005
            
            #add-point:AFTER FIELD dzdl005
            {<point name="construct.a.page1.dzdl005" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl005
#         ON ACTION controlp INFIELD dzdl005
            #add-point:ON ACTION controlp INFIELD dzdl005
            {<point name="construct.c.page1.dzdl005" />}
            #END add-point
 
         #----<<dzdl006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl006
            #add-point:BEFORE FIELD dzdl006
            {<point name="construct.b.page1.dzdl006" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl006
            
            #add-point:AFTER FIELD dzdl006
            {<point name="construct.a.page1.dzdl006" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl006
          ON ACTION controlp INFIELD dzdl006
            #add-point:ON ACTION controlp INFIELD dzdl006
            {<point name="construct.c.page1.dzdl006" />}
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdl006    #顯示到畫面上
            NEXT FIELD dzdl006                       #返回原欄位

          {#ADP版次:1#}

            #END add-point
 
         #----<<dzdl007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl007
            #add-point:BEFORE FIELD dzdl007
            {<point name="construct.b.page1.dzdl007" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl007
            
            #add-point:AFTER FIELD dzdl007
            {<point name="construct.a.page1.dzdl007" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl007
#         ON ACTION controlp INFIELD dzdl007
            #add-point:ON ACTION controlp INFIELD dzdl007
            {<point name="construct.c.page1.dzdl007" />}
            #END add-point
 
         #----<<dzdl008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl008
            #add-point:BEFORE FIELD dzdl008
            {<point name="construct.b.page1.dzdl008" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl008
            
            #add-point:AFTER FIELD dzdl008
            {<point name="construct.a.page1.dzdl008" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl008
#         ON ACTION controlp INFIELD dzdl008
            #add-point:ON ACTION controlp INFIELD dzdl008
            {<point name="construct.c.page1.dzdl008" />}
            #END add-point
 
         #----<<dzdl009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl009
            #add-point:BEFORE FIELD dzdl009
            {<point name="construct.b.page1.dzdl009" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl009
            
            #add-point:AFTER FIELD dzdl009
            {<point name="construct.a.page1.dzdl009" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl009
#         ON ACTION controlp INFIELD dzdl009
            #add-point:ON ACTION controlp INFIELD dzdl009
            {<point name="construct.c.page1.dzdl009" />}
            #END add-point
 
         #----<<dzdl010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl010
            #add-point:BEFORE FIELD dzdl010
            {<point name="construct.b.page1.dzdl010" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl010
            
            #add-point:AFTER FIELD dzdl010
            {<point name="construct.a.page1.dzdl010" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl010
#         ON ACTION controlp INFIELD dzdl010
            #add-point:ON ACTION controlp INFIELD dzdl010
            {<point name="construct.c.page1.dzdl010" />}
            #END add-point
 
         #----<<dzdl011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl011
            #add-point:BEFORE FIELD dzdl011
            {<point name="construct.b.page1.dzdl011" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl011
            
            #add-point:AFTER FIELD dzdl011
            {<point name="construct.a.page1.dzdl011" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl011
#         ON ACTION controlp INFIELD dzdl011
            #add-point:ON ACTION controlp INFIELD dzdl011
            {<point name="construct.c.page1.dzdl011" />}
            #END add-point
 
         #----<<dzdl012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl012
            #add-point:BEFORE FIELD dzdl012
            {<point name="construct.b.page1.dzdl012" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl012
            
            #add-point:AFTER FIELD dzdl012
            {<point name="construct.a.page1.dzdl012" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl012
#         ON ACTION controlp INFIELD dzdl012
            #add-point:ON ACTION controlp INFIELD dzdl012
            {<point name="construct.c.page1.dzdl012" />}
            #END add-point
 
         #----<<dzdl013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl013
            #add-point:BEFORE FIELD dzdl013
            {<point name="construct.b.page1.dzdl013" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl013
            
            #add-point:AFTER FIELD dzdl013
            {<point name="construct.a.page1.dzdl013" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl013
#         ON ACTION controlp INFIELD dzdl013
            #add-point:ON ACTION controlp INFIELD dzdl013
            {<point name="construct.c.page1.dzdl013" />}
            #END add-point
 
         #----<<dzdl014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl014
            #add-point:BEFORE FIELD dzdl014
            {<point name="construct.b.page1.dzdl014" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl014
            
            #add-point:AFTER FIELD dzdl014
            {<point name="construct.a.page1.dzdl014" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdl014
#         ON ACTION controlp INFIELD dzdl014
            #add-point:ON ACTION controlp INFIELD dzdl014
            {<point name="construct.c.page1.dzdl014" />}
            #END add-point
 
         #----<<dzdlstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlstus
            #add-point:BEFORE FIELD dzdlstus
            {<point name="construct.b.page1.dzdlstus" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlstus
            
            #add-point:AFTER FIELD dzdlstus
            {<point name="construct.a.page1.dzdlstus" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdlstus
#         ON ACTION controlp INFIELD dzdlstus
            #add-point:ON ACTION controlp INFIELD dzdlstus
            {<point name="construct.c.page1.dzdlstus" />}
            #END add-point
 
         #----<<dzdlownid>>----
         #Ctrlp:construct.c.page1.dzdlownid
         ON ACTION controlp INFIELD dzdlownid
            #add-point:ON ACTION controlp INFIELD dzdlownid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdlownid  #顯示到畫面上

            NEXT FIELD dzdlownid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlownid
            #add-point:BEFORE FIELD dzdlownid
            {<point name="construct.b.page1.dzdlownid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlownid
            
            #add-point:AFTER FIELD dzdlownid
            {<point name="construct.a.page1.dzdlownid" />}
            #END add-point
            
 
         #----<<dzdlowndp>>----
         #Ctrlp:construct.c.page1.dzdlowndp
         ON ACTION controlp INFIELD dzdlowndp
            #add-point:ON ACTION controlp INFIELD dzdlowndp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdlowndp  #顯示到畫面上

            NEXT FIELD dzdlowndp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlowndp
            #add-point:BEFORE FIELD dzdlowndp
            {<point name="construct.b.page1.dzdlowndp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlowndp
            
            #add-point:AFTER FIELD dzdlowndp
            {<point name="construct.a.page1.dzdlowndp" />}
            #END add-point
            
 
         #----<<dzdlcrtid>>----
         #Ctrlp:construct.c.page1.dzdlcrtid
         ON ACTION controlp INFIELD dzdlcrtid
            #add-point:ON ACTION controlp INFIELD dzdlcrtid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdlcrtid  #顯示到畫面上

            NEXT FIELD dzdlcrtid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlcrtid
            #add-point:BEFORE FIELD dzdlcrtid
            {<point name="construct.b.page1.dzdlcrtid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlcrtid
            
            #add-point:AFTER FIELD dzdlcrtid
            {<point name="construct.a.page1.dzdlcrtid" />}
            #END add-point
            
 
         #----<<dzdlcrtdp>>----
         #Ctrlp:construct.c.page1.dzdlcrtdp
         ON ACTION controlp INFIELD dzdlcrtdp
            #add-point:ON ACTION controlp INFIELD dzdlcrtdp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdlcrtdp  #顯示到畫面上

            NEXT FIELD dzdlcrtdp                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlcrtdp
            #add-point:BEFORE FIELD dzdlcrtdp
            {<point name="construct.b.page1.dzdlcrtdp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlcrtdp
            
            #add-point:AFTER FIELD dzdlcrtdp
            {<point name="construct.a.page1.dzdlcrtdp" />}
            #END add-point
            
 
         #----<<dzdlcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlcrtdt
            #add-point:BEFORE FIELD dzdlcrtdt
            {<point name="construct.b.page1.dzdlcrtdt" />}
            #END add-point
 
         #----<<dzdlmodid>>----
         #Ctrlp:construct.c.page1.dzdlmodid
         ON ACTION controlp INFIELD dzdlmodid
            #add-point:ON ACTION controlp INFIELD dzdlmodid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdlmodid  #顯示到畫面上

            NEXT FIELD dzdlmodid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlmodid
            #add-point:BEFORE FIELD dzdlmodid
            {<point name="construct.b.page1.dzdlmodid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlmodid
            
            #add-point:AFTER FIELD dzdlmodid
            {<point name="construct.a.page1.dzdlmodid" />}
            #END add-point
            
 
         #----<<dzdlmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlmoddt
            #add-point:BEFORE FIELD dzdlmoddt
            {<point name="construct.b.page1.dzdlmoddt" />}
            #END add-point
 
         #----<<dzdlcnfid>>----
         #Ctrlp:construct.c.page1.dzdlcnfid
         ON ACTION controlp INFIELD dzdlcnfid
            #add-point:ON ACTION controlp INFIELD dzdlcnfid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdlcnfid  #顯示到畫面上

            NEXT FIELD dzdlcnfid                     #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlcnfid
            #add-point:BEFORE FIELD dzdlcnfid
            {<point name="construct.b.page1.dzdlcnfid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlcnfid
            
            #add-point:AFTER FIELD dzdlcnfid
            {<point name="construct.a.page1.dzdlcnfid" />}
            #END add-point
            
 
         #----<<dzdlcnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlcnfdt
            #add-point:BEFORE FIELD dzdlcnfdt
            {<point name="construct.b.page1.dzdlcnfdt" />}
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
        #CALL cl_qbe_list() RETURNING lc_qbe_sn
        #CALL cl_qbe_display_condition(lc_qbe_sn)
 
      ON ACTION qbe_save       #條件儲存
        #CALL cl_qbe_save()
 
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
   {<point name="cs.after_construct"/>}
   #end add-point
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
 
#+ filter過濾功能
PRIVATE FUNCTION adzi999_filter()
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
      CONSTRUCT g_wc_filter ON dzdl001
                          FROM s_browse[1].b_dzdl001
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
               DISPLAY adzi999_filter_parser('dzdl001') TO s_browse[1].b_dzdl001
 
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
PRIVATE FUNCTION adzi999_filter_parser(ps_field)
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
PRIVATE FUNCTION adzi999_query()
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
   CALL g_dzdl_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL adzi999_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adzi999_browser_fill(g_wc)
      CALL adzi999_fetch("")
      RETURN
   END IF
   
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
 
   LET g_error_show = 1
   CALL adzi999_browser_fill("F")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL adzi999_browser_fill("F")
   END IF
   
   #第二層助記碼搜尋
   IF g_browser_cnt = 0 THEN
 
      
      
      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL adzi999_browser_fill("F")
      END IF
      
   END IF
   
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLEAR FORM
   ELSE
      CALL adzi999_fetch("F") 
   END IF
   
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi999_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point    
   
   #add-point:fetch段動作開始前
   {<point name="fetch.before_fetch"/>}
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
   
   #該樣板不需此段落CALL adzi999_browser_fill(p_flag)
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
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
   
   LET g_dzdl_m.dzdl001 = g_browser[g_current_idx].b_dzdl001
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE dzdl001,dzdl002,dzdl003
 INTO g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
 FROM dzdl_t
 WHERE dzdl001 = g_dzdl_m.dzdl001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdl_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      INITIALIZE g_dzdl_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL adzi999_show()
 
END FUNCTION
 
 
#+ 資料新增
PRIVATE FUNCTION adzi999_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_dzdl_d.clear()
 
 
   INITIALIZE g_dzdl_m.* LIKE dzdl_t.*             #DEFAULT 設定
   LET g_dzdl001_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_dzdl_m.dzdl002 = "B"
      LET g_dzdl_m.dzdl003 = "SUB"
 
     
      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point 
 
      CALL adzi999_input("a")
      
      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzdl_m.* = g_dzdl_m_t.*
         CALL adzi999_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT WHILE
      END IF
      
      CALL g_dzdl_d.clear()
 
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   LET g_state = "Y"
   
   LET g_dzdl001_t = g_dzdl_m.dzdl001
 
   
   LET g_wc = g_wc,  
              " OR (  ",
              " dzdl001 = '", g_dzdl_m.dzdl001 CLIPPED, "' "
 
              , ") "
   
END FUNCTION
 
 
#+ 資料修改
PRIVATE FUNCTION adzi999_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point    
   
   IF g_dzdl_m.dzdl001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
    SELECT UNIQUE dzdl001,dzdl002,dzdl003
 INTO g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
 FROM dzdl_t
 WHERE dzdl001 = g_dzdl_m.dzdl001
 
   ERROR ""
  
   LET g_dzdl001_t = g_dzdl_m.dzdl001
 
   CALL s_transaction_begin()
   
   OPEN adzi999_cl USING g_dzdl_m.dzdl001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi999_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi999_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH adzi999_cl INTO g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzdl_m.dzdl001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE adzi999_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL adzi999_show()
   WHILE TRUE
      LET g_dzdl001_t = g_dzdl_m.dzdl001
 
 
      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point
      
      CALL adzi999_input("u")     #欄位更改
      
      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzdl_m.* = g_dzdl_m_t.*
         CALL adzi999_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_dzdl_m.dzdl001 != g_dzdl001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         {<point name="modify.b_key_update" mark="Y"/>}
         #end add-point
         
         #更新單頭key值
         UPDATE dzdl_t SET dzdl001 = g_dzdl_m.dzdl001
 
          WHERE  dzdl001 = g_dzdl001_t
 
         #add-point:單頭(偽)修改中
         {<point name="modify.m_key_update"/>}
         #end add-point
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "dzdl_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
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
   IF NOT cl_used_modified_record(g_dzdl_m.dzdl001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adzi999_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_dzdl_m.dzdl001,'U')
 
   CALL adzi999_b_fill("1=1")
   
END FUNCTION   
 
 
#+ 資料輸入
PRIVATE FUNCTION adzi999_input(p_cmd)
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
 
   #add-point:input段define_sql
   {<point name="input.define_sql" mark="Y"/>}
   #end add-point 
   LET g_forupd_sql = "SELECT dzdl004,dzdl005,dzdl006,dzdl007,dzdl008,dzdl009,dzdl010,dzdl011,dzdl012,dzdl013,dzdl014,dzdlstus,dzdlownid,'',dzdlowndp,'',dzdlcrtid,'',dzdlcrtdp,'',dzdlcrtdt,dzdlmodid,'',dzdlmoddt,dzdlcnfid,'',dzdlcnfdt FROM dzdl_t WHERE dzdl001=? AND dzdl004=? FOR UPDATE"
   #add-point:input段define_sql
   {<point name="input.after_define_sql"/>}
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adzi999_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adzi999_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL adzi999_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   {<point name="input.after_set_no_entry"/>}
   #end add-point
 
   DISPLAY BY NAME g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
   
   #add-point:進入修改段前
   {<point name="input.before_input"/>}
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
          
         #---------------------------<  Master  >---------------------------
         #----<<dzdl001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl001
            #add-point:BEFORE FIELD dzdl001
            {<point name="input.b.dzdl001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl001
            
            #add-point:AFTER FIELD dzdl001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdl_m.dzdl001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_dzdl_m.dzdl001 != g_dzdl001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdl_t WHERE "||"dzdl001 = '"||g_dzdl_m.dzdl001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL adzi999_get_dzdl001_name(g_dzdl_m.dzdl001,g_dzdl_m.dzdl002) RETURNING g_dzdl001_name
               DISPLAY g_dzdl001_name TO dzdl001_name
            END IF


          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl001
            #add-point:ON CHANGE dzdl001
            {<point name="input.g.dzdl001" />}
            #END add-point
 
         #----<<dzdl002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl002
            #add-point:BEFORE FIELD dzdl002
            {<point name="input.b.dzdl002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl002
            #add-point:AFTER FIELD dzdl002
            {<point name="input.a.dzdl002" />}
            CALL adzi999_get_dzdl001_name(g_dzdl_m.dzdl001,g_dzdl_m.dzdl002) RETURNING g_dzdl001_name
            DISPLAY g_dzdl001_name TO dzdl001_name
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl002
            #add-point:ON CHANGE dzdl002
            {<point name="input.g.dzdl002" />}
            #END add-point
 
         #----<<dzdl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl003
            #add-point:BEFORE FIELD dzdl003
            {<point name="input.b.dzdl003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl003
            
            #add-point:AFTER FIELD dzdl003
            {<point name="input.a.dzdl003" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl003
            #add-point:ON CHANGE dzdl003
            {<point name="input.g.dzdl003" />}
            #END add-point
 
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<dzdl001>>----
         #Ctrlp:input.c.dzdl001
#         ON ACTION controlp INFIELD dzdl001
            #add-point:ON ACTION controlp INFIELD dzdl001
            {<point name="input.c.dzdl001" />}
            #END add-point
 
         #----<<dzdl002>>----
         #Ctrlp:input.c.dzdl002
#         ON ACTION controlp INFIELD dzdl002
            #add-point:ON ACTION controlp INFIELD dzdl002
            {<point name="input.c.dzdl002" />}
            #END add-point
 
         #----<<dzdl003>>----
         #Ctrlp:input.c.dzdl003
#         ON ACTION controlp INFIELD dzdl003
            #add-point:ON ACTION controlp INFIELD dzdl003
            {<point name="input.c.dzdl003" />}
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
            DISPLAY BY NAME g_dzdl_m.dzdl001             
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point
            
               UPDATE dzdl_t SET (dzdl001,dzdl002,dzdl003) = (g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003)
                WHERE  dzdl001 = g_dzdl001_t
 
               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_dzdl_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               ELSE
                  #資料多語言用-增/改
                  
                  LET g_dzdl001_t = g_dzdl_m.dzdl001
 
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
           IF cl_null(g_dzdl_d[1].dzdl004) THEN
              NEXT FIELD dzdl004
           END IF
 
      END INPUT
    
      #Page1 預設值產生於此處
      INPUT ARRAY g_dzdl_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dzdl_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adzi999_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
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
               OPEN adzi999_cl USING 
                                               g_dzdl_m.dzdl001
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN adzi999_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CLOSE adzi999_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_dzdl_d[l_ac].dzdl004) 
 
            THEN
               LET l_cmd='u'
               LET g_dzdl_d_t.* = g_dzdl_d[l_ac].*  #BACKUP
               CALL adzi999_set_entry_b(l_cmd)
               CALL adzi999_set_no_entry_b(l_cmd)
               OPEN adzi999_bcl USING g_dzdl_m.dzdl001,
 
                                                g_dzdl_d_t.dzdl004
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN adzi999_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adzi999_bcl INTO g_dzdl_d[l_ac].dzdl004,g_dzdl_d[l_ac].dzdl005,g_dzdl_d[l_ac].dzdl006,g_dzdl_d[l_ac].dzdl007,g_dzdl_d[l_ac].dzdl008,g_dzdl_d[l_ac].dzdl009,g_dzdl_d[l_ac].dzdl010,g_dzdl_d[l_ac].dzdl011,g_dzdl_d[l_ac].dzdl012,g_dzdl_d[l_ac].dzdl013,g_dzdl_d[l_ac].dzdl014,g_dzdl_d[l_ac].dzdlstus,g_dzdl_d[l_ac].dzdlownid,g_dzdl_d[l_ac].dzdlownid_desc,g_dzdl_d[l_ac].dzdlowndp,g_dzdl_d[l_ac].dzdlowndp_desc,g_dzdl_d[l_ac].dzdlcrtid,g_dzdl_d[l_ac].dzdlcrtid_desc,g_dzdl_d[l_ac].dzdlcrtdp,g_dzdl_d[l_ac].dzdlcrtdp_desc,g_dzdl_d[l_ac].dzdlcrtdt,g_dzdl_d[l_ac].dzdlmodid,g_dzdl_d[l_ac].dzdlmodid_desc,g_dzdl_d[l_ac].dzdlmoddt,g_dzdl_d[l_ac].dzdlcnfid,g_dzdl_d[l_ac].dzdlcnfid_desc,g_dzdl_d[l_ac].dzdlcnfdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_dzdl_d_t.dzdl004
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL adzi999_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body.before_row"/>}
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_dzdl_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dzdl_d[l_ac].* TO NULL
            
            #公用欄位預設值
            #此段落由子樣板a14產生    
      LET g_dzdl_d[l_ac].dzdlownid = g_user
      LET g_dzdl_d[l_ac].dzdlowndp = g_dept
      LET g_dzdl_d[l_ac].dzdlcrtid = g_user
      LET g_dzdl_d[l_ac].dzdlcrtdp = g_dept 
      LET g_dzdl_d[l_ac].dzdlcrtdt = cl_get_current()
      #LET g_dzdl_d[l_ac].dzdlmodid = g_user
      #LET g_dzdl_d[l_ac].dzdlmoddt = cl_get_current()
      LET g_dzdl_d[l_ac].dzdlstus = "Y"
 
  
            
            #一般欄位預設值
            LET g_dzdl_d[l_ac].dzdl006 = '-'
            LET g_dzdl_d[l_ac].dzdl007 = '10'  
            LET g_dzdl_d[l_ac].dzdl008 = '-'
            LET g_dzdl_d[l_ac].dzdl009 = '20'  
            LET g_dzdl_d[l_ac].dzdl013 = '40'  
            
            
            LET g_dzdl_d_t.* = g_dzdl_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adzi999_set_entry_b(l_cmd)
            CALL adzi999_set_no_entry_b(l_cmd)
            
            #add-point:modify段before insert
            {<point name="input.body.before_insert"/>}
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM dzdl_t 
             WHERE  dzdl001 = g_dzdl_m.dzdl001
 
               AND dzdl004 = g_dzdl_d[l_ac].dzdl004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               
               CALL s_transaction_begin()
            
               #add-point:單身新增前
               {<point name="input.body.b_insert" mark="Y"/>}
               #end add-point
               
               INSERT INTO dzdl_t
                           (
                            dzdl001,dzdl002,dzdl003,
                            dzdl004
                            ,dzdl005,dzdl006,dzdl007,dzdl008,dzdl009,dzdl010,dzdl011,dzdl012,dzdl013,dzdl014,dzdlstus,dzdlownid,dzdlowndp,dzdlcrtid,dzdlcrtdp,dzdlcrtdt,dzdlmodid,dzdlmoddt,dzdlcnfid,dzdlcnfdt) 
                     VALUES(
                            g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003,
                            g_dzdl_d[l_ac].dzdl004
                            ,g_dzdl_d[l_ac].dzdl005,g_dzdl_d[l_ac].dzdl006,g_dzdl_d[l_ac].dzdl007,g_dzdl_d[l_ac].dzdl008,g_dzdl_d[l_ac].dzdl009,g_dzdl_d[l_ac].dzdl010,g_dzdl_d[l_ac].dzdl011,g_dzdl_d[l_ac].dzdl012,g_dzdl_d[l_ac].dzdl013,g_dzdl_d[l_ac].dzdl014,g_dzdl_d[l_ac].dzdlstus,g_dzdl_d[l_ac].dzdlownid,g_dzdl_d[l_ac].dzdlowndp,g_dzdl_d[l_ac].dzdlcrtid,g_dzdl_d[l_ac].dzdlcrtdp,g_dzdl_d[l_ac].dzdlcrtdt,g_dzdl_d[l_ac].dzdlmodid,g_dzdl_d[l_ac].dzdlmoddt,g_dzdl_d[l_ac].dzdlcnfid,g_dzdl_d[l_ac].dzdlcnfdt)
               #add-point:單身新增中
               {<point name="input.body.m_insert"/>}
               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_dzdl_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dzdl_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
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
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_dzdl_d.deleteElement(l_ac)
               NEXT FIELD dzdl004
            END IF
            IF NOT cl_null(g_dzdl_d_t.dzdl004) 
 
               THEN
               
               #add-point:單身刪除前
               {<point name="input.body.b_delete"/>}
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF adzi999_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE adzi999_bcl
               LET l_count = g_dzdl_d.getLength()
            END IF 
            
            #add-point:單身刪除後
            {<point name="input.body.a_delete"/>}
            #end add-point
              
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            {<point name="input.body.after_delete"/>}
            #end add-point
            CALL adzi999_delete_b(l_count) 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl004
            #add-point:BEFORE FIELD dzdl004
            {<point name="input.b.page1.dzdl004" />}
            IF cl_null(g_dzdl_d[l_ac].dzdl004) THEN
               SELECT MAX(dzdl004) + 1 INTO g_dzdl_d[l_ac].dzdl004 FROM dzdl_t
                WHERE dzdl001 = g_dzdl_m.dzdl001
               IF cl_null(g_dzdl_d[l_ac].dzdl004) THEN
                  LET g_dzdl_d[l_ac].dzdl004 = 1
               END IF
            END IF
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl004
            
            #add-point:AFTER FIELD dzdl004
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdl_m.dzdl001) AND NOT cl_null(g_dzdl_d[g_detail_idx].dzdl004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_dzdl_m.dzdl001 != g_dzdl001_t OR g_dzdl_d[g_detail_idx].dzdl004 != g_dzdl_d_t.dzdl004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdl_t WHERE "||"dzdl001 = '"||g_dzdl_m.dzdl001 ||"' AND "|| "dzdl004 = '"||g_dzdl_d[g_detail_idx].dzdl004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl004
            #add-point:ON CHANGE dzdl004
            {<point name="input.g.page1.dzdl004" />}
            #END add-point
 
         #----<<dzdl005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl005
            #add-point:BEFORE FIELD dzdl005
            {<point name="input.b.page1.dzdl005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl005
            
            #add-point:AFTER FIELD dzdl005
            {<point name="input.a.page1.dzdl005" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl005
            #add-point:ON CHANGE dzdl005
            {<point name="input.g.page1.dzdl005" />}
            #END add-point
 
         #----<<dzdl006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl006
            #add-point:BEFORE FIELD dzdl006
            {<point name="input.b.page1.dzdl006" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl006
            
            #add-point:AFTER FIELD dzdl006
            {<point name="input.a.page1.dzdl006" />}
            IF NOT cl_null(g_dzdl_d[l_ac].dzdl006) THEN
               CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl006) RETURNING g_dzdl_d[l_ac].dzdl006_name
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl006
            #add-point:ON CHANGE dzdl006
            {<point name="input.g.page1.dzdl006" />}
            #END add-point
 
         #----<<dzdl007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl007
            #add-point:BEFORE FIELD dzdl007
            {<point name="input.b.page1.dzdl007" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl007
            
            #add-point:AFTER FIELD dzdl007
            {<point name="input.a.page1.dzdl007" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl007
            #add-point:ON CHANGE dzdl007
            {<point name="input.g.page1.dzdl007" />}
            #END add-point
 
         #----<<dzdl008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl008
            #add-point:BEFORE FIELD dzdl008
            {<point name="input.b.page1.dzdl008" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl008
            
            #add-point:AFTER FIELD dzdl008
            {<point name="input.a.page1.dzdl008" />}
            IF NOT cl_null(g_dzdl_d[l_ac].dzdl008) THEN
               CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl008) RETURNING g_dzdl_d[l_ac].dzdl008_name
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl008
            #add-point:ON CHANGE dzdl008
            {<point name="input.g.page1.dzdl008" />}
            #END add-point
 
         #----<<dzdl009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl009
            #add-point:BEFORE FIELD dzdl009
            {<point name="input.b.page1.dzdl009" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl009
            
            #add-point:AFTER FIELD dzdl009
            {<point name="input.a.page1.dzdl009" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl009
            #add-point:ON CHANGE dzdl009
            {<point name="input.g.page1.dzdl009" />}
            #END add-point
 
         #----<<dzdl010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl010
            #add-point:BEFORE FIELD dzdl010
            {<point name="input.b.page1.dzdl010" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl010
            
            #add-point:AFTER FIELD dzdl010
            {<point name="input.a.page1.dzdl010" />}
            IF NOT cl_null(g_dzdl_d[l_ac].dzdl010) THEN
               CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl010) RETURNING g_dzdl_d[l_ac].dzdl010_name
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl010
            #add-point:ON CHANGE dzdl010
            {<point name="input.g.page1.dzdl010" />}
            #END add-point
 
         #----<<dzdl011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl011
            #add-point:BEFORE FIELD dzdl011
            {<point name="input.b.page1.dzdl011" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl011
            
            #add-point:AFTER FIELD dzdl011
            {<point name="input.a.page1.dzdl011" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl011
            #add-point:ON CHANGE dzdl011
            {<point name="input.g.page1.dzdl011" />}
            #END add-point
 
         #----<<dzdl012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl012
            #add-point:BEFORE FIELD dzdl012
            {<point name="input.b.page1.dzdl012" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl012
            
            #add-point:AFTER FIELD dzdl012
            {<point name="input.a.page1.dzdl012" />}
            IF NOT cl_null(g_dzdl_d[l_ac].dzdl012) THEN
               CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl012) RETURNING g_dzdl_d[l_ac].dzdl012_name
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl012
            #add-point:ON CHANGE dzdl012
            {<point name="input.g.page1.dzdl012" />}
            #END add-point
 
         #----<<dzdl013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl013
            #add-point:BEFORE FIELD dzdl013
            {<point name="input.b.page1.dzdl013" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl013
            
            #add-point:AFTER FIELD dzdl013
            {<point name="input.a.page1.dzdl013" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl013
            #add-point:ON CHANGE dzdl013
            {<point name="input.g.page1.dzdl013" />}
            #END add-point
 
         #----<<dzdl014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdl014
            #add-point:BEFORE FIELD dzdl014
            {<point name="input.b.page1.dzdl014" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdl014
            
            #add-point:AFTER FIELD dzdl014
            {<point name="input.a.page1.dzdl014" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdl014
            #add-point:ON CHANGE dzdl014
            {<point name="input.g.page1.dzdl014" />}
            #END add-point
 
         #----<<dzdlstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdlstus
            #add-point:BEFORE FIELD dzdlstus
            {<point name="input.b.page1.dzdlstus" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdlstus
            
            #add-point:AFTER FIELD dzdlstus
            {<point name="input.a.page1.dzdlstus" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdlstus
            #add-point:ON CHANGE dzdlstus
            {<point name="input.g.page1.dzdlstus" />}
            #END add-point
 
         #----<<dzdlownid>>----
         #----<<dzdlowndp>>----
         #----<<dzdlcrtid>>----
         #----<<dzdlcrtdp>>----
         #----<<dzdlcrtdt>>----
         #----<<dzdlmodid>>----
         #----<<dzdlmoddt>>----
         #----<<dzdlcnfid>>----
         #----<<dzdlcnfdt>>----
 
         #---------------------<  Detail: page1  >---------------------
         #----<<dzdl004>>----
         #Ctrlp:input.c.page1.dzdl004
#         ON ACTION controlp INFIELD dzdl004
            #add-point:ON ACTION controlp INFIELD dzdl004
            {<point name="input.c.page1.dzdl004" />}
            #END add-point
 
         #----<<dzdl005>>----
         #Ctrlp:input.c.page1.dzdl005
#         ON ACTION controlp INFIELD dzdl005
            #add-point:ON ACTION controlp INFIELD dzdl005
            {<point name="input.c.page1.dzdl005" />}
            #END add-point
 
         #----<<dzdl006>>----
         #Ctrlp:input.c.page1.dzdl006
          ON ACTION controlp INFIELD dzdl006
            #add-point:ON ACTION controlp INFIELD dzdl006
            {<point name="input.c.page1.dzdl006" />}
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzdl_d[l_ac].dzdl006
            CALL q_ooag001_4() 
            LET g_dzdl_d[l_ac].dzdl006 = g_qryparam.return1
            #END add-point
 
         #----<<dzdl007>>----
         #Ctrlp:input.c.page1.dzdl007
#         ON ACTION controlp INFIELD dzdl007
            #add-point:ON ACTION controlp INFIELD dzdl007
            {<point name="input.c.page1.dzdl007" />}
            #END add-point
 
         #----<<dzdl008>>----
         #Ctrlp:input.c.page1.dzdl008
          ON ACTION controlp INFIELD dzdl008
            #add-point:ON ACTION controlp INFIELD dzdl008
            {<point name="input.c.page1.dzdl008" />}
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzdl_d[l_ac].dzdl008
            CALL q_ooag001_4() 
            LET g_dzdl_d[l_ac].dzdl008 = g_qryparam.return1
            #END add-point
 
         #----<<dzdl009>>----
         #Ctrlp:input.c.page1.dzdl009
#         ON ACTION controlp INFIELD dzdl009
            #add-point:ON ACTION controlp INFIELD dzdl009
            {<point name="input.c.page1.dzdl009" />}
            #END add-point
 
         #----<<dzdl010>>----
         #Ctrlp:input.c.page1.dzdl010
          ON ACTION controlp INFIELD dzdl010
            #add-point:ON ACTION controlp INFIELD dzdl010
            {<point name="input.c.page1.dzdl010" />}
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzdl_d[l_ac].dzdl010
            CALL q_ooag001_4() 
            LET g_dzdl_d[l_ac].dzdl010 = g_qryparam.return1
            #END add-point
 
         #----<<dzdl011>>----
         #Ctrlp:input.c.page1.dzdl011
#         ON ACTION controlp INFIELD dzdl011
            #add-point:ON ACTION controlp INFIELD dzdl011
            {<point name="input.c.page1.dzdl011" />}
            #END add-point
 
         #----<<dzdl012>>----
         #Ctrlp:input.c.page1.dzdl012
          ON ACTION controlp INFIELD dzdl012
            #add-point:ON ACTION controlp INFIELD dzdl012
            {<point name="input.c.page1.dzdl012" />}
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dzdl_d[l_ac].dzdl012
            CALL q_ooag001_4() 
            LET g_dzdl_d[l_ac].dzdl012 = g_qryparam.return1
            #END add-point
 
         #----<<dzdl013>>----
         #Ctrlp:input.c.page1.dzdl013
#         ON ACTION controlp INFIELD dzdl013
            #add-point:ON ACTION controlp INFIELD dzdl013
            {<point name="input.c.page1.dzdl013" />}
            #END add-point
 
         #----<<dzdl014>>----
         #Ctrlp:input.c.page1.dzdl014
#         ON ACTION controlp INFIELD dzdl014
            #add-point:ON ACTION controlp INFIELD dzdl014
            {<point name="input.c.page1.dzdl014" />}
            #END add-point
 
         #----<<dzdlstus>>----
         #Ctrlp:input.c.page1.dzdlstus
#         ON ACTION controlp INFIELD dzdlstus
            #add-point:ON ACTION controlp INFIELD dzdlstus
            {<point name="input.c.page1.dzdlstus" />}
            #END add-point
 
         #----<<dzdlownid>>----
         #----<<dzdlowndp>>----
         #----<<dzdlcrtid>>----
         #----<<dzdlcrtdp>>----
         #----<<dzdlcrtdt>>----
         #----<<dzdlmodid>>----
         #----<<dzdlmoddt>>----
         #----<<dzdlcnfid>>----
         #----<<dzdlcnfdt>>----
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_dzdl_d[l_ac].* = g_dzdl_d_t.*
               CLOSE adzi999_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dzdl_d[l_ac].dzdl004
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_dzdl_d[l_ac].* = g_dzdl_d_t.*
            ELSE
            
               #add-point:單身修改前
               {<point name="input.body.b_update" mark="Y"/>}
               #end add-point
         
               UPDATE dzdl_t SET (dzdl001,dzdl004,dzdl005,dzdl006,dzdl007,dzdl008,dzdl009,dzdl010,dzdl011,dzdl012,dzdl013,dzdl014,dzdlstus,dzdlownid,dzdlowndp,dzdlcrtid,dzdlcrtdp,dzdlcrtdt,dzdlmodid,dzdlmoddt,dzdlcnfid,dzdlcnfdt) = (g_dzdl_m.dzdl001,g_dzdl_d[l_ac].dzdl004,g_dzdl_d[l_ac].dzdl005,g_dzdl_d[l_ac].dzdl006,g_dzdl_d[l_ac].dzdl007,g_dzdl_d[l_ac].dzdl008,g_dzdl_d[l_ac].dzdl009,g_dzdl_d[l_ac].dzdl010,g_dzdl_d[l_ac].dzdl011,g_dzdl_d[l_ac].dzdl012,g_dzdl_d[l_ac].dzdl013,g_dzdl_d[l_ac].dzdl014,g_dzdl_d[l_ac].dzdlstus,g_dzdl_d[l_ac].dzdlownid,g_dzdl_d[l_ac].dzdlowndp,g_dzdl_d[l_ac].dzdlcrtid,g_dzdl_d[l_ac].dzdlcrtdp,g_dzdl_d[l_ac].dzdlcrtdt,g_dzdl_d[l_ac].dzdlmodid,g_dzdl_d[l_ac].dzdlmoddt,g_dzdl_d[l_ac].dzdlcnfid,g_dzdl_d[l_ac].dzdlcnfdt)
                WHERE  dzdl001 = g_dzdl_m.dzdl001 
 
                 AND dzdl004 = g_dzdl_d_t.dzdl004 #項次   
 
               #add-point:單身修改中
               {<point name="input.body.m_update"/>}
               #end add-point      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "dzdl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_dzdl_d[l_ac].* = g_dzdl_d_t.*
               ELSE
                  #資料多語言用-增/改
                  
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
 
 
      
 
      
      #add-point:input段more_input
      {<point name="input.more_inputarray"/>}
      #end add-point    
      
      BEFORE DIALOG
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD dzdl001
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
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
END FUNCTION
 
 
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzi999_show()
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point
   
   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point
   
   
 
   LET g_dzdl_m_t.* = g_dzdl_m.*      #保存單頭舊值
   
   DISPLAY BY NAME g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
   CALL adzi999_get_dzdl001_name(g_dzdl_m.dzdl001,g_dzdl_m.dzdl002) RETURNING g_dzdl001_name
   DISPLAY g_dzdl001_name TO dzdl001_name

   CALL adzi999_b_fill(g_wc2)                 #單身
 
   CALL adzi999_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point   
   
END FUNCTION
 
 
#+ 帶出reference資料
PRIVATE FUNCTION adzi999_ref_show()
   {<Local define>}
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   {</Local define>}
   #add-point:ref_show段define
   {<point name="ref_show.define"/>}
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   {<point name="ref_show.head.reference"/>}
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dzdl_d.getLength()
      #add-point:ref_show段d_reference
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdl_d[l_ac].dzdlownid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdl_d[l_ac].dzdlownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdl_d[l_ac].dzdlownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdl_d[l_ac].dzdlowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dzdl_d[l_ac].dzdlowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdl_d[l_ac].dzdlowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdl_d[l_ac].dzdlcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdl_d[l_ac].dzdlcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdl_d[l_ac].dzdlcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdl_d[l_ac].dzdlcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_dzdl_d[l_ac].dzdlcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdl_d[l_ac].dzdlcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdl_d[l_ac].dzdlmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdl_d[l_ac].dzdlmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdl_d[l_ac].dzdlmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_dzdl_d[l_ac].dzdlcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            LET g_dzdl_d[l_ac].dzdlcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_dzdl_d[l_ac].dzdlcnfid_desc
          {#ADP版次:1#}
      #end add-point
   END FOR
   
 
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
 
#+ 資料複製
PRIVATE FUNCTION adzi999_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE dzdl_t.dzdl001 
   DEFINE l_oldno     LIKE dzdl_t.dzdl001 
 
   DEFINE l_master    RECORD LIKE dzdl_t.*
   DEFINE l_detail    RECORD LIKE dzdl_t.*
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
 
   IF g_dzdl_m.dzdl001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   LET g_dzdl001_t = g_dzdl_m.dzdl001
 
    
   CALL adzi999_set_entry('a')
   CALL adzi999_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   
 
   INPUT l_newno #FROM 
 
    FROM dzdl001 
 
         ATTRIBUTE(FIELD ORDER FORM)
         
         AFTER FIELD dzdl001 
            #add-point:AFTER FIELD dzdl001
            {<point name="reproduce.dzdl001" />}
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
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00006"
         LET g_errparam.extend = "Reproduce"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         NEXT FIELD dzdl001 
         END IF
         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM dzdl_t 
          WHERE  dzdl001 = l_newno
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #NEXT FIELD dzdl001 
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
   
   LET g_sql = "SELECT * FROM dzdl_t WHERE  ",
               " dzdl001 = '",g_dzdl_m.dzdl001,"'"
 
   DECLARE adzi999_reproduce CURSOR FROM g_sql
 
   FOREACH adzi999_reproduce INTO l_detail.*
 
      LET l_detail.dzdl001 = l_newno
 
      
      #公用欄位給予預設值
      #此段落由子樣板a13產生
      LET l_detail.dzdlownid = g_user
      LET l_detail.dzdlowndp = g_dept
      LET l_detail.dzdlcrtid = g_user
      LET l_detail.dzdlcrtdp = g_dept 
      LET l_detail.dzdlcrtdt = cl_get_current()
      LET l_detail.dzdlmodid = "" #g_user
      LET l_detail.dzdlmoddt = "" #cl_get_current()
      #LET l_detail.dzdlstus = "Y"
 
 
 
      #add-point:單身複製前
      {<point name="reproduce.body.b_insert" mark="Y"/>}
      #end add-point
      INSERT INTO dzdl_t VALUES (l_detail.*) #複製單身
      #add-point:單身複製中
      {<point name="reproduce.body.m_insert"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
  
      #add-point:單身複製後
      {<point name="reproduce.body.a_insert"/>}
      #end add-point
   END FOREACH
 
   CALL s_transaction_end('Y','0')
   ERROR 'ROW(',l_newno,') O.K'
   CLOSE adzi999_reproduce
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " dzdl001 = '", l_newno CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point
   
END FUNCTION
 
#+ 資料刪除
PRIVATE FUNCTION adzi999_delete()
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
   
   IF g_dzdl_m.dzdl001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
    SELECT UNIQUE dzdl001,dzdl002,dzdl003
 INTO g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
 FROM dzdl_t
 WHERE dzdl001 = g_dzdl_m.dzdl001
   CALL s_transaction_begin()
   
   
 
   OPEN adzi999_cl USING g_dzdl_m.dzdl001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi999_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi999_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH adzi999_cl INTO g_dzdl_m.dzdl001,g_dzdl_m.dzdl002,g_dzdl_m.dzdl003
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzdl_m.dzdl001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   CALL adzi999_show()
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      #刪除相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values =g_dzdl_m.dzdl001
      LET g_pk_array[1].column ="dzdl001"
      CALL cl_doc_remove()
 
      #add-point:單身刪除前
      {<point name="delete.body.b_delete" mark="Y"/>}
      #end add-point
      
      DELETE FROM dzdl_t WHERE  dzdl001 = g_dzdl_m.dzdl001
 
                                                               
      #add-point:單身刪除中
      {<point name="delete.body.m_delete"/>}
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dzdl_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      {<point name="delete.body.a_delete"/>}
      #end add-point
      
      CLEAR FORM
      CALL g_dzdl_d.clear() 
 
     
      CALL adzi999_ui_browser_refresh()  
      CALL adzi999_ui_headershow()  
      CALL adzi999_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL adzi999_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL adzi999_browser_fill("F")
      END IF
       
   END IF
 
   CLOSE adzi999_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_dzdl_m.dzdl001,'D')
    
END FUNCTION
 
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi999_b_fill(p_wc2)
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point     
 
   #先清空單身變數內容
   CALL g_dzdl_d.clear()
 
 
   #add-point:b_fill段define
   {<point name="b_fill.sql_before"/>}
   #end add-point
   
   LET g_sql = "SELECT dzdl004,dzdl005,dzdl006,dzdl007,dzdl008,dzdl009,dzdl010,dzdl011,dzdl012,dzdl013,dzdl014,dzdlstus,dzdlownid,'',dzdlowndp,'',dzdlcrtid,'',dzdlcrtdp,'',dzdlcrtdt,dzdlmodid,'',dzdlmoddt,dzdlcnfid,'',dzdlcnfdt FROM dzdl_t WHERE dzdl001=?"   
 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY dzdl_t.dzdl004"
 
   PREPARE adzi999_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR adzi999_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs USING g_dzdl_m.dzdl001
 
                                            
   FOREACH b_fill_cs INTO g_dzdl_d[l_ac].dzdl004,g_dzdl_d[l_ac].dzdl005,g_dzdl_d[l_ac].dzdl006,g_dzdl_d[l_ac].dzdl007,g_dzdl_d[l_ac].dzdl008,g_dzdl_d[l_ac].dzdl009,g_dzdl_d[l_ac].dzdl010,g_dzdl_d[l_ac].dzdl011,g_dzdl_d[l_ac].dzdl012,g_dzdl_d[l_ac].dzdl013,g_dzdl_d[l_ac].dzdl014,g_dzdl_d[l_ac].dzdlstus,g_dzdl_d[l_ac].dzdlownid,g_dzdl_d[l_ac].dzdlownid_desc,g_dzdl_d[l_ac].dzdlowndp,g_dzdl_d[l_ac].dzdlowndp_desc,g_dzdl_d[l_ac].dzdlcrtid,g_dzdl_d[l_ac].dzdlcrtid_desc,g_dzdl_d[l_ac].dzdlcrtdp,g_dzdl_d[l_ac].dzdlcrtdp_desc,g_dzdl_d[l_ac].dzdlcrtdt,g_dzdl_d[l_ac].dzdlmodid,g_dzdl_d[l_ac].dzdlmodid_desc,g_dzdl_d[l_ac].dzdlmoddt,g_dzdl_d[l_ac].dzdlcnfid,g_dzdl_d[l_ac].dzdlcnfid_desc,g_dzdl_d[l_ac].dzdlcnfdt
 
                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
                        
      #add-point:b_fill段資料填充
      {<point name="b_fill.fill"/>}
      #end add-point
 
      #帶出公用欄位reference值
      #此段落由子樣板a12產生
      #LET g_dzdl_d[l_ac].dzdlownid_desc = cl_get_username(g_dzdl_d[l_ac].dzdlownid)
      #LET g_dzdl_d[l_ac].dzdlowndp_desc = cl_get_deptname(g_dzdl_d[l_ac].dzdlowndp)
      #LET g_dzdl_d[l_ac].dzdlcrtid_desc = cl_get_username(g_dzdl_d[l_ac].dzdlcrtid)
      #LET g_dzdl_d[l_ac].dzdlcrtdp_desc = cl_get_deptname(g_dzdl_d[l_ac].dzdlcrtdp)
      #LET g_dzdl_d[l_ac].dzdlmodid_desc = cl_get_username(g_dzdl_d[l_ac].dzdlmodid)
      #LET g_dzdl_d[l_ac].dzdlcnfid_desc = cl_get_deptname(g_dzdl_d[l_ac].dzdlcnfid)
      ##LET g_dzdl_d[l_ac].dzdlpstid_desc = cl_get_deptname(g_dzdl_d[l_ac].dzdlpstid)
      
      CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl006) RETURNING g_dzdl_d[l_ac].dzdl006_name
      CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl008) RETURNING g_dzdl_d[l_ac].dzdl008_name
      CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl010) RETURNING g_dzdl_d[l_ac].dzdl010_name
      CALL adzi999_get_name(g_dzdl_d[l_ac].dzdl012) RETURNING g_dzdl_d[l_ac].dzdl012_name
 
      
 
   
 
     
      #add-point:單身資料抓取
      {<point name="bfill.foreach"/>}
      #end add-point
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_dzdl_d.deleteElement(l_ac)
 
 
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE adzi999_pb   
   
END FUNCTION
 
 
#+ 單身db資料刪除
PRIVATE FUNCTION adzi999_before_delete()
   #add-point:before_delete段define
   {<point name="before_delete.define"/>}
   #end add-point 
   
   #add-point:單筆刪除前
   {<point name="delete.body.b_single_delete" mark="Y"/>}
   #end add-point
   
   DELETE FROM dzdl_t
    WHERE  dzdl001 = g_dzdl_m.dzdl001 AND
 
          dzdl004 = g_dzdl_d_t.dzdl004
 
      
   #add-point:單筆刪除中
   {<point name="delete.body.m_single_delete"/>}
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdl_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
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
PRIVATE FUNCTION adzi999_delete_b(p_total)
   {<Local define>}
   DEFINE p_total LIKE type_t.num5
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point     
 
 
 
   IF p_total = g_dzdl_d.getLength() THEN
      CALL g_dzdl_d.deleteElement(l_ac)
   END IF 
   
END FUNCTION
 
 
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi999_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1  
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("dzdl001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point 
 
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi999_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("dzdl001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point 
 
END FUNCTION
 
 
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzi999_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point     
   
   #add-point:set_entry_b段
   {<point name="set_entry_b.set_entry_b"/>}
   #end add-point  
   
END FUNCTION
 
 
#+ 單身欄位關閉設定
PRIVATE FUNCTION adzi999_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point    
   
   #add-point:set_no_entry_b段
   {<point name="set_no_entry_b.set_no_entry_b段"/>}
   #end add-point 
   
END FUNCTION
 
 
#+ 外部參數搜尋, 施工中
PRIVATE FUNCTION adzi999_default_search()
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
      LET ls_wc = ls_wc, " dzdl001 = '", g_argv[1], "' AND "
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
 
 

FUNCTION adzi999_get_dzdl001_name(p_dzdl001,p_dzdl002)
   DEFINE p_dzdl001    LIKE dzdl_t.dzdl001
   DEFINE p_dzdl002    LIKE dzdl_t.dzdl002
   DEFINE r_gzzal003   LIKE gzzal_t.gzzal003

   IF cl_null(p_dzdl001) OR cl_null(p_dzdl002) THEN
      RETURN NULL
   END IF

   CASE p_dzdl002
        WHEN 'B'   #应用元件
                   #CALL sadz_get_name('dzda_t','dzda001',p_dzdl001) RETURNING r_gzzal003 
                   SELECT gzdel003 INTO r_gzzal003 FROM gzdel_t WHERE gzdel001 = p_dzdl001 AND gzdel002 = g_lang
        WHEN 'S'   #子作业
                   SELECT gzdel003 INTO r_gzzal003 FROM gzdel_t WHERE gzdel001 = p_dzdl001 AND gzdel002 = g_lang
        WHEN 'M'   #独立作业
                   SELECT gzzal003 INTO r_gzzal003 FROM gzzal_t WHERE gzzal001 = p_dzdl001 AND gzzal002 = g_lang
        WHEN 'F'   #子画面
                   SELECT gzdel003 INTO r_gzzal003 FROM gzdel_t WHERE gzdel001 = p_dzdl001 AND gzdel002 = g_lang
   END CASE
   RETURN r_gzzal003

END FUNCTION

FUNCTION adzi999_get_name(p_oofa003)
   DEFINE p_oofa003       LIKE oofa_t.oofa003
   DEFINE r_oofa011       LIKE oofa_t.oofa011

   SELECT oofa011 INTO r_oofa011 FROM oofa_t
    WHERE oofa003 = p_oofa003
      AND oofa002 = '2'
   RETURN r_oofa011

END FUNCTION




