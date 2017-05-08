#該程式已解開Section, 不再透過樣板產出!
{<section id="abmm204.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:9,PR版次:9) Build-000437
#+ 
#+ Filename...: abmm204
#+ Description: 集團生管資料修改作業
#+ Creator....: 02587(2013-10-09 23:42:47)
#+ Modifier...: 02295(2016-03-31 16:56:17) -SD/PR- 01996
 
{</section>}
 
{<section id="abmm204.global" >}
#應用 i04 樣板自動產生(Version:29)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#18  2016/04/13  BY 07900    校验代码重复错误讯息的修改
#160426-00020#1   2016/04/27  By Ann_Huang   修正v_inaa001_1 傳遞的外部參數arg1, arg2值
#160627-00008#1   2016/06/28  By Ann_Huang   修正庫存特徵值無法正常顯示問題
#160705-00042#8   2016/07/12  By sakura      程式中寫死g_prog部分改寫MATCHES方式
#160905-00007#1   2016-09-05  By 08734        ent调整
#170120-00046#1   2016/01/20  By 02295        增加ENT
#161216-00029#5  2017/01/22 By xujing   若当前BOM为失效状态，修改、删除、整单操作、明细操作中各项action不可执行
#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_bmaa_m        RECORD
       bmaasite LIKE bmaa_t.bmaasite, 
   bmaa001 LIKE bmaa_t.bmaa001, 
   bmaa002 LIKE bmaa_t.bmaa002, 
   imaal003 LIKE imaal_t.imaal003, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr80, 
   imaal004 LIKE imaal_t.imaal004, 
   imaa010 LIKE imaa_t.imaa010, 
   imaa010_desc LIKE type_t.chr80, 
   bmaa004 LIKE bmaa_t.bmaa004
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bmba_d        RECORD
       bmba009 LIKE bmba_t.bmba009, 
   bmba003 LIKE bmba_t.bmba003, 
   bmba003_desc LIKE type_t.chr500, 
   bmba003_desc_desc LIKE type_t.chr500, 
   bmba004 LIKE bmba_t.bmba004, 
   bmba004_desc LIKE type_t.chr500, 
   bmba007 LIKE bmba_t.bmba007, 
   bmba007_desc LIKE type_t.chr500, 
   bmba008 LIKE bmba_t.bmba008, 
   bmba005 LIKE bmba_t.bmba006,                   #开section type_t.dat-->bmba_t.bmba006
   bmba006 LIKE bmba_t.bmba006, 
   bmba011 LIKE bmba_t.bmba011, 
   bmba012 LIKE bmba_t.bmba012, 
   bmba010 LIKE bmba_t.bmba010, 
   bmba021 LIKE bmba_t.bmba021, 
   bmba022 LIKE bmba_t.bmba022, 
   bmba023 LIKE bmba_t.bmba023, 
   bmba024 LIKE bmba_t.bmba024, 
   bmba024_desc LIKE type_t.chr500, 
   bmba024_desc_desc LIKE type_t.chr500, 
   bmba030 LIKE bmba_t.bmba030, 
   bmba031 LIKE bmba_t.bmba031, 
   bmba015 LIKE bmba_t.bmba015, 
   bmba015_desc LIKE type_t.chr500, 
   bmba016 LIKE bmba_t.bmba016, 
   bmba016_desc LIKE type_t.chr500, 
   bmba032 LIKE bmba_t.bmba032
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_browser_b_bmba003  LIKE bmba_t.bmba003
DEFINE g_bmaa_l_date        LIKE type_t.chr20
DEFINE g_bmaa_t_l_date      LIKE type_t.chr20
#end add-point
 
#模組變數(Module Variables)
DEFINE g_bmaa_m          type_g_bmaa_m
DEFINE g_bmaa_m_t        type_g_bmaa_m
DEFINE g_bmaa_m_o        type_g_bmaa_m
 
   DEFINE g_bmaasite_t LIKE bmaa_t.bmaasite
DEFINE g_bmaa001_t LIKE bmaa_t.bmaa001
DEFINE g_bmaa002_t LIKE bmaa_t.bmaa002
 
 
DEFINE g_bmba_d          DYNAMIC ARRAY OF type_g_bmba_d
DEFINE g_bmba_d_t        type_g_bmba_d
DEFINE g_bmba_d_o        type_g_bmba_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       #外顯欄位
       b_show          LIKE type_t.chr100,
       #父節點id
       b_pid           LIKE type_t.chr100,
       #本身節點id
       b_id            LIKE type_t.chr100,
       #是否展開
       b_exp           LIKE type_t.chr100,
       #是否有子節點
       b_hasC          LIKE type_t.num5,
       #是否已展開
       b_isExp         LIKE type_t.num5,
       #展開值
       b_expcode       LIKE type_t.num5,
       #tree自定義欄位
          b_bmaa001 LIKE bmaa_t.bmaa001,
   b_bmaa001_desc LIKE type_t.chr80,
   b_bmaa001_desc_desc LIKE type_t.chr80,
      b_bmaa002 LIKE bmaa_t.bmaa002,
      b_bmaasite LIKE bmaa_t.bmaasite
       END RECORD
      
 
DEFINE g_wc                  STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
 
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
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_row_index           LIKE type_t.num10    
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_aw                  STRING                        #確定當下點擊的單身
 
DEFINE g_wc_table1           STRING                        #第1個單身table所使用的g_wc
 
 
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abmm204.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_date_time   DATETIME YEAR TO SECOND
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("abm","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   LET l_date_time = '2013-11-13 09:40:13'
   SELECT bmba005 INTO l_date_time FROM bmba_t
    WHERE bmba001 = 'A009391310005'
      AND bmba003 = 'A009391310001'
      AND bmba005 <= l_date_time
      AND (bmba006 >= l_date_time OR bmba006 IS NULL)
      AND bmbaent = g_enterprise #160905-00007#1 add
   LET g_sql = "SELECT bmba005 FROM bmba_t ",
               " WHERE bmba001 = 'A009391310005' ",
               "   AND bmba003 = 'A009391310001' ",
               "   AND bmba005 = ? ",
               "   AND (bmba006 >= ? OR bmba006 IS NULL)",
               "   AND bmbaent = ",g_enterprise     #160905-00007#1 add
   PREPARE test_pre FROM g_sql
   EXECUTE test_pre USING l_date_time INTO l_date_time
   #end add-point
   LET g_forupd_sql = " SELECT bmaasite,bmaa001,bmaa002,'','','','','','',bmaa004", 
                      " FROM bmaa_t",
                      " WHERE bmaaent= ? AND bmaasite=? AND bmaa001=? AND bmaa002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abmm204_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bmaasite,t0.bmaa001,t0.bmaa002,t0.bmaa004",
               " FROM bmaa_t t0",
               
               " WHERE t0.bmaaent = '" ||g_enterprise|| "' AND t0.bmaasite = ? AND t0.bmaa001 = ? AND t0.bmaa002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abmm204_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmm204 WITH FORM cl_ap_formpath("abm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abmm204_init()   
 
      #進入選單 Menu (="N")
      CALL abmm204_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abmm204
      
   END IF 
   
   CLOSE abmm204_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abmm204.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abmm204_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   
   
      CALL cl_set_combo_scc('bmba021','4003') 
 
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
 
   #end add-point
   
   CALL abmm204_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abmm204.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abmm204_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bmaa_m.* TO NULL
         CALL g_bmba_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abmm204_init()
      END IF
   
      CALL abmm204_browser_fill()
      
      #temp CALL cl_notice()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
         
            BEFORE INPUT
            
         END INPUT
      
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
               
               CALL abmm204_fetch('') # reload data
               #LET g_detail_idx = 1
               CALL abmm204_ui_detailshow() #Setting the current row 
      
               CALL abmm204_idx_chk()
               #NEXT FIELD bmba003
         
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL abmm204_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
               
               ON COLLAPSE (g_row_index)
                  #樹關閉
         
         END DISPLAY
        
         DISPLAY ARRAY g_bmba_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               CALL abmm204_idx_chk()
               LET g_detail_idx = ARR_CURR()
               
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL abmm204_idx_chk()
               
            
               
         END DISPLAY
        
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL abmm204_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abmm204_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abmm204_idx_chk()
            
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog2"
            #若執行集團級程式，則不開放切換營運中心的功能
            #IF g_prog = 'abmm204' THEN        #160705-00042#8 160712 by sakura mark
            IF g_prog MATCHES 'abmm204' THEN   #160705-00042#8 160712 by sakura add
               CALL cl_set_act_visible("logistics", FALSE)
            ELSE
               CALL cl_set_act_visible("logistics", TRUE)
            END IF
            #end add-point
            
            #NEXT FIELD bmba003
      
         #Browser用Action
      
         #一般搜尋
         ON ACTION searchdata
            #取得搜尋關鍵字
            INITIALIZE g_wc TO NULL
            INITIALIZE g_wc2 TO NULL
            INITIALIZE g_wc_table1 TO NULL
 
            LET g_searchstr = GET_FLDBUF(searchstr)
            IF NOT abmm204_browser_search("normal") THEN
               CONTINUE DIALOG
            END IF
            LET g_current_idx = 1
            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -100 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
            END IF   
            LET g_action_choice = "searchdata"
            #EXIT DIALOG
      
         #進階搜尋
         ON ACTION advancesearch    
         
         #升冪排序
         ON ACTION ascending
            INITIALIZE g_wc TO NULL
            INITIALIZE g_wc2 TO NULL
            LET g_order = "ASC"
            LET g_current_idx = 1
            LET g_searchstr = GET_FLDBUF(searchstr)
            
            IF NOT abmm204_browser_search("normal") THEN
               CONTINUE DIALOG
            END IF
            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -100 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
            END IF   
            LET g_action_choice = "ASCENDING"
            EXIT DIALOG
       
         #降冪排序
         ON ACTION descending
            INITIALIZE g_wc TO NULL
            INITIALIZE g_wc2 TO NULL
            LET g_order = "DESC"
            LET g_current_idx = 1
            LET g_searchstr = GET_FLDBUF(searchstr)
            
            IF NOT abmm204_browser_search("normal") THEN
               CONTINUE DIALOG
            END IF
            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -100 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
            END IF   
            LET g_action_choice = "DESCENDING"
            EXIT DIALOG
            
          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_bmba_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
            
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
               CALL gfrm_curr.setElementImage("mainhidden","small/arr-r.png")
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementImage("mainhidden","small/arr-l.png")
               LET g_main_hidden = 1
            END IF
       
         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_worksheet_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet",0)
               CALL gfrm_curr.setElementImage("worksheethidden","small/arr-l.png")
               LET g_worksheet_hidden = 0
               NEXT FIELD b_bmaasite
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet",1)
               CALL gfrm_curr.setElementImage("worksheethidden","small/arr-r.png")
               LET g_worksheet_hidden = 1
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
      
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abmm204_modify()
               #add-point:ON ACTION modify name="menu.modify"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abmm204_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abmm204_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abmm204_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abmm204_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abmm204_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
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
 
{<section id="abmm204.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abmm204_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point 
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="browser_search.pre_function"
   
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
      LET g_wc = " 1=1 "
   END IF         
   
   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY bmaasite"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL abmm204_browser_fill()
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abmm204_browser_fill()
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE l_type            STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   CALL abmm204_tree_creat()
   RETURN
   #end add-point    
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_bmaa_m.* TO NULL
   CALL g_bmba_d.clear()        
 
   CALL g_browser.clear()
   
   IF NOT cl_null(g_wc2) AND g_wc2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2
      LET g_sql = " SELECT DISTINCT t0.bmaa001,t0.bmaa002,t0.bmaasite,t1.imaal003 ,t2.imaal004 FROM bmaa_t t0", 
 
                  " INNER JOIN bmba_t ON bmba001 = bmaa001 ",
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=bmaa001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=bmaa001 AND t2.imaal002='"||g_dlang||"' ",
 
                  " WHERE bmaaent = '" ||g_enterprise|| "' AND ", g_wc
   ELSE 
      LET g_sql = " SELECT DISTINCT t0.bmaa001,t0.bmaa002,t0.bmaasite,t1.imaal003 ,t2.imaal004 FROM bmaa_t t0", 
 
                                 " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=bmaa001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=bmaa001 AND t2.imaal002='"||g_dlang||"' ",
 
                  " WHERE bmaaent = '" ||g_enterprise|| "' AND ", g_wc   
   END IF   
   
   LET g_sql = g_sql, cl_sql_add_filter("bmaa_t"),
                      " ORDER BY bmaasite,bmaa001,bmaa002 "
 
   #add-point:browser填充前 name="browser_fill.before_browser"
   
   IF NOT cl_null(g_wc2) AND g_wc2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2
      LET g_sql = " SELECT UNIQUE bmaa001,'',bmaa002,bmaasite FROM bmaa_t ",
                  " INNER JOIN bmba_t ON bmba001 = bmaa001 ",
                  " WHERE bmaaent = '" ||g_enterprise|| "' AND bmaasite = '" ||g_site ||"' AND ", g_wc
                  #此程式無root欄位: , " AND  = ?"
   ELSE 
      LET g_sql = " SELECT UNIQUE bmaa001,'',bmaa002,bmaasite FROM bmaa_t ",
                  " WHERE bmaaent = '" ||g_enterprise|| "' AND bmaasite = '" ||g_site ||"' AND ", g_wc   
                  #此程式無root欄位: , " AND  = ?"
   END IF   
   
   LET g_sql = g_sql, " ORDER BY bmaasite,bmaa001,bmaa002 "
   #end add-point
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   
   #add-point:browser type填充前 name="browser_fill.before_type"
   
   #end add-point
   
 
   CALL g_browser.clear()
   LET g_cnt = 1
   LET l_type = "0"
   
 
      #add-point:browser_fill段type用 name="browser_fill.type"
      
      #end add-point
 
      FOREACH browse_cur INTO g_browser[g_cnt].b_bmaa001,g_browser[g_cnt].b_bmaa002,g_browser[g_cnt].b_bmaasite, 
          g_browser[g_cnt].b_bmaa001_desc,g_browser[g_cnt].b_bmaa001_desc_desc 
      
         LET g_browser[g_cnt].b_pid  = l_type
         LET g_browser[g_cnt].b_id   = l_type, '.', g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp  = FALSE
         LET g_browser[g_cnt].b_hasC = abmm204_chk_hasC(g_cnt)
         CALL abmm204_desc_show(g_cnt)
      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
      
      IF g_cnt > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_cnt 
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_error_show = 0
      
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   LET g_browser_cnt = g_browser.getLength()
   
   CLOSE browse_cur
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abmm204_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point   
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bmaa_m.bmaasite = g_browser[g_current_idx].b_bmaasite   
   LET g_bmaa_m.bmaa001 = g_browser[g_current_idx].b_bmaa001   
   LET g_bmaa_m.bmaa002 = g_browser[g_current_idx].b_bmaa002   
 
   EXECUTE abmm204_master_referesh USING g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002 INTO g_bmaa_m.bmaasite, 
       g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.bmaa004
   CALL abmm204_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abmm204_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point   
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abmm204_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_bmaasite = g_bmaa_m.bmaasite 
         AND g_browser[l_i].b_bmaa001 = g_bmaa_m.bmaa001 
         AND g_browser[l_i].b_bmaa002 = g_bmaa_m.bmaa002 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abmm204_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_wc       STRING
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_wc1       STRING
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_bmaa_m.* TO NULL
   CALL g_bmba_d.clear()        
 
   
   LET g_current_idx = 1
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bmaasite,bmaa001,bmaa002,imaa009,imaa010,bmaa004
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
         
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaasite
            #add-point:BEFORE FIELD bmaasite name="construct.b.bmaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaasite
            
            #add-point:AFTER FIELD bmaasite name="construct.a.bmaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaasite
            #add-point:ON ACTION controlp INFIELD bmaasite name="construct.c.bmaasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa001
            #add-point:ON ACTION controlp INFIELD bmaa001 name="construct.c.bmaa001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmaa001  #顯示到畫面上

            NEXT FIELD bmaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa001
            #add-point:BEFORE FIELD bmaa001 name="construct.b.bmaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa001
            
            #add-point:AFTER FIELD bmaa001 name="construct.a.bmaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa002
            #add-point:BEFORE FIELD bmaa002 name="construct.b.bmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa002
            
            #add-point:AFTER FIELD bmaa002 name="construct.a.bmaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa002
            #add-point:ON ACTION controlp INFIELD bmaa002 name="construct.c.bmaa002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="construct.b.imaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="construct.a.imaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="construct.c.imaa010"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			 LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa010  #顯示到畫面上

            NEXT FIELD imaa010  
            #END add-point
 
 
         #Ctrlp:construct.c.bmaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa004
            #add-point:ON ACTION controlp INFIELD bmaa004 name="construct.c.bmaa004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmaa004  #顯示到畫面上

            NEXT FIELD bmaa004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa004
            #add-point:BEFORE FIELD bmaa004 name="construct.b.bmaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa004
            
            #add-point:AFTER FIELD bmaa004 name="construct.a.bmaa004"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table1 ON bmba009,bmba003,bmba004,bmba007,bmba008,bmba005,bmba006,bmba011,bmba012, 
          bmba010,bmba021,bmba022,bmba023,bmba024,bmba030,bmba031,bmba015,bmba016,bmba032
           FROM s_detail1[1].bmba009,s_detail1[1].bmba003,s_detail1[1].bmba004,s_detail1[1].bmba007, 
               s_detail1[1].bmba008,s_detail1[1].bmba005,s_detail1[1].bmba006,s_detail1[1].bmba011,s_detail1[1].bmba012, 
               s_detail1[1].bmba010,s_detail1[1].bmba021,s_detail1[1].bmba022,s_detail1[1].bmba023,s_detail1[1].bmba024, 
               s_detail1[1].bmba030,s_detail1[1].bmba031,s_detail1[1].bmba015,s_detail1[1].bmba016,s_detail1[1].bmba032 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba009
            #add-point:BEFORE FIELD bmba009 name="construct.b.page1.bmba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba009
            
            #add-point:AFTER FIELD bmba009 name="construct.a.page1.bmba009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba009
            #add-point:ON ACTION controlp INFIELD bmba009 name="construct.c.page1.bmba009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bmba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba003
            #add-point:ON ACTION controlp INFIELD bmba003 name="construct.c.page1.bmba003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba003  #顯示到畫面上

            NEXT FIELD bmba003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba003
            #add-point:BEFORE FIELD bmba003 name="construct.b.page1.bmba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba003
            
            #add-point:AFTER FIELD bmba003 name="construct.a.page1.bmba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba004
            #add-point:ON ACTION controlp INFIELD bmba004 name="construct.c.page1.bmba004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			 LET g_qryparam.arg1 = "215" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba004  #顯示到畫面上

            NEXT FIELD bmba004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba004
            #add-point:BEFORE FIELD bmba004 name="construct.b.page1.bmba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba004
            
            #add-point:AFTER FIELD bmba004 name="construct.a.page1.bmba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba007
            #add-point:ON ACTION controlp INFIELD bmba007 name="construct.c.page1.bmba007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			 LET g_qryparam.arg1 = "221" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba007  #顯示到畫面上

            NEXT FIELD bmba007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba007
            #add-point:BEFORE FIELD bmba007 name="construct.b.page1.bmba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba007
            
            #add-point:AFTER FIELD bmba007 name="construct.a.page1.bmba007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba008
            #add-point:BEFORE FIELD bmba008 name="construct.b.page1.bmba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba008
            
            #add-point:AFTER FIELD bmba008 name="construct.a.page1.bmba008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba008
            #add-point:ON ACTION controlp INFIELD bmba008 name="construct.c.page1.bmba008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba005
            #add-point:BEFORE FIELD bmba005 name="construct.b.page1.bmba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba005
            
            #add-point:AFTER FIELD bmba005 name="construct.a.page1.bmba005"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba005
            #add-point:ON ACTION controlp INFIELD bmba005 name="construct.c.page1.bmba005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba006
            #add-point:BEFORE FIELD bmba006 name="construct.b.page1.bmba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba006
            
            #add-point:AFTER FIELD bmba006 name="construct.a.page1.bmba006"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba006
            #add-point:ON ACTION controlp INFIELD bmba006 name="construct.c.page1.bmba006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba011
            #add-point:BEFORE FIELD bmba011 name="construct.b.page1.bmba011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba011
            
            #add-point:AFTER FIELD bmba011 name="construct.a.page1.bmba011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba011
            #add-point:ON ACTION controlp INFIELD bmba011 name="construct.c.page1.bmba011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba012
            #add-point:BEFORE FIELD bmba012 name="construct.b.page1.bmba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba012
            
            #add-point:AFTER FIELD bmba012 name="construct.a.page1.bmba012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba012
            #add-point:ON ACTION controlp INFIELD bmba012 name="construct.c.page1.bmba012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bmba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba010
            #add-point:ON ACTION controlp INFIELD bmba010 name="construct.c.page1.bmba010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba010  #顯示到畫面上

            NEXT FIELD bmba010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba010
            #add-point:BEFORE FIELD bmba010 name="construct.b.page1.bmba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba010
            
            #add-point:AFTER FIELD bmba010 name="construct.a.page1.bmba010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba021
            #add-point:BEFORE FIELD bmba021 name="construct.b.page1.bmba021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba021
            
            #add-point:AFTER FIELD bmba021 name="construct.a.page1.bmba021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba021
            #add-point:ON ACTION controlp INFIELD bmba021 name="construct.c.page1.bmba021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba022
            #add-point:BEFORE FIELD bmba022 name="construct.b.page1.bmba022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba022
            
            #add-point:AFTER FIELD bmba022 name="construct.a.page1.bmba022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba022
            #add-point:ON ACTION controlp INFIELD bmba022 name="construct.c.page1.bmba022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba023
            #add-point:BEFORE FIELD bmba023 name="construct.b.page1.bmba023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba023
            
            #add-point:AFTER FIELD bmba023 name="construct.a.page1.bmba023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba023
            #add-point:ON ACTION controlp INFIELD bmba023 name="construct.c.page1.bmba023"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bmba024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba024
            #add-point:ON ACTION controlp INFIELD bmba024 name="construct.c.page1.bmba024"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmea008_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmba024  #顯示到畫面上

            NEXT FIELD bmba024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba024
            #add-point:BEFORE FIELD bmba024 name="construct.b.page1.bmba024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba024
            
            #add-point:AFTER FIELD bmba024 name="construct.a.page1.bmba024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba030
            #add-point:BEFORE FIELD bmba030 name="construct.b.page1.bmba030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba030
            
            #add-point:AFTER FIELD bmba030 name="construct.a.page1.bmba030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba030
            #add-point:ON ACTION controlp INFIELD bmba030 name="construct.c.page1.bmba030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba031
            #add-point:BEFORE FIELD bmba031 name="construct.b.page1.bmba031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba031
            
            #add-point:AFTER FIELD bmba031 name="construct.a.page1.bmba031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba031
            #add-point:ON ACTION controlp INFIELD bmba031 name="construct.c.page1.bmba031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bmba015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba015
            #add-point:ON ACTION controlp INFIELD bmba015 name="construct.c.page1.bmba015"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			IF g_site = 'ALL' THEN
			   CALL q_inaa001_5()         #所有營運據點呼叫開窗
			ELSE   
               CALL q_inaa001_2()         #當前營運據點呼叫開窗
            END IF   
            DISPLAY g_qryparam.return1 TO bmba015  #顯示到畫面上

            NEXT FIELD bmba015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba015
            #add-point:BEFORE FIELD bmba015 name="construct.b.page1.bmba015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba015
            
            #add-point:AFTER FIELD bmba015 name="construct.a.page1.bmba015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba016
            #add-point:ON ACTION controlp INFIELD bmba016 name="construct.c.page1.bmba016"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN 
               CALL q_inab002_7()      #所有營運據點呼叫開窗  
            ELSE
               CALL q_inab002_1()      #當前營運據點呼叫開窗
            END IF                              
            DISPLAY g_qryparam.return1 TO bmba016  #顯示到畫面上

            NEXT FIELD bmba016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba016
            #add-point:BEFORE FIELD bmba016 name="construct.b.page1.bmba016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba016
            
            #add-point:AFTER FIELD bmba016 name="construct.a.page1.bmba016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba032
            #add-point:BEFORE FIELD bmba032 name="construct.b.page1.bmba032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba032
            
            #add-point:AFTER FIELD bmba032 name="construct.a.page1.bmba032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bmba032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba032
            #add-point:ON ACTION controlp INFIELD bmba032 name="construct.c.page1.bmba032"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      CONSTRUCT BY NAME l_wc1 ON imaa009,imaa010
         BEFORE CONSTRUCT
            CALL cl_qbe_init()

         ON ACTION controlp INFIELD imaa009
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE  
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009	
            
         ON ACTION controlp INFIELD imaa010
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa010  #顯示到畫面上
            NEXT FIELD imaa010 
       END CONSTRUCT 
       
      INPUT g_bmaa_l_date FROM l_date
   
         BEFORE INPUT            
            LET g_bmaa_l_date = cl_get_current()
            
         AFTER INPUT
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               RETURN
            END IF
            LET g_bmaa_l_date = DATE(g_bmaa_l_date) USING 'YYYY-MM-DD'
            LET g_bmaa_t_l_date = g_bmaa_l_date 
   
       END INPUT 
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_bmaa_l_date = cl_get_current()
         LET g_bmaa_t_l_date = g_bmaa_l_date       
         #end add-point  
 
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
 
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
   
   #組合g_wc2
   LET g_wc2 = g_wc_table1
 
 
   #add-point:cs段after_construct name="cs.after_construct"
   IF NOT cl_null(l_wc1) THEN 
      LET g_wc = g_wc ," AND ",l_wc1
   END IF
   #end add-point
   
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abmm204_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_bmba_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count   
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   #add-point:query段before constrcut name="query.before_constrcut"
   
   #end add-point
   
   CALL abmm204_construct()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_bmaa_m.* TO NULL
      LET g_wc = " 1=1"
      LET g_wc2 = " 1=1"
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      RETURN
   END IF
   
   LET g_error_show = 1
   CALL abmm204_browser_fill()
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   ELSE
      CALL abmm204_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abmm204_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_bmaastus  LIKE bmaa_t.bmaastus    #161216-00029#5 add   
   #end add-point
  
   #add-point:Function前置處理  name="fetch.before_fetch"
   INITIALIZE g_bmaa_m.* TO NULL
   LET g_bmaa_l_date = ''
   DISPLAY BY NAME g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003,g_bmaa_m.imaa009,g_bmaa_m.imaa009_desc,g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.imaa010_desc,g_bmaa_l_date,g_bmaa_m.bmaa004
   DISPLAY g_bmaa_l_date TO FORMONLY.l_date 
   CALL g_bmba_d.clear()   
   LET g_browser[g_current_idx].b_bmaa001 = g_browser[g_current_idx].b_show
   
   SELECT COUNT(bmba003) INTO l_n FROM bmba_t
    WHERE bmba001 = g_browser[g_current_idx].b_bmaa001 
      AND bmba002 = g_browser[g_current_idx].b_bmaa002
      AND bmbaent = g_enterprise 
      AND bmbasite = g_site
    
   IF l_n  = 0 THEN 
      SELECT UNIQUE bmaasite,bmaa001,bmaa002,bmaa004
        INTO g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.bmaa004
        FROM bmaa_t
        WHERE bmaaent = g_enterprise 
          AND bmaasite = g_browser[g_current_idx].b_bmaasite 
          AND bmaa001 = g_browser[g_current_idx].b_bmaa001 
          AND bmaa002 = g_browser[g_current_idx].b_bmaa002 
      LET  g_bmaa_l_date = g_bmaa_t_l_date    
      CALL abmm204_show()
      RETURN
   END IF 
   #end add-point  
   
   DISPLAY g_current_idx TO FORMONLY.h_count   
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
   
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
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
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
 
   #CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
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
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_bmaa_m.bmaasite = g_browser[g_current_idx].b_bmaasite
   LET g_bmaa_m.bmaa001 = g_browser[g_current_idx].b_bmaa001
   LET g_bmaa_m.bmaa002 = g_browser[g_current_idx].b_bmaa002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abmm204_master_referesh USING g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002 INTO g_bmaa_m.bmaasite, 
       g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.bmaa004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bmaa_t:",SQLERRMESSAGE  
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_bmaa_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制 name="fetch.action_control"
   LET  g_bmaa_l_date = g_bmaa_t_l_date
   CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)    #161216-00029#5 add  
   #161216-00029#5 add(s)
   SELECT bmaastus INTO l_bmaastus FROM bmaa_t 
    WHERE bmaaent = g_enterprise
      AND bmaasite = g_site
      AND bmaa001 = g_bmaa_m.bmaa001
      AND bmaa002 = g_bmaa_m.bmaa002
   IF l_bmaastus = 'VO' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete",FALSE)
   END IF
   #161216-00029#5 add(e)
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_bmaa_m_t.* = g_bmaa_m.*
   LET g_bmaa_m_o.* = g_bmaa_m.*
   
   #重新顯示   
   CALL abmm204_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.insert" >}
#+ 資料新增
PRIVATE FUNCTION abmm204_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM                    #清畫面欄位內容
   CALL g_bmba_d.clear()    #清除陣列
 
 
   INITIALIZE g_bmaa_m.* LIKE bmaa_t.*             #DEFAULT 設定
   LET g_bmaasite_t = NULL
   LET g_bmaa001_t = NULL
   LET g_bmaa002_t = NULL
 
   
   CALL s_transaction_begin()
               
   WHILE TRUE
      #公用欄位給值
      
 
      #append欄位給值
      
     
      #單頭預設值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
     
      CALL abmm204_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_bmaa_m.* = g_bmaa_m_t.*
         CALL abmm204_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #CALL g_bmba_d.clear()
 
 
      LET g_rec_b = 0
      EXIT WHILE
        
   END WHILE
   
   #功能已完成,通報訊息中心
   CALL abmm204_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.modify" >}
#+ 資料修改
PRIVATE FUNCTION abmm204_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_bmaa_m.bmaasite IS NULL
   OR g_bmaa_m.bmaa001 IS NULL
   OR g_bmaa_m.bmaa002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE abmm204_master_referesh USING g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002 INTO g_bmaa_m.bmaasite, 
       g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.bmaa004
 
   #檢查是否允許此動作
   IF NOT abmm204_action_chk() THEN
      RETURN
   END IF
  
   LET g_bmaasite_t = g_bmaa_m.bmaasite
   LET g_bmaa001_t = g_bmaa_m.bmaa001
   LET g_bmaa002_t = g_bmaa_m.bmaa002
 
   CALL s_transaction_begin()
   
   OPEN abmm204_cl USING g_enterprise,g_bmaa_m.bmaasite
                                                       ,g_bmaa_m.bmaa001
                                                       ,g_bmaa_m.bmaa002
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmm204_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE abmm204_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH abmm204_cl INTO g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003,g_bmaa_m.imaa009, 
       g_bmaa_m.imaa009_desc,g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.imaa010_desc,g_bmaa_m.bmaa004 
 
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_bmaa_m.bmaasite,":",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE abmm204_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   CALL abmm204_show()
   WHILE TRUE
      LET g_bmaasite_t = g_bmaa_m.bmaasite
      LET g_bmaa001_t = g_bmaa_m.bmaa001
      LET g_bmaa002_t = g_bmaa_m.bmaa002
 
      
      #寫入修改者/修改日期資訊
      
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abmm204_input("u")     #欄位更改
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_bmaa_m.* = g_bmaa_m_t.*
         CALL abmm204_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若有modid跟moddt則進行update
 
      
      #若單頭key欄位有變更
      IF g_bmaa_m.bmaasite != g_bmaasite_t 
      OR g_bmaa_m.bmaa001 != g_bmaa001_t 
      OR g_bmaa_m.bmaa002 != g_bmaa002_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bmba_t SET bmbasite = g_bmaa_m.bmaasite
                                      ,bmba001 = g_bmaa_m.bmaa001
                                      ,bmba002 = g_bmaa_m.bmaa002
 
          WHERE bmbaent = g_enterprise AND bmbasite = g_bmaasite_t
            AND bmba001 = g_bmaa001_t
            AND bmba002 = g_bmaa002_t
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmba_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmba_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
      
      EXIT WHILE
   END WHILE
 
   CLOSE abmm204_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abmm204_msgcentre_notify('modify')
 
END FUNCTION   
 
{</section>}
 
{<section id="abmm204.input" >}
#+ 資料輸入
PRIVATE FUNCTION abmm204_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd_t         LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n             LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt           LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否  
   DEFINE  l_count         LIKE type_t.num10
   DEFINE  l_i             LIKE type_t.num10
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_imae021        LIKE imae_t.imae021
   DEFINE l_imae091        LIKE imae_t.imae091
   DEFINE l_cnt1           LIKE type_t.num5
   DEFINE l_cnt2           LIKE type_t.num5   
   DEFINE l_bmba004        LIKE bmba_t.bmba004
   DEFINE l_bmba007        LIKE bmba_t.bmba007
   DEFINE l_bmba008        LIKE bmba_t.bmba008
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003,g_bmaa_m.imaa009, 
       g_bmaa_m.imaa009_desc,g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.imaa010_desc,g_bmaa_m.bmaa004 
 
   
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT bmba009,bmba003,bmba004,bmba007,bmba008,bmba005,bmba006,bmba011,bmba012, 
       bmba010,bmba021,bmba022,bmba023,bmba024,bmba030,bmba031,bmba015,bmba016,bmba032 FROM bmba_t WHERE  
       bmbaent=? AND bmbasite=? AND bmba001=? AND bmba002=? AND bmba003=? AND bmba004=? AND bmba005=?  
       AND bmba007=? AND bmba008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE abmm204_bcl CURSOR FROM g_forupd_sql
   
 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   LET lb_reproduce = FALSE
   
   #控制key欄位可否輸入
   CALL abmm204_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abmm204_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
   
   DISPLAY BY NAME g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003,g_bmaa_m.imaa009, 
       g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.bmaa004
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abmm204.input.head" >}
      #單頭段
      INPUT BY NAME g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003,g_bmaa_m.imaa009, 
          g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.bmaa004 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaasite
            #add-point:BEFORE FIELD bmaasite name="input.b.bmaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaasite
            
            #add-point:AFTER FIELD bmaasite name="input.a.bmaasite"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t  OR g_bmaa_m.bmaa001 != g_bmaa001_t  OR g_bmaa_m.bmaa002 != g_bmaa002_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmaa_t WHERE "||"bmaaent = '" ||g_enterprise|| "' AND "||"bmaasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmaa001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmaa002 = '"||g_bmaa_m.bmaa002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmaasite
            #add-point:ON CHANGE bmaasite name="input.g.bmaasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa001
            #add-point:BEFORE FIELD bmaa001 name="input.b.bmaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa001
            
            #add-point:AFTER FIELD bmaa001 name="input.a.bmaa001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t  OR g_bmaa_m.bmaa001 != g_bmaa001_t  OR g_bmaa_m.bmaa002 != g_bmaa002_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmaa_t WHERE "||"bmaaent = '" ||g_enterprise|| "' AND "||"bmaasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmaa001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmaa002 = '"||g_bmaa_m.bmaa002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmaa001
            #add-point:ON CHANGE bmaa001 name="input.g.bmaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa002
            #add-point:BEFORE FIELD bmaa002 name="input.b.bmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa002
            
            #add-point:AFTER FIELD bmaa002 name="input.a.bmaa002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t  OR g_bmaa_m.bmaa001 != g_bmaa001_t  OR g_bmaa_m.bmaa002 != g_bmaa002_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmaa_t WHERE "||"bmaaent = '" ||g_enterprise|| "' AND "||"bmaasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmaa001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmaa002 = '"||g_bmaa_m.bmaa002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmaa002
            #add-point:ON CHANGE bmaa002 name="input.g.bmaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="input.b.imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="input.a.imaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal003
            #add-point:ON CHANGE imaal003 name="input.g.imaal003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="input.a.imaa009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmaa_m.imaa009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmaa_m.imaa009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmaa_m.imaa009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="input.b.imaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa009
            #add-point:ON CHANGE imaa009 name="input.g.imaa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="input.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="input.a.imaal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal004
            #add-point:ON CHANGE imaal004 name="input.g.imaal004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="input.a.imaa010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmaa_m.imaa010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmaa_m.imaa010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmaa_m.imaa010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="input.b.imaa010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa010
            #add-point:ON CHANGE imaa010 name="input.g.imaa010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa004
            #add-point:BEFORE FIELD bmaa004 name="input.b.bmaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa004
            
            #add-point:AFTER FIELD bmaa004 name="input.a.bmaa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmaa004
            #add-point:ON CHANGE bmaa004 name="input.g.bmaa004"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bmaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaasite
            #add-point:ON ACTION controlp INFIELD bmaasite name="input.c.bmaasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa001
            #add-point:ON ACTION controlp INFIELD bmaa001 name="input.c.bmaa001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmaa_m.bmaa001             #給予default值

            #給予arg

            CALL q_imaa001_2()                                #呼叫開窗

            LET g_bmaa_m.bmaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmaa_m.bmaa001 TO bmaa001              #顯示到畫面上

            NEXT FIELD bmaa001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bmaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa002
            #add-point:ON ACTION controlp INFIELD bmaa002 name="input.c.bmaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="input.c.imaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="input.c.imaa009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmaa_m.imaa009             #給予default值

            #給予arg

            CALL q_rtax001()                                #呼叫開窗

            LET g_bmaa_m.imaa009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmaa_m.imaa009 TO imaa009              #顯示到畫面上

            NEXT FIELD imaa009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaal004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="input.c.imaal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="input.c.imaa010"
            
            #END add-point
 
 
         #Ctrlp:input.c.bmaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa004
            #add-point:ON ACTION controlp INFIELD bmaa004 name="input.c.bmaa004"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bmaa_m.bmaasite             
                            ,g_bmaa_m.bmaa001   
                            ,g_bmaa_m.bmaa002   
 
 
            IF p_cmd <> 'u' THEN
               LET l_count = 1  
               
               SELECT COUNT(1) INTO l_count FROM bmaa_t
                WHERE bmaaent = g_enterprise AND bmaasite = g_bmaa_m.bmaasite
                  AND bmaa001 = g_bmaa_m.bmaa001
                  AND bmaa002 = g_bmaa_m.bmaa002
 
               IF l_count = 0 THEN
                  
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
                  
                  INSERT INTO bmaa_t (bmaaent,bmaasite,bmaa001,bmaa002,bmaa004)
                  VALUES (g_enterprise,g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.bmaa004)  
 
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "g_bmaa_m:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CONTINUE DIALOG
                  END IF
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
                  
                  IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                     CALL abmm204_detail_reproduce()
                  END IF
                  
                  LET p_cmd = 'u'
 
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =  g_bmaa_m.bmaasite 
                  LET g_errparam.code   = '!' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  NEXT FIELD bmaasite
               END IF 
            ELSE
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               UPDATE bmaa_t SET (bmaasite,bmaa001,bmaa002,bmaa004) = (g_bmaa_m.bmaasite,g_bmaa_m.bmaa001, 
                   g_bmaa_m.bmaa002,g_bmaa_m.bmaa004)
                WHERE bmaaent = g_enterprise AND bmaasite = g_bmaasite_t
                  AND bmaa001 = g_bmaa001_t
                  AND bmaa002 = g_bmaa002_t
 
                  
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmaa_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmaa_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     LET g_log1 = util.JSON.stringify(g_bmaa_m_t)
                     LET g_log2 = util.JSON.stringify(g_bmaa_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
 
            END IF
            LET g_bmaasite_t = g_bmaa_m.bmaasite
            LET g_bmaa001_t = g_bmaa_m.bmaa001
            LET g_bmaa002_t = g_bmaa_m.bmaa002
 
           #controlp
      END INPUT
 
{</section>}
 
{<section id="abmm204.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bmba_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bmba_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abmm204_b_fill()
            LET g_rec_b = g_bmba_d.getLength()
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
 
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN abmm204_cl USING g_enterprise,g_bmaa_m.bmaasite
                                                                ,g_bmaa_m.bmaa001
                                                                ,g_bmaa_m.bmaa002
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abmm204_cl:" 
               LET g_errparam.code   =  STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CLOSE abmm204_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
                   
            #FETCH abmm204_cl INTO g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003, 
            #    g_bmaa_m.imaa009,g_bmaa_m.imaa009_desc,g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.imaa010_desc, 
            #    g_bmaa_m.bmaa004 #鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = g_bmaa_m.bmaasite 
            #   LET g_errparam.code   = SQLCA.sqlcode 
            #   LET g_errparam.popup  = FALSE 
            #   CALL cl_err()
            #   CLOSE abmm204_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_bmba_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bmba_d[l_ac].bmba003 IS NOT NULL
               AND g_bmba_d[l_ac].bmba004 IS NOT NULL 
               AND g_bmba_d[l_ac].bmba005 IS NOT NULL 
               AND g_bmba_d[l_ac].bmba007 IS NOT NULL 
               AND g_bmba_d[l_ac].bmba008 IS NOT NULL 
 
            THEN
               LET l_cmd='u'
               LET g_bmba_d_t.* = g_bmba_d[l_ac].*  #BACKUP
               LET g_bmba_d_o.* = g_bmba_d[l_ac].*  #BACKUP
               CALL abmm204_set_entry_b(l_cmd)
               CALL abmm204_set_no_entry_b(l_cmd)
               IF NOT abmm204_lock_b("bmba_t",'1') THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abmm204_bcl INTO g_bmba_d[l_ac].bmba009,g_bmba_d[l_ac].bmba003,g_bmba_d[l_ac].bmba004, 
                      g_bmba_d[l_ac].bmba007,g_bmba_d[l_ac].bmba008,g_bmba_d[l_ac].bmba005,g_bmba_d[l_ac].bmba006, 
                      g_bmba_d[l_ac].bmba011,g_bmba_d[l_ac].bmba012,g_bmba_d[l_ac].bmba010,g_bmba_d[l_ac].bmba021, 
                      g_bmba_d[l_ac].bmba022,g_bmba_d[l_ac].bmba023,g_bmba_d[l_ac].bmba024,g_bmba_d[l_ac].bmba030, 
                      g_bmba_d[l_ac].bmba031,g_bmba_d[l_ac].bmba015,g_bmba_d[l_ac].bmba016,g_bmba_d[l_ac].bmba032 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bmba_d_t.bmba003,":",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL abmm204_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
   
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bmba_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
                  LET g_bmba_d[l_ac].bmba022 = "N"
      LET g_bmba_d[l_ac].bmba023 = "0"
      LET g_bmba_d[l_ac].bmba031 = "N"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_bmba_d_t.* = g_bmba_d[l_ac].*     #新輸入資料
            LET g_bmba_d_o.* = g_bmba_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abmm204_set_entry_b(l_cmd)
            CALL abmm204_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bmba_d[li_reproduce_target].* = g_bmba_d[li_reproduce].*
 
               LET g_bmba_d[g_bmba_d.getLength()].bmba003 = NULL
               LET g_bmba_d[g_bmba_d.getLength()].bmba004 = NULL
               LET g_bmba_d[g_bmba_d.getLength()].bmba005 = NULL
               LET g_bmba_d[g_bmba_d.getLength()].bmba007 = NULL
               LET g_bmba_d[g_bmba_d.getLength()].bmba008 = NULL
 
            END IF
            #add-point:modify段before insert name="input.body.before_insert"
            #工单展开选项
            SELECT imae021,imae091 INTO l_imae021,l_imae091 FROM imae_t 
             WHERE imaeent = g_enterprise
               AND imaesite = g_site
               AND imae001 = g_bmba_d[l_ac].bmba003 
            IF cl_null(l_imae021) THEN 
               LET l_imae021 = '1'
            END IF  
            IF cl_null(l_imae091) THEN 
               LET l_imae091 = 'N'
            END IF   
            LET g_bmba_d[l_ac].bmba021 = l_imae021 
            LET g_bmba_d[l_ac].bmba030 = l_imae091            
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
            SELECT COUNT(1) INTO l_count FROM bmba_t 
             WHERE bmbaent = g_enterprise AND bmbasite = g_bmaa_m.bmaasite
               AND bmba001 = g_bmaa_m.bmaa001
               AND bmba002 = g_bmaa_m.bmaa002
 
               AND g_bmba_d[l_ac].bmba003 = bmba003
               AND g_bmba_d[l_ac].bmba004 = bmba004
               AND g_bmba_d[l_ac].bmba005 = bmba005
               AND g_bmba_d[l_ac].bmba007 = bmba007
               AND g_bmba_d[l_ac].bmba008 = bmba008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmaa_m.bmaasite
               LET gs_keys[2] = g_bmaa_m.bmaa001
               LET gs_keys[3] = g_bmaa_m.bmaa002
               LET gs_keys[4] = g_bmba_d[g_detail_idx].bmba003
               LET gs_keys[5] = g_bmba_d[g_detail_idx].bmba004
               LET gs_keys[6] = g_bmba_d[g_detail_idx].bmba005
               LET gs_keys[7] = g_bmba_d[g_detail_idx].bmba007
               LET gs_keys[8] = g_bmba_d[g_detail_idx].bmba008
               CALL abmm204_insert_b('bmba_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_bmba_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bmba_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abmm204_b_fill()
               #資料多語言用-增/改
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ##ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point  
               
               DELETE FROM bmba_t
                WHERE bmbaent = g_enterprise AND bmbasite = g_bmaa_m.bmaasite AND
                                          bmba001 = g_bmaa_m.bmaa001 AND
                                          bmba002 = g_bmaa_m.bmaa002 AND
 
                      bmba003 = g_bmba_d_t.bmba003
                  AND bmba004 = g_bmba_d_t.bmba004
                  AND bmba005 = g_bmba_d_t.bmba005
                  AND bmba007 = g_bmba_d_t.bmba007
                  AND bmba008 = g_bmba_d_t.bmba008
 
                  
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bmba_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE abmm204_bcl
               LET l_count = g_bmba_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmaa_m.bmaasite
               LET gs_keys[2] = g_bmaa_m.bmaa001
               LET gs_keys[3] = g_bmaa_m.bmaa002
               LET gs_keys[4] = g_bmba_d_t.bmba003
               LET gs_keys[5] = g_bmba_d_t.bmba004
               LET gs_keys[6] = g_bmba_d_t.bmba005
               LET gs_keys[7] = g_bmba_d_t.bmba007
               LET gs_keys[8] = g_bmba_d_t.bmba008
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL abmm204_delete_b('bmba_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_bmba_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba009
            #add-point:BEFORE FIELD bmba009 name="input.b.page1.bmba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba009
            
            #add-point:AFTER FIELD bmba009 name="input.a.page1.bmba009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba009
            #add-point:ON CHANGE bmba009 name="input.g.page1.bmba009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba003
            
            #add-point:AFTER FIELD bmba003 name="input.a.page1.bmba003"
            IF g_bmba_d[l_ac].bmba003 = g_bmaa_m.bmaa001 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'tree-004'
               LET g_errparam.extend = g_bmba_d[l_ac].bmba003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD bmba003
            ELSE 
               IF NOT ap_chk_isExist(g_bmba_d[l_ac].bmba003,"SELECT COUNT(*) FROM bmaa_t WHERE bmaaent = '"||g_enterprise||"' AND bmaa001 = ? ",'tree-003',1)  THEN #160905-00007#1 add
                  NEXT FIELD bmba003
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba003
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmba_d[l_ac].bmba003_desc = '', g_rtn_fields[1] , ''
            LET g_bmba_d[l_ac].bmba003_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_bmba_d[l_ac].bmba003_desc
            DISPLAY BY NAME g_bmba_d[l_ac].bmba003_desc_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba003) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba004) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba005) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba007) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba008) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t OR g_bmaa_m.bmaa001 != g_bmaa001_t OR g_bmaa_m.bmaa002 != g_bmaa002_t OR g_bmba_d[g_detail_idx].bmba003 != g_bmba_d_t.bmba003 OR g_bmba_d[g_detail_idx].bmba004 != g_bmba_d_t.bmba004 OR g_bmba_d[g_detail_idx].bmba005 != g_bmba_d_t.bmba005 OR g_bmba_d[g_detail_idx].bmba007 != g_bmba_d_t.bmba007 OR g_bmba_d[g_detail_idx].bmba008 != g_bmba_d_t.bmba008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND "||"bmbasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmba001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmba002 = '"||g_bmaa_m.bmaa002 ||"' AND "|| "bmba003 = '"||g_bmba_d[g_detail_idx].bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_d[g_detail_idx].bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_d[g_detail_idx].bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_d[g_detail_idx].bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_d[g_detail_idx].bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba003
            #add-point:BEFORE FIELD bmba003 name="input.b.page1.bmba003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba003
            #add-point:ON CHANGE bmba003 name="input.g.page1.bmba003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba004
            
            #add-point:AFTER FIELD bmba004 name="input.a.page1.bmba004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='215' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmba_d[l_ac].bmba004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmba_d[l_ac].bmba004_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba003) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba004) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba005) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba007) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba008) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t OR g_bmaa_m.bmaa001 != g_bmaa001_t OR g_bmaa_m.bmaa002 != g_bmaa002_t OR g_bmba_d[g_detail_idx].bmba003 != g_bmba_d_t.bmba003 OR g_bmba_d[g_detail_idx].bmba004 != g_bmba_d_t.bmba004 OR g_bmba_d[g_detail_idx].bmba005 != g_bmba_d_t.bmba005 OR g_bmba_d[g_detail_idx].bmba007 != g_bmba_d_t.bmba007 OR g_bmba_d[g_detail_idx].bmba008 != g_bmba_d_t.bmba008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND "||"bmbasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmba001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmba002 = '"||g_bmaa_m.bmaa002 ||"' AND "|| "bmba003 = '"||g_bmba_d[g_detail_idx].bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_d[g_detail_idx].bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_d[g_detail_idx].bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_d[g_detail_idx].bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_d[g_detail_idx].bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba004
            #add-point:BEFORE FIELD bmba004 name="input.b.page1.bmba004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba004
            #add-point:ON CHANGE bmba004 name="input.g.page1.bmba004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba007
            
            #add-point:AFTER FIELD bmba007 name="input.a.page1.bmba007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bmba_d[l_ac].bmba007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bmba_d[l_ac].bmba007_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba003) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba004) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba005) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba007) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba008) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t OR g_bmaa_m.bmaa001 != g_bmaa001_t OR g_bmaa_m.bmaa002 != g_bmaa002_t OR g_bmba_d[g_detail_idx].bmba003 != g_bmba_d_t.bmba003 OR g_bmba_d[g_detail_idx].bmba004 != g_bmba_d_t.bmba004 OR g_bmba_d[g_detail_idx].bmba005 != g_bmba_d_t.bmba005 OR g_bmba_d[g_detail_idx].bmba007 != g_bmba_d_t.bmba007 OR g_bmba_d[g_detail_idx].bmba008 != g_bmba_d_t.bmba008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND "||"bmbasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmba001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmba002 = '"||g_bmaa_m.bmaa002 ||"' AND "|| "bmba003 = '"||g_bmba_d[g_detail_idx].bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_d[g_detail_idx].bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_d[g_detail_idx].bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_d[g_detail_idx].bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_d[g_detail_idx].bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba007
            #add-point:BEFORE FIELD bmba007 name="input.b.page1.bmba007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba007
            #add-point:ON CHANGE bmba007 name="input.g.page1.bmba007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba008
            #add-point:BEFORE FIELD bmba008 name="input.b.page1.bmba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba008
            
            #add-point:AFTER FIELD bmba008 name="input.a.page1.bmba008"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba003) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba004) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba005) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba007) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba008) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t OR g_bmaa_m.bmaa001 != g_bmaa001_t OR g_bmaa_m.bmaa002 != g_bmaa002_t OR g_bmba_d[g_detail_idx].bmba003 != g_bmba_d_t.bmba003 OR g_bmba_d[g_detail_idx].bmba004 != g_bmba_d_t.bmba004 OR g_bmba_d[g_detail_idx].bmba005 != g_bmba_d_t.bmba005 OR g_bmba_d[g_detail_idx].bmba007 != g_bmba_d_t.bmba007 OR g_bmba_d[g_detail_idx].bmba008 != g_bmba_d_t.bmba008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND "||"bmbasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmba001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmba002 = '"||g_bmaa_m.bmaa002 ||"' AND "|| "bmba003 = '"||g_bmba_d[g_detail_idx].bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_d[g_detail_idx].bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_d[g_detail_idx].bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_d[g_detail_idx].bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_d[g_detail_idx].bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba008
            #add-point:ON CHANGE bmba008 name="input.g.page1.bmba008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba005
            #add-point:BEFORE FIELD bmba005 name="input.b.page1.bmba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba005
            
            #add-point:AFTER FIELD bmba005 name="input.a.page1.bmba005"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_bmaa_m.bmaasite) AND NOT cl_null(g_bmaa_m.bmaa001) AND NOT cl_null(g_bmaa_m.bmaa002) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba003) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba004) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba005) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba007) AND NOT cl_null(g_bmba_d[g_detail_idx].bmba008) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_bmaa_m.bmaasite != g_bmaasite_t OR g_bmaa_m.bmaa001 != g_bmaa001_t OR g_bmaa_m.bmaa002 != g_bmaa002_t OR g_bmba_d[g_detail_idx].bmba003 != g_bmba_d_t.bmba003 OR g_bmba_d[g_detail_idx].bmba004 != g_bmba_d_t.bmba004 OR g_bmba_d[g_detail_idx].bmba005 != g_bmba_d_t.bmba005 OR g_bmba_d[g_detail_idx].bmba007 != g_bmba_d_t.bmba007 OR g_bmba_d[g_detail_idx].bmba008 != g_bmba_d_t.bmba008))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bmba_t WHERE "||"bmbaent = '" ||g_enterprise|| "' AND "||"bmbasite = '"||g_bmaa_m.bmaasite ||"' AND "|| "bmba001 = '"||g_bmaa_m.bmaa001 ||"' AND "|| "bmba002 = '"||g_bmaa_m.bmaa002 ||"' AND "|| "bmba003 = '"||g_bmba_d[g_detail_idx].bmba003 ||"' AND "|| "bmba004 = '"||g_bmba_d[g_detail_idx].bmba004 ||"' AND "|| "bmba005 = '"||g_bmba_d[g_detail_idx].bmba005 ||"' AND "|| "bmba007 = '"||g_bmba_d[g_detail_idx].bmba007 ||"' AND "|| "bmba008 = '"||g_bmba_d[g_detail_idx].bmba008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba005
            #add-point:ON CHANGE bmba005 name="input.g.page1.bmba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba006
            #add-point:BEFORE FIELD bmba006 name="input.b.page1.bmba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba006
            
            #add-point:AFTER FIELD bmba006 name="input.a.page1.bmba006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba006
            #add-point:ON CHANGE bmba006 name="input.g.page1.bmba006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba011
            #add-point:BEFORE FIELD bmba011 name="input.b.page1.bmba011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba011
            
            #add-point:AFTER FIELD bmba011 name="input.a.page1.bmba011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba011
            #add-point:ON CHANGE bmba011 name="input.g.page1.bmba011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba012
            #add-point:BEFORE FIELD bmba012 name="input.b.page1.bmba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba012
            
            #add-point:AFTER FIELD bmba012 name="input.a.page1.bmba012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba012
            #add-point:ON CHANGE bmba012 name="input.g.page1.bmba012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba010
            #add-point:BEFORE FIELD bmba010 name="input.b.page1.bmba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba010
            
            #add-point:AFTER FIELD bmba010 name="input.a.page1.bmba010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba010
            #add-point:ON CHANGE bmba010 name="input.g.page1.bmba010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba021
            #add-point:BEFORE FIELD bmba021 name="input.b.page1.bmba021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba021
            
            #add-point:AFTER FIELD bmba021 name="input.a.page1.bmba021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba021
            #add-point:ON CHANGE bmba021 name="input.g.page1.bmba021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba022
            #add-point:BEFORE FIELD bmba022 name="input.b.page1.bmba022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba022
            
            #add-point:AFTER FIELD bmba022 name="input.a.page1.bmba022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba022
            #add-point:ON CHANGE bmba022 name="input.g.page1.bmba022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba023
            #add-point:BEFORE FIELD bmba023 name="input.b.page1.bmba023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba023
            
            #add-point:AFTER FIELD bmba023 name="input.a.page1.bmba023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba023
            #add-point:ON CHANGE bmba023 name="input.g.page1.bmba023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba024
            
            #add-point:AFTER FIELD bmba024 name="input.a.page1.bmba024"
            IF NOT cl_null(g_bmba_d[l_ac].bmba024) THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_bmba_d[l_ac].bmba024
               CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_bmba_d[l_ac].bmba024_desc = '', g_rtn_fields[1] , ''
               LET g_bmba_d[l_ac].bmba024_desc_desc = '', g_rtn_fields[2] , ''
               DISPLAY BY NAME g_bmba_d[l_ac].bmba024_desc,g_bmba_d[l_ac].bmba024_desc
           
               #如果主件不是ALL，那么判断时候需要依据所有的关键字，
               #如果主件是ALL的话，所有关键字都可以忽略，只需要判断元件就ok
               IF cl_null(g_bmba_d[l_ac].bmba004) THEN
                  LET l_bmba004 = ' '
               ELSE
                  LET l_bmba004 = g_bmba_d[l_ac].bmba004
               END IF
               IF cl_null(g_bmba_d[l_ac].bmba007) THEN
                  LET l_bmba007 = ' '
               ELSE
                  LET l_bmba007 = g_bmba_d[l_ac].bmba007
               END IF
               IF cl_null(g_bmba_d[l_ac].bmba008) THEN
                  LET l_bmba008 = ' '
               ELSE
                  LET l_bmba008 = g_bmba_d[l_ac].bmba008
               END IF
               SELECT COUNT(*) INTO l_cnt1 FROM bmea_t
                WHERE bmeaent = g_enterprise
                  AND bmeasite= g_bmaa_m.bmaasite
                  AND bmea001 = g_bmaa_m.bmaa001         #主件
                  AND bmea002 = g_bmaa_m.bmaa002
                  AND bmea003 = g_bmba_d[l_ac].bmba003  #元件编号
                  AND bmea004 = l_bmba004                #部位
                  AND bmea005 = l_bmba007                #作业
                  AND bmea006 = l_bmba008                #制程序
                  AND bmea008 = g_bmba_d[l_ac].bmba024  #替代料
               SELECT COUNT(*) INTO l_cnt2 FROM bmea_t
                WHERE bmeaent = g_enterprise
                  AND bmeasite= g_bmaa_m.bmaasite
                  AND bmea001 = 'ALL'                    #主件
                  AND bmea003 = g_bmba_d[l_ac].bmba003  #元件编号
                  AND bmea008 = g_bmba_d[l_ac].bmba024  #替代料
                  
               IF l_cnt1 = 0 AND l_cnt2 = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00043'
                  LET g_errparam.extend = g_bmba_d[l_ac].bmba024
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bmba_d[l_ac].bmba024 = g_bmba_d_t.bmba024
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_bmba_d[l_ac].bmba024
                  CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_bmba_d[l_ac].bmba024_desc = '', g_rtn_fields[1] , ''
                  LET g_bmba_d[l_ac].bmba024_desc_desc = '', g_rtn_fields[2] , ''
                  DISPLAY BY NAME g_bmba_d[l_ac].bmba024_desc,g_bmba_d[l_ac].bmba024_desc                 
                  NEXT FIELD CURRENT
               END IF
            END IF    

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba024
            #add-point:BEFORE FIELD bmba024 name="input.b.page1.bmba024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba024
            #add-point:ON CHANGE bmba024 name="input.g.page1.bmba024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba030
            #add-point:BEFORE FIELD bmba030 name="input.b.page1.bmba030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba030
            
            #add-point:AFTER FIELD bmba030 name="input.a.page1.bmba030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba030
            #add-point:ON CHANGE bmba030 name="input.g.page1.bmba030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba031
            #add-point:BEFORE FIELD bmba031 name="input.b.page1.bmba031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba031
            
            #add-point:AFTER FIELD bmba031 name="input.a.page1.bmba031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba031
            #add-point:ON CHANGE bmba031 name="input.g.page1.bmba031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba015
            
            #add-point:AFTER FIELD bmba015 name="input.a.page1.bmba015"
            CALL abmm204_bmba015_desc()            
            IF NOT cl_null(g_bmba_d[l_ac].bmba015) THEN
               IF g_site = 'ALL' THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bmba_d[l_ac].bmba015
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inaa001_3") THEN
                     LET g_bmba_d[l_ac].bmba015 = g_bmba_d_t.bmba015
                     CALL abmm204_bmba015_desc()
                     NEXT FIELD bmba015 
                  END IF
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  #LET g_chkparam.arg1 = g_bmba_d[l_ac].bmba015    #160426-00020#1  --- mark
                  #LET g_chkparam.arg2 = g_site                    #160426-00020#1  --- mark
                  LET g_chkparam.arg1 = g_site                     #160426-00020#1  --- add
                  LET g_chkparam.arg2 = g_bmba_d[l_ac].bmba015     #160426-00020#1  --- add
                  IF NOT cl_chk_exist("v_inaa001_1") THEN
                     LET g_bmba_d[l_ac].bmba015 = g_bmba_d_t.bmba015
                     CALL abmm204_bmba015_desc()
                     NEXT FIELD bmba015 
                  END IF
               END IF 
            END IF               
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba015
            #add-point:BEFORE FIELD bmba015 name="input.b.page1.bmba015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba015
            #add-point:ON CHANGE bmba015 name="input.g.page1.bmba015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba016
            
            #add-point:AFTER FIELD bmba016 name="input.a.page1.bmba016"
            CALL abmm204_bmba015_desc()
            IF NOT cl_null (g_bmba_d[l_ac].bmba016)  THEN
               IF g_site = 'ALL' THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bmba_d[l_ac].bmba015
                  LET g_chkparam.arg2 = g_bmba_d[l_ac].bmba016
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#18  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002_2") THEN
                     LET g_bmba_d[l_ac].bmba016 = g_bmba_d_t.bmba016
                     CALL abmm204_bmba015_desc()
                     NEXT FIELD bmba016 
                  END IF
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_bmba_d[l_ac].bmba015
                  LET g_chkparam.arg3 = g_bmba_d[l_ac].bmba016
                  IF NOT cl_chk_exist("v_inab002_1") THEN
                     LET g_bmba_d[l_ac].bmba016 = g_bmba_d_t.bmba016
                     CALL abmm204_bmba015_desc()
                     NEXT FIELD bmba016
                  END IF
                END IF                  
            END IF             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba016
            #add-point:BEFORE FIELD bmba016 name="input.b.page1.bmba016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba016
            #add-point:ON CHANGE bmba016 name="input.g.page1.bmba016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmba032
            #add-point:BEFORE FIELD bmba032 name="input.b.page1.bmba032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmba032
            
            #add-point:AFTER FIELD bmba032 name="input.a.page1.bmba032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bmba032
            #add-point:ON CHANGE bmba032 name="input.g.page1.bmba032"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bmba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba009
            #add-point:ON ACTION controlp INFIELD bmba009 name="input.c.page1.bmba009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba003
            #add-point:ON ACTION controlp INFIELD bmba003 name="input.c.page1.bmba003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_d[l_ac].bmba003             #給予default值

            #給予arg

            CALL q_imaa001()                                #呼叫開窗

            LET g_bmba_d[l_ac].bmba003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_d[l_ac].bmba003 TO bmba003              #顯示到畫面上

            NEXT FIELD bmba003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba004
            #add-point:ON ACTION controlp INFIELD bmba004 name="input.c.page1.bmba004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_d[l_ac].bmba004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "215" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_bmba_d[l_ac].bmba004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_d[l_ac].bmba004 TO bmba004              #顯示到畫面上

            NEXT FIELD bmba004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba007
            #add-point:ON ACTION controlp INFIELD bmba007 name="input.c.page1.bmba007"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_d[l_ac].bmba007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "221" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_bmba_d[l_ac].bmba007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_d[l_ac].bmba007 TO bmba007              #顯示到畫面上

            NEXT FIELD bmba007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba008
            #add-point:ON ACTION controlp INFIELD bmba008 name="input.c.page1.bmba008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba005
            #add-point:ON ACTION controlp INFIELD bmba005 name="input.c.page1.bmba005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba006
            #add-point:ON ACTION controlp INFIELD bmba006 name="input.c.page1.bmba006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba011
            #add-point:ON ACTION controlp INFIELD bmba011 name="input.c.page1.bmba011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba012
            #add-point:ON ACTION controlp INFIELD bmba012 name="input.c.page1.bmba012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba010
            #add-point:ON ACTION controlp INFIELD bmba010 name="input.c.page1.bmba010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_d[l_ac].bmba010             #給予default值

            #給予arg

            CALL q_ooca001()                                #呼叫開窗

            LET g_bmba_d[l_ac].bmba010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_d[l_ac].bmba010 TO bmba010              #顯示到畫面上

            NEXT FIELD bmba010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba021
            #add-point:ON ACTION controlp INFIELD bmba021 name="input.c.page1.bmba021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba022
            #add-point:ON ACTION controlp INFIELD bmba022 name="input.c.page1.bmba022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba023
            #add-point:ON ACTION controlp INFIELD bmba023 name="input.c.page1.bmba023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba024
            #add-point:ON ACTION controlp INFIELD bmba024 name="input.c.page1.bmba024"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_d[l_ac].bmba024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_bmaa_m.bmaasite
            LET g_qryparam.arg2 = g_bmaa_m.bmaa001
            LET g_qryparam.arg3 = g_bmaa_m.bmaa002
            LET g_qryparam.arg4 = g_bmba_d[l_ac].bmba003  #元件料號
            LET g_qryparam.arg5 = g_bmba_d[l_ac].bmba004  #部位
            LET g_qryparam.arg6 = g_bmba_d[l_ac].bmba007  #作業
            LET g_qryparam.arg7 = g_bmba_d[l_ac].bmba008  #製程序
            CALL q_bmea008_2()

            LET g_bmba_d[l_ac].bmba024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_d[l_ac].bmba024 TO bmba024              #顯示到畫面上

            NEXT FIELD bmba024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba030
            #add-point:ON ACTION controlp INFIELD bmba030 name="input.c.page1.bmba030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba031
            #add-point:ON ACTION controlp INFIELD bmba031 name="input.c.page1.bmba031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba015
            #add-point:ON ACTION controlp INFIELD bmba015 name="input.c.page1.bmba015"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_d[l_ac].bmba015             #給予default值

            #給予arg

            IF g_site = 'ALL' THEN
			   CALL q_inaa001_5()         #所有營運據點呼叫開窗
			ELSE   
               CALL q_inaa001_2()         #當前營運據點呼叫開窗
            END IF                                 #呼叫開窗

            LET g_bmba_d[l_ac].bmba015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_d[l_ac].bmba015 TO bmba015              #顯示到畫面上

            NEXT FIELD bmba015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba016
            #add-point:ON ACTION controlp INFIELD bmba016 name="input.c.page1.bmba016"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bmba_d[l_ac].bmba016             #給予default值

            #給予arg

             IF g_site = 'ALL' THEN
                LET g_qryparam.arg1 = g_bmba_d[l_ac].bmba015
                CALL q_inab002_4()         #呼叫開窗
             ELSE
                LET g_qryparam.arg1 = g_bmba_d[l_ac].bmba015
                CALL q_inab002_5()         #呼叫開窗
            END IF                             

            LET g_bmba_d[l_ac].bmba016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bmba_d[l_ac].bmba016 TO bmba016              #顯示到畫面上

            NEXT FIELD bmba016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bmba032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmba032
            #add-point:ON ACTION controlp INFIELD bmba032 name="input.c.page1.bmba032"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_bmba_d[l_ac].* = g_bmba_d_t.*
               CLOSE abmm204_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bmba_d[l_ac].bmba003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_bmba_d[l_ac].* = g_bmba_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
      
               UPDATE bmba_t SET (bmbasite,bmba001,bmba002,bmba009,bmba003,bmba004,bmba007,bmba008,bmba005, 
                   bmba006,bmba011,bmba012,bmba010,bmba021,bmba022,bmba023,bmba024,bmba030,bmba031,bmba015, 
                   bmba016,bmba032) = (g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmba_d[l_ac].bmba009, 
                   g_bmba_d[l_ac].bmba003,g_bmba_d[l_ac].bmba004,g_bmba_d[l_ac].bmba007,g_bmba_d[l_ac].bmba008, 
                   g_bmba_d[l_ac].bmba005,g_bmba_d[l_ac].bmba006,g_bmba_d[l_ac].bmba011,g_bmba_d[l_ac].bmba012, 
                   g_bmba_d[l_ac].bmba010,g_bmba_d[l_ac].bmba021,g_bmba_d[l_ac].bmba022,g_bmba_d[l_ac].bmba023, 
                   g_bmba_d[l_ac].bmba024,g_bmba_d[l_ac].bmba030,g_bmba_d[l_ac].bmba031,g_bmba_d[l_ac].bmba015, 
                   g_bmba_d[l_ac].bmba016,g_bmba_d[l_ac].bmba032)
                WHERE bmbaent = g_enterprise AND bmbasite = g_bmaa_m.bmaasite 
                  AND bmba001 = g_bmaa_m.bmaa001 
                  AND bmba002 = g_bmaa_m.bmaa002 
 
                  AND bmba003 = g_bmba_d_t.bmba003 #項次   
                  AND bmba004 = g_bmba_d_t.bmba004  
                  AND bmba005 = g_bmba_d_t.bmba005  
                  AND bmba007 = g_bmba_d_t.bmba007  
                  AND bmba008 = g_bmba_d_t.bmba008  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmba_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bmba_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bmaa_m.bmaasite
               LET gs_keys_bak[1] = g_bmaasite_t
               LET gs_keys[2] = g_bmaa_m.bmaa001
               LET gs_keys_bak[2] = g_bmaa001_t
               LET gs_keys[3] = g_bmaa_m.bmaa002
               LET gs_keys_bak[3] = g_bmaa002_t
               LET gs_keys[4] = g_bmba_d[g_detail_idx].bmba003
               LET gs_keys_bak[4] = g_bmba_d_t.bmba003
               LET gs_keys[5] = g_bmba_d[g_detail_idx].bmba004
               LET gs_keys_bak[5] = g_bmba_d_t.bmba004
               LET gs_keys[6] = g_bmba_d[g_detail_idx].bmba005
               LET gs_keys_bak[6] = g_bmba_d_t.bmba005
               LET gs_keys[7] = g_bmba_d[g_detail_idx].bmba007
               LET gs_keys_bak[7] = g_bmba_d_t.bmba007
               LET gs_keys[8] = g_bmba_d[g_detail_idx].bmba008
               LET gs_keys_bak[8] = g_bmba_d_t.bmba008
               CALL abmm204_update_b('bmba_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_bmaa_m),util.JSON.stringify(g_bmba_d_t)
                     LET g_log2 = util.JSON.stringify(g_bmaa_m),util.JSON.stringify(g_bmba_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL abmm204_unlock_b("bmba_t",'1')
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point   
              
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_bmba_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_bmba_d.getLength()+1
              
      END INPUT
      
 
      
 
      
      #add-point:input段more input name="input.more_input"
      
      #end add-point  
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD bmaasite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bmba009
 
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
   
   CLOSE abmm204_bcl
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abmm204_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point   
   DEFINE l_ac_t    LIKE type_t.num10
   DEFINE l_sql     STRING
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   SELECT imaa009,imaa010 INTO g_bmaa_m.imaa009,g_bmaa_m.imaa010 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_bmaa_m.bmaa001
    DISPLAY g_bmaa_l_date TO FORMONLY.l_date 
   #end add-point
   
   
   
   DISPLAY BY NAME g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003,g_bmaa_m.imaa009, 
       g_bmaa_m.imaa009_desc,g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.imaa010_desc,g_bmaa_m.bmaa004 
 
    
   CALL abmm204_set_pk_array()    
    
   #顯示狀態(stus)圖片
   
 
   IF g_bfill = "Y" THEN
      CALL abmm204_b_fill()                 #單身
   END IF
     
   #帶出公用欄位reference值
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abmm204_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
 
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmaa_m.bmaa001
   CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_bmaa_m.imaal003 = g_rtn_fields[1] 
   LET g_bmaa_m.imaal004 = g_rtn_fields[2] 
   DISPLAY BY NAME g_bmaa_m.imaal003,g_bmaa_m.imaal004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmaa_m.imaa009
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmaa_m.imaa009_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_bmaa_m.imaa009_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bmaa_m.imaa010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bmaa_m.imaa010_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_bmaa_m.imaa010_desc 
   #end add-point
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bmba_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba003
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_bmba_d[l_ac].bmba003_desc = '', g_rtn_fields[1] , ''
#            LET g_bmba_d[l_ac].bmba003_desc_desc = '', g_rtn_fields[2] , ''
#            DISPLAY BY NAME g_bmba_d[l_ac].bmba003_desc
#            DISPLAY BY NAME g_bmba_d[l_ac].bmba003_desc_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba004
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='215' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_bmba_d[l_ac].bmba004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_bmba_d[l_ac].bmba004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba007
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_bmba_d[l_ac].bmba007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_bmba_d[l_ac].bmba007_desc
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba024
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_bmba_d[l_ac].bmba024_desc = '', g_rtn_fields[1] , ''
#            LET g_bmba_d[l_ac].bmba024_desc_desc = '', g_rtn_fields[2] , ''
#            DISPLAY BY NAME g_bmba_d[l_ac].bmba024_desc,g_bmba_d[l_ac].bmba024_desc            

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_bmba_d[l_ac].bmba015
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_bmba_d[l_ac].bmba015_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_bmba_d[l_ac].bmba015_desc
#            CALL abmm204_bmba015_desc()
      #end add-point
   END FOR
 
   
    
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abmm204_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point 
   DEFINE l_newno     LIKE bmaa_t.bmaasite 
   DEFINE l_oldno     LIKE bmaa_t.bmaasite 
   DEFINE l_newno02     LIKE bmaa_t.bmaa001 
   DEFINE l_oldno02     LIKE bmaa_t.bmaa001 
   DEFINE l_newno03     LIKE bmaa_t.bmaa002 
   DEFINE l_oldno03     LIKE bmaa_t.bmaa002 
 
   DEFINE l_master    RECORD LIKE bmaa_t.*
   DEFINE l_detail    RECORD LIKE bmba_t.*
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   IF g_bmaa_m.bmaasite IS NULL
   OR g_bmaa_m.bmaa001 IS NULL
   OR g_bmaa_m.bmaa002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
    
   LET g_bmaasite_t = g_bmaa_m.bmaasite
   LET g_bmaa001_t = g_bmaa_m.bmaa001
   LET g_bmaa002_t = g_bmaa_m.bmaa002
 
   
   LET g_bmaa_m.bmaasite = ""
   LET g_bmaa_m.bmaa001 = ""
   LET g_bmaa_m.bmaa002 = ""
 
   
   CALL abmm204_set_entry('a')
   CALL abmm204_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   CALL abmm204_input("r")
   
   
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
 
   #功能已完成,通報訊息中心
   CALL abmm204_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abmm204_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point   
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bmba_t.*
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abmm204_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bmba_t
    WHERE bmbaent = g_enterprise AND bmbasite = g_bmaasite_t
    AND bmba001 = g_bmaa001_t
    AND bmba002 = g_bmaa002_t
 
    INTO TEMP abmm204_detail
   
   #將key修正為調整後   
   UPDATE abmm204_detail 
      #更新key欄位
      SET bmbasite = g_bmaa_m.bmaasite
          , bmba001 = g_bmaa_m.bmaa001
          , bmba002 = g_bmaa_m.bmaa002
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO bmba_t SELECT * FROM abmm204_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "Reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abmm204_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bmaasite_t = g_bmaa_m.bmaasite
   LET g_bmaa001_t = g_bmaa_m.bmaa001
   LET g_bmaa002_t = g_bmaa_m.bmaa002
 
   
   DROP TABLE abmm204_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abmm204_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point   
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_bmaa_m.bmaasite IS NULL
   OR g_bmaa_m.bmaa001 IS NULL
   OR g_bmaa_m.bmaa002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE abmm204_master_referesh USING g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002 INTO g_bmaa_m.bmaasite, 
       g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.bmaa004
   
   #檢查是否允許此動作
   IF NOT abmm204_action_chk() THEN
      RETURN
   END IF
   
   CALL abmm204_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN abmm204_cl USING g_enterprise,g_bmaa_m.bmaasite
                                                       ,g_bmaa_m.bmaa001
                                                       ,g_bmaa_m.bmaa002
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abmm204_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE abmm204_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH abmm204_cl INTO g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmaa_m.imaal003,g_bmaa_m.imaa009, 
       g_bmaa_m.imaa009_desc,g_bmaa_m.imaal004,g_bmaa_m.imaa010,g_bmaa_m.imaa010_desc,g_bmaa_m.bmaa004  
                    #鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_bmaa_m.bmaasite,":",SQLERRMESSAGE  
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下 
      
      #資料備份
      LET g_bmaasite_t = g_bmaa_m.bmaasite
      LET g_bmaa001_t = g_bmaa_m.bmaa001
      LET g_bmaa002_t = g_bmaa_m.bmaa002
 
      
      #應用 a47 樣板自動產生(Version:3)
      #刪除相關文件
      CALL abmm204_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
      
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
      
      DELETE FROM bmaa_t
       WHERE bmaaent = g_enterprise AND bmaasite = g_bmaa_m.bmaasite
         AND bmaa001 = g_bmaa_m.bmaa001
         AND bmaa002 = g_bmaa_m.bmaa002
 
      
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bmaa_m.bmaasite,":",SQLERRMESSAGE  
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      
      
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bmba_t
       WHERE bmbaent = g_enterprise AND bmbasite = g_bmaa_m.bmaasite
         AND bmba001 = g_bmaa_m.bmaa001
         AND bmba002 = g_bmaa_m.bmaa002
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmba_t:",SQLERRMESSAGE  
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF       
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
                                                               
 
                            
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE abmm204_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL g_bmba_d.clear() 
 
     
      CALL abmm204_ui_browser_refresh()  
      CALL abmm204_ui_headershow()  
      CALL abmm204_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abmm204_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         CALL abmm204_browser_fill()
      END IF
       
   END IF
 
   CLOSE abmm204_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abmm204_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abmm204.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abmm204_b_fill()
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point   
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   CALL g_bmba_d.clear()    #g_bmba_d 單頭及單身 
 
 
   #add-point:b_fill段define name="b_fill.sql_before"
   IF cl_null(g_bmaa_l_date) THEN 
      LET g_sql = "SELECT UNIQUE bmba009,bmba003,a.imaal003,a.imaal004,bmba004,a.oocql004,bmba007,b.oocql004,bmba008, ",
                  "       bmba005,bmba006,bmba011,bmba012,bmba010,bmba021,bmba022,bmba023,",
                 #"       bmba024,b.imaal003,b.imaal004,bmba030,bmba031,bmba015,inayl003,bmba016,inab003 ",           #160627-00008#1 mark
                  "       bmba024,b.imaal003,b.imaal004,bmba030,bmba031,bmba015,inayl003,bmba016,inab003,bmba032 ",   #160627-00008#1 add
                  "  FROM bmba_t",
                  "  LEFT JOIN imaal_t a ON bmbaent=a.imaalent AND a.imaal001=bmba003 AND a.imaal002='",g_dlang,"'",
                  "  LEFT JOIN oocql_t a ON bmbaent=a.oocqlent AND a.oocql001='215' AND a.oocql002=bmba004 AND a.oocql003='",g_dlang,"'",                  
                  "  LEFT JOIN oocql_t b ON bmbaent=b.oocqlent AND b.oocql001='221' AND b.oocql002=bmba007 AND b.oocql003='",g_dlang,"'", 
                  "  LEFT JOIN inayl_t ON inaylent=bmbaent AND inayl001=bmba015 AND inayl002='",g_dlang,"'",
                  "  LEFT JOIN inab_t ON inabent=bmbaent AND inabsite=bmbasite AND inab001=bmba015 AND inab002=bmba016  ",                  
                  "  LEFT JOIN imaal_t b ON bmbaent=b.imaalent AND b.imaal001=bmba024 AND b.imaal002='",g_dlang,"'",                  
                  " WHERE bmbaent=? AND bmbasite=? AND bmba001=? AND bmba002=?"   
   ELSE
      LET g_sql = "SELECT UNIQUE bmba009,bmba003,a.imaal003,a.imaal004,bmba004,a.oocql004,bmba007,b.oocql004,bmba008, ",
                  "       bmba005,bmba006,bmba011,bmba012,bmba010,bmba021,bmba022,bmba023,",
                 #"       bmba024,b.imaal003,b.imaal004,bmba030,bmba031,bmba015,inayl003,bmba016,inab003 ",           #160627-00008#1 mark
                  "       bmba024,b.imaal003,b.imaal004,bmba030,bmba031,bmba015,inayl003,bmba016,inab003,bmba032 ",   #160627-00008#1 add
                  "  FROM bmba_t",
                  "  LEFT JOIN imaal_t a ON bmbaent=a.imaalent AND a.imaal001=bmba003 AND a.imaal002='",g_dlang,"'",
                  "  LEFT JOIN oocql_t a ON bmbaent=a.oocqlent AND a.oocql001='215' AND a.oocql002=bmba004 AND a.oocql003='",g_dlang,"'",                  
                  "  LEFT JOIN oocql_t b ON bmbaent=b.oocqlent AND b.oocql001='221' AND b.oocql002=bmba007 AND b.oocql003='",g_dlang,"'", 
                  "  LEFT JOIN inayl_t ON inaylent=bmbaent AND inayl001=bmba015 AND inayl002='",g_dlang,"'",
                  "  LEFT JOIN inab_t ON inabent=bmbaent AND inabsite=bmbasite AND inab001=bmba015 AND inab002=bmba016  ",                  
                  "  LEFT JOIN imaal_t b ON bmbaent=b.imaalent AND b.imaal001=bmba024 AND b.imaal002='",g_dlang,"'", 
                  " WHERE bmbaent=? AND bmbasite=? AND bmba001=? AND bmba002=? AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= ? AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > ? OR bmba006 IS NULL)"
   END IF
   IF NOT cl_null(g_wc_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table1 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY  bmba_t.bmba009,bmba_t.bmba003,bmba_t.bmba004,bmba_t.bmba005,bmba_t.bmba007,bmba_t.bmba008"
 
   PREPARE abmm204_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR abmm204_pb1   
   LET g_cnt = l_ac
   LET l_ac = 1
   IF cl_null(g_bmaa_l_date) THEN
      OPEN b_fill_cs1 USING g_enterprise,g_bmaa_m.bmaasite
                                               ,g_bmaa_m.bmaa001

                                               ,g_bmaa_m.bmaa002

   ELSE
      LET  g_bmaa_l_date = g_bmaa_t_l_date
      OPEN b_fill_cs1 USING g_enterprise,g_bmaa_m.bmaasite
                                               ,g_bmaa_m.bmaa001

                                               ,g_bmaa_m.bmaa002
                                               ,g_bmaa_l_date
                                               ,g_bmaa_l_date
   END IF


                                            
   FOREACH b_fill_cs1 INTO g_bmba_d[l_ac].bmba009,g_bmba_d[l_ac].bmba003,g_bmba_d[l_ac].bmba003_desc,g_bmba_d[l_ac].bmba003_desc_desc,g_bmba_d[l_ac].bmba004,g_bmba_d[l_ac].bmba004_desc,g_bmba_d[l_ac].bmba007,g_bmba_d[l_ac].bmba007_desc,g_bmba_d[l_ac].bmba008,g_bmba_d[l_ac].bmba005,g_bmba_d[l_ac].bmba006,g_bmba_d[l_ac].bmba011,g_bmba_d[l_ac].bmba012,g_bmba_d[l_ac].bmba010,g_bmba_d[l_ac].bmba021,g_bmba_d[l_ac].bmba022,g_bmba_d[l_ac].bmba023,g_bmba_d[l_ac].bmba024,g_bmba_d[l_ac].bmba024_desc,g_bmba_d[l_ac].bmba024_desc_desc,g_bmba_d[l_ac].bmba030,g_bmba_d[l_ac].bmba031,g_bmba_d[l_ac].bmba015,g_bmba_d[l_ac].bmba015_desc,g_bmba_d[l_ac].bmba016,g_bmba_d[l_ac].bmba016_desc
                          ,g_bmba_d[l_ac].bmba032  #160627-00008#1 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      #add-point:b_fill段資料填充
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_bmba_d[l_ac].bmba024
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_bmba_d[l_ac].bmba024_desc = '', g_rtn_fields[1] , ''
#      LET g_bmba_d[l_ac].bmba024_desc_desc = '', g_rtn_fields[2] , ''
#      DISPLAY BY NAME g_bmba_d[l_ac].bmba024_desc,g_bmba_d[l_ac].bmba024_desc_desc     
#      CALL abmm204_bmba015_desc()      
      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_bmba_d[l_ac].bmba003
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_bmba_d[l_ac].bmba003_desc = '', g_rtn_fields[1] , ''
#      LET g_bmba_d[l_ac].bmba003_desc_desc = '', g_rtn_fields[2] , ''
#      DISPLAY BY NAME g_bmba_d[l_ac].bmba003_desc
#      DISPLAY BY NAME g_bmba_d[l_ac].bmba003_desc_desc

#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_bmba_d[l_ac].bmba004
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='215' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_bmba_d[l_ac].bmba004_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_bmba_d[l_ac].bmba004_desc
#
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_bmba_d[l_ac].bmba007
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_bmba_d[l_ac].bmba007_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_bmba_d[l_ac].bmba007_desc
      #end add-point
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   

   
   CALL g_bmba_d.deleteElement(g_bmba_d.getLength())

 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   CLOSE b_fill_cs1

   
   FREE abmm204_pb1 
   RETURN   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bmba009,bmba003,bmba004,bmba007,bmba008,bmba005,bmba006,bmba011,bmba012, 
       bmba010,bmba021,bmba022,bmba023,bmba024,bmba030,bmba031,bmba015,bmba016,bmba032 ,t1.imaal003 , 
       t2.imaal004 ,t3.oocql004 ,t4.oocql004 ,t5.imaal003 ,t6.imaal004 ,t7.inaa002 ,t8.inab003 FROM bmba_t", 
           
               " INNER JOIN bmaa_t ON bmaasite = bmbasite ",
               " AND bmaa001 = bmba001 ",
               " AND bmaa002 = bmba002 ",
 
               "",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=bmba003 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=bmba003 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='215' AND t3.oocql002=bmba004 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='221' AND t4.oocql002=bmba007 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent='"||g_enterprise||"' AND t5.imaal001=bmba024 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t6 ON t6.imaalent='"||g_enterprise||"' AND t6.imaal001=bmba024 AND t6.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inaa_t t7 ON t7.inaaent='"||g_enterprise||"' AND t7.inaasite=bmbasite AND t7.inaa001=bmba015  ",
               " LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inabsite=bmbasite AND t8.inab001=bmba015 AND t8.inab002=bmba016  ",
 
               " WHERE bmbaent=? AND bmbasite=? AND bmba001=? AND bmba002=?"
 
   IF NOT cl_null(g_wc_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table1 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY  bmba_t.bmba003,bmba_t.bmba004,bmba_t.bmba005,bmba_t.bmba007,bmba_t.bmba008"
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
   PREPARE abmm204_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR abmm204_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs USING g_enterprise,g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002
                                            
   FOREACH b_fill_cs INTO g_bmba_d[l_ac].bmba009,g_bmba_d[l_ac].bmba003,g_bmba_d[l_ac].bmba004,g_bmba_d[l_ac].bmba007, 
       g_bmba_d[l_ac].bmba008,g_bmba_d[l_ac].bmba005,g_bmba_d[l_ac].bmba006,g_bmba_d[l_ac].bmba011,g_bmba_d[l_ac].bmba012, 
       g_bmba_d[l_ac].bmba010,g_bmba_d[l_ac].bmba021,g_bmba_d[l_ac].bmba022,g_bmba_d[l_ac].bmba023,g_bmba_d[l_ac].bmba024, 
       g_bmba_d[l_ac].bmba030,g_bmba_d[l_ac].bmba031,g_bmba_d[l_ac].bmba015,g_bmba_d[l_ac].bmba016,g_bmba_d[l_ac].bmba032, 
       g_bmba_d[l_ac].bmba003_desc,g_bmba_d[l_ac].bmba003_desc_desc,g_bmba_d[l_ac].bmba004_desc,g_bmba_d[l_ac].bmba007_desc, 
       g_bmba_d[l_ac].bmba024_desc,g_bmba_d[l_ac].bmba024_desc_desc,g_bmba_d[l_ac].bmba015_desc,g_bmba_d[l_ac].bmba016_desc 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
     
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL abmm204_bmba015_desc()
      #end add-point
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
 
   
   CALL g_bmba_d.deleteElement(g_bmba_d.getLength())
 
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   CLOSE b_fill_cs
 
   
   FREE abmm204_pb
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abmm204_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point    
   DEFINE ps_table    STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_page     STRING
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "bmba_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point   
      DELETE FROM bmba_t
       WHERE bmbaent = g_enterprise AND
         bmbasite = ps_keys_bak[1] AND bmba001 = ps_keys_bak[2] AND bmba002 = ps_keys_bak[3] AND bmba003 = ps_keys_bak[4] AND bmba004 = ps_keys_bak[5] AND bmba005 = ps_keys_bak[6] AND bmba007 = ps_keys_bak[7] AND bmba008 = ps_keys_bak[8]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abmm204_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point    
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "bmba_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point   
      INSERT INTO bmba_t
                  (bmbaent,
                   bmbasite,bmba001,bmba002,
                   bmba003,bmba004,bmba005,bmba007,bmba008
                   ,bmba009,bmba006,bmba011,bmba012,bmba010,bmba021,bmba022,bmba023,bmba024,bmba030,bmba031,bmba015,bmba016,bmba032) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
                   ,g_bmba_d[l_ac].bmba009,g_bmba_d[l_ac].bmba006,g_bmba_d[l_ac].bmba011,g_bmba_d[l_ac].bmba012, 
                       g_bmba_d[l_ac].bmba010,g_bmba_d[l_ac].bmba021,g_bmba_d[l_ac].bmba022,g_bmba_d[l_ac].bmba023, 
                       g_bmba_d[l_ac].bmba024,g_bmba_d[l_ac].bmba030,g_bmba_d[l_ac].bmba031,g_bmba_d[l_ac].bmba015, 
                       g_bmba_d[l_ac].bmba016,g_bmba_d[l_ac].bmba032)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bmba_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point   
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abmm204_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"

   #end add-point   
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
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"

   #end add-point 
   
   #add-point:Function前置處理  name="update_b.pre_function"

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
   
   #判斷是否是同一群組的table
   LET ls_group = ""
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bmba_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"

      #end add-point     
      UPDATE bmba_t 
         SET (bmbasite,bmba001,bmba002,
              bmba003,bmba004,bmba005,bmba007,bmba008
              ,bmba009,bmba006,bmba011,bmba012,bmba010,bmba021,bmba022,bmba023,bmba024,bmba030,bmba031,bmba015,bmba016,bmba032) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8]
              ,g_bmba_d[l_ac].bmba009,g_bmba_d[l_ac].bmba006,g_bmba_d[l_ac].bmba011,g_bmba_d[l_ac].bmba012, 
                  g_bmba_d[l_ac].bmba010,g_bmba_d[l_ac].bmba021,g_bmba_d[l_ac].bmba022,g_bmba_d[l_ac].bmba023, 
                  g_bmba_d[l_ac].bmba024,g_bmba_d[l_ac].bmba030,g_bmba_d[l_ac].bmba031,g_bmba_d[l_ac].bmba015, 
                  g_bmba_d[l_ac].bmba016,g_bmba_d[l_ac].bmba032) 
         WHERE bmbaent = g_enterprise   #170120-00046#1 add ent
           AND bmbasite = ps_keys_bak[1] AND bmba001 = ps_keys_bak[2] AND bmba002 = ps_keys_bak[3] AND bmba003 = ps_keys_bak[4] AND bmba004 = ps_keys_bak[5] AND bmba005 = ps_keys_bak[6] AND bmba007 = ps_keys_bak[7] AND bmba008 = ps_keys_bak[8]
      #add-point:update_b段修改中 name="update_b.m_update"

      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmba_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bmba_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"

      #end add-point   
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abmm204_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ps_page  STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL abmm204_b_fill()
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "bmba_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abmm204_bcl USING g_enterprise,
                                       g_bmaa_m.bmaasite,g_bmaa_m.bmaa001,g_bmaa_m.bmaa002,g_bmba_d[g_detail_idx].bmba003, 
                                           g_bmba_d[g_detail_idx].bmba004,g_bmba_d[g_detail_idx].bmba005, 
                                           g_bmba_d[g_detail_idx].bmba007,g_bmba_d[g_detail_idx].bmba008 
 
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abmm204_bcl:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abmm204_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table STRING
   DEFINE ps_page  STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE abmm204_bcl
   END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abmm204_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bmaasite,bmaa001,bmaa002",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("l_date", TRUE)     
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abmm204_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bmaasite,bmaa001,bmaa002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'a' OR p_cmd = 'u' THEN
      CALL cl_set_comp_entry("l_date",FALSE)      
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abmm204_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("bmba032",TRUE)
   CALL cl_set_comp_required("bmba032",FALSE)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abmm204_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaf055  LIKE imaf_t.imaf055
   #end add-point 
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   SELECT imaf055 INTO l_imaf055 FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = g_bmba_d[l_ac].bmba003
    
   IF l_imaf055 = 2 THEN    
      CALL cl_set_comp_entry("bmba032",FALSE)
   END IF
   IF l_imaf055 = 1 THEN    
      CALL cl_set_comp_required("bmba032",TRUE)
   END IF   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="abmm204.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abmm204_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point     
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
 
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   LET g_wc = " 1=1"
   
   RETURN
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " bmaasite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bmaa001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bmaa002 = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION abmm204_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bmba_d.getLength() THEN
         LET g_detail_idx = g_bmba_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bmba_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bmba_d.getLength() TO FORMONLY.cnt
   END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.browser_expand" >}
#+ Tree子節點展開
PRIVATE FUNCTION abmm204_browser_expand(p_id)
   #add-point:browser_expand段define name="browser_expand.define_customerization"
   
   #end add-point
   DEFINE p_id          LIKE type_t.num10
   DEFINE l_id          LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_keyvalue    LIKE type_t.chr50
   DEFINE l_typevalue   LIKE type_t.chr50
   DEFINE l_type        LIKE type_t.chr50
   DEFINE l_sql         STRING
   DEFINE ls_source     LIKE type_t.chr500
   DEFINE ls_exp_code   LIKE type_t.chr500
   DEFINE l_return      LIKE type_t.num5
   #add-point:browser_expand段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand.define"
   DEFINE l_bmba009     LIKE bmba_t.bmba009
   
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   LET l_return = FALSE

   LET l_keyvalue =g_browser[p_id].b_show

   #此程式無root欄位:LET l_typevalue = g_browser[p_id].b_
   
   IF cl_null(g_bmaa_l_date) THEN
      LET l_sql = " SELECT UNIQUE '','','','FALSE','','','',bmba003,'','',bmba002,bmbasite,bmba009",
                  " FROM   bmba_t ",
                 # " INNER JOIN bmaa_t ON bmba001 = bmaa001 AND bmbaent = bmaaent AND bmbasite = bmaasite AND bmba002 = bmaa002 AND bmba003 <> bmaa001 ",
                  " WHERE bmba001 = '", l_keyvalue,"' ",
                  "   AND bmba002 = '", g_browser[p_id].b_bmaa002,"' ",
                  "   AND bmbaent = '",g_enterprise,"' ",
                  "   AND bmbasite = '",g_site,"' ",
                  " ORDER BY bmba009"
   ELSE
      LET l_sql = " SELECT UNIQUE '','','','FALSE','','','',bmba003,'','',bmba002,bmbasite,bmba009",
                  " FROM   bmba_t ",
                 # " INNER JOIN bmaa_t ON bmba001 = bmaa001 AND bmbaent = bmaaent AND bmbasite = bmaasite AND bmba002 = bmaa002 AND bmba003 <> bmaa001 ",
                  " WHERE bmba001 = '", l_keyvalue,"' ",
                  "   AND bmba002 = '", g_browser[p_id].b_bmaa002,"' ",
                  "   AND bmbaent = '",g_enterprise,"' ",
                  "   AND bmbasite = '",g_site,"' ",
                  "   AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss')<= '",g_bmaa_l_date ,"' AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > '",g_bmaa_l_date ,"' OR bmba006 IS NULL)",
                  " ORDER BY bmba009"
   END IF                  
   
   PREPARE tree_expand1 FROM l_sql
   DECLARE tree_ex_cur1 CURSOR FOR tree_expand1
  
   LET l_id = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur1 INTO g_browser[l_id].*,l_bmba009
      #pid=父節點id
      LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id   = g_browser[p_id].b_id||"."||l_cnt
      LET g_browser_b_bmba003 =  g_browser[l_id].b_bmaa001
      LET g_browser[l_id].b_hasC = abmm204_chk_hasC(l_id)
      CALL abmm204_desc_show(l_id)
      LET l_id = l_id + 1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      
      LET l_return = TRUE
   END FOREACH
   
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
   
   CLOSE tree_ex_cur1
   FREE tree_expand1
   RETURN   
   #end add-point
   
   #add-point:Function前置處理  name="browser_expand.pre_function"
   
   #end add-point
   
   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_keyvalue = g_browser[p_id].b_bmaa001
   
   LET l_sql = " SELECT DISTINCT '','','','FALSE','','','',t0.bmba003,t0.bmaa002,t0.bmaasite",
               " FROM   bmba_t t0 ",
               " INNER JOIN bmaa_t ON bmba003 = bmaa001 ",
               " WHERE  bmba001 = '", l_keyvalue,"' ",
               " ORDER BY bmba003"
 
   #add-point:browser_expand段sql調整 name="browser_expand.modify_sql"
   
   #end add-point
   
   #LET l_sql = cl_sql_add_tabid(l_sql,"bmaa_t")            #WC重組
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE tree_expand FROM l_sql
   DECLARE tree_ex_cur CURSOR FOR tree_expand
  
   LET l_id = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur INTO g_browser[l_id].*
      #pid=父節點id
      LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id   = g_browser[p_id].b_id||"."||l_cnt
      #hasC=確認該節點是否有子孫
      #LET g_browser[l_id].b_bmaa001 = g_browser[l_id].b_bmaa001 CLIPPED
      CALL abmm204_desc_show(l_id)
      LET g_browser[l_id].b_hasC = abmm204_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      
      LET l_return = TRUE
   END FOREACH
   
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
   
   CLOSE tree_ex_cur
   FREE tree_expand
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.chk_hasC" >}
#+ 確認該節點是否有子節點
PRIVATE FUNCTION abmm204_chk_hasC(pi_id)
   #add-point:chk_hasC段define name="chk_hasC.define_customerization"
   
   #end add-point
   DEFINE pi_id    INTEGER
   DEFINE li_cnt   INTEGER
   #add-point:chk_hasC段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="chk_hasC.define"
   LET li_cnt = 0
   SELECT COUNT(*) INTO li_cnt FROM bmba_t 
   #INNER JOIN bmaa_t ON bmba003 <> bmaa001
    WHERE bmbaent = g_enterprise AND bmbasite = g_site AND bmba001 = g_browser_b_bmba003 AND bmba002 =g_browser[pi_id].b_bmaa002 
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
   RETURN   
   #end add-point
   
   #add-point:Function前置處理  name="chk_hasC.pre_function"
   
   #end add-point
   
   LET li_cnt = 0
    
    SELECT COUNT(1) INTO li_cnt FROM bmba_t
    INNER JOIN bmaa_t ON bmba003 = bmaa001
    WHERE bmbaent = g_enterprise AND bmba001 = g_browser[pi_id].b_bmaa001
   
   #add-point:chk_hasC段確認後 name="chk_hasC.after_chk"
   
   #end add-point
   
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abmm204.desc_show" >}
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION abmm204_desc_show(pi_ac)
   #add-point:desc_show段define name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   #add-point:desc_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="desc_show.pre_function"
   
   #end add-point
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   
   
   #add-point:browser_create段desc處理 name="desc_show.show"
      LET g_browser[l_ac].b_show = 
           g_browser[l_ac].b_bmaa001
      SELECT imaal003,imaal004 INTO g_browser[l_ac].b_bmaa001_desc,g_browser[l_ac].b_bmaa001_desc_desc FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_browser[l_ac].b_bmaa001
         AND imaal002 = g_lang         
      DISPLAY BY NAME g_browser[l_ac].b_bmaa001_desc
      DISPLAY BY NAME g_browser[l_ac].b_bmaa001_desc_desc
   #end add-point
 
   LET l_ac = li_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abmm204_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "bmba009"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.state_change" >}
   
 
{</section>}
 
{<section id="abmm204.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abmm204_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_bmaa_m.bmaasite
   LET g_pk_array[1].column = 'bmaasite'
   LET g_pk_array[2].values = g_bmaa_m.bmaa001
   LET g_pk_array[2].column = 'bmaa001'
   LET g_pk_array[3].values = g_bmaa_m.bmaa002
   LET g_pk_array[3].column = 'bmaa002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmm204.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abmm204_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL abmm204_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bmaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abmm204.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abmm204_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abmm204.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION abmm204_tree_creat()
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE l_type            STRING
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_bmba009         LIKE bmba_t.bmba009
   CLEAR FORM                
   #INITIALIZE g_bmaa_m.* TO NULL
   CALL g_bmba_d.clear()        

   CALL g_browser.clear()
   
   IF NOT cl_null(g_wc2) AND g_wc2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2
      LET g_sql = " SELECT UNIQUE bmaa001,bmaa002,bmaasite FROM bmaa_t ",
                  " LEFT JOIN imaa_t ON imaaent = bmaaent AND imaa001 = bmaa001 ",
                  " INNER JOIN bmba_t ON bmba001 = bmaa001 AND bmba002 = bmaa002 AND bmbaent = bmaaent AND bmbasite = bmaasite",
                  " WHERE bmaaent = '" ||g_enterprise|| "' AND bmaasite = '"|| g_site || "'"||" AND ",g_wc
     ELSE 
      LET g_sql = " SELECT UNIQUE bmaa001,bmaa002,bmaasite FROM bmaa_t ",
                  " LEFT JOIN imaa_t ON imaaent = bmaaent AND imaa001 = bmaa001 ",
                  " WHERE bmaaent = '" ||g_enterprise|| "' AND bmaasite = '" ||g_site || "'"||" AND ",g_wc   
   END IF 
   LET l_sql = " AND (bmaa001,bmaa002) NOT IN (SELECT bmba003,bmba002 FROM bmba_t INNER JOIN bmaa_t ON bmba001 = bmaa001 AND bmbaent = bmaaent AND bmbasite = bmaasite AND bmba002 = bmaa002 ",
               " WHERE bmaaent = '" ||g_enterprise|| "' AND bmaasite = '"|| g_site || "'",
               " AND ",g_wc,")"
   LET g_sql = g_sql,l_sql,  " ORDER BY bmaa001"
   PREPARE type_pre FROM g_sql
   DECLARE type_cur CURSOR FOR type_pre

   IF cl_null(g_wc2) THEN 
      LET g_wc2 = "1=1"
   END IF   
   LET g_wc = g_wc, " AND ", g_wc2
   IF cl_null(g_bmaa_l_date) THEN
      LET g_sql = " SELECT  bmaa001,bmba003,bmaa002,bmaasite,bmba009 FROM bmaa_t ",
                  " LEFT JOIN imaa_t ON imaaent = bmaaent AND imaa001 = bmaa001 ",
                  " INNER JOIN bmba_t ON bmba001 = bmaa001 AND bmbaent = bmaaent AND bmbasite = bmaasite AND bmba002 = bmaa002 ",
                  "  WHERE bmaaent = '" ||g_enterprise|| "' AND bmaasite = '" ||g_site || "' AND bmaa001 = ? AND  bmaa002 = ? AND "||g_wc
   ELSE
      LET g_sql = " SELECT  bmaa001,bmba003,bmaa002,bmaasite,bmba009 FROM bmaa_t ",
                  " LEFT JOIN imaa_t ON imaaent = bmaaent AND imaa001 = bmaa001 ",
                  " INNER JOIN bmba_t ON bmba001 = bmaa001 AND bmbaent = bmaaent AND bmbasite = bmaasite AND bmba002 = bmaa002 ",
                  "  WHERE bmaaent = '" ||g_enterprise|| "' AND bmaasite = '" ||g_site || "' AND bmaa001 = ? AND  bmaa002 = ? AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss') <= '",g_bmaa_l_date ,"' AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') > '",g_bmaa_l_date ,"' OR bmba006 IS NULL) AND "||g_wc
   END IF
   LET g_sql = g_sql," ORDER BY bmba009 "
   PREPARE browse_pre1 FROM g_sql
   DECLARE browse_cur1 CURSOR FOR browse_pre1

   CALL g_browser.clear()
   LET g_cnt = 1
   LET l_type = "0"
   LET l_cnt = 1
      FOREACH type_cur INTO g_browser[g_cnt].b_bmaa001,g_browser[g_cnt].b_bmaa002,g_browser[g_cnt].b_bmaasite
         LET g_browser[g_cnt].b_show  = '(',g_browser[g_cnt].b_bmaa001,')'
         LET g_browser[g_cnt].b_id    = g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp   = FALSE
         LET g_browser_b_bmba003 = g_browser[g_cnt].b_bmaa001
         LET g_browser[g_cnt].b_hasC  = abmm204_chk_hasC(g_cnt)
         LET g_browser[g_cnt].b_isExp = 1
         LET l_type = g_cnt USING "<<<"    
         LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_bmaa001
         SELECT imaal003,imaal004 INTO g_browser[g_cnt].b_bmaa001_desc,g_browser[g_cnt].b_bmaa001_desc_desc FROM imaal_t
          WHERE imaalent = g_enterprise
            AND imaal001 = g_browser[g_cnt].b_bmaa001
            AND imaal002 = g_lang         
          DISPLAY BY NAME g_browser[g_cnt].b_bmaa001_desc
          DISPLAY BY NAME g_browser[g_cnt].b_bmaa001_desc_desc        

         OPEN browse_cur1 USING g_browser[g_cnt].b_bmaa001,g_browser[g_cnt].b_bmaa002
         LET g_cnt = g_cnt + 1
         FOREACH browse_cur1 INTO g_browser[g_cnt].b_bmaa001,g_browser_b_bmba003,g_browser[g_cnt].b_bmaa002,g_browser[g_cnt].b_bmaasite,l_bmba009

            LET g_browser[g_cnt].b_pid  = l_type
            LET g_browser[g_cnt].b_id   = l_type, '.', g_cnt USING "<<<"
            LET g_browser[g_cnt].b_exp  = FALSE
            LET g_browser[g_cnt].b_hasC = abmm204_chk_hasC(g_cnt)
            LET g_browser[g_cnt].b_show = g_browser_b_bmba003
            SELECT imaal003,imaal004 INTO g_browser[g_cnt].b_bmaa001_desc,g_browser[g_cnt].b_bmaa001_desc_desc FROM imaal_t
             WHERE imaalent = g_enterprise
               AND imaal001 = g_browser_b_bmba003
               AND imaal002 = g_lang         
             DISPLAY BY NAME g_browser[g_cnt].b_bmaa001_desc
             DISPLAY BY NAME g_browser[g_cnt].b_bmaa001_desc_desc              
            LET g_cnt = g_cnt + 1
            IF g_cnt > g_max_rec THEN
               EXIT FOREACH
            END IF
         END FOREACH
         LET l_cnt = l_cnt + 1
         IF l_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
      IF (g_cnt > g_max_rec OR l_cnt > g_max_rec) AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
      LET g_error_show = 0
      
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   LET g_browser_cnt = g_browser.getLength()
   
   CLOSE browse_cur1
   CLOSE type_cur
   FREE browse_pre1
   FREE type_pre

END FUNCTION
#倉庫帶值 儲位帶值
PRIVATE FUNCTION abmm204_bmba015_desc()
   LET g_bmba_d[l_ac].bmba015_desc = ''
   LET g_bmba_d[l_ac].bmba016_desc = ''
   IF NOT cl_null(g_bmba_d[l_ac].bmba015) THEN   
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_bmba_d[l_ac].bmba015
      LET g_ref_fields[2] = g_bmaa_m.bmaasite
      CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? AND inaasite=? ","") RETURNING g_rtn_fields
      IF cl_null(g_rtn_fields[1]) THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_bmba_d[l_ac].bmba015
         CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
      END IF
   LET g_bmba_d[l_ac].bmba015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bmba_d[l_ac].bmba015_desc
   END IF   
   IF NOT cl_null(g_bmba_d[l_ac].bmba016) THEN   
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_bmba_d[l_ac].bmba015
      LET g_ref_fields[2] = g_bmba_d[l_ac].bmba016
      LET g_ref_fields[3] = g_site
      CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? AND inabsite=? ","") RETURNING g_rtn_fields
      IF cl_null(g_rtn_fields[1]) THEN
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_bmba_d[l_ac].bmba015
         LET g_ref_fields[2] = g_bmba_d[l_ac].bmba016
         CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
     END IF
   LET g_bmba_d[l_ac].bmba016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bmba_d[l_ac].bmba016_desc
   END IF   
END FUNCTION

 
{</section>}
 
