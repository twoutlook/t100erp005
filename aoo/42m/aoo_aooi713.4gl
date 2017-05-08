#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi713.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-06-06 22:45:43), PR版次:0012(2016-12-14 13:51:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000334
#+ Filename...: aooi713
#+ Description: 款別基本資料維護作業
#+ Creator....: 02295(2013-09-25 14:28:45)
#+ Modifier...: 07142 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi713.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#32  2016/03/27   By 07900    重复错误信息修改
#160509-00004#2   2016/05/09   By 02114    新增ooia040,ooia041,ooia042三个栏位
#160905-00007#9   2016/09/05   By 01531    调整系统中无ENT的SQL条件增加ent
#160913-00055#3   2016/09/18   By lixiang  交易对象栏位开窗调整为q_pmaa001_25
#161019-00017#2   2016/10/20   By lixh     组织类型调整 q_ooef001 => q_ooef001_1
#161121-00012#1   2016/11/21   By fionchen 調整不會顯示收銀繳款是否核對明細資料不會顯示問題
#161124-00048#13  2016/12/14   By 08734    星号整批调整
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
PRIVATE TYPE type_g_ooia_m RECORD
       ooia001 LIKE ooia_t.ooia001, 
   ooia008 LIKE type_t.num5, 
   ooial003 LIKE ooial_t.ooial003, 
   ooia009 LIKE type_t.num5, 
   ooia007 LIKE type_t.chr10, 
   ooia007_desc LIKE type_t.chr80, 
   ooia010 LIKE type_t.chr10, 
   ooia010_desc LIKE type_t.chr80, 
   ooia002 LIKE ooia_t.ooia002, 
   ooia039 LIKE type_t.chr10, 
   ooia005 LIKE ooia_t.ooia005, 
   ooia045 LIKE ooia_t.ooia045, 
   ooiastus LIKE ooia_t.ooiastus, 
   ooia004 LIKE ooia_t.ooia004, 
   ooia004_desc LIKE type_t.chr80, 
   ooia006 LIKE ooia_t.ooia006, 
   ooia006_desc LIKE type_t.chr80, 
   ooia038 LIKE ooia_t.ooia038, 
   ooia043 LIKE ooia_t.ooia043, 
   ooia044 LIKE ooia_t.ooia044, 
   ooia003 LIKE ooia_t.ooia003, 
   ooia040 LIKE ooia_t.ooia040, 
   ooia011 LIKE ooia_t.ooia011, 
   ooia041 LIKE ooia_t.ooia041, 
   ooia012 LIKE ooia_t.ooia012, 
   ooia042 LIKE ooia_t.ooia042, 
   ooia042_desc LIKE type_t.chr80, 
   ooia013 LIKE ooia_t.ooia013, 
   ooia013_desc LIKE type_t.chr80, 
   ooia014 LIKE ooia_t.ooia014, 
   ooia015 LIKE ooia_t.ooia015, 
   ooia016 LIKE ooia_t.ooia016, 
   ooia017 LIKE type_t.chr10, 
   ooia018 LIKE type_t.chr500, 
   ooia019 LIKE type_t.chr500, 
   ooia020 LIKE type_t.chr1, 
   ooia021 LIKE type_t.chr1, 
   ooia022 LIKE ooia_t.ooia022, 
   ooia023 LIKE type_t.chr1, 
   ooia024 LIKE type_t.chr1, 
   ooia025 LIKE type_t.chr1, 
   ooia026 LIKE type_t.chr1, 
   ooia027 LIKE type_t.chr1, 
   ooia028 LIKE type_t.chr1, 
   ooia029 LIKE type_t.chr1, 
   ooia030 LIKE type_t.chr1, 
   ooia031 LIKE type_t.chr1, 
   ooia032 LIKE type_t.chr500, 
   ooia033 LIKE type_t.chr500, 
   ooia034 LIKE type_t.chr500, 
   ooia035 LIKE type_t.chr500, 
   ooia036 LIKE type_t.chr500, 
   ooia037 LIKE type_t.chr500, 
   ooiaownid LIKE ooia_t.ooiaownid, 
   ooiaownid_desc LIKE type_t.chr80, 
   ooiaowndp LIKE ooia_t.ooiaowndp, 
   ooiaowndp_desc LIKE type_t.chr80, 
   ooiacrtid LIKE ooia_t.ooiacrtid, 
   ooiacrtid_desc LIKE type_t.chr80, 
   ooiacrtdp LIKE ooia_t.ooiacrtdp, 
   ooiacrtdp_desc LIKE type_t.chr80, 
   ooiacrtdt LIKE ooia_t.ooiacrtdt, 
   ooiamodid LIKE ooia_t.ooiamodid, 
   ooiamodid_desc LIKE type_t.chr80, 
   ooiamoddt LIKE ooia_t.ooiamoddt
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
            b_ooia001 LIKE ooia_t.ooia001,
      b_ooia002 LIKE ooia_t.ooia002,
      b_ooia008 LIKE ooia_t.ooia008,
      b_ooia009 LIKE ooia_t.ooia009,
      b_ooia010 LIKE ooia_t.ooia010,
      b_ooia004 LIKE ooia_t.ooia004,
   b_ooia004_desc LIKE type_t.chr80,
      b_ooia003 LIKE ooia_t.ooia003,
      b_ooia011 LIKE ooia_t.ooia011,
      b_ooia005 LIKE ooia_t.ooia005,
      b_ooia045 LIKE ooia_t.ooia045,
      b_ooiastus LIKE ooia_t.ooiastus
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_ooia_m        type_g_ooia_m  #單頭變數宣告
DEFINE g_ooia_m_t      type_g_ooia_m  #單頭舊值宣告(系統還原用)
DEFINE g_ooia_m_o      type_g_ooia_m  #單頭舊值宣告(其他用途)
DEFINE g_ooia_m_mask_o type_g_ooia_m  #轉換遮罩前資料
DEFINE g_ooia_m_mask_n type_g_ooia_m  #轉換遮罩後資料
 
   DEFINE g_ooia001_t LIKE ooia_t.ooia001
 
   
#應用 a54 樣板自動產生(Version:3)
DEFINE g_browser_expand   DYNAMIC ARRAY OF RECORD                   #資料瀏覽之欄位  
      b_ooia002 STRING
      END RECORD 
 
 
 
 
   
DEFINE g_master_multi_table_t    RECORD
      ooial001 LIKE ooial_t.ooial001,
      ooial003 LIKE ooial_t.ooial003
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
 
