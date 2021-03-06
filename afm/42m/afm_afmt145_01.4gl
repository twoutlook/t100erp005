#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt145_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-12-18 10:01:49), PR版次:0005(2017-01-06 19:39:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: afmt145_01
#+ Description: 整批產生
#+ Creator....: 02291(2015-12-16 09:30:36)
#+ Modifier...: 02291 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt145_01.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160302-00029#1  2016/03/13 By 01727   整批產生時抓融資到帳表中的默認摘要字段放入帳務表中
#160829-00019#1  2016/08/29 By Reanna  afmt185產生的資料沒有會科，但afmi020有設定，SQL有誤調整
#160822-00008#7  2016/08/29 By 08732   _t_o新舊值調整
#161006-00005#12 2016/10/19 By 08732   組織類型與職能開窗調整
#161104-00024#11 2016/11/08 By 08171   程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161104-00046#15 2017/01/03 By 08729   處理單別預設值
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
PRIVATE TYPE type_g_fmct_m RECORD
       fmctsite LIKE fmct_t.fmctsite, 
   fmctsite_desc LIKE type_t.chr80, 
   fmctld LIKE fmct_t.fmctld, 
   fmctld_desc LIKE type_t.chr80, 
   fmctdocno LIKE fmct_t.fmctdocno, 
   fmctcomp LIKE fmct_t.fmctcomp, 
   fmctdocdt LIKE fmct_t.fmctdocdt, 
   fmct001 LIKE fmct_t.fmct001
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_fmctdocno LIKE fmct_t.fmctdocno
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_glaa                RECORD LIKE glaa_t.* #161104-00024#11 mark
#161104-00024#11 --s add
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
END RECORD
#161104-00024#11 --e add
DEFINE g_fmct001             LIKE fmct_t.fmct001
DEFINE g_flag                LIKE type_t.chr1
DEFINE g_errno               LIKE type_t.chr100
DEFINE g_glav002             LIKE glav_t.glav002
DEFINE g_glav005             LIKE glav_t.glav005
DEFINE g_sdate_s             LIKE glav_t.glav004
DEFINE g_sdate_e             LIKE glav_t.glav004
DEFINE g_glav006             LIKE glav_t.glav006
DEFINE g_pdate_s             LIKE glav_t.glav004
DEFINE g_pdate_e             LIKE glav_t.glav004
DEFINE g_glav007             LIKE glav_t.glav007
DEFINE g_wdate_s             LIKE glav_t.glav004
DEFINE g_wdate_e             LIKE glav_t.glav004
DEFINE g_type1               LIKE type_t.chr10
DEFINE g_user_slip_wc        STRING              #161104-00046#15 add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fmct_m        type_g_fmct_m  #單頭變數宣告
DEFINE g_fmct_m_t      type_g_fmct_m  #單頭舊值宣告(系統還原用)
DEFINE g_fmct_m_o      type_g_fmct_m  #單頭舊值宣告(其他用途)
DEFINE g_fmct_m_mask_o type_g_fmct_m  #轉換遮罩前資料
DEFINE g_fmct_m_mask_n type_g_fmct_m  #轉換遮罩後資料
 
   DEFINE g_fmctdocno_t LIKE fmct_t.fmctdocno
 
   
 
   
 
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
 
{<section id="afmt145_01.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION afmt145_01(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_fmct001
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_fmct001      LIKE fmct_t.fmct001
   DEFINE l_flag1         LIKE type_t.num5   #161104-00046#15
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_fmct001 = p_fmct001
   #161104-00046#15 --s add
   #建立與單頭array相同的temptable
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc 
   #161104-00046#15 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = "SELECT fmctsite,'',fmctld,'',fmctdocno,fmctcomp,fmctdocdt,fmct001 FROM fmct_t  
       WHERE fmctent= ? AND fmctdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt145_01_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT t0.fmctsite,t0.fmctld,t0.fmctdocno,t0.fmctcomp,t0.fmctdocdt,t0.fmct001",
               " FROM fmct_t t0",
               " WHERE fmctent = " ||g_enterprise|| " AND t0.fmctdocno = ?"
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmt145_01_master_referesh FROM g_sql
   
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afmt145_01 WITH FORM cl_ap_formpath("afm","afmt145_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL afmt145_01_init()   
 
   #進入選單 Menu (="N")
   CALL afmt145_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_afmt145_01
 
   CLOSE afmt145_01_cl
   
   
 
   #add-point:離開前 name="main.exit"
   RETURN g_fmct_m.fmctdocno
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt145_01.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt145_01_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('fmct001','8874')
   CALL s_fin_create_account_center_tmp()
   CASE g_fmct001
      WHEN '01' LET g_prog = 'afmt145'
      WHEN '02' LET g_prog = 'afmt175'
      WHEN '03' LET g_prog = 'afmt185'
   END CASE
   CALL afmt145_01_fmctdocno_title()
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_fmct_m.* LIKE fmct_t.*             #DEFAULT 設定
   LET g_fmctdocno_t = NULL
   
   CALL s_transaction_begin()
   
   LET g_fmct_m.fmct001 = g_fmct001
   LET g_fmct_m.fmctdocdt = g_today
   LET g_fmct_m.fmctsite = g_site
   CALL s_fin_orga_get_comp_ld(g_fmct_m.fmctsite) RETURNING l_success,g_errno,g_fmct_m.fmctcomp,g_fmct_m.fmctld
   LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
   LET g_fmct_m.fmctld_desc = s_desc_get_ld_desc(g_fmct_m.fmctld)
   DISPLAY BY NAME g_fmct_m.fmct001,g_fmct_m.fmctdocdt,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
   DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
   SELECT * INTO g_glaa.* FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_fmct_m.fmctld
   LET g_fmct_m.fmctcomp = g_glaa.glaacomp
   CALL s_get_accdate(g_glaa.glaa003,g_fmct_m.fmctdocdt,'','')
    RETURNING g_flag,g_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
              g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
    
   CALL afmt145_01_input("a")
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afmt145_01_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmt145_01_ui_dialog() 
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
            CALL afmt145_01_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   RETURN
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fmct_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afmt145_01_init()
      END IF
      
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL afmt145_01_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmt145_01_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL afmt145_01_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmt145_01_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afmt145_01_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afmt145_01_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afmt145_01_fetch("L")  
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
                  CALL afmt145_01_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt145_01_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt145_01_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt145_01_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt145_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt145_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt145_01_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmct_m.fmctdocdt)
 
 
 
            
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
                  CALL afmt145_01_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afmt145_01_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afmt145_01_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
 
 
         
            
            
            #第一筆資料
            ON ACTION first
               CALL afmt145_01_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afmt145_01_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afmt145_01_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afmt145_01_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afmt145_01_fetch("L")  
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
                  CALL afmt145_01_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt145_01_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt145_01_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt145_01_insert()
               #add-point:ON ACTION insert name="menu.insert"
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt145_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt145_01_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt145_01_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fmct_m.fmctdocdt)
 
 
 
 
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
 
