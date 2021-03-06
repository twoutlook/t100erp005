#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi714.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2015-12-22 18:08:28), PR版次:0013(2016-10-03 15:42:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000354
#+ Filename...: aooi714
#+ Description: 收款條件維護作業
#+ Creator....: 02295(2013-09-25 09:17:13)
#+ Modifier...: 02599 -SD/PR- 05599
 
{</section>}
 
{<section id="aooi714.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#151216-00008#1   2015/12/22   By 02599     增加字段ooib026尾款性质
#160107-00003#11  2016/02/18   By catmoon   交易認定日是帳齡分析在用的，不應該出現在aooi716/aooi714
#160318-00005#33  2016/03/27   By 07900     重复错误信息修改
#160623-00020#1   2016/06/24   By xianghui  树状结构中付款兑现日组出的字符串不对
#160929-00022#1   2016/10/03   By charles4m 依參數調整對應的開窗，否則付款條件會開到收款條件的窗
#160929-00023#1   2016/10/03   By charles4m ooib011、ooib021 新增時，預設值給 05
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
PRIVATE TYPE type_g_ooib_m RECORD
       ooib002 LIKE ooib_t.ooib002, 
   ooibl004 LIKE ooibl_t.ooibl004, 
   ooib004 LIKE ooib_t.ooib004, 
   ooib006 LIKE ooib_t.ooib006, 
   ooib007 LIKE ooib_t.ooib007, 
   ooib026 LIKE ooib_t.ooib026, 
   ooib025 LIKE ooib_t.ooib025, 
   ooib025_desc LIKE type_t.chr80, 
   ooib005 LIKE ooib_t.ooib005, 
   ooib005_desc LIKE type_t.chr80, 
   ooib001 LIKE ooib_t.ooib001, 
   ooib011 LIKE ooib_t.ooib011, 
   ooib012 LIKE ooib_t.ooib012, 
   ooib013 LIKE ooib_t.ooib013, 
   ooib014 LIKE ooib_t.ooib014, 
   ooib021 LIKE ooib_t.ooib021, 
   ooib022 LIKE ooib_t.ooib022, 
   ooib023 LIKE ooib_t.ooib023, 
   ooib024 LIKE ooib_t.ooib024, 
   ooibstus LIKE ooib_t.ooibstus, 
   ooibownid LIKE ooib_t.ooibownid, 
   ooibownid_desc LIKE type_t.chr80, 
   ooibowndp LIKE ooib_t.ooibowndp, 
   ooibowndp_desc LIKE type_t.chr80, 
   ooibcrtid LIKE ooib_t.ooibcrtid, 
   ooibcrtid_desc LIKE type_t.chr80, 
   ooibcrtdp LIKE ooib_t.ooibcrtdp, 
   ooibcrtdp_desc LIKE type_t.chr80, 
   ooibcrtdt LIKE ooib_t.ooibcrtdt, 
   ooibmodid LIKE ooib_t.ooibmodid, 
   ooibmodid_desc LIKE type_t.chr80, 
   ooibmoddt LIKE ooib_t.ooibmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
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
            b_ooib002 LIKE ooib_t.ooib002,
      b_ooib001 LIKE ooib_t.ooib001,
      b_ooib004 LIKE ooib_t.ooib004,
   b_date1 LIKE type_t.chr80,
   b_date2 LIKE type_t.chr80,
      b_ooib006 LIKE ooib_t.ooib006,
      b_ooibstus LIKE ooib_t.ooibstus
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_ooib_m        type_g_ooib_m  #單頭變數宣告
DEFINE g_ooib_m_t      type_g_ooib_m  #單頭舊值宣告(系統還原用)
DEFINE g_ooib_m_o      type_g_ooib_m  #單頭舊值宣告(其他用途)
DEFINE g_ooib_m_mask_o type_g_ooib_m  #轉換遮罩前資料
DEFINE g_ooib_m_mask_n type_g_ooib_m  #轉換遮罩後資料
 
   DEFINE g_ooib002_t LIKE ooib_t.ooib002
 
   
#應用 a54 樣板自動產生(Version:3)
DEFINE g_browser_expand   DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
      b_ooib001 STRING
      END RECORD 
 
 
 
 
   
DEFINE g_master_multi_table_t    RECORD
      ooibl002 LIKE ooibl_t.ooibl002,
      ooibl004 LIKE ooibl_t.ooibl004
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
 
{<section id="aooi714.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT ooib002,'',ooib004,ooib006,ooib007,ooib026,ooib025,'',ooib005,'',ooib001, 
       ooib011,ooib012,ooib013,ooib014,ooib021,ooib022,ooib023,ooib024,ooibstus,ooibownid,'',ooibowndp, 
       '',ooibcrtid,'',ooibcrtdp,'',ooibcrtdt,ooibmodid,'',ooibmoddt", 
                      " FROM ooib_t",
                      " WHERE ooibent= ? AND ooib002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi714_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.ooib002,t0.ooib004,t0.ooib006,t0.ooib007,t0.ooib026,t0.ooib025,t0.ooib005, 
       t0.ooib001,t0.ooib011,t0.ooib012,t0.ooib013,t0.ooib014,t0.ooib021,t0.ooib022,t0.ooib023,t0.ooib024, 
       t0.ooibstus,t0.ooibownid,t0.ooibowndp,t0.ooibcrtid,t0.ooibcrtdp,t0.ooibcrtdt,t0.ooibmodid,t0.ooibmoddt, 
       t1.oocql004 ,t2.ooidl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011",
               " FROM ooib_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='3114' AND t1.oocql002=t0.ooib025 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooidl_t t2 ON t2.ooidlent="||g_enterprise||" AND t2.ooidl001=t0.ooib005 AND t2.ooidl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.ooibownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.ooibowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.ooibcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.ooibcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.ooibmodid  ",
 
               " WHERE t0.ooibent = " ||g_enterprise|| " AND t0.ooib002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aooi714_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi714 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi714_init()   
 
      #進入選單 Menu (="N")
      CALL aooi714_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi714
      
   END IF 
   
   CLOSE aooi714_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi714.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aooi714_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql      STRING
   DEFINE l_str      STRING 
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002  
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_main_hidden = 0
   #定義combobox狀態
      CALL cl_set_combo_scc_part('ooibstus','17','N,Y')
 
      CALL cl_set_combo_scc('ooib004','8310') 
   CALL cl_set_combo_scc('ooib026','8335') 
   CALL cl_set_combo_scc('ooib011','8312') 
   CALL cl_set_combo_scc('ooib021','8312') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('ooib001','46')
   CALL cl_set_combo_scc('b_ooib004','8310') 
   CALL cl_set_combo_scc('b_ooib006','8016') 
   CALL cl_set_combo_scc_part('b_ooibstus','17','N,Y')
   
  #LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8312' AND gzcb002 NOT IN ('90','91','01','92')"           #160107-00003#11 mark
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8312' AND gzcb002 NOT IN ('90','91','01','92','09','10')" #160107-00003#11 add
   PREPARE ooib011_pre FROM l_sql
   DECLARE ooib011_cur CURSOR FOR ooib011_pre
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH ooib011_cur INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH

   CALL cl_set_combo_scc_part('ooib011','8312',l_str)
   
  #LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8312' AND gzcb002 NOT IN ('01','92')"            #160107-00003#11 mark
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8312' AND gzcb002 NOT IN ('01','92','09','10')"  #160107-00003#11 add
   PREPARE ooib011_pre2 FROM l_sql
   DECLARE ooib011_cur2 CURSOR FOR ooib011_pre2
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH ooib011_cur2 INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   
   CALL cl_set_combo_scc_part('ooib021','8312',l_str)
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aooi714_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aooi714.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aooi714_ui_dialog() 
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aooi714_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL aooi714_display()
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_ooib_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aooi714_init()
      END IF
      
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_worksheet_hidden = 1 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL aooi714_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aooi714_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aooi714_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aooi714_set_act_visible()
               CALL aooi714_set_act_no_visible()
               IF NOT (g_ooib_m.ooib002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " ooibent = " ||g_enterprise|| " AND",
                                     " ooib002 = '", g_ooib_m.ooib002, "' "
 
                  #填到對應位置
                  CALL aooi714_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aooi714_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aooi714_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aooi714_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aooi714_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aooi714_fetch("L")  
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
                  CALL aooi714_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aooi714_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aooi714_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi714_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi714_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi714_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aooi714_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi714_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_ooib004
            LET g_action_choice="prog_ooib004"
            IF cl_auth_chk_act("prog_ooib004") THEN
               
               #add-point:ON ACTION prog_ooib004 name="menu2.prog_ooib004"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               LET la_param.prog     = 'azzi600'
               LET la_param.param[1] = g_ooib_m.ooib004

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi714_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi714_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi714_set_pk_array()
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
           
            #快速搜尋(樹狀專用)
            INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
               BEFORE INPUT
            
            END INPUT
      
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
                  CALL aooi714_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               #應用 a53 樣板自動產生(Version:3)
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL aooi714_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
                  LET g_browser_expand[g_browser_expand.getLength()+1].b_ooib001 = g_browser[g_row_index].b_ooib001
                  
               ON COLLAPSE (g_row_index)
                  #樹關閉
 
 
 
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL aooi714_browser_fill(g_wc,"")
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
                  CALL aooi714_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aooi714_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aooi714_set_act_visible()
               CALL aooi714_set_act_no_visible()
               IF NOT (g_ooib_m.ooib002 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " ooibent = " ||g_enterprise|| " AND",
                                     " ooib002 = '", g_ooib_m.ooib002, "' "
 
                  #填到對應位置
                  CALL aooi714_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL aooi714_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aooi714_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aooi714_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aooi714_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aooi714_fetch("L")  
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
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/mainhidden.png")
                  LET g_main_hidden = 1
               END IF
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 1
               END IF
         
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
 
            #快速搜尋(樹狀專用)
            ON ACTION searchdata
               LET g_current_idx = 1
               LET g_searchstr = GET_FLDBUF(searchstr)
               CALL aooi714_browser_search()
               EXIT DIALOG
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aooi714_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aooi714_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aooi714_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi714_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi714_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi714_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aooi714_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi714_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_ooib004
            LET g_action_choice="prog_ooib004"
            IF cl_auth_chk_act("prog_ooib004") THEN
               
               #add-point:ON ACTION prog_ooib004 name="menu.prog_ooib004"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               LET la_param.prog     = 'azzi600'
               LET la_param.param[1] = g_ooib_m.ooib004

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi714_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi714_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi714_set_pk_array()
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
 
{<section id="aooi714.browser_fill" >}
#應用 a30 樣板自動產生(Version:10)
#+ 瀏覽頁簽資料填充(六階樹狀)
PRIVATE FUNCTION aooi714_browser_fill(ps_wc,ps_page_action) 
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE ps_wc              STRING
   DEFINE ps_page_action     STRING
   DEFINE ls_sql             STRING
   DEFINE li_idx             LIKE type_t.num10
   DEFINE li_idx2            LIKE type_t.num10
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   CLEAR FORM
   INITIALIZE g_ooib_m.* TO NULL
   CALL g_browser.clear()
   
   LET ls_sql = " SELECT UNIQUE ooib001 ",
                " FROM ooib_t ",
                "  ",
                "  LEFT JOIN ooibl_t ON ooib002 = ooibl002 AND ooibl003 = '",g_lang,"' ",
                " WHERE ooibent = '" ||g_enterprise|| "' AND ", g_wc
                
   PREPARE browse_pre1 FROM ls_sql
   DECLARE browse_cur1 CURSOR FOR browse_pre1
   
   LET li_idx = 1 
   FOREACH browse_cur1 INTO g_browser[li_idx].b_ooib001
      
      LET g_browser[li_idx].b_pid     = 0
      LET g_browser[li_idx].b_id      = 0, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = TRUE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_show    = g_browser[li_idx].b_ooib001
      CALL aooi714_desc_show(li_idx)      
      CALL aooi714_browser_expand(li_idx)
      LET g_browser[li_idx].b_isExp = 1
      
      #LET li_idx = li_idx + 1
      
      IF li_idx > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #CALL g_browser.deleteElement(g_browser.getLength())
   
   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   
   #CALL aooi714_fetch("") 
   
   FREE browse_pre1
   RETURN
   
   #end add-point
   
   #add-point:Function前置處理 name="browser_fill.before_fill"
   
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_ooib_m.* TO NULL
   CALL g_browser.clear()
    
   LET ls_sql = " SELECT DISTINCT ooib001 ",
                " FROM ooib_t ",
                "  ",
                "  LEFT JOIN ooibl_t ON ooiblent = "||g_enterprise||" AND ooib002 = ooibl002 AND ooibl003 = '",g_dlang,"' ",
                " WHERE ooibent = " ||g_enterprise|| " AND ", g_wc ,cl_sql_add_filter("ooib_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooib_t")             #WC重組           
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料             
   PREPARE browse_pre FROM ls_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   LET li_idx = 1 
   FOREACH browse_cur INTO g_browser[li_idx].b_ooib001
      
      LET g_browser[li_idx].b_pid     = 0
      LET g_browser[li_idx].b_id      = 0, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_show    = g_browser[li_idx].b_ooib001
      CALL aooi714_desc_show(li_idx)
      LET li_idx = li_idx + 1
      
      IF li_idx > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF li_idx > g_max_rec AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = li_idx
      LET g_errparam.code   = 9035 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET g_error_show = 0
   
   CALL g_browser.deleteElement(g_browser.getLength())
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   
   #樹展開
   FOR li_idx = 1 TO g_browser.getLength()
      FOR li_idx2 = 1 TO g_browser_expand.getLength()
         IF g_browser_expand[li_idx2].b_ooib001.equals(g_browser[li_idx].b_ooib001)
            THEN
            CALL aooi714_browser_expand(li_idx)
            LET g_browser[li_idx].b_isExp = 1  
            LET g_browser[li_idx].b_exp = TRUE
         END IF 
      END FOR
   END FOR
   
   FREE browse_pre
   
END FUNCTION
 
#+ Tree子節點展開
PRIVATE FUNCTION aooi714_browser_expand(pi_id)
   #add-point:browser_expand段define(客製用) name="browser_expand.define_customerization"
   
   #end add-point
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_type_list     STRING
   DEFINE ls_sql           STRING
   #add-point:browser_expand段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand.define"
   
   #end add-point
   
   #已經展開過或展開leaf
   IF g_browser[pi_id].b_isExp = TRUE OR g_browser[pi_id].b_expcode > (2-1) THEN
      RETURN
   END IF
   
   #leaf展開
   IF g_browser[pi_id].b_expcode = (2-1) THEN
      CALL aooi714_browser_expand_leaf(pi_id)
      RETURN
   END IF
   
   LET li_lv = g_browser[pi_id].b_expcode
   LET g_browser[pi_id].b_isExp = TRUE
   
   CASE li_lv
      WHEN 1
         LET ls_wc = " AND ooib001 = '",g_browser[pi_id].b_ooib001,"' "
         LET ls_type_list = "ooib001"
      WHEN 2               
         LET ls_wc = " AND ooib001 = '", g_browser[pi_id].b_ooib001, "'"
         LET ls_type_list = "ooib001"
      WHEN 3
         LET ls_wc = " AND ooib001 = '", g_browser[pi_id].b_ooib001, "'"
         LET ls_type_list = "ooib001"
      WHEN 4                
         LET ls_wc = " AND ooib001 = '", g_browser[pi_id].b_ooib001, "'"
         LET ls_type_list = "ooib001"
      WHEN 5
         LET ls_wc = " AND ooib001 = '", g_browser[pi_id].b_ooib001, "'"
         LET ls_type_list = "ooib001"
   END CASE
   
   LET ls_sql = " SELECT DISTINCT   ", ls_type_list, 
                " FROM ooib_t ",
                "  ",
                "  LEFT JOIN ooibl_t ON ooiblent = "||g_enterprise||" AND ooib002 = ooibl002 AND ooibl003 = '",g_dlang,"' ",
                " WHERE ooibent = " ||g_enterprise|| " AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
    
   #add-point:browser_expand段before prepare name="browser_expand.before_prepare"
   
   #end add-point
                
   PREPARE expand_pre FROM ls_sql
   DECLARE expand_cur CURSOR FOR expand_pre
   
   LET li_idx = pi_id + 1
   CALL g_browser.insertElement(li_idx)
   FOREACH expand_cur INTO g_browser[li_idx].b_ooib001
      LET g_browser[li_idx].b_pid     = g_browser[pi_id].b_id 
      LET g_browser[li_idx].b_id      = g_browser[pi_id].b_id , ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = li_lv + 1
      LET g_browser[li_idx].b_hasC    = TRUE
      CASE li_lv
         WHEN 1
         WHEN 2
         WHEN 3
         WHEN 4
         WHEN 5
      END CASE
      CALL aooi714_desc_show(li_idx)
      LET li_idx = li_idx + 1
      CALL g_browser.insertElement(li_idx)
   END FOREACH
   
   CALL g_browser.deleteElement(li_idx)
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
 
END FUNCTION
 
#+ Tree leaf節點展開
PRIVATE FUNCTION aooi714_browser_expand_leaf(pi_id)
   #add-point:browser_expand_leaf段define(客製用) name="browser_expand_leaf.define_customerization"
   
   #end add-point
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_sql           STRING
   DEFINE ls_type_list     STRING
   #add-point:browser_expand_leaf段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand_leaf.define"
   DEFINE l_season         LIKE type_t.chr10
   DEFINE l_month          LIKE type_t.chr10
   DEFINE l_days           LIKE type_t.chr10
   
   LET l_season = cl_getmsg('aoo-00214',g_lang)
   LET l_month = cl_getmsg('aoo-00215',g_lang)
   LET l_days = cl_getmsg('aoo-00216',g_lang)
   #end add-point
   
   LET ls_wc = " AND ooib001 = '", g_browser[pi_id].b_ooib001, "'"
 
   LET ls_sql = " SELECT DISTINCT t0.ooib002,t0.ooib001,t0.ooib004,t0.ooib006,t0.ooibstus ",
                " FROM ooib_t t0 ",
                "  ",
                
               " LEFT JOIN ooibl_t ON ooiblent = "||g_enterprise||" AND ooib002 = ooibl002 AND ooibl003 = '",g_dlang,"' ",
                " WHERE ooibent = " ||g_enterprise|| " AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
          
   LET ls_sql = ls_sql, " ORDER BY t0.ooib002"
          
   #add-point:browser_expand_leaf段before prepare name="browser_expand_leaf.before_prepare"
   LET ls_sql = " SELECT DISTINCT ooib002,ooib001,ooib004,(ooib011||':'||a.gzcbl004||'/'||ooib012||'"||l_season||"'||ooib013||'"||l_month||"'||ooib014||'"||l_days||"'),(ooib021||':'||b.gzcbl004||'/'||ooib022||'"||l_season||"'||ooib023||'"||l_month||"'||ooib024||'"||l_days||"'),ooib006,ooibstus ",
                " FROM ooib_t ",
                "      LEFT JOIN gzcbl_t a ON a.gzcbl001 = '8312' AND a.gzcbl002 = ooib011 AND a.gzcbl003 = '",g_lang,"'",
                #"      LEFT JOIN gzcbl_t b ON b.gzcbl001 = '8312' AND b.gzcbl002 = ooib011 AND b.gzcbl003 = '",g_lang,"'",  #160623-00020#1 mark
                "      LEFT JOIN gzcbl_t b ON b.gzcbl001 = '8312' AND b.gzcbl002 = ooib021 AND b.gzcbl003 = '",g_lang,"'",  #160623-00020#1 add
                "  LEFT JOIN ooibl_t ON ooib002 = ooibl002 AND ooibl003 = '",g_lang,"' ",
                " WHERE ooibent = '" ||g_enterprise|| "' AND ", g_wc, ls_wc
                
   LET ls_sql = ls_sql, " ORDER BY ooib002"              
   PREPARE leaf_pre2 FROM ls_sql
   DECLARE leaf_cur2 CURSOR FOR leaf_pre2
   
   LET g_cnt = pi_id + 1
   CALL g_browser.insertElement(g_cnt)
   FOREACH leaf_cur2 INTO g_browser[g_cnt].b_ooib002,g_browser[g_cnt].b_ooib001,g_browser[g_cnt].b_ooib004, 
       g_browser[g_cnt].b_date1,g_browser[g_cnt].b_date2,
       g_browser[g_cnt].b_ooib006,g_browser[g_cnt].b_ooibstus
      LET g_browser[g_cnt].b_pid     = g_browser[pi_id].b_id 
      LET g_browser[g_cnt].b_id      = g_browser[pi_id].b_id , ".", g_cnt USING "<<<"
      LET g_browser[g_cnt].b_exp     = FALSE
      LET g_browser[g_cnt].b_expcode = li_lv + 1
      LET g_browser[g_cnt].b_hasC    = FALSE
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_ooib002
      CALL aooi714_desc_show(g_cnt)
      LET g_cnt = g_cnt + 1
      CALL g_browser.insertElement(g_cnt)
   END FOREACH
   
   CALL g_browser.deleteElement(g_cnt)
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   RETURN   
   #end add-point 
          
   PREPARE leaf_pre FROM ls_sql
   DECLARE leaf_cur CURSOR FOR leaf_pre
   
   LET g_cnt = pi_id + 1
   CALL g_browser.insertElement(g_cnt)
   FOREACH leaf_cur INTO g_browser[g_cnt].b_ooib002,g_browser[g_cnt].b_ooib001,g_browser[g_cnt].b_ooib004, 
       g_browser[g_cnt].b_ooib006,g_browser[g_cnt].b_ooibstus
      LET g_browser[g_cnt].b_pid     = g_browser[pi_id].b_id 
      LET g_browser[g_cnt].b_id      = g_browser[pi_id].b_id , ".", g_cnt USING "<<<"
      LET g_browser[g_cnt].b_exp     = FALSE
      LET g_browser[g_cnt].b_expcode = li_lv + 1
      LET g_browser[g_cnt].b_hasC    = FALSE
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_ooib002
      CALL aooi714_desc_show(g_cnt)
      LET g_cnt = g_cnt + 1
      CALL g_browser.insertElement(g_cnt)
   END FOREACH
   
   CALL g_browser.deleteElement(g_cnt)
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
                      
END FUNCTION
 
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION aooi714_desc_show(pi_ac)
   #add-point:desc_show段define (客製用) name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   #add-point:desc_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   
   #end add-point
   
   LET li_tmp = g_cnt
   LET g_cnt = pi_ac
   
   #add-point:desc_show段desc處理 name="desc_show.show"
   IF g_cnt = 1 THEN
      IF g_argv[1] ='2' THEN 
         LET g_browser[g_cnt].b_show = cl_getmsg('aoo-00208',g_lang)
      ELSE
         LET g_browser[g_cnt].b_show = cl_getmsg('aoo-00209',g_lang)
      END IF
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_ooib002
      CALL ap_ref_array2(g_ref_fields," SELECT ooibl004 FROM ooibl_t WHERE ooiblent = '"||g_enterprise||"' AND ooibl002 = ? AND ooibl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
      LET g_ooib_m.ooibl004 = g_rtn_fields[1]       
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_ooib002,"(",g_rtn_fields[1],")"
   END IF
   #end add-point
   LET g_cnt = li_tmp
   
END FUNCTION
 
#+ 簡易快速查詢
PRIVATE FUNCTION aooi714_browser_search()
   #add-point:browser_search段define(客製用) name="browser_search.define_customerization"
   
   #END add-point
   DEFINE ls_wc       STRING   #若有輸入g_searchstr時用來代換g_wc的暫存變數
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   IF NOT cl_null(g_searchstr) THEN
      LET ls_wc = " lower(", g_searchcol, ") LIKE '", g_searchstr, "%'"
      LET ls_wc = ls_wc.toLowerCase()
   ELSE
      LET ls_wc = " 1=1 "
   END IF

   LET g_wc = ls_wc," AND ooib001 = '",g_argv[1],"'"
   RETURN
   #END add-point
   
   IF NOT cl_null(g_searchstr) THEN
      LET ls_wc = " lower(", g_searchcol, ") LIKE '", g_searchstr, "%'"
      LET ls_wc = ls_wc.toLowerCase()
   ELSE
      LET ls_wc = " 1=1 "
   END IF
 
   LET g_wc = ls_wc
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi714.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi714_construct()
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
   INITIALIZE g_ooib_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON ooib002,ooibl004,ooib004,ooib006,ooib007,ooib026,ooib025,ooib005,ooib001, 
          ooib011,ooib012,ooib013,ooib014,ooib021,ooib022,ooib023,ooib024,ooibstus,ooibownid,ooibowndp, 
          ooibcrtid,ooibcrtdp,ooibcrtdt,ooibmodid,ooibmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<ooibcrtdt>>----
         AFTER FIELD ooibcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<ooibmoddt>>----
         AFTER FIELD ooibmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ooibcnfdt>>----
         
         #----<<ooibpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.ooib002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib002
            #add-point:ON ACTION controlp INFIELD ooib002 name="construct.c.ooib002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
           #CALL q_ooib001_1()                           #呼叫開窗 #160929-00022#1 mark
           #160929-00022#1 ---add (s)---
            IF g_argv[1] = '2' THEN
               CALL q_ooib001_1()                        #呼叫開窗
            ELSE
               CALL q_ooib001_2()
            END IF
           #160929-00022#1 ---add (e)---
            DISPLAY g_qryparam.return1 TO ooib002  #顯示到畫面上

            NEXT FIELD ooib002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib002
            #add-point:BEFORE FIELD ooib002 name="construct.b.ooib002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib002
            
            #add-point:AFTER FIELD ooib002 name="construct.a.ooib002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibl004
            #add-point:BEFORE FIELD ooibl004 name="construct.b.ooibl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibl004
            
            #add-point:AFTER FIELD ooibl004 name="construct.a.ooibl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooibl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibl004
            #add-point:ON ACTION controlp INFIELD ooibl004 name="construct.c.ooibl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib004
            #add-point:BEFORE FIELD ooib004 name="construct.b.ooib004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib004
            
            #add-point:AFTER FIELD ooib004 name="construct.a.ooib004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib004
            #add-point:ON ACTION controlp INFIELD ooib004 name="construct.c.ooib004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib006
            #add-point:BEFORE FIELD ooib006 name="construct.b.ooib006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib006
            
            #add-point:AFTER FIELD ooib006 name="construct.a.ooib006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib006
            #add-point:ON ACTION controlp INFIELD ooib006 name="construct.c.ooib006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib007
            #add-point:BEFORE FIELD ooib007 name="construct.b.ooib007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib007
            
            #add-point:AFTER FIELD ooib007 name="construct.a.ooib007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib007
            #add-point:ON ACTION controlp INFIELD ooib007 name="construct.c.ooib007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib026
            #add-point:BEFORE FIELD ooib026 name="construct.b.ooib026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib026
            
            #add-point:AFTER FIELD ooib026 name="construct.a.ooib026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib026
            #add-point:ON ACTION controlp INFIELD ooib026 name="construct.c.ooib026"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooib025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib025
            #add-point:ON ACTION controlp INFIELD ooib025 name="construct.c.ooib025"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "3114"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooib025  #顯示到畫面上

            NEXT FIELD ooib025                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib025
            #add-point:BEFORE FIELD ooib025 name="construct.b.ooib025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib025
            
            #add-point:AFTER FIELD ooib025 name="construct.a.ooib025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib005
            #add-point:ON ACTION controlp INFIELD ooib005 name="construct.c.ooib005"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
           #CALL q_ooid001_1()                           #呼叫開窗 #160929-00022#1 mark
           #160929-00022#1 ---add (s)---
            IF g_argv[1] = '2' THEN
               CALL q_ooid001_1()                        #呼叫開窗
            ELSE
               CALL q_ooid001_2()
            END IF
           #160929-00022#1 ---add (e)---
            DISPLAY g_qryparam.return1 TO ooib005  #顯示到畫面上

            NEXT FIELD ooib005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib005
            #add-point:BEFORE FIELD ooib005 name="construct.b.ooib005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib005
            
            #add-point:AFTER FIELD ooib005 name="construct.a.ooib005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib001
            #add-point:BEFORE FIELD ooib001 name="construct.b.ooib001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib001
            
            #add-point:AFTER FIELD ooib001 name="construct.a.ooib001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib001
            #add-point:ON ACTION controlp INFIELD ooib001 name="construct.c.ooib001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib011
            #add-point:BEFORE FIELD ooib011 name="construct.b.ooib011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib011
            
            #add-point:AFTER FIELD ooib011 name="construct.a.ooib011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib011
            #add-point:ON ACTION controlp INFIELD ooib011 name="construct.c.ooib011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib012
            #add-point:BEFORE FIELD ooib012 name="construct.b.ooib012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib012
            
            #add-point:AFTER FIELD ooib012 name="construct.a.ooib012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib012
            #add-point:ON ACTION controlp INFIELD ooib012 name="construct.c.ooib012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib013
            #add-point:BEFORE FIELD ooib013 name="construct.b.ooib013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib013
            
            #add-point:AFTER FIELD ooib013 name="construct.a.ooib013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib013
            #add-point:ON ACTION controlp INFIELD ooib013 name="construct.c.ooib013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib014
            #add-point:BEFORE FIELD ooib014 name="construct.b.ooib014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib014
            
            #add-point:AFTER FIELD ooib014 name="construct.a.ooib014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib014
            #add-point:ON ACTION controlp INFIELD ooib014 name="construct.c.ooib014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib021
            #add-point:BEFORE FIELD ooib021 name="construct.b.ooib021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib021
            
            #add-point:AFTER FIELD ooib021 name="construct.a.ooib021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib021
            #add-point:ON ACTION controlp INFIELD ooib021 name="construct.c.ooib021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib022
            #add-point:BEFORE FIELD ooib022 name="construct.b.ooib022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib022
            
            #add-point:AFTER FIELD ooib022 name="construct.a.ooib022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib022
            #add-point:ON ACTION controlp INFIELD ooib022 name="construct.c.ooib022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib023
            #add-point:BEFORE FIELD ooib023 name="construct.b.ooib023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib023
            
            #add-point:AFTER FIELD ooib023 name="construct.a.ooib023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib023
            #add-point:ON ACTION controlp INFIELD ooib023 name="construct.c.ooib023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib024
            #add-point:BEFORE FIELD ooib024 name="construct.b.ooib024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib024
            
            #add-point:AFTER FIELD ooib024 name="construct.a.ooib024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooib024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib024
            #add-point:ON ACTION controlp INFIELD ooib024 name="construct.c.ooib024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibstus
            #add-point:BEFORE FIELD ooibstus name="construct.b.ooibstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibstus
            
            #add-point:AFTER FIELD ooibstus name="construct.a.ooibstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooibstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibstus
            #add-point:ON ACTION controlp INFIELD ooibstus name="construct.c.ooibstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooibownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibownid
            #add-point:ON ACTION controlp INFIELD ooibownid name="construct.c.ooibownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooibownid  #顯示到畫面上

            NEXT FIELD ooibownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibownid
            #add-point:BEFORE FIELD ooibownid name="construct.b.ooibownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibownid
            
            #add-point:AFTER FIELD ooibownid name="construct.a.ooibownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooibowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibowndp
            #add-point:ON ACTION controlp INFIELD ooibowndp name="construct.c.ooibowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooibowndp  #顯示到畫面上

            NEXT FIELD ooibowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibowndp
            #add-point:BEFORE FIELD ooibowndp name="construct.b.ooibowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibowndp
            
            #add-point:AFTER FIELD ooibowndp name="construct.a.ooibowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooibcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibcrtid
            #add-point:ON ACTION controlp INFIELD ooibcrtid name="construct.c.ooibcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooibcrtid  #顯示到畫面上

            NEXT FIELD ooibcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibcrtid
            #add-point:BEFORE FIELD ooibcrtid name="construct.b.ooibcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibcrtid
            
            #add-point:AFTER FIELD ooibcrtid name="construct.a.ooibcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooibcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibcrtdp
            #add-point:ON ACTION controlp INFIELD ooibcrtdp name="construct.c.ooibcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooibcrtdp  #顯示到畫面上

            NEXT FIELD ooibcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibcrtdp
            #add-point:BEFORE FIELD ooibcrtdp name="construct.b.ooibcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibcrtdp
            
            #add-point:AFTER FIELD ooibcrtdp name="construct.a.ooibcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibcrtdt
            #add-point:BEFORE FIELD ooibcrtdt name="construct.b.ooibcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooibmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibmodid
            #add-point:ON ACTION controlp INFIELD ooibmodid name="construct.c.ooibmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooibmodid  #顯示到畫面上

            NEXT FIELD ooibmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibmodid
            #add-point:BEFORE FIELD ooibmodid name="construct.b.ooibmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibmodid
            
            #add-point:AFTER FIELD ooibmodid name="construct.a.ooibmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibmoddt
            #add-point:BEFORE FIELD ooibmoddt name="construct.b.ooibmoddt"
            
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
   LET g_wc = g_wc," AND ooib001 = '",g_argv[1],"'"
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="aooi714.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aooi714_query()
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
 
   INITIALIZE g_ooib_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aooi714_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aooi714_browser_fill(g_wc,"F")
      CALL aooi714_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
      CALL g_browser_expand.clear()
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aooi714_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aooi714_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aooi714.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aooi714_fetch(p_fl)
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
   
   #樹狀管控(action)
   IF g_browser[g_current_idx].b_expcode <> "2" THEN
      INITIALIZE g_ooib_m.* TO NULL
      DISPLAY BY NAME g_ooib_m.*
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
      RETURN
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
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
   LET g_ooib_m.ooib002 = g_browser[g_current_idx].b_ooib002
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aooi714_master_referesh USING g_ooib_m.ooib002 INTO g_ooib_m.ooib002,g_ooib_m.ooib004,g_ooib_m.ooib006, 
       g_ooib_m.ooib007,g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001,g_ooib_m.ooib011, 
       g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022,g_ooib_m.ooib023, 
       g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibowndp,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt,g_ooib_m.ooib025_desc,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooibownid_desc,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp_desc, 
       g_ooib_m.ooibmodid_desc
   
   #遮罩相關處理
   LET g_ooib_m_mask_o.* =  g_ooib_m.*
   CALL aooi714_ooib_t_mask()
   LET g_ooib_m_mask_n.* =  g_ooib_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aooi714_set_act_visible()
   CALL aooi714_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_ooib_m_t.* = g_ooib_m.*
   LET g_ooib_m_o.* = g_ooib_m.*
   
   LET g_data_owner = g_ooib_m.ooibownid      
   LET g_data_dept  = g_ooib_m.ooibowndp
   
   #重新顯示
   CALL aooi714_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aooi714.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi714_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   CLEAR g_ooib_m.*
   INITIALIZE g_ooib_m.* LIKE ooib_t.*             #DEFAULT 設定
   INITIALIZE g_ooib_m_t.* LIKE ooib_t.*             #DEFAULT 設定
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #此段落由子樣板a14產生    
      LET g_ooib_m.ooibownid = g_user
      LET g_ooib_m.ooibowndp = g_dept
      LET g_ooib_m.ooibcrtid = g_user
      LET g_ooib_m.ooibcrtdp = g_dept 
      LET g_ooib_m.ooibcrtdt = cl_get_current()
      #LET g_ooib_m.ooibmodid = g_user
      #LET g_ooib_m.ooibmoddt = cl_get_current()
      LET g_ooib_m.ooibstus = "Y"


 
      #append欄位給值
      
     
      #一般欄位給值
      LET g_ooib_m.ooib004 = "10"
      LET g_ooib_m.ooib006 = "N"
     #LET g_ooib_m.ooib011 = "01" #160929-00023 mark
      LET g_ooib_m.ooib011 = "05" #160929-00023 add
      LET g_ooib_m.ooib012 = "0"
      LET g_ooib_m.ooib013 = "0"
      LET g_ooib_m.ooib014 = "0"
      LET g_ooib_m.ooib001 = "1"
      LET g_ooib_m.ooib007 = "N"
     #LET g_ooib_m.ooib021 = "01" #160929-00023 mark
      LET g_ooib_m.ooib021 = "05" #160929-00023 add
      LET g_ooib_m.ooib022 = "0"
      LET g_ooib_m.ooib023 = "0"
      LET g_ooib_m.ooib024 = "0"
      DISPLAY BY NAME g_ooib_m.*
 
      #add-point:單頭預設值

      #end add-point   
     
      CALL aooi714_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooib_m.* = g_ooib_m_t.*
         CALL aooi714_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   LET g_state = "Y"
   RETURN
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_ooib_m.* TO NULL             #DEFAULT 設定
   LET g_ooib002_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      #應用 a55 樣板自動產生(Version:3)
      #六階樹狀給值
      LET g_current_idx = g_curr_diag.getCurrentRow("s_browse")
      IF g_current_idx > 0 THEN
         IF NOT cl_null(g_browser[g_current_idx].b_show) THEN
            LET g_ooib_m.ooib001 = g_browser[g_current_idx].b_ooib001
         END IF
      END IF
 
 
 
 
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooib_m.ooibownid = g_user
      LET g_ooib_m.ooibowndp = g_dept
      LET g_ooib_m.ooibcrtid = g_user
      LET g_ooib_m.ooibcrtdp = g_dept 
      LET g_ooib_m.ooibcrtdt = cl_get_current()
      LET g_ooib_m.ooibmodid = g_user
      LET g_ooib_m.ooibmoddt = cl_get_current()
      LET g_ooib_m.ooibstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_ooib_m.ooib004 = "10"
      LET g_ooib_m.ooib006 = "N"
      LET g_ooib_m.ooib007 = "N"
      LET g_ooib_m.ooib026 = "1"
      LET g_ooib_m.ooib001 = "1"
      LET g_ooib_m.ooib011 = "05"
      LET g_ooib_m.ooib012 = "0"
      LET g_ooib_m.ooib013 = "0"
      LET g_ooib_m.ooib014 = "0"
      LET g_ooib_m.ooib021 = "05"
      LET g_ooib_m.ooib022 = "0"
      LET g_ooib_m.ooib023 = "0"
      LET g_ooib_m.ooib024 = "0"
      LET g_ooib_m.ooibstus = "Y"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooib_m.ooibstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aooi714_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_ooib_m.* TO NULL
         CALL aooi714_show()
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
   CALL aooi714_set_act_visible()
   CALL aooi714_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_ooib002_t = g_ooib_m.ooib002
 
   
   #組合新增資料的條件
   LET g_add_browse = " ooibent = " ||g_enterprise|| " AND",
                      " ooib002 = '", g_ooib_m.ooib002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aooi714_master_referesh USING g_ooib_m.ooib002 INTO g_ooib_m.ooib002,g_ooib_m.ooib004,g_ooib_m.ooib006, 
       g_ooib_m.ooib007,g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001,g_ooib_m.ooib011, 
       g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022,g_ooib_m.ooib023, 
       g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibowndp,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt,g_ooib_m.ooib025_desc,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooibownid_desc,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp_desc, 
       g_ooib_m.ooibmodid_desc
   
   
   #遮罩相關處理
   LET g_ooib_m_mask_o.* =  g_ooib_m.*
   CALL aooi714_ooib_t_mask()
   LET g_ooib_m_mask_n.* =  g_ooib_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooib_m.ooib002,g_ooib_m.ooibl004,g_ooib_m.ooib004,g_ooib_m.ooib006,g_ooib_m.ooib007, 
       g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib025_desc,g_ooib_m.ooib005,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooib001,g_ooib_m.ooib011,g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021, 
       g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibownid_desc, 
       g_ooib_m.ooibowndp,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdp_desc,g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmodid_desc,g_ooib_m.ooibmoddt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_ooib_m.ooibownid      
   LET g_data_dept  = g_ooib_m.ooibowndp
 
   #功能已完成,通報訊息中心
   CALL aooi714_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi714.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi714_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
  IF g_ooib_m.ooibstus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "aoo-00234"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_ooib_m.ooib002 IS NULL
 
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
   LET g_ooib002_t = g_ooib_m.ooib002
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aooi714_cl USING g_enterprise,g_ooib_m.ooib002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi714_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aooi714_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi714_master_referesh USING g_ooib_m.ooib002 INTO g_ooib_m.ooib002,g_ooib_m.ooib004,g_ooib_m.ooib006, 
       g_ooib_m.ooib007,g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001,g_ooib_m.ooib011, 
       g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022,g_ooib_m.ooib023, 
       g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibowndp,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt,g_ooib_m.ooib025_desc,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooibownid_desc,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp_desc, 
       g_ooib_m.ooibmodid_desc
 
   #檢查是否允許此動作
   IF NOT aooi714_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_ooib_m_mask_o.* =  g_ooib_m.*
   CALL aooi714_ooib_t_mask()
   LET g_ooib_m_mask_n.* =  g_ooib_m.*
   
   
 
   #顯示資料
   CALL aooi714_show()
   
   WHILE TRUE
      LET g_ooib_m.ooib002 = g_ooib002_t
 
      
      #寫入修改者/修改日期資訊
      LET g_ooib_m.ooibmodid = g_user 
LET g_ooib_m.ooibmoddt = cl_get_current()
LET g_ooib_m.ooibmodid_desc = cl_get_username(g_ooib_m.ooibmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aooi714_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_ooib_m.* = g_ooib_m_t.*
         CALL aooi714_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE ooib_t SET (ooibmodid,ooibmoddt) = (g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt)
       WHERE ooibent = g_enterprise AND ooib002 = g_ooib002_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aooi714_set_act_visible()
   CALL aooi714_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ooibent = " ||g_enterprise|| " AND",
                      " ooib002 = '", g_ooib_m.ooib002, "' "
 
   #填到對應位置
   CALL aooi714_browser_fill(g_wc,"")
 
   CLOSE aooi714_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi714_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aooi714.input" >}
#+ 資料輸入
PRIVATE FUNCTION aooi714_input(p_cmd)
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
   
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   CALL gfrm_curr.setElementHidden("mainlayout",0)
   CALL gfrm_curr.setElementImage("mainhidden","small/arr-u.png")
   LET g_main_hidden = 1
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooib_m.ooib002,g_ooib_m.ooibl004,g_ooib_m.ooib004,g_ooib_m.ooib006,g_ooib_m.ooib007, 
       g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib025_desc,g_ooib_m.ooib005,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooib001,g_ooib_m.ooib011,g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021, 
       g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibownid_desc, 
       g_ooib_m.ooibowndp,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdp_desc,g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmodid_desc,g_ooib_m.ooibmoddt 
 
   
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
   CALL aooi714_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aooi714_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_ooib_m.ooib002,g_ooib_m.ooibl004,g_ooib_m.ooib004,g_ooib_m.ooib006,g_ooib_m.ooib007, 
          g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001,g_ooib_m.ooib011,g_ooib_m.ooib012, 
          g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024, 
          g_ooib_m.ooibstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_ooib_m.ooib002) THEN
                  CALL n_ooibl(g_ooib_m.ooib002)    # n_glafl:對應多語言表格
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooib_m.ooib002
                  CALL ap_ref_array2(g_ref_fields," SELECT ooibl004 FROM ooibl_t WHERE ooiblent = '"||g_enterprise||"' AND ooibl002 = ? AND ooibl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
                  LET g_ooib_m.ooibl004 = g_rtn_fields[1] 
                  DISPLAY BY NAME g_ooib_m.ooibl004
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.ooibl002 = g_ooib_m.ooib002
LET g_master_multi_table_t.ooibl004 = g_ooib_m.ooibl004
 
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib002
            #add-point:BEFORE FIELD ooib002 name="input.b.ooib002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib002
            
            #add-point:AFTER FIELD ooib002 name="input.a.ooib002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooib_m.ooib002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooib_m.ooib002 != g_ooib002_t ))) THEN 
                  IF NOT ap_chk_notDup(g_ooib_m.ooib002,"SELECT COUNT(*) FROM ooib_t WHERE "||"ooibent = '" ||g_enterprise|| "' AND "||"ooib002 = '"||g_ooib_m.ooib002 ||"'",'std-00004',0) THEN 
                     LET g_ooib_m.ooib002 = g_ooib_m_t.ooib002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib002
            #add-point:ON CHANGE ooib002 name="input.g.ooib002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibl004
            #add-point:BEFORE FIELD ooibl004 name="input.b.ooibl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibl004
            
            #add-point:AFTER FIELD ooibl004 name="input.a.ooibl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooibl004
            #add-point:ON CHANGE ooibl004 name="input.g.ooibl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib004
            #add-point:BEFORE FIELD ooib004 name="input.b.ooib004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib004
            
            #add-point:AFTER FIELD ooib004 name="input.a.ooib004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib004
            #add-point:ON CHANGE ooib004 name="input.g.ooib004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib006
            #add-point:BEFORE FIELD ooib006 name="input.b.ooib006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib006
            
            #add-point:AFTER FIELD ooib006 name="input.a.ooib006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib006
            #add-point:ON CHANGE ooib006 name="input.g.ooib006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib007
            #add-point:BEFORE FIELD ooib007 name="input.b.ooib007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib007
            
            #add-point:AFTER FIELD ooib007 name="input.a.ooib007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib007
            #add-point:ON CHANGE ooib007 name="input.g.ooib007"
            IF g_ooib_m.ooib005 = 'Y' THEN 
               CALL cl_set_comp_entry("ooib002,ooib023,ooib024",FALSE)
               LET g_ooib_m.ooib022 = 0
               LET g_ooib_m.ooib023 = 0
               LET g_ooib_m.ooib024 = 0
               DISPLAY BY NAME g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024
            ELSE
               CALL cl_set_comp_entry("ooib022,ooib023,ooib024",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib026
            #add-point:BEFORE FIELD ooib026 name="input.b.ooib026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib026
            
            #add-point:AFTER FIELD ooib026 name="input.a.ooib026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib026
            #add-point:ON CHANGE ooib026 name="input.g.ooib026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib025
            
            #add-point:AFTER FIELD ooib025 name="input.a.ooib025"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooib_m.ooib025
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3114' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooib_m.ooib025_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_ooib_m.ooib025_desc
            
            IF NOT cl_null(g_ooib_m.ooib025) THEN 
               IF NOT ap_chk_isExist(g_ooib_m.ooib025,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3114' ",'aoo-00199',1) THEN 
                  LET g_ooib_m.ooib025 = g_ooib_m_t.ooib025
                  DISPLAY '' TO ooib025_desc                  
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_ooib_m.ooib025,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3114' AND oocqstus = 'Y' ",'sub-01302',"axri012") THEN #aoo-00200 #160318-00005#33 by 07900 --mod 
                  LET g_ooib_m.ooib025 = g_ooib_m_t.ooib025
                  DISPLAY '' TO ooib025_desc                  
                  NEXT FIELD CURRENT
               END IF                
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib025
            #add-point:BEFORE FIELD ooib025 name="input.b.ooib025"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooib_m.ooib025
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3114' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooib_m.ooib025_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_ooib_m.ooib025_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib025
            #add-point:ON CHANGE ooib025 name="input.g.ooib025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib005
            
            #add-point:AFTER FIELD ooib005 name="input.a.ooib005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooib_m.ooib005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooidl003 FROM ooidl_t WHERE ooidlent='"||g_enterprise||"' AND ooidl001=? AND ooidl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooib_m.ooib005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooib_m.ooib005_desc
            IF NOT cl_null(g_ooib_m.ooib005) THEN    
               IF NOT ap_chk_isExist(g_ooib_m.ooib005,"SELECT COUNT(*) FROM ooid_t WHERE "||"ooident = '" ||g_enterprise|| "' AND "||"ooid001 = ? ",'aoo-00193',1) THEN 
                  LET g_ooib_m.ooib005 = g_ooib_m_t.ooib005
                  NEXT FIELD CURRENT
               END IF 
               IF NOT ap_chk_isExist(g_ooib_m.ooib005,"SELECT COUNT(*) FROM ooid_t WHERE "||"ooident = '" ||g_enterprise|| "' AND "||"ooid001 = ? AND ooidstus = 'Y' ",'sub-01302',"aooi717") THEN #aoo-00194 #160318-00005#33 by 07900 --mod
                  LET g_ooib_m.ooib005 = g_ooib_m_t.ooib005
                  NEXT FIELD CURRENT
               END IF               
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib005
            #add-point:BEFORE FIELD ooib005 name="input.b.ooib005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooib_m.ooib005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooidl003 FROM ooidl_t WHERE ooidlent='"||g_enterprise||"' AND ooidl001=? AND ooidl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooib_m.ooib005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooib_m.ooib005_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib005
            #add-point:ON CHANGE ooib005 name="input.g.ooib005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib001
            #add-point:BEFORE FIELD ooib001 name="input.b.ooib001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib001
            
            #add-point:AFTER FIELD ooib001 name="input.a.ooib001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib001
            #add-point:ON CHANGE ooib001 name="input.g.ooib001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib011
            #add-point:BEFORE FIELD ooib011 name="input.b.ooib011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib011
            
            #add-point:AFTER FIELD ooib011 name="input.a.ooib011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib011
            #add-point:ON CHANGE ooib011 name="input.g.ooib011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooib_m.ooib012,"0","1","4","1","azz-00087",1) THEN
               NEXT FIELD ooib012
            END IF 
 
 
 
            #add-point:AFTER FIELD ooib012 name="input.a.ooib012"
            IF NOT cl_null(g_ooib_m.ooib012) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib012
            #add-point:BEFORE FIELD ooib012 name="input.b.ooib012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib012
            #add-point:ON CHANGE ooib012 name="input.g.ooib012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooib_m.ooib013,"0","1","12","1","azz-00087",1) THEN
               NEXT FIELD ooib013
            END IF 
 
 
 
            #add-point:AFTER FIELD ooib013 name="input.a.ooib013"
            IF NOT cl_null(g_ooib_m.ooib013) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib013
            #add-point:BEFORE FIELD ooib013 name="input.b.ooib013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib013
            #add-point:ON CHANGE ooib013 name="input.g.ooib013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooib_m.ooib014,"-365","1","365","1","azz-00087",1) THEN
               NEXT FIELD ooib014
            END IF 
 
 
 
            #add-point:AFTER FIELD ooib014 name="input.a.ooib014"
            IF NOT cl_null(g_ooib_m.ooib014) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib014
            #add-point:BEFORE FIELD ooib014 name="input.b.ooib014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib014
            #add-point:ON CHANGE ooib014 name="input.g.ooib014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib021
            #add-point:BEFORE FIELD ooib021 name="input.b.ooib021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib021
            
            #add-point:AFTER FIELD ooib021 name="input.a.ooib021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib021
            #add-point:ON CHANGE ooib021 name="input.g.ooib021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooib_m.ooib022,"0","1","4","1","azz-00087",1) THEN
               NEXT FIELD ooib022
            END IF 
 
 
 
            #add-point:AFTER FIELD ooib022 name="input.a.ooib022"
            IF NOT cl_null(g_ooib_m.ooib022) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib022
            #add-point:BEFORE FIELD ooib022 name="input.b.ooib022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib022
            #add-point:ON CHANGE ooib022 name="input.g.ooib022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooib_m.ooib023,"0","1","12","1","azz-00087",1) THEN
               NEXT FIELD ooib023
            END IF 
 
 
 
            #add-point:AFTER FIELD ooib023 name="input.a.ooib023"
            IF NOT cl_null(g_ooib_m.ooib023) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib023
            #add-point:BEFORE FIELD ooib023 name="input.b.ooib023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib023
            #add-point:ON CHANGE ooib023 name="input.g.ooib023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooib024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooib_m.ooib024,"-365","1","365","1","azz-00087",1) THEN
               NEXT FIELD ooib024
            END IF 
 
 
 
            #add-point:AFTER FIELD ooib024 name="input.a.ooib024"
            IF NOT cl_null(g_ooib_m.ooib024) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooib024
            #add-point:BEFORE FIELD ooib024 name="input.b.ooib024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooib024
            #add-point:ON CHANGE ooib024 name="input.g.ooib024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooibstus
            #add-point:BEFORE FIELD ooibstus name="input.b.ooibstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooibstus
            
            #add-point:AFTER FIELD ooibstus name="input.a.ooibstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooibstus
            #add-point:ON CHANGE ooibstus name="input.g.ooibstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooib002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib002
            #add-point:ON ACTION controlp INFIELD ooib002 name="input.c.ooib002"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooibl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibl004
            #add-point:ON ACTION controlp INFIELD ooibl004 name="input.c.ooibl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib004
            #add-point:ON ACTION controlp INFIELD ooib004 name="input.c.ooib004"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib006
            #add-point:ON ACTION controlp INFIELD ooib006 name="input.c.ooib006"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib007
            #add-point:ON ACTION controlp INFIELD ooib007 name="input.c.ooib007"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib026
            #add-point:ON ACTION controlp INFIELD ooib026 name="input.c.ooib026"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib025
            #add-point:ON ACTION controlp INFIELD ooib025 name="input.c.ooib025"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooib_m.ooib025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3114" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooib_m.ooib025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooib_m.ooib025 TO ooib025              #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooib_m.ooib025
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3114' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooib_m.ooib025_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_ooib_m.ooib025_desc
            
            NEXT FIELD ooib025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooib005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib005
            #add-point:ON ACTION controlp INFIELD ooib005 name="input.c.ooib005"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooib_m.ooib005             #給予default值

            #給予arg
            IF g_argv[1] = '2' THEN
               CALL q_ooid001_1()                                #呼叫開窗
            ELSE
               CALL q_ooid001_2()
            END IF
            LET g_ooib_m.ooib005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooib_m.ooib005 TO ooib005              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooib_m.ooib005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooidl003 FROM ooidl_t WHERE ooidlent='"||g_enterprise||"' AND ooidl001=? AND ooidl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooib_m.ooib005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooib_m.ooib005_desc
            NEXT FIELD ooib005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooib001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib001
            #add-point:ON ACTION controlp INFIELD ooib001 name="input.c.ooib001"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib011
            #add-point:ON ACTION controlp INFIELD ooib011 name="input.c.ooib011"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib012
            #add-point:ON ACTION controlp INFIELD ooib012 name="input.c.ooib012"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib013
            #add-point:ON ACTION controlp INFIELD ooib013 name="input.c.ooib013"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib014
            #add-point:ON ACTION controlp INFIELD ooib014 name="input.c.ooib014"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib021
            #add-point:ON ACTION controlp INFIELD ooib021 name="input.c.ooib021"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib022
            #add-point:ON ACTION controlp INFIELD ooib022 name="input.c.ooib022"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib023
            #add-point:ON ACTION controlp INFIELD ooib023 name="input.c.ooib023"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooib024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooib024
            #add-point:ON ACTION controlp INFIELD ooib024 name="input.c.ooib024"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooibstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooibstus
            #add-point:ON ACTION controlp INFIELD ooibstus name="input.c.ooibstus"
            
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
               SELECT COUNT(1) INTO l_count FROM ooib_t
                WHERE ooibent = g_enterprise AND ooib002 = g_ooib_m.ooib002
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  LET g_ooib_m.ooib001 = g_argv[1]
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO ooib_t (ooibent,ooib002,ooib004,ooib006,ooib007,ooib026,ooib025,ooib005, 
                      ooib001,ooib011,ooib012,ooib013,ooib014,ooib021,ooib022,ooib023,ooib024,ooibstus, 
                      ooibownid,ooibowndp,ooibcrtid,ooibcrtdp,ooibcrtdt,ooibmodid,ooibmoddt)
                  VALUES (g_enterprise,g_ooib_m.ooib002,g_ooib_m.ooib004,g_ooib_m.ooib006,g_ooib_m.ooib007, 
                      g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001,g_ooib_m.ooib011, 
                      g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022, 
                      g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibowndp, 
                      g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp,g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooib_t:",SQLERRMESSAGE 
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
         IF g_ooib_m.ooib002 = g_master_multi_table_t.ooibl002 AND
         g_ooib_m.ooibl004 = g_master_multi_table_t.ooibl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'ooiblent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_ooib_m.ooib002
            LET l_field_keys[02] = 'ooibl002'
            LET l_var_keys_bak[02] = g_master_multi_table_t.ooibl002
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'ooibl003'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_ooib_m.ooibl004
            LET l_fields[01] = 'ooibl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'ooibl_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_ooib_m.ooib002
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi714_ooib_t_mask_restore('restore_mask_o')
               
               UPDATE ooib_t SET (ooib002,ooib004,ooib006,ooib007,ooib026,ooib025,ooib005,ooib001,ooib011, 
                   ooib012,ooib013,ooib014,ooib021,ooib022,ooib023,ooib024,ooibstus,ooibownid,ooibowndp, 
                   ooibcrtid,ooibcrtdp,ooibcrtdt,ooibmodid,ooibmoddt) = (g_ooib_m.ooib002,g_ooib_m.ooib004, 
                   g_ooib_m.ooib006,g_ooib_m.ooib007,g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005, 
                   g_ooib_m.ooib001,g_ooib_m.ooib011,g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014, 
                   g_ooib_m.ooib021,g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus, 
                   g_ooib_m.ooibownid,g_ooib_m.ooibowndp,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp,g_ooib_m.ooibcrtdt, 
                   g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt)
                WHERE ooibent = g_enterprise AND ooib002 = g_ooib002_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooib_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooib_t:",SQLERRMESSAGE 
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
         IF g_ooib_m.ooib002 = g_master_multi_table_t.ooibl002 AND
         g_ooib_m.ooibl004 = g_master_multi_table_t.ooibl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'ooiblent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_ooib_m.ooib002
            LET l_field_keys[02] = 'ooibl002'
            LET l_var_keys_bak[02] = g_master_multi_table_t.ooibl002
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'ooibl003'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_ooib_m.ooibl004
            LET l_fields[01] = 'ooibl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'ooibl_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aooi714_ooib_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_ooib_m_t)
                     LET g_log2 = util.JSON.stringify(g_ooib_m)
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
 
{<section id="aooi714.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aooi714_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE ooib_t.ooib002 
   DEFINE l_oldno     LIKE ooib_t.ooib002 
 
   DEFINE l_master    RECORD LIKE ooib_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
 
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_ooib_m.ooib002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_ooib002_t = g_ooib_m.ooib002
 
   
   #清空key值
   LET g_ooib_m.ooib002 = ""
 
    
   CALL aooi714_set_entry("a")
   CALL aooi714_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooib_m.ooibownid = g_user
      LET g_ooib_m.ooibowndp = g_dept
      LET g_ooib_m.ooibcrtid = g_user
      LET g_ooib_m.ooibcrtdp = g_dept 
      LET g_ooib_m.ooibcrtdt = cl_get_current()
      LET g_ooib_m.ooibmodid = g_user
      LET g_ooib_m.ooibmoddt = cl_get_current()
      LET g_ooib_m.ooibstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooib_m.ooibstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aooi714_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_ooib_m.* TO NULL
      CALL aooi714_show()
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
      LET g_errparam.extend = "ooib_t:",SQLERRMESSAGE 
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
   CALL aooi714_set_act_visible()
   CALL aooi714_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_ooib002_t = g_ooib_m.ooib002
 
   
   #組合新增資料的條件
   LET g_add_browse = " ooibent = " ||g_enterprise|| " AND",
                      " ooib002 = '", g_ooib_m.ooib002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_ooib_m.ooibownid      
   LET g_data_dept  = g_ooib_m.ooibowndp
              
   #功能已完成,通報訊息中心
   CALL aooi714_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aooi714.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aooi714_show()
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
   CALL aooi714_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooib_m.ooib002
   CALL ap_ref_array2(g_ref_fields," SELECT ooibl004 FROM ooibl_t WHERE ooiblent = '"||g_enterprise||"' AND ooibl002 = ? AND ooibl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_ooib_m.ooibl004 = g_rtn_fields[1] 
   DISPLAY BY NAME g_ooib_m.ooibl004
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooib_m.ooib005
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooidl003 FROM ooidl_t WHERE ooidlent='"||g_enterprise||"' AND ooidl001=? AND ooidl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_ooib_m.ooib005_desc = g_rtn_fields[1]
#   DISPLAY BY NAME g_ooib_m.ooib005_desc   
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooib_m.ooib025
#   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3114' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_ooib_m.ooib025_desc = g_rtn_fields[1]
#   DISPLAY BY NAME g_ooib_m.ooib025_desc   
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooib_m.ooibownid
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_ooib_m.ooibownid_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_ooib_m.ooibownid_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooib_m.ooibowndp
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_ooib_m.ooibowndp_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_ooib_m.ooibowndp_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooib_m.ooibcrtid
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_ooib_m.ooibcrtid_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_ooib_m.ooibcrtid_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooib_m.ooibcrtdp
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_ooib_m.ooibcrtdp_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_ooib_m.ooibcrtdp_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooib_m.ooibmodid
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_ooib_m.ooibmodid_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_ooib_m.ooibmodid_desc   
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooib_m.ooib002,g_ooib_m.ooibl004,g_ooib_m.ooib004,g_ooib_m.ooib006,g_ooib_m.ooib007, 
       g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib025_desc,g_ooib_m.ooib005,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooib001,g_ooib_m.ooib011,g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021, 
       g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibownid_desc, 
       g_ooib_m.ooibowndp,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdp_desc,g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmodid_desc,g_ooib_m.ooibmoddt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aooi714_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooib_m.ooibstus 
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
 
{<section id="aooi714.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aooi714_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   IF g_ooib_m.ooibstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "aoo-00233"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_ooib_m.ooib002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_ooib002_t = g_ooib_m.ooib002
 
   
   LET g_master_multi_table_t.ooibl002 = g_ooib_m.ooib002
LET g_master_multi_table_t.ooibl004 = g_ooib_m.ooibl004
 
 
   OPEN aooi714_cl USING g_enterprise,g_ooib_m.ooib002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi714_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aooi714_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi714_master_referesh USING g_ooib_m.ooib002 INTO g_ooib_m.ooib002,g_ooib_m.ooib004,g_ooib_m.ooib006, 
       g_ooib_m.ooib007,g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001,g_ooib_m.ooib011, 
       g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022,g_ooib_m.ooib023, 
       g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibowndp,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt,g_ooib_m.ooib025_desc,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooibownid_desc,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp_desc, 
       g_ooib_m.ooibmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aooi714_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_ooib_m_mask_o.* =  g_ooib_m.*
   CALL aooi714_ooib_t_mask()
   LET g_ooib_m_mask_n.* =  g_ooib_m.*
   
   #將最新資料顯示到畫面上
   CALL aooi714_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi714_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM ooib_t 
       WHERE ooibent = g_enterprise AND ooib002 = g_ooib_m.ooib002 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooib_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'ooiblent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.ooibl002
   LET l_field_keys[02] = 'ooibl002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'ooibl_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_ooib_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aooi714_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aooi714_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         CALL aooi714_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aooi714_cl
 
   #功能已完成,通報訊息中心
   CALL aooi714_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi714.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aooi714_ui_browser_refresh()
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
      IF g_browser[l_i].b_ooib002 = g_ooib_m.ooib002
 
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
 
{<section id="aooi714.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aooi714_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("ooib002",TRUE)
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
 
{<section id="aooi714.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aooi714_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("ooib002",FALSE)
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
 
{<section id="aooi714.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aooi714_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi714.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aooi714_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi714.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi714_default_search()
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
   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " ooib001 = '", g_argv[1], "' AND "
   END IF
   

   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   RETURN
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " ooib002 = '", g_argv[01], "' AND "
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi714.mask_functions" >}
&include "erp/aoo/aooi714_mask.4gl"
 
{</section>}
 
{<section id="aooi714.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aooi714_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_ooib_m.ooib002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aooi714_cl USING g_enterprise,g_ooib_m.ooib002
   IF STATUS THEN
      CLOSE aooi714_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi714_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aooi714_master_referesh USING g_ooib_m.ooib002 INTO g_ooib_m.ooib002,g_ooib_m.ooib004,g_ooib_m.ooib006, 
       g_ooib_m.ooib007,g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001,g_ooib_m.ooib011, 
       g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022,g_ooib_m.ooib023, 
       g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibowndp,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt,g_ooib_m.ooib025_desc,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooibownid_desc,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp_desc, 
       g_ooib_m.ooibmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT aooi714_action_chk() THEN
      CLOSE aooi714_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooib_m.ooib002,g_ooib_m.ooibl004,g_ooib_m.ooib004,g_ooib_m.ooib006,g_ooib_m.ooib007, 
       g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib025_desc,g_ooib_m.ooib005,g_ooib_m.ooib005_desc, 
       g_ooib_m.ooib001,g_ooib_m.ooib011,g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021, 
       g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibownid_desc, 
       g_ooib_m.ooibowndp,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp, 
       g_ooib_m.ooibcrtdp_desc,g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmodid_desc,g_ooib_m.ooibmoddt 
 
 
   CASE g_ooib_m.ooibstus
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
         CASE g_ooib_m.ooibstus
            
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
      g_ooib_m.ooibstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aooi714_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_ooib_m.ooibmodid = g_user
   LET g_ooib_m.ooibmoddt = cl_get_current()
   LET g_ooib_m.ooibstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE ooib_t 
      SET (ooibstus,ooibmodid,ooibmoddt) 
        = (g_ooib_m.ooibstus,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt)     
    WHERE ooibent = g_enterprise AND ooib002 = g_ooib_m.ooib002
 
    
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
      EXECUTE aooi714_master_referesh USING g_ooib_m.ooib002 INTO g_ooib_m.ooib002,g_ooib_m.ooib004, 
          g_ooib_m.ooib006,g_ooib_m.ooib007,g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib005,g_ooib_m.ooib001, 
          g_ooib_m.ooib011,g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021,g_ooib_m.ooib022, 
          g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibowndp, 
          g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtdp,g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmoddt, 
          g_ooib_m.ooib025_desc,g_ooib_m.ooib005_desc,g_ooib_m.ooibownid_desc,g_ooib_m.ooibowndp_desc, 
          g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp_desc,g_ooib_m.ooibmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_ooib_m.ooib002,g_ooib_m.ooibl004,g_ooib_m.ooib004,g_ooib_m.ooib006,g_ooib_m.ooib007, 
          g_ooib_m.ooib026,g_ooib_m.ooib025,g_ooib_m.ooib025_desc,g_ooib_m.ooib005,g_ooib_m.ooib005_desc, 
          g_ooib_m.ooib001,g_ooib_m.ooib011,g_ooib_m.ooib012,g_ooib_m.ooib013,g_ooib_m.ooib014,g_ooib_m.ooib021, 
          g_ooib_m.ooib022,g_ooib_m.ooib023,g_ooib_m.ooib024,g_ooib_m.ooibstus,g_ooib_m.ooibownid,g_ooib_m.ooibownid_desc, 
          g_ooib_m.ooibowndp,g_ooib_m.ooibowndp_desc,g_ooib_m.ooibcrtid,g_ooib_m.ooibcrtid_desc,g_ooib_m.ooibcrtdp, 
          g_ooib_m.ooibcrtdp_desc,g_ooib_m.ooibcrtdt,g_ooib_m.ooibmodid,g_ooib_m.ooibmodid_desc,g_ooib_m.ooibmoddt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aooi714_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi714_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi714.signature" >}
   
 
{</section>}
 
{<section id="aooi714.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi714_set_pk_array()
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
   LET g_pk_array[1].values = g_ooib_m.ooib002
   LET g_pk_array[1].column = 'ooib002'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi714.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi714.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aooi714_msgcentre_notify(lc_state)
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
   CALL aooi714_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_ooib_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi714.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aooi714_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aooi714.other_function" readonly="Y" >}
#+ 收款與付款欄位名稱
PRIVATE FUNCTION aooi714_display()
DEFINE l_msg   STRING

   IF g_argv[1] = '2' THEN 
      CALL cl_getmsg('aoo-00202',g_lang) RETURNING l_msg
      CALL aooi714_set_comp_att_text("group1",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00204',g_lang) RETURNING l_msg
      CALL aooi714_set_comp_att_text("group2",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00206',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib006",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00208',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib002",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00210',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib001",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00212',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("b_date1",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00204',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("b_date2",l_msg CLIPPED)
      
      CALL cl_getmsg('aoo-00217',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib011",l_msg CLIPPED)       
   ELSE
      CALL cl_getmsg('aoo-00203',g_lang) RETURNING l_msg
      CALL aooi714_set_comp_att_text("group1",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00205',g_lang) RETURNING l_msg
      CALL aooi714_set_comp_att_text("group2",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00207',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib006",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00209',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib002",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00211',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib001",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00213',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("b_date1",l_msg CLIPPED)

      CALL cl_getmsg('aoo-00205',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("b_date2",l_msg CLIPPED)   
      
      CALL cl_getmsg('aoo-00218',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("lbl_ooib011",l_msg CLIPPED) 
   END IF
END FUNCTION
#+ text屬性
PRIVATE FUNCTION aooi714_set_comp_att_text(ps_fields,ps_att_value)
   DEFINE   ps_fields          STRING,
            ps_att_value       STRING
   DEFINE   lst_fields         base.StringTokenizer,
            lst_string         base.StringTokenizer,
            ls_field_name      STRING,
            ls_field_value     STRING,
            ls_win_name        STRING
   DEFINE   lnode_root         om.DomNode,
            lnode_win          om.DomNode,
            lnode_pre          om.DomNode,
            llst_items         om.NodeList,
            lnode_list         om.NodeList,
            li_i               LIKE type_t.num5,
            lnode_item         om.DomNode,
            ls_item_name       STRING,
            lnode_item_child   om.DomNode,
            ls_item_pre_tag    STRING,
            ls_item_tag_name   STRING
   DEFINE   g_chg              DYNAMIC ARRAY OF RECORD
               item            STRING,
               value           STRING
                               END RECORD
   DEFINE   lwin_curr          ui.Window
   DEFINE   ls_btn_name        STRING
   DEFINE l_str STRING
   DEFINE l_cnt SMALLINT
   DEFINE   lnode_p            om.DomNode,
            ls_item_tag_name_p STRING,
            ls_item_name_p     STRING,
            ls_str_p           LIKE type_t.chr100

   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN

      RETURN
   END IF


   IF (ps_fields IS NULL) THEN
      RETURN
   ELSE
      LET ps_fields = ps_fields.toLowerCase()
   END IF

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
   LET ls_win_name = lnode_win.getAttribute("name")

   LET llst_items = lnode_win.selectByPath("//Form//*")
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
   LET lst_string = base.StringTokenizer.create(ps_att_value,",")
   WHILE lst_fields.hasMoreTokens() AND lst_string.hasMoreTokens()
      LET ls_field_name = lst_fields.nextToken()
      LET ls_field_value = lst_string.nextToken()
      LET ls_field_name = ls_field_name.trim()

      IF ls_field_name.equals(ls_win_name) THEN
         CALL lnode_win.setAttribute("text",ls_field_value)
      END IF

      FOR li_i = 1 TO llst_items.getLength()
         LET lnode_item = llst_items.item(li_i)
         LET ls_item_name = lnode_item.getAttribute("colName")

         IF (ls_item_name IS NULL) THEN
            LET ls_item_name = lnode_item.getAttribute("name")

            LET ls_item_tag_name = lnode_item.getTagName()
            IF ls_item_tag_name.equals("Item") THEN
               IF (ls_item_name IS NOT NULL) THEN
                    LET lnode_p = lnode_item.getParent()   #取父結點
                  LET ls_item_tag_name_p = lnode_p.getTagName()   #父結點類型
                  IF ls_item_tag_name_p.equals("RadioGroup") OR ls_item_tag_name_p.equals("ComboBox") THEN
                         LET ls_item_name_p = lnode_p.getAttribute("comment")  #取comment因為裡面一定會有[***]
                         LET ls_str_p = ls_item_name_p
                         #取[]之間的東西
                         select substr(ls_str_p,instr(ls_str_p,'[',1)+1,length(ls_str_p)-instr(ls_str_p,'[',1)-1) INTO ls_str_p from dual
                         LET ls_item_name = ls_str_p CLIPPED || '_' || ls_item_name
                  END IF
               END IF
            END IF

            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
         END IF

         IF (ls_item_name.equals(ls_field_name)) THEN
            LET ls_item_tag_name = lnode_item.getTagName()
            LET lnode_list = lnode_item.selectByTagName("CheckBox")
            LET l_cnt = lnode_list.getlength()
            IF ls_item_tag_name.equals("TableColumn") OR
               ls_item_tag_name.equals("Page") OR
               ls_item_tag_name.equals("Item") OR
               ls_item_tag_name.equals("Group") OR
               ls_item_tag_name.equals("Label") OR
               ls_item_tag_name.equals("Window")OR
               ls_item_tag_name.equals("Button") THEN
               CALL lnode_item.setAttribute("text",ls_field_value.trim())
            ELSE
               IF l_cnt > 0 THEN
                  LET lnode_item_child = lnode_item.getFirstChild()
                  CALL lnode_item_child.setAttribute("text",ls_field_value.trim())
               ELSE
                  LET lnode_pre = lnode_item.getPrevious()
                  LET ls_item_pre_tag = lnode_pre.getTagName()
                  IF ls_item_pre_tag.equals("Label") THEN
                     CALL lnode_pre.setAttribute("text",ls_field_value.trim())
                  ELSE
                     IF ls_item_pre_tag.equals("Button") THEN
                        LET ls_btn_name = lnode_pre.getAttribute("name")
                        IF ls_btn_name.subString(1,4) = "btn_" THEN
                           LET lnode_pre = lnode_pre.getPrevious()
                           LET ls_item_pre_tag = lnode_pre.getTagName()
                           IF ls_item_pre_tag.equals("Label") THEN
                              CALL lnode_pre.setAttribute("text",ls_field_value.trim())
                           END IF
                        END IF
                     END IF
                  END IF
              END IF
            END IF
            EXIT FOR
         END IF
      END FOR
   END WHILE
END FUNCTION

 
{</section>}
 
