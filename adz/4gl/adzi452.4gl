#+ Version..: T100-ERP-1.00.00(版次:1) Build-000005
#+ 
#+ Filename...: adzi452
#+ Description: 應用元件改名批量處理作業
#+ Creator....: 00537(2013/10/12)
#+ Modifier...: 00537(2013/10/12)
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
PRIVATE type type_g_dzdk_m        RECORD
       dzdk001 LIKE dzdk_t.dzdk001, 
       dzdk001_desc LIKE dzdi_t.dzdi005,
       dzdk002 LIKE dzdk_t.dzdk002, 
       dzdk002_desc LIKE dzdi_t.dzdi005,
       dzdk003 LIKE dzdk_t.dzdk003,
       dzdk008 LIKE dzdk_t.dzdk008
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dzdk_d        RECORD
       dzdk004 LIKE dzdk_t.dzdk004, 
       dzdk005 LIKE dzdk_t.dzdk005, 
       dzdk006 LIKE dzdk_t.dzdk006,
       dzdk006_desc LIKE dzdi_t.dzdi005, 
       dzdk007 DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_dzdk2_d RECORD
       item LIKE dzdk_t.dzdk004,
       mod  LIKE type_t.chr1,
       subname LIKE dzbb_t.dzbb001,
       point LIKE dzbb_t.dzbb002,
       code STRING,
       success LIKE type_t.chr1,
       err_msg LIKE type_t.chr1000,
       dzbb003 LIKE dzbb_t.dzbb003,
       dzbb004 LIKE dzbb_t.dzbb004
       END RECORD
 
 
 
#無單頭append欄位定義
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_dzdk_m          type_g_dzdk_m
DEFINE g_dzdk_m_t        type_g_dzdk_m
 
DEFINE g_dzdk001_t     LIKE dzdk_t.dzdk001
DEFINE g_dzdk002_t     LIKE dzdk_t.dzdk002
 
 
 
DEFINE g_dzdk_d          DYNAMIC ARRAY OF type_g_dzdk_d
DEFINE g_dzdk_d_t        type_g_dzdk_d
DEFINE g_dzdk2_d   DYNAMIC ARRAY OF type_g_dzdk2_d
DEFINE g_dzdk2_d_t type_g_dzdk2_d
 
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_dzdk001 LIKE dzdk_t.dzdk001,
      b_dzdk002 LIKE dzdk_t.dzdk002
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
DEFINE g_flag                LIKE type_t.chr1

{</Module define>}
 
#add-point:自定義模組變數(Module Variable)
{<point name="global.variable"/>}
DEFINE g_dzdi003             LIKE dzdi_t.dzdi003
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
   {<point name="main.define_sql" mark="Y"/>}
   #end add-point
   LET g_forupd_sql = "SELECT dzdk001,dzdk002,dzdk003,dzdk008 FROM dzdk_t WHERE dzdk001=? AND dzdk002=? FOR UPDATE"
   #add-point:SQL_define
   {<point name="main.after_define_sql"/>}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE adzi452_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR

   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
   
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi452 WITH FORM cl_ap_formpath("adz",g_code)
 
      #程式初始化
      CALL adzi452_init()   
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #進入選單 Menu (="N")
      CALL adzi452_ui_dialog() 
 
      #畫面關閉
      CLOSE WINDOW w_adzi452
      
   END IF 
   
   CLOSE adzi452_cl
   
   
 
   #add-point:作業離開前
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
    
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzi452_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point    
  
   LET g_bfill = "Y"
   
   
   LET g_error_show = 1
   #add-point:畫面資料初始化
   {<point name="init.init"/>}
   CALL cl_set_combo_scc('dzdk003','18001')
   #end add-point
   
   CALL adzi452_default_search()
    
END FUNCTION
 
 
#+ 功能選單
PRIVATE FUNCTION adzi452_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   DEFINE l_flag   LIKE type_t.num5     #标识第一次进入
   {<point name="ui_dialog.define"/>}
   #end add-point  
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #該樣板不需此段落CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("mainlayout",1)
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("worksheet",0)
   #該樣板不需此段落LET g_main_hidden = 1
   
   #add-point:ui_dialog段before dialog 
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point
   LET l_flag = TRUE    
   WHILE TRUE
   
      CALL adzi452_browser_fill("")
 
      #該樣板不需此段落CALL lib_cl_dlg.cl_dlg_before_display()
      #該樣板不需此段落CALL cl_notice()
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_dzdk001 = g_dzdk001_t
               AND g_browser[li_idx].b_dzdk002 = g_dzdk002_t
 
 
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
    
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #該樣板不需此段落#左側瀏覽頁簽
         #該樣板不需此段落DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
         #該樣板不需此段落
         #該樣板不需此段落   BEFORE ROW
         #該樣板不需此段落      #回歸舊筆數位置 (回到當時異動的筆數)
         #該樣板不需此段落      LET g_current_idx = DIALOG.getCurrentRow("s_browse")
         #該樣板不需此段落      IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
         #該樣板不需此段落         CALL DIALOG.setCurrentRow("s_browse",g_current_row)
         #該樣板不需此段落         LET g_current_idx = g_current_row
         #該樣板不需此段落      END IF
         #該樣板不需此段落      LET g_current_row = g_current_idx #目前指標
         #該樣板不需此段落      LET g_current_sw = TRUE
         #該樣板不需此段落      
         #該樣板不需此段落      IF g_current_idx > g_browser.getLength() THEN
         #該樣板不需此段落         LET g_current_idx = g_browser.getLength()
         #該樣板不需此段落      END IF 
         #該樣板不需此段落      
         #該樣板不需此段落      CALL adzi452_fetch('') # reload data
         #該樣板不需此段落      LET g_detail_idx = 1
         #該樣板不需此段落      CALL adzi452_ui_detailshow() #Setting the current row 
         #該樣板不需此段落
         #該樣板不需此段落END DISPLAY
        
         DISPLAY ARRAY g_dzdk_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_ac = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.idx
#               CALL adzi452_ui_detailshow()
               
            BEFORE DISPLAY 
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
               
         END DISPLAY
        
         DISPLAY ARRAY g_dzdk2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL adzi452_ui_detailshow()
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
         END DISPLAY
 
 
         
         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point
         
         #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_qryplan
         #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_relateapps 
         
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            #該樣板不需此段落LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
            #該樣板不需此段落   CALL DIALOG.setCurrentRow("s_browse",g_current_row)
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
               CALL adzi452_fetch('') # reload data
            END IF
#若是第一次打开程序，需要填充一次第二单身，之后只有新增和查询的时候才会刷新第二单身
            IF l_flag THEN CALL adzi452_b2_fill('') LET l_flag = FALSE END IF 
            #LET g_detail_idx = 1
            CALL adzi452_ui_detailshow() #Setting the current row 
            
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
         #該樣板不需此段落ON ACTION filter
         #該樣板不需此段落   CALL adzi452_filter()
         #該樣板不需此段落   EXIT DIALOG
         
         ON ACTION first
            CALL adzi452_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL adzi452_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL adzi452_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL adzi452_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL adzi452_fetch('L')
            LET g_current_row = g_current_idx
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         #該樣板不需此段落ON ACTION mainhidden       #主頁摺疊
         #該樣板不需此段落   IF g_main_hidden THEN
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",0)
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",1)
         #該樣板不需此段落      LET g_main_hidden = 0
         #該樣板不需此段落   ELSE
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",1)
         #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",0)
         #該樣板不需此段落      LET g_main_hidden = 1
         #該樣板不需此段落   END IF
            
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
            
         
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL adzi452_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL adzi452_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
                EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL adzi452_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
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
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL adzi452_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL adzi452_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
 
        ON ACTION process 
            LET g_action_choice="process"
            IF cl_auth_chk_act("process") THEN 
               CALL adzi452_process()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
        ON ACTION compile
            LET g_action_choice="compile"
            IF cl_auth_chk_act("compile") THEN 
               CALL adzi452_compile()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
        ON ACTION send_mail 
            LET g_action_choice="send_mail"
            IF cl_auth_chk_act("send_mail") THEN 
              #CALL adzi452_send_mail()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
        ON ACTION backup 
            LET g_action_choice="backup"
            IF cl_auth_chk_act("backup") THEN 
               CALL adzi452_backup()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF
        ON ACTION upd_dzda
            LET g_action_choice="upd_dzda"
            IF cl_auth_chk_act("upd_dzda") THEN 
               CALL adzi452_upd_dzda()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
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
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF  
            
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adzi452_browser_search(p_type)
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
      LET g_wc = g_wc, " ORDER BY dzdk001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL adzi452_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE
 
