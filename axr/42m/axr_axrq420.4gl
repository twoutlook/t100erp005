#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq420.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2015-03-02 17:02:00), PR版次:0008(2016-12-02 09:47:29)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: axrq420
#+ Description: 收款沖銷明細表
#+ Creator....: 02114(2015-03-02 14:12:29)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="axrq420.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#7   2016/02/24  By yangtt   增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串pmabsite
#160318-00025#12  2016/04/26  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160727-00019#6   2016/07/28  By 08734    axrq420_print_tmp ——> axrq420_tmp01
#160811-00009#2   2016/08/17  By 01531    账务中心/法人/账套权限控管
#161111-00049#9   2016/11/28  By 01727     控制组权限修改
#161128-00061#4   2016/12/02  by 02481    标准程式定义采用宣告模式,弃用.*写法

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
 
#單身 type 宣告
PRIVATE TYPE type_g_xrde_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xrdeld LIKE xrde_t.xrdeld, 
   xrdedocno LIKE xrde_t.xrdedocno, 
   xrdeseq LIKE xrde_t.xrdeseq, 
   xrda005 LIKE xrda_t.xrda005, 
   xrda005_desc LIKE type_t.chr500, 
   xrde002 LIKE xrde_t.xrde002, 
   xrde006 LIKE xrde_t.xrde006, 
   xrde003 LIKE xrde_t.xrde003, 
   xrde004 LIKE xrde_t.xrde004, 
   xrde008 LIKE xrde_t.xrde008, 
   xrde100 LIKE xrde_t.xrde100, 
   xrde101 LIKE xrde_t.xrde101, 
   xrde109 LIKE xrde_t.xrde109, 
   xrde119 LIKE xrde_t.xrde119, 
   xrde120 LIKE xrde_t.xrde120, 
   xrde121 LIKE xrde_t.xrde121, 
   xrde129 LIKE xrde_t.xrde129, 
   xrde130 LIKE xrde_t.xrde130, 
   xrde131 LIKE xrde_t.xrde131, 
   xrde139 LIKE xrde_t.xrde139, 
   xrde014 LIKE xrde_t.xrde014, 
   xrde013 LIKE xrde_t.xrde013, 
   xrde012 LIKE xrde_t.xrde012, 
   xrde015 LIKE xrde_t.xrde015, 
   xrde010 LIKE xrde_t.xrde010, 
   xrde016 LIKE xrde_t.xrde016 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xrda_m      RECORD
       xrdald            LIKE xrda_t.xrdald,
       xrdald_desc       LIKE type_t.chr500,
       xrdacomp          LIKE type_t.chr500
                         END RECORD
DEFINE g_xrda_m          type_g_xrda_m
#161128-00061#4-----modify--begin----------
#DEFINE g_glaa              RECORD LIKE glaa_t.* 
DEFINE g_glaa  RECORD  #帳套資料檔
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
#161128-00061#4-----modify--end----------
DEFINE g_wc_qbe          STRING
DEFINE l_ac2             LIKE type_t.num5 
DEFINE g_sql_ctrl        STRING                #151231-00010#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xrde_d
DEFINE g_master_t                   type_g_xrde_d
DEFINE g_xrde_d          DYNAMIC ARRAY OF type_g_xrde_d
DEFINE g_xrde_d_t        type_g_xrde_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq420.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#9 Add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#7(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161111-00049#9 Mark
  #161111-00049#9 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#9 Add  ---(E)---
   #151231-00010#7(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq420_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq420_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq420_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq420 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq420_init()   
 
      #進入選單 Menu (="N")
      CALL axrq420_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq420
      
   END IF 
   
   CLOSE axrq420_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq420.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq420_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql      STRING
   DEFINE l_str      STRING
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002
   DEFINE l_success  LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   #xrde002下拉菜單取值,SCC_8306 AND gzcb004='1'
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8306' AND gzcb004 = '1'"
   PREPARE axrt400_xrde002_prep FROM l_sql
   DECLARE axrt400_xrde002_curs CURSOR FOR axrt400_xrde002_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrt400_xrde002_curs INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('b_xrde002','8306',l_str)
   
   #xrce006下拉菜單取值,SCC_8310 AND gzcb002<>'ZZ'
   LET l_str = Null
   LET l_gzcb002 = Null
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8310' AND gzcb002 <> 'ZZ'"
   PREPARE axrt400_xrce006_prep FROM l_sql
   DECLARE axrt400_xrce006_curs CURSOR FOR axrt400_xrce006_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrt400_xrce006_curs INTO l_gzcb002
      IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('b_xrde006','8310',l_str)
   #end add-point
 
   CALL axrq420_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq420.default_search" >}
