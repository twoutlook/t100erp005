#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi150.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2015-10-13 14:53:19), PR版次:0016(2017-01-20 14:00:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000528
#+ Filename...: aimi150
#+ Description: 產品策略維護作業
#+ Creator....: 02482(2013-10-10 09:28:35)
#+ Modifier...: 02295 -SD/PR- 06978
 
{</section>}
 
{<section id="aimi150.global" >}
#應用 i05 樣板自動產生(Version:37)
#add-point:填寫註解說明
#160318-00005#20  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#15  2016/04/06 BY 07900   重复错误讯息的修改
#160905-00007#4   2016/09/05  by 08172       调整系统中无ENT的SQL条件增加ent
#160922-00037#1   2016/10/17 By lixiang 树状结构根据查询条件显示出符合条件的据点结构
#170118-00023#1   2017/01/20 By ywtsai  判斷若產品分類僅輸入一個字*，非模糊比對，仍需檢核要存在aimi010中
#end add-point
#add-point:填寫註解說明(客製用)

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
PRIVATE type type_g_ooed_m RECORD
   ooed004 LIKE ooed_t.ooed004, 
   ooed004_desc LIKE type_t.chr80, 
   ooed001 LIKE ooed_t.ooed001, 
   ooed002 LIKE ooed_t.ooed002, 
   ooed003 LIKE ooed_t.ooed003, 
   ooed005 LIKE ooed_t.ooed005
                                  END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單身 type 宣告
 TYPE type_g_imda_d        RECORD
       imdastus       LIKE imda_t.imdastus, 
       imda002        LIKE imda_t.imda002,
       imda002_desc   LIKE type_t.chr80,  
       imda004        LIKE imda_t.imda004, 
       imda005        LIKE imda_t.imda005,        
       imda003        LIKE imda_t.imda003, 
       imdamodid      LIKE imda_t.imdamodid, 
       imdamodid_desc LIKE type_t.chr80,
       imdamoddt      DATETIME YEAR TO SECOND,
       imdaownid      LIKE imda_t.imdaownid, 
       imdaownid_desc LIKE type_t.chr80, 
       imdaowndp      LIKE imda_t.imdaowndp, 
       imdaowndp_desc LIKE type_t.chr80, 
       imdacrtid      LIKE imda_t.imdacrtid, 
       imdacrtid_desc LIKE type_t.chr80, 
       imdacrtdp      LIKE imda_t.imdacrtdp, 
       imdacrtdp_desc LIKE type_t.chr80,
       imdacrtdt      DATETIME YEAR TO SECOND
                      END RECORD
 TYPE type_g_imda2_d RECORD
       imdbstus       LIKE imdb_t.imdbstus, 
       imdb002        LIKE imdb_t.imdb002, 
       imdb002_desc   LIKE type_t.chr80, 
       imdb002_desc1  LIKE type_t.chr80,
       imdb004        LIKE imdb_t.imdb004,
       imdb005        LIKE imdb_t.imdb005,       
       imdb003        LIKE imdb_t.imdb003, 
       imdbmodid      LIKE imdb_t.imdbmodid, 
       imdbmodid_desc LIKE type_t.chr80, 
       imdbmoddt      DATETIME YEAR TO SECOND,
       imdbownid      LIKE imdb_t.imdbownid, 
       imdbownid_desc LIKE type_t.chr80, 
       imdbowndp      LIKE imdb_t.imdbowndp, 
       imdbowndp_desc LIKE type_t.chr80, 
       imdbcrtid      LIKE imdb_t.imdbcrtid, 
       imdbcrtid_desc LIKE type_t.chr80,
       imdbcrtdp      LIKE imdb_t.imdbcrtdp, 
       imdbcrtdp_desc LIKE type_t.chr80, 
       imdbcrtdt      DATETIME YEAR TO SECOND
                      END RECORD
                      
DEFINE g_imda_d       DYNAMIC ARRAY OF type_g_imda_d
DEFINE g_imda_d_t     type_g_imda_d
DEFINE g_imda2_d      DYNAMIC ARRAY OF type_g_imda2_d
DEFINE g_imda2_d_t    type_g_imda2_d 

DEFINE g_wc2          STRING                        #單身CONSTRUCT結果
DEFINE g_wc_table1    STRING                        #第1個單身table所使用的g_wc
DEFINE g_wc_table2    STRING                        #第2個單身table所使用的g_wc
DEFINE g_current_page LIKE type_t.num5              #目前所在頁數
DEFINE g_bfill        LIKE type_t.chr5              #是否刷新單身、
DEFINE gs_keys        DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak    DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert       LIKE type_t.chr5              #是否導到其他page

DEFINE g_wc_def       STRING
DEFINE g_detail_cnt   LIKE type_t.num5
DEFINE g_detail_idx   LIKE type_t.num5
#end add-point
                                  
#模組變數(Module Variables)
DEFINE g_ooed_m          type_g_ooed_m
DEFINE g_ooed_m_t        type_g_ooed_m
DEFINE g_ooed_m_o        type_g_ooed_m
 
   DEFINE g_ooed004_t LIKE ooed_t.ooed004
DEFINE g_ooed001_t LIKE ooed_t.ooed001
DEFINE g_ooed002_t LIKE ooed_t.ooed002
DEFINE g_ooed003_t LIKE ooed_t.ooed003
DEFINE g_ooed005_t LIKE ooed_t.ooed005
 
 
#DEFINE g_ooed004_t        LIKE ooed_t.ooed004
#DEFINE g_ooed005_t        LIKE ooed_t.ooed005
#DEFINE g_ooed001_t      LIKE ooed_t.ooed001
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #tree自定義欄位
          b_ooed001 LIKE ooed_t.ooed001,
      b_ooed002 LIKE ooed_t.ooed002,
      b_ooed003 LIKE ooed_t.ooed003,
      b_ooed004 LIKE ooed_t.ooed004,
   b_ooed004_desc LIKE type_t.chr80,
      b_ooed005 LIKE ooed_t.ooed005
                   END RECORD
 
DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER    #root資料所在
       
#多table用變數
 
DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_curr_diag           ui.Dialog                #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10         
DEFINE gwin_curr             ui.Window                #Current Window
DEFINE gfrm_curr             ui.Form                  #Current Form
DEFINE g_page_action         STRING                   #page action
DEFINE g_header_hidden       LIKE type_t.num5         #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5         #隱藏工作Panel
DEFINE g_browser_cnt         LIKE type_t.num10        #total count
DEFINE g_page                STRING                   #第幾頁
DEFINE g_current_row         LIKE type_t.num10        #Browser所在筆數
DEFINE g_current_sw          LIKE type_t.num10        #Browser所在筆數用開關
 
