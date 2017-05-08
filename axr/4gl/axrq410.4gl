#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2016-04-19 14:14:46), PR版次:0013(2016-12-02 09:45:35)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: axrq410
#+ Description: 收款沖銷明細查詢作業
#+ Creator....: 01531(2014-09-11 16:02:20)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axrq410.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#7   2016/02/24  By yangtt   增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串pmabsite
#141226-00016#12  2016/04/18  By 01727    第二單身資料來源改抓xrde_t資料
#160318-00025#12  2016/04/26  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160727-00019#6   2016/07/28  By 08734    axrq410_print_tmp1 ——> axrq410_tmp01
#160811-00009#2   2016/08/17  By 01531    账务中心/法人/账套权限控管
#160912-00011#1   2016/09/20  By 01727    加上二行 條件, 不取 銀存收支單 及保證票之調撥單
#160913-00017#7   2016/09/22  By 07900    AXR模组调整交易客商开窗
#161017-00011#1   2016/10/20  By 01727    财务权限问题修正
#161101-00025#1   2016/11/04  By 01727    沖帳單資訊中增加呈現 xrde002 為 20,21,22 轉待抵的資料
#161111-00049#2   2016/11/12  By 01727    控制组权限修改
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
PRIVATE TYPE type_g_nmbb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   nmbb027 LIKE nmbb_t.nmbb027, 
   nmbb027_desc LIKE type_t.chr500, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb053 LIKE nmbb_t.nmbb053, 
   nmbb053_desc LIKE type_t.chr500, 
   nmbb031 LIKE nmbb_t.nmbb031, 
   nmbb003 LIKE nmbb_t.nmbb003, 
   nmbb003_desc LIKE type_t.chr500, 
   nmbb030 LIKE nmbb_t.nmbb030, 
   nmbb042 LIKE nmbb_t.nmbb042, 
   nmbb040 LIKE nmbb_t.nmbb040, 
   unrev LIKE type_t.num20_6, 
   nmbbdocno LIKE nmbb_t.nmbbdocno, 
   nmbbseq LIKE nmbb_t.nmbbseq, 
   nmbborga LIKE nmbb_t.nmbborga, 
   nmbborga_desc LIKE type_t.chr500, 
   nmbb026 LIKE nmbb_t.nmbb026, 
   nmbb026_desc LIKE type_t.chr500 
       END RECORD
PRIVATE TYPE type_g_nmbb2_d RECORD
       flag LIKE type_t.chr500, 
   xrdadocdt LIKE xrda_t.xrdadocdt, 
   xrce002 LIKE xrce_t.xrce002, 
   xrce024 LIKE xrce_t.xrce024, 
   xrce003 LIKE xrce_t.xrce003, 
   xrce014 LIKE xrce_t.xrce014, 
   xrce005 LIKE xrce_t.xrce005, 
   xrcb031 LIKE xrcb_t.xrcb031, 
   xrcc003 LIKE xrcc_t.xrcc003, 
   xrce100 LIKE xrce_t.xrce100, 
   xrce109 LIKE xrce_t.xrce109, 
   xrce119 LIKE xrce_t.xrce119, 
   delay LIKE type_t.num5, 
   xrda006 LIKE xrda_t.xrda006, 
   xrda006_desc LIKE type_t.chr500, 
   xrdadocno LIKE xrda_t.xrdadocno, 
   xrce004 LIKE xrce_t.xrce004
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xrda_m      RECORD
       xrdald            LIKE xrda_t.xrdald,
       xrdald_desc       LIKE type_t.chr500,
       xrdacomp          LIKE type_t.chr500
                         END RECORD
DEFINE g_xrda_m          type_g_xrda_m
DEFINE g_ls              LIKE type_t.chr1
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
DEFINE g_master                     type_g_nmbb_d
DEFINE g_master_t                   type_g_nmbb_d
DEFINE g_nmbb_d          DYNAMIC ARRAY OF type_g_nmbb_d
DEFINE g_nmbb_d_t        type_g_nmbb_d
DEFINE g_nmbb2_d   DYNAMIC ARRAY OF type_g_nmbb2_d
DEFINE g_nmbb2_d_t type_g_nmbb2_d
 
 
      
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
 
{<section id="axrq410.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#2 Add
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
  #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161111-00049#2 Mark
  #161111-00049#2 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#2 Add  ---(E)---
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
   DECLARE axrq410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq410_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq410_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq410 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq410_init()   
 
      #進入選單 Menu (="N")
      CALL axrq410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq410
      
   END IF 
   
   CLOSE axrq410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq410.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq410_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
 
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_nmbb042','8714') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('flag','8333')
  #CALL cl_set_combo_scc('b_xrce002','8306')   #141226-00016#13 Mark
   CALL cl_set_combo_scc('b_xrce002','8306')   #141226-00016#13 Add
   CALL cl_set_combo_scc('b_nmbb029','8310') 
   CALL cl_set_combo_scc('b_nmbb042','8711')  
   CALL cl_set_comp_visible("b_nmbb053_desc,b_nmbborga_desc,b_nmbb003_desc", FALSE)  
   CALL cl_set_comp_visible("b_nmbb053,b_nmbborga,b_nmbb003", TRUE)   
   
   #end add-point
 
   CALL axrq410_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq410.default_search" >}
PRIVATE FUNCTION axrq410_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmbbdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmbbseq = '", g_argv[02], "' AND "
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
 
{<section id="axrq410.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq410_ui_dialog()
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
#   DEFINE la_param     RECORD
#          prog         STRING,
#          param        DYNAMIC ARRAY OF STRING
#                       END RECORD
#   DEFINE ls_js        STRING
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
      CALL axrq410_b_fill()
   ELSE
      CALL axrq410_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmbb_d.clear()
         CALL g_nmbb2_d.clear()
 
 
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
 
         CALL axrq410_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmbb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq410_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq410_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL cl_set_comp_visible("b_nmbb053_desc,b_nmbborga_desc,b_nmbb003_desc", TRUE)  
               CALL cl_set_comp_visible("b_nmbb053,b_nmbborga,b_nmbb003", FALSE)  
               CALL axrq410_b_fill2()
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_nmbb2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_nmbb2_d.getLength() TO FORMONLY.h_count
               CALL axrq410_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq410_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)        #141226-00016#12 Add
            CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)   #141226-00016#12 Add
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               IF NOT cl_ask_confirm("axr-00340") THEN
                  #按否列印匯總
                  CALL axrq410_x02('1=1','axrq410_tmp01')   #160727-00019#6  2016/07/28  By 08734    axrq410_print_tmp1 ——> axrq410_tmp01 
               ELSE
                  CALL axrq410_x01('1=1','axrq410_print_tmp')
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               IF NOT cl_ask_confirm("axr-00340") THEN
                  #按否列印匯總
                  CALL axrq410_x02('1=1','axrq410_tmp01')   #160727-00019#6  2016/07/28  By 08734    axrq410_print_tmp1 ——> axrq410_tmp01 
               ELSE
                  CALL axrq410_x01('1=1','axrq410_print_tmp')
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq410_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)        #141226-00016#12 Add
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)   #141226-00016#12 Add
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
            CALL axrq410_filter()
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
            CALL axrq410_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmbb_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_nmbb2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
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
            CALL axrq410_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq410_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq410_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq410_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmbb_d.getLength()
               LET g_nmbb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmbb_d.getLength()
               LET g_nmbb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmbb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmbb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmbb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmbb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  IF g_current_page = 1 THEN 
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog = 'anmt550'
                     LET la_param.param[1] = g_glaa.glaacomp
                     LET la_param.param[2] = g_nmbb_d[g_detail_idx].nmbbdocno         
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun(ls_js)  
                  END IF
                  IF g_current_page = 2 THEN 
                     INITIALIZE la_param.* TO NULL
                     CASE g_nmbb2_d[g_detail_idx].flag
                       WHEN '4' LET la_param.prog = 'axrt400'
                       WHEN '3' LET la_param.prog = 'axrt300'
                     END CASE   
                       LET la_param.param[1] = g_xrda_m.xrdald
                       LET la_param.param[2] = g_nmbb2_d[g_detail_idx].xrdadocno                     
                       LET ls_js = util.JSON.stringify( la_param )
                       CALL cl_cmdrun(ls_js)  
                  END IF                  
               END IF
               EXIT DIALOG
            END IF
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
 