PRIVATE FUNCTION axrq420_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrdeseq = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq420_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axrq420_b_fill()
   ELSE
      CALL axrq420_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrde_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq420_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrde_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq420_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq420_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq420_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrq420_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axrq420_x01('1=1','axrq420_tmp01',g_glaa.glaa015,g_glaa.glaa019)   #160727-00019#6  2016/07/28  By 08734    axrq420_print_tmp ——> axrq420_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axrq420_x01('1=1','axrq420_tmp01',g_glaa.glaa015,g_glaa.glaa019)   #160727-00019#6  2016/07/28  By 08734    axrq420_print_tmp ——> axrq420_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq420_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq420_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL axrq420_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrde_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq420_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq420_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq420_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq420_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq420_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_xrdald   LIKE xrda_t.xrdald
   DEFINE l_ld_str   STRING #160811-00009#2
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrde_d.clear()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xrdeld
           FROM s_detail1[1].b_xrdeld
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xrdeld>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrdeld
            #add-point:BEFORE FIELD b_xrdeld name="construct.b.page1.b_xrdeld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrdeld
            
            #add-point:AFTER FIELD b_xrdeld name="construct.a.page1.b_xrdeld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrdeld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrdeld
            #add-point:ON ACTION controlp INFIELD b_xrdeld name="construct.c.page1.b_xrdeld"
            
            #END add-point
 
 
         #----<<b_xrdedocno>>----
         #----<<b_xrdeseq>>----
         #----<<b_xrda005>>----
         #----<<xrda005_desc>>----
         #----<<b_xrde002>>----
         #----<<b_xrde006>>----
         #----<<b_xrde003>>----
         #----<<b_xrde004>>----
         #----<<b_xrde008>>----
         #----<<b_xrde100>>----
         #----<<b_xrde101>>----
         #----<<b_xrde109>>----
         #----<<b_xrde119>>----
         #----<<b_xrde120>>----
         #----<<b_xrde121>>----
         #----<<b_xrde129>>----
         #----<<b_xrde130>>----
         #----<<b_xrde131>>----
         #----<<b_xrde139>>----
         #----<<b_xrde014>>----
         #----<<b_xrde013>>----
         #----<<b_xrde012>>----
         #----<<b_xrde015>>----
         #----<<b_xrde010>>----
         #----<<b_xrde016>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_xrda_m.xrdald
        ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT
               CALL axrq420_def()
               DISPLAY BY NAME g_xrda_m.*

            BEFORE FIELD xrdald
               LET l_xrdald = g_xrda_m.xrdald

            AFTER FIELD xrdald
               LET g_xrda_m.xrdald_desc = ' '
               DISPLAY BY NAME g_xrda_m.xrdald_desc
               IF NOT cl_null(g_xrda_m.xrdald) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrda_m.xrdald
                  LET g_chkparam.arg2 = ' '
                  #160318-00025#12--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#12--add--end
                  IF NOT cl_chk_exist("v_glaald_1") THEN
                     LET g_xrda_m.xrdald = l_xrdald
                     CALL axrq420_xrda_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF  
               #160811-00009#2 Add  ---(S)---
               LET g_errno = ''
               CALL s_fin_account_center_with_ld_chk('',g_xrda_m.xrdald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xrda_m.xrdald = l_xrdald
                  CALL axrq420_xrda_desc()
                  NEXT FIELD CURRENT
               END IF
               #160811-00009#2 Add  ---(E)---  
               CALL axrq420_xrda_desc()
              #161111-00049#9 Add  ---(S)---
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
              #161111-00049#9 Add  ---(E)---


            ON ACTION controlp INFIELD xrdald
               CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str #160811-00009#2 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xrda_m.xrdald         #給予default值
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               LET g_qryparam.where = l_ld_str CLIPPED  #160811-00009#2
               CALL  q_authorised_ld()                           #呼叫開窗
               LET g_xrda_m.xrdald = g_qryparam.return1          #將開窗取得的值回傳到變數
               DISPLAY g_xrda_m.xrdald TO xrdald                 #顯示到畫面上
               #CALL axrq420_xrda_desc()
               NEXT FIELD xrdald                                 #返回原欄位

         END INPUT    

         CONSTRUCT BY NAME g_wc_qbe ON xrdadocno,xrda003,xrda005,xrdadocdt
         
            ON ACTION controlp INFIELD xrdadocno
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " xrdald = '",g_xrda_m.xrdald,"'"#161111-00049#9 Add
               CALL q_xrdadocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrdadocno      #顯示到畫面上
               NEXT FIELD xrdadocno                         #返回原欄位
         
            ON ACTION controlp INFIELD xrda003
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrda003      #顯示到畫面上
               NEXT FIELD xrda003                         #返回原欄位
         
            ON ACTION controlp INFIELD xrda005
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      #151231-00010#7--(S)
               LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrda_m.xrdald,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where ," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#7--(E)
               CALL q_pmaa001_13()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrda005      #顯示到畫面上
               NEXT FIELD xrda005                         #返回原欄位  
         END CONSTRUCT
         
      BEFORE DIALOG
         CALL cl_qbe_init()
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL axrq420_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="axrq420.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq420_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xrde002       LIKE type_t.chr500
   DEFINE l_xrde006       LIKE type_t.chr500
   DEFINE l_xrdald_desc   LIKE type_t.chr500
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_glaa.glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('b_xrde120,b_xrde121,b_xrde129',TRUE)
   ELSE
      CALL cl_set_comp_visible('b_xrde120,b_xrde121,b_xrde129',FALSE)
   END IF
   
   IF g_glaa.glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('b_xrde130,b_xrde131,b_xrde139',TRUE)
   ELSE
      CALL cl_set_comp_visible('b_xrde130,b_xrde131,b_xrde139',FALSE)
   END IF
   
   IF cl_null(g_wc_qbe) THEN 
      LET g_wc_qbe = " 1=1 "
   END IF
   
   #2015/5/27---XG
   CALL axrq420_create_tmp()
   DELETE FROM axrq420_tmp01  #160727-00019#6  2016/07/28  By 08734    axrq420_print_tmp ——> axrq420_tmp01
   LET l_xrdald_desc = g_xrda_m.xrdald," ",g_xrda_m.xrdald_desc," ",g_xrda_m.xrdacomp
   #2015/5/27---XG
   
   #151231-00010#7--(S)
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc = g_wc,"AND xrda005 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
   #end add-point
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE xrdeld,xrdedocno,xrdeseq,'','',xrde002,xrde006,xrde003,xrde004, 
       xrde008,xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde014, 
       xrde013,xrde012,xrde015,xrde010,xrde016  ,DENSE_RANK() OVER( ORDER BY xrde_t.xrdeseq) AS RANK FROM xrde_t", 
 
 
 
                     "",
                     " WHERE xrdeent=? AND xrdeld=? AND xrdedocno=? AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrde_t"),
                     " ORDER BY xrde_t.xrdeseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT xrdeld,xrdedocno,xrdeseq,'','',xrde002,xrde006,xrde003,xrde004,xrde008,xrde100, 
       xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde014,xrde013,xrde012, 
       xrde015,xrde010,xrde016",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE xrdeld,xrdedocno,xrdeseq,xrda005,'',xrde002,xrde006,xrde003,xrde004,xrde008,xrde100, 
                               xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139,xrde014,xrde013,xrde012, 
                               xrde015,xrde010,xrde016 FROM xrde_t,xrda_t",
               " WHERE xrdeent=? ",
               "   AND xrdeent = xrdaent",
               "   AND xrdeld = xrdald",
               "   AND xrdedocno = xrdadocno",
               "   AND xrdald = '",g_xrda_m.xrdald,"'",
               "   AND ", g_wc_qbe,
               "   AND ", ls_wc,cl_sql_add_filter("xrde_t")
    
   LET g_sql = g_sql, cl_sql_add_filter("xrde_t"),
                      " ORDER BY xrde_t.xrdedocno,xrde_t.xrdeseq"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq420_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq420_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xrde_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xrde_d[l_ac].xrdeld,g_xrde_d[l_ac].xrdedocno,g_xrde_d[l_ac].xrdeseq,g_xrde_d[l_ac].xrda005, 
       g_xrde_d[l_ac].xrda005_desc,g_xrde_d[l_ac].xrde002,g_xrde_d[l_ac].xrde006,g_xrde_d[l_ac].xrde003, 
       g_xrde_d[l_ac].xrde004,g_xrde_d[l_ac].xrde008,g_xrde_d[l_ac].xrde100,g_xrde_d[l_ac].xrde101,g_xrde_d[l_ac].xrde109, 
       g_xrde_d[l_ac].xrde119,g_xrde_d[l_ac].xrde120,g_xrde_d[l_ac].xrde121,g_xrde_d[l_ac].xrde129,g_xrde_d[l_ac].xrde130, 
       g_xrde_d[l_ac].xrde131,g_xrde_d[l_ac].xrde139,g_xrde_d[l_ac].xrde014,g_xrde_d[l_ac].xrde013,g_xrde_d[l_ac].xrde012, 
       g_xrde_d[l_ac].xrde015,g_xrde_d[l_ac].xrde010,g_xrde_d[l_ac].xrde016
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xrde_d[l_ac].statepic = cl_get_actipic(g_xrde_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrde_d[l_ac].xrda005
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrde_d[l_ac].xrda005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xrde_d[l_ac].xrda005_desc
      
      #2015/5/27---XG
      LET l_xrde002 = ''
      LET l_xrde006 = ''
      IF NOT cl_null(g_xrde_d[l_ac].xrde002) THEN
         LET l_xrde002 = g_xrde_d[l_ac].xrde002,":",s_desc_gzcbl004_desc('8306',g_xrde_d[l_ac].xrde002)
      END IF
      IF NOT cl_null(g_xrde_d[l_ac].xrde006) THEN
         LET l_xrde006 = g_xrde_d[l_ac].xrde006,":",s_desc_gzcbl004_desc('8310',g_xrde_d[l_ac].xrde006)
      END IF
      
      INSERT INTO axrq420_tmp01 VALUES(l_xrdald_desc,g_xrde_d[l_ac].xrdeld,g_xrde_d[l_ac].xrdedocno,g_xrde_d[l_ac].xrdeseq,   #160727-00019#6  2016/07/28  By 08734    axrq420_print_tmp ——> axrq420_tmp01
       g_xrde_d[l_ac].xrda005,g_xrde_d[l_ac].xrda005_desc,l_xrde002,l_xrde006,g_xrde_d[l_ac].xrde003, 
       g_xrde_d[l_ac].xrde004,g_xrde_d[l_ac].xrde008,g_xrde_d[l_ac].xrde100,g_xrde_d[l_ac].xrde101,g_xrde_d[l_ac].xrde109, 
       g_xrde_d[l_ac].xrde119,g_xrde_d[l_ac].xrde120,g_xrde_d[l_ac].xrde121,g_xrde_d[l_ac].xrde129,g_xrde_d[l_ac].xrde130, 
       g_xrde_d[l_ac].xrde131,g_xrde_d[l_ac].xrde139,g_xrde_d[l_ac].xrde014,g_xrde_d[l_ac].xrde013,g_xrde_d[l_ac].xrde012, 
       g_xrde_d[l_ac].xrde015,g_xrde_d[l_ac].xrde010,g_xrde_d[l_ac].xrde016)
      #2015/5/27---XG
      #end add-point
 
      CALL axrq420_detail_show("'1'")      
 
      CALL axrq420_xrde_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_xrde_d.deleteElement(g_xrde_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_xrde_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq420_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq420_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq420_detail_action_trans()
 
   IF g_xrde_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq420_fetch()
   END IF
   
      CALL axrq420_filter_show('xrdeld','b_xrdeld')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq420_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrq420.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq420_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq420_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrdeld
                          FROM s_detail1[1].b_xrdeld
 
         BEFORE CONSTRUCT
                     DISPLAY axrq420_filter_parser('xrdeld') TO s_detail1[1].b_xrdeld
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xrdeld>>----
         #Ctrlp:construct.c.filter.page1.b_xrdeld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrdeld
            #add-point:ON ACTION controlp INFIELD b_xrdeld name="construct.c.filter.page1.b_xrdeld"
            
            #END add-point
 
 
         #----<<b_xrdedocno>>----
         #----<<b_xrdeseq>>----
         #----<<b_xrda005>>----
         #----<<xrda005_desc>>----
         #----<<b_xrde002>>----
         #----<<b_xrde006>>----
         #----<<b_xrde003>>----
         #----<<b_xrde004>>----
         #----<<b_xrde008>>----
         #----<<b_xrde100>>----
         #----<<b_xrde101>>----
         #----<<b_xrde109>>----
         #----<<b_xrde119>>----
         #----<<b_xrde120>>----
         #----<<b_xrde121>>----
         #----<<b_xrde129>>----
         #----<<b_xrde130>>----
         #----<<b_xrde131>>----
         #----<<b_xrde139>>----
         #----<<b_xrde014>>----
         #----<<b_xrde013>>----
         #----<<b_xrde012>>----
         #----<<b_xrde015>>----
         #----<<b_xrde010>>----
         #----<<b_xrde016>>----
   
 
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
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL axrq420_filter_show('xrdeld','b_xrdeld')
 
    
   CALL axrq420_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq420_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="axrq420.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq420_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrq420_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.insert" >}
#+ insert
PRIVATE FUNCTION axrq420_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq420.modify" >}
#+ modify
PRIVATE FUNCTION axrq420_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq420_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.delete" >}
#+ delete
PRIVATE FUNCTION axrq420_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq420_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq420_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_xrde_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrde_d.getLength() AND g_xrde_d.getLength() > 0
            LET g_detail_idx = g_xrde_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrde_d.getLength() THEN
               LET g_detail_idx = g_xrde_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrq420.mask_functions" >}
 &include "erp/axr/axrq420_mask.4gl"
 
{</section>}
 
{<section id="axrq420.other_function" readonly="Y" >}
#默認值
PRIVATE FUNCTION axrq420_def()
   DEFINE l_xrdacomp_desc         LIKE type_t.chr500
   DEFINE l_success               LIKE type_t.chr1
   DEFINE l_sql                   STRING


   #根據人員抓取對應法人的主帳套
   CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,g_xrda_m.xrdald,g_xrda_m.xrdacomp,g_errno

   #根據帳套檢查該員工是否有使用權限
   CALL s_ld_chk_authorization(g_user,g_xrda_m.xrdald) RETURNING l_success
   IF l_success = 'N' THEN
      LET g_xrda_m.xrdald   = NULL
   END IF

   #161128-00061#4-----modify--begin----------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161128-00061#4----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrda_m.xrdald

   CALL s_axrt300_xrca_ref('xrcald',g_xrda_m.xrdald,'','') RETURNING l_success,g_xrda_m.xrdald_desc
   CALL s_axrt300_xrca_ref('xrcasite',g_xrda_m.xrdacomp,'','') RETURNING l_success,l_xrdacomp_desc
   IF NOT cl_null(g_xrda_m.xrdacomp) THEN LET g_xrda_m.xrdacomp = g_xrda_m.xrdacomp,'(',l_xrdacomp_desc,')' END IF

  #161111-00049#9 Add  ---(S)---
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#9 Add  ---(E)---

   DISPLAY BY NAME g_xrda_m.xrdald_desc
   DISPLAY BY NAME g_xrda_m.xrdacomp
END FUNCTION
# 賬套名稱帶值
PRIVATE FUNCTION axrq420_xrda_desc()
   DEFINE l_xrdacomp_desc   LIKE type_t.chr80
   DEFINE l_success         LIKE type_t.chr1
   
   CALL s_axrt300_xrca_ref('xrcald',g_xrda_m.xrdald,'','') RETURNING l_success,g_xrda_m.xrdald_desc
   #161128-00061#4-----modify--begin----------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161128-00061#4----modify--end---------- 
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrda_m.xrdald
   LET g_xrda_m.xrdacomp = g_glaa.glaacomp
   CALL s_axrt300_xrca_ref('xrcasite',g_xrda_m.xrdacomp,'','') RETURNING l_success,l_xrdacomp_desc
   IF NOT cl_null(g_xrda_m.xrdacomp) THEN LET g_xrda_m.xrdacomp = g_xrda_m.xrdacomp,'(',l_xrdacomp_desc,')' END IF
   DISPLAY BY NAME g_xrda_m.xrdald_desc,g_xrda_m.xrdacomp
   
END FUNCTION

################################################################################
# Descriptions...: 新建臨時表XG用
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq420_create_tmp()
   DROP TABLE axrq420_tmp01;  #160727-00019#6  2016/07/28  By 08734    axrq420_print_tmp ——> axrq420_tmp01
      CREATE TEMP TABLE axrq420_tmp01(    #160727-00019#6  2016/07/28  By 08734    axrq420_print_tmp ——> axrq420_tmp01
     xrdeld_desc  VARCHAR(500),
     xrdeld  VARCHAR(5), 
   xrdedocno  VARCHAR(20), 
   xrdeseq  INTEGER, 
   xrda005  VARCHAR(10), 
   xrda005_desc  VARCHAR(500), 
   xrde002  VARCHAR(500), 
   xrde006  VARCHAR(500), 
   xrde003  VARCHAR(20), 
   xrde004  INTEGER, 
   xrde008  VARCHAR(20), 
   xrde100  VARCHAR(10), 
   xrde101  DECIMAL(20,10), 
   xrde109  DECIMAL(20,6), 
   xrde119  DECIMAL(20,6), 
   xrde120  VARCHAR(10), 
   xrde121  DECIMAL(20,10), 
   xrde129  DECIMAL(20,6), 
   xrde130  VARCHAR(10), 
   xrde131  DECIMAL(20,10), 
   xrde139  DECIMAL(20,6), 
   xrde014  VARCHAR(20), 
   xrde013  VARCHAR(10), 
   xrde012  VARCHAR(10), 
   xrde015  VARCHAR(1), 
   xrde010  VARCHAR(255), 
   xrde016  VARCHAR(24)
   )
END FUNCTION

 
{</section>}
 