DEFINE g_searchcol           LIKE type_t.chr200
DEFINE g_searchstr           LIKE type_t.chr200
DEFINE g_searchtype          LIKE type_t.chr200
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_root_search         BOOLEAN
DEFINE g_first               LIKE type_t.num5  #標示是否要啟動s_browse重查
DEFINE g_aw                  STRING            #確定當下點擊的單身
DEFINE g_log1                STRING            #log用
DEFINE g_log2                STRING            #log用
DEFINE g_add_browse          STRING            #新增填充用WC
DEFINE g_add_idx             LIKE type_t.num5  #新增資料指標
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aimi150.main" >}
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
   CALL cl_ap_init("aim","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT ooed004,'',ooed001,ooed002,ooed003,ooed005", 
                      " FROM ooed_t",
                      " WHERE ooedent= ? AND ooed001=? AND ooed002=? AND ooed003=? AND ooed004=? AND  
                          ooed005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi150_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.ooed004,t0.ooed001,t0.ooed002,t0.ooed003,t0.ooed005,t1.ooefl003", 
 
               " FROM ooed_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=ooed004 AND t1.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.ooedent = " ||g_enterprise|| " AND t0.ooed001 = ? AND t0.ooed002 = ? AND t0.ooed003 = ? AND t0.ooed004 = ? AND t0.ooed005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimi150_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimi150 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimi150_init()   
 
      #進入選單 Menu (="N")
      CALL aimi150_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimi150
      
   END IF 
   
   CLOSE aimi150_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimi150.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimi150_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_add_idx = 1
   LET g_current_idx = 1
    
   #add-point:畫面資料初始化 name="init.init"
   LET g_bfill = "Y"
   CALL cl_set_combo_scc('imda003','1102') 
   CALL cl_set_combo_scc('imdb003','1102') 
   CALL cl_set_combo_scc('imda004','2022') 
   CALL cl_set_combo_scc('imdb004','2022') 
   #end add-point
   
   CALL aimi150_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aimi150.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimi150_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit      LIKE type_t.num5    #判別是否為離開作業
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_ooed_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         LET g_first = 1
         CALL aimi150_init()
      END IF
 
      #當瀏覽頁簽被設定關閉時,使用MENU (開啟時使用DIALOG)
      IF g_worksheet_hidden = 1 THEN
 
         LET g_current_sw = FALSE
 
         #回歸舊筆數位置 (回到當時異動的筆數)
         LET g_current_idx = g_current_row
         LET g_current_sw = TRUE
         CALL cl_show_fld_cont() 
         IF g_current_idx > 0 THEN
         CALL aimi150_fetch("")    #當每次點任一筆資料都會需要用到
         END IF
 
         MENU
            #add-point:ui_dialog段其他頁簽的 display array(in menu) name="ui_dialog.more_displayarray_in_menu"
            
            #end add-point
            
            
            #ACTION表單列
            ON ACTION first
               LET g_current_idx = 1
               CALL aimi150_fetch("")
               LET g_current_row = g_current_idx
            
            ON ACTION next
               LET g_current_idx = g_current_idx + 1
               CALL aimi150_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION jump
               CALL aimi150_fetch("/")
               LET g_current_row = g_current_idx
 
            ON ACTION previous
               LET g_current_idx = g_current_idx - 1
               CALL aimi150_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION last 
               LET g_current_idx = g_browser_cnt
               CALL aimi150_fetch("") 
               LET g_current_row = g_current_idx
 
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
 
            ON ACTION close
               LET li_exit = TRUE
               EXIT MENU
 
            ON ACTION mainhidden       #主頁摺疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
         
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 1
               END IF
               EXIT MENU
         
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
 
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               
               #add-point:ON ACTION exporttoexcel name="menu2.exporttoexcel"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi150_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prcategory
            LET g_action_choice="prcategory"
            IF cl_auth_chk_act("prcategory") THEN
               
               #add-point:ON ACTION prcategory name="menu2.prcategory"
                CALL aimi150_01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION event
            LET g_action_choice="event"
            IF cl_auth_chk_act("event") THEN
               
               #add-point:ON ACTION event name="menu2.event"
                CALL aimi150_02()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi150_query()
               #add-point:ON ACTION query name="menu2.query"
              
               #END add-point
               
            END IF
 
 
 
 
 
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi150_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi150_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi150_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
 
         END MENU
 
      ELSE
         #第一次進入程式, 或啟動重新查詢
         IF g_first = 0 THEN 
            CALL aimi150_browser_fill(g_wc,g_searchtype)
            LET g_first = 1
         END IF
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
            INPUT g_searchstr,g_searchcol,g_searchtype FROM formonly.searchstr,formonly.cbo_searchcol, 
                formonly.rdo_searchtype
               BEFORE INPUT
            END INPUT
            
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
 
               BEFORE DISPLAY
                  CALL DIALOG.setSelectionMode("s_browse",1) #設定為單選
 
               BEFORE ROW
                  #add-point:ui_dialog段before row1 name="ui_dialog.before_row1"
                  
                  #end add-point
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_row > 1 AND g_current_sw = FALSE THEN
                     CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                     LET g_current_idx = g_current_row
                  END IF
                  #add-point:ui_dialog段before row2 name="ui_dialog.before_row2"
                  
                  #end add-point
                  LET g_current_row = g_current_idx #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont() 
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
 
                  CALL aimi150_fetch("")  #當每次點任一筆資料都會需要用到
 
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL aimi150_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
 
               ON COLLAPSE (g_row_index)
                  #樹關閉
                  
               #add-point:ui_dialog段action name="ui_dialog.tree_action"
               
               #end add-point
 
            END DISPLAY
 
            #add-point:ui_dialog段其他頁簽的 display array name="ui_dialog.more_displayarray"
            DISPLAY ARRAY g_imda_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               CALL aimi150_idx_chk()
               LET g_detail_idx = ARR_CURR()
               
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL aimi150_idx_chk()
               
            END DISPLAY
    
            DISPLAY ARRAY g_imda2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
            
               BEFORE ROW
                  CALL aimi150_idx_chk()
                  
               BEFORE DISPLAY
                  LET g_current_page = 2
                  CALL aimi150_idx_chk()
                  LET g_detail_idx = ARR_CURR()
          
            END DISPLAY
            #end add-point
 
            BEFORE DIALOG
               #action default動作(判定是否要先執行特定動作)
               
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_current_sw = FALSE
 
               #add-point:ui_dialog,before dialog1 name="ui_dialog.b_dialog1"
               
               #end add-point
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_sw = FALSE THEN
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               #add-point:ui_dialog,before dialog2 name="ui_dialog.b_dialog2"
               
               #end add-point
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont() 
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               IF g_current_idx > 0 THEN
               CALL aimi150_fetch("")            #當每次點任一筆資料都會需要用到
               END IF
               #add-point:ui_dialog,before dialog name="ui_dialog.b_dialog"
               CALL aimi150_ui_detailshow()
               LET g_current_page = 1
               CALL aimi150_idx_chk()
               #end add-point
 
            AFTER DIALOG 
               #add-point:ui_dialog,after dialog name="ui_dialog.a_dialog"
               
               #end add-point
 
 
            #一般搜尋
            ON ACTION searchdata
               LET g_searchstr = GET_FLDBUF(searchstr)
               LET g_searchcol = GET_FLDBUF(cbo_searchcol)
               #若無輸入關鍵字則查找出所有資料
               IF g_searchcol="0" AND NOT cl_null(g_searchstr) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "searchcol:" 
                  LET g_errparam.code = "std-00001" 
                  LET g_errparam.popup = FALSE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF 
               IF NOT cl_null(g_searchstr) THEN
                  LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
                  LET g_wc = g_wc.toLowerCase()
               ELSE
                  LET g_wc = " 1=1 "
               END IF
               LET g_first = 0 #啟動重查
               EXIT DIALOG
 
            #進階搜尋
            #ON ACTION advancesearch
 
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
            
            ON ACTION close
               LET li_exit = TRUE
               EXIT DIALOG
            
            ON ACTION mainhidden       #主頁摺疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/mainhidden.png")
                  LET g_main_hidden = 1
               END IF
               EXIT DIALOG
 
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 1
               END IF
               EXIT DIALOG
 
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
 
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               ---2015-1-9 zj mod----
                              #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_imda_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel
                  LET g_export_node[2] = base.typeInfo.create(g_imda2_d)
                  LET g_export_id[2]   = "s_detail2"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
               
               -----2015-1-9 zj mod-------
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi150_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prcategory
            LET g_action_choice="prcategory"
            IF cl_auth_chk_act("prcategory") THEN
               
               #add-point:ON ACTION prcategory name="menu.prcategory"
                CALL aimi150_01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION event
            LET g_action_choice="event"
            IF cl_auth_chk_act("event") THEN
               
               #add-point:ON ACTION event name="menu.event"
                CALL aimi150_02()
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi150_query()
               #add-point:ON ACTION query name="menu.query"
               IF g_browser_cnt > 0 THEN
                  CALL aimi150_fetch('')
                  CALL aimi150_show()
               END IF
               #END add-point
               
            END IF
 
 
 
 
 
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi150_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi150_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi150_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            &include "main_menu_exit_dialog.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
   END WHILE
 
END FUNCTION 
 
{</section>}
 
{<section id="aimi150.browser_fill" >}
#+ 瀏覽頁簽where條件組成
PRIVATE FUNCTION aimi150_browser_fill(p_wc,p_type)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc       STRING 
   DEFINE p_type     LIKE type_t.chr10
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_cnt2     LIKE type_t.num10   
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_wc_def   STRING
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_fill"
   LET g_wc_def = p_wc
   CALL g_browser.clear()
   CLEAR FORM
   LET l_cnt = 0
   LET l_cnt2 = 0
   LET l_wc_def = cl_replace_str(p_wc,'ooed004','ooef001')
   DROP TABLE aimi150_tmp
   
   #Create temp table
   CREATE TEMP TABLE aimi150_tmp
   (
         ooed001 VARCHAR(500),
   ooed002 VARCHAR(500),
   ooed003 VARCHAR(500),
   ooed004 VARCHAR(500),
   ooed005 VARCHAR(500),
      #僅含browser的欄位
      exp_code  VARCHAR(5)
   );
 
   #先確定搜尋範圍(若無條件搜尋則只找root出來)
   SELECT COUNT(*) INTO l_cnt FROM ooed_t 
    WHERE ooedent = g_enterprise      #160905-00007#4 by 08172
   
   #取得符合p_wc的所有資料
#   IF g_wc2 <> " 1=1" THEN
#      LET g_sql = "SELECT COUNT(*)",
#                  " FROM ooed_t  ",
#                  " LEFT JOIN imda_t ON imdaent = ooedent AND imda001 = ooed004 ",
#                  " LEFT JOIN imdb_t ON imdbent = ooedent AND imdb001 = ooed004 ",
#                  " WHERE ooedent = '" ||g_enterprise|| "' AND ",p_wc, " AND ", g_wc2
#   ELSE
#      LET g_sql = "SELECT COUNT(*)",
#                  " FROM ooed_t  ",
#                  " WHERE ooedent = '" ||g_enterprise|| "' AND ",p_wc
#   END IF  
   IF g_wc2 <> " 1=1" THEN
      LET g_sql = "SELECT COUNT(*)",
                  " FROM ooef_t  ",
                  " LEFT JOIN imda_t ON imdaent = ooefent AND imda001 = ooef001 ",
                  " LEFT JOIN imdb_t ON imdbent = ooefent AND imdb001 = ooef001 ",
                  " WHERE ooefent = '" ||g_enterprise|| "' AND ooef201 = 'Y' ",
                  "   AND ",l_wc_def, " AND ", g_wc2
   ELSE
      LET g_sql = "SELECT COUNT(*)",
                  " FROM ooef_t  ",
                  " WHERE ooefent = '" ||g_enterprise|| "' AND ooef201 = 'Y' AND ",l_wc_def
   END IF  
   PREPARE master_cnt1 FROM g_sql
   DECLARE master_cntcur1 CURSOR FOR master_cnt1
   OPEN master_cntcur1
   FETCH master_cntcur1 INTO l_cnt2
   LET g_root_search = FALSE
   
   IF l_cnt2 = 0 THEN
      RETURN
   END IF
   
   IF l_cnt = l_cnt2 THEN
      #未輸入條件時則只查找root節點
      LET p_wc = " ooed004 = ooed005 "
      LET g_root_search = TRUE
   END IF
 
   #取得符合p_wc的所有資料
#   IF g_wc2 <> " 1=1" THEN
#      LET g_sql = "SELECT ooed001,ooed002,ooed003,ooed004,ooed005 ",
#                  " FROM ooed_t  ",
#                  " LEFT JOIN imda_t ON imdaent = ooedent AND imda001 = ooed004 ",
#                  " LEFT JOIN imdb_t ON imdbent = ooedent AND imdb001 = ooed004 ",
#                  " WHERE ooedent = '" ||g_enterprise|| "' AND ",p_wc, " AND ", g_wc2
#   ELSE
#      LET g_sql = "SELECT ooed001,ooed002,ooed003,ooed004,ooed005 ",
#                  " FROM ooed_t  ",
#                  " WHERE ooedent = '" ||g_enterprise|| "' AND ",p_wc
#   END IF
   IF g_wc2 <> " 1=1" THEN
      LET g_sql = "SELECT ooef001 ",
                  " FROM ooef_t  ",
                  " LEFT JOIN imda_t ON imdaent = ooefent AND imda001 = ooef001 ",
                  " LEFT JOIN imdb_t ON imdbent = ooefent AND imdb001 = ooef001 ",
                  " WHERE ooefent = '" ||g_enterprise|| "' AND ooef201 = 'Y' AND ",l_wc_def, " AND ", g_wc2
   ELSE
      LET g_sql = "SELECT ooef001 ",
                  " FROM ooef_t  ",
                  " WHERE ooefent = '" ||g_enterprise|| "' AND ooef201 = 'Y' AND ",l_wc_def
   END IF           
   PREPARE master_ext1 FROM g_sql
   DECLARE master_extcur1 CURSOR FOR master_ext1
 
   #搜尋建構樹所需的節點
   CASE p_type
      WHEN "1" #上推
         CALL aimi150_match_node(p_wc,p_type) 
      WHEN "2" #下展
         #CALL aimi150_find_speed_tbl(p_wc,p_type) 
         CALL aimi150_match_node(p_wc,p_type) 
      WHEN "3" #全部
         CALL aimi150_match_node(p_wc,p_type) 
   END CASE
 
   CALL aimi150_browser_create(p_type)
   RETURN
   #end add-point
 
   CALL g_browser.clear()
   CLEAR FORM
   LET l_cnt = 0
   LET l_cnt2 = 0
   
   DROP TABLE aimi150_tmp
   
   #Create temp table
   CREATE TEMP TABLE aimi150_tmp
   (
         ooed001 VARCHAR(500),
   ooed002 VARCHAR(500),
   ooed003 VARCHAR(500),
   ooed004 VARCHAR(500),
   ooed004_desc VARCHAR(500),
   ooed005 VARCHAR(500),
      #僅含browser的欄位
      exp_code  VARCHAR(5)
   );
 
   #先確定搜尋範圍(若無條件搜尋則只找root出來)
   SELECT COUNT(1) INTO l_cnt FROM ooed_t WHERE ooedent = g_enterprise AND 1=1
   
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT COUNT(1)",
               " FROM ooed_t ",
               "  ",
               " WHERE ooedent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("ooed_t")
   #add-point:browser_fill段cnt wc name="browser_fill.cnt_wc"
   
   #end add-point
              
   PREPARE master_cnt FROM g_sql
   DECLARE master_cntcur CURSOR FOR master_cnt
   OPEN master_cntcur
   IF SQLCA.SQLCODE THEN   #(ver:36)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN master_cntcur:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   FETCH master_cntcur INTO l_cnt2
   LET g_root_search = FALSE
   
   IF l_cnt2 = 0 THEN
      #INITIALIZE g_errparam TO NULL 
      #LET g_errparam.extend = "" 
      #LET g_errparam.code = "-100" 
      #LET g_errparam.popup = TRUE 
      #CALL cl_err()
      RETURN
   END IF
   
   IF l_cnt = l_cnt2 THEN
      #未輸入條件時則只查找root節點
      LET p_wc = " ooed004 = ooed005 "
      LET g_root_search = TRUE
   END IF
 
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT ooed001,ooed002,ooed003,ooed004,'',ooed005 ",
               " FROM ooed_t",
               "  ",
               " WHERE ooedent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("ooed_t")
   #add-point:browser_fill段sql wc name="browser_fill.sql_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooed_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_ext FROM g_sql
   DECLARE master_extcur CURSOR FOR master_ext
   
   #單筆update
   #LET g_sql = "SELECT '','','','','','','',ooed001,ooed002,ooed003,ooed004,'',ooed005 ",
   #            " FROM ooed_t",
   #            "  ",
   #            " WHERE ooedent = " ||g_enterprise|| " AND ",
   #            " ooed001 = ?"
   #            ," ooed002 = ?"
   #            ," ooed003 = ?"
   #            ," ooed004 = ?"
   #            ," ooed005 = ?"
 
                
   LET g_sql = " SELECT t0.ooed001,t0.ooed002,t0.ooed003,t0.ooed004,t0.ooed005,t1.ooefl003 ",
               " FROM ooed_t t0",
               "  ",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=ooed004 AND t1.ooefl002='"||g_dlang||"' ",
 
               " WHERE ooedent = " ||g_enterprise|| " AND ",
               " ooed001 = ?"
               ," AND ooed002 = ?"
               ," AND ooed003 = ?"
               ," AND ooed004 = ?"
               ," AND ooed005 = ?"
 
 
               
   #add-point:browser_fill段sql wc name="browser_fill.refresh"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_refresh FROM g_sql
   DECLARE master_refreshcur CURSOR FOR master_refresh
 
   #搜尋建構樹所需的節點
   CASE p_type
      WHEN "1" #上推
         CALL aimi150_match_node(p_wc,p_type) 
      WHEN "2" #下展
         #CALL aimi150_find_speed_tbl(p_wc,p_type) 
         CALL aimi150_match_node(p_wc,p_type) 
      WHEN "3" #全部
         CALL aimi150_match_node(p_wc,p_type) 
   END CASE
 
   CALL aimi150_browser_create(p_type)
     
END FUNCTION
 
{</section>}
 
{<section id="aimi150.match_node" >}
PRIVATE FUNCTION aimi150_match_node(p_wc,p_type)
   #add-point:match_node段define name="match_node.define_customerization"
   
   #end add-point
   DEFINE p_wc         LIKE type_t.chr200
   DEFINE p_type       LIKE type_t.chr10
   DEFINE ls_code      LIKE type_t.chr50
   DEFINE ls_code2     LIKE type_t.chr50
   DEFINE l_bstmp      RECORD    #body欄位
             ooed001 VARCHAR(500),
   ooed002 VARCHAR(500),
   ooed003 VARCHAR(500),
   ooed004 VARCHAR(500),
   ooed004_desc VARCHAR(500),
   ooed005 VARCHAR(500)
          #僅含單身table的欄位
   END RECORD 
   DEFINE l_child_list DYNAMIC ARRAY OF RECORD    #body欄位
             ooed001 VARCHAR(500),
   ooed002 VARCHAR(500),
   ooed003 VARCHAR(500),
   ooed004 VARCHAR(500),
   ooed004_desc VARCHAR(500),
   ooed005 VARCHAR(500)
          #僅含單身table的欄位
   END RECORD
   DEFINE li_cnt       LIKE type_t.num10   #(ver:35) add
   #add-point:match_node段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="match_node.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="match_node.pre_function"
   
   #end add-point
   
   #先找出符合條件的節點並給予展開值
   CASE p_type
      WHEN 1
         LET ls_code = "0" #展開值0則無法展開
      WHEN 2
         LET ls_code = "2"
      WHEN 3
         LET ls_code = "2"
   END CASE
   
   IF cl_null("ooed005") THEN
      LET ls_code = "0"
   END IF 
   
   CALL s_transaction_begin()
 
   LET g_sql = " INSERT INTO aimi150_tmp (ooed001,ooed002,ooed003,ooed004,ooed004_desc,ooed005,exp_code) VALUES (?, 
       ?,?,?,?,?,?)"
   PREPARE master_tmp FROM g_sql
   
   IF g_root_search THEN
      #DECLARE master_tmp_cur CURSOR FOR master_tmp
      #OPEN master_tmp_cur
      FOREACH master_extcur INTO l_bstmp.*
         EXECUTE master_tmp USING l_bstmp.*,ls_code
         #PUT master_tmp_cur FROM l_bstmp.*,ls_code
      END FOREACH
      #FLUSH master_tmp_cur
      CALL s_transaction_end("Y","0")
      RETURN
   END IF
 
   #(ver:35) ---modify start---
   FOREACH master_extcur INTO l_bstmp.*
      #(ver:35) add ooed005
      IF aimi150_tmp_tbl_chk(l_bstmp.ooed004,l_bstmp.ooed005,ls_code   #(ver:35) add ooed005
                  ,l_bstmp.ooed001
                  ) THEN
         EXECUTE master_tmp USING l_bstmp.*,ls_code
      END IF
 
      LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
   END FOREACH
 
   #找出符合條件的節點的所有祖先並給予展開值
   CASE p_type
      WHEN 1
         LET ls_code2 = "1"
      WHEN 2
         LET ls_code2 = "-1"
      WHEN 3
         LET ls_code2 = "1"
   END CASE
 
   WHILE TRUE
      IF l_child_list.getLength() <= 0 THEN
         EXIT WHILE
      END IF
 
      #若pid欄位存在才進行後續處理
      #擷取該節點的所有父節點
      IF cl_null(l_child_list[1].ooed004) THEN
         IF l_child_list.getLength() = 1 THEN
            EXIT WHILE
         ELSE
            CALL l_child_list.deleteElement(1)
            CONTINUE WHILE
         END IF
      END IF
 
      #確認是否有父節點
      LET g_sql = " SELECT COUNT(1) ",
                  " FROM ooed_t t0",
                  " WHERE ooedent = " ||g_enterprise|| " AND ooed004 = ? ",
                  " AND ooed001 = ? ",
                  cl_sql_add_filter("gzwe_t")
      PREPARE master_getparent_cnt FROM g_sql
      EXECUTE master_getparent_cnt USING l_child_list[1].ooed005 INTO li_cnt
      IF li_cnt <= 0 THEN
         CALL l_child_list.deleteElement(1)
         CONTINUE WHILE
      END IF
 
      #擷取該節點的父節點到temp table中
      LET g_sql = " SELECT ooed001,ooed002,ooed003,ooed004,'',ooed005 ",
                  " FROM ooed_t t0",
                  " WHERE ooedent = " ||g_enterprise|| " AND ooed004 = ? ",
                  " AND ooed001 = ? ",
                  cl_sql_add_filter("ooed_t")
      PREPARE master_getparent_up FROM g_sql
      DECLARE master_getparent_up_cur CURSOR FOR master_getparent_up
      
   #  EXECUTE master_getparent_up USING l_child_list[1].ooed005
   #                                    ,l_child_list[1].ooed001
   #                                    INTO l_bstmp.*
      FOREACH master_getparent_up_cur USING l_child_list[1].ooed005
                                        INTO l_bstmp.*
 
         IF SQLCA.SQLCODE THEN
            FREE master_getparent_up
            EXIT WHILE
         END IF
         #FREE master_getparent_up
      
         #確定該節點是否存在於temp table中
         IF STATUS = 0 AND aimi150_tmp_tbl_chk(l_bstmp.ooed004,l_bstmp.ooed005,ls_code2
                     ,l_bstmp.ooed001
                     ) THEN
            EXECUTE master_tmp USING l_bstmp.*,ls_code2
 
            #若已找到root，表示已到根結點
            IF l_bstmp.ooed004 = l_bstmp.ooed005 THEN
               CALL l_child_list.deleteElement(1)
               CONTINUE WHILE
            END IF
 
            LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
         END IF
      END FOREACH
      CALL l_child_list.deleteElement(1)
   END WHILE
   #(ver:35) --- modify end ---
 
   CLOSE master_tmp
   
   CALL s_transaction_end("Y","0")
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.tmp_tbl_chk" >}
#+ TEMP TABLE CHK
#PRIVATE FUNCTION aimi150_tmp_tbl_chk(ps_id,pi_code,ps_type)
PRIVATE FUNCTION aimi150_tmp_tbl_chk(ps_id,ps_pid,pi_code,ps_type)   #(ver:35) modify
   #add-point:tmp_tbl_chk段define name="tmp_tbl_chk.define_customerization"
   
   #end add-point
   DEFINE ps_id       STRING
   DEFINE ps_pid      STRING   #(ver:35) add
   DEFINE pi_code     LIKE type_t.num10
   DEFINE ps_type     STRING
   DEFINE ls_id       LIKE type_t.chr500
   DEFINE ls_pid      LIKE type_t.chr500   #(ver:35) add
   DEFINE ls_search   LIKE type_t.chr500
   DEFINE ls_type     LIKE type_t.chr500
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_code     LIKE type_t.num10   
   #add-point:tmp_tbl_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="tmp_tbl_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="tmp_tbl_chk.pre_function"
   
   #end add-point
   
   LET ls_id = ps_id
   LET ls_pid = ps_pid   #(ver:35) add
   LET ls_type = ps_type
  
   IF cl_null(ls_id) THEN
      RETURN TRUE
   END IF
   
   LET g_sql = " SELECT COUNT(1) FROM aimi150_tmp ", 
               " WHERE ooed004 = ? ",
                 " AND ooed005 = ? "   #(ver:35) add
                ," AND ooed001 = ? "
 
   PREPARE aimi150_get_cnt FROM g_sql
   EXECUTE aimi150_get_cnt USING ls_id ,ls_pid   #(ver:35) add ls_pid
                                           ,ls_type
                                     INTO li_cnt
   FREE aimi150_get_cnt
 
   IF li_cnt = 0 OR SQLCA.SQLCODE THEN
      RETURN TRUE
   ELSE
      #資料已存在, 確定是否需要更新展開值
      LET g_sql = " SELECT exp_code FROM aimi150_tmp ",
                  " WHERE ooed004 = ? ",
                    " AND ooed005 = ? "   #(ver:35) add
                   ," AND ooed001 = ? "
 
      PREPARE aimi150_chk_exp FROM g_sql
      EXECUTE aimi150_chk_exp USING ls_id ,ls_pid   #(ver;35) add ls_pid
                                              ,ls_type
                                        INTO li_code
      FREE aimi150_chk_exp
      
      #若新展開值>原展開值則做更新
      IF pi_code > li_code THEN
         LET g_sql = " UPDATE aimi150_tmp SET (exp_code) = ('",pi_code,"') ",
                     " WHERE ooed004 = ? ",
                       " AND ooed005 = ? "   #(ver:35) add
                      ," AND ooed001 = ? "
         PREPARE aimi150_upd_exp FROM g_sql
         EXECUTE aimi150_upd_exp USING ls_id ,ls_pid   #(ver:35) add ls_pid
                                                 ,ls_type
         FREE aimi150_upd_exp
      END IF
      
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.browser_expand" >}
#+ Tree子節點展開
PRIVATE FUNCTION aimi150_browser_expand(p_id)
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
   DEFINE ls_ent_wc     LIKE type_t.chr500
   #add-point:browser_expand段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand.define"