END FUNCTION
 
 
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adzi452_browser_fill(ps_page_action)
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
      LET l_searchcol = "dzdk001"
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
      LET l_sub_sql = " SELECT UNIQUE dzdk001 ",
                      ", dzdk002 ",
 
 
                      " FROM dzdk_t ",
                      " ",
                      " ",
                      " WHERE  ",l_wc, " AND ", l_wc2 
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE dzdk001 ",
                      ", dzdk002 ",
 
 
                      " FROM dzdk_t ",
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
 
      #依照dzdk001,dzdk002 Browser欄位定義(取代原本bs_sql功能)
      LET l_sub_sql  = "SELECT DISTINCT dzdk001,dzdk002 ",
                       " FROM dzdk_t ",
                       " ",
                       " WHERE  ", g_wc," AND ",g_wc2
 
   ELSE
      #單身無輸入資料
      LET l_sub_sql  = "SELECT DISTINCT dzdk001,dzdk002 ",
                       " FROM dzdk_t ",
                       " WHERE  ", g_wc
                 
   END IF
   
   LET l_sql_rank = "SELECT dzdk001,dzdk002,DENSE_RANK() OVER(ORDER BY dzdk001 ",g_order,") AS RANK ",
                    " FROM (",l_sub_sql,") "
                       
   #定義翻頁CURSOR
   LET g_sql= " SELECT dzdk001,dzdk002 FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
              " AND RANK<",g_pagestart+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
                
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_dzdk001,g_browser[g_cnt].b_dzdk002    
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
      #end add-point    
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND g_wc THEN
      INITIALIZE g_dzdk_m.* TO NULL
      CALL g_dzdk_d.clear()
      CALL g_dzdk2_d.clear()
 
 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   #該樣板不需此段落CALL adzi452_fetch('')
   
   FREE browse_pre
   
END FUNCTION
 
 
#+ 單頭資料重新顯示
PRIVATE FUNCTION adzi452_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point    
   
   LET g_dzdk_m.dzdk001 = g_browser[g_current_idx].b_dzdk001   
   LET g_dzdk_m.dzdk002 = g_browser[g_current_idx].b_dzdk002   
 
 
    SELECT UNIQUE dzdk001,dzdk002,dzdk003,dzdk008
 INTO g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
 FROM dzdk_t
 WHERE dzdk001 = g_dzdk_m.dzdk001 AND dzdk002 = g_dzdk_m.dzdk002
   CALL adzi452_show()
   
END FUNCTION
 
 
#+ 單身資料重新顯示
PRIVATE FUNCTION adzi452_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point    
   
   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   END IF
   
   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point 
   
