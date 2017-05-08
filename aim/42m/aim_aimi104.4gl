#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi104.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-10-24 16:56:38), PR版次:0017(2016-10-27 17:12:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000361
#+ Filename...: aimi104
#+ Description: 集團預設料件採購分群資料維護作業
#+ Creator....: 02295(2013-07-26 16:02:27)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aimi104.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#20  2016/03/30 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160505-00002#3   2016/07/11 By lixiang  数量栏位非必输，改由手动撰写代码判断值域范围
#160705-00042#11  2016/07/14 By sakura   程式中寫死g_prog部分改寫MATCHES方式
#160523-00031#4   2016/08/02 By zhujing  將主畫面上的所有欄位放到瀏覽畫面上
#160905-00015#1   2016/09/09 By 06948    供應商開窗不應帶出類別為客戶的資料，將開窗改為 q_pmaa001_3()
#160913-00055#2   2016/09/18 By lixiang  供应商栏位检核时，需要限定输入的资料为供应商或校验对象
#161013-00017#4   2016/10/24 By zhujing  可以直接在aimi104增加新的分群代號，不用先在aimi004增加
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
PRIVATE TYPE type_g_imce_m RECORD
       imce141 LIKE imce_t.imce141, 
   oocql004 LIKE oocql_t.oocql004, 
   oocql005 LIKE oocql_t.oocql005, 
   imce142 LIKE imce_t.imce142, 
   imce142_desc LIKE type_t.chr80, 
   imce143 LIKE imce_t.imce143, 
   imce143_desc LIKE type_t.chr80, 
   imce144 LIKE imce_t.imce144, 
   imce144_desc LIKE type_t.chr80, 
   imce145 LIKE imce_t.imce145, 
   imce146 LIKE imce_t.imce146, 
   imce147 LIKE imce_t.imce147, 
   imce148 LIKE imce_t.imce148, 
   imce149 LIKE imce_t.imce149, 
   imcestus LIKE imce_t.imcestus, 
   imceownid LIKE imce_t.imceownid, 
   imceownid_desc LIKE type_t.chr80, 
   imceowndp LIKE imce_t.imceowndp, 
   imceowndp_desc LIKE type_t.chr80, 
   imcecrtid LIKE imce_t.imcecrtid, 
   imcecrtid_desc LIKE type_t.chr80, 
   imcecrtdp LIKE imce_t.imcecrtdp, 
   imcecrtdp_desc LIKE type_t.chr80, 
   imcecrtdt LIKE imce_t.imcecrtdt, 
   imcemodid LIKE imce_t.imcemodid, 
   imcemodid_desc LIKE type_t.chr80, 
   imcemoddt LIKE imce_t.imcemoddt, 
   imce151 LIKE imce_t.imce151, 
   imce158 LIKE imce_t.imce158, 
   imce157 LIKE imce_t.imce157, 
   imce157_desc LIKE type_t.chr80, 
   imce152 LIKE imce_t.imce152, 
   imce153 LIKE imce_t.imce153, 
   imce153_desc LIKE type_t.chr80, 
   imce154 LIKE imce_t.imce154, 
   imce155 LIKE imce_t.imce155, 
   imce156 LIKE imce_t.imce156, 
   imce161 LIKE imce_t.imce161, 
   imce162 LIKE imce_t.imce162, 
   imce163 LIKE imce_t.imce163, 
   imce164 LIKE imce_t.imce164, 
   imce165 LIKE imce_t.imce165, 
   imce166 LIKE imce_t.imce166, 
   imce171 LIKE imce_t.imce171, 
   imce172 LIKE imce_t.imce172, 
   imce173 LIKE imce_t.imce173, 
   imce174 LIKE imce_t.imce174, 
   imce175 LIKE imce_t.imce175, 
   imce176 LIKE imce_t.imce176, 
   imce176_desc LIKE type_t.chr80
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_imce141 LIKE imce_t.imce141,
   b_imce141_desc LIKE type_t.chr80,
      b_imce142 LIKE imce_t.imce142,
   b_imce142_desc LIKE type_t.chr80,
      b_imce143 LIKE imce_t.imce143,
   b_imce143_desc LIKE type_t.chr80,
      b_imce144 LIKE imce_t.imce144,
   b_imce144_desc LIKE type_t.chr80,
      b_imce145 LIKE imce_t.imce145,
      b_imce146 LIKE imce_t.imce146,
      b_imce147 LIKE imce_t.imce147,
      b_imce148 LIKE imce_t.imce148,
      b_imce149 LIKE imce_t.imce149,
      b_imce151 LIKE imce_t.imce151,
      b_imce158 LIKE imce_t.imce158,
      b_imce157 LIKE imce_t.imce157,
   b_imce157_desc LIKE type_t.chr80,
      b_imce152 LIKE imce_t.imce152,
      b_imce153 LIKE imce_t.imce153,
   b_imce153_desc LIKE type_t.chr80,
      b_imce154 LIKE imce_t.imce154,
      b_imce155 LIKE imce_t.imce155,
      b_imce156 LIKE imce_t.imce156,
      b_imce161 LIKE imce_t.imce161,
      b_imce162 LIKE imce_t.imce162,
      b_imce163 LIKE imce_t.imce163,
      b_imce164 LIKE imce_t.imce164,
      b_imce165 LIKE imce_t.imce165,
      b_imce166 LIKE imce_t.imce166,
      b_imce171 LIKE imce_t.imce171,
      b_imce172 LIKE imce_t.imce172,
      b_imce173 LIKE imce_t.imce173,
      b_imce174 LIKE imce_t.imce174,
      b_imce175 LIKE imce_t.imce175,
      b_imce176 LIKE imce_t.imce176,
   b_imce176_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_imce_m        type_g_imce_m  #單頭變數宣告
DEFINE g_imce_m_t      type_g_imce_m  #單頭舊值宣告(系統還原用)
DEFINE g_imce_m_o      type_g_imce_m  #單頭舊值宣告(其他用途)
DEFINE g_imce_m_mask_o type_g_imce_m  #轉換遮罩前資料
DEFINE g_imce_m_mask_n type_g_imce_m  #轉換遮罩後資料
 
   DEFINE g_imce141_t LIKE imce_t.imce141
 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      oocql001 LIKE oocql_t.oocql001,
      oocql002 LIKE oocql_t.oocql002,
      oocql004 LIKE oocql_t.oocql004,
      oocql005 LIKE oocql_t.oocql005
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
 