# 
#   #若已經展開
#   IF g_browser[p_id].b_isExp = 1 THEN
#      RETURN
#   END IF
#   
#   LET l_return = FALSE
# 
#   LET l_keyvalue = g_browser[p_id].b_ooed004
#   
#         
#   LET l_sql = "SELECT UNIQUE ooed004,ooed003 ",
#               "  FROM ooed_t ",
#               " WHERE ooedent = '",g_enterprise,"' ",
#               "   AND ooed005 = '",l_keyvalue,"' ",
#               "   AND ooed004 <> ooed005",
#               "   AND ooed001 = '8'",   #14/11/04 mod 2->8
#               "   AND ooed006 <= '",g_today,"' ",
#               "   AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ",
#               " ORDER BY ooed004"
#   
#   PREPARE tree_expand1 FROM l_sql
#   DECLARE tree_ex_cur1 CURSOR FOR tree_expand1
#  
#   LET l_id = p_id + 1
#   CALL g_browser.insertElement(l_id)
#   LET l_cnt = 1
#   FOREACH tree_ex_cur1 INTO g_browser[l_id].b_ooed004,g_browser[l_id].b_ooed003
#      #pid=父節點id
#      LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
#      #id=本身節點id(採流水號遞增)
#      LET g_browser[l_id].b_id  = g_browser[p_id].b_id||"."||l_cnt
#      LET g_browser[l_id].b_exp = TRUE
#      LET g_browser[l_id].b_ooed005 = g_browser[p_id].b_ooed004
#      LET g_browser[l_id].b_ooed002 = g_browser[p_id].b_ooed005
#      #hasC=確認該節點是否有子孫
#      CALL aimi150_desc_show(l_id)
#      LET g_browser[l_id].b_hasC = aimi150_chk_hasC(l_id)
#      IF g_browser[l_id].b_hasC = 1 THEN
#         CALL aimi150_browser_expand1(l_id)
#         LET l_id = g_browser.getLength()
#      END IF
#      LET l_id = l_id + 1
#      CALL g_browser.insertElement(l_id)
#      LET l_cnt = l_cnt + 1
#      LET l_return = TRUE
#   END FOREACH
#   LET l_cnt = l_cnt -1
#   #刪除空資料
#   CALL g_browser.deleteElement(l_id)
   RETURN
   #end add-point
   
   #add-point:Function前置處理  name="browser_expand.pre_function"
   
   #end add-point
   
   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_return = FALSE
 
   LET l_keyvalue = g_browser[p_id].b_ooed004
   LET l_typevalue = g_browser[p_id].b_ooed001
   
   CASE g_browser[p_id].b_expcode
      WHEN -1
         CALL g_browser.deleteElement(p_id)
      WHEN 0
         RETURN
      WHEN 1
         LET ls_source = "aimi150_tmp"
         LET ls_exp_code = "exp_code"
      WHEN 2
         LET ls_source = "ooed_t"
         LET ls_exp_code = "'2'"
         LET ls_ent_wc = " ooedent = " ||g_enterprise|| " AND "
   END CASE
    
   LET l_sql = " SELECT DISTINCT '','','','FALSE','','',",ls_exp_code,",ooed001,ooed002,ooed003,ooed004, 
       '',ooed005,t1.ooefl003 ",
               " FROM ",ls_source,
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=ooed004 AND t1.ooefl002='"||g_dlang||"' ",
 
               " WHERE ",ls_ent_wc,"ooed005 = '", l_keyvalue,
               "' AND ooed004 <> ooed005",
               " AND ooed001 = '", l_typevalue,"'", 
               " ORDER BY ooed004"
   
   #add-point:browser_expand段before_pre name="browser_expand.before_pre"
   
   #end add-point
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE tree_expand FROM l_sql
   DECLARE tree_ex_cur CURSOR FOR tree_expand
  
   LET l_id = p_id + 1
   LET g_cnt = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur INTO g_browser[l_id].*,g_browser[g_cnt].b_ooed004_desc 
      #pid=父節點id
      LET g_browser[l_id].b_pid = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id = g_browser[p_id].b_id||"."||l_cnt
      #hasC=確認該節點是否有子孫
      CALL aimi150_desc_show(l_id)
      LET g_browser[l_id].b_hasC = aimi150_chk_hasC(l_id)
      LET l_id = l_id + 1
      LET g_cnt = l_id
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE
   END FOREACH
   
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
   DISPLAY g_browser.getLength() TO FORMONLY.h_count 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.browser_create" >}
PRIVATE FUNCTION aimi150_browser_create(p_type)
   #add-point:browser_create name="browser_create.define_customerization"
   
   #end add-point
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50
   #add-point:browser_create(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_create.define"
   CALL aimi150_tree_create()
   RETURN
   #end add-point
   
   #add-point:Function前置處理  name="browser_create.pre_function"
   
   #end add-point
   
   #先找出所有的帳別資料
   LET g_sql = " SELECT DISTINCT ooed001 FROM aimi150_tmp ORDER BY ooed001"
   PREPARE master_type FROM g_sql
   DECLARE master_typecur CURSOR FOR master_type
   INITIALIZE g_browser_root TO NULL
   
   LET l_ac = 1
   FOREACH master_typecur INTO g_browser[l_ac].b_ooed001
      #確定root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處為帳別部分(LV-1)
      LET g_browser[l_ac].b_ooed004  = g_browser[l_ac].b_ooed001
      LET g_browser[l_ac].b_ooed001 = g_browser[l_ac].b_ooed001
      LET g_browser[l_ac].b_pid = "0" CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET l_ac = l_ac + 1
      
      #抓出LV2的所有資料
      #LET g_sql = " SELECT DISTINCT t0.ooed001,t0.ooed002,t0.ooed003,t0.ooed004,t0.ooed005,exp_code FROM aimi150_tmp a ", 
 
      LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,ooed001,ooed002,ooed003,ooed004, 
          '',ooed005,t1.ooefl003 FROM aimi150_tmp a ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=ooed004 AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE ",
                  "a.ooed001 = ? ",
                  " AND ",
                  " (( SELECT COUNT(1) FROM aimi150_tmp b WHERE a.ooed005 = b.ooed004 ", 
                  " AND a.ooed001 = b.ooed001",
                  ") = 0 OR ", 
                  " a.ooed004 = a.ooed005 )", 
                  " ORDER BY a.ooed004"
      #add-point:browser_create.before_pre name="browser_create.before_pre"
      
      #end add-point
 
      PREPARE master_getLV2 FROM g_sql
      DECLARE master_getLV2cur CURSOR FOR master_getLV2
      
      #以下為一般資料root(LV-2)
      #OPEN master_getLV2cur USING g_browser[l_ac-1].b_ooed001   #(ver:36)
 
      LET g_cnt = l_ac
      FOREACH master_getLV2cur   #(ver:36) #(ver:37)
         USING g_browser[l_ac-1].b_ooed001   #(ver:36)
         INTO g_browser[g_cnt].*,g_browser[g_cnt].b_ooed004_desc    #(ver:36)
         #(ver:36) ---add start---
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "Browser Create FOREACH ERROR"
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         #(ver:36) --- add end ---
 
         #去除多餘空白
         #LET g_browser[g_cnt].b_ooed004 = g_browser[g_cnt].b_ooed004 CLIPPED
         LET g_browser[g_cnt].b_pid = l_pid
         LET g_browser[g_cnt].b_id  = l_pid,".",g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp = FALSE
         #(ver:35) ---modify start---
         #LET g_browser[g_cnt].b_expcode = 2
         CASE g_browser[g_cnt].b_expcode
            WHEN 2
               LET g_browser[g_cnt].b_hasC = aimi150_chk_hasC(g_cnt)
            WHEN 1
               LET g_browser[g_cnt].b_hasC = aimi150_chk_hasC(g_cnt)
            WHEN 0
               LET g_browser[g_cnt].b_hasC = FALSE
            WHEN -1
               #向下查找到展開值不等於-1得節點(temp table中查找)
               LET g_cnt = aimi150_find_node(g_cnt)
         END CASE
         #(ver:35) --- modify end ---
         IF cl_null("ooed005") THEN
            LET g_browser[g_cnt].b_hasC = FALSE
         ELSE
            LET g_browser[g_cnt].b_hasC = TRUE
         END IF
 
         LET g_cnt = g_cnt + 1
      END FOREACH
      LET l_ac = g_browser.getLength()
 
   END FOREACH
   
   #組合描述欄位&刪除多於資料
   FOR l_ac = 1 TO g_browser.getLength()
      IF cl_null(g_browser[l_ac].b_ooed004) THEN
         CALL g_browser.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         CALL aimi150_desc_show(l_ac)
      END IF
   END FOR
   CALL g_browser.deleteElement(l_ac)
 
   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
 
   FREE tree_expand
   FREE master_getLV2
   
END FUNCTION
 
{</section>}
 
{<section id="aimi150.desc_show" >}
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION aimi150_desc_show(pi_ac)
   #add-point:desc_show段define name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10   
   #add-point:desc_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   DEFINE l_ooed003    LIKE ooed_t.ooed003
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   IF cl_null(l_ac) OR l_ac = 0 THEN
      LET l_ac = 1
   END IF
   IF cl_null(g_browser[l_ac].b_ooed004) AND cl_null(g_browser[l_ac].b_ooed005) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[l_ac].b_ooed002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[l_ac].b_ooed004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[l_ac].b_ooed004_desc
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed002,'(',g_browser[l_ac].b_ooed003,')'
   ELSE
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed004
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[l_ac].b_ooed004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[l_ac].b_ooed004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[l_ac].b_ooed004_desc
   END IF
   RETURN
   #end add-point
   
   #add-point:Function前置處理  name="desc_show.pre_function"
   
   #end add-point
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   
   
   #add-point:browser_create段desc處理 name="desc_show.show"
   IF cl_null(g_browser[l_ac].b_ooed004) AND cl_null(g_browser[l_ac].b_ooed005) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[l_ac].b_ooed002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET g_browser[l_ac].b_ooed004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[l_ac].b_ooed004_desc
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed002,'(',g_browser[l_ac].b_ooed003,')'
   ELSE
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_ooed004
   END IF

   #end add-point
 
   LET l_ac = li_tmp
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.find_node" >}
#+ 尋找符合條件的節點
PRIVATE FUNCTION aimi150_find_node(pi_ac)
   #add-point:find_node段define name="find_node.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   DEFINE ls_pid  STRING
   #add-point:find_node段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="find_node.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="find_node.pre_function"
   
   #end add-point
   
   LET ls_pid = g_browser[pi_ac].b_pid
   
   LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,ooed001,ooed002,ooed003,ooed004,'', 
       ooed005 ",
               " FROM aimi150_tmp ",
               " WHERE ooed005 = ? AND ooed005 <> ooed004",
               " ORDER BY ooed004"
   PREPARE master_getNode FROM g_sql
   DECLARE master_getNodecur CURSOR FOR master_getNode
   
   LET li_idx = pi_ac
   WHILE li_idx <= g_browser.getLength()
      IF g_browser[li_idx].b_expcode = -1 THEN
      #  OPEN master_getNodecur USING g_browser[li_idx].b_ooed004   #(ver:36)
         FOREACH master_getNodecur USING g_browser[li_idx].b_ooed004 INTO g_browser[g_browser.getLength()+1].*  
               #(ver:36)
 
            #(ver:36) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH ",SQLERRMESSAGE
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               RETURN
            END IF
            #(ver:36) --- end ---
            CALL aimi150_desc_show(g_browser.getLength())
            LET g_browser[g_browser.getLength()].b_pid = ls_pid
            LET g_browser[g_browser.getLength()].b_id = g_browser.getLength()
            LET g_browser[g_browser.getLength()].b_hasC = aimi150_chk_hasC(g_browser.getLength())
         END FOREACH
         CALL g_browser.deleteElement(li_idx)
         CALL g_browser.deleteElement(g_browser.getLength())
      ELSE
         LET li_idx = li_idx + 1
      END IF
   
   END WHILE
   
   FREE master_getNode
   
   RETURN g_browser.getLength()
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.chk_hasC" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi150_chk_hasC(pi_id)
   #add-point:chk_hasC段define name="chk_hasC.define_customerization"
   
   #end add-point
   DEFINE pi_id    LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:chk_hasC段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="chk_hasC.define"
   LET g_sql = "SELECT COUNT(*) FROM ooed_t ",
               " WHERE ooedent = '" ||g_enterprise|| "'",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed001 = '8'",   #14/11/04 mod 2->8
               "   AND ooed006 <= '",g_today,"' ",
               "   AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ", 
               "   AND ooed005 = ? ",
               "   AND ooed002 = ? ",
               "   AND ooed003 = ? "
   PREPARE aimi150_master_chk1 FROM g_sql 
   EXECUTE aimi150_master_chk1 USING g_browser[pi_id].b_ooed004,g_browser[pi_id].b_ooed002,g_browser[pi_id].b_ooed003 INTO li_cnt
   FREE aimi150_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
   #end add-point
   
   #add-point:Function前置處理  name="chk_hasC.pre_function"
   
   #end add-point
   
   LET g_sql = "SELECT COUNT(ooed005) FROM aimi150_tmp ",
               " WHERE ",
                "ooed005 = ? AND ",
                "exp_code <> '-1' AND ooed004 <> ooed005 "
                 ," AND ",
                "ooed001 = ?"
 
   PREPARE aimi150_temp_chk FROM g_sql
 
   LET g_sql = "SELECT COUNT(1) FROM ooed_t ",
               " WHERE ooedent = " ||g_enterprise|| " AND ", 
               "ooed004 <> ooed005 AND ",
               "ooed005 = ? ",
                " AND ",
               "ooed001 = ?",
               cl_sql_add_filter("ooed_t")
   
   PREPARE aimi150_master_chk FROM g_sql
   
   CASE g_browser[pi_id].b_expcode 
      WHEN -1
         RETURN FALSE
      WHEN 0
         RETURN FALSE
      WHEN 1
         EXECUTE aimi150_temp_chk 
           USING g_browser[pi_id].b_ooed004
                 ,g_browser[pi_id].b_ooed001
            INTO li_cnt
         FREE aimi150_temp_chk
      WHEN 2 
         EXECUTE aimi150_master_chk 
           USING g_browser[pi_id].b_ooed004
                 ,g_browser[pi_id].b_ooed001
            INTO li_cnt
         FREE aimi150_master_chk
   END CASE
    
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi150_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_wc       STRING
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   CALL g_imda_d.clear()        
   CALL g_imda2_d.clear()

   LET g_current_idx = 1
   LET g_action_choice = ""
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc_table1 TO NULL
   INITIALIZE g_wc_table2 TO NULL
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面
   CLEAR FORM
   INITIALIZE g_ooed_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_qryparam.state = "c"
    
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT BY NAME g_wc ON ooed004,ooed001,ooed002,ooed003,ooed005 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
            
         
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed004
            #add-point:BEFORE FIELD ooed004 name="construct.b.ooed004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed004
            
            #add-point:AFTER FIELD ooed004 name="construct.a.ooed004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooed004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed004
            #add-point:ON ACTION controlp INFIELD ooed004 name="construct.c.ooed004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooed004  #顯示到畫面上

            NEXT FIELD ooed004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed001
            #add-point:BEFORE FIELD ooed001 name="construct.b.ooed001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed001
            
            #add-point:AFTER FIELD ooed001 name="construct.a.ooed001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooed001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed001
            #add-point:ON ACTION controlp INFIELD ooed001 name="construct.c.ooed001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed002
            #add-point:BEFORE FIELD ooed002 name="construct.b.ooed002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed002
            
            #add-point:AFTER FIELD ooed002 name="construct.a.ooed002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooed002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed002
            #add-point:ON ACTION controlp INFIELD ooed002 name="construct.c.ooed002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed003
            #add-point:BEFORE FIELD ooed003 name="construct.b.ooed003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed003
            
            #add-point:AFTER FIELD ooed003 name="construct.a.ooed003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooed003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed003
            #add-point:ON ACTION controlp INFIELD ooed003 name="construct.c.ooed003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed005
            #add-point:BEFORE FIELD ooed005 name="construct.b.ooed005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed005
            
            #add-point:AFTER FIELD ooed005 name="construct.a.ooed005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooed005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed005
            #add-point:ON ACTION controlp INFIELD ooed005 name="construct.c.ooed005"
            
            #END add-point
 
 
 
       
      END CONSTRUCT
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT g_wc_table1 ON imdastus,imda002,imda004,imda005,imda003,imdamodid,imdamoddt,imdaownid,imdaowndp,imdacrtid,imdacrtdp,imdacrtdt
           FROM s_detail1[1].imdastus,s_detail1[1].imda002,s_detail1[1].imda004,s_detail1[1].imda005,s_detail1[1].imda003,s_detail1[1].imdamodid,s_detail1[1].imdamoddt,s_detail1[1].imdaownid,s_detail1[1].imdaowndp,s_detail1[1].imdacrtid,s_detail1[1].imdacrtdp,s_detail1[1].imdacrtdt
                      
         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)

         BEFORE FIELD imdastus

         AFTER FIELD imdastus

         ON ACTION controlp INFIELD imdastus

         BEFORE FIELD imda002

         AFTER FIELD imda002

         ON ACTION controlp INFIELD imda002
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO imda002  #顯示到畫面上
            NEXT FIELD imda002
             
         BEFORE FIELD imda004
            
         AFTER FIELD imda004

         ON ACTION controlp INFIELD imda004
         
         BEFORE FIELD imda005
            
         AFTER FIELD imda005

         ON ACTION controlp INFIELD imda005
             
         BEFORE FIELD imda003
            
         AFTER FIELD imda003

         ON ACTION controlp INFIELD imda003

         ON ACTION controlp INFIELD imdaownid
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdaownid  #顯示到畫面上

            NEXT FIELD imdaownid                     #返回原欄位

         BEFORE FIELD imdaownid

         AFTER FIELD imdaownid
            
        
         ON ACTION controlp INFIELD imdaowndp
          
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdaowndp  #顯示到畫面上

            NEXT FIELD imdaowndp                     #返回原欄位

         BEFORE FIELD imdaowndp


         AFTER FIELD imdaowndp
 
            

         ON ACTION controlp INFIELD imdacrtid
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdacrtid  #顯示到畫面上

            NEXT FIELD imdacrtid                     #返回原欄位


         BEFORE FIELD imdacrtid
        
         AFTER FIELD imdacrtid
            
     
         BEFORE FIELD imdacrtdt
         
         ON ACTION controlp INFIELD imdacrtdp

            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdacrtdp  #顯示到畫面上

            NEXT FIELD imdacrtdp                     #返回原欄位


         BEFORE FIELD imdacrtdp
         
         AFTER FIELD imdacrtdp
         
         ON ACTION controlp INFIELD imdamodid

            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdamodid  #顯示到畫面上

            NEXT FIELD imdamodid                     #返回原欄位


            
         BEFORE FIELD imdamodid
           
         AFTER FIELD imdamodid
            
            
         BEFORE FIELD imdamoddt
       
      END CONSTRUCT
      
      CONSTRUCT g_wc_table2 ON imdbstus,imdb002,imdb004,imdb005,imdb003,imdbmodid,imdbmoddt,imdbownid,imdbowndp,imdbcrtid,imdbcrtdp,imdbcrtdt
           FROM s_detail2[1].imdbstus,s_detail2[1].imdb002,s_detail2[1].imdb004,s_detail2[1].imdb005,s_detail2[1].imdb003,s_detail2[1].imdbmodid,s_detail2[1].imdbmoddt,s_detail2[1].imdbownid,s_detail2[1].imdbowndp,s_detail2[1].imdbcrtid,s_detail2[1].imdbcrtdp,s_detail2[1].imdbcrtdt
                      
         BEFORE CONSTRUCT
           # CALL cl_qbe_display_condition(lc_qbe_sn)

         BEFORE FIELD imdbstus

         AFTER FIELD imdbstus

         ON ACTION controlp INFIELD imdbstus

         BEFORE FIELD imdb002

         AFTER FIELD imdb002

         ON ACTION controlp INFIELD imdb002
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdb002  #顯示到畫面上
            NEXT FIELD imdb002
             
         BEFORE FIELD imdb004
            
         AFTER FIELD imdb004

         ON ACTION controlp INFIELD imdb004
         
         BEFORE FIELD imdb005
            
         AFTER FIELD imdb005

         ON ACTION controlp INFIELD imdb005
             
         BEFORE FIELD imdb003
            
         AFTER FIELD imdb003

         ON ACTION controlp INFIELD imdb003

         ON ACTION controlp INFIELD imdbownid
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdbownid  #顯示到畫面上

            NEXT FIELD imdbownid                     #返回原欄位

         BEFORE FIELD imdbownid

         AFTER FIELD imdbownid
            
        
         ON ACTION controlp INFIELD imdbowndp
          
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdbowndp  #顯示到畫面上

            NEXT FIELD imdbowndp                     #返回原欄位

         BEFORE FIELD imdbowndp


         AFTER FIELD imdbowndp
 
            

         ON ACTION controlp INFIELD imdbcrtid
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdbcrtid  #顯示到畫面上

            NEXT FIELD imdbcrtid                     #返回原欄位


         BEFORE FIELD imdbcrtid
        
         AFTER FIELD imdbcrtid
            
     
         BEFORE FIELD imdbcrtdt
         
         ON ACTION controlp INFIELD imdbcrtdp

            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdbcrtdp  #顯示到畫面上

            NEXT FIELD imdbcrtdp                     #返回原欄位


         BEFORE FIELD imdbcrtdp
         
         AFTER FIELD imdbcrtdp
         
         ON ACTION controlp INFIELD imdbmodid

            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imdbmodid  #顯示到畫面上

            NEXT FIELD imdbmodid                     #返回原欄位


            
         BEFORE FIELD imdbmodid
           
         AFTER FIELD imdbmodid
            
            
         BEFORE FIELD imdbmoddt
       
      END CONSTRUCT
      #end add-point
         
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段before dialog name="cs.before_dialog"
         
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
 
   #add-point:cs段after_construct name="cs.after_construct"
   LET g_wc2 = g_wc_table1
   IF g_wc_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc_table2
   END IF
   #end add-point
   
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimi150_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.before_query"
   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_imda_d.clear()
   CALL g_imda2_d.clear()


   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count   
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
 
   #CLEAR FORM
   #CALL g_browser.clear()
 
   DISPLAY ' ' TO FORMONLY.b_count
 
   CALL aimi150_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      #CALL aimi150_browser_fill(g_wc,g_searchtype)
      CALL aimi150_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_browser_cnt = 1
      LET g_current_idx = 1
      CALL g_browser.clear()
   END IF
 
   LET g_searchtype = "3"
   LET g_searchcol = "0"
   CALL aimi150_browser_fill(g_wc,g_searchtype)
   
   #第一層模糊搜尋
   IF g_browser_cnt = 0 THEN
      LET g_wc = cl_wc_parser(g_wc)
      CALL aimi150_browser_fill(g_wc,g_searchtype)
   END IF
 
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-100'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   RETURN
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
 
   #CLEAR FORM
   #CALL g_browser.clear()
 
   DISPLAY " " TO FORMONLY.h_count
 
   CALL aimi150_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      #add-point:query段取消 name="query.cancel"
      
      #end add-point
      #CALL aimi150_browser_fill(g_wc,g_searchtype)
      CALL aimi150_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_browser_cnt = 0
      LET g_current_idx = 1
      CALL g_browser.clear()
      LET g_first = 0  #設定重新查詢資料後顯示
   END IF
 
   LET g_searchtype = "3"
   LET g_searchcol = "0"
   CALL aimi150_browser_fill(g_wc,g_searchtype)
   
   IF g_browser_cnt > 0 THEN
      CALL aimi150_fetch("")
   ELSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #第一層模糊搜尋
   #IF g_browser_cnt = 0 THEN
   #   LET g_wc = cl_wc_parser(g_wc)
   #   CALL aimi150_browser_fill(g_wc,g_searchtype)
   #END IF
   
   #第二層速記碼搜尋
   #IF g_browser_cnt = 0 THEN
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "" 
   #   LET g_errparam.code = "-100" 
   #   LET g_errparam.popup = TRUE 
   #   CALL cl_err()
   #END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimi150_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DISPLAY g_current_idx TO FORMONLY.h_count
   LET ls_chk = g_browser[g_current_idx].b_id 
   #瀏覽頁筆數顯示
   LET li_idx = 1
   FOR li_idx = 1 TO g_browser_root.getLength()
      IF g_browser_root[li_idx] > g_current_idx THEN
       EXIT FOR
      END IF
   END FOR
   LET li_idx = g_current_idx - li_idx + 1
   DISPLAY li_idx TO FORMONLY.b_index   #當下筆數
      
   IF p_flag = '/' THEN
      IF (NOT g_no_ask) THEN      
         CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
         LET INT_FLAG = 0
 
         PROMPT ls_msg CLIPPED,': ' FOR g_jump
            #交談指令共用ACTION
            &include "common_action.4gl" 
         END PROMPT
 
         IF INT_FLAG THEN
            LET INT_FLAG = 0
         ELSE
            IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
               LET g_current_idx = g_jump
            END IF
            LET g_no_ask = FALSE  
         END IF           
      END IF
   END IF    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
              
   LET g_ooed_m.ooed004 = g_browser[g_current_idx].b_ooed004
   LET g_ooed_m.ooed005 = g_browser[g_current_idx].b_ooed005
   LET g_ooed_m.ooed001 = g_browser[g_current_idx].b_ooed001
    
   #add-point:fetch段refresh前
   IF cl_null(g_ooed_m.ooed004) THEN LET g_ooed_m.ooed004 = g_browser[g_current_idx].b_ooed002 END IF
   LET g_ooed_m.ooed002 = g_browser[g_current_idx].b_ooed002
   LET g_ooed_m.ooed003 = g_browser[g_current_idx].b_ooed003
   LET g_ooed_m.ooed001 = '8'   #14/11/04 mod 2->8
   #end add-point
    
   #重讀DB,因TEMP有不被更新特性
