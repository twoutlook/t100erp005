#該程式未解開Section, 採用最新樣板產出!
{<section id="aimt310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-05-30 18:07:44), PR版次:0004(2016-07-13 10:13:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: aimt310
#+ Description: 料件申請關務資料維護作業
#+ Creator....: 04441(2015-07-28 10:07:34)
#+ Modifier...: 04441 -SD/PR- 02159
 
{</section>}
 
{<section id="aimt310.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#18   16/04/13  BY 07900   校验代码重复错误讯息的修改
#160705-00042#9    16/07/13  By sakura  程式中寫死g_prog部分改寫MATCHES方式
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_imbn_m RECORD
       imbndocno LIKE imbn_t.imbndocno, 
   imbadocdt LIKE imba_t.imbadocdt, 
   imba900 LIKE imba_t.imba900, 
   imba900_desc LIKE type_t.chr80, 
   oobxl003 LIKE type_t.chr80, 
   imba000 LIKE imba_t.imba000, 
   imba901 LIKE imba_t.imba901, 
   imba901_desc LIKE type_t.chr80, 
   imba001 LIKE imba_t.imba001, 
   imba002 LIKE imba_t.imba002, 
   imbal002 LIKE imbal_t.imbal002, 
   imbal003 LIKE imbal_t.imbal003, 
   imbal004 LIKE imbal_t.imbal004, 
   imba009 LIKE imba_t.imba009, 
   imba009_desc LIKE type_t.chr80, 
   imba003 LIKE imba_t.imba003, 
   imba003_desc LIKE type_t.chr80, 
   imba004 LIKE imba_t.imba004, 
   imba005 LIKE imba_t.imba005, 
   imba005_desc LIKE type_t.chr80, 
   imba006 LIKE imba_t.imba006, 
   imba006_desc LIKE type_t.chr80, 
   imba010 LIKE imba_t.imba010, 
   imba010_desc LIKE type_t.chr80, 
   status LIKE type_t.chr500, 
   imbn011 LIKE imbn_t.imbn011, 
   imbn011_desc LIKE type_t.chr80, 
   imbn012 LIKE imbn_t.imbn012, 
   imbn013 LIKE imbn_t.imbn013, 
   imbn014 LIKE imbn_t.imbn014, 
   imbnownid LIKE imbn_t.imbnownid, 
   imbnownid_desc LIKE type_t.chr80, 
   imbnowndp LIKE imbn_t.imbnowndp, 
   imbnowndp_desc LIKE type_t.chr80, 
   imbncrtid LIKE imbn_t.imbncrtid, 
   imbncrtid_desc LIKE type_t.chr80, 
   imbncrtdp LIKE imbn_t.imbncrtdp, 
   imbncrtdp_desc LIKE type_t.chr80, 
   imbncrtdt LIKE imbn_t.imbncrtdt, 
   imbnmodid LIKE imbn_t.imbnmodid, 
   imbnmodid_desc LIKE type_t.chr80, 
   imbnmoddt LIKE imbn_t.imbnmoddt, 
   imbn021 LIKE imbn_t.imbn021, 
   imbn022 LIKE imbn_t.imbn022, 
   imbn023 LIKE imbn_t.imbn023, 
   imbn024 LIKE imbn_t.imbn024, 
   imbn025 LIKE imbn_t.imbn025, 
   imbn031 LIKE imbn_t.imbn031, 
   imbn032 LIKE imbn_t.imbn032, 
   imbn033 LIKE imbn_t.imbn033, 
   imbn034 LIKE imbn_t.imbn034
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
         b_imba000 LIKE imba_t.imba000,
      b_imbndocno LIKE imbn_t.imbndocno,
   b_imbadocdt LIKE imba_t.imbadocdt,
   b_imba001 LIKE imba_t.imba001,
   b_imba001_desc LIKE type_t.chr80,
   b_imba001_desc_desc LIKE type_t.chr80,
   b_imba009 LIKE imba_t.imba009,
   b_imba009_desc LIKE type_t.chr80,
   b_imba003 LIKE imba_t.imba003,
   b_imba003_desc LIKE type_t.chr80,
      b_imbn011 LIKE imbn_t.imbn011,
   b_imbn011_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imbn_m        type_g_imbn_m  #單頭變數宣告
DEFINE g_imbn_m_t      type_g_imbn_m  #單頭舊值宣告(系統還原用)
DEFINE g_imbn_m_o      type_g_imbn_m  #單頭舊值宣告(其他用途)
DEFINE g_imbn_m_mask_o type_g_imbn_m  #轉換遮罩前資料
DEFINE g_imbn_m_mask_n type_g_imbn_m  #轉換遮罩後資料
 
   DEFINE g_imbndocno_t LIKE imbn_t.imbndocno
 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      imbaldocno LIKE imbal_t.imbaldocno,
      imbal002 LIKE imbal_t.imbal002,
      imbal003 LIKE imbal_t.imbal003,
      imbal004 LIKE imbal_t.imbal004
      END RECORD
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aimt310.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_flag  LIKE type_t.chr1
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aim","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_imbn_m.imbndocno = g_argv[02]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imbndocno,'','','','','','','','','','','','','','','','','','','','', 
       '','','','',imbn011,'',imbn012,imbn013,imbn014,imbnownid,'',imbnowndp,'',imbncrtid,'',imbncrtdp, 
       '',imbncrtdt,imbnmodid,'',imbnmoddt,imbn021,imbn022,imbn023,imbn024,imbn025,imbn031,imbn032,imbn033, 
       imbn034", 
                      " FROM imbn_t",
                      " WHERE imbnent= ? AND imbnsite= ? AND imbndocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimt310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imbndocno,t0.imbn011,t0.imbn012,t0.imbn013,t0.imbn014,t0.imbnownid, 
       t0.imbnowndp,t0.imbncrtid,t0.imbncrtdp,t0.imbncrtdt,t0.imbnmodid,t0.imbnmoddt,t0.imbn021,t0.imbn022, 
       t0.imbn023,t0.imbn024,t0.imbn025,t0.imbn031,t0.imbn032,t0.imbn033,t0.imbn034,t8.oocql004 ,t9.ooag011 , 
       t10.ooefl003 ,t11.ooag011 ,t12.ooefl003 ,t13.ooag011",
               " FROM imbn_t t0",
                              " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='229' AND t8.oocql002=t0.imbn011 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.imbnownid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.imbnowndp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.imbncrtid  ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.imbncrtdp AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.imbnmodid  ",
 
               " WHERE t0.imbnent = " ||g_enterprise|| " AND t0.imbnsite = ? AND t0.imbndocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimt310_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimt310 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimt310_init()   
 
      #進入選單 Menu (="N")
      CALL aimt310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimt310
      
   END IF 
   
   CLOSE aimt310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimt310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimt310_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
      CALL cl_set_combo_scc('imba000','32') 
   CALL cl_set_combo_scc('imba004','1001') 
   CALL cl_set_combo_scc('imbn013','1022') 
   CALL cl_set_combo_scc('imbn014','1023') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('status','13')
   CALL cl_set_combo_scc('b_imba000','32')
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimt310_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimt310_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
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
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_imbn_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimt310_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL aimt310_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimt310_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimt310' THEN        #160705-00042#9 160713 by sakura mark
               IF g_prog MATCHES 'aimt310' THEN   #160705-00042#9 160713 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL aimt310_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimt310_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimt310_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimt310_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimt310_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               EXIT MENU
               
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
               EXIT MENU
            
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aimt310_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimt310_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimt310_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimt310_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt306
            LET g_action_choice="open_aimt306"
            IF cl_auth_chk_act("open_aimt306") THEN
               
               #add-point:ON ACTION open_aimt306 name="menu2.open_aimt306"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt306 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt307
            LET g_action_choice="open_aimt307"
            IF cl_auth_chk_act("open_aimt307") THEN
               
               #add-point:ON ACTION open_aimt307 name="menu2.open_aimt307"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt307 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt308
            LET g_action_choice="open_aimt308"
            IF cl_auth_chk_act("open_aimt308") THEN
               
               #add-point:ON ACTION open_aimt308 name="menu2.open_aimt308"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt308 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt303
            LET g_action_choice="open_aimt303"
            IF cl_auth_chk_act("open_aimt303") THEN
               
               #add-point:ON ACTION open_aimt303 name="menu2.open_aimt303"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt303 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/aim/aimt310_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/aim/aimt310_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt301
            LET g_action_choice="open_aimt301"
            IF cl_auth_chk_act("open_aimt301") THEN
               
               #add-point:ON ACTION open_aimt301 name="menu2.open_aimt301"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt301 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimt310_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt302
            LET g_action_choice="open_aimt302"
            IF cl_auth_chk_act("open_aimt302") THEN
               
               #add-point:ON ACTION open_aimt302 name="menu2.open_aimt302"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt302 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt304
            LET g_action_choice="open_aimt304"
            IF cl_auth_chk_act("open_aimt304") THEN
               
               #add-point:ON ACTION open_aimt304 name="menu2.open_aimt304"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt304 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt305
            LET g_action_choice="open_aimt305"
            IF cl_auth_chk_act("open_aimt305") THEN
               
               #add-point:ON ACTION open_aimt305 name="menu2.open_aimt305"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt305 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba009
            LET g_action_choice="prog_imba009"
            IF cl_auth_chk_act("prog_imba009") THEN
               
               #add-point:ON ACTION prog_imba009 name="menu2.prog_imba009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imbn_m.imba009)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba003
            LET g_action_choice="prog_imba003"
            IF cl_auth_chk_act("prog_imba003") THEN
               
               #add-point:ON ACTION prog_imba003 name="menu2.prog_imba003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imbn_m.imba003)
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimt310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimt310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimt310_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL aimt310_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL aimt310_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimt310_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimt310' THEN        #160705-00042#9 160713 by sakura mark
               IF g_prog MATCHES 'aimt310' THEN   #160705-00042#9 160713 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
 
 
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aimt310_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimt310_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimt310_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimt310_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimt310_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimt310_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
                  CALL cl_notice()
               END IF
               #EXIT DIALOG
               
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
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               END IF
         
            #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aimt310_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimt310_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimt310_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimt310_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt306
            LET g_action_choice="open_aimt306"
            IF cl_auth_chk_act("open_aimt306") THEN
               
               #add-point:ON ACTION open_aimt306 name="menu.open_aimt306"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt306 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt307
            LET g_action_choice="open_aimt307"
            IF cl_auth_chk_act("open_aimt307") THEN
               
               #add-point:ON ACTION open_aimt307 name="menu.open_aimt307"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt307 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt308
            LET g_action_choice="open_aimt308"
            IF cl_auth_chk_act("open_aimt308") THEN
               
               #add-point:ON ACTION open_aimt308 name="menu.open_aimt308"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt308 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt303
            LET g_action_choice="open_aimt303"
            IF cl_auth_chk_act("open_aimt303") THEN
               
               #add-point:ON ACTION open_aimt303 name="menu.open_aimt303"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt303 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/aim/aimt310_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/aim/aimt310_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt301
            LET g_action_choice="open_aimt301"
            IF cl_auth_chk_act("open_aimt301") THEN
               
               #add-point:ON ACTION open_aimt301 name="menu.open_aimt301"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt301 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimt310_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt302
            LET g_action_choice="open_aimt302"
            IF cl_auth_chk_act("open_aimt302") THEN
               
               #add-point:ON ACTION open_aimt302 name="menu.open_aimt302"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt302 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt304
            LET g_action_choice="open_aimt304"
            IF cl_auth_chk_act("open_aimt304") THEN
               
               #add-point:ON ACTION open_aimt304 name="menu.open_aimt304"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt304 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt305
            LET g_action_choice="open_aimt305"
            IF cl_auth_chk_act("open_aimt305") THEN
               
               #add-point:ON ACTION open_aimt305 name="menu.open_aimt305"
               IF NOT cl_null(g_imbn_m.imbndocno) THEN
                  CALL cl_cmdrun("aimt305 '"||g_imbn_m.imbndocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba009
            LET g_action_choice="prog_imba009"
            IF cl_auth_chk_act("prog_imba009") THEN
               
               #add-point:ON ACTION prog_imba009 name="menu.prog_imba009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imbn_m.imba009)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba003
            LET g_action_choice="prog_imba003"
            IF cl_auth_chk_act("prog_imba003") THEN
               
               #add-point:ON ACTION prog_imba003 name="menu.prog_imba003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imbn_m.imba003)
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimt310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimt310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimt310_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimt310_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "imbndocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imbn_t ",
               "  ",
               "  LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbndocno = imbaldocno AND imbal001 = '",g_dlang,"' ",
               " WHERE imbnent = " ||g_enterprise|| " AND imbnsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imbn_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   LET g_sql = " SELECT COUNT(*) FROM imbn_t,imba_t ",
               "   LEFT JOIN imbal_t ON imbalent = imbaent AND imbadocno = imbaldocno AND imbal001 = '",g_dlang,"' ",
               "  WHERE imbaent = imbnent AND imbadocno = imbndocno ",
               "    AND imbnent = '" ||g_enterprise|| "' AND imbnsite = '" ||g_site|| "' ",
               "    AND ",p_wc CLIPPED, cl_sql_add_filter("imbn_t")
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_imbn_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imbnstus,t0.imbndocno,t0.imbn011,t5.oocql004",
               " FROM imbn_t t0 ",
               "  ",
                              " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='229' AND t5.oocql002=t0.imbn011 AND t5.oocql003='"||g_dlang||"' ",
 
               " LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbndocno = imbaldocno AND imbal001 = '",g_dlang,"' ",
               " WHERE t0.imbnent = " ||g_enterprise|| " AND t0.imbnsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imbn_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   LET g_sql = " SELECT imbnstus,imbndocno,imbn011,oocql004 ",
               "   FROM imba_t,imbn_t ",
               "   LEFT JOIN oocql_t ON oocqlent = imbnent AND oocql001 = '229' AND oocql002 = imbn011 AND oocql003 = '"||g_lang||"' ",
               "  WHERE imbaent = imbnent AND imbadocno = imbndocno ",
               "    AND imbnent = '" ||g_enterprise|| "' AND imbnsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imbn_t")
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
 
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imbn_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imbndocno,g_browser[g_cnt].b_imbn011, 
          g_browser[g_cnt].b_imbn011_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      SELECT imba000,imbadocdt,imba001,imbal002,imbal003,imba009,rtaxl003,imba003,oocql004
        INTO g_browser[g_cnt].b_imba000,g_browser[g_cnt].b_imbadocdt,g_browser[g_cnt].b_imba001,
             g_browser[g_cnt].b_imba001_desc,g_browser[g_cnt].b_imba001_desc_desc,g_browser[g_cnt].b_imba009,
             g_browser[g_cnt].b_imba009_desc,g_browser[g_cnt].b_imba003,g_browser[g_cnt].b_imba003_desc
        FROM imba_t
        LEFT JOIN imbal_t ON imbalent = imbaent AND imbaldocno = imbadocno AND imbal001 = g_lang
        LEFT JOIN rtaxl_t ON rtaxlent = imbaent AND rtaxl001 = imba009 AND rtaxl002 = g_lang
        LEFT JOIN oocql_t ON oocqlent = imbaent AND oocql001='200' AND oocql002 = imba003 AND oocql003 = g_lang
       WHERE imbadocno = g_browser[g_cnt].b_imbndocno
         AND imbaent = g_enterprise
         #end add-point
         
         #遮罩相關處理
         CALL aimt310_browser_mask()
         
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
 
      FREE browse_pre
 
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_imbndocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt310.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimt310_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_imbn_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imbndocno,imbadocdt,imba900,imba000,imba901,imba001,imba002,imbal002, 
          imbal003,imbal004,imba009,imba003,imba004,imba005,imba006,imba010,imbn011,imbn012,imbn013, 
          imbn014,imbnownid,imbnowndp,imbncrtid,imbncrtdp,imbncrtdt,imbnmodid,imbnmoddt,imbn021,imbn022, 
          imbn023,imbn024,imbn025,imbn031,imbn032,imbn033,imbn034
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imbncrtdt>>----
         AFTER FIELD imbncrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imbnmoddt>>----
         AFTER FIELD imbnmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imbncnfdt>>----
         
         #----<<imbnpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.imbndocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbndocno
            #add-point:ON ACTION controlp INFIELD imbndocno name="construct.c.imbndocno"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbndocno  #顯示到畫面上

            NEXT FIELD imbndocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbndocno
            #add-point:BEFORE FIELD imbndocno name="construct.b.imbndocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbndocno
            
            #add-point:AFTER FIELD imbndocno name="construct.a.imbndocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocdt
            #add-point:BEFORE FIELD imbadocdt name="construct.b.imbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocdt
            
            #add-point:AFTER FIELD imbadocdt name="construct.a.imbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocdt
            #add-point:ON ACTION controlp INFIELD imbadocdt name="construct.c.imbadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba900
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba900
            #add-point:ON ACTION controlp INFIELD imba900 name="construct.c.imba900"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba900  #顯示到畫面上

            NEXT FIELD imba900                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba900
            #add-point:BEFORE FIELD imba900 name="construct.b.imba900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba900
            
            #add-point:AFTER FIELD imba900 name="construct.a.imba900"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba000
            #add-point:BEFORE FIELD imba000 name="construct.b.imba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba000
            
            #add-point:AFTER FIELD imba000 name="construct.a.imba000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba000
            #add-point:ON ACTION controlp INFIELD imba000 name="construct.c.imba000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba901
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba901
            #add-point:ON ACTION controlp INFIELD imba901 name="construct.c.imba901"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba901  #顯示到畫面上

            NEXT FIELD imba901                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba901
            #add-point:BEFORE FIELD imba901 name="construct.b.imba901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba901
            
            #add-point:AFTER FIELD imba901 name="construct.a.imba901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba001
            #add-point:ON ACTION controlp INFIELD imba001 name="construct.c.imba001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba001  #顯示到畫面上

            NEXT FIELD imba001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba001
            #add-point:BEFORE FIELD imba001 name="construct.b.imba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba001
            
            #add-point:AFTER FIELD imba001 name="construct.a.imba001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba002
            #add-point:BEFORE FIELD imba002 name="construct.b.imba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba002
            
            #add-point:AFTER FIELD imba002 name="construct.a.imba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba002
            #add-point:ON ACTION controlp INFIELD imba002 name="construct.c.imba002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal002
            #add-point:BEFORE FIELD imbal002 name="construct.b.imbal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal002
            
            #add-point:AFTER FIELD imbal002 name="construct.a.imbal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal002
            #add-point:ON ACTION controlp INFIELD imbal002 name="construct.c.imbal002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal003
            #add-point:BEFORE FIELD imbal003 name="construct.b.imbal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal003
            
            #add-point:AFTER FIELD imbal003 name="construct.a.imbal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal003
            #add-point:ON ACTION controlp INFIELD imbal003 name="construct.c.imbal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal004
            #add-point:BEFORE FIELD imbal004 name="construct.b.imbal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal004
            
            #add-point:AFTER FIELD imbal004 name="construct.a.imbal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal004
            #add-point:ON ACTION controlp INFIELD imbal004 name="construct.c.imbal004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba009
            #add-point:ON ACTION controlp INFIELD imba009 name="construct.c.imba009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba009  #顯示到畫面上

            NEXT FIELD imba009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba009
            #add-point:BEFORE FIELD imba009 name="construct.b.imba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba009
            
            #add-point:AFTER FIELD imba009 name="construct.a.imba009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba003
            #add-point:ON ACTION controlp INFIELD imba003 name="construct.c.imba003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba003  #顯示到畫面上

            NEXT FIELD imba003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba003
            #add-point:BEFORE FIELD imba003 name="construct.b.imba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba003
            
            #add-point:AFTER FIELD imba003 name="construct.a.imba003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba004
            #add-point:BEFORE FIELD imba004 name="construct.b.imba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba004
            
            #add-point:AFTER FIELD imba004 name="construct.a.imba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba004
            #add-point:ON ACTION controlp INFIELD imba004 name="construct.c.imba004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba005
            #add-point:ON ACTION controlp INFIELD imba005 name="construct.c.imba005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba005  #顯示到畫面上

            NEXT FIELD imba005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba005
            #add-point:BEFORE FIELD imba005 name="construct.b.imba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba005
            
            #add-point:AFTER FIELD imba005 name="construct.a.imba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba006
            #add-point:ON ACTION controlp INFIELD imba006 name="construct.c.imba006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba006  #顯示到畫面上

            NEXT FIELD imba006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba006
            #add-point:BEFORE FIELD imba006 name="construct.b.imba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba006
            
            #add-point:AFTER FIELD imba006 name="construct.a.imba006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba010
            #add-point:ON ACTION controlp INFIELD imba010 name="construct.c.imba010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba010  #顯示到畫面上

            NEXT FIELD imba010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba010
            #add-point:BEFORE FIELD imba010 name="construct.b.imba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba010
            
            #add-point:AFTER FIELD imba010 name="construct.a.imba010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn011
            #add-point:ON ACTION controlp INFIELD imbn011 name="construct.c.imbn011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "229"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbn011  #顯示到畫面上
            NEXT FIELD imbn011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn011
            #add-point:BEFORE FIELD imbn011 name="construct.b.imbn011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn011
            
            #add-point:AFTER FIELD imbn011 name="construct.a.imbn011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn012
            #add-point:BEFORE FIELD imbn012 name="construct.b.imbn012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn012
            
            #add-point:AFTER FIELD imbn012 name="construct.a.imbn012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn012
            #add-point:ON ACTION controlp INFIELD imbn012 name="construct.c.imbn012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn013
            #add-point:BEFORE FIELD imbn013 name="construct.b.imbn013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn013
            
            #add-point:AFTER FIELD imbn013 name="construct.a.imbn013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn013
            #add-point:ON ACTION controlp INFIELD imbn013 name="construct.c.imbn013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn014
            #add-point:BEFORE FIELD imbn014 name="construct.b.imbn014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn014
            
            #add-point:AFTER FIELD imbn014 name="construct.a.imbn014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn014
            #add-point:ON ACTION controlp INFIELD imbn014 name="construct.c.imbn014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imbnownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbnownid
            #add-point:ON ACTION controlp INFIELD imbnownid name="construct.c.imbnownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbnownid  #顯示到畫面上

            NEXT FIELD imbnownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbnownid
            #add-point:BEFORE FIELD imbnownid name="construct.b.imbnownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbnownid
            
            #add-point:AFTER FIELD imbnownid name="construct.a.imbnownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbnowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbnowndp
            #add-point:ON ACTION controlp INFIELD imbnowndp name="construct.c.imbnowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbnowndp  #顯示到畫面上

            NEXT FIELD imbnowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbnowndp
            #add-point:BEFORE FIELD imbnowndp name="construct.b.imbnowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbnowndp
            
            #add-point:AFTER FIELD imbnowndp name="construct.a.imbnowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbncrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbncrtid
            #add-point:ON ACTION controlp INFIELD imbncrtid name="construct.c.imbncrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbncrtid  #顯示到畫面上

            NEXT FIELD imbncrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbncrtid
            #add-point:BEFORE FIELD imbncrtid name="construct.b.imbncrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbncrtid
            
            #add-point:AFTER FIELD imbncrtid name="construct.a.imbncrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbncrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbncrtdp
            #add-point:ON ACTION controlp INFIELD imbncrtdp name="construct.c.imbncrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbncrtdp  #顯示到畫面上

            NEXT FIELD imbncrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbncrtdp
            #add-point:BEFORE FIELD imbncrtdp name="construct.b.imbncrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbncrtdp
            
            #add-point:AFTER FIELD imbncrtdp name="construct.a.imbncrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbncrtdt
            #add-point:BEFORE FIELD imbncrtdt name="construct.b.imbncrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imbnmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbnmodid
            #add-point:ON ACTION controlp INFIELD imbnmodid name="construct.c.imbnmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbnmodid  #顯示到畫面上

            NEXT FIELD imbnmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbnmodid
            #add-point:BEFORE FIELD imbnmodid name="construct.b.imbnmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbnmodid
            
            #add-point:AFTER FIELD imbnmodid name="construct.a.imbnmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbnmoddt
            #add-point:BEFORE FIELD imbnmoddt name="construct.b.imbnmoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn021
            #add-point:BEFORE FIELD imbn021 name="construct.b.imbn021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn021
            
            #add-point:AFTER FIELD imbn021 name="construct.a.imbn021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn021
            #add-point:ON ACTION controlp INFIELD imbn021 name="construct.c.imbn021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn022
            #add-point:BEFORE FIELD imbn022 name="construct.b.imbn022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn022
            
            #add-point:AFTER FIELD imbn022 name="construct.a.imbn022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn022
            #add-point:ON ACTION controlp INFIELD imbn022 name="construct.c.imbn022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn023
            #add-point:BEFORE FIELD imbn023 name="construct.b.imbn023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn023
            
            #add-point:AFTER FIELD imbn023 name="construct.a.imbn023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn023
            #add-point:ON ACTION controlp INFIELD imbn023 name="construct.c.imbn023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn024
            #add-point:BEFORE FIELD imbn024 name="construct.b.imbn024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn024
            
            #add-point:AFTER FIELD imbn024 name="construct.a.imbn024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn024
            #add-point:ON ACTION controlp INFIELD imbn024 name="construct.c.imbn024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn025
            #add-point:BEFORE FIELD imbn025 name="construct.b.imbn025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn025
            
            #add-point:AFTER FIELD imbn025 name="construct.a.imbn025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn025
            #add-point:ON ACTION controlp INFIELD imbn025 name="construct.c.imbn025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn031
            #add-point:BEFORE FIELD imbn031 name="construct.b.imbn031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn031
            
            #add-point:AFTER FIELD imbn031 name="construct.a.imbn031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn031
            #add-point:ON ACTION controlp INFIELD imbn031 name="construct.c.imbn031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn032
            #add-point:BEFORE FIELD imbn032 name="construct.b.imbn032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn032
            
            #add-point:AFTER FIELD imbn032 name="construct.a.imbn032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn032
            #add-point:ON ACTION controlp INFIELD imbn032 name="construct.c.imbn032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn033
            #add-point:BEFORE FIELD imbn033 name="construct.b.imbn033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn033
            
            #add-point:AFTER FIELD imbn033 name="construct.a.imbn033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn033
            #add-point:ON ACTION controlp INFIELD imbn033 name="construct.c.imbn033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn034
            #add-point:BEFORE FIELD imbn034 name="construct.b.imbn034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn034
            
            #add-point:AFTER FIELD imbn034 name="construct.a.imbn034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbn034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn034
            #add-point:ON ACTION controlp INFIELD imbn034 name="construct.c.imbn034"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="aimt310.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimt310_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON imbndocno,imbn011
                          FROM s_browse[1].b_imbndocno,s_browse[1].b_imbn011
 
         BEFORE CONSTRUCT
               DISPLAY aimt310_filter_parser('imbndocno') TO s_browse[1].b_imbndocno
            DISPLAY aimt310_filter_parser('imbn011') TO s_browse[1].b_imbn011
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
 
      CALL aimt310_filter_show('imbndocno')
   CALL aimt310_filter_show('imbn011')
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimt310_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{</section>}
 
{<section id="aimt310.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimt310_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aimt310_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimt310_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_imbn_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimt310_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimt310_browser_fill(g_wc,"F")
      CALL aimt310_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimt310_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aimt310_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimt310.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimt310_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_imbn_m.imbndocno = g_browser[g_current_idx].b_imbndocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimt310_master_referesh USING g_site,g_imbn_m.imbndocno INTO g_imbn_m.imbndocno,g_imbn_m.imbn011, 
       g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnowndp,g_imbn_m.imbncrtid, 
       g_imbn_m.imbncrtdp,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmoddt,g_imbn_m.imbn021, 
       g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031,g_imbn_m.imbn032, 
       g_imbn_m.imbn033,g_imbn_m.imbn034,g_imbn_m.imbn011_desc,g_imbn_m.imbnownid_desc,g_imbn_m.imbnowndp_desc, 
       g_imbn_m.imbncrtid_desc,g_imbn_m.imbncrtdp_desc,g_imbn_m.imbnmodid_desc
   
   #遮罩相關處理
   LET g_imbn_m_mask_o.* =  g_imbn_m.*
   CALL aimt310_imbn_t_mask()
   LET g_imbn_m_mask_n.* =  g_imbn_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimt310_set_act_visible()
   CALL aimt310_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   SELECT imbastus INTO g_imbn_m.status
     FROM imba_t
    WHERE imbaent = g_enterprise
      AND imbadocno = g_imbn_m.imbndocno
   CALL cl_set_act_visible("modify,query",TRUE)
   IF g_imbn_m.status != 'N' THEN
      CALL cl_set_act_visible("modify",FALSE)
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("query",FALSE)
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imbn_m_t.* = g_imbn_m.*
   LET g_imbn_m_o.* = g_imbn_m.*
   
   LET g_data_owner = g_imbn_m.imbnownid      
   LET g_data_dept  = g_imbn_m.imbnowndp
   
   #重新顯示
   CALL aimt310_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimt310_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imbn_m.* TO NULL             #DEFAULT 設定
   LET g_imbndocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imbn_m.imbnownid = g_user
      LET g_imbn_m.imbnowndp = g_dept
      LET g_imbn_m.imbncrtid = g_user
      LET g_imbn_m.imbncrtdp = g_dept 
      LET g_imbn_m.imbncrtdt = cl_get_current()
      LET g_imbn_m.imbnmodid = g_user
      LET g_imbn_m.imbnmoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imbn_m.imba000 = "I"
      LET g_imbn_m.imba004 = "M"
      LET g_imbn_m.status = "N"
      LET g_imbn_m.imbn012 = "N"
      LET g_imbn_m.imbn022 = "0"
      LET g_imbn_m.imbn024 = "0"
      LET g_imbn_m.imbn025 = "0"
      LET g_imbn_m.imbn031 = "0"
      LET g_imbn_m.imbn034 = "N"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL aimt310_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imbn_m.* TO NULL
         CALL aimt310_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimt310_set_act_visible()
   CALL aimt310_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imbndocno_t = g_imbn_m.imbndocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbnent = " ||g_enterprise|| " AND imbnsite = '" ||g_site|| "' AND",
                      " imbndocno = '", g_imbn_m.imbndocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimt310_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimt310_master_referesh USING g_site,g_imbn_m.imbndocno INTO g_imbn_m.imbndocno,g_imbn_m.imbn011, 
       g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnowndp,g_imbn_m.imbncrtid, 
       g_imbn_m.imbncrtdp,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmoddt,g_imbn_m.imbn021, 
       g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031,g_imbn_m.imbn032, 
       g_imbn_m.imbn033,g_imbn_m.imbn034,g_imbn_m.imbn011_desc,g_imbn_m.imbnownid_desc,g_imbn_m.imbnowndp_desc, 
       g_imbn_m.imbncrtid_desc,g_imbn_m.imbncrtdp_desc,g_imbn_m.imbnmodid_desc
   
   
   #遮罩相關處理
   LET g_imbn_m_mask_o.* =  g_imbn_m.*
   CALL aimt310_imbn_t_mask()
   LET g_imbn_m_mask_n.* =  g_imbn_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imbn_m.imbndocno,g_imbn_m.imbadocdt,g_imbn_m.imba900,g_imbn_m.imba900_desc,g_imbn_m.oobxl003, 
       g_imbn_m.imba000,g_imbn_m.imba901,g_imbn_m.imba901_desc,g_imbn_m.imba001,g_imbn_m.imba002,g_imbn_m.imbal002, 
       g_imbn_m.imbal003,g_imbn_m.imbal004,g_imbn_m.imba009,g_imbn_m.imba009_desc,g_imbn_m.imba003,g_imbn_m.imba003_desc, 
       g_imbn_m.imba004,g_imbn_m.imba005,g_imbn_m.imba005_desc,g_imbn_m.imba006,g_imbn_m.imba006_desc, 
       g_imbn_m.imba010,g_imbn_m.imba010_desc,g_imbn_m.status,g_imbn_m.imbn011,g_imbn_m.imbn011_desc, 
       g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnownid_desc, 
       g_imbn_m.imbnowndp,g_imbn_m.imbnowndp_desc,g_imbn_m.imbncrtid,g_imbn_m.imbncrtid_desc,g_imbn_m.imbncrtdp, 
       g_imbn_m.imbncrtdp_desc,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmodid_desc,g_imbn_m.imbnmoddt, 
       g_imbn_m.imbn021,g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031, 
       g_imbn_m.imbn032,g_imbn_m.imbn033,g_imbn_m.imbn034
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_imbn_m.imbnownid      
   LET g_data_dept  = g_imbn_m.imbnowndp
 
   #功能已完成,通報訊息中心
   CALL aimt310_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimt310.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimt310_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imbn_m.imbndocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_imbndocno_t = g_imbn_m.imbndocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimt310_cl USING g_enterprise, g_site,g_imbn_m.imbndocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimt310_master_referesh USING g_site,g_imbn_m.imbndocno INTO g_imbn_m.imbndocno,g_imbn_m.imbn011, 
       g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnowndp,g_imbn_m.imbncrtid, 
       g_imbn_m.imbncrtdp,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmoddt,g_imbn_m.imbn021, 
       g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031,g_imbn_m.imbn032, 
       g_imbn_m.imbn033,g_imbn_m.imbn034,g_imbn_m.imbn011_desc,g_imbn_m.imbnownid_desc,g_imbn_m.imbnowndp_desc, 
       g_imbn_m.imbncrtid_desc,g_imbn_m.imbncrtdp_desc,g_imbn_m.imbnmodid_desc
 
   #檢查是否允許此動作
   IF NOT aimt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imbn_m_mask_o.* =  g_imbn_m.*
   CALL aimt310_imbn_t_mask()
   LET g_imbn_m_mask_n.* =  g_imbn_m.*
   
   
 
   #顯示資料
   CALL aimt310_show()
   
   WHILE TRUE
      LET g_imbn_m.imbndocno = g_imbndocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imbn_m.imbnmodid = g_user 
LET g_imbn_m.imbnmoddt = cl_get_current()
LET g_imbn_m.imbnmodid_desc = cl_get_username(g_imbn_m.imbnmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aimt310_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imbn_m.* = g_imbn_m_t.*
         CALL aimt310_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imbn_t SET (imbnmodid,imbnmoddt) = (g_imbn_m.imbnmodid,g_imbn_m.imbnmoddt)
       WHERE imbnent = g_enterprise AND imbnsite = g_site AND imbndocno = g_imbndocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimt310_set_act_visible()
   CALL aimt310_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imbnent = " ||g_enterprise|| " AND imbnsite = '" ||g_site|| "' AND",
                      " imbndocno = '", g_imbn_m.imbndocno, "' "
 
   #填到對應位置
   CALL aimt310_browser_fill(g_wc,"")
 
   CLOSE aimt310_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimt310_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimt310.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimt310_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
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
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imbn_m.imbndocno,g_imbn_m.imbadocdt,g_imbn_m.imba900,g_imbn_m.imba900_desc,g_imbn_m.oobxl003, 
       g_imbn_m.imba000,g_imbn_m.imba901,g_imbn_m.imba901_desc,g_imbn_m.imba001,g_imbn_m.imba002,g_imbn_m.imbal002, 
       g_imbn_m.imbal003,g_imbn_m.imbal004,g_imbn_m.imba009,g_imbn_m.imba009_desc,g_imbn_m.imba003,g_imbn_m.imba003_desc, 
       g_imbn_m.imba004,g_imbn_m.imba005,g_imbn_m.imba005_desc,g_imbn_m.imba006,g_imbn_m.imba006_desc, 
       g_imbn_m.imba010,g_imbn_m.imba010_desc,g_imbn_m.status,g_imbn_m.imbn011,g_imbn_m.imbn011_desc, 
       g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnownid_desc, 
       g_imbn_m.imbnowndp,g_imbn_m.imbnowndp_desc,g_imbn_m.imbncrtid,g_imbn_m.imbncrtid_desc,g_imbn_m.imbncrtdp, 
       g_imbn_m.imbncrtdp_desc,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmodid_desc,g_imbn_m.imbnmoddt, 
       g_imbn_m.imbn021,g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031, 
       g_imbn_m.imbn032,g_imbn_m.imbn033,g_imbn_m.imbn034
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL aimt310_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimt310_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imbn_m.imba002,g_imbn_m.imbal002,g_imbn_m.imbal003,g_imbn_m.imbal004,g_imbn_m.imbn011, 
          g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbn021,g_imbn_m.imbn022,g_imbn_m.imbn023, 
          g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031,g_imbn_m.imbn032,g_imbn_m.imbn033,g_imbn_m.imbn034  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.imbaldocno = g_imbn_m.imbndocno
LET g_master_multi_table_t.imbal002 = g_imbn_m.imbal002
LET g_master_multi_table_t.imbal003 = g_imbn_m.imbal003
LET g_master_multi_table_t.imbal004 = g_imbn_m.imbal004
 
            #add-point:input開始前 name="input.before.input"
            IF cl_null(g_imbn_m.imbn012) THEN
               LET g_imbn_m.imbn012 = "N"
            END IF
            IF cl_null(g_imbn_m.imbn022) THEN
               LET g_imbn_m.imbn022 = "0"
            END IF
            IF cl_null(g_imbn_m.imbn024) THEN
               LET g_imbn_m.imbn024 = "0"
            END IF
            IF cl_null(g_imbn_m.imbn025) THEN
               LET g_imbn_m.imbn025 = "0"
            END IF
            IF cl_null(g_imbn_m.imbn031) THEN
               LET g_imbn_m.imbn031 = "0"
            END IF
            IF cl_null(g_imbn_m.imbn034) THEN
               LET g_imbn_m.imbn034 = "N"
            END IF
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba002
            #add-point:BEFORE FIELD imba002 name="input.b.imba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba002
            
            #add-point:AFTER FIELD imba002 name="input.a.imba002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba002
            #add-point:ON CHANGE imba002 name="input.g.imba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal002
            #add-point:BEFORE FIELD imbal002 name="input.b.imbal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal002
            
            #add-point:AFTER FIELD imbal002 name="input.a.imbal002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal002
            #add-point:ON CHANGE imbal002 name="input.g.imbal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal003
            #add-point:BEFORE FIELD imbal003 name="input.b.imbal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal003
            
            #add-point:AFTER FIELD imbal003 name="input.a.imbal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal003
            #add-point:ON CHANGE imbal003 name="input.g.imbal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal004
            #add-point:BEFORE FIELD imbal004 name="input.b.imbal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal004
            
            #add-point:AFTER FIELD imbal004 name="input.a.imbal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal004
            #add-point:ON CHANGE imbal004 name="input.g.imbal004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn011
            
            #add-point:AFTER FIELD imbn011 name="input.a.imbn011"
            DISPLAY "" TO imbn011_desc
            IF NOT cl_null(g_imbn_m.imbn011) THEN
               IF g_imbn_m.imbn011 != g_imbn_m_o.imbn011 OR cl_null(g_imbn_m_o.imbn011) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_imbn_m.imbn011
                  IF g_site = 'ALL' THEN
                     #160318-00025#18  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00221:sub-01302|aimi107|",cl_get_progname("aimi107",g_lang,"2"),"|:EXEPROGaimi107"
                     #160318-00025#18  by 07900 --add-end
                     CALL cl_chk_exist("v_imcp011") RETURNING l_success
                  ELSE
                     CALL s_azzi650_chk_exist('229',g_imbn_m.imbn011) RETURNING l_success
                  END IF
                  IF NOT l_success THEN
                     LET g_imbn_m.imbn011 = g_imbn_m_o.imbn011
                     CALL s_desc_get_acc_desc('229',g_imbn_m.imbn011) RETURNING g_imbn_m.imbn011_desc
                     DISPLAY BY NAME g_imbn_m.imbn011_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM imcp_t
                   WHERE imcp011 = g_imbn_m.imbn011
                     AND imcpent = g_enterprise
                     AND imcpsite = g_site
                     AND imcpstus = 'Y'
                  IF l_cnt > 0 THEN
                     IF cl_ask_confirm('aim-00120') THEN
                        CALL aimt310_get_imcp()
                     END IF
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('229',g_imbn_m.imbn011) RETURNING g_imbn_m.imbn011_desc
            DISPLAY BY NAME g_imbn_m.imbn011_desc
            LET g_imbn_m_o.imbn011 = g_imbn_m.imbn011
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn011
            #add-point:BEFORE FIELD imbn011 name="input.b.imbn011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn011
            #add-point:ON CHANGE imbn011 name="input.g.imbn011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn012
            #add-point:BEFORE FIELD imbn012 name="input.b.imbn012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn012
            
            #add-point:AFTER FIELD imbn012 name="input.a.imbn012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn012
            #add-point:ON CHANGE imbn012 name="input.g.imbn012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn013
            #add-point:BEFORE FIELD imbn013 name="input.b.imbn013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn013
            
            #add-point:AFTER FIELD imbn013 name="input.a.imbn013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn013
            #add-point:ON CHANGE imbn013 name="input.g.imbn013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn014
            #add-point:BEFORE FIELD imbn014 name="input.b.imbn014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn014
            
            #add-point:AFTER FIELD imbn014 name="input.a.imbn014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn014
            #add-point:ON CHANGE imbn014 name="input.g.imbn014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn021
            #add-point:BEFORE FIELD imbn021 name="input.b.imbn021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn021
            
            #add-point:AFTER FIELD imbn021 name="input.a.imbn021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn021
            #add-point:ON CHANGE imbn021 name="input.g.imbn021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imbn_m.imbn022,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD imbn022
            END IF 
 
 
 
            #add-point:AFTER FIELD imbn022 name="input.a.imbn022"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn022
            #add-point:BEFORE FIELD imbn022 name="input.b.imbn022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn022
            #add-point:ON CHANGE imbn022 name="input.g.imbn022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn023
            #add-point:BEFORE FIELD imbn023 name="input.b.imbn023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn023
            
            #add-point:AFTER FIELD imbn023 name="input.a.imbn023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn023
            #add-point:ON CHANGE imbn023 name="input.g.imbn023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imbn_m.imbn024,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD imbn024
            END IF 
 
 
 
            #add-point:AFTER FIELD imbn024 name="input.a.imbn024"
            IF NOT cl_null(g_imbn_m.imbn024) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn024
            #add-point:BEFORE FIELD imbn024 name="input.b.imbn024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn024
            #add-point:ON CHANGE imbn024 name="input.g.imbn024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imbn_m.imbn025,"0","1","","","azz-00079",1) THEN
               NEXT FIELD imbn025
            END IF 
 
 
 
            #add-point:AFTER FIELD imbn025 name="input.a.imbn025"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn025
            #add-point:BEFORE FIELD imbn025 name="input.b.imbn025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn025
            #add-point:ON CHANGE imbn025 name="input.g.imbn025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imbn_m.imbn031,"0","1","","","azz-00079",1) THEN
               NEXT FIELD imbn031
            END IF 
 
 
 
            #add-point:AFTER FIELD imbn031 name="input.a.imbn031"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn031
            #add-point:BEFORE FIELD imbn031 name="input.b.imbn031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn031
            #add-point:ON CHANGE imbn031 name="input.g.imbn031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn032
            #add-point:BEFORE FIELD imbn032 name="input.b.imbn032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn032
            
            #add-point:AFTER FIELD imbn032 name="input.a.imbn032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn032
            #add-point:ON CHANGE imbn032 name="input.g.imbn032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn033
            #add-point:BEFORE FIELD imbn033 name="input.b.imbn033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn033
            
            #add-point:AFTER FIELD imbn033 name="input.a.imbn033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn033
            #add-point:ON CHANGE imbn033 name="input.g.imbn033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbn034
            #add-point:BEFORE FIELD imbn034 name="input.b.imbn034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbn034
            
            #add-point:AFTER FIELD imbn034 name="input.a.imbn034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbn034
            #add-point:ON CHANGE imbn034 name="input.g.imbn034"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba002
            #add-point:ON ACTION controlp INFIELD imba002 name="input.c.imba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal002
            #add-point:ON ACTION controlp INFIELD imbal002 name="input.c.imbal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal003
            #add-point:ON ACTION controlp INFIELD imbal003 name="input.c.imbal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal004
            #add-point:ON ACTION controlp INFIELD imbal004 name="input.c.imbal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn011
            #add-point:ON ACTION controlp INFIELD imbn011 name="input.c.imbn011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imbn_m.imbn011       #給予default值
            LET g_qryparam.default2 = g_imbn_m.imbn011_desc  #說明
            LET g_qryparam.arg1 = "229"
            CALL q_oocq002()                                 #呼叫開窗
            LET g_imbn_m.imbn011 = g_qryparam.return1
            LET g_imbn_m.imbn011_desc = g_qryparam.return2
            DISPLAY g_imbn_m.imbn011 TO imbn011
            DISPLAY g_imbn_m.imbn011_desc TO imbn011_desc
            NEXT FIELD imbn011                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imbn012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn012
            #add-point:ON ACTION controlp INFIELD imbn012 name="input.c.imbn012"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn013
            #add-point:ON ACTION controlp INFIELD imbn013 name="input.c.imbn013"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn014
            #add-point:ON ACTION controlp INFIELD imbn014 name="input.c.imbn014"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn021
            #add-point:ON ACTION controlp INFIELD imbn021 name="input.c.imbn021"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn022
            #add-point:ON ACTION controlp INFIELD imbn022 name="input.c.imbn022"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn023
            #add-point:ON ACTION controlp INFIELD imbn023 name="input.c.imbn023"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn024
            #add-point:ON ACTION controlp INFIELD imbn024 name="input.c.imbn024"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn025
            #add-point:ON ACTION controlp INFIELD imbn025 name="input.c.imbn025"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn031
            #add-point:ON ACTION controlp INFIELD imbn031 name="input.c.imbn031"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn032
            #add-point:ON ACTION controlp INFIELD imbn032 name="input.c.imbn032"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn033
            #add-point:ON ACTION controlp INFIELD imbn033 name="input.c.imbn033"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbn034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbn034
            #add-point:ON ACTION controlp INFIELD imbn034 name="input.c.imbn034"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM imbn_t
                WHERE imbnent = g_enterprise AND imbnsite = g_site AND imbndocno = g_imbn_m.imbndocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imbn_t (imbnent, imbnsite,imbndocno,imbn011,imbn012,imbn013,imbn014,imbnownid, 
                      imbnowndp,imbncrtid,imbncrtdp,imbncrtdt,imbnmodid,imbnmoddt,imbn021,imbn022,imbn023, 
                      imbn024,imbn025,imbn031,imbn032,imbn033,imbn034)
                  VALUES (g_enterprise, g_site,g_imbn_m.imbndocno,g_imbn_m.imbn011,g_imbn_m.imbn012, 
                      g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnowndp,g_imbn_m.imbncrtid, 
                      g_imbn_m.imbncrtdp,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmoddt,g_imbn_m.imbn021, 
                      g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031, 
                      g_imbn_m.imbn032,g_imbn_m.imbn033,g_imbn_m.imbn034) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imbn_m.imbndocno = g_master_multi_table_t.imbaldocno AND
         g_imbn_m.imbal002 = g_master_multi_table_t.imbal002 AND 
         g_imbn_m.imbal003 = g_master_multi_table_t.imbal003 AND 
         g_imbn_m.imbal004 = g_master_multi_table_t.imbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imbn_m.imbndocno
            LET l_field_keys[02] = 'imbaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imbal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imbn_m.imbal002
            LET l_fields[01] = 'imbal002'
            LET l_vars[02] = g_imbn_m.imbal003
            LET l_fields[02] = 'imbal003'
            LET l_vars[03] = g_imbn_m.imbal004
            LET l_fields[03] = 'imbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imbal_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imbn_m.imbndocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aimt310_imbn_t_mask_restore('restore_mask_o')
               
               UPDATE imbn_t SET (imbndocno,imbn011,imbn012,imbn013,imbn014,imbnownid,imbnowndp,imbncrtid, 
                   imbncrtdp,imbncrtdt,imbnmodid,imbnmoddt,imbn021,imbn022,imbn023,imbn024,imbn025,imbn031, 
                   imbn032,imbn033,imbn034) = (g_imbn_m.imbndocno,g_imbn_m.imbn011,g_imbn_m.imbn012, 
                   g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnowndp,g_imbn_m.imbncrtid, 
                   g_imbn_m.imbncrtdp,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmoddt,g_imbn_m.imbn021, 
                   g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031, 
                   g_imbn_m.imbn032,g_imbn_m.imbn033,g_imbn_m.imbn034)
                WHERE imbnent = g_enterprise AND imbnsite = g_site AND imbndocno = g_imbndocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imbn_m.imbndocno = g_master_multi_table_t.imbaldocno AND
         g_imbn_m.imbal002 = g_master_multi_table_t.imbal002 AND 
         g_imbn_m.imbal003 = g_master_multi_table_t.imbal003 AND 
         g_imbn_m.imbal004 = g_master_multi_table_t.imbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imbn_m.imbndocno
            LET l_field_keys[02] = 'imbaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imbal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imbn_m.imbal002
            LET l_fields[01] = 'imbal002'
            LET l_vars[02] = g_imbn_m.imbal003
            LET l_fields[02] = 'imbal003'
            LET l_vars[03] = g_imbn_m.imbal004
            LET l_fields[03] = 'imbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imbal_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimt310_imbn_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imbn_m_t)
                     LET g_log2 = util.JSON.stringify(g_imbn_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
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
         
      #放棄輸入
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
 
{<section id="aimt310.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimt310_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imbn_t.imbndocno 
   DEFINE l_oldno     LIKE imbn_t.imbndocno 
 
   DEFINE l_master    RECORD LIKE imbn_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_imbn_m.imbndocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imbndocno_t = g_imbn_m.imbndocno
 
   
   #清空key值
   LET g_imbn_m.imbndocno = ""
 
    
   CALL aimt310_set_entry("a")
   CALL aimt310_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imbn_m.imbnownid = g_user
      LET g_imbn_m.imbnowndp = g_dept
      LET g_imbn_m.imbncrtid = g_user
      LET g_imbn_m.imbncrtdp = g_dept 
      LET g_imbn_m.imbncrtdt = cl_get_current()
      LET g_imbn_m.imbnmodid = g_user
      LET g_imbn_m.imbnmoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aimt310_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imbn_m.* TO NULL
      CALL aimt310_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "imbn_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimt310_set_act_visible()
   CALL aimt310_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imbndocno_t = g_imbn_m.imbndocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbnent = " ||g_enterprise|| " AND imbnsite = '" ||g_site|| "' AND",
                      " imbndocno = '", g_imbn_m.imbndocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimt310_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imbn_m.imbnownid      
   LET g_data_dept  = g_imbn_m.imbnowndp
              
   #功能已完成,通報訊息中心
   CALL aimt310_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimt310_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
 
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimt310_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   SELECT imbadocdt,imba900,ooag011,imba000,imba901,
          ooefl003,imba001,imba002,imbal002,imbal003,
          imbal004,imba009,rtaxl003,imba003,a.oocql004, 
          imba004,imba005,imeal003,imba006,oocal003, 
          imba010,b.oocql004
     INTO g_imbn_m.imbadocdt,g_imbn_m.imba900,g_imbn_m.imba900_desc,g_imbn_m.imba000,g_imbn_m.imba901,
          g_imbn_m.imba901_desc,g_imbn_m.imba001,g_imbn_m.imba002,g_imbn_m.imbal002,g_imbn_m.imbal003,
          g_imbn_m.imbal004,g_imbn_m.imba009,g_imbn_m.imba009_desc,g_imbn_m.imba003,g_imbn_m.imba003_desc,
          g_imbn_m.imba004,g_imbn_m.imba005,g_imbn_m.imba005_desc,g_imbn_m.imba006,g_imbn_m.imba006_desc, 
          g_imbn_m.imba010,g_imbn_m.imba010_desc
     FROM imba_t
     LEFT JOIN ooag_t ON ooagent = imbaent AND ooag001 = imba900
     LEFT JOIN ooefl_t ON ooeflent = imbaent AND ooefl001 = imba901 AND ooefl002 = g_lang
     LEFT JOIN imbal_t ON imbalent = imbaent AND imbaldocno = imbadocno AND imbal001 = g_lang
     LEFT JOIN rtaxl_t ON rtaxlent = imbaent AND rtaxl001 = imba009 AND rtaxl002 = g_lang
     LEFT JOIN oocql_t a ON a.oocqlent = imbaent AND a.oocql001='200' AND a.oocql002 = imba003 AND a.oocql003 = g_lang
     LEFT JOIN imeal_t ON imealent = imbaent AND imeal001 = imba005 AND imeal002 = g_lang
     LEFT JOIN oocal_t ON oocalent = imbaent AND oocal001 = imba006 AND oocal002 = g_lang
     LEFT JOIN oocql_t b ON b.oocqlent = imbaent AND b.oocql001='210' AND b.oocql002 = imba010 AND b.oocql003 = g_lang
    WHERE imbadocno = g_imbn_m.imbndocno
      AND imbaent = g_enterprise
   
   CALL s_aooi200_get_slip_desc(g_imbn_m.imbndocno) RETURNING g_imbn_m.oobxl003

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imbn_m.imbndocno,g_imbn_m.imbadocdt,g_imbn_m.imba900,g_imbn_m.imba900_desc,g_imbn_m.oobxl003, 
       g_imbn_m.imba000,g_imbn_m.imba901,g_imbn_m.imba901_desc,g_imbn_m.imba001,g_imbn_m.imba002,g_imbn_m.imbal002, 
       g_imbn_m.imbal003,g_imbn_m.imbal004,g_imbn_m.imba009,g_imbn_m.imba009_desc,g_imbn_m.imba003,g_imbn_m.imba003_desc, 
       g_imbn_m.imba004,g_imbn_m.imba005,g_imbn_m.imba005_desc,g_imbn_m.imba006,g_imbn_m.imba006_desc, 
       g_imbn_m.imba010,g_imbn_m.imba010_desc,g_imbn_m.status,g_imbn_m.imbn011,g_imbn_m.imbn011_desc, 
       g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnownid_desc, 
       g_imbn_m.imbnowndp,g_imbn_m.imbnowndp_desc,g_imbn_m.imbncrtid,g_imbn_m.imbncrtid_desc,g_imbn_m.imbncrtdp, 
       g_imbn_m.imbncrtdp_desc,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmodid_desc,g_imbn_m.imbnmoddt, 
       g_imbn_m.imbn021,g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031, 
       g_imbn_m.imbn032,g_imbn_m.imbn033,g_imbn_m.imbn034
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimt310_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimt310_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
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
   
   #先確定key值無遺漏
   IF g_imbn_m.imbndocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imbndocno_t = g_imbn_m.imbndocno
 
   
   LET g_master_multi_table_t.imbaldocno = g_imbn_m.imbndocno
LET g_master_multi_table_t.imbal002 = g_imbn_m.imbal002
LET g_master_multi_table_t.imbal003 = g_imbn_m.imbal003
LET g_master_multi_table_t.imbal004 = g_imbn_m.imbal004
 
 
   OPEN aimt310_cl USING g_enterprise, g_site,g_imbn_m.imbndocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimt310_master_referesh USING g_site,g_imbn_m.imbndocno INTO g_imbn_m.imbndocno,g_imbn_m.imbn011, 
       g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,g_imbn_m.imbnownid,g_imbn_m.imbnowndp,g_imbn_m.imbncrtid, 
       g_imbn_m.imbncrtdp,g_imbn_m.imbncrtdt,g_imbn_m.imbnmodid,g_imbn_m.imbnmoddt,g_imbn_m.imbn021, 
       g_imbn_m.imbn022,g_imbn_m.imbn023,g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031,g_imbn_m.imbn032, 
       g_imbn_m.imbn033,g_imbn_m.imbn034,g_imbn_m.imbn011_desc,g_imbn_m.imbnownid_desc,g_imbn_m.imbnowndp_desc, 
       g_imbn_m.imbncrtid_desc,g_imbn_m.imbncrtdp_desc,g_imbn_m.imbnmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aimt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imbn_m_mask_o.* =  g_imbn_m.*
   CALL aimt310_imbn_t_mask()
   LET g_imbn_m_mask_n.* =  g_imbn_m.*
   
   #將最新資料顯示到畫面上
   CALL aimt310_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimt310_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imbn_t 
       WHERE imbnent = g_enterprise AND imbnsite = g_site AND imbndocno = g_imbn_m.imbndocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'imbalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
   LET l_field_keys[02] = 'imbaldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imbal_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imbn_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimt310_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimt310_browser_fill(g_wc,"")
         CALL aimt310_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimt310_cl
 
   #功能已完成,通報訊息中心
   CALL aimt310_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimt310_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_imbndocno = g_imbn_m.imbndocno
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="aimt310.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimt310_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imbndocno",TRUE)
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
 
{<section id="aimt310.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimt310_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imbndocno",FALSE)
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
 
{<section id="aimt310.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimt310_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimt310.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimt310_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimt310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimt310_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
 
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " imbndocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_wc  = " imbnsite = '",g_argv[1],"' "
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc  = g_wc," AND imbndocno = '",g_argv[02],"' "
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimt310.mask_functions" >}
&include "erp/aim/aimt310_mask.4gl"
 
{</section>}
 
{<section id="aimt310.state_change" >}
   
 
{</section>}
 
{<section id="aimt310.signature" >}
   
 
{</section>}
 
{<section id="aimt310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimt310_set_pk_array()
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
   LET g_pk_array[1].values = g_imbn_m.imbndocno
   LET g_pk_array[1].column = 'imbndocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt310.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimt310.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimt310_msgcentre_notify(lc_state)
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
   CALL aimt310_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imbn_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt310.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimt310_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimt310.other_function" readonly="Y" >}
################################################################################
# Descriptions...: aooi090有設定到的欄位就不用重帶
# Memo...........:
# Usage..........: CALL aimt310_chk_ooeh(p_ooeh002)
# Input parameter: 
# Return code....: 
# Date & Author..: 150729 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aimt310_chk_ooeh(p_ooeh002)
DEFINE p_ooeh002    LIKE ooeh_t.ooeh002
DEFINE l_n          LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooeh_t
    WHERE ooehent = g_enterprise
      AND ooeh001 = '5'
      AND ooeh002 = p_ooeh002
   IF l_n > 0 THEN
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 則依此分群重帶aimi110或aimi120(依營運據點)的資料
# Memo...........:
# Usage..........: CALL aimt310_get_imcp()
# Input parameter: 
# Return code....: 
# Date & Author..: 150729 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aimt310_get_imcp()
DEFINE l_imcp  RECORD
    imcp012	   LIKE imcp_t.imcp012,  #保稅否
    imcp013	   LIKE imcp_t.imcp013,  #保稅料件型態
    imcp014	   LIKE imcp_t.imcp014,  #保稅料區分
    imcp021	   LIKE imcp_t.imcp021,  #保稅統計類別
    imcp022	   LIKE imcp_t.imcp022,  #保稅年度盤差容許率
    imcp023	   LIKE imcp_t.imcp023,  #稅則編號
    imcp024	   LIKE imcp_t.imcp024,  #保稅應補稅稅率
    imcp025	   LIKE imcp_t.imcp025,  #保稅單價
    imcp031	   LIKE imcp_t.imcp031,  #推廣貿易服務費
    imcp032	   LIKE imcp_t.imcp032,  #稅則
    imcp033	   LIKE imcp_t.imcp033,  #帳卡編號
    imcp034	   LIKE imcp_t.imcp034   #受託加工成品
           END RECORD

   INITIALIZE l_imcp.* TO NULL
   SELECT COALESCE(imcp012,'N'),imcp013,imcp014,imcp021,COALESCE(imcp022,0),imcp023,
          COALESCE(imcp024,0),COALESCE(imcp025,0),COALESCE(imcp031,0),imcp032,imcp033,COALESCE(imcp034,0)
     INTO l_imcp.imcp012,l_imcp.imcp013,l_imcp.imcp014,
          l_imcp.imcp021,l_imcp.imcp022,l_imcp.imcp023,
          l_imcp.imcp024,l_imcp.imcp025,l_imcp.imcp031,
          l_imcp.imcp032,l_imcp.imcp033,l_imcp.imcp034
     FROM imcp_t
    WHERE imcpent = g_enterprise
      AND imcpsite = g_site
      AND imcp011 = g_imbn_m.imbn011
      AND imcpstus = 'Y'
   #集團層的不需要考慮aooi090,據點級的資料需aooi090設定的欄位
   IF g_site = 'ALL' THEN
      LET g_imbn_m.imbn012 = l_imcp.imcp012
      LET g_imbn_m.imbn013 = l_imcp.imcp013
      LET g_imbn_m.imbn014 = l_imcp.imcp014
      LET g_imbn_m.imbn021 = l_imcp.imcp021
      LET g_imbn_m.imbn022 = l_imcp.imcp022
      LET g_imbn_m.imbn023 = l_imcp.imcp023
      LET g_imbn_m.imbn024 = l_imcp.imcp024
      LET g_imbn_m.imbn025 = l_imcp.imcp025
      LET g_imbn_m.imbn031 = l_imcp.imcp031
      LET g_imbn_m.imbn032 = l_imcp.imcp032
      LET g_imbn_m.imbn033 = l_imcp.imcp033
      LET g_imbn_m.imbn034 = l_imcp.imcp034
   ELSE
      IF aimt310_chk_ooeh('imbn012') THEN
         LET g_imbn_m.imbn012 = l_imcp.imcp012
      END IF
      IF aimt310_chk_ooeh('imbn013') THEN
         LET g_imbn_m.imbn013 = l_imcp.imcp013
      END IF
      IF aimt310_chk_ooeh('imbn014') THEN
         LET g_imbn_m.imbn014 = l_imcp.imcp014
      END IF
      IF aimt310_chk_ooeh('imbn021') THEN
         LET g_imbn_m.imbn021 = l_imcp.imcp021
      END IF
      IF aimt310_chk_ooeh('imbn022') THEN
         LET g_imbn_m.imbn022 = l_imcp.imcp022
      END IF
      IF aimt310_chk_ooeh('imbn023') THEN
         LET g_imbn_m.imbn023 = l_imcp.imcp023
      END IF
      IF aimt310_chk_ooeh('imbn024') THEN
         LET g_imbn_m.imbn024 = l_imcp.imcp024
      END IF
      IF aimt310_chk_ooeh('imbn025') THEN
         LET g_imbn_m.imbn025 = l_imcp.imcp025
      END IF
      IF aimt310_chk_ooeh('imbn031') THEN
         LET g_imbn_m.imbn031 = l_imcp.imcp031
      END IF
      IF aimt310_chk_ooeh('imbn032') THEN
         LET g_imbn_m.imbn032 = l_imcp.imcp032
      END IF
      IF aimt310_chk_ooeh('imbn033') THEN
         LET g_imbn_m.imbn033 = l_imcp.imcp033
      END IF
      IF aimt310_chk_ooeh('imbn034') THEN
         LET g_imbn_m.imbn034 = l_imcp.imcp034
      END IF
   END IF

   DISPLAY BY NAME g_imbn_m.imbn012,g_imbn_m.imbn013,g_imbn_m.imbn014,
                   g_imbn_m.imbn021,g_imbn_m.imbn022,g_imbn_m.imbn023,
                   g_imbn_m.imbn024,g_imbn_m.imbn025,g_imbn_m.imbn031,
                   g_imbn_m.imbn032,g_imbn_m.imbn033,g_imbn_m.imbn034

END FUNCTION

 
{</section>}
 