{<section id="aimi104.main" >}
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
   IF g_argv[1] IS NOT NULL THEN 
      LET g_site = g_argv[1]
   END IF 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imce141,'','',imce142,'',imce143,'',imce144,'',imce145,imce146,imce147, 
       imce148,imce149,imcestus,imceownid,'',imceowndp,'',imcecrtid,'',imcecrtdp,'',imcecrtdt,imcemodid, 
       '',imcemoddt,imce151,imce158,imce157,'',imce152,imce153,'',imce154,imce155,imce156,imce161,imce162, 
       imce163,imce164,imce165,imce166,imce171,imce172,imce173,imce174,imce175,imce176,''", 
                      " FROM imce_t",
                      " WHERE imceent= ? AND imcesite= ? AND imce141=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi104_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imce141,t0.imce142,t0.imce143,t0.imce144,t0.imce145,t0.imce146,t0.imce147, 
       t0.imce148,t0.imce149,t0.imcestus,t0.imceownid,t0.imceowndp,t0.imcecrtid,t0.imcecrtdp,t0.imcecrtdt, 
       t0.imcemodid,t0.imcemoddt,t0.imce151,t0.imce158,t0.imce157,t0.imce152,t0.imce153,t0.imce154,t0.imce155, 
       t0.imce156,t0.imce161,t0.imce162,t0.imce163,t0.imce164,t0.imce165,t0.imce166,t0.imce171,t0.imce172, 
       t0.imce173,t0.imce174,t0.imce175,t0.imce176,t1.ooag011 ,t2.oocal003 ,t3.oocal003 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.imaal003 ,t10.pmaal004 ,t11.oocql004",
               " FROM imce_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.imce142  ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.imce143 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imce144 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.imceownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.imceowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.imcecrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.imcecrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.imcemodid  ",
               " LEFT JOIN imaal_t t9 ON t9.imaalent="||g_enterprise||" AND t9.imaal001=t0.imce157 AND t9.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t10 ON t10.pmaalent="||g_enterprise||" AND t10.pmaal001=t0.imce153 AND t10.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='274' AND t11.oocql002=t0.imce176 AND t11.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.imceent = " ||g_enterprise|| " AND t0.imcesite = ? AND t0.imce141 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimi104_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimi104 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimi104_init()   
 
      #進入選單 Menu (="N")
      CALL aimi104_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimi104
      
   END IF 
   
   CLOSE aimi104_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimi104.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimi104_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('imcestus','17','N,Y')
 
      CALL cl_set_combo_scc('imce147','2025') 
   CALL cl_set_combo_scc('imce151','2031') 
   CALL cl_set_combo_scc('imce158','2027') 
   CALL cl_set_combo_scc('imce152','2028') 
   CALL cl_set_combo_scc('imce156','2024') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   #160523-00031#4 add-S
   CALL cl_set_combo_scc_part('b_imcestus','17','N,Y')
   CALL cl_set_combo_scc('b_imce147','2025') 
   CALL cl_set_combo_scc('b_imce151','2031') 
   CALL cl_set_combo_scc('b_imce158','2027') 
   CALL cl_set_combo_scc('b_imce152','2028') 
   CALL cl_set_combo_scc('b_imce156','2024') 
   #160523-00031#4 add-E
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimi104_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimi104.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimi104_ui_dialog() 
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
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aimi104_insert()
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
         INITIALIZE g_imce_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimi104_init()
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
               CALL aimi104_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimi104_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimi104' THEN        #160705-00042#11 160714 by sakura mark    
               IF g_prog MATCHES 'aimi104' THEN   #160705-00042#11 160714 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi104_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi104_set_act_visible()
               CALL aimi104_set_act_no_visible()
               IF NOT (g_imce_m.imce141 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imceent = " ||g_enterprise|| " AND imcesite = '" ||g_site|| "' AND",
                                     " imce141 = '", g_imce_m.imce141, "' "
 
                  #填到對應位置
                  CALL aimi104_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aimi104_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi104_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimi104_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimi104_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimi104_fetch("L")  
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
                  CALL aimi104_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi104_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi104_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION cost_cluster
            LET g_action_choice="cost_cluster"
            IF cl_auth_chk_act("cost_cluster") THEN
               
               #add-point:ON ACTION cost_cluster name="menu2.cost_cluster"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi104_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimi102
            LET g_action_choice="aimi102"
            IF cl_auth_chk_act("aimi102") THEN
               
               #add-point:ON ACTION aimi102 name="menu2.aimi102"
               IF g_site = 'ALL' THEN 
                  CALL cl_cmdrun('aimi102')
               ELSE
                  CALL cl_cmdrun('aimi112')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi104_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi104_insert()
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
               CALL aimi104_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi104_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION wms_cluster
            LET g_action_choice="wms_cluster"
            IF cl_auth_chk_act("wms_cluster") THEN
               
               #add-point:ON ACTION wms_cluster name="menu2.wms_cluster"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimi106
            LET g_action_choice="aimi106"
            IF cl_auth_chk_act("aimi106") THEN
               
               #add-point:ON ACTION aimi106 name="menu2.aimi106"
               IF g_site = 'ALL' THEN 
                  CALL cl_cmdrun('aimi106')
               ELSE
                  CALL cl_cmdrun('aimi116')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimi101
            LET g_action_choice="aimi101"
            IF cl_auth_chk_act("aimi101") THEN
               
               #add-point:ON ACTION aimi101 name="menu2.aimi101"
               IF g_site = 'ALL' THEN 
                  CALL cl_cmdrun('aimi101')
               ELSE
                  CALL cl_cmdrun('aimi111')
               END IF
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi104_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi104_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi104_set_pk_array()
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
                  CALL aimi104_fetch("")
 
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
                  CALL aimi104_browser_fill(g_wc,"")
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
                  CALL aimi104_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimi104' THEN        #160705-00042#11 160714 by sakura mark
               IF g_prog MATCHES 'aimi104' THEN   #160705-00042#11 160714 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi104_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi104_set_act_visible()
               CALL aimi104_set_act_no_visible()
               IF NOT (g_imce_m.imce141 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imceent = " ||g_enterprise|| " AND imcesite = '" ||g_site|| "' AND",
                                     " imce141 = '", g_imce_m.imce141, "' "
 
                  #填到對應位置
                  CALL aimi104_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aimi104_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimi104_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi104_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimi104_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimi104_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimi104_fetch("L")  
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
                  CALL aimi104_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi104_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi104_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION cost_cluster
            LET g_action_choice="cost_cluster"
            IF cl_auth_chk_act("cost_cluster") THEN
               
               #add-point:ON ACTION cost_cluster name="menu.cost_cluster"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi104_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimi102
            LET g_action_choice="aimi102"
            IF cl_auth_chk_act("aimi102") THEN
               
               #add-point:ON ACTION aimi102 name="menu.aimi102"
               IF g_site = 'ALL' THEN 
                  CALL cl_cmdrun('aimi102')
               ELSE
                  CALL cl_cmdrun('aimi112')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi104_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi104_insert()
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
               CALL aimi104_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi104_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION wms_cluster
            LET g_action_choice="wms_cluster"
            IF cl_auth_chk_act("wms_cluster") THEN
               
               #add-point:ON ACTION wms_cluster name="menu.wms_cluster"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimi106
            LET g_action_choice="aimi106"
            IF cl_auth_chk_act("aimi106") THEN
               
               #add-point:ON ACTION aimi106 name="menu.aimi106"
               IF g_site = 'ALL' THEN 
                  CALL cl_cmdrun('aimi106')
               ELSE
                  CALL cl_cmdrun('aimi116')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimi101
            LET g_action_choice="aimi101"
            IF cl_auth_chk_act("aimi101") THEN
               
               #add-point:ON ACTION aimi101 name="menu.aimi101"
               IF g_site = 'ALL' THEN 
                  CALL cl_cmdrun('aimi101')
               ELSE
                  CALL cl_cmdrun('aimi111')
               END IF
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi104_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi104_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi104_set_pk_array()
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
 
{<section id="aimi104.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimi104_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "imce141"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imce_t ",
               "  ",
               "  LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND '203' = oocql001 AND imce141 = oocql002 AND oocql003 = '",g_dlang,"' ",
               " WHERE imceent = " ||g_enterprise|| " AND imcesite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imce_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   
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
      INITIALIZE g_imce_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imcestus,t0.imce141,t0.imce142,t0.imce143,t0.imce144,t0.imce145,t0.imce146, 
       t0.imce147,t0.imce148,t0.imce149,t0.imce151,t0.imce158,t0.imce157,t0.imce152,t0.imce153,t0.imce154, 
       t0.imce155,t0.imce156,t0.imce161,t0.imce162,t0.imce163,t0.imce164,t0.imce165,t0.imce166,t0.imce171, 
       t0.imce172,t0.imce173,t0.imce174,t0.imce175,t0.imce176,t1.oocql004 ,t2.ooag011 ,t3.oocal003 , 
       t4.oocal003 ,t5.imaal003 ,t6.pmaal004 ,t7.oocql004",
               " FROM imce_t t0 ",
               "  ",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='203' AND t1.oocql002=t0.imce141 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imce142  ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imce143 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.imce144 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=t0.imce157 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.imce153 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='274' AND t7.oocql002=t0.imce176 AND t7.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.imceent = " ||g_enterprise|| " AND t0.imcesite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imce_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imce_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imce141,g_browser[g_cnt].b_imce142, 
          g_browser[g_cnt].b_imce143,g_browser[g_cnt].b_imce144,g_browser[g_cnt].b_imce145,g_browser[g_cnt].b_imce146, 
          g_browser[g_cnt].b_imce147,g_browser[g_cnt].b_imce148,g_browser[g_cnt].b_imce149,g_browser[g_cnt].b_imce151, 
          g_browser[g_cnt].b_imce158,g_browser[g_cnt].b_imce157,g_browser[g_cnt].b_imce152,g_browser[g_cnt].b_imce153, 
          g_browser[g_cnt].b_imce154,g_browser[g_cnt].b_imce155,g_browser[g_cnt].b_imce156,g_browser[g_cnt].b_imce161, 
          g_browser[g_cnt].b_imce162,g_browser[g_cnt].b_imce163,g_browser[g_cnt].b_imce164,g_browser[g_cnt].b_imce165, 
          g_browser[g_cnt].b_imce166,g_browser[g_cnt].b_imce171,g_browser[g_cnt].b_imce172,g_browser[g_cnt].b_imce173, 
          g_browser[g_cnt].b_imce174,g_browser[g_cnt].b_imce175,g_browser[g_cnt].b_imce176,g_browser[g_cnt].b_imce141_desc, 
          g_browser[g_cnt].b_imce142_desc,g_browser[g_cnt].b_imce143_desc,g_browser[g_cnt].b_imce144_desc, 
          g_browser[g_cnt].b_imce157_desc,g_browser[g_cnt].b_imce153_desc,g_browser[g_cnt].b_imce176_desc 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
         
         #遮罩相關處理
         CALL aimi104_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
 
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
   
   IF cl_null(g_browser[g_cnt].b_imce141) THEN
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
 
{<section id="aimi104.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi104_construct()
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
   INITIALIZE g_imce_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imce141,oocql004,oocql005,imce142,imce143,imce144,imce145,imce146,imce147, 
          imce148,imce149,imcestus,imceownid,imceowndp,imcecrtid,imcecrtdp,imcecrtdt,imcemodid,imcemoddt, 
          imce151,imce158,imce157,imce152,imce153,imce154,imce155,imce156,imce161,imce162,imce163,imce164, 
          imce165,imce166,imce171,imce172,imce173,imce174,imce175,imce176
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imcecrtdt>>----
         AFTER FIELD imcecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imcemoddt>>----
         AFTER FIELD imcemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imcecnfdt>>----
         
         #----<<imcepstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.imce141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce141
            #add-point:ON ACTION controlp INFIELD imce141 name="construct.c.imce141"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '203'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imce141  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oocq002 #應用分類碼 

            NEXT FIELD imce141                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce141
            #add-point:BEFORE FIELD imce141 name="construct.b.imce141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce141
            
            #add-point:AFTER FIELD imce141 name="construct.a.imce141"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="construct.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="construct.a.oocql004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="construct.c.oocql004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="construct.b.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="construct.a.oocql005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="construct.c.oocql005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imce142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce142
            #add-point:ON ACTION controlp INFIELD imce142 name="construct.c.imce142"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imce142  #顯示到畫面上

            NEXT FIELD imce142                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce142
            #add-point:BEFORE FIELD imce142 name="construct.b.imce142"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce142
            
            #add-point:AFTER FIELD imce142 name="construct.a.imce142"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce143
            #add-point:ON ACTION controlp INFIELD imce143 name="construct.c.imce143"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imce143  #顯示到畫面上

            NEXT FIELD imce143                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce143
            #add-point:BEFORE FIELD imce143 name="construct.b.imce143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce143
            
            #add-point:AFTER FIELD imce143 name="construct.a.imce143"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce144
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce144
            #add-point:ON ACTION controlp INFIELD imce144 name="construct.c.imce144"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imce144  #顯示到畫面上

            NEXT FIELD imce144                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce144
            #add-point:BEFORE FIELD imce144 name="construct.b.imce144"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce144
            
            #add-point:AFTER FIELD imce144 name="construct.a.imce144"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce145
            #add-point:BEFORE FIELD imce145 name="construct.b.imce145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce145
            
            #add-point:AFTER FIELD imce145 name="construct.a.imce145"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce145
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce145
            #add-point:ON ACTION controlp INFIELD imce145 name="construct.c.imce145"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce146
            #add-point:BEFORE FIELD imce146 name="construct.b.imce146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce146
            
            #add-point:AFTER FIELD imce146 name="construct.a.imce146"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce146
            #add-point:ON ACTION controlp INFIELD imce146 name="construct.c.imce146"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce147
            #add-point:BEFORE FIELD imce147 name="construct.b.imce147"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce147
            
            #add-point:AFTER FIELD imce147 name="construct.a.imce147"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce147
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce147
            #add-point:ON ACTION controlp INFIELD imce147 name="construct.c.imce147"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce148
            #add-point:BEFORE FIELD imce148 name="construct.b.imce148"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce148
            
            #add-point:AFTER FIELD imce148 name="construct.a.imce148"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce148
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce148
            #add-point:ON ACTION controlp INFIELD imce148 name="construct.c.imce148"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce149
            #add-point:BEFORE FIELD imce149 name="construct.b.imce149"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce149
            
            #add-point:AFTER FIELD imce149 name="construct.a.imce149"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce149
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce149
            #add-point:ON ACTION controlp INFIELD imce149 name="construct.c.imce149"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcestus
            #add-point:BEFORE FIELD imcestus name="construct.b.imcestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcestus
            
            #add-point:AFTER FIELD imcestus name="construct.a.imcestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcestus
            #add-point:ON ACTION controlp INFIELD imcestus name="construct.c.imcestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imceownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imceownid
            #add-point:ON ACTION controlp INFIELD imceownid name="construct.c.imceownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imceownid  #顯示到畫面上

            NEXT FIELD imceownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imceownid
            #add-point:BEFORE FIELD imceownid name="construct.b.imceownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imceownid
            
            #add-point:AFTER FIELD imceownid name="construct.a.imceownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imceowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imceowndp
            #add-point:ON ACTION controlp INFIELD imceowndp name="construct.c.imceowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imceowndp  #顯示到畫面上

            NEXT FIELD imceowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imceowndp
            #add-point:BEFORE FIELD imceowndp name="construct.b.imceowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imceowndp
            
            #add-point:AFTER FIELD imceowndp name="construct.a.imceowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcecrtid
            #add-point:ON ACTION controlp INFIELD imcecrtid name="construct.c.imcecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcecrtid  #顯示到畫面上

            NEXT FIELD imcecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcecrtid
            #add-point:BEFORE FIELD imcecrtid name="construct.b.imcecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcecrtid
            
            #add-point:AFTER FIELD imcecrtid name="construct.a.imcecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcecrtdp
            #add-point:ON ACTION controlp INFIELD imcecrtdp name="construct.c.imcecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcecrtdp  #顯示到畫面上

            NEXT FIELD imcecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcecrtdp
            #add-point:BEFORE FIELD imcecrtdp name="construct.b.imcecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcecrtdp
            
            #add-point:AFTER FIELD imcecrtdp name="construct.a.imcecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcecrtdt
            #add-point:BEFORE FIELD imcecrtdt name="construct.b.imcecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcemodid
            #add-point:ON ACTION controlp INFIELD imcemodid name="construct.c.imcemodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcemodid  #顯示到畫面上

            NEXT FIELD imcemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcemodid
            #add-point:BEFORE FIELD imcemodid name="construct.b.imcemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcemodid
            
            #add-point:AFTER FIELD imcemodid name="construct.a.imcemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcemoddt
            #add-point:BEFORE FIELD imcemoddt name="construct.b.imcemoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce151
            #add-point:BEFORE FIELD imce151 name="construct.b.imce151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce151
            
            #add-point:AFTER FIELD imce151 name="construct.a.imce151"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce151
            #add-point:ON ACTION controlp INFIELD imce151 name="construct.c.imce151"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce158
            #add-point:BEFORE FIELD imce158 name="construct.b.imce158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce158
            
            #add-point:AFTER FIELD imce158 name="construct.a.imce158"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce158
            #add-point:ON ACTION controlp INFIELD imce158 name="construct.c.imce158"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imce157
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce157
            #add-point:ON ACTION controlp INFIELD imce157 name="construct.c.imce157"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imce157  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO imaal003 #品名 

            NEXT FIELD imce157                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce157
            #add-point:BEFORE FIELD imce157 name="construct.b.imce157"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce157
            
            #add-point:AFTER FIELD imce157 name="construct.a.imce157"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce152
            #add-point:BEFORE FIELD imce152 name="construct.b.imce152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce152
            
            #add-point:AFTER FIELD imce152 name="construct.a.imce152"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce152
            #add-point:ON ACTION controlp INFIELD imce152 name="construct.c.imce152"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imce153
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce153
            #add-point:ON ACTION controlp INFIELD imce153 name="construct.c.imce153"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()     #160905-00015 mark
            CALL q_pmaa001_3()    #160905-00015 add
            DISPLAY g_qryparam.return1 TO imce153  #顯示到畫面上

            NEXT FIELD imce153                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce153
            #add-point:BEFORE FIELD imce153 name="construct.b.imce153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce153
            
            #add-point:AFTER FIELD imce153 name="construct.a.imce153"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce154
            #add-point:BEFORE FIELD imce154 name="construct.b.imce154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce154
            
            #add-point:AFTER FIELD imce154 name="construct.a.imce154"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce154
            #add-point:ON ACTION controlp INFIELD imce154 name="construct.c.imce154"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce155
            #add-point:BEFORE FIELD imce155 name="construct.b.imce155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce155
            
            #add-point:AFTER FIELD imce155 name="construct.a.imce155"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce155
            #add-point:ON ACTION controlp INFIELD imce155 name="construct.c.imce155"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce156
            #add-point:BEFORE FIELD imce156 name="construct.b.imce156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce156
            
            #add-point:AFTER FIELD imce156 name="construct.a.imce156"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce156
            #add-point:ON ACTION controlp INFIELD imce156 name="construct.c.imce156"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce161
            #add-point:BEFORE FIELD imce161 name="construct.b.imce161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce161
            
            #add-point:AFTER FIELD imce161 name="construct.a.imce161"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce161
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce161
            #add-point:ON ACTION controlp INFIELD imce161 name="construct.c.imce161"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce162
            #add-point:BEFORE FIELD imce162 name="construct.b.imce162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce162
            
            #add-point:AFTER FIELD imce162 name="construct.a.imce162"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce162
            #add-point:ON ACTION controlp INFIELD imce162 name="construct.c.imce162"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce163
            #add-point:BEFORE FIELD imce163 name="construct.b.imce163"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce163
            
            #add-point:AFTER FIELD imce163 name="construct.a.imce163"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce163
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce163
            #add-point:ON ACTION controlp INFIELD imce163 name="construct.c.imce163"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce164
            #add-point:BEFORE FIELD imce164 name="construct.b.imce164"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce164
            
            #add-point:AFTER FIELD imce164 name="construct.a.imce164"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce164
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce164
            #add-point:ON ACTION controlp INFIELD imce164 name="construct.c.imce164"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce165
            #add-point:BEFORE FIELD imce165 name="construct.b.imce165"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce165
            
            #add-point:AFTER FIELD imce165 name="construct.a.imce165"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce165
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce165
            #add-point:ON ACTION controlp INFIELD imce165 name="construct.c.imce165"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce166
            #add-point:BEFORE FIELD imce166 name="construct.b.imce166"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce166
            
            #add-point:AFTER FIELD imce166 name="construct.a.imce166"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce166
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce166
            #add-point:ON ACTION controlp INFIELD imce166 name="construct.c.imce166"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce171
            #add-point:BEFORE FIELD imce171 name="construct.b.imce171"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce171
            
            #add-point:AFTER FIELD imce171 name="construct.a.imce171"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce171
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce171
            #add-point:ON ACTION controlp INFIELD imce171 name="construct.c.imce171"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce172
            #add-point:BEFORE FIELD imce172 name="construct.b.imce172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce172
            
            #add-point:AFTER FIELD imce172 name="construct.a.imce172"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce172
            #add-point:ON ACTION controlp INFIELD imce172 name="construct.c.imce172"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce173
            #add-point:BEFORE FIELD imce173 name="construct.b.imce173"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce173
            
            #add-point:AFTER FIELD imce173 name="construct.a.imce173"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce173
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce173
            #add-point:ON ACTION controlp INFIELD imce173 name="construct.c.imce173"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce174
            #add-point:BEFORE FIELD imce174 name="construct.b.imce174"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce174
            
            #add-point:AFTER FIELD imce174 name="construct.a.imce174"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce174
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce174
            #add-point:ON ACTION controlp INFIELD imce174 name="construct.c.imce174"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce175
            #add-point:BEFORE FIELD imce175 name="construct.b.imce175"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce175
            
            #add-point:AFTER FIELD imce175 name="construct.a.imce175"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imce175
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce175
            #add-point:ON ACTION controlp INFIELD imce175 name="construct.c.imce175"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imce176
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce176
            #add-point:ON ACTION controlp INFIELD imce176 name="construct.c.imce176"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '274'
            CALL q_oocq002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imce176  #顯示到畫面上

            NEXT FIELD imce176                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce176
            #add-point:BEFORE FIELD imce176 name="construct.b.imce176"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce176
            
            #add-point:AFTER FIELD imce176 name="construct.a.imce176"
            
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
 
{<section id="aimi104.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimi104_filter()
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
      CONSTRUCT g_wc_filter ON imce141,imce142,imce143,imce144,imce145,imce146,imce147,imce148,imce149, 
          imce151,imce158,imce157,imce152,imce153,imce154,imce155,imce156,imce161,imce162,imce163,imce164, 
          imce165,imce166,imce171,imce172,imce173,imce174,imce175,imce176
                          FROM s_browse[1].b_imce141,s_browse[1].b_imce142,s_browse[1].b_imce143,s_browse[1].b_imce144, 
                              s_browse[1].b_imce145,s_browse[1].b_imce146,s_browse[1].b_imce147,s_browse[1].b_imce148, 
                              s_browse[1].b_imce149,s_browse[1].b_imce151,s_browse[1].b_imce158,s_browse[1].b_imce157, 
                              s_browse[1].b_imce152,s_browse[1].b_imce153,s_browse[1].b_imce154,s_browse[1].b_imce155, 
                              s_browse[1].b_imce156,s_browse[1].b_imce161,s_browse[1].b_imce162,s_browse[1].b_imce163, 
                              s_browse[1].b_imce164,s_browse[1].b_imce165,s_browse[1].b_imce166,s_browse[1].b_imce171, 
                              s_browse[1].b_imce172,s_browse[1].b_imce173,s_browse[1].b_imce174,s_browse[1].b_imce175, 
                              s_browse[1].b_imce176
 
         BEFORE CONSTRUCT
               DISPLAY aimi104_filter_parser('imce141') TO s_browse[1].b_imce141
            DISPLAY aimi104_filter_parser('imce142') TO s_browse[1].b_imce142
            DISPLAY aimi104_filter_parser('imce143') TO s_browse[1].b_imce143
            DISPLAY aimi104_filter_parser('imce144') TO s_browse[1].b_imce144
            DISPLAY aimi104_filter_parser('imce145') TO s_browse[1].b_imce145
            DISPLAY aimi104_filter_parser('imce146') TO s_browse[1].b_imce146
            DISPLAY aimi104_filter_parser('imce147') TO s_browse[1].b_imce147
            DISPLAY aimi104_filter_parser('imce148') TO s_browse[1].b_imce148
            DISPLAY aimi104_filter_parser('imce149') TO s_browse[1].b_imce149
            DISPLAY aimi104_filter_parser('imce151') TO s_browse[1].b_imce151
            DISPLAY aimi104_filter_parser('imce158') TO s_browse[1].b_imce158
            DISPLAY aimi104_filter_parser('imce157') TO s_browse[1].b_imce157
            DISPLAY aimi104_filter_parser('imce152') TO s_browse[1].b_imce152
            DISPLAY aimi104_filter_parser('imce153') TO s_browse[1].b_imce153
            DISPLAY aimi104_filter_parser('imce154') TO s_browse[1].b_imce154
            DISPLAY aimi104_filter_parser('imce155') TO s_browse[1].b_imce155
            DISPLAY aimi104_filter_parser('imce156') TO s_browse[1].b_imce156
            DISPLAY aimi104_filter_parser('imce161') TO s_browse[1].b_imce161
            DISPLAY aimi104_filter_parser('imce162') TO s_browse[1].b_imce162
            DISPLAY aimi104_filter_parser('imce163') TO s_browse[1].b_imce163
            DISPLAY aimi104_filter_parser('imce164') TO s_browse[1].b_imce164
            DISPLAY aimi104_filter_parser('imce165') TO s_browse[1].b_imce165
            DISPLAY aimi104_filter_parser('imce166') TO s_browse[1].b_imce166
            DISPLAY aimi104_filter_parser('imce171') TO s_browse[1].b_imce171
            DISPLAY aimi104_filter_parser('imce172') TO s_browse[1].b_imce172
            DISPLAY aimi104_filter_parser('imce173') TO s_browse[1].b_imce173
            DISPLAY aimi104_filter_parser('imce174') TO s_browse[1].b_imce174
            DISPLAY aimi104_filter_parser('imce175') TO s_browse[1].b_imce175
            DISPLAY aimi104_filter_parser('imce176') TO s_browse[1].b_imce176
      
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
 
      CALL aimi104_filter_show('imce141')
   CALL aimi104_filter_show('imce142')
   CALL aimi104_filter_show('imce143')
   CALL aimi104_filter_show('imce144')
   CALL aimi104_filter_show('imce145')
   CALL aimi104_filter_show('imce146')
   CALL aimi104_filter_show('imce147')
   CALL aimi104_filter_show('imce148')
   CALL aimi104_filter_show('imce149')
   CALL aimi104_filter_show('imce151')
   CALL aimi104_filter_show('imce158')
   CALL aimi104_filter_show('imce157')
   CALL aimi104_filter_show('imce152')
   CALL aimi104_filter_show('imce153')
   CALL aimi104_filter_show('imce154')
   CALL aimi104_filter_show('imce155')
   CALL aimi104_filter_show('imce156')
   CALL aimi104_filter_show('imce161')
   CALL aimi104_filter_show('imce162')
   CALL aimi104_filter_show('imce163')
   CALL aimi104_filter_show('imce164')
   CALL aimi104_filter_show('imce165')
   CALL aimi104_filter_show('imce166')
   CALL aimi104_filter_show('imce171')
   CALL aimi104_filter_show('imce172')
   CALL aimi104_filter_show('imce173')
   CALL aimi104_filter_show('imce174')
   CALL aimi104_filter_show('imce175')
   CALL aimi104_filter_show('imce176')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi104.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimi104_filter_parser(ps_field)
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
 
{<section id="aimi104.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimi104_filter_show(ps_field)
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
   LET ls_condition = aimi104_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimi104.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimi104_query()
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
 
   INITIALIZE g_imce_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimi104_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimi104_browser_fill(g_wc,"F")
      CALL aimi104_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimi104_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aimi104_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimi104.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimi104_fetch(p_fl)
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
   LET g_imce_m.imce141 = g_browser[g_current_idx].b_imce141
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimi104_master_referesh USING g_site,g_imce_m.imce141 INTO g_imce_m.imce141,g_imce_m.imce142, 
       g_imce_m.imce143,g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148, 
       g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid,g_imce_m.imceowndp,g_imce_m.imcecrtid,g_imce_m.imcecrtdp, 
       g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157, 
       g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce142_desc, 
       g_imce_m.imce143_desc,g_imce_m.imce144_desc,g_imce_m.imceownid_desc,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp_desc,g_imce_m.imcemodid_desc,g_imce_m.imce157_desc,g_imce_m.imce153_desc,g_imce_m.imce176_desc 
 
   
   #遮罩相關處理
   LET g_imce_m_mask_o.* =  g_imce_m.*
   CALL aimi104_imce_t_mask()
   LET g_imce_m_mask_n.* =  g_imce_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi104_set_act_visible()
   CALL aimi104_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete", TRUE)
   IF g_imce_m.imcestus ='N' THEN  
      CALL cl_set_act_visible("modify,delete", FALSE)   
   END IF      
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imce_m_t.* = g_imce_m.*
   LET g_imce_m_o.* = g_imce_m.*
   
   LET g_data_owner = g_imce_m.imceownid      
   LET g_data_dept  = g_imce_m.imceowndp
   
   #重新顯示
   CALL aimi104_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimi104.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimi104_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imce_m.* TO NULL             #DEFAULT 設定
   LET g_imce141_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imce_m.imceownid = g_user
      LET g_imce_m.imceowndp = g_dept
      LET g_imce_m.imcecrtid = g_user
      LET g_imce_m.imcecrtdp = g_dept 
      LET g_imce_m.imcecrtdt = cl_get_current()
      LET g_imce_m.imcemodid = g_user
      LET g_imce_m.imcemoddt = cl_get_current()
      LET g_imce_m.imcestus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imce_m.imce145 = "0"
      LET g_imce_m.imce146 = "0"
      LET g_imce_m.imce147 = "1"
      LET g_imce_m.imce148 = "0"
      LET g_imce_m.imce149 = "0"
      LET g_imce_m.imce151 = "0"
      LET g_imce_m.imce158 = "0"
      LET g_imce_m.imce152 = "0"
      LET g_imce_m.imce154 = "0"
      LET g_imce_m.imce155 = "0"
      LET g_imce_m.imce156 = "0"
      LET g_imce_m.imce161 = "N"
      LET g_imce_m.imce162 = "N"
      LET g_imce_m.imce163 = "N"
      LET g_imce_m.imce164 = "0"
      LET g_imce_m.imce165 = "0"
      LET g_imce_m.imce166 = "0"
      LET g_imce_m.imce171 = "0"
      LET g_imce_m.imce172 = "0"
      LET g_imce_m.imce173 = "0"
      LET g_imce_m.imce174 = "0"
      LET g_imce_m.imce175 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_imce_m.imcestus = "Y"
      INITIALIZE g_imce_m_t.* LIKE imce_t.*
      LET g_imce141_t = ''
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imce_m.imcestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aimi104_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imce_m.* TO NULL
         CALL aimi104_show()
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
   CALL aimi104_set_act_visible()
   CALL aimi104_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imce141_t = g_imce_m.imce141
 
   
   #組合新增資料的條件
   LET g_add_browse = " imceent = " ||g_enterprise|| " AND imcesite = '" ||g_site|| "' AND",
                      " imce141 = '", g_imce_m.imce141, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi104_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimi104_master_referesh USING g_site,g_imce_m.imce141 INTO g_imce_m.imce141,g_imce_m.imce142, 
       g_imce_m.imce143,g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148, 
       g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid,g_imce_m.imceowndp,g_imce_m.imcecrtid,g_imce_m.imcecrtdp, 
       g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157, 
       g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce142_desc, 
       g_imce_m.imce143_desc,g_imce_m.imce144_desc,g_imce_m.imceownid_desc,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp_desc,g_imce_m.imcemodid_desc,g_imce_m.imce157_desc,g_imce_m.imce153_desc,g_imce_m.imce176_desc 
 
   
   
   #遮罩相關處理
   LET g_imce_m_mask_o.* =  g_imce_m.*
   CALL aimi104_imce_t_mask()
   LET g_imce_m_mask_n.* =  g_imce_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imce_m.imce141,g_imce_m.oocql004,g_imce_m.oocql005,g_imce_m.imce142,g_imce_m.imce142_desc, 
       g_imce_m.imce143,g_imce_m.imce143_desc,g_imce_m.imce144,g_imce_m.imce144_desc,g_imce_m.imce145, 
       g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid, 
       g_imce_m.imceownid_desc,g_imce_m.imceowndp,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp,g_imce_m.imcecrtdp_desc,g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemodid_desc, 
       g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce157_desc,g_imce_m.imce152, 
       g_imce_m.imce153,g_imce_m.imce153_desc,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce176_desc 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_imce_m.imceownid      
   LET g_data_dept  = g_imce_m.imceowndp
 
   #功能已完成,通報訊息中心
   CALL aimi104_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi104.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimi104_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imce_m.imce141 IS NULL
 
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
   LET g_imce141_t = g_imce_m.imce141
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimi104_cl USING g_enterprise, g_site,g_imce_m.imce141
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi104_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi104_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi104_master_referesh USING g_site,g_imce_m.imce141 INTO g_imce_m.imce141,g_imce_m.imce142, 
       g_imce_m.imce143,g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148, 
       g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid,g_imce_m.imceowndp,g_imce_m.imcecrtid,g_imce_m.imcecrtdp, 
       g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157, 
       g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce142_desc, 
       g_imce_m.imce143_desc,g_imce_m.imce144_desc,g_imce_m.imceownid_desc,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp_desc,g_imce_m.imcemodid_desc,g_imce_m.imce157_desc,g_imce_m.imce153_desc,g_imce_m.imce176_desc 
 
 
   #檢查是否允許此動作
   IF NOT aimi104_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imce_m_mask_o.* =  g_imce_m.*
   CALL aimi104_imce_t_mask()
   LET g_imce_m_mask_n.* =  g_imce_m.*
   
   
 
   #顯示資料
   CALL aimi104_show()
   
   WHILE TRUE
      LET g_imce_m.imce141 = g_imce141_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imce_m.imcemodid = g_user 
LET g_imce_m.imcemoddt = cl_get_current()
LET g_imce_m.imcemodid_desc = cl_get_username(g_imce_m.imcemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aimi104_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imce_m.* = g_imce_m_t.*
         CALL aimi104_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imce_t SET (imcemodid,imcemoddt) = (g_imce_m.imcemodid,g_imce_m.imcemoddt)
       WHERE imceent = g_enterprise AND imcesite = g_site AND imce141 = g_imce141_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi104_set_act_visible()
   CALL aimi104_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imceent = " ||g_enterprise|| " AND imcesite = '" ||g_site|| "' AND",
                      " imce141 = '", g_imce_m.imce141, "' "
 
   #填到對應位置
   CALL aimi104_browser_fill(g_wc,"")
 
   CLOSE aimi104_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi104_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimi104.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimi104_input(p_cmd)
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
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imce_m.imce141,g_imce_m.oocql004,g_imce_m.oocql005,g_imce_m.imce142,g_imce_m.imce142_desc, 
       g_imce_m.imce143,g_imce_m.imce143_desc,g_imce_m.imce144,g_imce_m.imce144_desc,g_imce_m.imce145, 
       g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid, 
       g_imce_m.imceownid_desc,g_imce_m.imceowndp,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp,g_imce_m.imcecrtdp_desc,g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemodid_desc, 
       g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce157_desc,g_imce_m.imce152, 
       g_imce_m.imce153,g_imce_m.imce153_desc,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce176_desc 
 
   
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
   CALL aimi104_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimi104_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imce_m.imce141,g_imce_m.oocql004,g_imce_m.oocql005,g_imce_m.imce142,g_imce_m.imce143, 
          g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149, 
          g_imce_m.imcestus,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce152,g_imce_m.imce153, 
          g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161,g_imce_m.imce162,g_imce_m.imce163, 
          g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171,g_imce_m.imce172,g_imce_m.imce173, 
          g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               #161013-00017#4 add-S
               IF NOT cl_null(g_imce_m.imce141)  THEN
                  CALL n_oocql('203',g_imce_m.imce141)    # n_glacl:對應多語言表格 。 g_glac_m.glac002: 對應值
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = '203'
                  LET g_ref_fields[2] = g_imce_m.imce141
                  CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                      ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imce_m.oocql004 = g_rtn_fields[1]
                  LET g_imce_m.oocql005 = g_rtn_fields[2]

                  DISPLAY BY NAME g_imce_m.oocql004
                  DISPLAY BY NAME g_imce_m.oocql005
               END IF
               #161013-00017#4 add-E
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.oocql001 = '203'
LET g_master_multi_table_t.oocql002 = g_imce_m.imce141
LET g_master_multi_table_t.oocql004 = g_imce_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imce_m.oocql005
 
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce141
            #add-point:BEFORE FIELD imce141 name="input.b.imce141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce141
            
            #add-point:AFTER FIELD imce141 name="input.a.imce141"
            #161013-00017#4 mod-S
#            DISPLAY '' TO imce141_desc
            DISPLAY '' TO oocql004
            DISPLAY '' TO oocql005
            #161013-00017#4 mod-E
            IF NOT aimi104_chk_imce141('a') THEN 
               NEXT FIELD imce141
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imce_m.imce141
            #161013-00017#4 mod-S
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='203' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imce141_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imce141_desc
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='203' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imce_m.oocql004 = g_rtn_fields[1]
            LET g_imce_m.oocql005 = g_rtn_fields[2]
            DISPLAY BY NAME g_imce_m.oocql004
            DISPLAY BY NAME g_imce_m.oocql005
            #161013-00017#4 mod-E
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce141
            #add-point:ON CHANGE imce141 name="input.g.imce141"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="input.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="input.a.oocql004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql004
            #add-point:ON CHANGE oocql004 name="input.g.oocql004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="input.b.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="input.a.oocql005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql005
            #add-point:ON CHANGE oocql005 name="input.g.oocql005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce142
            
            #add-point:AFTER FIELD imce142 name="input.a.imce142"
            DISPLAY '' TO imce142_desc
            IF NOT cl_null(g_imce_m.imce142) THEN
               IF NOT ap_chk_isExist(g_imce_m.imce142,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ?  ",'aoo-00074',1) THEN 
                  LET g_imce_m.imce142 = g_imce_m_t.imce142 
                  NEXT FIELD imce142
               END IF
               IF NOT ap_chk_isExist(g_imce_m.imce142,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? AND ooagstus = 'Y' ",'sub-01302','aooi130') THEN #'aim-00070',1) THEN
                  LET g_imce_m.imce142 = g_imce_m_t.imce142                 
                  NEXT FIELD imce142
               END IF    
            END IF        
            INITIALIZE g_ref_fields TO NULL          
            LET g_ref_fields[1] = g_imce_m.imce142
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001 = ? ","") RETURNING g_rtn_fields
            LET g_imce_m.imce142_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imce_m.imce142_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce142
            #add-point:BEFORE FIELD imce142 name="input.b.imce142"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce142
            #add-point:ON CHANGE imce142 name="input.g.imce142"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce143
            
            #add-point:AFTER FIELD imce143 name="input.a.imce143"
            IF NOT aimi104_chk_imce143_imce144(g_imce_m.imce143) THEN 
               LET g_imce_m.imce143 = g_imce_m_t.imce143
               NEXT FIELD imce143
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce143
            #add-point:BEFORE FIELD imce143 name="input.b.imce143"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce143
            #add-point:ON CHANGE imce143 name="input.g.imce143"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce144
            
            #add-point:AFTER FIELD imce144 name="input.a.imce144"
            IF NOT aimi104_chk_imce143_imce144(g_imce_m.imce144) THEN 
               LET g_imce_m.imce144 = g_imce_m_t.imce144
               NEXT FIELD imce144
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce144
            #add-point:BEFORE FIELD imce144 name="input.b.imce144"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce144
            #add-point:ON CHANGE imce144 name="input.g.imce144"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce145
            #add-point:BEFORE FIELD imce145 name="input.b.imce145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce145
            
            #add-point:AFTER FIELD imce145 name="input.a.imce145"
            IF NOT aimi104_chk_qty(g_imce_m.imce145) THEN 
               LET g_imce_m.imce145 = g_imce_m_t.imce145
               NEXT FIELD imce145
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce145
            #add-point:ON CHANGE imce145 name="input.g.imce145"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce146
            #add-point:BEFORE FIELD imce146 name="input.b.imce146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce146
            
            #add-point:AFTER FIELD imce146 name="input.a.imce146"
            IF NOT aimi104_chk_qty(g_imce_m.imce146) THEN 
               LET g_imce_m.imce146 = g_imce_m_t.imce146
               NEXT FIELD imce146
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce146
            #add-point:ON CHANGE imce146 name="input.g.imce146"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce147
            #add-point:BEFORE FIELD imce147 name="input.b.imce147"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce147
            
            #add-point:AFTER FIELD imce147 name="input.a.imce147"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce147
            #add-point:ON CHANGE imce147 name="input.g.imce147"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce148
            #add-point:BEFORE FIELD imce148 name="input.b.imce148"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce148
            
            #add-point:AFTER FIELD imce148 name="input.a.imce148"
            IF NOT aimi104_chk_qty(g_imce_m.imce148) THEN 
               LET g_imce_m.imce148 = g_imce_m_t.imce148
               NEXT FIELD imce148
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce148
            #add-point:ON CHANGE imce148 name="input.g.imce148"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce149
            #add-point:BEFORE FIELD imce149 name="input.b.imce149"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce149
            
            #add-point:AFTER FIELD imce149 name="input.a.imce149"
            IF NOT aimi104_chk_qty(g_imce_m.imce149) THEN 
               LET g_imce_m.imce149 = g_imce_m_t.imce149
               NEXT FIELD imce149
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce149
            #add-point:ON CHANGE imce149 name="input.g.imce149"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcestus
            #add-point:BEFORE FIELD imcestus name="input.b.imcestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcestus
            
            #add-point:AFTER FIELD imcestus name="input.a.imcestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcestus
            #add-point:ON CHANGE imcestus name="input.g.imcestus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce151
            #add-point:BEFORE FIELD imce151 name="input.b.imce151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce151
            
            #add-point:AFTER FIELD imce151 name="input.a.imce151"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce151
            #add-point:ON CHANGE imce151 name="input.g.imce151"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce158
            #add-point:BEFORE FIELD imce158 name="input.b.imce158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce158
            
            #add-point:AFTER FIELD imce158 name="input.a.imce158"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce158
            #add-point:ON CHANGE imce158 name="input.g.imce158"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce157
            
            #add-point:AFTER FIELD imce157 name="input.a.imce157"
            DISPLAY '' TO imce157_desc
            IF NOT cl_null(g_imce_m.imce157) THEN 
               IF NOT ap_chk_isExist(g_imce_m.imce157,"SELECT COUNT(*) FROM imaa_t WHERE "||"imaaent = '" ||g_enterprise|| "' AND "||"imaa001 = ?  ",'aim-00001',1) THEN 
                  LET g_imce_m.imce157 = g_imce_m_t.imce157 
                  NEXT FIELD imce157
               END IF     
               IF NOT ap_chk_isExist(g_imce_m.imce157,"SELECT COUNT(*) FROM imaa_t WHERE "||"imaaent = '" ||g_enterprise|| "' AND "||"imaa001 = ? AND imaastus = 'Y' ",'sub-01302','aimm200') THEN#160318-00005#20 mod #'aim-00002',1) THEN 
                  LET g_imce_m.imce157 = g_imce_m_t.imce157 
                  NEXT FIELD imce157
               END IF       
               IF NOT ap_chk_isExist(g_imce_m.imce157,"SELECT COUNT(*) FROM imaa_t WHERE "||"imaaent = '" ||g_enterprise|| "' AND "||"imaa001 = ? AND imaa027 = 'Y' AND imaastus = 'Y' ",'aim-00094',1) THEN 
                  LET g_imce_m.imce157 = g_imce_m_t.imce157 
                  NEXT FIELD imce157
               END IF               
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imce_m.imce157
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imce_m.imce157_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imce_m.imce157_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce157
            #add-point:BEFORE FIELD imce157 name="input.b.imce157"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce157
            #add-point:ON CHANGE imce157 name="input.g.imce157"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce152
            #add-point:BEFORE FIELD imce152 name="input.b.imce152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce152
            
            #add-point:AFTER FIELD imce152 name="input.a.imce152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce152
            #add-point:ON CHANGE imce152 name="input.g.imce152"
            IF NOT cl_null(g_imce_m.imce152) THEN 
               CALL cl_set_comp_entry('imce154',g_imce_m.imce152 = '2')
               IF g_imce_m.imce152 != '2' THEN LET g_imce_m.imce154 = 0 END IF
               IF g_imce_m.imce152 MATCHES '[23]' THEN 
                  CALL cl_set_comp_entry('imce155',TRUE)
               ELSE
                  CALL cl_set_comp_entry('imce155',FALSE)
                  LET g_imce_m.imce155 = 0
               END IF
               DISPLAY BY NAME g_imce_m.imce154,g_imce_m.imce155
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce153
            
            #add-point:AFTER FIELD imce153 name="input.a.imce153"
            DISPLAY '' TO imce153_desc
            IF NOT cl_null(g_imce_m.imce153) THEN 
               #IF NOT ap_chk_isExist(g_imce_m.imce153,"SELECT COUNT(*) FROM pmaa_t WHERE "||"pmaaent = '" ||g_enterprise|| "' AND "||" pmaa001 = ?  ",'apm-00016',1) THEN   #160913-00055#2
               IF NOT ap_chk_isExist(g_imce_m.imce153,"SELECT COUNT(1) FROM pmaa_t WHERE "||"pmaaent = '" ||g_enterprise|| "' AND "||" pmaa001 = ?  AND (pmaa002 = '1' OR pmaa002 = '3') ",'apm-00016',1) THEN   #160913-00055#2
                  LET g_imce_m.imce153 = g_imce_m_t.imce153 
                  NEXT FIELD imce153
               END IF     
               #IF NOT ap_chk_isExist(g_imce_m.imce153,"SELECT COUNT(*) FROM pmaa_t WHERE "||"pmaaent = '" ||g_enterprise|| "' AND "||" pmaa001 = ? AND pmaastus = 'Y' ",'apm-00017',1) THEN  #160913-00055#2 
               IF NOT ap_chk_isExist(g_imce_m.imce153,"SELECT COUNT(1) FROM pmaa_t WHERE "||"pmaaent = '" ||g_enterprise|| "' AND "||" pmaa001 = ? AND (pmaa002 = '1' OR pmaa002 = '3') AND pmaastus = 'Y' ",'apm-00017',1) THEN  #160913-00055#2 
                  LET g_imce_m.imce153 = g_imce_m_t.imce153 
                  NEXT FIELD imce153
               END IF               
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imce_m.imce153
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imce_m.imce153_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imce_m.imce153_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce153
            #add-point:BEFORE FIELD imce153 name="input.b.imce153"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce153
            #add-point:ON CHANGE imce153 name="input.g.imce153"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce154
            #add-point:BEFORE FIELD imce154 name="input.b.imce154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce154
            
            #add-point:AFTER FIELD imce154 name="input.a.imce154"
            IF NOT aimi104_chk_qty(g_imce_m.imce154) THEN 
               LET g_imce_m.imce154 = g_imce_m_t.imce154
               NEXT FIELD imce154
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce154
            #add-point:ON CHANGE imce154 name="input.g.imce154"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce155
            #add-point:BEFORE FIELD imce155 name="input.b.imce155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce155
            
            #add-point:AFTER FIELD imce155 name="input.a.imce155"
            IF NOT aimi104_chk_qty(g_imce_m.imce155) THEN 
               LET g_imce_m.imce155 = g_imce_m_t.imce155
               NEXT FIELD imce155
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce155
            #add-point:ON CHANGE imce155 name="input.g.imce155"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce156
            #add-point:BEFORE FIELD imce156 name="input.b.imce156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce156
            
            #add-point:AFTER FIELD imce156 name="input.a.imce156"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce156
            #add-point:ON CHANGE imce156 name="input.g.imce156"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce161
            #add-point:BEFORE FIELD imce161 name="input.b.imce161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce161
            
            #add-point:AFTER FIELD imce161 name="input.a.imce161"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce161
            #add-point:ON CHANGE imce161 name="input.g.imce161"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce162
            #add-point:BEFORE FIELD imce162 name="input.b.imce162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce162
            
            #add-point:AFTER FIELD imce162 name="input.a.imce162"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce162
            #add-point:ON CHANGE imce162 name="input.g.imce162"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce163
            #add-point:BEFORE FIELD imce163 name="input.b.imce163"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce163
            
            #add-point:AFTER FIELD imce163 name="input.a.imce163"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce163
            #add-point:ON CHANGE imce163 name="input.g.imce163"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce164
            #add-point:BEFORE FIELD imce164 name="input.b.imce164"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce164
            
            #add-point:AFTER FIELD imce164 name="input.a.imce164"
            #160505-00002#3--s
            IF NOT cl_null(g_imce_m.imce164) THEN 
               IF NOT cl_ap_chk_range(g_imce_m.imce164,"0.000","1","100.000","1","azz-00087",1) THEN
                  LET g_imce_m.imce164 = g_imce_m_t.imce164
                  NEXT FIELD imce164
               END IF
            END IF
            #160505-00002#3--e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce164
            #add-point:ON CHANGE imce164 name="input.g.imce164"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce165
            #add-point:BEFORE FIELD imce165 name="input.b.imce165"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce165
            
            #add-point:AFTER FIELD imce165 name="input.a.imce165"
            IF NOT cl_null(g_imce_m.imce165) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imce_m.imce165,"0.000","1","100.000","1","azz-00087",1) THEN
                  LET g_imce_m.imce165 = g_imce_m_t.imce165
                  NEXT FIELD imce165
               END IF
               #160505-00002#3--e
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce165
            #add-point:ON CHANGE imce165 name="input.g.imce165"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce166
            #add-point:BEFORE FIELD imce166 name="input.b.imce166"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce166
            
            #add-point:AFTER FIELD imce166 name="input.a.imce166"
            IF NOT cl_null(g_imce_m.imce166) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imce_m.imce166,"0.000","1","100.000","1","azz-00087",1) THEN
                  LET g_imce_m.imce166 = g_imce_m_t.imce166
                  NEXT FIELD imce166
               END IF
               #160505-00002#3--e
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce166
            #add-point:ON CHANGE imce166 name="input.g.imce166"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce171
            #add-point:BEFORE FIELD imce171 name="input.b.imce171"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce171
            
            #add-point:AFTER FIELD imce171 name="input.a.imce171"
            IF NOT cl_null(g_imce_m.imce171) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imce_m.imce171,"0.000","1","","","azz-00079",1) THEN
                  LET g_imce_m.imce171 = g_imce_m_t.imce171
                  NEXT FIELD imce171
               END IF
               #160505-00002#3--e
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce171
            #add-point:ON CHANGE imce171 name="input.g.imce171"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce172
            #add-point:BEFORE FIELD imce172 name="input.b.imce172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce172
            
            #add-point:AFTER FIELD imce172 name="input.a.imce172"
            IF NOT cl_null(g_imce_m.imce172) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imce_m.imce172,"0.000","1","","","azz-00079",1) THEN
                  LET g_imce_m.imce172 = g_imce_m_t.imce172
                  NEXT FIELD imce172
               END IF
               #160505-00002#3--e
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce172
            #add-point:ON CHANGE imce172 name="input.g.imce172"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce173
            #add-point:BEFORE FIELD imce173 name="input.b.imce173"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce173
            
            #add-point:AFTER FIELD imce173 name="input.a.imce173"
            IF NOT cl_null(g_imce_m.imce173) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imce_m.imce173,"0.000","1","","","azz-00079",1) THEN
                  LET g_imce_m.imce173 = g_imce_m_t.imce173
                  NEXT FIELD imce173
               END IF
               #160505-00002#3--e
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce173
            #add-point:ON CHANGE imce173 name="input.g.imce173"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce174
            #add-point:BEFORE FIELD imce174 name="input.b.imce174"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce174
            
            #add-point:AFTER FIELD imce174 name="input.a.imce174"
            IF NOT cl_null(g_imce_m.imce174) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imce_m.imce174,"0.000","1","","","azz-00079",1) THEN
                  LET g_imce_m.imce174 = g_imce_m_t.imce174
                  NEXT FIELD imce174
               END IF
               #160505-00002#3--e
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce174
            #add-point:ON CHANGE imce174 name="input.g.imce174"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce175
            #add-point:BEFORE FIELD imce175 name="input.b.imce175"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce175
            
            #add-point:AFTER FIELD imce175 name="input.a.imce175"
            IF NOT cl_null(g_imce_m.imce175) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imce_m.imce175,"0.000","1","","","azz-00079",1) THEN
                  LET g_imce_m.imce175 = g_imce_m_t.imce175
                  NEXT FIELD imce175
               END IF
               #160505-00002#3--e
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce175
            #add-point:ON CHANGE imce175 name="input.g.imce175"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imce176
            
            #add-point:AFTER FIELD imce176 name="input.a.imce176"
            DISPLAY '' TO imce176_desc
            IF NOT cl_null(g_imce_m.imce176) THEN 
               IF NOT ap_chk_isExist(g_imce_m.imce176,"SELECT COUNT(1) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '274' ",'sub-01303','aooi715') THEN #'aim-00092',1) THEN 
                  LET g_imce_m.imce176 = g_imce_m_t.imce176 
                  NEXT FIELD imce176
               END IF
               IF NOT ap_chk_isExist(g_imce_m.imce176,"SELECT COUNT(1) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '274' AND oocqstus = 'Y' ",'sub-01302','aooi715') THEN #160318-00005#20 mod#'aim-00093',1) THEN 
                  LET g_imce_m.imce176 = g_imce_m_t.imce176 
                  NEXT FIELD imce176
               END IF         
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imce_m.imce176
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imce_m.imce176_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_imce_m.imce176_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imce176
            #add-point:BEFORE FIELD imce176 name="input.b.imce176"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imce176
            #add-point:ON CHANGE imce176 name="input.g.imce176"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imce141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce141
            #add-point:ON ACTION controlp INFIELD imce141 name="input.c.imce141"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_imce_m.imce141             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '203'           
            CALL q_oocq002()                                #呼叫開窗
            LET g_imce_m.imce141 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_imce_m.imce141 TO imce141              #顯示到畫面上
            #161013-00017#4 marked-S
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imce141
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='203' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imce141_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imce141_desc            
            #161013-00017#4 marked-E
            #161013-00017#4 add-S
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = '203'
            LET g_ref_fields[2] = g_imce_m.imce141 
            CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imce_m.oocql004 = g_rtn_fields[1]
            LET g_imce_m.oocql005 = g_rtn_fields[2]
            DISPLAY BY NAME g_imce_m.oocql004
            DISPLAY BY NAME g_imce_m.oocql005
            #161013-00017#4 add-E
            NEXT FIELD imce141                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="input.c.oocql004"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="input.c.oocql005"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce142
            #add-point:ON ACTION controlp INFIELD imce142 name="input.c.imce142"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imce_m.imce142             #給予default值

            #給予arg
            LET g_qryparam.where = " ooagstus = 'Y' "
            CALL q_ooag001()                                #呼叫開窗

            LET g_imce_m.imce142 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ''
            DISPLAY g_imce_m.imce142 TO imce142              #顯示到畫面上

            NEXT FIELD imce142                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imce143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce143
            #add-point:ON ACTION controlp INFIELD imce143 name="input.c.imce143"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imce_m.imce143             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imce_m.imce143 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imce_m.imce143 TO imce143              #顯示到畫面上

            NEXT FIELD imce143                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imce144
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce144
            #add-point:ON ACTION controlp INFIELD imce144 name="input.c.imce144"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imce_m.imce144             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imce_m.imce144 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imce_m.imce144 TO imce144              #顯示到畫面上

            NEXT FIELD imce144                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imce145
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce145
            #add-point:ON ACTION controlp INFIELD imce145 name="input.c.imce145"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce146
            #add-point:ON ACTION controlp INFIELD imce146 name="input.c.imce146"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce147
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce147
            #add-point:ON ACTION controlp INFIELD imce147 name="input.c.imce147"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce148
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce148
            #add-point:ON ACTION controlp INFIELD imce148 name="input.c.imce148"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce149
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce149
            #add-point:ON ACTION controlp INFIELD imce149 name="input.c.imce149"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcestus
            #add-point:ON ACTION controlp INFIELD imcestus name="input.c.imcestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce151
            #add-point:ON ACTION controlp INFIELD imce151 name="input.c.imce151"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce158
            #add-point:ON ACTION controlp INFIELD imce158 name="input.c.imce158"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce157
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce157
            #add-point:ON ACTION controlp INFIELD imce157 name="input.c.imce157"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imce_m.imce157             #給予default值
            LET g_qryparam.default2 = "" #g_imce_m.imaal003 #品名

            #給予arg

            CALL q_imaa001_3()                                #呼叫開窗

            LET g_imce_m.imce157 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_imce_m.imaal003 = g_qryparam.return2 #品名

            DISPLAY g_imce_m.imce157 TO imce157              #顯示到畫面上
            #DISPLAY g_imce_m.imaal003 TO imaal003 #品名

            NEXT FIELD imce157                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imce152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce152
            #add-point:ON ACTION controlp INFIELD imce152 name="input.c.imce152"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce153
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce153
            #add-point:ON ACTION controlp INFIELD imce153 name="input.c.imce153"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imce_m.imce153             #給予default值

            #給予arg
   
           #CALL q_pmaa001()      #160905-00015 mark
            CALL q_pmaa001_3()    #160905-00015 add
            
            LET g_imce_m.imce153 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imce_m.imce153 TO imce153              #顯示到畫面上

            NEXT FIELD imce153                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imce154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce154
            #add-point:ON ACTION controlp INFIELD imce154 name="input.c.imce154"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce155
            #add-point:ON ACTION controlp INFIELD imce155 name="input.c.imce155"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce156
            #add-point:ON ACTION controlp INFIELD imce156 name="input.c.imce156"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce161
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce161
            #add-point:ON ACTION controlp INFIELD imce161 name="input.c.imce161"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce162
            #add-point:ON ACTION controlp INFIELD imce162 name="input.c.imce162"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce163
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce163
            #add-point:ON ACTION controlp INFIELD imce163 name="input.c.imce163"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce164
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce164
            #add-point:ON ACTION controlp INFIELD imce164 name="input.c.imce164"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce165
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce165
            #add-point:ON ACTION controlp INFIELD imce165 name="input.c.imce165"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce166
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce166
            #add-point:ON ACTION controlp INFIELD imce166 name="input.c.imce166"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce171
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce171
            #add-point:ON ACTION controlp INFIELD imce171 name="input.c.imce171"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce172
            #add-point:ON ACTION controlp INFIELD imce172 name="input.c.imce172"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce173
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce173
            #add-point:ON ACTION controlp INFIELD imce173 name="input.c.imce173"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce174
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce174
            #add-point:ON ACTION controlp INFIELD imce174 name="input.c.imce174"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce175
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce175
            #add-point:ON ACTION controlp INFIELD imce175 name="input.c.imce175"
            
            #END add-point
 
 
         #Ctrlp:input.c.imce176
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imce176
            #add-point:ON ACTION controlp INFIELD imce176 name="input.c.imce176"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imce_m.imce176             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "274" #應用分類

            CALL q_oocq002_3()                                #呼叫開窗

            LET g_imce_m.imce176 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imce_m.imce176
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imce_m.imce176_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imce_m.imce176_desc
            
            DISPLAY g_imce_m.imce176 TO imce176              #顯示到畫面上

            NEXT FIELD imce176                          #返回原欄位


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
               SELECT COUNT(1) INTO l_count FROM imce_t
                WHERE imceent = g_enterprise AND imcesite = g_site AND imce141 = g_imce_m.imce141
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imce_t (imceent, imcesite,imce141,imce142,imce143,imce144,imce145,imce146, 
                      imce147,imce148,imce149,imcestus,imceownid,imceowndp,imcecrtid,imcecrtdp,imcecrtdt, 
                      imcemodid,imcemoddt,imce151,imce158,imce157,imce152,imce153,imce154,imce155,imce156, 
                      imce161,imce162,imce163,imce164,imce165,imce166,imce171,imce172,imce173,imce174, 
                      imce175,imce176)
                  VALUES (g_enterprise, g_site,g_imce_m.imce141,g_imce_m.imce142,g_imce_m.imce143,g_imce_m.imce144, 
                      g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149, 
                      g_imce_m.imcestus,g_imce_m.imceownid,g_imce_m.imceowndp,g_imce_m.imcecrtid,g_imce_m.imcecrtdp, 
                      g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158, 
                      g_imce_m.imce157,g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155, 
                      g_imce_m.imce156,g_imce_m.imce161,g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164, 
                      g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171,g_imce_m.imce172,g_imce_m.imce173, 
                      g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  #161013-00017#4 add-S
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imce_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_count = 1
                  SELECT COUNT(1) INTO l_count FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '203' AND oocq002 = g_imce_m.imce141
                  IF l_count = 0 THEN #新增分类码及说明
                     INSERT INTO oocq_t (oocqent,oocqstus,oocq001,oocq002,oocq003)
                     VALUES (g_enterprise,'Y','203',g_imce_m.imce141,'203')
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET SQLCA.sqlcode = NULL
                  #161013-00017#4 add-E
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imce_t:",SQLERRMESSAGE 
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
         IF '203' = g_master_multi_table_t.oocql001 AND
         g_imce_m.imce141 = g_master_multi_table_t.oocql002 AND
         g_imce_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imce_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '203'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imce_m.imce141
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imce_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imce_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imce_m.imce141
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aimi104_imce_t_mask_restore('restore_mask_o')
               
               UPDATE imce_t SET (imce141,imce142,imce143,imce144,imce145,imce146,imce147,imce148,imce149, 
                   imcestus,imceownid,imceowndp,imcecrtid,imcecrtdp,imcecrtdt,imcemodid,imcemoddt,imce151, 
                   imce158,imce157,imce152,imce153,imce154,imce155,imce156,imce161,imce162,imce163,imce164, 
                   imce165,imce166,imce171,imce172,imce173,imce174,imce175,imce176) = (g_imce_m.imce141, 
                   g_imce_m.imce142,g_imce_m.imce143,g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146, 
                   g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid, 
                   g_imce_m.imceowndp,g_imce_m.imcecrtid,g_imce_m.imcecrtdp,g_imce_m.imcecrtdt,g_imce_m.imcemodid, 
                   g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce152, 
                   g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
                   g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166, 
                   g_imce_m.imce171,g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175, 
                   g_imce_m.imce176)
                WHERE imceent = g_enterprise AND imcesite = g_site AND imce141 = g_imce141_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imce_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imce_t:",SQLERRMESSAGE 
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
         IF '203' = g_master_multi_table_t.oocql001 AND
         g_imce_m.imce141 = g_master_multi_table_t.oocql002 AND
         g_imce_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imce_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '203'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imce_m.imce141
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imce_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imce_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimi104_imce_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imce_m_t)
                     LET g_log2 = util.JSON.stringify(g_imce_m)
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
 
{<section id="aimi104.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimi104_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imce_t.imce141 
   DEFINE l_oldno     LIKE imce_t.imce141 
 
   DEFINE l_master    RECORD LIKE imce_t.* #此變數樣板目前無使用
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
   IF g_imce_m.imce141 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imce141_t = g_imce_m.imce141
 
   
   #清空key值
   LET g_imce_m.imce141 = ""
 
    
   CALL aimi104_set_entry("a")
   CALL aimi104_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imce_m.imceownid = g_user
      LET g_imce_m.imceowndp = g_dept
      LET g_imce_m.imcecrtid = g_user
      LET g_imce_m.imcecrtdp = g_dept 
      LET g_imce_m.imcecrtdt = cl_get_current()
      LET g_imce_m.imcemodid = g_user
      LET g_imce_m.imcemoddt = cl_get_current()
      LET g_imce_m.imcestus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_imce_m.imce141 = ''
   LET g_imce_m_t.imce141 = ''
   #161013-00017#4 mod-S
#   LET g_imce_m.imce141_desc = ''
#   DISPLAY BY NAME g_imce_m.imce141_desc
   LET g_imce_m.oocql004 = ''
   LET g_imce_m.oocql005 = ''
   DISPLAY BY NAME g_imce_m.oocql004
   DISPLAY BY NAME g_imce_m.oocql005
   #161013-00017#4 mod-E
   LET g_imce_m.imcestus = "Y"
   DISPLAY BY NAME g_imce_m.imcestus
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imce_m.imcestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aimi104_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imce_m.* TO NULL
      CALL aimi104_show()
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
      LET g_errparam.extend = "imce_t:",SQLERRMESSAGE 
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
   CALL aimi104_set_act_visible()
   CALL aimi104_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imce141_t = g_imce_m.imce141
 
   
   #組合新增資料的條件
   LET g_add_browse = " imceent = " ||g_enterprise|| " AND imcesite = '" ||g_site|| "' AND",
                      " imce141 = '", g_imce_m.imce141, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi104_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imce_m.imceownid      
   LET g_data_dept  = g_imce_m.imceowndp
              
   #功能已完成,通報訊息中心
   CALL aimi104_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimi104.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimi104_show()
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
   CALL aimi104_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imce141
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='203' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imce141_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imce141_desc
#
#            INITIALIZE g_ref_fields TO NULL          
#            LET g_ref_fields[1] = g_imce_m.imce142
#            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t,ooag_t WHERE oofaent='"||g_enterprise||"' AND oofa001=ooag002 AND ooag001 = ? ","") RETURNING g_rtn_fields
#            LET g_imce_m.imce142_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imce142_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imceownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imce_m.imceownid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imceownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imceowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imceowndp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imceowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imcecrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imce_m.imcecrtid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imcecrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imcecrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imcecrtdp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imcecrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imcemodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_imce_m.imcemodid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imcemodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imce153
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imce153_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imce153_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imce157
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imce157_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imce157_desc
#           
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imce_m.imce176
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imce_m.imce176_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imce_m.imce176_desc           
   #161013-00017#4 add-S
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '203'
   LET g_ref_fields[2] = g_imce_m.imce141
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
       ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imce_m.oocql004 = g_rtn_fields[1]
   LET g_imce_m.oocql005 = g_rtn_fields[2]
    
   DISPLAY BY NAME g_imce_m.oocql004
   DISPLAY BY NAME g_imce_m.oocql005
   #161013-00017#4 add-E
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imce_m.imce141,g_imce_m.oocql004,g_imce_m.oocql005,g_imce_m.imce142,g_imce_m.imce142_desc, 
       g_imce_m.imce143,g_imce_m.imce143_desc,g_imce_m.imce144,g_imce_m.imce144_desc,g_imce_m.imce145, 
       g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid, 
       g_imce_m.imceownid_desc,g_imce_m.imceowndp,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp,g_imce_m.imcecrtdp_desc,g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemodid_desc, 
       g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce157_desc,g_imce_m.imce152, 
       g_imce_m.imce153,g_imce_m.imce153_desc,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce176_desc 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimi104_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imce_m.imcestus 
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
 
{<section id="aimi104.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimi104_delete()
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
   IF g_imce_m.imce141 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imce141_t = g_imce_m.imce141
 
   
   LET g_master_multi_table_t.oocql001 = '203'
LET g_master_multi_table_t.oocql002 = g_imce_m.imce141
LET g_master_multi_table_t.oocql004 = g_imce_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imce_m.oocql005
 
 
   OPEN aimi104_cl USING g_enterprise, g_site,g_imce_m.imce141
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi104_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi104_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi104_master_referesh USING g_site,g_imce_m.imce141 INTO g_imce_m.imce141,g_imce_m.imce142, 
       g_imce_m.imce143,g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148, 
       g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid,g_imce_m.imceowndp,g_imce_m.imcecrtid,g_imce_m.imcecrtdp, 
       g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157, 
       g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce142_desc, 
       g_imce_m.imce143_desc,g_imce_m.imce144_desc,g_imce_m.imceownid_desc,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp_desc,g_imce_m.imcemodid_desc,g_imce_m.imce157_desc,g_imce_m.imce153_desc,g_imce_m.imce176_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aimi104_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imce_m_mask_o.* =  g_imce_m.*
   CALL aimi104_imce_t_mask()
   LET g_imce_m_mask_n.* =  g_imce_m.*
   
   #將最新資料顯示到畫面上
   CALL aimi104_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimi104_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imce_t 
       WHERE imceent = g_enterprise AND imcesite = g_site AND imce141 = g_imce_m.imce141 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      #161013-00017#4 mod-S
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imce_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      #多语言不用删除
      {
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imce_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'oocqlent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
   LET l_field_keys[02] = 'oocql001'
   LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
   LET l_field_keys[03] = 'oocql002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      }
      #161013-00017#4 mod-E
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imce_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimi104_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimi104_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimi104_browser_fill(g_wc,"")
         CALL aimi104_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimi104_cl
 
   #功能已完成,通報訊息中心
   CALL aimi104_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimi104.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimi104_ui_browser_refresh()
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
      IF g_browser[l_i].b_imce141 = g_imce_m.imce141
 
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
 
{<section id="aimi104.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimi104_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   IF NOT cl_null(g_imce_m.imce152) AND g_imce_m.imce152 = '2' THEN 
      CALL cl_set_comp_entry('imce154',TRUE)
   END IF   
   IF NOT cl_null(g_imce_m.imce152) AND g_imce_m.imce152 MATCHES '[23]' THEN 
      CALL cl_set_comp_entry('imce155',TRUE)
   END IF
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imce141",TRUE)
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
 
{<section id="aimi104.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimi104_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   IF NOT cl_null(g_imce_m.imce152) AND g_imce_m.imce152 != '2' THEN 
      CALL cl_set_comp_entry('imce154',FALSE)
   END IF   
   IF NOT cl_null(g_imce_m.imce152) AND g_imce_m.imce152 NOT MATCHES '[23]' THEN 
      CALL cl_set_comp_entry('imce155',FALSE)
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imce141",FALSE)
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
 
{<section id="aimi104.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimi104_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi104.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimi104_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi104.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimi104_default_search()
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
      LET ls_wc = ls_wc, " imce141 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc =  " imce141 = '", g_argv[02], "' AND "
   END IF
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
   IF NOT cl_null(g_argv[01]) THEN 
      LET g_wc = g_wc , " AND imcesite = '",g_argv[01],"'"
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi104.mask_functions" >}
&include "erp/aim/aimi104_mask.4gl"
 
{</section>}
 
{<section id="aimi104.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aimi104_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imce_m.imce141 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aimi104_cl USING g_enterprise, g_site,g_imce_m.imce141
   IF STATUS THEN
      CLOSE aimi104_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi104_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aimi104_master_referesh USING g_site,g_imce_m.imce141 INTO g_imce_m.imce141,g_imce_m.imce142, 
       g_imce_m.imce143,g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148, 
       g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid,g_imce_m.imceowndp,g_imce_m.imcecrtid,g_imce_m.imcecrtdp, 
       g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157, 
       g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce142_desc, 
       g_imce_m.imce143_desc,g_imce_m.imce144_desc,g_imce_m.imceownid_desc,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp_desc,g_imce_m.imcemodid_desc,g_imce_m.imce157_desc,g_imce_m.imce153_desc,g_imce_m.imce176_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aimi104_action_chk() THEN
      CLOSE aimi104_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imce_m.imce141,g_imce_m.oocql004,g_imce_m.oocql005,g_imce_m.imce142,g_imce_m.imce142_desc, 
       g_imce_m.imce143,g_imce_m.imce143_desc,g_imce_m.imce144,g_imce_m.imce144_desc,g_imce_m.imce145, 
       g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid, 
       g_imce_m.imceownid_desc,g_imce_m.imceowndp,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid,g_imce_m.imcecrtid_desc, 
       g_imce_m.imcecrtdp,g_imce_m.imcecrtdp_desc,g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemodid_desc, 
       g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce157_desc,g_imce_m.imce152, 
       g_imce_m.imce153,g_imce_m.imce153_desc,g_imce_m.imce154,g_imce_m.imce155,g_imce_m.imce156,g_imce_m.imce161, 
       g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165,g_imce_m.imce166,g_imce_m.imce171, 
       g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175,g_imce_m.imce176,g_imce_m.imce176_desc 
 
 
   CASE g_imce_m.imcestus
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
         CASE g_imce_m.imcestus
            
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
      g_imce_m.imcestus = lc_state OR cl_null(lc_state) THEN
      CLOSE aimi104_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_imce_m.imcemodid = g_user
   LET g_imce_m.imcemoddt = cl_get_current()
   LET g_imce_m.imcestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imce_t 
      SET (imcestus,imcemodid,imcemoddt) 
        = (g_imce_m.imcestus,g_imce_m.imcemodid,g_imce_m.imcemoddt)     
    WHERE imceent = g_enterprise AND imcesite = g_site AND imce141 = g_imce_m.imce141
 
    
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
      EXECUTE aimi104_master_referesh USING g_site,g_imce_m.imce141 INTO g_imce_m.imce141,g_imce_m.imce142, 
          g_imce_m.imce143,g_imce_m.imce144,g_imce_m.imce145,g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148, 
          g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid,g_imce_m.imceowndp,g_imce_m.imcecrtid, 
          g_imce_m.imcecrtdp,g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemoddt,g_imce_m.imce151, 
          g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce154,g_imce_m.imce155, 
          g_imce_m.imce156,g_imce_m.imce161,g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165, 
          g_imce_m.imce166,g_imce_m.imce171,g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175, 
          g_imce_m.imce176,g_imce_m.imce142_desc,g_imce_m.imce143_desc,g_imce_m.imce144_desc,g_imce_m.imceownid_desc, 
          g_imce_m.imceowndp_desc,g_imce_m.imcecrtid_desc,g_imce_m.imcecrtdp_desc,g_imce_m.imcemodid_desc, 
          g_imce_m.imce157_desc,g_imce_m.imce153_desc,g_imce_m.imce176_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imce_m.imce141,g_imce_m.oocql004,g_imce_m.oocql005,g_imce_m.imce142,g_imce_m.imce142_desc, 
          g_imce_m.imce143,g_imce_m.imce143_desc,g_imce_m.imce144,g_imce_m.imce144_desc,g_imce_m.imce145, 
          g_imce_m.imce146,g_imce_m.imce147,g_imce_m.imce148,g_imce_m.imce149,g_imce_m.imcestus,g_imce_m.imceownid, 
          g_imce_m.imceownid_desc,g_imce_m.imceowndp,g_imce_m.imceowndp_desc,g_imce_m.imcecrtid,g_imce_m.imcecrtid_desc, 
          g_imce_m.imcecrtdp,g_imce_m.imcecrtdp_desc,g_imce_m.imcecrtdt,g_imce_m.imcemodid,g_imce_m.imcemodid_desc, 
          g_imce_m.imcemoddt,g_imce_m.imce151,g_imce_m.imce158,g_imce_m.imce157,g_imce_m.imce157_desc, 
          g_imce_m.imce152,g_imce_m.imce153,g_imce_m.imce153_desc,g_imce_m.imce154,g_imce_m.imce155, 
          g_imce_m.imce156,g_imce_m.imce161,g_imce_m.imce162,g_imce_m.imce163,g_imce_m.imce164,g_imce_m.imce165, 
          g_imce_m.imce166,g_imce_m.imce171,g_imce_m.imce172,g_imce_m.imce173,g_imce_m.imce174,g_imce_m.imce175, 
          g_imce_m.imce176,g_imce_m.imce176_desc
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aimi104_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi104_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi104.signature" >}
   
 
{</section>}
 
{<section id="aimi104.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimi104_set_pk_array()
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
   LET g_pk_array[1].values = g_imce_m.imce141
   LET g_pk_array[1].column = 'imce141'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi104.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimi104.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimi104_msgcentre_notify(lc_state)
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
   CALL aimi104_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imce_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi104.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimi104_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi104.other_function" readonly="Y" >}
# 單位有效性檢查
PRIVATE FUNCTION aimi104_chk_imce143_imce144(p_ooca001)
DEFINE p_ooca001  LIKE ooca_t.ooca001

   IF NOT cl_null(g_imce_m.imce143) OR NOT cl_null(g_imce_m.imce144) THEN
      IF NOT ap_chk_isExist(p_ooca001,"SELECT COUNT(*) FROM ooca_t WHERE "||"oocaent = '" ||g_enterprise|| "' AND "||"ooca001 = ?  ",'aim-00004',1) THEN 
         RETURN FALSE
      END IF
      IF NOT ap_chk_isExist(p_ooca001,"SELECT COUNT(*) FROM ooca_t WHERE "||"oocaent = '" ||g_enterprise|| "' AND "||"ooca001 = ? AND oocastus = 'Y' ",'sub-01302','aooi250') THEN #160318-00005#20 mod  #'aim-00005',1) THEN
         RETURN FALSE
      END IF       
   END IF 
   RETURN TRUE
END FUNCTION
# 採購分群檢查
PRIVATE FUNCTION aimi104_chk_imce141(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1
DEFINE l_count LIKE type_t.num5  #161013-00017#4 add

   IF NOT cl_null(g_imce_m.imce141) THEN 
      IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imce_m.imce141 != g_imce141_t ))) THEN 
         IF NOT ap_chk_notDup(g_imce_m.imce141,"SELECT COUNT(*) FROM imce_t WHERE "||"imceent = '" ||g_enterprise|| "' AND imcesite = '" ||g_site|| "' AND "||"imce141 = '"||g_imce_m.imce141 ||"'",'std-00004',1) THEN 
            LET g_imce_m.imce141 = g_imce_m_t.imce141 
            RETURN FALSE
         END IF
         #dorislai-20150630-modify----(S)
#         IF NOT ap_chk_isExist(g_imce_m.imce141,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '203'  ",'sub-01302','aimi004') THEN 
#            LET g_imce_m.imce141 = g_imce_m_t.imce141
#            RETURN FALSE
#         END IF          
#         IF NOT ap_chk_isExist(g_imce_m.imce141,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq002 = ? AND oocq001 = '203' AND oocqstus = 'Y' ",'sub-01302','aimi004') THEN 
#            LET g_imce_m.imce141 = g_imce_m_t.imce141 
#            RETURN FALSE
#         END IF 
         #161013-00017#4 marked-S
#         IF NOT s_azzi650_chk_exist('203',g_imce_m.imce141) THEN
#            LET g_imce_m.imce141 = g_imce_m_t.imce141 
#            RETURN FALSE
#         END IF
         #161013-00017#4 marked-E
         #dorislai-20150630-modify----(E)     
         #161013-00017#4 add-S
         LET l_count = 1
         SELECT COUNT(1) INTO l_count FROM oocq_t
          WHERE oocqent = g_enterprise AND oocq001 = '203' AND oocq002 = g_imce_m.imce141 
         IF l_count > 0 THEN
            LET l_count = 1
            SELECT COUNT(1) INTO l_count FROM oocq_t
             WHERE oocqent = g_enterprise AND oocq001 = '203' AND oocq002 = g_imce_m.imce141 AND oocqstus = 'Y'
            IF l_count = 0 OR cl_null(l_count) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00295'     
               LET g_errparam.extend = g_imce_m.imce141 
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1]='aimi004'
               CALL cl_err()
               LET g_imce_m.imce141  = g_imce_m_t.imce141
               RETURN FALSE
            END IF
         END IF
         #161013-00017#4 add-E
      END IF
   END IF
   RETURN TRUE
END FUNCTION
# 數量欄位檢查
PRIVATE FUNCTION aimi104_chk_qty(p_qty)
DEFINE p_qty  LIKE type_t.num20_6

   IF NOT cl_null(p_qty) THEN
      IF p_qty < 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aqc-00004'
         LET g_errparam.extend = p_qty
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN FALSE 
      END IF   
   END IF 
   RETURN TRUE
END FUNCTION

 
{</section>}
 
