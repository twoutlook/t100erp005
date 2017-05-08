#該程式未解開Section, 採用最新樣板產出!
{<section id="anmi931.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2013-10-08 00:00:00), PR版次:0004(2016-09-05 16:33:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000280
#+ Filename...: anmi931
#+ Description: 資金收支項目存提碼維護
#+ Creator....: 02299(2013-10-08 15:52:52)
#+ Modifier...: 02299 -SD/PR- 01727
 
{</section>}
 
{<section id="anmi931.global" >}
#應用 i05 樣板自動產生(Version:37)
#add-point:填寫註解說明
#160318-00005#26  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00007#7   2016/09/05 By 01727     调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_nmbe_m RECORD
   nmbe001 LIKE nmbe_t.nmbe001, 
   nmbe002 LIKE nmbe_t.nmbe002, 
   nmbe002_desc LIKE type_t.chr80, 
   nmbe003 LIKE nmbe_t.nmbe003, 
   nmbe003_desc LIKE type_t.chr80, 
   nmbestus LIKE nmbe_t.nmbestus, 
   nmbeownid LIKE nmbe_t.nmbeownid, 
   nmbeownid_desc LIKE type_t.chr80, 
   nmbeowndp LIKE nmbe_t.nmbeowndp, 
   nmbeowndp_desc LIKE type_t.chr80, 
   nmbecrtid LIKE nmbe_t.nmbecrtid, 
   nmbecrtid_desc LIKE type_t.chr80, 
   nmbecrtdp LIKE nmbe_t.nmbecrtdp, 
   nmbecrtdp_desc LIKE type_t.chr80, 
   nmbecrtdt LIKE nmbe_t.nmbecrtdt, 
   nmbemodid LIKE nmbe_t.nmbemodid, 
   nmbemodid_desc LIKE type_t.chr80, 
   nmbemoddt LIKE nmbe_t.nmbemoddt
                                  END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_nmbe001_ins    LIKE nmbe_t.nmbe001
DEFINE g_nmbe001_def    LIKE nmbe_t.nmbe001
DEFINE g_nmbe002_ins    LIKE nmbe_t.nmbe002
DEFINE g_wc_def         STRING
#end add-point
                                  
#模組變數(Module Variables)
DEFINE g_nmbe_m          type_g_nmbe_m
DEFINE g_nmbe_m_t        type_g_nmbe_m
DEFINE g_nmbe_m_o        type_g_nmbe_m
 
   DEFINE g_nmbe001_t LIKE nmbe_t.nmbe001
DEFINE g_nmbe002_t LIKE nmbe_t.nmbe002
DEFINE g_nmbe003_t LIKE nmbe_t.nmbe003
 
 
#DEFINE g_nmbe003_t        LIKE nmbe_t.nmbe003
#DEFINE g_nmbe002_t        LIKE nmbe_t.nmbe002
#DEFINE g_nmbe001_t      LIKE nmbe_t.nmbe001
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #tree自定義欄位
          b_nmbe001 LIKE nmbe_t.nmbe001,
      b_nmbe002 LIKE nmbe_t.nmbe002,
   b_nmbe002_desc LIKE type_t.chr80,
      b_nmbe003 LIKE nmbe_t.nmbe003,
   b_nmbe003_desc LIKE type_t.chr80
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
 
{<section id="anmi931.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_nmbe001_def = g_argv[1]
   LET g_nmbe001_ins = g_nmbe001_def
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmbe001,nmbe002,'',nmbe003,'',nmbestus,nmbeownid,'',nmbeowndp,'',nmbecrtid, 
       '',nmbecrtdp,'',nmbecrtdt,nmbemodid,'',nmbemoddt", 
                      " FROM nmbe_t",
                      " WHERE nmbeent= ? AND nmbe001=? AND nmbe002=? AND nmbe003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmi931_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmbe001,t0.nmbe002,t0.nmbe003,t0.nmbestus,t0.nmbeownid,t0.nmbeowndp, 
       t0.nmbecrtid,t0.nmbecrtdp,t0.nmbecrtdt,t0.nmbemodid,t0.nmbemoddt,t1.nmbdl004 ,t2.nmajl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011",
               " FROM nmbe_t t0",
                              " LEFT JOIN nmbdl_t t1 ON t1.nmbdlent="||g_enterprise||" AND t1.nmbdl001=nmbe001 AND t1.nmbdl002=nmbe002 AND t1.nmbdl003='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t2 ON t2.nmajlent="||g_enterprise||" AND t2.nmajl001=nmbe003 AND t2.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=nmbeownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=nmbeowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=nmbecrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=nmbecrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=nmbemodid  ",
 
               " WHERE t0.nmbeent = " ||g_enterprise|| " AND t0.nmbe001 = ? AND t0.nmbe002 = ? AND t0.nmbe003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmi931_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmi931 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmi931_init()   
 
      #進入選單 Menu (="N")
      CALL anmi931_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmi931
      
   END IF 
   
   CLOSE anmi931_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmi931.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmi931_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
      CALL cl_set_combo_scc_part('nmbestus','17','N,Y')
 
   
   LET g_add_idx = 1
   LET g_current_idx = 1
    
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   CALL anmi931_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmi931.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmi931_ui_dialog()
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
         INITIALIZE g_nmbe_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         LET g_first = 1
         CALL anmi931_init()
      END IF
 
      #當瀏覽頁簽被設定關閉時,使用MENU (開啟時使用DIALOG)
      IF g_worksheet_hidden = 1 THEN
 
         LET g_current_sw = FALSE
 
         #回歸舊筆數位置 (回到當時異動的筆數)
         LET g_current_idx = g_current_row
         LET g_current_sw = TRUE
         CALL cl_show_fld_cont() 
         IF g_current_idx > 0 THEN
         CALL anmi931_fetch("")    #當每次點任一筆資料都會需要用到
         END IF
 
         MENU
            #add-point:ui_dialog段其他頁簽的 display array(in menu) name="ui_dialog.more_displayarray_in_menu"
            
            #end add-point
            
            ON ACTION statechange
               LET g_action_choice = "statechange"
               CALL anmi931_statechange()
            
            #ACTION表單列
            ON ACTION first
               LET g_current_idx = 1
               CALL anmi931_fetch("")
               LET g_current_row = g_current_idx
            
            ON ACTION next
               LET g_current_idx = g_current_idx + 1
               CALL anmi931_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION jump
               CALL anmi931_fetch("/")
               LET g_current_row = g_current_idx
 
            ON ACTION previous
               LET g_current_idx = g_current_idx - 1
               CALL anmi931_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION last 
               LET g_current_idx = g_browser_cnt
               CALL anmi931_fetch("") 
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmi931_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmi931_delete(DIALOG)
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmi931_insert(DIALOG)
               #add-point:ON ACTION insert name="menu2.insert"
               
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
               CALL anmi931_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
 
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmi931_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmi931_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmi931_set_pk_array()
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
            CALL anmi931_browser_fill(g_wc,g_searchtype)
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
 
                  CALL anmi931_fetch("")  #當每次點任一筆資料都會需要用到
 
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL anmi931_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
 
               ON COLLAPSE (g_row_index)
                  #樹關閉
                  
               #add-point:ui_dialog段action name="ui_dialog.tree_action"
               
               #end add-point
 
            END DISPLAY
 
            #add-point:ui_dialog段其他頁簽的 display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
            BEFORE DIALOG
               #action default動作(判定是否要先執行特定動作)
               #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL anmi931_insert(DIALOG)
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
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
               CALL anmi931_fetch("")            #當每次點任一筆資料都會需要用到
               END IF
               #add-point:ui_dialog,before dialog name="ui_dialog.b_dialog"
               
               #end add-point
 
            AFTER DIALOG 
               #add-point:ui_dialog,after dialog name="ui_dialog.a_dialog"
               
               #end add-point
 
            ON ACTION statechange
               LET g_action_choice = "statechange"
               CALL anmi931_statechange()
 
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmi931_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmi931_delete(DIALOG)
               #add-point:ON ACTION delete name="menu.delete"
               EXIT DIALOG
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmi931_insert(DIALOG)
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmi931_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
 
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmi931_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmi931_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmi931_set_pk_array()
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
 
{<section id="anmi931.browser_fill" >}
#+ 瀏覽頁簽where條件組成
PRIVATE FUNCTION anmi931_browser_fill(p_wc,p_type)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc       STRING 
   DEFINE p_type     LIKE type_t.chr10
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_cnt2     LIKE type_t.num10   
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_fill"
   CALL g_browser.clear()
   CLEAR FORM
   LET g_wc_def = p_wc
   CALL anmi931_create_tree()
   RETURN
   #end add-point
 
   CALL g_browser.clear()
   CLEAR FORM
   LET l_cnt = 0
   LET l_cnt2 = 0
   
   DROP TABLE anmi931_tmp
   
   #Create temp table
   CREATE TEMP TABLE anmi931_tmp
   (
         nmbe001 VARCHAR(500),
   nmbe002 VARCHAR(500),
   nmbe002_desc VARCHAR(500),
   nmbe003 VARCHAR(500),
   nmbe003_desc VARCHAR(500),
      #僅含browser的欄位
      exp_code  VARCHAR(5)
   );
 
   #先確定搜尋範圍(若無條件搜尋則只找root出來)
   SELECT COUNT(1) INTO l_cnt FROM nmbe_t WHERE nmbeent = g_enterprise AND 1=1
   
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT COUNT(1)",
               " FROM nmbe_t ",
               "  ",
               " WHERE nmbeent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("nmbe_t")
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
      LET p_wc = " nmbe003 = nmbe002 "
      LET g_root_search = TRUE
   END IF
 
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT nmbe001,nmbe002,'',nmbe003,'' ",
               " FROM nmbe_t",
               "  ",
               " WHERE nmbeent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("nmbe_t")
   #add-point:browser_fill段sql wc name="browser_fill.sql_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmbe_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_ext FROM g_sql
   DECLARE master_extcur CURSOR FOR master_ext
   
   #單筆update
   #LET g_sql = "SELECT '','','','','','','',nmbe001,nmbe002,'',nmbe003,'' ",
   #            " FROM nmbe_t",
   #            "  ",
   #            " WHERE nmbeent = " ||g_enterprise|| " AND ",
   #            " nmbe001 = ?"
   #            ," nmbe002 = ?"
   #            ," nmbe003 = ?"
 
                
   LET g_sql = " SELECT t0.nmbe001,t0.nmbe002,t0.nmbe003,t1.nmbdl004 ,t2.nmajl003 ",
               " FROM nmbe_t t0",
               "  ",
                              " LEFT JOIN nmbdl_t t1 ON t1.nmbdlent="||g_enterprise||" AND t1.nmbdl001=nmbe001 AND t1.nmbdl002=nmbe002 AND t1.nmbdl003='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t2 ON t2.nmajlent="||g_enterprise||" AND t2.nmajl001=nmbe003 AND t2.nmajl002='"||g_dlang||"' ",
 
               " WHERE nmbeent = " ||g_enterprise|| " AND ",
               " nmbe001 = ?"
               ," AND nmbe002 = ?"
               ," AND nmbe003 = ?"
 
 
               
   #add-point:browser_fill段sql wc name="browser_fill.refresh"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_refresh FROM g_sql
   DECLARE master_refreshcur CURSOR FOR master_refresh
 
   #搜尋建構樹所需的節點
   CASE p_type
      WHEN "1" #上推
         CALL anmi931_match_node(p_wc,p_type) 
      WHEN "2" #下展
         #CALL anmi931_find_speed_tbl(p_wc,p_type) 
         CALL anmi931_match_node(p_wc,p_type) 
      WHEN "3" #全部
         CALL anmi931_match_node(p_wc,p_type) 
   END CASE
 
   CALL anmi931_browser_create(p_type)
     
END FUNCTION
 
{</section>}
 
{<section id="anmi931.match_node" >}
PRIVATE FUNCTION anmi931_match_node(p_wc,p_type)
   #add-point:match_node段define name="match_node.define_customerization"
   
   #end add-point
   DEFINE p_wc         LIKE type_t.chr200
   DEFINE p_type       LIKE type_t.chr10
   DEFINE ls_code      LIKE type_t.chr50
   DEFINE ls_code2     LIKE type_t.chr50
   DEFINE l_bstmp      RECORD    #body欄位
             nmbe001 VARCHAR(500),
   nmbe002 VARCHAR(500),
   nmbe002_desc VARCHAR(500),
   nmbe003 VARCHAR(500),
   nmbe003_desc VARCHAR(500)
          #僅含單身table的欄位
   END RECORD 
   DEFINE l_child_list DYNAMIC ARRAY OF RECORD    #body欄位
             nmbe001 VARCHAR(500),
   nmbe002 VARCHAR(500),
   nmbe002_desc VARCHAR(500),
   nmbe003 VARCHAR(500),
   nmbe003_desc VARCHAR(500)
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
   
   IF cl_null("nmbe002") THEN
      LET ls_code = "0"
   END IF 
   
   CALL s_transaction_begin()
 
   LET g_sql = " INSERT INTO anmi931_tmp (nmbe001,nmbe002,nmbe002_desc,nmbe003,nmbe003_desc,exp_code) VALUES (?, 
       ?,?,?,?,?)"
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
      #(ver:35) add nmbe002
      IF anmi931_tmp_tbl_chk(l_bstmp.nmbe003,l_bstmp.nmbe002,ls_code   #(ver:35) add nmbe002
                  ,l_bstmp.nmbe001
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
      IF cl_null(l_child_list[1].nmbe003) THEN
         IF l_child_list.getLength() = 1 THEN
            EXIT WHILE
         ELSE
            CALL l_child_list.deleteElement(1)
            CONTINUE WHILE
         END IF
      END IF
 
      #確認是否有父節點
      LET g_sql = " SELECT COUNT(1) ",
                  " FROM nmbe_t t0",
                  " WHERE nmbeent = " ||g_enterprise|| " AND nmbe003 = ? ",
                  " AND nmbe001 = ? ",
                  cl_sql_add_filter("gzwe_t")
      PREPARE master_getparent_cnt FROM g_sql
      EXECUTE master_getparent_cnt USING l_child_list[1].nmbe002 INTO li_cnt
      IF li_cnt <= 0 THEN
         CALL l_child_list.deleteElement(1)
         CONTINUE WHILE
      END IF
 
      #擷取該節點的父節點到temp table中
      LET g_sql = " SELECT nmbe001,nmbe002,'',nmbe003,'' ",
                  " FROM nmbe_t t0",
                  " WHERE nmbeent = " ||g_enterprise|| " AND nmbe003 = ? ",
                  " AND nmbe001 = ? ",
                  cl_sql_add_filter("nmbe_t")
      PREPARE master_getparent_up FROM g_sql
      DECLARE master_getparent_up_cur CURSOR FOR master_getparent_up
      
   #  EXECUTE master_getparent_up USING l_child_list[1].nmbe002
   #                                    ,l_child_list[1].nmbe001
   #                                    INTO l_bstmp.*
      FOREACH master_getparent_up_cur USING l_child_list[1].nmbe002
                                        INTO l_bstmp.*
 
         IF SQLCA.SQLCODE THEN
            FREE master_getparent_up
            EXIT WHILE
         END IF
         #FREE master_getparent_up
      
         #確定該節點是否存在於temp table中
         IF STATUS = 0 AND anmi931_tmp_tbl_chk(l_bstmp.nmbe003,l_bstmp.nmbe002,ls_code2
                     ,l_bstmp.nmbe001
                     ) THEN
            EXECUTE master_tmp USING l_bstmp.*,ls_code2
 
            #若已找到root，表示已到根結點
            IF l_bstmp.nmbe003 = l_bstmp.nmbe002 THEN
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
 
{<section id="anmi931.tmp_tbl_chk" >}
#+ TEMP TABLE CHK
#PRIVATE FUNCTION anmi931_tmp_tbl_chk(ps_id,pi_code,ps_type)
PRIVATE FUNCTION anmi931_tmp_tbl_chk(ps_id,ps_pid,pi_code,ps_type)   #(ver:35) modify
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
   
   LET g_sql = " SELECT COUNT(1) FROM anmi931_tmp ", 
               " WHERE nmbe003 = ? ",
                 " AND nmbe002 = ? "   #(ver:35) add
                ," AND nmbe001 = ? "
 
   PREPARE anmi931_get_cnt FROM g_sql
   EXECUTE anmi931_get_cnt USING ls_id ,ls_pid   #(ver:35) add ls_pid
                                           ,ls_type
                                     INTO li_cnt
   FREE anmi931_get_cnt
 
   IF li_cnt = 0 OR SQLCA.SQLCODE THEN
      RETURN TRUE
   ELSE
      #資料已存在, 確定是否需要更新展開值
      LET g_sql = " SELECT exp_code FROM anmi931_tmp ",
                  " WHERE nmbe003 = ? ",
                    " AND nmbe002 = ? "   #(ver:35) add
                   ," AND nmbe001 = ? "
 
      PREPARE anmi931_chk_exp FROM g_sql
      EXECUTE anmi931_chk_exp USING ls_id ,ls_pid   #(ver;35) add ls_pid
                                              ,ls_type
                                        INTO li_code
      FREE anmi931_chk_exp
      
      #若新展開值>原展開值則做更新
      IF pi_code > li_code THEN
         LET g_sql = " UPDATE anmi931_tmp SET (exp_code) = ('",pi_code,"') ",
                     " WHERE nmbe003 = ? ",
                       " AND nmbe002 = ? "   #(ver:35) add
                      ," AND nmbe001 = ? "
         PREPARE anmi931_upd_exp FROM g_sql
         EXECUTE anmi931_upd_exp USING ls_id ,ls_pid   #(ver:35) add ls_pid
                                                 ,ls_type
         FREE anmi931_upd_exp
      END IF
      
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmi931.browser_expand" >}
#+ Tree子節點展開
PRIVATE FUNCTION anmi931_browser_expand(p_id)
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
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_expand.pre_function"
   
   #end add-point
   
   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_return = FALSE
 
   LET l_keyvalue = g_browser[p_id].b_nmbe003
   LET l_typevalue = g_browser[p_id].b_nmbe001
   
   CASE g_browser[p_id].b_expcode
      WHEN -1
         CALL g_browser.deleteElement(p_id)
      WHEN 0
         RETURN
      WHEN 1
         LET ls_source = "anmi931_tmp"
         LET ls_exp_code = "exp_code"
      WHEN 2
         LET ls_source = "nmbe_t"
         LET ls_exp_code = "'2'"
         LET ls_ent_wc = " nmbeent = " ||g_enterprise|| " AND "
   END CASE
    
   LET l_sql = " SELECT DISTINCT '','','','FALSE','','',",ls_exp_code,",nmbe001,nmbe002,'',nmbe003,'', 
       t1.nmbdl004 ,t2.nmajl003 ",
               " FROM ",ls_source,
                              " LEFT JOIN nmbdl_t t1 ON t1.nmbdlent="||g_enterprise||" AND t1.nmbdl001=nmbe001 AND t1.nmbdl002=nmbe002 AND t1.nmbdl003='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t2 ON t2.nmajlent="||g_enterprise||" AND t2.nmajl001=nmbe003 AND t2.nmajl002='"||g_dlang||"' ",
 
               " WHERE ",ls_ent_wc,"nmbe002 = '", l_keyvalue,
               "' AND nmbe003 <> nmbe002",
               " AND nmbe001 = '", l_typevalue,"'", 
               " ORDER BY nmbe003"
   
   #add-point:browser_expand段before_pre name="browser_expand.before_pre"
   
   #end add-point
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE tree_expand FROM l_sql
   DECLARE tree_ex_cur CURSOR FOR tree_expand
  
   LET l_id = p_id + 1
   LET g_cnt = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur INTO g_browser[l_id].*,g_browser[g_cnt].b_nmbe002_desc,g_browser[g_cnt].b_nmbe003_desc  
 
      #pid=父節點id
      LET g_browser[l_id].b_pid = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id = g_browser[p_id].b_id||"."||l_cnt
      #hasC=確認該節點是否有子孫
      CALL anmi931_desc_show(l_id)
      LET g_browser[l_id].b_hasC = anmi931_chk_hasC(l_id)
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
 
{<section id="anmi931.browser_create" >}
PRIVATE FUNCTION anmi931_browser_create(p_type)
   #add-point:browser_create name="browser_create.define_customerization"
   
   #end add-point
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50
   #add-point:browser_create(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_create.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_create.pre_function"
   
   #end add-point
   
   #先找出所有的帳別資料
   LET g_sql = " SELECT DISTINCT nmbe001 FROM anmi931_tmp ORDER BY nmbe001"
   PREPARE master_type FROM g_sql
   DECLARE master_typecur CURSOR FOR master_type
   INITIALIZE g_browser_root TO NULL
   
   LET l_ac = 1
   FOREACH master_typecur INTO g_browser[l_ac].b_nmbe001
      #確定root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處為帳別部分(LV-1)
      LET g_browser[l_ac].b_nmbe003  = g_browser[l_ac].b_nmbe001
      LET g_browser[l_ac].b_nmbe001 = g_browser[l_ac].b_nmbe001
      LET g_browser[l_ac].b_pid = "0" CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET l_ac = l_ac + 1
      
      #抓出LV2的所有資料
      #LET g_sql = " SELECT DISTINCT t0.nmbe001,t0.nmbe002,t0.nmbe003,exp_code FROM anmi931_tmp a ",
      LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,nmbe001,nmbe002,'',nmbe003,'',t1.nmbdl004 , 
          t2.nmajl003 FROM anmi931_tmp a ",
                                 " LEFT JOIN nmbdl_t t1 ON t1.nmbdlent="||g_enterprise||" AND t1.nmbdl001=nmbe001 AND t1.nmbdl002=nmbe002 AND t1.nmbdl003='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t2 ON t2.nmajlent="||g_enterprise||" AND t2.nmajl001=nmbe003 AND t2.nmajl002='"||g_dlang||"' ",
 
                  " WHERE ",
                  "a.nmbe001 = ? ",
                  " AND ",
                  " (( SELECT COUNT(1) FROM anmi931_tmp b WHERE a.nmbe002 = b.nmbe003 ", 
                  " AND a.nmbe001 = b.nmbe001",
                  ") = 0 OR ", 
                  " a.nmbe003 = a.nmbe002 )", 
                  " ORDER BY a.nmbe003"
      #add-point:browser_create.before_pre name="browser_create.before_pre"
      
      #end add-point
 
      PREPARE master_getLV2 FROM g_sql
      DECLARE master_getLV2cur CURSOR FOR master_getLV2
      
      #以下為一般資料root(LV-2)
      #OPEN master_getLV2cur USING g_browser[l_ac-1].b_nmbe001   #(ver:36)
 
      LET g_cnt = l_ac
      FOREACH master_getLV2cur   #(ver:36) #(ver:37)
         USING g_browser[l_ac-1].b_nmbe001   #(ver:36)
         INTO g_browser[g_cnt].*,g_browser[g_cnt].b_nmbe002_desc,g_browser[g_cnt].b_nmbe003_desc     
             #(ver:36)
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
         #LET g_browser[g_cnt].b_nmbe003 = g_browser[g_cnt].b_nmbe003 CLIPPED
         LET g_browser[g_cnt].b_pid = l_pid
         LET g_browser[g_cnt].b_id  = l_pid,".",g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp = FALSE
         #(ver:35) ---modify start---
         #LET g_browser[g_cnt].b_expcode = 2
         CASE g_browser[g_cnt].b_expcode
            WHEN 2
               LET g_browser[g_cnt].b_hasC = anmi931_chk_hasC(g_cnt)
            WHEN 1
               LET g_browser[g_cnt].b_hasC = anmi931_chk_hasC(g_cnt)
            WHEN 0
               LET g_browser[g_cnt].b_hasC = FALSE
            WHEN -1
               #向下查找到展開值不等於-1得節點(temp table中查找)
               LET g_cnt = anmi931_find_node(g_cnt)
         END CASE
         #(ver:35) --- modify end ---
         IF cl_null("nmbe002") THEN
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
      IF cl_null(g_browser[l_ac].b_nmbe003) THEN
         CALL g_browser.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         CALL anmi931_desc_show(l_ac)
      END IF
   END FOR
   CALL g_browser.deleteElement(l_ac)
 
   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
 
   FREE tree_expand
   FREE master_getLV2
   
END FUNCTION
 
{</section>}
 
{<section id="anmi931.desc_show" >}
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION anmi931_desc_show(pi_ac)
   #add-point:desc_show段define name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10   
   #add-point:desc_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   CALL anmi931_nmbe002_ref(g_browser[l_ac].b_nmbe001,g_browser[l_ac].b_nmbe002)
      RETURNING g_browser[l_ac].b_nmbe002_desc
   CALL anmi931_nmbe003_ref(g_browser[l_ac].b_nmbe003)
      RETURNING g_browser[l_ac].b_nmbe003_desc
   #end add-point
   
   #add-point:Function前置處理  name="desc_show.pre_function"
   
   #end add-point
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   
   
   #add-point:browser_create段desc處理 name="desc_show.show"
   IF cl_null(g_browser[l_ac].b_nmbe002) THEN 
      LET g_browser[l_ac].b_show = g_browser[l_ac].b_nmbe001
   ELSE
      IF cl_null(g_browser[l_ac].b_nmbe003) THEN
         LET g_browser[l_ac].b_show = g_browser[l_ac].b_nmbe002," ",g_browser[l_ac].b_nmbe002_desc
      ELSE
         LET g_browser[l_ac].b_show = g_browser[l_ac].b_nmbe003," ",g_browser[l_ac].b_nmbe003_desc
      END IF 
   END IF

   #end add-point
 
   LET l_ac = li_tmp
 
END FUNCTION
 
{</section>}
 
{<section id="anmi931.find_node" >}
#+ 尋找符合條件的節點
PRIVATE FUNCTION anmi931_find_node(pi_ac)
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
   
   LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,nmbe001,nmbe002,'',nmbe003,'' ",
               " FROM anmi931_tmp ",
               " WHERE nmbe002 = ? AND nmbe002 <> nmbe003",
               " ORDER BY nmbe003"
   PREPARE master_getNode FROM g_sql
   DECLARE master_getNodecur CURSOR FOR master_getNode
   
   LET li_idx = pi_ac
   WHILE li_idx <= g_browser.getLength()
      IF g_browser[li_idx].b_expcode = -1 THEN
      #  OPEN master_getNodecur USING g_browser[li_idx].b_nmbe003   #(ver:36)
         FOREACH master_getNodecur USING g_browser[li_idx].b_nmbe003 INTO g_browser[g_browser.getLength()+1].*  
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
            CALL anmi931_desc_show(g_browser.getLength())
            LET g_browser[g_browser.getLength()].b_pid = ls_pid
            LET g_browser[g_browser.getLength()].b_id = g_browser.getLength()
            LET g_browser[g_browser.getLength()].b_hasC = anmi931_chk_hasC(g_browser.getLength())
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
 
{<section id="anmi931.chk_hasC" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmi931_chk_hasC(pi_id)
   #add-point:chk_hasC段define name="chk_hasC.define_customerization"
   
   #end add-point
   DEFINE pi_id    LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:chk_hasC段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="chk_hasC.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="chk_hasC.pre_function"
   
   #end add-point
   
   LET g_sql = "SELECT COUNT(nmbe002) FROM anmi931_tmp ",
               " WHERE ",
                "nmbe002 = ? AND ",
                "exp_code <> '-1' AND nmbe003 <> nmbe002 "
                 ," AND ",
                "nmbe001 = ?"
 
   PREPARE anmi931_temp_chk FROM g_sql
 
   LET g_sql = "SELECT COUNT(1) FROM nmbe_t ",
               " WHERE nmbeent = " ||g_enterprise|| " AND ", 
               "nmbe003 <> nmbe002 AND ",
               "nmbe002 = ? ",
                " AND ",
               "nmbe001 = ?",
               cl_sql_add_filter("nmbe_t")
   
   PREPARE anmi931_master_chk FROM g_sql
   
   CASE g_browser[pi_id].b_expcode 
      WHEN -1
         RETURN FALSE
      WHEN 0
         RETURN FALSE
      WHEN 1
         EXECUTE anmi931_temp_chk 
           USING g_browser[pi_id].b_nmbe003
                 ,g_browser[pi_id].b_nmbe001
            INTO li_cnt
         FREE anmi931_temp_chk
      WHEN 2 
         EXECUTE anmi931_master_chk 
           USING g_browser[pi_id].b_nmbe003
                 ,g_browser[pi_id].b_nmbe001
            INTO li_cnt
         FREE anmi931_master_chk
   END CASE
    
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmi931.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmi931_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_wc       STRING
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面
   CLEAR FORM
   INITIALIZE g_nmbe_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_qryparam.state = "c"
    
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT BY NAME g_wc ON nmbe001,nmbe002,nmbe003,nmbestus,nmbeownid,nmbeowndp,nmbecrtid,nmbecrtdp, 
          nmbecrtdt,nmbemodid,nmbemoddt 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
            
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmbecrtdt>>----
         AFTER FIELD nmbecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmbemoddt>>----
         AFTER FIELD nmbemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbecnfdt>>----
         
         #----<<nmbepstdt>>----
 
 
 
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbe001
            #add-point:BEFORE FIELD nmbe001 name="construct.b.nmbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbe001
            
            #add-point:AFTER FIELD nmbe001 name="construct.a.nmbe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbe001
            #add-point:ON ACTION controlp INFIELD nmbe001 name="construct.c.nmbe001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbe002
            #add-point:ON ACTION controlp INFIELD nmbe002 name="construct.c.nmbe002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_nmbd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbe002  #顯示到畫面上

            NEXT FIELD nmbe002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbe002
            #add-point:BEFORE FIELD nmbe002 name="construct.b.nmbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbe002
            
            #add-point:AFTER FIELD nmbe002 name="construct.a.nmbe002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbe003
            #add-point:ON ACTION controlp INFIELD nmbe003 name="construct.c.nmbe003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbe003  #顯示到畫面上

            NEXT FIELD nmbe003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbe003
            #add-point:BEFORE FIELD nmbe003 name="construct.b.nmbe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbe003
            
            #add-point:AFTER FIELD nmbe003 name="construct.a.nmbe003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbestus
            #add-point:BEFORE FIELD nmbestus name="construct.b.nmbestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbestus
            
            #add-point:AFTER FIELD nmbestus name="construct.a.nmbestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbestus
            #add-point:ON ACTION controlp INFIELD nmbestus name="construct.c.nmbestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbeownid
            #add-point:ON ACTION controlp INFIELD nmbeownid name="construct.c.nmbeownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbeownid  #顯示到畫面上

            NEXT FIELD nmbeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbeownid
            #add-point:BEFORE FIELD nmbeownid name="construct.b.nmbeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbeownid
            
            #add-point:AFTER FIELD nmbeownid name="construct.a.nmbeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbeowndp
            #add-point:ON ACTION controlp INFIELD nmbeowndp name="construct.c.nmbeowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbeowndp  #顯示到畫面上

            NEXT FIELD nmbeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbeowndp
            #add-point:BEFORE FIELD nmbeowndp name="construct.b.nmbeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbeowndp
            
            #add-point:AFTER FIELD nmbeowndp name="construct.a.nmbeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbecrtid
            #add-point:ON ACTION controlp INFIELD nmbecrtid name="construct.c.nmbecrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbecrtid  #顯示到畫面上

            NEXT FIELD nmbecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbecrtid
            #add-point:BEFORE FIELD nmbecrtid name="construct.b.nmbecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbecrtid
            
            #add-point:AFTER FIELD nmbecrtid name="construct.a.nmbecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbecrtdp
            #add-point:ON ACTION controlp INFIELD nmbecrtdp name="construct.c.nmbecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbecrtdp  #顯示到畫面上

            NEXT FIELD nmbecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbecrtdp
            #add-point:BEFORE FIELD nmbecrtdp name="construct.b.nmbecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbecrtdp
            
            #add-point:AFTER FIELD nmbecrtdp name="construct.a.nmbecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbecrtdt
            #add-point:BEFORE FIELD nmbecrtdt name="construct.b.nmbecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbemodid
            #add-point:ON ACTION controlp INFIELD nmbemodid name="construct.c.nmbemodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbemodid  #顯示到畫面上

            NEXT FIELD nmbemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbemodid
            #add-point:BEFORE FIELD nmbemodid name="construct.b.nmbemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbemodid
            
            #add-point:AFTER FIELD nmbemodid name="construct.a.nmbemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbemoddt
            #add-point:BEFORE FIELD nmbemoddt name="construct.b.nmbemoddt"
            
            #END add-point
 
 
 
       
      END CONSTRUCT
  
      #add-point:cs段more_construct name="cs.more_construct"
      
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
   
   #end add-point
   
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmi931.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmi931_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.before_query"
   
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
 
   CALL anmi931_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      #add-point:query段取消 name="query.cancel"
      
      #end add-point
      #CALL anmi931_browser_fill(g_wc,g_searchtype)
      CALL anmi931_fetch("")
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
   CALL anmi931_browser_fill(g_wc,g_searchtype)
   
   IF g_browser_cnt > 0 THEN
      CALL anmi931_fetch("")
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
   #   CALL anmi931_browser_fill(g_wc,g_searchtype)
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
 
{<section id="anmi931.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmi931_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.befroe_fetch"
   
   #end add-point 
 
   LET ls_chk = g_browser[g_current_idx].b_id 
   IF ls_chk.getIndexOf(".",1) = 0 THEN
      INITIALIZE g_nmbe_m.* TO NULL
      DISPLAY BY NAME g_nmbe_m.*
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
 
   LET g_nmbe_m.nmbe003 = g_browser[g_current_idx].b_nmbe003
   LET g_nmbe_m.nmbe002 = g_browser[g_current_idx].b_nmbe002
   LET g_nmbe_m.nmbe001 = g_browser[g_current_idx].b_nmbe001
    
   #add-point:fetch段refresh前 name="fetch.before_refresh"
   IF cl_null(g_nmbe_m.nmbe003) THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
      RETURN
   END IF 
   #end add-point
    
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmi931_master_referesh USING g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003 INTO g_nmbe_m.nmbe001, 
       g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid, 
       g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt,g_nmbe_m.nmbe002_desc, 
       g_nmbe_m.nmbe003_desc,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp_desc,g_nmbe_m.nmbecrtid_desc, 
       g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbemodid_desc 
   
   IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "nmbe_t:",SQLERRMESSAGE 
       LET g_errparam.code = SQLCA.SQLCODE 
       LET g_errparam.popup = TRUE 
       CALL cl_err()
       INITIALIZE g_nmbe_m.* TO NULL
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
   LET g_nmbe_m_t.* = g_nmbe_m.*
   LET g_nmbe_m_o.* = g_nmbe_m.*
   
   #重新顯示
   CALL anmi931_show()
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   DISPLAY g_browser.getLength() TO FORMONLY.h_count 
 
   
   
END FUNCTION
 
{</section>}
 
{<section id="anmi931.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmi931_insert(l_dialog)
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
   
   LET g_nmbe001_t = g_nmbe_m.nmbe001
   LET g_nmbe002_t = g_nmbe_m.nmbe002
   LET g_nmbe003_t = g_nmbe_m.nmbe003
 
   LET g_nmbe003_t = g_nmbe_m.nmbe003
   LET g_nmbe001_t = g_nmbe_m.nmbe001
 
   #清畫面欄位內容
   CLEAR g_nmbe_m.*
 
 
   #add-point:單頭預設值 name="insert.before_insert"
   
   #end add-point 
 
   INITIALIZE g_nmbe_m.* LIKE nmbe_t.*
   DISPLAY BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
       g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
       g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
       g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
   CALL s_transaction_begin()
 
   #其他table資料備份(確定是否更改用)
   
 
   WHILE TRUE
      #給予pid,type預設值
      LET g_nmbe_m.nmbe002 = g_nmbe003_t
      LET g_nmbe_m.nmbe001 = g_nmbe001_t
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbe_m.nmbeownid = g_user
      LET g_nmbe_m.nmbeowndp = g_dept
      LET g_nmbe_m.nmbecrtid = g_user
      LET g_nmbe_m.nmbecrtdp = g_dept 
      LET g_nmbe_m.nmbecrtdt = cl_get_current()
      LET g_nmbe_m.nmbemodid = g_user
      LET g_nmbe_m.nmbemoddt = cl_get_current()
      LET g_nmbe_m.nmbestus = 'Y'
 
 
 
      
      CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
  
      
      
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      LET g_nmbe_m.nmbestus = "Y"
      IF g_current_idx = 0 THEN
         LET g_nmbe_m.nmbe001 = g_nmbe001_ins
         LET g_nmbe_m.nmbe002 = g_nmbe002_ins
      ELSE
         IF cl_null(g_browser[g_current_idx].b_nmbe001) THEN
            #LET g_nmbe_m.nmbe001 = g_nmbe001_ins
         ELSE
            LET g_nmbe_m.nmbe001 = g_browser[g_current_idx].b_nmbe001
         END IF 
         IF cl_null(g_browser[g_current_idx].b_nmbe002) THEN
            #LET g_nmbe_m.nmbe002 = g_nmbe002_ins
         ELSE
            LET g_nmbe_m.nmbe002 = g_browser[g_current_idx].b_nmbe002
         END IF
      END IF
      CALL anmi931_nmbe002_ref(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) 
         RETURNING g_nmbe_m.nmbe002_desc
      DISPLAY g_nmbe_m.nmbe002_desc TO nmbe002_desc
   
      DISPLAY '' TO nmbe003_desc
      #end add-point 
 
      CALL anmi931_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      IF NOT INT_FLAG THEN
         LET g_nmbe001_ins = g_nmbe_m.nmbe001
         LET g_nmbe002_ins = g_nmbe_m.nmbe002
      END IF
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_nmbe_m.* = g_nmbe_m_t.*
         CALL anmi931_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         EXIT WHILE
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_nmbe_m.nmbe002 = g_nmbe_m.nmbe003 THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_nmbe002 = g_nmbe_m.nmbe002
            LET g_browser[li_addpos].b_nmbe003 = g_nmbe_m.nmbe003
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL anmi931_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_nmbe003 = g_nmbe_m.nmbe002 THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_nmbe002 = g_nmbe_m.nmbe002
                     LET g_browser[li_addpos].b_nmbe003 = g_nmbe_m.nmbe003
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_nmbe001
                                                     ,g_browser[li_addpos].b_nmbe002
                                                     ,g_browser[li_addpos].b_nmbe003
 
                                                INTO g_browser[g_cnt].b_nmbe001,g_browser[g_cnt].b_nmbe002, 
                                                    g_browser[g_cnt].b_nmbe003,g_browser[g_cnt].b_nmbe002_desc, 
                                                    g_browser[g_cnt].b_nmbe003_desc
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL anmi931_desc_show(li_addpos)
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
   EXECUTE anmi931_master_referesh USING g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003 INTO g_nmbe_m.nmbe001, 
       g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid, 
       g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt,g_nmbe_m.nmbe002_desc, 
       g_nmbe_m.nmbe003_desc,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp_desc,g_nmbe_m.nmbecrtid_desc, 
       g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbemodid_desc
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
       g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
       g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
       g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
   
   #功能已完成,通報訊息中心
   CALL anmi931_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmi931.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmi931_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_nmbe_m.nmbe001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
   
   EXECUTE anmi931_master_referesh USING g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003 INTO g_nmbe_m.nmbe001, 
       g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid, 
       g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt,g_nmbe_m.nmbe002_desc, 
       g_nmbe_m.nmbe003_desc,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp_desc,g_nmbe_m.nmbecrtid_desc, 
       g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbemodid_desc
 
   #檢查是否允許此動作
   IF NOT anmi931_action_chk() THEN
      RETURN
   END IF
  
   LET g_nmbe001_t = g_nmbe_m.nmbe001
   LET g_nmbe002_t = g_nmbe_m.nmbe002
   LET g_nmbe003_t = g_nmbe_m.nmbe003
 
   
   CALL s_transaction_begin()
   
   OPEN anmi931_cl USING g_enterprise,g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE anmi931_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmi931_cl:" 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH anmi931_cl INTO g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
       g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
       g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
       g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.SQLCODE THEN
      CLOSE anmi931_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_nmbe_m.nmbe003,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #其他table資料備份(確定是否更改用)
   
 
   CALL anmi931_show()
   WHILE TRUE
      LET g_nmbe_m.nmbe001 = g_nmbe001_t
      LET g_nmbe_m.nmbe002 = g_nmbe002_t
      LET g_nmbe_m.nmbe003 = g_nmbe003_t
 
      
      #寫入修改者/修改日期資訊
      LET g_nmbe_m.nmbemodid = g_user 
LET g_nmbe_m.nmbemoddt = cl_get_current()
LET g_nmbe_m.nmbemodid_desc = cl_get_username(g_nmbe_m.nmbemodid)
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL anmi931_input("u")     #欄位更改
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_nmbe_m.* = g_nmbe_m_t.*
         CALL anmi931_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE nmbe_t SET (nmbemodid,nmbemoddt) = (g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt)
       WHERE nmbeent = g_enterprise AND nmbe001 = g_nmbe001_t
         AND nmbe002 = g_nmbe002_t
         AND nmbe003 = g_nmbe003_t
 
      
      EXIT WHILE
  
   END WHILE
 
   CLOSE anmi931_cl
   CALL s_transaction_end("Y","0")
 
   #功能已完成,通報訊息中心
   CALL anmi931_msgcentre_notify('modify')
   
END FUNCTION
 
{</section>}
 
{<section id="anmi931.check" >}
#+ 避免資料錯誤
PRIVATE FUNCTION anmi931_check(ps_id,ps_pid ,ps_type)
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
   LET ls_sql = " SELECT nmbe003,nmbe002 FROM ",
                " (SELECT nmbe003,nmbe002 FROM nmbe_t WHERE nmbeent = " ||g_enterprise|| " AND nmbe003<>nmbe002)", 
 
                " WHERE nmbe003 = '",ps_id,"' OR nmbe002 = '",ps_id,"'",
                " START WITH nmbe003='",ps_pid,"'",
                " CONNECT BY PRIOR nmbe002=nmbe003 "
 
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
 
{<section id="anmi931.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmi931_reproduce(l_dialog)
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_dialog      ui.DIALOG
   DEFINE li_addpos     LIKE type_t.num10
   DEFINE l_newno           LIKE nmbe_t.nmbe001 
   DEFINE l_oldno           LIKE nmbe_t.nmbe001 
   DEFINE l_newno02     LIKE nmbe_t.nmbe002 
   DEFINE l_oldno02     LIKE nmbe_t.nmbe002 
   DEFINE l_newno03     LIKE nmbe_t.nmbe003 
   DEFINE l_oldno03     LIKE nmbe_t.nmbe003 
 
   DEFINE l_master          RECORD LIKE nmbe_t.*
   DEFINE l_cnt             LIKE type_t.num10  
   DEFINE li_idx            LIKE type_t.num10  
   DEFINE li_cnt            LIKE type_t.num10  
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.before_reproduce"
   
   #end add-point
 
   #檢查PK欄位是否均有值,若全部為NULL時退出
   IF g_nmbe_m.nmbe001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   EXECUTE anmi931_master_referesh USING g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003 INTO g_nmbe_m.nmbe001, 
       g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid, 
       g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt,g_nmbe_m.nmbe002_desc, 
       g_nmbe_m.nmbe003_desc,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp_desc,g_nmbe_m.nmbecrtid_desc, 
       g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbemodid_desc
 
   #檢查如果有子節點(hasC=1)則顯示錯誤訊息後退出
 
   ERROR ""
 
   CALL cl_set_head_visible("","YES")
 
      LET g_nmbe_m.nmbe002_desc = ''
   DISPLAY BY NAME g_nmbe_m.nmbe002_desc
   LET g_nmbe_m.nmbe003_desc = ''
   DISPLAY BY NAME g_nmbe_m.nmbe003_desc
 
 
   LET g_nmbe_m.nmbe001 = ""
   LET g_nmbe_m.nmbe002 = ""
   LET g_nmbe_m.nmbe003 = ""
 
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbe_m.nmbeownid = g_user
      LET g_nmbe_m.nmbeowndp = g_dept
      LET g_nmbe_m.nmbecrtid = g_user
      LET g_nmbe_m.nmbecrtdp = g_dept 
      LET g_nmbe_m.nmbecrtdt = cl_get_current()
      LET g_nmbe_m.nmbemodid = g_user
      LET g_nmbe_m.nmbemoddt = cl_get_current()
      LET g_nmbe_m.nmbestus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #其他table資料備份(確定是否更改用)
   
 
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #直接呼叫輸入
   CALL anmi931_input("r")
 
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
 
   IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_nmbe_m.* = g_nmbe_m_t.*
         CALL anmi931_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_nmbe_m.nmbe002 = g_nmbe_m.nmbe003 THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_nmbe002 = g_nmbe_m.nmbe002
            LET g_browser[li_addpos].b_nmbe003 = g_nmbe_m.nmbe003
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL anmi931_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_nmbe003 = g_nmbe_m.nmbe002 THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_nmbe002 = g_nmbe_m.nmbe002
                     LET g_browser[li_addpos].b_nmbe003 = g_nmbe_m.nmbe003
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_nmbe001
                                                     ,g_browser[li_addpos].b_nmbe002
                                                     ,g_browser[li_addpos].b_nmbe003
 
                                                INTO g_browser[g_cnt].b_nmbe001,g_browser[g_cnt].b_nmbe002, 
                                                    g_browser[g_cnt].b_nmbe003,g_browser[g_cnt].b_nmbe002_desc, 
                                                    g_browser[g_cnt].b_nmbe003_desc
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL anmi931_desc_show(li_addpos)
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
   CALL anmi931_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmi931.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmi931_input(p_cmd)
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
   DISPLAY BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
       g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
       g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
       g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
 
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
   CALL anmi931_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmi931_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            #add-point:input段define name="input.action"
            IF NOT cl_null(g_nmbe_m.nmbe001) THEN 
               IF NOT cl_null(g_nmbe_m.nmbe002) THEN 
                  NEXT FIELD nmbe003
               ELSE
                  NEXT FIELD nmbe002
               END IF 
            ELSE
               NEXT FIELD nmbe001
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbe001
            #add-point:BEFORE FIELD nmbe001 name="input.b.nmbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbe001
            
            #add-point:AFTER FIELD nmbe001 name="input.a.nmbe001"
            #此段落由子樣板a05產生
            IF NOT anmi931_key_chk(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,
                                   g_nmbe_m_t.nmbe001,g_nmbe_m_t.nmbe002,g_nmbe_m_t.nmbe003,p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_nmbe_m.nmbe001 =''
               ELSE
                  LET g_nmbe_m.nmbe001 = g_nmbe_m_t.nmbe001
               END IF 
               NEXT FIELD nmbe001
            END IF 
            IF NOT anmi931_nmbe001_chk(g_nmbe_m.nmbe001) THEN
               IF p_cmd = 'a' THEN
                  LET g_nmbe_m.nmbe001 =''
               ELSE
                  LET g_nmbe_m.nmbe001 = g_nmbe_m_t.nmbe001
               END IF
               NEXT FIELD nmbe001
            END IF
            DISPLAY '' TO nmbe002_desc
            IF NOT anmi931_nmbe002_chk(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) THEN
               LET g_nmbe_m.nmbe002 = ''
               CALL anmi931_nmbe002_ref(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) 
                  RETURNING g_nmbe_m.nmbe002_desc
               DISPLAY g_nmbe_m.nmbe002_desc TO nmbe002_desc   
               NEXT FIELD nmbe002
            END IF 
            CALL anmi931_nmbe002_ref(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) 
                  RETURNING g_nmbe_m.nmbe002_desc
               DISPLAY g_nmbe_m.nmbe002_desc TO nmbe002_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbe001
            #add-point:ON CHANGE nmbe001 name="input.g.nmbe001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbe002
            
            #add-point:AFTER FIELD nmbe002 name="input.a.nmbe002"
            DISPLAY '' TO nmbe002_desc
            IF NOT anmi931_key_chk(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,
                                   g_nmbe_m_t.nmbe001,g_nmbe_m_t.nmbe002,g_nmbe_m_t.nmbe003,p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_nmbe_m.nmbe002 =''
               ELSE
                  LET g_nmbe_m.nmbe002 = g_nmbe_m_t.nmbe002
               END IF
               NEXT FIELD nmbe002
            END IF
            IF NOT anmi931_nmbe002_chk(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) THEN
               IF p_cmd = 'a' THEN
                  LET g_nmbe_m.nmbe002 =''
               ELSE
                  LET g_nmbe_m.nmbe002 = g_nmbe_m_t.nmbe002
               END IF
               CALL anmi931_nmbe002_ref(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) 
                  RETURNING g_nmbe_m.nmbe002_desc
               DISPLAY g_nmbe_m.nmbe002_desc TO nmbe002_desc   
               NEXT FIELD nmbe002
            END IF 
            CALL anmi931_nmbe002_ref(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) 
                  RETURNING g_nmbe_m.nmbe002_desc
               DISPLAY g_nmbe_m.nmbe002_desc TO nmbe002_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbe002
            #add-point:BEFORE FIELD nmbe002 name="input.b.nmbe002"
            IF cl_null(g_nmbe_m.nmbe001) THEN
               NEXT FIELD nmbe001
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbe002
            #add-point:ON CHANGE nmbe002 name="input.g.nmbe002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbe003
            
            #add-point:AFTER FIELD nmbe003 name="input.a.nmbe003"
            DISPLAY '' TO nmbe003_desc
            IF NOT anmi931_key_chk(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,
                                   g_nmbe_m_t.nmbe001,g_nmbe_m_t.nmbe002,g_nmbe_m_t.nmbe003,p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_nmbe_m.nmbe003 =''
               ELSE
                  LET g_nmbe_m.nmbe003 = g_nmbe_m_t.nmbe003
               END IF
               NEXT FIELD nmbe003
            END IF
            IF NOT anmi931_nmbe003_chk(g_nmbe_m.nmbe003) THEN
               IF p_cmd = 'a' THEN
                  LET g_nmbe_m.nmbe003 =''
               ELSE
                  LET g_nmbe_m.nmbe003 = g_nmbe_m_t.nmbe003
               END IF
               CALL anmi931_nmbe003_ref(g_nmbe_m.nmbe003) 
                  RETURNING g_nmbe_m.nmbe003_desc
               DISPLAY g_nmbe_m.nmbe003_desc TO nmbe003_desc
               NEXT FIELD nmbe003
            END IF 
            CALL anmi931_nmbe003_ref(g_nmbe_m.nmbe003) 
               RETURNING g_nmbe_m.nmbe003_desc
            DISPLAY g_nmbe_m.nmbe003_desc TO nmbe003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbe003
            #add-point:BEFORE FIELD nmbe003 name="input.b.nmbe003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbe003
            #add-point:ON CHANGE nmbe003 name="input.g.nmbe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbestus
            #add-point:BEFORE FIELD nmbestus name="input.b.nmbestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbestus
            
            #add-point:AFTER FIELD nmbestus name="input.a.nmbestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbestus
            #add-point:ON CHANGE nmbestus name="input.g.nmbestus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbe001
            #add-point:ON ACTION controlp INFIELD nmbe001 name="input.c.nmbe001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbe002
            #add-point:ON ACTION controlp INFIELD nmbe002 name="input.c.nmbe002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbe_m.nmbe002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmbe_m.nmbe001 #

            CALL q_nmbd002()                                #呼叫開窗

            LET g_nmbe_m.nmbe002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmbe_m.nmbe002 TO nmbe002              #顯示到畫面上
            CALL anmi931_nmbe002_ref(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) 
               RETURNING g_nmbe_m.nmbe002_desc
            DISPLAY g_nmbe_m.nmbe002_desc TO nmbe002_desc
            NEXT FIELD nmbe002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbe003
            #add-point:ON ACTION controlp INFIELD nmbe003 name="input.c.nmbe003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbe_m.nmbe003             #給予default值

            CALL q_nmaj001()                                #呼叫開窗

            LET g_nmbe_m.nmbe003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmbe_m.nmbe003 TO nmbe003              #顯示到畫面上
            CALL anmi931_nmbe003_ref(g_nmbe_m.nmbe003) 
               RETURNING g_nmbe_m.nmbe003_desc
            DISPLAY g_nmbe_m.nmbe003_desc TO nmbe003_desc
            NEXT FIELD nmbe003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbestus
            #add-point:ON ACTION controlp INFIELD nmbestus name="input.c.nmbestus"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #避免資料錯誤的檢查
            IF anmi931_check(g_nmbe_m.nmbe003,g_nmbe_m.nmbe002
               ,g_nmbe_m.nmbe001
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
            DISPLAY BY NAME g_nmbe_m.nmbe003
 
            #實體新增/修改/複製段落的處理
            CASE
               WHEN p_cmd = "a" OR p_cmd = "r"
                  LET l_count = 1
 
                  SELECT COUNT(1) INTO l_count FROM nmbe_t
                   WHERE nmbeent = g_enterprise AND nmbe001 = g_nmbe_m.nmbe001
                     AND nmbe002 = g_nmbe_m.nmbe002
                     AND nmbe003 = g_nmbe_m.nmbe003
 
                         #
                  IF l_count = 0 THEN
                     #add-point:單頭新增前 name="input.head.b_insert"
                     
                     #end add-point
 
                     INSERT INTO nmbe_t (nmbeent,nmbe001,nmbe002,nmbe003,nmbestus,nmbeownid,nmbeowndp, 
                         nmbecrtid,nmbecrtdp,nmbecrtdt,nmbemodid,nmbemoddt)
                     VALUES (g_enterprise,g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus, 
                         g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtdp, 
                         g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt) 
 
                     #add-point:單頭新增中 name="input.head.m_insert"
                     
                     #end add-point
 
                     IF SQLCA.SQLCODE THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "g_nmbe_m:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                  
                     #提速檔資料建置
                     IF g_nmbe_m.nmbe003 <> g_nmbe_m.nmbe002 THEN
                        #CALL n_nmbes_generate_child(g_nmbe_m.nmbe003,g_nmbe_m.nmbe002)
                     END IF
                     
                     #add-point:單頭新增後 name="input.head.a_insert"
                     
                     #end add-point
                     
                     #資料多語言用-增/改
                     
                     CALL s_transaction_end("Y","0")
                  ELSE
                     CALL s_transaction_end("N","0")
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend =  g_nmbe_m.nmbe003 
                     LET g_errparam.code =  "std-00006" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  END IF 
 
               #修改段落
               WHEN p_cmd = "u"  
                  #add-point:單頭修改前 name="input.head.b_update"
                  
                  #end add-point
                  UPDATE nmbe_t SET (nmbe001,nmbe002,nmbe003,nmbestus,nmbeownid,nmbeowndp,nmbecrtid, 
                      nmbecrtdp,nmbecrtdt,nmbemodid,nmbemoddt) = (g_nmbe_m.nmbe001,g_nmbe_m.nmbe002, 
                      g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid, 
                      g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt)
                   WHERE nmbeent = g_enterprise AND nmbe001 = g_nmbe001_t #
                     AND nmbe002 = g_nmbe002_t
                     AND nmbe003 = g_nmbe003_t
 
                  #add-point:單頭修改中 name="input.head.m_update"
                  
                  #end add-point
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        CALL s_transaction_end('N','0')
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "nmbe_t" 
                        LET g_errparam.code = "std-00009" 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        
                     WHEN SQLCA.SQLCODE #其他錯誤
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "nmbe_t:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL s_transaction_end('N','0')
                        CALL cl_err()
                        
                     OTHERWISE
                        #add-point:單頭修改後 name="input.head.a_update"
                        
                        #end add-point
    
                        #資料多語言用-增/改
                        
                        LET g_log1 = util.JSON.stringify(g_nmbe_m_t)
                        LET g_log2 = util.JSON.stringify(g_nmbe_m)
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
   
   #end add-point
    
END FUNCTION
 
{</section>}
 
{<section id="anmi931.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmi931_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
       
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmi931_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:reference段之後 name="show.head.reference"
#   CALL anmi931_nmbe002_ref(g_nmbe_m.nmbe001,g_nmbe_m.nmbe002) 
#      RETURNING g_nmbe_m.nmbe002_desc
#   DISPLAY g_nmbe_m.nmbe002_desc TO nmbe002_desc
#   
#   CALL anmi931_nmbe003_ref(g_nmbe_m.nmbe003) 
#      RETURNING g_nmbe_m.nmbe003_desc
#   DISPLAY g_nmbe_m.nmbe003_desc TO nmbe003_desc
#   INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbe_m.nmbeownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_nmbe_m.nmbeownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbe_m.nmbeownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbe_m.nmbeowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_nmbe_m.nmbeowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbe_m.nmbeowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbe_m.nmbecrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_nmbe_m.nmbecrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbe_m.nmbecrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbe_m.nmbecrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_nmbe_m.nmbecrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbe_m.nmbecrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbe_m.nmbemodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_nmbe_m.nmbemodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbe_m.nmbemodid_desc
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
       g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
       g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
       g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
 
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbe_m.nmbestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()   
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmi931.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmi931_delete(l_dialog)
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
   
   IF g_nmbe_m.nmbe001 IS NULL
 
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
 
   EXECUTE anmi931_master_referesh USING g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003 INTO g_nmbe_m.nmbe001, 
       g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid, 
       g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt,g_nmbe_m.nmbe002_desc, 
       g_nmbe_m.nmbe003_desc,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp_desc,g_nmbe_m.nmbecrtid_desc, 
       g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbemodid_desc
    
   #檢查是否允許此動作
   IF NOT anmi931_action_chk() THEN
      RETURN
   END IF
    
   CALL anmi931_show()
   
   #Transaction開始
   CALL s_transaction_begin()
   
   
 
   OPEN anmi931_cl USING g_enterprise,g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE anmi931_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmi931_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH anmi931_cl INTO g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
       g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
       g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
       g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_nmbe_m.nmbe003,":",SQLERRMESSAGE 
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
#        LET li_status = anmi931_sql_delete(TRUE)
#     ELSE
#        LET li_status = FALSE
#     END IF
#  ELSE
      #如果沒有子節點,詢問是否刪除本筆資料
      IF cl_ask_delete() THEN
         LET li_status = anmi931_sql_delete(FALSE)
      ELSE
         LET li_status = FALSE
      END IF
#  END IF
   #(ver:35) --- modify end ---
 
   #檢查實體砍除是否發生意外中止
   IF NOT li_status THEN
      CALL s_transaction_end("N","0")
      CLOSE anmi931_cl
      RETURN
   END IF
 
   #刪除節點與資料內容
   CALL l_dialog.deleteNode("s_browse",g_current_idx)  #deleteNode會順便幫忙做deleteElement
 
   #確認這一階還有沒有兄弟 (有:不異動上階屬性/否:上階hasC及exp設定成0)
   #SELECT COUNT(1) INTO li_cnt
   #  FROM nmbe_t
   # WHERE nmbe002 = g_nmbe_m.nmbe002
   #IF g_current_idx > 1 THEN
   #   IF li_cnt = 0  THEN
   #      LET g_browser[g_current_idx - 1].b_hasC = 0
   #      LET g_browser[g_current_idx - 1].b_exp = 0
   #   END IF
   #END IF
 
   #add-point:單頭刪除後 name="delete.head.a_delete"
   
   #end add-point
   
   IF g_current_idx > 1 THEN
      LET g_current_idx = g_current_idx - 1
   END IF
   
   IF g_browser.getLength() > 0 THEN
      CALL anmi931_fetch("")
   END IF
 
   LET g_log1 = util.JSON.stringify(g_nmbe_m)   #(ver:36)
   IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:36)
      CLOSE anmi931_cl
      CALL s_transaction_end('N','0')
   ELSE
      CLOSE anmi931_cl
      CALL s_transaction_end('Y','0')
   END IF
 
   #功能已完成,通報訊息中心
   CALL anmi931_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmi931.sql_delete" >}
#+ 實體刪除FUNCTION 
PRIVATE FUNCTION anmi931_sql_delete(li_node)
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
      CALL anmi931_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
   #add-point:單頭刪除前 name="delete.head.b_delete"
   
   #end add-point
   
   IF li_node = TRUE THEN
      #砍除該節點以下所有節點
      LET ls_sql = " SELECT nmbe003,nmbe002 FROM ",
                   " (SELECT nmbe003,nmbe002 FROM nmbe_t WHERE nmbeent = " ||g_enterprise|| " AND nmbe003<>nmbe002)", 
 
                   " START WITH nmbe002='",g_nmbe_m.nmbe002,"'",
                   " CONNECT BY PRIOR nmbe003 = nmbe002"
 
   ELSE 
   
   END IF
 
   #刪除當下節點
   DELETE FROM nmbe_t
    WHERE nmbeent = g_enterprise AND nmbe001 = g_nmbe_m.nmbe001
      AND nmbe002 = g_nmbe_m.nmbe002
      AND nmbe003 = g_nmbe_m.nmbe003
 
 
   #add-point:單頭刪除中 name="delete.head.m_delete"
   
   #end add-point
 
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "nmbe_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
   END IF
 
   #(ver:35) ---modify start---
   # 若此節點還有存在在其他節點下，則多語言資料不可刪除
   LET li_cnt = 0
   LET ls_sql = " SELECT COUNT(1) FROM nmbe_t",
                 " WHERE nmbeent = " ||g_enterprise|| " AND nmbe003 = '",g_nmbe_m.nmbe003,"'"
 
   PREPARE master_chk_node_exist FROM ls_sql
   EXECUTE master_chk_node_exist INTO li_cnt
   IF li_cnt <= 0 THEN
      
   END IF
   #(ver:35) --- modify end ---
 
   RETURN li_return
 
END FUNCTION
 
{</section>}
 
{<section id="anmi931.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmi931_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1 
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("nmbe001,nmbe002,nmbe003",TRUE)
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
 
{<section id="anmi931.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmi931_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmbe001,nmbe002,nmbe003",FALSE)
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
 
{<section id="anmi931.default_search" >}
#+ 外部參數預設搜尋
PRIVATE FUNCTION anmi931_default_search()
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
      LET ls_wc = ls_wc, " nmbe001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmbe002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " nmbe003 = '", g_argv[03], "' AND "
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
   
   #CALL anmi931_browser_fill(g_wc,g_searchtype)
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmi931.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmi931_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmbe_m.nmbe001 IS NULL
      OR g_nmbe_m.nmbe002 IS NULL      OR g_nmbe_m.nmbe003 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmi931_cl USING g_enterprise,g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003
   IF STATUS THEN
      CLOSE anmi931_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmi931_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmi931_master_referesh USING g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003 INTO g_nmbe_m.nmbe001, 
       g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbecrtid, 
       g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt,g_nmbe_m.nmbe002_desc, 
       g_nmbe_m.nmbe003_desc,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp_desc,g_nmbe_m.nmbecrtid_desc, 
       g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbemodid_desc
   
 
   #檢查是否允許此動作
   IF NOT anmi931_action_chk() THEN
      CLOSE anmi931_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
       g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
       g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
       g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
 
   CASE g_nmbe_m.nmbestus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_nmbe_m.nmbestus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_nmbe_m.nmbestus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmi931_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_nmbe_m.nmbemodid = g_user
   LET g_nmbe_m.nmbemoddt = cl_get_current()
   LET g_nmbe_m.nmbestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmbe_t 
      SET (nmbestus,nmbemodid,nmbemoddt) 
        = (g_nmbe_m.nmbestus,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt)     
    WHERE nmbeent = g_enterprise AND nmbe001 = g_nmbe_m.nmbe001
      AND nmbe002 = g_nmbe_m.nmbe002      AND nmbe003 = g_nmbe_m.nmbe003
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE anmi931_master_referesh USING g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe003 INTO g_nmbe_m.nmbe001, 
          g_nmbe_m.nmbe002,g_nmbe_m.nmbe003,g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeowndp, 
          g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdt,g_nmbe_m.nmbemodid,g_nmbe_m.nmbemoddt, 
          g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003_desc,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp_desc, 
          g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbemodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmbe_m.nmbe001,g_nmbe_m.nmbe002,g_nmbe_m.nmbe002_desc,g_nmbe_m.nmbe003,g_nmbe_m.nmbe003_desc, 
          g_nmbe_m.nmbestus,g_nmbe_m.nmbeownid,g_nmbe_m.nmbeownid_desc,g_nmbe_m.nmbeowndp,g_nmbe_m.nmbeowndp_desc, 
          g_nmbe_m.nmbecrtid,g_nmbe_m.nmbecrtid_desc,g_nmbe_m.nmbecrtdp,g_nmbe_m.nmbecrtdp_desc,g_nmbe_m.nmbecrtdt, 
          g_nmbe_m.nmbemodid,g_nmbe_m.nmbemodid_desc,g_nmbe_m.nmbemoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE anmi931_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmi931_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi931.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmi931_set_pk_array()
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
   LET g_pk_array[1].values = g_nmbe_m.nmbe001
   LET g_pk_array[1].column = 'nmbe001'
   LET g_pk_array[2].values = g_nmbe_m.nmbe002
   LET g_pk_array[2].column = 'nmbe002'
   LET g_pk_array[3].values = g_nmbe_m.nmbe003
   LET g_pk_array[3].column = 'nmbe003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi931.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmi931_msgcentre_notify(lc_state)
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
   CALL anmi931_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmbe_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmi931.action_chk" >}
PRIVATE FUNCTION anmi931_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmi931.other_function" readonly="Y" >}
#+ nmbe002帶值
PRIVATE FUNCTION anmi931_nmbe002_ref(p_nmbe001,p_nmbe002)
   DEFINE p_nmbe001 LIKE nmbe_t.nmbe001
   DEFINE p_nmbe002 LIKE nmbe_t.nmbe002
   DEFINE r_nmbdl004 LIKE nmbdl_t.nmbdl004
   
   INITIALIZE g_ref_fields TO NULL
   LET r_nmbdl004 = ''
   LET g_ref_fields[1] = p_nmbe001
   LET g_ref_fields[2] = p_nmbe002
   CALL ap_ref_array2(g_ref_fields,"SELECT nmbdl004 FROM nmbdl_t WHERE nmbdlent='"||g_enterprise||"' AND nmbdl001=? AND nmbdl002=? AND nmbdl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_nmbdl004 = g_rtn_fields[1] 
   RETURN r_nmbdl004
END FUNCTION
#nmbe002有效性檢查
PRIVATE FUNCTION anmi931_nmbe002_chk(p_nmbe001,p_nmbe002)
   DEFINE p_nmbe001 LIKE nmbe_t.nmbe001
   DEFINE p_nmbe002 LIKE nmbe_t.nmbe002
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(p_nmbe001) AND NOT cl_null(p_nmbe002) THEN
      IF r_success THEN
         #檢查是否存在nmbd_t表中
         #報錯：anm-00001
         IF NOT ap_chk_isExist(p_nmbe002,"SELECT COUNT(*) FROM nmbd_t WHERE "
            ||"nmbdent = '" ||g_enterprise|| "' AND "||"nmbd002 = ? AND nmbd001 = '"||p_nmbe001||"' ",'anm-00001',0) THEN
            LET r_success = FALSE
         END IF
      END IF
      IF r_success THEN
         #檢查是否存在nmbd_t表且為有效的資料
         #報錯：'sub-01302'  #160318-00005#26 mod  anm-00015
         IF NOT ap_chk_isExist(p_nmbe002,"SELECT COUNT(*) FROM nmbd_t WHERE "
            ||"nmbdent = '" ||g_enterprise|| "' AND "||"nmbd002 = ? AND nmbdstus = 'Y' AND nmbd001 = '"||p_nmbe001||"'",'sub-01302','anmi930') THEN #160318-00005#26 mod #'anm-00015',0) THEN
            LET r_success = FALSE
         END IF
      END IF 
   END IF 
   RETURN r_success 
END FUNCTION
#+ nmbe003帶值
PRIVATE FUNCTION anmi931_nmbe003_ref(p_nmbe003)
   DEFINE p_nmbe003 LIKE nmbe_t.nmbe003
   DEFINE r_nmajl003 LIKE nmajl_t.nmajl003
   
   INITIALIZE g_ref_fields TO NULL
   LET r_nmajl003 = ''
   LET g_ref_fields[1] = p_nmbe003
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_nmajl003 = g_rtn_fields[1]
   RETURN r_nmajl003
END FUNCTION
#+ nmbe003有效性檢查
PRIVATE FUNCTION anmi931_nmbe003_chk(p_nmbe003)
   DEFINE p_nmbe003 LIKE nmbe_t.nmbe003
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(p_nmbe003) THEN
      IF r_success THEN
         #檢查是否存在nmaj_t表中的nmaj001
         #報錯：anm-00017
         IF NOT ap_chk_isExist(p_nmbe003,"SELECT COUNT(*) FROM nmaj_t WHERE "
            ||"nmajent = '" ||g_enterprise|| "' AND "||"nmaj001 = ? ",'anm-00017',0) THEN
            LET r_success = FALSE
         END IF
      END IF 
      IF r_success THEN
         #檢查是否存在nmaj_t表中的nmaj001且為有效的資料
         #報錯：anm-00016
         IF NOT ap_chk_isExist(p_nmbe003,"SELECT COUNT(*) FROM nmaj_t WHERE "
            ||"nmajent = '" ||g_enterprise|| "' AND "||"nmaj001 = ? AND nmajstus = 'Y' ",'anm-00016',0) THEN
            LET r_success = FALSE
         END IF
      END IF 
   END IF 
   RETURN r_success 
END FUNCTION
#+ key值檢查重複性
PRIVATE FUNCTION anmi931_key_chk(p_nmbe001,p_nmbe002,p_nmbe003,p_nmbe001_t,p_nmbe002_t,p_nmbe003_t,p_cmd)
   DEFINE p_nmbe001 LIKE nmbe_t.nmbe001
   DEFINE p_nmbe001_t LIKE nmbe_t.nmbe001
   DEFINE p_nmbe002 LIKE nmbe_t.nmbe002
   DEFINE p_nmbe002_t LIKE nmbe_t.nmbe002
   DEFINE p_nmbe003 LIKE nmbe_t.nmbe003
   DEFINE p_nmbe003_t LIKE nmbe_t.nmbe003
   DEFINE r_success LIKE type_t.num5
   DEFINE p_cmd LIKE type_t.chr5
   
   LET r_success = TRUE
   IF NOT cl_null(p_nmbe001) AND NOT cl_null(p_nmbe002) AND NOT cl_null(p_nmbe003) THEN 
      IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (p_nmbe001 != p_nmbe001_t  
           OR p_nmbe002 != p_nmbe002_t  OR p_nmbe003 != p_nmbe003_t ))) THEN 
         IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbe_t WHERE "||"nmbeent = '" 
            ||g_enterprise|| "' AND "||"nmbe001 = '"||p_nmbe001 ||"' AND "
            || "nmbe002 = '"||p_nmbe002 ||"' AND "|| "nmbe003 = '"||p_nmbe003 ||"'",'std-00004',0) THEN 
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION
#+ nmbe001有效性檢查
PRIVATE FUNCTION anmi931_nmbe001_chk(p_nmbe001)
   DEFINE p_nmbe001 LIKE nmbe_t.nmbe001
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(p_nmbe001) THEN
      IF r_success THEN
         #檢查是否存在nmbd_t表中
         #報錯：anm-00001
         IF NOT ap_chk_isExist(p_nmbe001,"SELECT COUNT(*) FROM nmbd_t WHERE "
            ||"nmbdent = '" ||g_enterprise|| "' AND "||"nmbd001 = ? ",'anm-00001',0) THEN
            LET r_success = FALSE
         END IF
      END IF
      IF r_success THEN
         #檢查是否存在nmbd_t表且為有效的資料
         #報錯：'sub-01302'  #160318-00005#26 mod anm-00015
         IF NOT ap_chk_isExist(p_nmbe001,"SELECT COUNT(*) FROM nmbd_t WHERE "
            ||"nmbdent = '" ||g_enterprise|| "' AND "||"nmbd001 = ? AND nmbdstus = 'Y' ",'sub-01302','anmi930') THEN #160318-00005#26 mod #'anm-00015',0) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success 
END FUNCTION
#+
PRIVATE FUNCTION anmi931_create_tree()
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50   #用於樹的第一層
   DEFINE l_pid2   LIKE type_t.chr50   #用於樹的第一層
   DEFINE l_sql    STRING 

   #建立樹上面的內容
   IF cl_null(g_wc_def) THEN 
      LET g_wc_def = " 1=1"
   END IF
   #第一層的資料
   
   IF cl_null(g_nmbe001_def) THEN 
      IF g_wc_def = " 1=1" THEN
         LET l_sql = " SELECT UNIQUE nmbd001 FROM nmbd_t ",
                     "  WHERE nmbdent = '",g_enterprise,"'  ORDER BY nmbd001"
      ELSE
         LET l_sql = " SELECT UNIQUE nmbd001 FROM nmbd_t ",
                     "  WHERE nmbdent = '",g_enterprise,"' AND nmbd001 IN (SELECT nmbe001 FROM nmbe_t WHERE nmbeent ='",g_enterprise,"' AND ",g_wc_def," )",
                     "  ORDER BY nmbd001"
      END IF
   ELSE
      LET l_sql = " SELECT UNIQUE nmbd001 FROM nmbd_t ",
                  "  WHERE nmbdent = '",g_enterprise,"' AND nmbd001 = '",g_nmbe001_def,"' ORDER BY nmbd001"
      
   END IF 
   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   IF cl_null(g_nmbe001_def) THEN 
      IF g_wc_def = " 1=1" THEN
         LET l_sql = " SELECT UNIQUE nmbd002 FROM nmbd_t ",
                     "  WHERE nmbdent = '",g_enterprise,"' AND nmbd001 = ? AND nmbdstus = 'Y' ORDER BY nmbd002"
      ELSE
         LET l_sql = " SELECT UNIQUE nmbd002 FROM nmbd_t WHERE nmbd001 = ? AND nmbdstus = 'Y' AND nmbdent ='",g_enterprise,"'",
                     "    AND nmbd002 IN (SELECT nmbe002 FROM nmbe_t WHERE nmbeent ='",g_enterprise,"' AND ",g_wc_def,")",
                     "  ORDER BY nmbd002"
      END IF 
   ELSE
      LET l_sql = " SELECT UNIQUE nmbd002 FROM nmbd_t ",
                     "  WHERE nmbdent = '",g_enterprise,"' AND nmbd001 = ? AND nmbdstus = 'Y' ORDER BY nmbd002"
      LET g_nmbe001_def = ''
   END IF 
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1
   #第三層的資料
   LET l_sql = " SELECT UNIQUE nmbe003 FROM nmbe_t WHERE nmbe001 = ? AND nmbe002 = ? AND nmbeent ='",g_enterprise,"'",
               "    AND  ",g_wc_def,
               "  ORDER BY nmbe003"
   PREPARE master_type_2 FROM l_sql
   DECLARE master_typecur_2 CURSOR FOR master_type_2

   INITIALIZE g_browser_root TO NULL
   #初始化l_ac
   LET l_ac = 1

   FOREACH master_typecur_0 INTO g_browser[l_ac].b_nmbe001
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處(LV-1)
      LET g_browser[l_ac].b_nmbe001 = g_browser[l_ac].b_nmbe001
      LET g_browser[l_ac].b_pid = '0' CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      #第一層给与第二层的值
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET g_cnt = l_ac
      LET l_ac = l_ac + 1 
      FOREACH master_typecur_1 USING g_browser[g_cnt].b_nmbe001 INTO g_browser[l_ac].b_nmbe002
         LET g_browser_root[g_browser_root.getLength()+1] = l_ac
         #此處(LV-2)
         LET g_browser[l_ac].b_nmbe001 = g_browser[g_cnt].b_nmbe001
         LET g_browser[l_ac].b_nmbe002 = g_browser[l_ac].b_nmbe002
         LET g_browser[l_ac].b_pid = l_pid
         LET g_browser[l_ac].b_id = l_pid,".",l_ac USING "<<<"
         LET g_browser[l_ac].b_exp = TRUE
         LET g_browser[l_ac].b_hasC = TRUE
         #第二層给与第三层的值
         LET l_pid2 = g_browser[l_ac].b_id CLIPPED
         LET g_cnt = l_ac
         LET l_ac = l_ac + 1 
         FOREACH master_typecur_2 USING g_browser[g_cnt].b_nmbe001,g_browser[g_cnt].b_nmbe002 INTO g_browser[l_ac].b_nmbe003
            LET g_browser[l_ac].b_nmbe001 = g_browser[g_cnt].b_nmbe001
            LET g_browser[l_ac].b_nmbe002 = g_browser[g_cnt].b_nmbe002
            LET g_browser[l_ac].b_nmbe003 = g_browser[l_ac].b_nmbe003
            LET g_browser[l_ac].b_pid = l_pid2
            LET g_browser[l_ac].b_id = l_pid2,".",l_ac USING "<<<"
            LET g_browser[l_ac].b_exp = TRUE
            LET g_browser[l_ac].b_hasC = FALSE
            LET l_ac = l_ac +1
	     END FOREACH
      END FOREACH
      LET l_ac = g_browser.getLength()
   END FOREACH 

   FOR l_ac = 1 TO g_browser.getLength()
      IF cl_null(g_browser[l_ac].b_nmbe001) THEN
         CALL g_browser.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         CALL anmi931_desc_show(l_ac)
      END IF
   END FOR
   CALL g_browser.deleteElement(l_ac)
   
   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
   DISPLAY g_browser_cnt TO FORMONLY.b_count 
   FREE tree_expand
END FUNCTION

 
{</section>}
 