{<section id="afmt145_01.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afmt145_01_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "fmctdocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM fmct_t ",
               "  ",
               "  ",
               " WHERE fmctent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("fmct_t")
                
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
   
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_fmct_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.fmctstus,t0.fmctdocno",
               " FROM fmct_t t0 ",
               "  ",
               
               " WHERE t0.fmctent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("fmct_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmct_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmctdocno
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
   
   IF cl_null(g_browser[g_cnt].b_fmctdocno) THEN
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
 
{<section id="afmt145_01.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt145_01_construct()
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
   INITIALIZE g_fmct_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON fmctsite,fmctld,fmctdocno,fmctcomp,fmctdocdt,fmct001
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         
      
         #一般欄位
                  #Ctrlp:construct.c.fmctsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctsite
            #add-point:ON ACTION controlp INFIELD fmctsite name="construct.c.fmctsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#12   mark                    
            CALL q_ooef001_46()   #161006-00005#12   add
            DISPLAY g_qryparam.return1 TO fmctsite  #顯示到畫面上
            NEXT FIELD fmctsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctsite
            #add-point:BEFORE FIELD fmctsite name="construct.b.fmctsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctsite
            
            #add-point:AFTER FIELD fmctsite name="construct.a.fmctsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmctld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctld
            #add-point:ON ACTION controlp INFIELD fmctld name="construct.c.fmctld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmctld  #顯示到畫面上
            NEXT FIELD fmctld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctld
            #add-point:BEFORE FIELD fmctld name="construct.b.fmctld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctld
            
            #add-point:AFTER FIELD fmctld name="construct.a.fmctld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmctdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctdocno
            #add-point:ON ACTION controlp INFIELD fmctdocno name="construct.c.fmctdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fmctdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmctdocno  #顯示到畫面上
            NEXT FIELD fmctdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctdocno
            #add-point:BEFORE FIELD fmctdocno name="construct.b.fmctdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctdocno
            
            #add-point:AFTER FIELD fmctdocno name="construct.a.fmctdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmctcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctcomp
            #add-point:ON ACTION controlp INFIELD fmctcomp name="construct.c.fmctcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmctcomp  #顯示到畫面上
            NEXT FIELD fmctcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctcomp
            #add-point:BEFORE FIELD fmctcomp name="construct.b.fmctcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctcomp
            
            #add-point:AFTER FIELD fmctcomp name="construct.a.fmctcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctdocdt
            #add-point:BEFORE FIELD fmctdocdt name="construct.b.fmctdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctdocdt
            
            #add-point:AFTER FIELD fmctdocdt name="construct.a.fmctdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmctdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctdocdt
            #add-point:ON ACTION controlp INFIELD fmctdocdt name="construct.c.fmctdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmct001
            #add-point:BEFORE FIELD fmct001 name="construct.b.fmct001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmct001
            
            #add-point:AFTER FIELD fmct001 name="construct.a.fmct001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmct001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmct001
            #add-point:ON ACTION controlp INFIELD fmct001 name="construct.c.fmct001"
            
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
 
{<section id="afmt145_01.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt145_01_query()
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
 
   INITIALIZE g_fmct_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afmt145_01_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt145_01_browser_fill(g_wc,"F")
      CALL afmt145_01_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afmt145_01_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL afmt145_01_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt145_01_fetch(p_fl)
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
   
   
   CALL afmt145_01_browser_fill(g_wc,p_fl)
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_fmct_m.fmctdocno = g_browser[g_current_idx].b_fmctdocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afmt145_01_master_referesh USING g_fmct_m.fmctdocno INTO g_fmct_m.fmctsite,g_fmct_m.fmctld, 
       g_fmct_m.fmctdocno,g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001,g_fmct_m.fmctsite_desc, 
       g_fmct_m.fmctld_desc
   
   #遮罩相關處理
   LET g_fmct_m_mask_o.* =  g_fmct_m.*
   CALL afmt145_01_fmct_t_mask()
   LET g_fmct_m_mask_n.* =  g_fmct_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt145_01_set_act_visible()
   CALL afmt145_01_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_fmct_m_t.* = g_fmct_m.*
   LET g_fmct_m_o.* = g_fmct_m.*
   
   
   #重新顯示
   CALL afmt145_01_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt145_01_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_fmct_m.* TO NULL             #DEFAULT 設定
   LET g_fmctdocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fmct_m.fmct001 = "1"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_fmct_m.fmct001 = g_fmct001
      LET g_fmct_m.fmctdocdt = g_today
      LET g_fmct_m.fmctsite = g_site
      CALL s_fin_orga_get_comp_ld(g_fmct_m.fmctsite) RETURNING l_success,g_errno,g_fmct_m.fmctcomp,g_fmct_m.fmctld
      LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
      LET g_fmct_m.fmctld_desc = s_desc_get_ld_desc(g_fmct_m.fmctld)
      DISPLAY BY NAME g_fmct_m.fmct001,g_fmct_m.fmctdocdt,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
      DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
      SELECT * INTO g_glaa.* FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_fmct_m.fmctld
      LET g_fmct_m.fmctcomp = g_glaa.glaacomp
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL afmt145_01_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_fmct_m.* TO NULL
         CALL afmt145_01_show()
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
   CALL afmt145_01_set_act_visible()
   CALL afmt145_01_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmctdocno_t = g_fmct_m.fmctdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmctent = " ||g_enterprise|| " AND",
                      " fmctdocno = '", g_fmct_m.fmctdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt145_01_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt145_01_master_referesh USING g_fmct_m.fmctdocno INTO g_fmct_m.fmctsite,g_fmct_m.fmctld, 
       g_fmct_m.fmctdocno,g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001,g_fmct_m.fmctsite_desc, 
       g_fmct_m.fmctld_desc
   
   
   #遮罩相關處理
   LET g_fmct_m_mask_o.* =  g_fmct_m.*
   CALL afmt145_01_fmct_t_mask()
   LET g_fmct_m_mask_n.* =  g_fmct_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc,g_fmct_m.fmctdocno, 
       g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
 
   #功能已完成,通報訊息中心
   CALL afmt145_01_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt145_01_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fmct_m.fmctdocno IS NULL
 
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
   LET g_fmctdocno_t = g_fmct_m.fmctdocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afmt145_01_cl USING g_enterprise,g_fmct_m.fmctdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt145_01_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmt145_01_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt145_01_master_referesh USING g_fmct_m.fmctdocno INTO g_fmct_m.fmctsite,g_fmct_m.fmctld, 
       g_fmct_m.fmctdocno,g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001,g_fmct_m.fmctsite_desc, 
       g_fmct_m.fmctld_desc
 
   #檢查是否允許此動作
   IF NOT afmt145_01_action_chk() THEN
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fmct_m_mask_o.* =  g_fmct_m.*
   CALL afmt145_01_fmct_t_mask()
   LET g_fmct_m_mask_n.* =  g_fmct_m.*
   
   
 
   #顯示資料
   CALL afmt145_01_show()
   
   WHILE TRUE
      LET g_fmct_m.fmctdocno = g_fmctdocno_t
 
      
      #寫入修改者/修改日期資訊
      
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL afmt145_01_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_fmct_m.* = g_fmct_m_t.*
         CALL afmt145_01_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt145_01_set_act_visible()
   CALL afmt145_01_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmctent = " ||g_enterprise|| " AND",
                      " fmctdocno = '", g_fmct_m.fmctdocno, "' "
 
   #填到對應位置
   CALL afmt145_01_browser_fill(g_wc,"")
 
   CLOSE afmt145_01_cl
 
   #功能已完成,通報訊息中心
   CALL afmt145_01_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afmt145_01.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt145_01_input(p_cmd)
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
   DEFINE l_fmctstus      LIKE fmct_t.fmctstus
   DEFINE l_fmctownid     LIKE fmct_t.fmctownid 
   DEFINE l_fmctowndp     LIKE fmct_t.fmctowndp 
   DEFINE l_fmctcrtid     LIKE fmct_t.fmctcrtid 
   DEFINE l_fmctcrtdp     LIKE fmct_t.fmctcrtdp 
   DEFINE l_fmctcrtdt     LIKE fmct_t.fmctcrtdt
   DEFINE l_fmctmodid     LIKE fmct_t.fmctmodid
   DEFINE l_fmctmoddt     LIKE fmct_t.fmctmoddt
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_origin_str    STRING
   DEFINE  l_flag         LIKE type_t.num5    #161104-00046#15-add
   DEFINE  l_slip         LIKE ooba_t.ooba002 #161104-00046#15-add
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc,g_fmct_m.fmctdocno, 
       g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001
   
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
   CALL afmt145_01_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt145_01_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   CALL afmt145_01_input1(p_cmd)
   RETURN
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt, 
          g_fmct_m.fmct001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            LET g_fmct_m.fmct001 = g_fmct001
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctsite
            
            #add-point:AFTER FIELD fmctsite name="input.a.fmctsite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmct_m.fmctsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmct_m.fmctsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmct_m.fmctsite_desc

            IF NOT cl_null(g_fmct_m.fmctsite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmct_m.fmctsite != g_fmct_m_t.fmctsite OR g_fmct_m_t.fmctsite IS NULL )) THEN  #160822-00008#7  mark
               IF g_fmct_m.fmctsite != g_fmct_m_o.fmctsite OR cl_null(g_fmct_m_o.fmctsite) THEN                                      #160822-00008#7
                  CALL s_fin_account_center_sons_query('3',g_fmct_m.fmctsite,g_today,'1')
                  IF g_fmct_m.fmctsite != g_fmct_m_t.fmctsite OR cl_null(g_fmct_m_t.fmctsite) THEN
                    CALL s_fin_orga_get_comp_ld(g_fmct_m.fmctsite) RETURNING l_success,g_errno,g_fmct_m.fmctcomp,g_fmct_m.fmctld
                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_fmct_m.fmctsite,g_fmct_m.fmctld,g_user,'3','N','',g_fmct_m.fmctdocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_fmct_m.fmctsite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_fmct_m.fmctsite = g_fmct_m_t.fmctsite  #160822-00008#7  mark
                     #LET g_fmct_m.fmctld = g_fmct_m_t.fmctld      #160822-00008#7  mark
                     LET g_fmct_m.fmctsite = g_fmct_m_o.fmctsite   #160822-00008#7
                     LET g_fmct_m.fmctld = g_fmct_m_o.fmctld       #160822-00008#7
                     LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_anm_date_chk(g_fmct_m.fmctsite,g_fmct_m.fmctdocdt) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "afm-00207"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_fmct_m.fmctsite = g_fmct_m_t.fmctsite  #160822-00008#7  mark
                     #LET g_fmct_m.fmctld = g_fmct_m_t.fmctld      #160822-00008#7  mark
                     LET g_fmct_m.fmctsite = g_fmct_m_o.fmctsite   #160822-00008#7
                     LET g_fmct_m.fmctld = g_fmct_m_o.fmctld       #160822-00008#7
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
               DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
            END IF
            LET g_fmct_m_o.* = g_fmct_m.*    #160822-00008#7
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctsite
            #add-point:BEFORE FIELD fmctsite name="input.b.fmctsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmctsite
            #add-point:ON CHANGE fmctsite name="input.g.fmctsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctld
            
            #add-point:AFTER FIELD fmctld name="input.a.fmctld"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmct_m.fmctld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmct_m.fmctld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmct_m.fmctld_desc

           IF NOT cl_null(g_fmct_m.fmctld) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmct_m.fmctld != g_fmct_m_t.fmctld OR g_fmct_m_t.fmctld IS NULL )) THEN  #160822-00008#7  mark
               IF g_fmct_m.fmctld != g_fmct_m_o.fmctld OR cl_null(g_fmct_m_o.fmctld) THEN                                      #160822-00008#7
                  CALL s_fin_account_center_with_ld_chk(g_fmct_m.fmctsite,g_fmct_m.fmctld,g_user,'3','N','',g_fmct_m.fmctdocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_fmct_m.fmctsite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_fmct_m.fmctld = g_fmct_m_t.fmctld  #160822-00008#7  mark
                     LET g_fmct_m.fmctld = g_fmct_m_o.fmctld   #160822-00008#7
                     LET g_fmct_m.fmctld_desc = s_desc_get_ld_desc(g_fmct_m.fmctld)
                     DISPLAY BY NAME g_fmct_m.fmctld,g_fmct_m.fmctld_desc
                     NEXT FIELD CURRENT
                  END IF
                  SELECT * INTO g_glaa.* FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_fmct_m.fmctld
                  LET g_fmct_m.fmctcomp = g_glaa.glaacomp
               END IF
            END IF
            LET g_fmct_m_o.* = g_fmct_m.*    #160822-00008#7
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctld
            #add-point:BEFORE FIELD fmctld name="input.b.fmctld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmctld
            #add-point:ON CHANGE fmctld name="input.g.fmctld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctdocno
            #add-point:BEFORE FIELD fmctdocno name="input.b.fmctdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctdocno
            
            #add-point:AFTER FIELD fmctdocno name="input.a.fmctdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_fmct_m.fmctdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmct_m.fmctdocno != g_fmctdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmct_t WHERE "||"fmctent = '" ||g_enterprise|| "' AND "||"fmctdocno = '"||g_fmct_m.fmctdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_fmct_m.fmctdocno) THEN
                     CALL s_aooi200_fin_chk_slip(g_fmct_m.fmctld,g_glaa.glaa024,g_fmct_m.fmctdocno,g_prog) RETURNING l_success
                     IF l_success = FALSE THEN
                        LET g_fmct_m.fmctdocno = g_fmct_m_t.fmctdocno
                        NEXT FIELD fmctdocno
                     END IF
                     #161104-00046#15-----s
                     CALL s_aooi200_fin_get_slip(g_fmct_m.fmctdocno) RETURNING g_sub_success,l_slip
                     CALL s_control_chk_doc('1',g_fmct_m.fmctdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                     IF g_sub_success AND l_flag THEN             
                     ELSE
                        LET g_fmct_m.fmctdocno = g_fmct_m_o.fmctdocno 
                        NEXT FIELD CURRENT                  
                     END IF
                     #161104-00046#15-----e  
                  END IF
                  
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmctdocno
            #add-point:ON CHANGE fmctdocno name="input.g.fmctdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctcomp
            #add-point:BEFORE FIELD fmctcomp name="input.b.fmctcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctcomp
            
            #add-point:AFTER FIELD fmctcomp name="input.a.fmctcomp"
            LET g_fmct_m_o.* = g_fmct_m.*    #160822-00008#7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmctcomp
            #add-point:ON CHANGE fmctcomp name="input.g.fmctcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmctdocdt
            #add-point:BEFORE FIELD fmctdocdt name="input.b.fmctdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmctdocdt
            
            #add-point:AFTER FIELD fmctdocdt name="input.a.fmctdocdt"
            IF NOT cl_null(g_fmct_m.fmctdocdt) THEN
               CALL s_get_accdate(g_glaa.glaa003,g_fmct_m.fmctdocdt,'','')
                RETURNING g_flag,g_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
                          g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmctdocdt
            #add-point:ON CHANGE fmctdocdt name="input.g.fmctdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmct001
            #add-point:BEFORE FIELD fmct001 name="input.b.fmct001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmct001
            
            #add-point:AFTER FIELD fmct001 name="input.a.fmct001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmct001
            #add-point:ON CHANGE fmct001 name="input.g.fmct001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmctsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctsite
            #add-point:ON ACTION controlp INFIELD fmctsite name="input.c.fmctsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctsite             #給予default值
            LET g_qryparam.default2 = "" #g_fmct_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()     #161006-00005#12   mark                    
            CALL q_ooef001_46()   #161006-00005#12   add

            LET g_fmct_m.fmctsite = g_qryparam.return1              
            LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
            DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
            #LET g_fmct_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmct_m.fmctsite TO fmctsite              #
            #DISPLAY g_fmct_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmctsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmctld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctld
            #add-point:ON ACTION controlp INFIELD fmctld name="input.c.fmctld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctld             #給予default值

            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_fmct_m.fmctsite,g_fmct_m.fmctdocdt,'1')
            #取得帳務組織下所屬成員之帳別
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL afmt145_01_change_to_sql(l_origin_str) RETURNING l_origin_str

            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"

            #給予arg

            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_fmct_m.fmctld = g_qryparam.return1            
            LET g_fmct_m.fmctld_desc = s_desc_get_ld_desc(g_fmct_m.fmctld)
            DISPLAY BY NAME g_fmct_m.fmctld,g_fmct_m.fmctld_desc            
            SELECT * INTO g_glaa.* FROM glaa_t
              WHERE glaaent = g_enterprise
                AND glaald = g_fmct_m.fmctld

            DISPLAY g_fmct_m.fmctld TO fmctld              #

            NEXT FIELD fmctld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmctdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctdocno
            #add-point:ON ACTION controlp INFIELD fmctdocno name="input.c.fmctdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctdocno             #給予default值
            LET g_qryparam.where = "ooba001 = '",g_glaa.glaa024,"' AND oobx003 = '",g_prog,"'"

            #給予arg
            LET g_qryparam.arg1 = ""

            CALL q_ooba002_4()                                #呼叫開窗

            LET g_fmct_m.fmctdocno = g_qryparam.return1              

            DISPLAY g_fmct_m.fmctdocno TO fmctdocno              #

            NEXT FIELD fmctdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmctcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctcomp
            #add-point:ON ACTION controlp INFIELD fmctcomp name="input.c.fmctcomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctcomp             #給予default值
            LET g_qryparam.default2 = "" #g_fmct_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooef001()                                #呼叫開窗

            LET g_fmct_m.fmctcomp = g_qryparam.return1              
            #LET g_fmct_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmct_m.fmctcomp TO fmctcomp              #
            #DISPLAY g_fmct_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmctcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmctdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmctdocdt
            #add-point:ON ACTION controlp INFIELD fmctdocdt name="input.c.fmctdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmct001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmct001
            #add-point:ON ACTION controlp INFIELD fmct001 name="input.c.fmct001"
            
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
               SELECT COUNT(1) INTO l_count FROM fmct_t
                WHERE fmctent = g_enterprise AND fmctdocno = g_fmct_m.fmctdocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  LET g_success = 'Y'
                  CALL s_aooi200_fin_gen_docno(g_fmct_m.fmctld,g_glaa.glaa024,g_glaa.glaa003,g_fmct_m.fmctdocno,g_fmct_m.fmctdocdt,g_prog)
                        RETURNING l_success,g_fmct_m.fmctdocno
                  IF l_success  = 0  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_fmct_m.fmctdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_success = 'N'
                     NEXT FIELD fmctdocno
                  END IF
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO fmct_t (fmctent,fmctsite,fmctld,fmctdocno,fmctcomp,fmctdocdt,fmct001)
                  VALUES (g_enterprise,g_fmct_m.fmctsite,g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctcomp, 
                      g_fmct_m.fmctdocdt,g_fmct_m.fmct001) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
               
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmct_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  LET l_fmctownid = g_user
                  LET l_fmctowndp = g_dept
                  LET l_fmctcrtid = g_user
                  LET l_fmctcrtdp = g_dept 
                  LET l_fmctcrtdt = cl_get_current()
                  LET l_fmctmodid = g_user
                  LET l_fmctmoddt = cl_get_current()
                  LET l_fmctstus = 'N'
                  UPDATE fmct_t SET fmctownid = l_fmctownid,
                                    fmctowndp = l_fmctowndp,
                                    fmctcrtid = l_fmctcrtid,
                                    fmctcrtdp = l_fmctcrtdp,
                                    fmctcrtdt = l_fmctcrtdt,
                                    fmctmodid = l_fmctmodid,
                                    fmctmoddt = l_fmctmoddt,
                                    fmctstus  = l_fmctstus  
                   WHERE fmctent = g_enterprise AND fmctdocno = g_fmct_m.fmctdocno
                  
                  #end add-point
                  
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fmct_m.fmctdocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt145_01_fmct_t_mask_restore('restore_mask_o')
               
               UPDATE fmct_t SET (fmctsite,fmctld,fmctdocno,fmctcomp,fmctdocdt,fmct001) = (g_fmct_m.fmctsite, 
                   g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001) 
 
                WHERE fmctent = g_enterprise AND fmctdocno = g_fmctdocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmct_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmct_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afmt145_01_fmct_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_fmct_m_t)
                     LET g_log2 = util.JSON.stringify(g_fmct_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     ELSE
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      CONSTRUCT g_wc ON fmcrdocno FROM fmcrdocno
         ON ACTION controlp INFIELD fmcrdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CASE g_fmct001 
               WHEN '01' 
                  LET g_qryparam.where    = " fmcrstus = 'Y' AND fmcrdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
                                            "    AND fmcrdocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
                                            "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
                                            "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
                                            "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')"
                  CALL q_fmcrdocno()
               WHEN '02' 
                  LET g_qryparam.where    = " fmcvstus = 'Y' AND fmcvdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
                                            "    AND fmcvdocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
                                            "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
                                            "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
                                            "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')"
                  CALL q_fmcvdocno_01()
               WHEN '03' 
                  LET g_qryparam.where    = " fmcystus = 'Y' AND fmcydocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
                                            "    AND fmcydocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
                                            "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
                                            "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
                                            "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')"
                  CALL q_fmcydocno()
            END CASE
            DISPLAY g_qryparam.return1 to fmcrdocno
            NEXT FIELD fmcrdocno
      END CONSTRUCT
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
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CALL s_transaction_end('N','0')
      DELETE FROM fmct_t WHERE fmctent = g_enterprise AND fmctdocno = g_fmct_m.fmctdocno
      RETURN
   END IF
   IF cl_null(g_wc) OR g_wc = " 1=2" THEN LET g_wc = " 1=1" END IF
   CASE g_fmct001 
      WHEN '01' CALL afmt145_01_ins_fmcu()
      WHEN '02' CALL afmt145_01_ins_fmcu_02()
      WHEN '03' CALL afmt145_01_ins_fmcu_03()
   END CASE

   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
   ELSE
      CALL s_transaction_end('N','1')
      DELETE FROM fmct_t WHERE fmctent = g_enterprise AND fmctdocno = g_fmct_m.fmctdocno
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt145_01_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fmct_t.fmctdocno 
   DEFINE l_oldno     LIKE fmct_t.fmctdocno 
 
   DEFINE l_master    RECORD LIKE fmct_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_fmct_m.fmctdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_fmctdocno_t = g_fmct_m.fmctdocno
 
   
   #清空key值
   LET g_fmct_m.fmctdocno = ""
 
    
   CALL afmt145_01_set_entry("a")
   CALL afmt145_01_set_no_entry("a")
   
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL afmt145_01_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_fmct_m.* TO NULL
      CALL afmt145_01_show()
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
      LET g_errparam.extend = "fmct_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afmt145_01_set_act_visible()
   CALL afmt145_01_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmctdocno_t = g_fmct_m.fmctdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmctent = " ||g_enterprise|| " AND",
                      " fmctdocno = '", g_fmct_m.fmctdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt145_01_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
              
   #功能已完成,通報訊息中心
   CALL afmt145_01_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afmt145_01_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt145_01_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc,g_fmct_m.fmctdocno, 
       g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afmt145_01_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afmt145_01_delete()
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
   IF g_fmct_m.fmctdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_fmctdocno_t = g_fmct_m.fmctdocno
 
   
   
 
   OPEN afmt145_01_cl USING g_enterprise,g_fmct_m.fmctdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt145_01_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afmt145_01_cl
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt145_01_master_referesh USING g_fmct_m.fmctdocno INTO g_fmct_m.fmctsite,g_fmct_m.fmctld, 
       g_fmct_m.fmctdocno,g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001,g_fmct_m.fmctsite_desc, 
       g_fmct_m.fmctld_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt145_01_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmct_m_mask_o.* =  g_fmct_m.*
   CALL afmt145_01_fmct_t_mask()
   LET g_fmct_m_mask_n.* =  g_fmct_m.*
   
   #將最新資料顯示到畫面上
   CALL afmt145_01_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt145_01_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM fmct_t 
       WHERE fmctent = g_enterprise AND fmctdocno = g_fmct_m.fmctdocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmct_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fmct_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afmt145_01_cl
         RETURN
      END IF
      
      CLEAR FORM
      CALL afmt145_01_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afmt145_01_browser_fill(g_wc,"")
         CALL afmt145_01_fetch("P")
      ELSE
         CLEAR FORM
      END IF
   ELSE    
   END IF
 
   CLOSE afmt145_01_cl
 
   #功能已完成,通報訊息中心
   CALL afmt145_01_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt145_01_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmctdocno = g_fmct_m.fmctdocno
 
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
 
{<section id="afmt145_01.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt145_01_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("fmctdocno",TRUE)
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
 
{<section id="afmt145_01.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt145_01_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmctdocno",FALSE)
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
 
{<section id="afmt145_01.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt145_01_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt145_01_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt145_01_default_search()
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
      LET ls_wc = ls_wc, " fmctdocno = '", g_argv[01], "' AND "
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
 
{<section id="afmt145_01.mask_functions" >}
&include "erp/afm/afmt145_01_mask.4gl"
 
{</section>}
 
{<section id="afmt145_01.state_change" >}
   
 
{</section>}
 
{<section id="afmt145_01.signature" >}
   
 
{</section>}
 
{<section id="afmt145_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt145_01_set_pk_array()
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
   LET g_pk_array[1].values = g_fmct_m.fmctdocno
   LET g_pk_array[1].column = 'fmctdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt145_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afmt145_01.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt145_01_msgcentre_notify(lc_state)
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
   CALL afmt145_01_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmct_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt145_01.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt145_01_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt145_01.other_function" readonly="Y" >}

# 將取回的字串轉換為SQL條件
PRIVATE FUNCTION afmt145_01_change_to_sql(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: 将融资到账资料插入fmcu_t
# Memo...........:
# Usage..........: CALL afmt145_01_ins_fmcu()
# Date & Author..: 2015/12/17 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt145_01_ins_fmcu()
DEFINE l_sql             STRING
DEFINE l_n               LIKE type_t.num5
DEFINE l_fmcsdocno       LIKE fmcs_t.fmcsdocno
DEFINE l_fmcsseq         LIKE fmcs_t.fmcsseq
DEFINE l_fmcs001         LIKE fmcs_t.fmcs001
DEFINE l_fmcs002         LIKE fmcs_t.fmcs002
DEFINE l_fmcs003         LIKE fmcs_t.fmcs003
DEFINE l_fmcs004         LIKE fmcs_t.fmcs004
DEFINE l_fmcs005         LIKE fmcs_t.fmcs005
DEFINE l_fmcs006         LIKE fmcs_t.fmcs006
DEFINE l_fmcs007         LIKE fmcs_t.fmcs007
DEFINE l_fmcs008_1       LIKE fmcs_t.fmcs008
DEFINE l_fmcs008         LIKE fmcs_t.fmcs008
DEFINE l_fmcs009         LIKE fmcs_t.fmcs009
DEFINE l_fmcs010         LIKE fmcs_t.fmcs010
DEFINE l_fmcs011         LIKE fmcs_t.fmcs011
DEFINE l_fmcs012         LIKE fmcs_t.fmcs012
DEFINE l_fmcs013         LIKE fmcs_t.fmcs013
DEFINE l_fmcs014         LIKE fmcs_t.fmcs014
DEFINE l_fmcuseq         LIKE fmcu_t.fmcuseq
DEFINE l_fmcj001         LIKE fmcj_t.fmcj001
DEFINE l_fmab003         LIKE fmab_t.fmab003
DEFINE l_fmab004         LIKE fmab_t.fmab004
DEFINE l_fmab005         LIKE fmab_t.fmab005
DEFINE l_fmab006         LIKE fmab_t.fmab006
DEFINE l_fmab007         LIKE fmab_t.fmab007
DEFINE l_fmab008         LIKE fmab_t.fmab008
DEFINE l_fmab011         LIKE fmab_t.fmab011
DEFINE l_fmcq008         LIKE fmcq_t.fmcq008
DEFINE l_fmcu012         LIKE fmcu_t.fmcu012
DEFINE l_fmcu013         LIKE fmcu_t.fmcu013
DEFINE l_fmdcseq2        LIKE fmdc_t.fmdcseq2
DEFINE l_fmdc004         LIKE fmdc_t.fmdc004
DEFINE l_fmdc006         LIKE fmdc_t.fmdc006 
DEFINE l_fmdc009         LIKE fmdc_t.fmdc009 
DEFINE l_fmdc010         LIKE fmdc_t.fmdc010 
DEFINE l_fmdc011         LIKE fmdc_t.fmdc011 
DEFINE l_fmdc012         LIKE fmdc_t.fmdc012 
DEFINE l_fmdc013         LIKE fmdc_t.fmdc013 
DEFINE l_fmdc014         LIKE fmdc_t.fmdc014 
DEFINE l_fmdc016         LIKE fmdc_t.fmdc016 
DEFINE l_fmdc015         LIKE fmdc_t.fmdc015
DEFINE l_fmdc003         LIKE fmdc_t.fmdc003
DEFINE l_fmaa003         LIKE fmaa_t.fmaa003
DEFINE l_fmcs021         LIKE fmcs_t.fmcs021   #160302-00029#1  Add
   
   LET l_n = 0 
   LET g_wc = cl_replace_str(g_wc,'fmcydocno','fmcrdocno')
   LET l_sql = " SELECT COUNT(*) FROM fmcu_t ",
               "  WHERE fmcuent = ",g_enterprise ,
               "    AND fmcu003 IN(SELECT fmcrdocno FROM fmcr_t WHERE fmcrent = ",g_enterprise,
               "    AND fmcrstus = 'Y' AND fmcrsite = '",g_fmct_m.fmctcomp,"')",
               "    AND fmct001 = '01' AND ",g_wc CLIPPED
   PREPARE fmcu_count_prep FROM l_sql
   EXECUTE fmcu_count_prep INTO l_n
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afm-00219'
      LET g_errparam.extend = g_fmct_m.fmctcomp
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   
   LET l_sql = " SELECT fmdcseq2,fmdc004,fmdc006,fmdc009,fmdc010,fmdc011,fmdc012,fmdc013,fmdc014,fmdc003,fmdc015,fmdc016",
               "   FROM fmdc_t,fmcr_t ",
               "  WHERE fmdcent = fmcrent AND fmdcdocno = fmcrdocno ",
               "    AND fmdcent = ",g_enterprise," AND fmcrstus = 'Y' ",
               "    AND fmcrcomp = '",g_fmct_m.fmctcomp,"' AND fmdcdocno = ? ",
               "    AND fmdcseq = ?"
   PREPARE fmdc_ins_prep FROM l_sql
   DECLARE fmdc_ins_curs CURSOR FOR fmdc_ins_prep
   
   LET l_sql = " SELECT fmcsdocno,fmcsseq,fmcs001,fmcs002,fmcs003,fmcs004,fmcs005,fmcs006,fmcs007,",
               "        fmcs008,fmcs009,fmcs010,fmcs011,fmcs012,fmcs013,fmcs014 FROM fmcs_t,fmcr_t ",
               "  WHERE fmcsent = fmcrent AND fmcsdocno = fmcrdocno ",
               "    AND fmcsent = ",g_enterprise," AND fmcrstus = 'Y' ",
               "    AND fmcrcomp = '",g_fmct_m.fmctcomp,"'",
               "    AND fmcrdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
               "    AND fmcrdocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
               "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
               "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
               "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')",
               "    AND ",g_wc CLIPPED
   PREPARE fmcs_ins_prep FROM l_sql
   DECLARE fmcs_ins_curs CURSOR FOR fmcs_ins_prep
   
   FOREACH fmcs_ins_curs INTO l_fmcsdocno,l_fmcsseq,l_fmcs001,l_fmcs002,l_fmcs003,l_fmcs004,l_fmcs005,
                              l_fmcs006,l_fmcs007,l_fmcs008,l_fmcs009,l_fmcs010,l_fmcs011,l_fmcs012,
                              l_fmcs013,l_fmcs014
     
     SELECT MAX(fmcuseq) INTO l_fmcuseq
        FROM fmcu_t
       WHERE fmcuent = g_enterprise
         AND fmcudocno = g_fmct_m.fmctdocno
      
      IF cl_null(l_fmcuseq) THEN
         LET l_fmcuseq = 1
      ELSE
         LET l_fmcuseq = l_fmcuseq + 1
      END IF

     #160302-00029#1  Add  ---(S)---
      SELECT fmcs021 INTO l_fmcs021 FROM fmcs_t WHERE fmcsent = g_enterprise
         AND fmcsdocno = l_fmcsdocno
         AND fmcsseq   = l_fmcsseq
     #160302-00029#1  Add  ---(E)---

      #融资类型
      SELECT fmcj001 INTO l_fmcj001 FROM fmcj_t
       WHERE fmcjent = g_enterprise AND fmcjdocno = l_fmcs001
      #类别
      SELECT fmaa003 INTO l_fmaa003 FROM fmaa_t
       WHERE fmaaent = g_enterprise AND fmaa001 = l_fmcj001
      
      #科目,afmi020中的融资本金面值科目
      SELECT fmab003,fmab004,fmab005,fmab006,fmab007,fmab008,fmab011 
        INTO l_fmab003,l_fmab004,l_fmab005,l_fmab006,l_fmab007,l_fmab008,l_fmab011 FROM fmab_t
       WHERE fmabent = g_enterprise AND fmab001 = l_fmcj001
         AND fmab002 = g_glaa.glaa004 AND fmabstus = 'Y'
      #对方科目，anmi121
      SELECT glab005 INTO l_fmcu013 FROM glab_t
       WHERE glabent = g_enterprise AND glabld = g_fmct_m.fmctld
         AND glab001 = '40' AND glab002 = '40'
         AND glab003 = l_fmcs004
      
      LET l_fmcu012 = l_fmab003
      IF cl_null(l_fmcs008) THEN LET l_fmcs008 = 0 END IF
      #5.发行债券
      IF l_fmaa003 = '5' THEN
         #金额取法：
         #融资到帐  到帐档 单身项次对应的融资合同融资清单的债券明细  合计金额（融资到账单单身的融资合同+项次取afmt035_02的债券本金总额fmcq008）
         SELECT SUM(fmcq008) INTO l_fmcq008 FROM fmcq_t
          WHERE fmcqent = g_enterprise AND fmcqdocno = l_fmcsdocno
            AND fmcqseq = l_fmcsseq
         IF cl_null(l_fmcq008) THEN LET l_fmcq008 = 0 END IF
         LET l_fmcs008 = l_fmcs008 - l_fmcq008  #利息调整金额
         LET l_fmcs008_1 = l_fmcq008  #融资到账金额
      ELSE
         LET l_fmcs008_1 = l_fmcs008
      END IF
      #融资到账单
      INSERT INTO fmcu_t(fmcuent,fmcudocno,fmcuseq,fmcu001,fmcu002,fmcu003,fmcu004,fmcu005,fmcu006,fmcu007,
                         fmcu008,fmcu009,fmcu010,fmcu011,fmcu014,fmcu015,fmcu016,fmcu017,fmcu012,fmcu013,
                         fmcu045     #160302-00029#1 Add
                         )
                  VALUES(g_enterprise,g_fmct_m.fmctdocno,l_fmcuseq,l_fmcs003,'01',l_fmcsdocno,l_fmcsseq,'',l_fmcs005,
                         l_fmcs006,l_fmcs007,l_fmcs008_1,l_fmcs009,l_fmcs010,l_fmcs011,l_fmcs012,l_fmcs013,l_fmcs014,
                         l_fmcu012,l_fmcu013,
                         l_fmcs021   #160302-00029#1 Add
                         )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "fmcu_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      
      #5.发行债券
      IF l_fmaa003 = '5' THEN
         #金额取法：
         #融资到帐  到帐档 单身项次对应的融资合同融资清单的债券明细  合计金额（融资到账单单身的融资合同+项次取afmt035_02的债券本金总额fmcq008）
         SELECT MAX(fmcuseq) INTO l_fmcuseq
           FROM fmcu_t
          WHERE fmcuent = g_enterprise
            AND fmcudocno = g_fmct_m.fmctdocno
         
         IF cl_null(l_fmcuseq) THEN
            LET l_fmcuseq = 1
         ELSE
            LET l_fmcuseq = l_fmcuseq + 1
         END IF
         #利息调整
         INSERT INTO fmcu_t(fmcuent,fmcudocno,fmcuseq,fmcu001,fmcu002,fmcu003,fmcu004,fmcu005,fmcu006,fmcu007,
                            fmcu008,fmcu009,fmcu010,fmcu011,fmcu014,fmcu015,fmcu016,fmcu017,fmcu012,fmcu013)
                     VALUES(g_enterprise,g_fmct_m.fmctdocno,l_fmcuseq,l_fmcs003,'07',l_fmcsdocno,l_fmcsseq,'',l_fmcs005,
                            l_fmcs006,l_fmcs007,l_fmcs008,l_fmcs009,l_fmcs010,l_fmcs011,l_fmcs012,l_fmcs013,l_fmcs014,
                            l_fmab004,'')
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "fmcu_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
      END IF
      
      #融资费用
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM fmdc_t WHERE fmdcent = g_enterprise AND fmdcdocno = l_fmcsdocno AND fmdcseq = l_fmcsseq
      IF l_n = 0 THEN
         CONTINUE FOREACH
      END IF
      
      FOREACH fmdc_ins_curs USING l_fmcsdocno,l_fmcsseq INTO l_fmdcseq2,l_fmdc004,l_fmdc006,l_fmdc009,l_fmdc010,
                                 l_fmdc011,l_fmdc012,l_fmdc013,l_fmdc014,l_fmdc003,l_fmdc015,l_fmdc016
         
         SELECT MAX(fmcuseq) INTO l_fmcuseq
           FROM fmcu_t
          WHERE fmcuent = g_enterprise
            AND fmcudocno = g_fmct_m.fmctdocno
         
         IF cl_null(l_fmcuseq) THEN
            LET l_fmcuseq = 1
         ELSE
            LET l_fmcuseq = l_fmcuseq + 1
         END IF
         
         LET l_fmcu012 = ''
         #科目,根据费用种类，取afmi020科目
         CASE l_fmdc003
            WHEN '1' LET l_fmcu012 = l_fmab005
            WHEN '2' LET l_fmcu012 = l_fmab006
            WHEN '3' LET l_fmcu012 = l_fmab007
            WHEN '4' LET l_fmcu012 = l_fmab008
            WHEN '5' LET l_fmcu012 = l_fmab011
         END CASE
         INSERT INTO fmcu_t(fmcuent,fmcudocno,fmcuseq,fmcu001,fmcu002,fmcu003,fmcu004,fmcu005,fmcu006,fmcu007,
                            fmcu008,fmcu009,fmcu010,fmcu011,fmcu014,fmcu015,fmcu016,fmcu017,fmcu012,fmcu013)
                     VALUES(g_enterprise,g_fmct_m.fmctdocno,l_fmcuseq,l_fmcs003,'02',l_fmcsdocno,l_fmcsseq,l_fmdcseq2,
                            l_fmdc015,l_fmdc016,l_fmdc004,l_fmdc006,l_fmdc009,l_fmdc010,l_fmdc011,l_fmdc012,l_fmdc013,
                            l_fmdc014,l_fmcu012,l_fmcu013)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "fmcu_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
      END FOREACH 
      
   END FOREACH
   RETURN 
END FUNCTION

################################################################################
# Descriptions...: 将计提利息资料插入fmcu_t
# Memo...........:
# Usage..........: CALL afmt145_01_ins_fmcu_03()
# Date & Author..: 2016/01/05 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt145_01_ins_fmcu_03()
DEFINE l_sql             STRING
DEFINE l_n               LIKE type_t.num5
DEFINE l_fmaa003         LIKE fmaa_t.fmaa003
DEFINE l_fmcj001         LIKE fmcj_t.fmcj001
DEFINE l_fmcuseq         LIKE fmcu_t.fmcuseq
DEFINE l_fmcu009         LIKE fmcu_t.fmcu009
DEFINE l_fmcu012         LIKE fmcu_t.fmcu012
DEFINE l_fmcu013         LIKE fmcu_t.fmcu013
DEFINE l_fmczdocno       LIKE fmcz_t.fmczdocno
DEFINE l_fmczseq         LIKE fmcz_t.fmczseq
DEFINE l_fmcz001         LIKE fmcz_t.fmcz001
DEFINE l_fmcz002         LIKE fmcz_t.fmcz002
DEFINE l_fmcz003         LIKE fmcz_t.fmcz003
DEFINE l_fmcz004         LIKE fmcz_t.fmcz004
DEFINE l_fmcz005         LIKE fmcz_t.fmcz005
DEFINE l_fmcz006         LIKE fmcz_t.fmcz006
DEFINE l_fmcz009         LIKE fmcz_t.fmcz009
DEFINE l_fmcz010         LIKE fmcz_t.fmcz010
DEFINE l_fmcz011         LIKE fmcz_t.fmcz011
DEFINE l_fmcz012         LIKE fmcz_t.fmcz012
DEFINE l_fmcz013         LIKE fmcz_t.fmcz013
DEFINE l_fmcz014         LIKE fmcz_t.fmcz014
DEFINE l_fmcz015         LIKE fmcz_t.fmcz015
DEFINE l_flag1           LIKE type_t.chr1       #记录是否有资料插入fmcu_t
DEFINE l_fmcu002         LIKE fmcu_t.fmcu002
DEFINE l_fmab004         LIKE fmab_t.fmab004
DEFINE l_fmab005         LIKE fmab_t.fmab005
DEFINE l_fmab006         LIKE fmab_t.fmab006
DEFINE l_fmab007         LIKE fmab_t.fmab007
DEFINE l_fmab008         LIKE fmab_t.fmab008
DEFINE l_fmab009         LIKE fmab_t.fmab009
DEFINE l_fmab010         LIKE fmab_t.fmab010
DEFINE l_fmab011         LIKE fmab_t.fmab011
DEFINE l_fmcz023         LIKE fmcz_t.fmcz023   #160302-00029#1  Add
   
   LET l_n = 0 
   LET g_wc = cl_replace_str(g_wc,'fmcrdocno','fmcydocno')
   LET l_sql = " SELECT COUNT(*) FROM fmcu_t ",
               "  WHERE fmcuent = ",g_enterprise ,
               "    AND fmcu003 IN(SELECT fmcydocno FROM fmcy_t WHERE fmcyent = ",g_enterprise,
               "    AND fmcystus = 'Y' AND fmcysite = '",g_fmct_m.fmctcomp,"')",
               "    AND fmct001 = '03' AND ",g_wc CLIPPED
   PREPARE fmcu_count_prep1 FROM l_sql
   EXECUTE fmcu_count_prep1 INTO l_n
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afm-00222'
      LET g_errparam.extend = g_fmct_m.fmctcomp
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   
   
   
   LET l_sql = " SELECT fmczdocno,fmczseq,fmcz001,fmcz002,fmcz003,fmcz004,fmcz005,fmcz006,fmcz009,",
               "        fmcz010,fmcz011,fmcz012,fmcz013,fmcz014,fmcz015 FROM fmcz_t,fmcy_t ",
               "  WHERE fmczent = fmcyent AND fmczdocno = fmcydocno ",
               "    AND fmczent = ",g_enterprise," AND fmcystus = 'Y' ",
               "    AND fmcycomp = '",g_fmct_m.fmctcomp,"'",
               "    AND fmcydocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
               "    AND fmcydocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
               "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
               "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
               "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')",
               "    AND ",g_wc CLIPPED
   PREPARE fmcz_ins_prep FROM l_sql
   DECLARE fmcz_ins_curs CURSOR FOR fmcz_ins_prep
   
   LET l_flag1 = 'N'  #记录是否有资料插入fmcu_t
   FOREACH fmcz_ins_curs INTO l_fmczdocno,l_fmczseq,l_fmcz001,l_fmcz002,l_fmcz003,l_fmcz004,l_fmcz005,
                              l_fmcz006,l_fmcz009,l_fmcz010,l_fmcz011,l_fmcz012,l_fmcz013,l_fmcz014,l_fmcz015
     
     SELECT MAX(fmcuseq) INTO l_fmcuseq
        FROM fmcu_t
       WHERE fmcuent = g_enterprise
         AND fmcudocno = g_fmct_m.fmctdocno
      
      IF cl_null(l_fmcuseq) THEN
         LET l_fmcuseq = 1
      ELSE
         LET l_fmcuseq = l_fmcuseq + 1
      END IF

     #160302-00029#1  Add  ---(S)---
      SELECT fmcz023 INTO l_fmcz023 FROM fmcz_t WHERE fmczent = g_enterprise
         AND fmczdocno = l_fmczdocno
         AND fmczseq   = l_fmczseq
     #160302-00029#1  Add  ---(E)---

      #融资类型
      SELECT fmcj001 INTO l_fmcj001 FROM fmcj_t
       WHERE fmcjent = g_enterprise AND fmcjdocno = l_fmcz002
      #类别
      SELECT fmaa003 INTO l_fmaa003 FROM fmaa_t
       WHERE fmaaent = g_enterprise AND fmaa001 = l_fmcj001
      
      LET l_fmab004 = ''
      LET l_fmab005 = ''
      LET l_fmab006 = ''
      LET l_fmab007 = ''
      LET l_fmab008 = ''
      LET l_fmab009 = ''
      LET l_fmab010 = ''
      LET l_fmab011 = ''
      #对方科目，费用化利息科目科目;afmi020中的应付利息科目；
      #160829-00019#1 mark ------
      #SELECT fmab004,fmab005,fmab06,fmab007,fmab008,fmab011,fmab009,fmab010
      #  INTO l_fmab004,l_fmab005,l_fmab006,l_fmab007,l_fmab008,l_fmab011,l_fmab009,l_fmcu013,l_fmab010 FROM fmab_t
      #160829-00019#1 mark end---
      #160829-00019#1 -s
      SELECT fmab004,fmab005,fmab006,fmab007,fmab008,
             fmab011,fmab009,fmab010
        INTO l_fmab004,l_fmab005,l_fmab006,l_fmab007,l_fmab008,
             l_fmab011,l_fmcu013,l_fmab010
        FROM fmab_t
      #160829-00019#1 -e
       WHERE fmabent = g_enterprise AND fmab001 = l_fmcj001
         AND fmab002 = g_glaa.glaa004 AND fmabstus = 'Y'

#      IF l_fmcz004 = '2' THEN   #利息调整
#         LET l_fmcu009 = l_fmcz009
#      ELSE
         LET l_fmcu009 = l_fmcz006
#      END IF
      
      CASE l_fmcz004
         WHEN '1' 
            LET l_fmcu002 = '06'
            LET l_fmcu012 = l_fmab010
         WHEN '2' 
            LET l_fmcu002 = '07'
            LET l_fmcu012 = l_fmab004
         WHEN '3' 
            LET l_fmcu002 = '08'
            LET l_fmcu012 = l_fmab005
         WHEN '4' 
            LET l_fmcu002 = '09'
            LET l_fmcu012 = l_fmab006
         WHEN '5' 
            LET l_fmcu002 = '10'
            LET l_fmcu012 = l_fmab007
         WHEN '6' 
            LET l_fmcu002 = '11'
            LET l_fmcu012 = l_fmab008
         WHEN '7' 
            LET l_fmcu002 = '12'
            LET l_fmcu012 = l_fmab011
      END CASE
      #融资到账单
      INSERT INTO fmcu_t(fmcuent,fmcudocno,fmcuseq,fmcu001,fmcu002,fmcu003,fmcu004,fmcu005,fmcu006,fmcu007,
                         fmcu008,fmcu009,fmcu010,fmcu011,fmcu014,fmcu015,fmcu016,fmcu017,fmcu012,fmcu013,
                         fmcu045     #160302-00029#1 Add
                         )
                  VALUES(g_enterprise,g_fmct_m.fmctdocno,l_fmcuseq,l_fmcz001,l_fmcu002,l_fmczdocno,l_fmczseq,'','',
                         '',l_fmcz005,l_fmcu009,l_fmcz010,l_fmcz011,l_fmcz012,l_fmcz013,l_fmcz014,l_fmcz015,
                         l_fmcu012,l_fmcu013,
                         l_fmcz023   #160302-00029#1 Add
                         )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "fmcu_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      LET l_flag1 = 'Y'
      
   END FOREACH
   
   IF l_flag1 = 'N' THEN
      LET g_success = 'N'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 栏位名称动态
# Memo...........:
# Usage..........: CALL afmt145_01_fmctdocno_title()
# Date & Author..: 2016/01/06 By  yangtt
# Modify.........:
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt145_01_fmctdocno_title()
DEFINE l_str           STRING
   
   CASE g_fmct001
      WHEN '01'
         LET l_str = cl_getmsg('afm-00224',g_dlang)
         CALL cl_set_comp_att_text('lbl_fmctdocno',l_str)
         LET l_str = cl_getmsg('afm-00230',g_dlang)
         CALL cl_set_comp_att_text('lbl_fmcrdocno',l_str)
      WHEN '02'
         LET l_str = cl_getmsg('afm-00228',g_dlang)
         CALL cl_set_comp_att_text('lbl_fmctdocno',l_str)
         LET l_str = cl_getmsg('afm-00229',g_dlang)
         CALL cl_set_comp_att_text('lbl_fmcrdocno',l_str)
      WHEN '03'
         LET l_str = cl_getmsg('afm-00231',g_dlang)
         CALL cl_set_comp_att_text('lbl_fmctdocno',l_str)
         LET l_str = cl_getmsg('afm-00223',g_dlang)
         CALL cl_set_comp_att_text('lbl_fmcrdocno',l_str)
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 将偿还本息资料插入fmcu_t
# Memo...........:
# Usage..........: CALL afmt145_01_ins_fmcu_02()
# Date & Author..: 2016/01/15 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt145_01_ins_fmcu_02()
DEFINE l_sql             STRING
DEFINE l_n               LIKE type_t.num5
DEFINE l_flag            LIKE type_t.chr1
DEFINE l_errno           LIKE type_t.chr100
DEFINE l_glav002         LIKE glav_t.glav002
DEFINE l_glav005         LIKE glav_t.glav005
DEFINE l_sdate_s         LIKE glav_t.glav004
DEFINE l_sdate_e         LIKE glav_t.glav004
DEFINE l_glav006         LIKE glav_t.glav006
DEFINE l_pdate_s         LIKE glav_t.glav004
DEFINE l_pdate_e         LIKE glav_t.glav004
DEFINE l_glav007         LIKE glav_t.glav007
DEFINE l_wdate_s         LIKE glav_t.glav004
DEFINE l_wdate_e         LIKE glav_t.glav004
DEFINE l_fmaa003         LIKE fmaa_t.fmaa003
DEFINE l_fmcj001         LIKE fmcj_t.fmcj001
DEFINE l_fmcuseq         LIKE fmcu_t.fmcuseq
DEFINE l_fmcu009         LIKE fmcu_t.fmcu009
DEFINE l_fmcu012         LIKE fmcu_t.fmcu012
DEFINE l_fmcu013         LIKE fmcu_t.fmcu013
DEFINE l_fmcu011         LIKE fmcu_t.fmcu011
DEFINE l_fmcu015         LIKE fmcu_t.fmcu015
DEFINE l_fmcu017         LIKE fmcu_t.fmcu017
DEFINE l_fmcwdocno       LIKE fmcw_t.fmcwdocno
DEFINE l_fmcwseq         LIKE fmcw_t.fmcwseq
DEFINE l_fmcw001         LIKE fmcw_t.fmcw001
DEFINE l_fmcw002         LIKE fmcw_t.fmcw002
DEFINE l_fmcw004         LIKE fmcw_t.fmcw004
DEFINE l_fmcw005         LIKE fmcw_t.fmcw005
DEFINE l_fmcw006         LIKE fmcw_t.fmcw006
DEFINE l_fmcw008         LIKE fmcw_t.fmcw008
DEFINE l_fmcw009         LIKE fmcw_t.fmcw009
DEFINE l_fmcw010         LIKE fmcw_t.fmcw010
DEFINE l_fmcw011         LIKE fmcw_t.fmcw011
DEFINE l_fmcw012         LIKE fmcw_t.fmcw012
DEFINE l_fmcw013         LIKE fmcw_t.fmcw013
DEFINE l_fmcw014         LIKE fmcw_t.fmcw014
DEFINE l_fmcw015         LIKE fmcw_t.fmcw015
DEFINE l_fmcw017         LIKE fmcw_t.fmcw017
DEFINE l_fmcw018         LIKE fmcw_t.fmcw018
DEFINE l_fmcw019         LIKE fmcw_t.fmcw019
DEFINE l_fmcw020         LIKE fmcw_t.fmcw020
DEFINE l_fmcw021         LIKE fmcw_t.fmcw021
DEFINE l_fmcw022         LIKE fmcw_t.fmcw022
DEFINE l_flag1           LIKE type_t.chr1       #记录是否有资料插入fmcu_t
DEFINE l_fmcu002         LIKE fmcu_t.fmcu002
DEFINE l_fmab003         LIKE fmab_t.fmab003
DEFINE l_fmab009         LIKE fmab_t.fmab009
DEFINE l_fmab010         LIKE fmab_t.fmab010
DEFINE l_fmab006         LIKE fmab_t.fmab006
DEFINE l_fmab007         LIKE fmab_t.fmab007
DEFINE l_glab005         LIKE glab_t.glab005
DEFINE l_fmcs004         LIKE fmcs_t.fmcs004
DEFINE l_fmcw026         LIKE fmcw_t.fmcw026   #160302-00029#1  Add
DEFINE l_fmcz009         LIKE fmcz_t.fmcz009
   
   LET l_n = 0 
   LET g_wc = cl_replace_str(g_wc,'fmcrdocno','fmcvdocno')
   LET l_sql = " SELECT COUNT(*) FROM fmcu_t ",
               "  WHERE fmcuent = ",g_enterprise ,
               "    AND fmcu003 IN(SELECT fmcvdocno FROM fmcv_t WHERE fmcvent = ",g_enterprise,
               "    AND fmcvstus = 'Y' AND fmcvsite = '",g_fmct_m.fmctcomp,"')",
               "    AND fmct001 = '02' AND ",g_wc CLIPPED
   PREPARE fmcu_count_prep2 FROM l_sql
   EXECUTE fmcu_count_prep2 INTO l_n
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afm-00232'
      LET g_errparam.extend = g_fmct_m.fmctcomp
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   
   LET l_sql = " SELECT fmcwdocno,fmcwseq,fmcw001,fmcw002,fmcw021,fmcw022,fmcw004,fmcw005,fmcw006,fmcw008,fmcw009,",
               "        fmcw010,fmcw011,fmcw012,fmcw013,fmcw014,fmcw015,fmcw017,fmcw018,fmcw019,",
               "        fmcw020 FROM fmcw_t,fmcv_t ",
               "  WHERE fmcwent = fmcvent AND fmcwdocno = fmcvdocno ",
               "    AND fmcwent = ",g_enterprise," AND fmcvstus = 'Y' ",
               "    AND fmcvcomp = '",g_fmct_m.fmctcomp,"'",
               "    AND fmcvdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
               "    AND fmcvdocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
               "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
               "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
               "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')",
               "    AND ",g_wc CLIPPED
   PREPARE fmcw_ins_prep FROM l_sql
   DECLARE fmcw_ins_curs CURSOR FOR fmcw_ins_prep
   
   LET l_flag1 = 'N'  #记录是否有资料插入fmcu_t
   FOREACH fmcw_ins_curs INTO l_fmcwdocno,l_fmcwseq,l_fmcw001,l_fmcw002,l_fmcw021,l_fmcw022,l_fmcw004,l_fmcw005,
                              l_fmcw006,l_fmcw008,l_fmcw009,l_fmcw010,l_fmcw011,l_fmcw012,l_fmcw013,
                              l_fmcw014,l_fmcw015,l_fmcw017,l_fmcw018,l_fmcw019,l_fmcw020
     
     SELECT MAX(fmcuseq) INTO l_fmcuseq
        FROM fmcu_t
       WHERE fmcuent = g_enterprise
         AND fmcudocno = g_fmct_m.fmctdocno
      
      IF cl_null(l_fmcuseq) THEN
         LET l_fmcuseq = 1
      ELSE
         LET l_fmcuseq = l_fmcuseq + 1
      END IF

     #160302-00029#1  Add  ---(S)---
      SELECT fmcw026 INTO l_fmcw026 FROM fmcw_t WHERE fmcwent = g_enterprise
         AND fmcwdocno = l_fmcwdocno
         AND fmcwseq   = l_fmcwseq
     #160302-00029#1  Add  ---(E)---

      #融资类型
      SELECT fmcj001 INTO l_fmcj001 FROM fmcj_t
       WHERE fmcjent = g_enterprise AND fmcjdocno = l_fmcw002
      #类别
      SELECT fmaa003 INTO l_fmaa003 FROM fmaa_t
       WHERE fmaaent = g_enterprise AND fmaa001 = l_fmcj001
      
      #对方科目，费用化利息科目科目;afmi020中的应付利息科目；
      SELECT fmab003,fmab009,fmab010 INTO l_fmab003,l_fmab009,l_fmab010 FROM fmab_t
       WHERE fmabent = g_enterprise AND fmab001 = l_fmcj001
         AND fmab002 = g_glaa.glaa004 AND fmabstus = 'Y'
         
      #取到账单里的贷款账户
      SELECT fmcs004 INTO l_fmcs004 FROM fmcs_t
       WHERE fmcsent = g_enterprise AND fmcsdocno = l_fmcw021
         AND fmcsseq = l_fmcw022
      #对方科目，anmi121
      SELECT glab005 INTO l_glab005 FROM glab_t
       WHERE glabent = g_enterprise AND glabld = g_fmct_m.fmctld
         AND glab001 = '40' AND glab002 = '40'
         AND glab003 = l_fmcs004
      
      CASE l_fmcw004
         WHEN '1'  #本金
            LET l_fmcu002 = '03'
            LET l_fmcu012 = l_fmab003
            LET l_fmcu013 = l_glab005
         WHEN '2'  #偿还利息
            LET l_fmcu002 = '04'
            LET l_fmcu012 = l_fmab009
            LET l_fmcu013 = l_glab005
         WHEN '3'  #其他
            LET l_fmcu002 = '05'
            LET l_fmcu012 = l_fmab009
            LET l_fmcu013 = l_glab005
      END CASE
      #偿还本息账务
      INSERT INTO fmcu_t(fmcuent,fmcudocno,fmcuseq,fmcu001,fmcu002,fmcu003,fmcu004,fmcu005,fmcu006,fmcu007,
                         fmcu008,fmcu009,fmcu010,fmcu011,fmcu014,fmcu015,fmcu016,fmcu017,fmcu012,fmcu013,
                         fmcu045     #160302-00029#1  Add
                         )
                  VALUES(g_enterprise,g_fmct_m.fmctdocno,l_fmcuseq,l_fmcw001,l_fmcu002,l_fmcwdocno,l_fmcwseq,'',l_fmcw008,
                         l_fmcw009,l_fmcw005,l_fmcw006,l_fmcw010,l_fmcw011,l_fmcw012,l_fmcw013,l_fmcw014,l_fmcw015,
                         l_fmcu012,l_fmcu013,
                         l_fmcw026   #160302-00029#1  Add
                         )
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "fmcu_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      LET l_flag1 = 'Y'
      #还款利息=2.利息时,分两笔插入fmcu_t，金额=fmcw017（已计提未支付利息），汇率=历史汇率
      IF l_fmcw004 = '2' THEN
         #已计提未支付利息大于0，不插入
         IF l_fmcw017 = 0 THEN CONTINUE FOREACH END IF 
         LET l_fmcz009 = 0 
         SELECT SUM(fmcz009) INTO l_fmcz009 FROM fmcy_t,fmcz_t
          WHERE fmcyent = fmczent AND fmcydocno = fmczdocno
            AND fmczent = g_enterprise AND fmcz016 = l_fmcw021
            AND fmcz017 = l_fmcw022 AND fmcz004 = '1'
            AND fmcystus = 'Y'
            
         #已计提利息为0，不插入
         IF l_fmcz009 = 0 THEN CONTINUE FOREACH END IF        
        
         SELECT MAX(fmcuseq) INTO l_fmcuseq
           FROM fmcu_t
          WHERE fmcuent = g_enterprise
            AND fmcudocno = g_fmct_m.fmctdocno
         
         IF cl_null(l_fmcuseq) THEN
            LET l_fmcuseq = 1
         ELSE
            LET l_fmcuseq = l_fmcuseq + 1
         END IF
         
         IF cl_null(l_fmcw017) THEN LET l_fmcw017 = 0 END IF
         IF cl_null(l_fmcw018) THEN LET l_fmcw018 = 0 END IF
         IF cl_null(l_fmcw019) THEN LET l_fmcw019 = 0 END IF      
         IF cl_null(l_fmcw020) THEN LET l_fmcw020 = 0 END IF 
         
         LET l_fmcu011 = l_fmcw017 * l_fmcw018
         LET l_fmcu015 = l_fmcw017 * l_fmcw019
         LET l_fmcu017 = l_fmcw017 * l_fmcw020
         
         IF cl_null(l_fmcu011) THEN LET l_fmcu011 = 0 END IF
         IF cl_null(l_fmcu015) THEN LET l_fmcu015 = 0 END IF      
         IF cl_null(l_fmcu017) THEN LET l_fmcu017 = 0 END IF 
         
         LET l_fmcu012 = l_fmab010
         LET l_fmcu013 = l_glab005
         
         #偿还本息账务
         INSERT INTO fmcu_t(fmcuent,fmcudocno,fmcuseq,fmcu001,fmcu002,fmcu003,fmcu004,fmcu005,fmcu006,fmcu007,
                            fmcu008,fmcu009,fmcu010,fmcu011,fmcu014,fmcu015,fmcu016,fmcu017,fmcu012,fmcu013)
                     VALUES(g_enterprise,g_fmct_m.fmctdocno,l_fmcuseq,l_fmcw001,'06',l_fmcwdocno,l_fmcwseq,'',l_fmcw008,
                            l_fmcw009,l_fmcw005,l_fmcw017,l_fmcw018,l_fmcu011,l_fmcw019,l_fmcu015,l_fmcw020,l_fmcu017,
                            l_fmcu012,l_fmcu013)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "fmcu_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
      END IF
      
      
   END FOREACH
   
   IF l_flag1 = 'N' THEN
      LET g_success = 'N'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt145_01_input1(p_cmd)
    #add-point:input段define(客製用)

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
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE l_fmctstus      LIKE fmct_t.fmctstus
   DEFINE l_fmctownid     LIKE fmct_t.fmctownid 
   DEFINE l_fmctowndp     LIKE fmct_t.fmctowndp 
   DEFINE l_fmctcrtid     LIKE fmct_t.fmctcrtid 
   DEFINE l_fmctcrtdp     LIKE fmct_t.fmctcrtdp 
   DEFINE l_fmctcrtdt     LIKE fmct_t.fmctcrtdt
   DEFINE l_fmctmodid     LIKE fmct_t.fmctmodid
   DEFINE l_fmctmoddt     LIKE fmct_t.fmctmoddt
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_origin_str    STRING
   DEFINE l_flag1         LIKE type_t.num5   #161104-00046#15
   #end add-point
   
   #add-point:Function前置處理 
   LET p_cmd = 'a'
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc,g_fmct_m.fmctdocno, 
       g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt,g_fmct_m.fmct001
   
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
   CALL afmt145_01_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL afmt145_01_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctcomp,g_fmct_m.fmctdocdt, 
          g_fmct_m.fmct001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前
            LET g_fmct_m.fmct001 = g_fmct001
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD fmctsite
            
            #add-point:AFTER FIELD fmctsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmct_m.fmctsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmct_m.fmctsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmct_m.fmctsite_desc

            IF NOT cl_null(g_fmct_m.fmctsite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmct_m.fmctsite != g_fmct_m_t.fmctsite OR g_fmct_m_t.fmctsite IS NULL )) THEN  #160822-00008#7  mark
               IF g_fmct_m.fmctsite != g_fmct_m_o.fmctsite OR cl_null(g_fmct_m_o.fmctsite) THEN                                      #160822-00008#7
                  CALL s_fin_account_center_sons_query('3',g_fmct_m.fmctsite,g_today,'1')
                  IF g_fmct_m.fmctsite != g_fmct_m_t.fmctsite OR cl_null(g_fmct_m_t.fmctsite) THEN
                    CALL s_fin_orga_get_comp_ld(g_fmct_m.fmctsite) RETURNING l_success,g_errno,g_fmct_m.fmctcomp,g_fmct_m.fmctld
                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_fmct_m.fmctsite,g_fmct_m.fmctld,g_user,'3','N','',g_fmct_m.fmctdocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_fmct_m.fmctsite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_fmct_m.fmctsite = g_fmct_m_t.fmctsite  #160822-00008#7  mark
                     #LET g_fmct_m.fmctld = g_fmct_m_t.fmctld      #160822-00008#7  mark
                     LET g_fmct_m.fmctsite = g_fmct_m_o.fmctsite   #160822-00008#7
                     LET g_fmct_m.fmctld = g_fmct_m_o.fmctld       #160822-00008#7
                     LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_anm_date_chk(g_fmct_m.fmctsite,g_fmct_m.fmctdocdt) RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "afm-00207"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_fmct_m.fmctsite = g_fmct_m_t.fmctsite  #160822-00008#7  mark
                     #LET g_fmct_m.fmctld = g_fmct_m_t.fmctld      #160822-00008#7  mark
                     LET g_fmct_m.fmctsite = g_fmct_m_o.fmctsite   #160822-00008#7
                     LET g_fmct_m.fmctld = g_fmct_m_o.fmctld       #160822-00008#7
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
               DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
            END IF
            LET g_fmct_m_o.* = g_fmct_m.*    #160822-00008#7
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD fmctsite
            #add-point:BEFORE FIELD fmctsite

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE fmctsite
            #add-point:ON CHANGE fmctsite

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD fmctld
            
            #add-point:AFTER FIELD fmctld
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmct_m.fmctld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmct_m.fmctld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmct_m.fmctld_desc

           IF NOT cl_null(g_fmct_m.fmctld) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fmct_m.fmctld != g_fmct_m_t.fmctld OR g_fmct_m_t.fmctld IS NULL )) THEN  #160822-00008#7  mark
               IF g_fmct_m.fmctld != g_fmct_m_o.fmctld OR cl_null(g_fmct_m_o.fmctld) THEN                                      #160822-00008#7
                  CALL s_fin_account_center_with_ld_chk(g_fmct_m.fmctsite,g_fmct_m.fmctld,g_user,'3','N','',g_fmct_m.fmctdocdt) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_fmct_m.fmctsite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_fmct_m.fmctld = g_fmct_m_t.fmctld  #160822-00008#7  mark
                     LET g_fmct_m.fmctld = g_fmct_m_o.fmctld   #160822-00008#7
                     LET g_fmct_m.fmctld_desc = s_desc_get_ld_desc(g_fmct_m.fmctld)
                     DISPLAY BY NAME g_fmct_m.fmctld,g_fmct_m.fmctld_desc
                     NEXT FIELD CURRENT
                  END IF
                  SELECT * INTO g_glaa.* FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_fmct_m.fmctld
                  LET g_fmct_m.fmctcomp = g_glaa.glaacomp
               END IF
            END IF
            LET g_fmct_m_o.* = g_fmct_m.*    #160822-00008#7
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD fmctld
            #add-point:BEFORE FIELD fmctld

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE fmctld
            #add-point:ON CHANGE fmctld

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD fmctdocno
            #add-point:BEFORE FIELD fmctdocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD fmctdocno
            
            #add-point:AFTER FIELD fmctdocno
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_fmct_m.fmctdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmct_m.fmctdocno != g_fmctdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmct_t WHERE "||"fmctent = '" ||g_enterprise|| "' AND "||"fmctdocno = '"||g_fmct_m.fmctdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_fmct_m.fmctdocno) THEN
                     CALL s_aooi200_fin_chk_slip(g_fmct_m.fmctld,g_glaa.glaa024,g_fmct_m.fmctdocno,g_prog) RETURNING l_success
                     IF l_success = FALSE THEN
                        LET g_fmct_m.fmctdocno = g_fmct_m_t.fmctdocno
                        NEXT FIELD fmctdocno
                     END IF
                     #161104-00046#15 --s add
                     CALL s_control_chk_doc('1',g_fmct_m.fmctdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
                     IF g_sub_success AND l_flag1 THEN             
                     ELSE
                        LET g_fmct_m.fmctdocno = g_fmct_m_t.fmctdocno
                        NEXT FIELD CURRENT                
                     END IF
                     #161104-00046#15 --e add
                  END IF
                  
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE fmctdocno
            #add-point:ON CHANGE fmctdocno

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD fmctcomp
            #add-point:BEFORE FIELD fmctcomp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD fmctcomp
            
            #add-point:AFTER FIELD fmctcomp
            LET g_fmct_m_o.* = g_fmct_m.*    #160822-00008#7
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE fmctcomp
            #add-point:ON CHANGE fmctcomp

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD fmctdocdt
            #add-point:BEFORE FIELD fmctdocdt

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD fmctdocdt
            
            #add-point:AFTER FIELD fmctdocdt
            IF NOT cl_null(g_fmct_m.fmctdocdt) THEN
               CALL s_get_accdate(g_glaa.glaa003,g_fmct_m.fmctdocdt,'','')
                RETURNING g_flag,g_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
                          g_glav006,g_pdate_s,g_pdate_e,g_glav007,g_wdate_s,g_wdate_e
            END IF
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE fmctdocdt
            #add-point:ON CHANGE fmctdocdt

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD fmct001
            #add-point:BEFORE FIELD fmct001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD fmct001
            
            #add-point:AFTER FIELD fmct001

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE fmct001
            #add-point:ON CHANGE fmct001

            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.fmctsite
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD fmctsite
            #add-point:ON ACTION controlp INFIELD fmctsite
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctsite             #給予default值
            LET g_qryparam.default2 = "" #g_fmct_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001()     #161006-00005#12   mark                    
            CALL q_ooef001_46()   #161006-00005#12   add

            LET g_fmct_m.fmctsite = g_qryparam.return1              
            LET g_fmct_m.fmctsite_desc = s_desc_get_department_desc(g_fmct_m.fmctsite)
            DISPLAY BY NAME g_fmct_m.fmctsite,g_fmct_m.fmctsite_desc,g_fmct_m.fmctld,g_fmct_m.fmctld_desc
            #LET g_fmct_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmct_m.fmctsite TO fmctsite              #
            #DISPLAY g_fmct_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmctsite                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.fmctld
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD fmctld
            #add-point:ON ACTION controlp INFIELD fmctld
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctld             #給予default值

            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_fmct_m.fmctsite,g_fmct_m.fmctdocdt,'1')
            #取得帳務組織下所屬成員之帳別
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL afmt145_01_change_to_sql(l_origin_str) RETURNING l_origin_str

            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"

            #給予arg

            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_fmct_m.fmctld = g_qryparam.return1            
            LET g_fmct_m.fmctld_desc = s_desc_get_ld_desc(g_fmct_m.fmctld)
            DISPLAY BY NAME g_fmct_m.fmctld,g_fmct_m.fmctld_desc            
            SELECT * INTO g_glaa.* FROM glaa_t
              WHERE glaaent = g_enterprise
                AND glaald = g_fmct_m.fmctld

            DISPLAY g_fmct_m.fmctld TO fmctld              #

            NEXT FIELD fmctld                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.fmctdocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD fmctdocno
            #add-point:ON ACTION controlp INFIELD fmctdocno
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctdocno             #給予default值
            LET g_qryparam.where = "ooba001 = '",g_glaa.glaa024,"' AND oobx003 = '",g_prog,"'"

            #給予arg
            LET g_qryparam.arg1 = ""
            #161104-00046#15 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#15 --e add
            CALL q_ooba002_4()                                #呼叫開窗

            LET g_fmct_m.fmctdocno = g_qryparam.return1              

            DISPLAY g_fmct_m.fmctdocno TO fmctdocno              #

            NEXT FIELD fmctdocno                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.fmctcomp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD fmctcomp
            #add-point:ON ACTION controlp INFIELD fmctcomp
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmct_m.fmctcomp             #給予default值
            LET g_qryparam.default2 = "" #g_fmct_m.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooef001()                                #呼叫開窗

            LET g_fmct_m.fmctcomp = g_qryparam.return1              
            #LET g_fmct_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmct_m.fmctcomp TO fmctcomp              #
            #DISPLAY g_fmct_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD fmctcomp                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.fmctdocdt
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD fmctdocdt
            #add-point:ON ACTION controlp INFIELD fmctdocdt

            #END add-point
 
         #Ctrlp:input.c.fmct001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD fmct001
            #add-point:ON ACTION controlp INFIELD fmct001

            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            
      END INPUT
      
      #add-point:input段more input 
      CONSTRUCT g_wc ON fmcrdocno FROM fmcrdocno
         ON ACTION controlp INFIELD fmcrdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CASE g_fmct001 
               WHEN '01' 
                  LET g_qryparam.where    = " fmcrstus = 'Y' AND fmcrdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
                                            "    AND fmcrcomp = '",g_fmct_m.fmctcomp,"'",
                                            "    AND fmcrdocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
                                            "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
                                            "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
                                            "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')"
                  CALL q_fmcrdocno()
               WHEN '02' 
                  LET g_qryparam.where    = " fmcvstus = 'Y' AND fmcvdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
                                            "    AND fmcvcomp = '",g_fmct_m.fmctcomp,"'",
                                            "    AND fmcvdocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
                                            "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
                                            "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
                                            "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')"
                  CALL q_fmcvdocno_01()
               WHEN '03' 
                  LET g_qryparam.where    = " fmcystus = 'Y' AND fmcydocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"'",
                                            "    AND fmcycomp = '",g_fmct_m.fmctcomp,"'",
                                            "    AND fmcydocno NOT IN( SELECT UNIQUE fmcu003 FROM fmct_t,fmcu_t WHERE fmcuent = ",g_enterprise,
                                            "    AND fmctent = fmcuent AND fmctdocno = fmcudocno ",
                                            "    AND fmctld = '",g_fmct_m.fmctld,"' AND fmctstus <> 'X' ",
                                            "    AND fmctdocdt BETWEEN '",g_pdate_s,"' AND '",g_pdate_e,"')"
                  CALL q_fmcydocno()
            END CASE
            DISPLAY g_qryparam.return1 to fmcrdocno
            NEXT FIELD fmcrdocno
      END CONSTRUCT
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog 

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
    
   #add-point:input段after input 
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CALL s_transaction_end('N','0')
      DELETE FROM fmct_t WHERE fmctent = g_enterprise AND fmctdocno = g_fmct_m.fmctdocno
      RETURN
   END IF
   IF cl_null(g_wc) OR g_wc = " 1=2" THEN LET g_wc = " 1=1" END IF
   LET g_success = 'Y'
   CALL afmt145_01_ins_fmct()
   CASE g_fmct001 
      WHEN '01' 
         CALL afmt145_01_ins_fmcu()
         LET g_type1 = 'M14'
         IF g_glaa.glaa121 = 'Y' THEN
            CALL s_pre_voucher_ins('FM','M14',g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctdocdt,'14') RETURNING l_success
         END IF
      WHEN '02' 
         CALL afmt145_01_ins_fmcu_02()
         LET g_type1 = 'M17'
         IF g_glaa.glaa121 = 'Y' THEN
            CALL s_pre_voucher_ins('FM','M17',g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctdocdt,'17') RETURNING l_success
         END IF
      WHEN '03' 
         CALL afmt145_01_ins_fmcu_03()
         LET g_type1 = 'M18'
         IF g_glaa.glaa121 = 'Y' THEN
            CALL s_pre_voucher_ins('FM','M18',g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctdocdt,'18') RETURNING l_success
         END IF
   END CASE

   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM fmcu_t
    WHERE fmcuent = g_enterprise AND fmcudocno = g_fmct_m.fmctdocno   
   IF l_n = 0 THEN
      LET g_success = 'N'
   END IF
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
   ELSE
      CALL s_transaction_end('N','1')
      DELETE FROM fmct_t WHERE fmctent = g_enterprise AND fmctdocno = g_fmct_m.fmctdocno
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_pre_voucher_del('FM',g_type1,g_fmct_m.fmctld,g_fmct_m.fmctdocno ) RETURNING l_success 
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
   END IF
   #end add-point    
END FUNCTION

################################################################################
# Descriptions...: 资料插入fmct_t
# Memo...........:
# Usage..........: CALL afmt145_01_ins_fmct()
# Date & Author..: 2016/01/21 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt145_01_ins_fmct()
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_fmctstus      LIKE fmct_t.fmctstus
   DEFINE l_fmctownid     LIKE fmct_t.fmctownid 
   DEFINE l_fmctowndp     LIKE fmct_t.fmctowndp 
   DEFINE l_fmctcrtid     LIKE fmct_t.fmctcrtid 
   DEFINE l_fmctcrtdp     LIKE fmct_t.fmctcrtdp 
   DEFINE l_fmctcrtdt     LIKE fmct_t.fmctcrtdt
   DEFINE l_fmctmodid     LIKE fmct_t.fmctmodid
   DEFINE l_fmctmoddt     LIKE fmct_t.fmctmoddt

   CALL s_aooi200_fin_gen_docno(g_fmct_m.fmctld,g_glaa.glaa024,g_glaa.glaa003,g_fmct_m.fmctdocno,g_fmct_m.fmctdocdt,g_prog)
         RETURNING l_success,g_fmct_m.fmctdocno
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_fmct_m.fmctdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   LET l_fmctownid = g_user
   LET l_fmctowndp = g_dept
   LET l_fmctcrtid = g_user
   LET l_fmctcrtdp = g_dept 
   LET l_fmctcrtdt = cl_get_current()
   LET l_fmctmodid = g_user
   LET l_fmctmoddt = cl_get_current()
   LET l_fmctstus = 'N'
   
   #將新增的單頭資料寫入資料庫
   INSERT INTO fmct_t (fmctent,fmctsite,fmctld,fmctdocno,fmctcomp,fmctdocdt,fmct001,fmctownid,
                       fmctowndp,fmctcrtid,fmctcrtdp,fmctcrtdt,fmctmodid,fmctmoddt,fmctstus)
   VALUES (g_enterprise,g_fmct_m.fmctsite,g_fmct_m.fmctld,g_fmct_m.fmctdocno,g_fmct_m.fmctcomp, 
           g_fmct_m.fmctdocdt,g_fmct_m.fmct001,l_fmctownid,l_fmctowndp,l_fmctcrtid,l_fmctcrtdp,
           l_fmctcrtdt,l_fmctmodid,l_fmctmoddt,l_fmctstus) 
   
   #若寫入錯誤則提示錯誤訊息並返回輸入頁面
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fmct_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF
   
END FUNCTION

 
{</section>}
 
