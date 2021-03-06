#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-11-07 15:34:49), PR版次:0002(2016-12-16 12:05:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi410
#+ Description: 預算BOM維護作業
#+ Creator....: 02114(2016-11-07 15:34:49)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="abgi410.global" >}
#應用 i04 樣板自動產生(Version:37)
#add-point:填寫註解說明 name="global.memo"
#161215-00051#1   2016/12/16  By 02114    查询时加上权限
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

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
PRIVATE type type_g_bgda_m        RECORD
       bgda001 LIKE bgda_t.bgda001, 
   bgda001_desc LIKE type_t.chr80, 
   bgda002 LIKE bgda_t.bgda002, 
   bgasl003 LIKE bgasl_t.bgasl003, 
   bgasl004 LIKE bgasl_t.bgasl004, 
   bgdastus LIKE bgda_t.bgdastus, 
   bgas004 LIKE type_t.chr10, 
   bgda003 LIKE bgda_t.bgda003, 
   bgas005 LIKE type_t.chr10, 
   bgda005 LIKE bgda_t.bgda005, 
   bgas310 LIKE type_t.chr10, 
   bgdaownid LIKE bgda_t.bgdaownid, 
   bgdaownid_desc LIKE type_t.chr80, 
   bgdaowndp LIKE bgda_t.bgdaowndp, 
   bgdaowndp_desc LIKE type_t.chr80, 
   bgdacrtid LIKE bgda_t.bgdacrtid, 
   bgdacrtid_desc LIKE type_t.chr80, 
   bgdacrtdp LIKE bgda_t.bgdacrtdp, 
   bgdacrtdp_desc LIKE type_t.chr80, 
   bgdacrtdt LIKE bgda_t.bgdacrtdt, 
   bgdamodid LIKE bgda_t.bgdamodid, 
   bgdamodid_desc LIKE type_t.chr80, 
   bgdamoddt LIKE bgda_t.bgdamoddt, 
   bgdacnfid LIKE bgda_t.bgdacnfid, 
   bgdacnfid_desc LIKE type_t.chr80, 
   bgdacnfdt LIKE bgda_t.bgdacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgdb_d        RECORD
       bgdbseq LIKE bgdb_t.bgdbseq, 
   bgdb004 LIKE bgdb_t.bgdb004, 
   bgasl003 LIKE type_t.chr500, 
   bgasl004 LIKE type_t.chr500, 
   bgdb005 LIKE bgdb_t.bgdb005, 
   bgdb006 LIKE bgdb_t.bgdb006, 
   bgdb007 LIKE bgdb_t.bgdb007, 
   bgdb008 LIKE bgdb_t.bgdb008, 
   bgda003 LIKE type_t.dat, 
   bgdb009 LIKE bgdb_t.bgdb009
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_path_add            DYNAMIC ARRAY OF STRING
DEFINE g_idx                 LIKE type_t.num5
DEFINE g_bgda001_str            STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_bgda_m          type_g_bgda_m
DEFINE g_bgda_m_t        type_g_bgda_m
DEFINE g_bgda_m_o        type_g_bgda_m
 
   DEFINE g_bgda001_t LIKE bgda_t.bgda001
DEFINE g_bgda002_t LIKE bgda_t.bgda002
DEFINE g_bgda003_t LIKE bgda_t.bgda003
 
 
DEFINE g_bgdb_d          DYNAMIC ARRAY OF type_g_bgdb_d
DEFINE g_bgdb_d_t        type_g_bgdb_d
DEFINE g_bgdb_d_o        type_g_bgdb_d
 
 
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
          b_bgda001 LIKE bgda_t.bgda001,
      b_bgda002 LIKE bgda_t.bgda002,
      b_bgda003 LIKE bgda_t.bgda003
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
 
{<section id="abgi410.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bgda001,'',bgda002,'','',bgdastus,'',bgda003,'',bgda005,'',bgdaownid, 
       '',bgdaowndp,'',bgdacrtid,'',bgdacrtdp,'',bgdacrtdt,bgdamodid,'',bgdamoddt,bgdacnfid,'',bgdacnfdt", 
        
                      " FROM bgda_t",
                      " WHERE bgdaent= ? AND bgda001=? AND bgda002=? AND bgda003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgda001,t0.bgda002,t0.bgdastus,t0.bgda003,t0.bgda005,t0.bgdaownid, 
       t0.bgdaowndp,t0.bgdacrtid,t0.bgdacrtdp,t0.bgdacrtdt,t0.bgdamodid,t0.bgdamoddt,t0.bgdacnfid,t0.bgdacnfdt, 
       t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011",
               " FROM bgda_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=bgda001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=bgdaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=bgdaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=bgdacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=bgdacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgdamodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=bgdacnfid  ",
 
               " WHERE t0.bgdaent = " ||g_enterprise|| " AND t0.bgda001 = ? AND t0.bgda002 = ? AND t0.bgda003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   LET g_sql = " SELECT DISTINCT t0.bgda001,t0.bgda002,t0.bgdastus,t0.bgda003,t0.bgda005,t0.bgdaownid, 
       t0.bgdaowndp,t0.bgdacrtid,t0.bgdacrtdp,t0.bgdacrtdt,t0.bgdamodid,t0.bgdamoddt,t0.bgdacnfid,t0.bgdacnfdt, 
       t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011",
               " FROM bgda_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=bgda001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=bgdaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=bgdaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=bgdacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=bgdacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgdamodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=bgdacnfid  ",
 
               " WHERE t0.bgdaent = " ||g_enterprise|| " AND t0.bgda001 = ? AND t0.bgda002 = ? AND t0.bgda003 = ?",
               "   AND t0.bgda005 IS NULL"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE abgi410_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgi410 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgi410_init()   
 
      #進入選單 Menu (="N")
      CALL abgi410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgi410
      
   END IF 
   
   CLOSE abgi410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgi410.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgi410_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   
      CALL cl_set_combo_scc_part('bgdastus','50','N,Y,X')
 
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('bgas005','1001')
   IF g_prog = 'abgi415' THEN 
      CALL cl_set_comp_visible('bgda001',TRUE)
   ELSE
      CALL cl_set_comp_visible('bgda001',FALSE)
   END IF
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
   CALL abgi410_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgi410.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgi410_ui_dialog()
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
   LET g_wc = " 1=2 "
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bgda_m.* TO NULL
         CALL g_bgdb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgi410_init()
      END IF
   
      CALL abgi410_browser_fill()
      
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
               
               CALL abgi410_fetch('') # reload data
               #LET g_detail_idx = 1
               CALL abgi410_ui_detailshow() #Setting the current row 
      
               CALL abgi410_idx_chk()
               #NEXT FIELD bgdbseq
         
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL abgi410_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
               
               ON COLLAPSE (g_row_index)
                  #樹關閉
         
         END DISPLAY
        
         DISPLAY ARRAY g_bgdb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               CALL abgi410_idx_chk()
               LET g_detail_idx = ARR_CURR()
               
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL abgi410_idx_chk()
               
            
               
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
               CALL abgi410_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgi410_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abgi410_idx_chk()
            
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog2"
            
            #end add-point
            
            #NEXT FIELD bgdbseq
      
         #Browser用Action
      
         #一般搜尋
         ON ACTION searchdata
            #取得搜尋關鍵字
            INITIALIZE g_wc TO NULL
            INITIALIZE g_wc2 TO NULL
            INITIALIZE g_wc_table1 TO NULL
 
            LET g_searchstr = GET_FLDBUF(searchstr)
            IF NOT abgi410_browser_search("normal") THEN
               CONTINUE DIALOG
            END IF
            LET g_current_idx = 1
            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -100 
               LET g_errparam.popup = TRUE 
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
            
            IF NOT abgi410_browser_search("normal") THEN
               CONTINUE DIALOG
            END IF
            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -100 
               LET g_errparam.popup = TRUE 
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
            
            IF NOT abgi410_browser_search("normal") THEN
               CONTINUE DIALOG
            END IF
            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -100 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
 
            END IF   
            LET g_action_choice = "DESCENDING"
            EXIT DIALOG
            
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abgi410_statechange()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bgdb_d)
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
               NEXT FIELD b_bgda001
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
               CALL abgi410_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgi410_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgi410_02
            LET g_action_choice="open_abgi410_02"
            IF cl_auth_chk_act("open_abgi410_02") THEN
               
               #add-point:ON ACTION open_abgi410_02 name="menu.open_abgi410_02"
               CALL abgi410_02()
               CALL abgi410_browser_fill()
               CALL abgi410_fetch_1()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgi410_01
            LET g_action_choice="open_abgi410_01"
            IF cl_auth_chk_act("open_abgi410_01") THEN
               
               #add-point:ON ACTION open_abgi410_01 name="menu.open_abgi410_01"
               CALL abgi410_01()
               CALL abgi410_browser_fill()
               CALL abgi410_fetch_1()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgi410_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgi410_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
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
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgi410_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgi410_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgi410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgi410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgi410_set_pk_array()
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
 
