#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq911.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:19(2016-12-26 15:41:36), PR版次:0019(2017-01-25 12:41:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: axrq911
#+ Description: 客戶帳款明細查詢
#+ Creator....: 01727(2015-02-12 12:34:41)
#+ Modifier...: 03080 -SD/PR- 07900
 
{</section>}
 
{<section id="axrq911.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1              By Reanna 法人開窗修改
#150311-00003#2              By 01727  增加捉取直接沖帳的數據
#150311-00003#2              By 01727  将當期立帳的調汇金額獨立顯示
#150902-00001#6              By Hans   科目後加傳票號碼, 發票號碼取主檔 xrca066
#151111-00004#1   2015/11/11 By 01727  1.跨期查询时,期初余额取值错误（应该以起始日期抓上期的月结档,目前抓了截止日期的上期月结档金额）
#                                      2.排序顺序调整,把单据日期放到币别排序后面
#                                      3.期末余额那一行,业务人员、人员名称、传票编号需清空
#160318-00025#47  2016/04/29 By 07959  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00007#24  2016/05/30 By 02599  程式优化
#160727-00019#6   2016/07/28 By 08734  axrq911_bfill_tmp ——> axrq911_tmp01
#160731-00372#1   2016/08/19 By 07900  客户开窗不要开供应商
#160816-00071#1   2016/08/22 By 01258  从临时表查资料，不要匹配权限条件，否则普通用户查不到！
#160913-00017#10  2016/09/22 By 07900  AXR模组调整交易客商开窗
#161021-00050#6   2016/10/26 By 08729  處理組織開窗
#161123-00027#1   2016/11/23 By 01727  单身查询时加上科目条件则查不到期初金额
#161111-00049#9   2016/11/28 By 01727  控制组权限修改
#161208-00002#1   2016/12/08 By 05016  當 aoos020 應收/付沖帳參數設定為 3.沖銷至明細時,以下相關查詢呈現的科目請抓取單身科目為主:aapq911,axrq911,aapq930,axrq930
#161221-00050#1   161226     By albireo   查詢時使用b_xrca001,顯示時用xrca001_desc欄位達到查詢可以下條件,EXCEL匯出與報表能正常顯示說明的效果
#170124-00013#2   2017/01/25 By 07900  應收/應付 帳齡分析表及月結表，因採月底重評價作業期初迴轉，故相關的結帳報表,期初值應扣減重評價金額。
#                                      取期初值時, 判斷是否有迴轉 IF glca002 = '2' THEN   #次月迴轉
#                                      期初【本幣】值必須先扣減 [上一期]的重評價金額 xreb115 本期匯差金額 其它的不變
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
PRIVATE TYPE type_g_xrca_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   xrcacomp LIKE xrca_t.xrcacomp, 
   xrcacomp_desc LIKE type_t.chr500, 
   xrcald LIKE xrca_t.xrcald, 
   xrcald_desc LIKE type_t.chr500, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr500, 
   xrca014 LIKE xrca_t.xrca014, 
   xrca014_desc LIKE type_t.chr500, 
   type LIKE type_t.chr500, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca001 LIKE xrca_t.xrca001, 
   xrca001_desc LIKE type_t.chr500, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcb047 LIKE xrcb_t.xrcb047, 
   xrca035 LIKE xrca_t.xrca035, 
   xrca035_desc LIKE type_t.chr500, 
   xrca038 LIKE xrca_t.xrca038, 
   xrca066 LIKE xrca_t.xrca066, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca108 LIKE xrca_t.xrca108, 
   l_xrca1081 LIKE type_t.num20_6, 
   l_xrca1082 LIKE type_t.num20_6, 
   xrca118 LIKE xrca_t.xrca118, 
   l_xrca1181 LIKE type_t.num20_6, 
   l_xrca1182 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
       xrcasite      LIKE xrca_t.xrcasite,
       xrcasite_desc LIKE type_t.chr100,
       strdate       LIKE xrca_t.xrcadocdt,
       enddate       LIKE xrca_t.xrcadocdt,
       curr          LIKE type_t.chr1,
       xrcastus      LIKE type_t.chr1
END RECORD       
     
DEFINE g_wc_xrcald   STRING
DEFINE g_wc_xrcacomp STRING    

DEFINE g_xrcald       LIKE xrca_t.xrcald
DEFINE g_xrca004       LIKE xrca_t.xrca004
DEFINE g_xrca100       LIKE xrca_t.xrca100
DEFINE g_xrca_d2        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       xrcald          LIKE xrca_t.xrcald,
       xrca004         LIKE xrca_t.xrca004,
       xrca100         LIKE xrca_t.xrca100
      END RECORD
DEFINE g_current_idx   LIKE type_t.num10
DEFINE g_jump          LIKE type_t.num10
DEFINE g_no_ask        LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5

DEFINE g_xrcasite      LIKE xrca_t.xrcasite
DEFINE g_year          LIKE type_t.chr100
DEFINE g_strmon        LIKE type_t.chr100
DEFINE g_endmon        LIKE type_t.chr100
DEFINE g_ld            LIKE xrca_t.xrcald
DEFINE g_currency      LIKE type_t.chr100
DEFINE g_xrea009       LIKE xrea_t.xrea009
DEFINE xrcasite_t      LIKE xrca_t.xrcasite   #161021-00050#6 add
DEFINE g_sql_ctrl      STRING                 #161111-00049#9 Add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xrca_d
DEFINE g_master_t                   type_g_xrca_d
DEFINE g_xrca_d          DYNAMIC ARRAY OF type_g_xrca_d
DEFINE g_xrca_d_t        type_g_xrca_d
 
      
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
 
{<section id="axrq911.main" >}
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
  #161111-00049#2 Add  ---(S)---
   LET g_sql_ctrl = NULL
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#2 Add  ---(E)---
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
   DECLARE axrq911_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq911_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq911_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq911 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq911_init()   
 
      #進入選單 Menu (="N")
      CALL axrq911_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq911
      
   END IF 
   
   CLOSE axrq911_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq911.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq911_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_strdate  LIKE glav_t.glav004
   DEFINE l_enddate  LIKE glav_t.glav004 
   DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_preyear  LIKE xrea_t.xrea001 #上期年
   DEFINE l_premon   LIKE xrea_t.xrea002 #上期月
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_xrca001','8302') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL axrq911_create_tmp()
   #CALL cl_set_combo_scc('b_xrca001','8502')  #161221-00050#1 mark
   CALL cl_set_combo_scc('b_xrca001','8302')  #161221-00050#1   
   CALL s_fin_create_account_center_tmp()  
   CALL axrq911_default()   
   LET g_xrcasite = g_argv[1]  #帳務中心
   LET g_year     = g_argv[2]  #年度
   LET g_strmon   = g_argv[3]  #起始月
   LET g_endmon   = g_argv[4]  #結束月
   LET g_ld       = g_argv[5]  #帳套
   LET g_currency = g_argv[6]  #是否顯示幣別如果不為空 則顯示幣別 ELS 不顯示原幣   
   LET g_xrea009  = g_argv[7]  #帳款對象     

   IF NOT cl_null(g_argv[1]) THEN
      LET g_input.xrcasite = g_xrcasite   
      LET g_input.xrcasite_desc = s_desc_get_department_desc(g_input.xrcasite)
      LET g_input.xrcastus = '1'   
      CALL s_fin_account_center_sons_query('3',g_input.xrcasite,g_today,'1')
      #取得帳務中心底下之組織範圍
      #CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite   #150127-00007#1 mark
      CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
      CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp
      #取得帳務中心底下的帳套範圍   
      CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
      CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
      IF g_currency = 'N' THEN
         LET g_input.curr = 'N'
         LET g_currency = ''
         CALL cl_set_comp_visible('b_xrca100,b_xrca108,l_xrca1081,l_xrca1082',FALSE)
      ELSE
         LET g_input.curr = 'Y'
         CALL cl_set_comp_visible('b_xrca100,b_xrca108,l_xrca1081,l_xrca1082',TRUE)          
      END IF      
      #起始日期
      CALL s_ld_sel_glaa(g_ld,'glaa003') RETURNING g_sub_success,l_glaa003        
      CALL s_fin_date_get_period_range(l_glaa003,g_year,g_strmon)RETURNING g_input.strdate,l_enddate
      #如果取不到取上期會計日期的起始日期
      IF cl_null(g_input.strdate) THEN
         CALL s_fin_date_get_last_period(l_glaa003,g_ld,g_year,g_strmon)RETURNING g_sub_success,l_preyear,l_premon        
         CALL s_fin_date_get_period_range(l_glaa003,l_preyear,l_premon)RETURNING g_input.strdate,l_enddate                     
      END IF      
      CALL s_fin_date_get_period_range(l_glaa003,g_year,g_endmon)RETURNING l_enddate,g_input.enddate
      #如果取不到取上期會計日期的結束日期 
      IF cl_null(g_input.enddate) THEN 
         CALL s_fin_date_get_last_period(l_glaa003,g_ld,g_year,g_endmon)RETURNING g_sub_success,l_preyear,l_premon 
         CALL s_fin_date_get_period_range(l_glaa003,g_year,l_premon)RETURNING l_strdate,g_input.enddate  
      END IF
      DISPLAY BY NAME g_input.xrcasite,g_input.curr,g_input.strdate,g_input.enddate,
                      g_input.xrcasite_desc,g_input.strdate,g_input.enddate   
   END IF       
   
   CALL cl_set_comp_visible('b_xrca001',FALSE)
   CALL cl_set_comp_visible('b_acc',FALSE)
   #end add-point
 
   CALL axrq911_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq911.default_search" >}
PRIVATE FUNCTION axrq911_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xrcald = '", g_argv[08], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xrcadocno = '", g_argv[09], "' AND "
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
 
{<section id="axrq911.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq911_ui_dialog()
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
  #IF g_header_cnt=1 THEN
     CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
  #ELSE
  #   IF g_current_idx=1 THEN
  #      CALL cl_set_act_visible("first,previous", FALSE)
  #      CALL cl_set_act_visible("jump,next,last", TRUE)
  #   ELSE
  #      IF g_current_idx<>g_header_cnt THEN
  #         CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
  #      ELSE
  #         CALL cl_set_act_visible("first,previous,jump",TRUE)
  #         CALL cl_set_act_visible("next,last", FALSE)
  #      END IF
  #   END IF
  #END IF
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axrq911_b_fill()
   ELSE
      CALL axrq911_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrca_d.clear()
 
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
 
         CALL axrq911_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq911_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq911_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               #筆數設定             
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_xrca_d2.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xrca_d.getLength() TO FORMONLY.cnt
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
            CALL axrq911_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
           #IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
           #ELSE
           #   IF g_current_idx=1 THEN
           #      CALL cl_set_act_visible("first,previous", FALSE)
           #      CALL cl_set_act_visible("jump,next,last", TRUE)
           #   ELSE
           #      IF g_current_idx<>g_header_cnt THEN
           #         CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
           #      ELSE
           #         CALL cl_set_act_visible("first,previous,jump",TRUE)
           #         CALL cl_set_act_visible("next,last", FALSE)
           #      END IF
           #   END IF
           #END IF
           #CALL cl_set_comp_visible('sel', FALSE)
           #CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axrq911_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axrq911_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq911_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible('sel', FALSE)
               CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
               EXIT DIALOG
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
            CALL axrq911_filter()
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
            CALL axrq911_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrca_d)
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
            CALL axrq911_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq911_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq911_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq911_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xrca_d.getLength()
               LET g_xrca_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xrca_d.getLength()
               LET g_xrca_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xrca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrca_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xrca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrca_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
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
 
{<section id="axrq911.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq911_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_fday            LIKE xrca_t.xrcadocdt
   DEFINE l_success         LIKE type_t.chr1      #161021-00050#6 add
   DEFINE l_glaa004         LIKE glaa_t.glaa004   #161111-00049#9 Add
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#9 Add
   DEFINE l_ld_str          STRING                #161111-00049#9 Add
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   LET xrcasite_t = g_input.xrcasite  #161021-00050#6 add
   #161111-00049#9 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
   #161111-00049#9 Add  ---(E)---
   #161221-00050#1-----s
   CALL cl_set_comp_visible('b_xrca001',TRUE)
   CALL cl_set_comp_visible('xrca001_desc',FALSE)
   #161221-00050#1-----e
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrca_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON xrcacomp,xrcald,xrca004,xrca014,xrcadocdt,xrca001,xrcadocno,xrcb047,xrca035, 
          xrca038,xrca066,xrca100,xrca108,xrca118
           FROM s_detail1[1].b_xrcacomp,s_detail1[1].b_xrcald,s_detail1[1].b_xrca004,s_detail1[1].b_xrca014, 
               s_detail1[1].b_xrcadocdt,s_detail1[1].b_xrca001,s_detail1[1].b_xrcadocno,s_detail1[1].b_xrcb047, 
               s_detail1[1].b_xrca035,s_detail1[1].b_xrca038,s_detail1[1].b_xrca066,s_detail1[1].b_xrca100, 
               s_detail1[1].b_xrca108,s_detail1[1].b_xrca118
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_xrcacomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcacomp
            #add-point:BEFORE FIELD b_xrcacomp name="construct.b.page1.b_xrcacomp"
           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcacomp
            
            #add-point:AFTER FIELD b_xrcacomp name="construct.a.page1.b_xrcacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrcacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcacomp
            #add-point:ON ACTION controlp INFIELD b_xrcacomp name="construct.c.page1.b_xrcacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_xrcacomp
            #CALL q_ooef001()            #161021-00050#6 mark
            CALL q_ooef001_2()           #161021-00050#6 add   
            DISPLAY g_qryparam.return1 TO b_xrcacomp   
            NEXT FIELD b_xrcacomp
            #END add-point
 
 
         #----<<xrcacomp_desc>>----
         #----<<b_xrcald>>----
         #Ctrlp:construct.c.page1.b_xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcald
            #add-point:ON ACTION controlp INFIELD b_xrcald name="construct.c.page1.b_xrcald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glaald IN ",g_wc_xrcald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_xrcald
            NEXT FIELD b_xrcald


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcald
            #add-point:BEFORE FIELD b_xrcald name="construct.b.page1.b_xrcald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcald
            
            #add-point:AFTER FIELD b_xrcald name="construct.a.page1.b_xrcald"
            
            #END add-point
            
 
 
         #----<<xrcald_desc>>----
         #----<<b_xrca004>>----
         #Ctrlp:construct.c.page1.b_xrca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca004
            #add-point:ON ACTION controlp INFIELD b_xrca004 name="construct.c.page1.b_xrca004"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           # LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #供廠商OR交易對象  ##160731-00372#1  2016/08/19  By 07900 mark
            LET g_qryparam.where = " (pmaa002 ='2' OR pmaa002 ='3') "  #160731-00372#1  2016/08/19  By 07900 add
            #161111-00049#9 Add  ---(S)---
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            #161111-00049#9 Add  ---(E)---
            CALL q_pmaa001_25()
            DISPLAY g_qryparam.return1 TO b_xrca004
            NEXT FIELD b_xrca004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca004
            #add-point:BEFORE FIELD b_xrca004 name="construct.b.page1.b_xrca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca004
            
            #add-point:AFTER FIELD b_xrca004 name="construct.a.page1.b_xrca004"
            
            #END add-point
            
 
 
         #----<<xrca004_desc>>----
         #----<<b_xrca014>>----
         #Ctrlp:construct.c.page1.b_xrca014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca014
            #add-point:ON ACTION controlp INFIELD b_xrca014 name="construct.c.page1.b_xrca014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca014  #顯示到畫面上
            NEXT FIELD b_xrca014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca014
            #add-point:BEFORE FIELD b_xrca014 name="construct.b.page1.b_xrca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca014
            
            #add-point:AFTER FIELD b_xrca014 name="construct.a.page1.b_xrca014"
            
            #END add-point
            
 
 
         #----<<xrca014_desc>>----
         #----<<b_type>>----
         #----<<b_xrcadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcadocdt
            #add-point:BEFORE FIELD b_xrcadocdt name="construct.b.page1.b_xrcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcadocdt
            
            #add-point:AFTER FIELD b_xrcadocdt name="construct.a.page1.b_xrcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocdt
            #add-point:ON ACTION controlp INFIELD b_xrcadocdt name="construct.c.page1.b_xrcadocdt"
            
            #END add-point
 
 
         #----<<b_xrca001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca001
            #add-point:BEFORE FIELD b_xrca001 name="construct.b.page1.b_xrca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca001
            
            #add-point:AFTER FIELD b_xrca001 name="construct.a.page1.b_xrca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca001
            #add-point:ON ACTION controlp INFIELD b_xrca001 name="construct.c.page1.b_xrca001"
            
            #END add-point
 
 
         #----<<xrca001_desc>>----
         #----<<b_xrcadocno>>----
         #Ctrlp:construct.c.page1.b_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocno
            #add-point:ON ACTION controlp INFIELD b_xrcadocno name="construct.c.page1.b_xrcadocno"
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str                    #161111-00049#9 Add
            CALL cl_replace_str(l_ld_str,'glaald','xrcald') RETURNING l_ld_str           #161111-00049#9 Add
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrcastus = 'Y' AND  xrcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",
                                   #" AND xrcasite IN ", g_wc_xrcasite   #150127-00007#1 mark
                                   " AND xrcacomp IN ", g_wc_xrcacomp    #150127-00007#1 add
            #161111-00049#9 Add  ---(S)---
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str CLIPPED
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = xrcaent ",
                                                       "                AND pmaa001 = xrca004 )"
            END IF
            #161111-00049#9 Add  ---(E)---
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcadocno  #顯示到畫面上
            NEXT FIELD b_xrcadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcadocno
            #add-point:BEFORE FIELD b_xrcadocno name="construct.b.page1.b_xrcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcadocno
            
            #add-point:AFTER FIELD b_xrcadocno name="construct.a.page1.b_xrcadocno"
            
            #END add-point
            
 
 
         #----<<b_xrcb047>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcb047
            #add-point:BEFORE FIELD b_xrcb047 name="construct.b.page1.b_xrcb047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcb047
            
            #add-point:AFTER FIELD b_xrcb047 name="construct.a.page1.b_xrcb047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrcb047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb047
            #add-point:ON ACTION controlp INFIELD b_xrcb047 name="construct.c.page1.b_xrcb047"
            
            #END add-point
 
 
         #----<<b_xrca035>>----
         #Ctrlp:construct.c.page1.b_xrca035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca035
            #add-point:ON ACTION controlp INFIELD b_xrca035 name="construct.c.page1.b_xrca035"
            #費用(借方)科目編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161111-00049#9 Add  ---(S)---
			   LET g_qryparam.where = g_qryparam.where," AND glac001 = '",l_glaa004,"'"
            #161111-00049#9 Add  ---(E)---
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_xrca035   #顯示到畫面上


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca035
            #add-point:BEFORE FIELD b_xrca035 name="construct.b.page1.b_xrca035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca035
            
            #add-point:AFTER FIELD b_xrca035 name="construct.a.page1.b_xrca035"
            
            #END add-point
            
 
 
         #----<<xrca035_desc>>----
         #----<<b_xrca038>>----
         #Ctrlp:construct.c.page1.b_xrca038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca038
            #add-point:ON ACTION controlp INFIELD b_xrca038 name="construct.c.page1.b_xrca038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrca038()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca038  #顯示到畫面上
            NEXT FIELD b_xrca038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca038
            #add-point:BEFORE FIELD b_xrca038 name="construct.b.page1.b_xrca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca038
            
            #add-point:AFTER FIELD b_xrca038 name="construct.a.page1.b_xrca038"
            
            #END add-point
            
 
 
         #----<<b_xrca066>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca066
            #add-point:BEFORE FIELD b_xrca066 name="construct.b.page1.b_xrca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca066
            
            #add-point:AFTER FIELD b_xrca066 name="construct.a.page1.b_xrca066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca066
            #add-point:ON ACTION controlp INFIELD b_xrca066 name="construct.c.page1.b_xrca066"
            
            #END add-point
 
 
         #----<<b_xrca100>>----
         #Ctrlp:construct.c.page1.b_xrca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca100
            #add-point:ON ACTION controlp INFIELD b_xrca100 name="construct.c.page1.b_xrca100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca100  #顯示到畫面上
            NEXT FIELD b_xrca100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca100
            #add-point:BEFORE FIELD b_xrca100 name="construct.b.page1.b_xrca100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca100
            
            #add-point:AFTER FIELD b_xrca100 name="construct.a.page1.b_xrca100"
            
            #END add-point
            
 
 
         #----<<b_xrca108>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca108
            #add-point:BEFORE FIELD b_xrca108 name="construct.b.page1.b_xrca108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca108
            
            #add-point:AFTER FIELD b_xrca108 name="construct.a.page1.b_xrca108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca108
            #add-point:ON ACTION controlp INFIELD b_xrca108 name="construct.c.page1.b_xrca108"
            
            #END add-point
 
 
         #----<<l_xrca1081>>----
         #----<<l_xrca1082>>----
         #----<<b_xrca118>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca118
            #add-point:BEFORE FIELD b_xrca118 name="construct.b.page1.b_xrca118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca118
            
            #add-point:AFTER FIELD b_xrca118 name="construct.a.page1.b_xrca118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca118
            #add-point:ON ACTION controlp INFIELD b_xrca118 name="construct.c.page1.b_xrca118"
            
            #END add-point
 
 
         #----<<l_xrca1181>>----
         #----<<l_xrca1182>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_input.xrcasite,g_input.xrcasite_desc,g_input.strdate,g_input.enddate,
            g_input.curr,g_input.xrcastus    
      
      FROM b_xrcasite,xrcasite_desc,b_strdate,b_enddate,
           b_curr,b_xrcastus
      ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD b_xrcasite
           LET g_input.xrcasite_desc = ''
           IF NOT cl_null(g_input.xrcasite) THEN
              #161021-00050#6-add(s)
              CALL s_fin_account_center_with_ld_chk(g_input.xrcasite,'',g_user,'3','N','',g_today) RETURNING l_success,g_errno
                 IF NOT cl_null(g_errno) THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = g_errno
                    LET g_errparam.extend = g_input.xrcasite
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_input.xrcasite = xrcasite_t
                    CALL s_desc_get_department_desc(g_input.xrcasite) RETURNING g_input.xrcasite_desc
                    DISPLAY BY NAME g_input.xrcasite,g_input.xrcasite_desc
                    NEXT FIELD CURRENT
                 END IF
              #161021-00050#6-add(e) 
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_input.xrcasite
              #160318-00025#47  2016/04/29  by pengxin  add(S)
              LET g_errshow = TRUE #是否開窗 
              LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
              #160318-00025#47  2016/04/29  by pengxin  add(E)
              IF NOT cl_chk_exist("v_ooef001") THEN
                 LET g_input.xrcasite = ''
                 LET g_input.xrcasite_desc = ''
                 DISPLAY BY NAME g_input.xrcasite_desc,g_input.xrcasite
                 NEXT FIELD b_xrcasite
              END IF
              CALL s_fin_account_center_sons_query('3',g_input.xrcasite,g_today,'1')
              #取得帳務中心底下之組織範圍
              #CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite   #150127-00007#1 mark
              CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
              CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp              
              #取得帳務中心底下的帳套範圍   
              CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
              CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
              LET g_input.xrcasite_desc = s_desc_get_department_desc(g_input.xrcasite)
              DISPLAY BY NAME g_input.xrcasite_desc
              LET xrcasite_t = g_input.xrcasite    #161021-00050#6-add
           END IF
           
         ON ACTION controlp  INFIELD  b_xrcasite               
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_input.xrcasite
           #CALL q_ooef001()        #161021-00050#6 mark
           CALL q_ooef001_46()      #161021-00050#6 add
           LET g_input.xrcasite = g_qryparam.return1
           CALL s_fin_account_center_sons_query('3',g_input.xrcasite,g_today,'1')
           #取得帳務中心底下之組織範圍
           #CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite   #150127-00007#1 mark
           CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
           CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp              
           #取得帳務中心底下的帳套範圍   
           CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
           CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
           LET g_input.xrcasite_desc = s_desc_get_department_desc(g_input.xrcasite)            
           CALL s_desc_get_department_desc(g_input.xrcasite) RETURNING g_input.xrcasite_desc
           DISPLAY BY NAME g_input.xrcasite,g_input.xrcasite_desc
           NEXT FIELD b_xrcasite 
           
      ON CHANGE b_strdate  #起始日期當月第一天     
         IF g_input.strdate != s_date_get_first_date(g_input.strdate) THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "aap-00335"
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_date_get_first_date(g_input.strdate) RETURNING g_input.strdate    
         END IF
         IF g_input.enddate < g_input.strdate THEN            
            CALL s_date_get_first_date(g_input.enddate) RETURNING g_input.strdate
         END IF
         DISPLAY BY NAME g_input.enddate,g_input.strdate
            
      ON CHANGE b_enddate　#截止日期不可小於起始日期
         IF g_input.enddate < g_input.strdate THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "aap-00336"
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_date_get_first_date(g_input.enddate) RETURNING g_input.strdate
         END IF
         DISPLAY BY NAME g_input.enddate,g_input.strdate

      ON CHANGE b_curr
           IF g_input.curr = 'Y' THEN
              CALL cl_set_comp_visible('b_xrca100,b_xrca108,l_xrca1081,l_xrca1082',TRUE)
           ELSE  # 不含＂幣別＂則隱藏單身的【幣別】【原幣期初、期末、本期增加、本期減少金額
              CALL cl_set_comp_visible('b_xrca100,b_xrca108,l_xrca1081,l_xrca1082',FALSE)
           END IF
      
      END INPUT     
      
      
      BEFORE DIALOG
         IF NOT cl_null(g_argv[01]) THEN
            EXIT DIALOG
         END IF
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
      CALL axrq911_default()
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
   CALL axrq911_insert_tmp()
  #CALL axrq911_set_page()
  #CALL axrq911_fetch1('F')
  #LET g_error_show = 1
  # IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
  #   INITIALIZE g_errparam TO NULL 
  #   LET g_errparam.extend = "" 
  #   LET g_errparam.code   = -100 
  #   LET g_errparam.popup  = TRUE 
  #   CALL cl_err()
  #
  #END IF
  #
  #CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
  #CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
  #RETURN
   #end add-point
        
   LET g_error_show = 1
   CALL axrq911_b_fill()
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
 
{<section id="axrq911.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq911_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xrca100_t   LIKE xrca_t.xrca004 #前筆帳款對象
   DEFINE l_tmp         type_g_xrca_d
   DEFINE l_odr         LIKE type_t.num5
   DEFINE l_ins         LIKE type_t.chr80
   DEFINE l_xrcc108     LIKE xrcc_t.xrcc108
   DEFINE l_xrcc118     LIKE xrcc_t.xrcc118
   DEFINE l_xrcald      LIKE xrca_t.xrcald
   DEFINE l_xrca004     LIKE xrca_t.xrca004
   DEFINE l_xrca100     LIKE xrca_t.xrca100
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_xrca        type_g_xrca_d    
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_gzcb001     LIKE gzcb_t.gzcb001
   #160505-00007#24--add--str--
   DEFINE l_xrcacomp_desc_sql    STRING
   DEFINE l_xrcald_desc_sql      STRING
   DEFINE l_xrca004_desc_sql     STRING
   DEFINE l_xrca035_desc_sql     STRING
   DEFINE l_xrca001_desc_sql     STRING
   DEFINE l_xrca014_sql          STRING
   DEFINE l_xrca014_desc_sql     STRING
   DEFINE l_axr_00326            STRING
   DEFINE l_axr_00327            STRING
   DEFINE l_axr_00298            STRING
   DEFINE l_axr_00328            STRING
   DEFINE l_axr_00365            STRING
   DEFINE l_sql                  STRING
   #160505-00007#24--add--end
   DEFINE l_xrca035      STRING                 #161208-00002#1
   DEFINE l_s_fin_1002    LIKE type_t.chr1       #161208-00002#1   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#   DELETE FROM axrq911_bfill_tmp #160505-00007#24 mark
   #161221-00050#1-----s
   CALL cl_set_comp_visible('b_xrca001',FALSE)
   CALL cl_set_comp_visible('xrca001_desc',TRUE)
   #161221-00050#1-----e
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',xrcacomp,'',xrcald,'',xrca004,'',xrca014,'','',xrcadocdt,xrca001, 
       '',xrcadocno,'',xrca035,'',xrca038,xrca066,xrca100,xrca108,'','',xrca118,'',''  ,DENSE_RANK() OVER( ORDER BY xrca_t.xrcald, 
       xrca_t.xrcadocno) AS RANK FROM xrca_t",
 
 
                     "",
                     " WHERE xrcaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrca_t"),
                     " ORDER BY xrca_t.xrcald,xrca_t.xrcadocno"
 
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
 
   LET g_sql = "SELECT '',xrcacomp,'',xrcald,'',xrca004,'',xrca014,'','',xrcadocdt,xrca001,'',xrcadocno, 
       '',xrca035,'',xrca038,xrca066,xrca100,xrca108,'','',xrca118,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#160505-00007#24--mark--str--
#未发现使用，故mark
#   LET g_sql = "   SELECT xrca100,                                   ",
#              "           SUM(xrca108),SUM(xrca1081),SUM(xrca1082),  ",  
#               "          SUM(xrca118),SUM(xrca1181),SUM(xrca1182)   ",       
#               "   FROM axrq911_tmp                                  ",
#               "  WHERE xrcald = ?                                   ",
#               "    AND xrca004 = ?                                  ",
#               "    AND type < 3                                     "
#   IF NOT cl_null(g_xrca100) THEN 
#      LET g_sql = g_sql ,   
#              "      AND xrca100 = '",g_xrca100,"'  "
#   END IF
#   LET g_sql = g_sql,
#               "    AND xrcacomp IN ",g_wc_xrcacomp CLIPPED, " AND ",ls_wc,
#               " GROUP BY xrca100                                        "
#   PREPARE axrq911_pb5 FROM g_sql
#
#   LET g_sql = "   SELECT xrca100,                                   ",
#              "           SUM(xrca108),SUM(l_xrca1081),SUM(l_xrca1082),  ",  
#               "          SUM(xrca118),SUM(l_xrca1181),SUM(l_xrca1182)   ",       
#               "   FROM axrq911_bfill_tmp                            ",
#               "  WHERE xrcald = ?                                   ",
#               "    AND type = 3                                     "
#   IF NOT cl_null(g_xrca100) THEN 
#      LET g_sql = g_sql ,   
#              "      AND xrca100 = '",g_xrca100,"'  "
#   END IF
#   LET g_sql = g_sql," GROUP BY xrca100                              "
#   PREPARE axrq911_pb7 FROM g_sql
#160505-00007#24--mark--end

   LET g_sql = "SELECT glgb001 glgb001,1 ls FROM glgb_t WHERE glgbent = '",g_enterprise,"'",
               "   AND glgb100 = 'AR'                                        ",
               "   AND glgbld = ?   AND glgbdocno = ?                        ",
               " UNION ",
               "SELECT xrce010 glgb001,2 ls FROM xrce_t WHERE xrceent = '",g_enterprise,"'",
               "   AND xrceld = ?   AND xrcedocno = ?"
#160505-00007#24--mod--str--
#   LET g_sql = "SELECT glgb001 FROM (",g_sql,") ORDER BY ls DESC" 
#   PREPARE axrq911_pb6 FROM g_sql
#   DECLARE axrq911_cs6 CURSOR FOR axrq911_pb6
   #摘要（不为空值摘要笔数）
   LET l_sql = "SELECT glgb001 FROM (",g_sql,") WHERE RTRIM(glgb001) IS NOT NULL "
   PREPARE axrq911_cnt_pr FROM g_sql
   #抓取摘要值
   LET g_sql = "SELECT glgb001 FROM (",g_sql,") WHERE RTRIM(glgb001) IS NOT NULL ORDER BY ls DESC" 
   DECLARE axrq911_cs6 CURSOR FROM g_sql
#160505-00007#24--mod--end

#160505-00007#24--mod--str--
#   LET g_sql = "   SELECT ''       ,xrcacomp,''       ,xrcald,'', ",
#               "          xrca004  ,'','','',type     ,xrcadocdt, ",
#               "          xrca001 ,gzcb001,xrcadocno,'',xrca035 , ",
#               #"          ''       ,xrca100 ,                    ", #150902-00001#6 mark
#               "          '',xrca038,xrca066,xrca100,             ", #150902-00001#6
#               "          xrca108  ,xrca1081,xrca1082 ,           ",
#               "          xrca118  ,xrca1181,xrca1182             ",
#               "     FROM axrq911_tmp                             ",
#               "    WHERE xrcaent= ? AND 1=1                      "
   LET l_xrcacomp_desc_sql="(SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=xrcacomp AND ooefl002='"||g_dlang||"') xrcacomp_desc "
   LET l_xrcald_desc_sql="(SELECT glaal002 FROM glaal_t WHERE glaalent="||g_enterprise||" AND glaalld=xrcald AND glaal001='"||g_dlang||"') xrcald_desc "
   LET l_xrca004_desc_sql="(SELECT pmaal004 FROM pmaal_t WHERE pmaalent="||g_enterprise||" AND pmaal001=xrca004 AND pmaal002='"||g_dlang||"') xrca004_desc "
   LET l_xrca035_desc_sql="(SELECT glacl004 FROM glacl_t,glaa_t ",
                          "  WHERE glaclent=glaaent AND glacl001=glaa004",
                          "    AND glaald=xrcald AND glacl002=xrca035 ",
                          "    AND glaclent=",g_enterprise,
                          "    AND glacl003='",g_dlang,"') xrca035_desc"
   LET l_xrca001_desc_sql="(SELECT CASE WHEN RTRIM(gzcbl004) IS NULL THEN gzcbl002 ELSE gzcbl002||':'||gzcbl004 END",
                          "  FROM gzcbl_t",
                          "  WHERE gzcbl001 = gzcb001 AND gzcbl002 = xrca001",
                          "   AND gzcbl003 ='",g_dlang,"') xrca001_desc "
   LET l_xrca014_sql="(SELECT xrca014 FROM xrca_t t1 WHERE t1.xrcadocno = x.xrcadocno AND t1.xrcald = x.xrcald AND t1.xrcaent="||g_enterprise||") xrca014 "
   LET l_xrca014_desc_sql="(SELECT ooag011  FROM ooag_t,xrca_t t2  ",
                          "  WHERE ooagent ='"||g_enterprise||"' AND ooag001=t2.xrca014 ",
                          "    AND t2.xrcadocno=x.xrcadocno AND t2.xrcald = x.xrcald ",
                          "    AND t2.xrcaent="||g_enterprise||") xrca014_desc "

   #161111-00049#9 Add  ---(S)---
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc = ls_wc," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = xrcaent ",
                        "                AND pmaa001 = xrca004 )"
   END IF
   #161111-00049#9 Add  ---(E)---

   #161123-00027#1 Mark ---(S)---
   #重写SQL语句
  #LET g_sql = "SELECT 'N',xrcacomp,",l_xrcacomp_desc_sql,",xrcald,",l_xrcald_desc_sql,", ",
  #            "       xrca004,", l_xrca004_desc_sql,",",l_xrca014_sql,",",l_xrca014_desc_sql,",",
  #            "       type,xrcadocdt,xrca001,",l_xrca001_desc_sql,",xrcadocno,'',",
  #            "       xrca035,",l_xrca035_desc_sql,",xrca038,xrca066,xrca100,", 
  #            "       nvl(xrca108,0),nvl(xrca1081,0),nvl(xrca1082,0),",
  #            "       nvl(xrca118,0),nvl(xrca1181,0),nvl(xrca1182,0) ",
  #            "  FROM axrq911_tmp x                           ",
  #            " WHERE xrcaent= ? AND 1=1                      "
   #161123-00027#1 Mark ---(E)---
   #161123-00027#1 Add  ---(S)---
   LET g_sql = "SELECT 'N',xrcacomp,",l_xrcacomp_desc_sql,",xrcald,",l_xrcald_desc_sql,", ",
               "       xrca004,", l_xrca004_desc_sql,",",l_xrca014_sql,",",l_xrca014_desc_sql,",",
               "       type,xrcadocdt,xrca001,",l_xrca001_desc_sql,",xrcadocno,'',",
               "       xrca035,",l_xrca035_desc_sql,",xrca038,xrca066,xrca100,", 
               "       xrca108,xrca1081,xrca1082,",
               "       xrca118,xrca1181,xrca1182 ",
               "  FROM (SELECT xrcacomp,xrcald,xrca004,type,xrcadocdt,xrca001,              ",
               "               xrcadocno,xrca100,xrca035,                                   ",
               "               SUM(nvl(xrca108,0)) xrca108,SUM(nvl(xrca1081,0)) xrca1081,   ",
               "               SUM(nvl(xrca1082,0)) xrca1082,SUM(nvl(xrca118,0)) xrca118,   ",
               "               SUM(nvl(xrca1181,0)) xrca1181,SUM(nvl(xrca1182,0)) xrca1182, ",
               "               xrcaent,flag,gzcb001,xrca038,xrca066                         ",
               "   FROM axrq911_tmp WHERE type = '2'                                        ",
               "          AND ", ls_wc  ,
               "       GROUP BY xrcacomp,xrcald,xrca004,type,xrcadocdt,xrca001,xrca035,     ",
               "               xrcadocno,xrca100,xrcaent,flag,gzcb001,xrca038,xrca066       ",
               "     UNION                                                                  ",
               "     SELECT xrcacomp,xrcald,xrca004,type,xrcadocdt,xrca001,                 ",
               "               xrcadocno,xrca100,'' xrca035,                                ",
               "               SUM(nvl(xrca108,0)) xrca108,SUM(nvl(xrca1081,0)) xrca1081,   ",
               "               SUM(nvl(xrca1082,0)) xrca1082,SUM(nvl(xrca118,0)) xrca118,   ",
               "               SUM(nvl(xrca1181,0)) xrca1181,SUM(nvl(xrca1182,0)) xrca1182, ",
               "               xrcaent,flag,gzcb001,xrca038,xrca066                         ",
               "   FROM axrq911_tmp WHERE type = '1'                                        ",
               "      AND ", ls_wc  ,
               "       GROUP BY xrcacomp,xrcald,xrca004,type,xrcadocdt,xrca001,             ",
               "               xrcadocno,xrca100,xrcaent,flag,gzcb001,xrca038,xrca066) x ",
               " WHERE xrcaent= ? AND 1=1                      "
   #161123-00027#1 Add  ---(E)---
#160505-00007#24--mod--end   
   IF NOT cl_null(g_xrca100) THEN 
      LET g_sql = g_sql ,   
               "      AND xrca100 = '",g_xrca100,"'  "
   END IF
   IF NOT cl_null(g_ld) THEN 
      LET g_sql = g_sql ,
               "      AND xrcald = '",g_ld,"'  "
   END IF
   IF NOT cl_null(g_xrea009) THEN 
      LET g_sql = g_sql ,
               "      AND xrca004 = '",g_xrea009,"'  "
   END IF
   LET g_sql = g_sql ,
               "      AND xrcacomp IN " ,g_wc_xrcacomp CLIPPED  
              #"      AND ", ls_wc,cl_sql_add_filter("xrca_t")    #160816-00071#1 mark  
              #"      AND ", ls_wc                                #160816-00071#1 add   #161123-00027#1 Mark
   
  #LET g_sql = g_sql, cl_sql_add_filter("xrca_t"),                #160816-00071#1 mark
   LET g_sql = g_sql,                                             #160816-00071#1 add
              #" ORDER BY xrcald,xrca004,xrca100,type,flag,xrcadocdt "   #151111-00004#1 Mark
               " ORDER BY xrcald,xrca004,xrca100,type,xrcadocdt,flag "   #151111-00004#1 Add

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq911_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq911_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xrca_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_xrca100_t = '' 
   LET l_ins = '' #判斷是否塞入合計
   LET l_odr = 1
   LET l_xrcald = NULL
   LET l_xrca004 = NULL
   LET l_xrcc108 = 0
   LET l_xrcc118 = 0
   
   #160505-00007#24--add--str--
   LET l_axr_00326=cl_getmsg('aap-00326',g_dlang) #期初余额
   LET l_axr_00327=cl_getmsg('aap-00327',g_dlang) #本期异动
   LET l_axr_00298=cl_getmsg('axr-00298',g_dlang) #期末余额
   LET l_axr_00328=cl_getmsg('aap-00328',g_dlang) #合计
   LET l_axr_00365=cl_getmsg('axr-00365',g_dlang) #应收重评价作业
   
   LET l_sql="SELECT COUNT(*) FROM xreh_t WHERE xrehent = ",g_enterprise," AND xrehld =? AND xrehdocno = ? AND xreh003 = 'AR'"
   PREPARE axrq911_xreh_cnt_pr FROM l_sql
   
   LET l_sql="SELECT xrde010 FROM xrde_t WHERE xrdeent = ",g_enterprise," AND xrdeld = ? AND xrde014 = ?"
   PREPARE axrq911_xrde_sel_pr FROM l_sql
   #160505-00007#24--add--end
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xrca_d[l_ac].sel,g_xrca_d[l_ac].xrcacomp,g_xrca_d[l_ac].xrcacomp_desc, 
       g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcald_desc,g_xrca_d[l_ac].xrca004,g_xrca_d[l_ac].xrca004_desc, 
       g_xrca_d[l_ac].xrca014,g_xrca_d[l_ac].xrca014_desc,g_xrca_d[l_ac].type,g_xrca_d[l_ac].xrcadocdt, 
       g_xrca_d[l_ac].xrca001,g_xrca_d[l_ac].xrca001_desc,g_xrca_d[l_ac].xrcadocno,g_xrca_d[l_ac].xrcb047, 
       g_xrca_d[l_ac].xrca035,g_xrca_d[l_ac].xrca035_desc,g_xrca_d[l_ac].xrca038,g_xrca_d[l_ac].xrca066, 
       g_xrca_d[l_ac].xrca100,g_xrca_d[l_ac].xrca108,g_xrca_d[l_ac].l_xrca1081,g_xrca_d[l_ac].l_xrca1082, 
       g_xrca_d[l_ac].xrca118,g_xrca_d[l_ac].l_xrca1181,g_xrca_d[l_ac].l_xrca1182
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xrca_d[l_ac].statepic = cl_get_actipic(g_xrca_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
#160505-00007#24--mark--str--
#      IF cl_null(g_xrca_d[l_ac].xrca108 ) THEN LET g_xrca_d[l_ac].xrca108  = 0 END IF
#      IF cl_null(g_xrca_d[l_ac].l_xrca1081) THEN LET g_xrca_d[l_ac].l_xrca1081 = 0 END IF
#      IF cl_null(g_xrca_d[l_ac].l_xrca1082) THEN LET g_xrca_d[l_ac].l_xrca1082 = 0 END IF
#
#      IF cl_null(g_xrca_d[l_ac].xrca118 ) THEN LET g_xrca_d[l_ac].xrca118  = 0 END IF
#      IF cl_null(g_xrca_d[l_ac].l_xrca1181) THEN LET g_xrca_d[l_ac].l_xrca1181 = 0 END IF
#      IF cl_null(g_xrca_d[l_ac].l_xrca1182) THEN LET g_xrca_d[l_ac].l_xrca1182 = 0 END IF
#160505-00007#24--mark--end
      IF cl_null(l_xrcald)  THEN LET l_xrcald  = g_xrca_d[l_ac].xrcald END IF
      IF cl_null(l_xrca004) THEN LET l_xrca004 = g_xrca_d[l_ac].xrca004 END IF
      IF cl_null(l_xrca100) THEN LET l_xrca100 = g_xrca_d[l_ac].xrca100 END IF
#160505-00007#24--mark--str--
#      LET g_xrca_d[l_ac].xrcacomp_desc = s_desc_get_department_desc(g_xrca_d[l_ac].xrcacomp)
#      LET g_xrca_d[l_ac].xrcald_desc   = s_desc_get_ld_desc(g_xrca_d[l_ac].xrcald)
#      #帳款對象
#      LET g_xrca_d[l_ac].xrca004_desc  = s_desc_get_trading_partner_abbr_desc(g_xrca_d[l_ac].xrca004)
#      #科目名稱                           
#      LET g_xrca_d[l_ac].xrca035_desc = s_desc_get_account_desc(g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrca035)
#160505-00007#24--mark--end
      #xrcald,xrca004,xrca100决定一次期初、期中、期末
      #增加期初余额
      IF g_xrca_d[l_ac].type <> '1' AND l_ac = 1 THEN
         LET g_xrca_d[l_ac + 1].* = g_xrca_d[l_ac].*
         LET g_xrca_d[l_ac].type = 1   #期初余额
         LET g_xrca_d[l_ac].xrcadocdt = NULL
         LET g_xrca_d[l_ac].xrca001   = NULL
         LET g_xrca_d[l_ac].xrca001_desc= NULL
         LET g_xrca_d[l_ac].xrcadocno = NULL
         LET g_xrca_d[l_ac].xrcb047   = NULL
         LET g_xrca_d[l_ac].xrca108   = 0
         LET g_xrca_d[l_ac].l_xrca1081  = 0
         LET g_xrca_d[l_ac].l_xrca1082  = 0
         LET g_xrca_d[l_ac].xrca118   = 0
         LET g_xrca_d[l_ac].l_xrca1181  = 0
         LET g_xrca_d[l_ac].l_xrca1182  = 0
         LET g_xrca_d[l_ac].xrca035     = ''   #161123-00027#1 Add
         LET g_xrca_d[l_ac].xrca038   = NULL #150902-00001#6
         LET g_xrca_d[l_ac].xrca066   = NULL #150902-00001#6
#         LET g_xrca_d[l_ac].type = cl_getmsg('aap-00326',g_dlang) #160505-00007#24 mark
         LET g_xrca_d[l_ac].type = l_axr_00326 #160505-00007#24 add
         LET g_xrca_d[l_ac].xrca014 = NULL     #160505-00007#24 add
         LET g_xrca_d[l_ac].xrca014_desc = NULL#160505-00007#24 add
#160505-00007#24--mark--str--
#      LET g_xrca_d[l_ac].xrcacomp_desc = s_desc_get_department_desc(g_xrca_d[l_ac].xrcacomp)
#      LET g_xrca_d[l_ac].xrcald_desc   = s_desc_get_ld_desc(g_xrca_d[l_ac].xrcald)
#      #帳款對象
#      LET g_xrca_d[l_ac].xrca004_desc  = s_desc_get_trading_partner_abbr_desc(g_xrca_d[l_ac].xrca004)
#      #科目名稱                           
#      LET g_xrca_d[l_ac].xrca035_desc = s_desc_get_account_desc(g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrca035)
#160505-00007#24--mark--end
         LET l_ac = l_ac + 1
      END IF

      LET l_flag = 'N' #期中异动
      #显示原币否
      IF g_input.curr = 'Y' THEN 
         IF g_xrca_d[l_ac].xrca100 = l_xrca100 THEN
            LET l_flag = 'Y'
         END IF
      ELSE
         LET l_flag = 'Y'
      END IF
      IF g_xrca_d[l_ac].xrcald = l_xrcald AND g_xrca_d[l_ac].xrca004 = l_xrca004 AND l_flag = 'Y' THEN
         IF g_xrca_d[l_ac].type <> '3' THEN
            LET l_xrcc108 = l_xrcc108 + g_xrca_d[l_ac].l_xrca1082
            LET g_xrca_d[l_ac].l_xrca1082 = l_xrcc108

            LET l_xrcc118 = l_xrcc118 + g_xrca_d[l_ac].l_xrca1182
            LET g_xrca_d[l_ac].l_xrca1182 = l_xrcc118
         END IF
      ELSE
         #增加期末余额
         LET g_xrca_d[l_ac + 1].* = g_xrca_d[l_ac].*
         LET g_xrca_d[l_ac].type = 3
         LET g_xrca_d[l_ac].xrcb047   = NULL
         LET g_xrca_d[l_ac].xrcadocdt = NULL
         LET g_xrca_d[l_ac].xrca001   = NULL
         LET g_xrca_d[l_ac].xrca001_desc= NULL
         LET g_xrca_d[l_ac].xrcadocno = NULL
         LET g_xrca_d[l_ac].xrcald    = l_xrcald
         LET g_xrca_d[l_ac].xrca004   = l_xrca004
         LET g_xrca_d[l_ac].xrca100   = l_xrca100
         LET g_xrca_d[l_ac].xrca108   = 0
         LET g_xrca_d[l_ac].l_xrca1081  = 0
         LET g_xrca_d[l_ac].l_xrca1082  = g_xrca_d[l_ac - 1].l_xrca1082
         LET g_xrca_d[l_ac].xrca118   = 0
         LET g_xrca_d[l_ac].l_xrca1181  = 0
         LET g_xrca_d[l_ac].l_xrca1182  = g_xrca_d[l_ac - 1].l_xrca1182
#         LET g_xrca_d[l_ac].type = cl_getmsg('axr-00298',g_dlang) #160505-00007#24 mark
         LET g_xrca_d[l_ac].type = l_axr_00298 #160505-00007#24 add
         LET g_xrca_d[l_ac].xrca035     = ''   #161123-00027#1 Add
         LET g_xrca_d[l_ac].xrca038   = NULL #150902-00001#6
         LET g_xrca_d[l_ac].xrca066   = NULL #150902-00001#6
         LET g_xrca_d[l_ac].xrca014   = NULL   #151111-00004#1 Add
         LET g_xrca_d[l_ac].xrca014_desc= NULL   #151111-00004#1 Add
#160505-00007#24--mod--str--
#         LET g_xrca_d[l_ac].xrcacomp_desc = s_desc_get_department_desc(g_xrca_d[l_ac].xrcacomp)
#         LET g_xrca_d[l_ac].xrcald_desc   = s_desc_get_ld_desc(g_xrca_d[l_ac].xrcald)
#         #帳款對象
#         LET g_xrca_d[l_ac].xrca004_desc  = s_desc_get_trading_partner_abbr_desc(g_xrca_d[l_ac].xrca004)
#         #科目名稱                           
#         LET g_xrca_d[l_ac].xrca035_desc = s_desc_get_account_desc(g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrca035)
         LET g_xrca_d[l_ac].xrcacomp_desc = g_xrca_d[l_ac-1].xrcacomp_desc
         LET g_xrca_d[l_ac].xrcald_desc = g_xrca_d[l_ac-1].xrcald_desc
         LET g_xrca_d[l_ac].xrca004_desc = g_xrca_d[l_ac-1].xrca004_desc
         #科目
         LET g_xrca_d[l_ac].xrca035 = g_xrca_d[l_ac-1].xrca035
         LET g_xrca_d[l_ac].xrca035_desc = g_xrca_d[l_ac-1].xrca035_desc
#160505-00007#24--mod--end
         LET l_ac = l_ac + 1
         LET l_xrcc108 = 0
         LET l_xrcc118 = 0
         
         #增加期初余额
         IF g_xrca_d[l_ac].type <> '1' THEN
            LET g_xrca_d[l_ac + 1].* = g_xrca_d[l_ac].*
            LET g_xrca_d[l_ac].type = 1
            LET g_xrca_d[l_ac].xrcb047   = NULL
            LET g_xrca_d[l_ac].xrcadocdt = NULL
            LET g_xrca_d[l_ac].xrca001   = NULL
            LET g_xrca_d[l_ac].xrca001_desc= NULL
            LET g_xrca_d[l_ac].xrcadocno = NULL
            LET g_xrca_d[l_ac].xrca108   = 0
            LET g_xrca_d[l_ac].l_xrca1081  = 0
            LET g_xrca_d[l_ac].l_xrca1082  = 0
            LET g_xrca_d[l_ac].xrca118   = 0
            LET g_xrca_d[l_ac].l_xrca1181  = 0
            LET g_xrca_d[l_ac].xrca038   = NULL #150902-00001#6
            LET g_xrca_d[l_ac].l_xrca1182  = 0
            LET g_xrca_d[l_ac].xrca066   = NULL #150902-00001#6
#160505-00007#24--mark--str--
#            LET g_xrca_d[l_ac].xrcacomp_desc = s_desc_get_department_desc(g_xrca_d[l_ac].xrcacomp)
#            LET g_xrca_d[l_ac].xrcald_desc   = s_desc_get_ld_desc(g_xrca_d[l_ac].xrcald)
#            #帳款對象
#            LET g_xrca_d[l_ac].xrca004_desc  = s_desc_get_trading_partner_abbr_desc(g_xrca_d[l_ac].xrca004)
#            #科目名稱                           
#            LET g_xrca_d[l_ac].xrca035_desc = s_desc_get_account_desc(g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrca035)
#            LET g_xrca_d[l_ac].type = cl_getmsg('aap-00326',g_dlang)
#160505-00007#24--mark--end
            LET g_xrca_d[l_ac].type = l_axr_00326 #160505-00007#24 add
            LET g_xrca_d[l_ac].xrca014 = NULL     #160505-00007#24 add
            LET g_xrca_d[l_ac].xrca014_desc = NULL#160505-00007#24 add
            LET l_ac = l_ac + 1
         END IF
         IF g_xrca_d[l_ac].type <> '3' THEN
            LET l_xrcc108 = l_xrcc108 + g_xrca_d[l_ac].l_xrca1082
            LET g_xrca_d[l_ac].l_xrca1082 = l_xrcc108

            LET l_xrcc118 = l_xrcc118 + g_xrca_d[l_ac].l_xrca1182
            LET g_xrca_d[l_ac].l_xrca1182 = l_xrcc118
         END IF

      END IF
#160505-00007#24--mark--str--
#      LET g_xrca_d[l_ac].xrcacomp_desc = s_desc_get_department_desc(g_xrca_d[l_ac].xrcacomp)
#      LET g_xrca_d[l_ac].xrcald_desc   = s_desc_get_ld_desc(g_xrca_d[l_ac].xrcald)
#      #帳款對象
#      LET g_xrca_d[l_ac].xrca004_desc  = s_desc_get_trading_partner_abbr_desc(g_xrca_d[l_ac].xrca004)
#      #科目名稱                           
#      LET g_xrca_d[l_ac].xrca035_desc = s_desc_get_account_desc(g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrca035)

#      IF NOT cl_null(g_xrca_d[l_ac].xrca001) THEN
#         LET l_gzcb001 = g_xrca_d[l_ac].xrca001_desc
#         SELECT gzcbl004 INTO g_xrca_d[l_ac].xrca001_desc FROM gzcbl_t
#          WHERE gzcbl001 = l_gzcb001
#            AND gzcbl002 = g_xrca_d[l_ac].xrca001
#            AND gzcbl003 = g_lang
#         IF NOT cl_null(g_xrca_d[l_ac].xrca001_desc) THEN
#            LET g_xrca_d[l_ac].xrca001_desc = g_xrca_d[l_ac].xrca001,":",g_xrca_d[l_ac].xrca001_desc
#         END IF
#      END IF
#160505-00007#24--mark--end
      CASE g_xrca_d[l_ac].type
         WHEN '1' #1.期初余额
#            LET g_xrca_d[l_ac].type = cl_getmsg('aap-00326',g_dlang)  #160505-00007#24 mark
            LET g_xrca_d[l_ac].type = l_axr_00326                      #160505-00007#24 add
         WHEN '2' #2.本期异动
#            LET g_xrca_d[l_ac].type = cl_getmsg('aap-00327',g_dlang)  #160505-00007#24 mark
            LET g_xrca_d[l_ac].type = l_axr_00327                      #160505-00007#24 add
         WHEN '3' #2.期末余额
#            LET g_xrca_d[l_ac].type = cl_getmsg('axr-00298',g_dlang)  #160505-00007#24 mark
            LET g_xrca_d[l_ac].type = l_axr_00298                      #160505-00007#24 add
         WHEN '9'   
#            LET g_xrca_d[l_ac].type = cl_getmsg('aap-00328',g_dlang)  #160505-00007#24 mark
            LET g_xrca_d[l_ac].type = l_axr_00328                      #160505-00007#24 add
      END CASE

      IF NOT cl_null(g_xrca_d[l_ac].xrcadocno) THEN
#160505-00007#24--mark--str--
#         SELECT xrca014 INTO g_xrca_d[l_ac].xrca014 FROM xrca_t WHERE xrcadocno = g_xrca_d[l_ac].xrcadocno
#            AND xrcald = g_xrca_d[l_ac].xrcald
#            AND xrcaent = g_enterprise
#         CALL s_axrt300_xrca_ref('xrca003',g_xrca_d[l_ac].xrca014,'','')
#            RETURNING l_success,g_xrca_d[l_ac].xrca014_desc
#160505-00007#24--mark--end

#160505-00007#24--mod--str--
#         FOREACH axrq911_cs6 USING g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno,g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno INTO g_xrca_d[l_ac].xrcb047
#            IF NOT cl_null(g_xrca_d[l_ac].xrcb047) THEN EXIT FOREACH END IF
#         END FOREACH
         #摘要笔数
         LET l_n = 0 
         EXECUTE axrq911_cnt_pr USING g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno,g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno
                                INTO l_n
         IF cl_null(l_n) THEN LET l_n = 0 END IF
         #当摘要有值时，抓取摘要
         IF l_n > 0 THEN
            OPEN axrq911_cs6 USING g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno,g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno
            FETCH axrq911_cs6 INTO g_xrca_d[l_ac].xrcb047
            CLOSE axrq911_cs6
         END IF
#160505-00007#24--mod--end

         LET l_n = 0
#         SELECT COUNT(*) INTO l_n FROM xreh_t WHERE xrehent = g_enterprise AND xrehld = g_xrca_d[l_ac].xrcald AND xrehdocno = g_xrca_d[l_ac].xrcadocno AND xreh003 = 'AR' #160505-00007#24 mark
         EXECUTE axrq911_xreh_cnt_pr USING g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno INTO l_n  #160505-00007#24 add
         IF cl_null(l_n) THEN LET l_n = 0 END IF
         IF l_n > 0 THEN
#            LET g_xrca_d[l_ac].xrca001_desc = "应收重评价作业" #160505-00007#24 mark
            LET g_xrca_d[l_ac].xrca001_desc = l_axr_00365      #160505-00007#24 add
         ELSE
            IF cl_null(g_xrca_d[l_ac].xrcb047) THEN
#160505-00007#24--mod--str--
#               SELECT xrde010 INTO g_xrca_d[l_ac].xrcb047 FROM xrde_t WHERE xrdeent = g_enterprise
#                  AND xrdeld = g_xrca_d[l_ac].xrcald
#                  AND xrde014 = g_xrca_d[l_ac].xrcadocno
               EXECUTE axrq911_xrde_sel_pr USING g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrcadocno INTO g_xrca_d[l_ac].xrcb047
#160505-00007#24--mod--end 
            END IF
         END IF
      END IF

      LET l_xrcald  = g_xrca_d[l_ac].xrcald 
      LET l_xrca004 = g_xrca_d[l_ac].xrca004
      LET l_xrca100 = g_xrca_d[l_ac].xrca100

      #end add-point
 
      CALL axrq911_detail_show("'1'")      
 
      CALL axrq911_xrca_t_mask()
 
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
   
 
   
   CALL g_xrca_d.deleteElement(g_xrca_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF l_ac > 1 THEN
      #最后增加期末余额
      LET g_xrca_d[l_ac].* = g_xrca_d[l_ac - 1].*
      LET g_xrca_d[l_ac].type = 3
      LET g_xrca_d[l_ac].xrcb047   = NULL
      LET g_xrca_d[l_ac].xrcadocdt = NULL
      LET g_xrca_d[l_ac].xrca001   = NULL
      LET g_xrca_d[l_ac].xrca001_desc= NULL
      LET g_xrca_d[l_ac].xrcadocno = NULL
#160505-00007#24--mark--str--
#      LET g_xrca_d[l_ac].xrcald    = l_xrcald
#      LET g_xrca_d[l_ac].xrca004   = l_xrca004
#      LET g_xrca_d[l_ac].xrca100   = l_xrca100
#160505-00007#24--mark--end
      LET g_xrca_d[l_ac].xrca108   = 0
      LET g_xrca_d[l_ac].l_xrca1081  = 0
      LET g_xrca_d[l_ac].l_xrca1082  = g_xrca_d[l_ac - 1].l_xrca1082
      LET g_xrca_d[l_ac].xrca118   = 0
      LET g_xrca_d[l_ac].l_xrca1181  = 0
      LET g_xrca_d[l_ac].xrca038   = NULL     #151111-00004#1 Add
      LET g_xrca_d[l_ac].xrca066   = NULL     #151111-00004#1 Add
      LET g_xrca_d[l_ac].xrca014   = NULL     #151111-00004#1 Add
      LET g_xrca_d[l_ac].xrca014_desc= NULL   #151111-00004#1 Add
      LET g_xrca_d[l_ac].l_xrca1182  = g_xrca_d[l_ac - 1].l_xrca1182
#      LET g_xrca_d[l_ac].type = cl_getmsg('axr-00298',g_dlang) #160505-00007#24 mark
      LET g_xrca_d[l_ac].type = l_axr_00298                     #160505-00007#24 add
#160505-00007#24--mark--str--
#      LET g_xrca_d[l_ac].xrcacomp_desc = s_desc_get_department_desc(g_xrca_d[l_ac].xrcacomp)
#      LET g_xrca_d[l_ac].xrcald_desc   = s_desc_get_ld_desc(g_xrca_d[l_ac].xrcald)
#      #帳款對象
#      LET g_xrca_d[l_ac].xrca004_desc  = s_desc_get_trading_partner_abbr_desc(g_xrca_d[l_ac].xrca004)
#      #科目名稱                           
#      LET g_xrca_d[l_ac].xrca035_desc = s_desc_get_account_desc(g_xrca_d[l_ac].xrcald,g_xrca_d[l_ac].xrca035)
#160505-00007#24--mark--end
   END IF

   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_xrca_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq911_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq911_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq911_detail_action_trans()
 
   IF g_xrca_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq911_fetch()
   END IF
   
      CALL axrq911_filter_show('xrcacomp','b_xrcacomp')
   CALL axrq911_filter_show('xrcald','b_xrcald')
   CALL axrq911_filter_show('xrca004','b_xrca004')
   CALL axrq911_filter_show('xrca014','b_xrca014')
   CALL axrq911_filter_show('xrcadocdt','b_xrcadocdt')
   CALL axrq911_filter_show('xrca001','b_xrca001')
   CALL axrq911_filter_show('xrcadocno','b_xrcadocno')
   CALL axrq911_filter_show('xrcb047','b_xrcb047')
   CALL axrq911_filter_show('xrca035','b_xrca035')
   CALL axrq911_filter_show('xrca038','b_xrca038')
   CALL axrq911_filter_show('xrca066','b_xrca066')
   CALL axrq911_filter_show('xrca100','b_xrca100')
   CALL axrq911_filter_show('xrca108','b_xrca108')
   CALL axrq911_filter_show('xrca118','b_xrca118')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq911.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq911_fetch()
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
 
{<section id="axrq911.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq911_detail_show(ps_page)
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
 
{<section id="axrq911.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq911_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_ld_str          STRING                #161111-00049#9 Add
   DEFINE l_glaa004         LIKE glaa_t.glaa004   #161111-00049#9 Add
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#9 Add
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   #161111-00049#9 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
   #161111-00049#9 Add  ---(E)---
   #161221-00050#1-----s
   CALL cl_set_comp_visible('b_xrca001',TRUE)
   CALL cl_set_comp_visible('xrca001_desc',FALSE)
   #161221-00050#1-----e
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
      CONSTRUCT g_wc_filter ON xrcacomp,xrcald,xrca004,xrca014,xrcadocdt,xrca001,xrcadocno,xrcb047,xrca035, 
          xrca038,xrca066,xrca100,xrca108,xrca118
                          FROM s_detail1[1].b_xrcacomp,s_detail1[1].b_xrcald,s_detail1[1].b_xrca004, 
                              s_detail1[1].b_xrca014,s_detail1[1].b_xrcadocdt,s_detail1[1].b_xrca001, 
                              s_detail1[1].b_xrcadocno,s_detail1[1].b_xrcb047,s_detail1[1].b_xrca035, 
                              s_detail1[1].b_xrca038,s_detail1[1].b_xrca066,s_detail1[1].b_xrca100,s_detail1[1].b_xrca108, 
                              s_detail1[1].b_xrca118
 
         BEFORE CONSTRUCT
                     DISPLAY axrq911_filter_parser('xrcacomp') TO s_detail1[1].b_xrcacomp
            DISPLAY axrq911_filter_parser('xrcald') TO s_detail1[1].b_xrcald
            DISPLAY axrq911_filter_parser('xrca004') TO s_detail1[1].b_xrca004
            DISPLAY axrq911_filter_parser('xrca014') TO s_detail1[1].b_xrca014
            DISPLAY axrq911_filter_parser('xrcadocdt') TO s_detail1[1].b_xrcadocdt
            DISPLAY axrq911_filter_parser('xrca001') TO s_detail1[1].b_xrca001
            DISPLAY axrq911_filter_parser('xrcadocno') TO s_detail1[1].b_xrcadocno
            DISPLAY axrq911_filter_parser('xrcb047') TO s_detail1[1].b_xrcb047
            DISPLAY axrq911_filter_parser('xrca035') TO s_detail1[1].b_xrca035
            DISPLAY axrq911_filter_parser('xrca038') TO s_detail1[1].b_xrca038
            DISPLAY axrq911_filter_parser('xrca066') TO s_detail1[1].b_xrca066
            DISPLAY axrq911_filter_parser('xrca100') TO s_detail1[1].b_xrca100
            DISPLAY axrq911_filter_parser('xrca108') TO s_detail1[1].b_xrca108
            DISPLAY axrq911_filter_parser('xrca118') TO s_detail1[1].b_xrca118
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrcacomp>>----
         #Ctrlp:construct.c.filter.page1.b_xrcacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcacomp
            #add-point:ON ACTION controlp INFIELD b_xrcacomp name="construct.c.filter.page1.b_xrcacomp"
            
            #END add-point
 
 
         #----<<xrcacomp_desc>>----
         #----<<b_xrcald>>----
         #Ctrlp:construct.c.page1.b_xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcald
            #add-point:ON ACTION controlp INFIELD b_xrcald name="construct.c.filter.page1.b_xrcald"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcald  #顯示到畫面上
            NEXT FIELD b_xrcald                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrcald_desc>>----
         #----<<b_xrca004>>----
         #Ctrlp:construct.c.page1.b_xrca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca004
            #add-point:ON ACTION controlp INFIELD b_xrca004 name="construct.c.filter.page1.b_xrca004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()   #160913-00017#10  mark                  #呼叫開窗
            #160913-00017#10--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#10--ADD(E)-
            DISPLAY g_qryparam.return1 TO b_xrca004  #顯示到畫面上
            NEXT FIELD b_xrca004                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrca004_desc>>----
         #----<<b_xrca014>>----
         #Ctrlp:construct.c.page1.b_xrca014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca014
            #add-point:ON ACTION controlp INFIELD b_xrca014 name="construct.c.filter.page1.b_xrca014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca014  #顯示到畫面上
            NEXT FIELD b_xrca014                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrca014_desc>>----
         #----<<b_type>>----
         #----<<b_xrcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocdt
            #add-point:ON ACTION controlp INFIELD b_xrcadocdt name="construct.c.filter.page1.b_xrcadocdt"
            
            #END add-point
 
 
         #----<<b_xrca001>>----
         #Ctrlp:construct.c.filter.page1.b_xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca001
            #add-point:ON ACTION controlp INFIELD b_xrca001 name="construct.c.filter.page1.b_xrca001"
            
            #END add-point
 
 
         #----<<xrca001_desc>>----
         #----<<b_xrcadocno>>----
         #Ctrlp:construct.c.page1.b_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocno
            #add-point:ON ACTION controlp INFIELD b_xrcadocno name="construct.c.filter.page1.b_xrcadocno"
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str                    #161111-00049#9 Add
            CALL cl_replace_str(l_ld_str,'glaald','xrcald') RETURNING l_ld_str           #161111-00049#9 Add
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrcastus = 'Y' AND  xrcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",
                                   " AND xrcacomp IN ", g_wc_xrcacomp
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str CLIPPED
            #161111-00049#9 Add  ---(E)---
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcadocno  #顯示到畫面上
            NEXT FIELD b_xrcadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrcb047>>----
         #Ctrlp:construct.c.filter.page1.b_xrcb047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb047
            #add-point:ON ACTION controlp INFIELD b_xrcb047 name="construct.c.filter.page1.b_xrcb047"
            
            #END add-point
 
 
         #----<<b_xrca035>>----
         #Ctrlp:construct.c.page1.b_xrca035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca035
            #add-point:ON ACTION controlp INFIELD b_xrca035 name="construct.c.filter.page1.b_xrca035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161111-00049#9 Add  ---(S)---
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
			   LET g_qryparam.where = g_qryparam.where," AND glac001 = '",l_glaa004,"'"
            #161111-00049#9 Add  ---(E)---
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca035  #顯示到畫面上
            NEXT FIELD b_xrca035                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrca035_desc>>----
         #----<<b_xrca038>>----
         #Ctrlp:construct.c.page1.b_xrca038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca038
            #add-point:ON ACTION controlp INFIELD b_xrca038 name="construct.c.filter.page1.b_xrca038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrca038()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca038  #顯示到畫面上
            NEXT FIELD b_xrca038                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrca066>>----
         #Ctrlp:construct.c.filter.page1.b_xrca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca066
            #add-point:ON ACTION controlp INFIELD b_xrca066 name="construct.c.filter.page1.b_xrca066"
            
            #END add-point
 
 
         #----<<b_xrca100>>----
         #Ctrlp:construct.c.page1.b_xrca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca100
            #add-point:ON ACTION controlp INFIELD b_xrca100 name="construct.c.filter.page1.b_xrca100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca100  #顯示到畫面上
            NEXT FIELD b_xrca100                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrca108>>----
         #Ctrlp:construct.c.filter.page1.b_xrca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca108
            #add-point:ON ACTION controlp INFIELD b_xrca108 name="construct.c.filter.page1.b_xrca108"
            
            #END add-point
 
 
         #----<<l_xrca1081>>----
         #----<<l_xrca1082>>----
         #----<<b_xrca118>>----
         #Ctrlp:construct.c.filter.page1.b_xrca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca118
            #add-point:ON ACTION controlp INFIELD b_xrca118 name="construct.c.filter.page1.b_xrca118"
            
            #END add-point
 
 
         #----<<l_xrca1181>>----
         #----<<l_xrca1182>>----
   
 
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
   
      CALL axrq911_filter_show('xrcacomp','b_xrcacomp')
   CALL axrq911_filter_show('xrcald','b_xrcald')
   CALL axrq911_filter_show('xrca004','b_xrca004')
   CALL axrq911_filter_show('xrca014','b_xrca014')
   CALL axrq911_filter_show('xrcadocdt','b_xrcadocdt')
   CALL axrq911_filter_show('xrca001','b_xrca001')
   CALL axrq911_filter_show('xrcadocno','b_xrcadocno')
   CALL axrq911_filter_show('xrcb047','b_xrcb047')
   CALL axrq911_filter_show('xrca035','b_xrca035')
   CALL axrq911_filter_show('xrca038','b_xrca038')
   CALL axrq911_filter_show('xrca066','b_xrca066')
   CALL axrq911_filter_show('xrca100','b_xrca100')
   CALL axrq911_filter_show('xrca108','b_xrca108')
   CALL axrq911_filter_show('xrca118','b_xrca118')
 
    
   CALL axrq911_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq911.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq911_filter_parser(ps_field)
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
 
{<section id="axrq911.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq911_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq911_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq911.insert" >}
#+ insert
PRIVATE FUNCTION axrq911_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq911.modify" >}
#+ modify
PRIVATE FUNCTION axrq911_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq911.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq911_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq911.delete" >}
#+ delete
PRIVATE FUNCTION axrq911_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq911.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq911_detail_action_trans()
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
 
{<section id="axrq911.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq911_detail_index_setting()
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
            IF g_xrca_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrca_d.getLength() AND g_xrca_d.getLength() > 0
            LET g_detail_idx = g_xrca_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrca_d.getLength() THEN
               LET g_detail_idx = g_xrca_d.getLength()
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
 
{<section id="axrq911.mask_functions" >}
 &include "erp/axr/axrq911_mask.4gl"
 
{</section>}
 
{<section id="axrq911.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 創建臨時表
# Memo...........:
# Usage..........: CALL axrq911_create_tmp()
# Date & Author..: 2015/01/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq911_create_tmp()

   DROP TABLE axrq911_tmp;
   CREATE TEMP TABLE axrq911_tmp(
      xrcacomp   VARCHAR(10),       
      xrcald     VARCHAR(5), 
      xrca004    VARCHAR(10),
      type       VARCHAR(500), 
      xrcadocdt  DATE, 
      xrca001    VARCHAR(10), 
      xrcadocno  VARCHAR(20), 
      xrca035    VARCHAR(24), 
      xrca100    VARCHAR(10), 
      xrca108    DECIMAL(20,6), 
      xrca1081   VARCHAR(500), 
      xrca1082   VARCHAR(500), 
      xrca118    DECIMAL(20,6), 
      xrca1181   VARCHAR(500), 
      xrca1182   VARCHAR(500),
      xrcaent    SMALLINT,
      flag       VARCHAR(1),
      gzcb001    INTEGER,
      xrca038    VARCHAR(20),      #150902-00001#6
      xrca066    VARCHAR(20)     #150902-00001#6      
         )
    #填充單身用  
    DROP TABLE axrq911_tmp01;   #160727-00019#6  2016/07/28  By 08734    axrq911_bfill_tmp ——> axrq911_tmp01
    CREATE TEMP TABLE axrq911_tmp01(   #160727-00019#6  2016/07/28  By 08734    axrq911_bfill_tmp ——> axrq911_tmp01
       sel            VARCHAR(1), 
       xrcacomp       VARCHAR(10), 
       xrcacomp_desc  VARCHAR(500), 
       xrcald         VARCHAR(5), 
       xrcald_desc    VARCHAR(500), 
       xrca004        VARCHAR(10), 
       xrca004_desc   VARCHAR(500), 
       xrca014        VARCHAR(20), 
       xrca014_desc   VARCHAR(500), 
       type           VARCHAR(500), 
       xrcadocdt      DATE, 
       xrca001        VARCHAR(10),
       xrca001_desc   VARCHAR(200),      
       xrcadocno      VARCHAR(20),  
       xrcb047        VARCHAR(255),  
       xrca035        VARCHAR(24), 
       xrca035_desc   VARCHAR(500), 
       xrca038        VARCHAR(20),      #150902-00001#6
       xrca066        VARCHAR(20),       #150902-00001#6  
       xrca100        VARCHAR(10), 
       xrca108        DECIMAL(20,6), 
       l_xrca1081     DECIMAL(20,6), 
       l_xrca1082     DECIMAL(20,6), 
       xrca118        DECIMAL(20,6), 
       l_xrca1181     DECIMAL(20,6), 
       l_xrca1182     DECIMAL(20,6),
       odr            SMALLINT
          )

END FUNCTION

################################################################################
# Descriptions...: 輸入臨時表
# Memo...........:
# Usage..........: CALL axrq911_insert_tmp()
# Date & Author..: 2015/01/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq911_insert_tmp()
DEFINE l_glaa003  LIKE glaa_t.glaa003
DEFINE l_xrcacomp LIKE xrca_t.xrcacomp
DEFINE l_xrcald   LIKE xrca_t.xrcald
DEFINE l_year     LIKE xrea_t.xrea001
DEFINE l_mon      LIKE xrea_t.xrea002
DEFINE l_preyear  LIKE xrea_t.xrea001 #上期年
DEFINE l_premon   LIKE xrea_t.xrea002 #上期月
DEFINE l_ld       LIKE glaa_t.glaald 
DEFINE l_xrcastus   STRING
DEFINE l_xrdastus   STRING
DEFINE l_apdastus   STRING
DEFINE l_xrea100  LIKE xrea_t.xrea100
DEFINE l_xrca100  LIKE xrca_t.xrca100
DEFINE l_apce100  LIKE apce_t.apce100
DEFINE l_xrce100  LIKE xrce_t.xrce100
DEFINE l_xreg001  LIKE xreg_t.xreg001
DEFINE l_xreg002  LIKE xreg_t.xreg002
DEFINE l_xrca035      STRING                 #161208-00002#1
DEFINE l_s_fin_1002    LIKE type_t.chr1       #161208-00002#1   
             
   
   #取得所屬法人+帳別
   CALL s_fin_orga_get_comp_ld(g_input.xrcasite) RETURNING g_sub_success,g_errno,l_xrcacomp,l_xrcald 
   #取得會計參照表號    
   CALL s_ld_sel_glaa(l_xrcald,'glaa003') RETURNING g_sub_success,l_glaa003   
   #取上期會計年月
   IF cl_null(g_year) THEN
      LET l_year = YEAR(g_input.strdate)
      LET l_mon  = MONTH(g_input.strdate)   #151111-00004#1 Mod g_input.enddate --> g_input.strdate
      CALL s_fin_date_get_last_period(l_glaa003,l_xrcald,l_year,l_mon)
                        RETURNING g_sub_success,l_preyear,l_premon
   ELSE
      #aapq910上期月份
       CALL s_ld_sel_glaa(g_ld,'glaa003') RETURNING g_sub_success,l_glaa003 
      CALL s_fin_date_get_last_period(l_glaa003,l_xrcald,g_year,g_strmon)
                        RETURNING g_sub_success,l_preyear,l_premon               
   END IF     
   #取得開始日期的年度期別
   CALL s_fin_date_get_period_value('',l_xrcald,g_input.strdate) RETURNING g_sub_success,l_xreg001,l_xreg002  
   
   #161208-00002#1---s---
   CALL cl_get_para(g_enterprise,l_xrcacomp,'S-FIN-2002') RETURNING l_s_fin_1002
   IF l_s_fin_1002 = '3' THEN
      LET l_xrca035 = 'xrcb029' 
   ELSE
      LET l_xrca035 = 'xrca035' 
   END IF
   #161208-00002#1---e---
            
   
   #狀態碼 xrcastus
   CASE g_input.xrcastus    
      WHEN '1' 
         LET l_xrcastus = " xrcastus = 'Y' "
         LET l_xrdastus = " xrdastus = 'Y' "
         LET l_apdastus = " apdastus = 'Y' "
      WHEN '2' #已審核以拋傳票
         LET l_xrcastus = " xrcastus = 'Y' AND xrca037 = 'Y' " 
         LET l_xrdastus = " xrdastus = 'Y' AND xrda014 IS NOT NULL " 
         LET l_apdastus = " apdastus = 'Y' AND apda014 IS NOT NULL " 
      WHEN '3'  
         LET l_xrcastus = " xrcastus = 'N' "
         LET l_xrdastus = " xrdastus = 'N' "
         LET l_apdastus = " apdastus = 'N' "
      WHEN '4'
         LET l_xrcastus = " xrcastus IN ('N','Y','X','A','D','R','W') "
         LET l_xrdastus = " xrdastus IN ('N','Y','X','A','D','R','W') "
         LET l_apdastus = " apdastus IN ('N','Y','X','A','D','R','W') "
   END CASE
   #是否顯示原幣 
   IF g_input.curr = 'Y' THEN
      LET l_xrea100 = 'xrea100'
      LET l_xrca100 = 'xrca100'
      LET l_apce100 = 'apce100'
      LET l_xrce100 = 'xrce100' 
   ELSE
      LET l_xrea100 = "''"
      LET l_xrca100 = "''"
      LET l_apce100 = "''"
      LET l_xrce100 = "''"       
   END IF 

   DELETE FROM axrq911_tmp
   #期末餘額 =本期增加 - 本期減少
   #期末餘額 金額CASE xrea004 link 2% OR IN (02,04) THEN 金額＊－１)  #待抵單以負數值呈現      
   LET g_sql = "   INSERT INTO axrq911_tmp                              ",
               "   SELECT xreacomp ,xreald,xrea009,1            ,'',    ",  
               "           ''       ,''   ,xrea019,",l_xrea100,",       ",   #161123-00027#1 Mod '' --> xrea019
               "          0,0,SUM(a),                                   ",
               "          0,0,SUM(b),xreaent,1,''                       ",
               "           ,'',''                                       ", #150902-00001#6
               "      FROM ( SELECT xreacomp ,xreald ,xrea009,1 ,xrea004,xrea019,          ",   #161123-00027#1 Add xrea019
               "                    xrea001  ,xrea002,xrea100   ,xrea005,xrea003,xreaent,  ",
               "                    CASE WHEN (xrea004 = '04' OR xrea004 = '02' OR xrea004 LIKE '2%') THEN xrea103*-1 ELSE  xrea103 END a,   ",                    
               "                    CASE WHEN (xrea004 = '04' OR xrea004 = '02' OR xrea004 LIKE '2%') THEN ", # xrea113*-1 ELSE  xrea113 END b    ",    #170124-00013#2 xul mark xrea113*-1 ELSE  xrea113 END b  
               # #170124-00013#2 xul--add--s---
               "              (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR' AND glca002 <> '1') ='2' ",
               "               THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
               "                AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END )*-1 ",
               "                    ELSE   ",
               "               (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR' AND glca002 <> '1') ='2' ",
               "               THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
               "                AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) END b    ",   
                # #170124-00013#2 xul--add--e---                
               "               FROM xrea_t WHERE xreaent = '",g_enterprise,"'",
               "                AND xrea003 = 'AR'     )                    ",
               "    WHERE xrea001 = '",l_preyear,"'               ",
               "      AND xrea002 = '",l_premon,"'                ",    
               "      AND xreald IN ",g_wc_xrcald CLIPPED,        
               "      AND xrea003 = 'AR'                          ",
               "    GROUP BY xreacomp,xreald,xrea009,xrea019,",l_xrea100,",xreaent "            #161123-00027#1 Add xrea019                                               
   PREPARE axrq911_tmp_pre01 FROM g_sql
   EXECUTE axrq911_tmp_pre01        
   #增加數xrca 期間立帳
   #立帳本期減少 = 0 --> 本期增加 - 0 = 本期減少
   LET g_sql = "   INSERT INTO axrq911_tmp                               ",
               "   SELECT xrcacomp,xrcald   ,xrca004,2,xrcadocdt,        ",
               #"          xrca001,xrcadocno,xrca035,",l_xrca100,",       ",   #161208-00002#1
               "          xrca001,xrcadocno, ",l_xrca035,",",l_xrca100,",",    #161208-00002#1
              #150311-00003#2   By 01727 Mark ---(S)---
              #"          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc108*-1 ELSE xrcc108 END),0,   ",
              #"          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc108*-1 ELSE xrcc108 END),     ",
              #"          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN (xrcc118+xrcc113)*-1 ELSE (xrcc118+xrcc113) END),0, ",
              #"          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN (xrcc118+xrcc113)*-1 ELSE (xrcc118+xrcc113) END),   ",
              #150311-00003#2   By 01727 Mark ---(E)---
              #150311-00003#2   By 01727 Add  ---(S)---
               "          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc108*-1 ELSE xrcc108 END),SUM(xrca107),   ",
               "          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc108*-1 ELSE xrcc108 END)-SUM(xrca107),     ",
               "          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc118*-1 ELSE xrcc118 END),SUM(xrca117), ",
               "          SUM(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc118*-1 ELSE xrcc118 END)-SUM(xrca117),   ",
              #150311-00003#2   By 01727 Add  ---(E)---
               "          xrcaent,2,8302                                                    ",
               "         ,xrca038,xrca066                                                   ", #150902-00001#6
              #"     FROM xrca_t,xrcc_t                                                     ", #161208-00002#1 mark
               "     FROM xrca_t,xrcb_t,xrcc_t                                              ", #161208-00002#1
               "    WHERE xrcaent = xrccent AND xrcaent = '",g_enterprise,"'                ",
               "      AND xrcadocno = xrcbdocno AND xrcald = xrcbld AND xrcbseq = xrccseq  AND xrcaent = xrcbent  ", #161208-00002#1
               "      AND xrcadocno = xrccdocno AND xrcald = xrccld                         ",
               "      AND ",l_xrcastus CLIPPED , 
               "      AND xrcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",                             
               "      AND xrcald IN ",g_wc_xrcald CLIPPED ,
              #"   GROUP BY xrcacomp,xrcald,xrca004,xrcadocdt,xrca001,xrcadocno,xrca035,",l_xrca100,",xrcaent"
              #"   GROUP BY xrcacomp,xrcald,xrca004,xrcadocdt,xrca001,xrcadocno,xrca035,",l_xrca100,",xrcaent,xrca038,xrca066 "   #150902-00001#6  #161208-00002#1 mark            
               "   GROUP BY xrcacomp,xrcald,xrca004,xrcadocdt,xrca001,xrcadocno,",l_xrca035,",",l_xrca100,",xrcaent,xrca038,xrca066  "   #161208-00002#1 add
   PREPARE axrq911_tmp_pre02 FROM g_sql
   EXECUTE axrq911_tmp_pre02 
   #取得調匯金額
   LET g_sql = "   INSERT INTO axrq911_tmp                                  ",
               "   SELECT xrcacomp,xrcald   ,xrca004,2,xregdocdt,           ",
              #"          '',xregdocno,xrca035,",l_xrca100,",               ",   #161208-00002#1
               "          '',xrcadocno, ",l_xrca035,",",l_xrca100,",        ",   #161208-00002#1
               "          0,0,0,SUM(xreh115),0,SUM(xreh115),xrcaent,2,''                  ",
               "         ,xrca038,xrca066                                                 ", #150902-00001#6
               #"     FROM xrca_t,xreg_t,xreh_t                              ",              #161208-00002#1 mark
               "     FROM xrca_t,xrcb_t,xreg_t,xreh_t                       ",               #161208-00002#1
               "    WHERE xrcaent = '",g_enterprise,"'                      ",                         
               "      AND xrcald IN ",g_wc_xrcald CLIPPED ,
               "      AND xregdocno = xrehdocno",
               "      AND xregld = xrehld",
               "      AND xregent = xrehent",
               "      AND xrehent = xrcaent",
               "      AND xreg001 = '",l_xreg001,"'",
               "      AND xreg002 = '",l_xreg002,"'",
               "      AND xreh008 <= '",g_input.enddate,"'", 
               "      AND xreh005 = xrcadocno",
               "      AND xreh005 = xrcbdocno  AND xreh006 = xrcbseq AND xrehld = xrcbld ",  #161208-00002#1
               "      AND xregstus = 'Y'",
               "       AND xreg003 = 'AR'",
              #"   GROUP BY xrcacomp,xrcald,xrca004,xregdocdt,xregdocno,xrca035,",l_xrca100,",xrcaent"
              #"   GROUP BY xrcacomp,xrcald,xrca004,xregdocdt,xregdocno,xrca035,",l_xrca100,",xrcaent,xrca038,xrca066" #150902-00001#6  #161208-00002#1 mark
               "   GROUP BY xrcacomp,xrcald,xrca004,xregdocdt,xrcadocno,",l_xrca035,",",l_xrca100,",xrcaent,xrca038,xrca066"            #161208-00002#1          
   PREPARE axrq911_tmp_pre021 FROM g_sql
   EXECUTE axrq911_tmp_pre021 
   #減少數xrce 期間有被[AP]付款沖帳的帳款單者
   #本期增加 = 0 --> 0 - 本期減少 = 期末餘額
   #本期增加 = 0 --> 0 - 本期減少 = 期末餘額
   #收款核銷
   LET g_sql = "   INSERT INTO axrq911_tmp                               ",
               "   SELECT xrcecomp,xrceld   ,xrda005,2,xrdadocdt,        ",
              #"          xrda001      ,xrce003,xrce016,",l_xrce100,",   ",
               "          xrda001      ,xrcedocno,xrce016,",l_xrce100,",   ",  #--carol.wu
              #20150415 By 01727 Mark ---(S)---
              #"          0,SUM(CASE WHEN xrce002 = '30' THEN 
              #                    CASE WHEN xrce015 ='D' THEN xrce109 * -1 ELSE xrce109 END 
              #                 ELSE
              #                    CASE WHEN xrce015 ='C' THEN xrce109 * -1 ELSE xrce109 END
              #                 END),                                    ",
              #"         (0-SUM(CASE WHEN xrce002 = '30' THEN
              #                    CASE WHEN xrce015 ='D' THEN xrce109 * -1 ELSE xrce109 END
              #                 ELSE
              #                    CASE WHEN xrce015 ='C' THEN xrce109 * -1 ELSE xrce109 END
              #                 END)),    ",
              #"          0,SUM(CASE WHEN xrce002 = '30' THEN
              #                    CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END
              #                 ELSE
              #                    CASE WHEN xrce015 ='C' THEN xrce119 * -1 ELSE xrce119 END
              #                 END),      ",
              #"         (0-SUM(CASE WHEN xrce002 = '30' THEN
              #                    CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END
              #                 ELSE
              #                    CASE WHEN xrce015 ='C' THEN xrce119 * -1 ELSE xrce119 END
              #                 END)),      ",
              #20150415 By 01727 Mark ---(E)---
              #20150415 By 01727 Add  ---(S)---
               "          0,SUM(CASE WHEN xrce015 ='D' THEN xrce109 * -1 ELSE xrce109 END),                                    ",
               "         (0-SUM(CASE WHEN xrce015 ='D' THEN xrce109 * -1 ELSE xrce109 END)),     ",
               "          0,SUM(CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END),      ",
               "         (0-SUM(CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END)),     ",
              #20150415 By 01727 Add  ---(E)---
               "          xrdaent,3,8307                                                         ",
               "         ,xrce029,xrce054                                                        ", #150902-00001#6
               "     FROM xrda_t,xrce_t                                                          ",
               "    WHERE xrdaent = xrceent AND xrceent = '",g_enterprise,"'                     ",
               "      AND xrdadocno = xrcedocno AND xrdald = xrceld                              ",
               "      AND xrce002 LIKE '3%'",
               "      AND ",l_xrdastus CLIPPED ,                                                 
               "      AND xrdadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'     ",                             
               "      AND xrceld IN ",g_wc_xrcald CLIPPED,
              #"    GROUP BY xrcecomp,xrceld,xrda005,xrdadocdt,xrda001,xrce003,xrce016,",l_xrce100,",xrdaent  "                              
              #"    GROUP BY xrcecomp,xrceld,xrda005,xrdadocdt,xrda001,xrcedocno,xrce016,",l_xrce100,",xrdaent"    #--carol.wu
               "    GROUP BY xrcecomp,xrceld,xrda005,xrdadocdt,xrda001,xrcedocno,xrce016,",l_xrce100,",xrdaent,xrce029,xrce054"    #150902-00001#6
   PREPARE axrq911_tmp_pre03 FROM g_sql
   EXECUTE axrq911_tmp_pre03
   LET g_sql = "   INSERT INTO axrq911_tmp                               ",
               "   SELECT xrcecomp,xrceld   ,xrca004,2,xrcadocdt,        ",
               "          xrce002 ,xrce003,xrce016,",l_xrce100,",   ",
               "          0,SUM(CASE WHEN xrce015 ='D' THEN xrce109 * -1 ELSE xrce109 END),      ",
               "         (0-SUM(CASE WHEN xrce015 ='D' THEN xrce109 * -1 ELSE xrce109 END)),     ",
               "          0,SUM(CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END),      ",
               "         (0-SUM(CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END)),     ",
               "          xrcaent,3,8306                                                         ",
                              "         ,xrce029,xrce054                                         ", #150902-00001#6
               "     FROM xrca_t,xrce_t                                                          ",
               "    WHERE xrcaent = xrceent AND xrceent = '",g_enterprise,"'                     ",
               "      AND xrcadocno = xrcedocno AND xrcald = xrceld                              ",
               "      AND xrce002 LIKE '3%'",
               "      AND ",l_xrcastus CLIPPED ,                                                 
               "      AND xrcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'     ",                             
               "      AND xrceld IN ",g_wc_xrcald CLIPPED,
               #"    GROUP BY xrcecomp,xrceld,xrca004,xrcadocdt,xrce002,xrce003,xrce016,",l_xrce100,",xrcaent"
                "    GROUP BY xrcecomp,xrceld,xrca004,xrcadocdt,xrce002,xrce003,xrce016,",l_xrce100,",xrcaent,xrce029,xrce054"    #150902-00001#6
   PREPARE axrq911_tmp_pre031 FROM g_sql
   EXECUTE axrq911_tmp_pre031
   #減少xrcf 期間有被沖暫估(xrcf_t)的帳款單者
   #本期增加 = 0 --> 0 - 本期減少 = 期末餘額   
   LET g_sql = "   INSERT INTO axrq911_tmp                               ",
               "   SELECT xrcacomp,xrcald   ,xrca004,2,xrcadocdt,        ",
               "          xrca001,xrcf008,xrcf021   ,",l_xrca100,",      ",
               "          0,SUM(CASE WHEN (xrca001 ='02' OR xrca001= '04') THEN xrcf105 * -1 ELSE xrcf105 END),  ",
               "          (0-SUM(CASE WHEN (xrca001 ='02' OR xrca001= '04') THEN xrcf105 * -1 ELSE xrcf105 END)),",
               "          0,SUM(CASE WHEN (xrca001 ='02' OR xrca001= '04') THEN xrcf115 * -1 ELSE xrcf115 END),  ",
               "          (0-SUM(CASE WHEN (xrca001 ='02' OR xrca001= '04') THEN xrcf115 * -1 ELSE xrcf115 END)),",
               "          xrcaent,4,8507                                                                         ",
               "         ,xrca038,xrca066                                                               ", #150902-00001#6
               "     FROM xrcf_t,xrca_t                                                                 ", 
               "    WHERE xrcfent = xrcaent AND xrcfent = '",g_enterprise,"'                            ",
               "      AND xrcf008 = xrcadocno                                                           ",
               "      AND xrcfdocno IN                                                                  ",
               "            (SELECT xrcadocno FROM xrca_t WHERE xrcaent = '",g_enterprise,"'            ",
               "                AND xrcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'   ", 
               "                AND xrcald IN ",g_wc_xrcald CLIPPED,")",                                                                   
               "      AND ",l_xrcastus CLIPPED , 
               "      AND xrcf008 = xrcadocno                         ",                                        
               "      AND xrcfld IN ",g_wc_xrcald CLIPPED,         
               #"    GROUP BY xrcacomp,xrcald,xrca004,xrcadocdt,xrca001,xrcf008,xrcf021,xrcf024,",l_xrca100,",xrcaent "                             
               "    GROUP BY xrcacomp,xrcald,xrca004,xrcadocdt,xrca001,xrcf008,xrcf021,xrcf024,",l_xrca100,",xrcaent,xrca038,xrca066   " #150902-00001#6
   PREPARE axrq911_tmp_pre04 FROM g_sql
   EXECUTE axrq911_tmp_pre04
   #減少apce 期間有被[AR]收款沖帳的帳款單者, 
   #本期增加 = 0 --> 0 - 本期減少 = 期末餘額   
   LET g_sql = "   INSERT INTO axrq911_tmp                               ",
               "   SELECT apcecomp,apceld   ,apce038,2,apdadocdt,        ",
               "          apda001 ,apcedocno,apce016,",l_apce100,",      ",
               "          0,SUM(CASE WHEN apce015 ='D' THEN apce109 * -1 ELSE apce109 END),  ",
               "          (0-SUM(CASE WHEN apce015 ='D' THEN apce109 * -1 ELSE apce109 END)),",
               "          0,SUM(CASE WHEN apce015 ='D' THEN apce119 * -1 ELSE apce119 END),  ",
               "          (0-SUM(CASE WHEN apce015 ='D' THEN apce119 * -1 ELSE apce119 END)),",
               "          apceent,5,8507                                                     ",
               "          ,apce029,apce048                                                   ",  #150902-00001#6
               "     FROM apce_t,apda_t                                                      ",
               "    WHERE apceent = apdaent AND apceent = '",g_enterprise,"'                 ",
               "      AND apcedocno = apdadocno AND apceld = apdald                          ",
               "      AND ",l_apdastus CLIPPED ,                                      
               "      AND apdadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",                             
               "      AND apceld IN ",g_wc_xrcald CLIPPED ,
               "      AND apce002 like '3%'                                                 ",
               #"    GROUP BY apcecomp,apceld,apce038,apdadocdt,apda001,apcedocno,apce016,",l_apce100,",apceent"                              
                "    GROUP BY apcecomp,apceld,apce038,apdadocdt,apda001,apcedocno,apce016,",l_apce100,",apceent,apce029,apce048 " #150902-00001#6
   PREPARE axrq911_tmp_pre05 FROM g_sql
   EXECUTE axrq911_tmp_pre05

END FUNCTION

################################################################################
# Descriptions...: 給予預設值
# Memo...........:
# Usage..........: CALL axrq911_default()
# Date & Author..: 2015/01/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq911_default()
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#9 Add

   LET g_input.xrcasite = g_site   
   LET g_input.xrcasite_desc = s_desc_get_department_desc(g_input.xrcasite)
   LET g_input.curr = 'Y' 
   CALL cl_set_comp_visible('b_xrca100,b_xrca108,l_xrca1081,l_xrca1082',TRUE)
   LET g_input.xrcastus = '1'
   LET g_input.strdate = s_date_get_first_date(g_today) 
   LET g_input.enddate = g_today     
   CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')
   #取得帳務中心底下之組織範圍
   #CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite   #150127-00007#1 mark
   CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
   CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp
   #取得帳務中心底下的帳套範圍   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald

  #161111-00049#2 Add  ---(S)---
   LET g_sql_ctrl = NULL
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#2 Add  ---(E)---

   DISPLAY BY NAME g_input.xrcasite,g_input.curr,g_input.strdate,g_input.enddate,
                   g_input.xrcasite_desc
END FUNCTION

################################################################################
# Descriptions...: 設置分頁
# Memo...........:
# Usage..........: CALL axrq911_set_page()
# Date & Author..: Hans By 2015/01/20
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq911_set_page()
DEFINE l_idx    LIKE type_t.num5
DEFINE l_sql    STRING

   #是否顯示原幣_分頁         
    IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   IF g_input.curr = 'Y' THEN
      CALL g_xrca_d2.clear()
      LET l_sql="   SELECT DISTINCT xrcald,xrca004,xrca100 ",
                "     FROM axrq911_tmp ",
                "    WHERE 1=1 "
      IF NOT cl_null(g_argv[1]) THEN
         LET l_sql = l_sql, "   AND xrca100 = '",g_currency,"'  ",
                            "   AND xrca004  = '",g_xrea009,"'  ",
                            "   AND xrcald   = '",g_ld,"'       "
      END IF
      LET l_sql = l_sql CLIPPED," AND ", g_wc
      LET l_sql = l_sql," ORDER BY xrcald,xrca004,xrca100 "      
     
      PREPARE axrq911_pr FROM l_sql
      DECLARE axrq911_cr CURSOR FOR axrq911_pr      
      LET l_idx=1  
   
      FOREACH axrq911_cr INTO g_xrca_d2[l_idx].xrcald,g_xrca_d2[l_idx].xrca004,g_xrca_d2[l_idx].xrca100 
         IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = 'FOREACH axrq911_cr'
              LET g_errparam.popup = FALSE
              CALL cl_err()
              EXIT FOREACH
        END IF
        IF l_idx > g_max_rec THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 9035
           LET g_errparam.extend = ''
           LET g_errparam.popup = FALSE
           CALL cl_err()
           EXIT FOREACH
        END IF
        IF cl_null(g_xrca_d2[l_idx].xrcald) OR cl_null(g_xrca_d2[l_idx].xrca004) OR cl_null(g_xrca_d2[l_idx].xrca100) then
           CALL g_xrca_d2.deleteElement(l_idx)
        ELSE
           LET l_idx=l_idx+1
        END IF        
        
      END FOREACH
   ELSE 
      CALL g_xrca_d2.clear()
      LET l_sql="   SELECT DISTINCT xrcald,xrca004  ", 
                "     FROM axrq911_tmp              ",
                "WHERE 1=1 "                 
      IF NOT cl_null(g_argv[1]) THEN
         LET l_sql = l_sql, "   AND xrca004  = '",g_xrea009,"'  ",
                            "   AND xrcald   = '",g_ld,"'         "
      END IF
      LET l_sql = l_sql CLIPPED , " AND ", g_wc
      LET l_sql = l_sql,"  ORDER BY xrcald,xrca004 "       
      PREPARE axrq911_pr2 FROM l_sql
      DECLARE axrq911_cr2 CURSOR FOR axrq911_pr2      
      LET l_idx=1  
      FOREACH axrq911_cr2 INTO g_xrca_d2[l_idx].xrcald,g_xrca_d2[l_idx].xrca004
         IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = 'FOREACH axrq911_cr2'
              LET g_errparam.popup = FALSE
              CALL cl_err()
              EXIT FOREACH
        END IF
        IF l_idx > g_max_rec THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 9035
           LET g_errparam.extend = ''
           LET g_errparam.popup = FALSE
           CALL cl_err()
           EXIT FOREACH
        END IF
        IF cl_null(g_xrca_d2[l_idx].xrcald) OR cl_null(g_xrca_d2[l_idx].xrca004)  then
           CALL g_xrca_d2.deleteElement(l_idx)
        ELSE
           LET l_idx=l_idx+1
        END IF    
     END FOREACH
   END IF   
   
   LET l_idx=l_idx - 1
   CALL g_xrca_d2.deleteElement(g_xrca_d2.getLength())
   LET g_header_cnt = g_xrca_d2.getLength()
   LET g_rec_b = l_idx   
   DISPLAY g_header_cnt TO FORMONLY.h_count    
     
      
   
END FUNCTION

################################################################################
# Descriptions...: 抓分頁取資料
# Memo...........:
# Usage..........: CALL axrq911_fetch1(p_flag)
# Input parameter: p_flag   第幾筆
# Date & Author..: 2015/01/20 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq911_fetch1(p_flag)
 DEFINE p_flag   LIKE type_t.chr1
 DEFINE ls_msg     STRING

   IF g_header_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt
      WHEN 'P'
         IF g_current_idx > 1 THEN
            LET g_current_idx = g_current_idx - 1
         END IF
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF

      WHEN '/'
         IF (NOT g_no_ask) THEN
            CALL cl_set_act_visible("accept,cancel", TRUE)
            CALL cl_getmsg('fetch',g_dlang) RETURNING ls_msg
            LET INT_FLAG = 0

            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT

            CALL cl_set_act_visible("accept,cancel", FALSE)
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
            END IF
         END IF

         IF g_jump > 0 AND g_jump <= g_xrca_d2.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE
   #代表沒有資料
   IF g_current_idx = 0 OR g_xrca_d2.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_xrca_d2.getLength() THEN
      LET g_current_idx = g_xrca_d2.getLength()
   END IF

   DISPLAY g_current_idx TO FORMONLY.h_index
   IF NOT cl_null(g_argv[1]) THEN  
      LET g_xrcald  = g_ld   
      LET g_xrca004 = g_xrea009
      LET g_xrca100 = g_currency                       
   ELSE            
      LET g_xrcald = g_xrca_d2[g_current_idx].xrcald
      LET g_xrca004 = g_xrca_d2[g_current_idx].xrca004
      LET g_xrca100 = g_xrca_d2[g_current_idx].xrca100
   END IF
   CALL axrq911_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........:
# Usage..........: CALL axrq911_output()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/19 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq911_output()
   DEFINE l_i          LIKE type_t.num10
   DEFINE l_wc         STRING
    
   IF g_xrca_d.getLength() <=0 THEN
      RETURN
   END IF
   DELETE FROM axrq911_tmp01;  #160727-00019#6  2016/07/28  By 08734    axrq911_bfill_tmp ——> axrq911_tmp01
   FOR l_i=1 TO g_xrca_d.getLength() 
      INSERT INTO axrq911_tmp01 VALUES(   #160727-00019#6  2016/07/28  By 08734    axrq911_bfill_tmp ——> axrq911_tmp01
      g_xrca_d[l_i].sel,g_xrca_d[l_i].xrcacomp,g_xrca_d[l_i].xrcacomp_desc, 
      g_xrca_d[l_i].xrcald,g_xrca_d[l_i].xrcald_desc,g_xrca_d[l_i].xrca004,g_xrca_d[l_i].xrca004_desc, 
      g_xrca_d[l_i].xrca014,g_xrca_d[l_i].xrca014_desc,g_xrca_d[l_i].type,g_xrca_d[l_i].xrcadocdt, 
      g_xrca_d[l_i].xrca001,g_xrca_d[l_i].xrca001_desc,g_xrca_d[l_i].xrcadocno,g_xrca_d[l_i].xrcb047, 
      g_xrca_d[l_i].xrca035,g_xrca_d[l_i].xrca035_desc,g_xrca_d[l_i].xrca038,g_xrca_d[l_i].xrca066,
      g_xrca_d[l_i].xrca100,g_xrca_d[l_i].xrca108, 
      g_xrca_d[l_i].l_xrca1081,g_xrca_d[l_i].l_xrca1082,g_xrca_d[l_i].xrca118,g_xrca_d[l_i].l_xrca1181, 
      g_xrca_d[l_i].l_xrca1182,l_i
      )
   END FOR
   LET l_wc=" 1=1"
   #當勾選顯示原幣時，顯示幣別及原幣金額，否則不顯示幣別及原幣金額
   IF g_input.curr = 'Y' THEN
      CALL axrq911_x01('axrq911_tmp01',l_wc)  #160727-00019#6  2016/07/28  By 08734    axrq911_bfill_tmp ——> axrq911_tmp01
   ELSE
      CALL axrq911_x02('axrq911_tmp01',l_wc)  #160727-00019#6  2016/07/28  By 08734    axrq911_bfill_tmp ——> axrq911_tmp01
   END IF
END FUNCTION

 
{</section>}
 