#    SELECT UNIQUE ooed004,ooed001,ooed002,ooed003,ooed005
# INTO g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005
# FROM ooed_t
# WHERE ooedent = g_enterprise AND ooed001 = g_ooed_m.ooed001 AND ooed002 = g_ooed_m.ooed002 AND ooed003 = g_ooed_m.ooed003 AND ooed004 = g_ooed_m.ooed004 
#   
#   IF SQLCA.sqlcode THEN
#       CALL cl_err("ooed_t",SQLCA.sqlcode,1)
#       INITIALIZE g_ooed_m.* TO NULL
#       RETURN
#   END IF

    SELECT UNIQUE ooef001 INTO g_ooed_m.ooed004
      FROM ooef_t
     WHERE ooefent = g_enterprise
       AND ooef001 = g_ooed_m.ooed004
   IF SQLCA.sqlcode THEN
       INITIALIZE g_ooed_m.* TO NULL
       RETURN
   END IF
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
   #add-point:fetch段after_fetch

   #end add-point
 
   
   #重新顯示
   CALL aimi150_show()
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   DISPLAY g_browser_cnt TO FORMONLY.b_count 
   
   RETURN
   #end add-point
   
   #add-point:Function前置處理  name="fetch.befroe_fetch"
   
   #end add-point 
 
   LET ls_chk = g_browser[g_current_idx].b_id 
   IF ls_chk.getIndexOf(".",1) = 0 THEN
      INITIALIZE g_ooed_m.* TO NULL
      DISPLAY BY NAME g_ooed_m.*
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   #   DISPLAY "" TO FORMONLY.h_index
      RETURN
   END IF
 
   #瀏覽頁筆數顯示
   LET li_idx = 1
   FOR li_idx = 1 TO g_browser_root.getLength()
      IF g_browser_root[li_idx] > g_current_idx THEN
       EXIT FOR
      END IF
   END FOR
   LET li_idx = g_current_idx - li_idx + 1
   #DISPLAY li_idx TO FORMONLY.h_index   #當下筆數
 
   IF p_flag = "/" THEN
      IF (NOT g_no_ask) THEN      
         CALL cl_getmsg("fetch",g_lang) RETURNING ls_msg
         LET INT_FLAG = 0
 
         PROMPT ls_msg CLIPPED,": " FOR g_jump
            #交談指令共用ACTION
            &include "common_action.4gl" 
         END PROMPT
 
         IF INT_FLAG THEN
            LET INT_FLAG = 0
         ELSE
            IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
               LET g_current_idx = g_jump
            END IF
            LET g_no_ask = FALSE  
         END IF           
      END IF
   END IF    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   LET g_ooed_m.ooed004 = g_browser[g_current_idx].b_ooed004
   LET g_ooed_m.ooed005 = g_browser[g_current_idx].b_ooed005
   LET g_ooed_m.ooed001 = g_browser[g_current_idx].b_ooed001
    
   #add-point:fetch段refresh前 name="fetch.before_refresh"
   LET g_ooed_m.ooed002 = g_browser[g_current_idx].b_ooed002
   LET g_ooed_m.ooed003 = g_browser[g_current_idx].b_ooed003
   LET g_ooed_m.ooed001 = '8'   #14/11/04 mod 2->8
   #end add-point
    
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aimi150_master_referesh USING g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004, 
       g_ooed_m.ooed005 INTO g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005, 
       g_ooed_m.ooed004_desc 
   
   IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "ooed_t:",SQLERRMESSAGE 
       LET g_errparam.code = SQLCA.SQLCODE 
       LET g_errparam.popup = TRUE 
       CALL cl_err()
       INITIALIZE g_ooed_m.* TO NULL
       RETURN
   END IF
   
   #若無資料則關閉相關功能
   IF g_browser.getLength() = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
   #add-point:fetch段after_fetch name="fetch.after_fetch"
   
   #end add-point
 
   
   
   #保存單頭舊值
   LET g_ooed_m_t.* = g_ooed_m.*
   LET g_ooed_m_o.* = g_ooed_m.*
   
   #重新顯示
   CALL aimi150_show()
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   DISPLAY g_browser.getLength() TO FORMONLY.h_count 
 
   
   
END FUNCTION
 
{</section>}
 
{<section id="aimi150.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimi150_insert(l_dialog)
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point
   DEFINE l_dialog   ui.DIALOG
   DEFINE li_addpos  LIKE type_t.num10 #新增節點時產出的畫面實際位置
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   LET g_ooed001_t = g_ooed_m.ooed001
   LET g_ooed002_t = g_ooed_m.ooed002
   LET g_ooed003_t = g_ooed_m.ooed003
   LET g_ooed004_t = g_ooed_m.ooed004
   LET g_ooed005_t = g_ooed_m.ooed005
 
   LET g_ooed004_t = g_ooed_m.ooed004
   LET g_ooed001_t = g_ooed_m.ooed001
 
   #清畫面欄位內容
   CLEAR g_ooed_m.*
 
 
   #add-point:單頭預設值 name="insert.before_insert"
   CLEAR FORM               #清畫面欄位內容
   CALL g_imda_d.clear()    #清除陣列
   CALL g_imda2_d.clear()   #清除陣列
   INITIALIZE g_ooed_m_t.* TO NULL
   #end add-point 
 
   INITIALIZE g_ooed_m.* LIKE ooed_t.*
   DISPLAY BY NAME g_ooed_m.ooed004,g_ooed_m.ooed004_desc,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003, 
       g_ooed_m.ooed005
   CALL s_transaction_begin()
 
   #其他table資料備份(確定是否更改用)
   
 
   WHILE TRUE
      #給予pid,type預設值
      LET g_ooed_m.ooed005 = g_ooed004_t
      LET g_ooed_m.ooed001 = g_ooed001_t
      
      
      CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
  
      
      
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL aimi150_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL g_imda_d.clear()
      CALL g_imda2_d.clear() 
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooed_m.* = g_ooed_m_t.*
         CALL aimi150_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         EXIT WHILE
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_ooed_m.ooed005 = g_ooed_m.ooed004 THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_ooed005 = g_ooed_m.ooed005
            LET g_browser[li_addpos].b_ooed004 = g_ooed_m.ooed004
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL aimi150_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_ooed004 = g_ooed_m.ooed005 THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_ooed005 = g_ooed_m.ooed005
                     LET g_browser[li_addpos].b_ooed004 = g_ooed_m.ooed004
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_ooed001
                                                     ,g_browser[li_addpos].b_ooed002
                                                     ,g_browser[li_addpos].b_ooed003
                                                     ,g_browser[li_addpos].b_ooed004
                                                     ,g_browser[li_addpos].b_ooed005
 
                                                INTO g_browser[g_cnt].b_ooed001,g_browser[g_cnt].b_ooed002, 
                                                    g_browser[g_cnt].b_ooed003,g_browser[g_cnt].b_ooed004, 
                                                    g_browser[g_cnt].b_ooed005,g_browser[g_cnt].b_ooed004_desc 
 
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL aimi150_desc_show(li_addpos)
                     #打開父節點
                     LET g_browser[li_idx].b_hasC = TRUE
                     LET g_browser[li_idx].b_exp = TRUE
                     LET g_current_idx = li_addpos
                     EXIT FOR
                  END IF
               END FOR
            END IF
            LET g_cnt = li_cnt
         END IF
      END IF
      
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimi150_master_referesh USING g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004, 
       g_ooed_m.ooed005 INTO g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005, 
       g_ooed_m.ooed004_desc
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooed_m.ooed004,g_ooed_m.ooed004_desc,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003, 
       g_ooed_m.ooed005
   
   #功能已完成,通報訊息中心
   CALL aimi150_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi150.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimi150_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_ooed_m.ooed004 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF 
   
    SELECT UNIQUE ooef001 INTO g_ooed_m.ooed004
      FROM ooef_t
     WHERE ooefent = g_enterprise
       AND ooef001 = g_ooed_m.ooed004
  
   ERROR ""
  
   LET g_ooed001_t = g_ooed_m.ooed001
   LET g_ooed002_t = g_ooed_m.ooed002

   LET g_ooed003_t = g_ooed_m.ooed003

   LET g_ooed004_t = g_ooed_m.ooed004

   CALL s_transaction_begin()
 
   CALL aimi150_show()
   WHILE TRUE
      LET g_ooed_m.ooed001 = g_ooed001_t
      LET g_ooed_m.ooed002 = g_ooed002_t

      LET g_ooed_m.ooed003 = g_ooed003_t

      LET g_ooed_m.ooed004 = g_ooed004_t


      
      #寫入修改者/修改日期資訊
      
 
      #add-point:modify段修改前

      #end add-point
      
      CALL aimi150_input("u")     #欄位更改
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
          LET INT_FLAG = 0
          LET g_ooed_m.* = g_ooed_m_t.*
          CALL aimi150_show()
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 9001
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          EXIT WHILE
      END IF
 
      EXIT WHILE
  
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_ooed_m.ooed004,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimi150_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_ooed_m.ooed004,'U')
   RETURN
   #end add-point
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_ooed_m.ooed001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
   
   EXECUTE aimi150_master_referesh USING g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004, 
       g_ooed_m.ooed005 INTO g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005, 
       g_ooed_m.ooed004_desc
 
   #檢查是否允許此動作
   IF NOT aimi150_action_chk() THEN
      RETURN
   END IF
  
   LET g_ooed001_t = g_ooed_m.ooed001
   LET g_ooed002_t = g_ooed_m.ooed002
   LET g_ooed003_t = g_ooed_m.ooed003
   LET g_ooed004_t = g_ooed_m.ooed004
   LET g_ooed005_t = g_ooed_m.ooed005
 
   
   CALL s_transaction_begin()
   
   OPEN aimi150_cl USING g_enterprise,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004,g_ooed_m.ooed005
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE aimi150_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi150_cl:" 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH aimi150_cl INTO g_ooed_m.ooed004,g_ooed_m.ooed004_desc,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003, 
       g_ooed_m.ooed005
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.SQLCODE THEN
      CLOSE aimi150_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_ooed_m.ooed004,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #其他table資料備份(確定是否更改用)
   
 
   CALL aimi150_show()
   WHILE TRUE
      LET g_ooed_m.ooed001 = g_ooed001_t
      LET g_ooed_m.ooed002 = g_ooed002_t
      LET g_ooed_m.ooed003 = g_ooed003_t
      LET g_ooed_m.ooed004 = g_ooed004_t
      LET g_ooed_m.ooed005 = g_ooed005_t
 
      
      #寫入修改者/修改日期資訊
      
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aimi150_input("u")     #欄位更改
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooed_m.* = g_ooed_m_t.*
         CALL aimi150_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
 
      
      EXIT WHILE
  
   END WHILE
 
   CLOSE aimi150_cl
   CALL s_transaction_end("Y","0")
 
   #功能已完成,通報訊息中心
   CALL aimi150_msgcentre_notify('modify')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi150.check" >}