END FUNCTION
 
 
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adzi452_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_dzdk001 = g_dzdk_m.dzdk001 
         AND g_browser[l_i].b_dzdk002 = g_dzdk_m.dzdk002 
 
 
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
PRIVATE FUNCTION adzi452_construct()
 
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
   INITIALIZE g_dzdk_m.* TO NULL
   CALL g_dzdk_d.clear()
   CALL g_dzdk2_d.clear()
 
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dzdk001,dzdk002,dzdk003,dzdk008
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.head.before_construct"/>}
            #end add-point 
            
        #---------------------------<  Master  >---------------------------
         #----<<dzdk001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk001
            #add-point:BEFORE FIELD dzdk001
            {<point name="construct.b.dzdk001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk001
            
            #add-point:AFTER FIELD dzdk001
            {<point name="construct.a.dzdk001" />}
            #END add-point
            
 
         #Ctrlp:construct.c.dzdk001
#         ON ACTION controlp INFIELD dzdk001
            #add-point:ON ACTION controlp INFIELD dzdk001
            {<point name="construct.c.dzdk001" />}
            #END add-point
 
         #----<<dzdk002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk002
            #add-point:BEFORE FIELD dzdk002
            {<point name="construct.b.dzdk002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk002
            
            #add-point:AFTER FIELD dzdk002
            {<point name="construct.a.dzdk002" />}
            #END add-point
            
 
         #Ctrlp:construct.c.dzdk001
         ON ACTION controlp INFIELD dzdk001
            #add-point:ON ACTION controlp INFIELD dzdk001
            {<point name="construct.c.dzdk002" />}
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzdk001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdk001  #顯示到畫面上
            NEXT FIELD dzdk001  
            #END add-point

         #Ctrlp:construct.c.dzdk001
         ON ACTION controlp INFIELD dzdk002
            #add-point:ON ACTION controlp INFIELD dzdk002
            {<point name="construct.c.dzdk002" />}
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzdk002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO dzdk002  #顯示到畫面上
            NEXT FIELD dzdk002  
            #END add-point
 
         #----<<dzdk003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk003
            #add-point:BEFORE FIELD dzdk003
            {<point name="construct.b.dzdk003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk003
            
            #add-point:AFTER FIELD dzdk003
            {<point name="construct.a.dzdk003" />}
            #END add-point
            
 
         #Ctrlp:construct.c.dzdk003
#         ON ACTION controlp INFIELD dzdk003
            #add-point:ON ACTION controlp INFIELD dzdk003
            {<point name="construct.c.dzdk003" />}
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身可以混搭多頁簽
      CONSTRUCT g_wc2 ON dzdk004,dzdk005,dzdk006,dzdk007
         FROM s_detail1[1].dzdk004,s_detail1[1].dzdk005,s_detail1[1].dzdk006,s_detail1[1].dzdk007
 
 
                      
         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point 
            
            #公用欄位開窗相關處理
            
          
            #---------------------<  Detail: page1  >---------------------
         #----<<dzdk004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk004
            #add-point:BEFORE FIELD dzdk004
            {<point name="construct.b.page1.dzdk004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk004
            
            #add-point:AFTER FIELD dzdk004
            {<point name="construct.a.page1.dzdk004" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdk004
#         ON ACTION controlp INFIELD dzdk004
            #add-point:ON ACTION controlp INFIELD dzdk004
            {<point name="construct.c.page1.dzdk004" />}
            #END add-point
 
         #----<<dzdk005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk005
            #add-point:BEFORE FIELD dzdk005
            {<point name="construct.b.page1.dzdk005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk005
            
            #add-point:AFTER FIELD dzdk005
            {<point name="construct.a.page1.dzdk005" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdk005
#         ON ACTION controlp INFIELD dzdk005
            #add-point:ON ACTION controlp INFIELD dzdk005
            {<point name="construct.c.page1.dzdk005" />}
            #END add-point
 
         #----<<dzdk006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk006
            #add-point:BEFORE FIELD dzdk006
            {<point name="construct.b.page1.dzdk006" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk006
            
            #add-point:AFTER FIELD dzdk006
            {<point name="construct.a.page1.dzdk006" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdk006
#         ON ACTION controlp INFIELD dzdk006
            #add-point:ON ACTION controlp INFIELD dzdk006
            {<point name="construct.c.page1.dzdk006" />}
            #END add-point
 
         #----<<dzdk007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk007
            #add-point:BEFORE FIELD dzdk007
            {<point name="construct.b.page1.dzdk007" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk007
            
            #add-point:AFTER FIELD dzdk007
            {<point name="construct.a.page1.dzdk007" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.dzdk007
#         ON ACTION controlp INFIELD dzdk007
            #add-point:ON ACTION controlp INFIELD dzdk007
            {<point name="construct.c.page1.dzdk007" />}
            #END add-point
 
   
            #---------------------<  Detail: page2  >---------------------
   
 
 
          
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
PRIVATE FUNCTION adzi452_filter()
#該樣板不需此段落   {<Local define>}
#該樣板不需此段落   {</Local define>}
#該樣板不需此段落   #add-point:filter段define
#該樣板不需此段落   {<point name="filter.define"/>}
#該樣板不需此段落   #end add-point    
 
#該樣板不需此段落   LET INT_FLAG = 0
 
#該樣板不需此段落   LET g_qryparam.state = 'c'
 
#該樣板不需此段落   LET g_wc_filter_t = g_wc_filter
#該樣板不需此段落   LET g_wc_t = g_wc
 
#該樣板不需此段落   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
#該樣板不需此段落   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
#該樣板不需此段落   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
#該樣板不需此段落      #單頭
#該樣板不需此段落      CONSTRUCT g_wc_filter ON 
#該樣板不需此段落                          FROM 
 
#該樣板不需此段落         BEFORE CONSTRUCT
#該樣板不需此段落            CALL cl_qbe_init()
#該樣板不需此段落   
 
#該樣板不需此段落      END CONSTRUCT
 
      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point
 
#該樣板不需此段落      BEFORE DIALOG
         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
         #end add-point  
 
#該樣板不需此段落      ON ACTION accept
#該樣板不需此段落         ACCEPT DIALOG
 
#該樣板不需此段落      ON ACTION cancel
#該樣板不需此段落         LET INT_FLAG = 1
#該樣板不需此段落         EXIT DIALOG 
 
#該樣板不需此段落      #交談指令共用ACTION
#該樣板不需此段落      &include "common_action.4gl" 
#該樣板不需此段落         CONTINUE DIALOG
   
#該樣板不需此段落   END DIALOG
 
#該樣板不需此段落   IF NOT INT_FLAG THEN
#該樣板不需此段落      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
#該樣板不需此段落      LET g_wc = g_wc , g_wc_filter
#該樣板不需此段落   ELSE
#該樣板不需此段落      LET g_wc_filter = g_wc_filter_t
#該樣板不需此段落      LET g_wc = g_wc_t
#該樣板不需此段落   END IF
 
END FUNCTION
 
#+ filter過濾功能
PRIVATE FUNCTION adzi452_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
#該樣板不需此段落   #add-point:filter段define
#該樣板不需此段落   {<point name="filter_parser.define"/>}
#該樣板不需此段落   #end add-point    
 
#該樣板不需此段落   #一般條件解析
#該樣板不需此段落   LET ls_tmp = ps_field, "='"
#該樣板不需此段落   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
#該樣板不需此段落   IF li_tmp > 0 THEN
#該樣板不需此段落      LET li_tmp = ls_tmp.getLength() + li_tmp
#該樣板不需此段落      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
#該樣板不需此段落      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
#該樣板不需此段落   END IF
 
#該樣板不需此段落   #模糊條件解析
#該樣板不需此段落   LET ls_tmp = ps_field, " like '"
#該樣板不需此段落   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
#該樣板不需此段落   IF li_tmp > 0 THEN
#該樣板不需此段落      LET li_tmp = ls_tmp.getLength() + li_tmp
#該樣板不需此段落      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
#該樣板不需此段落      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
#該樣板不需此段落      LET ls_var = cl_replace_str(ls_var,'%','*')
#該樣板不需此段落   END IF
 
#該樣板不需此段落   RETURN ls_var
 
END FUNCTION
 
 
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adzi452_query()
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
   CALL g_dzdk_d.clear()
   CALL g_dzdk2_d.clear()
 
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL adzi452_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL adzi452_browser_fill(g_wc)
      CALL adzi452_fetch("")
      RETURN
   END IF
   
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
 
   LET g_error_show = 1
   CALL adzi452_browser_fill("F")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(ls_wc)
      LET g_error_show = 1
      CALL adzi452_browser_fill("F")
   END IF
   
   #第二層助記碼搜尋
   IF g_browser_cnt = 0 THEN
 
      
      
      IF NOT cl_null(g_wc) THEN
         LET g_error_show = 1
         CALL adzi452_browser_fill("F")
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
      CALL adzi452_fetch("F") 
   END IF
   CALL adzi452_b2_fill(g_wc2) 
END FUNCTION
 
 
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adzi452_fetch(p_flag)
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
   
   CALL adzi452_browser_fill(p_flag)
   
   #該樣板不需此段落CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
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
   
   LET g_dzdk_m.dzdk001 = g_browser[g_current_idx].b_dzdk001
   LET g_dzdk_m.dzdk002 = g_browser[g_current_idx].b_dzdk002
 
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE dzdk001,dzdk002,dzdk003,dzdk008
 INTO g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
 FROM dzdk_t
 WHERE dzdk001 = g_dzdk_m.dzdk001 AND dzdk002 = g_dzdk_m.dzdk002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdk_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      INITIALIZE g_dzdk_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL adzi452_show()
 
END FUNCTION
 
 
#+ 資料新增
PRIVATE FUNCTION adzi452_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_dzdk_d.clear()
   CALL g_dzdk2_d.clear()
 
 
 
   INITIALIZE g_dzdk_m.* LIKE dzdk_t.*             #DEFAULT 設定
   LET g_dzdk001_t = NULL
   LET g_dzdk002_t = NULL
 
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
      LET g_dzdk_m.dzdk008 = 'N' 
      LET g_dzdk_m.dzdk003 = 3
      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point 
 
      CALL adzi452_input("a")
      
      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzdk_m.* = g_dzdk_m_t.*
         CALL adzi452_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT WHILE
      END IF
      
      CALL g_dzdk_d.clear()
 
 
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   LET g_state = "Y"
   
   LET g_dzdk001_t = g_dzdk_m.dzdk001
   LET g_dzdk002_t = g_dzdk_m.dzdk002
 
 
   
   LET g_wc = g_wc,  
              " OR (  ",
              " dzdk001 = '", g_dzdk_m.dzdk001 CLIPPED, "' "
              ," AND dzdk002 = '", g_dzdk_m.dzdk002 CLIPPED, "' "
 
 
              , ") "
   
END FUNCTION
 
 
#+ 資料修改
PRIVATE FUNCTION adzi452_modify()
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point    
   
   IF g_dzdk_m.dzdk001 IS NULL
   OR g_dzdk_m.dzdk002 IS NULL
 
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
    SELECT UNIQUE dzdk001,dzdk002,dzdk003,dzdk008
 INTO g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
 FROM dzdk_t
 WHERE dzdk001 = g_dzdk_m.dzdk001 AND dzdk002 = g_dzdk_m.dzdk002
 
   ERROR ""
  
   LET g_dzdk001_t = g_dzdk_m.dzdk001
   LET g_dzdk002_t = g_dzdk_m.dzdk002
 
 
   CALL s_transaction_begin()
   
   OPEN adzi452_cl USING g_dzdk_m.dzdk001
                                                       ,g_dzdk_m.dzdk002
 
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi452_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi452_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH adzi452_cl INTO g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzdk_m.dzdk001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE adzi452_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL adzi452_show()
   WHILE TRUE
      LET g_dzdk001_t = g_dzdk_m.dzdk001
      LET g_dzdk002_t = g_dzdk_m.dzdk002
 
 
 
      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point
      
      CALL adzi452_input("u")     #欄位更改
      
      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzdk_m.* = g_dzdk_m_t.*
         CALL adzi452_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_dzdk_m.dzdk001 != g_dzdk001_t 
      OR g_dzdk_m.dzdk002 != g_dzdk002_t 
 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         {<point name="modify.b_key_update" mark="Y"/>}
         #end add-point
         
         #更新單頭key值
         UPDATE dzdk_t SET dzdk001 = g_dzdk_m.dzdk001
                                       , dzdk002 = g_dzdk_m.dzdk002
 
 
          WHERE  dzdk001 = g_dzdk001_t
            AND dzdk002 = g_dzdk002_t
 
 
         #add-point:單頭(偽)修改中
         {<point name="modify.m_key_update"/>}
         #end add-point
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "dzdk_t"
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
   IF NOT cl_used_modified_record(g_dzdk_m.dzdk001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adzi452_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_dzdk_m.dzdk001,'U')
 
   CALL adzi452_b_fill("1=1")
   
END FUNCTION   
 
 
#+ 資料輸入
PRIVATE FUNCTION adzi452_input(p_cmd)
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
   DEFINE  l_success       LIKE type_t.num5
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
   LET g_forupd_sql = "SELECT dzdk004,dzdk005,dzdk006,'',dzdk007 FROM dzdk_t WHERE dzdk001=? AND dzdk002=? AND dzdk004=? FOR UPDATE"
   #add-point:input段define_sql
   {<point name="input.after_define_sql"/>}
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adzi452_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adzi452_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL adzi452_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   {<point name="input.after_set_no_entry"/>}
   #end add-point
 
   DISPLAY BY NAME g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
   
   #add-point:進入修改段前
   {<point name="input.before_input"/>}
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            
            
          
         #---------------------------<  Master  >---------------------------
         #----<<dzdk001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk001
            #add-point:BEFORE FIELD dzdk001
            {<point name="input.b.dzdk001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk001
            
            #add-point:AFTER FIELD dzdk001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdk_m.dzdk001) AND NOT cl_null(g_dzdk_m.dzdk002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_dzdk_m.dzdk001 != g_dzdk001_t  OR g_dzdk_m.dzdk002 != g_dzdk002_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdk_t WHERE "||"dzdk001 = '"||g_dzdk_m.dzdk001 ||"' AND "|| "dzdk002 = '"||g_dzdk_m.dzdk002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF  NOT cl_null(g_dzdk_m.dzdk001)  THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_dzdk_m.dzdk001 != g_dzdk001_t   ) THEN 
                  IF NOT adzi452_chk_dzdk001(g_dzdk_m.dzdk001) THEN LET g_dzdk_m.dzdk001 = NULL NEXT FIELD dzdk001 END IF 
                  LET g_dzdi003 = g_dzdk_m.dzdk001
                  LET g_dzdi003 = s_chr_trim(g_dzdi003)
                  CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzdk_m.dzdk001_desc
                  DISPLAY g_dzdk_m.dzdk001_desc TO FORMONLY.dzdk001_desc 
               END IF
            END IF
            DISPLAY BY NAME g_dzdk_m.dzdk001

          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdk001
            #add-point:ON CHANGE dzdk001
            {<point name="input.g.dzdk001" />}
            #END add-point
 
         #----<<dzdk002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk002
            #add-point:BEFORE FIELD dzdk002
            {<point name="input.b.dzdk002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk002
            
            #add-point:AFTER FIELD dzdk002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dzdk_m.dzdk001) AND NOT cl_null(g_dzdk_m.dzdk002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_dzdk_m.dzdk001 != g_dzdk001_t  OR g_dzdk_m.dzdk002 != g_dzdk002_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dzdk_t WHERE "||"dzdk001 = '"||g_dzdk_m.dzdk001 ||"' AND "|| "dzdk002 = '"||g_dzdk_m.dzdk002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_dzdk_m.dzdk002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_dzdk_m.dzdk002 != g_dzdk002_t ) THEN 
                  IF NOT adzi452_chk_dzdk002(g_dzdk_m.dzdk002,1) THEN LET g_dzdk_m.dzdk002 = NULL NEXT FIELD dzdk002 END IF                   
                  LET g_dzdi003 = g_dzdk_m.dzdk002
                  LET g_dzdi003 = s_chr_trim(g_dzdi003)
                  CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzdk_m.dzdk002_desc
                  DISPLAY g_dzdk_m.dzdk002_desc TO FORMONLY.dzdk002_desc 
               END IF
            END IF
            DISPLAY BY NAME g_dzdk_m.dzdk002
#元件名称维护和显示
        BEFORE FIELD dzdk001_desc
           LET g_dzdk_m_t.dzdk001_desc = GET_FLDBUF(dzdk001_desc)


        ON ACTION update_item
           CASE
              WHEN INFIELD(dzdk001_desc)
                 LET g_dzdi003 = g_dzdk_m.dzdk001
                 LET g_dzdi003 = s_chr_trim(g_dzdi003)
                 CALL sadz_edit_name("dzda_t","dzda001",g_dzdi003) RETURNING l_success
                 CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzdk_m.dzdk001_desc
                 DISPLAY g_dzdk_m.dzdk001_desc TO FORMONLY.dzdk001_desc
                 CALL cl_show_fld_cont()
              WHEN INFIELD(dzdk002_desc)
                 LET g_dzdi003 = g_dzdk_m.dzdk002 
                 LET g_dzdi003 = s_chr_trim(g_dzdi003)
                 CALL sadz_edit_name("dzda_t","dzda001",g_dzdi003) RETURNING l_success
                 CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzdk_m.dzdk002_desc
                 DISPLAY g_dzdk_m.dzdk002_desc TO FORMONLY.dzdk002_desc
                 CALL cl_show_fld_cont()
           END CASE

        AFTER FIELD a
           IF g_dzdk_m.dzdk008 ='N' THEN LET g_flag ='s' ELSE LET g_flag ='c' END IF 

          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdk002
            #add-point:ON CHANGE dzdk002
            {<point name="input.g.dzdk002" />}
            #END add-point
 
         #----<<dzdk003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD dzdk003
            #add-point:BEFORE FIELD dzdk003
            {<point name="input.b.dzdk003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD dzdk003
            
            #add-point:AFTER FIELD dzdk003
            {<point name="input.a.dzdk003" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE dzdk003
            #add-point:ON CHANGE dzdk003
            {<point name="input.g.dzdk003" />}
            #END add-point
 
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<dzdk001>>----
         #Ctrlp:input.c.dzdk001
         ON ACTION controlp INFIELD dzdk001
            #add-point:ON ACTION controlp INFIELD dzdk001
            {<point name="input.c.dzdk001" />}
            LET g_qryparam.default1 = g_dzdk_m.dzdk001
            LET g_qryparam.reqry = FALSE
            CALL q_dzda001()
            LET g_dzdk_m.dzdk001 = g_qryparam.return1
            DISPLAY g_dzdk_m.dzdk001 TO dzdk001
            NEXT FIELD dzdk001
            #END add-point
 
         #----<<dzdk002>>----
         #Ctrlp:input.c.dzdk002
         ON ACTION controlp INFIELD dzdk002
            #add-point:ON ACTION controlp INFIELD dzdk002
            {<point name="input.c.dzdk002" />}
            LET g_qryparam.default1 = g_dzdk_m.dzdk002
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "dzdastus <> '5'"
            CALL q_dzda001()
            LET g_dzdk_m.dzdk002 = g_qryparam.return1
            DISPLAY g_dzdk_m.dzdk002 TO dzdk002
            NEXT FIELD dzdk002
            #END add-point
 
         #----<<dzdk003>>----
         #Ctrlp:input.c.dzdk003
#         ON ACTION controlp INFIELD dzdk003
            #add-point:ON ACTION controlp INFIELD dzdk003
            {<point name="input.c.dzdk003" />}
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
            DISPLAY BY NAME g_dzdk_m.dzdk001             
                            ,g_dzdk_m.dzdk002   
 
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point
            
               UPDATE dzdk_t SET (dzdk001,dzdk002,dzdk003,dzdk008) = (g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008)
                WHERE dzdk001 = g_dzdk001_t
                  AND dzdk002 = g_dzdk002_t
 
 
               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_dzdk_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               ELSE
                  #資料多語言用-增/改
                  
                  LET g_dzdk001_t = g_dzdk_m.dzdk001
                  LET g_dzdk002_t = g_dzdk_m.dzdk002
 
 
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
#如果是新增或者修改了老元件名称，则刷新第二单身
           IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_dzdk_m.dzdk001 != g_dzdk001_t) THEN
              CALL adzi452_b2_fill(g_wc2)
           END IF            
           #若單身還沒有輸入資料, 強制切換至單身
           IF p_cmd='a' THEN
              INSERT INTO dzdk_t (dzdk001,dzdk002,dzdk003,dzdk004,dzdk008) VALUES (g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,0,g_dzdk_m.dzdk008)    #因为是假双挡，但是历次修改的单身又不能进入，所以在这里insert dzdk，第0笔单身只是为了key完整，不显示在单身
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'Insert error!'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 CALL s_transaction_end('N','0')
                 RETURN
              END IF
              CALL s_transaction_end('Y','0')
              NEXT FIELD mod
           END IF
 
      END INPUT
      
#      DISPLAY ARRAY g_dzdk_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
#      
#         BEFORE ROW
#            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#            LET l_ac = g_detail_idx
#            DISPLAY g_detail_idx TO FORMONLY.idx
#            CALL adzi452_ui_detailshow()
#            
#         BEFORE DISPLAY 
#            CALL FGL_SET_ARR_CURR(g_detail_idx)
#            LET l_ac = DIALOG.getCurrentRow("s_detail1")
#            
#            #控制stus哪個按鈕可以按
            
            
         
 
            
#      END DISPLAY
        

      INPUT ARRAY g_dzdk2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dzdk2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adzi452_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            
            LET l_cmd = ''           
            LET l_cmd='u'
            LET g_dzdk2_d_t.* = g_dzdk2_d[l_ac].*  #BACKUP
            CALL adzi452_set_entry_b(l_cmd)
            CALL adzi452_set_no_entry_b(l_cmd) 
            CALL adzi452_ref_show()
            CALL cl_show_fld_cont()
            #add-point:modify段before row
            {<point name="input.body.before_row"/>}
            #end add-point  
            
        
         BEFORE INSERT          

              
         BEFORE DELETE                            #是否取消單身

              
         AFTER DELETE 

 
         #---------------------<  Detail: page2  >---------------------
         #----<<dzdk004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mod
            #add-point:BEFORE FIELD dzdk004
            {<point name="input.b.page1.dzdk004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mod
            
          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a04產生

 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               EXIT DIALOG 
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
            NEXT FIELD dzdk001
   
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
PRIVATE FUNCTION adzi452_show()
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point
   
   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point
   
   
 
   LET g_dzdk_m_t.* = g_dzdk_m.*      #保存單頭舊值
#显示单头新老元件名称
   LET g_dzdi003 = g_dzdk_m.dzdk001
   IF g_dzdi003 is NOT NULL THEN LET g_dzdi003 = s_chr_trim(g_dzdi003) END IF 
   LET g_dzdk_m.dzdk001_desc = ''
   CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzdk_m.dzdk001_desc
   DISPLAY g_dzdk_m.dzdk001_desc TO FORMONLY.dzdk001_desc 

   LET g_dzdi003 = g_dzdk_m.dzdk002
   IF g_dzdi003 is NOT NULL THEN LET g_dzdi003 = s_chr_trim(g_dzdi003) END IF 
   CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzdk_m.dzdk002_desc
   DISPLAY g_dzdk_m.dzdk002_desc TO FORMONLY.dzdk002_desc 
   
   
   DISPLAY BY NAME g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
   CALL adzi452_b_fill(g_wc2)                 #單身
 
   CALL adzi452_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point   
   
END FUNCTION
 
 
#+ 帶出reference資料
PRIVATE FUNCTION adzi452_ref_show()
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
   FOR l_ac = 1 TO g_dzdk_d.getLength()
      #add-point:ref_show段d_reference
      {<point name="ref_show.body.reference"/>}
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_dzdk2_d.getLength()
      #add-point:ref_show段d2_reference
      {<point name="ref_show.body.reference2"/>}
      #end add-point
   END FOR
 
 
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
 
#+ 資料複製
PRIVATE FUNCTION adzi452_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE dzdk_t.dzdk001 
   DEFINE l_oldno     LIKE dzdk_t.dzdk001 
   DEFINE l_newno02     LIKE dzdk_t.dzdk002 
   DEFINE l_oldno02     LIKE dzdk_t.dzdk002 
 
 
   DEFINE l_master    RECORD LIKE dzdk_t.*
   DEFINE l_detail    RECORD LIKE dzdk_t.*
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
 
   IF g_dzdk_m.dzdk001 IS NULL
      OR g_dzdk_m.dzdk002 IS NULL
 
 
      THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   LET g_dzdk001_t = g_dzdk_m.dzdk001
   LET g_dzdk002_t = g_dzdk_m.dzdk002
 
 
    
   CALL adzi452_set_entry('a')
   CALL adzi452_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   
 
   INPUT l_newno #FROM 
         ,l_newno02
 
 
    FROM dzdk001 
         ,dzdk002 
 
 
         ATTRIBUTE(FIELD ORDER FORM)
         
         AFTER FIELD dzdk001 
            #add-point:AFTER FIELD dzdk001
            {<point name="reproduce.dzdk001" />}
            #END add-point
         
         AFTER FIELD dzdk002 
            #add-point:AFTER FIELD dzdk002
            {<point name="reproduce.dzdk002" />}
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
            OR l_newno02 IS NULL
 
 
            THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00006"
         LET g_errparam.extend = "Reproduce"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         NEXT FIELD dzdk001 
         END IF
         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM dzdk_t 
          WHERE  dzdk001 = l_newno
            AND dzdk002 = l_newno02
 
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #NEXT FIELD dzdk001 
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
   
   LET g_sql = "SELECT * FROM dzdk_t WHERE  ",
               " dzdk001 = '",g_dzdk_m.dzdk001,"'"
              ," AND dzdk002 = '",g_dzdk_m.dzdk002,"'"
 
 
   DECLARE adzi452_reproduce CURSOR FROM g_sql
 
   FOREACH adzi452_reproduce INTO l_detail.*
 
      LET l_detail.dzdk001 = l_newno
      LET l_detail.dzdk002 = l_newno02
 
 
      
      #公用欄位給予預設值
      
 
      #add-point:單身複製前
      {<point name="reproduce.body.b_insert" mark="Y"/>}
      #end add-point
      INSERT INTO dzdk_t VALUES (l_detail.*) #複製單身
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
   CLOSE adzi452_reproduce
   
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " dzdk001 = '", l_newno CLIPPED, "' "
              ," AND dzdk002 = '", l_newno02 CLIPPED, "' "
 
 
              , ") "
   
   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point
   
END FUNCTION
 
#+ 資料刪除
PRIVATE FUNCTION adzi452_delete()
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
   
   IF g_dzdk_m.dzdk001 IS NULL
   OR g_dzdk_m.dzdk002 IS NULL
 
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
 
    SELECT UNIQUE dzdk001,dzdk002,dzdk003,dzdk008
 INTO g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
 FROM dzdk_t
 WHERE dzdk001 = g_dzdk_m.dzdk001 AND dzdk002 = g_dzdk_m.dzdk002
   CALL s_transaction_begin()
   
   
 
   OPEN adzi452_cl USING g_dzdk_m.dzdk001
                                                       ,g_dzdk_m.dzdk002
 
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adzi452_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE adzi452_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH adzi452_cl INTO g_dzdk_m.dzdk001,g_dzdk_m.dzdk002,g_dzdk_m.dzdk003,g_dzdk_m.dzdk008
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_dzdk_m.dzdk001
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   CALL adzi452_show()
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      #刪除相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values =g_dzdk_m.dzdk001
      LET g_pk_array[1].column ="dzdk001"
      CALL cl_doc_remove()
 
      #add-point:單身刪除前
      {<point name="delete.body.b_delete" mark="Y"/>}
      #end add-point
      
      DELETE FROM dzdk_t WHERE  dzdk001 = g_dzdk_m.dzdk001
                                                               AND dzdk002 = g_dzdk_m.dzdk002
 
 
                                                               
      #add-point:單身刪除中
      {<point name="delete.body.m_delete"/>}
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dzdk_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      {<point name="delete.body.a_delete"/>}
      #end add-point
      
      CLEAR FORM
      CALL g_dzdk_d.clear() 
      CALL g_dzdk2_d.clear()       
 
 
     
      CALL adzi452_ui_browser_refresh()  
      CALL adzi452_ui_headershow()  
      CALL adzi452_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL adzi452_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL adzi452_browser_fill("F")
      END IF
       
   END IF
 
   CLOSE adzi452_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_dzdk_m.dzdk001,'D')
    
END FUNCTION
 
 
#+ 單身陣列填充
PRIVATE FUNCTION adzi452_b_fill(p_wc2)
DEFINE l_dzbb003       LIKE dzbb_t.dzbb003
DEFINE l_dzbb004       LIKE dzbb_t.dzbb004
DEFINE l_dzbb098       LIKE dzbb_t.dzbb098

   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point     
 
   #先清空單身變數內容
   CALL g_dzdk_d.clear()

   #若单头没有填新老元件，则没法做查询和替换的功能，这时候跑以下sql很耗资源的，所以直接return 
   IF g_dzdk_m.dzdk001 is NULL OR g_dzdk_m.dzdk002 is NULL THEN RETURN END IF 
 
   #add-point:b_fill段define
   {<point name="b_fill.sql_before"/>}
   #end add-point
   
   LET g_sql = "SELECT dzdk004,dzdk005,dzdk006,'',dzdk007 FROM dzdk_t WHERE dzdk001=? AND dzdk002=? AND dzdk004 > 0 "   
 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY dzdk_t.dzdk001,dzdk_t.dzdk002,dzdk_t.dzdk004"
 
   PREPARE adzi452_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR adzi452_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs USING g_dzdk_m.dzdk001
                                            ,g_dzdk_m.dzdk002
 
 
                                            
   FOREACH b_fill_cs INTO g_dzdk_d[l_ac].dzdk004,g_dzdk_d[l_ac].dzdk005,g_dzdk_d[l_ac].dzdk006,g_dzdk_d[l_ac].dzdk006_desc,g_dzdk_d[l_ac].dzdk007
 
 
                          
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

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_dzdk_d[l_ac].dzdk006
      CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
      LET g_dzdk_d[l_ac].dzdk006_desc = '', g_rtn_fields[1] , ''          
 
     
      #add-point:單身資料抓取
      {<point name="bfill.foreach"/>}
      #end add-point
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_dzdk_d.deleteElement(l_ac) 
 
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE adzi452_pb  
      
END FUNCTION
 
#更新第二单身
PRIVATE FUNCTION adzi452_b2_fill(p_wc2)
DEFINE l_dzbb003       LIKE dzbb_t.dzbb003
DEFINE l_dzbb004       LIKE dzbb_t.dzbb004
DEFINE l_dzbb098       LIKE dzbb_t.dzbb098

   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point     
 
   #先清空單身變數內容
   CALL g_dzdk2_d.clear()

   #若单头没有填新老元件，则没法做查询和替换的功能，这时候跑以下sql很耗资源的，所以直接return 
   IF g_dzdk_m.dzdk001 is NULL OR g_dzdk_m.dzdk002 is NULL THEN RETURN END IF 
 
   #add-point:b_fill段define
   {<point name="b_fill.sql_before"/>}
   #end add-point
     
#以下为抓取设计器中使用了改名前老元件的程序资料 
   IF g_dzdk_m.dzdk008 ='N' THEN LET g_flag ='s' ELSE LET g_flag ='c' END IF 
   LET g_sql = "SELECT '','N',dzbb001,dzbb002,dzbb098,'N','',dzbb003,dzbb004 FROM dzbb_t,dzba_t ",
               " WHERE dzbb001 = dzba001 ",
               "   AND dzbb002 = dzba003 ", 
               "   AND dzbb003 = dzba004 ", 
               "   AND dzbb004 ='",g_flag CLIPPED,"'",  #目前只知道非客制的是's'，客制是'c'
               "   AND dzba002 ='1'",                   #以后会有ALM传过来，现在先写死1
               "   AND dzbb098 LIKE '%",g_dzdk_m.dzdk001 CLIPPED,"(%'", 
               " ORDER BY dzbb_t.dzbb001,dzbb_t.dzbb002" 
   PREPARE adzi452_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR adzi452_pb2
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   LOCATE l_dzbb098  IN FILE                                          
   FOREACH b_fill_cs2 INTO g_dzdk2_d[l_ac].item,g_dzdk2_d[l_ac].mod,g_dzdk2_d[l_ac].subname,g_dzdk2_d[l_ac].point,l_dzbb098,g_dzdk2_d[l_ac].success,g_dzdk2_d[l_ac].err_msg,g_dzdk2_d[l_ac].dzbb003,g_dzdk2_d[l_ac].dzbb004
  
                          
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
      LET g_dzdk2_d[l_ac].item = l_ac
      LET g_dzdk2_d[l_ac].code = l_dzbb098
      LET g_dzdk2_d[l_ac].mod ='N'
      LET g_dzdk2_d[l_ac].success ='N'
      #end add-point
 
      #帶出公用欄位reference值   
 
     
      #add-point:單身資料抓取
      {<point name="bfill.foreach"/>}
      #end add-point
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   FREE l_dzbb098
   CALL g_dzdk2_d.deleteElement(l_ac) 
 
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
      
END FUNCTION
 
#+ 單身db資料刪除
PRIVATE FUNCTION adzi452_before_delete()
   #add-point:before_delete段define
   {<point name="before_delete.define"/>}
   #end add-point 
   
   #add-point:單筆刪除前
   {<point name="delete.body.b_single_delete" mark="Y"/>}
   #end add-point
   
   DELETE FROM dzdk_t
    WHERE  dzdk001 = g_dzdk_m.dzdk001 AND
                              dzdk002 = g_dzdk_m.dzdk002 AND
 
 
          dzdk004 = g_dzdk_d_t.dzdk004
 
      
   #add-point:單筆刪除中
   {<point name="delete.body.m_single_delete"/>}
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dzdk_t"
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
PRIVATE FUNCTION adzi452_delete_b(p_total)
   {<Local define>}
   DEFINE p_total LIKE type_t.num5
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point     
 
   IF p_total = g_dzdk2_d.getLength() THEN
      CALL g_dzdk2_d.deleteElement(l_ac)
   END IF
 
 
 
   IF p_total = g_dzdk_d.getLength() THEN
      CALL g_dzdk_d.deleteElement(l_ac)
   END IF 
   
END FUNCTION
 
 
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzi452_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1  
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("dzdk001,dzdk002",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point 
 
END FUNCTION
 
 
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzi452_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("dzdk001,dzdk002",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point 
 
END FUNCTION
 
 
#+ 單身欄位開啟設定
PRIVATE FUNCTION adzi452_set_entry_b(p_cmd)
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
PRIVATE FUNCTION adzi452_set_no_entry_b(p_cmd)
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
PRIVATE FUNCTION adzi452_default_search()
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
      LET ls_wc = ls_wc, " dzdk001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " dzdk002 = ", g_argv[02], " AND "
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

#检查老元件是否已经在adzi400中注册并且是有效资料
PRIVATE FUNCTION adzi452_chk_dzdk001(p_dzdk001)
DEFINE p_dzdk001    LIKE dzdk_t.dzdk001    #需进行判断的老元件
DEFINE l_n          LIKE type_t.num5
DEFINE l_return     LIKE type_t.num5

   LET l_n = 0
   LET l_return = TRUE 
   SELECT COUNT(*) INTO l_n FROM dzda_t WHERE dzda001 =p_dzdk001 
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00143'
      LET g_errparam.extend = p_dzdk001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_return = FALSE 
   END IF  
   RETURN l_return
END FUNCTION 
  
#检查参数传入的新元件是否已经在设计器中定义，用function.新元件的条件去套dzba003
PRIVATE FUNCTION adzi452_chk_dzdk002(p_dzdk002,p_flag)
DEFINE p_dzdk002    LIKE dzdk_t.dzdk002    #需进行判断的新元件
DEFINE p_flag       LIKE type_t.chr1       #0:错误不弹窗  1:错误弹出窗口
DEFINE l_dzba003    LIKE dzba_t.dzba003 
DEFINE l_n          LIKE type_t.num5
DEFINE l_return     LIKE type_t.num5

   LET l_n = 0
   LET l_return = TRUE 
   LET l_dzba003 = 'function.',p_dzdk002 CLIPPED 
   SELECT COUNT(*) INTO l_n FROM dzba_t WHERE dzba003 =l_dzba003 AND dzbastus ='Y'
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00193'
      LET g_errparam.extend = p_dzdk002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_return = FALSE 
      RETURN l_return
   END IF  
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM dzda_t WHERE dzda001 =p_dzdk002 
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00143'
      LET g_errparam.extend = p_dzdk002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_return = FALSE 
      RETURN l_return
   END IF  
   RETURN l_return
   
END FUNCTION     

#批量更新
#整批更新的逻辑过程：
#            检查是否已存在此元件
#            是否已有效存在于注册信息中
#            是否已被锁
#            锁定程序
#            备份
#            更新specdesigner
#            按照specdesigner产生4gl
#            所有执行成功否置成Y
#            错误的话，错误信息写上去
#            最后解锁 
#以上过程包含在一个事务中，每一笔单身一个事务
PRIVATE FUNCTION adzi452_process()
DEFINE i     LIKE type_t.num5    #第二单身数组的角标
DEFINE l_n   LIKE type_t.num5

   LET g_action_choice = ""
   IF g_dzdk2_d.getlength() = 0 THEN RETURN END IF 
#检查要替换的新元件是否存在设计器中
   IF NOT adzi452_chk_dzdk002(g_dzdk_m.dzdk002,0) THEN RETURN END IF 
#是否已有效存在于注册信息中
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM dzda_t WHERE dzda001 = g_dzdk_m.dzdk002 AND dzdastus <> '5' 
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00194'
      LET g_errparam.extend = g_dzdk_m.dzdk002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN  
   END IF 
   FOR i =1 TO g_dzdk2_d.getlength() 
      IF g_dzdk2_d[i].mod ='N' THEN CONTINUE FOR END IF             #不勾选更新的不处理
      IF g_dzdk2_d[i].success ='N' THEN CONTINUE FOR END IF         #批处理前会先执行备份，默认success是N，若备份失败，这一笔的success还是N，只有success是Y的，备份成了，才会走下去做更新
#以下都是包含在一个事务中了，每一笔单身是一个事务
      CALL s_transaction_begin()
#            是否已被锁         程序锁的功能等型管那边有了锁的功能再参考做
#            锁定程序 
#更新设计器资料dzba_t,dzbb_t
      IF NOT adzi452_upd_specdesigner(i) THEN CALL s_transaction_end('N','0') LET g_dzdk2_d[i].success ='N'  CONTINUE FOR END IF 
      IF NOT adzi452_upd_detail1(i) THEN CALL s_transaction_end('N','0') LET g_dzdk2_d[i].success ='N'  CONTINUE FOR END IF  
#解锁
#若之前都执行成功则commit
      CALL s_transaction_end('Y','0')
      LET g_dzdk2_d[i].success ='Y' 
   END FOR 
END FUNCTION 
PRIVATE FUNCTION adzi452_backup()
DEFINE i            LIKE type_t.num5
DEFINE l_path       STRING
DEFINE l_cmd        STRING
DEFINE l_sql        STRING
DEFINE l_subname    STRING
DEFINE l_result     LIKE type_t.num5
DEFINE l_message    STRING
DEFINE l_time       STRING

   LET g_action_choice = ""
   FOR i =1 TO g_dzdk2_d.getlength()
      IF g_dzdk2_d[i].mod ='N' THEN CONTINUE FOR END IF  #不修改的不备份
      IF i >1 THEN    #相同4gl的只需要备份一次
         IF g_dzdk2_d[i].subname = g_dzdk2_d[i-1].subname AND g_dzdk2_d[i-1].success ='Y' THEN 
            LET g_dzdk2_d[i].success = g_dzdk2_d[i-1].success
            CONTINUE FOR 
         END IF 
      END IF  
       
#在adz/4gl下建立备份目录
#      LET l_time = cl_get_current()
      LET l_time = s_chr_replace(cl_get_current(),' ',':',0)   #时间格式内年和具体的小时分秒之间会有个空格，不去掉空格，mkdir会按空格切断成2个目录来建的
      LET l_path = '$ADZ/4gl/adzi452_backup/',g_dzdk_m.dzdk001 CLIPPED,'_',g_dzdk_m.dzdk002 CLIPPED,'/',l_time CLIPPED,'/',g_dzdk2_d[i].subname CLIPPED 
      LET l_cmd = 'mkdir -p ',l_path 
      LET l_message = NULL 
      TRY
        CALL cl_cmdrun_openpipe("mkdir",l_cmd,TRUE) RETURNING l_result,l_message
      CATCH
        DISPLAY "mkdir error !!"
      END TRY
      IF l_message is NOT NULL THEN 
         LET g_dzdk2_d[i].err_msg = g_dzdk2_d[i].err_msg,l_message 
         LET g_dzdk2_d[i].success = 'N' 
         CONTINUE FOR
      END IF 

#输出exp导出文件到备份目录下  
      LET l_sql = "spool ",l_path,"/",g_dzdk2_d[i].subname CLIPPED,'.txt ;',
                  " SELECT * FROM dzbb_t WHERE dzbb001 = '",g_dzdk2_d[i].subname CLIPPED,"' AND dzbb003 = '",g_dzdk2_d[i].dzbb003,"' AND dzbb004 = '",g_dzdk2_d[i].dzbb004,"';",
                  "spool off "
      DECLARE adzi452_backup CURSOR FROM l_sql
      EXECUTE adzi452_backup
#将4gl备份到备份目录下
      LET l_subname = g_dzdk2_d[i].subname CLIPPED 
      LET l_cmd = "cp $",UPSHIFT(l_subname.substring(1,3)),'/4gl/',g_dzdk2_d[i].subname CLIPPED,".4gl ",l_path
      LET l_message = NULL 
      TRY
        CALL cl_cmdrun_openpipe("cp",l_cmd,TRUE) RETURNING l_result,l_message
      CATCH
        DISPLAY "Backup 4GL file error !!"
      END TRY
      IF l_message is NOT NULL THEN 
         LET g_dzdk2_d[i].err_msg = g_dzdk2_d[i].err_msg,l_message 
         LET g_dzdk2_d[i].success = 'N' 
         CONTINUE FOR
      END IF 
      LET g_dzdk2_d[i].success = 'Y'

   END FOR 
#以下封存，暂时不考虑备份到客户端主机上 --begin
##下载bat文件到本地客户端
#   IF NOT cl_download_file("./adzi452.bat", "C:/adzi452.bat") THEN LET l_return = FALSE RETURN l_return END IF 
##在windows端执行bat
#   LET l_path = '\"c:\\adzi452.bat'
#   CALL ui.Interface.frontCall("standard",
#                                "shellexec",
#                                 [l_path],
#                                 [l_return])
#   IF NOT l_return THEN  
#      RETURN l_return 
#   END IF #
#下载备份文件
##   LET l_sql = "SELECT * FROM dzba_t WHERE dzba001 = '",g_dzdk2_d[i].subname CLIPPED,"' AND dzba002 ='1' AND dzba003 = '",g_dzdk2_d[i].point CLIPPED,"'"
##   LET l_sql = "unloadx ds dzda_",g_dzdk2_d[i].subname CLIPPED,g_dzdk2_d[i].point,".txt ",l_sql 
#                                       --end   
END FUNCTION 
PRIVATE FUNCTION adzi452_upd_specdesigner(p_i)
DEFINE p_i          LIKE type_t.num5            #第二单身数组的角标
DEFINE l_return     LIKE type_t.num5
DEFINE i            LIKE type_t.num5
DEFINE l_source     LIKE dzbb_t.dzbb098
DEFINE l_str1       LIKE type_t.chr100
DEFINE l_str2       LIKE type_t.chr100
DEFINE l_msg        STRING

   
   LET l_return = TRUE 
   IF p_i =0 OR p_i IS NULL THEN 
      LET l_return = FALSE 
      RETURN l_return 
   END IF
   LET i = p_i
   IF g_dzdk2_d[i].success ='N' THEN 
      LET l_return = FALSE 
      RETURN l_return 
   END IF 
    LOCATE l_source  IN FILE
   LET l_source = g_dzdk2_d[i].point
   LET l_str1   = g_dzdk_m.dzdk001 CLIPPED,'('
   LET l_str2   = g_dzdk_m.dzdk002 CLIPPED,'('
   IF l_str2 is NULL THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00242'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_return = FALSE 
      RETURN l_return 
   END IF 
   UPDATE dzbb_t SET dzbb098 = replace(l_source,l_str1,l_str2)
    WHERE dzbb001 = g_dzdk2_d[i].subname
      AND dzbb002 = g_dzdk2_d[i].point
      AND dzbb003 = g_dzdk2_d[i].dzbb003
      AND dzbb004 = g_dzdk2_d[i].dzbb004
 
    FREE l_source
   IF SQLCA.sqlcode THEN 
      LET l_msg = SQLCA.sqlcode
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code = SQLCA.sqlcode
    LET g_errparam.extend = ''
    LET g_errparam.popup = FALSE
    CALL cl_err()
      LET l_return = FALSE 
      IF g_dzdk2_d[i].err_msg is NULL THEN 
         LET g_dzdk2_d[i].err_msg = cl_getmsg(l_msg,g_lang) 
      ELSE 
      	 LET g_dzdk2_d[i].err_msg = g_dzdk2_d[i].err_msg,'\n',cl_getmsg(l_msg,g_lang)
    	END IF 
      RETURN l_return 
   END IF
   IF SQLCA.sqlerrd[3] = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET l_return = FALSE 
      IF g_dzdk2_d[i].err_msg is NULL THEN 
         LET g_dzdk2_d[i].err_msg = cl_getmsg('sub-00034',g_lang) 
      ELSE 
      	 LET g_dzdk2_d[i].err_msg = g_dzdk2_d[i].err_msg,'\n',cl_getmsg('sub-00034',g_lang)
    	END IF 
      RETURN l_return 
   END IF
   RETURN l_return 
END FUNCTION 
#批量编译利用r.c3做
PRIVATE FUNCTION adzi452_compile()
DEFINE i              LIKE type_t.num5
DEFINE ls_run_cmd     STRING
DEFINE l_result       LIKE type_t.num5
DEFINE l_message      STRING

   LET g_action_choice = ""
   FOR i =1 TO g_dzdk2_d.getlength()
      IF g_dzdk2_d[i].mod ='N' THEN CONTINUE FOR END IF  #不修改的不编译
      IF i >1 THEN    #相同4gl的只需要编译一次
         IF g_dzdk2_d[i].subname = g_dzdk2_d[i-1].subname AND g_dzdk2_d[i-1].success ='Y' THEN 
            LET g_dzdk2_d[i].success = g_dzdk2_d[i-1].success
            CONTINUE FOR 
         END IF 
      END IF 
      IF g_dzdk2_d[i].success ='N' THEN 
         CONTINUE FOR 
      END IF 
      LET ls_run_cmd = "r.c3 ",g_dzdk2_d[i].subname
      LET l_message = NULL 
      TRY
        CALL cl_cmdrun_openpipe("r.c3",ls_run_cmd,TRUE) RETURNING l_result,l_message
      CATCH
        DISPLAY "Generate component 4GL file error !!"
      END TRY
      IF l_message is NOT NULL THEN LET g_dzdk2_d[i].err_msg = g_dzdk2_d[i].err_msg,l_message END IF 

   END FOR 

END FUNCTION 

PRIVATE FUNCTION adzi452_send_mail()
DEFINE l_receiver    STRING
DEFINE l_cc          STRING
DEFINE l_bcc         STRING
    
    LET g_action_choice = ""
#   CALL cl_jmail_javamail() RETURNING l_receiver,l_cc,l_bcc
#参考范例；azzi010_send_mail
END FUNCTION

PRIVATE FUNCTION adzi452_upd_dzda()
  
    LET g_action_choice = ""
    CASE g_dzdk_m.dzdk003
         WHEN '1'
           SELECT * FROM dzda_t WHERE dzda001 = g_dzdk_m.dzdk001 INTO TEMP x
           UPDATE x SET dzda001  = g_dzdk_m.dzdk002,
                        dzdastus = 0
           INSERT INTO dzda_t SELECT * FROM x
           IF SQLCA.sqlcode AND SQLCA.sqlcode <> -239 THEN    #重复插则不提示不报错
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              RETURN 
           END IF
           IF SQLCA.sqlerrd[3] > 0 THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'sub-00253'
              LET g_errparam.extend = g_dzdk_m.dzdk002
              LET g_errparam.popup = TRUE
              CALL cl_err()
           END IF 
         WHEN '2'
           UPDATE dzda_t SET dzda001 = g_dzdk_m.dzdk002 WHERE dzda001 = g_dzdk_m.dzdk001
           IF SQLCA.sqlcode THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
           END IF
           IF SQLCA.sqlerrd[3] = 0 THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'sub-00033'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              RETURN 
           END IF
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'sub-00033'
           LET g_errparam.extend = g_dzdk_m.dzdk002
           LET g_errparam.popup = TRUE
           CALL cl_err()
         WHEN '3'
         #不处理
    END CASE 
END FUNCTION

#成功更新设计器资料后，将成功的那笔更新到第一单身里去
PRIVATE FUNCTION adzi452_upd_detail1(p_i)
DEFINE p_i          LIKE type_t.num5            #第二单身数组的角标
DEFINE i            LIKE type_t.num5
DEFINE l_return     LIKE type_t.num5
DEFINE l_dzdk004    LIKE dzdk_t.dzdk004
DEFINE l_dzdk  RECORD LIKE dzdk_t.*

    LET l_return = TRUE 
    LET i = p_i
    IF i >1 THEN    #相同4gl的只需要更新一次
       IF g_dzdk2_d[i].subname = g_dzdk2_d[i-1].subname AND g_dzdk2_d[i-1].success ='Y' THEN 
          LET g_dzdk2_d[i].success = g_dzdk2_d[i-1].success
          LET l_return = TRUE  
          RETURN l_return 
       END IF 
    END IF
    IF g_dzdk2_d[i].success ='N' THEN LET l_return = FALSE RETURN l_return END IF 
    SELECT MAX(dzdk004)+1 INTO l_dzdk004 FROM dzdk_t WHERE dzdk001 = g_dzdk_m.dzdk001 AND dzdk002 = g_dzdk_m.dzdk002
    IF l_dzdk004 is NULL THEN LET l_dzdk004 = 1 END IF 
    LET l_dzdk.dzdk001 = g_dzdk_m.dzdk001
    LET l_dzdk.dzdk002 = g_dzdk_m.dzdk002
    LET l_dzdk.dzdk003 = g_dzdk_m.dzdk003
    LET l_dzdk.dzdk008 = g_dzdk_m.dzdk008
    LET l_dzdk.dzdk004 = l_dzdk004
    LET l_dzdk.dzdk005 = g_dzdk2_d[i].subname
    LET l_dzdk.dzdk006 = g_user
    LET l_dzdk.dzdk007 = cl_get_current()
    INSERT INTO dzdk_t VALUES(l_dzdk.*)
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET l_return = FALSE 
       RETURN l_return
    END IF
    IF SQLCA.sqlerrd[3] = 0 THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'sub-00032'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET l_return = FALSE 
       RETURN l_return
    END IF
    INITIALIZE g_errparam TO NULL
    LET g_errparam.code = 'sub-00033'
    LET g_errparam.extend = ''
    LET g_errparam.popup = FALSE
    CALL cl_err()
    RETURN l_return
    
END FUNCTION
{<point name="other.function"/>}
 
 