{<section id="abgi410.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgi410_browser_search(p_type)
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
      LET g_errparam.code = "std-00005" 
      LET g_errparam.popup = FALSE 
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
      LET g_wc = g_wc, " ORDER BY bgda001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL abgi410_browser_fill()
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgi410_browser_fill()
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
   DEFINE l_ooef001_str     STRING    #161215-00051#1
   #end add-point    
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
 
   #end add-point
   
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_bgda_m.* TO NULL
   CALL g_bgdb_d.clear()        
 
   CALL g_browser.clear()
   
   IF NOT cl_null(g_wc2) AND g_wc2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2
      LET g_sql = " SELECT DISTINCT t0.bgda001,t0.bgda002,t0.bgda003 FROM bgda_t t0",
                  " INNER JOIN bgdb_t ON bgdaent = " ||g_enterprise|| " AND bgdb002 = bgda002 ",
                  
                  " WHERE bgdaent = " ||g_enterprise|| " AND ", g_wc
   ELSE 
      LET g_sql = " SELECT DISTINCT t0.bgda001,t0.bgda002,t0.bgda003 FROM bgda_t t0",
                  
                  " WHERE bgdaent = " ||g_enterprise|| " AND ", g_wc   
   END IF   
   
   LET g_sql = g_sql, cl_sql_add_filter("bgda_t"),
                      " ORDER BY bgda001,bgda002,bgda003 "
 
   #add-point:browser填充前 name="browser_fill.before_browser"
   IF g_prog = 'abgi410' THEN 
      LET g_wc = g_wc," AND bgda001 = 'ALL' "
   ELSE
      LET g_wc = g_wc," AND bgda001 <> 'ALL' "
      
      #161215-00051#1--add--str--lujh
      #檢查預算組織是否在abgi090中可操作的組織中
      CALL s_abg2_get_budget_site('','',g_user,'02') RETURNING l_ooef001_str
      CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
      LET g_wc = g_wc," AND bgda001 IN ",l_ooef001_str
      #161215-00051#1--add--end--lujh
   END IF
   
   IF NOT cl_null(g_wc2) AND g_wc2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2
      LET g_sql = " SELECT DISTINCT t0.bgda001,t0.bgda002,t0.bgda003 FROM bgda_t t0",
                  " INNER JOIN bgdb_t ON bgdb002 = bgda002 ",
                  
                  " WHERE bgdaent = " ||g_enterprise|| " AND ", g_wc,
                  #"   AND bgda001 = '",g_site,"'",
                  "   AND (SELECT COUNT(*) FROM bgdb_t t1 ",
                  "         WHERE t1.bgdbent = ",g_enterprise,
                  "           AND t0.bgda001 = t1.bgdb001 ",
                  #"           AND t0.bgda003 = t1.bgdb003 ",              
                  "           AND t0.bgda002 = t1.bgdb004 ",
                  "           ) = 0 ",
                  "   AND bgda005 IS NULL "                
   ELSE 
      LET g_sql = " SELECT DISTINCT t0.bgda001,t0.bgda002,t0.bgda003 FROM bgda_t t0",
                  
                  " WHERE bgdaent = " ||g_enterprise|| " AND ", g_wc,
                  #"   AND bgda001 = '",g_site,"'",
                  "   AND (SELECT COUNT(*) FROM bgdb_t t1 ",
                  "         WHERE t1.bgdbent = ",g_enterprise,
                  "           AND t0.bgda001 = t1.bgdb001 ",
                  #"           AND t0.bgda003 = t1.bgdb003 ",              
                  "           AND t0.bgda002 = t1.bgdb004 ",
                  "           ) = 0 ",
                  "   AND bgda005 IS NULL "                  
   END IF   
   
   LET g_sql = g_sql, cl_sql_add_filter("bgda_t"),
                      " ORDER BY bgda001,bgda002,bgda003 "
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
 
      FOREACH browse_cur    #(ver:36)
         INTO g_browser[g_cnt].b_bgda001,g_browser[g_cnt].b_bgda002,g_browser[g_cnt].b_bgda003    #(ver:36) 
 
 
         #(ver:36) ---start---
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         #(ver:36) --- end ---
      
         LET g_browser[g_cnt].b_pid  = l_type
         LET g_browser[g_cnt].b_id   = l_type, '.', g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp  = FALSE
         LET g_browser[g_cnt].b_hasC = abgi410_chk_hasC(g_cnt)
         CALL abgi410_desc_show(g_cnt)
      
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
         LET g_errparam.code = 9035 
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
 
{<section id="abgi410.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgi410_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point   
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bgda_m.bgda001 = g_browser[g_current_idx].b_bgda001   
   LET g_bgda_m.bgda002 = g_browser[g_current_idx].b_bgda002   
   LET g_bgda_m.bgda003 = g_browser[g_current_idx].b_bgda003   
 
   EXECUTE abgi410_master_referesh USING g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgda_m.bgda001, 
       g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp, 
       g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt, 
       g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt,g_bgda_m.bgda001_desc,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp_desc, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdamodid_desc,g_bgda_m.bgdacnfid_desc 
 
   CALL abgi410_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgi410_ui_detailshow()
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
 
{<section id="abgi410.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgi410_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_bgda001 = g_bgda_m.bgda001 
         AND g_browser[l_i].b_bgda002 = g_bgda_m.bgda002 
         AND g_browser[l_i].b_bgda003 = g_bgda_m.bgda003 
 
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
 
{<section id="abgi410.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgi410_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_wc       STRING
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ooef001_str     STRING    #161215-00051#1
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   LET g_bgda001_str = ''
   #end add-point
   
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_bgda_m.* TO NULL
   CALL g_bgdb_d.clear()        
 
   
   LET g_current_idx = 1
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bgda001,bgda002,bgasl003,bgasl004,bgdastus,bgas004,bgda003,bgas005,bgda005, 
          bgas310,bgdaownid,bgdaowndp,bgdacrtid,bgdacrtdp,bgdacrtdt,bgdamodid,bgdamoddt,bgdacnfid,bgdacnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgdacrtdt>>----
         AFTER FIELD bgdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgdamoddt>>----
         AFTER FIELD bgdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgdacnfdt>>----
         AFTER FIELD bgdacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgdapstdt>>----
 
 
 
            
                  #Ctrlp:construct.c.bgda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda001
            #add-point:ON ACTION controlp INFIELD bgda001 name="construct.c.bgda001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161215-00051#1--add--str--lujh
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'02') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = "  ooef001 IN ",l_ooef001_str
            #161215-00051#1--add--end--lujh
            CALL q_ooef001_77()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgda001  #顯示到畫面上
            NEXT FIELD bgda001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda001
            #add-point:BEFORE FIELD bgda001 name="construct.b.bgda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda001
            
            #add-point:AFTER FIELD bgda001 name="construct.a.bgda001"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_bgda001_str
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda002
            #add-point:ON ACTION controlp INFIELD bgda002 name="construct.c.bgda002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgda002  #顯示到畫面上
            NEXT FIELD bgda002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda002
            #add-point:BEFORE FIELD bgda002 name="construct.b.bgda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda002
            
            #add-point:AFTER FIELD bgda002 name="construct.a.bgda002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl003
            #add-point:BEFORE FIELD bgasl003 name="construct.b.bgasl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl003
            
            #add-point:AFTER FIELD bgasl003 name="construct.a.bgasl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgasl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl003
            #add-point:ON ACTION controlp INFIELD bgasl003 name="construct.c.bgasl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl004
            #add-point:BEFORE FIELD bgasl004 name="construct.b.bgasl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl004
            
            #add-point:AFTER FIELD bgasl004 name="construct.a.bgasl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgasl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl004
            #add-point:ON ACTION controlp INFIELD bgasl004 name="construct.c.bgasl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdastus
            #add-point:BEFORE FIELD bgdastus name="construct.b.bgdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdastus
            
            #add-point:AFTER FIELD bgdastus name="construct.a.bgdastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdastus
            #add-point:ON ACTION controlp INFIELD bgdastus name="construct.c.bgdastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgas004
            #add-point:BEFORE FIELD bgas004 name="construct.b.bgas004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgas004
            
            #add-point:AFTER FIELD bgas004 name="construct.a.bgas004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgas004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgas004
            #add-point:ON ACTION controlp INFIELD bgas004 name="construct.c.bgas004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda003
            #add-point:BEFORE FIELD bgda003 name="construct.b.bgda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda003
            
            #add-point:AFTER FIELD bgda003 name="construct.a.bgda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda003
            #add-point:ON ACTION controlp INFIELD bgda003 name="construct.c.bgda003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgas005
            #add-point:BEFORE FIELD bgas005 name="construct.b.bgas005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgas005
            
            #add-point:AFTER FIELD bgas005 name="construct.a.bgas005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgas005
            #add-point:ON ACTION controlp INFIELD bgas005 name="construct.c.bgas005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda005
            #add-point:BEFORE FIELD bgda005 name="construct.b.bgda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda005
            
            #add-point:AFTER FIELD bgda005 name="construct.a.bgda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda005
            #add-point:ON ACTION controlp INFIELD bgda005 name="construct.c.bgda005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgas310
            #add-point:BEFORE FIELD bgas310 name="construct.b.bgas310"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgas310
            
            #add-point:AFTER FIELD bgas310 name="construct.a.bgas310"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgas310
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgas310
            #add-point:ON ACTION controlp INFIELD bgas310 name="construct.c.bgas310"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdaownid
            #add-point:ON ACTION controlp INFIELD bgdaownid name="construct.c.bgdaownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdaownid  #顯示到畫面上
            NEXT FIELD bgdaownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdaownid
            #add-point:BEFORE FIELD bgdaownid name="construct.b.bgdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdaownid
            
            #add-point:AFTER FIELD bgdaownid name="construct.a.bgdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdaowndp
            #add-point:ON ACTION controlp INFIELD bgdaowndp name="construct.c.bgdaowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdaowndp  #顯示到畫面上
            NEXT FIELD bgdaowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdaowndp
            #add-point:BEFORE FIELD bgdaowndp name="construct.b.bgdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdaowndp
            
            #add-point:AFTER FIELD bgdaowndp name="construct.a.bgdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdacrtid
            #add-point:ON ACTION controlp INFIELD bgdacrtid name="construct.c.bgdacrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdacrtid  #顯示到畫面上
            NEXT FIELD bgdacrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdacrtid
            #add-point:BEFORE FIELD bgdacrtid name="construct.b.bgdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdacrtid
            
            #add-point:AFTER FIELD bgdacrtid name="construct.a.bgdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdacrtdp
            #add-point:ON ACTION controlp INFIELD bgdacrtdp name="construct.c.bgdacrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdacrtdp  #顯示到畫面上
            NEXT FIELD bgdacrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdacrtdp
            #add-point:BEFORE FIELD bgdacrtdp name="construct.b.bgdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdacrtdp
            
            #add-point:AFTER FIELD bgdacrtdp name="construct.a.bgdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdacrtdt
            #add-point:BEFORE FIELD bgdacrtdt name="construct.b.bgdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdamodid
            #add-point:ON ACTION controlp INFIELD bgdamodid name="construct.c.bgdamodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdamodid  #顯示到畫面上
            NEXT FIELD bgdamodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdamodid
            #add-point:BEFORE FIELD bgdamodid name="construct.b.bgdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdamodid
            
            #add-point:AFTER FIELD bgdamodid name="construct.a.bgdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdamoddt
            #add-point:BEFORE FIELD bgdamoddt name="construct.b.bgdamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdacnfid
            #add-point:ON ACTION controlp INFIELD bgdacnfid name="construct.c.bgdacnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdacnfid  #顯示到畫面上
            NEXT FIELD bgdacnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdacnfid
            #add-point:BEFORE FIELD bgdacnfid name="construct.b.bgdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdacnfid
            
            #add-point:AFTER FIELD bgdacnfid name="construct.a.bgdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdacnfdt
            #add-point:BEFORE FIELD bgdacnfdt name="construct.b.bgdacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table1 ON bgdbseq,bgdb004,bgasl003,bgasl004,bgdb005,bgdb006,bgdb007,bgdb008,bgda003, 
          bgdb009
           FROM s_detail1[1].bgdbseq,s_detail1[1].bgdb004,s_detail1[1].bgasl003,s_detail1[1].bgasl004, 
               s_detail1[1].bgdb005,s_detail1[1].bgdb006,s_detail1[1].bgdb007,s_detail1[1].bgdb008,s_detail1[1].bgda003, 
               s_detail1[1].bgdb009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdbseq
            #add-point:BEFORE FIELD bgdbseq name="construct.b.page1.bgdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdbseq
            
            #add-point:AFTER FIELD bgdbseq name="construct.a.page1.bgdbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdbseq
            #add-point:ON ACTION controlp INFIELD bgdbseq name="construct.c.page1.bgdbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb004
            #add-point:ON ACTION controlp INFIELD bgdb004 name="construct.c.page1.bgdb004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdb004  #顯示到畫面上
            NEXT FIELD bgdb004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb004
            #add-point:BEFORE FIELD bgdb004 name="construct.b.page1.bgdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb004
            
            #add-point:AFTER FIELD bgdb004 name="construct.a.page1.bgdb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl003
            #add-point:BEFORE FIELD bgasl003 name="construct.b.page1.bgasl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl003
            
            #add-point:AFTER FIELD bgasl003 name="construct.a.page1.bgasl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgasl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl003
            #add-point:ON ACTION controlp INFIELD bgasl003 name="construct.c.page1.bgasl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl004
            #add-point:BEFORE FIELD bgasl004 name="construct.b.page1.bgasl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl004
            
            #add-point:AFTER FIELD bgasl004 name="construct.a.page1.bgasl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgasl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl004
            #add-point:ON ACTION controlp INFIELD bgasl004 name="construct.c.page1.bgasl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb005
            #add-point:BEFORE FIELD bgdb005 name="construct.b.page1.bgdb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb005
            
            #add-point:AFTER FIELD bgdb005 name="construct.a.page1.bgdb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgdb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb005
            #add-point:ON ACTION controlp INFIELD bgdb005 name="construct.c.page1.bgdb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb006
            #add-point:BEFORE FIELD bgdb006 name="construct.b.page1.bgdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb006
            
            #add-point:AFTER FIELD bgdb006 name="construct.a.page1.bgdb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb006
            #add-point:ON ACTION controlp INFIELD bgdb006 name="construct.c.page1.bgdb006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bgdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb007
            #add-point:ON ACTION controlp INFIELD bgdb007 name="construct.c.page1.bgdb007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgdb007  #顯示到畫面上
            NEXT FIELD bgdb007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb007
            #add-point:BEFORE FIELD bgdb007 name="construct.b.page1.bgdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb007
            
            #add-point:AFTER FIELD bgdb007 name="construct.a.page1.bgdb007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb008
            #add-point:BEFORE FIELD bgdb008 name="construct.b.page1.bgdb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb008
            
            #add-point:AFTER FIELD bgdb008 name="construct.a.page1.bgdb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgdb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb008
            #add-point:ON ACTION controlp INFIELD bgdb008 name="construct.c.page1.bgdb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda003
            #add-point:BEFORE FIELD bgda003 name="construct.b.page1.bgda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda003
            
            #add-point:AFTER FIELD bgda003 name="construct.a.page1.bgda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda003
            #add-point:ON ACTION controlp INFIELD bgda003 name="construct.c.page1.bgda003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb009
            #add-point:BEFORE FIELD bgdb009 name="construct.b.page1.bgdb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb009
            
            #add-point:AFTER FIELD bgdb009 name="construct.a.page1.bgdb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgdb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb009
            #add-point:ON ACTION controlp INFIELD bgdb009 name="construct.c.page1.bgdb009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      AFTER DIALOG
         IF cl_null(g_bgda001_str) AND g_prog = 'abgi415' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'abg-00246'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD bgda001
         END IF
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         IF g_prog = 'abgi415' THEN 
            DISPLAY g_site TO bgda001
         END IF
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
   
   #end add-point
   
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgi410_query()
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
   CALL g_bgdb_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count   
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   #add-point:query段before constrcut name="query.before_constrcut"
   
   #end add-point
   
   CALL abgi410_construct()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_bgda_m.* TO NULL
      LET g_wc = " 1=1"
      LET g_wc2 = " 1=1"
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      RETURN
   END IF
   
   LET g_error_show = 1
   CALL abgi410_browser_fill()
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
 
   ELSE
      CALL abgi410_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgi410_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
  
   #add-point:Function前置處理  name="fetch.before_fetch"
   CALL abgi410_fetch_1()
   RETURN
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
   
   LET g_bgda_m.bgda001 = g_browser[g_current_idx].b_bgda001
   LET g_bgda_m.bgda002 = g_browser[g_current_idx].b_bgda002
   LET g_bgda_m.bgda003 = g_browser[g_current_idx].b_bgda003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgi410_master_referesh USING g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgda_m.bgda001, 
       g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp, 
       g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt, 
       g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt,g_bgda_m.bgda001_desc,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp_desc, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdamodid_desc,g_bgda_m.bgdacnfid_desc 
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgda_t:",SQLERRMESSAGE  
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
 
      INITIALIZE g_bgda_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_bgda_m_t.* = g_bgda_m.*
   LET g_bgda_m_o.* = g_bgda_m.*
   
   #重新顯示   
   CALL abgi410_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgi410_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM                    #清畫面欄位內容
   CALL g_bgdb_d.clear()    #清除陣列
 
 
   INITIALIZE g_bgda_m.* TO NULL             #DEFAULT 設定
   LET g_bgda001_t = NULL
   LET g_bgda002_t = NULL
   LET g_bgda003_t = NULL
 
   
   CALL s_transaction_begin()
               
   WHILE TRUE
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgda_m.bgdaownid = g_user
      LET g_bgda_m.bgdaowndp = g_dept
      LET g_bgda_m.bgdacrtid = g_user
      LET g_bgda_m.bgdacrtdp = g_dept 
      LET g_bgda_m.bgdacrtdt = cl_get_current()
      LET g_bgda_m.bgdamodid = g_user
      LET g_bgda_m.bgdamoddt = cl_get_current()
      LET g_bgda_m.bgdastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #單頭預設值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_bgda_m.bgda003 = g_today
      IF g_prog = 'abgi415' THEN 
         SELECT ooef017 INTO g_bgda_m.bgda001
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site
         CALL s_desc_get_department_desc(g_bgda_m.bgda001) RETURNING g_bgda_m.bgda001_desc
         DISPLAY BY NAME g_bgda_m.bgda001_desc
      ELSE
         LET g_bgda_m.bgda001 = 'ALL'
      END IF
      #end add-point 
     
      CALL abgi410_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_bgda_m.* = g_bgda_m_t.*
         CALL abgi410_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #CALL g_bgdb_d.clear()
 
 
      LET g_rec_b = 0
      EXIT WHILE
        
   END WHILE
   
   #功能已完成,通報訊息中心
   CALL abgi410_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgi410_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_bgda_m.bgda001 IS NULL
   OR g_bgda_m.bgda002 IS NULL
   OR g_bgda_m.bgda003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE abgi410_master_referesh USING g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgda_m.bgda001, 
       g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp, 
       g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt, 
       g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt,g_bgda_m.bgda001_desc,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp_desc, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdamodid_desc,g_bgda_m.bgdacnfid_desc 
 
 
   #檢查是否允許此動作
   IF NOT abgi410_action_chk() THEN
      RETURN
   END IF
  
   LET g_bgda001_t = g_bgda_m.bgda001
   LET g_bgda002_t = g_bgda_m.bgda002
   LET g_bgda003_t = g_bgda_m.bgda003
 
   CALL s_transaction_begin()
   
   OPEN abgi410_cl USING g_enterprise,g_bgda_m.bgda001
                                                       ,g_bgda_m.bgda002
                                                       ,g_bgda_m.bgda003
 
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE abgi410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH abgi410_cl INTO g_bgda_m.bgda001,g_bgda_m.bgda001_desc,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004, 
       g_bgda_m.bgdastus,g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310, 
       g_bgda_m.bgdaownid,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp,g_bgda_m.bgdaowndp_desc,g_bgda_m.bgdacrtid, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid, 
       g_bgda_m.bgdamodid_desc,g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfid_desc,g_bgda_m.bgdacnfdt 
 
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.SQLCODE THEN
      CLOSE abgi410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_bgda_m.bgda001,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
 
   CALL abgi410_show()
   WHILE TRUE
      LET g_bgda001_t = g_bgda_m.bgda001
      LET g_bgda002_t = g_bgda_m.bgda002
      LET g_bgda003_t = g_bgda_m.bgda003
 
      
      #寫入修改者/修改日期資訊
      LET g_bgda_m.bgdamodid = g_user 
LET g_bgda_m.bgdamoddt = cl_get_current()
LET g_bgda_m.bgdamodid_desc = cl_get_username(g_bgda_m.bgdamodid)
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgi410_input("u")     #欄位更改
 
      #add-point:modify段修改後 name="modify.after_input"
    
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_bgda_m.* = g_bgda_m_t.*
         CALL abgi410_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若有modid跟moddt則進行update
      UPDATE bgda_t SET (bgdamodid,bgdamoddt) = (g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt)
       WHERE bgdaent = g_enterprise AND bgda001 = g_bgda001_t
         AND bgda002 = g_bgda002_t
         AND bgda003 = g_bgda003_t
 
      
      #若單頭key欄位有變更
      IF g_bgda_m.bgda001 != g_bgda001_t 
      OR g_bgda_m.bgda002 != g_bgda002_t 
      OR g_bgda_m.bgda003 != g_bgda003_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         CALL s_transaction_end('Y','0')
         {
         #end add-point
         
         #更新單身key值
         UPDATE bgdb_t SET bgdb001 = g_bgda_m.bgda001
                                      ,bgdb002 = g_bgda_m.bgda002
                                      ,bgdb003 = g_bgda_m.bgda003
 
          WHERE bgdbent = g_enterprise AND bgdb001 = g_bgda001_t
            AND bgdb002 = g_bgda002_t
            AND bgdb003 = g_bgda003_t
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgdb_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         }
         CALL s_transaction_begin()
         
         LET g_bgda_m.bgdamodid = g_user 
         LET g_bgda_m.bgdamoddt = cl_get_current()
         LET g_bgda_m.bgdamodid_desc = cl_get_username(g_bgda_m.bgdamodid)
         UPDATE bgda_t SET (bgdamodid,bgdamoddt) = (g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt)
          WHERE bgdaent = g_enterprise AND bgda001 = g_bgda001_t
            AND bgda002 = g_bgda002_t
            AND bgda003 = g_bgda003_t
         #end add-point
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
      
      EXIT WHILE
   END WHILE
 
   CLOSE abgi410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgi410_msgcentre_notify('modify')
 
END FUNCTION   
 
{</section>}
 
{<section id="abgi410.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgi410_input(p_cmd)
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
   DEFINE  l_loop                LIKE type_t.chr1
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_site_str            STRING
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   LET l_site_str = ''
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bgda_m.bgda001,g_bgda_m.bgda001_desc,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004, 
       g_bgda_m.bgdastus,g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310, 
       g_bgda_m.bgdaownid,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp,g_bgda_m.bgdaowndp_desc,g_bgda_m.bgdacrtid, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid, 
       g_bgda_m.bgdamodid_desc,g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfid_desc,g_bgda_m.bgdacnfdt 
 
   
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT bgdbseq,bgdb004,bgdb005,bgdb006,bgdb007,bgdb008,bgdb009 FROM bgdb_t WHERE  
       bgdbent=? AND bgdb001=? AND bgdb002=? AND bgdb003=? AND bgdbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE abgi410_bcl CURSOR FROM g_forupd_sql
   
 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   LET lb_reproduce = FALSE
   
   #控制key欄位可否輸入
   CALL abgi410_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgi410_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   LET g_errshow = 1
   #end add-point
   
   DISPLAY BY NAME g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004,g_bgda_m.bgdastus, 
       g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgi410.input.head" >}
      #單頭段
      INPUT BY NAME g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004,g_bgda_m.bgdastus, 
          g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310 
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
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda001
            
            #add-point:AFTER FIELD bgda001 name="input.a.bgda001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgda_m.bgda001) AND NOT cl_null(g_bgda_m.bgda002) AND NOT cl_null(g_bgda_m.bgda003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgda_m.bgda001 != g_bgda001_t  OR g_bgda_m.bgda002 != g_bgda002_t  OR g_bgda_m.bgda003 != g_bgda003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgda_t WHERE "||"bgdaent = " ||g_enterprise|| " AND "||"bgda001 = '"||g_bgda_m.bgda001 ||"' AND "|| "bgda002 = '"||g_bgda_m.bgda002 ||"' AND "|| "bgda003 = '"||g_bgda_m.bgda003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_bgda_m.bgda001) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgda_m.bgda001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_24") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_abg2_get_budget_site('','',g_user,'02') RETURNING l_site_str
                  IF cl_null(l_site_str) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00248'
                     LET g_errparam.extend = g_bgda_m.bgda001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgda_m.bgda001 = ''
                     LET g_bgda_m.bgda001_desc = ''
                     DISPLAY BY NAME g_bgda_m.bgda001_desc 
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查預算組織是否在abgi090中可操作的組織中
                  IF s_chr_get_index_of(l_site_str,g_bgda_m.bgda001,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00255'
                     LET g_errparam.extend = g_bgda_m.bgda001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgda_m.bgda001 = ''
                     LET g_bgda_m.bgda001_desc = ''
                     DISPLAY BY NAME g_bgda_m.bgda001_desc 
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgda_m.bgda001 = ''
                  LET g_bgda_m.bgda001_desc = ''
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_bgda_m.bgda001) RETURNING g_bgda_m.bgda001_desc
            DISPLAY BY NAME g_bgda_m.bgda001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda001
            #add-point:BEFORE FIELD bgda001 name="input.b.bgda001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgda001
            #add-point:ON CHANGE bgda001 name="input.g.bgda001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda002
            
            #add-point:AFTER FIELD bgda002 name="input.a.bgda002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgda_m.bgda001) AND NOT cl_null(g_bgda_m.bgda002) AND NOT cl_null(g_bgda_m.bgda003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgda_m.bgda001 != g_bgda001_t  OR g_bgda_m.bgda002 != g_bgda002_t  OR g_bgda_m.bgda003 != g_bgda003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgda_t WHERE "||"bgdaent = " ||g_enterprise|| " AND "||"bgda001 = '"||g_bgda_m.bgda001 ||"' AND "|| "bgda002 = '"||g_bgda_m.bgda002 ||"' AND "|| "bgda003 = '"||g_bgda_m.bgda003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bgda_m.bgda002) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgda_m.bgda002
               LET g_chkparam.err_str[1] = "sub-01302:sub-01302|abgi165|",cl_get_progname("abgi165",g_lang,"2"),"|:EXEPROGabgi165" 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgas001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT COUNT(1) INTO l_n
                    FROM bgda_t
                   WHERE bgdaent = g_enterprise
                     AND bgda001 = g_bgda_m.bgda001
                     AND bgda002 = g_bgda_m.bgda002
                     
                  IF l_n > 0 THEN 
                     IF cl_ask_confirm('abg-00238') THEN 
                        CALL s_abgi410_invalid(g_bgda_m.bgda001,g_bgda_m.bgda002) RETURNING l_success
                        IF l_success = FALSE THEN 
                           CALL s_transaction_end('N','0') 
                        END IF
                     ELSE
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgda_m.bgda002 = ''
                  CALL abgi410_bgda002_get(g_bgda_m.bgda002)
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL abgi410_bgda002_get(g_bgda_m.bgda002)
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda002
            #add-point:BEFORE FIELD bgda002 name="input.b.bgda002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgda002
            #add-point:ON CHANGE bgda002 name="input.g.bgda002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl003
            #add-point:BEFORE FIELD bgasl003 name="input.b.bgasl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl003
            
            #add-point:AFTER FIELD bgasl003 name="input.a.bgasl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgasl003
            #add-point:ON CHANGE bgasl003 name="input.g.bgasl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl004
            #add-point:BEFORE FIELD bgasl004 name="input.b.bgasl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl004
            
            #add-point:AFTER FIELD bgasl004 name="input.a.bgasl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgasl004
            #add-point:ON CHANGE bgasl004 name="input.g.bgasl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdastus
            #add-point:BEFORE FIELD bgdastus name="input.b.bgdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdastus
            
            #add-point:AFTER FIELD bgdastus name="input.a.bgdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdastus
            #add-point:ON CHANGE bgdastus name="input.g.bgdastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgas004
            #add-point:BEFORE FIELD bgas004 name="input.b.bgas004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgas004
            
            #add-point:AFTER FIELD bgas004 name="input.a.bgas004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgas004
            #add-point:ON CHANGE bgas004 name="input.g.bgas004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda003
            #add-point:BEFORE FIELD bgda003 name="input.b.bgda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda003
            
            #add-point:AFTER FIELD bgda003 name="input.a.bgda003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgda_m.bgda001) AND NOT cl_null(g_bgda_m.bgda002) AND NOT cl_null(g_bgda_m.bgda003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgda_m.bgda001 != g_bgda001_t  OR g_bgda_m.bgda002 != g_bgda002_t  OR g_bgda_m.bgda003 != g_bgda003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgda_t WHERE "||"bgdaent = " ||g_enterprise|| " AND "||"bgda001 = '"||g_bgda_m.bgda001 ||"' AND "|| "bgda002 = '"||g_bgda_m.bgda002 ||"' AND "|| "bgda003 = '"||g_bgda_m.bgda003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgda003
            #add-point:ON CHANGE bgda003 name="input.g.bgda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgas005
            #add-point:BEFORE FIELD bgas005 name="input.b.bgas005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgas005
            
            #add-point:AFTER FIELD bgas005 name="input.a.bgas005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgas005
            #add-point:ON CHANGE bgas005 name="input.g.bgas005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda005
            #add-point:BEFORE FIELD bgda005 name="input.b.bgda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda005
            
            #add-point:AFTER FIELD bgda005 name="input.a.bgda005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgda005
            #add-point:ON CHANGE bgda005 name="input.g.bgda005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgas310
            #add-point:BEFORE FIELD bgas310 name="input.b.bgas310"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgas310
            
            #add-point:AFTER FIELD bgas310 name="input.a.bgas310"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgas310
            #add-point:ON CHANGE bgas310 name="input.g.bgas310"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda001
            #add-point:ON ACTION controlp INFIELD bgda001 name="input.c.bgda001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgda_m.bgda001             #給予default值
            
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'02') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND ooef001 IN ",l_site_str
            ELSE
               LET g_qryparam.where = " ooef001 IN ",l_site_str
            END IF
            
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_77()                                #呼叫開窗
 
            LET g_bgda_m.bgda001 = g_qryparam.return1   
            CALL s_desc_get_department_desc(g_bgda_m.bgda001) RETURNING g_bgda_m.bgda001_desc
            DISPLAY BY NAME g_bgda_m.bgda001_desc                        
            DISPLAY g_bgda_m.bgda001 TO bgda001              #
            NEXT FIELD bgda001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda002
            #add-point:ON ACTION controlp INFIELD bgda002 name="input.c.bgda002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgda_m.bgda002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgas001()                                #呼叫開窗
 
            LET g_bgda_m.bgda002 = g_qryparam.return1              

            DISPLAY g_bgda_m.bgda002 TO bgda002              #
            CALL abgi410_bgda002_get(g_bgda_m.bgda002)
            NEXT FIELD bgda002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgasl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl003
            #add-point:ON ACTION controlp INFIELD bgasl003 name="input.c.bgasl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgasl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl004
            #add-point:ON ACTION controlp INFIELD bgasl004 name="input.c.bgasl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdastus
            #add-point:ON ACTION controlp INFIELD bgdastus name="input.c.bgdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgas004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgas004
            #add-point:ON ACTION controlp INFIELD bgas004 name="input.c.bgas004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda003
            #add-point:ON ACTION controlp INFIELD bgda003 name="input.c.bgda003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgas005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgas005
            #add-point:ON ACTION controlp INFIELD bgas005 name="input.c.bgas005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda005
            #add-point:ON ACTION controlp INFIELD bgda005 name="input.c.bgda005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgas310
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgas310
            #add-point:ON ACTION controlp INFIELD bgas310 name="input.c.bgas310"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
                
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bgda_m.bgda001             
                            ,g_bgda_m.bgda002   
                            ,g_bgda_m.bgda003   
 
 
            IF p_cmd <> 'u' THEN
               LET l_count = 1  
               
               SELECT COUNT(1) INTO l_count FROM bgda_t
                WHERE bgdaent = g_enterprise AND bgda001 = g_bgda_m.bgda001
                  AND bgda002 = g_bgda_m.bgda002
                  AND bgda003 = g_bgda_m.bgda003
 
               IF l_count = 0 THEN
                  
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
                  
                  INSERT INTO bgda_t (bgdaent,bgda001,bgda002,bgdastus,bgda003,bgda005,bgdaownid,bgdaowndp, 
                      bgdacrtid,bgdacrtdp,bgdacrtdt,bgdamodid,bgdamoddt,bgdacnfid,bgdacnfdt)
                  VALUES (g_enterprise,g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003, 
                      g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp,g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp, 
                      g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt)  
 
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "g_bgda_m:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
 
                     CONTINUE DIALOG
                  END IF
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
                  
                  IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                     CALL abgi410_detail_reproduce()
                  END IF
                  
                  LET p_cmd = 'u'
 
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =  g_bgda_m.bgda001 
                  LET g_errparam.code = '!' 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  NEXT FIELD bgda001
               END IF 
            ELSE
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               UPDATE bgda_t SET (bgda001,bgda002,bgdastus,bgda003,bgda005,bgdaownid,bgdaowndp,bgdacrtid, 
                   bgdacrtdp,bgdacrtdt,bgdamodid,bgdamoddt,bgdacnfid,bgdacnfdt) = (g_bgda_m.bgda001, 
                   g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid, 
                   g_bgda_m.bgdaowndp,g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid, 
                   g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt)
                WHERE bgdaent = g_enterprise AND bgda001 = g_bgda001_t
                  AND bgda002 = g_bgda002_t
                  AND bgda003 = g_bgda003_t
 
                  
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgda_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgda_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  OTHERWISE
                     
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     LET g_log1 = util.JSON.stringify(g_bgda_m_t)
                     LET g_log2 = util.JSON.stringify(g_bgda_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
 
            END IF
            LET g_bgda001_t = g_bgda_m.bgda001
            LET g_bgda002_t = g_bgda_m.bgda002
            LET g_bgda003_t = g_bgda_m.bgda003
 
           #controlp
      END INPUT
 
{</section>}
 
{<section id="abgi410.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi410_b_fill()
            LET g_rec_b = g_bgdb_d.getLength()
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
            OPEN abgi410_cl USING g_enterprise,g_bgda_m.bgda001
                                                                ,g_bgda_m.bgda002
                                                                ,g_bgda_m.bgda003
 
            IF SQLCA.SQLCODE THEN   #(ver:36)
               CLOSE abgi410_cl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgi410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               RETURN
            END IF
                   
            #FETCH abgi410_cl INTO g_bgda_m.bgda001,g_bgda_m.bgda001_desc,g_bgda_m.bgda002,g_bgda_m.bgasl003, 
            #    g_bgda_m.bgasl004,g_bgda_m.bgdastus,g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005, 
            #    g_bgda_m.bgda005,g_bgda_m.bgas310,g_bgda_m.bgdaownid,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp, 
            #    g_bgda_m.bgdaowndp_desc,g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp, 
            #    g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamodid_desc, 
            #    g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfid_desc,g_bgda_m.bgdacnfdt #鎖住將被更改或取消的資料 
 
            #IF SQLCA.SQLCODE THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = g_bgda_m.bgda001 
            #   LET g_errparam.code = SQLCA.SQLCODE 
            #   LET g_errparam.popup = FALSE 
            #   CALL cl_err()
            #   CLOSE abgi410_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_bgdb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bgdb_d[l_ac].bgdbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgdb_d_t.* = g_bgdb_d[l_ac].*  #BACKUP
               LET g_bgdb_d_o.* = g_bgdb_d[l_ac].*  #BACKUP
               CALL abgi410_set_entry_b(l_cmd)
               CALL abgi410_set_no_entry_b(l_cmd)
               IF NOT abgi410_lock_b("bgdb_t",'1') THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi410_bcl INTO g_bgdb_d[l_ac].bgdbseq,g_bgdb_d[l_ac].bgdb004,g_bgdb_d[l_ac].bgdb005, 
                      g_bgdb_d[l_ac].bgdb006,g_bgdb_d[l_ac].bgdb007,g_bgdb_d[l_ac].bgdb008,g_bgdb_d[l_ac].bgdb009 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bgdb_d_t.bgdbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL abgi410_show()
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
            INITIALIZE g_bgdb_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            
            #add-point:modify段before備份 name="input.body.before_bak"
            SELECT MAX(bgdbseq)+1 INTO g_bgdb_d[l_ac].bgdbseq
              FROM bgdb_t
             WHERE bgdbent = g_enterprise
               AND bgdb001 = g_bgda_m.bgda001
               AND bgdb002 = g_bgda_m.bgda002
               AND bgdb003 = g_bgda_m.bgda003
               
            IF cl_null(g_bgdb_d[l_ac].bgdbseq) THEN 
               LET g_bgdb_d[l_ac].bgdbseq = 1
            END IF
            #end add-point
            LET g_bgdb_d_t.* = g_bgdb_d[l_ac].*     #新輸入資料
            LET g_bgdb_d_o.* = g_bgdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgi410_set_entry_b(l_cmd)
            CALL abgi410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgdb_d[li_reproduce_target].* = g_bgdb_d[li_reproduce].*
 
               LET g_bgdb_d[g_bgdb_d.getLength()].bgdbseq = NULL
 
            END IF
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM bgdb_t 
             WHERE bgdbent = g_enterprise AND bgdb001 = g_bgda_m.bgda001
               AND bgdb002 = g_bgda_m.bgda002
               AND bgdb003 = g_bgda_m.bgda003
 
               AND g_bgdb_d[l_ac].bgdbseq = bgdbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgda_m.bgda001
               LET gs_keys[2] = g_bgda_m.bgda002
               LET gs_keys[3] = g_bgda_m.bgda003
               LET gs_keys[4] = g_bgdb_d[g_detail_idx].bgdbseq
               CALL abgi410_insert_b('bgdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_bgdb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               CALL s_transaction_end('N','0')                    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgdb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgi410_b_fill()
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
                  LET g_errparam.code =  -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point  
               
               DELETE FROM bgdb_t
                WHERE bgdbent = g_enterprise AND bgdb001 = g_bgda_m.bgda001 AND
                                          bgdb002 = g_bgda_m.bgda002 AND
                                          bgdb003 = g_bgda_m.bgda003 AND
 
                      bgdbseq = g_bgdb_d_t.bgdbseq
 
                  
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                  
               IF SQLCA.SQLCODE THEN
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bgdb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE abgi410_bcl
               LET l_count = g_bgdb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgda_m.bgda001
               LET gs_keys[2] = g_bgda_m.bgda002
               LET gs_keys[3] = g_bgda_m.bgda003
               LET gs_keys[4] = g_bgdb_d_t.bgdbseq
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL abgi410_delete_b('bgdb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgdb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdbseq
            #add-point:BEFORE FIELD bgdbseq name="input.b.page1.bgdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdbseq
            
            #add-point:AFTER FIELD bgdbseq name="input.a.page1.bgdbseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgda_m.bgda001 IS NOT NULL AND g_bgda_m.bgda002 IS NOT NULL AND g_bgda_m.bgda003 IS NOT NULL AND g_bgdb_d[g_detail_idx].bgdbseq IS NOT NULL AND g_bgdb_d[g_detail_idx].bgdb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgda_m.bgda001 != g_bgda001_t OR g_bgda_m.bgda002 != g_bgda002_t OR g_bgda_m.bgda003 != g_bgda003_t OR g_bgdb_d[g_detail_idx].bgdbseq != g_bgdb_d_t.bgdbseq OR g_bgdb_d[g_detail_idx].bgdb004 != g_bgdb_d_t.bgdb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgdb_t WHERE "||"bgdbent = " ||g_enterprise|| " AND "||"bgdb001 = '"||g_bgda_m.bgda001 ||"' AND "|| "bgdb002 = '"||g_bgda_m.bgda002 ||"' AND "|| "bgdb003 = '"||g_bgda_m.bgda003 ||"' AND "|| "bgdbseq = '"||g_bgdb_d[g_detail_idx].bgdbseq ||"' AND "|| "bgdb004 = '"||g_bgdb_d[g_detail_idx].bgdb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdbseq
            #add-point:ON CHANGE bgdbseq name="input.g.page1.bgdbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb004
            
            #add-point:AFTER FIELD bgdb004 name="input.a.page1.bgdb004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgda_m.bgda001 IS NOT NULL AND g_bgda_m.bgda002 IS NOT NULL AND g_bgda_m.bgda003 IS NOT NULL AND g_bgdb_d[g_detail_idx].bgdbseq IS NOT NULL AND g_bgdb_d[g_detail_idx].bgdb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgda_m.bgda001 != g_bgda001_t OR g_bgda_m.bgda002 != g_bgda002_t OR g_bgda_m.bgda003 != g_bgda003_t OR g_bgdb_d[g_detail_idx].bgdbseq != g_bgdb_d_t.bgdbseq OR g_bgdb_d[g_detail_idx].bgdb004 != g_bgdb_d_t.bgdb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgdb_t WHERE "||"bgdbent = " ||g_enterprise|| " AND "||"bgdb001 = '"||g_bgda_m.bgda001 ||"' AND "|| "bgdb002 = '"||g_bgda_m.bgda002 ||"' AND "|| "bgdb003 = '"||g_bgda_m.bgda003 ||"' AND "|| "bgdbseq = '"||g_bgdb_d[g_detail_idx].bgdbseq ||"' AND "|| "bgdb004 = '"||g_bgdb_d[g_detail_idx].bgdb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF g_bgdb_d[l_ac].bgdb004 = g_bgda_m.bgda002 THEN 
               LET g_errparam.extend = g_bgdb_d[l_ac].bgdb004
               LET g_errparam.code = 'abg-00225'
               LET g_errparam.popup = 1
               CALL cl_err()
               LET g_bgdb_d[l_ac].bgdb004 = g_bgdb_d_t.bgdb004
               CALL abgi410_bgda002_desc(g_bgdb_d[l_ac].bgdb004) RETURNING g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004
               DISPLAY g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004 TO s_detail[1].bgasl003,s_detail[1].bgasl004
               NEXT FIELD bgdb004
            END IF

            IF NOT cl_null(g_bgdb_d[l_ac].bgdb004) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgdb_d[l_ac].bgdb004
               LET g_chkparam.err_str[1] = "sub-01302:sub-01302|abgi165|",cl_get_progname("abgi165",g_lang,"2"),"|:EXEPROGabgi165" 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgas001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #檢查是否為無窮迴圈
                  CALL abgi410_tree_loop_chk(g_bgda_m.bgda002,g_bgdb_d[l_ac].bgdb004,NULL) RETURNING l_loop  
                  IF l_loop = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00026'
                     LET g_errparam.extend = g_bgdb_d[l_ac].bgdb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_bgdb_d[l_ac].bgdb004 = g_bgdb_d_t.bgdb004
                     CALL abgi410_bgda002_desc(g_bgdb_d[l_ac].bgdb004) RETURNING g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004
                     DISPLAY g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004 TO s_detail[1].bgasl003,s_detail[1].bgasl004
                     NEXT FIELD CURRENT
                  END IF

               ELSE
                  #檢查失敗時後續處理
                  LET g_bgdb_d[l_ac].bgdb004 = g_bgdb_d_t.bgdb004
                  CALL abgi410_bgda002_desc(g_bgdb_d[l_ac].bgdb004) RETURNING g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004
                  DISPLAY g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004 TO s_detail[1].bgasl003,s_detail[1].bgasl004
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL abgi410_bgda002_desc(g_bgdb_d[l_ac].bgdb004) RETURNING g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004
            DISPLAY g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004 TO s_detail[1].bgasl003,s_detail[1].bgasl004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb004
            #add-point:BEFORE FIELD bgdb004 name="input.b.page1.bgdb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdb004
            #add-point:ON CHANGE bgdb004 name="input.g.page1.bgdb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl003
            #add-point:BEFORE FIELD bgasl003 name="input.b.page1.bgasl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl003
            
            #add-point:AFTER FIELD bgasl003 name="input.a.page1.bgasl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgasl003
            #add-point:ON CHANGE bgasl003 name="input.g.page1.bgasl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgasl004
            #add-point:BEFORE FIELD bgasl004 name="input.b.page1.bgasl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgasl004
            
            #add-point:AFTER FIELD bgasl004 name="input.a.page1.bgasl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgasl004
            #add-point:ON CHANGE bgasl004 name="input.g.page1.bgasl004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgdb_d[l_ac].bgdb005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bgdb005
            END IF 
 
 
 
            #add-point:AFTER FIELD bgdb005 name="input.a.page1.bgdb005"
            IF NOT cl_null(g_bgdb_d[l_ac].bgdb005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb005
            #add-point:BEFORE FIELD bgdb005 name="input.b.page1.bgdb005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdb005
            #add-point:ON CHANGE bgdb005 name="input.g.page1.bgdb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgdb_d[l_ac].bgdb006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD bgdb006
            END IF 
 
 
 
            #add-point:AFTER FIELD bgdb006 name="input.a.page1.bgdb006"
            IF NOT cl_null(g_bgdb_d[l_ac].bgdb006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb006
            #add-point:BEFORE FIELD bgdb006 name="input.b.page1.bgdb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdb006
            #add-point:ON CHANGE bgdb006 name="input.g.page1.bgdb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb007
            
            #add-point:AFTER FIELD bgdb007 name="input.a.page1.bgdb007"
            IF NOT cl_null(g_bgdb_d[l_ac].bgdb007) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgdb_d[l_ac].bgdb007

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgdb_d[l_ac].bgdb007 = g_bgdb_d_t.bgdb007
                  NEXT FIELD CURRENT
               END IF

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb007
            #add-point:BEFORE FIELD bgdb007 name="input.b.page1.bgdb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdb007
            #add-point:ON CHANGE bgdb007 name="input.g.page1.bgdb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb008
            #add-point:BEFORE FIELD bgdb008 name="input.b.page1.bgdb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb008
            
            #add-point:AFTER FIELD bgdb008 name="input.a.page1.bgdb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdb008
            #add-point:ON CHANGE bgdb008 name="input.g.page1.bgdb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgda003
            #add-point:BEFORE FIELD bgda003 name="input.b.page1.bgda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgda003
            
            #add-point:AFTER FIELD bgda003 name="input.a.page1.bgda003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgda003
            #add-point:ON CHANGE bgda003 name="input.g.page1.bgda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdb009
            #add-point:BEFORE FIELD bgdb009 name="input.b.page1.bgdb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdb009
            
            #add-point:AFTER FIELD bgdb009 name="input.a.page1.bgdb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdb009
            #add-point:ON CHANGE bgdb009 name="input.g.page1.bgdb009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdbseq
            #add-point:ON ACTION controlp INFIELD bgdbseq name="input.c.page1.bgdbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb004
            #add-point:ON ACTION controlp INFIELD bgdb004 name="input.c.page1.bgdb004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgdb_d[l_ac].bgdb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgas001()                                #呼叫開窗
 
            LET g_bgdb_d[l_ac].bgdb004 = g_qryparam.return1              
            CALL abgi410_bgda002_desc(g_bgdb_d[l_ac].bgdb004) RETURNING g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004
            DISPLAY g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004 TO s_detail[1].bgasl003,s_detail[1].bgasl004
            DISPLAY g_bgdb_d[l_ac].bgdb004 TO bgdb004              #
            
            NEXT FIELD bgdb004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgasl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl003
            #add-point:ON ACTION controlp INFIELD bgasl003 name="input.c.page1.bgasl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgasl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgasl004
            #add-point:ON ACTION controlp INFIELD bgasl004 name="input.c.page1.bgasl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgdb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb005
            #add-point:ON ACTION controlp INFIELD bgdb005 name="input.c.page1.bgdb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb006
            #add-point:ON ACTION controlp INFIELD bgdb006 name="input.c.page1.bgdb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb007
            #add-point:ON ACTION controlp INFIELD bgdb007 name="input.c.page1.bgdb007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgdb_d[l_ac].bgdb007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_bgdb_d[l_ac].bgdb007 = g_qryparam.return1              

            DISPLAY g_bgdb_d[l_ac].bgdb007 TO bgdb007              #

            NEXT FIELD bgdb007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.bgdb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb008
            #add-point:ON ACTION controlp INFIELD bgdb008 name="input.c.page1.bgdb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgda003
            #add-point:ON ACTION controlp INFIELD bgda003 name="input.c.page1.bgda003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgdb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdb009
            #add-point:ON ACTION controlp INFIELD bgdb009 name="input.c.page1.bgdb009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgdb_d[l_ac].* = g_bgdb_d_t.*
               CLOSE abgi410_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bgdb_d[l_ac].bgdbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
 
               LET g_bgdb_d[l_ac].* = g_bgdb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
      
               UPDATE bgdb_t SET (bgdb001,bgdb002,bgdb003,bgdbseq,bgdb004,bgdb005,bgdb006,bgdb007,bgdb008, 
                   bgdb009) = (g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003,g_bgdb_d[l_ac].bgdbseq, 
                   g_bgdb_d[l_ac].bgdb004,g_bgdb_d[l_ac].bgdb005,g_bgdb_d[l_ac].bgdb006,g_bgdb_d[l_ac].bgdb007, 
                   g_bgdb_d[l_ac].bgdb008,g_bgdb_d[l_ac].bgdb009)
                WHERE bgdbent = g_enterprise AND bgdb001 = g_bgda_m.bgda001 
                  AND bgdb002 = g_bgda_m.bgda002 
                  AND bgdb003 = g_bgda_m.bgda003 
 
                  AND bgdbseq = g_bgdb_d_t.bgdbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgdb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgdb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                   
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgda_m.bgda001
               LET gs_keys_bak[1] = g_bgda001_t
               LET gs_keys[2] = g_bgda_m.bgda002
               LET gs_keys_bak[2] = g_bgda002_t
               LET gs_keys[3] = g_bgda_m.bgda003
               LET gs_keys_bak[3] = g_bgda003_t
               LET gs_keys[4] = g_bgdb_d[g_detail_idx].bgdbseq
               LET gs_keys_bak[4] = g_bgdb_d_t.bgdbseq
               CALL abgi410_update_b('bgdb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_bgda_m),util.JSON.stringify(g_bgdb_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgda_m),util.JSON.stringify(g_bgdb_d[l_ac])
                     IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL abgi410_unlock_b("bgdb_t",'1')
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
            
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point   
              
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_bgdb_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_bgdb_d.getLength()+1
              
      END INPUT
      
 
      
 
      
      #add-point:input段more input name="input.more_input"
      
      #end add-point  
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD bgda001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgdbseq
 
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
   
   CLOSE abgi410_bcl
    
   #add-point:input段after input  name="input.after_input"
   CALL abgi410_browser_fill()
   CALL abgi410_fetch_1()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgi410_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point   
   DEFINE l_ac_t    LIKE type_t.num10
   DEFINE l_sql     STRING
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL abgi410_bgda002_get(g_bgda_m.bgda002)
   #end add-point
   
   
   
   DISPLAY BY NAME g_bgda_m.bgda001,g_bgda_m.bgda001_desc,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004, 
       g_bgda_m.bgdastus,g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310, 
       g_bgda_m.bgdaownid,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp,g_bgda_m.bgdaowndp_desc,g_bgda_m.bgdacrtid, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid, 
       g_bgda_m.bgdamodid_desc,g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfid_desc,g_bgda_m.bgdacnfdt 
 
    
   CALL abgi410_set_pk_array()    
    
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bgda_m.bgdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
 
   IF g_bfill = "Y" THEN
      CALL abgi410_b_fill()                 #單身
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgi410_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
 
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bgdb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
 
   
    
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgi410_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point 
   DEFINE l_newno     LIKE bgda_t.bgda001 
   DEFINE l_oldno     LIKE bgda_t.bgda001 
   DEFINE l_newno02     LIKE bgda_t.bgda002 
   DEFINE l_oldno02     LIKE bgda_t.bgda002 
   DEFINE l_newno03     LIKE bgda_t.bgda003 
   DEFINE l_oldno03     LIKE bgda_t.bgda003 
 
   DEFINE l_master    RECORD LIKE bgda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgdb_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   IF g_bgda_m.bgda001 IS NULL
   OR g_bgda_m.bgda002 IS NULL
   OR g_bgda_m.bgda003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
    
   LET g_bgda001_t = g_bgda_m.bgda001
   LET g_bgda002_t = g_bgda_m.bgda002
   LET g_bgda003_t = g_bgda_m.bgda003
 
   
   LET g_bgda_m.bgda001 = ""
   LET g_bgda_m.bgda002 = ""
   LET g_bgda_m.bgda003 = ""
 
   
   CALL abgi410_set_entry('a')
   CALL abgi410_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgda_m.bgdaownid = g_user
      LET g_bgda_m.bgdaowndp = g_dept
      LET g_bgda_m.bgdacrtid = g_user
      LET g_bgda_m.bgdacrtdp = g_dept 
      LET g_bgda_m.bgdacrtdt = cl_get_current()
      LET g_bgda_m.bgdamodid = g_user
      LET g_bgda_m.bgdamoddt = cl_get_current()
      LET g_bgda_m.bgdastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   CALL abgi410_input("r")
   
      LET g_bgda_m.bgda001_desc = ''
   DISPLAY BY NAME g_bgda_m.bgda001_desc
 
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
 
   #功能已完成,通報訊息中心
   CALL abgi410_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgi410_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point   
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgdb_t.* #此變數樣板目前無使用
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgi410_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgdb_t
    WHERE bgdbent = g_enterprise AND bgdb001 = g_bgda001_t
    AND bgdb002 = g_bgda002_t
    AND bgdb003 = g_bgda003_t
 
    INTO TEMP abgi410_detail
   
   #將key修正為調整後   
   UPDATE abgi410_detail 
      #更新key欄位
      SET bgdb001 = g_bgda_m.bgda001
          , bgdb002 = g_bgda_m.bgda002
          , bgdb003 = g_bgda_m.bgda003
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO bgdb_t SELECT * FROM abgi410_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "Reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abgi410_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgda001_t = g_bgda_m.bgda001
   LET g_bgda002_t = g_bgda_m.bgda002
   LET g_bgda003_t = g_bgda_m.bgda003
 
   
   DROP TABLE abgi410_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgi410_delete()
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
   
   IF g_bgda_m.bgda001 IS NULL
   OR g_bgda_m.bgda002 IS NULL
   OR g_bgda_m.bgda003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE abgi410_master_referesh USING g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgda_m.bgda001, 
       g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp, 
       g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt, 
       g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt,g_bgda_m.bgda001_desc,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp_desc, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdamodid_desc,g_bgda_m.bgdacnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT abgi410_action_chk() THEN
      RETURN
   END IF
   
   CALL abgi410_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN abgi410_cl USING g_enterprise,g_bgda_m.bgda001
                                                       ,g_bgda_m.bgda002
                                                       ,g_bgda_m.bgda003
 
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE abgi410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   FETCH abgi410_cl INTO g_bgda_m.bgda001,g_bgda_m.bgda001_desc,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004, 
       g_bgda_m.bgdastus,g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310, 
       g_bgda_m.bgdaownid,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp,g_bgda_m.bgdaowndp_desc,g_bgda_m.bgdacrtid, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid, 
       g_bgda_m.bgdamodid_desc,g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfid_desc,g_bgda_m.bgdacnfdt  
                    #鎖住將被更改或取消的資料
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_bgda_m.bgda001,":",SQLERRMESSAGE  
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下 
      
      #資料備份
      LET g_bgda001_t = g_bgda_m.bgda001
      LET g_bgda002_t = g_bgda_m.bgda002
      LET g_bgda003_t = g_bgda_m.bgda003
 
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi410_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
      
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
      
      DELETE FROM bgda_t
       WHERE bgdaent = g_enterprise AND bgda001 = g_bgda_m.bgda001
         AND bgda002 = g_bgda_m.bgda002
         AND bgda003 = g_bgda_m.bgda003
 
      
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
      
      IF SQLCA.SQLCODE THEN
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bgda_m.bgda001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      
      
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bgdb_t
       WHERE bgdbent = g_enterprise AND bgdb001 = g_bgda_m.bgda001
         AND bgdb002 = g_bgda_m.bgda002
         AND bgdb003 = g_bgda_m.bgda003
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgdb_t:",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF       
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
                                                               
 
                            
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bgda_m)   #(ver:36)
      IF NOT cl_log_modified_record(g_log1,'') THEN 
         CLOSE abgi410_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL g_bgdb_d.clear() 
 
     
      CALL abgi410_ui_browser_refresh()  
      CALL abgi410_ui_headershow()  
      CALL abgi410_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgi410_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         CALL abgi410_browser_fill()
      END IF
       
   END IF
 
   CLOSE abgi410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgi410_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgi410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgi410_b_fill()
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point   
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
 
   #end add-point
   
   CALL g_bgdb_d.clear()    #g_bgdb_d 單頭及單身 
 
 
   #add-point:b_fill段define name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bgdbseq,bgdb004,bgdb005,bgdb006,bgdb007,bgdb008,bgdb009  FROM bgdb_t", 
           
               " INNER JOIN bgda_t ON bgda001 = bgdb001 ",
               " AND bgda002 = bgdb002 ",
               " AND bgda003 = bgdb003 ",
 
               "",
               
               " WHERE bgdbent=? AND bgdb001=? AND bgdb002=? AND bgdb003=?"
 
   IF NOT cl_null(g_wc_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table1 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY  bgdb_t.bgdbseq"
 
   #add-point:單身填充控制 name="b_fill.sql"
   
   #end add-point   #(ver:35)
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
   PREPARE abgi410_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR abgi410_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
#  OPEN b_fill_cs USING g_enterprise,g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003   #(ver:36)
                                            
   FOREACH b_fill_cs USING g_enterprise,g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgdb_d[l_ac].bgdbseq, 
       g_bgdb_d[l_ac].bgdb004,g_bgdb_d[l_ac].bgdb005,g_bgdb_d[l_ac].bgdb006,g_bgdb_d[l_ac].bgdb007,g_bgdb_d[l_ac].bgdb008, 
       g_bgdb_d[l_ac].bgdb009   #(ver:36)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL abgi410_bgda002_desc(g_bgdb_d[l_ac].bgdb004) RETURNING g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004
      DISPLAY g_bgdb_d[l_ac].bgasl003,g_bgdb_d[l_ac].bgasl004 TO s_detail[1].bgasl003,s_detail[1].bgasl004
      LET g_bgdb_d[l_ac].bgda003 = g_bgda_m.bgda003
      #end add-point
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
 
   
   CALL g_bgdb_d.deleteElement(g_bgdb_d.getLength())
 
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   CLOSE b_fill_cs
 
   
   FREE abgi410_pb
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgi410_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "bgdb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point   
      DELETE FROM bgdb_t
       WHERE bgdbent = g_enterprise AND
         bgdb001 = ps_keys_bak[1] AND bgdb002 = ps_keys_bak[2] AND bgdb003 = ps_keys_bak[3] AND bgdbseq = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point   
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgi410_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "bgdb_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point   
      INSERT INTO bgdb_t
                  (bgdbent,
                   bgdb001,bgdb002,bgdb003,
                   bgdbseq
                   ,bgdb004,bgdb005,bgdb006,bgdb007,bgdb008,bgdb009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_bgdb_d[l_ac].bgdb004,g_bgdb_d[l_ac].bgdb005,g_bgdb_d[l_ac].bgdb006,g_bgdb_d[l_ac].bgdb007, 
                       g_bgdb_d[l_ac].bgdb008,g_bgdb_d[l_ac].bgdb009)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point   
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgdb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point   
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgi410_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bgdb_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE bgdb_t 
         SET (bgdb001,bgdb002,bgdb003,
              bgdbseq
              ,bgdb004,bgdb005,bgdb006,bgdb007,bgdb008,bgdb009) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_bgdb_d[l_ac].bgdb004,g_bgdb_d[l_ac].bgdb005,g_bgdb_d[l_ac].bgdb006,g_bgdb_d[l_ac].bgdb007, 
                  g_bgdb_d[l_ac].bgdb008,g_bgdb_d[l_ac].bgdb009) 
         WHERE bgdbent = g_enterprise AND
               bgdb001 = ps_keys_bak[1] AND bgdb002 = ps_keys_bak[2] AND bgdb003 = ps_keys_bak[3] AND bgdbseq = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgdb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgdb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point   
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgi410_lock_b(ps_table,ps_page)
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
   #CALL abgi410_b_fill()
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "bgdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abgi410_bcl USING g_enterprise,
                                       g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003,g_bgdb_d[g_detail_idx].bgdbseq 
 
                                       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgi410_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgi410_unlock_b(ps_table,ps_page)
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
      CLOSE abgi410_bcl
   END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgi410_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgda001,bgda002,bgda003",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgi410_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgda001,bgda002,bgda003",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgi410_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgi410_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point 
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="abgi410.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgi410_default_search()
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
      LET ls_wc = ls_wc, " bgda001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgda002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bgda003 = '", g_argv[03], "' AND "
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
 
{<section id="abgi410.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION abgi410_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bgdb_d.getLength() THEN
         LET g_detail_idx = g_bgdb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgdb_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgdb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.browser_expand" >}
#+ Tree子節點展開
PRIVATE FUNCTION abgi410_browser_expand(p_id)
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
   DEFINE l_keyvalue1   LIKE type_t.chr50
   DEFINE l_keyvalue2   LIKE type_t.chr50
   #end add-point
   
   #add-point:Function前置處理  name="browser_expand.pre_function"
   LET l_keyvalue1 = g_browser[p_id].b_bgda001
   LET l_keyvalue2 = g_browser[p_id].b_bgda003
   #end add-point
   
   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_keyvalue = g_browser[p_id].b_bgda002
   
   LET l_sql = " SELECT DISTINCT '','','','FALSE','','','',t0.bgda001,t0.bgdb004,t0.bgda003",
                 " FROM bgdb_t t0 ",
                " INNER JOIN bgdbent = " ||g_enterprise|| " AND bgda_t ON bgdb004 = bgda002 ",
                " WHERE bgdbent = " ||g_enterprise|| " AND bgdb002 = '", l_keyvalue,"' ",
                " ORDER BY bgdb004"
 
   #add-point:browser_expand段sql調整 name="browser_expand.modify_sql"
   LET l_sql = " SELECT  '','','','FALSE','','','',bgdb001,t0.bgdb004,",
               "         (SELECT DISTINCT bgdb003 FROM bgdb_t ",
               "           WHERE bgdbent = ",g_enterprise,
               "             AND bgdb001 = '",l_keyvalue1,"'",
               "             AND bgdb002 = t0.bgdb004 ",
               "             AND bgdb009 IS NULL ",
               "         ) ",
               "        ,bgdbseq",
               "   FROM bgdb_t t0 ",
               "  WHERE bgdb002 = '",l_keyvalue,"'",
               "    AND bgdb001 = '",l_keyvalue1,"'",
               #"    AND bgdb003 = '",l_keyvalue2,"'",
               "    AND bgdb009 IS NULL ",
               " ORDER BY bgdb004"
   #end add-point
   
   #LET l_sql = cl_sql_add_tabid(l_sql,"bgda_t")            #WC重組
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
      #LET g_browser[l_id].b_bgda002 = g_browser[l_id].b_bgda002 CLIPPED
      CALL abgi410_desc_show(l_id)
      LET g_browser[l_id].b_hasC = abgi410_chk_hasC(l_id)
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
 
{<section id="abgi410.chk_hasC" >}
#+ 確認該節點是否有子節點
PRIVATE FUNCTION abgi410_chk_hasC(pi_id)
   #add-point:chk_hasC段define name="chk_hasC.define_customerization"
   
   #end add-point
   DEFINE pi_id    INTEGER
   DEFINE li_cnt   INTEGER
   #add-point:chk_hasC段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="chk_hasC.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="chk_hasC.pre_function"
   
   #end add-point
   
   LET li_cnt = 0
    
    SELECT COUNT(1) INTO li_cnt FROM bgdb_t
    INNER JOIN bgda_t ON bgdb004 = bgda002
    WHERE bgdbent = g_enterprise AND bgdb002 = g_browser[pi_id].b_bgda002
   
   #add-point:chk_hasC段確認後 name="chk_hasC.after_chk"
   LET li_cnt = 0
   SELECT COUNT(1) INTO li_cnt FROM bgdb_t
    WHERE bgdbent = g_enterprise AND bgdb002 = g_browser[pi_id].b_bgda002 AND bgdb009 IS NULL
      AND bgdb001 = g_browser[pi_id].b_bgda001
   #end add-point
   
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgi410.desc_show" >}
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION abgi410_desc_show(pi_ac)
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
   LET g_browser[l_ac].b_show = g_browser[l_ac].b_bgda002

   #end add-point
 
   LET l_ac = li_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgi410_modify_detail_chk(ps_record)
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
         LET ls_return = "bgdbseq"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abgi410_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bgda_m.bgda001 IS NULL
      OR g_bgda_m.bgda002 IS NULL      OR g_bgda_m.bgda003 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abgi410_cl USING g_enterprise,g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003
   IF STATUS THEN
      CLOSE abgi410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abgi410_master_referesh USING g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgda_m.bgda001, 
       g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp, 
       g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt, 
       g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt,g_bgda_m.bgda001_desc,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp_desc, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdamodid_desc,g_bgda_m.bgdacnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT abgi410_action_chk() THEN
      CLOSE abgi410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgda_m.bgda001,g_bgda_m.bgda001_desc,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004, 
       g_bgda_m.bgdastus,g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310, 
       g_bgda_m.bgdaownid,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp,g_bgda_m.bgdaowndp_desc,g_bgda_m.bgdacrtid, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid, 
       g_bgda_m.bgdamodid_desc,g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfid_desc,g_bgda_m.bgdacnfdt 
 
 
   CASE g_bgda_m.bgdastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   LET l_success = TRUE
   CALL cl_err_collect_init()
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bgda_m.bgdastus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("open,valid,void",TRUE)
      CASE g_bgda_m.bgdastus
         WHEN "X"
            CALL cl_set_act_visible("open,valid,void",FALSE)
            CLOSE abgi410_cl
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("valid,void",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("open",FALSE)
      END CASE
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
            CALL s_abgi410_unconfirm(g_bgda_m.bgda001,g_bgda_m.bgda002) RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               RETURN
            ELSE
               CALL cl_err_collect_show()  
               CALL s_transaction_end('Y','0')
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            CALL s_abgi410_confirm(g_bgda_m.bgda001,g_bgda_m.bgda002) RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               RETURN
            ELSE
               CALL cl_err_collect_show()  
               CALL s_transaction_end('Y','0')
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            CALL s_abgi410_void(g_bgda_m.bgda001,g_bgda_m.bgda002) RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               RETURN
            ELSE
               CALL cl_err_collect_show()  
               CALL s_transaction_end('Y','0')
            END IF
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_bgda_m.bgdastus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgi410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_bgda_m.bgdamodid = g_user
   LET g_bgda_m.bgdamoddt = cl_get_current()
   LET g_bgda_m.bgdastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bgda_t 
      SET (bgdastus,bgdamodid,bgdamoddt) 
        = (g_bgda_m.bgdastus,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt)     
    WHERE bgdaent = g_enterprise AND bgda001 = g_bgda_m.bgda001
      AND bgda002 = g_bgda_m.bgda002      AND bgda003 = g_bgda_m.bgda003
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE abgi410_master_referesh USING g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgda_m.bgda001, 
          g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp, 
          g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt, 
          g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt,g_bgda_m.bgda001_desc,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp_desc, 
          g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdamodid_desc,g_bgda_m.bgdacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bgda_m.bgda001,g_bgda_m.bgda001_desc,g_bgda_m.bgda002,g_bgda_m.bgasl003,g_bgda_m.bgasl004, 
          g_bgda_m.bgdastus,g_bgda_m.bgas004,g_bgda_m.bgda003,g_bgda_m.bgas005,g_bgda_m.bgda005,g_bgda_m.bgas310, 
          g_bgda_m.bgdaownid,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp,g_bgda_m.bgdaowndp_desc,g_bgda_m.bgdacrtid, 
          g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid, 
          g_bgda_m.bgdamodid_desc,g_bgda_m.bgdamoddt,g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfid_desc,g_bgda_m.bgdacnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abgi410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgi410_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi410.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgi410_set_pk_array()
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
   LET g_pk_array[1].values = g_bgda_m.bgda001
   LET g_pk_array[1].column = 'bgda001'
   LET g_pk_array[2].values = g_bgda_m.bgda002
   LET g_pk_array[2].column = 'bgda002'
   LET g_pk_array[3].values = g_bgda_m.bgda003
   LET g_pk_array[3].column = 'bgda003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi410.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgi410_msgcentre_notify(lc_state)
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
   CALL abgi410_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi410.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abgi410_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abgi410.other_function" readonly="Y" >}
# 抓取基础资料
PRIVATE FUNCTION abgi410_bgda002_get(p_bgda002)
   DEFINE p_bgda002          LIKE bgda_t.bgda002
   
   LET g_bgda_m.bgasl003 = ''   LET g_bgda_m.bgasl004 = ''
   CALL abgi410_bgda002_desc(p_bgda002) RETURNING g_bgda_m.bgasl003,g_bgda_m.bgasl004
      
   SELECT bgas004,bgas005,bgas310
     INTO g_bgda_m.bgas004,g_bgda_m.bgas005,g_bgda_m.bgas310
     FROM bgas_t
    WHERE bgasent = g_enterprise
      AND bgas001 = g_bgda_m.bgda002
      
   DISPLAY g_bgda_m.bgasl003,g_bgda_m.bgasl004,g_bgda_m.bgas004,g_bgda_m.bgas005,g_bgda_m.bgas310
        TO bgasl003,bgasl004,bgas004,bgas005,bgas310
END FUNCTION
# 抓取品名規格
PRIVATE FUNCTION abgi410_bgda002_desc(p_bgda002)
   DEFINE p_bgda002          LIKE bgda_t.bgda002
   DEFINE r_bgasl003         LIKE bgasl_t.bgasl003
   DEFINE r_bgasl004         LIKE bgasl_t.bgasl004
   
   LET r_bgasl003 = ''  LET r_bgasl004 = ''
   SELECT bgasl003,bgasl004
     INTO r_bgasl003,r_bgasl004
     FROM bgasl_t
    WHERE bgaslent = g_enterprise
      AND bgasl001 = p_bgda002
      AND bgasl002 = g_dlang
   
   RETURN r_bgasl003,r_bgasl004
END FUNCTION
# 迴圈檢查
PRIVATE FUNCTION abgi410_tree_loop_chk(p_key1,p_addkey2,p_flag)
   DEFINE p_key1             STRING
   DEFINE p_addkey2          STRING            #要增加的節點key2
   DEFINE p_flag             LIKE type_t.chr1  #是否已跑遞迴
   DEFINE l_bgdb             DYNAMIC ARRAY OF RECORD
                             bgdb004           LIKE bgdb_t.bgdb004
                             END RECORD
   DEFINE l_child            INTEGER
   DEFINE l_str              STRING
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_loop             LIKE type_t.chr1  #是否為無窮迴圈Y/N

   IF cl_null(p_flag) THEN   #第一次進遞迴
      LET g_idx = 1
      LET g_path_add[g_idx] = p_addkey2
      IF g_path_add[g_idx] = p_key1 THEN
         LET l_loop = "Y"
         RETURN l_loop
      END IF
   END IF
   LET p_flag = "Y"
   IF cl_null(l_loop) THEN
      LET l_loop = "N"
   END IF

   IF NOT cl_null(p_addkey2) THEN
      LET g_sql = "SELECT UNIQUE bgdb004 ",
                  "  FROM bgdb_t ",
                  " WHERE bgdb001 = '",g_bgda_m.bgda001,"'",  
                  "   AND bgdb002 = '", p_addkey2,"'",  
                  "   AND bgdb003 = '",g_bgda_m.bgda003,"'",  
                  " ORDER BY bgdb004"
      PREPARE abgi410_tree_pre FROM g_sql
      DECLARE abgi410_tree_cs CURSOR FOR abgi410_tree_pre

      #在FOREACH中直接使用遞迴,資料會錯亂,所以先將資料放到陣列後,在FOR迴圈處理
      LET l_cnt = 1
      CALL l_bgdb.clear()
      FOREACH abgi410_tree_cs INTO l_bgdb[l_cnt].*
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'FOREACH:'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
         END IF
         LET l_cnt = l_cnt + 1
      END FOREACH
      CALL l_bgdb.deleteelement(l_cnt)  #刪除FOREACH最後新增的空白列
      LET l_cnt = l_cnt - 1

      IF l_cnt >0 THEN
         FOR l_i=1 TO l_cnt
            LET g_idx = g_idx + 1
            LET g_path_add[g_idx] = l_bgdb[l_i].bgdb004
            IF g_path_add[g_idx] = p_key1 THEN
               LET l_loop = "Y"
               RETURN l_loop
            END IF
            #有子節點
            SELECT COUNT(1) INTO l_child FROM bgdb_t
             WHERE bgdbent = g_enterprise AND bgdb002 = l_bgdb[l_i].bgdb004
            IF l_child > 0 THEN
               CALL abgi410_tree_loop_chk(p_key1,l_bgdb[l_i].bgdb004,p_flag) RETURNING l_loop
               IF l_loop = 'Y' THEN 
                  RETURN l_loop 
               END IF          
            END IF
          END FOR
      END IF
   END IF
   RETURN l_loop
END FUNCTION
# 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgi410_fetch_1()
   #add-point:fetch段define name="fetch.define_customerization"

   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"

   #end add-point
  
   #add-point:Function前置處理  name="fetch.before_fetch"

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
   
   LET g_bgda_m.bgda001 = g_browser[g_current_idx].b_bgda001
   LET g_bgda_m.bgda002 = g_browser[g_current_idx].b_bgda002
   LET g_bgda_m.bgda003 = g_browser[g_current_idx].b_bgda003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgi410_master_referesh USING g_bgda_m.bgda001,g_bgda_m.bgda002,g_bgda_m.bgda003 INTO g_bgda_m.bgda001, 
       g_bgda_m.bgda002,g_bgda_m.bgdastus,g_bgda_m.bgda003,g_bgda_m.bgda005,g_bgda_m.bgdaownid,g_bgda_m.bgdaowndp, 
       g_bgda_m.bgdacrtid,g_bgda_m.bgdacrtdp,g_bgda_m.bgdacrtdt,g_bgda_m.bgdamodid,g_bgda_m.bgdamoddt, 
       g_bgda_m.bgdacnfid,g_bgda_m.bgdacnfdt,g_bgda_m.bgda001_desc,g_bgda_m.bgdaownid_desc,g_bgda_m.bgdaowndp_desc, 
       g_bgda_m.bgdacrtid_desc,g_bgda_m.bgdacrtdp_desc,g_bgda_m.bgdamodid_desc,g_bgda_m.bgdacnfid_desc 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgda_t:",SQLERRMESSAGE  
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      LET g_errparam.popup  = FALSE
      CLEAR FORM                    #清畫面欄位內容
      CALL g_bgdb_d.clear()    #清除陣列
      CALL cl_err()
 
      INITIALIZE g_bgda_m.* TO NULL
      
      RETURN
   END IF
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_bgda_m.bgdastus = 'Y' OR g_bgda_m.bgdastus = 'X' THEN 
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_bgda_m_t.* = g_bgda_m.*
   LET g_bgda_m_o.* = g_bgda_m.*
   
   #重新顯示   
   CALL abgi410_show()
END FUNCTION

 
{</section>}
 