#+ 避免資料錯誤
PRIVATE FUNCTION aimi150_check(ps_id,ps_pid ,ps_type)
   #add-point:check段define name="check.define_customerization"
   
   #end add-point
   DEFINE ps_id       STRING
   DEFINE ps_pid      STRING
   DEFINE ps_type     STRING
   DEFINE ls_pid      LIKE type_t.chr100
   DEFINE ls_id       LIKE type_t.chr100
   DEFINE ls_type     LIKE type_t.chr100
   DEFINE ls_return   LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   #add-point:check段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="check.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="check.pre_function"
   
   #end add-point
   
   #從該節點往上檢查, 若出現ID重複的狀況代表會導致無限迴圈
   LET ls_sql = " SELECT ooed004,ooed005 FROM ",
                " (SELECT ooed004,ooed005 FROM ooed_t WHERE ooedent = " ||g_enterprise|| " AND ooed004<>ooed005)", 
 
                " WHERE ooed004 = '",ps_id,"' OR ooed005 = '",ps_id,"'",
                " START WITH ooed004='",ps_pid,"'",
                " CONNECT BY PRIOR ooed005=ooed004 "
 
   PREPARE check_cnt FROM ls_sql
   DECLARE check_cntcur CURSOR FOR check_cnt
   OPEN check_cntcur
   IF SQLCA.SQLCODE THEN   #(ver:36)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN check_cntcur:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
 
   FETCH check_cntcur INTO li_cnt
 
   IF li_cnt > 0 THEN
      LET ls_return = TRUE
   ELSE
      LET ls_return = FALSE
   END IF
   
   RETURN ls_return 
   
END FUNCTION
 
{</section>}
 