{<section id="axrq410.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq410_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_xrdald          LIKE xrda_t.xrdald
   DEFINE l_ld_str          STRING                #160811-00009#2 Add
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#2 Add

   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
 
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmbb_d.clear()
   CALL g_nmbb2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON nmbb027,nmbadocdt,nmbb029,nmbb004,nmbb006,nmbb053,nmbb031,nmbb003,nmbb030, 
          nmbb042,nmbb040,nmbbdocno,nmbbseq,nmbborga,nmbb026,xrce014
           FROM s_detail1[1].b_nmbb027,s_detail1[1].b_nmbadocdt,s_detail1[1].b_nmbb029,s_detail1[1].b_nmbb004, 
               s_detail1[1].b_nmbb006,s_detail1[1].b_nmbb053,s_detail1[1].b_nmbb031,s_detail1[1].b_nmbb003, 
               s_detail1[1].b_nmbb030,s_detail1[1].b_nmbb042,s_detail1[1].b_nmbb040,s_detail1[1].b_nmbbdocno, 
               s_detail1[1].b_nmbbseq,s_detail1[1].b_nmbborga,s_detail1[1].b_nmbb026,s_detail2[1].b_xrce014 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL cl_set_comp_visible("b_nmbb053_desc,b_nmbborga_desc,b_nmbb003_desc", FALSE)    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_nmbb027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb027
            #add-point:BEFORE FIELD b_nmbb027 name="construct.b.page1.b_nmbb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb027
            
            #add-point:AFTER FIELD b_nmbb027 name="construct.a.page1.b_nmbb027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb027
            #add-point:ON ACTION controlp INFIELD b_nmbb027 name="construct.c.page1.b_nmbb027"
            
            #END add-point
 
 
         #----<<b_nmbb027_desc>>----
         #----<<b_nmbadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbadocdt
            #add-point:BEFORE FIELD b_nmbadocdt name="construct.b.page1.b_nmbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbadocdt
            
            #add-point:AFTER FIELD b_nmbadocdt name="construct.a.page1.b_nmbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbadocdt
            #add-point:ON ACTION controlp INFIELD b_nmbadocdt name="construct.c.page1.b_nmbadocdt"
            
            #END add-point
 
 
         #----<<b_nmbb029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb029
            #add-point:BEFORE FIELD b_nmbb029 name="construct.b.page1.b_nmbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb029
            
            #add-point:AFTER FIELD b_nmbb029 name="construct.a.page1.b_nmbb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbb029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb029
            #add-point:ON ACTION controlp INFIELD b_nmbb029 name="construct.c.page1.b_nmbb029"
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = '8310'
#            CALL q_gzcb001()                             #呼叫開窗
#            DISPLAY g_qryparam.return1 TO b_nmbb029      #顯示到畫面上
#            NEXT FIELD b_nmbb029                         #返回原欄位


            #END add-point
 
 
         #----<<b_nmbb004>>----
         #Ctrlp:construct.c.page1.b_nmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb004
            #add-point:ON ACTION controlp INFIELD b_nmbb004 name="construct.c.page1.b_nmbb004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb004  #顯示到畫面上
            NEXT FIELD b_nmbb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb004
            #add-point:BEFORE FIELD b_nmbb004 name="construct.b.page1.b_nmbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb004
            
            #add-point:AFTER FIELD b_nmbb004 name="construct.a.page1.b_nmbb004"
            
            #END add-point
            
 
 
         #----<<b_nmbb006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb006
            #add-point:BEFORE FIELD b_nmbb006 name="construct.b.page1.b_nmbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb006
            
            #add-point:AFTER FIELD b_nmbb006 name="construct.a.page1.b_nmbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb006
            #add-point:ON ACTION controlp INFIELD b_nmbb006 name="construct.c.page1.b_nmbb006"
            
            #END add-point
 
 
         #----<<b_nmbb053>>----
         #Ctrlp:construct.c.page1.b_nmbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb053
            #add-point:ON ACTION controlp INFIELD b_nmbb053 name="construct.c.page1.b_nmbb053"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb053  #顯示到畫面上
            NEXT FIELD b_nmbb053                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb053
            #add-point:BEFORE FIELD b_nmbb053 name="construct.b.page1.b_nmbb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb053
            
            #add-point:AFTER FIELD b_nmbb053 name="construct.a.page1.b_nmbb053"
            
            #END add-point
            
 
 
         #----<<b_nmbb053_desc>>----
         #----<<b_nmbb031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb031
            #add-point:BEFORE FIELD b_nmbb031 name="construct.b.page1.b_nmbb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb031
            
            #add-point:AFTER FIELD b_nmbb031 name="construct.a.page1.b_nmbb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb031
            #add-point:ON ACTION controlp INFIELD b_nmbb031 name="construct.c.page1.b_nmbb031"
            
            #END add-point
 
 
         #----<<b_nmbb003>>----
         #Ctrlp:construct.c.page1.b_nmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb003
            #add-point:ON ACTION controlp INFIELD b_nmbb003 name="construct.c.page1.b_nmbb003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb003  #顯示到畫面上
            NEXT FIELD b_nmbb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb003
            #add-point:BEFORE FIELD b_nmbb003 name="construct.b.page1.b_nmbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb003
            
            #add-point:AFTER FIELD b_nmbb003 name="construct.a.page1.b_nmbb003"
            
            #END add-point
            
 
 
         #----<<b_nmbb003_desc>>----
         #----<<b_nmbb030>>----
         #Ctrlp:construct.c.page1.b_nmbb030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb030
            #add-point:ON ACTION controlp INFIELD b_nmbb030 name="construct.c.page1.b_nmbb030"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmbb030()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb030  #顯示到畫面上
            NEXT FIELD b_nmbb030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb030
            #add-point:BEFORE FIELD b_nmbb030 name="construct.b.page1.b_nmbb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb030
            
            #add-point:AFTER FIELD b_nmbb030 name="construct.a.page1.b_nmbb030"
            
            #END add-point
            
 
 
         #----<<b_nmbb042>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb042
            #add-point:BEFORE FIELD b_nmbb042 name="construct.b.page1.b_nmbb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb042
            
            #add-point:AFTER FIELD b_nmbb042 name="construct.a.page1.b_nmbb042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb042
            #add-point:ON ACTION controlp INFIELD b_nmbb042 name="construct.c.page1.b_nmbb042"
            
            #END add-point
 
 
         #----<<b_nmbb040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb040
            #add-point:BEFORE FIELD b_nmbb040 name="construct.b.page1.b_nmbb040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb040
            
            #add-point:AFTER FIELD b_nmbb040 name="construct.a.page1.b_nmbb040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbb040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb040
            #add-point:ON ACTION controlp INFIELD b_nmbb040 name="construct.c.page1.b_nmbb040"
            
            #END add-point
 
 
         #----<<unrev>>----
         #----<<b_nmbbdocno>>----
         #Ctrlp:construct.c.page1.b_nmbbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbbdocno
            #add-point:ON ACTION controlp INFIELD b_nmbbdocno name="construct.c.page1.b_nmbbdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " nmbb026 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrda_m.xrdald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND nmbb026 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_nmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbbdocno  #顯示到畫面上
            NEXT FIELD b_nmbbdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbbdocno
            #add-point:BEFORE FIELD b_nmbbdocno name="construct.b.page1.b_nmbbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbbdocno
            
            #add-point:AFTER FIELD b_nmbbdocno name="construct.a.page1.b_nmbbdocno"
            
            #END add-point
            
 
 
         #----<<b_nmbbseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbbseq
            #add-point:BEFORE FIELD b_nmbbseq name="construct.b.page1.b_nmbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbbseq
            
            #add-point:AFTER FIELD b_nmbbseq name="construct.a.page1.b_nmbbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbbseq
            #add-point:ON ACTION controlp INFIELD b_nmbbseq name="construct.c.page1.b_nmbbseq"
            
            #END add-point
 
 
         #----<<b_nmbborga>>----
         #Ctrlp:construct.c.page1.b_nmbborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbborga
            #add-point:ON ACTION controlp INFIELD b_nmbborga name="construct.c.page1.b_nmbborga"
            #此段落由子樣板a08產生
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str      #161017-00011#1 Add
            LET l_ld_str = cl_replace_str(l_ld_str,"ooef001","nmbborga")   #161017-00011#1 Add
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_ld_str CLIPPED   #161017-00011#1 Add
            CALL q_nmbborga_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbborga  #顯示到畫面上
            NEXT FIELD b_nmbborga                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbborga
            #add-point:BEFORE FIELD b_nmbborga name="construct.b.page1.b_nmbborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbborga
            
            #add-point:AFTER FIELD b_nmbborga name="construct.a.page1.b_nmbborga"
            
            #END add-point
            
 
 
         #----<<b_nmbborga_desc>>----
         #----<<b_nmbb026>>----
         #Ctrlp:construct.c.page1.b_nmbb026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb026
            #add-point:ON ACTION controlp INFIELD b_nmbb026 name="construct.c.page1.b_nmbb026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrda_m.xrdald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
             # CALL q_pmaa001()   #160913-00017#7  mark                  #呼叫開窗
            #160913-00017#7--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#7--ADD(E)--
            DISPLAY g_qryparam.return1 TO b_nmbb026  #顯示到畫面上
            NEXT FIELD b_nmbb026                     #返回原欄位
  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbb026
            #add-point:BEFORE FIELD b_nmbb026 name="construct.b.page1.b_nmbb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbb026
            
            #add-point:AFTER FIELD b_nmbb026 name="construct.a.page1.b_nmbb026"
            
            #END add-point
            
 
 
         #----<<b_nmbb026_desc>>----
         #----<<flag>>----
         #----<<b_xrdadocdt>>----
         #----<<b_xrce002>>----
         #----<<b_xrce024>>----
         #----<<b_xrce003>>----
         #----<<b_xrce014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrce014
            #add-point:BEFORE FIELD b_xrce014 name="construct.b.page2.b_xrce014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrce014
            
            #add-point:AFTER FIELD b_xrce014 name="construct.a.page2.b_xrce014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_xrce014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrce014
            #add-point:ON ACTION controlp INFIELD b_xrce014 name="construct.c.page2.b_xrce014"
            
            #END add-point
 
 
         #----<<b_xrce005>>----
         #----<<b_xrcb031>>----
         #----<<b_xrcc003>>----
         #----<<b_xrce100>>----
         #----<<b_xrce109>>----
         #----<<b_xrce119>>----
         #----<<delay>>----
         #----<<b_xrda006>>----
         #----<<b_xrda006_desc>>----
         #----<<b_xrdadocno>>----
         #----<<b_xrce004>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
         INPUT BY NAME g_xrda_m.xrdald

            BEFORE INPUT
               CALL axrq410_def()
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
                     CALL axrq410_xrda_desc()
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
                  CALL axrq410_xrda_desc()
                  NEXT FIELD CURRENT
               END IF
              #161111-00049#2 Add  ---(S)---
               SELECT ooef017 INTO l_ooef017 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrda_m.xrdald)
                  AND ooefstus = 'Y'
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
              #161111-00049#2 Add  ---(E)---
               #160811-00009#2 Add  ---(E)---               
               CALL axrq410_xrda_desc()

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
               CALL axrq410_xrda_desc()
               NEXT FIELD xrdald                                 #返回原欄位

         END INPUT    

         CONSTRUCT BY NAME g_wc_qbe ON nmbborga,nmbadocdt,nmbb053,nmbb026,nmbb027,nmbbdocno,nmbb029,nmbb003,nmbb030
         
            ON ACTION controlp INFIELD nmbborga
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str      #161017-00011#1 Add
               LET l_ld_str = cl_replace_str(l_ld_str,"ooef001","nmbborga")   #161017-00011#1 Add
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = l_ld_str CLIPPED   #161017-00011#1 Add
               CALL q_nmbborga_1()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbborga     #顯示到畫面上
               NEXT FIELD nmbborga                         #返回原欄位

            ON ACTION controlp INFIELD nmbb026
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_glaa.glaacomp
               #151231-00010#7--(S)
               LET g_qryparam.where = " nmbb026 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrda_m.xrdald,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where ," AND nmbb026 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#7--(E)
               CALL q_nmbb026_1()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbb026      #顯示到畫面上
               NEXT FIELD nmbb026                         #返回原欄位

            ON ACTION controlp INFIELD nmbb053
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbb053      #顯示到畫面上
               NEXT FIELD nmbb053                         #返回原欄位

            ON ACTION controlp INFIELD nmbb027
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_glaa.glaacomp
               CALL q_nmbb027()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbb027      #顯示到畫面上
               NEXT FIELD nmbb027                         #返回原欄位
               
            ON ACTION controlp INFIELD nmbbdocno
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_nmbadocno()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbbdocno     #顯示到畫面上
               NEXT FIELD nmbbdocno                         #返回原欄位               

            ON ACTION controlp INFIELD nmbb003
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_nmas_01()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbb003      #顯示到畫面上
               NEXT FIELD nmbb003                         #返回原欄位

            ON ACTION controlp INFIELD nmbb029
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '8310'
               CALL q_gzcb001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbb029      #顯示到畫面上
               NEXT FIELD nmbb029                         #返回原欄位

            ON ACTION controlp INFIELD nmbb030
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_nmbb030()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbb030      #顯示到畫面上
               NEXT FIELD nmbb030                         #返回原欄位
               
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
      INITIALIZE g_xrda_m.* TO NULL
      CALL axrq410_def()
      CALL axrq410_xrda_desc()
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
   CALL axrq410_b_fill()
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
 
