#該程式未解開Section, 採用最新樣板產出!
{<section id="aimt306.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-05-31 10:44:22), PR版次:0012(2017-02-20 11:36:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000335
#+ Filename...: aimt306
#+ Description: 料件申請品管資料維護作業
#+ Creator....: 02294(2013-07-17 15:40:56)
#+ Modifier...: 04441 -SD/PR- 08993
 
{</section>}
 
{<section id="aimt306.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#18   16/04/13  BY 07900   校验代码重复错误讯息的修改
#160705-00042#9    16/07/13  By sakura  程式中寫死g_prog部分改寫MATCHES方式
#161124-00048#3    16/12/08  By 08734   星号整批调整
#160824-00007#272  16/12/29  By 06137   修正舊值備份寫法
#170217-00068#2    17/02/20  By 08993   g_prog MATCHES '程式編號*'，修正漏寫*的問題
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
PRIVATE TYPE type_g_imbe_m RECORD
       imbedocno LIKE imbe_t.imbedocno, 
   fflabel1 LIKE type_t.chr80, 
   imbadocdt LIKE imba_t.imbadocdt, 
   fflabel3 LIKE type_t.chr80, 
   imba900 LIKE imba_t.imba900, 
   imba900_desc LIKE type_t.chr80, 
   imbedocno_desc LIKE type_t.chr80, 
   fflabel2 LIKE type_t.chr80, 
   imba000 LIKE imba_t.imba000, 
   fflabel4 LIKE type_t.chr80, 
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
   status1 LIKE type_t.chr500, 
   imbe111 LIKE imbe_t.imbe111, 
   imbe111_desc LIKE type_t.chr80, 
   imbe112 LIKE imbe_t.imbe112, 
   imbe112_desc LIKE type_t.chr80, 
   imbe113 LIKE imbe_t.imbe113, 
   imbe113_desc LIKE type_t.chr80, 
   imbe114 LIKE imbe_t.imbe114, 
   imbe115 LIKE imbe_t.imbe115, 
   imbe116 LIKE imbe_t.imbe116, 
   imbe117 LIKE imbe_t.imbe117, 
   imbe120 LIKE imbe_t.imbe120, 
   imbeownid LIKE imbe_t.imbeownid, 
   imbeownid_desc LIKE type_t.chr80, 
   imbeowndp LIKE imbe_t.imbeowndp, 
   imbeowndp_desc LIKE type_t.chr80, 
   imbecrtid LIKE imbe_t.imbecrtid, 
   imbecrtid_desc LIKE type_t.chr80, 
   imbecrtdp LIKE imbe_t.imbecrtdp, 
   imbecrtdp_desc LIKE type_t.chr80, 
   imbecrtdt LIKE imbe_t.imbecrtdt, 
   imbemodid LIKE imbe_t.imbemodid, 
   imbemodid_desc LIKE type_t.chr80, 
   imbemoddt LIKE imbe_t.imbemoddt, 
   imbe118 LIKE imbe_t.imbe118, 
   imbe119 LIKE imbe_t.imbe119
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
         b_imba000 LIKE imba_t.imba000,
      b_imbedocno LIKE imbe_t.imbedocno,
   b_imbadocdt LIKE imba_t.imbadocdt,
   b_imba001 LIKE imba_t.imba001,
   b_imbedocno_desc LIKE type_t.chr80,
   b_imbal003 LIKE imbal_t.imbal003,
   b_imba009 LIKE imba_t.imba009,
   b_imba009_desc LIKE type_t.chr80,
   b_imba003 LIKE imba_t.imba003,
   b_imba003_desc LIKE type_t.chr80,
      b_imbe111 LIKE imbe_t.imbe111,
   b_imbe111_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imbe_m        type_g_imbe_m  #單頭變數宣告
DEFINE g_imbe_m_t      type_g_imbe_m  #單頭舊值宣告(系統還原用)
DEFINE g_imbe_m_o      type_g_imbe_m  #單頭舊值宣告(其他用途)
DEFINE g_imbe_m_mask_o type_g_imbe_m  #轉換遮罩前資料
DEFINE g_imbe_m_mask_n type_g_imbe_m  #轉換遮罩後資料
 
   DEFINE g_imbedocno_t LIKE imbe_t.imbedocno
 
   
 
   
 
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
 
{<section id="aimt306.main" >}
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
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_imbe_m.imbedocno = g_argv[02]
   END IF
  
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imbedocno,'','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','',imbe111,'',imbe112,'',imbe113,'',imbe114,imbe115,imbe116,imbe117,imbe120, 
       imbeownid,'',imbeowndp,'',imbecrtid,'',imbecrtdp,'',imbecrtdt,imbemodid,'',imbemoddt,imbe118, 
       imbe119", 
                      " FROM imbe_t",
                      " WHERE imbeent= ? AND imbesite= ? AND imbedocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimt306_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imbedocno,t0.imbe111,t0.imbe112,t0.imbe113,t0.imbe114,t0.imbe115, 
       t0.imbe116,t0.imbe117,t0.imbe120,t0.imbeownid,t0.imbeowndp,t0.imbecrtid,t0.imbecrtdp,t0.imbecrtdt, 
       t0.imbemodid,t0.imbemoddt,t0.imbe118,t0.imbe119,t1.oocql004 ,t2.ooag011 ,t3.oocal003 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011",
               " FROM imbe_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='205' AND t1.oocql002=t0.imbe111 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imbe112  ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imbe113 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.imbeownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.imbeowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.imbecrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.imbecrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.imbemodid  ",
 
               " WHERE t0.imbeent = " ||g_enterprise|| " AND t0.imbesite = ? AND t0.imbedocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimt306_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimt306 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimt306_init()   
 
      #進入選單 Menu (="N")
      CALL aimt306_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimt306
      
   END IF 
   
   CLOSE aimt306_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimt306.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimt306_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
      CALL cl_set_combo_scc('imba000','32') 
   CALL cl_set_combo_scc('imba004','1001') 
   CALL cl_set_combo_scc('imbe115','5051') 
   CALL cl_set_combo_scc('imbe116','5052') 
   CALL cl_set_combo_scc('imbe117','5053') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_imba000','32') 
   CALL cl_set_combo_scc('status1','13')
   CALL cl_set_combo_scc('imba000','32')
   CALL cl_set_combo_scc('imba004','1001') 

   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimt306_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimt306.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimt306_ui_dialog() 
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
         INITIALIZE g_imbe_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimt306_init()
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
               CALL aimt306_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimt306_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimt306' THEN        #160705-00042#9 160713 by sakura mark    
#               IF g_prog MATCHES 'aimt306' THEN   #160705-00042#9 160713 by sakura add  #170217-00068#2 mark
               IF g_prog MATCHES 'aimt306*' THEN   #160705-00042#9 160713 by sakura add  #170217-00068#2 mod
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL aimt306_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimt306_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimt306_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimt306_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimt306_fetch("L")  
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
                  CALL aimt306_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimt306_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimt306_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimt306_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt307
            LET g_action_choice="open_aimt307"
            IF cl_auth_chk_act("open_aimt307") THEN
               
               #add-point:ON ACTION open_aimt307 name="menu2.open_aimt307"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt307 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt308
            LET g_action_choice="open_aimt308"
            IF cl_auth_chk_act("open_aimt308") THEN
               
               #add-point:ON ACTION open_aimt308 name="menu2.open_aimt308"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt308 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt310
            LET g_action_choice="open_aimt310"
            IF cl_auth_chk_act("open_aimt310") THEN
               
               #add-point:ON ACTION open_aimt310 name="menu2.open_aimt310"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt310 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt303
            LET g_action_choice="open_aimt303"
            IF cl_auth_chk_act("open_aimt303") THEN
               
               #add-point:ON ACTION open_aimt303 name="menu2.open_aimt303"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt303 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/aim/aimt306_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/aim/aimt306_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt301
            LET g_action_choice="open_aimt301"
            IF cl_auth_chk_act("open_aimt301") THEN
               
               #add-point:ON ACTION open_aimt301 name="menu2.open_aimt301"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt301 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimt306_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt302
            LET g_action_choice="open_aimt302"
            IF cl_auth_chk_act("open_aimt302") THEN
               
               #add-point:ON ACTION open_aimt302 name="menu2.open_aimt302"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt302 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt304
            LET g_action_choice="open_aimt304"
            IF cl_auth_chk_act("open_aimt304") THEN
               
               #add-point:ON ACTION open_aimt304 name="menu2.open_aimt304"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt304 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt305
            LET g_action_choice="open_aimt305"
            IF cl_auth_chk_act("open_aimt305") THEN
               
               #add-point:ON ACTION open_aimt305 name="menu2.open_aimt305"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt305 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba009
            LET g_action_choice="prog_imba009"
            IF cl_auth_chk_act("prog_imba009") THEN
               
               #add-point:ON ACTION prog_imba009 name="menu2.prog_imba009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imbe_m.imba009)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba003
            LET g_action_choice="prog_imba003"
            IF cl_auth_chk_act("prog_imba003") THEN
               
               #add-point:ON ACTION prog_imba003 name="menu2.prog_imba003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imbe_m.imba003)


               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimt306_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimt306_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimt306_set_pk_array()
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
                  CALL aimt306_fetch("")
 
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
                  CALL aimt306_browser_fill(g_wc,"")
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
                  CALL aimt306_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimt306' THEN        #160705-00042#9 160713 by sakura mark  
#               IF g_prog MATCHES 'aimt306' THEN   #160705-00042#9 160713 by sakura add  #170217-00068#2 mark
               IF g_prog MATCHES 'aimt306*' THEN   #160705-00042#9 160713 by sakura add  #170217-00068#2 mod
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
               CALL aimt306_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimt306_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimt306_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimt306_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimt306_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimt306_fetch("L")  
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
                  CALL aimt306_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimt306_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimt306_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimt306_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt307
            LET g_action_choice="open_aimt307"
            IF cl_auth_chk_act("open_aimt307") THEN
               
               #add-point:ON ACTION open_aimt307 name="menu.open_aimt307"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt307 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt308
            LET g_action_choice="open_aimt308"
            IF cl_auth_chk_act("open_aimt308") THEN
               
               #add-point:ON ACTION open_aimt308 name="menu.open_aimt308"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt308 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt310
            LET g_action_choice="open_aimt310"
            IF cl_auth_chk_act("open_aimt310") THEN
               
               #add-point:ON ACTION open_aimt310 name="menu.open_aimt310"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt310 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt303
            LET g_action_choice="open_aimt303"
            IF cl_auth_chk_act("open_aimt303") THEN
               
               #add-point:ON ACTION open_aimt303 name="menu.open_aimt303"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt303 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/aim/aimt306_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/aim/aimt306_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt301
            LET g_action_choice="open_aimt301"
            IF cl_auth_chk_act("open_aimt301") THEN
               
               #add-point:ON ACTION open_aimt301 name="menu.open_aimt301"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt301 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimt306_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt302
            LET g_action_choice="open_aimt302"
            IF cl_auth_chk_act("open_aimt302") THEN
               
               #add-point:ON ACTION open_aimt302 name="menu.open_aimt302"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt302 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt304
            LET g_action_choice="open_aimt304"
            IF cl_auth_chk_act("open_aimt304") THEN
               
               #add-point:ON ACTION open_aimt304 name="menu.open_aimt304"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt304 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt305
            LET g_action_choice="open_aimt305"
            IF cl_auth_chk_act("open_aimt305") THEN
               
               #add-point:ON ACTION open_aimt305 name="menu.open_aimt305"
               IF NOT cl_null(g_imbe_m.imbedocno) THEN
                  CALL cl_cmdrun("aimt305 '"||g_imbe_m.imbedocno||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba009
            LET g_action_choice="prog_imba009"
            IF cl_auth_chk_act("prog_imba009") THEN
               
               #add-point:ON ACTION prog_imba009 name="menu.prog_imba009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imbe_m.imba009)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba003
            LET g_action_choice="prog_imba003"
            IF cl_auth_chk_act("prog_imba003") THEN
               
               #add-point:ON ACTION prog_imba003 name="menu.prog_imba003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imbe_m.imba003)


               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimt306_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimt306_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimt306_set_pk_array()
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
 
{<section id="aimt306.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimt306_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "imbedocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imbe_t ",
               "  ",
               "  ",
               " WHERE imbeent = " ||g_enterprise|| " AND imbesite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imbe_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   LET g_sql = " SELECT COUNT(*) FROM imbe_t, ",
               "  imba_t ",
               "  LEFT OUTER JOIN imbal_t ON imbaent = imbalent AND imbadocno = imbaldocno AND imbal001 = '",g_lang,"' ",
               " WHERE imbaent = imbeent AND imbadocno = imbedocno ", 
               "   AND imbeent = '" ||g_enterprise|| "' AND imbesite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED
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
      INITIALIZE g_imbe_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imbestus,t0.imbedocno,t0.imbe111,t1.imbal002 ,t2.oocql004",
               " FROM imbe_t t0 ",
               "  ",
                              " LEFT JOIN imbal_t t1 ON t1.imbalent="||g_enterprise||" AND t1.imbaldocno=t0.imbedocno AND t1.imbal001='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='205' AND t2.oocql002=t0.imbe111 AND t2.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.imbeent = " ||g_enterprise|| " AND t0.imbesite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imbe_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   #LET l_sql_rank = "SELECT imbestus,'',imbedocno,'','','','','','','','',imbe111,'',RANK() OVER(ORDER BY imbedocno ", 
   #
   #
   #                 g_order,
   #                 ") AS RANK ",
   #                 " FROM imbe_t,",
   #                 "  imba_t ",
   #                 "  LEFT OUTER JOIN imbal_t ON imbaent = imbalent AND imbadocno = imbaldocno AND imbal001 = '",g_lang,"' ",
   #                 " WHERE imbaent = imbeent AND imbadocno = imbedocno ", 
   #                 "   AND imbeent = '" ||g_enterprise|| "' AND imbesite = '" ||g_site|| "' AND ", g_wc
 
   LET g_sql = " SELECT t0.imbestus,t0.imbedocno,t0.imbe111,t1.imbal002 ,t2.oocql004",
               " FROM imbe_t t0 ",
               "  ",
               " LEFT JOIN imbal_t t1 ON t1.imbalent='"||g_enterprise||"' AND t1.imbaldocno=t0.imbedocno AND t1.imbal001='"||g_lang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='205' AND t2.oocql002=t0.imbe111 AND t2.oocql003='"||g_lang||"' ",
               "  , imba_t ",
               " WHERE t0.imbeent = imbaent AND t0.imbedocno = imbadocno ",
               "   AND t0.imbeent = '" ||g_enterprise|| "' AND t0.imbesite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imbe_t")
   
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order

   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imbe_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imbedocno,g_browser[g_cnt].b_imbe111, 
          g_browser[g_cnt].b_imbedocno_desc,g_browser[g_cnt].b_imbe111_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      CALL aimt306_b_imbedocno_ref(g_browser[g_cnt].b_imbedocno) RETURNING g_browser[g_cnt].b_imba000,g_browser[g_cnt].b_imbadocdt,g_browser[g_cnt].b_imba001,g_browser[g_cnt].b_imbedocno_desc,g_browser[g_cnt].b_imbal003,g_browser[g_cnt].b_imba009,g_browser[g_cnt].b_imba003
      DISPLAY BY NAME g_browser[g_cnt].b_imba000,g_browser[g_cnt].b_imbadocdt,g_browser[g_cnt].b_imba001,g_browser[g_cnt].b_imbedocno_desc,g_browser[g_cnt].b_imbal003,g_browser[g_cnt].b_imba009,g_browser[g_cnt].b_imba003

      CALL aimt306_b_imba009_ref(g_browser[g_cnt].b_imba009) RETURNING g_browser[g_cnt].b_imba009_desc
      DISPLAY BY NAME g_browser[g_cnt].b_imba009_desc
      
      CALL aimt306_b_imba003_ref(g_browser[g_cnt].b_imba003) RETURNING g_browser[g_cnt].b_imba003_desc
      DISPLAY BY NAME g_browser[g_cnt].b_imba003_desc
      
         #end add-point
         
         #遮罩相關處理
         CALL aimt306_browser_mask()
         
         
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
   
   IF cl_null(g_browser[g_cnt].b_imbedocno) THEN
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
 
{<section id="aimt306.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimt306_construct()
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
   INITIALIZE g_imbe_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imbedocno,imbadocdt,imba900,imba000,imba901,imba001,imba002,imbal002, 
          imbal003,imbal004,imba009,imba003,imba004,imba005,imba006,imba010,imbe111,imbe112,imbe113, 
          imbe114,imbe115,imbe116,imbe117,imbe120,imbeownid,imbeowndp,imbecrtid,imbecrtdp,imbecrtdt, 
          imbemodid,imbemoddt,imbe118,imbe119
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imbecrtdt>>----
         AFTER FIELD imbecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imbemoddt>>----
         AFTER FIELD imbemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imbecnfdt>>----
         
         #----<<imbepstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.imbedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbedocno
            #add-point:ON ACTION controlp INFIELD imbedocno name="construct.c.imbedocno"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbedocno  #顯示到畫面上

            NEXT FIELD imbedocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbedocno
            #add-point:BEFORE FIELD imbedocno name="construct.b.imbedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbedocno
            
            #add-point:AFTER FIELD imbedocno name="construct.a.imbedocno"
            
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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba001
            #add-point:BEFORE FIELD imba001 name="construct.b.imba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba001
            
            #add-point:AFTER FIELD imba001 name="construct.a.imba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba001
            #add-point:ON ACTION controlp INFIELD imba001 name="construct.c.imba001"
            
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
            
 
 
         #Ctrlp:construct.c.imbe111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe111
            #add-point:ON ACTION controlp INFIELD imbe111 name="construct.c.imbe111"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            
            CALL q_imcg111()                           #呼叫開窗
           
            DISPLAY g_qryparam.return1 TO imbe111  #顯示到畫面上

            NEXT FIELD imbe111                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe111
            #add-point:BEFORE FIELD imbe111 name="construct.b.imbe111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe111
            
            #add-point:AFTER FIELD imbe111 name="construct.a.imbe111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe112
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe112
            #add-point:ON ACTION controlp INFIELD imbe112 name="construct.c.imbe112"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooagstus = 'Y' "
            CALL q_ooag001_2()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imbe112  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD imbe112                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe112
            #add-point:BEFORE FIELD imbe112 name="construct.b.imbe112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe112
            
            #add-point:AFTER FIELD imbe112 name="construct.a.imbe112"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe113
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe113
            #add-point:ON ACTION controlp INFIELD imbe113 name="construct.c.imbe113"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus = 'Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imbe113  #顯示到畫面上

            NEXT FIELD imbe113                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe113
            #add-point:BEFORE FIELD imbe113 name="construct.b.imbe113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe113
            
            #add-point:AFTER FIELD imbe113 name="construct.a.imbe113"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe114
            #add-point:BEFORE FIELD imbe114 name="construct.b.imbe114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe114
            
            #add-point:AFTER FIELD imbe114 name="construct.a.imbe114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe114
            #add-point:ON ACTION controlp INFIELD imbe114 name="construct.c.imbe114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe115
            #add-point:BEFORE FIELD imbe115 name="construct.b.imbe115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe115
            
            #add-point:AFTER FIELD imbe115 name="construct.a.imbe115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe115
            #add-point:ON ACTION controlp INFIELD imbe115 name="construct.c.imbe115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe116
            #add-point:BEFORE FIELD imbe116 name="construct.b.imbe116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe116
            
            #add-point:AFTER FIELD imbe116 name="construct.a.imbe116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe116
            #add-point:ON ACTION controlp INFIELD imbe116 name="construct.c.imbe116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe117
            #add-point:BEFORE FIELD imbe117 name="construct.b.imbe117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe117
            
            #add-point:AFTER FIELD imbe117 name="construct.a.imbe117"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe117
            #add-point:ON ACTION controlp INFIELD imbe117 name="construct.c.imbe117"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe120
            #add-point:BEFORE FIELD imbe120 name="construct.b.imbe120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe120
            
            #add-point:AFTER FIELD imbe120 name="construct.a.imbe120"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe120
            #add-point:ON ACTION controlp INFIELD imbe120 name="construct.c.imbe120"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imbeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbeownid
            #add-point:ON ACTION controlp INFIELD imbeownid name="construct.c.imbeownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbeownid  #顯示到畫面上

            NEXT FIELD imbeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbeownid
            #add-point:BEFORE FIELD imbeownid name="construct.b.imbeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbeownid
            
            #add-point:AFTER FIELD imbeownid name="construct.a.imbeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbeowndp
            #add-point:ON ACTION controlp INFIELD imbeowndp name="construct.c.imbeowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbeowndp  #顯示到畫面上

            NEXT FIELD imbeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbeowndp
            #add-point:BEFORE FIELD imbeowndp name="construct.b.imbeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbeowndp
            
            #add-point:AFTER FIELD imbeowndp name="construct.a.imbeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbecrtid
            #add-point:ON ACTION controlp INFIELD imbecrtid name="construct.c.imbecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbecrtid  #顯示到畫面上

            NEXT FIELD imbecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbecrtid
            #add-point:BEFORE FIELD imbecrtid name="construct.b.imbecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbecrtid
            
            #add-point:AFTER FIELD imbecrtid name="construct.a.imbecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbecrtdp
            #add-point:ON ACTION controlp INFIELD imbecrtdp name="construct.c.imbecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbecrtdp  #顯示到畫面上

            NEXT FIELD imbecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbecrtdp
            #add-point:BEFORE FIELD imbecrtdp name="construct.b.imbecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbecrtdp
            
            #add-point:AFTER FIELD imbecrtdp name="construct.a.imbecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbecrtdt
            #add-point:BEFORE FIELD imbecrtdt name="construct.b.imbecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imbemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbemodid
            #add-point:ON ACTION controlp INFIELD imbemodid name="construct.c.imbemodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbemodid  #顯示到畫面上

            NEXT FIELD imbemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbemodid
            #add-point:BEFORE FIELD imbemodid name="construct.b.imbemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbemodid
            
            #add-point:AFTER FIELD imbemodid name="construct.a.imbemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbemoddt
            #add-point:BEFORE FIELD imbemoddt name="construct.b.imbemoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe118
            #add-point:BEFORE FIELD imbe118 name="construct.b.imbe118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe118
            
            #add-point:AFTER FIELD imbe118 name="construct.a.imbe118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe118
            #add-point:ON ACTION controlp INFIELD imbe118 name="construct.c.imbe118"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe119
            #add-point:BEFORE FIELD imbe119 name="construct.b.imbe119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe119
            
            #add-point:AFTER FIELD imbe119 name="construct.a.imbe119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbe119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe119
            #add-point:ON ACTION controlp INFIELD imbe119 name="construct.c.imbe119"
            
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
 
{<section id="aimt306.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimt306_filter()
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
      CONSTRUCT g_wc_filter ON imbedocno,imbe111
                          FROM s_browse[1].b_imbedocno,s_browse[1].b_imbe111
 
         BEFORE CONSTRUCT
               DISPLAY aimt306_filter_parser('imbedocno') TO s_browse[1].b_imbedocno
            DISPLAY aimt306_filter_parser('imbe111') TO s_browse[1].b_imbe111
      
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
 
      CALL aimt306_filter_show('imbedocno')
   CALL aimt306_filter_show('imbe111')
 
END FUNCTION
 
{</section>}
 
{<section id="aimt306.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimt306_filter_parser(ps_field)
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
 
{<section id="aimt306.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimt306_filter_show(ps_field)
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
   LET ls_condition = aimt306_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimt306.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimt306_query()
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
 
   INITIALIZE g_imbe_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimt306_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimt306_browser_fill(g_wc,"F")
      CALL aimt306_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimt306_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aimt306_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimt306.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimt306_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_imbastus  LIKE imba_t.imbastus
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
   LET g_imbe_m.imbedocno = g_browser[g_current_idx].b_imbedocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimt306_master_referesh USING g_site,g_imbe_m.imbedocno INTO g_imbe_m.imbedocno,g_imbe_m.imbe111, 
       g_imbe_m.imbe112,g_imbe_m.imbe113,g_imbe_m.imbe114,g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117, 
       g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeowndp,g_imbe_m.imbecrtid,g_imbe_m.imbecrtdp, 
       g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemoddt,g_imbe_m.imbe118,g_imbe_m.imbe119,g_imbe_m.imbe111_desc, 
       g_imbe_m.imbe112_desc,g_imbe_m.imbe113_desc,g_imbe_m.imbeownid_desc,g_imbe_m.imbeowndp_desc,g_imbe_m.imbecrtid_desc, 
       g_imbe_m.imbecrtdp_desc,g_imbe_m.imbemodid_desc
   
   #遮罩相關處理
   LET g_imbe_m_mask_o.* =  g_imbe_m.*
   CALL aimt306_imbe_t_mask()
   LET g_imbe_m_mask_n.* =  g_imbe_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimt306_set_act_visible()
   CALL aimt306_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,query",TRUE)
   LET l_imbastus = NULL
   SELECT imbastus INTO l_imbastus
     FROM imba_t WHERE imbaent = g_enterprise AND imbadocno= g_imbe_m.imbedocno
   IF l_imbastus = 'N' THEN
      CALL cl_set_act_visible("modify",TRUE)
   ELSE
      CALL cl_set_act_visible("modify",FALSE)
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("query",FALSE)
   END IF
   IF g_imbe_m.imbe116 = '1' THEN
      CALL cl_set_combo_scc_part("imbe117",'5053','1,2,3')
   END IF
   IF g_imbe_m.imbe116 = '2' THEN
      CALL cl_set_combo_scc_part("imbe117",'5053','1,2,3,4')
   END IF
   IF g_imbe_m.imbe116 = '3' OR g_imbe_m.imbe116 = '4' THEN
      CALL cl_set_combo_scc_part("imbe117",'5053','1,2,3,4,5,6,7')
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imbe_m_t.* = g_imbe_m.*
   LET g_imbe_m_o.* = g_imbe_m.*
   
   LET g_data_owner = g_imbe_m.imbeownid      
   LET g_data_dept  = g_imbe_m.imbeowndp
   
   #重新顯示
   CALL aimt306_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimt306.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimt306_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imbe_m.* TO NULL             #DEFAULT 設定
   LET g_imbedocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imbe_m.imbeownid = g_user
      LET g_imbe_m.imbeowndp = g_dept
      LET g_imbe_m.imbecrtid = g_user
      LET g_imbe_m.imbecrtdp = g_dept 
      LET g_imbe_m.imbecrtdt = cl_get_current()
      LET g_imbe_m.imbemodid = g_user
      LET g_imbe_m.imbemoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imbe_m.imba000 = "I"
      LET g_imbe_m.imbe114 = "N"
      LET g_imbe_m.imbe115 = "N"
      LET g_imbe_m.imbe116 = "1"
      LET g_imbe_m.imbe117 = "1"
      LET g_imbe_m.imbe120 = "N"
      LET g_imbe_m.imbe118 = "0"
      LET g_imbe_m.imbe119 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL aimt306_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imbe_m.* TO NULL
         CALL aimt306_show()
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
   CALL aimt306_set_act_visible()
   CALL aimt306_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imbedocno_t = g_imbe_m.imbedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbeent = " ||g_enterprise|| " AND imbesite = '" ||g_site|| "' AND",
                      " imbedocno = '", g_imbe_m.imbedocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimt306_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimt306_master_referesh USING g_site,g_imbe_m.imbedocno INTO g_imbe_m.imbedocno,g_imbe_m.imbe111, 
       g_imbe_m.imbe112,g_imbe_m.imbe113,g_imbe_m.imbe114,g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117, 
       g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeowndp,g_imbe_m.imbecrtid,g_imbe_m.imbecrtdp, 
       g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemoddt,g_imbe_m.imbe118,g_imbe_m.imbe119,g_imbe_m.imbe111_desc, 
       g_imbe_m.imbe112_desc,g_imbe_m.imbe113_desc,g_imbe_m.imbeownid_desc,g_imbe_m.imbeowndp_desc,g_imbe_m.imbecrtid_desc, 
       g_imbe_m.imbecrtdp_desc,g_imbe_m.imbemodid_desc
   
   
   #遮罩相關處理
   LET g_imbe_m_mask_o.* =  g_imbe_m.*
   CALL aimt306_imbe_t_mask()
   LET g_imbe_m_mask_n.* =  g_imbe_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imbe_m.imbedocno,g_imbe_m.fflabel1,g_imbe_m.imbadocdt,g_imbe_m.fflabel3,g_imbe_m.imba900, 
       g_imbe_m.imba900_desc,g_imbe_m.imbedocno_desc,g_imbe_m.fflabel2,g_imbe_m.imba000,g_imbe_m.fflabel4, 
       g_imbe_m.imba901,g_imbe_m.imba901_desc,g_imbe_m.imba001,g_imbe_m.imba002,g_imbe_m.imbal002,g_imbe_m.imbal003, 
       g_imbe_m.imbal004,g_imbe_m.imba009,g_imbe_m.imba009_desc,g_imbe_m.imba003,g_imbe_m.imba003_desc, 
       g_imbe_m.imba004,g_imbe_m.imba005,g_imbe_m.imba005_desc,g_imbe_m.imba006,g_imbe_m.imba006_desc, 
       g_imbe_m.imba010,g_imbe_m.imba010_desc,g_imbe_m.status1,g_imbe_m.imbe111,g_imbe_m.imbe111_desc, 
       g_imbe_m.imbe112,g_imbe_m.imbe112_desc,g_imbe_m.imbe113,g_imbe_m.imbe113_desc,g_imbe_m.imbe114, 
       g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117,g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeownid_desc, 
       g_imbe_m.imbeowndp,g_imbe_m.imbeowndp_desc,g_imbe_m.imbecrtid,g_imbe_m.imbecrtid_desc,g_imbe_m.imbecrtdp, 
       g_imbe_m.imbecrtdp_desc,g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemodid_desc,g_imbe_m.imbemoddt, 
       g_imbe_m.imbe118,g_imbe_m.imbe119
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_imbe_m.imbeownid      
   LET g_data_dept  = g_imbe_m.imbeowndp
 
   #功能已完成,通報訊息中心
   CALL aimt306_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimt306.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimt306_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
 
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imbe_m.imbedocno IS NULL
 
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
   LET g_imbedocno_t = g_imbe_m.imbedocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimt306_cl USING g_enterprise, g_site,g_imbe_m.imbedocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimt306_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimt306_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimt306_master_referesh USING g_site,g_imbe_m.imbedocno INTO g_imbe_m.imbedocno,g_imbe_m.imbe111, 
       g_imbe_m.imbe112,g_imbe_m.imbe113,g_imbe_m.imbe114,g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117, 
       g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeowndp,g_imbe_m.imbecrtid,g_imbe_m.imbecrtdp, 
       g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemoddt,g_imbe_m.imbe118,g_imbe_m.imbe119,g_imbe_m.imbe111_desc, 
       g_imbe_m.imbe112_desc,g_imbe_m.imbe113_desc,g_imbe_m.imbeownid_desc,g_imbe_m.imbeowndp_desc,g_imbe_m.imbecrtid_desc, 
       g_imbe_m.imbecrtdp_desc,g_imbe_m.imbemodid_desc
 
   #檢查是否允許此動作
   IF NOT aimt306_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imbe_m_mask_o.* =  g_imbe_m.*
   CALL aimt306_imbe_t_mask()
   LET g_imbe_m_mask_n.* =  g_imbe_m.*
   
   
 
   #顯示資料
   CALL aimt306_show()
   
   WHILE TRUE
      LET g_imbe_m.imbedocno = g_imbedocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imbe_m.imbemodid = g_user 
LET g_imbe_m.imbemoddt = cl_get_current()
LET g_imbe_m.imbemodid_desc = cl_get_username(g_imbe_m.imbemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
 
      #end add-point
 
      #資料輸入
      CALL aimt306_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imbe_m.* = g_imbe_m_t.*
         CALL aimt306_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imbe_t SET (imbemodid,imbemoddt) = (g_imbe_m.imbemodid,g_imbe_m.imbemoddt)
       WHERE imbeent = g_enterprise AND imbesite = g_site AND imbedocno = g_imbedocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimt306_set_act_visible()
   CALL aimt306_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imbeent = " ||g_enterprise|| " AND imbesite = '" ||g_site|| "' AND",
                      " imbedocno = '", g_imbe_m.imbedocno, "' "
 
   #填到對應位置
   CALL aimt306_browser_fill(g_wc,"")
 
   CLOSE aimt306_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimt306_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimt306.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimt306_input(p_cmd)
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
   DEFINE l_errno         STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_rate          LIKE inaj_t.inaj014
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
   DISPLAY BY NAME g_imbe_m.imbedocno,g_imbe_m.fflabel1,g_imbe_m.imbadocdt,g_imbe_m.fflabel3,g_imbe_m.imba900, 
       g_imbe_m.imba900_desc,g_imbe_m.imbedocno_desc,g_imbe_m.fflabel2,g_imbe_m.imba000,g_imbe_m.fflabel4, 
       g_imbe_m.imba901,g_imbe_m.imba901_desc,g_imbe_m.imba001,g_imbe_m.imba002,g_imbe_m.imbal002,g_imbe_m.imbal003, 
       g_imbe_m.imbal004,g_imbe_m.imba009,g_imbe_m.imba009_desc,g_imbe_m.imba003,g_imbe_m.imba003_desc, 
       g_imbe_m.imba004,g_imbe_m.imba005,g_imbe_m.imba005_desc,g_imbe_m.imba006,g_imbe_m.imba006_desc, 
       g_imbe_m.imba010,g_imbe_m.imba010_desc,g_imbe_m.status1,g_imbe_m.imbe111,g_imbe_m.imbe111_desc, 
       g_imbe_m.imbe112,g_imbe_m.imbe112_desc,g_imbe_m.imbe113,g_imbe_m.imbe113_desc,g_imbe_m.imbe114, 
       g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117,g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeownid_desc, 
       g_imbe_m.imbeowndp,g_imbe_m.imbeowndp_desc,g_imbe_m.imbecrtid,g_imbe_m.imbecrtid_desc,g_imbe_m.imbecrtdp, 
       g_imbe_m.imbecrtdp_desc,g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemodid_desc,g_imbe_m.imbemoddt, 
       g_imbe_m.imbe118,g_imbe_m.imbe119
   
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
   CALL aimt306_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimt306_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imbe_m.imbedocno,g_imbe_m.imbe111,g_imbe_m.imbe112,g_imbe_m.imbe113,g_imbe_m.imbe114, 
          g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117,g_imbe_m.imbe120,g_imbe_m.imbe118,g_imbe_m.imbe119  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbedocno
            
            #add-point:AFTER FIELD imbedocno name="input.a.imbedocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_imbe_m.imbedocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imbe_m.imbedocno != g_imbedocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imbe_t WHERE "||"imbeent = '" ||g_enterprise|| "' AND imbesite = '" ||g_site|| "' AND "||"imbedocno = '"||g_imbe_m.imbedocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbedocno
            #add-point:BEFORE FIELD imbedocno name="input.b.imbedocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbedocno
            #add-point:ON CHANGE imbedocno name="input.g.imbedocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe111
            
            #add-point:AFTER FIELD imbe111 name="input.a.imbe111"
            CALL aimt306_imbe111_ref(g_imbe_m.imbe111) RETURNING g_imbe_m.imbe111_desc
            DISPLAY BY NAME g_imbe_m.imbe111_desc
            IF NOT cl_null(g_imbe_m.imbe111) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imbe_m.imbe111 != g_imbe_m_t.imbe111 OR cl_null(g_imbe_m_t.imbe111))) THEN  #160824-00007#272 Mark By ken 161230
               IF g_imbe_m.imbe111 != g_imbe_m_o.imbe111 OR cl_null(g_imbe_m_o.imbe111) THEN    #160824-00007#272 Add By ken 161230
                  IF g_site = 'ALL' THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL

                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_imbe_m.imbe111
                     #160318-00025#18  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00043:sub-01302|aimi106|",cl_get_progname("aimi106",g_lang,"2"),"|:EXEPROGaimi106"
                     #160318-00025#18  by 07900 --add-end
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_imcg111") THEN
                        #LET g_imbe_m.imbe111 = g_imbe_m_t.imbe111    #160824-00007#272 Mark By ken 161230
                        LET g_imbe_m.imbe111 = g_imbe_m_o.imbe111     #160824-00007#272 Add By ken 161230
                        CALL aimt306_imbe111_ref(g_imbe_m.imbe111) RETURNING g_imbe_m.imbe111_desc
                        DISPLAY BY NAME g_imbe_m.imbe111_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL

                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_imbe_m.imbe111
                     #160318-00025#18  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00151:sub-01302|aimi116|",cl_get_progname("aimi116",g_lang,"2"),"|:EXEPROGaimi116"
                     #160318-00025#18  by 07900 --add-end
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_imcg111_1") THEN
                        #LET g_imbe_m.imbe111 = g_imbe_m_t.imbe111    #160824-00007#272 Mark By ken 161230
                        LET g_imbe_m.imbe111 = g_imbe_m_o.imbe111     #160824-00007#272 Add By ken 161230
                        CALL aimt306_imbe111_ref(g_imbe_m.imbe111) RETURNING g_imbe_m.imbe111_desc
                        DISPLAY BY NAME g_imbe_m.imbe111_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               IF g_imbe_m.imbe111 <> g_imbe_m_o.imbe111 OR cl_null(g_imbe_m_o.imbe111) THEN
                  IF cl_ask_confirm('aim-00120') THEN
                     CALL aimt306_get_imcg()
                  END IF
               END IF
            END IF
            LET g_imbe_m_o.imbe111 = g_imbe_m.imbe111
            LET g_imbe_m_o.* = g_imbe_m.*   #160824-00007#272 Add By ken 161230
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe111
            #add-point:BEFORE FIELD imbe111 name="input.b.imbe111"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe111
            #add-point:ON CHANGE imbe111 name="input.g.imbe111"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe112
            
            #add-point:AFTER FIELD imbe112 name="input.a.imbe112"
            CALL aimt306_imbe112_ref(g_imbe_m.imbe112) RETURNING g_imbe_m.imbe112_desc
            DISPLAY BY NAME g_imbe_m.imbe112_desc
            IF NOT cl_null(g_imbe_m.imbe112) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imbe_m.imbe112 != g_imbe_m_t.imbe112 OR cl_null(g_imbe_m_t.imbe112))) THEN  #160824-00007#272 Mark By ken 161230
               IF g_imbe_m.imbe112 != g_imbe_m_o.imbe112 OR cl_null(g_imbe_m_o.imbe112) THEN     #160824-00007#272 Add By ken 161230
                   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imbe_m.imbe112
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#18  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_imbe_m.imbe112 = g_imbe_m_t.imbe112  #160824-00007#272 Mark By ken 161230
                     LET g_imbe_m.imbe112 = g_imbe_m_o.imbe112   #160824-00007#272 Add By ken 161230
                     CALL aimt306_imbe112_ref(g_imbe_m.imbe112) RETURNING g_imbe_m.imbe112_desc
                     DISPLAY BY NAME g_imbe_m.imbe112_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_imbe_m_o.* = g_imbe_m.*   #160824-00007#272 Add By ken 161230
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe112
            #add-point:BEFORE FIELD imbe112 name="input.b.imbe112"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe112
            #add-point:ON CHANGE imbe112 name="input.g.imbe112"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe113
            
            #add-point:AFTER FIELD imbe113 name="input.a.imbe113"
            CALL aimt306_imbe113_ref(g_imbe_m.imbe113) RETURNING g_imbe_m.imbe113_desc
            DISPLAY BY NAME g_imbe_m.imbe113_desc
            IF NOT cl_null(g_imbe_m.imbe113) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imbe_m.imbe113 != g_imbe_m_t.imbe113 OR cl_null(g_imbe_m_t.imbe113))) THEN    #160824-00007#272 Mark By ken 161230
               IF g_imbe_m.imbe113 != g_imbe_m_o.imbe113 OR cl_null(g_imbe_m_o.imbe113) THEN    #160824-00007#272 Add By ken 161230
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imbe_m.imbe113
                  #160318-00025#18  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  #160318-00025#18  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     #LET g_imbe_m.imbe113 = g_imbe_m_t.imbe113  #160824-00007#272 Mark By ken 161230
                     LET g_imbe_m.imbe113 = g_imbe_m_o.imbe113   #160824-00007#272 Add By ken 161230
                     CALL aimt306_imbe113_ref(g_imbe_m.imbe113) RETURNING g_imbe_m.imbe113_desc
                     DISPLAY BY NAME g_imbe_m.imbe113_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aimi190_get_convert(g_imbe_m.imba001,g_imbe_m.imbe113,g_imbe_m.imba006) RETURNING l_success,l_rate
               END IF
            END IF
            LET g_imbe_m_o.* = g_imbe_m.*   #160824-00007#272 Add By ken 161230
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe113
            #add-point:BEFORE FIELD imbe113 name="input.b.imbe113"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe113
            #add-point:ON CHANGE imbe113 name="input.g.imbe113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe114
            #add-point:BEFORE FIELD imbe114 name="input.b.imbe114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe114
            
            #add-point:AFTER FIELD imbe114 name="input.a.imbe114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe114
            #add-point:ON CHANGE imbe114 name="input.g.imbe114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe115
            #add-point:BEFORE FIELD imbe115 name="input.b.imbe115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe115
            
            #add-point:AFTER FIELD imbe115 name="input.a.imbe115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe115
            #add-point:ON CHANGE imbe115 name="input.g.imbe115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe116
            #add-point:BEFORE FIELD imbe116 name="input.b.imbe116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe116
            
            #add-point:AFTER FIELD imbe116 name="input.a.imbe116"
            IF g_imbe_m.imbe116 = '1' THEN
               CALL cl_set_combo_scc_part("imbe117",'5053','1,2,3')
            END IF
            IF g_imbe_m.imbe116 = '2' THEN
               CALL cl_set_combo_scc_part("imbe117",'5053','1,2,3,4')
            END IF
            IF g_imbe_m.imbe116 = '3' OR g_imbe_m.imbe116 = '4' THEN
               CALL cl_set_combo_scc_part("imbe117",'5053','1,2,3,4,5,6,7')
            END IF
            LET g_imbe_m_o.* = g_imbe_m.*   #160824-00007#272 Add By ken 161230
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe116
            #add-point:ON CHANGE imbe116 name="input.g.imbe116"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe117
            #add-point:BEFORE FIELD imbe117 name="input.b.imbe117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe117
            
            #add-point:AFTER FIELD imbe117 name="input.a.imbe117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe117
            #add-point:ON CHANGE imbe117 name="input.g.imbe117"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe120
            #add-point:BEFORE FIELD imbe120 name="input.b.imbe120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe120
            
            #add-point:AFTER FIELD imbe120 name="input.a.imbe120"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe120
            #add-point:ON CHANGE imbe120 name="input.g.imbe120"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe118
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imbe_m.imbe118,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imbe118
            END IF 
 
 
 
            #add-point:AFTER FIELD imbe118 name="input.a.imbe118"
            IF NOT cl_null(g_imbe_m.imbe118) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe118
            #add-point:BEFORE FIELD imbe118 name="input.b.imbe118"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe118
            #add-point:ON CHANGE imbe118 name="input.g.imbe118"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbe119
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imbe_m.imbe119,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imbe119
            END IF 
 
 
 
            #add-point:AFTER FIELD imbe119 name="input.a.imbe119"
            IF NOT cl_null(g_imbe_m.imbe119) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbe119
            #add-point:BEFORE FIELD imbe119 name="input.b.imbe119"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbe119
            #add-point:ON CHANGE imbe119 name="input.g.imbe119"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imbedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbedocno
            #add-point:ON ACTION controlp INFIELD imbedocno name="input.c.imbedocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbe111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe111
            #add-point:ON ACTION controlp INFIELD imbe111 name="input.c.imbe111"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbe_m.imbe111             #給予default值

            
            CALL q_imcg111()                                #呼叫開窗

            LET g_imbe_m.imbe111 = g_qryparam.return1              #將開窗取得的值回傳到變數
          
            CALL aimt306_imbe111_ref(g_imbe_m.imbe111) RETURNING g_imbe_m.imbe111_desc
            DISPLAY BY NAME g_imbe_m.imbe111_desc
            
            DISPLAY g_imbe_m.imbe111 TO imbe111              #顯示到畫面上

            NEXT FIELD imbe111                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbe112
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe112
            #add-point:ON ACTION controlp INFIELD imbe112 name="input.c.imbe112"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbe_m.imbe112             #給予default值
            #LET g_qryparam.default2 = "" #g_imbe_m.oofa011 #全名

            #給予arg

            CALL q_ooag001_2()                                #呼叫開窗

            LET g_imbe_m.imbe112 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_imbe_m.oofa011 = g_qryparam.return2 #全名

            DISPLAY g_imbe_m.imbe112 TO imbe112              #顯示到畫面上
            #DISPLAY g_imbe_m.oofa011 TO oofa011 #全名

            CALL aimt306_imbe112_ref(g_imbe_m.imbe112) RETURNING g_imbe_m.imbe112_desc
            DISPLAY BY NAME g_imbe_m.imbe112_desc
            
            NEXT FIELD imbe112                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbe113
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe113
            #add-point:ON ACTION controlp INFIELD imbe113 name="input.c.imbe113"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbe_m.imbe113             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imbe_m.imbe113 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imbe_m.imbe113 TO imbe113              #顯示到畫面上

            CALL aimt306_imbe113_ref(g_imbe_m.imbe113) RETURNING g_imbe_m.imbe113_desc
            DISPLAY BY NAME g_imbe_m.imbe113_desc
            
            NEXT FIELD imbe113                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbe114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe114
            #add-point:ON ACTION controlp INFIELD imbe114 name="input.c.imbe114"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbe115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe115
            #add-point:ON ACTION controlp INFIELD imbe115 name="input.c.imbe115"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbe116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe116
            #add-point:ON ACTION controlp INFIELD imbe116 name="input.c.imbe116"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbe117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe117
            #add-point:ON ACTION controlp INFIELD imbe117 name="input.c.imbe117"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbe120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe120
            #add-point:ON ACTION controlp INFIELD imbe120 name="input.c.imbe120"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbe118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe118
            #add-point:ON ACTION controlp INFIELD imbe118 name="input.c.imbe118"
            
            #END add-point
 
 
         #Ctrlp:input.c.imbe119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbe119
            #add-point:ON ACTION controlp INFIELD imbe119 name="input.c.imbe119"
            
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
               SELECT COUNT(1) INTO l_count FROM imbe_t
                WHERE imbeent = g_enterprise AND imbesite = g_site AND imbedocno = g_imbe_m.imbedocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imbe_t (imbeent, imbesite,imbedocno,imbe111,imbe112,imbe113,imbe114,imbe115, 
                      imbe116,imbe117,imbe120,imbeownid,imbeowndp,imbecrtid,imbecrtdp,imbecrtdt,imbemodid, 
                      imbemoddt,imbe118,imbe119)
                  VALUES (g_enterprise, g_site,g_imbe_m.imbedocno,g_imbe_m.imbe111,g_imbe_m.imbe112, 
                      g_imbe_m.imbe113,g_imbe_m.imbe114,g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117, 
                      g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeowndp,g_imbe_m.imbecrtid,g_imbe_m.imbecrtdp, 
                      g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemoddt,g_imbe_m.imbe118,g_imbe_m.imbe119)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imbe_m.imbedocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aimt306_imbe_t_mask_restore('restore_mask_o')
               
               UPDATE imbe_t SET (imbedocno,imbe111,imbe112,imbe113,imbe114,imbe115,imbe116,imbe117, 
                   imbe120,imbeownid,imbeowndp,imbecrtid,imbecrtdp,imbecrtdt,imbemodid,imbemoddt,imbe118, 
                   imbe119) = (g_imbe_m.imbedocno,g_imbe_m.imbe111,g_imbe_m.imbe112,g_imbe_m.imbe113, 
                   g_imbe_m.imbe114,g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117,g_imbe_m.imbe120, 
                   g_imbe_m.imbeownid,g_imbe_m.imbeowndp,g_imbe_m.imbecrtid,g_imbe_m.imbecrtdp,g_imbe_m.imbecrtdt, 
                   g_imbe_m.imbemodid,g_imbe_m.imbemoddt,g_imbe_m.imbe118,g_imbe_m.imbe119)
                WHERE imbeent = g_enterprise AND imbesite = g_site AND imbedocno = g_imbedocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbe_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimt306_imbe_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imbe_m_t)
                     LET g_log2 = util.JSON.stringify(g_imbe_m)
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
 
{<section id="aimt306.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimt306_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imbe_t.imbedocno 
   DEFINE l_oldno     LIKE imbe_t.imbedocno 
 
   DEFINE l_master    RECORD LIKE imbe_t.* #此變數樣板目前無使用
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
   IF g_imbe_m.imbedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imbedocno_t = g_imbe_m.imbedocno
 
   
   #清空key值
   LET g_imbe_m.imbedocno = ""
 
    
   CALL aimt306_set_entry("a")
   CALL aimt306_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imbe_m.imbeownid = g_user
      LET g_imbe_m.imbeowndp = g_dept
      LET g_imbe_m.imbecrtid = g_user
      LET g_imbe_m.imbecrtdp = g_dept 
      LET g_imbe_m.imbecrtdt = cl_get_current()
      LET g_imbe_m.imbemodid = g_user
      LET g_imbe_m.imbemoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_imbe_m.imbedocno_desc = ''
   DISPLAY BY NAME g_imbe_m.imbedocno_desc
 
   
   #資料輸入
   CALL aimt306_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imbe_m.* TO NULL
      CALL aimt306_show()
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
      LET g_errparam.extend = "imbe_t:",SQLERRMESSAGE 
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
   CALL aimt306_set_act_visible()
   CALL aimt306_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imbedocno_t = g_imbe_m.imbedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbeent = " ||g_enterprise|| " AND imbesite = '" ||g_site|| "' AND",
                      " imbedocno = '", g_imbe_m.imbedocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimt306_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imbe_m.imbeownid      
   LET g_data_dept  = g_imbe_m.imbeowndp
              
   #功能已完成,通報訊息中心
   CALL aimt306_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimt306.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimt306_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   INITIALIZE g_imbe_m_o.* TO NULL
   LET g_imbe_m_o.* = g_imbe_m.*      #保存單頭舊值
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimt306_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            CALL aimt306_imbedocno_ref(g_imbe_m.imbedocno) RETURNING g_imbe_m.imbedocno_desc,g_imbe_m.imba000,g_imbe_m.imbadocdt,g_imbe_m.imba001,g_imbe_m.imba002,g_imbe_m.imbal002,g_imbe_m.imbal003,g_imbe_m.imbal004,g_imbe_m.imba009,g_imbe_m.imba003,g_imbe_m.imba004,g_imbe_m.imba005,g_imbe_m.imba006,g_imbe_m.imba010,g_imbe_m.status1,g_imbe_m.imba900,g_imbe_m.imba901
            DISPLAY BY NAME g_imbe_m.imbedocno_desc,g_imbe_m.imba000,g_imbe_m.imbadocdt,g_imbe_m.imba001,g_imbe_m.imba002,g_imbe_m.imbal002,g_imbe_m.imbal003,g_imbe_m.imbal004,g_imbe_m.imba009,g_imbe_m.imba003,g_imbe_m.imba004,g_imbe_m.imba005,g_imbe_m.imba006,g_imbe_m.imba010,g_imbe_m.status1
            DISPLAY BY NAME g_imbe_m.status1,g_imbe_m.imba900,g_imbe_m.imba901
            
            CALL aimt306_imba900_ref(g_imbe_m.imba900) RETURNING g_imbe_m.imba900_desc
            DISPLAY BY NAME g_imbe_m.imba900_desc
            
            CALL aimt306_imba901_ref(g_imbe_m.imba901) RETURNING g_imbe_m.imba901_desc
            DISPLAY BY NAME g_imbe_m.imba901_desc
            
            CALL aimt306_imba009_ref(g_imbe_m.imba009) RETURNING g_imbe_m.imba009_desc
            DISPLAY BY NAME g_imbe_m.imba009_desc

            CALL aimt306_imba003_ref(g_imbe_m.imba003) RETURNING g_imbe_m.imba003_desc
            DISPLAY BY NAME g_imbe_m.imba003_desc

            CALL aimt306_imba005_ref(g_imbe_m.imba005) RETURNING g_imbe_m.imba005_desc
            DISPLAY BY NAME g_imbe_m.imba005_desc

            CALL aimt306_imba006_ref(g_imbe_m.imba006) RETURNING g_imbe_m.imba006_desc
            DISPLAY BY NAME g_imbe_m.imba006_desc

            CALL aimt306_imba010_ref(g_imbe_m.imba010) RETURNING g_imbe_m.imba010_desc
            DISPLAY BY NAME g_imbe_m.imba010_desc

            #CALL aimt306_imbe111_ref(g_imbe_m.imbe111) RETURNING g_imbe_m.imbe111_desc
            #DISPLAY BY NAME g_imbe_m.imbe111_desc
            #
            #CALL aimt306_imbe112_ref(g_imbe_m.imbe112) RETURNING g_imbe_m.imbe112_desc
            #DISPLAY BY NAME g_imbe_m.imbe112_desc
            #
            #CALL aimt306_imbe113_ref(g_imbe_m.imbe113) RETURNING g_imbe_m.imbe113_desc
            #DISPLAY BY NAME g_imbe_m.imbe113_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imbe_m.imbeownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imbe_m.imbeownid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imbe_m.imbeownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imbe_m.imbeowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imbe_m.imbeowndp_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imbe_m.imbeowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imbe_m.imbecrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imbe_m.imbecrtid_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_imbe_m.imbecrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imbe_m.imbecrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imbe_m.imbecrtdp_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_imbe_m.imbecrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imbe_m.imbemodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imbe_m.imbemodid_desc =g_rtn_fields[1] 
            DISPLAY BY NAME g_imbe_m.imbemodid_desc

           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_imbe_m.imbecnfid
           #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
           #LET g_imbe_m.imbecnfid_desc = g_rtn_fields[1]
           #DISPLAY BY NAME g_imbe_m.imbecnfid_desc

           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_imbe_m.imbepstid
           #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
           #LET g_imbe_m.imbepstid_desc =  g_rtn_fields[1]
           #DISPLAY BY NAME g_imbe_m.imbepstid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imbe_m.imbedocno,g_imbe_m.fflabel1,g_imbe_m.imbadocdt,g_imbe_m.fflabel3,g_imbe_m.imba900, 
       g_imbe_m.imba900_desc,g_imbe_m.imbedocno_desc,g_imbe_m.fflabel2,g_imbe_m.imba000,g_imbe_m.fflabel4, 
       g_imbe_m.imba901,g_imbe_m.imba901_desc,g_imbe_m.imba001,g_imbe_m.imba002,g_imbe_m.imbal002,g_imbe_m.imbal003, 
       g_imbe_m.imbal004,g_imbe_m.imba009,g_imbe_m.imba009_desc,g_imbe_m.imba003,g_imbe_m.imba003_desc, 
       g_imbe_m.imba004,g_imbe_m.imba005,g_imbe_m.imba005_desc,g_imbe_m.imba006,g_imbe_m.imba006_desc, 
       g_imbe_m.imba010,g_imbe_m.imba010_desc,g_imbe_m.status1,g_imbe_m.imbe111,g_imbe_m.imbe111_desc, 
       g_imbe_m.imbe112,g_imbe_m.imbe112_desc,g_imbe_m.imbe113,g_imbe_m.imbe113_desc,g_imbe_m.imbe114, 
       g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117,g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeownid_desc, 
       g_imbe_m.imbeowndp,g_imbe_m.imbeowndp_desc,g_imbe_m.imbecrtid,g_imbe_m.imbecrtid_desc,g_imbe_m.imbecrtdp, 
       g_imbe_m.imbecrtdp_desc,g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemodid_desc,g_imbe_m.imbemoddt, 
       g_imbe_m.imbe118,g_imbe_m.imbe119
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimt306_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimt306.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimt306_delete()
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
   IF g_imbe_m.imbedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imbedocno_t = g_imbe_m.imbedocno
 
   
   
 
   OPEN aimt306_cl USING g_enterprise, g_site,g_imbe_m.imbedocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimt306_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimt306_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimt306_master_referesh USING g_site,g_imbe_m.imbedocno INTO g_imbe_m.imbedocno,g_imbe_m.imbe111, 
       g_imbe_m.imbe112,g_imbe_m.imbe113,g_imbe_m.imbe114,g_imbe_m.imbe115,g_imbe_m.imbe116,g_imbe_m.imbe117, 
       g_imbe_m.imbe120,g_imbe_m.imbeownid,g_imbe_m.imbeowndp,g_imbe_m.imbecrtid,g_imbe_m.imbecrtdp, 
       g_imbe_m.imbecrtdt,g_imbe_m.imbemodid,g_imbe_m.imbemoddt,g_imbe_m.imbe118,g_imbe_m.imbe119,g_imbe_m.imbe111_desc, 
       g_imbe_m.imbe112_desc,g_imbe_m.imbe113_desc,g_imbe_m.imbeownid_desc,g_imbe_m.imbeowndp_desc,g_imbe_m.imbecrtid_desc, 
       g_imbe_m.imbecrtdp_desc,g_imbe_m.imbemodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aimt306_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imbe_m_mask_o.* =  g_imbe_m.*
   CALL aimt306_imbe_t_mask()
   LET g_imbe_m_mask_n.* =  g_imbe_m.*
   
   #將最新資料顯示到畫面上
   CALL aimt306_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimt306_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imbe_t 
       WHERE imbeent = g_enterprise AND imbesite = g_site AND imbedocno = g_imbe_m.imbedocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imbe_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimt306_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimt306_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimt306_browser_fill(g_wc,"")
         CALL aimt306_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimt306_cl
 
   #功能已完成,通報訊息中心
   CALL aimt306_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimt306.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimt306_ui_browser_refresh()
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
      IF g_browser[l_i].b_imbedocno = g_imbe_m.imbedocno
 
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
 
{<section id="aimt306.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimt306_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imbedocno",TRUE)
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
 
{<section id="aimt306.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimt306_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imbedocno",FALSE)
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
 
{<section id="aimt306.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimt306_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimt306.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimt306_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimt306.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimt306_default_search()
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
      LET ls_wc = ls_wc, " imbedocno = '", g_argv[01], "' AND "
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
      LET g_wc  = " imbesite = '",g_argv[1],"' "
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc  = g_wc," AND imbedocno = '",g_argv[02],"' "
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
 
{<section id="aimt306.mask_functions" >}
&include "erp/aim/aimt306_mask.4gl"
 
{</section>}
 
{<section id="aimt306.state_change" >}
   
 
{</section>}
 
{<section id="aimt306.signature" >}
   
 
{</section>}
 
{<section id="aimt306.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimt306_set_pk_array()
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
   LET g_pk_array[1].values = g_imbe_m.imbedocno
   LET g_pk_array[1].column = 'imbedocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt306.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimt306.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimt306_msgcentre_notify(lc_state)
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
   CALL aimt306_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imbe_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt306.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimt306_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimt306.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aimt306_b_imba003_ref(p_imba003)
DEFINE p_imba003      LIKE imba_t.imba003
DEFINE r_imba003_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imba003_desc = '', g_rtn_fields[1] , ''
      RETURN r_imba003_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimt306_imbe113_ref(p_imbe113)
DEFINE p_imbe113      LIKE imbe_t.imbe113
DEFINE p_imbe113_desc LIKE oocal_t.oocal003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imbe113
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET p_imbe113_desc = g_rtn_fields[1] 
      RETURN p_imbe113_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imbe112_ref(p_imbe112)
DEFINE p_imbe112      LIKE imbe_t.imbe112
DEFINE p_imbe112_desc LIKE oofa_t.oofa011

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imbe112
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET p_imbe112_desc = g_rtn_fields[1]
      RETURN p_imbe112_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imbe111_ref(p_imbe111)
DEFINE p_imbe111      LIKE imbe_t.imbe111
DEFINE p_imbe111_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imbe111
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='205' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET p_imbe111_desc = g_rtn_fields[1]
      RETURN p_imbe111_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imbedocno_ref(p_imbedocno)
DEFINE p_imbedocno LIKE imbe_t.imbedocno
DEFINE r_imba000   LIKE imba_t.imba000
DEFINE r_imbadocdt LIKE imba_t.imbadocdt
DEFINE r_imba001   LIKE imba_t.imba001
DEFINE r_imba002   LIKE imba_t.imba002
DEFINE r_imbal002  LIKE imbal_t.imbal002
DEFINE r_imbal003  LIKE imbal_t.imbal003
DEFINE r_imbal004  LIKE imbal_t.imbal004
DEFINE r_imba009   LIKE imba_t.imba009
DEFINE r_imba003   LIKE imba_t.imba003
DEFINE r_imba004   LIKE imba_t.imba004
DEFINE r_imba005   LIKE imba_t.imba005
DEFINE r_imba006   LIKE imba_t.imba006
DEFINE r_imba010   LIKE imba_t.imba010
DEFINE r_imbastus  LIKE imba_t.imbastus
DEFINE r_imba900   LIKE imba_t.imba900
DEFINE r_imba901   LIKE imba_t.imba901
DEFINE l_ooba002   LIKE ooba_t.ooba002
DEFINE l_success      LIKE type_t.num5
DEFINE r_imbedocno_desc  LIKE oobxl_t.oobxl003
DEFINE l_flag          LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_flag1         LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_site          LIKE type_t.chr20


      LET l_flag = TRUE
      LET l_flag1 = TRUE
      LET l_ooba002 = NULL
      LET r_imbedocno_desc = ""
      IF NOT cl_null(g_imbe_m.imbedocno) THEN
         CALL s_aooi200_get_slip(g_imbe_m.imbedocno) RETURNING l_flag1,l_ooba002
         IF l_flag1 THEN
            IF NOT cl_null(l_ooba002) THEN
               SELECT oobxl003 INTO r_imbedocno_desc
                 FROM oobxl_t
                WHERE oobxl001 = l_ooba002
                  AND oobxl002 = g_dlang
                  AND oobxlent = g_enterprise
            ELSE
               LET r_imbedocno_desc = ""
            END IF
         END IF
      ELSE
         LET r_imbedocno_desc = ""
      END IF
      
      LET r_imba000 = NULL
      LET r_imbadocdt = NULL
      LET r_imba001 = NULL
      LET r_imba002 = NULL
      LET r_imba009 = NULL
      LET r_imba003 = NULL
      LET r_imba004 = NULL
      LET r_imba005 = NULL
      LET r_imba006 = NULL
      LET r_imba010 = NULL
      LET r_imbastus = NULL
      LET r_imba900 = NULL
      LET r_imba901 = NULL
      
      SELECT imba000,imbadocdt,imba001,imba002,imba009,imba003,imba004,imba005,imba006,imba010,imbastus,imba900,imba901
        INTO r_imba000,r_imbadocdt,r_imba001,r_imba002,r_imba009,r_imba003,r_imba004,r_imba005,r_imba006,r_imba010,r_imbastus,r_imba900,r_imba901
        FROM imba_t WHERE imbaent = g_enterprise AND imbadocno = p_imbedocno
        
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imbedocno
      CALL ap_ref_array2(g_ref_fields,"SELECT imbal002,imbal003,imbal004 FROM imbal_t WHERE imbalent='"||g_enterprise||"' AND imbaldocno=? AND imbal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imbal002 = g_rtn_fields[1]
      LET r_imbal003 = g_rtn_fields[2]
      LET r_imbal004 = g_rtn_fields[3]
      
      RETURN r_imbedocno_desc,r_imba000,r_imbadocdt,r_imba001,r_imba002,r_imbal002,r_imbal003,r_imbal004,r_imba009,r_imba003,r_imba004,r_imba005,r_imba006,r_imba010,r_imbastus,r_imba900,r_imba901
END FUNCTION
#+
PRIVATE FUNCTION aimt306_imba010_ref(p_imba010)
DEFINE p_imba010      LIKE imba_t.imba010     
DEFINE r_imba010_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba010
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imba010_desc = g_rtn_fields[1]
      RETURN r_imba010_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imba003_ref(p_imba003)
DEFINE p_imba003      LIKE imba_t.imba003      
DEFINE r_imba003_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imba003_desc = g_rtn_fields[1] 
      RETURN r_imba003_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimt306_b_imbedocno_ref(p_imbedocno)
DEFINE p_imbedocno LIKE imbe_t.imbedocno
DEFINE r_imba000   LIKE imba_t.imba000
DEFINE r_imbadocdt LIKE imba_t.imbadocdt
DEFINE r_imba001   LIKE imba_t.imba001
DEFINE r_imba009   LIKE imba_t.imba009
DEFINE r_imba003   LIKE imba_t.imba003
DEFINE r_imbal002  LIKE imbal_t.imbal002
DEFINE r_imbal003  LIKE imbal_t.imbal003
     
      LET r_imbadocdt = NULL
      LET r_imba000 = NULL
      LET r_imba001 = NULL
      LET r_imba009 = NULL
      LET r_imba003 = NULL
      SELECT imba000,imbadocdt,imba001,imba009,imba003 INTO r_imba000,r_imbadocdt,r_imba001,r_imba009,r_imba003
        FROM imba_t WHERE imbaent = g_enterprise AND imbadocno = p_imbedocno
        
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imbedocno
      CALL ap_ref_array2(g_ref_fields,"SELECT imbal002,imbal003 FROM imbal_t WHERE imbalent='"||g_enterprise||"' AND imbaldocno=? AND imbal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imbal002 = '',g_rtn_fields[1],''
      LET r_imbal003 = '',g_rtn_fields[2],'' 
      RETURN r_imba000,r_imbadocdt,r_imba001,r_imbal002,r_imbal003,r_imba009,r_imba003
     
END FUNCTION
#+
PRIVATE FUNCTION aimt306_b_imba009_ref(p_imba009)
DEFINE p_imba009      LIKE imba_t.imba009
DEFINE r_imba009_desc LIKE rtaxl_t.rtaxl003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba009
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET r_imba009_desc = '', g_rtn_fields[1] , ''
      RETURN r_imba009_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imba009_ref(p_imba009)
DEFINE p_imba009      LIKE imba_t.imba009      
DEFINE r_imba009_desc LIKE rtaxl_t.rtaxl003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba009
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imba009_desc = g_rtn_fields[1]
      RETURN r_imba009_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imba006_ref(p_imba006)
DEFINE p_imba006      LIKE imba_t.imba006      
DEFINE r_imba006_desc LIKE oocal_t.oocal003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imba006_desc = g_rtn_fields[1]
      RETURN r_imba006_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imba005_ref(p_imba005)
DEFINE p_imba005      LIKE imba_t.imba005      
DEFINE r_imba005_desc LIKE imeal_t.imeal003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba005
      CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"' ","") RETURNING g_rtn_fields
      LET r_imba005_desc = g_rtn_fields[1]
      RETURN r_imba005_desc

END FUNCTION
#+
PRIVATE FUNCTION aimt306_imba901_ref(p_imba901)
DEFINE p_imba901      LIKE imba_t.imba901
DEFINE r_imba901_desc LIKE ooefl_t.ooefl003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba901
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imba901_desc= g_rtn_fields[1]
      RETURN r_imba901_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimt306_imba900_ref(p_imba900)
DEFINE p_imba900      LIKE imba_t.imba900
DEFINE r_imba900_desc LIKE oofa_t.oofa011

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imba900
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET r_imba900_desc = g_rtn_fields[1]
      RETURN r_imba900_desc

END FUNCTION
################################################################################
# Descriptions...: 重新带料件分群资料
# Usage..........: CALL aimt306_get_imcg()
# Date & Author..: 2014/02/17 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION aimt306_get_imcg()
#DEFINE l_imcg    RECORD LIKE imcg_t.*  #161124-00048#3   2016/12/08 By 08734 mark
#161124-00048#3   2016/12/08 By 08734 add(S)
DEFINE l_imcg RECORD  #料件據點品管分群檔
       imcgent LIKE imcg_t.imcgent, #企业编号
       imcgownid LIKE imcg_t.imcgownid, #资料所有者
       imcgowndp LIKE imcg_t.imcgowndp, #资料所有部门
       imcgcrtid LIKE imcg_t.imcgcrtid, #资料录入者
       imcgcrtdt LIKE imcg_t.imcgcrtdt, #资料创建日
       imcgcrtdp LIKE imcg_t.imcgcrtdp, #资料录入部门
       imcgmodid LIKE imcg_t.imcgmodid, #资料更改者
       imcgmoddt LIKE imcg_t.imcgmoddt, #最近更改日
       imcgstus LIKE imcg_t.imcgstus, #状态码
       imcgsite LIKE imcg_t.imcgsite, #营运据点
       imcg111 LIKE imcg_t.imcg111, #品管分群
       imcg112 LIKE imcg_t.imcg112, #品管员
       imcg113 LIKE imcg_t.imcg113, #检验单位
       imcg114 LIKE imcg_t.imcg114, #进料检验否
       imcg115 LIKE imcg_t.imcg115, #检验程度
       imcg116 LIKE imcg_t.imcg116, #检验水准
       imcg117 LIKE imcg_t.imcg117, #检验级数
       imcg118 LIKE imcg_t.imcg118, #库存失效提前通知天数
       imcg119 LIKE imcg_t.imcg119, #检验标准工时
       imcg120 LIKE imcg_t.imcg120 #使用品检判定等级功能
END RECORD
#161124-00048#3   2016/12/08 By 08734 add(E)

   INITIALIZE l_imcg.* TO NULL
   #SELECT * INTO l_imcg.* FROM imcg_t  #161124-00048#3   2016/12/08 By 08734 mark 
   SELECT imcgent,imcgownid,imcgowndp,imcgcrtid,imcgcrtdt,imcgcrtdp,imcgmodid,imcgmoddt,imcgstus,imcgsite,imcg111,imcg112,imcg113,imcg114,imcg115,imcg116,imcg117,imcg118,imcg119,imcg120  #161124-00048#3   2016/12/08 By 08734 add 
     INTO l_imcg.*
     FROM imcg_t
    WHERE imcgent = g_enterprise
      AND imcgsite = g_site
      AND imcg111 = g_imbe_m.imbe111
   LET g_imbe_m.imbe112 = l_imcg.imcg112
   LET g_imbe_m.imbe113 = l_imcg.imcg113
   LET g_imbe_m.imbe114 = l_imcg.imcg114
   LET g_imbe_m.imbe115 = l_imcg.imcg115
   LET g_imbe_m.imbe116 = l_imcg.imcg116
   LET g_imbe_m.imbe117 = l_imcg.imcg117
   LET g_imbe_m.imbe118 = l_imcg.imcg118
   LET g_imbe_m.imbe119 = l_imcg.imcg119
   LET g_imbe_m.imbe120 = l_imcg.imcg120
   
   IF cl_null(g_imbe_m.imbe113) THEN
      LET g_imbe_m.imbe113 = g_imbe_m.imba006
   END IF
   
   DISPLAY BY NAME g_imbe_m.imbe112,g_imbe_m.imbe113,g_imbe_m.imbe114,g_imbe_m.imbe115, 
     g_imbe_m.imbe116,g_imbe_m.imbe117,g_imbe_m.imbe120,g_imbe_m.imbe118,g_imbe_m.imbe119
     
   CALL aimt306_imbe112_ref(g_imbe_m.imbe112) RETURNING g_imbe_m.imbe112_desc
   DISPLAY BY NAME g_imbe_m.imbe112_desc

   CALL aimt306_imbe113_ref(g_imbe_m.imbe113) RETURNING g_imbe_m.imbe113_desc
   DISPLAY BY NAME g_imbe_m.imbe113_desc
            
   
END FUNCTION

 
{</section>}
 