{<section id="aimi150.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimi150_reproduce(l_dialog)
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_dialog      ui.DIALOG
   DEFINE li_addpos     LIKE type_t.num10
   DEFINE l_newno           LIKE ooed_t.ooed001 
   DEFINE l_oldno           LIKE ooed_t.ooed001 
   DEFINE l_newno02     LIKE ooed_t.ooed002 
   DEFINE l_oldno02     LIKE ooed_t.ooed002 
   DEFINE l_newno03     LIKE ooed_t.ooed003 
   DEFINE l_oldno03     LIKE ooed_t.ooed003 
   DEFINE l_newno04     LIKE ooed_t.ooed004 
   DEFINE l_oldno04     LIKE ooed_t.ooed004 
   DEFINE l_newno05     LIKE ooed_t.ooed005 
   DEFINE l_oldno05     LIKE ooed_t.ooed005 
 
   DEFINE l_master          RECORD LIKE ooed_t.*
   DEFINE l_cnt             LIKE type_t.num10  
   DEFINE li_idx            LIKE type_t.num10  
   DEFINE li_cnt            LIKE type_t.num10  
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.before_reproduce"
   DEFINE l_sql             STRING
   DEFINE l_time            LIKE imda_t.imdacrtdt
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   IF g_ooed_m.ooed004 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
    
   CALL aimi150_set_entry('a')
   CALL aimi150_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   LET g_ooed_m.ooed004_desc = ''
   DISPLAY BY NAME g_ooed_m.ooed004_desc

   
   INPUT l_newno       
        ,l_newno02

        ,l_newno03

        ,l_newno04


   FROM ooed001
        ,ooed002

        ,ooed003

        ,ooed004


        ATTRIBUTE(FIELD ORDER FORM)

      ON ACTION controlp INFIELD ooed004   
            #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = l_newno04             #給予default值
            #給予arg
            LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                                #呼叫開窗
            LET l_newno04 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY l_newno04 TO ooed004                    #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_newno04
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooed_m.ooed004_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_ooed_m.ooed004_desc
            NEXT FIELD ooed004                              #返回原欄位

        
      BEFORE INPUT
         LET l_newno = '2'

      AFTER FIELD ooed004
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = l_newno04
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_ooed_m.ooed004_desc = g_rtn_fields[1]
         DISPLAY BY NAME g_ooed_m.ooed004_desc
         IF NOT cl_null(l_newno04) THEN
            IF NOT ap_chk_isExist(l_newno04,"SELECT COUNT(*) FROM ooef_t WHERE ooefent = '" ||g_enterprise||"' AND ooef001 = ? ","aoo-00090",0 ) THEN
               LET l_newno04 = ""
               LET g_ooed_m.ooed004_desc = ""
               DISPLAY BY NAME g_ooed_m.ooed004_desc
               NEXT FIELD ooed004
            END IF
            IF NOT ap_chk_isExist(l_newno04,"SELECT COUNT(*) FROM ooef_t WHERE ooefent = '" ||g_enterprise||"' AND ooef001 = ? AND ooefstus = 'Y' ","sub-01302",'aooi100') THEN #160318-00005#20 mod#"aoo-00091",0 ) THEN
               LET l_newno04 = ""
               LET g_ooed_m.ooed004_desc = ""
               DISPLAY BY NAME g_ooed_m.ooed004_desc
               NEXT FIELD ooed004
            END IF
         END IF


            
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT
         
   END INPUT
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   CALL s_transaction_begin()
 
   LET l_time = cl_get_current()
   LET l_sql = "  MERGE INTO imda_t ",
               "  USING(SELECT DISTINCT imdaent imdaent_b,imda001 imda001_b,imda002 imda002_b,imda003 imda003_b,imda004 imda004_b,imda005 imda005_b ",
               "          FROM imda_t  ",
               "         WHERE imda001 = '",g_ooed_m.ooed004,"'",
               "           AND imdaent = '",g_enterprise,"')",
               "     ON(imda001 = '",l_newno04,"' AND imda002 = imda002_b AND imdaent = imdaent_b) ",
               "   WHEN NOT MATCHED THEN ",
               " INSERT(imdaent,imda001,imda002,imdastus,imda003,imda004,imda005,imdaownid,imdaowndp,imdacrtid,imdacrtdt,imdacrtdp,imdamodid,imdamoddt)",
               " VALUES('",g_enterprise,"','",l_newno04,"',imda002_b,'Y',imda003_b,imda004_b,imda005_b,'",g_user,"','",g_dept,"','",g_user,"','",l_time,"','",g_dept,"','','')",
               "   WHEN MATCHED THEN ",
               " UPDATE SET imdastus = 'Y', ",
               "            imdamodid = NULL, ",
               "            imdamoddt = NULL,",
               "            imdaownid = '",g_user,"',",
               "            imdaowndp = '",g_dept,"',",
               "            imdacrtid = '",g_user,"',",
               "            imdacrtdt = '",l_time,"',",
               "            imdacrtdp = '",g_dept,"' "
   PREPARE aimi150_ins_imda_pre FROM l_sql
   EXECUTE aimi150_ins_imda_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "imda_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   LET l_time = cl_get_current()
   LET l_sql = "  MERGE INTO imdb_t ",
               "  USING(SELECT DISTINCT imdbent imdbent_b,imdb001 imdb001_b,imdb002 imdb002_b,imdb003 imdb003_b,imdb004 imdb004_b,imdb005 imdb005_b ",
               "          FROM imdb_t ",
               "         WHERE imdb001 = '",g_ooed_m.ooed004,"'",
               "           AND imdbent = '",g_enterprise,"')",
               "     ON(imdb001 = '",l_newno04,"' AND imdb002 = imdb002_b AND imdbent = imdbent_b) ",
               "   WHEN NOT MATCHED THEN ",
               " INSERT(imdbent,imdb001,imdb002,imdbstus,imdb003,imdb004,imdb005,imdbownid,imdbowndp,imdbcrtid,imdbcrtdt,imdbcrtdp,imdbmodid,imdbmoddt)",
               " VALUES('",g_enterprise,"','",l_newno04,"',imdb002_b,'Y',imdb003_b,imdb004_b,imdb005_b,'",g_user,"','",g_dept,"','",g_user,"','",l_time,"','",g_dept,"','','')",
               "   WHEN MATCHED THEN ",
               " UPDATE SET imdbstus = 'Y', ",
               "            imdbmodid = NULL, ",
               "            imdbmoddt = NULL, ",
               "            imdbownid = '",g_user,"',",
               "            imdbowndp = '",g_dept,"',",
               "            imdbcrtid = '",g_user,"',",
               "            imdbcrtdt = '",l_time,"',",
               "            imdbcrtdp = '",g_dept,"' "
   PREPARE aimi150_ins_imdb_pre FROM l_sql
   EXECUTE aimi150_ins_imdb_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "imdb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   LET g_wc = " ooed004 = '",l_newno04,"' " 
   CALL s_transaction_end('Y','0')
   RETURN
   #end add-point
 
   #檢查PK欄位是否均有值,若全部為NULL時退出
   IF g_ooed_m.ooed001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   EXECUTE aimi150_master_referesh USING g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004, 
       g_ooed_m.ooed005 INTO g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005, 
       g_ooed_m.ooed004_desc
 
   #檢查如果有子節點(hasC=1)則顯示錯誤訊息後退出
 
   ERROR ""
 
   CALL cl_set_head_visible("","YES")
 
      LET g_ooed_m.ooed004_desc = ''
   DISPLAY BY NAME g_ooed_m.ooed004_desc
 
 
   LET g_ooed_m.ooed001 = ""
   LET g_ooed_m.ooed002 = ""
   LET g_ooed_m.ooed003 = ""
   LET g_ooed_m.ooed004 = ""
   LET g_ooed_m.ooed005 = ""
 
   
   
   CALL s_transaction_begin()
   
   #其他table資料備份(確定是否更改用)
   
 
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #直接呼叫輸入
   CALL aimi150_input("r")
 
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
 
   IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooed_m.* = g_ooed_m_t.*
         CALL aimi150_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_ooed_m.ooed005 = g_ooed_m.ooed004 THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_ooed005 = g_ooed_m.ooed005
            LET g_browser[li_addpos].b_ooed004 = g_ooed_m.ooed004
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL aimi150_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_ooed004 = g_ooed_m.ooed005 THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_ooed005 = g_ooed_m.ooed005
                     LET g_browser[li_addpos].b_ooed004 = g_ooed_m.ooed004
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_ooed001
                                                     ,g_browser[li_addpos].b_ooed002
                                                     ,g_browser[li_addpos].b_ooed003
                                                     ,g_browser[li_addpos].b_ooed004
                                                     ,g_browser[li_addpos].b_ooed005
 
                                                INTO g_browser[g_cnt].b_ooed001,g_browser[g_cnt].b_ooed002, 
                                                    g_browser[g_cnt].b_ooed003,g_browser[g_cnt].b_ooed004, 
                                                    g_browser[g_cnt].b_ooed005,g_browser[g_cnt].b_ooed004_desc 
 
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL aimi150_desc_show(li_addpos)
                     #打開父節點
                     LET g_browser[li_idx].b_hasC = TRUE
                     LET g_browser[li_idx].b_exp = TRUE
                     LET g_current_idx = li_addpos
                     EXIT FOR
                  END IF
               END FOR
            END IF
            LET g_cnt = li_cnt 
         END IF
      END IF
 
   #功能已完成,通報訊息中心
   CALL aimi150_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimi150_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_cmd_t         LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooed_m.ooed004,g_ooed_m.ooed004_desc,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003, 
       g_ooed_m.ooed005
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r' 
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF  
   
   CALL cl_set_head_visible("","YES")
 
   LET l_insert = FALSE
   LET g_action_choice = ""
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL aimi150_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   LET g_errshow = 1 
   #end add-point
   CALL aimi150_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   LET g_forupd_sql = "SELECT imdastus,imda002,'',imda004,imda005,imda003,imdamodid,'',imdamoddt,imdaownid,'',imdaowndp,'',imdacrtid,'',imdacrtdp,'',imdacrtdt FROM imda_t WHERE imdaent=? AND imda001=? AND imda002=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aimi150_bcl CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT imdbstus,imdb002,'','',imdb004,imdb005,imdb003,imdbmodid,'',imdbmoddt,imdbownid,'',imdbowndp,'',imdbcrtid,'',imdbcrtdp,'',imdbcrtdt FROM imdb_t WHERE imdbent=? AND imdb001=? AND imdb002=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aimi150_bcl2 CURSOR FROM g_forupd_sql
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   #end add-point
 
   DISPLAY BY NAME g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005 
 
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            #add-point:input段define name="input.action"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed004
            
            #add-point:AFTER FIELD ooed004 name="input.a.ooed004"
            #此段落由子樣板a05產生
            DISPLAY "" TO g_ooed_m.ooed004_desc
            IF NOT cl_null(g_ooed_m.ooed004) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #160318-00025#15 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               #160318-00025#15 by 07900 --add-end
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooed_m.ooed004
               LET g_chkparam.where = " ooef201 = 'Y' "
                #160318-00025#15 by 07900 --add-str 
               LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#15 by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooef001") THEN
                  LET g_ooed_m.ooed004 = g_ooed_m_t.ooed004
                  CALL aimi150_desc()
                  NEXT FIELD ooed004
               END IF
            END IF
            CALL aimi150_desc()



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed004
            #add-point:BEFORE FIELD ooed004 name="input.b.ooed004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooed004
            #add-point:ON CHANGE ooed004 name="input.g.ooed004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed001
            #add-point:BEFORE FIELD ooed001 name="input.b.ooed001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed001
            
            #add-point:AFTER FIELD ooed001 name="input.a.ooed001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooed_m.ooed001) AND NOT cl_null(g_ooed_m.ooed002) AND NOT cl_null(g_ooed_m.ooed003) AND NOT cl_null(g_ooed_m.ooed004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooed_m.ooed001 != g_ooed001_t  OR g_ooed_m.ooed002 != g_ooed002_t  OR g_ooed_m.ooed003 != g_ooed003_t  OR g_ooed_m.ooed004 != g_ooed004_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooed_t WHERE "||"ooedent = '" ||g_enterprise|| "' AND "||"ooed001 = '"||g_ooed_m.ooed001 ||"' AND "|| "ooed002 = '"||g_ooed_m.ooed002 ||"' AND "|| "ooed003 = '"||g_ooed_m.ooed003 ||"' AND "|| "ooed004 = '"||g_ooed_m.ooed004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooed001
            #add-point:ON CHANGE ooed001 name="input.g.ooed001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed002
            #add-point:BEFORE FIELD ooed002 name="input.b.ooed002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed002
            
            #add-point:AFTER FIELD ooed002 name="input.a.ooed002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooed_m.ooed001) AND NOT cl_null(g_ooed_m.ooed002) AND NOT cl_null(g_ooed_m.ooed003) AND NOT cl_null(g_ooed_m.ooed004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooed_m.ooed001 != g_ooed001_t  OR g_ooed_m.ooed002 != g_ooed002_t  OR g_ooed_m.ooed003 != g_ooed003_t  OR g_ooed_m.ooed004 != g_ooed004_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooed_t WHERE "||"ooedent = '" ||g_enterprise|| "' AND "||"ooed001 = '"||g_ooed_m.ooed001 ||"' AND "|| "ooed002 = '"||g_ooed_m.ooed002 ||"' AND "|| "ooed003 = '"||g_ooed_m.ooed003 ||"' AND "|| "ooed004 = '"||g_ooed_m.ooed004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooed002
            #add-point:ON CHANGE ooed002 name="input.g.ooed002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed003
            #add-point:BEFORE FIELD ooed003 name="input.b.ooed003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed003
            
            #add-point:AFTER FIELD ooed003 name="input.a.ooed003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooed_m.ooed001) AND NOT cl_null(g_ooed_m.ooed002) AND NOT cl_null(g_ooed_m.ooed003) AND NOT cl_null(g_ooed_m.ooed004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooed_m.ooed001 != g_ooed001_t  OR g_ooed_m.ooed002 != g_ooed002_t  OR g_ooed_m.ooed003 != g_ooed003_t  OR g_ooed_m.ooed004 != g_ooed004_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooed_t WHERE "||"ooedent = '" ||g_enterprise|| "' AND "||"ooed001 = '"||g_ooed_m.ooed001 ||"' AND "|| "ooed002 = '"||g_ooed_m.ooed002 ||"' AND "|| "ooed003 = '"||g_ooed_m.ooed003 ||"' AND "|| "ooed004 = '"||g_ooed_m.ooed004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooed003
            #add-point:ON CHANGE ooed003 name="input.g.ooed003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooed005
            #add-point:BEFORE FIELD ooed005 name="input.b.ooed005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooed005
            
            #add-point:AFTER FIELD ooed005 name="input.a.ooed005"
            IF g_ooed_m.ooed005 <> g_ooed_m.ooed004 THEN 
               IF NOT ap_chk_isExist(g_ooed_m.ooed005,"SELECT COUNT(*) FROM ooed_t WHERE ooedent ='"||g_enterprise||"' AND ooed004 = ? ",'tree-002',1)  THEN   #160905-00007#4 by 08172 add ent
                  NEXT FIELD ooed005
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooed005
            #add-point:ON CHANGE ooed005 name="input.g.ooed005"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooed004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed004
            #add-point:ON ACTION controlp INFIELD ooed004 name="input.c.ooed004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "

            LET g_qryparam.default1 = g_ooed_m.ooed004             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_ooed_m.ooed004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooed_m.ooed004 TO ooed004              #顯示到畫面上
            CALL aimi150_desc()
            NEXT FIELD ooed004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooed001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed001
            #add-point:ON ACTION controlp INFIELD ooed001 name="input.c.ooed001"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooed002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed002
            #add-point:ON ACTION controlp INFIELD ooed002 name="input.c.ooed002"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooed003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed003
            #add-point:ON ACTION controlp INFIELD ooed003 name="input.c.ooed003"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooed005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooed005
            #add-point:ON ACTION controlp INFIELD ooed005 name="input.c.ooed005"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #避免資料錯誤的檢查
            IF aimi150_check(g_ooed_m.ooed004,g_ooed_m.ooed005
               ,g_ooed_m.ooed001
               ) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code = "std-00020" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
 
            #CALL cl_err_collect_show()   #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_ooed_m.ooed004
 
            #實體新增/修改/複製段落的處理
            CASE
               WHEN p_cmd = "a" OR p_cmd = "r"
                  LET l_count = 1
 
                  SELECT COUNT(1) INTO l_count FROM ooed_t
                   WHERE ooedent = g_enterprise AND ooed001 = g_ooed_m.ooed001
                     AND ooed002 = g_ooed_m.ooed002
                     AND ooed003 = g_ooed_m.ooed003
                     AND ooed004 = g_ooed_m.ooed004
                     AND ooed005 = g_ooed_m.ooed005
 
                         #
                  IF l_count = 0 THEN
                     #add-point:單頭新增前 name="input.head.b_insert"
                  EXIT DIALOG
                     #end add-point
 
                     INSERT INTO ooed_t (ooedent,ooed004,ooed001,ooed002,ooed003,ooed005)
                     VALUES (g_enterprise,g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003, 
                         g_ooed_m.ooed005) 
 
                     #add-point:單頭新增中 name="input.head.m_insert"
                     
                     #end add-point
 
                     IF SQLCA.SQLCODE THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "g_ooed_m:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                  
                     #提速檔資料建置
                     IF g_ooed_m.ooed004 <> g_ooed_m.ooed005 THEN
                        #CALL n_ooeds_generate_child(g_ooed_m.ooed004,g_ooed_m.ooed005)
                     END IF
                     
                     #add-point:單頭新增後 name="input.head.a_insert"
                 
                     #end add-point
                     
                     #資料多語言用-增/改
                     
                     CALL s_transaction_end("Y","0")
                  ELSE
                     CALL s_transaction_end("N","0")
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend =  g_ooed_m.ooed004 
                     LET g_errparam.code =  "std-00006" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  END IF 
 
               #修改段落
               WHEN p_cmd = "u"  
                  #add-point:單頭修改前 name="input.head.b_update"
               EXIT DIALOG
                  #end add-point
                  UPDATE ooed_t SET (ooed004,ooed001,ooed002,ooed003,ooed005) = (g_ooed_m.ooed004,g_ooed_m.ooed001, 
                      g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005)
                   WHERE ooedent = g_enterprise AND ooed001 = g_ooed001_t #
                     AND ooed002 = g_ooed002_t
                     AND ooed003 = g_ooed003_t
                     AND ooed004 = g_ooed004_t
                     AND ooed005 = g_ooed005_t
 
                  #add-point:單頭修改中 name="input.head.m_update"
                  
                  #end add-point
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        CALL s_transaction_end('N','0')
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "ooed_t" 
                        LET g_errparam.code = "std-00009" 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        
                     WHEN SQLCA.SQLCODE #其他錯誤
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "ooed_t:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL s_transaction_end('N','0')
                        CALL cl_err()
                        
                     OTHERWISE
                        #add-point:單頭修改後 name="input.head.a_update"
                        
                        #end add-point
    
                        #資料多語言用-增/改
                        
                        LET g_log1 = util.JSON.stringify(g_ooed_m_t)
                        LET g_log2 = util.JSON.stringify(g_ooed_m)
                        IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                           CALL s_transaction_end('N','0')
                        ELSE
                           CALL s_transaction_end('Y','0')
                        END IF
                  END CASE
 
               OTHERWISE 
            END CASE
 
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:before dialog name="input.before_dialog"
         
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
        
      #在dialog button (放棄)
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
   
   #add-point:input段after input  name="input.after_input"
   IF NOT INT_FLAG THEN 
      CALL aimi150_b()
   END IF
   #end add-point
    
END FUNCTION
 
{</section>}
 
{<section id="aimi150.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aimi150_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ac_t    LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
       
   
   #帶出公用欄位reference值
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimi150_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:reference段之後 name="show.head.reference"
   CALL aimi150_desc()
   
   LET l_ac_t = l_ac
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooed_m.ooed004,g_ooed_m.ooed004_desc,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003, 
       g_ooed_m.ooed005
 
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()   
 
   #add-point:show段之後 name="show.after"
   IF g_bfill = "Y" THEN
      CALL aimi150_b_fill()
   END IF
   FOR l_ac = 1 TO g_imda_d.getLength()
       CALL aimi150_imda_desc()
   END FOR
   FOR l_ac = 1 TO g_imda2_d.getLength()
       CALL aimi150_imdb_desc()
   END FOR
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimi150.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aimi150_delete(l_dialog)
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_dialog        ui.DIALOG
   DEFINE li_status       LIKE type_t.num5  #SQL實體資料刪除狀態
   DEFINE li_cnt          LIKE type_t.num10 #查看本階是否有兄弟資料
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_ooed_m.ooed001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:delete段before_delete name="delete.before_delete"
   
   #end add-point
 
   EXECUTE aimi150_master_referesh USING g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004, 
       g_ooed_m.ooed005 INTO g_ooed_m.ooed004,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed005, 
       g_ooed_m.ooed004_desc
    
   #檢查是否允許此動作
   IF NOT aimi150_action_chk() THEN
      RETURN
   END IF
    
   CALL aimi150_show()
   
   #Transaction開始
   CALL s_transaction_begin()
   
   
 
   OPEN aimi150_cl USING g_enterprise,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004,g_ooed_m.ooed005
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE aimi150_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi150_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH aimi150_cl INTO g_ooed_m.ooed004,g_ooed_m.ooed004_desc,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003, 
       g_ooed_m.ooed005
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_ooed_m.ooed004,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   #add-point:delete段before_delete name="delete.before_delete_ask"
   
   #end add-point
 
   #(ver:35) ---modify start---
   #(ver:35) 為避免刪除全部子節點可能會對其他節點造成影響，現改為只刪除當下節點
   #先判斷是否有子節點(hasC) 詢問是否砍除全部
#  IF g_browser[g_current_idx].b_hasC THEN
#     IF cl_ask_delete_all_node() THEN
#        LET li_status = aimi150_sql_delete(TRUE)
#     ELSE
#        LET li_status = FALSE
#     END IF
#  ELSE
      #如果沒有子節點,詢問是否刪除本筆資料
      IF cl_ask_delete() THEN
         LET li_status = aimi150_sql_delete(FALSE)
      ELSE
         LET li_status = FALSE
      END IF
#  END IF
   #(ver:35) --- modify end ---
 
   #檢查實體砍除是否發生意外中止
   IF NOT li_status THEN
      CALL s_transaction_end("N","0")
      CLOSE aimi150_cl
      RETURN
   END IF
 
   #刪除節點與資料內容
   CALL l_dialog.deleteNode("s_browse",g_current_idx)  #deleteNode會順便幫忙做deleteElement
 
   #確認這一階還有沒有兄弟 (有:不異動上階屬性/否:上階hasC及exp設定成0)
   #SELECT COUNT(1) INTO li_cnt
   #  FROM ooed_t
   # WHERE ooed005 = g_ooed_m.ooed005
   #IF g_current_idx > 1 THEN
   #   IF li_cnt = 0  THEN
   #      LET g_browser[g_current_idx - 1].b_hasC = 0
   #      LET g_browser[g_current_idx - 1].b_exp = 0
   #   END IF
   #END IF
 
   #add-point:單頭刪除後 name="delete.head.a_delete"
      CALL aimi150_ui_detailshow()
   #end add-point
   
   IF g_current_idx > 1 THEN
      LET g_current_idx = g_current_idx - 1
   END IF
   
   IF g_browser.getLength() > 0 THEN
      CALL aimi150_fetch("")
   END IF
 
   LET g_log1 = util.JSON.stringify(g_ooed_m)   #(ver:36)
   IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:36)
      CLOSE aimi150_cl
      CALL s_transaction_end('N','0')
   ELSE
      CLOSE aimi150_cl
      CALL s_transaction_end('Y','0')
   END IF
 
   #功能已完成,通報訊息中心
   CALL aimi150_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aimi150.sql_delete" >}
#+ 實體刪除FUNCTION 
PRIVATE FUNCTION aimi150_sql_delete(li_node)
   #add-point:sql_delete段define name="sql_delet.define_customerization"
   
   #end add-point
   DEFINE li_node         LIKE type_t.num5  #TRUE:砍除Node Tree/FALSE:砍除Single Node
   DEFINE li_return       LIKE type_t.num5
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE ls_sql          STRING
   DEFINE li_cnt          LIKE type_t.num10   #(ver:35) add
   #add-point:sql_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sql_delet.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="sql_delet.pre_function"
   
   #end add-point
   
   LET li_return = TRUE
 
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimi150_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
   #add-point:單頭刪除前 name="delete.head.b_delete"
      DELETE FROM imda_t
       WHERE imdaent = g_enterprise
         AND imda001 = g_ooed_m.ooed004 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imda_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      DELETE FROM imdb_t
       WHERE imdbent = g_enterprise
         AND imdb001 = g_ooed_m.ooed004 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imdb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      CALL g_imda_d.clear()
      RETURN
   #end add-point
   
   IF li_node = TRUE THEN
      #砍除該節點以下所有節點
      LET ls_sql = " SELECT ooed004,ooed005 FROM ",
                   " (SELECT ooed004,ooed005 FROM ooed_t WHERE ooedent = " ||g_enterprise|| " AND ooed004<>ooed005)", 
 
                   " START WITH ooed005='",g_ooed_m.ooed005,"'",
                   " CONNECT BY PRIOR ooed004 = ooed005"
 
   ELSE 
   
   END IF
 
   #刪除當下節點
   DELETE FROM ooed_t
    WHERE ooedent = g_enterprise AND ooed001 = g_ooed_m.ooed001
      AND ooed002 = g_ooed_m.ooed002
      AND ooed003 = g_ooed_m.ooed003
      AND ooed004 = g_ooed_m.ooed004
      AND ooed005 = g_ooed_m.ooed005
 
 
   #add-point:單頭刪除中 name="delete.head.m_delete"
   
   #end add-point
 
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ooed_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
   END IF
 
   #(ver:35) ---modify start---
   # 若此節點還有存在在其他節點下，則多語言資料不可刪除
   LET li_cnt = 0
   LET ls_sql = " SELECT COUNT(1) FROM ooed_t",
                 " WHERE ooedent = " ||g_enterprise|| " AND ooed004 = '",g_ooed_m.ooed004,"'"
 
   PREPARE master_chk_node_exist FROM ls_sql
   EXECUTE master_chk_node_exist INTO li_cnt
   IF li_cnt <= 0 THEN
      
   END IF
   #(ver:35) --- modify end ---
 
   RETURN li_return
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimi150_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1 
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("ooed001,ooed002,ooed003,ooed004,ooed005",TRUE)
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
 
{<section id="aimi150.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimi150_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("ooed001,ooed002,ooed003,ooed004,ooed005",FALSE)
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
 
{<section id="aimi150.default_search" >}
#+ 外部參數預設搜尋
PRIVATE FUNCTION aimi150_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="default_search.before"
   
   #end add-point  
   
   IF g_searchtype = 0 OR cl_null(g_searchtype) THEN
      LET g_searchtype = 3
   END IF 
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " ooed001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " ooed002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " ooed003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " ooed004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " ooed005 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #CALL aimi150_browser_fill(g_wc,g_searchtype)
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimi150.state_change" >}
   
 
{</section>}
 
{<section id="aimi150.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimi150_set_pk_array()
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
   LET g_pk_array[1].values = g_ooed_m.ooed001
   LET g_pk_array[1].column = 'ooed001'
   LET g_pk_array[2].values = g_ooed_m.ooed002
   LET g_pk_array[2].column = 'ooed002'
   LET g_pk_array[3].values = g_ooed_m.ooed003
   LET g_pk_array[3].column = 'ooed003'
   LET g_pk_array[4].values = g_ooed_m.ooed004
   LET g_pk_array[4].column = 'ooed004'
   LET g_pk_array[5].values = g_ooed_m.ooed005
   LET g_pk_array[5].column = 'ooed005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi150.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimi150_msgcentre_notify(lc_state)
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
   CALL aimi150_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_ooed_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi150.action_chk" >}
PRIVATE FUNCTION aimi150_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi150.other_function" readonly="Y" >}
#+樹建立
PRIVATE FUNCTION aimi150_tree_create()
DEFINE l_pid      LIKE type_t.chr50   #用於樹的第一層
DEFINE l_sql      STRING 
DEFINE l_ac       LIKE type_t.num5
DEFINE l_n2       LIKE type_t.num5
DEFINE l_wc_def   STRING 
DEFINE l_a        LIKE type_t.chr1

   #傳入的條件
   IF cl_null(g_wc_def) THEN
      LET g_wc_def = " 1=1"
   END IF
   #建立樹上面的內容
   CALL g_browser.clear()
   CLEAR FORM
   LET l_wc_def = cl_replace_str(g_wc_def,'ooed004','ooef001')
   #第一層的資料
#   LET l_sql = " SELECT UNIQUE ooed002,ooed003 FROM ooed_t ",
#               "  WHERE ooedent = '",g_enterprise,"'",
#               "    AND ooed001 = '8'",   #14/11/04 mod 2->8
#               "    AND ooed006 <= '",g_today,"' ",
#               "    AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ",
#               "    AND ",g_wc_def," ",
#               "  ORDER BY ooed002 "
#   PREPARE master_type_0 FROM l_sql
#   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #160922-00037#1---s
   IF g_wc2 <> " 1=1" THEN
      LET l_sql = " SELECT UNIQUE '1' as a,ooed002,ooed003 FROM ooed_t ",
                  "    LEFT JOIN imda_t ON imdaent = ooedent AND imda001 = ooed002 ",
                  "    LEFT JOIN imdb_t ON imdbent = ooedent AND imdb001 = ooed002 ",
                  "  WHERE ooedent = '",g_enterprise,"'",
                  "    AND ooed001 = '8' ",   #14/11/04 mod 2->8
                  "    AND ooed006 <= '",g_today,"' ",
                  "    AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ",
                  "    AND ",g_wc_def, " AND ", g_wc2,
                  " ORDER BY 1,2"
   ELSE
   #160922-00037#1---e
      LET l_sql = " SELECT UNIQUE '1' as a,ooed002,ooed003 FROM ooed_t ",
                  "  WHERE ooedent = '",g_enterprise,"'",
                  "    AND ooed001 = '8' ",   #14/11/04 mod 2->8
                  "    AND ooed006 <= '",g_today,"' ",
                  "    AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ",
                  "    AND ",g_wc_def," ",
                  #"  UNION ",
                  #" SELECT UNIQUE '2' as a,ooef001,'' FROM ooef_t ",
                  #"  WHERE ooefent = '",g_enterprise,"'",
                  #"    AND ooef201 = 'Y' AND ",l_wc_def," ",
                  " ORDER BY 1,2"
   END IF  #160922-00037#1

   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   #160922-00037#1---s
   IF g_wc2 <> " 1=1" THEN
      LET l_sql = " SELECT UNIQUE ooed004,ooed003 FROM ooed_t ",
                  "    LEFT JOIN imda_t ON imdaent = ooedent AND imda001 = ooed004 ",
                  "    LEFT JOIN imdb_t ON imdbent = ooedent AND imdb001 = ooed004 ",
                  "  WHERE ooedent = '",g_enterprise,"'",
                  "    AND ooed001 = '8' ",   #14/11/04 mod 2->8
                  "    AND ooed006 <= '",g_today,"' ",
                  "    AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ",
                  "    AND ooed002 = ? ", 
                  "    AND ooed003 = ? ",
                  "    AND ooed002 = ooed005 ",
                  "    AND ooed004 <> ooed005 ",
                  "    AND ",g_wc_def," AND ", g_wc2,
                  "  ORDER BY ooed004 "
   ELSE
   #160922-00037#1---e
      LET l_sql = " SELECT UNIQUE ooed004,ooed003 FROM ooed_t ",
                  "  WHERE ooedent = '",g_enterprise,"'",
                  "    AND ooed001 = '8' ",   #14/11/04 mod 2->8
                  "    AND ooed006 <= '",g_today,"' ",
                  "    AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ",
                  "    AND ooed002 = ? ", 
                  "    AND ooed003 = ? ",
                  "    AND ooed002 = ooed005 ",
                  "    AND ooed004 <> ooed005 ",
                  "    AND ",g_wc_def," ",   #lixiang  unmark
                  "  ORDER BY ooed004 "
   END IF  #160922-00037#1                
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1
   
   INITIALIZE g_browser_root TO NULL
   #初始化l_ac
   LET l_ac = 1
   FOREACH master_typecur_0 INTO l_a,g_browser[l_ac].b_ooed002,g_browser[l_ac].b_ooed003
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處(LV-1)
      LET g_browser[l_ac].b_ooed002 = g_browser[l_ac].b_ooed002
      LET g_browser[l_ac].b_pid = '0' CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      IF l_a = '1' THEN
         LET g_browser[l_ac].b_hasC = TRUE
      ELSE
         LET g_browser[l_ac].b_hasC = FALSE
      END IF
      LET g_browser[l_ac].b_isExp = TRUE
      #第一層節點編號
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET l_ac = l_ac + 1 
      LET g_cnt = l_ac
      IF NOT cl_null(g_browser[l_ac-1].b_ooed003) THEN
         FOREACH master_typecur_1 USING g_browser[l_ac-1].b_ooed002,g_browser[l_ac-1].b_ooed003 INTO g_browser[g_cnt].b_ooed004,g_browser[g_cnt].b_ooed003  
            LET g_browser[g_cnt].b_ooed002 = g_browser[l_ac-1].b_ooed002
            LET g_browser[g_cnt].b_ooed004 = g_browser[g_cnt].b_ooed004
            LET g_browser[g_cnt].b_ooed005 = g_browser[l_ac-1].b_ooed004
            LET g_browser[g_cnt].b_pid = l_pid
            LET g_browser[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
            LET g_browser[g_cnt].b_exp = TRUE
            LET g_browser[g_cnt].b_hasC = aimi150_chk_hasC(g_cnt)
            IF g_browser[g_cnt].b_hasC = 1 THEN
               CALL aimi150_browser_expand1(g_cnt)
               LET g_cnt = g_browser.getLength()
            END IF
            LET g_cnt = g_cnt +1
         END FOREACH 
         LET l_ac = g_browser.getLength()
      END IF
      
   END FOREACH 
   CALL g_browser.deleteElement(l_ac)
   FOR l_ac = 1 TO g_browser.getLength()
       CALL aimi150_desc_show(l_ac)
   END FOR
   IF g_browser.getLength() > 0 THEN
      LET g_browser_cnt = g_browser.getLength()
   ELSE
      LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
   END IF
   FREE master_type_0
   FREE master_type_1
   FOR l_n2 = 1 TO g_browser.getLength()
       IF g_browser[l_n2].b_isExp is null THEN
         CALL aimi150_browser_expand1(l_n2)
      END IF
   END FOR
END FUNCTION
#+ 單身筆數變更
PRIVATE FUNCTION aimi150_idx_chk()
    IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imda_d.getLength() THEN
         LET g_detail_idx = g_imda_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imda_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imda_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_imda2_d.getLength() THEN
         LET g_detail_idx = g_imda2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imda2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imda2_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION
#+營運據點名稱顯示
PRIVATE FUNCTION aimi150_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooed_m.ooed004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooed_m.ooed004_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ooed_m.ooed004_desc

END FUNCTION
#+ 單身資料重新顯示
PRIVATE FUNCTION aimi150_ui_detailshow()
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
END FUNCTION
#imdb單身參考欄位顯示
PRIVATE FUNCTION aimi150_imdb_desc()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda2_d[l_ac].imdbownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imda2_d[l_ac].imdbownid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda2_d[l_ac].imdbownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda2_d[l_ac].imdbowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imda2_d[l_ac].imdbowndp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda2_d[l_ac].imdbowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda2_d[l_ac].imdbcrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imda2_d[l_ac].imdbcrtid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda2_d[l_ac].imdbcrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda2_d[l_ac].imdbcrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imda2_d[l_ac].imdbcrtdp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda2_d[l_ac].imdbcrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda2_d[l_ac].imdbmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imda2_d[l_ac].imdbmodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda2_d[l_ac].imdbmodid_desc
            
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda2_d[l_ac].imdb002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imda2_d[l_ac].imdb002_desc = g_rtn_fields[1]
   LET g_imda2_d[l_ac].imdb002_desc1 = g_rtn_fields[2]
   DISPLAY BY NAME g_imda2_d[l_ac].imdb002_desc
   DISPLAY BY NAME g_imda2_d[l_ac].imdb002_desc1
END FUNCTION
#imda單身參考欄位顯示
PRIVATE FUNCTION aimi150_imda_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda_d[l_ac].imdaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imda_d[l_ac].imdaownid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda_d[l_ac].imdaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda_d[l_ac].imdaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imda_d[l_ac].imdaowndp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda_d[l_ac].imdaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda_d[l_ac].imdacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imda_d[l_ac].imdacrtid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda_d[l_ac].imdacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda_d[l_ac].imdacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imda_d[l_ac].imdacrtdp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda_d[l_ac].imdacrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda_d[l_ac].imdamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imda_d[l_ac].imdamodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda_d[l_ac].imdamodid_desc
            
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imda_d[l_ac].imda002
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imda_d[l_ac].imda002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imda_d[l_ac].imda002_desc
END FUNCTION
#+ 單身陣列填充
PRIVATE FUNCTION aimi150_b_fill()
   CALL g_imda_d.clear()    #g_imda_d 單頭及單身 
   CALL g_imda2_d.clear()



   LET g_sql = "SELECT UNIQUE imdastus,imda002,'',imda004,imda005,imda003,imdamodid,'',imdamoddt,imdaownid,'',imdaowndp,'',imdacrtid,'',imdacrtdp,'',imdacrtdt FROM imda_t",  
               " WHERE imdaent=? AND imda001=?"
 
   IF NOT cl_null(g_wc_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table1 CLIPPED
   END IF
   LET g_sql = g_sql, " ORDER BY imda_t.imda002"
 
   PREPARE aimi150_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR aimi150_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_cs USING g_enterprise,g_ooed_m.ooed004

                                            
   FOREACH b_fill_cs INTO g_imda_d[l_ac].imdastus,g_imda_d[l_ac].imda002,g_imda_d[l_ac].imda002_desc,g_imda_d[l_ac].imda004,g_imda_d[l_ac].imda005,g_imda_d[l_ac].imda003,g_imda_d[l_ac].imdamodid,g_imda_d[l_ac].imdamodid_desc,g_imda_d[l_ac].imdamoddt,g_imda_d[l_ac].imdaownid,g_imda_d[l_ac].imdaownid_desc,g_imda_d[l_ac].imdaowndp,g_imda_d[l_ac].imdaowndp_desc,g_imda_d[l_ac].imdacrtid,g_imda_d[l_ac].imdacrtid_desc,g_imda_d[l_ac].imdacrtdp,g_imda_d[l_ac].imdacrtdp_desc,g_imda_d[l_ac].imdacrtdt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aimi150_imda_desc()
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET g_sql = "SELECT UNIQUE imdbstus,imdb002,'','',imdb004,imdb005,imdb003,imdbmodid,'',imdbmoddt,imdbownid,'',imdbowndp,'',imdbcrtid,'',imdbcrtdp,'',imdbcrtdt FROM imdb_t",    
               " WHERE imdbent=? AND imdb001=?"   
 
   IF NOT cl_null(g_wc_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_table2 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY imdb_t.imdb002"

   PREPARE aimi150_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR aimi150_pb2
 
   LET l_ac = 1

   OPEN b_fill_cs2 USING g_enterprise,g_ooed_m.ooed004

                                            
   FOREACH b_fill_cs2 INTO g_imda2_d[l_ac].imdbstus,g_imda2_d[l_ac].imdb002,g_imda2_d[l_ac].imdb002_desc,g_imda2_d[l_ac].imdb002_desc1,g_imda2_d[l_ac].imdb004,g_imda2_d[l_ac].imdb005,g_imda2_d[l_ac].imdb003,g_imda2_d[l_ac].imdbmodid,g_imda2_d[l_ac].imdbmodid_desc,g_imda2_d[l_ac].imdbmoddt,g_imda2_d[l_ac].imdbownid,g_imda2_d[l_ac].imdbownid_desc,g_imda2_d[l_ac].imdbowndp,g_imda2_d[l_ac].imdbowndp_desc,g_imda2_d[l_ac].imdbcrtid,g_imda2_d[l_ac].imdbcrtid_desc,g_imda2_d[l_ac].imdbcrtdp,g_imda2_d[l_ac].imdbcrtdp_desc,g_imda2_d[l_ac].imdbcrtdt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aimi150_imdb_desc()
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_imda_d.deleteElement(g_imda_d.getLength())
   CALL g_imda2_d.deleteElement(g_imda2_d.getLength())
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   CLOSE b_fill_cs
   CLOSE b_fill_cs2


   
   FREE aimi150_pb
   FREE aimi150_pb2
END FUNCTION
#單身錄入操作
PRIVATE FUNCTION aimi150_b()
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
DEFINE  l_imda002       STRING
DEFINE  l_imdb002       STRING
DEFINE  l_hasx          LIKE type_t.num5
DEFINE  l_hasxlen       LIKE type_t.num5                #170118-00023#1 add
   
   IF g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   LET g_errshow = 1 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_imda_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imda_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 

            CALL aimi150_b_fill()
            LET g_rec_b = g_imda_d.getLength()
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aimi150_cl USING g_enterprise,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004,g_ooed_m.ooed005

            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aimi150_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aimi150_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
                               
            LET g_rec_b = g_imda_d.getLength()
            
            IF g_rec_b >= l_ac AND NOT cl_null(g_imda_d[l_ac].imda002) THEN
               LET l_cmd='u'
               LET g_imda_d_t.* = g_imda_d[l_ac].*  #BACKUP
               CALL aimi150_set_entry_b(l_cmd)
               CALL aimi150_set_no_entry_b(l_cmd)
               IF NOT aimi150_lock_b("imda_t",'1') THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi150_bcl INTO g_imda_d[l_ac].imdastus,g_imda_d[l_ac].imda002,g_imda_d[l_ac].imda002_desc,g_imda_d[l_ac].imda004,g_imda_d[l_ac].imda005,g_imda_d[l_ac].imda003,g_imda_d[l_ac].imdamodid,g_imda_d[l_ac].imdamodid_desc,g_imda_d[l_ac].imdamoddt,g_imda_d[l_ac].imdaownid,g_imda_d[l_ac].imdaownid_desc,g_imda_d[l_ac].imdaowndp,g_imda_d[l_ac].imdaowndp_desc,g_imda_d[l_ac].imdacrtid,g_imda_d[l_ac].imdacrtid_desc,g_imda_d[l_ac].imdacrtdp,g_imda_d[l_ac].imdacrtdp_desc,g_imda_d[l_ac].imdacrtdt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_imda_d_t.imda002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL aimi150_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imda_d[l_ac].* TO NULL 
            INITIALIZE g_imda_d_t.* TO NULL
            LET g_imda_d[l_ac].imda003 = "1"
            CALL cl_show_fld_cont()
            CALL aimi150_set_entry_b(l_cmd)
            CALL aimi150_set_no_entry_b(l_cmd)
            LET g_imda_d[l_ac].imdastus = "Y"
            LET g_imda_d[l_ac].imda005 = "N"
            LET g_imda_d[l_ac].imdaownid = g_user
            LET g_imda_d[l_ac].imdaowndp = g_dept
            LET g_imda_d[l_ac].imdacrtid = g_user
            LET g_imda_d[l_ac].imdacrtdp = g_dept
            LET g_imda_d[l_ac].imdacrtdt = cl_get_current()
            CALL aimi150_imda_desc()
  
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
            SELECT COUNT(*) INTO l_count FROM imda_t 
             WHERE imdaent = g_enterprise
               AND imda001 = g_ooed_m.ooed004
               AND g_imda_d[l_ac].imda002 = imda002

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooed_m.ooed004
               LET gs_keys[2] = g_imda_d[l_ac].imda002
               CALL aimi150_insert_b('imda_t',gs_keys,"'1'")
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_imda_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "imda_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_imda_d[l_ac].imda002) THEN 
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
              
               DELETE FROM imda_t
                WHERE imdaent = g_enterprise
                  AND imda001 = g_ooed_m.ooed004 
                  AND imda002 = g_imda_d_t.imda002

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "imda_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aimi150_bcl
               LET l_count = g_imda_d.getLength()
            END IF 
            INITIALIZE gs_keys TO NULL 
            LET gs_keys[1] = g_ooed_m.ooed004
            LET gs_keys[2] = g_imda_d[l_ac].imda002

              
         AFTER DELETE 
            CALL aimi150_delete_b('imda_t',gs_keys,"'1'")
            
         BEFORE FIELD imdastus

         AFTER FIELD imdastus
            
         
         ON CHANGE imdastus

         BEFORE FIELD imda002

         AFTER FIELD imda002
            DISPLAY "" TO s_detail1[l_ac].imda002_desc
            
            IF NOT cl_null(g_ooed_m.ooed004) AND NOT cl_null(g_imda_d[l_ac].imda002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooed_m.ooed004 != g_ooed004_t OR g_imda_d[l_ac].imda002 != g_imda_d_t.imda002))) THEN 
                  IF NOT ap_chk_notDup(g_imda_d[l_ac].imda002,"SELECT COUNT(*) FROM imda_t WHERE "||"imdaent = '" ||g_enterprise|| "' AND "||"imda001 = '"||g_ooed_m.ooed004 ||"' AND "|| "imda002 = '"||g_imda_d[l_ac].imda002 ||"'",'std-00004',0) THEN 
                     LET g_imda_d[l_ac].imda002 = g_imda_d_t.imda002
                     CALL aimi150_imda_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET l_imda002 = g_imda_d[l_ac].imda002
               LET l_hasx = l_imda002.getIndexOf('*',1)
               LET l_hasxlen = LENGTH(l_hasxlen)                            #170118-00023#1 add
               #IF g_imda_d[l_ac].imda002 <> 'ALL' AND l_hasx = 0 THEN      #170118-00023#1 mark
               IF g_imda_d[l_ac].imda002 <> 'ALL' AND (l_hasx = 0 OR (l_hasx = 1 AND l_hasxlen = 1)) THEN    #170118-00023#1 add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                   #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imda_d[l_ac].imda002
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
                  #160318-00025#15 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_rtax001") THEN
                     LET g_imda_d[l_ac].imda002 = g_imda_d_t.imda002
                     CALL aimi150_imda_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aimi150_imda_desc()
            
         ON CHANGE imda002


         BEFORE FIELD imda004

         AFTER FIELD imda004
            IF g_imda_d[l_ac].imda004 = '2' OR g_imda_d[l_ac].imda004 = '3'  THEN 
               LET g_imda_d[l_ac].imda005 = 'Y' 
            END IF
            
         ON CHANGE imda004
            IF g_imda_d[l_ac].imda004 = '2' OR g_imda_d[l_ac].imda004 = '3'  THEN 
               LET g_imda_d[l_ac].imda005 = 'Y' 
            END IF
            
         BEFORE FIELD imda005

         AFTER FIELD imda005
            
         ON CHANGE imda005
         
         BEFORE FIELD imda003

         AFTER FIELD imda003
            
         ON CHANGE imda003
         
         ON ACTION controlp INFIELD imdastus
            
         ON ACTION controlp INFIELD imda002
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imda_d[l_ac].imda002 
            CALL q_rtax001_1()
            LET g_imda_d[l_ac].imda002 = g_qryparam.return1
            CALL aimi150_imda_desc()
            DISPLAY g_imda_d[l_ac].imda002 TO imda002
            
         ON ACTION controlp INFIELD imda003

 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_imda_d[l_ac].* = g_imda_d_t.*
               CLOSE aimi150_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_imda_d[l_ac].imda002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_imda_d[l_ac].* = g_imda_d_t.*
            ELSE
               LET g_imda_d[l_ac].imdamodid = g_user
               LET g_imda_d[l_ac].imdamoddt = cl_get_current()
               CALL aimi150_imda_desc()
               UPDATE imda_t SET (imda001,imdastus,imda002,imda004,imda005,imda003,imdaownid,imdaowndp,imdacrtid,imdacrtdt,imdacrtdp,imdamodid,imdamoddt) = (g_ooed_m.ooed004,g_imda_d[l_ac].imdastus,g_imda_d[l_ac].imda002,g_imda_d[l_ac].imda004,g_imda_d[l_ac].imda005,g_imda_d[l_ac].imda003,g_imda_d[l_ac].imdaownid,g_imda_d[l_ac].imdaowndp,g_imda_d[l_ac].imdacrtid,g_imda_d[l_ac].imdacrtdt,g_imda_d[l_ac].imdacrtdp,g_imda_d[l_ac].imdamodid,g_imda_d[l_ac].imdamoddt)
                WHERE imdaent = g_enterprise 
                  AND imda001 = g_ooed_m.ooed004 
                  AND imda002 = g_imda_d_t.imda002

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "imda_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_imda_d[l_ac].* = g_imda_d_t.*
               ELSE
                  INITIALIZE gs_keys TO NULL 
                  LET gs_keys[1] = g_ooed_m.ooed004
                  LET gs_keys_bak[1] = g_ooed004_t 
                  LET gs_keys[2] = g_imda_d[l_ac].imda002
                  LET gs_keys_bak[2] = g_imda_d_t.imda002
                  CALL aimi150_update_b('imda_t',gs_keys,gs_keys_bak,"'1'")
               END IF
            END IF
            
         AFTER ROW
            CALL aimi150_unlock_b("imda_t",'1')
            CALL s_transaction_end('Y','0')
            
         AFTER INPUT
          
      END INPUT
      
      INPUT ARRAY g_imda2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         BEFORE INPUT
           IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imda2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 

            CALL aimi150_b_fill()
            LET g_rec_b = g_imda2_d.getLength()
            CALL FGL_SET_ARR_CURR(g_detail_idx)
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imda2_d[l_ac].* TO NULL 
            INITIALIZE g_imda2_d_t.* TO NULL 
            LET g_imda2_d[l_ac].imdb003 = "1"
            CALL cl_show_fld_cont()
            CALL aimi150_set_entry_b(l_cmd)
            CALL aimi150_set_no_entry_b(l_cmd)
            LET g_imda2_d[l_ac].imdbstus = "Y"
            LET g_imda2_d[l_ac].imdb005 = "N"
            LET g_imda2_d[l_ac].imdbownid = g_user
            LET g_imda2_d[l_ac].imdbowndp = g_dept
            LET g_imda2_d[l_ac].imdbcrtid = g_user
            LET g_imda2_d[l_ac].imdbcrtdp = g_dept
            LET g_imda2_d[l_ac].imdbcrtdt = cl_get_current()
            CALL aimi150_imdb_desc()
            
         BEFORE ROW 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aimi150_cl USING g_enterprise,g_ooed_m.ooed001,g_ooed_m.ooed002,g_ooed_m.ooed003,g_ooed_m.ooed004,g_ooed_m.ooed005
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aimi150_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aimi150_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            LET g_rec_b = g_imda2_d.getLength()
            
            IF g_rec_b >= l_ac AND NOT cl_null(g_imda2_d[l_ac].imdb002) THEN 
               LET l_cmd='u'
               LET g_imda2_d_t.* = g_imda2_d[l_ac].*  #BACKUP
               CALL aimi150_set_entry_b(l_cmd)
               CALL aimi150_set_no_entry_b(l_cmd)
               IF NOT aimi150_lock_b("imdb_t",'2') THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimi150_bcl2 INTO g_imda2_d[l_ac].imdbstus,g_imda2_d[l_ac].imdb002,g_imda2_d[l_ac].imdb002_desc,g_imda2_d[l_ac].imdb002_desc1,g_imda2_d[l_ac].imdb004,g_imda2_d[l_ac].imdb005,g_imda2_d[l_ac].imdb003,g_imda2_d[l_ac].imdbmodid,g_imda2_d[l_ac].imdbmodid_desc,g_imda2_d[l_ac].imdbmoddt,g_imda2_d[l_ac].imdbownid,g_imda2_d[l_ac].imdbownid_desc,g_imda2_d[l_ac].imdbowndp,g_imda2_d[l_ac].imdbowndp_desc,g_imda2_d[l_ac].imdbcrtid,g_imda2_d[l_ac].imdbcrtid_desc,g_imda2_d[l_ac].imdbcrtdp,g_imda2_d[l_ac].imdbcrtdp_desc,g_imda2_d[l_ac].imdbcrtdt
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL aimi150_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_imda2_d[l_ac].imdb002) 
            THEN
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
         
               DELETE FROM imdb_t
                WHERE imdbent = g_enterprise 
                  AND imdb001 = g_ooed_m.ooed004
                  AND imdb002 = g_imda2_d_t.imdb002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "imda_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aimi150_bcl
               LET l_count = g_imda_d.getLength()
            END IF 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooed_m.ooed004
               LET gs_keys[2] = g_imda2_d[l_ac].imdb002

            
         AFTER DELETE 
               CALL aimi150_delete_b('imdb_t',gs_keys,"'2'")
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
            SELECT COUNT(*) INTO l_count 
              FROM imdb_t 
             WHERE imdbent = g_enterprise 
               AND imdb001 = g_ooed_m.ooed004
               AND g_imda2_d[l_ac].imdb002 = imdb002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooed_m.ooed004
               LET gs_keys[2] = g_imda2_d[l_ac].imdb002
               CALL aimi150_insert_b('imdb_t',gs_keys,"'2'")
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_imda_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "imdb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_imda2_d[l_ac].* = g_imda2_d_t.*
               CLOSE aimi150_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_imda2_d[l_ac].* = g_imda2_d_t.*
            ELSE
               LET g_imda2_d[l_ac].imdbmodid = g_user
               LET g_imda2_d[l_ac].imdbmoddt = cl_get_current()
               CALL aimi150_imdb_desc()
               UPDATE imdb_t SET (imdb001,imdbstus,imdb002,imdb004,imdb005,imdb003,imdbownid,imdbowndp,imdbcrtid,imdbcrtdt,imdbcrtdp,imdbmodid,imdbmoddt) = (g_ooed_m.ooed004,g_imda2_d[l_ac].imdbstus,g_imda2_d[l_ac].imdb002,g_imda2_d[l_ac].imdb004,g_imda2_d[l_ac].imdb005,g_imda2_d[l_ac].imdb003,g_imda2_d[l_ac].imdbownid,g_imda2_d[l_ac].imdbowndp,g_imda2_d[l_ac].imdbcrtid,g_imda2_d[l_ac].imdbcrtdt,g_imda2_d[l_ac].imdbcrtdp,g_imda2_d[l_ac].imdbmodid,g_imda2_d[l_ac].imdbmoddt) #自訂欄位頁簽
                WHERE imdbent = g_enterprise 
                  AND imdb001 = g_ooed_m.ooed004
                  AND imdb002 = g_imda2_d_t.imdb002 

                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_imda2_d[l_ac].* = g_imda2_d_t.*
               ELSE
                 INITIALIZE gs_keys TO NULL 
                 LET gs_keys[1] = g_ooed_m.ooed004
                 LET gs_keys_bak[1] = g_ooed004_t 
                 LET gs_keys[2] = g_imda2_d[l_ac].imdb002
                 LET gs_keys_bak[2] = g_imda2_d_t.imdb002
                 CALL aimi150_update_b('imdb_t',gs_keys,gs_keys_bak,"'2'")
               END IF

            END IF

         BEFORE FIELD imdbstus

         AFTER FIELD imdbstus
        

         ON CHANGE imdbstus

         AFTER FIELD imdb002
            DISPLAY "" TO s_detail2[l_ac].imdb002_desc
            DISPLAY "" TO s_detail2[l_ac].imdb002_desc1
            IF NOT cl_null(g_ooed_m.ooed004) AND NOT cl_null(g_imda2_d[l_ac].imdb002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooed_m.ooed004 != g_ooed004_t OR g_imda2_d[l_ac].imdb002 != g_imda2_d_t.imdb002))) THEN 
                  IF NOT ap_chk_notDup(g_imda2_d[l_ac].imdb002,"SELECT COUNT(*) FROM imdb_t WHERE "||"imdbent = '" ||g_enterprise|| "' AND "||"imdb001 = '"||g_ooed_m.ooed004 ||"' AND "|| "imdb002 = '"||g_imda2_d[l_ac].imdb002 ||"'",'std-00004',0) THEN
                     LET g_imda2_d[l_ac].imdb002 = g_imda2_d_t.imdb002   
                     CALL aimi150_imdb_desc()                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET l_imdb002 = g_imda2_d[l_ac].imdb002
            LET l_hasx = l_imdb002.getIndexOf('*',1)            
            IF NOT cl_null(g_imda2_d[l_ac].imdb002) AND l_hasx = 0 THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #160318-00025#15 by 07900 --add-str 
                LET g_errshow = TRUE #是否開窗
               #160318-00025#15 by 07900 --add-end
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imda2_d[l_ac].imdb002
               #160318-00025#15 by 07900 --add-str 
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#15 by 07900 --add-end 
               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaa001_5") THEN
                  LET g_imda2_d[l_ac].imdb002 = g_imda2_d_t.imdb002  
                  CALL aimi150_imdb_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aimi150_imdb_desc()

         BEFORE FIELD imdb002

         ON CHANGE imdb002

         BEFORE FIELD imdb004

         AFTER FIELD imdb004
            IF g_imda2_d[l_ac].imdb004 = '2' OR g_imda2_d[l_ac].imdb004 = '3'  THEN 
               LET g_imda2_d[l_ac].imdb005 = 'Y' 
            END IF
            
         ON CHANGE imdb004
            IF g_imda2_d[l_ac].imdb004 = '2' OR g_imda2_d[l_ac].imdb004 = '3'  THEN 
               LET g_imda2_d[l_ac].imdb005 = 'Y' 
            END IF
            
         BEFORE FIELD imdb005

         AFTER FIELD imdb005

         ON CHANGE imdb005
         
         BEFORE FIELD imdb003

         AFTER FIELD imdb003

         ON CHANGE imdb003

         ON ACTION controlp INFIELD imdbstus

         ON ACTION controlp INFIELD imdb002    
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imda2_d[l_ac].imdb002             #給予default值
            #給予arg
            CALL q_imaa001()                                #呼叫開窗
            LET g_imda2_d[l_ac].imdb002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_imda2_d[l_ac].imdb002 TO imdb002              #顯示到畫面上
            CALL aimi150_imdb_desc()
            NEXT FIELD imdb002                          #返回原欄位

         ON ACTION controlp INFIELD imdb003

         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imda2_d[l_ac].* = g_imda2_d_t.*
               END IF
               CLOSE aimi150_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            CALL aimi150_unlock_b("imdb_t",'2')
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT

      END INPUT
      
      
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
#+ 單身欄位開啟設定
PRIVATE FUNCTION aimi150_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1 
   
END FUNCTION
#+ 單身欄位關閉設定
PRIVATE FUNCTION aimi150_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   
END FUNCTION
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aimi150_lock_b(ps_table,ps_page)
DEFINE ps_table       STRING
DEFINE ps_page        STRING
DEFINE ls_group       STRING

   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "imda_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aimi150_bcl USING g_enterprise,g_ooed_m.ooed004,g_imda_d[l_ac].imda002
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aimi150_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "imdb_t,"
   #僅鎖定自身table
   LET ls_group = "imdb_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimi150_bcl2 USING g_enterprise,g_ooed_m.ooed004,g_imda2_d[l_ac].imdb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aimi150_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   
   RETURN TRUE
END FUNCTION
#+ 新增單身後其他table連動
PRIVATE FUNCTION aimi150_insert_b(ps_table,ps_keys,ps_page)
DEFINE ps_table    STRING
DEFINE ps_page     STRING
DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
DEFINE ls_group    STRING
   
   #判斷是否是同一群組的table
   LET ls_group = "imda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      INSERT INTO imda_t
                  (imdaent,
                   imda001,
                   imda002,
                   imdastus,imda004,imda005,imda003,imdaownid,imdaowndp,imdacrtid,imdacrtdt,imdacrtdp,imdamodid,imdamoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],
                   g_imda_d[l_ac].imdastus,g_imda_d[l_ac].imda004,g_imda_d[l_ac].imda005,g_imda_d[l_ac].imda003,g_imda_d[l_ac].imdaownid,g_imda_d[l_ac].imdaowndp,g_imda_d[l_ac].imdacrtid,g_imda_d[l_ac].imdacrtdt,g_imda_d[l_ac].imdacrtdp,g_imda_d[l_ac].imdamodid,g_imda_d[l_ac].imdamoddt)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imda_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
   END IF
   
   LET ls_group = "imdb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      INSERT INTO imdb_t
                  (imdbent,
                   imdb001,
                   imdb002,
                   imdbstus,imdb004,imdb005,imdb003,imdbownid,imdbowndp,imdbcrtid,imdbcrtdt,imdbcrtdp,imdbmodid,imdbmoddt) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],
                   g_imda2_d[l_ac].imdbstus,g_imda2_d[l_ac].imdb004,g_imda2_d[l_ac].imdb005,g_imda2_d[l_ac].imdb003,g_imda2_d[l_ac].imdbownid,g_imda2_d[l_ac].imdbowndp,g_imda2_d[l_ac].imdbcrtid,g_imda2_d[l_ac].imdbcrtdt,g_imda2_d[l_ac].imdbcrtdp,g_imda2_d[l_ac].imdbmodid,g_imda2_d[l_ac].imdbmoddt)  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imdb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
   END IF