{<section id="axrq410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq410_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axrq410_b_fill1()
   RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',nmbb027,'','',nmbb029,nmbb004,nmbb006,nmbb053,'',nmbb031,nmbb003, 
       '',nmbb030,nmbb042,nmbb040,'',nmbbdocno,nmbbseq,nmbborga,'',nmbb026,'','','','','','','','','', 
       '','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY nmbb_t.nmbbdocno,nmbb_t.nmbbseq) AS RANK FROM nmbb_t", 
 
 
 
                     " LEFT JOIN xrda_t ON nmbbdocno = xrdald AND nmbbseq = xrdadocno LEFT JOIN xrce_t ON nmbbdocno = xrceld AND nmbbseq = xrcedocno AND  LEFT JOIN xrcb_t ON nmbbdocno = xrcbld AND nmbbseq = xrcbdocno AND  LEFT JOIN xrcc_t ON nmbbdocno = xrccld AND nmbbseq = xrccdocno AND",
                     " WHERE nmbbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmbb_t"),
                     " ORDER BY nmbb_t.nmbbdocno,nmbb_t.nmbbseq"
 
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
 
   LET g_sql = "SELECT '',nmbb027,'','',nmbb029,nmbb004,nmbb006,nmbb053,'',nmbb031,nmbb003,'',nmbb030, 
       nmbb042,nmbb040,'',nmbbdocno,nmbbseq,nmbborga,'',nmbb026,'','','','','','','','','','','','', 
       '','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq410_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq410_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmbb_d.clear()
   CALL g_nmbb2_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_nmbb_d[l_ac].sel,g_nmbb_d[l_ac].nmbb027,g_nmbb_d[l_ac].nmbb027_desc,g_nmbb_d[l_ac].nmbadocdt, 
       g_nmbb_d[l_ac].nmbb029,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb006,g_nmbb_d[l_ac].nmbb053,g_nmbb_d[l_ac].nmbb053_desc, 
       g_nmbb_d[l_ac].nmbb031,g_nmbb_d[l_ac].nmbb003,g_nmbb_d[l_ac].nmbb003_desc,g_nmbb_d[l_ac].nmbb030, 
       g_nmbb_d[l_ac].nmbb042,g_nmbb_d[l_ac].nmbb040,g_nmbb_d[l_ac].unrev,g_nmbb_d[l_ac].nmbbdocno,g_nmbb_d[l_ac].nmbbseq, 
       g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbborga_desc,g_nmbb_d[l_ac].nmbb026,g_nmbb_d[l_ac].nmbb026_desc, 
       g_nmbb2_d[l_ac].flag,g_nmbb2_d[l_ac].xrdadocdt,g_nmbb2_d[l_ac].xrce002,g_nmbb2_d[l_ac].xrce024, 
       g_nmbb2_d[l_ac].xrce003,g_nmbb2_d[l_ac].xrce014,g_nmbb2_d[l_ac].xrce005,g_nmbb2_d[l_ac].xrcb031, 
       g_nmbb2_d[l_ac].xrcc003,g_nmbb2_d[l_ac].xrce100,g_nmbb2_d[l_ac].xrce109,g_nmbb2_d[l_ac].xrce119, 
       g_nmbb2_d[l_ac].delay,g_nmbb2_d[l_ac].xrda006,g_nmbb2_d[l_ac].xrda006_desc,g_nmbb2_d[l_ac].xrdadocno, 
       g_nmbb2_d[l_ac].xrce004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_nmbb_d[l_ac].statepic = cl_get_actipic(g_nmbb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axrq410_detail_show("'1'")      
 
      CALL axrq410_nmbb_t_mask()
 
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
   
 
   
   CALL g_nmbb_d.deleteElement(g_nmbb_d.getLength())   
   CALL g_nmbb2_d.deleteElement(g_nmbb2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_nmbb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq410_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq410_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq410_detail_action_trans()
 
   IF g_nmbb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq410_fetch()
   END IF
   
      CALL axrq410_filter_show('nmbb027','b_nmbb027')
   CALL axrq410_filter_show('nmbadocdt','b_nmbadocdt')
   CALL axrq410_filter_show('nmbb029','b_nmbb029')
   CALL axrq410_filter_show('nmbb004','b_nmbb004')
   CALL axrq410_filter_show('nmbb006','b_nmbb006')
   CALL axrq410_filter_show('nmbb053','b_nmbb053')
   CALL axrq410_filter_show('nmbb031','b_nmbb031')
   CALL axrq410_filter_show('nmbb003','b_nmbb003')
   CALL axrq410_filter_show('nmbb030','b_nmbb030')
   CALL axrq410_filter_show('nmbb042','b_nmbb042')
   CALL axrq410_filter_show('nmbb040','b_nmbb040')
   CALL axrq410_filter_show('nmbbdocno','b_nmbbdocno')
   CALL axrq410_filter_show('nmbbseq','b_nmbbseq')
   CALL axrq410_filter_show('nmbborga','b_nmbborga')
   CALL axrq410_filter_show('nmbb026','b_nmbb026')
   CALL axrq410_filter_show('xrce014','b_xrce014')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq410.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq410_fetch()
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
 
{<section id="axrq410.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq410_detail_show(ps_page)
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
      CALL cl_set_comp_visible("b_nmbb053_desc,b_nmbborga_desc,b_nmbb003_desc", TRUE)  
      CALL cl_set_comp_visible("b_nmbb053,b_nmbborga,b_nmbb003", FALSE)  
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb027
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_nmbb_d[l_ac].nmbb027_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb027_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb026
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_nmbb_d[l_ac].nmbb026_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb026_desc

      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbb2_d[l_ac].xrda006
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbb2_d[l_ac].xrda006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbb2_d[l_ac].xrda006_desc

 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq410.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq410_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_ld_str   STRING   #160811-00009#2
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
      CONSTRUCT g_wc_filter ON nmbb027,nmbadocdt,nmbb029,nmbb004,nmbb006,nmbb053,nmbb031,nmbb003,nmbb030, 
          nmbb042,nmbb040,nmbbdocno,nmbbseq,nmbborga,nmbb026,xrce014
                          FROM s_detail1[1].b_nmbb027,s_detail1[1].b_nmbadocdt,s_detail1[1].b_nmbb029, 
                              s_detail1[1].b_nmbb004,s_detail1[1].b_nmbb006,s_detail1[1].b_nmbb053,s_detail1[1].b_nmbb031, 
                              s_detail1[1].b_nmbb003,s_detail1[1].b_nmbb030,s_detail1[1].b_nmbb042,s_detail1[1].b_nmbb040, 
                              s_detail1[1].b_nmbbdocno,s_detail1[1].b_nmbbseq,s_detail1[1].b_nmbborga, 
                              s_detail1[1].b_nmbb026,s_detail2[1].b_xrce014
 
         BEFORE CONSTRUCT
                     DISPLAY axrq410_filter_parser('nmbb027') TO s_detail1[1].b_nmbb027
            DISPLAY axrq410_filter_parser('nmbadocdt') TO s_detail1[1].b_nmbadocdt
            DISPLAY axrq410_filter_parser('nmbb029') TO s_detail1[1].b_nmbb029
            DISPLAY axrq410_filter_parser('nmbb004') TO s_detail1[1].b_nmbb004
            DISPLAY axrq410_filter_parser('nmbb006') TO s_detail1[1].b_nmbb006
            DISPLAY axrq410_filter_parser('nmbb053') TO s_detail1[1].b_nmbb053
            DISPLAY axrq410_filter_parser('nmbb031') TO s_detail1[1].b_nmbb031
            DISPLAY axrq410_filter_parser('nmbb003') TO s_detail1[1].b_nmbb003
            DISPLAY axrq410_filter_parser('nmbb030') TO s_detail1[1].b_nmbb030
            DISPLAY axrq410_filter_parser('nmbb042') TO s_detail1[1].b_nmbb042
            DISPLAY axrq410_filter_parser('nmbb040') TO s_detail1[1].b_nmbb040
            DISPLAY axrq410_filter_parser('nmbbdocno') TO s_detail1[1].b_nmbbdocno
            DISPLAY axrq410_filter_parser('nmbbseq') TO s_detail1[1].b_nmbbseq
            DISPLAY axrq410_filter_parser('nmbborga') TO s_detail1[1].b_nmbborga
            DISPLAY axrq410_filter_parser('nmbb026') TO s_detail1[1].b_nmbb026
            DISPLAY axrq410_filter_parser('xrce014') TO s_detail2[1].b_xrce014
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmbb027>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb027
            #add-point:ON ACTION controlp INFIELD b_nmbb027 name="construct.c.filter.page1.b_nmbb027"
            
            #END add-point
 
 
         #----<<b_nmbb027_desc>>----
         #----<<b_nmbadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_nmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbadocdt
            #add-point:ON ACTION controlp INFIELD b_nmbadocdt name="construct.c.filter.page1.b_nmbadocdt"
            
            #END add-point
 
 
         #----<<b_nmbb029>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb029
            #add-point:ON ACTION controlp INFIELD b_nmbb029 name="construct.c.filter.page1.b_nmbb029"
            
            #END add-point
 
 
         #----<<b_nmbb004>>----
         #Ctrlp:construct.c.page1.b_nmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb004
            #add-point:ON ACTION controlp INFIELD b_nmbb004 name="construct.c.filter.page1.b_nmbb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb004  #顯示到畫面上
            NEXT FIELD b_nmbb004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb006>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb006
            #add-point:ON ACTION controlp INFIELD b_nmbb006 name="construct.c.filter.page1.b_nmbb006"
            
            #END add-point
 
 
         #----<<b_nmbb053>>----
         #Ctrlp:construct.c.page1.b_nmbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb053
            #add-point:ON ACTION controlp INFIELD b_nmbb053 name="construct.c.filter.page1.b_nmbb053"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb053  #顯示到畫面上
            NEXT FIELD b_nmbb053                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb053_desc>>----
         #----<<b_nmbb031>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb031
            #add-point:ON ACTION controlp INFIELD b_nmbb031 name="construct.c.filter.page1.b_nmbb031"
            
            #END add-point
 
 
         #----<<b_nmbb003>>----
         #Ctrlp:construct.c.page1.b_nmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb003
            #add-point:ON ACTION controlp INFIELD b_nmbb003 name="construct.c.filter.page1.b_nmbb003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb003  #顯示到畫面上
            NEXT FIELD b_nmbb003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb003_desc>>----
         #----<<b_nmbb030>>----
         #Ctrlp:construct.c.page1.b_nmbb030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb030
            #add-point:ON ACTION controlp INFIELD b_nmbb030 name="construct.c.filter.page1.b_nmbb030"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmbb030()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb030  #顯示到畫面上
            NEXT FIELD b_nmbb030                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb042>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb042
            #add-point:ON ACTION controlp INFIELD b_nmbb042 name="construct.c.filter.page1.b_nmbb042"
            
            #END add-point
 
 
         #----<<b_nmbb040>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb040
            #add-point:ON ACTION controlp INFIELD b_nmbb040 name="construct.c.filter.page1.b_nmbb040"
            
            #END add-point
 
 
         #----<<unrev>>----
         #----<<b_nmbbdocno>>----
         #Ctrlp:construct.c.page1.b_nmbbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbbdocno
            #add-point:ON ACTION controlp INFIELD b_nmbbdocno name="construct.c.filter.page1.b_nmbbdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " nmbb026 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrda_m.xrdald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND nmbb026 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_nmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbbdocno  #顯示到畫面上
            NEXT FIELD b_nmbbdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbbseq>>----
         #Ctrlp:construct.c.filter.page1.b_nmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbbseq
            #add-point:ON ACTION controlp INFIELD b_nmbbseq name="construct.c.filter.page1.b_nmbbseq"
            
            #END add-point
 
 
         #----<<b_nmbborga>>----
         #Ctrlp:construct.c.page1.b_nmbborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbborga
            #add-point:ON ACTION controlp INFIELD b_nmbborga name="construct.c.filter.page1.b_nmbborga"
            #應用 a08 樣板自動產生(Version:2)
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str      #161017-00011#1 Add
            LET l_ld_str = cl_replace_str(l_ld_str,"ooef001","nmbborga")   #161017-00011#1 Add
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_ld_str CLIPPED   #161017-00011#1 Add
            CALL q_nmbborga_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbborga  #顯示到畫面上
            NEXT FIELD b_nmbborga                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbborga_desc>>----
         #----<<b_nmbb026>>----
         #Ctrlp:construct.c.page1.b_nmbb026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb026
            #add-point:ON ACTION controlp INFIELD b_nmbb026 name="construct.c.filter.page1.b_nmbb026"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_glaa.glaacomp   #161111-00049#2 Add
            #151231-00010#7--(S)
            LET g_qryparam.where = " nmbb026 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrda_m.xrdald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND nmbb026 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_nmbb026_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb026  #顯示到畫面上
            NEXT FIELD b_nmbb026                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb026_desc>>----
         #----<<flag>>----
         #----<<b_xrdadocdt>>----
         #----<<b_xrce002>>----
         #----<<b_xrce024>>----
         #----<<b_xrce003>>----
         #----<<b_xrce014>>----
         #Ctrlp:construct.c.filter.page2.b_xrce014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrce014
            #add-point:ON ACTION controlp INFIELD b_xrce014 name="construct.c.filter.page2.b_xrce014"
            
            #END add-point
 
 
         #----<<b_xrce005>>----
         #----<<b_xrcb031>>----
         #----<<b_xrcc003>>----
         #----<<b_xrce100>>----
         #----<<b_xrce109>>----
         #----<<b_xrce119>>----
         #----<<delay>>----
         #----<<b_xrda006>>----
         #----<<b_xrda006_desc>>----
         #----<<b_xrdadocno>>----
         #----<<b_xrce004>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
          CALL cl_set_comp_visible("b_nmbb053_desc,b_nmbborga_desc,b_nmbb003_desc", FALSE)  
          CALL cl_set_comp_visible("b_nmbb053,b_nmbborga,b_nmbb003", TRUE)  
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
   
      CALL axrq410_filter_show('nmbb027','b_nmbb027')
   CALL axrq410_filter_show('nmbadocdt','b_nmbadocdt')
   CALL axrq410_filter_show('nmbb029','b_nmbb029')
   CALL axrq410_filter_show('nmbb004','b_nmbb004')
   CALL axrq410_filter_show('nmbb006','b_nmbb006')
   CALL axrq410_filter_show('nmbb053','b_nmbb053')
   CALL axrq410_filter_show('nmbb031','b_nmbb031')
   CALL axrq410_filter_show('nmbb003','b_nmbb003')
   CALL axrq410_filter_show('nmbb030','b_nmbb030')
   CALL axrq410_filter_show('nmbb042','b_nmbb042')
   CALL axrq410_filter_show('nmbb040','b_nmbb040')
   CALL axrq410_filter_show('nmbbdocno','b_nmbbdocno')
   CALL axrq410_filter_show('nmbbseq','b_nmbbseq')
   CALL axrq410_filter_show('nmbborga','b_nmbborga')
   CALL axrq410_filter_show('nmbb026','b_nmbb026')
   CALL axrq410_filter_show('xrce014','b_xrce014')
 
    
   CALL axrq410_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq410.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq410_filter_parser(ps_field)
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
 
{<section id="axrq410.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq410_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq410.insert" >}
#+ insert
PRIVATE FUNCTION axrq410_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq410.modify" >}
#+ modify
PRIVATE FUNCTION axrq410_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq410.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq410_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq410.delete" >}
#+ delete
PRIVATE FUNCTION axrq410_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq410.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq410_detail_action_trans()
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
 
{<section id="axrq410.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq410_detail_index_setting()
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
            IF g_nmbb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmbb_d.getLength() AND g_nmbb_d.getLength() > 0
            LET g_detail_idx = g_nmbb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmbb_d.getLength() THEN
               LET g_detail_idx = g_nmbb_d.getLength()
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
 
{<section id="axrq410.mask_functions" >}
 &include "erp/axr/axrq410_mask.4gl"
 
{</section>}
 
{<section id="axrq410.other_function" readonly="Y" >}

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrq410_def()
# Input parameter:  
# Date & Author..: 2014/9/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq410_def()
   DEFINE l_xrdacomp_desc         LIKE type_t.chr500
   DEFINE l_success               LIKE type_t.chr1
   DEFINE l_sql                   STRING


   #根據人員抓取對應法人的主帳套
   SELECT DISTINCT glaald INTO g_xrda_m.xrdald
     FROM glaa_t,ooef_t,ooag_t
    WHERE ooag004 = ooef001
      AND ooagent = ooefent
      AND glaacomp = ooef017
      AND ooefent = glaaent
      AND glaa014 = 'Y'
      AND ooag001 = g_user
      AND glaaent = g_enterprise

   #根據帳套檢查該員工是否有使用權限
   CALL s_ld_chk_authorization(g_user,g_xrda_m.xrdald) RETURNING l_success
   IF l_success = 'N' THEN
      LET g_xrda_m.xrdald   = NULL
   END IF

   CALL s_axrt300_sel_ld(g_xrda_m.xrdald) RETURNING l_success,g_ls
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

   CALL s_axrt300_xrca_ref('xrcald',g_xrda_m.xrdald,'','') RETURNING l_success,g_xrda_m.xrdald_desc
   CALL s_axrt300_xrca_ref('xrcasite',g_xrda_m.xrdacomp,'','') RETURNING l_success,l_xrdacomp_desc
   IF NOT cl_null(g_xrda_m.xrdacomp) THEN LET g_xrda_m.xrdacomp = g_xrda_m.xrdacomp,'(',l_xrdacomp_desc,')' END IF

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrq410_xrda_desc()
# Input parameter:  
# Date & Author..: 2014/9/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq410_xrda_desc()
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
   CALL s_axrt300_sel_ld(g_xrda_m.xrdald) RETURNING l_success,g_ls
   DISPLAY BY NAME g_xrda_m.xrdald_desc,g_xrda_m.xrdacomp
   
END FUNCTION

################################################################################
# Descriptions...: 單身一：收款單身
# Memo...........:
# Usage..........: CALL axrq410_b_fill1()
# Input parameter:  
# Date & Author..: 2014/9/14 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq410_b_fill1()
   DEFINE l_flag     LIKE type_t.num5
   DEFINE ls_wc1     STRING
   DEFINE l_success  LIKE type_t.chr1   
   DEFINE l_pmaa004  LIKE pmaa_t.pmaa004 
   DEFINE l_xrdald_desc LIKE type_t.chr500 
   DEFINE l_nmbb029  LIKE type_t.chr500 
   DEFINE l_nmbb042  LIKE type_t.chr500
   DEFINE l_ld_str   STRING   #160811-00009#2
   
   #2015/5/27--XG
   CALL axrq410_create_tmp()
   DELETE FROM axrq410_print_tmp
   LET l_xrdald_desc = g_xrda_m.xrdald," ",g_xrda_m.xrdald_desc," ",g_xrda_m.xrdacomp
   #2015/5/27--XG
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   
   IF cl_null(g_wc_table) THEN
      LET g_wc_table = " 1=1"
   END IF   

   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF

   IF cl_null(g_wc_qbe) THEN
      LET g_wc_qbe = " 1=1"
   END IF   
   
   #151231-00010#7--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc = g_wc,"AND nmbb026 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
   
   CASE
      WHEN g_ls = '1'
         LET ls_wc1= "nmbb006 - nmbb008"
      WHEN g_ls = '2'
         LET ls_wc1 = "nmbb006 - nmbb020"
      WHEN g_ls = '3'
         LET ls_wc1 = "nmbb006 - nmbb023"
   END CASE

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str      #161017-00011#1 Add
   LET l_ld_str = cl_replace_str(l_ld_str,"ooef001","nmbborga")   #161017-00011#1 Add

   #收款單身
   LET g_sql = " SELECT UNIQUE 'N',nmbb027,'',nmbadocdt,nmbb029,nmbb004,nmbb006,nmbb053,'',nmbb031,nmbb003,'',",
               "        nmbb030,nmbb042,nmbb040,SUM(",ls_wc1,"),",
               "        nmbbdocno,nmbbseq,nmbborga,'',nmbb026,''", 
               "   FROM nmba_t,nmbb_t",
               "   WHERE nmbaent=nmbbent AND nmbacomp=nmbbcomp AND nmbadocno=nmbbdocno ",
               "     AND nmbbent=",g_enterprise," AND nmbbcomp='",g_glaa.glaacomp,"'",
	            "     AND nmbastus <> 'X' ",
	            "     AND nmbb001= '1' ",               
	            "     AND nmba003 NOT IN ('anmt310','anmt440')",#160912-00011#1 Add
               "     AND ",g_wc," AND ",g_wc_qbe," AND ",g_wc_table," AND ",g_wc_filter,
               "     AND ",l_ld_str CLIPPED,   #161017-00011#1 Add
               " GROUP BY nmbb027,nmbadocdt,nmbb029,nmbb004,nmbb006,nmbb053,nmbb031,nmbb003,nmbb030,nmbb042,nmbb040,",
               "          nmbbdocno,nmbbseq,nmbborga,nmbb026 "
           
   PREPARE axrq410_nmbb_prep FROM g_sql
   DECLARE axrq410_nmbb_curs CURSOR FOR axrq410_nmbb_prep
   CALL g_nmbb_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH axrq410_nmbb_curs INTO g_nmbb_d[l_ac].*
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbb:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #繳款人員
      CALL s_axrt300_xrca_ref('xrca003',g_nmbb_d[l_ac].nmbb053,'','') RETURNING l_success,g_rtn_fields[1]
      IF NOT cl_null(g_rtn_fields[1]) THEN
         LET g_nmbb_d[l_ac].nmbb053_desc = g_nmbb_d[l_ac].nmbb053,'(',g_rtn_fields[1],')'
      ELSE
         LET g_nmbb_d[l_ac].nmbb053_desc = g_nmbb_d[l_ac].nmbb053
      END IF

      #公司收款帳戶
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb003
      CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(g_rtn_fields[1]) THEN
         LET g_nmbb_d[l_ac].nmbb003_desc = g_nmbb_d[l_ac].nmbb003,'(', g_rtn_fields[1] , ')'
      ELSE
         LET g_nmbb_d[l_ac].nmbb003_desc = g_nmbb_d[l_ac].nmbb003
      END IF
  
      #來源組織名稱
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbborga
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF NOT cl_null(g_rtn_fields[1]) THEN
         LET g_nmbb_d[l_ac].nmbborga_desc = g_nmbb_d[l_ac].nmbborga,'(', g_rtn_fields[1] , ')'
      ELSE
         LET g_nmbb_d[l_ac].nmbborga_desc = g_nmbb_d[l_ac].nmbborga
      END IF 
  

      #收款對象
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb026
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbb_d[l_ac].nmbb026_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmbb_d[l_ac].nmbb026_desc

      #繳款對象
      SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t WHERE pmaaent = g_enterprise
         AND pmaa001 = g_nmbb_d[l_ac].nmbb026

      #nmbb027_ref
      CASE l_pmaa004 
        WHEN '2'    #2.一次性交易對象pmak
             LET g_rtn_fields[1] = ''
             SELECT pmak003 INTO g_rtn_fields[1] FROM pmak_t WHERE pmakent = g_enterprise
                AND pmak001 = g_nmbb_d[l_ac].nmbb027

        WHEN '4'    #4.員工ooga
              LET g_rtn_fields[1] = ''
              LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb027
              CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields 

        OTHERWISE 
              LET g_rtn_fields[1] = ''
              CALL s_axrt300_xrca_ref('xrca005',g_master.nmbb027,'','') RETURNING l_success,g_rtn_fields[1]

      END CASE  
      
      LET g_nmbb_d[l_ac].nmbb027_desc = g_rtn_fields[1]
    
      #背書轉入 
      IF cl_null(g_nmbb_d[l_ac].nmbb040) THEN
         LET g_nmbb_d[l_ac].nmbb040 = 'N'
      END IF

      #2015/5/27---XG
      IF NOT cl_null( g_nmbb_d[l_ac].nmbb029) THEN
         LET l_nmbb029 = g_nmbb_d[l_ac].nmbb029,":",s_desc_gzcbl004_desc('8310',g_nmbb_d[l_ac].nmbb029)
      END IF
      IF NOT cl_null( g_nmbb_d[l_ac].nmbb042) THEN
         LET l_nmbb042 = g_nmbb_d[l_ac].nmbb042,":",s_desc_gzcbl004_desc('8711',g_nmbb_d[l_ac].nmbb042)
      END IF
      
      INSERT INTO axrq410_print_tmp VALUES(l_xrdald_desc,g_nmbb_d[l_ac].nmbb027_desc,
         g_nmbb_d[l_ac].nmbadocdt,l_nmbb029,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb006,
         g_nmbb_d[l_ac].nmbb053_desc,g_nmbb_d[l_ac].nmbb031,
         g_nmbb_d[l_ac].nmbb003_desc,g_nmbb_d[l_ac].nmbb030,l_nmbb042,g_nmbb_d[l_ac].nmbb040,
         g_nmbb_d[l_ac].unrev,g_nmbb_d[l_ac].nmbbdocno,g_nmbb_d[l_ac].nmbbseq,g_nmbb_d[l_ac].nmbborga,
         g_nmbb_d[l_ac].nmbborga_desc,g_nmbb_d[l_ac].nmbb026,g_nmbb_d[l_ac].nmbb026_desc)
      #2015/5/27---XG

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH

   LET g_error_show = 0
   CALL g_nmbb_d.deleteElement(g_nmbb_d.getLength())   
   
   #單身總筆數顯示
   LET g_detail_cnt = g_nmbb_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   LET l_ac = 1
   
   CALL cl_set_comp_visible("b_nmbb053_desc,b_nmbborga_desc,b_nmbb003_desc", TRUE)  
   CALL cl_set_comp_visible("b_nmbb053,b_nmbborga,b_nmbb003", FALSE)  
               
   CALL axrq410_b_fill2()
END FUNCTION

################################################################################
# Descriptions...: 單身二：沖銷單信息
# Memo...........:
# Usage..........: CALL axrq410_b_fill2()
# Input parameter:  
# Date & Author..: 2014/9/14 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq410_b_fill2()
DEFINE l_xrdald_desc LIKE type_t.chr500
DEFINE l_flag        LIKE type_t.chr500
DEFINE l_xrce002     LIKE type_t.chr500
   DEFINE l_ld_str   STRING   #160811-00009#2
   
   #2015/5/27--XG
   DELETE FROM axrq410_tmp01   #160727-00019#6  2016/07/28  By 08734    axrq410_print_tmp1 ——> axrq410_tmp01
   LET l_xrdald_desc = g_xrda_m.xrdald," ",g_xrda_m.xrdald_desc," ",g_xrda_m.xrdacomp
   #2015/5/27--XG   
   #141226-00016#12

  #141226-00016#12 Mark ---(S)---
  ##收款沖銷&直接沖銷
  #LET g_sql=" SELECT '4' flag,xrdadocdt,xrce002,xrce024,xrce003,xrce014,xrce005,null,null,",
  #          "        xrce100,SUM(xrce109),SUM(xrce119),0,null,null,xrdadocno,xrce004 ",
  #          "   FROM xrda_t,xrce_t ",
  #          "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",            
  #          "    AND xrdaent=",g_enterprise," AND xrdald='",g_xrda_m.xrdald,"' ",
  #          "    AND xrdadocno IN (SELECT xrdadocno FROM xrda_t,xrce_t ",
  #          "                       WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
  #          "                         AND xrce001 = 'axrt400' AND xrce003='",g_nmbb_d[l_ac].nmbbdocno,"' AND xrdastus='Y' ",
  #          "                         AND xrdaent=",g_enterprise," AND xrdald='",g_xrda_m.xrdald,"' ",
  #          "                         AND xrce004='",g_nmbb_d[l_ac].nmbbseq,"' )",
  #          "    AND xrce002 IN ('20','21','22','30','31','32','40','41','42') ",
  #          "  GROUP BY xrdadocdt,xrce002,xrce024,xrce003,xrce014,xrce005,xrce100,xrda006,xrdadocno,xrce004 ",
  #          " UNION ",
  #          " SELECT '3' flag,xrcadocdt,xrce002,xrca018,xrce003,null,xrce005,xrca008,xrca009,",
  #          "        xrce100,SUM(xrce109),SUM(xrce119),0,xrca057,null,xrcadocno,xrce004 ",
  #          "   FROM xrca_t,xrce_t ",
  #          "  WHERE xrcaent=xrceent AND xrcald=xrceld AND xrcadocno=xrcedocno ",
  #          "    AND xrcaent=",g_enterprise," AND xrcald='",g_xrda_m.xrdald,"' ",
  #          "    AND xrce001 = 'axrt300'",             
  #          "    AND xrce003='",g_nmbb_d[l_ac].nmbbdocno,"' AND xrcastus='Y' ",
  #          "    AND xrce004='",g_nmbb_d[l_ac].nmbbseq,"' ",
  #          "  GROUP BY xrcadocdt,xrce002,xrca018,xrce003,xrce005,xrca008,xrca009,xrce100,xrca057,xrcadocno,xrce004 "
  #141226-00016#12 Mark ---(E)---

   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str   #161017-00011#1 Add
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrdeld")   #161017-00011#1 Add

  #141226-00016#12 Add  ---(S)---
   #收款沖銷&直接沖銷
   LET g_sql=" SELECT '4' flag,xrdadocdt,xrce002,xrce024,xrce003,xrce014,xrce005,null,null,",
             "        xrce100,SUM(xrce109),SUM(xrce119),0,null,null,xrdadocno,xrce004 ",
             "   FROM xrda_t,xrce_t ",
             "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",            
             "    AND xrdaent=",g_enterprise," AND xrdald='",g_xrda_m.xrdald,"' ",
             "    AND xrdadocno IN (SELECT xrdadocno FROM xrda_t,xrde_t ",
             "                       WHERE xrdaent=xrdeent AND xrdald=xrdeld AND xrdadocno=xrdedocno ",
             "                         AND xrde001 = 'axrt400' AND xrde003='",g_nmbb_d[l_ac].nmbbdocno,"' AND xrdastus='Y' ",
             "                         AND xrdaent=",g_enterprise," AND xrdald='",g_xrda_m.xrdald,"' ",
             "                         AND ",l_ld_str CLIPPED,   #161017-00011#1 Add
             "                         AND xrde004='",g_nmbb_d[l_ac].nmbbseq,"' )",
             "    AND xrce002 IN ('20','21','22','30','31','32','40','41','42') ",
             "  GROUP BY xrdadocdt,xrce002,xrce024,xrce003,xrce014,xrce005,xrce100,xrda006,xrdadocno,xrce004 ",
             " UNION ",
             " SELECT '3' flag,xrcadocdt,xrde002,xrca018,xrde003,null,0,xrca008,xrca009,",
             "        xrde100,SUM(xrde109),SUM(xrde119),0,xrca057,null,xrcadocno,xrde004 ",
             "   FROM xrca_t,xrde_t ",
             "  WHERE xrcaent=xrdeent AND xrcald=xrdeld AND xrcadocno=xrdedocno ",
             "    AND xrcaent=",g_enterprise," AND xrcald='",g_xrda_m.xrdald,"' ",
             "    AND xrde001 = 'axrt300'",             
             "    AND xrde003='",g_nmbb_d[l_ac].nmbbdocno,"' AND xrcastus='Y' ",
             "    AND xrde004='",g_nmbb_d[l_ac].nmbbseq,"' ",
             "    AND ",l_ld_str CLIPPED,   #161017-00011#1 Add
             "  GROUP BY xrcadocdt,xrde002,xrca018,xrde003,xrca008,xrca009,xrde100,xrca057,xrcadocno,xrde004 ",
             #161101-00025#1 Add  ---(S)---
             " UNION ",
             " SELECT '4' flag,xrdadocdt,xrde002,'',xrde014,xrde014,0,null,null,",
             "        xrde100,SUM(xrde109),SUM(xrde119),0,null,null,xrdadocno,xrde004 ",
             "   FROM xrda_t,xrde_t ",
             "  WHERE xrdaent=xrdeent AND xrdald=xrdeld AND xrdadocno=xrdedocno ",            
             "    AND xrdaent=",g_enterprise," AND xrdald='",g_xrda_m.xrdald,"' ",
             "    AND xrdadocno IN (SELECT xrdadocno FROM xrda_t,xrde_t ",
             "                       WHERE xrdaent=xrdeent AND xrdald=xrdeld AND xrdadocno=xrdedocno ",
             "                         AND xrde001 = 'axrt400' AND xrde003='",g_nmbb_d[l_ac].nmbbdocno,"' AND xrdastus='Y' ",
             "                         AND xrdaent=",g_enterprise," AND xrdald='",g_xrda_m.xrdald,"' ",
             "                         AND ",l_ld_str CLIPPED,   #161017-00011#1 Add
             "                         AND xrde004='",g_nmbb_d[l_ac].nmbbseq,"' )",
             "    AND xrde002 IN ('20','21','22') ",
             "  GROUP BY xrdadocdt,xrde002,'',xrde014,xrde014,xrde100,xrda006,xrdadocno,xrde004 "
             #161101-00025#1 Add  ---(E)---
  #141226-00016#12 Add  ---(E)---
    
   PREPARE axrq410_pb2 FROM g_sql
   DECLARE axrq410_curs2 CURSOR FOR axrq410_pb2
   CALL g_nmbb2_d.clear()
 
   LET l_ac2 = 1
   FOREACH axrq410_curs2 INTO g_nmbb2_d[l_ac2].*

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #收款沖銷 flag='4'
      #收款條件、應收款日、沖銷對象
      IF g_nmbb2_d[l_ac2].flag = '4' THEN 
         IF g_nmbb2_d[l_ac2].xrce002 = '30' OR g_nmbb2_d[l_ac2].xrce002 = '31' OR g_nmbb2_d[l_ac2].xrce002 = '32' THEN
            IF g_nmbb2_d[l_ac2].xrce004 = 0 THEN 
               SELECT xrcb031,xrcc003,xrca004 
                INTO g_nmbb2_d[l_ac2].xrcb031,g_nmbb2_d[l_ac2].xrcc003,g_nmbb2_d[l_ac2].xrda006          
                FROM xrcb_t,xrcc_t,xrca_t
               WHERE xrcaent=xrcbent AND xrcald=xrcbld  
                 AND xrcaent=xrccent AND xrcald=xrccld   
                 AND xrcbdocno = g_nmbb2_d[l_ac2].xrce003
                 AND xrcbdocno = xrccdocno      
                 AND xrcbdocno = xrcadocno 
                 AND xrcc001 = g_nmbb2_d[l_ac2].xrce005              
                 AND xrccseq IS NOT NULL  
            ELSE
               SELECT xrcb031,xrcc003,xrca004  
                INTO g_nmbb2_d[l_ac2].xrcb031,g_nmbb2_d[l_ac2].xrcc003,g_nmbb2_d[l_ac2].xrda006                 
                FROM xrcb_t,xrcc_t,xrca_t
               WHERE xrcaent=xrcbent AND xrcald=xrcbld  
                 AND xrcaent=xrccent AND xrcald=xrccld   
                 AND xrcbdocno = g_nmbb2_d[l_ac2].xrce003
                 AND xrcbdocno = xrccdocno      
                 AND xrcbdocno = xrcadocno   
                 AND xrcc001 = g_nmbb2_d[l_ac2].xrce005             
                 AND xrccseq = g_nmbb2_d[l_ac2].xrce004
            END IF     
         END IF

         IF g_nmbb2_d[l_ac2].xrce002 = '40' OR g_nmbb2_d[l_ac2].xrce002 = '41' OR g_nmbb2_d[l_ac2].xrce002 = '42' THEN 
            IF g_nmbb2_d[l_ac2].xrce004 = 0 THEN 
               SELECT apcb030,apcc003,apca004 
                INTO g_nmbb2_d[l_ac2].xrcb031,g_nmbb2_d[l_ac2].xrcc003,g_nmbb2_d[l_ac2].xrda006           
                FROM apcb_t,apcc_t,apca_t
               WHERE apcbdocno = g_nmbb2_d[l_ac2].xrce003 
                 AND apcald = apccld AND apcald = apcbld
                 AND apcaent = apccent AND apcaent = apcbent
                 AND apcadocno = apccdocno      
                 AND apcadocno = apcbdocno
                 AND apcc001 = g_nmbb2_d[l_ac2].xrce005      
                 AND apccseq IS NOT NULL
            ELSE
               SELECT apcb030,apcc003,apca004 
                 INTO g_nmbb2_d[l_ac2].xrcb031,g_nmbb2_d[l_ac2].xrcc003,g_nmbb2_d[l_ac2].xrda006                 
                FROM apcb_t,apcc_t,apca_t
               WHERE apcbdocno = g_nmbb2_d[l_ac2].xrce003 
                 AND apcald = apccld AND apcald = apcbld
                 AND apcaent = apccent AND apcaent = apcbent
                 AND apcadocno = apccdocno      
                 AND apcadocno = apcbdocno
                 AND apcc001 = g_nmbb2_d[l_ac2].xrce005      
                 AND apccseq = g_nmbb2_d[l_ac2].xrce004            
            END IF                 
         END IF

         IF g_nmbb2_d[l_ac2].xrce002 = '20' OR g_nmbb2_d[l_ac2].xrce002 = '22' THEN 
            SELECT xrcb031,xrcc003,xrca004 
              INTO g_nmbb2_d[l_ac2].xrcb031,g_nmbb2_d[l_ac2].xrcc003,g_nmbb2_d[l_ac2].xrda006   
              FROM xrcb_t,xrcc_t,xrca_t
             WHERE xrcbdocno = g_nmbb2_d[l_ac2].xrce014   
               AND xrcadocno = xrcbdocno      
               AND xrcadocno = xrccdocno
               AND xrcald = xrcbld AND xrcald = xrccld 
               AND xrcaent = xrcbent AND xrcaent = xrccent 
              #AND xrcc001 = 1    #161101-00025#1 Mark
         END IF

         IF g_nmbb2_d[l_ac2].xrce002 = '21' THEN 
            SELECT apcb031,apcc003,apca004
              INTO g_nmbb2_d[l_ac2].xrcb031,g_nmbb2_d[l_ac2].xrcc003,g_nmbb2_d[l_ac2].xrda006              
              FROM apcb_t,apcc_t,apca_t
             WHERE apcbdocno = g_nmbb2_d[l_ac2].xrce014   
               AND apcadocno = apcbdocno      
               AND apcadocno = apccdocno
               AND apcald = apcbld AND apcald = apccld 
               AND apcaent = apcbent AND apcaent = apccent 
               AND apcc001 = 1 
         END IF  
      END IF
      
      #沖銷對象
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbb2_d[l_ac2].xrda006
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbb2_d[l_ac2].xrda006_desc = '', g_rtn_fields[1] , ''

      #逾期天數
      LET g_nmbb2_d[l_ac2].delay = g_nmbb2_d[l_ac2].xrcc003 - g_nmbb_d[l_ac].nmbadocdt    #141226-00016#12 Mod l_ac2 --> l_ac

      #2015/5/27---XG
      IF NOT cl_null(g_nmbb2_d[l_ac2].flag) THEN
         LET l_flag = g_nmbb2_d[l_ac2].flag,":",s_desc_gzcbl004_desc('8333',g_nmbb2_d[l_ac2].flag)
      END IF
      IF NOT cl_null(g_nmbb2_d[l_ac2].xrce002) THEN
         LET l_xrce002 = g_nmbb2_d[l_ac2].xrce002,":",s_desc_gzcbl004_desc('8306',g_nmbb2_d[l_ac2].xrce002)
      END IF
      
      INSERT INTO axrq410_tmp01 VALUES(l_xrdald_desc,l_flag,g_nmbb2_d[l_ac2].xrdadocdt,  #160727-00019#6  2016/07/28  By 08734    axrq410_print_tmp1 ——> axrq410_tmp01
          l_xrce002,g_nmbb2_d[l_ac2].xrce024,g_nmbb2_d[l_ac2].xrce003,g_nmbb2_d[l_ac2].xrce014,
          g_nmbb2_d[l_ac2].xrce005,g_nmbb2_d[l_ac2].xrcb031,g_nmbb2_d[l_ac2].xrcc003,g_nmbb2_d[l_ac2].xrce100,
          g_nmbb2_d[l_ac2].xrce109,g_nmbb2_d[l_ac2].xrce119,g_nmbb2_d[l_ac2].delay,g_nmbb2_d[l_ac2].xrda006,
          g_nmbb2_d[l_ac2].xrda006_desc,g_nmbb2_d[l_ac2].xrdadocno,g_nmbb2_d[l_ac2].xrce004)
      #2015/5/27---XG
 
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
 
   CALL g_nmbb2_d.deleteElement(g_nmbb2_d.getLength())   
END FUNCTION

################################################################################
# Descriptions...: 新建臨時表XG
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq410_create_tmp()
   DROP TABLE axrq410_print_tmp;
      CREATE TEMP TABLE axrq410_print_tmp(
   xrdald_desc LIKE type_t.chr500, 
   nmbb027_desc LIKE type_t.chr500, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmbb029 LIKE type_t.chr500, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb006 LIKE nmbb_t.nmbb006,
   nmbb053_desc LIKE type_t.chr500, 
   nmbb031 LIKE nmbb_t.nmbb031, 
   nmbb003_desc LIKE type_t.chr500, 
   nmbb030 LIKE nmbb_t.nmbb030, 
   nmbb042 LIKE type_t.chr500, 
   nmbb040 LIKE nmbb_t.nmbb040, 
   unrev LIKE type_t.num20_6, 
   nmbbdocno LIKE nmbb_t.nmbbdocno, 
   nmbbseq LIKE nmbb_t.nmbbseq, 
   nmbborga LIKE nmbb_t.nmbborga, 
   nmbborga_desc LIKE type_t.chr500,
   nmbb026 LIKE nmbb_t.nmbb026,
   nmbb026_desc LIKE type_t.chr500 
       )
DROP TABLE axrq410_tmp01;  #160727-00019#6  2016/07/28  By 08734    axrq410_print_tmp1 ——> axrq410_tmp01
      CREATE TEMP TABLE axrq410_tmp01(  #160727-00019#6  2016/07/28  By 08734    axrq410_print_tmp1 ——> axrq410_tmp01
       xrdald_desc LIKE type_t.chr500,
   flag LIKE type_t.chr500, 
   xrdadocdt LIKE xrda_t.xrdadocdt, 
   xrce002 LIKE type_t.chr500, 
   xrce024 LIKE xrce_t.xrce024, 
   xrce003 LIKE xrce_t.xrce003, 
   xrce014 LIKE xrce_t.xrce014, 
   xrce005 LIKE xrce_t.xrce005, 
   xrcb031 LIKE xrcb_t.xrcb031, 
   xrcc003 LIKE xrcc_t.xrcc003, 
   xrce100 LIKE xrce_t.xrce100, 
   xrce109 LIKE xrce_t.xrce109, 
   xrce119 LIKE xrce_t.xrce119, 
   delay LIKE type_t.chr80, 
   xrda006 LIKE xrda_t.xrda006, 
   xrda006_desc LIKE type_t.chr500, 
   xrdadocno LIKE xrda_t.xrdadocno, 
   xrce004 LIKE xrce_t.xrce004
   )
END FUNCTION

 
{</section>}
 