{<section id="aooi713.main" >}
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
   LET g_forupd_sql = " SELECT ooia001,'','','','','','','',ooia002,'',ooia005,ooia045,ooiastus,ooia004, 
       '',ooia006,'',ooia038,ooia043,ooia044,ooia003,ooia040,ooia011,ooia041,ooia012,ooia042,'',ooia013, 
       '',ooia014,ooia015,ooia016,'','','','','',ooia022,'','','','','','','','','','','','','','','', 
       ooiaownid,'',ooiaowndp,'',ooiacrtid,'',ooiacrtdp,'',ooiacrtdt,ooiamodid,'',ooiamoddt", 
                      " FROM ooia_t",
                      " WHERE ooiaent= ? AND ooia001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi713_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.ooia001,t0.ooia008,t0.ooia009,t0.ooia007,t0.ooia010,t0.ooia002,t0.ooia039, 
       t0.ooia005,t0.ooia045,t0.ooiastus,t0.ooia004,t0.ooia006,t0.ooia038,t0.ooia043,t0.ooia044,t0.ooia003, 
       t0.ooia040,t0.ooia011,t0.ooia041,t0.ooia012,t0.ooia042,t0.ooia013,t0.ooia014,t0.ooia015,t0.ooia016, 
       t0.ooia017,t0.ooia018,t0.ooia019,t0.ooia020,t0.ooia021,t0.ooia022,t0.ooia023,t0.ooia024,t0.ooia025, 
       t0.ooia026,t0.ooia027,t0.ooia028,t0.ooia029,t0.ooia030,t0.ooia031,t0.ooia032,t0.ooia033,t0.ooia034, 
       t0.ooia035,t0.ooia036,t0.ooia037,t0.ooiaownid,t0.ooiaowndp,t0.ooiacrtid,t0.ooiacrtdp,t0.ooiacrtdt, 
       t0.ooiamodid,t0.ooiamoddt,t1.ooial003 ,t2.ooial003 ,t3.oocql004 ,t4.ooail003 ,t5.ooefl003 ,t6.pmaal004 , 
       t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011",
               " FROM ooia_t t0",
                              " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=t0.ooia007 AND t1.ooial002='"||g_dlang||"' ",
               " LEFT JOIN ooial_t t2 ON t2.ooialent="||g_enterprise||" AND t2.ooial001=t0.ooia010 AND t2.ooial002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='3112' AND t3.oocql002=t0.ooia004 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.ooia006 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.ooia042 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.ooia013 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.ooiaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.ooiaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.ooiacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.ooiacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.ooiamodid  ",
 
               " WHERE t0.ooiaent = " ||g_enterprise|| " AND t0.ooia001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aooi713_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi713 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi713_init()   
 
      #進入選單 Menu (="N")
      CALL aooi713_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi713
      
   END IF 
   
   CLOSE aooi713_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi713.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aooi713_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_main_hidden = 0
   #定義combobox狀態
      CALL cl_set_combo_scc_part('ooiastus','17','N,Y')
 
      CALL cl_set_combo_scc('ooia002','8310') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('b_ooiastus','17','N,Y')
   CALL cl_set_combo_scc('b_ooia002','8310')
   CALL cl_set_combo_scc('b_ooia003','8016')
   CALL cl_set_combo_scc('b_ooia005','8016')
    CALL cl_set_combo_scc('b_ooia045','8016')
   CALL cl_set_combo_scc('b_ooia011','8016')
   CALL cl_set_combo_scc('ooia039','6886')  #added BY LANJJ 2015-12-24 
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aooi713_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aooi713.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aooi713_ui_dialog() 
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

   DEFINE l_success   LIKE type_t.num5 #added By lanjj 2015-12-05
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
            CALL aooi713_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_ooia_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aooi713_init()
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
               CALL aooi713_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aooi713_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aooi713_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aooi713_set_act_visible()
               CALL aooi713_set_act_no_visible()
               IF NOT (g_ooia_m.ooia001 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " ooiaent = " ||g_enterprise|| " AND",
                                     " ooia001 = '", g_ooia_m.ooia001, "' "
 
                  #填到對應位置
                  CALL aooi713_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aooi713_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aooi713_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aooi713_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aooi713_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aooi713_fetch("L")  
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
                  CALL aooi713_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aooi713_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aooi713_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION handling_fee
            LET g_action_choice="handling_fee"
            IF cl_auth_chk_act("handling_fee") THEN
               
               #add-point:ON ACTION handling_fee name="menu2.handling_fee"
               #ADDED BY LANJJ 2015-12-04   整单操作action  ----START----批量产生卡手续费
               IF g_browser[g_current_idx].b_ooiastus = 'Y' THEN 
                  CALL s_transaction_begin()
                  CALL s_aooi713_handling_fee(g_browser[g_current_idx].b_ooia001,  # 款别编号
                                              g_browser[g_current_idx].b_ooia002,  # 款别性质
                                              '',                                  # 门店
                                              '',                                  # 店群
                                              'aooi713')                           # 本程序名
                     RETURNING l_success
                  IF l_success = TRUE THEN 
                     CALL s_transaction_end('Y','0')
                  ELSE 
                     CALL s_transaction_end('N','0')
                  END IF 
               END IF
               #ADDED BY LANJJ 2015-12-04   整单操作action  ---- END ----批量产生卡手续费
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi713_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               CALL aooi713_fetch("")  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi713_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi713_insert()
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aooi713_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi713_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi713_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi713_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi713_set_pk_array()
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
                  CALL aooi713_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               #應用 a53 樣板自動產生(Version:3)
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL aooi713_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
                  LET g_browser_expand[g_browser_expand.getLength()+1].b_ooia002 = g_browser[g_row_index].b_ooia002
                  
               ON COLLAPSE (g_row_index)
                  #樹關閉
 
 
 
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL aooi713_browser_fill(g_wc,"")
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
                  CALL aooi713_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aooi713_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aooi713_set_act_visible()
               CALL aooi713_set_act_no_visible()
               IF NOT (g_ooia_m.ooia001 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " ooiaent = " ||g_enterprise|| " AND",
                                     " ooia001 = '", g_ooia_m.ooia001, "' "
 
                  #填到對應位置
                  CALL aooi713_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL aooi713_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aooi713_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aooi713_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aooi713_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aooi713_fetch("L")  
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
               CALL aooi713_browser_search()
               EXIT DIALOG
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aooi713_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aooi713_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aooi713_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION handling_fee
            LET g_action_choice="handling_fee"
            IF cl_auth_chk_act("handling_fee") THEN
               
               #add-point:ON ACTION handling_fee name="menu.handling_fee"
               #ADDED BY LANJJ 2015-12-04   整单操作action  ----START----批量产生卡手续费
               IF g_browser[g_current_idx].b_ooiastus = 'Y' THEN 
                  CALL s_transaction_begin()
                  CALL s_aooi713_handling_fee(g_browser[g_current_idx].b_ooia001,  # 款别编号
                                              g_browser[g_current_idx].b_ooia002,  # 款别性质
                                              '',                                  # 门店
                                              '',                                  # 店群
                                              'aooi713')                           # 本程序名
                     RETURNING l_success
                  IF l_success = TRUE THEN 
                     CALL s_transaction_end('Y',1)
                  ELSE 
                     CALL s_transaction_end('N',1)
                  END IF 
               END IF
               #ADDED BY LANJJ 2015-12-04   整单操作action  ---- END ----批量产生卡手续费
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi713_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi713_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi713_insert()
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
               CALL aooi713_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi713_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi713_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi713_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi713_set_pk_array()
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
 
{<section id="aooi713.browser_fill" >}
#應用 a30 樣板自動產生(Version:10)
#+ 瀏覽頁簽資料填充(六階樹狀)
PRIVATE FUNCTION aooi713_browser_fill(ps_wc,ps_page_action) 
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE ps_wc              STRING
   DEFINE ps_page_action     STRING
   DEFINE ls_sql             STRING
   DEFINE li_idx             LIKE type_t.num10
   DEFINE li_idx2            LIKE type_t.num10
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_type            STRING
   DEFINE l_type2            STRING
   CLEAR FORM
   INITIALIZE g_ooia_m.* TO NULL
   CALL g_browser.clear()
   
   LET ls_sql = " SELECT DISTINCT ooia002 ",
                " FROM ooia_t ",
                "  ",
                "  LEFT JOIN ooial_t ON ooia001 = ooial001 AND ooial002 = '",g_lang,"' ",
                " WHERE ooiaent = '" ||g_enterprise|| "' AND ", g_wc,
                " ORDER BY ooia002"
                
   PREPARE browse_pre1 FROM ls_sql
   DECLARE browse_cur1 CURSOR FOR browse_pre1
   
   LET l_type = "0"
   LET li_idx = 1 
   FOREACH browse_cur1 INTO g_browser[li_idx].b_ooia002
      
      LET g_browser[li_idx].b_pid     = 0
      LET g_browser[li_idx].b_id      = 0, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = TRUE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_isExp = TRUE
      LET l_type = g_browser[li_idx].b_id
      CALL aooi713_desc_show(li_idx)
      
      --------------------------------------------------------------------------------------
      LET ls_sql = " SELECT DISTINCT ooia001,ooia002,ooia008,ooia009,ooia010,ooia004,oocql004,ooia003,ooia011,ooia005,ooia045,ooiastus ",
                   " FROM ooia_t ",
                   "  LEFT JOIN ooial_t ON ooia001 = ooial001 AND ooial002 = '",g_lang,"' ",
                   "  LEFT JOIN oocql_t ON oocqlent='"||g_enterprise||"' AND oocql001='3112' AND oocql002=ooia004 AND oocql003='",g_lang,"' ",
                   " WHERE ooiaent = '" ||g_enterprise|| "' AND ooia002 = ? AND ooia008 = '1' AND ooia001 IN (SELECT ooia007 FROM ooia_t WHERE ", g_wc,")",
                   " ORDER BY ooia001"
      PREPARE browse_pre2 FROM ls_sql
      DECLARE browse_cur2 CURSOR FOR browse_pre2                  
      OPEN browse_cur2 USING g_browser[li_idx].b_ooia002  
      LET li_idx = li_idx + 1
      
      FOREACH browse_cur2 INTO g_browser[li_idx].b_ooia001,g_browser[li_idx].b_ooia002,g_browser[li_idx].b_ooia008,g_browser[li_idx].b_ooia009,g_browser[li_idx].b_ooia010,g_browser[li_idx].b_ooia004,g_browser[li_idx].b_ooia004_desc,g_browser[li_idx].b_ooia003,g_browser[li_idx].b_ooia011,g_browser[li_idx].b_ooia005,g_browser[li_idx].b_ooia045,g_browser[li_idx].b_ooiastus
         LET g_browser[li_idx].b_pid     = l_type 
         LET g_browser[li_idx].b_id      = l_type , ".", li_idx USING "<<<"
         LET g_browser[li_idx].b_exp     = FALSE
         LET g_browser[li_idx].b_expcode = 2
         LET g_browser[li_idx].b_hasC    = TRUE
         CALL aooi713_desc_show(li_idx)
         LET l_type2 = g_browser[li_idx].b_id
        #LET ls_sql = " SELECT DISTINCT ooia001,ooia002,ooia008,ooia009,ooia010,ooia004,oocql004,ooia003,ooia011,ooia005,ooiastus ",           #161121-00012#1 mark
         LET ls_sql = " SELECT DISTINCT ooia001,ooia002,ooia008,ooia009,ooia010,ooia004,oocql004,ooia003,ooia011,ooia005,ooia045,ooiastus ",   #161121-00012#1 add ooia045
                   " FROM ooia_t ",
                   "  LEFT JOIN ooial_t ON ooia001 = ooial001 AND ooial002 = '",g_lang,"' ",
                   "  LEFT JOIN oocql_t ON oocqlent='"||g_enterprise||"' AND oocql001='3112' AND oocql002=ooia004 AND oocql003='",g_lang,"' ",
                   " WHERE ooiaent = '" ||g_enterprise|| "' AND ooia002 = ? AND ooia007 = ? AND ooia008 = '2' AND ", g_wc,
                   " ORDER BY ooia001"
         PREPARE browse_pre3 FROM ls_sql
         DECLARE browse_cur3 CURSOR FOR browse_pre3                 
         OPEN browse_cur3 USING g_browser[li_idx].b_ooia002,g_browser[li_idx].b_ooia001
         LET li_idx = li_idx + 1
         
        #FOREACH browse_cur3 INTO g_browser[li_idx].b_ooia001,g_browser[li_idx].b_ooia002,g_browser[li_idx].b_ooia008,g_browser[li_idx].b_ooia009,g_browser[li_idx].b_ooia010,g_browser[li_idx].b_ooia004,g_browser[li_idx].b_ooia004_desc,g_browser[li_idx].b_ooia003,g_browser[li_idx].b_ooia011,g_browser[li_idx].b_ooia005,g_browser[li_idx].b_ooiastus                              #161121-00012#1 mark
         FOREACH browse_cur3 INTO g_browser[li_idx].b_ooia001,g_browser[li_idx].b_ooia002,g_browser[li_idx].b_ooia008,g_browser[li_idx].b_ooia009,g_browser[li_idx].b_ooia010,g_browser[li_idx].b_ooia004,g_browser[li_idx].b_ooia004_desc,g_browser[li_idx].b_ooia003,g_browser[li_idx].b_ooia011,g_browser[li_idx].b_ooia005,g_browser[li_idx].b_ooia045,g_browser[li_idx].b_ooiastus  #161121-00012#1 add ooia045
            LET g_browser[li_idx].b_pid     = l_type2 
            LET g_browser[li_idx].b_id      = l_type2 , ".", li_idx USING "<<<"
            LET g_browser[li_idx].b_exp     = FALSE
            LET g_browser[li_idx].b_expcode = 2
            LET g_browser[li_idx].b_hasC    = FALSE
            CALL aooi713_desc_show(li_idx)
            
            LET li_idx = li_idx + 1
            #CALL g_browser.insertElement(li_idx)
         END FOREACH
         #CALL g_browser.insertElement(li_idx)
      END FOREACH                         
      --------------------------------------------------------------------------------------
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
   
   CALL g_browser.deleteElement(g_browser.getLength())
   
   LET g_browser_cnt = g_browser.getLength()

   #瀏覽頁筆數顯示
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   
   #CALL aooi713_fetch("") 
   
   FREE browse_pre1
   FREE browse_pre2   
   RETURN
   
   #end add-point
   
   #add-point:Function前置處理 name="browser_fill.before_fill"
   
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_ooia_m.* TO NULL
   CALL g_browser.clear()
    
   LET ls_sql = " SELECT DISTINCT ooia002 ",
                " FROM ooia_t ",
                "  ",
                "  LEFT JOIN ooial_t ON ooialent = "||g_enterprise||" AND ooia001 = ooial001 AND ooial002 = '",g_dlang,"' ",
                " WHERE ooiaent = " ||g_enterprise|| " AND ", g_wc ,cl_sql_add_filter("ooia_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooia_t")             #WC重組           
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料             
   PREPARE browse_pre FROM ls_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   LET li_idx = 1 
   FOREACH browse_cur INTO g_browser[li_idx].b_ooia002
      
      LET g_browser[li_idx].b_pid     = 0
      LET g_browser[li_idx].b_id      = 0, ".", li_idx USING "<<<"
      LET g_browser[li_idx].b_exp     = FALSE
      LET g_browser[li_idx].b_expcode = 1
      LET g_browser[li_idx].b_hasC    = TRUE
      LET g_browser[li_idx].b_show    = g_browser[li_idx].b_ooia002
      CALL aooi713_desc_show(li_idx)
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
         IF g_browser_expand[li_idx2].b_ooia002.equals(g_browser[li_idx].b_ooia002)
            THEN
            CALL aooi713_browser_expand(li_idx)
            LET g_browser[li_idx].b_isExp = 1  
            LET g_browser[li_idx].b_exp = TRUE
         END IF 
      END FOR
   END FOR
   
   FREE browse_pre
   
END FUNCTION
 
#+ Tree子節點展開
PRIVATE FUNCTION aooi713_browser_expand(pi_id)
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
      CALL aooi713_browser_expand_leaf(pi_id)
      RETURN
   END IF
   
   LET li_lv = g_browser[pi_id].b_expcode
   LET g_browser[pi_id].b_isExp = TRUE
   
   CASE li_lv
      WHEN 1
         LET ls_wc = " AND ooia002 = '",g_browser[pi_id].b_ooia002,"' "
         LET ls_type_list = "ooia002"
      WHEN 2               
         LET ls_wc = " AND ooia002 = '", g_browser[pi_id].b_ooia002, "'"
         LET ls_type_list = "ooia002"
      WHEN 3
         LET ls_wc = " AND ooia002 = '", g_browser[pi_id].b_ooia002, "'"
         LET ls_type_list = "ooia002"
      WHEN 4                
         LET ls_wc = " AND ooia002 = '", g_browser[pi_id].b_ooia002, "'"
         LET ls_type_list = "ooia002"
      WHEN 5
         LET ls_wc = " AND ooia002 = '", g_browser[pi_id].b_ooia002, "'"
         LET ls_type_list = "ooia002"
   END CASE
   
   LET ls_sql = " SELECT DISTINCT   ", ls_type_list, 
                " FROM ooia_t ",
                "  ",
                "  LEFT JOIN ooial_t ON ooialent = "||g_enterprise||" AND ooia001 = ooial001 AND ooial002 = '",g_dlang,"' ",
                " WHERE ooiaent = " ||g_enterprise|| " AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
    
   #add-point:browser_expand段before prepare name="browser_expand.before_prepare"
   
   #end add-point
                
   PREPARE expand_pre FROM ls_sql
   DECLARE expand_cur CURSOR FOR expand_pre
   
   LET li_idx = pi_id + 1
   CALL g_browser.insertElement(li_idx)
   FOREACH expand_cur INTO g_browser[li_idx].b_ooia002
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
      CALL aooi713_desc_show(li_idx)
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
PRIVATE FUNCTION aooi713_browser_expand_leaf(pi_id)
   #add-point:browser_expand_leaf段define(客製用) name="browser_expand_leaf.define_customerization"
   
   #end add-point
   DEFINE pi_id            LIKE type_t.num10
   DEFINE li_lv            LIKE type_t.num10
   DEFINE li_idx           LIKE type_t.num10
   DEFINE ls_wc            STRING
   DEFINE ls_sql           STRING
   DEFINE ls_type_list     STRING
   #add-point:browser_expand_leaf段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand_leaf.define"
   
   #end add-point
   
   LET ls_wc = " AND ooia002 = '", g_browser[pi_id].b_ooia002, "'"
 
   LET ls_sql = " SELECT DISTINCT t0.ooia001,t0.ooia002,t0.ooia008,t0.ooia009,t0.ooia010,t0.ooia004, 
       t0.ooia003,t0.ooia011,t0.ooia005,t0.ooia045,t0.ooiastus ,t1.oocql004",
                " FROM ooia_t t0 ",
                "  ",
                               " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='3112' AND t1.oocql002=t0.ooia004 AND t1.oocql003='"||g_dlang||"' ",
 
               " LEFT JOIN ooial_t ON ooialent = "||g_enterprise||" AND ooia001 = ooial001 AND ooial002 = '",g_dlang,"' ",
                " WHERE ooiaent = " ||g_enterprise|| " AND ", g_wc, ls_wc #,cl_get_extra_cond('zzuser', 'zzgrup')
 
   LET li_lv = g_browser[pi_id].b_expcode 
          
   LET ls_sql = ls_sql, " ORDER BY t0.ooia001"
          
   #add-point:browser_expand_leaf段before prepare name="browser_expand_leaf.before_prepare"
   
   #end add-point 
          
   PREPARE leaf_pre FROM ls_sql
   DECLARE leaf_cur CURSOR FOR leaf_pre
   
   LET g_cnt = pi_id + 1
   CALL g_browser.insertElement(g_cnt)
   FOREACH leaf_cur INTO g_browser[g_cnt].b_ooia001,g_browser[g_cnt].b_ooia002,g_browser[g_cnt].b_ooia008, 
       g_browser[g_cnt].b_ooia009,g_browser[g_cnt].b_ooia010,g_browser[g_cnt].b_ooia004,g_browser[g_cnt].b_ooia003, 
       g_browser[g_cnt].b_ooia011,g_browser[g_cnt].b_ooia005,g_browser[g_cnt].b_ooia045,g_browser[g_cnt].b_ooiastus, 
       g_browser[g_cnt].b_ooia004_desc
      LET g_browser[g_cnt].b_pid     = g_browser[pi_id].b_id 
      LET g_browser[g_cnt].b_id      = g_browser[pi_id].b_id , ".", g_cnt USING "<<<"
      LET g_browser[g_cnt].b_exp     = FALSE
      LET g_browser[g_cnt].b_expcode = li_lv + 1
      LET g_browser[g_cnt].b_hasC    = FALSE
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_ooia001
      CALL aooi713_desc_show(g_cnt)
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
PRIVATE FUNCTION aooi713_desc_show(pi_ac)
   #add-point:desc_show段define (客製用) name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   #add-point:desc_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
   
   #end add-point
   
   LET li_tmp = g_cnt
   LET g_cnt = pi_ac
   
   #add-point:desc_show段desc處理 name="desc_show.show"
   IF NOT cl_null(g_browser[g_cnt].b_ooia001) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_ooia001
      CALL ap_ref_array2(g_ref_fields," SELECT ooial003 FROM ooial_t WHERE ooialent = '"||g_enterprise||"' AND ooial001 = ? AND ooial002 = '"||g_dlang||"'","") RETURNING g_rtn_fields    
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_ooia001,"(",g_rtn_fields[1] ,")"
   ELSE   
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_ooia002
      CALL ap_ref_array2(g_ref_fields," SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '8310' AND gzcbl002 = ? AND gzcbl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields    
      LET g_browser[g_cnt].b_show = g_browser[g_cnt].b_ooia002,"(",g_rtn_fields[1] ,")"      
   END IF
   #end add-point
   LET g_cnt = li_tmp
   
END FUNCTION
 
#+ 簡易快速查詢
PRIVATE FUNCTION aooi713_browser_search()
   #add-point:browser_search段define(客製用) name="browser_search.define_customerization"
   
   #END add-point
   DEFINE ls_wc       STRING   #若有輸入g_searchstr時用來代換g_wc的暫存變數
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
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
 
{<section id="aooi713.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi713_construct()
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
   INITIALIZE g_ooia_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON ooia001,ooia008,ooial003,ooia009,ooia007,ooia010,ooia002,ooia039,ooia005, 
          ooia045,ooiastus,ooia004,ooia006,ooia038,ooia043,ooia044,ooia003,ooia040,ooia011,ooia041,ooia012, 
          ooia042,ooia013,ooia014,ooia015,ooia016,ooia017,ooia018,ooia019,ooia020,ooia021,ooia022,ooia023, 
          ooia024,ooia025,ooia026,ooia027,ooia028,ooia029,ooia030,ooia031,ooia032,ooia033,ooia034,ooia035, 
          ooia036,ooia037,ooiaownid,ooiaowndp,ooiacrtid,ooiacrtdp,ooiacrtdt,ooiamodid,ooiamoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<ooiacrtdt>>----
         AFTER FIELD ooiacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<ooiamoddt>>----
         AFTER FIELD ooiamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ooiacnfdt>>----
         
         #----<<ooiapstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.ooia001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia001
            #add-point:ON ACTION controlp INFIELD ooia001 name="construct.c.ooia001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooia()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooia001  #顯示到畫面上

            NEXT FIELD ooia001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia001
            #add-point:BEFORE FIELD ooia001 name="construct.b.ooia001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia001
            
            #add-point:AFTER FIELD ooia001 name="construct.a.ooia001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia008
            #add-point:BEFORE FIELD ooia008 name="construct.b.ooia008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia008
            
            #add-point:AFTER FIELD ooia008 name="construct.a.ooia008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia008
            #add-point:ON ACTION controlp INFIELD ooia008 name="construct.c.ooia008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooial003
            #add-point:BEFORE FIELD ooial003 name="construct.b.ooial003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooial003
            
            #add-point:AFTER FIELD ooial003 name="construct.a.ooial003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooial003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooial003
            #add-point:ON ACTION controlp INFIELD ooial003 name="construct.c.ooial003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia009
            #add-point:BEFORE FIELD ooia009 name="construct.b.ooia009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia009
            
            #add-point:AFTER FIELD ooia009 name="construct.a.ooia009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia009
            #add-point:ON ACTION controlp INFIELD ooia009 name="construct.c.ooia009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooia007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia007
            #add-point:ON ACTION controlp INFIELD ooia007 name="construct.c.ooia007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooia007  #顯示到畫面上
            NEXT FIELD ooia007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia007
            #add-point:BEFORE FIELD ooia007 name="construct.b.ooia007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia007
            
            #add-point:AFTER FIELD ooia007 name="construct.a.ooia007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia010
            #add-point:ON ACTION controlp INFIELD ooia010 name="construct.c.ooia010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooia010  #顯示到畫面上
            NEXT FIELD ooia010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia010
            #add-point:BEFORE FIELD ooia010 name="construct.b.ooia010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia010
            
            #add-point:AFTER FIELD ooia010 name="construct.a.ooia010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia002
            #add-point:BEFORE FIELD ooia002 name="construct.b.ooia002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia002
            
            #add-point:AFTER FIELD ooia002 name="construct.a.ooia002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia002
            #add-point:ON ACTION controlp INFIELD ooia002 name="construct.c.ooia002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia039
            #add-point:BEFORE FIELD ooia039 name="construct.b.ooia039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia039
            
            #add-point:AFTER FIELD ooia039 name="construct.a.ooia039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia039
            #add-point:ON ACTION controlp INFIELD ooia039 name="construct.c.ooia039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia005
            #add-point:BEFORE FIELD ooia005 name="construct.b.ooia005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia005
            
            #add-point:AFTER FIELD ooia005 name="construct.a.ooia005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia005
            #add-point:ON ACTION controlp INFIELD ooia005 name="construct.c.ooia005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia045
            #add-point:BEFORE FIELD ooia045 name="construct.b.ooia045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia045
            
            #add-point:AFTER FIELD ooia045 name="construct.a.ooia045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia045
            #add-point:ON ACTION controlp INFIELD ooia045 name="construct.c.ooia045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiastus
            #add-point:BEFORE FIELD ooiastus name="construct.b.ooiastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiastus
            
            #add-point:AFTER FIELD ooiastus name="construct.a.ooiastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooiastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiastus
            #add-point:ON ACTION controlp INFIELD ooiastus name="construct.c.ooiastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooia004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia004
            #add-point:ON ACTION controlp INFIELD ooia004 name="construct.c.ooia004"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1= "3112"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooia004  #顯示到畫面上

            NEXT FIELD ooia004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia004
            #add-point:BEFORE FIELD ooia004 name="construct.b.ooia004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia004
            
            #add-point:AFTER FIELD ooia004 name="construct.a.ooia004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia006
            #add-point:ON ACTION controlp INFIELD ooia006 name="construct.c.ooia006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooia006  #顯示到畫面上

            NEXT FIELD ooia006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia006
            #add-point:BEFORE FIELD ooia006 name="construct.b.ooia006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia006
            
            #add-point:AFTER FIELD ooia006 name="construct.a.ooia006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia038
            #add-point:BEFORE FIELD ooia038 name="construct.b.ooia038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia038
            
            #add-point:AFTER FIELD ooia038 name="construct.a.ooia038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia038
            #add-point:ON ACTION controlp INFIELD ooia038 name="construct.c.ooia038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia043
            #add-point:BEFORE FIELD ooia043 name="construct.b.ooia043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia043
            
            #add-point:AFTER FIELD ooia043 name="construct.a.ooia043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia043
            #add-point:ON ACTION controlp INFIELD ooia043 name="construct.c.ooia043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia044
            #add-point:BEFORE FIELD ooia044 name="construct.b.ooia044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia044
            
            #add-point:AFTER FIELD ooia044 name="construct.a.ooia044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia044
            #add-point:ON ACTION controlp INFIELD ooia044 name="construct.c.ooia044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia003
            #add-point:BEFORE FIELD ooia003 name="construct.b.ooia003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia003
            
            #add-point:AFTER FIELD ooia003 name="construct.a.ooia003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia003
            #add-point:ON ACTION controlp INFIELD ooia003 name="construct.c.ooia003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia040
            #add-point:BEFORE FIELD ooia040 name="construct.b.ooia040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia040
            
            #add-point:AFTER FIELD ooia040 name="construct.a.ooia040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia040
            #add-point:ON ACTION controlp INFIELD ooia040 name="construct.c.ooia040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia011
            #add-point:BEFORE FIELD ooia011 name="construct.b.ooia011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia011
            
            #add-point:AFTER FIELD ooia011 name="construct.a.ooia011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia011
            #add-point:ON ACTION controlp INFIELD ooia011 name="construct.c.ooia011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia041
            #add-point:BEFORE FIELD ooia041 name="construct.b.ooia041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia041
            
            #add-point:AFTER FIELD ooia041 name="construct.a.ooia041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia041
            #add-point:ON ACTION controlp INFIELD ooia041 name="construct.c.ooia041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia012
            #add-point:BEFORE FIELD ooia012 name="construct.b.ooia012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia012
            
            #add-point:AFTER FIELD ooia012 name="construct.a.ooia012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia012
            #add-point:ON ACTION controlp INFIELD ooia012 name="construct.c.ooia012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooia042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia042
            #add-point:ON ACTION controlp INFIELD ooia042 name="construct.c.ooia042"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160509-00004#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161019-00017#2
            CALL q_ooef001_1()   #161019-00017#2
            DISPLAY g_qryparam.return1 TO ooia042  #顯示到畫面上
            NEXT FIELD ooia042                     #返回原欄位
            #160509-00004#1--add--end--lujh
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia042
            #add-point:BEFORE FIELD ooia042 name="construct.b.ooia042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia042
            
            #add-point:AFTER FIELD ooia042 name="construct.a.ooia042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia013
            #add-point:ON ACTION controlp INFIELD ooia013 name="construct.c.ooia013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()                           #呼叫開窗   #160913-00055#3 
            CALL q_pmaa001_25()        #160913-00055#3
            DISPLAY g_qryparam.return1 TO ooia013  #顯示到畫面上
            NEXT FIELD ooia013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia013
            #add-point:BEFORE FIELD ooia013 name="construct.b.ooia013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia013
            
            #add-point:AFTER FIELD ooia013 name="construct.a.ooia013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia014
            #add-point:BEFORE FIELD ooia014 name="construct.b.ooia014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia014
            
            #add-point:AFTER FIELD ooia014 name="construct.a.ooia014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia014
            #add-point:ON ACTION controlp INFIELD ooia014 name="construct.c.ooia014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia015
            #add-point:BEFORE FIELD ooia015 name="construct.b.ooia015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia015
            
            #add-point:AFTER FIELD ooia015 name="construct.a.ooia015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia015
            #add-point:ON ACTION controlp INFIELD ooia015 name="construct.c.ooia015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia016
            #add-point:BEFORE FIELD ooia016 name="construct.b.ooia016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia016
            
            #add-point:AFTER FIELD ooia016 name="construct.a.ooia016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia016
            #add-point:ON ACTION controlp INFIELD ooia016 name="construct.c.ooia016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia017
            #add-point:BEFORE FIELD ooia017 name="construct.b.ooia017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia017
            
            #add-point:AFTER FIELD ooia017 name="construct.a.ooia017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia017
            #add-point:ON ACTION controlp INFIELD ooia017 name="construct.c.ooia017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia018
            #add-point:BEFORE FIELD ooia018 name="construct.b.ooia018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia018
            
            #add-point:AFTER FIELD ooia018 name="construct.a.ooia018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia018
            #add-point:ON ACTION controlp INFIELD ooia018 name="construct.c.ooia018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia019
            #add-point:BEFORE FIELD ooia019 name="construct.b.ooia019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia019
            
            #add-point:AFTER FIELD ooia019 name="construct.a.ooia019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia019
            #add-point:ON ACTION controlp INFIELD ooia019 name="construct.c.ooia019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia020
            #add-point:BEFORE FIELD ooia020 name="construct.b.ooia020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia020
            
            #add-point:AFTER FIELD ooia020 name="construct.a.ooia020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia020
            #add-point:ON ACTION controlp INFIELD ooia020 name="construct.c.ooia020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia021
            #add-point:BEFORE FIELD ooia021 name="construct.b.ooia021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia021
            
            #add-point:AFTER FIELD ooia021 name="construct.a.ooia021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia021
            #add-point:ON ACTION controlp INFIELD ooia021 name="construct.c.ooia021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia022
            #add-point:BEFORE FIELD ooia022 name="construct.b.ooia022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia022
            
            #add-point:AFTER FIELD ooia022 name="construct.a.ooia022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia022
            #add-point:ON ACTION controlp INFIELD ooia022 name="construct.c.ooia022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia023
            #add-point:BEFORE FIELD ooia023 name="construct.b.ooia023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia023
            
            #add-point:AFTER FIELD ooia023 name="construct.a.ooia023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia023
            #add-point:ON ACTION controlp INFIELD ooia023 name="construct.c.ooia023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia024
            #add-point:BEFORE FIELD ooia024 name="construct.b.ooia024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia024
            
            #add-point:AFTER FIELD ooia024 name="construct.a.ooia024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia024
            #add-point:ON ACTION controlp INFIELD ooia024 name="construct.c.ooia024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia025
            #add-point:BEFORE FIELD ooia025 name="construct.b.ooia025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia025
            
            #add-point:AFTER FIELD ooia025 name="construct.a.ooia025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia025
            #add-point:ON ACTION controlp INFIELD ooia025 name="construct.c.ooia025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia026
            #add-point:BEFORE FIELD ooia026 name="construct.b.ooia026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia026
            
            #add-point:AFTER FIELD ooia026 name="construct.a.ooia026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia026
            #add-point:ON ACTION controlp INFIELD ooia026 name="construct.c.ooia026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia027
            #add-point:BEFORE FIELD ooia027 name="construct.b.ooia027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia027
            
            #add-point:AFTER FIELD ooia027 name="construct.a.ooia027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia027
            #add-point:ON ACTION controlp INFIELD ooia027 name="construct.c.ooia027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia028
            #add-point:BEFORE FIELD ooia028 name="construct.b.ooia028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia028
            
            #add-point:AFTER FIELD ooia028 name="construct.a.ooia028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia028
            #add-point:ON ACTION controlp INFIELD ooia028 name="construct.c.ooia028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia029
            #add-point:BEFORE FIELD ooia029 name="construct.b.ooia029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia029
            
            #add-point:AFTER FIELD ooia029 name="construct.a.ooia029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia029
            #add-point:ON ACTION controlp INFIELD ooia029 name="construct.c.ooia029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia030
            #add-point:BEFORE FIELD ooia030 name="construct.b.ooia030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia030
            
            #add-point:AFTER FIELD ooia030 name="construct.a.ooia030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia030
            #add-point:ON ACTION controlp INFIELD ooia030 name="construct.c.ooia030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia031
            #add-point:BEFORE FIELD ooia031 name="construct.b.ooia031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia031
            
            #add-point:AFTER FIELD ooia031 name="construct.a.ooia031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia031
            #add-point:ON ACTION controlp INFIELD ooia031 name="construct.c.ooia031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia032
            #add-point:BEFORE FIELD ooia032 name="construct.b.ooia032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia032
            
            #add-point:AFTER FIELD ooia032 name="construct.a.ooia032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia032
            #add-point:ON ACTION controlp INFIELD ooia032 name="construct.c.ooia032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia033
            #add-point:BEFORE FIELD ooia033 name="construct.b.ooia033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia033
            
            #add-point:AFTER FIELD ooia033 name="construct.a.ooia033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia033
            #add-point:ON ACTION controlp INFIELD ooia033 name="construct.c.ooia033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia034
            #add-point:BEFORE FIELD ooia034 name="construct.b.ooia034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia034
            
            #add-point:AFTER FIELD ooia034 name="construct.a.ooia034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia034
            #add-point:ON ACTION controlp INFIELD ooia034 name="construct.c.ooia034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia035
            #add-point:BEFORE FIELD ooia035 name="construct.b.ooia035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia035
            
            #add-point:AFTER FIELD ooia035 name="construct.a.ooia035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia035
            #add-point:ON ACTION controlp INFIELD ooia035 name="construct.c.ooia035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia036
            #add-point:BEFORE FIELD ooia036 name="construct.b.ooia036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia036
            
            #add-point:AFTER FIELD ooia036 name="construct.a.ooia036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia036
            #add-point:ON ACTION controlp INFIELD ooia036 name="construct.c.ooia036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia037
            #add-point:BEFORE FIELD ooia037 name="construct.b.ooia037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia037
            
            #add-point:AFTER FIELD ooia037 name="construct.a.ooia037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooia037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia037
            #add-point:ON ACTION controlp INFIELD ooia037 name="construct.c.ooia037"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooiaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiaownid
            #add-point:ON ACTION controlp INFIELD ooiaownid name="construct.c.ooiaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiaownid  #顯示到畫面上

            NEXT FIELD ooiaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiaownid
            #add-point:BEFORE FIELD ooiaownid name="construct.b.ooiaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiaownid
            
            #add-point:AFTER FIELD ooiaownid name="construct.a.ooiaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooiaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiaowndp
            #add-point:ON ACTION controlp INFIELD ooiaowndp name="construct.c.ooiaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiaowndp  #顯示到畫面上

            NEXT FIELD ooiaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiaowndp
            #add-point:BEFORE FIELD ooiaowndp name="construct.b.ooiaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiaowndp
            
            #add-point:AFTER FIELD ooiaowndp name="construct.a.ooiaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooiacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiacrtid
            #add-point:ON ACTION controlp INFIELD ooiacrtid name="construct.c.ooiacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiacrtid  #顯示到畫面上

            NEXT FIELD ooiacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiacrtid
            #add-point:BEFORE FIELD ooiacrtid name="construct.b.ooiacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiacrtid
            
            #add-point:AFTER FIELD ooiacrtid name="construct.a.ooiacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooiacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiacrtdp
            #add-point:ON ACTION controlp INFIELD ooiacrtdp name="construct.c.ooiacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiacrtdp  #顯示到畫面上

            NEXT FIELD ooiacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiacrtdp
            #add-point:BEFORE FIELD ooiacrtdp name="construct.b.ooiacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiacrtdp
            
            #add-point:AFTER FIELD ooiacrtdp name="construct.a.ooiacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiacrtdt
            #add-point:BEFORE FIELD ooiacrtdt name="construct.b.ooiacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooiamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiamodid
            #add-point:ON ACTION controlp INFIELD ooiamodid name="construct.c.ooiamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiamodid  #顯示到畫面上

            NEXT FIELD ooiamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiamodid
            #add-point:BEFORE FIELD ooiamodid name="construct.b.ooiamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiamodid
            
            #add-point:AFTER FIELD ooiamodid name="construct.a.ooiamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiamoddt
            #add-point:BEFORE FIELD ooiamoddt name="construct.b.ooiamoddt"
            
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
 
{<section id="aooi713.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aooi713_query()
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
 
   INITIALIZE g_ooia_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aooi713_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aooi713_browser_fill(g_wc,"F")
      CALL aooi713_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
      CALL g_browser_expand.clear()
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aooi713_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aooi713_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aooi713.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aooi713_fetch(p_fl)
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
      INITIALIZE g_ooia_m.* TO NULL
      DISPLAY BY NAME g_ooia_m.*
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
   LET g_ooia_m.ooia001 = g_browser[g_current_idx].b_ooia001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aooi713_master_referesh USING g_ooia_m.ooia001 INTO g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooia009, 
       g_ooia_m.ooia007,g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045, 
       g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044, 
       g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042, 
       g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtdp, 
       g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt,g_ooia_m.ooia007_desc,g_ooia_m.ooia010_desc, 
       g_ooia_m.ooia004_desc,g_ooia_m.ooia006_desc,g_ooia_m.ooia042_desc,g_ooia_m.ooia013_desc,g_ooia_m.ooiaownid_desc, 
       g_ooia_m.ooiaowndp_desc,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiamodid_desc 
 
   
   #遮罩相關處理
   LET g_ooia_m_mask_o.* =  g_ooia_m.*
   CALL aooi713_ooia_t_mask()
   LET g_ooia_m_mask_n.* =  g_ooia_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aooi713_set_act_visible()
   CALL aooi713_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_ooia_m_t.* = g_ooia_m.*
   LET g_ooia_m_o.* = g_ooia_m.*
   
   LET g_data_owner = g_ooia_m.ooiaownid      
   LET g_data_dept  = g_ooia_m.ooiaowndp
   
   #重新顯示
   CALL aooi713_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aooi713.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi713_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_ooia_m.* TO NULL             #DEFAULT 設定
   LET g_ooia001_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      #應用 a55 樣板自動產生(Version:3)
      #六階樹狀給值
      LET g_current_idx = g_curr_diag.getCurrentRow("s_browse")
      IF g_current_idx > 0 THEN
         IF NOT cl_null(g_browser[g_current_idx].b_show) THEN
            LET g_ooia_m.ooia002 = g_browser[g_current_idx].b_ooia002
         END IF
      END IF
 
 
 
 
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooia_m.ooiaownid = g_user
      LET g_ooia_m.ooiaowndp = g_dept
      LET g_ooia_m.ooiacrtid = g_user
      LET g_ooia_m.ooiacrtdp = g_dept 
      LET g_ooia_m.ooiacrtdt = cl_get_current()
      LET g_ooia_m.ooiamodid = g_user
      LET g_ooia_m.ooiamoddt = cl_get_current()
      LET g_ooia_m.ooiastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_ooia_m.ooia002 = "10"
      LET g_ooia_m.ooia005 = "Y"
      LET g_ooia_m.ooiastus = "Y"
      LET g_ooia_m.ooia043 = "0"
      LET g_ooia_m.ooia044 = "0"
      LET g_ooia_m.ooia003 = "Y"
      LET g_ooia_m.ooia040 = "Y"
      LET g_ooia_m.ooia011 = "N"
      LET g_ooia_m.ooia041 = "N"
      LET g_ooia_m.ooia012 = "N"
      LET g_ooia_m.ooia016 = "N"
      LET g_ooia_m.ooia020 = "N"
      LET g_ooia_m.ooia021 = "N"
      LET g_ooia_m.ooia023 = "N"
      LET g_ooia_m.ooia024 = "N"
      LET g_ooia_m.ooia025 = "N"
      LET g_ooia_m.ooia026 = "N"
      LET g_ooia_m.ooia027 = "N"
      LET g_ooia_m.ooia028 = "N"
      LET g_ooia_m.ooia029 = "N"
      LET g_ooia_m.ooia030 = "N"
      LET g_ooia_m.ooia031 = "N"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_ooia_m.ooia008 = 1
      LET g_ooia_m.ooia045 = "N"
      CALL cl_set_comp_entry("ooia042",FALSE)   #160509-00004#1 add lujh
      IF g_current_idx > 0 THEN
         IF cl_null(g_browser[g_current_idx].b_ooia008) OR g_browser[g_current_idx].b_ooia008 = '2' THEN 
            LET g_ooia_m.ooia002 = g_browser[g_current_idx].b_ooia002
         END IF 
         IF g_browser[g_current_idx].b_ooia008 = '1' THEN 
            LET g_ooia_m.ooia002 = g_browser[g_current_idx].b_ooia002
            LET g_ooia_m.ooia007 = g_browser[g_current_idx].b_ooia001
            CALL aooi713_ooia007_display()
            LET g_ooia_m.ooia008 = 2
            LET g_ooia_m.ooia009 = 0
            LET g_ooia_m.ooia010 = g_browser[g_current_idx].b_ooia001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooia_m.ooia007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooia_m.ooia007_desc
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia010
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooia_m.ooia010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooia_m.ooia010_desc
         END IF 
      END IF 
      IF cl_null(g_ooia_m.ooia002) THEN 
         LET g_ooia_m.ooia002 = '10'
      END IF 
      #INITIALIZE g_ooia_m_t.* LIKE ooia_t.*   #161124-00048#13  2016/12/14 By 08734 mark
      INITIALIZE g_ooia_m_t.* TO NULL  #161124-00048#13  2016/12/14 By 08734 add
      CALL cl_set_comp_entry("ooia011",TRUE)
      CALL aooi713_tree_refresh()
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooia_m.ooiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aooi713_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL aooi713_browser_fill(g_wc,"")
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_ooia_m.* TO NULL
         CALL aooi713_show()
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
   CALL aooi713_set_act_visible()
   CALL aooi713_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_ooia001_t = g_ooia_m.ooia001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ooiaent = " ||g_enterprise|| " AND",
                      " ooia001 = '", g_ooia_m.ooia001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aooi713_master_referesh USING g_ooia_m.ooia001 INTO g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooia009, 
       g_ooia_m.ooia007,g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045, 
       g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044, 
       g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042, 
       g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtdp, 
       g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt,g_ooia_m.ooia007_desc,g_ooia_m.ooia010_desc, 
       g_ooia_m.ooia004_desc,g_ooia_m.ooia006_desc,g_ooia_m.ooia042_desc,g_ooia_m.ooia013_desc,g_ooia_m.ooiaownid_desc, 
       g_ooia_m.ooiaowndp_desc,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiamodid_desc 
 
   
   
   #遮罩相關處理
   LET g_ooia_m_mask_o.* =  g_ooia_m.*
   CALL aooi713_ooia_t_mask()
   LET g_ooia_m_mask_n.* =  g_ooia_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooial003,g_ooia_m.ooia009,g_ooia_m.ooia007, 
       g_ooia_m.ooia007_desc,g_ooia_m.ooia010,g_ooia_m.ooia010_desc,g_ooia_m.ooia002,g_ooia_m.ooia039, 
       g_ooia_m.ooia005,g_ooia_m.ooia045,g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia004_desc,g_ooia_m.ooia006, 
       g_ooia_m.ooia006_desc,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044,g_ooia_m.ooia003,g_ooia_m.ooia040, 
       g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042,g_ooia_m.ooia042_desc,g_ooia_m.ooia013, 
       g_ooia_m.ooia013_desc,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaownid_desc,g_ooia_m.ooiaowndp,g_ooia_m.ooiaowndp_desc, 
       g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiacrtdt, 
       g_ooia_m.ooiamodid,g_ooia_m.ooiamodid_desc,g_ooia_m.ooiamoddt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_ooia_m.ooiaownid      
   LET g_data_dept  = g_ooia_m.ooiaowndp
 
   #功能已完成,通報訊息中心
   CALL aooi713_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi713.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi713_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_ooia_m.ooia001 IS NULL
 
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
   LET g_ooia001_t = g_ooia_m.ooia001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aooi713_cl USING g_enterprise,g_ooia_m.ooia001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi713_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aooi713_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi713_master_referesh USING g_ooia_m.ooia001 INTO g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooia009, 
       g_ooia_m.ooia007,g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045, 
       g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044, 
       g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042, 
       g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtdp, 
       g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt,g_ooia_m.ooia007_desc,g_ooia_m.ooia010_desc, 
       g_ooia_m.ooia004_desc,g_ooia_m.ooia006_desc,g_ooia_m.ooia042_desc,g_ooia_m.ooia013_desc,g_ooia_m.ooiaownid_desc, 
       g_ooia_m.ooiaowndp_desc,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiamodid_desc 
 
 
   #檢查是否允許此動作
   IF NOT aooi713_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_ooia_m_mask_o.* =  g_ooia_m.*
   CALL aooi713_ooia_t_mask()
   LET g_ooia_m_mask_n.* =  g_ooia_m.*
   
   
 
   #顯示資料
   CALL aooi713_show()
   
   WHILE TRUE
      LET g_ooia_m.ooia001 = g_ooia001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_ooia_m.ooiamodid = g_user 
LET g_ooia_m.ooiamoddt = cl_get_current()
LET g_ooia_m.ooiamodid_desc = cl_get_username(g_ooia_m.ooiamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aooi713_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_ooia_m.* = g_ooia_m_t.*
         CALL aooi713_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE ooia_t SET (ooiamodid,ooiamoddt) = (g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt)
       WHERE ooiaent = g_enterprise AND ooia001 = g_ooia001_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aooi713_set_act_visible()
   CALL aooi713_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ooiaent = " ||g_enterprise|| " AND",
                      " ooia001 = '", g_ooia_m.ooia001, "' "
 
   #填到對應位置
   CALL aooi713_browser_fill(g_wc,"")
 
   CLOSE aooi713_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi713_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aooi713.input" >}
#+ 資料輸入
PRIVATE FUNCTION aooi713_input(p_cmd)
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
   DISPLAY BY NAME g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooial003,g_ooia_m.ooia009,g_ooia_m.ooia007, 
       g_ooia_m.ooia007_desc,g_ooia_m.ooia010,g_ooia_m.ooia010_desc,g_ooia_m.ooia002,g_ooia_m.ooia039, 
       g_ooia_m.ooia005,g_ooia_m.ooia045,g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia004_desc,g_ooia_m.ooia006, 
       g_ooia_m.ooia006_desc,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044,g_ooia_m.ooia003,g_ooia_m.ooia040, 
       g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042,g_ooia_m.ooia042_desc,g_ooia_m.ooia013, 
       g_ooia_m.ooia013_desc,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaownid_desc,g_ooia_m.ooiaowndp,g_ooia_m.ooiaowndp_desc, 
       g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiacrtdt, 
       g_ooia_m.ooiamodid,g_ooia_m.ooiamodid_desc,g_ooia_m.ooiamoddt
   
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
   CALL aooi713_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aooi713_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooial003,g_ooia_m.ooia009,g_ooia_m.ooia007, 
          g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045,g_ooia_m.ooiastus, 
          g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044,g_ooia_m.ooia003, 
          g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042,g_ooia_m.ooia013, 
          g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018,g_ooia_m.ooia019, 
          g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024,g_ooia_m.ooia025, 
          g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030,g_ooia_m.ooia031, 
          g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036,g_ooia_m.ooia037  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_ooia_m.ooia001) THEN
                  CALL n_ooial(g_ooia_m.ooia001)    # n_glafl:對應多語言表格
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooia_m.ooia001
                  CALL ap_ref_array2(g_ref_fields," SELECT ooial003 FROM ooial_t WHERE ooialent = '"||g_enterprise||"' AND ooial001 = ? AND ooial002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
                  LET g_ooia_m.ooial003 = g_rtn_fields[1] 
                  DISPLAY BY NAME g_ooia_m.ooial003
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.ooial001 = g_ooia_m.ooia001
LET g_master_multi_table_t.ooial003 = g_ooia_m.ooial003
 
            #add-point:input開始前 name="input.before.input"
            IF g_ooia_m.ooia008 = 1 THEN 
               CALL cl_set_comp_entry("ooia002",TRUE)
            ELSE
               CALL cl_set_comp_entry("ooia002",FALSE)
            END IF 
            IF g_ooia_m.ooia002 = '30' THEN 
               CALL cl_set_comp_entry("ooia011",TRUE)
            ELSE
               CALL cl_set_comp_entry("ooia011",FALSE)
            END IF
            IF g_ooia_m.ooia003 = 'Y' THEN
               CALL cl_set_comp_entry("ooia006",FALSE)
            ELSE
               CALL cl_set_comp_entry("ooia006",TRUE)            
            END IF
            IF g_ooia_m.ooia012 = 'Y' THEN 
               CALL cl_set_comp_entry("ooia013,ooia014,ooia015,ooia016",TRUE)
            ELSE
               LET g_ooia_m.ooia013 = ''
               LET g_ooia_m.ooia014 = ''
               LET g_ooia_m.ooia015 = ''
               LET g_ooia_m.ooia016 = 'N'
               LET g_ooia_m.ooia013_desc = ''
               DISPLAY BY NAME g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,
                               g_ooia_m.ooia013_desc
               CALL cl_set_comp_entry("ooia013,ooia014,ooia015,ooia016",FALSE)
            END IF
            IF g_ooia_m.ooia021 = 'Y' THEN
               CALL cl_set_comp_entry("ooia022",TRUE)
            ELSE
               LET g_ooia_m.ooia022 = ''
               DISPLAY BY NAME g_ooia_m.ooia022
               CALL cl_set_comp_entry("ooia022",FALSE)
            END IF 
            
            #ADDED BY LANJJ 2015-12-24
            LET g_ooia_m.ooia039 = cl_get_para(g_enterprise,"","E-CIR-0059")
            DISPLAY BY NAME g_ooia_m.ooia039
            #ADDED BY LANJJ 2015-12-24
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia001
            #add-point:BEFORE FIELD ooia001 name="input.b.ooia001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia001
            
            #add-point:AFTER FIELD ooia001 name="input.a.ooia001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooia_m.ooia001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooia_m.ooia001 != g_ooia001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooia_t WHERE "||"ooiaent = '" ||g_enterprise|| "' AND "||"ooia001 = '"||g_ooia_m.ooia001 ||"'",'std-00004',0) THEN 
                     LET g_ooia_m.ooia001 = g_ooia_m_t.ooia001
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF cl_null(g_ooia_m.ooia007) THEN 
                  LET g_ooia_m.ooia007 = g_ooia_m.ooia001
               END IF 
               IF NOT cl_null(g_ooia_m.ooia007) THEN 
                  IF g_ooia_m.ooia001 <> g_ooia_m.ooia007 THEN 
                     CALL cl_set_comp_entry("ooia002",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("ooia002",TRUE)
                  END IF 
               END IF 
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia001
            #add-point:ON CHANGE ooia001 name="input.g.ooia001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia008
            #add-point:BEFORE FIELD ooia008 name="input.b.ooia008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia008
            
            #add-point:AFTER FIELD ooia008 name="input.a.ooia008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia008
            #add-point:ON CHANGE ooia008 name="input.g.ooia008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooial003
            #add-point:BEFORE FIELD ooial003 name="input.b.ooial003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooial003
            
            #add-point:AFTER FIELD ooial003 name="input.a.ooial003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooial003
            #add-point:ON CHANGE ooial003 name="input.g.ooial003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia009
            #add-point:BEFORE FIELD ooia009 name="input.b.ooia009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia009
            
            #add-point:AFTER FIELD ooia009 name="input.a.ooia009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia009
            #add-point:ON CHANGE ooia009 name="input.g.ooia009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia007
            
            #add-point:AFTER FIELD ooia007 name="input.a.ooia007"
            IF NOT cl_null(g_ooia_m.ooia007) THEN 
               IF p_cmd = 'u' AND g_ooia_m.ooia007 != g_ooia_m_t.ooia007 THEN 
                  IF g_ooia_m.ooia008 = 1 AND g_ooia_m.ooia009 > 0 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'aoo-00379' 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()  
                     LET g_ooia_m.ooia007 = g_ooia_m_t.ooia007
                     NEXT FIELD ooia007
                  END IF 
               END IF 
               IF g_ooia_m.ooia007 <> g_ooia_m.ooia001 OR cl_null(g_ooia_m.ooia001) THEN 
                  CALL aooi713_ooia007_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()               
                     LET g_ooia_m.ooia007 = g_ooia_m_t.ooia007
                     NEXT FIELD ooia007
                  END IF
                  IF p_cmd = 'a' OR (p_cmd = 'u' AND g_ooia_m.ooia007 != g_ooia_m_t.ooia007) THEN 
                     CALL aooi713_ooia007_display()
                  END IF 
               ELSE
                  LET g_ooia_m.ooia008 = 1
                  LET g_ooia_m.ooia009 = 0
                  LET g_ooia_m.ooia010 = g_ooia_m.ooia001 
                  DISPLAY BY NAME g_ooia_m.ooia008,g_ooia_m.ooia009,g_ooia_m.ooia010
               END IF    
               IF NOT cl_null(g_ooia_m.ooia001) THEN 
                  IF g_ooia_m.ooia001 <> g_ooia_m.ooia007 THEN 
                     CALL cl_set_comp_entry("ooia002",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("ooia002",TRUE)
                  END IF 
               END IF               
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia007
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooia_m.ooia007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooia_m.ooia007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia007
            #add-point:BEFORE FIELD ooia007 name="input.b.ooia007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia007
            #add-point:ON CHANGE ooia007 name="input.g.ooia007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia010
            
            #add-point:AFTER FIELD ooia010 name="input.a.ooia010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia010
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooia_m.ooia010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooia_m.ooia010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia010
            #add-point:BEFORE FIELD ooia010 name="input.b.ooia010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia010
            #add-point:ON CHANGE ooia010 name="input.g.ooia010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia002
            #add-point:BEFORE FIELD ooia002 name="input.b.ooia002"
            IF g_ooia_m.ooia002 = '30' THEN 
               CALL cl_set_comp_entry("ooia011",TRUE)
            ELSE
               CALL cl_set_comp_entry("ooia011",FALSE)
               LET g_ooia_m.ooia011 = 'N'
            END IF
            DISPLAY BY NAME g_ooia_m.ooia011
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia002
            
            #add-point:AFTER FIELD ooia002 name="input.a.ooia002"
            IF g_ooia_m.ooia002 = '30' THEN 
               CALL cl_set_comp_entry("ooia011",TRUE)
            ELSE
               CALL cl_set_comp_entry("ooia011",FALSE)
               LET g_ooia_m.ooia011 = 'N'
            END IF
            DISPLAY BY NAME g_ooia_m.ooia011
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia002
            #add-point:ON CHANGE ooia002 name="input.g.ooia002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia039
            #add-point:BEFORE FIELD ooia039 name="input.b.ooia039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia039
            
            #add-point:AFTER FIELD ooia039 name="input.a.ooia039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia039
            #add-point:ON CHANGE ooia039 name="input.g.ooia039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia005
            #add-point:BEFORE FIELD ooia005 name="input.b.ooia005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia005
            
            #add-point:AFTER FIELD ooia005 name="input.a.ooia005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia005
            #add-point:ON CHANGE ooia005 name="input.g.ooia005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia045
            #add-point:BEFORE FIELD ooia045 name="input.b.ooia045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia045
            
            #add-point:AFTER FIELD ooia045 name="input.a.ooia045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia045
            #add-point:ON CHANGE ooia045 name="input.g.ooia045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiastus
            #add-point:BEFORE FIELD ooiastus name="input.b.ooiastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiastus
            
            #add-point:AFTER FIELD ooiastus name="input.a.ooiastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooiastus
            #add-point:ON CHANGE ooiastus name="input.g.ooiastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia004
            
            #add-point:AFTER FIELD ooia004 name="input.a.ooia004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia004
            CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '3112' AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
            LET g_ooia_m.ooia004_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_ooia_m.ooia004_desc
           
            IF NOT cl_null(g_ooia_m.ooia004) THEN            
               IF NOT ap_chk_isExist(g_ooia_m.ooia004,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3112' ",'aoo-00189',0) THEN 
                  LET g_ooia_m.ooia004 = g_ooia_m_t.ooia004 
                  NEXT FIELD CURRENT
               END IF 
               IF NOT ap_chk_isExist(g_ooia_m.ooia004,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '3112' AND oocqstus = 'Y' ",'sub-01302',"axri013") THEN #aoo-00190 #160318-00005#32 by 07900-mod
                  LET g_ooia_m.ooia004 = g_ooia_m_t.ooia004 
                  NEXT FIELD CURRENT
               END IF               
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia004
            #add-point:BEFORE FIELD ooia004 name="input.b.ooia004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia004
            #add-point:ON CHANGE ooia004 name="input.g.ooia004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia006
            
            #add-point:AFTER FIELD ooia006 name="input.a.ooia006"
            IF NOT cl_null(g_ooia_m.ooia006) THEN            
               IF NOT ap_chk_isExist(g_ooia_m.ooia006,"SELECT COUNT(*) FROM ooai_t WHERE "||"ooaient = '" ||g_enterprise|| "' AND "||"ooai001 = ? AND ooaistus = 'Y' ",'aoo-00028',0) THEN 
                  LET g_ooia_m.ooia006 = g_ooia_m_t.ooia006 
                  NEXT FIELD CURRENT
               END IF             
            END IF  
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia006
            CALL ap_ref_array2(g_ref_fields," SELECT ooail003 FROM ooail_t WHERE ooailent = '"||g_enterprise||"' AND ooail001 = ? AND ooail002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
            LET g_ooia_m.ooia006_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_ooia_m.ooia006_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia006
            #add-point:BEFORE FIELD ooia006 name="input.b.ooia006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia006
            #add-point:ON CHANGE ooia006 name="input.g.ooia006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia038
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooia_m.ooia038,"0","1","","","azz-00079",1) THEN
               NEXT FIELD ooia038
            END IF 
 
 
 
            #add-point:AFTER FIELD ooia038 name="input.a.ooia038"
            IF NOT cl_null(g_ooia_m.ooia038) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia038
            #add-point:BEFORE FIELD ooia038 name="input.b.ooia038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia038
            #add-point:ON CHANGE ooia038 name="input.g.ooia038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia043
            #add-point:BEFORE FIELD ooia043 name="input.b.ooia043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia043
            
            #add-point:AFTER FIELD ooia043 name="input.a.ooia043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia043
            #add-point:ON CHANGE ooia043 name="input.g.ooia043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia044
            #add-point:BEFORE FIELD ooia044 name="input.b.ooia044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia044
            
            #add-point:AFTER FIELD ooia044 name="input.a.ooia044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia044
            #add-point:ON CHANGE ooia044 name="input.g.ooia044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia003
            #add-point:BEFORE FIELD ooia003 name="input.b.ooia003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia003
            
            #add-point:AFTER FIELD ooia003 name="input.a.ooia003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia003
            #add-point:ON CHANGE ooia003 name="input.g.ooia003"
            IF g_ooia_m.ooia003 = 'Y' THEN
               LET g_ooia_m.ooia006 = ''
               LET g_ooia_m.ooia006_desc = ''
               DISPLAY BY NAME g_ooia_m.ooia006,g_ooia_m.ooia006_desc
               CALL cl_set_comp_entry("ooia006",FALSE)
            ELSE
               CALL cl_set_comp_entry("ooia006",TRUE)            
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia040
            #add-point:BEFORE FIELD ooia040 name="input.b.ooia040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia040
            
            #add-point:AFTER FIELD ooia040 name="input.a.ooia040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia040
            #add-point:ON CHANGE ooia040 name="input.g.ooia040"
            #160509-00004#1--add--str--lujh
            IF g_ooia_m.ooia040 = 'N' THEN 
               LET g_ooia_m.ooia041 = 'Y'
               CALL cl_set_comp_entry("ooia041",FALSE)
               CALL cl_set_comp_entry("ooia042",TRUE)
            ELSE
               CALL cl_set_comp_entry("ooia041",TRUE)
            END IF
            #160509-00004#1--add--end--lujh
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia011
            #add-point:BEFORE FIELD ooia011 name="input.b.ooia011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia011
            
            #add-point:AFTER FIELD ooia011 name="input.a.ooia011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia011
            #add-point:ON CHANGE ooia011 name="input.g.ooia011"
  
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia041
            #add-point:BEFORE FIELD ooia041 name="input.b.ooia041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia041
            
            #add-point:AFTER FIELD ooia041 name="input.a.ooia041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia041
            #add-point:ON CHANGE ooia041 name="input.g.ooia041"
            #160509-00004#4--add--str--lujh
            IF g_ooia_m.ooia041 = 'N' THEN 
               LET g_ooia_m.ooia042 = ''
               LET g_ooia_m.ooia042_desc = ''
               DISPLAY g_ooia_m.ooia042_desc TO ooia042_desc
               CALL cl_set_comp_entry("ooia042",FALSE)
            ELSE
               CALL cl_set_comp_entry("ooia042",TRUE)
            END IF
            #160509-00004#4--add--end--lujh
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia012
            #add-point:BEFORE FIELD ooia012 name="input.b.ooia012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia012
            
            #add-point:AFTER FIELD ooia012 name="input.a.ooia012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia012
            #add-point:ON CHANGE ooia012 name="input.g.ooia012"
            IF g_ooia_m.ooia012 = 'Y' THEN 
               CALL cl_set_comp_entry("ooia013,ooia014,ooia015,ooia016",TRUE)
            ELSE
               LET g_ooia_m.ooia013 = ''
               LET g_ooia_m.ooia014 = ''
               LET g_ooia_m.ooia015 = ''
               LET g_ooia_m.ooia016 = 'N'
               LET g_ooia_m.ooia013_desc = ''
               DISPLAY BY NAME g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,
                               g_ooia_m.ooia013_desc
               CALL cl_set_comp_entry("ooia013,ooia014,ooia015,ooia016",FALSE)
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia042
            
            #add-point:AFTER FIELD ooia042 name="input.a.ooia042"
            #160509-00004#1--add--str--lujh
            IF NOT cl_null(g_ooia_m.ooia042) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooia_m.ooia042

                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN     #161019-00017#2
               IF cl_chk_exist("v_ooef001_13") THEN   #161019-00017#2
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_ooia_m.ooia042 = g_ooia_m_t.ooia042
                  CALL s_desc_get_department_desc(g_ooia_m.ooia042) RETURNING g_ooia_m.ooia042_desc
                  DISPLAY g_ooia_m.ooia042_desc TO ooia042_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_ooia_m.ooia042) RETURNING g_ooia_m.ooia042_desc
            DISPLAY g_ooia_m.ooia042_desc TO ooia042_desc
            #160509-00004#1--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia042
            #add-point:BEFORE FIELD ooia042 name="input.b.ooia042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia042
            #add-point:ON CHANGE ooia042 name="input.g.ooia042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia013
            
            #add-point:AFTER FIELD ooia013 name="input.a.ooia013"
            IF NOT cl_null(g_ooia_m.ooia013) THEN
              IF NOT ap_chk_isExist(g_ooia_m.ooia013,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '"||g_enterprise||"' AND pmaa001 = ? ",'apm-00028',0) THEN 
                 LET g_ooia_m.ooia013 = g_ooia_m_t.ooia013
                 DISPLAY '' TO ooia013_desc
                 NEXT FIELD CURRENT
              END IF
              IF NOT ap_chk_isExist(g_ooia_m.ooia013,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '"||g_enterprise||"' AND pmaa001 = ? AND pmaastus = 'Y' ",'sub-01302',"apmm100") THEN  #apm-00029 #160318-00005#32 by 07900-mod
                 LET g_ooia_m.ooia013 = g_ooia_m_t.ooia013
                 DISPLAY '' TO ooia013_desc
                 NEXT FIELD CURRENT
              END IF              
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooia_m.ooia013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooia_m.ooia013_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia013
            #add-point:BEFORE FIELD ooia013 name="input.b.ooia013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia013
            #add-point:ON CHANGE ooia013 name="input.g.ooia013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia014
            #add-point:BEFORE FIELD ooia014 name="input.b.ooia014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia014
            
            #add-point:AFTER FIELD ooia014 name="input.a.ooia014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia014
            #add-point:ON CHANGE ooia014 name="input.g.ooia014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia015
            #add-point:BEFORE FIELD ooia015 name="input.b.ooia015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia015
            
            #add-point:AFTER FIELD ooia015 name="input.a.ooia015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia015
            #add-point:ON CHANGE ooia015 name="input.g.ooia015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia016
            #add-point:BEFORE FIELD ooia016 name="input.b.ooia016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia016
            
            #add-point:AFTER FIELD ooia016 name="input.a.ooia016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia016
            #add-point:ON CHANGE ooia016 name="input.g.ooia016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia017
            #add-point:BEFORE FIELD ooia017 name="input.b.ooia017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia017
            
            #add-point:AFTER FIELD ooia017 name="input.a.ooia017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia017
            #add-point:ON CHANGE ooia017 name="input.g.ooia017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia018
            #add-point:BEFORE FIELD ooia018 name="input.b.ooia018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia018
            
            #add-point:AFTER FIELD ooia018 name="input.a.ooia018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia018
            #add-point:ON CHANGE ooia018 name="input.g.ooia018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia019
            #add-point:BEFORE FIELD ooia019 name="input.b.ooia019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia019
            
            #add-point:AFTER FIELD ooia019 name="input.a.ooia019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia019
            #add-point:ON CHANGE ooia019 name="input.g.ooia019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia020
            #add-point:BEFORE FIELD ooia020 name="input.b.ooia020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia020
            
            #add-point:AFTER FIELD ooia020 name="input.a.ooia020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia020
            #add-point:ON CHANGE ooia020 name="input.g.ooia020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia021
            #add-point:BEFORE FIELD ooia021 name="input.b.ooia021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia021
            
            #add-point:AFTER FIELD ooia021 name="input.a.ooia021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia021
            #add-point:ON CHANGE ooia021 name="input.g.ooia021"
            IF g_ooia_m.ooia021 = 'Y' THEN
               CALL cl_set_comp_entry("ooia022",TRUE)
            ELSE
               LET g_ooia_m.ooia022 = ''
               DISPLAY BY NAME g_ooia_m.ooia022
               CALL cl_set_comp_entry("ooia022",FALSE)
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooia_m.ooia022,"0","1","","","azz-00079",1) THEN
               NEXT FIELD ooia022
            END IF 
 
 
 
            #add-point:AFTER FIELD ooia022 name="input.a.ooia022"
            IF NOT cl_null(g_ooia_m.ooia022) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia022
            #add-point:BEFORE FIELD ooia022 name="input.b.ooia022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia022
            #add-point:ON CHANGE ooia022 name="input.g.ooia022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia023
            #add-point:BEFORE FIELD ooia023 name="input.b.ooia023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia023
            
            #add-point:AFTER FIELD ooia023 name="input.a.ooia023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia023
            #add-point:ON CHANGE ooia023 name="input.g.ooia023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia024
            #add-point:BEFORE FIELD ooia024 name="input.b.ooia024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia024
            
            #add-point:AFTER FIELD ooia024 name="input.a.ooia024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia024
            #add-point:ON CHANGE ooia024 name="input.g.ooia024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia025
            #add-point:BEFORE FIELD ooia025 name="input.b.ooia025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia025
            
            #add-point:AFTER FIELD ooia025 name="input.a.ooia025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia025
            #add-point:ON CHANGE ooia025 name="input.g.ooia025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia026
            #add-point:BEFORE FIELD ooia026 name="input.b.ooia026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia026
            
            #add-point:AFTER FIELD ooia026 name="input.a.ooia026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia026
            #add-point:ON CHANGE ooia026 name="input.g.ooia026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia027
            #add-point:BEFORE FIELD ooia027 name="input.b.ooia027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia027
            
            #add-point:AFTER FIELD ooia027 name="input.a.ooia027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia027
            #add-point:ON CHANGE ooia027 name="input.g.ooia027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia028
            #add-point:BEFORE FIELD ooia028 name="input.b.ooia028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia028
            
            #add-point:AFTER FIELD ooia028 name="input.a.ooia028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia028
            #add-point:ON CHANGE ooia028 name="input.g.ooia028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia029
            #add-point:BEFORE FIELD ooia029 name="input.b.ooia029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia029
            
            #add-point:AFTER FIELD ooia029 name="input.a.ooia029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia029
            #add-point:ON CHANGE ooia029 name="input.g.ooia029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia030
            #add-point:BEFORE FIELD ooia030 name="input.b.ooia030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia030
            
            #add-point:AFTER FIELD ooia030 name="input.a.ooia030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia030
            #add-point:ON CHANGE ooia030 name="input.g.ooia030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia031
            #add-point:BEFORE FIELD ooia031 name="input.b.ooia031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia031
            
            #add-point:AFTER FIELD ooia031 name="input.a.ooia031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia031
            #add-point:ON CHANGE ooia031 name="input.g.ooia031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia032
            #add-point:BEFORE FIELD ooia032 name="input.b.ooia032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia032
            
            #add-point:AFTER FIELD ooia032 name="input.a.ooia032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia032
            #add-point:ON CHANGE ooia032 name="input.g.ooia032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia033
            #add-point:BEFORE FIELD ooia033 name="input.b.ooia033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia033
            
            #add-point:AFTER FIELD ooia033 name="input.a.ooia033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia033
            #add-point:ON CHANGE ooia033 name="input.g.ooia033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia034
            #add-point:BEFORE FIELD ooia034 name="input.b.ooia034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia034
            
            #add-point:AFTER FIELD ooia034 name="input.a.ooia034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia034
            #add-point:ON CHANGE ooia034 name="input.g.ooia034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia035
            #add-point:BEFORE FIELD ooia035 name="input.b.ooia035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia035
            
            #add-point:AFTER FIELD ooia035 name="input.a.ooia035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia035
            #add-point:ON CHANGE ooia035 name="input.g.ooia035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia036
            #add-point:BEFORE FIELD ooia036 name="input.b.ooia036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia036
            
            #add-point:AFTER FIELD ooia036 name="input.a.ooia036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia036
            #add-point:ON CHANGE ooia036 name="input.g.ooia036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooia037
            #add-point:BEFORE FIELD ooia037 name="input.b.ooia037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooia037
            
            #add-point:AFTER FIELD ooia037 name="input.a.ooia037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooia037
            #add-point:ON CHANGE ooia037 name="input.g.ooia037"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooia001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia001
            #add-point:ON ACTION controlp INFIELD ooia001 name="input.c.ooia001"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia008
            #add-point:ON ACTION controlp INFIELD ooia008 name="input.c.ooia008"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooial003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooial003
            #add-point:ON ACTION controlp INFIELD ooial003 name="input.c.ooial003"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia009
            #add-point:ON ACTION controlp INFIELD ooia009 name="input.c.ooia009"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia007
            #add-point:ON ACTION controlp INFIELD ooia007 name="input.c.ooia007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooia_m.ooia007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooia001()                                #呼叫開窗

            LET g_ooia_m.ooia007 = g_qryparam.return1              

            DISPLAY g_ooia_m.ooia007 TO ooia007              #

            NEXT FIELD ooia007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooia010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia010
            #add-point:ON ACTION controlp INFIELD ooia010 name="input.c.ooia010"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia002
            #add-point:ON ACTION controlp INFIELD ooia002 name="input.c.ooia002"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia039
            #add-point:ON ACTION controlp INFIELD ooia039 name="input.c.ooia039"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia005
            #add-point:ON ACTION controlp INFIELD ooia005 name="input.c.ooia005"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia045
            #add-point:ON ACTION controlp INFIELD ooia045 name="input.c.ooia045"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooiastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiastus
            #add-point:ON ACTION controlp INFIELD ooiastus name="input.c.ooiastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia004
            #add-point:ON ACTION controlp INFIELD ooia004 name="input.c.ooia004"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooia_m.ooia004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3112" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_ooia_m.ooia004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooia_m.ooia004 TO ooia004              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia004
            CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '3112' AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
            LET g_ooia_m.ooia004_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_ooia_m.ooia004_desc
            NEXT FIELD ooia004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooia006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia006
            #add-point:ON ACTION controlp INFIELD ooia006 name="input.c.ooia006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooia_m.ooia006             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_ooia_m.ooia006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooia_m.ooia006 TO ooia006              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia006
            CALL ap_ref_array2(g_ref_fields," SELECT ooail003 FROM ooail_t WHERE ooailent = '"||g_enterprise||"' AND ooail001 = ? AND ooail002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
            LET g_ooia_m.ooia006_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_ooia_m.ooia006_desc
            NEXT FIELD ooia006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooia038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia038
            #add-point:ON ACTION controlp INFIELD ooia038 name="input.c.ooia038"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia043
            #add-point:ON ACTION controlp INFIELD ooia043 name="input.c.ooia043"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia044
            #add-point:ON ACTION controlp INFIELD ooia044 name="input.c.ooia044"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia003
            #add-point:ON ACTION controlp INFIELD ooia003 name="input.c.ooia003"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia040
            #add-point:ON ACTION controlp INFIELD ooia040 name="input.c.ooia040"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia011
            #add-point:ON ACTION controlp INFIELD ooia011 name="input.c.ooia011"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia041
            #add-point:ON ACTION controlp INFIELD ooia041 name="input.c.ooia041"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia012
            #add-point:ON ACTION controlp INFIELD ooia012 name="input.c.ooia012"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia042
            #add-point:ON ACTION controlp INFIELD ooia042 name="input.c.ooia042"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160509-00004#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_ooia_m.ooia042             #給予default值
            LET g_qryparam.default2 = "" #g_ooia_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            #CALL q_ooef001()      #161019-00017#2
            CALL q_ooef001_1()   #161019-00017#2
            LET g_ooia_m.ooia042 = g_qryparam.return1  
            DISPLAY g_ooia_m.ooia042 TO ooia042 
            CALL s_desc_get_department_desc(g_ooia_m.ooia042) RETURNING g_ooia_m.ooia042_desc      
            DISPLAY g_ooia_m.ooia042_desc TO ooia042_desc            
            NEXT FIELD ooia042                          #返回原欄位
            #160509-00004#1--add--str--lujh
            #END add-point
 
 
         #Ctrlp:input.c.ooia013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia013
            #add-point:ON ACTION controlp INFIELD ooia013 name="input.c.ooia013"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooia_m.ooia013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_pmaa001()                                #呼叫開窗  #160913-00055#3 
            CALL q_pmaa001_25()        #160913-00055#3s

            LET g_ooia_m.ooia013 = g_qryparam.return1              

            DISPLAY g_ooia_m.ooia013 TO ooia013              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooia_m.ooia013
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooia_m.ooia013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooia_m.ooia013_desc
            NEXT FIELD ooia013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.ooia014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia014
            #add-point:ON ACTION controlp INFIELD ooia014 name="input.c.ooia014"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia015
            #add-point:ON ACTION controlp INFIELD ooia015 name="input.c.ooia015"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia016
            #add-point:ON ACTION controlp INFIELD ooia016 name="input.c.ooia016"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia017
            #add-point:ON ACTION controlp INFIELD ooia017 name="input.c.ooia017"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia018
            #add-point:ON ACTION controlp INFIELD ooia018 name="input.c.ooia018"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia019
            #add-point:ON ACTION controlp INFIELD ooia019 name="input.c.ooia019"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia020
            #add-point:ON ACTION controlp INFIELD ooia020 name="input.c.ooia020"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia021
            #add-point:ON ACTION controlp INFIELD ooia021 name="input.c.ooia021"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia022
            #add-point:ON ACTION controlp INFIELD ooia022 name="input.c.ooia022"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia023
            #add-point:ON ACTION controlp INFIELD ooia023 name="input.c.ooia023"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia024
            #add-point:ON ACTION controlp INFIELD ooia024 name="input.c.ooia024"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia025
            #add-point:ON ACTION controlp INFIELD ooia025 name="input.c.ooia025"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia026
            #add-point:ON ACTION controlp INFIELD ooia026 name="input.c.ooia026"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia027
            #add-point:ON ACTION controlp INFIELD ooia027 name="input.c.ooia027"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia028
            #add-point:ON ACTION controlp INFIELD ooia028 name="input.c.ooia028"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia029
            #add-point:ON ACTION controlp INFIELD ooia029 name="input.c.ooia029"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia030
            #add-point:ON ACTION controlp INFIELD ooia030 name="input.c.ooia030"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia031
            #add-point:ON ACTION controlp INFIELD ooia031 name="input.c.ooia031"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia032
            #add-point:ON ACTION controlp INFIELD ooia032 name="input.c.ooia032"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia033
            #add-point:ON ACTION controlp INFIELD ooia033 name="input.c.ooia033"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia034
            #add-point:ON ACTION controlp INFIELD ooia034 name="input.c.ooia034"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia035
            #add-point:ON ACTION controlp INFIELD ooia035 name="input.c.ooia035"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia036
            #add-point:ON ACTION controlp INFIELD ooia036 name="input.c.ooia036"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooia037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooia037
            #add-point:ON ACTION controlp INFIELD ooia037 name="input.c.ooia037"
            
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
               SELECT COUNT(1) INTO l_count FROM ooia_t
                WHERE ooiaent = g_enterprise AND ooia001 = g_ooia_m.ooia001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO ooia_t (ooiaent,ooia001,ooia008,ooia009,ooia007,ooia010,ooia002,ooia039, 
                      ooia005,ooia045,ooiastus,ooia004,ooia006,ooia038,ooia043,ooia044,ooia003,ooia040, 
                      ooia011,ooia041,ooia012,ooia042,ooia013,ooia014,ooia015,ooia016,ooia017,ooia018, 
                      ooia019,ooia020,ooia021,ooia022,ooia023,ooia024,ooia025,ooia026,ooia027,ooia028, 
                      ooia029,ooia030,ooia031,ooia032,ooia033,ooia034,ooia035,ooia036,ooia037,ooiaownid, 
                      ooiaowndp,ooiacrtid,ooiacrtdp,ooiacrtdt,ooiamodid,ooiamoddt)
                  VALUES (g_enterprise,g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooia009,g_ooia_m.ooia007, 
                      g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045, 
                      g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043, 
                      g_ooia_m.ooia044,g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041, 
                      g_ooia_m.ooia012,g_ooia_m.ooia042,g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015, 
                      g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018,g_ooia_m.ooia019,g_ooia_m.ooia020, 
                      g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024,g_ooia_m.ooia025, 
                      g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
                      g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035, 
                      g_ooia_m.ooia036,g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid, 
                      g_ooia_m.ooiacrtdp,g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooia_t:",SQLERRMESSAGE 
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
         IF g_ooia_m.ooia001 = g_master_multi_table_t.ooial001 AND
         g_ooia_m.ooial003 = g_master_multi_table_t.ooial003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'ooialent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_ooia_m.ooia001
            LET l_field_keys[02] = 'ooial001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.ooial001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'ooial002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_ooia_m.ooial003
            LET l_fields[01] = 'ooial003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'ooial_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  CALL aooi713_upd_ooia009()
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_ooia_m.ooia001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi713_ooia_t_mask_restore('restore_mask_o')
               
               UPDATE ooia_t SET (ooia001,ooia008,ooia009,ooia007,ooia010,ooia002,ooia039,ooia005,ooia045, 
                   ooiastus,ooia004,ooia006,ooia038,ooia043,ooia044,ooia003,ooia040,ooia011,ooia041, 
                   ooia012,ooia042,ooia013,ooia014,ooia015,ooia016,ooia017,ooia018,ooia019,ooia020,ooia021, 
                   ooia022,ooia023,ooia024,ooia025,ooia026,ooia027,ooia028,ooia029,ooia030,ooia031,ooia032, 
                   ooia033,ooia034,ooia035,ooia036,ooia037,ooiaownid,ooiaowndp,ooiacrtid,ooiacrtdp,ooiacrtdt, 
                   ooiamodid,ooiamoddt) = (g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooia009,g_ooia_m.ooia007, 
                   g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045, 
                   g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043, 
                   g_ooia_m.ooia044,g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041, 
                   g_ooia_m.ooia012,g_ooia_m.ooia042,g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015, 
                   g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018,g_ooia_m.ooia019,g_ooia_m.ooia020, 
                   g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024,g_ooia_m.ooia025, 
                   g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
                   g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035, 
                   g_ooia_m.ooia036,g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid, 
                   g_ooia_m.ooiacrtdp,g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt)
                WHERE ooiaent = g_enterprise AND ooia001 = g_ooia001_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooia_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooia_t:",SQLERRMESSAGE 
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
         IF g_ooia_m.ooia001 = g_master_multi_table_t.ooial001 AND
         g_ooia_m.ooial003 = g_master_multi_table_t.ooial003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'ooialent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_ooia_m.ooia001
            LET l_field_keys[02] = 'ooial001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.ooial001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'ooial002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_ooia_m.ooial003
            LET l_fields[01] = 'ooial003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'ooial_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aooi713_ooia_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     CALL aooi713_upd_ooia002()
                     CALL aooi713_upd_ooia009()
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_ooia_m_t)
                     LET g_log2 = util.JSON.stringify(g_ooia_m)
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
 
{<section id="aooi713.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aooi713_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE ooia_t.ooia001 
   DEFINE l_oldno     LIKE ooia_t.ooia001 
 
   DEFINE l_master    RECORD LIKE ooia_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   #DEFINE l_master1   RECORD LIKE ooial_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_master1 RECORD  #款別主檔多語言檔
       ooialent LIKE ooial_t.ooialent, #企业编号
       ooial001 LIKE ooial_t.ooial001, #款别编号
       ooial002 LIKE ooial_t.ooial002, #语言别
       ooial003 LIKE ooial_t.ooial003, #说明
       ooial004 LIKE ooial_t.ooial004 #助记码
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_ooia_m.ooia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_ooia001_t = g_ooia_m.ooia001
 
   
   #清空key值
   LET g_ooia_m.ooia001 = ""
 
    
   CALL aooi713_set_entry("a")
   CALL aooi713_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooia_m.ooiaownid = g_user
      LET g_ooia_m.ooiaowndp = g_dept
      LET g_ooia_m.ooiacrtid = g_user
      LET g_ooia_m.ooiacrtdp = g_dept 
      LET g_ooia_m.ooiacrtdt = cl_get_current()
      LET g_ooia_m.ooiamodid = g_user
      LET g_ooia_m.ooiamoddt = cl_get_current()
      LET g_ooia_m.ooiastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_ooia_m.ooiastus = "Y"
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooia_m.ooiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aooi713_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_ooia_m.* TO NULL
      CALL aooi713_show()
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
      LET g_errparam.extend = "ooia_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   #SELECT * INTO l_master1.* FROM ooial_t   #161124-00048#13  2016/12/14 By 08734 mark
   SELECT ooialent,ooial001,ooial002,ooial003,ooial004  #161124-00048#13  2016/12/14 By 08734 add
   INTO l_master1.* FROM ooial_t   
    WHERE ooialent = g_enterprise AND ooial001 = g_ooia_m.ooia001 AND ooial002 = g_dlang
   #LET l_master1.ooial001 = l_newno 
   #INSERT INTO ooial_t VALUES (l_master1.*)  #161124-00048#13  2016/12/14 By 08734 mark
   INSERT INTO ooial_t(ooialent,ooial001,ooial002,ooial003,ooial004)
      VALUES (l_master1.ooialent,l_master1.ooial001,l_master1.ooial002,l_master1.ooial003,l_master1.ooial004)  #161124-00048#13  2016/12/14 By 08734 add
   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ooial_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aooi713_set_act_visible()
   CALL aooi713_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_ooia001_t = g_ooia_m.ooia001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ooiaent = " ||g_enterprise|| " AND",
                      " ooia001 = '", g_ooia_m.ooia001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_ooia_m.ooiaownid      
   LET g_data_dept  = g_ooia_m.ooiaowndp
              
   #功能已完成,通報訊息中心
   CALL aooi713_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aooi713.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aooi713_show()
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
   CALL aooi713_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   #160509-00004#1--add--str--lujh
   IF g_ooia_m.ooia040 = 'N' THEN 
      CALL cl_set_comp_entry("ooia041",FALSE)
      CALL cl_set_comp_entry("ooia042",TRUE)
   ELSE
      CALL cl_set_comp_entry("ooia041",TRUE)
   END IF
   
   IF g_ooia_m.ooia041 = 'N' THEN 
      CALL cl_set_comp_entry("ooia042",FALSE)
   ELSE
      CALL cl_set_comp_entry("ooia042",TRUE)
   END IF
   #160509-00004#1--add--end--lujh
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooia001
   CALL ap_ref_array2(g_ref_fields," SELECT ooial003 FROM ooial_t WHERE ooialent = '"||g_enterprise||"' AND ooial001 = ? AND ooial002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_ooia_m.ooial003 = g_rtn_fields[1] 
   DISPLAY BY NAME g_ooia_m.ooial003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooia004
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '3112' AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_ooia_m.ooia004_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_ooia_m.ooia004_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooiaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ooia_m.ooiaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooia_m.ooiaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooiaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooia_m.ooiaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooia_m.ooiaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooiacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ooia_m.ooiacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooia_m.ooiacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooiacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooia_m.ooiacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooia_m.ooiacrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooiamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ooia_m.ooiamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooia_m.ooiamodid_desc
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooial003,g_ooia_m.ooia009,g_ooia_m.ooia007, 
       g_ooia_m.ooia007_desc,g_ooia_m.ooia010,g_ooia_m.ooia010_desc,g_ooia_m.ooia002,g_ooia_m.ooia039, 
       g_ooia_m.ooia005,g_ooia_m.ooia045,g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia004_desc,g_ooia_m.ooia006, 
       g_ooia_m.ooia006_desc,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044,g_ooia_m.ooia003,g_ooia_m.ooia040, 
       g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042,g_ooia_m.ooia042_desc,g_ooia_m.ooia013, 
       g_ooia_m.ooia013_desc,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaownid_desc,g_ooia_m.ooiaowndp,g_ooia_m.ooiaowndp_desc, 
       g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiacrtdt, 
       g_ooia_m.ooiamodid,g_ooia_m.ooiamodid_desc,g_ooia_m.ooiamoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aooi713_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooia_m.ooiastus 
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
 
{<section id="aooi713.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aooi713_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_n             LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_ooia_m.ooia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_ooia001_t = g_ooia_m.ooia001
 
   
   LET g_master_multi_table_t.ooial001 = g_ooia_m.ooia001
LET g_master_multi_table_t.ooial003 = g_ooia_m.ooial003
 
 
   OPEN aooi713_cl USING g_enterprise,g_ooia_m.ooia001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi713_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aooi713_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi713_master_referesh USING g_ooia_m.ooia001 INTO g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooia009, 
       g_ooia_m.ooia007,g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045, 
       g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044, 
       g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042, 
       g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtdp, 
       g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt,g_ooia_m.ooia007_desc,g_ooia_m.ooia010_desc, 
       g_ooia_m.ooia004_desc,g_ooia_m.ooia006_desc,g_ooia_m.ooia042_desc,g_ooia_m.ooia013_desc,g_ooia_m.ooiaownid_desc, 
       g_ooia_m.ooiaowndp_desc,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiamodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aooi713_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_ooia_m_mask_o.* =  g_ooia_m.*
   CALL aooi713_ooia_t_mask()
   LET g_ooia_m_mask_n.* =  g_ooia_m.*
   
   #將最新資料顯示到畫面上
   CALL aooi713_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      #检查是否存在下级款别
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 <> g_ooia_m.ooia001 
         AND ooia007 = g_ooia_m.ooia001 
      IF l_n > 0 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ""
         LET g_errparam.code   = "aoo-00366" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         CLOSE aooi713_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi713_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM ooia_t 
       WHERE ooiaent = g_enterprise AND ooia001 = g_ooia_m.ooia001 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooia_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      
      END IF      
      CALL aooi713_upd_ooia009()
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooia_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'ooialent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.ooial001
   LET l_field_keys[02] = 'ooial001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'ooial_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      CALL aooi713_browser_fill(" 1=1 ","F")
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_ooia_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aooi713_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aooi713_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         CALL aooi713_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aooi713_cl
 
   #功能已完成,通報訊息中心
   CALL aooi713_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aooi713.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aooi713_ui_browser_refresh()
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
      IF g_browser[l_i].b_ooia001 = g_ooia_m.ooia001
 
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
 
{<section id="aooi713.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aooi713_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("ooia001",TRUE)
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
 
{<section id="aooi713.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aooi713_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("ooia001",FALSE)
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
 
{<section id="aooi713.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aooi713_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi713.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aooi713_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi713.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi713_default_search()
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
      LET ls_wc = ls_wc, " ooia001 = '", g_argv[01], "' AND "
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
 
{<section id="aooi713.mask_functions" >}
&include "erp/aoo/aooi713_mask.4gl"
 
{</section>}
 
{<section id="aooi713.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aooi713_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_ooia_m.ooia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aooi713_cl USING g_enterprise,g_ooia_m.ooia001
   IF STATUS THEN
      CLOSE aooi713_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi713_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aooi713_master_referesh USING g_ooia_m.ooia001 INTO g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooia009, 
       g_ooia_m.ooia007,g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005,g_ooia_m.ooia045, 
       g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044, 
       g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042, 
       g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtdp, 
       g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt,g_ooia_m.ooia007_desc,g_ooia_m.ooia010_desc, 
       g_ooia_m.ooia004_desc,g_ooia_m.ooia006_desc,g_ooia_m.ooia042_desc,g_ooia_m.ooia013_desc,g_ooia_m.ooiaownid_desc, 
       g_ooia_m.ooiaowndp_desc,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiamodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aooi713_action_chk() THEN
      CLOSE aooi713_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooial003,g_ooia_m.ooia009,g_ooia_m.ooia007, 
       g_ooia_m.ooia007_desc,g_ooia_m.ooia010,g_ooia_m.ooia010_desc,g_ooia_m.ooia002,g_ooia_m.ooia039, 
       g_ooia_m.ooia005,g_ooia_m.ooia045,g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia004_desc,g_ooia_m.ooia006, 
       g_ooia_m.ooia006_desc,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044,g_ooia_m.ooia003,g_ooia_m.ooia040, 
       g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042,g_ooia_m.ooia042_desc,g_ooia_m.ooia013, 
       g_ooia_m.ooia013_desc,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018, 
       g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024, 
       g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030, 
       g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036, 
       g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaownid_desc,g_ooia_m.ooiaowndp,g_ooia_m.ooiaowndp_desc, 
       g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp,g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiacrtdt, 
       g_ooia_m.ooiamodid,g_ooia_m.ooiamodid_desc,g_ooia_m.ooiamoddt
 
   CASE g_ooia_m.ooiastus
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
         CASE g_ooia_m.ooiastus
            
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
         IF NOT aooi713_state_chk() THEN 
            LET lc_state = "Y"
         END IF
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
      g_ooia_m.ooiastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aooi713_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_ooia_m.ooiamodid = g_user
   LET g_ooia_m.ooiamoddt = cl_get_current()
   LET g_ooia_m.ooiastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE ooia_t 
      SET (ooiastus,ooiamodid,ooiamoddt) 
        = (g_ooia_m.ooiastus,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt)     
    WHERE ooiaent = g_enterprise AND ooia001 = g_ooia_m.ooia001
 
    
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
      EXECUTE aooi713_master_referesh USING g_ooia_m.ooia001 INTO g_ooia_m.ooia001,g_ooia_m.ooia008, 
          g_ooia_m.ooia009,g_ooia_m.ooia007,g_ooia_m.ooia010,g_ooia_m.ooia002,g_ooia_m.ooia039,g_ooia_m.ooia005, 
          g_ooia_m.ooia045,g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia006,g_ooia_m.ooia038,g_ooia_m.ooia043, 
          g_ooia_m.ooia044,g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012, 
          g_ooia_m.ooia042,g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015,g_ooia_m.ooia016,g_ooia_m.ooia017, 
          g_ooia_m.ooia018,g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021,g_ooia_m.ooia022,g_ooia_m.ooia023, 
          g_ooia_m.ooia024,g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027,g_ooia_m.ooia028,g_ooia_m.ooia029, 
          g_ooia_m.ooia030,g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033,g_ooia_m.ooia034,g_ooia_m.ooia035, 
          g_ooia_m.ooia036,g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaowndp,g_ooia_m.ooiacrtid, 
          g_ooia_m.ooiacrtdp,g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamoddt,g_ooia_m.ooia007_desc, 
          g_ooia_m.ooia010_desc,g_ooia_m.ooia004_desc,g_ooia_m.ooia006_desc,g_ooia_m.ooia042_desc,g_ooia_m.ooia013_desc, 
          g_ooia_m.ooiaownid_desc,g_ooia_m.ooiaowndp_desc,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp_desc, 
          g_ooia_m.ooiamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_ooia_m.ooia001,g_ooia_m.ooia008,g_ooia_m.ooial003,g_ooia_m.ooia009,g_ooia_m.ooia007, 
          g_ooia_m.ooia007_desc,g_ooia_m.ooia010,g_ooia_m.ooia010_desc,g_ooia_m.ooia002,g_ooia_m.ooia039, 
          g_ooia_m.ooia005,g_ooia_m.ooia045,g_ooia_m.ooiastus,g_ooia_m.ooia004,g_ooia_m.ooia004_desc, 
          g_ooia_m.ooia006,g_ooia_m.ooia006_desc,g_ooia_m.ooia038,g_ooia_m.ooia043,g_ooia_m.ooia044, 
          g_ooia_m.ooia003,g_ooia_m.ooia040,g_ooia_m.ooia011,g_ooia_m.ooia041,g_ooia_m.ooia012,g_ooia_m.ooia042, 
          g_ooia_m.ooia042_desc,g_ooia_m.ooia013,g_ooia_m.ooia013_desc,g_ooia_m.ooia014,g_ooia_m.ooia015, 
          g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018,g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021, 
          g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024,g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027, 
          g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030,g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033, 
          g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036,g_ooia_m.ooia037,g_ooia_m.ooiaownid,g_ooia_m.ooiaownid_desc, 
          g_ooia_m.ooiaowndp,g_ooia_m.ooiaowndp_desc,g_ooia_m.ooiacrtid,g_ooia_m.ooiacrtid_desc,g_ooia_m.ooiacrtdp, 
          g_ooia_m.ooiacrtdp_desc,g_ooia_m.ooiacrtdt,g_ooia_m.ooiamodid,g_ooia_m.ooiamodid_desc,g_ooia_m.ooiamoddt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aooi713_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi713_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi713.signature" >}
   
 
{</section>}
 
{<section id="aooi713.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi713_set_pk_array()
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
   LET g_pk_array[1].values = g_ooia_m.ooia001
   LET g_pk_array[1].column = 'ooia001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi713.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aooi713.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aooi713_msgcentre_notify(lc_state)
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
   CALL aooi713_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_ooia_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi713.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aooi713_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aooi713.other_function" readonly="Y" >}
#+ 置無效時檢查是否存在款別據點設定檔
PRIVATE FUNCTION aooi713_state_chk()
   DEFINE l_cnt     LIKE type_t.num5

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM ooia_t 
    WHERE ooiaent = g_enterprise 
      AND ooia007 = g_ooia_m.ooia001
      AND ooia008 <> '1'
      AND ooiastus = 'Y'
   IF l_cnt > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00388'
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN FALSE  
   END IF 
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM ooie_t 
    WHERE ooieent = g_enterprise AND ooie001 = g_ooia_m.ooia001 
   IF l_cnt > 0 THEN 
      IF cl_ask_promp('aoo-00236') THEN 
         UPDATE ooie_t SET ooiestus = 'N' 
          WHERE ooieent = g_enterprise AND ooie001 = g_ooia_m.ooia001 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()

            RETURN FALSE                
         END IF 
      ELSE
         RETURN FALSE      
      END IF      
   END IF
   RETURN TRUE 
END FUNCTION

################################################################################
# Descriptions...: 查询所属一级品类
# Memo...........:
# Usage..........: CALL aooi713_search_ooia010()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi713_search_ooia010()
   DEFINE l_ooia001    LIKE ooia_t.ooia001
   DEFINE l_ooia008    LIKE ooia_t.ooia008
   
   IF g_ooia_m.ooia001 != g_ooia_m.ooia007 THEN
      LET l_ooia001 = g_ooia_m.ooia007
      WHILE TRUE
         LET l_ooia008 = ''
         SELECT ooia007,ooia008 INTO l_ooia001,l_ooia008 FROM ooia_t
          WHERE ooia001 = l_ooia001 
            AND ooiaent = g_enterprise  #160905-00007#9  add
         IF l_ooia008 = 1 OR cl_null(l_ooia008) THEN
            LET g_ooia_m.ooia010 = l_ooia001
            EXIT WHILE
         ELSE
            CONTINUE WHILE
         END IF      
      END WHILE
   ELSE
      LET g_ooia_m.ooia010 = g_ooia_m.ooia001
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooia_m.ooia010
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooia_m.ooia010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooia_m.ooia010_desc
END FUNCTION

################################################################################
# Descriptions...: 计算层级
# Memo...........:
# Usage..........: CALL aooi713_cal_ooia008()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi713_cal_ooia008()
   DEFINE l_ooia008   LIKE ooia_t.ooia008
   
   IF g_ooia_m.ooia001 = g_ooia_m.ooia007 THEN
      LET g_ooia_m.ooia008 = 1
   ELSE
      LET l_ooia008 = ''
      SELECT ooia008 INTO l_ooia008 FROM ooia_t
       WHERE ooia001 = g_ooia_m.ooia007
         AND ooiaent = g_enterprise
      IF cl_null(l_ooia008) THEN
         LET g_ooia_m.ooia008 = 1
      ELSE
         LET g_ooia_m.ooia008 = l_ooia008 + 1
      END IF
   END IF
   IF g_ooia_m.ooia008 = 1 THEN 
      CALL cl_set_comp_entry("ooia002",TRUE)
   ELSE
      CALL cl_set_comp_entry("ooia002",FALSE)
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 下级款别数更新
# Memo...........:
# Usage..........: CALL aooi713_upd_ooia009()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi713_upd_ooia009()
   DEFINE l_cnt  LIKE type_t.num5
   
   #获取当前款别的下级款别层级数
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM ooia_t
    WHERE ooia007 = g_ooia_m.ooia001
      AND ooia001 <> g_ooia_m.ooia001
      AND ooiaent = g_enterprise

   UPDATE ooia_t SET ooia009 = l_cnt
    WHERE ooia001 = g_ooia_m.ooia001
      AND ooiaent = g_enterprise

   #获取上级款别的下级款别层级数
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM ooia_t
    WHERE ooia007 = g_ooia_m.ooia007
      AND ooia001 <> g_ooia_m.ooia007
      AND ooiaent = g_enterprise

   UPDATE ooia_t SET ooia009 = l_cnt
    WHERE ooia001 = g_ooia_m.ooia007
      AND ooiaent = g_enterprise

   #获取旧上级款别的下级款别层级数
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM ooia_t
    WHERE ooia007 = g_ooia_m_t.ooia007
      AND ooia001 <> g_ooia_m_t.ooia007
      AND ooiaent = g_enterprise

   UPDATE ooia_t SET ooia009 = l_cnt
    WHERE ooia001 = g_ooia_m_t.ooia007
      AND ooiaent = g_enterprise
END FUNCTION

################################################################################
# Descriptions...: 上级款别检查
# Memo...........:
# Usage..........: CALL aooi713_ooia007_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi713_ooia007_chk()
   DEFINE l_ooiastus   LIKE ooia_t.ooiastus
   #DEFINE l_ooia       RECORD LIKE ooia_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooia RECORD  #款別主檔
       ooiaent LIKE ooia_t.ooiaent, #企业编号
       ooia001 LIKE ooia_t.ooia001, #款别编号
       ooia002 LIKE ooia_t.ooia002, #款别性质
       ooia003 LIKE ooia_t.ooia003, #本币否
       ooia004 LIKE ooia_t.ooia004, #交易凭证类型
       ooia005 LIKE ooia_t.ooia005, #POS集成否
       ooiastus LIKE ooia_t.ooiastus, #状态码
       ooia006 LIKE ooia_t.ooia006, #默认币种
       ooia007 LIKE ooia_t.ooia007, #上级款别
       ooia008 LIKE ooia_t.ooia008, #层级
       ooia009 LIKE ooia_t.ooia009, #下级款别数
       ooia010 LIKE ooia_t.ooia010, #所属一级款别
       ooia011 LIKE ooia_t.ooia011, #即期票据否
       ooia012 LIKE ooia_t.ooia012, #第三方代收缴款否
       ooia013 LIKE ooia_t.ooia013, #代收机构
       ooia014 LIKE ooia_t.ooia014, #代收手续费费率
       ooia015 LIKE ooia_t.ooia015, #代收手续费金额
       ooia016 LIKE ooia_t.ooia016, #生成代收账款单否
       ooia017 LIKE ooia_t.ooia017, #对应款别编号
       ooia018 LIKE ooia_t.ooia018, #显示名称
       ooia019 LIKE ooia_t.ooia019, #打印名称
       ooia020 LIKE ooia_t.ooia020, #是否实收折让
       ooia021 LIKE ooia_t.ooia021, #储值付款单次使用否
       ooia022 LIKE ooia_t.ooia022, #录入号码最小长度
       ooia023 LIKE ooia_t.ooia023, #可退款
       ooia024 LIKE ooia_t.ooia024, #可找零
       ooia025 LIKE ooia_t.ooia025, #下传款别
       ooia026 LIKE ooia_t.ooia026, #可溢收
       ooia027 LIKE ooia_t.ooia027, #是否运行接口程序
       ooia028 LIKE ooia_t.ooia028, #扣款金额自动取值
       ooia029 LIKE ooia_t.ooia029, #接口小数倍数
       ooia030 LIKE ooia_t.ooia030, #允许空单交易
       ooia031 LIKE ooia_t.ooia031, #transflag标记
       ooia032 LIKE ooia_t.ooia032, #接口程序返回的打印文件
       ooia033 LIKE ooia_t.ooia033, #运行的接口程序
       ooia034 LIKE ooia_t.ooia034, #运行接口传入的文件名
       ooia035 LIKE ooia_t.ooia035, #运行接口传入档数据类型ID
       ooia036 LIKE ooia_t.ooia036, #运行接口后返回接口档
       ooia037 LIKE ooia_t.ooia037, #运行接口返回档数据类型
       ooiaownid LIKE ooia_t.ooiaownid, #资料所有者
       ooiaowndp LIKE ooia_t.ooiaowndp, #资料所有部门
       ooiacrtid LIKE ooia_t.ooiacrtid, #资料录入者
       ooiacrtdp LIKE ooia_t.ooiacrtdp, #资料录入部门
       ooiacrtdt LIKE ooia_t.ooiacrtdt, #资料创建日
       ooiamodid LIKE ooia_t.ooiamodid, #资料更改者
       ooiamoddt LIKE ooia_t.ooiamoddt, #最近更改日
       ooia038 LIKE ooia_t.ooia038, #标准手续费费率
       ooia039 LIKE ooia_t.ooia039, #券消费认列方式
       ooia040 LIKE ooia_t.ooia040, #资金入账是否当前据点
       ooia041 LIKE ooia_t.ooia041, #代收银否
       ooia042 LIKE ooia_t.ooia042, #代收银据点
       ooia043 LIKE ooia_t.ooia043, #刷卡上限金额
       ooia044 LIKE ooia_t.ooia044, #上限手续费率
       ooia045 LIKE ooia_t.ooia045 #收银缴款是否核对明细
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE l_cnt        LIKE type_t.num5
   
   LET g_errno = ''
   SELECT ooiastus INTO l_ooiastus
     FROM ooia_t
    WHERE ooiaent = g_enterprise
      AND ooia001 = g_ooia_m.ooia007
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'aoo-00364' #不存在
      WHEN l_ooiastus <> 'Y'   LET g_errno = 'aoo-00363' #無效
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN
      #获取层级   
      CALL aooi713_cal_ooia008()
      IF g_ooia_m.ooia008 > 2 THEN 
         LET g_errno = 'aoo-00365'
         LET g_ooia_m.ooia008 = ''
         RETURN 
      END IF 
      #获取上级款别对应资料
      #SELECT * INTO l_ooia.*  #161124-00048#13  2016/12/14 By 08734 mark
      SELECT ooiaent,ooia001,ooia002,ooia003,ooia004,ooia005,ooiastus,ooia006,ooia007,ooia008,ooia009,ooia010,ooia011,ooia012,ooia013,ooia014,ooia015,ooia016,
      ooia017,ooia018,ooia019,ooia020,ooia021,ooia022,ooia023,ooia024,ooia025,ooia026,ooia027,ooia028,ooia029,ooia030,ooia031,ooia032,ooia033,ooia034,ooia035,
      ooia036,ooia037,ooiaownid,ooiaowndp,ooiacrtid,ooiacrtdp,ooiacrtdt,ooiamodid,ooiamoddt,ooia038,ooia039,ooia040,ooia041,ooia042,ooia043,ooia044,ooia045 
        INTO l_ooia.*  #161124-00048#13  2016/12/14 By 08734 add
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 = g_ooia_m.ooia007
      LET g_ooia_m.ooia002 = l_ooia.ooia002
      LET g_ooia_m.ooia003 = l_ooia.ooia003
      LET g_ooia_m.ooia004 = l_ooia.ooia004
      LET g_ooia_m.ooia005 = l_ooia.ooia005
      LET g_ooia_m.ooia006 = l_ooia.ooia006
      LET g_ooia_m.ooia007 = l_ooia.ooia007
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM ooia_t
       WHERE ooia007 = g_ooia_m.ooia001
         AND ooia001 <> g_ooia_m.ooia001
         AND ooiaent = g_enterprise
      LET g_ooia_m.ooia009 = l_cnt 
      CALL aooi713_search_ooia010()
      DISPLAY BY NAME g_ooia_m.ooia002,g_ooia_m.ooia003,g_ooia_m.ooia004,g_ooia_m.ooia005,
                      g_ooia_m.ooia006,g_ooia_m.ooia007,g_ooia_m.ooia009,g_ooia_m.ooia010
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 更新款别分类
# Memo...........:
# Usage..........: CALL aooi713_upd_ooia002()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi713_upd_ooia002()
     
   UPDATE ooia_t SET ooia002 = g_ooia_m.ooia002
    WHERE ooia007 = g_ooia_m.ooia001
      AND ooia001 <> g_ooia_m.ooia001
      AND ooiaent = g_enterprise

END FUNCTION

################################################################################
# Descriptions...: 刷新TREE
# Memo...........:
# Usage..........: CALL aooi713_tree_refresh()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/09/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi713_tree_refresh()
   DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)         
       BEFORE DISPLAY
          EXIT DISPLAY
   END DISPLAY 
END FUNCTION

################################################################################
# Descriptions...: 带出对应栏位
# Memo...........:
# Usage..........: CALL aooi713_ooia007_display()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/09/10 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi713_ooia007_display()
   #DEFINE l_ooia   RECORD LIKE ooia_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooia RECORD  #款別主檔
       ooiaent LIKE ooia_t.ooiaent, #企业编号
       ooia001 LIKE ooia_t.ooia001, #款别编号
       ooia002 LIKE ooia_t.ooia002, #款别性质
       ooia003 LIKE ooia_t.ooia003, #本币否
       ooia004 LIKE ooia_t.ooia004, #交易凭证类型
       ooia005 LIKE ooia_t.ooia005, #POS集成否
       ooiastus LIKE ooia_t.ooiastus, #状态码
       ooia006 LIKE ooia_t.ooia006, #默认币种
       ooia007 LIKE ooia_t.ooia007, #上级款别
       ooia008 LIKE ooia_t.ooia008, #层级
       ooia009 LIKE ooia_t.ooia009, #下级款别数
       ooia010 LIKE ooia_t.ooia010, #所属一级款别
       ooia011 LIKE ooia_t.ooia011, #即期票据否
       ooia012 LIKE ooia_t.ooia012, #第三方代收缴款否
       ooia013 LIKE ooia_t.ooia013, #代收机构
       ooia014 LIKE ooia_t.ooia014, #代收手续费费率
       ooia015 LIKE ooia_t.ooia015, #代收手续费金额
       ooia016 LIKE ooia_t.ooia016, #生成代收账款单否
       ooia017 LIKE ooia_t.ooia017, #对应款别编号
       ooia018 LIKE ooia_t.ooia018, #显示名称
       ooia019 LIKE ooia_t.ooia019, #打印名称
       ooia020 LIKE ooia_t.ooia020, #是否实收折让
       ooia021 LIKE ooia_t.ooia021, #储值付款单次使用否
       ooia022 LIKE ooia_t.ooia022, #录入号码最小长度
       ooia023 LIKE ooia_t.ooia023, #可退款
       ooia024 LIKE ooia_t.ooia024, #可找零
       ooia025 LIKE ooia_t.ooia025, #下传款别
       ooia026 LIKE ooia_t.ooia026, #可溢收
       ooia027 LIKE ooia_t.ooia027, #是否运行接口程序
       ooia028 LIKE ooia_t.ooia028, #扣款金额自动取值
       ooia029 LIKE ooia_t.ooia029, #接口小数倍数
       ooia030 LIKE ooia_t.ooia030, #允许空单交易
       ooia031 LIKE ooia_t.ooia031, #transflag标记
       ooia032 LIKE ooia_t.ooia032, #接口程序返回的打印文件
       ooia033 LIKE ooia_t.ooia033, #运行的接口程序
       ooia034 LIKE ooia_t.ooia034, #运行接口传入的文件名
       ooia035 LIKE ooia_t.ooia035, #运行接口传入档数据类型ID
       ooia036 LIKE ooia_t.ooia036, #运行接口后返回接口档
       ooia037 LIKE ooia_t.ooia037, #运行接口返回档数据类型
       ooiaownid LIKE ooia_t.ooiaownid, #资料所有者
       ooiaowndp LIKE ooia_t.ooiaowndp, #资料所有部门
       ooiacrtid LIKE ooia_t.ooiacrtid, #资料录入者
       ooiacrtdp LIKE ooia_t.ooiacrtdp, #资料录入部门
       ooiacrtdt LIKE ooia_t.ooiacrtdt, #资料创建日
       ooiamodid LIKE ooia_t.ooiamodid, #资料更改者
       ooiamoddt LIKE ooia_t.ooiamoddt, #最近更改日
       ooia038 LIKE ooia_t.ooia038, #标准手续费费率
       ooia039 LIKE ooia_t.ooia039, #券消费认列方式
       ooia040 LIKE ooia_t.ooia040, #资金入账是否当前据点
       ooia041 LIKE ooia_t.ooia041, #代收银否
       ooia042 LIKE ooia_t.ooia042, #代收银据点
       ooia043 LIKE ooia_t.ooia043, #刷卡上限金额
       ooia044 LIKE ooia_t.ooia044, #上限手续费率
       ooia045 LIKE ooia_t.ooia045 #收银缴款是否核对明细
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   
   #SELECT * INTO l_ooia.*  #161124-00048#13  2016/12/14 By 08734 mark
   SELECT ooiaent,ooia001,ooia002,ooia003,ooia004,ooia005,ooiastus,ooia006,ooia007,ooia008,ooia009,ooia010,ooia011,ooia012,ooia013,ooia014,ooia015,ooia016,
   ooia017,ooia018,ooia019,ooia020,ooia021,ooia022,ooia023,ooia024,ooia025,ooia026,ooia027,ooia028,ooia029,ooia030,ooia031,ooia032,ooia033,ooia034,ooia035,
   ooia036,ooia037,ooiaownid,ooiaowndp,ooiacrtid,ooiacrtdp,ooiacrtdt,ooiamodid,ooiamoddt,ooia038,ooia039,ooia040,ooia041,ooia042,ooia043,ooia044,ooia045 
     INTO l_ooia.*  #161124-00048#13  2016/12/14 By 08734 add  
     FROM ooia_t
    WHERE ooiaent = g_enterprise
      AND ooia001 = g_ooia_m.ooia007
   
   LET g_ooia_m.ooia012 = l_ooia.ooia012
   LET g_ooia_m.ooia013 = l_ooia.ooia013
   LET g_ooia_m.ooia014 = l_ooia.ooia014
   LET g_ooia_m.ooia015 = l_ooia.ooia015
   LET g_ooia_m.ooia016 = l_ooia.ooia016
   LET g_ooia_m.ooia017 = l_ooia.ooia017
   LET g_ooia_m.ooia018 = l_ooia.ooia018
   LET g_ooia_m.ooia019 = l_ooia.ooia019
   LET g_ooia_m.ooia020 = l_ooia.ooia020
   LET g_ooia_m.ooia021 = l_ooia.ooia021
   LET g_ooia_m.ooia022 = l_ooia.ooia022
   LET g_ooia_m.ooia023 = l_ooia.ooia023
   LET g_ooia_m.ooia024 = l_ooia.ooia024
   LET g_ooia_m.ooia025 = l_ooia.ooia025
   LET g_ooia_m.ooia026 = l_ooia.ooia026
   LET g_ooia_m.ooia027 = l_ooia.ooia027
   LET g_ooia_m.ooia028 = l_ooia.ooia028
   LET g_ooia_m.ooia029 = l_ooia.ooia029
   LET g_ooia_m.ooia030 = l_ooia.ooia030
   LET g_ooia_m.ooia031 = l_ooia.ooia031
   LET g_ooia_m.ooia032 = l_ooia.ooia032
   LET g_ooia_m.ooia033 = l_ooia.ooia033
   LET g_ooia_m.ooia034 = l_ooia.ooia034
   LET g_ooia_m.ooia035 = l_ooia.ooia035
   LET g_ooia_m.ooia036 = l_ooia.ooia036
   LET g_ooia_m.ooia037 = l_ooia.ooia037
   DISPLAY BY NAME g_ooia_m.ooia012,g_ooia_m.ooia013,g_ooia_m.ooia014,g_ooia_m.ooia015, 
       g_ooia_m.ooia016,g_ooia_m.ooia017,g_ooia_m.ooia018,g_ooia_m.ooia019,g_ooia_m.ooia020,g_ooia_m.ooia021, 
       g_ooia_m.ooia022,g_ooia_m.ooia023,g_ooia_m.ooia024,g_ooia_m.ooia025,g_ooia_m.ooia026,g_ooia_m.ooia027, 
       g_ooia_m.ooia028,g_ooia_m.ooia029,g_ooia_m.ooia030,g_ooia_m.ooia031,g_ooia_m.ooia032,g_ooia_m.ooia033, 
       g_ooia_m.ooia034,g_ooia_m.ooia035,g_ooia_m.ooia036,g_ooia_m.ooia037
END FUNCTION

 
{</section>}
 