END FUNCTION
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aimi150_unlock_b(ps_table,ps_page)
DEFINE ps_table STRING
DEFINE ps_page  STRING
DEFINE ls_group STRING

   LET ls_group = ""
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aimi150_bcl
   END IF
   
   LET ls_group = "imdb_t,"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aimi150_bcl2
   END IF
END FUNCTION
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aimi150_delete_b(ps_table,ps_keys_bak,ps_page)
DEFINE ps_table    STRING
DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
DEFINE ps_page     STRING
DEFINE ls_group    STRING


   #判斷是否是同一群組的table
   LET ls_group = "imda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      DELETE FROM imda_t
       WHERE imdaent = g_enterprise 
         AND imda001 = ps_keys_bak[1]
         AND imda002 = ps_keys_bak[2]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      RETURN
   END IF
   
   LET ls_group = "imdb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      DELETE FROM imdb_t
       WHERE imdbent = g_enterprise 
         AND imdb001 = ps_keys_bak[1] 
         AND imdb002 = ps_keys_bak[2]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imdb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      RETURN
   END IF
END FUNCTION
#+ 修改單身後其他table連動
PRIVATE FUNCTION aimi150_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "imda_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      UPDATE imda_t 
         SET (imda001,
              imda002
              ,imdastus,imda004,imda005,imda003,imdaownid,imdaowndp,imdacrtid,imdacrtdt,imdacrtdp,imdamodid,imdamoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imda_d[l_ac].imdastus,g_imda_d[l_ac].imda004,g_imda_d[l_ac].imda005,g_imda_d[l_ac].imda003,g_imda_d[l_ac].imdaownid,g_imda_d[l_ac].imdaowndp,g_imda_d[l_ac].imdacrtid,g_imda_d[l_ac].imdacrtdt,g_imda_d[l_ac].imdacrtdp,g_imda_d[l_ac].imdamodid,g_imda_d[l_ac].imdamoddt) 
         WHERE imadent = g_enterprise AND imda001 = ps_keys_bak[1] AND imda002 = ps_keys_bak[2]   #160905-00007#4 by 08172 add ent
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE
         
      END IF 
      RETURN
   END IF
   
   LET ls_group = "imdb_t,"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      UPDATE imdb_t 
         SET (imdb001,
              imdb002
              ,imdbstus,imdb004,imdb005,imdb003,imdbownid,imdbowndp,imdbcrtid,imdbcrtdt,imdbcrtdp,imdbmodid,imdbmoddt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imda2_d[l_ac].imdbstus,g_imda2_d[l_ac].imdb004,g_imda2_d[l_ac].imdb005,g_imda2_d[l_ac].imdb003,g_imda2_d[l_ac].imdbownid,g_imda2_d[l_ac].imdbowndp,g_imda2_d[l_ac].imdbcrtid,g_imda2_d[l_ac].imdbcrtdt,g_imda2_d[l_ac].imdbcrtdp,g_imda2_d[l_ac].imdbmodid,g_imda2_d[l_ac].imdbmoddt) 
         WHERE imdbent = g_enterprise AND imdb001 = ps_keys_bak[1] AND imdb002 = ps_keys_bak[2]   #160905-00007#4 by 08172 add ent
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imdb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE
         
      END IF
      RETURN
      
   END IF


