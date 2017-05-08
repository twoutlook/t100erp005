#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt050.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2015-09-08 16:04:20), PR版次:0012(2017-02-21 10:56:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: abgt050
#+ Description: 預算追加維護
#+ Creator....: 05016(2015-08-07 11:33:07)
#+ Modifier...: 05016 -SD/PR- 06821
 
{</section>}
 
{<section id="abgt050.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#151130-00015#2  2015/12/22 BY Xiaozg  根据是否可以更改單據日期 設定開放單據日期修改
#160127-00033#1  160129     By albireo  b_fill僅看到這次調整內容的變化;利潤中心看有無啟用利潤中心決定是否從部門預設
#160318-00005#5  160321     By Jessy   修正azzi920重複定義之錯誤訊息
#160321-00016#23 160324     By Jessy   修正azzi920重複定義之錯誤訊息(sub)
#160318-00025#49 160426     By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160816-00068#14 2016/08/17 By 08209   調整transaction
#160818-00017#3  2016/08/25 By 07900   删除修改未重新判断状态码
#160920-00019#4  2016/09/20 By 08732   交易對象開窗調整為q_pmaa001_25
#161006-00005#11 2016/10/26 By 08732   組織類型與職能開窗調整
#160822-00012#3  2016/11/02 By 08729   新舊值處理
#161129-00019#4  2017/01/17 By 06821   預算組織權限,不卡 azzi800 有權限, 改call 元件s_abg2_get_budget_site(...)
#170220-00063#1  2017/02/21 By 06821   abgt050填写完表头基本数据页签后，任意点击空白处，程序闪退。（感觉是无法根据预算细项带出表样，即更新表体视图）
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
PRIVATE TYPE type_g_bgbe_m RECORD
       bgbe001 LIKE bgbe_t.bgbe001, 
   bgbe001_desc LIKE type_t.chr80, 
   bgbedocno LIKE bgbe_t.bgbedocno, 
   glaa001 LIKE type_t.chr10, 
   bgbedocdt LIKE bgbe_t.bgbedocdt, 
   bgbe002 LIKE bgbe_t.bgbe002, 
   bgbe003 LIKE bgbe_t.bgbe003, 
   bgbe003_desc LIKE type_t.chr80, 
   bgbe004 LIKE bgbe_t.bgbe004, 
   bgbe004_desc LIKE type_t.chr80, 
   bgbe005 LIKE bgbe_t.bgbe005, 
   bgbestus LIKE bgbe_t.bgbestus, 
   bgbe006 LIKE bgbe_t.bgbe006, 
   bgbe010 LIKE bgbe_t.bgbe010, 
   bgbe010_desc LIKE type_t.chr80, 
   bgbe018 LIKE bgbe_t.bgbe018, 
   bgbe018_desc LIKE type_t.chr80, 
   bgbe020 LIKE bgbe_t.bgbe020, 
   bgbe020_desc LIKE type_t.chr80, 
   bgbe025 LIKE bgbe_t.bgbe025, 
   bgbe025_desc LIKE type_t.chr80, 
   bgbe031 LIKE bgbe_t.bgbe031, 
   bgbe011 LIKE bgbe_t.bgbe011, 
   bgbe011_desc LIKE type_t.chr80, 
   bgbe019 LIKE bgbe_t.bgbe019, 
   bgbe019_desc LIKE type_t.chr80, 
   bgbe021 LIKE bgbe_t.bgbe021, 
   bgbe021_desc LIKE type_t.chr80, 
   bgbe026 LIKE bgbe_t.bgbe026, 
   bgbe026_desc LIKE type_t.chr80, 
   bgbe007 LIKE bgbe_t.bgbe007, 
   bgbe007_desc LIKE type_t.chr80, 
   bgbe012 LIKE bgbe_t.bgbe012, 
   bgbe012_desc LIKE type_t.chr80, 
   bgbe014 LIKE bgbe_t.bgbe014, 
   bgbe014_desc LIKE type_t.chr80, 
   bgbe022 LIKE bgbe_t.bgbe022, 
   bgbe022_desc LIKE type_t.chr80, 
   bgbe027 LIKE bgbe_t.bgbe027, 
   bgbe027_desc LIKE type_t.chr80, 
   bgbe008 LIKE bgbe_t.bgbe008, 
   bgbe008_desc LIKE type_t.chr80, 
   bgbe013 LIKE bgbe_t.bgbe013, 
   bgbe013_desc LIKE type_t.chr80, 
   bgbe015 LIKE bgbe_t.bgbe015, 
   bgbe015_desc LIKE type_t.chr80, 
   bgbe023 LIKE bgbe_t.bgbe023, 
   bgbe023_desc LIKE type_t.chr80, 
   bgbe028 LIKE bgbe_t.bgbe028, 
   bgbe028_desc LIKE type_t.chr80, 
   bgbe009 LIKE bgbe_t.bgbe009, 
   bgbe009_desc LIKE type_t.chr80, 
   bgbe017 LIKE bgbe_t.bgbe017, 
   bgbe016 LIKE bgbe_t.bgbe016, 
   bgbe016_desc LIKE type_t.chr80, 
   bgbe024 LIKE bgbe_t.bgbe024, 
   bgbe024_desc LIKE type_t.chr80, 
   bgbe029 LIKE bgbe_t.bgbe029, 
   bgbe029_desc LIKE type_t.chr80, 
   bgbe030 LIKE bgbe_t.bgbe030, 
   bgbeownid LIKE bgbe_t.bgbeownid, 
   bgbeownid_desc LIKE type_t.chr80, 
   bgbeowndp LIKE bgbe_t.bgbeowndp, 
   bgbeowndp_desc LIKE type_t.chr80, 
   bgbecrtid LIKE bgbe_t.bgbecrtid, 
   bgbecrtid_desc LIKE type_t.chr80, 
   bgbecrtdp LIKE bgbe_t.bgbecrtdp, 
   bgbecrtdp_desc LIKE type_t.chr80, 
   bgbecrtdt LIKE bgbe_t.bgbecrtdt, 
   bgbemodid LIKE bgbe_t.bgbemodid, 
   bgbemodid_desc LIKE type_t.chr80, 
   bgbemoddt LIKE bgbe_t.bgbemoddt, 
   bgbecnfid LIKE bgbe_t.bgbecnfid, 
   bgbecnfid_desc LIKE type_t.chr80, 
   bgbecnfdt LIKE bgbe_t.bgbecnfdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_bgbedocno LIKE bgbe_t.bgbedocno
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bgaa008             LIKE bgaa_t.bgaa008 #預算項目參照表 
DEFINE g_bgaa012             LIKE bgaa_t.bgaa012 #是否使用科目預算 
DEFINE g_glaald              LIKE glaa_t.glaald

DEFINE g_bgbd  DYNAMIC ARRAY OF RECORD
           bgbd003        LIKE bgbd_t.bgbd003, #組織
           bgbd003_desc   LIKE type_t.chr100,
           curr           LIKE type_t.chr100,
           bgbd011        LIKE bgbd_t.bgbd011, 
           bgbd034        LIKE bgbd_t.bgbd034,
           bgbd035        LIKE bgbd_t.bgbd035,
           usemoney       LIKE bgbd_t.bgbd039,
           budget         LIKE bgbd_t.bgbd034
           END RECORD

DEFINE g_glaa                RECORD
           glaacomp  LIKE glaa_t.glaacomp,
           glaa004   LIKE glaa_t.glaa004,
           glaa015   LIKE glaa_t.glaa015,
           glaa019   LIKE glaa_t.glaa019,
           glaa024   LIKE glaa_t.glaa024,
           glaa102   LIKE glaa_t.glaa102,
           glaa121   LIKE glaa_t.glaa121,
           glaa001   LIKE glaa_t.glaa001,
           glaa016   LIKE glaa_t.glaa016,
           glaa020   LIKE glaa_t.glaa020
                             END RECORD
                             
DEFINE g_glad                RECORD
           glad0171          LIKE  glad_t.glad0171,
           glad0172          LIKE  glad_t.glad0172,
           glad0181          LIKE  glad_t.glad0181,
           glad0182          LIKE  glad_t.glad0182,
           glad0191          LIKE  glad_t.glad0191,
           glad0192          LIKE  glad_t.glad0192,
           glad0201          LIKE  glad_t.glad0201,
           glad0202          LIKE  glad_t.glad0202,
           glad0211          LIKE  glad_t.glad0211,
           glad0212          LIKE  glad_t.glad0212,
           glad0221          LIKE  glad_t.glad0221,
           glad0222          LIKE  glad_t.glad0222,
           glad0231          LIKE  glad_t.glad0231,
           glad0232          LIKE  glad_t.glad0232,
           glad0241          LIKE  glad_t.glad0241,
           glad0242          LIKE  glad_t.glad0242,
           glad0251          LIKE  glad_t.glad0251,
           glad0252          LIKE  glad_t.glad0252,
           glad0261          LIKE  glad_t.glad0261,
           glad0262          LIKE  glad_t.glad0262
                             END RECORD
                                                        
DEFINE g_glac002             LIKE glac_t.glac002    #項目對應會科  
#DEFINE g_userorga            STRING   #161006-00005#11   add #161129-00019#4 mark
DEFINE g_ooef001_str         STRING    #161129-00019#4 add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_bgbe_m        type_g_bgbe_m  #單頭變數宣告
DEFINE g_bgbe_m_t      type_g_bgbe_m  #單頭舊值宣告(系統還原用)
DEFINE g_bgbe_m_o      type_g_bgbe_m  #單頭舊值宣告(其他用途)
DEFINE g_bgbe_m_mask_o type_g_bgbe_m  #轉換遮罩前資料
DEFINE g_bgbe_m_mask_n type_g_bgbe_m  #轉換遮罩後資料
 
   DEFINE g_bgbedocno_t LIKE bgbe_t.bgbedocno
 
   
 
   
 
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
 
{<section id="abgt050.main" >}
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
   LET g_forupd_sql = " SELECT bgbe001,'',bgbedocno,'',bgbedocdt,bgbe002,bgbe003,'',bgbe004,'',bgbe005, 
       bgbestus,bgbe006,bgbe010,'',bgbe018,'',bgbe020,'',bgbe025,'',bgbe031,bgbe011,'',bgbe019,'',bgbe021, 
       '',bgbe026,'',bgbe007,'',bgbe012,'',bgbe014,'',bgbe022,'',bgbe027,'',bgbe008,'',bgbe013,'',bgbe015, 
       '',bgbe023,'',bgbe028,'',bgbe009,'',bgbe017,bgbe016,'',bgbe024,'',bgbe029,'',bgbe030,bgbeownid, 
       '',bgbeowndp,'',bgbecrtid,'',bgbecrtdp,'',bgbecrtdt,bgbemodid,'',bgbemoddt,bgbecnfid,'',bgbecnfdt", 
        
                      " FROM bgbe_t",
                      " WHERE bgbeent= ? AND bgbedocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt050_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgbe001,t0.bgbedocno,t0.bgbedocdt,t0.bgbe002,t0.bgbe003,t0.bgbe004, 
       t0.bgbe005,t0.bgbestus,t0.bgbe006,t0.bgbe010,t0.bgbe018,t0.bgbe020,t0.bgbe025,t0.bgbe031,t0.bgbe011, 
       t0.bgbe019,t0.bgbe021,t0.bgbe026,t0.bgbe007,t0.bgbe012,t0.bgbe014,t0.bgbe022,t0.bgbe027,t0.bgbe008, 
       t0.bgbe013,t0.bgbe015,t0.bgbe023,t0.bgbe028,t0.bgbe009,t0.bgbe017,t0.bgbe016,t0.bgbe024,t0.bgbe029, 
       t0.bgbe030,t0.bgbeownid,t0.bgbeowndp,t0.bgbecrtid,t0.bgbecrtdp,t0.bgbecrtdt,t0.bgbemodid,t0.bgbemoddt, 
       t0.bgbecnfid,t0.bgbecnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011", 
 
               " FROM bgbe_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bgbeownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bgbeowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.bgbecrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bgbecrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.bgbemodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.bgbecnfid  ",
 
               " WHERE t0.bgbeent = " ||g_enterprise|| " AND t0.bgbedocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgt050_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt050 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt050_init()   
 
      #進入選單 Menu (="N")
      CALL abgt050_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt050
      
   END IF 
   
   CLOSE abgt050_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt050.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt050_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('bgbestus','13','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('bgbe017','6013') #經營方式
   CALL s_fin_create_account_center_tmp() 
   #161006-00005#11  add ---s
   CALL s_fin_create_account_center_tmp()
   #161129-00019#4 --s mark
   #CALL s_fin_azzi800_sons_query(g_today)
   #CALL s_fin_account_center_sons_str() RETURNING g_userorga
   #CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   #161129-00019#4 --e mark
   #161006-00005#11  add ---e
   #161129-00019#4 --s add
   #檢查預算組織是否在abgi090中可操作的組織中
   CALL s_abg2_get_budget_site('','',g_user,'11') RETURNING g_ooef001_str
   CALL s_fin_get_wc_str(g_ooef001_str) RETURNING g_ooef001_str
   #161129-00019#4 --e add   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL abgt050_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgt050_ui_dialog() 
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
            CALL abgt050_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET g_main_hidden = 1
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bgbe_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL abgt050_init()
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
               CALL abgt050_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL abgt050_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL abgt050_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL abgt050_set_act_visible()
               CALL abgt050_set_act_no_visible()
               IF NOT (g_bgbe_m.bgbedocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " bgbeent = " ||g_enterprise|| " AND",
                                     " bgbedocno = '", g_bgbe_m.bgbedocno, "' "
 
                  #填到對應位置
                  CALL abgt050_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL abgt050_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL abgt050_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL abgt050_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL abgt050_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL abgt050_fetch("L")  
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
                  CALL abgt050_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL abgt050_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abgt050_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt050_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt050_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt050_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgt050_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt050_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt050_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt050_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt050_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_bgbe_m.bgbedocdt)
 
 
 
            
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
                  CALL abgt050_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            DISPLAY ARRAY g_bgbd TO s_detail1.* ATTRIBUTES(COUNT = g_rec_b)
               BEFORE DISPLAY

            END DISPLAY
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL abgt050_browser_fill(g_wc,"")
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
                  CALL abgt050_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL abgt050_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL abgt050_set_act_visible()
               CALL abgt050_set_act_no_visible()
               IF NOT (g_bgbe_m.bgbedocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " bgbeent = " ||g_enterprise|| " AND",
                                     " bgbedocno = '", g_bgbe_m.bgbedocno, "' "
 
                  #填到對應位置
                  CALL abgt050_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abgt050_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL abgt050_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL abgt050_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL abgt050_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL abgt050_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL abgt050_fetch("L")  
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
                  CALL abgt050_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL abgt050_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abgt050_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt050_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt050_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt050_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgt050_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt050_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt050_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt050_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt050_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_bgbe_m.bgbedocdt)
 
 
 
 
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
 
{<section id="abgt050.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION abgt050_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "bgbedocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM bgbe_t ",
               "  ",
               "  ",
               " WHERE bgbeent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("bgbe_t")
                
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
      INITIALIZE g_bgbe_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.bgbestus,t0.bgbedocno",
               " FROM bgbe_t t0 ",
               "  ",
               
               " WHERE t0.bgbeent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("bgbe_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgbe_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bgbedocno
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
         CALL abgt050_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_bgbedocno) THEN
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
 
{<section id="abgt050.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt050_construct()
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
   INITIALIZE g_bgbe_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON bgbe001,bgbedocno,glaa001,bgbedocdt,bgbe002,bgbe003,bgbe004,bgbe005, 
          bgbestus,bgbe006,bgbe010,bgbe018,bgbe031,bgbe011,bgbe019,bgbe007,bgbe012,bgbe014,bgbe008,bgbe013, 
          bgbe015,bgbe009,bgbe017,bgbe016,bgbe030,bgbeownid,bgbeowndp,bgbecrtid,bgbecrtdp,bgbecrtdt, 
          bgbemodid,bgbemoddt,bgbecnfid,bgbecnfdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
           
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgbecrtdt>>----
         AFTER FIELD bgbecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgbemoddt>>----
         AFTER FIELD bgbemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgbecnfdt>>----
         AFTER FIELD bgbecnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgbepstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe001
            #add-point:BEFORE FIELD bgbe001 name="construct.b.bgbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe001
            
            #add-point:AFTER FIELD bgbe001 name="construct.a.bgbe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe001
            #add-point:ON ACTION controlp INFIELD bgbe001 name="construct.c.bgbe001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()
            DISPLAY g_qryparam.return1 TO bgbe001
            NEXT FIELD bgbe001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbedocno
            #add-point:BEFORE FIELD bgbedocno name="construct.b.bgbedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbedocno
            
            #add-point:AFTER FIELD bgbedocno name="construct.a.bgbedocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbedocno
            #add-point:ON ACTION controlp INFIELD bgbedocno name="construct.c.bgbedocno"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgbedocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbedocno  #顯示到畫面上
            NEXT FIELD bgbedocno  
            #END add-point
 
 
         #Ctrlp:construct.c.glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="construct.c.glaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa001  #顯示到畫面上
            NEXT FIELD glaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="construct.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="construct.a.glaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbedocdt
            #add-point:BEFORE FIELD bgbedocdt name="construct.b.bgbedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbedocdt
            
            #add-point:AFTER FIELD bgbedocdt name="construct.a.bgbedocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbedocdt
            #add-point:ON ACTION controlp INFIELD bgbedocdt name="construct.c.bgbedocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe002
            #add-point:BEFORE FIELD bgbe002 name="construct.b.bgbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe002
            
            #add-point:AFTER FIELD bgbe002 name="construct.a.bgbe002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe002
            #add-point:ON ACTION controlp INFIELD bgbe002 name="construct.c.bgbe002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe003
            #add-point:BEFORE FIELD bgbe003 name="construct.b.bgbe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe003
            
            #add-point:AFTER FIELD bgbe003 name="construct.a.bgbe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe003
            #add-point:ON ACTION controlp INFIELD bgbe003 name="construct.c.bgbe003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef001 IN ", g_userorga #161006-00005#11   add #161129-00019#4 mark
            LET g_qryparam.where = " ooef001 IN ", g_ooef001_str #161129-00019#4 add
            #CALL q_ooef001()     #161006-00005#11   mark
            CALL q_ooef001_77()   #161006-00005#11   add
            DISPLAY g_qryparam.return1 TO bgbe003
            NEXT FIELD bgbe003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe004
            #add-point:BEFORE FIELD bgbe004 name="construct.b.bgbe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe004
            
            #add-point:AFTER FIELD bgbe004 name="construct.a.bgbe004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe004
            #add-point:ON ACTION controlp INFIELD bgbe004 name="construct.c.bgbe004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgae001()
            DISPLAY g_qryparam.return1 TO bgbe004
            NEXT FIELD bgbe004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe005
            #add-point:BEFORE FIELD bgbe005 name="construct.b.bgbe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe005
            
            #add-point:AFTER FIELD bgbe005 name="construct.a.bgbe005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe005
            #add-point:ON ACTION controlp INFIELD bgbe005 name="construct.c.bgbe005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbestus
            #add-point:BEFORE FIELD bgbestus name="construct.b.bgbestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbestus
            
            #add-point:AFTER FIELD bgbestus name="construct.a.bgbestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbestus
            #add-point:ON ACTION controlp INFIELD bgbestus name="construct.c.bgbestus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe006
            #add-point:BEFORE FIELD bgbe006 name="construct.b.bgbe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe006
            
            #add-point:AFTER FIELD bgbe006 name="construct.a.bgbe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe006
            #add-point:ON ACTION controlp INFIELD bgbe006 name="construct.c.bgbe006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgbd004()
            DISPLAY g_qryparam.return1 TO bgbe006
            NEXT FIELD bgbe006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe010
            #add-point:BEFORE FIELD bgbe010 name="construct.b.bgbe010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe010
            
            #add-point:AFTER FIELD bgbe010 name="construct.a.bgbe010"
            #交易客商
            IF NOT cl_null(g_bgbe_m.bgbe010) THEN
               IF ( g_bgbe_m.bgbe010 != g_bgbe_m_t.bgbe010 OR g_bgbe_m_t.bgbe010 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_bgbe_m.bgbe010
                     LET g_chkparam.arg2 = ' '
                     LET g_errshow = TRUE   #160318-00025#49
                     LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49 
                     IF NOT cl_chk_exist("v_pmaa001_7") THEN
                        LET g_bgbe_m.bgbe010 = g_bgbe_m_t.bgbe010
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe010_desc = s_desc_get_trading_partner_abbr_desc(g_bgbe_m.bgbe010)
            DISPLAY BY NAME g_bgbe_m.bgbe010,g_bgbe_m.bgbe010_desc
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe010
            #add-point:ON ACTION controlp INFIELD bgbe010 name="construct.c.bgbe010"
            #交易客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()    #160920-00019#4--mark
            CALL q_pmaa001_25()  #160920-00019#4--add
            DISPLAY g_qryparam.return1 TO bgbe010
            NEXT FIELD bgbe010
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe018
            #add-point:BEFORE FIELD bgbe018 name="construct.b.bgbe018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe018
            
            #add-point:AFTER FIELD bgbe018 name="construct.a.bgbe018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe018
            #add-point:ON ACTION controlp INFIELD bgbe018 name="construct.c.bgbe018"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO bgbe018
            NEXT FIELD bgbe018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe031
            #add-point:BEFORE FIELD bgbe031 name="construct.b.bgbe031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe031
            
            #add-point:AFTER FIELD bgbe031 name="construct.a.bgbe031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe031
            #add-point:ON ACTION controlp INFIELD bgbe031 name="construct.c.bgbe031"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgbd004()
            DISPLAY g_qryparam.return2 TO bgbe031
            NEXT FIELD bgbe031
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe011
            #add-point:BEFORE FIELD bgbe011 name="construct.b.bgbe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe011
            
            #add-point:AFTER FIELD bgbe011 name="construct.a.bgbe011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe011
            #add-point:ON ACTION controlp INFIELD bgbe011 name="construct.c.bgbe011"
             #收款客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO bgbe011
            NEXT FIELD bgbe011
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe019
            #add-point:BEFORE FIELD bgbe019 name="construct.b.bgbe019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe019
            
            #add-point:AFTER FIELD bgbe019 name="construct.a.bgbe019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe019
            #add-point:ON ACTION controlp INFIELD bgbe019 name="construct.c.bgbe019"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO bgbe019
            NEXT FIELD bgbe019
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe007
            #add-point:BEFORE FIELD bgbe007 name="construct.b.bgbe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe007
            
            #add-point:AFTER FIELD bgbe007 name="construct.a.bgbe007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe007
            #add-point:ON ACTION controlp INFIELD bgbe007 name="construct.c.bgbe007"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbe007
            NEXT FIELD bgbe007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe012
            #add-point:BEFORE FIELD bgbe012 name="construct.b.bgbe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe012
            
            #add-point:AFTER FIELD bgbe012 name="construct.a.bgbe012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe012
            #add-point:ON ACTION controlp INFIELD bgbe012 name="construct.c.bgbe012"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO bgbe012
            NEXT FIELD bgbe012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe014
            #add-point:BEFORE FIELD bgbe014 name="construct.b.bgbe014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe014
            
            #add-point:AFTER FIELD bgbe014 name="construct.a.bgbe014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe014
            #add-point:ON ACTION controlp INFIELD bgbe014 name="construct.c.bgbe014"
             #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO bgbe014
            NEXT FIELD bgbe014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe008
            #add-point:BEFORE FIELD bgbe008 name="construct.b.bgbe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe008
            
            #add-point:AFTER FIELD bgbe008 name="construct.a.bgbe008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe008
            #add-point:ON ACTION controlp INFIELD bgbe008 name="construct.c.bgbe008"
            #成本利潤中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbe008
            NEXT FIELD bgbe008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe013
            #add-point:BEFORE FIELD bgbe013 name="construct.b.bgbe013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe013
            
            #add-point:AFTER FIELD bgbe013 name="construct.a.bgbe013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe013
            #add-point:ON ACTION controlp INFIELD bgbe013 name="construct.c.bgbe013"
             #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO bgbe013
            NEXT FIELD bgbe013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe015
            #add-point:BEFORE FIELD bgbe015 name="construct.b.bgbe015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe015
            
            #add-point:AFTER FIELD bgbe015 name="construct.a.bgbe015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe015
            #add-point:ON ACTION controlp INFIELD bgbe015 name="construct.c.bgbe015"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO bgbe015
            NEXT FIELD bgbe015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe009
            #add-point:BEFORE FIELD bgbe009 name="construct.b.bgbe009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe009
            
            #add-point:AFTER FIELD bgbe009 name="construct.a.bgbe009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe009
            #add-point:ON ACTION controlp INFIELD bgbe009 name="construct.c.bgbe009"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO bgbe009
            NEXT FIELD bgbe009
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe017
            #add-point:BEFORE FIELD bgbe017 name="construct.b.bgbe017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe017
            
            #add-point:AFTER FIELD bgbe017 name="construct.a.bgbe017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe017
            #add-point:ON ACTION controlp INFIELD bgbe017 name="construct.c.bgbe017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe016
            #add-point:BEFORE FIELD bgbe016 name="construct.b.bgbe016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe016
            
            #add-point:AFTER FIELD bgbe016 name="construct.a.bgbe016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe016
            #add-point:ON ACTION controlp INFIELD bgbe016 name="construct.c.bgbe016"
             #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO bgbe016
            NEXT FIELD bgbe016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe030
            #add-point:BEFORE FIELD bgbe030 name="construct.b.bgbe030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe030
            
            #add-point:AFTER FIELD bgbe030 name="construct.a.bgbe030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbe030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe030
            #add-point:ON ACTION controlp INFIELD bgbe030 name="construct.c.bgbe030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgbeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbeownid
            #add-point:ON ACTION controlp INFIELD bgbeownid name="construct.c.bgbeownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbeownid  #顯示到畫面上
            NEXT FIELD bgbeownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbeownid
            #add-point:BEFORE FIELD bgbeownid name="construct.b.bgbeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbeownid
            
            #add-point:AFTER FIELD bgbeownid name="construct.a.bgbeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbeowndp
            #add-point:ON ACTION controlp INFIELD bgbeowndp name="construct.c.bgbeowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbeowndp  #顯示到畫面上
            NEXT FIELD bgbeowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbeowndp
            #add-point:BEFORE FIELD bgbeowndp name="construct.b.bgbeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbeowndp
            
            #add-point:AFTER FIELD bgbeowndp name="construct.a.bgbeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbecrtid
            #add-point:ON ACTION controlp INFIELD bgbecrtid name="construct.c.bgbecrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbecrtid  #顯示到畫面上
            NEXT FIELD bgbecrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbecrtid
            #add-point:BEFORE FIELD bgbecrtid name="construct.b.bgbecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbecrtid
            
            #add-point:AFTER FIELD bgbecrtid name="construct.a.bgbecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbecrtdp
            #add-point:ON ACTION controlp INFIELD bgbecrtdp name="construct.c.bgbecrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbecrtdp  #顯示到畫面上
            NEXT FIELD bgbecrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbecrtdp
            #add-point:BEFORE FIELD bgbecrtdp name="construct.b.bgbecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbecrtdp
            
            #add-point:AFTER FIELD bgbecrtdp name="construct.a.bgbecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbecrtdt
            #add-point:BEFORE FIELD bgbecrtdt name="construct.b.bgbecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgbemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbemodid
            #add-point:ON ACTION controlp INFIELD bgbemodid name="construct.c.bgbemodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbemodid  #顯示到畫面上
            NEXT FIELD bgbemodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbemodid
            #add-point:BEFORE FIELD bgbemodid name="construct.b.bgbemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbemodid
            
            #add-point:AFTER FIELD bgbemodid name="construct.a.bgbemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbemoddt
            #add-point:BEFORE FIELD bgbemoddt name="construct.b.bgbemoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgbecnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbecnfid
            #add-point:ON ACTION controlp INFIELD bgbecnfid name="construct.c.bgbecnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbecnfid  #顯示到畫面上
            NEXT FIELD bgbecnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbecnfid
            #add-point:BEFORE FIELD bgbecnfid name="construct.b.bgbecnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbecnfid
            
            #add-point:AFTER FIELD bgbecnfid name="construct.a.bgbecnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbecnfdt
            #add-point:BEFORE FIELD bgbecnfdt name="construct.b.bgbecnfdt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         #161129-00019#4 --s add
         #檢查預算組織是否在abgi090中可操作的組織中
         CALL s_abg2_get_budget_site('','',g_user,'11') RETURNING g_ooef001_str
         CALL s_fin_get_wc_str(g_ooef001_str) RETURNING g_ooef001_str
         #161129-00019#4 --e add
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
 
{<section id="abgt050.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgt050_filter()
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
      CONSTRUCT g_wc_filter ON bgbedocno
                          FROM s_browse[1].b_bgbedocno
 
         BEFORE CONSTRUCT
               DISPLAY abgt050_filter_parser('bgbedocno') TO s_browse[1].b_bgbedocno
      
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
 
      CALL abgt050_filter_show('bgbedocno')
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgt050_filter_parser(ps_field)
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
 
{<section id="abgt050.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgt050_filter_show(ps_field)
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
   LET ls_condition = abgt050_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt050_query()
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
 
   INITIALIZE g_bgbe_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL abgt050_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt050_browser_fill(g_wc,"F")
      CALL abgt050_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL abgt050_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL abgt050_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgt050.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt050_fetch(p_fl)
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
   LET g_bgbe_m.bgbedocno = g_browser[g_current_idx].b_bgbedocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE abgt050_master_referesh USING g_bgbe_m.bgbedocno INTO g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno, 
       g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus, 
       g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031, 
       g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007,g_bgbe_m.bgbe012, 
       g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027,g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe028,g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe029,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtdp, 
       g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfdt, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid_desc,g_bgbe_m.bgbecrtdp_desc, 
       g_bgbe_m.bgbemodid_desc,g_bgbe_m.bgbecnfid_desc
   
   #遮罩相關處理
   LET g_bgbe_m_mask_o.* =  g_bgbe_m.*
   CALL abgt050_bgbe_t_mask()
   LET g_bgbe_m_mask_n.* =  g_bgbe_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL abgt050_set_act_visible()
   CALL abgt050_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_bgbe_m_t.* = g_bgbe_m.*
   LET g_bgbe_m_o.* = g_bgbe_m.*
   
   LET g_data_owner = g_bgbe_m.bgbeownid      
   LET g_data_dept  = g_bgbe_m.bgbeowndp
   
   #重新顯示
   CALL abgt050_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt050_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_bgbe_m.* TO NULL             #DEFAULT 設定
   LET g_bgbedocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgbe_m.bgbeownid = g_user
      LET g_bgbe_m.bgbeowndp = g_dept
      LET g_bgbe_m.bgbecrtid = g_user
      LET g_bgbe_m.bgbecrtdp = g_dept 
      LET g_bgbe_m.bgbecrtdt = cl_get_current()
      LET g_bgbe_m.bgbemodid = g_user
      LET g_bgbe_m.bgbemoddt = cl_get_current()
      LET g_bgbe_m.bgbestus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_bgbe_m.bgbe031 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_bgbe_m.bgbedocdt = g_today
      DISPLAY BY NAME g_bgbe_m.bgbedocdt
      CALL abgt050_bgbe_entry()
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bgbe_m.bgbestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL abgt050_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_bgbe_m.* TO NULL
         CALL abgt050_show()
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
   CALL abgt050_set_act_visible()
   CALL abgt050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgbedocno_t = g_bgbe_m.bgbedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgbeent = " ||g_enterprise|| " AND",
                      " bgbedocno = '", g_bgbe_m.bgbedocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt050_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt050_master_referesh USING g_bgbe_m.bgbedocno INTO g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno, 
       g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus, 
       g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031, 
       g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007,g_bgbe_m.bgbe012, 
       g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027,g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe028,g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe029,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtdp, 
       g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfdt, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid_desc,g_bgbe_m.bgbecrtdp_desc, 
       g_bgbe_m.bgbemodid_desc,g_bgbe_m.bgbecnfid_desc
   
   
   #遮罩相關處理
   LET g_bgbe_m_mask_o.* =  g_bgbe_m.*
   CALL abgt050_bgbe_t_mask()
   LET g_bgbe_m_mask_n.* =  g_bgbe_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgbe_m.bgbe001,g_bgbe_m.bgbe001_desc,g_bgbe_m.bgbedocno,g_bgbe_m.glaa001,g_bgbe_m.bgbedocdt, 
       g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc, 
       g_bgbe_m.bgbe005,g_bgbe_m.bgbestus,g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe010_desc,g_bgbe_m.bgbe018, 
       g_bgbe_m.bgbe018_desc,g_bgbe_m.bgbe020,g_bgbe_m.bgbe020_desc,g_bgbe_m.bgbe025,g_bgbe_m.bgbe025_desc, 
       g_bgbe_m.bgbe031,g_bgbe_m.bgbe011,g_bgbe_m.bgbe011_desc,g_bgbe_m.bgbe019,g_bgbe_m.bgbe019_desc, 
       g_bgbe_m.bgbe021,g_bgbe_m.bgbe021_desc,g_bgbe_m.bgbe026,g_bgbe_m.bgbe026_desc,g_bgbe_m.bgbe007, 
       g_bgbe_m.bgbe007_desc,g_bgbe_m.bgbe012,g_bgbe_m.bgbe012_desc,g_bgbe_m.bgbe014,g_bgbe_m.bgbe014_desc, 
       g_bgbe_m.bgbe022,g_bgbe_m.bgbe022_desc,g_bgbe_m.bgbe027,g_bgbe_m.bgbe027_desc,g_bgbe_m.bgbe008, 
       g_bgbe_m.bgbe008_desc,g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc,g_bgbe_m.bgbe015,g_bgbe_m.bgbe015_desc, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe023_desc,g_bgbe_m.bgbe028,g_bgbe_m.bgbe028_desc,g_bgbe_m.bgbe009, 
       g_bgbe_m.bgbe009_desc,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe024_desc,g_bgbe_m.bgbe029,g_bgbe_m.bgbe029_desc,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtid_desc, 
       g_bgbe_m.bgbecrtdp,g_bgbe_m.bgbecrtdp_desc,g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemodid_desc, 
       g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfid_desc,g_bgbe_m.bgbecnfdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_bgbe_m.bgbeownid      
   LET g_data_dept  = g_bgbe_m.bgbeowndp
 
   #功能已完成,通報訊息中心
   CALL abgt050_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt050.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt050_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_bgbe_m.bgbedocno IS NULL
 
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
   LET g_bgbedocno_t = g_bgbe_m.bgbedocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN abgt050_cl USING g_enterprise,g_bgbe_m.bgbedocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt050_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE abgt050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt050_master_referesh USING g_bgbe_m.bgbedocno INTO g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno, 
       g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus, 
       g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031, 
       g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007,g_bgbe_m.bgbe012, 
       g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027,g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe028,g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe029,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtdp, 
       g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfdt, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid_desc,g_bgbe_m.bgbecrtdp_desc, 
       g_bgbe_m.bgbemodid_desc,g_bgbe_m.bgbecnfid_desc
 
   #檢查是否允許此動作
   IF NOT abgt050_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bgbe_m_mask_o.* =  g_bgbe_m.*
   CALL abgt050_bgbe_t_mask()
   LET g_bgbe_m_mask_n.* =  g_bgbe_m.*
   
   
 
   #顯示資料
   CALL abgt050_show()
   
   WHILE TRUE
      LET g_bgbe_m.bgbedocno = g_bgbedocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_bgbe_m.bgbemodid = g_user 
LET g_bgbe_m.bgbemoddt = cl_get_current()
LET g_bgbe_m.bgbemodid_desc = cl_get_username(g_bgbe_m.bgbemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL abgt050_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgbe_m.* = g_bgbe_m_t.*
         CALL abgt050_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE bgbe_t SET (bgbemodid,bgbemoddt) = (g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt)
       WHERE bgbeent = g_enterprise AND bgbedocno = g_bgbedocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL abgt050_set_act_visible()
   CALL abgt050_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgbeent = " ||g_enterprise|| " AND",
                      " bgbedocno = '", g_bgbe_m.bgbedocno, "' "
 
   #填到對應位置
   CALL abgt050_browser_fill(g_wc,"")
 
   CLOSE abgt050_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt050_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="abgt050.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt050_input(p_cmd)
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
   DEFINE l_glae009              LIKE glae_t.glae009
   DEFINE l_wc           STRING
   
   #160127-00033-----s
   DEFINE l_bgae016      LIKE bgae_t.bgae016
   #160127-00033-----e
   
   DEFINE l_exeprog      LIKE type_t.chr80   #160321-00016#23 add
   DEFINE l_orga         STRING              #161006-00005#11 add
   DEFINE l_site_str     STRING              #161129-00019#4 add
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
   DISPLAY BY NAME g_bgbe_m.bgbe001,g_bgbe_m.bgbe001_desc,g_bgbe_m.bgbedocno,g_bgbe_m.glaa001,g_bgbe_m.bgbedocdt, 
       g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc, 
       g_bgbe_m.bgbe005,g_bgbe_m.bgbestus,g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe010_desc,g_bgbe_m.bgbe018, 
       g_bgbe_m.bgbe018_desc,g_bgbe_m.bgbe020,g_bgbe_m.bgbe020_desc,g_bgbe_m.bgbe025,g_bgbe_m.bgbe025_desc, 
       g_bgbe_m.bgbe031,g_bgbe_m.bgbe011,g_bgbe_m.bgbe011_desc,g_bgbe_m.bgbe019,g_bgbe_m.bgbe019_desc, 
       g_bgbe_m.bgbe021,g_bgbe_m.bgbe021_desc,g_bgbe_m.bgbe026,g_bgbe_m.bgbe026_desc,g_bgbe_m.bgbe007, 
       g_bgbe_m.bgbe007_desc,g_bgbe_m.bgbe012,g_bgbe_m.bgbe012_desc,g_bgbe_m.bgbe014,g_bgbe_m.bgbe014_desc, 
       g_bgbe_m.bgbe022,g_bgbe_m.bgbe022_desc,g_bgbe_m.bgbe027,g_bgbe_m.bgbe027_desc,g_bgbe_m.bgbe008, 
       g_bgbe_m.bgbe008_desc,g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc,g_bgbe_m.bgbe015,g_bgbe_m.bgbe015_desc, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe023_desc,g_bgbe_m.bgbe028,g_bgbe_m.bgbe028_desc,g_bgbe_m.bgbe009, 
       g_bgbe_m.bgbe009_desc,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe024_desc,g_bgbe_m.bgbe029,g_bgbe_m.bgbe029_desc,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtid_desc, 
       g_bgbe_m.bgbecrtdp,g_bgbe_m.bgbecrtdp_desc,g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemodid_desc, 
       g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfid_desc,g_bgbe_m.bgbecnfdt
   
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
   CALL abgt050_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt050_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
  
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno,g_bgbe_m.glaa001,g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002, 
          g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus,g_bgbe_m.bgbe006,g_bgbe_m.bgbe010, 
          g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031,g_bgbe_m.bgbe011,g_bgbe_m.bgbe019, 
          g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007,g_bgbe_m.bgbe012,g_bgbe_m.bgbe014,g_bgbe_m.bgbe022, 
          g_bgbe_m.bgbe027,g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015,g_bgbe_m.bgbe023,g_bgbe_m.bgbe028, 
          g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024,g_bgbe_m.bgbe029,g_bgbe_m.bgbe030  
 
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
         AFTER FIELD bgbe001
            
            #add-point:AFTER FIELD bgbe001 name="input.a.bgbe001"
            LET g_bgbe_m.bgbe001_desc = ' '
            DISPLAY BY NAME g_bgbe_m.bgbe001_desc
            IF NOT cl_null(g_bgbe_m.bgbe001) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbe_m.bgbe001 != g_bgbe_m_t.bgbe001 OR g_bgbe_m_t.bgbe001 IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbe_m.bgbe001 != g_bgbe_m_o.bgbe001 OR cl_null(g_bgbe_m_o.bgbe001) THEN #160822-00012#3 add
                  LET l_exeprog = '' #160321-00016#23 add
                  CALL abgt050_bgaa_bgae_bgaj_chk(g_bgbe_m.bgbe001,g_bgbe_m.bgbe004,g_bgbe_m.bgbe003)RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errparam.exeprog) THEN LET l_exeprog = g_errparam.exeprog END IF #160321-00016#23 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#5 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     IF NOT cl_null(l_exeprog) THEN  #s_fin_budget_chk
                        LET g_errparam.replace[1] = l_exeprog
                        LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                        LET g_errparam.exeprog = l_exeprog
                     END IF
                     #160318-00005#5 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgbe_m.bgbe001 = g_bgbe_m_o.bgbe001   #160822-00012#3 add
                     LET g_bgbe_m.bgbe003 = ''
                     LET g_bgbe_m.bgbe003_desc =''
                     LET g_bgbe_m.bgbe004 = ''
                     LET g_bgbe_m.bgbe004_desc = ''
                     DISPLAY BY NAME g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc
                     DISPLAY BY NAME g_bgbe_m.bgbe001_desc,g_bgbe_m.bgbe001
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_abg_center_sons_query(g_bgbe_m.bgbe001,'','')
                  LET g_bgbe_m.bgbe003 = ''
                  LET g_bgbe_m.bgbe003_desc =''
                  LET g_bgbe_m.bgbe004 = ''
                  LET g_bgbe_m.bgbe004_desc = ''
                  DISPLAY BY NAME g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc                 
               END IF
            END IF 
            LET g_bgbe_m_o.* = g_bgbe_m.*  #160822-00012#3 add            
            #使用預算項目參照表/使用科目預算
            SELECT bgaa008,bgaa012
              INTO g_bgaa008,g_bgaa012
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_bgbe_m.bgbe001
               
            #取得科目
            IF g_bgaa012 = 'Y' THEN
               LET g_glac002 = g_bgbe_m.bgbe004
            ELSE
               CALL abgt050_bg_to_acc(g_bgaa008,g_bgbe_m.bgbe004)RETURNING g_glac002
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe001
            #add-point:BEFORE FIELD bgbe001 name="input.b.bgbe001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe001
            #add-point:ON CHANGE bgbe001 name="input.g.bgbe001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbedocno
            #add-point:BEFORE FIELD bgbedocno name="input.b.bgbedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbedocno
            
            #add-point:AFTER FIELD bgbedocno name="input.a.bgbedocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_bgbe_m.bgbedocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgbe_m.bgbedocno != g_bgbedocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbe_t WHERE "||"bgbeent = '" ||g_enterprise|| "' AND "||"bgbedocno = '"||g_bgbe_m.bgbedocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_bgbe_m.bgbedocno) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbe_m.bgbedocno != g_bgbe_m_t.bgbedocno OR g_bgbe_m_t.bgbedocno IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbe_m.bgbedocno != g_bgbe_m_o.bgbedocno OR cl_null(g_bgbe_m_o.bgbedocno) THEN  #160822-00012#3 add
                  IF NOT s_aooi200_fin_chk_docno(g_glaald,'','',g_bgbe_m.bgbedocno,g_bgbe_m.bgbedocdt,g_prog) THEN
                     #LET g_bgbe_m.bgbedocno = g_bgbe_m_t.bgbedocno #160822-00012#3 mark
                     LET g_bgbe_m.bgbedocno = g_bgbe_m_o.bgbedocno  #160822-00012#3 add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bgbe_m_o.* = g_bgbe_m.* #160822-00012#3 add

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbedocno
            #add-point:ON CHANGE bgbedocno name="input.g.bgbedocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="input.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="input.a.glaa001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa001
            #add-point:ON CHANGE glaa001 name="input.g.glaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbedocdt
            #add-point:BEFORE FIELD bgbedocdt name="input.b.bgbedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbedocdt
            
            #add-point:AFTER FIELD bgbedocdt name="input.a.bgbedocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbedocdt
            #add-point:ON CHANGE bgbedocdt name="input.g.bgbedocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe002
            #add-point:BEFORE FIELD bgbe002 name="input.b.bgbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe002
            
            #add-point:AFTER FIELD bgbe002 name="input.a.bgbe002"
            IF NOT cl_null(g_bgbe_m.bgbe002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbe_m.bgbe002 != g_bgbe_m_t.bgbe002 OR g_bgbe_m_t.bgbe002 IS NULL )) THEN
                  CALL s_chr_alphanumeric(g_bgbe_m.bgbe002,1)RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     NEXT FIELD CURRENT
                  END IF
                  LET g_bgbe_m.bgbe002 = g_bgbe_m.bgbe002 USING '<<<<<<<<<<'
                  DISPLAY BY NAME g_bgbe_m.bgbe002
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe002
            #add-point:ON CHANGE bgbe002 name="input.g.bgbe002"
           
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe003
            
            #add-point:AFTER FIELD bgbe003 name="input.a.bgbe003"
            LET g_bgbe_m.bgbe003_desc = ' '
            DISPLAY BY NAME g_bgbe_m.bgbe003_desc
            IF NOT cl_null(g_bgbe_m.bgbe003) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbe_m.bgbe003 != g_bgbe_m_t.bgbe003 OR g_bgbe_m_t.bgbe003 IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbe_m.bgbe003 != g_bgbe_m_o.bgbe003 OR cl_null(g_bgbe_m_o.bgbe003) THEN    #160822-00012#3 add
                  LET l_exeprog = '' #160321-00016#23 add
                  CALL abgt050_bgaa_bgae_bgaj_chk(g_bgbe_m.bgbe001,g_bgbe_m.bgbe004,g_bgbe_m.bgbe003)RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errparam.exeprog) THEN LET l_exeprog = g_errparam.exeprog END IF #160321-00016#23 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#5 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     
                     IF NOT cl_null(l_exeprog) THEN  #s_fin_budget_chk
                        LET g_errparam.replace[1] = l_exeprog
                        LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                        LET g_errparam.exeprog = l_exeprog
                     END IF
                     #160318-00005#5 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_bgbe_m.bgbe003 = g_bgbe_m_t.bgbe003 #160822-00012#3 mark
                     LET g_bgbe_m.bgbe003 = g_bgbe_m_o.bgbe003  #160822-00012#3 add
                     LET g_bgbe_m.bgbe003_desc = s_desc_get_department_desc(g_bgbe_m.bgbe003)
                     DISPLAY BY NAME g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe003
                     NEXT FIELD CURRENT
                  END IF
                  #161129-00019#4 --s add
                  #檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bgbe_m.bgbe001,'',g_bgbe_m.bgbe003,'11')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgbe_m.bgbe003 = g_bgbe_m_o.bgbe003  
                     LET g_bgbe_m.bgbe003_desc = s_desc_get_department_desc(g_bgbe_m.bgbe003)
                     DISPLAY BY NAME g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe003
                     NEXT FIELD CURRENT
                  END IF
                  #161129-00019#4 --e add                   
               END IF
            END IF                              
            LET g_bgbe_m.bgbe003_desc = s_desc_get_department_desc(g_bgbe_m.bgbe003)
            DISPLAY BY NAME g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe003
            LET g_glaald = NULL            
            SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
             WHERE glaaent = g_enterprise
               AND glaacomp = ooef017
               AND glaaent = ooefent
               AND ooef001 = g_bgbe_m.bgbe003
               AND glaa014 = 'Y'
         
            SELECT bgaa008,bgaa012
              INTO g_bgaa008,g_bgaa012
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_bgbe_m.bgbe001
               
            CALL abgt050_ld_info(g_glaald)
            LET g_bgbe_m.glaa001 = g_glaa.glaa001
            DISPLAY BY NAME g_bgbe_m.glaa001
            LET g_bgbe_m_o.* = g_bgbe_m.* #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe003
            #add-point:BEFORE FIELD bgbe003 name="input.b.bgbe003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe003
            #add-point:ON CHANGE bgbe003 name="input.g.bgbe003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe004
            
            #add-point:AFTER FIELD bgbe004 name="input.a.bgbe004"
            LET g_bgbe_m.bgbe004_desc = ' '
            DISPLAY BY NAME g_bgbe_m.bgbe004_desc
            IF NOT cl_null(g_bgbe_m.bgbe004) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbe_m.bgbe004 != g_bgbe_m_t.bgbe004 OR g_bgbe_m_t.bgbe004 IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbe_m.bgbe004 != g_bgbe_m_o.bgbe004 OR cl_null(g_bgbe_m_o.bgbe004) THEN  #160822-00012#3 add
                  LET l_exeprog = '' #160321-00016#23 add
                  CALL abgt050_bgaa_bgae_bgaj_chk(g_bgbe_m.bgbe001,g_bgbe_m.bgbe004,g_bgbe_m.bgbe003)RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errparam.exeprog) THEN LET l_exeprog = g_errparam.exeprog END IF #160321-00016#23 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160318-00005#5 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     
                     IF NOT cl_null(l_exeprog) THEN  #s_fin_budget_chk
                        LET g_errparam.replace[1] = l_exeprog
                        LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                        LET g_errparam.exeprog = l_exeprog
                     END IF
                     #160318-00005#5 --e add 
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_bgbe_m.bgbe004 = g_bgbe_m_t.bgbe004 #160822-00012#3 mark
                     LET g_bgbe_m.bgbe004 = g_bgbe_m_o.bgbe004  #160822-00012#3 add
                     LET g_bgbe_m.bgbe004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbe_m.bgbe004)
                     DISPLAY BY NAME g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgbe_m.bgbe003) AND NOT cl_null(g_bgbe_m.bgbe001) AND NOT cl_null(g_bgbe_m.bgbedocdt) THEN
                     CALL abgt050_bgbe003_chk(g_bgbe_m.bgbe003,g_bgbe_m.bgbe001,g_bgbe_m.bgbe004,g_bgbe_m.bgbedocdt,1)
                         RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_bgbe_m.bgbe004 = g_bgbe_m_t.bgbe004 #160822-00012#3 mark
                        LET g_bgbe_m.bgbe004 = g_bgbe_m_o.bgbe004  #160822-00012#3 add
                        LET g_bgbe_m.bgbe004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbe_m.bgbe004)
                        DISPLAY BY NAME g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF                    
               END IF
            END IF                       
            IF g_bgaa012 = 'Y' THEN
               LET g_glac002 = g_bgbe_m.bgbe004
               LET g_bgbe_m.bgbe004_desc = s_desc_get_account_desc(g_glaald,g_bgbe_m.bgbe004)
            ELSE
               CALL abgt050_bg_to_acc(g_bgaa008,g_bgbe_m.bgbe004)RETURNING g_glac002
               LET g_bgbe_m.bgbe004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbe_m.bgbe004)
            END IF
            CALL s_fin_sel_glad(g_glaald,g_glac002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
            RETURNING g_errno,g_glad.*
            CALL abgt050_bgbe_entry()
            CALL abgt050_bgbe_noentry()
            DISPLAY BY NAME g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc
            LET g_bgbe_m_o.* = g_bgbe_m.* #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe004
            #add-point:BEFORE FIELD bgbe004 name="input.b.bgbe004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe004
            #add-point:ON CHANGE bgbe004 name="input.g.bgbe004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe005
            #add-point:BEFORE FIELD bgbe005 name="input.b.bgbe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe005
            
            #add-point:AFTER FIELD bgbe005 name="input.a.bgbe005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe005
            #add-point:ON CHANGE bgbe005 name="input.g.bgbe005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbestus
            #add-point:BEFORE FIELD bgbestus name="input.b.bgbestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbestus
            
            #add-point:AFTER FIELD bgbestus name="input.a.bgbestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbestus
            #add-point:ON CHANGE bgbestus name="input.g.bgbestus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbe_m.bgbe006,"1","1","13","1","azz-00087",1) THEN
               NEXT FIELD bgbe006
            END IF 
 
 
 
            #add-point:AFTER FIELD bgbe006 name="input.a.bgbe006"
            IF NOT cl_null(g_bgbe_m.bgbe006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe006
            #add-point:BEFORE FIELD bgbe006 name="input.b.bgbe006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe006
            #add-point:ON CHANGE bgbe006 name="input.g.bgbe006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe010
            
            #add-point:AFTER FIELD bgbe010 name="input.a.bgbe010"
            #交易客商
            IF NOT cl_null(g_bgbe_m.bgbe010) THEN
               IF (g_bgbe_m.bgbe010 != g_bgbe_m_t.bgbe010 OR g_bgbe_m_t.bgbe010 IS NULL) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_bgbe_m.bgbe010
                     LET g_chkparam.arg2 = ' '
                     LET g_errshow = TRUE   #160318-00025#49
                     LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49 
                     IF NOT cl_chk_exist("v_pmaa001_7") THEN
                        LET g_bgbe_m.bgbe010 = g_bgbe_m_t.bgbe010
                        DISPLAY BY NAME g_bgbe_m.bgbe010
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF   
            END IF               
            LET g_bgbe_m.bgbe010_desc = s_desc_get_trading_partner_abbr_desc(g_bgbe_m.bgbe010)
            DISPLAY BY NAME g_bgbe_m.bgbe010 ,g_bgbe_m.bgbe010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe010
            #add-point:BEFORE FIELD bgbe010 name="input.b.bgbe010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe010
            #add-point:ON CHANGE bgbe010 name="input.g.bgbe010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe018
            
            #add-point:AFTER FIELD bgbe018 name="input.a.bgbe018"
            #渠道
            IF NOT cl_null(g_bgbe_m.bgbe018) THEN
               #IF ( g_bgbe_m.bgbe018 != g_bgbe_m_t.bgbe018 OR g_bgbe_m_t.bgbe018 IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbe_m.bgbe018 != g_bgbe_m_o.bgbe018 OR cl_null(g_bgbe_m_o.bgbe018) THEN     #160822-00012#3 add
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq052_chk(g_bgbe_m.bgbe018)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_bgbe_m.bgbe018 = g_bgbe_m_t.bgbe018 #160822-00012#3 mark
                        LET g_bgbe_m.bgbe018 = g_bgbe_m_o.bgbe018  #160822-00012#3 add                       
                        LET g_bgbe_m.bgbe018_desc = s_desc_get_oojdl003_desc(g_bgbe_m.bgbe018)
                        DISPLAY BY NAME g_bgbe_m.bgbe018,g_bgbe_m.bgbe018_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe018_desc = s_desc_get_oojdl003_desc(g_bgbe_m.bgbe018)
            DISPLAY BY NAME g_bgbe_m.bgbe018,g_bgbe_m.bgbe018_desc 
            LET g_bgbe_m_o.* = g_bgbe_m.* #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe018
            #add-point:BEFORE FIELD bgbe018 name="input.b.bgbe018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe018
            #add-point:ON CHANGE bgbe018 name="input.g.bgbe018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe020
            
            #add-point:AFTER FIELD bgbe020 name="input.a.bgbe020"
            #自由核算項一
            IF NOT cl_null(g_bgbe_m.bgbe020) THEN
               IF (g_bgbe_m.bgbe020 != g_bgbe_m_t.bgbe020 OR g_bgbe_m_t.bgbe020 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0171,g_bgbe_m.bgbe020,g_glad.glad0172) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe020 = g_bgbe_m_t.bgbe020
                        LET g_bgbe_m.bgbe020_desc= s_fin_get_accting_desc(g_glad.glad0171,g_bgbe_m.bgbe020)
                        DISPLAY BY NAME g_bgbe_m.bgbe020_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe020_desc = s_fin_get_accting_desc(g_glad.glad0171,g_bgbe_m.bgbe020)
            DISPLAY BY NAME g_bgbe_m.bgbe020_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe020
            #add-point:BEFORE FIELD bgbe020 name="input.b.bgbe020"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe020
            #add-point:ON CHANGE bgbe020 name="input.g.bgbe020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe025
            
            #add-point:AFTER FIELD bgbe025 name="input.a.bgbe025"
            #自由核算項六
            IF NOT cl_null(g_bgbe_m.bgbe025) THEN
               IF (g_bgbe_m.bgbe025 != g_bgbe_m_t.bgbe025 OR g_bgbe_m_t.bgbe025 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0221,g_bgbe_m.bgbe025,g_glad.glad0222) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe025 = g_bgbe_m_t.bgbe025
                        LET g_bgbe_m.bgbe025_desc= s_fin_get_accting_desc(g_glad.glad0221,g_bgbe_m.bgbe025)
                        DISPLAY BY NAME g_bgbe_m.bgbe025_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe025_desc = s_fin_get_accting_desc(g_glad.glad0221,g_bgbe_m.bgbe025)
            DISPLAY BY NAME g_bgbe_m.bgbe025_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe025
            #add-point:BEFORE FIELD bgbe025 name="input.b.bgbe025"
            #自由核算項六
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe025
            #add-point:ON CHANGE bgbe025 name="input.g.bgbe025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbe_m.bgbe031,"1","1","13","1","azz-00087",1) THEN
               NEXT FIELD bgbe031
            END IF 
 
 
 
            #add-point:AFTER FIELD bgbe031 name="input.a.bgbe031"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe031
            #add-point:BEFORE FIELD bgbe031 name="input.b.bgbe031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe031
            #add-point:ON CHANGE bgbe031 name="input.g.bgbe031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe011
            
            #add-point:AFTER FIELD bgbe011 name="input.a.bgbe011"
            #收款客商
            IF NOT cl_null(g_bgbe_m.bgbe011) THEN
               IF ( g_bgbe_m.bgbe011 != g_bgbe_m_t.bgbe011 OR g_bgbe_m_t.bgbe011 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_bgbe_m.bgbe011
                     LET g_chkparam.arg2 = ' '
                     LET g_errshow = TRUE   #160318-00025#49
                     LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49 
                     IF NOT cl_chk_exist("v_pmaa001_7") THEN
                        LET g_bgbe_m.bgbe011 = g_bgbe_m_t.bgbe011
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe011_desc = s_desc_get_trading_partner_abbr_desc(g_bgbe_m.bgbe011)
            DISPLAY BY NAME g_bgbe_m.bgbe011,g_bgbe_m.bgbe011_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe011
            #add-point:BEFORE FIELD bgbe011 name="input.b.bgbe011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe011
            #add-point:ON CHANGE bgbe011 name="input.g.bgbe011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe019
            
            #add-point:AFTER FIELD bgbe019 name="input.a.bgbe019"
            #品牌
            IF NOT cl_null(g_bgbe_m.bgbe019) THEN
               IF ( g_bgbe_m.bgbe019 != g_bgbe_m_t.bgbe019 OR g_bgbe_m_t.bgbe019_desc IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF NOT s_azzi650_chk_exist('2002',g_bgbe_m.bgbe019) THEN
                        LET g_bgbe_m.bgbe019      = g_bgbe_m_t.bgbe019
                        LET g_bgbe_m.bgbe019_desc = s_desc_get_acc_desc('2002',g_bgbe_m.bgbe019)
                        DISPLAY BY NAME g_bgbe_m.bgbe019 ,g_bgbe_m.bgbe019_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe019_desc = s_desc_get_acc_desc('2002',g_bgbe_m.bgbe019)
            DISPLAY BY NAME g_bgbe_m.bgbe019 ,g_bgbe_m.bgbe019_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe019
            #add-point:BEFORE FIELD bgbe019 name="input.b.bgbe019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe019
            #add-point:ON CHANGE bgbe019 name="input.g.bgbe019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe021
            
            #add-point:AFTER FIELD bgbe021 name="input.a.bgbe021"
            #自由核算項二
            IF NOT cl_null(g_bgbe_m.bgbe021) THEN
               IF (g_bgbe_m.bgbe021 != g_bgbe_m_t.bgbe021 OR g_bgbe_m_t.bgbe021 IS NULL) THEN
                  IF g_bgaa012 = 'N' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0181,g_bgbe_m.bgbe021,g_glad.glad0182) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe021 = g_bgbe_m_t.bgbe021
                        LET g_bgbe_m.bgbe021_desc= s_fin_get_accting_desc(g_glad.glad0181,g_bgbe_m.bgbe021)
                        DISPLAY BY NAME g_bgbe_m.bgbe021_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe021_desc = s_fin_get_accting_desc(g_glad.glad0181,g_bgbe_m.bgbe021)
            DISPLAY BY NAME g_bgbe_m.bgbe021_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe021
            #add-point:BEFORE FIELD bgbe021 name="input.b.bgbe021"
            #自由核算項二
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe021
            #add-point:ON CHANGE bgbe021 name="input.g.bgbe021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe026
            
            #add-point:AFTER FIELD bgbe026 name="input.a.bgbe026"
            #自由核算項七
            IF NOT cl_null(g_bgbe_m.bgbe026) THEN
               IF (g_bgbe_m.bgbe026 != g_bgbe_m_t.bgbe026 OR g_bgbe_m_t.bgbe026 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0231,g_bgbe_m.bgbe026,g_glad.glad0232) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe026 = g_bgbe_m_t.bgbe026
                        LET g_bgbe_m.bgbe026_desc= s_fin_get_accting_desc(g_glad.glad0231,g_bgbe_m.bgbe026)
                        DISPLAY BY NAME g_bgbe_m.bgbe026_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe026_desc = s_fin_get_accting_desc(g_glad.glad0231,g_bgbe_m.bgbe026)
            DISPLAY BY NAME g_bgbe_m.bgbe026_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe026
            #add-point:BEFORE FIELD bgbe026 name="input.b.bgbe026"
            #自由核算項七
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe026
            #add-point:ON CHANGE bgbe026 name="input.g.bgbe026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe007
            
            #add-point:AFTER FIELD bgbe007 name="input.a.bgbe007"
            #部門
             IF NOT cl_null(g_bgbe_m.bgbe007) THEN
               IF ( g_bgbe_m.bgbe007 != g_bgbe_m_t.bgbe007 OR g_bgbe_m_t.bgbe007 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                  CALL s_department_chk(g_bgbe_m.bgbe007,g_today) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_bgbe_m.bgbe007 = g_bgbe_m_t.bgbe007              
                     DISPLAY BY NAME g_bgbe_m.bgbe007
                     NEXT FIELD CURRENT
                  END IF
                  #END IF
                  
                  #160127-00033#1-----s
                  SELECT bgae016 INTO l_bgae016
                    FROM bgae_t 
                   WHERE bgaeent = g_enterprise
                     AND bgae006 = g_bgaa008
                     AND bgae001 = g_bgbe_m.bgbe004
                   
                  IF l_bgae016 = 'Y' THEN
                     #取責任中心
                     CALL s_department_get_respon_center(g_bgbe_m.bgbe007,g_today)
                          RETURNING g_sub_success,g_errno,g_bgbe_m.bgbe008,g_bgbe_m.bgbe008_desc
                     DISPLAY BY NAME g_bgbe_m.bgbe008,g_bgbe_m.bgbe008_desc
                  END IF
                  #160127-00033#1-----e
               END IF
            END IF
            LET g_bgbe_m.bgbe007_desc = s_desc_get_department_desc(g_bgbe_m.bgbe007)
            DISPLAY BY NAME g_bgbe_m.bgbe007 ,g_bgbe_m.bgbe007_desc
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe007
            #add-point:BEFORE FIELD bgbe007 name="input.b.bgbe007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe007
            #add-point:ON CHANGE bgbe007 name="input.g.bgbe007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe012
            
            #add-point:AFTER FIELD bgbe012 name="input.a.bgbe012"
            #客群
            IF NOT cl_null(g_bgbe_m.bgbe012) THEN
               IF ( g_bgbe_m.bgbe012 != g_bgbe_m_t.bgbe012 OR g_bgbe_m_t.bgbe012 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     INITIALIZE g_chkparam.* TO NULL
                     IF NOT s_azzi650_chk_exist('281',g_bgbe_m.bgbe012) THEN
                        LET g_bgbe_m.bgbe012 = g_bgbe_m_t.bgbe012
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe012_desc = s_desc_get_acc_desc('281',g_bgbe_m.bgbe012)
            DISPLAY BY NAME g_bgbe_m.bgbe012,g_bgbe_m.bgbe012_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe012
            #add-point:BEFORE FIELD bgbe012 name="input.b.bgbe012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe012
            #add-point:ON CHANGE bgbe012 name="input.g.bgbe012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe014
            
            #add-point:AFTER FIELD bgbe014 name="input.a.bgbe014"
            #人員
            IF NOT cl_null(g_bgbe_m.bgbe014) THEN
               IF ( g_bgbe_m.bgbe014 != g_bgbe_m_t.bgbe014 OR g_bgbe_m_t.bgbe014 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_employee_chk(g_bgbe_m.bgbe014) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        LET g_bgbe_m.bgbe014 = g_bgbe_m_t.bgbe014
                        DISPLAY BY NAME g_bgbe_m.bgbe014
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe014_desc = s_desc_get_person_desc(g_bgbe_m.bgbe014)
            DISPLAY BY NAME g_bgbe_m.bgbe014,g_bgbe_m.bgbe014_desc
            LET g_bgbe_m_t.bgbe014_desc = g_bgbe_m.bgbe014_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe014
            #add-point:BEFORE FIELD bgbe014 name="input.b.bgbe014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe014
            #add-point:ON CHANGE bgbe014 name="input.g.bgbe014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe022
            
            #add-point:AFTER FIELD bgbe022 name="input.a.bgbe022"
            #自由核算項三
            IF NOT cl_null(g_bgbe_m.bgbe022) THEN
               IF (g_bgbe_m.bgbe022 != g_bgbe_m_t.bgbe022 OR g_bgbe_m_t.bgbe022 IS NULL) THEN
                  IF g_bgaa012 = 'N' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0191,g_bgbe_m.bgbe022,g_glad.glad0192) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe022 = g_bgbe_m_t.bgbe022
                        LET g_bgbe_m.bgbe022_desc= s_fin_get_accting_desc(g_glad.glad0191,g_bgbe_m.bgbe022)
                        DISPLAY BY NAME g_bgbe_m.bgbe021_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe022_desc = s_fin_get_accting_desc(g_glad.glad0181,g_bgbe_m.bgbe022)
            DISPLAY BY NAME g_bgbe_m.bgbe022_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe022
            #add-point:BEFORE FIELD bgbe022 name="input.b.bgbe022"
            #自由核算項三
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe022
            #add-point:ON CHANGE bgbe022 name="input.g.bgbe022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe027
            
            #add-point:AFTER FIELD bgbe027 name="input.a.bgbe027"
            #自由核算項八
            IF NOT cl_null(g_bgbe_m.bgbe027) THEN
               IF (g_bgbe_m.bgbe027 != g_bgbe_m_t.bgbe027 OR g_bgbe_m_t.bgbe027 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0241,g_bgbe_m.bgbe027,g_glad.glad0242) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe027 = g_bgbe_m_t.bgbe027
                        LET g_bgbe_m.bgbe027_desc= s_fin_get_accting_desc(g_glad.glad0241,g_bgbe_m.bgbe027)
                        DISPLAY BY NAME g_bgbe_m.bgbe027_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe027_desc = s_fin_get_accting_desc(g_glad.glad0241,g_bgbe_m.bgbe027)
            DISPLAY BY NAME g_bgbe_m.bgbe027_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe027
            #add-point:BEFORE FIELD bgbe027 name="input.b.bgbe027"
            #自由核算項八
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe027
            #add-point:ON CHANGE bgbe027 name="input.g.bgbe027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe008
            
            #add-point:AFTER FIELD bgbe008 name="input.a.bgbe008"
            #責任中心
            IF NOT cl_null(g_bgbe_m.bgbe008) THEN
               IF ( g_bgbe_m.bgbe008 != g_bgbe_m_t.bgbe008 OR g_bgbe_m_t.bgbe008 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq019_chk(g_bgbe_m.bgbe008,g_today)
                     IF NOT cl_null(g_errno) THEN
                        LET g_bgbe_m.bgbe008 = g_bgbe_m_t.bgbe008
                        DISPLAY BY NAME g_bgbe_m.bgbe008
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe008_desc = s_desc_get_department_desc(g_bgbe_m.bgbe008)
            DISPLAY BY NAME g_bgbe_m.bgbe008,g_bgbe_m.bgbe008_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe008
            #add-point:BEFORE FIELD bgbe008 name="input.b.bgbe008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe008
            #add-point:ON CHANGE bgbe008 name="input.g.bgbe008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe013
            
            #add-point:AFTER FIELD bgbe013 name="input.a.bgbe013"
            ##產品類別
            IF NOT cl_null(g_bgbe_m.bgbe013) THEN
               IF ( g_bgbe_m.bgbe013 != g_bgbe_m_t.bgbe013 OR g_bgbe_m_t.bgbe013 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq024_chk(g_bgbe_m.bgbe013)
                     IF NOT cl_null(g_errno) THEN
                        LET g_bgbe_m.bgbe013 = g_bgbe_m_t.bgbe013
                        LET g_bgbe_m.bgbe013_desc = s_desc_get_rtaxl003_desc(g_bgbe_m.bgbe013)
                        DISPLAY BY NAME g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe013_desc = s_desc_get_rtaxl003_desc(g_bgbe_m.bgbe013)
            DISPLAY BY NAME g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe013
            #add-point:BEFORE FIELD bgbe013 name="input.b.bgbe013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe013
            #add-point:ON CHANGE bgbe013 name="input.g.bgbe013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe015
            
            #add-point:AFTER FIELD bgbe015 name="input.a.bgbe015"
            #專案代號
            IF NOT cl_null(g_bgbe_m.bgbe015) THEN
               IF ( g_bgbe_m.bgbe015 != g_bgbe_m_t.bgbe015 OR g_bgbe_m_t.bgbe015 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_aap_project_chk(g_bgbe_m.bgbe015) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#23 --s add
                        LET g_errparam.replace[1] = 'apjm200'
                        LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                        LET g_errparam.exeprog = 'apjm200'
                        #160321-00016#23 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe015      = g_bgbe_m_t.bgbe015
                        LET g_bgbe_m.bgbe015_desc = s_desc_get_project_desc(g_bgbe_m.bgbe015)  
                        DISPLAY BY NAME g_bgbe_m.bgbe015,g_bgbe_m.bgbe015_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe015_desc = s_desc_get_project_desc(g_bgbe_m.bgbe015)      
            DISPLAY BY NAME g_bgbe_m.bgbe015,g_bgbe_m.bgbe015_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe015
            #add-point:BEFORE FIELD bgbe015 name="input.b.bgbe015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe015
            #add-point:ON CHANGE bgbe015 name="input.g.bgbe015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe023
            
            #add-point:AFTER FIELD bgbe023 name="input.a.bgbe023"
            #自由核算項四
            IF NOT cl_null(g_bgbe_m.bgbe023) THEN
               IF (g_bgbe_m.bgbe023 != g_bgbe_m_t.bgbe023 OR g_bgbe_m_t.bgbe023 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0201,g_bgbe_m.bgbe023,g_glad.glad0202) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe023 = g_bgbe_m_t.bgbe023
                        LET g_bgbe_m.bgbe023_desc= s_fin_get_accting_desc(g_glad.glad0201,g_bgbe_m.bgbe023)
                        DISPLAY BY NAME g_bgbe_m.bgbe023_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe023_desc = s_fin_get_accting_desc(g_glad.glad0201,g_bgbe_m.bgbe023)
            DISPLAY BY NAME g_bgbe_m.bgbe023_desc
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe023
            #add-point:BEFORE FIELD bgbe023 name="input.b.bgbe023"
            #自由核算項四
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe023
            #add-point:ON CHANGE bgbe023 name="input.g.bgbe023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe028
            
            #add-point:AFTER FIELD bgbe028 name="input.a.bgbe028"
            #自由核算項九
            IF NOT cl_null(g_bgbe_m.bgbe028) THEN
               IF (g_bgbe_m.bgbe028 != g_bgbe_m_t.bgbe028 OR g_bgbe_m_t.bgbe028 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0251,g_bgbe_m.bgbe028,g_glad.glad0252) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe028 = g_bgbe_m_t.bgbe028
                        LET g_bgbe_m.bgbe028_desc= s_fin_get_accting_desc(g_glad.glad0251,g_bgbe_m.bgbe028)
                        DISPLAY BY NAME g_bgbe_m.bgbe028_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe028_desc = s_fin_get_accting_desc(g_glad.glad0251,g_bgbe_m.bgbe028)
            DISPLAY BY NAME g_bgbe_m.bgbe028_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe028
            #add-point:BEFORE FIELD bgbe028 name="input.b.bgbe028"
            #自由核算項九
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe028
            #add-point:ON CHANGE bgbe028 name="input.g.bgbe028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe009
            
            #add-point:AFTER FIELD bgbe009 name="input.a.bgbe009"
            #區域
            IF NOT cl_null(g_bgbe_m.bgbe009) THEN
               IF ( g_bgbe_m.bgbe009 != g_bgbe_m_t.bgbe009 OR g_bgbe_m_t.bgbe009 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF NOT s_azzi650_chk_exist('287',g_bgbe_m.bgbe009) THEN
                        LET g_bgbe_m.bgbe009 = g_bgbe_m_t.bgbe009
                        DISPLAY BY NAME g_bgbe_m.bgbe009
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe009_desc = s_desc_get_acc_desc('287',g_bgbe_m.bgbe009)
            DISPLAY BY NAME g_bgbe_m.bgbe009 ,g_bgbe_m.bgbe009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe009
            #add-point:BEFORE FIELD bgbe009 name="input.b.bgbe009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe009
            #add-point:ON CHANGE bgbe009 name="input.g.bgbe009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe017
            #add-point:BEFORE FIELD bgbe017 name="input.b.bgbe017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe017
            
            #add-point:AFTER FIELD bgbe017 name="input.a.bgbe017"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe017
            #add-point:ON CHANGE bgbe017 name="input.g.bgbe017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe016
            
            #add-point:AFTER FIELD bgbe016 name="input.a.bgbe016"
            #WBS
            IF NOT cl_null(g_bgbe_m.bgbe016) THEN
               IF ( g_bgbe_m.bgbe016 != g_bgbe_m_t.bgbe016 OR g_bgbe_m_t.bgbe016 IS NULL ) THEN
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq028_chk(g_bgbe_m.bgbe015,g_bgbe_m.bgbe016)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe016      = g_bgbe_m_t.bgbe016
                        LET g_bgbe_m.bgbe016_desc = s_desc_get_pjbbl004_desc(g_bgbe_m.bgbe015,g_bgbe_m.bgbe016)
                        DISPLAY BY NAME g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe016_desc = s_desc_get_pjbbl004_desc(g_bgbe_m.bgbe015,g_bgbe_m.bgbe016)
            DISPLAY BY NAME g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe016
            #add-point:BEFORE FIELD bgbe016 name="input.b.bgbe016"
         
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe016
            #add-point:ON CHANGE bgbe016 name="input.g.bgbe016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe024
            
            #add-point:AFTER FIELD bgbe024 name="input.a.bgbe024"
            #自由核算項五
            IF NOT cl_null(g_bgbe_m.bgbe024) THEN
               IF (g_bgbe_m.bgbe024 != g_bgbe_m_t.bgbe024 OR g_bgbe_m_t.bgbe024 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0211,g_bgbe_m.bgbe024,g_glad.glad0212) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe024 = g_bgbe_m_t.bgbe024
                        LET g_bgbe_m.bgbe024_desc= s_fin_get_accting_desc(g_glad.glad0211,g_bgbe_m.bgbe024)
                        DISPLAY BY NAME g_bgbe_m.bgbe024_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe024_desc = s_fin_get_accting_desc(g_glad.glad0211,g_bgbe_m.bgbe024)
            DISPLAY BY NAME g_bgbe_m.bgbe024_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe024
            #add-point:BEFORE FIELD bgbe024 name="input.b.bgbe024"
            #自由核算項五
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe024
            #add-point:ON CHANGE bgbe024 name="input.g.bgbe024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe029
            
            #add-point:AFTER FIELD bgbe029 name="input.a.bgbe029"
            #自由核算項十
            IF NOT cl_null(g_bgbe_m.bgbe029) THEN
               IF (g_bgbe_m.bgbe029 != g_bgbe_m_t.bgbe029 OR g_bgbe_m_t.bgbe029 IS NULL) THEN
                  IF g_bgaa012 = 'Y' THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0261,g_bgbe_m.bgbe029,g_glad.glad0262) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_bgbe_m.bgbe029 = g_bgbe_m_t.bgbe029
                        LET g_bgbe_m.bgbe029_desc= s_fin_get_accting_desc(g_glad.glad0261,g_bgbe_m.bgbe029)
                        DISPLAY BY NAME g_bgbe_m.bgbe029_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbe_m.bgbe029_desc = s_fin_get_accting_desc(g_glad.glad0261,g_bgbe_m.bgbe029)
            DISPLAY BY NAME g_bgbe_m.bgbe029_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe029
            #add-point:BEFORE FIELD bgbe029 name="input.b.bgbe029"
            #自由核算項十
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe029
            #add-point:ON CHANGE bgbe029 name="input.g.bgbe029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbe030
            #add-point:BEFORE FIELD bgbe030 name="input.b.bgbe030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbe030
            
            #add-point:AFTER FIELD bgbe030 name="input.a.bgbe030"
            IF NOT cl_null(g_bgbe_m.bgbe030) THEN 
               CALL s_curr_round_ld('1',g_glaald,g_glaa.glaa001,g_bgbe_m.bgbe030,2) 
                  RETURNING g_sub_success,g_errno,g_bgbe_m.bgbe030  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbe030
            #add-point:ON CHANGE bgbe030 name="input.g.bgbe030"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgbe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe001
            #add-point:ON ACTION controlp INFIELD bgbe001 name="input.c.bgbe001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe001
            CALL q_bgaa001()
            LET g_bgbe_m.bgbe001 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe001
            NEXT FIELD bgbe001
            #END add-point
 
 
         #Ctrlp:input.c.bgbedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbedocno
            #add-point:ON ACTION controlp INFIELD bgbedocno name="input.c.bgbedocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbedocno      #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_bgbe_m.bgbedocno = g_qryparam.return1
            DISPLAY g_bgbe_m.bgbedocno TO bgbedocno
            NEXT FIELD bgbedocno                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.glaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="input.c.glaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbedocdt
            #add-point:ON ACTION controlp INFIELD bgbedocdt name="input.c.bgbedocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe002
            #add-point:ON ACTION controlp INFIELD bgbe002 name="input.c.bgbe002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe003
            #add-point:ON ACTION controlp INFIELD bgbe003 name="input.c.bgbe003"
            #161129-00019#4 --s mark
            ##161006-00005#11  add----s
            #CALL s_fin_abg_center_sons_query(g_bgbe_m.bgbe001,'','')
            #CALL s_fin_account_center_sons_str() RETURNING l_orga  
            #CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            ##161006-00005#11  add----e
            #161129-00019#4 --e mark
            #161129-00019#4 --s add
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgbe_m.bgbe001,'',g_user,'11') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            #161129-00019#4 --e add               
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe003  #給予default值
            #161006-00005#11   mark---s
            #LET g_qryparam.where = " ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) ",
            #                       "  AND  ooef001 IN (SELECT bgaj002 FROM bgaj_t  ",
            #                       "                   WHERE bgajent = '",g_enterprise,"'       ",
            #                       "                     AND bgaj001 = '",g_bgbe_m.bgbe001,"' ) "
            #CALL q_ooef001()
            #161006-00005#11   mark---e
            #161006-00005#11   add---s
            LET g_qryparam.where = "  ooef001 IN (SELECT bgaj002 FROM bgaj_t  ",
                                   "                   WHERE bgajent = '",g_enterprise,"'       ",
                                   "                     AND bgaj001 = '",g_bgbe_m.bgbe001,"' ) ",
                                   #" AND ooef001 IN ", g_userorga #161129-00019#4 mark
                                   " AND ooef001 IN ", l_site_str  #161129-00019#4 add
            #161129-00019#4 --s mark
            #IF NOT cl_null(g_bgbe_m.bgbe001) THEN 
            #   LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ", l_orga
            #END IF
            #161129-00019#4 --e mark
            CALL q_ooef001_77()   
            #161006-00005#11   add---e
            LET g_bgbe_m.bgbe003 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe003
            NEXT FIELD bgbe003
            #END add-point
 
 
         #Ctrlp:input.c.bgbe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe004
            #add-point:ON ACTION controlp INFIELD bgbe004 name="input.c.bgbe004"
            IF g_bgaa012 = 'Y' THEN
               #抓取會計科目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_bgbe_m.bgbe004
               LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' ",               #glac001(會計科目參照表)/glac003(科>
                                      " AND glac002 IN ( SELECT bgaf007                                ", 
                                                       "    FROM bgaf_t                                ",
                                                       "   WHERE bgafent = '",g_enterprise,"'          ",
                                                       "     AND bgaf001 = '",g_bgbe_m.bgbe003,"'      ",
                                                       "     AND bgaf002 <= '",g_bgbe_m.bgbedocdt,"'   ",
                                                       "     AND bgaf003 >= '",g_bgbe_m.bgbedocdt,"'   ",
                                                       "     AND bgaf004 = '",g_bgbe_m.bgbe001,"'      ",
                                                       "     AND bgaf012 = 'Y'                       ) "                                                       
               CALL aglt310_04()
               LET g_bgbe_m.bgbe004 = g_qryparam.return1
               DISPLAY BY NAME g_bgbe_m.bgbe004
               NEXT FIELD bgbe004
            ELSE
               #抓取預算項目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_bgbe_m.bgbe004  #給予default值
               LET g_qryparam.where = " bgae006 IN (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = ",g_enterprise," ",
                                                     " AND bgaa001 = '",g_bgbe_m.bgbe001,"' ) ",  #存在預算編號的預算項目參照表
                                       " AND bgae007 = '1' ",
                                       " AND bgae001 IN ( SELECT bgaf007                               ", 
                                                       "    FROM bgaf_t                                ",
                                                       "   WHERE bgafent = '",g_enterprise,"'          ",
                                                       "     AND bgaf001 = '",g_bgbe_m.bgbe003,"'      ",
                                                       "     AND bgaf002 <= '",g_bgbe_m.bgbedocdt,"'   ",
                                                       "     AND bgaf003 >= '",g_bgbe_m.bgbedocdt,"'   ",
                                                       "     AND bgaf004 = '",g_bgbe_m.bgbe001,"'      ",
                                                       "     AND bgaf012 = 'Y'                       ) "  
 
               CALL q_bgae001()
               LET g_bgbe_m.bgbe004 = g_qryparam.return1
               DISPLAY BY NAME g_bgbe_m.bgbe004
               NEXT FIELD bgbe004
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe005
            #add-point:ON ACTION controlp INFIELD bgbe005 name="input.c.bgbe005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbestus
            #add-point:ON ACTION controlp INFIELD bgbestus name="input.c.bgbestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbe006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe006
            #add-point:ON ACTION controlp INFIELD bgbe006 name="input.c.bgbe006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe006
            LET g_qryparam.where = " bgbd001 = '",g_bgbe_m.bgbe001,"' AND bgbd007 = '",g_bgbe_m.bgbe004,"' ",
                                   "                                  AND bgbd003 = '",g_bgbe_m.bgbe003,"' "
            CALL q_bgbd004()
            LET g_bgbe_m.bgbe006 = g_qryparam.return1
            LET g_bgbe_m.bgbe031 = g_qryparam.return2
            DISPLAY BY NAME g_bgbe_m.bgbe006
            NEXT FIELD bgbe006
            #END add-point
 
 
         #Ctrlp:input.c.bgbe010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe010
            #add-point:ON ACTION controlp INFIELD bgbe010 name="input.c.bgbe010"
            #交易客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe010
            LET g_qryparam.where = " pmaa001 IN ( SELECT bgbd016 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
                                   #" AND pmaa002 IN ('2','3') "   #160920-00019#4--mark
            #CALL q_pmaa001()    #160920-00019#4--mark
            CALL q_pmaa001_25()  #160920-00019#4--add
            LET g_bgbe_m.bgbe010 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe010 
            NEXT FIELD bgbe010
            #END add-point
 
 
         #Ctrlp:input.c.bgbe018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe018
            #add-point:ON ACTION controlp INFIELD bgbe018 name="input.c.bgbe018"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe018
            LET g_qryparam.where = " oojd001 IN ( SELECT bgbd042 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_oojd001_2()
            LET g_bgbe_m.bgbe018 = g_qryparam.return1          
            DISPLAY BY NAME g_bgbe_m.bgbe018
            NEXT FIELD bgbe018
            #END add-point
 
 
         #Ctrlp:input.c.bgbe020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe020
            #add-point:ON ACTION controlp INFIELD bgbe020 name="input.c.bgbe020"
            #自由核算項一
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe020
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe020 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe020
                  NEXT FIELD bgbe020
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe025
            #add-point:ON ACTION controlp INFIELD bgbe025 name="input.c.bgbe025"
            #自由核算項六
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe025
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe025 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe025
                  NEXT FIELD bgbe025
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe031
            #add-point:ON ACTION controlp INFIELD bgbe031 name="input.c.bgbe031"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe031
            LET g_qryparam.where = " bgbd001 = '",g_bgbe_m.bgbe001,"' AND bgbd007 = '",g_bgbe_m.bgbe004,"' ",
                                   "                                  AND bgbd003 = '",g_bgbe_m.bgbe003,"' "
            CALL q_bgbd004()
            LET g_bgbe_m.bgbe006 = g_qryparam.return1
            LET g_bgbe_m.bgbe031 = g_qryparam.return2
            DISPLAY BY NAME g_bgbe_m.bgbe006,g_bgbe_m.bgbe031
            NEXT FIELD bgbe031
            #END add-point
 
 
         #Ctrlp:input.c.bgbe011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe011
            #add-point:ON ACTION controlp INFIELD bgbe011 name="input.c.bgbe011"
            #收款客商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe011
            LET g_qryparam.where = " pmaa001 IN ( SELECT bgbd017 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
                                   #" AND pmaa002 IN ('2','3') "  #160920-00019#4--mark
            #CALL q_pmaa001()    #160920-00019#4--mark
            CALL q_pmaa001_25()  #160920-00019#4--add
            LET g_bgbe_m.bgbe011 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe011
            NEXT FIELD bgbe011
            #END add-point
 
 
         #Ctrlp:input.c.bgbe019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe019
            #add-point:ON ACTION controlp INFIELD bgbe019 name="input.c.bgbe019"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe019
            LET g_qryparam.where = " oocq002 IN ( SELECT bgbd043 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_oocq002_2002()
            LET g_bgbe_m.bgbe019 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe019
            NEXT FIELD bgbe019
            #END add-point
 
 
         #Ctrlp:input.c.bgbe021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe021
            #add-point:ON ACTION controlp INFIELD bgbe021 name="input.c.bgbe021"
            #自由核算項二
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe021
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe021 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe021
                  NEXT FIELD bgbe021
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe026
            #add-point:ON ACTION controlp INFIELD bgbe026 name="input.c.bgbe026"
            #自由核算項七
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe026
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe026 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe026
                  NEXT FIELD bgbe026
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe007
            #add-point:ON ACTION controlp INFIELD bgbe007 name="input.c.bgbe007"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe007
            LET g_qryparam.arg1 = g_today    #應以單據日期
            LET g_qryparam.where = " ooeg001 IN ( SELECT bgbd013 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "                                                            
            CALL q_ooeg001_4()
            LET g_bgbe_m.bgbe007 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe007
            NEXT FIELD bgbe007
            #END add-point
 
 
         #Ctrlp:input.c.bgbe012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe012
            #add-point:ON ACTION controlp INFIELD bgbe012 name="input.c.bgbe012"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe012
             LET g_qryparam.where = " oocq002 IN ( SELECT bgbd018 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_oocq002_281()
            LET g_bgbe_m.bgbe012 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe012
            NEXT FIELD bgbe012
            #END add-point
 
 
         #Ctrlp:input.c.bgbe014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe014
            #add-point:ON ACTION controlp INFIELD bgbe014 name="input.c.bgbe014"
              #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe014
            LET g_qryparam.where = " ooag001 IN ( SELECT bgbd020 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_ooag001_8()
            LET g_bgbe_m.bgbe014 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe014
            NEXT FIELD bgbe014
            #END add-point
 
 
         #Ctrlp:input.c.bgbe022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe022
            #add-point:ON ACTION controlp INFIELD bgbe022 name="input.c.bgbe022"
            #自由核算項三
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe022
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe022 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe022
                  NEXT FIELD bgbe022
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe027
            #add-point:ON ACTION controlp INFIELD bgbe027 name="input.c.bgbe027"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbe_m.bgbe027
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbe_m.bgbe027 = g_qryparam.return1
               DISPLAY BY NAME g_bgbe_m.bgbe027
               NEXT FIELD bgbe027
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe008
            #add-point:ON ACTION controlp INFIELD bgbe008 name="input.c.bgbe008"
             #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_bgbe_m.bgbe008
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg001 IN ( SELECT bgbd014 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_ooeg001_5()
            LET g_bgbe_m.bgbe008 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe008
            NEXT FIELD bgbe008
            #END add-point
 
 
         #Ctrlp:input.c.bgbe013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe013
            #add-point:ON ACTION controlp INFIELD bgbe013 name="input.c.bgbe013"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe013
            LET g_qryparam.where = " rtax001 IN ( SELECT bgbd019 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_rtax001()
            LET g_bgbe_m.bgbe013 = g_qryparam.return1
            NEXT FIELD bgbe013
            #END add-point
 
 
         #Ctrlp:input.c.bgbe015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe015
            #add-point:ON ACTION controlp INFIELD bgbe015 name="input.c.bgbe015"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe015
            LET g_qryparam.where = " pjba001 IN ( SELECT bgbd021 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_pjba001()
            LET g_bgbe_m.bgbe015 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe015
            NEXT FIELD bgbe015
            #END add-point
 
 
         #Ctrlp:input.c.bgbe023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe023
            #add-point:ON ACTION controlp INFIELD bgbe023 name="input.c.bgbe023"
            #自由核算項四
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe023
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe023 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe023
                  NEXT FIELD bgbe023
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe028
            #add-point:ON ACTION controlp INFIELD bgbe028 name="input.c.bgbe028"
            #自由核算項九
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe028
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe028 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe028
                  NEXT FIELD bgbe028
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe009
            #add-point:ON ACTION controlp INFIELD bgbe009 name="input.c.bgbe009"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe009
            LET g_qryparam.where = " oocq002 IN ( SELECT bgbd015 FROM bgbd_t               ",
                                   "               WHERE bgbdent ='",g_enterprise,"'       ",
                                   "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                   "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                   "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                   "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                   "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                   "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') "
            CALL q_oocq002_287()
            LET g_bgbe_m.bgbe009 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe009
            NEXT FIELD bgbe009
            #END add-point
 
 
         #Ctrlp:input.c.bgbe017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe017
            #add-point:ON ACTION controlp INFIELD bgbe017 name="input.c.bgbe017"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbe016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe016
            #add-point:ON ACTION controlp INFIELD bgbe016 name="input.c.bgbe016"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbe_m.bgbe016
            IF NOT cl_null(g_bgbe_m.bgbe015) THEN
               LET g_qryparam.where = " pjbb002 IN ( SELECT bgbd022 FROM bgbd_t               ",
                                      "               WHERE bgbdent ='",g_enterprise,"'       ",
                                      "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                      "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                      "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                      "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                      "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                      "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') ",
                                      " AND pjbb012='1' AND pjbb001='",g_bgbe_m.bgbe015,"'"
            ELSE
               LET g_qryparam.where = " pjbb002 IN ( SELECT bgbd022 FROM bgbd_t               ",
                                      "               WHERE bgbdent ='",g_enterprise,"'       ",
                                      "                 AND bgbd001 = '",g_bgbe_m.bgbe001,"'  ",                    
                                      "                 AND bgbd002 = '",g_bgbe_m.bgbe002,"'  ",
                                      "                 AND bgbd003 = '",g_bgbe_m.bgbe003,"'  ",
                                      "                 AND to_char(bgbd004) = TRIM('",g_bgbe_m.bgbe006,"')  ",
                                      "                 AND to_char(bgbd006) = TRIM('",g_bgbe_m.bgbe031,"')  ",
                                      "                 AND bgbd007 = '",g_bgbe_m.bgbe004,"') ",
                                      "   AND pjbb012='1' "
            END IF
            CALL q_pjbb002()
            LET g_bgbe_m.bgbe016 = g_qryparam.return1
            DISPLAY BY NAME g_bgbe_m.bgbe016
            NEXT FIELD bgbe016
            #END add-point
 
 
         #Ctrlp:input.c.bgbe024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe024
            #add-point:ON ACTION controlp INFIELD bgbe024 name="input.c.bgbe024"
            #自由核算項五
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe024
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe024 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe024
                  NEXT FIELD bgbe024
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe029
            #add-point:ON ACTION controlp INFIELD bgbe029 name="input.c.bgbe029"
            #自由核算項十
            IF g_bgaa012 = 'Y' THEN　
               IF NOT cl_null(l_glae009) THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.state = "i"
                  LET g_qryparam.default1 = g_bgbe_m.bgbe029
                  IF l_glae009 = 'q_glaf002' THEN
                     LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
                  END IF
                  CALL q_agli041(l_glae009)
                  LET g_bgbe_m.bgbe029 = g_qryparam.return1
                  DISPLAY BY NAME g_bgbe_m.bgbe029
                  NEXT FIELD bgbe029
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bgbe030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbe030
            #add-point:ON ACTION controlp INFIELD bgbe030 name="input.c.bgbe030"
            
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
               SELECT COUNT(1) INTO l_count FROM bgbe_t
                WHERE bgbeent = g_enterprise AND bgbedocno = g_bgbe_m.bgbedocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_fin_gen_docno(g_glaald,'','',g_bgbe_m.bgbedocno,g_bgbe_m.bgbedocdt,g_prog)
                       RETURNING g_sub_success,g_bgbe_m.bgbedocno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_bgbe_m.bgbedocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD bgbedocno
                  END IF
                  DISPLAY BY NAME g_bgbe_m.bgbedocno
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO bgbe_t (bgbeent,bgbe001,bgbedocno,bgbedocdt,bgbe002,bgbe003,bgbe004,bgbe005, 
                      bgbestus,bgbe006,bgbe010,bgbe018,bgbe020,bgbe025,bgbe031,bgbe011,bgbe019,bgbe021, 
                      bgbe026,bgbe007,bgbe012,bgbe014,bgbe022,bgbe027,bgbe008,bgbe013,bgbe015,bgbe023, 
                      bgbe028,bgbe009,bgbe017,bgbe016,bgbe024,bgbe029,bgbe030,bgbeownid,bgbeowndp,bgbecrtid, 
                      bgbecrtdp,bgbecrtdt,bgbemodid,bgbemoddt,bgbecnfid,bgbecnfdt)
                  VALUES (g_enterprise,g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno,g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002, 
                      g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus,g_bgbe_m.bgbe006, 
                      g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031, 
                      g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007, 
                      g_bgbe_m.bgbe012,g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027,g_bgbe_m.bgbe008, 
                      g_bgbe_m.bgbe013,g_bgbe_m.bgbe015,g_bgbe_m.bgbe023,g_bgbe_m.bgbe028,g_bgbe_m.bgbe009, 
                      g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024,g_bgbe_m.bgbe029,g_bgbe_m.bgbe030, 
                      g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtdp,g_bgbe_m.bgbecrtdt, 
                      g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfdt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbe_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_bgbe_m.bgbedocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL abgt050_bgbe_t_mask_restore('restore_mask_o')
               
               UPDATE bgbe_t SET (bgbe001,bgbedocno,bgbedocdt,bgbe002,bgbe003,bgbe004,bgbe005,bgbestus, 
                   bgbe006,bgbe010,bgbe018,bgbe020,bgbe025,bgbe031,bgbe011,bgbe019,bgbe021,bgbe026,bgbe007, 
                   bgbe012,bgbe014,bgbe022,bgbe027,bgbe008,bgbe013,bgbe015,bgbe023,bgbe028,bgbe009,bgbe017, 
                   bgbe016,bgbe024,bgbe029,bgbe030,bgbeownid,bgbeowndp,bgbecrtid,bgbecrtdp,bgbecrtdt, 
                   bgbemodid,bgbemoddt,bgbecnfid,bgbecnfdt) = (g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno,g_bgbe_m.bgbedocdt, 
                   g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus, 
                   g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025, 
                   g_bgbe_m.bgbe031,g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026, 
                   g_bgbe_m.bgbe007,g_bgbe_m.bgbe012,g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027, 
                   g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015,g_bgbe_m.bgbe023,g_bgbe_m.bgbe028, 
                   g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024,g_bgbe_m.bgbe029, 
                   g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtdp, 
                   g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfdt) 
 
                WHERE bgbeent = g_enterprise AND bgbedocno = g_bgbedocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbe_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL abgt050_bgbe_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     CALL abgt050_show()
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_bgbe_m_t)
                     LET g_log2 = util.JSON.stringify(g_bgbe_m)
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
 
{<section id="abgt050.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt050_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bgbe_t.bgbedocno 
   DEFINE l_oldno     LIKE bgbe_t.bgbedocno 
 
   DEFINE l_master    RECORD LIKE bgbe_t.* #此變數樣板目前無使用
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
   IF g_bgbe_m.bgbedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_bgbedocno_t = g_bgbe_m.bgbedocno
 
   
   #清空key值
   LET g_bgbe_m.bgbedocno = ""
 
    
   CALL abgt050_set_entry("a")
   CALL abgt050_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgbe_m.bgbeownid = g_user
      LET g_bgbe_m.bgbeowndp = g_dept
      LET g_bgbe_m.bgbecrtid = g_user
      LET g_bgbe_m.bgbecrtdp = g_dept 
      LET g_bgbe_m.bgbecrtdt = cl_get_current()
      LET g_bgbe_m.bgbemodid = g_user
      LET g_bgbe_m.bgbemoddt = cl_get_current()
      LET g_bgbe_m.bgbestus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bgbe_m.bgbestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL abgt050_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_bgbe_m.* TO NULL
      CALL abgt050_show()
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
      LET g_errparam.extend = "bgbe_t:",SQLERRMESSAGE 
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
   CALL abgt050_set_act_visible()
   CALL abgt050_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgbedocno_t = g_bgbe_m.bgbedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgbeent = " ||g_enterprise|| " AND",
                      " bgbedocno = '", g_bgbe_m.bgbedocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt050_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_bgbe_m.bgbeownid      
   LET g_data_dept  = g_bgbe_m.bgbeowndp
              
   #功能已完成,通報訊息中心
   CALL abgt050_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.show" >}
#+ 資料顯示 
PRIVATE FUNCTION abgt050_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   #使用預算項目參照表/使用科目預算
   SELECT bgaa008,bgaa012
     INTO g_bgaa008,g_bgaa012
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bgbe_m.bgbe001
   SELECT glaald INTO g_glaald FROM glaa_t,ooef_t
         WHERE glaaent = g_enterprise
           AND glaacomp = ooef017
           AND glaaent = ooefent
           AND ooef001 = g_bgbe_m.bgbe003
           AND glaa014 = 'Y'
   CALL abgt050_ld_info(g_glaald)
   LET g_bgbe_m.glaa001 = g_glaa.glaa001
   IF g_bgaa012 = 'Y' THEN
      LET g_glac002 = g_bgbe_m.bgbe004
      LET g_bgbe_m.bgbe004_desc = s_desc_get_account_desc(g_glaald,g_bgbe_m.bgbe004)
   ELSE
      CALL abgt050_bg_to_acc(g_bgaa008,g_bgbe_m.bgbe004)RETURNING g_glac002
      LET g_bgbe_m.bgbe004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbe_m.bgbe004)
   END IF
   CALL s_fin_sel_glad(g_glaald,g_glac002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
   RETURNING g_errno,g_glad.*
   CALL abgt050_b_fill()
   LET g_bgbe_m.bgbe001_desc = s_desc_get_budget_desc(g_bgbe_m.bgbe001)
   LET g_bgbe_m.bgbe003_desc = s_desc_get_department_desc(g_bgbe_m.bgbe003)
   LET g_bgbe_m.bgbe007_desc = s_desc_get_department_desc(g_bgbe_m.bgbe007)
   LET g_bgbe_m.bgbe008_desc = s_desc_get_department_desc(g_bgbe_m.bgbe008)
   LET g_bgbe_m.bgbe009_desc = s_desc_get_acc_desc('287',g_bgbe_m.bgbe009)
   LET g_bgbe_m.bgbe010_desc = s_desc_get_trading_partner_abbr_desc(g_bgbe_m.bgbe010)
   LET g_bgbe_m.bgbe011_desc = s_desc_get_trading_partner_abbr_desc(g_bgbe_m.bgbe011)
   LET g_bgbe_m.bgbe012_desc = s_desc_get_acc_desc('281',g_bgbe_m.bgbe012)
   LET g_bgbe_m.bgbe013_desc = s_desc_get_rtaxl003_desc(g_bgbe_m.bgbe013)
   LET g_bgbe_m.bgbe014_desc = s_desc_get_person_desc(g_bgbe_m.bgbe014)
   LET g_bgbe_m.bgbe015_desc = s_desc_get_project_desc(g_bgbe_m.bgbe015)
   LET g_bgbe_m.bgbe016_desc = s_desc_get_pjbbl004_desc(g_bgbe_m.bgbe015,g_bgbe_m.bgbe016)
   LET g_bgbe_m.bgbe018_desc = s_desc_get_oojdl003_desc(g_bgbe_m.bgbe018)
   LET g_bgbe_m.bgbe019_desc = s_desc_get_acc_desc('2002',g_bgbe_m.bgbe019)
   LET g_bgbe_m.bgbe020_desc = s_fin_get_accting_desc(g_glad.glad0171,g_bgbe_m.bgbe020)
   LET g_bgbe_m.bgbe021_desc = s_fin_get_accting_desc(g_glad.glad0181,g_bgbe_m.bgbe021)
   LET g_bgbe_m.bgbe022_desc = s_fin_get_accting_desc(g_glad.glad0191,g_bgbe_m.bgbe022)
   LET g_bgbe_m.bgbe023_desc = s_fin_get_accting_desc(g_glad.glad0201,g_bgbe_m.bgbe023)
   LET g_bgbe_m.bgbe024_desc = s_fin_get_accting_desc(g_glad.glad0211,g_bgbe_m.bgbe024)
   LET g_bgbe_m.bgbe025_desc = s_fin_get_accting_desc(g_glad.glad0221,g_bgbe_m.bgbe025)
   LET g_bgbe_m.bgbe026_desc = s_fin_get_accting_desc(g_glad.glad0231,g_bgbe_m.bgbe026)
   LET g_bgbe_m.bgbe027_desc = s_fin_get_accting_desc(g_glad.glad0241,g_bgbe_m.bgbe027)
   LET g_bgbe_m.bgbe028_desc = s_fin_get_accting_desc(g_glad.glad0251,g_bgbe_m.bgbe028)
   LET g_bgbe_m.bgbe029_desc = s_fin_get_accting_desc(g_glad.glad0261,g_bgbe_m.bgbe029)
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt050_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bgbe_m.bgbe001,g_bgbe_m.bgbe001_desc,g_bgbe_m.bgbedocno,g_bgbe_m.glaa001,g_bgbe_m.bgbedocdt, 
       g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc, 
       g_bgbe_m.bgbe005,g_bgbe_m.bgbestus,g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe010_desc,g_bgbe_m.bgbe018, 
       g_bgbe_m.bgbe018_desc,g_bgbe_m.bgbe020,g_bgbe_m.bgbe020_desc,g_bgbe_m.bgbe025,g_bgbe_m.bgbe025_desc, 
       g_bgbe_m.bgbe031,g_bgbe_m.bgbe011,g_bgbe_m.bgbe011_desc,g_bgbe_m.bgbe019,g_bgbe_m.bgbe019_desc, 
       g_bgbe_m.bgbe021,g_bgbe_m.bgbe021_desc,g_bgbe_m.bgbe026,g_bgbe_m.bgbe026_desc,g_bgbe_m.bgbe007, 
       g_bgbe_m.bgbe007_desc,g_bgbe_m.bgbe012,g_bgbe_m.bgbe012_desc,g_bgbe_m.bgbe014,g_bgbe_m.bgbe014_desc, 
       g_bgbe_m.bgbe022,g_bgbe_m.bgbe022_desc,g_bgbe_m.bgbe027,g_bgbe_m.bgbe027_desc,g_bgbe_m.bgbe008, 
       g_bgbe_m.bgbe008_desc,g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc,g_bgbe_m.bgbe015,g_bgbe_m.bgbe015_desc, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe023_desc,g_bgbe_m.bgbe028,g_bgbe_m.bgbe028_desc,g_bgbe_m.bgbe009, 
       g_bgbe_m.bgbe009_desc,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe024_desc,g_bgbe_m.bgbe029,g_bgbe_m.bgbe029_desc,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtid_desc, 
       g_bgbe_m.bgbecrtdp,g_bgbe_m.bgbecrtdp_desc,g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemodid_desc, 
       g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfid_desc,g_bgbe_m.bgbecnfdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL abgt050_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bgbe_m.bgbestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION abgt050_delete()
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
   IF g_bgbe_m.bgbedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_bgbedocno_t = g_bgbe_m.bgbedocno
 
   
   
 
   OPEN abgt050_cl USING g_enterprise,g_bgbe_m.bgbedocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt050_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE abgt050_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt050_master_referesh USING g_bgbe_m.bgbedocno INTO g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno, 
       g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus, 
       g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031, 
       g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007,g_bgbe_m.bgbe012, 
       g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027,g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe028,g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe029,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtdp, 
       g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfdt, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid_desc,g_bgbe_m.bgbecrtdp_desc, 
       g_bgbe_m.bgbemodid_desc,g_bgbe_m.bgbecnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT abgt050_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bgbe_m_mask_o.* =  g_bgbe_m.*
   CALL abgt050_bgbe_t_mask()
   LET g_bgbe_m_mask_n.* =  g_bgbe_m.*
   
   #將最新資料顯示到畫面上
   CALL abgt050_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt050_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM bgbe_t 
       WHERE bgbeent = g_enterprise AND bgbedocno = g_bgbe_m.bgbedocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_bgbe_m.bgbedocno,g_bgbe_m.bgbedocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bgbe_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE abgt050_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL abgt050_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL abgt050_browser_fill(g_wc,"")
         CALL abgt050_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abgt050_cl
 
   #功能已完成,通報訊息中心
   CALL abgt050_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt050_ui_browser_refresh()
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
      IF g_browser[l_i].b_bgbedocno = g_bgbe_m.bgbedocno
 
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
 
{<section id="abgt050.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt050_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("bgbedocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("bgbe001,bgbe002,bgbe003,bgbedocdt",TRUE)
      CALL abgt050_bgbe_entry()
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt050_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
    DEFINE l_success  LIKE type_t.num5     #151130-00015#2 
   DEFINE l_slip     LIKE type_t.chr10  #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80 #151130-00015#2
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgbedocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
       CALL cl_set_comp_entry("bgbe001,bgbe002,bgbe003,bgbedocdt",FALSE)
       CALL abgt050_bgbe_noentry()
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
    #151130-00015#2 -begin -add by XZG 20151222
      IF NOT cl_null(g_bgbe_m.bgbedocno) THEN  
            #获取单别
            CALL s_aooi200_fin_get_slip(g_bgbe_m.bgbedocno) RETURNING l_success,l_slip
            #是否可改日期
            CALL s_fin_get_doc_para(g_glaald,g_bgbe_m.bgbe003,l_slip,'D-FIN-0033') RETURNING l_dfin0033
            IF l_dfin0033 = "N"  THEN 
               CALL cl_set_comp_entry("bgbedocdt",FALSE)
            ELSE 
               CALL cl_set_comp_entry("bgbedocdt",TRUE)
            END IF          
         END IF 
      #151130-00015#2  -end
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt050.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt050_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt050.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt050_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_bgbe_m.bgbestus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt050.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt050_default_search()
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
      LET ls_wc = ls_wc, " bgbedocno = '", g_argv[01], "' AND "
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
 
{<section id="abgt050.mask_functions" >}
&include "erp/abg/abgt050_mask.4gl"
 
{</section>}
 
{<section id="abgt050.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abgt050_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bgbe_m.bgbedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abgt050_cl USING g_enterprise,g_bgbe_m.bgbedocno
   IF STATUS THEN
      CLOSE abgt050_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt050_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abgt050_master_referesh USING g_bgbe_m.bgbedocno INTO g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno, 
       g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus, 
       g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031, 
       g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007,g_bgbe_m.bgbe012, 
       g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027,g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe028,g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe029,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtdp, 
       g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfdt, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid_desc,g_bgbe_m.bgbecrtdp_desc, 
       g_bgbe_m.bgbemodid_desc,g_bgbe_m.bgbecnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT abgt050_action_chk() THEN
      CLOSE abgt050_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgbe_m.bgbe001,g_bgbe_m.bgbe001_desc,g_bgbe_m.bgbedocno,g_bgbe_m.glaa001,g_bgbe_m.bgbedocdt, 
       g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc, 
       g_bgbe_m.bgbe005,g_bgbe_m.bgbestus,g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe010_desc,g_bgbe_m.bgbe018, 
       g_bgbe_m.bgbe018_desc,g_bgbe_m.bgbe020,g_bgbe_m.bgbe020_desc,g_bgbe_m.bgbe025,g_bgbe_m.bgbe025_desc, 
       g_bgbe_m.bgbe031,g_bgbe_m.bgbe011,g_bgbe_m.bgbe011_desc,g_bgbe_m.bgbe019,g_bgbe_m.bgbe019_desc, 
       g_bgbe_m.bgbe021,g_bgbe_m.bgbe021_desc,g_bgbe_m.bgbe026,g_bgbe_m.bgbe026_desc,g_bgbe_m.bgbe007, 
       g_bgbe_m.bgbe007_desc,g_bgbe_m.bgbe012,g_bgbe_m.bgbe012_desc,g_bgbe_m.bgbe014,g_bgbe_m.bgbe014_desc, 
       g_bgbe_m.bgbe022,g_bgbe_m.bgbe022_desc,g_bgbe_m.bgbe027,g_bgbe_m.bgbe027_desc,g_bgbe_m.bgbe008, 
       g_bgbe_m.bgbe008_desc,g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc,g_bgbe_m.bgbe015,g_bgbe_m.bgbe015_desc, 
       g_bgbe_m.bgbe023,g_bgbe_m.bgbe023_desc,g_bgbe_m.bgbe028,g_bgbe_m.bgbe028_desc,g_bgbe_m.bgbe009, 
       g_bgbe_m.bgbe009_desc,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc,g_bgbe_m.bgbe024, 
       g_bgbe_m.bgbe024_desc,g_bgbe_m.bgbe029,g_bgbe_m.bgbe029_desc,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid, 
       g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid,g_bgbe_m.bgbecrtid_desc, 
       g_bgbe_m.bgbecrtdp,g_bgbe_m.bgbecrtdp_desc,g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemodid_desc, 
       g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfid_desc,g_bgbe_m.bgbecnfdt
 
   CASE g_bgbe_m.bgbestus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bgbe_m.bgbestus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
      
      CASE g_bgbe_m.bgbestus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL s_transaction_end('N','0')      #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
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
      g_bgbe_m.bgbestus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgt050_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_abgt050_conf_chk(g_bgbe_m.bgbedocno,g_glac002)  THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN    #一定要RETURN,避免執行後面的UPDATE狀態的程式段
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')      #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_abgt050_conf_upd(g_bgbe_m.bgbedocno) THEN
               CALL s_transaction_end('N','0')   #避免transaction被卡住,所以 rollback 後 再顯示錯誤訊息
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      CALL s_abgt050_unconf_chk(g_bgbe_m.bgbedocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_abgt050_unconf_upd(g_bgbe_m.bgbedocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   
   #作廢
   IF lc_state = 'X' THEN
      CALL cl_err_collect_init()
      CALL s_abgt050_void_chk(g_bgbe_m.bgbedocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行取消作廢？
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_abgt050_void_upd(g_bgbe_m.bgbedocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL cl_err_collect_show()
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   
   
   
   
   
   
   #end add-point
   
   LET g_bgbe_m.bgbemodid = g_user
   LET g_bgbe_m.bgbemoddt = cl_get_current()
   LET g_bgbe_m.bgbestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bgbe_t 
      SET (bgbestus,bgbemodid,bgbemoddt) 
        = (g_bgbe_m.bgbestus,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt)     
    WHERE bgbeent = g_enterprise AND bgbedocno = g_bgbe_m.bgbedocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE abgt050_master_referesh USING g_bgbe_m.bgbedocno INTO g_bgbe_m.bgbe001,g_bgbe_m.bgbedocno, 
          g_bgbe_m.bgbedocdt,g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe004,g_bgbe_m.bgbe005,g_bgbe_m.bgbestus, 
          g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe018,g_bgbe_m.bgbe020,g_bgbe_m.bgbe025,g_bgbe_m.bgbe031, 
          g_bgbe_m.bgbe011,g_bgbe_m.bgbe019,g_bgbe_m.bgbe021,g_bgbe_m.bgbe026,g_bgbe_m.bgbe007,g_bgbe_m.bgbe012, 
          g_bgbe_m.bgbe014,g_bgbe_m.bgbe022,g_bgbe_m.bgbe027,g_bgbe_m.bgbe008,g_bgbe_m.bgbe013,g_bgbe_m.bgbe015, 
          g_bgbe_m.bgbe023,g_bgbe_m.bgbe028,g_bgbe_m.bgbe009,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe024, 
          g_bgbe_m.bgbe029,g_bgbe_m.bgbe030,g_bgbe_m.bgbeownid,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbecrtid, 
          g_bgbe_m.bgbecrtdp,g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid, 
          g_bgbe_m.bgbecnfdt,g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid_desc, 
          g_bgbe_m.bgbecrtdp_desc,g_bgbe_m.bgbemodid_desc,g_bgbe_m.bgbecnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bgbe_m.bgbe001,g_bgbe_m.bgbe001_desc,g_bgbe_m.bgbedocno,g_bgbe_m.glaa001,g_bgbe_m.bgbedocdt, 
          g_bgbe_m.bgbe002,g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc, 
          g_bgbe_m.bgbe005,g_bgbe_m.bgbestus,g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe010_desc, 
          g_bgbe_m.bgbe018,g_bgbe_m.bgbe018_desc,g_bgbe_m.bgbe020,g_bgbe_m.bgbe020_desc,g_bgbe_m.bgbe025, 
          g_bgbe_m.bgbe025_desc,g_bgbe_m.bgbe031,g_bgbe_m.bgbe011,g_bgbe_m.bgbe011_desc,g_bgbe_m.bgbe019, 
          g_bgbe_m.bgbe019_desc,g_bgbe_m.bgbe021,g_bgbe_m.bgbe021_desc,g_bgbe_m.bgbe026,g_bgbe_m.bgbe026_desc, 
          g_bgbe_m.bgbe007,g_bgbe_m.bgbe007_desc,g_bgbe_m.bgbe012,g_bgbe_m.bgbe012_desc,g_bgbe_m.bgbe014, 
          g_bgbe_m.bgbe014_desc,g_bgbe_m.bgbe022,g_bgbe_m.bgbe022_desc,g_bgbe_m.bgbe027,g_bgbe_m.bgbe027_desc, 
          g_bgbe_m.bgbe008,g_bgbe_m.bgbe008_desc,g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc,g_bgbe_m.bgbe015, 
          g_bgbe_m.bgbe015_desc,g_bgbe_m.bgbe023,g_bgbe_m.bgbe023_desc,g_bgbe_m.bgbe028,g_bgbe_m.bgbe028_desc, 
          g_bgbe_m.bgbe009,g_bgbe_m.bgbe009_desc,g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc, 
          g_bgbe_m.bgbe024,g_bgbe_m.bgbe024_desc,g_bgbe_m.bgbe029,g_bgbe_m.bgbe029_desc,g_bgbe_m.bgbe030, 
          g_bgbe_m.bgbeownid,g_bgbe_m.bgbeownid_desc,g_bgbe_m.bgbeowndp,g_bgbe_m.bgbeowndp_desc,g_bgbe_m.bgbecrtid, 
          g_bgbe_m.bgbecrtid_desc,g_bgbe_m.bgbecrtdp,g_bgbe_m.bgbecrtdp_desc,g_bgbe_m.bgbecrtdt,g_bgbe_m.bgbemodid, 
          g_bgbe_m.bgbemodid_desc,g_bgbe_m.bgbemoddt,g_bgbe_m.bgbecnfid,g_bgbe_m.bgbecnfid_desc,g_bgbe_m.bgbecnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   CALL abgt050_b_fill()
   #end add-point  
 
   CLOSE abgt050_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt050_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt050.signature" >}
   
 
{</section>}
 
{<section id="abgt050.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt050_set_pk_array()
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
   LET g_pk_array[1].values = g_bgbe_m.bgbedocno
   LET g_pk_array[1].column = 'bgbedocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt050.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="abgt050.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt050_msgcentre_notify(lc_state)
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
   CALL abgt050_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgbe_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt050.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abgt050_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#3  2016/08/25 By 07900  --add--s--
   SELECT bgbestus INTO g_bgbe_m.bgbestus
     FROM bgbe_t
    WHERE bgbeent = g_enterprise      
      AND bgbedocno = g_bgbe_m.bgbedocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_bgbe_m.bgbestus
        
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_bgbe_m.bgbedocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL abgt050_set_act_visible()
        CALL abgt050_set_act_no_visible()
        CALL abgt050_show()
        RETURN FALSE
     END IF
   END IF  
   #160818-00017#3  2016/08/25 By 07900  --add--e--
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abgt050.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 帳套相關資訊
# Memo...........:
# Usage..........: CALL abgt050_ld_info(p_ld)
# Date & Author..: 2015/08/07 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt050_ld_info(p_ld)
DEFINE p_ld   LIKE glaa_t.glaald

   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa004|glaa015|glaa019|glaa024|glaa102|glaa121|glaa001|glaa016|glaa020')
        RETURNING g_sub_success,g_glaa.*
        
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL abgt050_bgaa_bgae_bgaj_chk(p_bgaa001,p_bgae001,p_bgaj002)
# Date & Author..: 2015/08/07 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt050_bgaa_bgae_bgaj_chk(p_bgaa001,p_bgae001,p_bgaj002)
DEFINE p_bgaa001   LIKE bgaa_t.bgaa001 #預算編號
DEFINE p_bgae001   LIKE bgae_t.bgae001 #預算項目編碼
DEFINE p_bgaj002   LIKE bgaj_t.bgaj002 #預算組織
DEFINE r_errno     LIKE gzze_t.gzze001
DEFINE r_success   LIKE type_t.num5
DEFINE l_ooefstus  LIKE ooef_t.ooefstus
DEFINE l_bgaf012   LIKE bgaf_t.bgaf012
DEFINE l_bgaf013   LIKE bgaf_t.bgaf013

   LET r_errno = NULL   LET r_success = TRUE   LET l_ooefstus = NULL
   
   IF NOT cl_null(p_bgaj002)THEN
      #單獨檢查組織
      SELECT ooefstus INTO l_ooefstus
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = p_bgaj002
         
  　   IF SQLCA.SQLCODE = '100' THEN
          LET r_success = FALSE
          LET r_errno =　'aoo-00094'
          RETURN r_success,r_errno
  　   END IF   
  
       IF l_ooefstus != 'Y' THEN
          LET r_success = FALSE
          #LET r_errno = 'aoo-00095' #160318-00005#5 mark
          LET r_errno = 'sub-01302'  #160318-00005#5 add
          RETURN r_success,r_errno
       END IF     
   END IF
   
   IF NOT cl_null(p_bgaa001)THEN
      #單獨檢查預算編號
      CALL s_fin_budget_chk(p_bgaa001)RETURNING g_sub_success,g_errno
      LET g_errparam.exeprog = '' #160321-00016#23 add
      IF NOT g_sub_success THEN
         LET g_errparam.exeprog = 'abgi040' #160321-00016#23 add
         LET r_success = FALSE
         LET r_errno = g_errno
         RETURN r_success,r_errno
      END IF
   END IF
     
   IF NOT cl_null(p_bgaj002) AND NOT cl_null(p_bgaa001) THEN
      #檢查組織是否存在預算樹
      CALL s_abg_site_chk(p_bgaj002)RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno  = g_errno
         RETURN r_success,r_errno
      END IF
      
      #161006-00005#11   add---s
      #檢查預算編號下的組織
      CALL s_abg_bgai004_chk(p_bgaa001,p_bgaj002)RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno  = g_errno
         RETURN r_success,r_errno
      END IF
      #161006-00005#11   add---e
   END IF
   
   
   
   IF NOT cl_null(p_bgae001) AND NOT cl_null(p_bgaa001)THEN
      IF g_bgaa012 = 'Y' THEN
         IF NOT cl_null(p_bgaj002)THEN
            #科目檢合
            CALL s_aap_glac002_chk(p_bgae001,g_glaald) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               LET r_success = FALSE
               LET r_errno  = g_errno
               RETURN r_success,r_errno
            END IF
         END IF      
      ELSE
         #預算項目必須存在預算編號中的預算項目參照表中
         CALL s_abg_bgae001_chk(p_bgaa001,'',p_bgae001,'1')
            RETURNING g_sub_success,g_errno
         IF NOT g_sub_success THEN
            LET r_success = FALSE
            LET r_errno  = g_errno
            RETURN r_success,r_errno
         END IF
         #檢查abgi100存在並有效
         IF NOT cl_null(p_bgaj002) AND NOT cl_null(p_bgaa001)
            AND NOT cl_null(p_bgae001)THEN
            CALL s_abg_bgai_chk(p_bgaa001,p_bgaj002,p_bgae001)
               RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               LET r_success = FALSE
               LET r_errno = g_errno
               RETURN r_success,r_errno
            END IF                
         END IF              
      END IF
      #abgi260是否存在可挪用預算項目
      SELECT bgaf012,bgaf013 INTO l_bgaf012,l_bgaf013
        FROM bgaf_t   
       WHERE bgafent = g_enterprise
         AND bgaf001 = p_bgaj002
         AND bgaf004 = p_bgaa001
         AND bgaf007 = p_bgae001
         AND bgaf002 <= g_bgbe_m.bgbedocdt
         AND bgaf003 >= g_bgbe_m.bgbedocdt 
         AND bgaf013 = 'Y'   
  
      IF SQLCA.SQLCODE= '100' THEN
         LET r_success = FALSE
         LET r_errno = 'abg-00096'
         RETURN r_success,r_errno
      END IF   
      IF l_bgaf012 = 'N' THEN
         LET r_success = FALSE
         LET r_errno = 'abg-00098'
         RETURN r_success,r_errno
      END IF
      IF l_bgaf013 = 'N' THEN
         LET r_success = FALSE
         LET r_errno = 'abg-00097'
         RETURN r_success,r_errno
      END IF 
   END IF

   RETURN r_success,r_errno
   
END FUNCTION

################################################################################
# Descriptions...: 不走科目預算時，項目轉換成科目
# Memo...........:
# Usage..........: CALL abgt050_bg_to_acc(p_bglist,p_bg)
# Date & Author..: 2015/08/07 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt050_bg_to_acc(p_bglist,p_bg)
DEFINE p_bglist   LIKE bgaa_t.bgaa008
DEFINE p_bg       LIKE bgae_t.bgae001
DEFINE r_acc      LIKE glac_t.glac002
DEFINE l_acclist  LIKE glaa_t.glaa004
#取第一個符合在abgi140中的第一個會計科目
DEFINE l_sql      STRING

   LET r_acc = NULL

   LET l_acclist = NULL
   SELECT glaa004 INTO l_acclist FROM glaa_t
   WHERE glaaent = g_enterprise
     AND glaald = g_glaald

   LET l_sql = "SELECT bgao003 FROM bgao_t ",
               " WHERE bgaoent = ",g_enterprise," ",
               "   AND bgao001 = '",p_bglist,"' ",
               "   AND bgao002 = '",l_acclist,"' ",
               "   AND bgao004 = '",p_bg,"' "
   PREPARE sel_bgaop1 FROM l_sql
   DECLARE sel_bgaoc1 CURSOR FOR sel_bgaop1

   FOREACH sel_bgaoc1 INTO r_acc
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      EXIT FOREACH
   END FOREACH

   RETURN r_acc
   
END FUNCTION

################################################################################
# Descriptions...: 核算項欄位開啟
# Memo...........:
# Usage..........: CALL abgt050_bgbe_entry()
# Date & Author..: 2015/08/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt050_bgbe_entry()


   CALL cl_set_comp_entry('bgbe007,bgbe008,bgbe009,bgbe010,bgbe011',TRUE)
   CALL cl_set_comp_entry('bgbe012,bgbe013,bgbe014,bgbe015,bgbe016',TRUE)
   CALL cl_set_comp_entry('bgbe017,bgbe018,bgbe019,bgbe020,bgbe021',TRUE)
   CALL cl_set_comp_entry('bgbe022,bgbe023,bgbe024,bgbe025,bgbe026,bgbe027,bgbe028,bgbe029',TRUE)


END FUNCTION

################################################################################
# Descriptions...: 根據核算項關閉欄位
# Memo...........:
# Usage..........: CALL abgt050_bgbe_noentry()
# Date & Author..: 2015/08/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt050_bgbe_noentry()
DEFINE l_glad           RECORD LIKE glad_t.*                      
DEFINE l_bgae           RECORD LIKE bgae_t.*
DEFINE l_field STRING
   
   LET l_field = NULL
   SELECT * INTO l_bgae.* 
     FROM bgae_t 
    WHERE bgaeent = g_enterprise
      AND bgae006 = g_bgaa008
      AND bgae001 = g_bgbe_m.bgbe004
      
   #CALL s_fin_sel_glad(g_glaald,g_glac002,'ALL') RETURNING l_glad.*    #170220-00063#1 mark 目前不走科目預算段,因此取回glad先以mark處理
  
   IF g_bgaa012 = 'N' THEN    
      IF l_bgae.bgae015 ='N' THEN                               #部門
         LET l_field = 'bgbe007' 
         LET g_bgbe_m.bgbe007 = '' LET g_bgbe_m.bgbe007_desc = ''
      END IF
      IF l_bgae.bgae016 ='N' THEN                               #利潤中心
         LET l_field = l_field CLIPPED,",",'bgbe008' CLIPPED  
         LET g_bgbe_m.bgbe007 = '' LET g_bgbe_m.bgbe007_desc = '' 
      END IF
      IF l_bgae.bgae017 ='N' THEN                               #區域
         LET l_field = l_field CLIPPED,",",'bgbe009' CLIPPED
         LET g_bgbe_m.bgbe009 = '' LET g_bgbe_m.bgbe009_desc = '' 
      END IF
      IF l_bgae.bgae018 ='N' THEN                               #交易客商
         LET l_field = l_field CLIPPED,",",'bgbe010' CLIPPED 
         LET g_bgbe_m.bgbe009 = '' LET g_bgbe_m.bgbe009_desc = '' 
      END IF
      IF l_bgae.bgae019 ='N' THEN                               #收款客商
         LET l_field = l_field CLIPPED,",",'bgbe011' CLIPPED 
         LET g_bgbe_m.bgbe011 = '' LET g_bgbe_m.bgbe011_desc = ''
      END IF
      IF l_bgae.bgae020 ='N' THEN                               #客群
         LET l_field = l_field CLIPPED,",",'bgbe012' CLIPPED            
         LET g_bgbe_m.bgbe012 = '' LET g_bgbe_m.bgbe012_desc = ''
      END IF
      IF l_bgae.bgae021 ='N' THEN                               #產品類別
         LET l_field = l_field CLIPPED,",",'bgbe013' CLIPPED           
         LET g_bgbe_m.bgbe013 = '' LET g_bgbe_m.bgbe013_desc = ''
      END IF
      IF l_bgae.bgae022 ='N' THEN                               #人員
         LET l_field = l_field CLIPPED,",",'bgbe014' CLIPPED 
         LET g_bgbe_m.bgbe014 = '' LET g_bgbe_m.bgbe014_desc = ''  
      END IF
      IF l_bgae.bgae023 ='N' THEN                               #專案編號
         LET l_field = l_field CLIPPED,",",'bgbe015' CLIPPED 
         LET g_bgbe_m.bgbe015 = '' LET g_bgbe_m.bgbe015_desc = '' 
      END IF
      IF l_bgae.bgae024 ='N' THEN                               #WBS
         LET l_field = l_field CLIPPED,",",'bgbe016' CLIPPED 
         LET g_bgbe_m.bgbe016 = '' LET g_bgbe_m.bgbe016_desc = ''
      END IF
      IF l_bgae.bgae025 ='N' THEN                               #經營方式
         LET l_field = l_field CLIPPED,",",'bgbe017' CLIPPED 
         LET g_bgbe_m.bgbe017 = '' 
      END IF
      IF l_bgae.bgae040 ='N' THEN                               #渠道
         LET l_field = l_field CLIPPED,",",'bgbe018' CLIPPED 
         LET g_bgbe_m.bgbe018 = '' LET g_bgbe_m.bgbe018_desc = ''
      END IF
      IF l_bgae.bgae041 ='N' THEN                               #品牌
         LET l_field = l_field CLIPPED,",",'bgbe019' CLIPPED 
         LET g_bgbe_m.bgbe019 = '' LET g_bgbe_m.bgbe019_desc = ''
      END IF
      IF l_bgae.bgae026 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe020' CLIPPED 
         LET g_bgbe_m.bgbe020 = '' LET g_bgbe_m.bgbe020_desc = ''
     END IF
     IF l_bgae.bgae027 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe021' CLIPPED 
         LET g_bgbe_m.bgbe021 = '' LET g_bgbe_m.bgbe021_desc = ''
     END IF
     IF l_bgae.bgae028 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe022' CLIPPED 
         LET g_bgbe_m.bgbe022 = '' LET g_bgbe_m.bgbe022_desc = ''
     END IF
     IF l_bgae.bgae029 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe023' CLIPPED 
         LET g_bgbe_m.bgbe023 = '' LET g_bgbe_m.bgbe023_desc = ''
     END IF
     IF l_bgae.bgae030 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe024' CLIPPED 
         LET g_bgbe_m.bgbe024 = '' LET g_bgbe_m.bgbe024_desc = ''
     END IF
     IF l_bgae.bgae031 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe025' CLIPPED 
         LET g_bgbe_m.bgbe025 = '' LET g_bgbe_m.bgbe025_desc = ''
     END IF
     IF l_bgae.bgae032 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe026' CLIPPED 
         LET g_bgbe_m.bgbe026 = '' LET g_bgbe_m.bgbe026_desc = ''
     END IF
     IF l_bgae.bgae033 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe027' CLIPPED 
         LET g_bgbe_m.bgbe027 = '' LET g_bgbe_m.bgbe027_desc = ''
     END IF
     IF l_bgae.bgae034 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe028' CLIPPED 
         LET g_bgbe_m.bgbe028 = '' LET g_bgbe_m.bgbe028_desc = ''
     END IF
     IF l_bgae.bgae035 ='N' THEN                               #自由核算
         LET l_field = l_field CLIPPED,",",'bgbe025' CLIPPED 
         LET g_bgbe_m.bgbe029 = '' LET g_bgbe_m.bgbe029_desc = ''
     END IF                
   ELSE
      IF l_glad.glad007 = 'N' THEN                                     #部門
         LET l_field = 'bgbe007'  
         LET g_bgbe_m.bgbe007 = '' LET g_bgbe_m.bgbe007_desc = '' 
      END IF                                                         
      IF l_glad.glad008 = 'N' THEN                                     #利潤中心
         LET l_field = l_field CLIPPED,",",'bgbe008' CLIPPED 
         LET g_bgbe_m.bgbe008 = '' LET g_bgbe_m.bgbe008_desc = '' 
      END IF   
      IF l_glad.glad009 = 'N' THEN
         LET l_field = l_field CLIPPED,",",'bgbe009' CLIPPED           #區域
         LET g_bgbe_m.bgbe009 = '' LET g_bgbe_m.bgbe009_desc = ''    
      END IF   
      IF l_glad.glad010 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe010' CLIPPED          #交易客商
         LET g_bgbe_m.bgbe010 = '' LET g_bgbe_m.bgbe010_desc = ''
      END IF  
      IF l_glad.glad011 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe012' CLIPPED           #客群 
         LET g_bgbe_m.bgbe012 = '' LET g_bgbe_m.bgbe012_desc = ''
      END IF       
      IF l_glad.glad012 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe013' CLIPPED           #產品類別
         LET g_bgbe_m.bgbe013 = '' LET g_bgbe_m.bgbe013_desc = ''
      END IF   
      IF l_glad.glad013 = 'N' THEN                                     #業務人員  
         LET l_field = l_field CLIPPED,",",'bgbe014' CLIPPED 
         LET g_bgbe_m.bgbe014 = '' LET g_bgbe_m.bgbe014_desc = ''   
      END IF   
      IF l_glad.glad015 = 'N' THEN                                     #專案代號
         LET l_field = l_field CLIPPED,",",'bgbe015' CLIPPED 
         LET g_bgbe_m.bgbe015 = '' LET g_bgbe_m.bgbe015_desc = ''
      END IF   
      IF l_glad.glad016 = 'N' THEN                                     #WBS
         LET l_field = l_field CLIPPED,",",'bgbe016' CLIPPED 
         LET g_bgbe_m.bgbe016 = '' LET g_bgbe_m.bgbe016_desc = ''
      END IF   
      IF l_glad.glad027 = 'N' THEN                                     #帳款客商  
         LET l_field = l_field CLIPPED,",",'bgbe011' CLIPPED 
         LET g_bgbe_m.bgbe011 = '' LET g_bgbe_m.bgbe011_desc = ''
      END IF    
      IF l_glad.glad031 = 'N' THEN                                     #經營方式
         LET l_field = l_field CLIPPED,",",'bgbe017' CLIPPED 
         LET g_bgbe_m.bgbe017 = '' 
      END IF   
      IF l_glad.glad032 = 'N' THEN                                     #渠道
         LET l_field = l_field CLIPPED,",",'bgbe018' CLIPPED 
         LET g_bgbe_m.bgbe018 = '' LET g_bgbe_m.bgbe018_desc = ''
      END IF   
      IF l_glad.glad033 = 'N' THEN                                     #品牌   
         LET l_field = l_field CLIPPED,",",'bgbe019' CLIPPED 
         LET g_bgbe_m.bgbe019 = '' LET g_bgbe_m.bgbe019_desc = ''
      END IF   
      IF l_glad.glad017 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe020' CLIPPED 
         LET g_bgbe_m.bgbe020 = '' LET g_bgbe_m.bgbe020_desc = ''
      END IF  
      IF l_glad.glad018 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe021' CLIPPED 
         LET g_bgbe_m.bgbe021 = '' LET g_bgbe_m.bgbe021_desc = ''
      END IF  
      IF l_glad.glad019 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe022' CLIPPED 
         LET g_bgbe_m.bgbe022 = '' LET g_bgbe_m.bgbe022_desc = ''
      END IF  
      IF l_glad.glad020 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe023' CLIPPED 
         LET g_bgbe_m.bgbe023 = '' LET g_bgbe_m.bgbe023_desc = ''
      END IF  
      IF l_glad.glad021 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe024' CLIPPED 
         LET g_bgbe_m.bgbe024 = '' LET g_bgbe_m.bgbe024_desc = ''
      END IF  
      IF l_glad.glad022 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe025' CLIPPED 
         LET g_bgbe_m.bgbe025 = '' LET g_bgbe_m.bgbe025_desc = ''
      END IF  
      IF l_glad.glad023 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe026' CLIPPED 
         LET g_bgbe_m.bgbe026 = '' LET g_bgbe_m.bgbe026_desc = ''
      END IF  
      IF l_glad.glad024 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe027' CLIPPED 
         LET g_bgbe_m.bgbe027 = '' LET g_bgbe_m.bgbe027_desc = ''
      END IF  
      IF l_glad.glad025 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe028' CLIPPED 
         LET g_bgbe_m.bgbe028 = '' LET g_bgbe_m.bgbe028_desc = ''
      END IF  
      IF l_glad.glad026 = 'N' THEN 
         LET l_field = l_field CLIPPED,",",'bgbe029' CLIPPED 
         LET g_bgbe_m.bgbe029 = '' LET g_bgbe_m.bgbe029_desc = ''
      END IF  
   END IF
   
   
    DISPLAY BY NAME g_bgbe_m.bgbe003,g_bgbe_m.bgbe003_desc,g_bgbe_m.bgbedocno,g_bgbe_m.glaa001,g_bgbe_m.bgbedocdt, 
       g_bgbe_m.bgbe002,g_bgbe_m.bgbe001,g_bgbe_m.bgbe001_desc,g_bgbe_m.bgbe004,g_bgbe_m.bgbe004_desc, 
       g_bgbe_m.bgbe005,g_bgbe_m.bgbe006,g_bgbe_m.bgbe010,g_bgbe_m.bgbe010_desc,g_bgbe_m.bgbe018,g_bgbe_m.bgbe018_desc, 
       g_bgbe_m.bgbe020,g_bgbe_m.bgbe020_desc,g_bgbe_m.bgbe025,g_bgbe_m.bgbe025_desc,g_bgbe_m.bgbe031, 
       g_bgbe_m.bgbe011,g_bgbe_m.bgbe011_desc,g_bgbe_m.bgbe019,g_bgbe_m.bgbe019_desc,g_bgbe_m.bgbe021, 
       g_bgbe_m.bgbe021_desc,g_bgbe_m.bgbe026,g_bgbe_m.bgbe026_desc,g_bgbe_m.bgbe007,g_bgbe_m.bgbe007_desc, 
       g_bgbe_m.bgbe012,g_bgbe_m.bgbe012_desc,g_bgbe_m.bgbe014,g_bgbe_m.bgbe014_desc,g_bgbe_m.bgbe022, 
       g_bgbe_m.bgbe022_desc,g_bgbe_m.bgbe027,g_bgbe_m.bgbe027_desc,g_bgbe_m.bgbe008,g_bgbe_m.bgbe008_desc, 
       g_bgbe_m.bgbe013,g_bgbe_m.bgbe013_desc,g_bgbe_m.bgbe015,g_bgbe_m.bgbe015_desc,g_bgbe_m.bgbe023, 
       g_bgbe_m.bgbe023_desc,g_bgbe_m.bgbe028,g_bgbe_m.bgbe028_desc,g_bgbe_m.bgbe009,g_bgbe_m.bgbe009_desc, 
       g_bgbe_m.bgbe017,g_bgbe_m.bgbe016,g_bgbe_m.bgbe016_desc,g_bgbe_m.bgbe024,g_bgbe_m.bgbe024_desc, 
       g_bgbe_m.bgbe029,g_bgbe_m.bgbe029_desc,g_bgbe_m.bgbe030
   CALL cl_set_comp_entry(l_field,FALSE) 



END FUNCTION

################################################################################
# Descriptions...: 投資滾算
# Memo...........:
# Usage..........: CALL abgt050_b_fill()
# Date & Author..: 2015/08/12 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt050_b_fill()
DEFINE l_sql STRING
DEFINE l_idx         LIKE type_t.num10
DEFINE l_mon STRING
DEFINE l_bgbd012     LIKE bgbd_t.bgbd012
DEFINE l_acctype   LIKE type_t.chr1
DEFINE l_ld          LIKE glaa_t.glaald
#160127-00033#1-----s
DEFINE l_bgbd008     LIKE bgbd_t.bgbd008
#160127-00033#1-----e

   LET l_idx = 1
   #取得項目借貸方向
   CALL s_abg_bgae001_acctype(g_bgbe_m.bgbe001,g_bgbe_m.bgbe004) RETURNING l_acctype #1借2貸
   IF l_acctype = '2' THEN #貸余型態 貸-借
      LET l_mon = "SUM(bgbd012 - bgbd011 )"       
   ELSE
      LET l_mon = "SUM(bgbd011 - bgbd012 )"   
   END IF
   
   CALL  s_abgt050_get_key(g_bgbe_m.bgbedocno)RETURNING l_bgbd008   #albireo 160127-00033#1 

   
   CALL g_bgbd.clear()   
   LET l_sql = " SELECT bgbd003,'','', ",l_mon CLIPPED, 
               "        ,SUM(bgbd034),SUM(bgbd035),SUM(bgbd039-bgbd040),''  ", 
               "   FROM bgbd_t                                ",
               "  WHERE bgbdent = '",g_enterprise,"'          ",
               "    AND bgbd001 = '",g_bgbe_m.bgbe001,"'      ",
               "    AND bgbd002 = '",g_bgbe_m.bgbe002,"'      ",
               "    AND bgbd003 = '",g_bgbe_m.bgbe003,"'      ",
               "    AND bgbd004 = '",g_bgbe_m.bgbe006,"'      ",
               "    AND bgbd006 = '",g_bgbe_m.bgbe031,"'      ",
               "    AND bgbd007 = '",g_bgbe_m.bgbe004,"'      ",
               "    AND bgbd008 = ? ",   #albireo 160127-00033#1
               "  GROUP BY bgbd003                            "
                                                            
    PREPARE abgt050_prep FROM l_sql
    DECLARE abgt050_curs CURSOR FOR abgt050_prep
    FOREACH abgt050_curs USING l_bgbd008   ##albireo 160127-00033#1 add USING l_bgbd008
       INTO g_bgbd[l_idx].*
      LET g_bgbd[l_idx].budget = g_bgbd[l_idx].bgbd011 + g_bgbd[l_idx].bgbd034 -
                                 g_bgbd[l_idx].bgbd035 - g_bgbd[l_idx].usemoney
     
      LET g_bgbd[l_idx].bgbd003_desc = s_desc_get_department_desc(g_bgbd[l_idx].bgbd003)
      
      SELECT glaald INTO l_ld FROM glaa_t,ooef_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = ooef017
         AND glaaent  = ooefent
         AND ooef001  = g_bgbd[l_idx].bgbd003
         AND glaa014  = 'Y'
      CALL s_ld_sel_glaa(l_ld,'glaa001') RETURNING g_sub_success,g_bgbd[l_idx].curr
      
      LET l_idx = l_idx + 1
   END FOREACH
    

END FUNCTION

################################################################################
# Descriptions...: 預算項目是否存在abgi260
# Memo...........:
# Usage..........: CALL abgt050_bgbe003_chk(p_bgaf001,p_bgaf004,p_bgaf007,p_date,p_flag)
# Date & Author..: 2015/08/13 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt050_bgbe003_chk(p_bgaf001,p_bgaf004,p_bgaf007,p_date,p_flag)
DEFINE r_success      LIKE type_t.chr1
DEFINE r_error        LIKE gzze_t.gzze001
DEFINE p_bgaf001      LIKE bgaf_t.bgaf001  #組織
DEFINE p_bgaf004      LIKE bgaf_t.bgaf004  #預算編號
DEFINE p_bgaf007      LIKE bgaf_t.bgaf007  #項目
DEFINE p_date         LIKE bgaf_t.bgaf002  #日期
DEFINE p_flag         LIKE type_t.chr1     #檢查挪用或追加
DEFINE l_bgaf012      LIKE bgaf_t.bgaf012  #追加
DEFINE l_bgaf013      LIKE bgaf_t.bgaf013  #挪用 

  
  #預算項目是否存在
   SELECT bgaf012,bgaf013 
     INTO l_bgaf012,l_bgaf013
     FROM bgaf_t   
    WHERE bgafent = g_enterprise
      AND bgaf001 = p_bgaf001
      AND bgaf004 = p_bgaf004
      AND bgaf007 = p_bgaf007
      AND bgaf002 <= p_date
      AND bgaf003 >= p_date
      
   IF SQLCA.SQLCODE THEN
      LET r_success = FALSE
      LET r_error = 'abg-00096'
   END IF
   
   IF p_flag = '1' THEN
      IF l_bgaf012 = 'N' THEN
         LET r_success = FALSE
         LET r_error = 'abg-00098'
      END IF
   ELSE
      IF l_bgaf013 = 'N' THEN
         LET r_success = FALSE
         LET r_error = 'abg-00097'
      END IF
   END IF
   
   RETURN r_success,r_error





END FUNCTION

 
{</section>}
 