END FUNCTION
#+ Tree子節點展開
PRIVATE FUNCTION aimi150_browser_expand1(p_id)
DEFINE p_id          LIKE type_t.num10
DEFINE l_id          LIKE type_t.num10
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_keyvalue    LIKE type_t.chr50
DEFINE l_typevalue   LIKE type_t.chr50
DEFINE l_type        LIKE type_t.chr50
DEFINE l_sql         LIKE type_t.chr500
DEFINE ls_source     LIKE type_t.chr500
DEFINE ls_exp_code   LIKE type_t.chr500
DEFINE l_return      LIKE type_t.num5

   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_return = FALSE
   LET g_browser[p_id].b_isExp = 1 
   LET l_keyvalue = g_browser[p_id].b_ooed004
   
         
   LET l_sql = "SELECT UNIQUE ooed004,ooed003 ",
               "  FROM ooed_t ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed005 = '",l_keyvalue,"' ",
               "   AND ooed004 <> ooed005",
               "   AND ooed001 = '8'",   #14/11/04 mod 2->8
               "   AND ooed006 <= '",g_today,"' ",
               "   AND ooed002 = '",g_browser[p_id].b_ooed002,"' ",
               "   AND ooed003 = '",g_browser[p_id].b_ooed003,"' ",
               "   AND (ooed007 IS NULL OR ooed007 > '",g_today,"' ) ",
               " ORDER BY ooed004"
   
   PREPARE tree_expand1 FROM l_sql
   DECLARE tree_ex_cur1 CURSOR FOR tree_expand1
  
   LET l_id = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur1 INTO g_browser[l_id].b_ooed004,g_browser[l_id].b_ooed003
      IF cl_null(g_browser[l_id].b_ooed004) THEN
         EXIT FOREACH
      END IF
      #pid=父節點id
      LET g_browser[l_id].b_pid  = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id  = g_browser[p_id].b_id||"."||l_cnt
      LET g_browser[l_id].b_exp = TRUE
      LET g_browser[l_id].b_ooed005 = g_browser[p_id].b_ooed004
      LET g_browser[l_id].b_ooed002 = g_browser[p_id].b_ooed002
      #hasC=確認該節點是否有子孫
      CALL aimi150_desc_show(l_id)
      LET g_browser[l_id].b_hasC = aimi150_chk_hasC(l_id)
#      IF g_browser[l_id].b_hasC = 1 THEN
#         CALL aimi150_browser_expand1(l_id)
#         LET l_id = g_browser.getLength()
#      END IF
      LET l_id = l_id + 1
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE
   END FOREACH
   LET l_cnt = l_cnt -1
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
END FUNCTION

 
{</section>}
 
