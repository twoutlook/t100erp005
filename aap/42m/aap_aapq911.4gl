#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq911.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:25(2016-12-26 09:26:06), PR版次:0025(2017-02-20 21:28:21)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000111
#+ Filename...: aapq911
#+ Description: 供應商帳款明細查詢作業
#+ Creator....: 05016(2015-01-16 09:16:58)
#+ Modifier...: 03080 -SD/PR- 05634
 
{</section>}
 
{<section id="aapq911.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1             By Reanna   法人開窗修改
#150227                     By albireo  對帳測試修改版回
#150228                     By Belle    調匯資料顯示修改
#150302                     By Hans     依造帳套是否取用分錄底稿決定摘要說明。
#150327          2015/03/27 By apo      本期增加只显示未付金额（不含汇差调整）,再单独一行显示汇差
#150409          2015/04/09 By apo      aapt420沖銷數以aapt420之單頭單據性質及單號表達
#150319-00004#8  2015/04/30 By jessy    查詢類轉XG報表
#150401-00001#14 2015/08/07 By Belle    調整暫估取得apca001的方式
#150902-00001#5  2015/09/14 By Hans     增加傳票編號,發票號碼科目後加傳票號碼, 發票號碼取主檔 apca066
#151225-00001#1  2015/12/30 By Hans     回追carolwu 映泰修改
#160318-00025#43 2016/04/26 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160414-00018#39 2016/04/28 By Hans     效能調校
#160722-00002#1  2016/07/22 By 03538    遇到期末餘額類型,帳款對象重新取得說明
#160812-00027#2  2016/08/16 By 06821    全面盤點應付程式帳套權限控管
#160831-00032#1  2016/09/06 By Hans     aapq911 若對象為 EMPL 時取原單據的受款對象
#160920-00019#2  2016/09/26 By 08732    交易對象開窗校驗調整
#160816-00073#1  2016/10/13 By 01258    从临时表里查数据不需要匹配权限栏位字段
#161006-00005#20 2016/10/21 By 06137    組織類型與職能開窗清單需測試及調整開窗內容
#161108-00017#3  2016/11/09 By Reanna   程式中INSERT INTO 有星號作整批調整
#161114-00017#2  2016/11/15 By 06821    應付_開窗過濾據點
#161208-00002#1  2016/12/08 By 05016    當 aoos020 應收/付沖帳參數設定為 3.沖銷至明細時,以下相關查詢呈現的科目請抓取單身科目為主:aapq911,axrq911,aapq930,axrq930
#161221-00050#1  2016/12/26 By albireo  查詢時使用b_apca001,顯示時用apca001_desc欄位達到查詢可以下條件,EXCEL匯出與報表能正常顯示說明的效果
#161229-00047#36 2017/01/13 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170124-00013#4  2017/02/06 By Hans    應收/應付 帳齡分析表及月結表，因採月底重評價作業期初迴轉，故相關的結帳報表,期初值應扣減重評價金
#                                      取期初值時, 判斷是否有迴轉 IF glca002 = '2' THEN   #次月迴轉
#                                      期初【本幣】值必須先扣減 [上一期]的重評價金額 xreb115 本期匯差金額 其它的不變
#170220-00040#1  2017/02/20 By dorishsu PREPARE aapq911_tmp_pre03,傳票號碼改抓apda014
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
PRIVATE TYPE type_g_apca_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   apcacomp LIKE apca_t.apcacomp, 
   apcacomp_desc LIKE type_t.chr500, 
   apcald LIKE apca_t.apcald, 
   apcald_desc LIKE type_t.chr500, 
   apca004 LIKE apca_t.apca004, 
   apca004_desc LIKE type_t.chr500, 
   pmab031 LIKE type_t.chr20, 
   pmab031_desc LIKE type_t.chr500, 
   type LIKE type_t.chr500, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apca001 LIKE apca_t.apca001, 
   apca001_desc LIKE type_t.chr500, 
   apcadocno LIKE apca_t.apcadocno, 
   apcb047 LIKE type_t.chr500, 
   apca035 LIKE apca_t.apca035, 
   apca035_desc LIKE type_t.chr500, 
   apca038 LIKE apca_t.apca038, 
   apca066 LIKE apca_t.apca066, 
   apca100 LIKE apca_t.apca100, 
   apca108 LIKE apca_t.apca108, 
   l_apca1081 LIKE type_t.num20_6, 
   l_apca1082 LIKE type_t.num20_6, 
   apca118 LIKE apca_t.apca118, 
   l_apca1181 LIKE type_t.num20_6, 
   l_apca1182 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
       apcasite        LIKE apca_t.apcasite,
       apcasite_desc   LIKE type_t.chr100,
       strdate         LIKE apca_t.apcadocdt,
       enddate         LIKE apca_t.apcadocdt,
       curr            LIKE type_t.chr1,
       apcastus        LIKE type_t.chr1
END RECORD       
     
DEFINE g_wc_apcald   STRING
DEFINE g_wc_apcacomp STRING    

DEFINE g_apcald       LIKE apca_t.apcald
DEFINE g_apca004       LIKE apca_t.apca004
DEFINE g_apca100       LIKE apca_t.apca100
DEFINE g_apca_d2        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       apcald          LIKE apca_t.apcald,
       apca004         LIKE apca_t.apca004,
       apca100         LIKE apca_t.apca100,
       apcaent         LIKE apca_t.apcaent
      END RECORD
DEFINE g_current_row   LIKE type_t.num5
DEFINE g_current_idx   LIKE type_t.num10
DEFINE g_jump          LIKE type_t.num10
DEFINE g_no_ask        LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5

DEFINE g_apcasite      LIKE apca_t.apcasite
DEFINE g_year          LIKE type_t.chr100
DEFINE g_strmon        LIKE type_t.chr100
DEFINE g_endmon        LIKE type_t.chr100
DEFINE g_ld            LIKE apca_t.apcald
DEFINE g_currency      LIKE type_t.chr100
DEFINE g_xrea009       LIKE xrea_t.xrea009
DEFINE l_apcastus_desc LIKE type_t.chr500   #150319-00004#8 接收資料類型的說明
DEFINE g_hide_flag     LIKE type_t.chr1     #150319-00004#8 tm.a2定義動態顯隱條件
DEFINE g_wc_cs_ld      STRING               #160812-00027#2 add 查詢時帳套權限範圍
DEFINE g_sql_ctrl      STRING               #160920-00019#2-add 交易對象控制組回傳
DEFINE g_comp          LIKE apca_t.apcacomp #161114-00017#2 add
DEFINE g_comp_str      STRING               #161229-00047#36
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apca_d
DEFINE g_master_t                   type_g_apca_d
DEFINE g_apca_d          DYNAMIC ARRAY OF type_g_apca_d
DEFINE g_apca_d_t        type_g_apca_d
 
      
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
 
{<section id="aapq911.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl  #160920-00019#2--add #161114-00017#2 mark
   #161114-00017#2 --s add
   #因單頭為INPUT,因此直接以帳套法人傳入
   LET g_sql_ctrl = NULL
   LET g_comp = ''
   SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#36 mark
   #161114-00017#2 --e add
   #161229-00047#36 add ------
   CALL s_fin_get_wc_str(g_comp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#36 add end---
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
   DECLARE aapq911_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq911_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq911_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq911 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq911_init()   
 
      #進入選單 Menu (="N")
      CALL aapq911_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq911
      
   END IF 
   
   CLOSE aapq911_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq911.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq911_init()
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
   
      CALL cl_set_combo_scc('b_apca001','8502') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL aapq911_create_tmp()
  #CALL cl_set_combo_scc('b_apca001','8502')       #150228
   CALL s_fin_create_account_center_tmp()  
   CALL aapq911_default()   
   LET g_apcasite = g_argv[1]  #帳務中心
   LET g_year     = g_argv[2]  #年度
   LET g_strmon   = g_argv[3]  #起始月
   LET g_endmon   = g_argv[4]  #結束月
   LET g_ld       = g_argv[5]  #帳套
   LET g_currency = g_argv[6]  #是否顯示幣別如果不為空 則顯示幣別 ELS 不顯示原幣   
   LET g_xrea009  = g_argv[7] #帳款對象     
 
   IF NOT cl_null(g_argv[1]) THEN
      LET g_input.apcasite = g_apcasite   
      LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)
      LET g_input.apcastus = '1'   
      CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
      #取得帳務中心底下之組織範圍
      #CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite   #150127-00007#1 mark
      CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp    #150127-00007#1 add
      CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
      #取得帳務中心底下的帳套範圍   
      CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
      CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
      IF g_currency = 'N' THEN
         LET g_input.curr = 'N'
         LET g_currency = ''
         CALL cl_set_comp_visible('b_apca100,b_apca108,l_apca1081,l_apca1082',FALSE)
      ELSE
         LET g_input.curr = 'Y'
         CALL cl_set_comp_visible('b_apca100,b_apca108,l_apca1081,l_apca1082',TRUE)          
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
      DISPLAY BY NAME g_input.apcasite,g_input.curr,g_input.strdate,g_input.enddate,
                      g_input.apcasite_desc,g_input.strdate,g_input.enddate   
   END IF       
   
   #160812-00027#2 --s add
   #帳套權限相關預設範圍
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld  
   #160812-00027#2 --e add
   #end add-point
 
   CALL aapq911_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq911.default_search" >}
PRIVATE FUNCTION aapq911_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " apcald = '", g_argv[08], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " apcadocno = '", g_argv[09], "' AND "
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
 
{<section id="aapq911.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq911_ui_dialog()
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
   IF g_header_cnt=1 THEN
     CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
   ELSE
      IF g_current_idx=1 THEN
         CALL cl_set_act_visible("first,previous", FALSE)
         CALL cl_set_act_visible("jump,next,last", TRUE)
      ELSE
         IF g_current_idx<>g_header_cnt THEN
            CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
         ELSE
            CALL cl_set_act_visible("first,previous,jump",TRUE)
            CALL cl_set_act_visible("next,last", FALSE)
         END IF
      END IF
   END IF
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
      CALL aapq911_b_fill()
   ELSE
      CALL aapq911_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apca_d.clear()
 
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
 
         CALL aapq911_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq911_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq911_detail_action_trans()
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
            CALL aapq911_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_comp_visible('sel', FALSE)
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aapq911_ins_aapq911_x01() #160414-00018#39
               #150319-00004#8-----s
               LET g_hide_flag  = g_input.curr                         #幣別的隱顯判斷(tm.a2)
               CALL aapq911_x01(' 1=1','aapq911_x01_tmp',g_hide_flag)  #畫面的東西轉成XG報表
               #150319-00004#8-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aapq911_ins_aapq911_x01() #160414-00018#39
               #150319-00004#8-----s
               LET g_hide_flag  = g_input.curr                         #幣別的隱顯判斷(tm.a2)
               CALL aapq911_x01(' 1=1','aapq911_x01_tmp',g_hide_flag)  #畫面的東西轉成XG報表
               #150319-00004#8-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq911_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible('sel', FALSE)
               CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
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
            CALL aapq911_filter()
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
            CALL aapq911_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apca_d)
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
            CALL aapq911_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq911_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq911_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq911_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apca_d.getLength()
               LET g_apca_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_apca_d.getLength()
               LET g_apca_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_apca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apca_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_apca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apca_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION previous
            LET g_action_choice="previous"
            CALL aapq911_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION next
            LET g_action_choice="next"
            CALL aapq911_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION first
            LET g_action_choice="first"
            CALL aapq911_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION jump
            LET g_action_choice="jump"
            CALL aapq911_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION last
            LET g_action_choice="last"
            CALL aapq911_fetch1('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
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
 
{<section id="aapq911.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq911_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_fday     LIKE apca_t.apcadocdt
   DEFINE l_ld_str   STRING                 #161114-00017#2 add
   #161114-00017#2 --s add
   DEFINE l_ld       LIKE glaa_t.glaald
   DEFINE l_comp     LIKE ooef_t.ooef001
   #161114-00017#2 --e add    
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   #161221-00050#1-----s
   CALL cl_set_comp_visible('b_apca001',TRUE)
   CALL cl_set_comp_visible('apca001_desc',FALSE)
   #161221-00050#1-----e
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apca_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apcacomp,apcald,apca004,apcadocdt,apca001,apcadocno,apca035,apca038,apca066, 
          apca100,apca108,apca118
           FROM s_detail1[1].b_apcacomp,s_detail1[1].b_apcald,s_detail1[1].b_apca004,s_detail1[1].b_apcadocdt, 
               s_detail1[1].b_apca001,s_detail1[1].b_apcadocno,s_detail1[1].b_apca035,s_detail1[1].b_apca038, 
               s_detail1[1].b_apca066,s_detail1[1].b_apca100,s_detail1[1].b_apca108,s_detail1[1].b_apca118 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_apcacomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcacomp
            #add-point:BEFORE FIELD b_apcacomp name="construct.b.page1.b_apcacomp"
           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcacomp
            
            #add-point:AFTER FIELD b_apcacomp name="construct.a.page1.b_apcacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcacomp
            #add-point:ON ACTION controlp INFIELD b_apcacomp name="construct.c.page1.b_apcacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_apcacomp
            CALL q_ooef001()                           
            DISPLAY g_qryparam.return1 TO b_apcacomp   
            NEXT FIELD b_apcacomp
            #END add-point
 
 
         #----<<apcacomp_desc>>----
         #----<<b_apcald>>----
         #Ctrlp:construct.c.page1.b_apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcald
            #add-point:ON ACTION controlp INFIELD b_apcald name="construct.c.page1.b_apcald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " glaald IN ",g_wc_apcald #160812-00027#2 mark
            LET g_qryparam.where = " glaald IN ",g_wc_cs_ld   #160812-00027#2 add
            LET g_qryparam.arg1 = g_user
            #LET g_qryparam.arg2 = g_grup #160812-00027#2 mark
            LET g_qryparam.arg2 = g_dept  #160812-00027#2 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_apcald
            NEXT FIELD b_apcald


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcald
            #add-point:BEFORE FIELD b_apcald name="construct.b.page1.b_apcald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcald
            
            #add-point:AFTER FIELD b_apcald name="construct.a.page1.b_apcald"
            
            #END add-point
            
 
 
         #----<<apcald_desc>>----
         #----<<b_apca004>>----
         #Ctrlp:construct.c.page1.b_apca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca004
            #add-point:ON ACTION controlp INFIELD b_apca004 name="construct.c.page1.b_apca004"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #供廠商OR交易對象  #160920-00019#2--mark
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001_25()
            DISPLAY g_qryparam.return1 TO b_apca004
            NEXT FIELD b_apca004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca004
            #add-point:BEFORE FIELD b_apca004 name="construct.b.page1.b_apca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca004
            
            #add-point:AFTER FIELD b_apca004 name="construct.a.page1.b_apca004"
            
            #END add-point
            
 
 
         #----<<apca004_desc>>----
         #----<<pmab031>>----
         #----<<pmab031_desc>>----
         #----<<b_type>>----
         #----<<b_apcadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcadocdt
            #add-point:BEFORE FIELD b_apcadocdt name="construct.b.page1.b_apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcadocdt
            
            #add-point:AFTER FIELD b_apcadocdt name="construct.a.page1.b_apcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apca001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca001
            #add-point:BEFORE FIELD b_apca001 name="construct.b.page1.b_apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca001
            
            #add-point:AFTER FIELD b_apca001 name="construct.a.page1.b_apca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca001
            #add-point:ON ACTION controlp INFIELD b_apca001 name="construct.c.page1.b_apca001"
            
            #END add-point
 
 
         #----<<apca001_desc>>----
         #----<<b_apcadocno>>----
         #Ctrlp:construct.c.page1.b_apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocno
            #add-point:ON ACTION controlp INFIELD b_apcadocno name="construct.c.page1.b_apcadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apcastus = 'Y' AND  apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",
                                   #" AND apcasite IN ", g_wc_apcasite   #150127-00007#1 mark
                                   " AND apcacomp IN ", g_wc_apcacomp    #150127-00007#1 add                                   
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcadocno  #顯示到畫面上
            NEXT FIELD b_apcadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apcadocno
            #add-point:BEFORE FIELD b_apcadocno name="construct.b.page1.b_apcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apcadocno
            
            #add-point:AFTER FIELD b_apcadocno name="construct.a.page1.b_apcadocno"
            
            #END add-point
            
 
 
         #----<<apcb047>>----
         #----<<b_apca035>>----
         #Ctrlp:construct.c.page1.b_apca035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca035
            #add-point:ON ACTION controlp INFIELD b_apca035 name="construct.c.page1.b_apca035"
            #費用(借方)科目編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161111-00042#2 --s add
			   LET l_comp = NULL
			   SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
			   LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glacent = gladent AND glad001= glac002 ",
                                   " AND gladld='",l_ld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"                              
            #161111-00042#2 --s add            
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_apca035   #顯示到畫面上


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca035
            #add-point:BEFORE FIELD b_apca035 name="construct.b.page1.b_apca035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca035
            
            #add-point:AFTER FIELD b_apca035 name="construct.a.page1.b_apca035"
            
            #END add-point
            
 
 
         #----<<apca035_desc>>----
         #----<<b_apca038>>----
         #Ctrlp:construct.c.page1.b_apca038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca038
            #add-point:ON ACTION controlp INFIELD b_apca038 name="construct.c.page1.b_apca038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_apca038()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca038  #顯示到畫面上
            NEXT FIELD b_apca038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca038
            #add-point:BEFORE FIELD b_apca038 name="construct.b.page1.b_apca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca038
            
            #add-point:AFTER FIELD b_apca038 name="construct.a.page1.b_apca038"
            
            #END add-point
            
 
 
         #----<<b_apca066>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca066
            #add-point:BEFORE FIELD b_apca066 name="construct.b.page1.b_apca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca066
            
            #add-point:AFTER FIELD b_apca066 name="construct.a.page1.b_apca066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca066
            #add-point:ON ACTION controlp INFIELD b_apca066 name="construct.c.page1.b_apca066"
            
            #END add-point
 
 
         #----<<b_apca100>>----
         #Ctrlp:construct.c.page1.b_apca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca100
            #add-point:ON ACTION controlp INFIELD b_apca100 name="construct.c.page1.b_apca100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca100  #顯示到畫面上
            NEXT FIELD b_apca100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca100
            #add-point:BEFORE FIELD b_apca100 name="construct.b.page1.b_apca100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca100
            
            #add-point:AFTER FIELD b_apca100 name="construct.a.page1.b_apca100"
            
            #END add-point
            
 
 
         #----<<b_apca108>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca108
            #add-point:BEFORE FIELD b_apca108 name="construct.b.page1.b_apca108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca108
            
            #add-point:AFTER FIELD b_apca108 name="construct.a.page1.b_apca108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca108
            #add-point:ON ACTION controlp INFIELD b_apca108 name="construct.c.page1.b_apca108"
            
            #END add-point
 
 
         #----<<l_apca1081>>----
         #----<<l_apca1082>>----
         #----<<b_apca118>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apca118
            #add-point:BEFORE FIELD b_apca118 name="construct.b.page1.b_apca118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apca118
            
            #add-point:AFTER FIELD b_apca118 name="construct.a.page1.b_apca118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca118
            #add-point:ON ACTION controlp INFIELD b_apca118 name="construct.c.page1.b_apca118"
            
            #END add-point
 
 
         #----<<l_apca1181>>----
         #----<<l_apca1182>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_input.apcasite,g_input.apcasite_desc,g_input.strdate,g_input.enddate,
            g_input.curr,g_input.apcastus    
      
      FROM b_apcasite,apcasite_desc,b_strdate,b_enddate,
           b_curr,b_apcastus
      ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD b_apcasite
            LET g_input.apcasite_desc = ''
            IF NOT cl_null(g_input.apcasite) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_input.apcasite
               #160318-00025#43  2016/04/26  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#43  2016/04/26  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooef001") THEN
                  LET g_input.apcasite = ''
                  LET g_input.apcasite_desc = ''
                  DISPLAY BY NAME g_input.apcasite_desc,g_input.apcasite
                  NEXT FIELD b_apcasite
               END IF
               CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
               #取得帳務中心底下之組織範圍
               #CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite   #150127-00007#1 mark
               CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp    #150127-00007#1 add
               CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp              
               #取得帳務中心底下的帳套範圍   
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)
               DISPLAY BY NAME g_input.apcasite_desc
               #161114-00017#2 --s add
               #控制組
               LET g_comp = ''
               SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.apcasite AND ooefstus = 'Y'
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#36 mark
               #161114-00017#2 --e add
               #161229-00047#36 add ------
               CALL s_fin_get_wc_str(g_comp) RETURNING g_comp_str
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
               #161229-00047#36 add end---
            END IF
           
         ON ACTION controlp  INFIELD  b_apcasite               
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_input.apcasite
           #CALL q_ooef001()            #161006-00005#20 Mark By Ken 161021
           CALL q_ooef001_46()          #161006-00005#20 Add By Ken 161021
           LET g_input.apcasite = g_qryparam.return1
           CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'1')
           #取得帳務中心底下之組織範圍
           #CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite   #150127-00007#1 mark
           CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp    #150127-00007#1 add
           CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp              
           #取得帳務中心底下的帳套範圍   
           CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
           CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
           LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)            
           CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
           DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
           NEXT FIELD b_apcasite 
           
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
              CALL cl_set_comp_visible('b_apca100,b_apca108,l_apca1081,l_apca1082',TRUE)
           ELSE  # 不含＂幣別＂則隱藏單身的【幣別】【原幣期初、期末、本期增加、本期減少金額
              CALL cl_set_comp_visible('b_apca100,b_apca108,l_apca1081,l_apca1082',FALSE)
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
      CALL aapq911_default()
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
 #  CALL aapq911_insert_tmp()
#   CALL aapq911_set_page()
#   CALL aapq911_fetch1('F')
#   LET g_error_show = 1
#    IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = -100 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#   END IF
#   
#   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
#   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
#   RETURN
   #end add-point
        
   LET g_error_show = 1
   CALL aapq911_b_fill()
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
 
{<section id="aapq911.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq911_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_apca100_t    LIKE apca_t.apca004 #前筆帳款對象
   DEFINE l_tmp          type_g_apca_d
   DEFINE l_odr          LIKE type_t.num5
   DEFINE l_ins          LIKE type_t.chr80
   DEFINE l_apcc108      LIKE apcc_t.apcc108   #20150213apo Add
   DEFINE l_apcc118      LIKE apcc_t.apcc118   #20150213apo Add  
   DEFINE l_group        LIKE type_t.chr100
   DEFINE l_group_t      LIKE type_t.chr100
   DEFINE l_grotype      LIKE type_t.chr100
   DEFINE l_apcald       LIKE apca_t.apcald
   DEFINE l_apca004      LIKE apca_t.apca004
   DEFINE l_apca100      LIKE apca_t.apca100
   DEFINE l_type_t       LIKE type_t.chr10
   DEFINE l_str          LIKE type_t.chr80
   DEFINE l_ap_slip      LIKE ooba_t.ooba002  #150301apo
   DEFINE l_oobx003      LIKE oobx_t.oobx003  #150301apo
   DEFINE l_glaa121      LIKE glaa_t.glaa121  #150302Hans
   DEFINE l_apca001_desc LIKE type_t.chr80
   
   #150319-00004#8-----s
   #XG報表用的temp
   DEFINE l_i            LIKE type_t.num10
   DEFINE l_x01_tmp      RECORD
      apcasite           LIKE apca_t.apcasite,
      apcasite_desc      LIKE type_t.chr100,
      l_sedate           LIKE type_t.chr500,
      strdate            LIKE apca_t.apcadocdt,
      enddate            LIKE apca_t.apcadocdt,
      curr               LIKE type_t.chr1,
      apcastus           LIKE type_t.chr1,
      l_apcastus_desc    LIKE type_t.chr500,
      apcacomp           LIKE apca_t.apcacomp, 
      apcacomp_desc      LIKE type_t.chr500, 
      apcald             LIKE apca_t.apcald, 
      apcald_desc        LIKE type_t.chr500, 
      apca004            LIKE apca_t.apca004, 
      apca004_desc       LIKE type_t.chr500, 
      pmab031            LIKE type_t.chr20, 
      pmab031_desc       LIKE type_t.chr500, 
      type               LIKE type_t.chr500, 
      apcadocdt          LIKE apca_t.apcadocdt, 
      apca001            LIKE apca_t.apca001, 
      apca001_desc       LIKE type_t.chr500, 
      apcadocno          LIKE apca_t.apcadocno, 
      apcb047            LIKE type_t.chr500, 
      apca035            LIKE apca_t.apca035, 
      apca035_desc       LIKE type_t.chr500, 
      apca038            LIKE apca_t.apca038, 
      apca066            LIKE apca_t.apca066,
      apca100            LIKE apca_t.apca100, 
      apca108            LIKE apca_t.apca108, 
      l_apca1081         LIKE type_t.num20_6, 
      l_apca1082         LIKE type_t.num20_6, 
      apca118            LIKE apca_t.apca118, 
      l_apca1181         LIKE type_t.num20_6, 
      l_apca1182         LIKE type_t.num20_6
   END RECORD
   #150319-00004#8-----e
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #161221-00050#1-----s
   CALL cl_set_comp_visible('b_apca001',FALSE)
   CALL cl_set_comp_visible('apca001_desc',TRUE)
   #161221-00050#1-----e
   CALL aapq911_insert_tmp()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',apcacomp,'',apcald,'',apca004,'','','','',apcadocdt,apca001, 
       '',apcadocno,'',apca035,'',apca038,apca066,apca100,apca108,'','',apca118,'',''  ,DENSE_RANK() OVER( ORDER BY apca_t.apcald, 
       apca_t.apcadocno) AS RANK FROM apca_t",
 
 
                     "",
                     " WHERE apcaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apca_t"),
                     " ORDER BY apca_t.apcald,apca_t.apcadocno"
 
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
 
   LET g_sql = "SELECT '',apcacomp,'',apcald,'',apca004,'','','','',apcadocdt,apca001,'',apcadocno,'', 
       apca035,'',apca038,apca066,apca100,apca108,'','',apca118,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160831-00032---s---
   LET g_sql = " SELECT apde017 FROM apde_t WHERE apdeent = ",g_enterprise," AND apdedocno = ? "
   PREPARE aapq911_apde017_prep FROM g_sql
   DECLARE aapq911_apde017_curs CURSOR FOR aapq911_apde017_prep
   
   LET g_sql = " SELECT apca057 FROM apca_t WHERE apcaent = ",g_enterprise," AND apcadocno = ? "
   PREPARE aapq911_apca057_prep FROM g_sql
     
  #160831-00032---e---
        
   #摘要說明　立帳:apcb047
   LET g_sql = "SELECT apcb047 FROM apcb_t WHERE apcbent = '",g_enterprise,"' ",
               "   AND apcb047 IS NOT NULL AND apcb047 <> ' '                 ",
               "   AND apcbld = ?   AND apcbdocno = ?                         ",
               " ORDER by apcbseq                                             "

               
   PREPARE aapq911_pb7 FROM g_sql
   DECLARE aapq911_cs7 CURSOR FOR aapq911_pb7
   
   #沖帳:apce010
   LET g_sql = "SELECT apce010 FROM apce_t WHERE apceent ='",g_enterprise,"' ",
               "  AND apce010 IS NOT NULL AND apce010 <> ' '                 ",
               "  AND apceld = ? AND apcedocno = ?                           ",
               #-150331apo--(s)
               #150331 carol:來源為aapt430之沖銷紀錄(apda_t+apce_t),帳款單性質1*的要排除, 2*不排除(原因為aapt430只會回寫性質為2*之apcc)
               "  AND NOT ( apce001='aapt430' AND EXISTS(SELECT 1 FROM apca_t ",
               "                                          WHERE apcaent = apceent ",
               "                                            AND apcadocno = apce003 ",
               "                                            AND apcald = apceld ",
               "                                            AND apca001 LIKE '1%')) ",
               #-150331apo--(e)               
               " ORDER BY apceseq                                            "
               
   PREPARE aapq911_pb9 FROM g_sql            
   DECLARE aapq911_cs9 CURSOR FOR aapq911_pb9
   
   #調匯:xreh033
   LET g_sql= "SELECT xreh033 FROM xreh_t WHERE xrehent = '",g_enterprise,"' ",
              "   AND xreh033 IS NOT NULL AND xreh033 <> ' '                 ",
              "   AND xrehld = ? AND xrehdocno = ?                           ",
              " ORDER BY xrehseq                                             "              
              
   PREPARE aapq911_pb10 FROM g_sql
   DECLARE aapq911_cs10 CURSOR FOR aapq911_pb10
   
   #啟用分錄底稿 
   LET g_sql = "SELECT glgb001 FROM glgb_t WHERE glgbent = '",g_enterprise,"' ",
               "   AND glgbld = ?   AND glgbdocno = ?                         ",
               "   AND glgb100 = 'AP'                                         ",
               "   AND glgb001 IS NOT NULL ",                                      #160414-00018#39 
               " ORDER BY glgbseq                                             "               
   PREPARE aapq911_pb8 FROM g_sql
   DECLARE aapq911_cs8 CURSOR FOR aapq911_pb8
   #160414-00018#39---s---
   #LET g_sql = "   SELECT ''       ,apcacomp,''       ,apcald,'', ",
   #            "          apca004  ,''      ,''       ,''    ,    ",
   #            "          type     ,apcadocdt,                    ",
   #            "          source,apca001,apcadocno,'',apca035,'', ",  #150228 add source           
   #            "          apca038 ,apca066,                       ",  #150902-00001#5
   #            "          apca100 ,                               ",
   #            "          apca108  ,apca1081,apca1082 ,           ",
   #            "          apca118  ,apca1181,apca1182             ",
   #            "     FROM aapq911_tmp                             ",
   #            "    WHERE apcaent= ? AND 1=1                      ", 
   #            "      AND apcacomp IN " ,g_wc_apcacomp CLIPPED,  
   #            "      AND ", ls_wc,cl_sql_add_filter("apca_t")
   #LET g_sql = g_sql, cl_sql_add_filter("apca_t"),
   #            #" ORDER BY type,apcald,apca004,apca100 "    #albireo 150227 mark
   #            #" ORDER BY apcald,apca004,apca100,type "                              #150326apo mark   #albireo 150227 add              
   #            " ORDER BY apcald,apca004,apca100,type,apcadocdt,apcadocno,apca001 "   #150326apo
  
  LET g_sql = "   SELECT '',                  ",
               "         apcacomp,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = apcaent AND ooefl001 = apcacomp AND ooefl002 ='",g_dlang,"'),  ",
               "         apcald,  (SELECT glaal002 FROM glaal_t WHERE glaalent = apcaent AND glaalld  = apcald   AND glaal001 ='",g_dlang,"'),  ",
               "         apca004, (SELECT pmaal004 FROM pmaal_t WHERE pmaalent = apcaent AND pmaal001 = apca004  AND pmaal002 ='",g_dlang,"'),  ",
               "                  (SELECT pmab031  FROM pmab_t  WHERE pmabent = apcaent  AND pmabsite =apcacomp  AND pmab001 = apca004      ),  ",
               "                  (SELECT ooag011  FROM ooag_t,pmab_t  WHERE ooagent = apcaent AND pmabent = apcaent AND ooag001 = pmab031 AND pmabsite = apcacomp AND pmab001 = apca004 ), ",               
               "          type     ,apcadocdt,                    ",
               "          source,apca001,apcadocno,'',            ",
               "          apca035,(SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = apcaent AND glaclent = glaaent AND glacl001 = glaa004       ",  #150228 add source           
               "                                                         AND glacl002 = apca035 AND glaald = apcald    AND glacl003 ='",g_dlang,"'),",
               "          apca038 ,apca066,apca100 ,              ", 
               "          apca108  ,apca1081,apca1082 ,           ",
               "          apca118  ,apca1181,apca1182             ",
               "     FROM aapq911_tmp                             ",
               "    WHERE apcaent= ? AND 1=1                      ", 
               "      AND apcacomp IN " ,g_wc_apcacomp CLIPPED,  
              #"      AND ", ls_wc,cl_sql_add_filter("apca_t")   #160816-00073#1 mark
               "      AND ", ls_wc                               #160816-00073#1 add
  #LET g_sql = g_sql, cl_sql_add_filter("apca_t"),               #160816-00073#1 mark
   #161114-00017#2 --s add
   #加上帳款對象控制組
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = apcaent ",
                        "                AND pmaa001 = apca004 )"
   END IF
   #161114-00017#2 --e add  
   LET g_sql = g_sql,                                            #160816-00073#1 add                          
               " ORDER BY apcald,apca004,apca100,type,apcadocdt,apcadocno,apca001 "  
   #160414-00018#39---e---               
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq911_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq911_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apca_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_group = ''
   LET l_group_t = ''   
   LET l_ins = '' #判斷是否塞入合計
   LET l_odr = 1
   LET l_apcc108 = 0 #20150213apo Add
   LET l_apcc118 = 0 #20150213apo Add   
   LET l_type_t = NULL
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apca_d[l_ac].sel,g_apca_d[l_ac].apcacomp,g_apca_d[l_ac].apcacomp_desc, 
       g_apca_d[l_ac].apcald,g_apca_d[l_ac].apcald_desc,g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca004_desc, 
       g_apca_d[l_ac].pmab031,g_apca_d[l_ac].pmab031_desc,g_apca_d[l_ac].type,g_apca_d[l_ac].apcadocdt, 
       g_apca_d[l_ac].apca001,g_apca_d[l_ac].apca001_desc,g_apca_d[l_ac].apcadocno,g_apca_d[l_ac].apcb047, 
       g_apca_d[l_ac].apca035,g_apca_d[l_ac].apca035_desc,g_apca_d[l_ac].apca038,g_apca_d[l_ac].apca066, 
       g_apca_d[l_ac].apca100,g_apca_d[l_ac].apca108,g_apca_d[l_ac].l_apca1081,g_apca_d[l_ac].l_apca1082, 
       g_apca_d[l_ac].apca118,g_apca_d[l_ac].l_apca1181,g_apca_d[l_ac].l_apca1182
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apca_d[l_ac].statepic = cl_get_actipic(g_apca_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF cl_null(g_apca_d[l_ac].apca108 ) THEN LET g_apca_d[l_ac].apca108  = 0 END IF
      IF cl_null(g_apca_d[l_ac].l_apca1081) THEN LET g_apca_d[l_ac].l_apca1081 = 0 END IF
      IF cl_null(g_apca_d[l_ac].l_apca1082) THEN LET g_apca_d[l_ac].l_apca1082 = 0 END IF

      IF cl_null(g_apca_d[l_ac].apca118 ) THEN LET g_apca_d[l_ac].apca118  = 0 END IF
      IF cl_null(g_apca_d[l_ac].l_apca1181) THEN LET g_apca_d[l_ac].l_apca1181 = 0 END IF
      IF cl_null(g_apca_d[l_ac].l_apca1182) THEN LET g_apca_d[l_ac].l_apca1182 = 0 END IF

      IF cl_null(l_apcald)  THEN LET l_apcald  = g_apca_d[l_ac].apcald END IF
      IF cl_null(l_apca004) THEN LET l_apca004 = g_apca_d[l_ac].apca004 END IF
      IF cl_null(l_apca100) THEN LET l_apca100 = g_apca_d[l_ac].apca100 END IF
      #150228
     #CASE g_apca_d[l_ac].apca001        #150409apo mark
      CASE g_apca_d[l_ac].apca001[1,1]   #150409apo
         WHEN '1'
            LET g_apca_d[l_ac].apca001_desc = g_apca_d[l_ac].apca001_desc,":",s_desc_gzcbl004_desc('8502',g_apca_d[l_ac].apca001_desc)
            #160831-00032---s---
            IF g_apca_d[l_ac].apca004 ='EMPL' AND NOT cl_null(g_apca_d[l_ac].apcadocno) THEN
               EXECUTE aapq911_apca057_prep USING g_apca_d[l_ac].apcadocno INTO g_apca_d[l_ac].pmab031
               CALL s_desc_get_person_desc(g_apca_d[l_ac].pmab031)RETURNING g_apca_d[l_ac].pmab031_desc
            END IF                           
            #160831-00032---e---
         WHEN '2' 
            #160831-00032---s---
            IF g_apca_d[l_ac].apca004 = 'EMPL' AND NOT cl_null(g_apca_d[l_ac].apcadocno) THEN
               FOREACH aapq911_apde017_curs USING g_apca_d[l_ac].apcadocno INTO g_apca_d[l_ac].pmab031
                  EXIT FOREACH
               END FOREACH
               CALL s_desc_get_person_desc(g_apca_d[l_ac].pmab031)RETURNING g_apca_d[l_ac].pmab031_desc
            END IF                           
            #160831-00032---e---
              #--150409apo--(s)--
              
              LET l_str = ''
              CASE g_apca_d[l_ac].apca001
                 WHEN '21'  #aapt420沖帳
                    LET l_str = '8507'
                 WHEN '2'   #直接沖帳
                    LET l_str = '8506'
              END CASE
              LET g_apca_d[l_ac].apca001_desc = g_apca_d[l_ac].apca001_desc,":",s_desc_gzcbl004_desc(l_str,g_apca_d[l_ac].apca001_desc)
              #--150409apo--(e)--
             #LET g_apca_d[l_ac].apca001_desc = g_apca_d[l_ac].apca001_desc,":",s_desc_gzcbl004_desc('8506',g_apca_d[l_ac].apca001_desc)  #150409apo mark
         WHEN '3'
              #--150301apo--(s)
              CALL s_aooi200_get_slip(g_apca_d[l_ac].apcadocno) RETURNING g_sub_success,l_ap_slip
              LET l_oobx003 = ''
              SELECT oobx003 INTO l_oobx003
                FROM oobx_t
               WHERE oobxent = g_enterprise
                 AND oobx001 = l_ap_slip     
              LET g_apca_d[l_ac].apca001_desc = s_desc_gzcbl004_desc('24',l_oobx003)                   
              #--150301apo--(e)                   
              #LET g_apca_d[l_ac].apca001_desc = s_desc_gzcbl004_desc('24',g_apca_d[l_ac].apca001_desc)
#-150326apo-mark--(s)              
#         OTHERWISE
#              SELECT gzcbl004 INTO l_apca001_desc
#                FROM gzcb_t,gzcbl_t
#               WHERE gzcb002 = gzcbl002 
#                 AND gzcbl001 = '8507'
#                 AND gzcbl003 = g_dlang
#                 AND gzcb002 = g_apca_d[l_ac].apca001_desc
#              UNION 
#              SELECT gzcbl004 INTO l_apca001_desc
#                FROM gzcb_t,gzcbl_t
#               WHERE gzcb002 = gzcbl002 
#                 AND gzcbl001 = '8502' 
#                 AND gzcbl003 = g_dlang
#                 AND gzcb002 = g_apca_d[l_ac].apca001_desc
#            LET g_apca_d[l_ac].apca001_desc = g_apca_d[l_ac].apca001_desc,":",l_apca001_desc
#-150326apo-mark--(e)
      END CASE          
      
    
      
      
      #150228
      #apcald,apca004,apca100决定一次期初、期中、期末
      IF g_apca_d[l_ac].type <> '1' AND l_ac = 1 THEN
         LET g_apca_d[l_ac + 1].* = g_apca_d[l_ac].*
         LET g_apca_d[l_ac].type = 1
         LET g_apca_d[l_ac].pmab031 = NULL
         LET g_apca_d[l_ac].pmab031_desc = NULL
         LET g_apca_d[l_ac].apcadocdt = NULL
         LET g_apca_d[l_ac].apca001   = NULL
         LET g_apca_d[l_ac].apca001_desc = NULL   #150326apo  
         LET g_apca_d[l_ac].apcadocno = NULL
         LET g_apca_d[l_ac].apca108   = 0
         LET g_apca_d[l_ac].l_apca1081  = 0
         LET g_apca_d[l_ac].l_apca1082  = 0
         LET g_apca_d[l_ac].apca118   = 0
         LET g_apca_d[l_ac].l_apca1181  = 0
         LET g_apca_d[l_ac].l_apca1182  = 0
         LET g_apca_d[l_ac].type = cl_getmsg('aap-00326',g_dlang)
        # LET g_apca_d[l_ac].apcacomp_desc = s_desc_get_department_desc(g_apca_d[l_ac].apcacomp) #160414-00018#39
        # LET g_apca_d[l_ac].apcald_desc   = s_desc_get_ld_desc(g_apca_d[l_ac].apcald)           #160414-00018#39
         #帳款對象
        # LET g_apca_d[l_ac].apca004_desc  = s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004) #160414-00018#39
         #科目名稱                           
        # LET g_apca_d[l_ac].apca035_desc = s_desc_get_account_desc(g_apca_d[l_ac].apcald,g_apca_d[l_ac].apca035) #160414-00018#39
         LET g_apca_d[l_ac].apca038 = NULL
         LET g_apca_d[l_ac].apca066 = NULL
         LET l_ac = l_ac + 1
      END IF
      
      IF g_apca_d[l_ac].apcald = l_apcald AND g_apca_d[l_ac].apca004 = l_apca004 AND (g_apca_d[l_ac].apca100 = l_apca100 OR g_apca_d[l_ac].apca100 IS NULL) THEN
         IF g_apca_d[l_ac].type <> '3' THEN
            LET l_apcc108 = l_apcc108 + g_apca_d[l_ac].l_apca1082
            LET g_apca_d[l_ac].l_apca1082 = l_apcc108

            LET l_apcc118 = l_apcc118 + g_apca_d[l_ac].l_apca1182
            LET g_apca_d[l_ac].l_apca1182 = l_apcc118
         END IF
      ELSE
         LET g_apca_d[l_ac + 1].* = g_apca_d[l_ac].*
         LET g_apca_d[l_ac].type = 3
         LET g_apca_d[l_ac].apcadocdt    = NULL
         LET g_apca_d[l_ac].apca001 = NULL   #150326apo
         LET g_apca_d[l_ac].apca001_desc = NULL
         LET g_apca_d[l_ac].pmab031 = NULL
         LET g_apca_d[l_ac].pmab031_desc = NULL
         LET g_apca_d[l_ac].apca035   = NULL
         LET g_apca_d[l_ac].apca035_desc = NULL 
         LET g_apca_d[l_ac].apca038 = NULL
         LET g_apca_d[l_ac].apca066 = NULL
         LET g_apca_d[l_ac].apcadocno = NULL
         LET g_apca_d[l_ac].apcald    = l_apcald
         LET g_apca_d[l_ac].apca004   = l_apca004
         LET g_apca_d[l_ac].apcacomp = g_apca_d[l_ac-1].apcacomp
         LET g_apca_d[l_ac].apcacomp_desc = s_desc_get_department_desc(g_apca_d[l_ac].apcacomp)            #160722-00002#1
         LET g_apca_d[l_ac].apcald_desc   = s_desc_get_ld_desc(g_apca_d[l_ac].apcald)                      #160722-00002#1
         LET g_apca_d[l_ac].apca004 =  g_apca_d[l_ac-1].apca004        
         LET g_apca_d[l_ac].apca004_desc  = s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004)   #160722-00002#1
         LET g_apca_d[l_ac].apca100   = l_apca100
         LET g_apca_d[l_ac].apca108   = 0
         LET g_apca_d[l_ac].l_apca1081  = 0
         LET g_apca_d[l_ac].l_apca1082  = g_apca_d[l_ac - 1].l_apca1082
         LET g_apca_d[l_ac].apca118   = 0
         LET g_apca_d[l_ac].l_apca1181  = 0
         LET g_apca_d[l_ac].l_apca1182  = g_apca_d[l_ac - 1].l_apca1182
         LET g_apca_d[l_ac].type = cl_getmsg('axr-00298',g_dlang)
         #LET g_apca_d[l_ac].apcacomp_desc = s_desc_get_department_desc(g_apca_d[l_ac].apcacomp) #160414-00018#39
         #LET g_apca_d[l_ac].apcald_desc   = s_desc_get_ld_desc(g_apca_d[l_ac].apcald)           #160414-00018#39
         #帳款對象
         #LET g_apca_d[l_ac].apca004_desc  = s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004) #160414-00018#39
         LET l_ac = l_ac + 1
         LET l_apcc108 = 0
         LET l_apcc118 = 0

         #albireo 150227-----s
         IF g_apca_d[l_ac].type = '1' THEN
            LET l_apcc108 = g_apca_d[l_ac].l_apca1082
            LET l_apcc118 = g_apca_d[l_ac].l_apca1182  
         END IF
         #albireo 150227-----e

         IF g_apca_d[l_ac].type <> '1' THEN
            LET g_apca_d[l_ac + 1].* = g_apca_d[l_ac].*
            LET g_apca_d[l_ac].type = 1
            LET g_apca_d[l_ac].pmab031 = NULL
            LET g_apca_d[l_ac].pmab031_desc = NULL
            LET g_apca_d[l_ac].apcadocdt = NULL
            LET g_apca_d[l_ac].apca001 = NULL   #150326apo
            LET g_apca_d[l_ac].apca001_desc   = NULL
            LET g_apca_d[l_ac].apcadocno = NULL
            LET g_apca_d[l_ac].apca108   = 0
            LET g_apca_d[l_ac].l_apca1081  = 0
            LET g_apca_d[l_ac].l_apca1082  = 0
            LET g_apca_d[l_ac].apca118   = 0
            LET g_apca_d[l_ac].l_apca1181  = 0
            LET g_apca_d[l_ac].l_apca1182  = 0
            LET g_apca_d[l_ac].type = cl_getmsg('aap-00326',g_dlang)
            #LET g_apca_d[l_ac].apcacomp_desc = s_desc_get_department_desc(g_apca_d[l_ac].apcacomp) #160414-00018#39
            #LET g_apca_d[l_ac].apcald_desc   = s_desc_get_ld_desc(g_apca_d[l_ac].apcald)           #160414-00018#39
            #帳款對象
            #LET g_apca_d[l_ac].apca004_desc  = s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004) #160414-00018#39
            #科目名稱                           
       　　 #LET g_apca_d[l_ac].apca035_desc = s_desc_get_account_desc(g_apca_d[l_ac].apcald,g_apca_d[l_ac].apca035) #160414-00018#39
            LET g_apca_d[l_ac].apca038 = NULL
            LET g_apca_d[l_ac].apca066 = NULL
            LET l_ac = l_ac + 1
            #150214--(s)
            LET l_apcc108 = l_apcc108 + g_apca_d[l_ac].apca108-g_apca_d[l_ac].l_apca1081    #150214  #albireo 150227 +l_apca1081 -> -l_apca1081
            LET g_apca_d[l_ac].l_apca1082 = l_apcc108

            LET l_apcc118 = l_apcc118 + g_apca_d[l_ac].apca118-g_apca_d[l_ac].l_apca1181    #150214  #albireo 150227 +l_apca1181 -> -l_apca1181
            LET g_apca_d[l_ac].l_apca1182 = l_apcc118
         END IF
         
       END IF
      
       #負責採購人員
       #160414-00018#39 ---s---
       #SELECT pmab031 INTO g_apca_d[l_ac].pmab031
       #  FROM pmab_t
       # WHERE pmabent  = g_enterprise
       #   AND pmabsite = g_apca_d[l_ac].apcacomp
       #   AND pmab001  = g_apca_d[l_ac].apca004
       #   
       #CALL s_desc_get_person_desc(g_apca_d[l_ac].pmab031)RETURNING g_apca_d[l_ac].pmab031_desc
       #160414-00018#39 ---e---
       #取得帳別相關資訊 根據是否啟用分錄底稿決定摘要
       CALL s_ld_sel_glaa(g_apca_d[l_Ac].apcald,'glaa121') RETURNING g_sub_success,l_glaa121 ##150302
       IF l_glaa121 = 'Y' AND g_apca_d[l_ac].apcald IS NOT NULL AND g_apca_d[l_ac].apcadocno IS NOT NULL THEN         
          FOREACH aapq911_cs8 USING g_apca_d[l_ac].apcald,g_apca_d[l_ac].apcadocno INTO g_apca_d[l_ac].apcb047
             IF NOT cl_null(g_apca_d[l_ac].apcb047) THEN EXIT FOREACH END IF
          END FOREACH
       ELSE
        #CASE g_apca_d[l_ac].apca001        #150409apo mark
         CASE g_apca_d[l_ac].apca001[1,1]   #150409apo
            WHEN '1'         #立沖apca0474
                FOREACH aapq911_cs7 USING g_apca_d[l_ac].apcald,g_apca_d[l_ac].apcadocno INTO g_apca_d[l_ac].apcb047
                   IF NOT cl_null(g_apca_d[l_ac].apcb047) THEN EXIT FOREACH END IF
                END FOREACH
            WHEN '2'         #沖帳apce010
               FOREACH aapq911_cs9 USING g_apca_d[l_ac].apcald,g_apca_d[l_ac].apcadocno INTO g_apca_d[l_ac].apcb047
                  IF NOT cl_null(g_apca_d[l_ac].apcb047) THEN EXIT FOREACH END IF
               END FOREACH
            WHEN '3'         #調匯xreh033
               FOREACH aapq911_cs10 USING g_apca_d[l_ac].apcald,g_apca_d[l_ac].apcadocno INTO g_apca_d[l_ac].apcb047
                  IF NOT cl_null(g_apca_d[l_ac].apcb047) THEN EXIT FOREACH END IF
               END　FOREACH                  
          END CASE
       END IF

      #LET g_apca_d[l_ac].apcacomp_desc = s_desc_get_department_desc(g_apca_d[l_ac].apcacomp) #160414-00018#39
      #LET g_apca_d[l_ac].apcald_desc   = s_desc_get_ld_desc(g_apca_d[l_ac].apcald)           #160414-00018#39
      #帳款對象
      #LET g_apca_d[l_ac].apca004_desc  = s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004)
      #科目名稱                           
      #LET g_apca_d[l_ac].apca035_desc = s_desc_get_account_desc(g_apca_d[l_ac].apcald,g_apca_d[l_ac].apca035)
      
      CASE g_apca_d[l_ac].type
         WHEN '1' #1.期初余额
            LET g_apca_d[l_ac].type = cl_getmsg('aap-00326',g_dlang)
         WHEN '2' #2.本期异动
            LET g_apca_d[l_ac].type = cl_getmsg('aap-00327',g_dlang)
         WHEN '3'   
            LET g_apca_d[l_ac].type = cl_getmsg('axr-00298',g_dlang)
         WHEN '9'
            LET g_apca_d[l_ac].type = cl_getmsg('aap-00328',g_dlang)
      END CASE

      LET l_apcald  = g_apca_d[l_ac].apcald
      LET l_apca004 = g_apca_d[l_ac].apca004
      LET l_apca100 = g_apca_d[l_ac].apca100
      
      LET g_tot_cnt = g_apca_d.getLength()
      #end add-point
 
      CALL aapq911_detail_show("'1'")      
 
      CALL aapq911_apca_t_mask()
 
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
   
 
   
   CALL g_apca_d.deleteElement(g_apca_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF l_ac > 1 THEN   #150226 albireo
      LET g_apca_d[l_ac].type = 3
      LET g_apca_d[l_ac].apcacomp = g_apca_d[l_ac-1].apcacomp
      LET g_apca_d[l_ac].apcadocdt = NULL
      LET g_apca_d[l_ac].apca001   = NULL
      LET g_apca_d[l_ac].apcadocno = NULL
      LET g_apca_d[l_ac].apcald    = l_apcald
      LET g_apca_d[l_ac].apca004   = l_apca004
      LET g_apca_d[l_ac].apcacomp_desc = s_desc_get_department_desc(g_apca_d[l_ac].apcacomp)            #160722-00002#1
      LET g_apca_d[l_ac].apcald_desc   = s_desc_get_ld_desc(g_apca_d[l_ac].apcald)                      #160722-00002#1              
      LET g_apca_d[l_ac].apca004_desc  = s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004)   #160722-00002#1
      LET g_apca_d[l_ac].apca100   = l_apca100
      LET g_apca_d[l_ac].apca108   = 0
      LET g_apca_d[l_ac].l_apca1081  = 0
      LET g_apca_d[l_ac].l_apca1082  = g_apca_d[l_ac - 1].l_apca1082
      LET g_apca_d[l_ac].apca118   = 0
      LET g_apca_d[l_ac].l_apca1181  = 0
      LET g_apca_d[l_ac].l_apca1182  = g_apca_d[l_ac - 1].l_apca1182
      LET g_apca_d[l_ac].type = cl_getmsg('axr-00298',g_dlang)
      #LET g_apca_d[l_ac].apcacomp_desc = s_desc_get_department_desc(g_apca_d[l_ac].apcacomp) #160414-00018#39
      #LET g_apca_d[l_ac].apcald_desc   = s_desc_get_ld_desc(g_apca_d[l_ac].apcald)           #160414-00018#39
      #帳款對象
      #LET g_apca_d[l_ac].apca004_desc  = s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004) #160414-00018#39
      #科目名稱                           
      #LET g_apca_d[l_ac].apca035_desc = s_desc_get_account_desc(g_apca_d[l_ac].apcald,g_apca_d[l_ac].apca035) #160414-00018#39
      LET g_apca_d[l_ac].apca038 = NULL
      LET g_apca_d[l_ac].apca066 = NULL
   END IF   #albireo 150227

   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #160414-00018#39 ---s---
   #150319-00004#8-----s
   #依畫面資料INSERT XG_tmp 
   #DELETE FROM aapq911_x01_tmp
   #CASE g_input.apcastus
   #   WHEN '1'
   #      SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
   #   WHEN '2'
   #      SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.2' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
   #   WHEN '3'
   #      SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.3' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
   #   WHEN '4'
   #      SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.4' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
   #END CASE  
   #FOR l_i = 1 TO g_apca_d.getLength()
   #   INITIALIZE l_x01_tmp.* TO NULL
   #   LET l_x01_tmp.apcasite_desc      = g_input.apcasite,':',g_input.apcasite_desc
   #   LET l_x01_tmp.l_sedate           = g_input.strdate,'~',g_input.enddate
   #   LET l_x01_tmp.curr               = g_input.curr
   #   LET l_x01_tmp.apcastus           = g_input.apcastus
   #   LET l_x01_tmp.l_apcastus_desc    = l_apcastus_desc
   #   LET l_x01_tmp.apcacomp           = g_apca_d[l_i].apcacomp 
   #   LET l_x01_tmp.apcacomp_desc      = g_apca_d[l_i].apcacomp_desc 
   #   LET l_x01_tmp.apcald             = g_apca_d[l_i].apcald 
   #   LET l_x01_tmp.apcald_desc        = g_apca_d[l_i].apcald_desc 
   #   LET l_x01_tmp.apca004            = g_apca_d[l_i].apca004 
   #   LET l_x01_tmp.apca004_desc       = g_apca_d[l_i].apca004_desc 
   #   LET l_x01_tmp.pmab031            = g_apca_d[l_i].pmab031 
   #   LET l_x01_tmp.pmab031_desc       = g_apca_d[l_i].pmab031_desc 
   #   LET l_x01_tmp.type               = g_apca_d[l_i].type 
   #   LET l_x01_tmp.apcadocdt          = g_apca_d[l_i].apcadocdt 
   #   LET l_x01_tmp.apca001            = g_apca_d[l_i].apca001 
   #   LET l_x01_tmp.apca001_desc       = g_apca_d[l_i].apca001_desc 
   #   LET l_x01_tmp.apcadocno          = g_apca_d[l_i].apcadocno 
   #   LET l_x01_tmp.apcb047            = g_apca_d[l_i].apcb047 
   #   LET l_x01_tmp.apca035            = g_apca_d[l_i].apca035 
   #   LET l_x01_tmp.apca035_desc       = g_apca_d[l_i].apca035_desc 
   #   LET l_x01_tmp.apca100            = g_apca_d[l_i].apca100 
   #   LET l_x01_tmp.apca108            = g_apca_d[l_i].apca108 
   #   LET l_x01_tmp.l_apca1081         = g_apca_d[l_i].l_apca1081 
   #   LET l_x01_tmp.l_apca1082         = g_apca_d[l_i].l_apca1082 
   #   LET l_x01_tmp.apca118            = g_apca_d[l_i].apca118 
   #   LET l_x01_tmp.l_apca1181         = g_apca_d[l_i].l_apca1181 
   #   LET l_x01_tmp.l_apca1182         = g_apca_d[l_i].l_apca1182
   #   LET l_x01_tmp.apca038            = g_apca_d[l_i].apca038   #150902-00001#5 
   #   LET l_x01_tmp.apca066            = g_apca_d[l_i].apca066   #150902-00001#5  
   #   INSERT INTO aapq911_x01_tmp VALUES(l_x01_tmp.*)
   #END FOR 
   #150319-00004#8-----e  
   #160414-00018#39 ---e---
   #end add-point
 
   LET g_detail_cnt = g_apca_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq911_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq911_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq911_detail_action_trans()
 
   IF g_apca_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq911_fetch()
   END IF
   
      CALL aapq911_filter_show('apcacomp','b_apcacomp')
   CALL aapq911_filter_show('apcald','b_apcald')
   CALL aapq911_filter_show('apca004','b_apca004')
   CALL aapq911_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq911_filter_show('apca001','b_apca001')
   CALL aapq911_filter_show('apcadocno','b_apcadocno')
   CALL aapq911_filter_show('apca035','b_apca035')
   CALL aapq911_filter_show('apca038','b_apca038')
   CALL aapq911_filter_show('apca066','b_apca066')
   CALL aapq911_filter_show('apca100','b_apca100')
   CALL aapq911_filter_show('apca108','b_apca108')
   CALL aapq911_filter_show('apca118','b_apca118')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq911.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq911_fetch()
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
 
{<section id="aapq911.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq911_detail_show(ps_page)
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
 
{<section id="aapq911.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq911_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_ld_str          STRING #161114-00017#2 add
   #161114-00017#2 --s add
   DEFINE l_ld              LIKE glaa_t.glaald
   DEFINE l_comp            LIKE ooef_t.ooef001
   #161114-00017#2 --e add   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   #161221-00050#1-----s
   CALL cl_set_comp_visible('b_apca001',TRUE)
   CALL cl_set_comp_visible('apca001_desc',FALSE)
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
      CONSTRUCT g_wc_filter ON apcacomp,apcald,apca004,apcadocdt,apca001,apcadocno,apca035,apca038,apca066, 
          apca100,apca108,apca118
                          FROM s_detail1[1].b_apcacomp,s_detail1[1].b_apcald,s_detail1[1].b_apca004, 
                              s_detail1[1].b_apcadocdt,s_detail1[1].b_apca001,s_detail1[1].b_apcadocno, 
                              s_detail1[1].b_apca035,s_detail1[1].b_apca038,s_detail1[1].b_apca066,s_detail1[1].b_apca100, 
                              s_detail1[1].b_apca108,s_detail1[1].b_apca118
 
         BEFORE CONSTRUCT
                     DISPLAY aapq911_filter_parser('apcacomp') TO s_detail1[1].b_apcacomp
            DISPLAY aapq911_filter_parser('apcald') TO s_detail1[1].b_apcald
            DISPLAY aapq911_filter_parser('apca004') TO s_detail1[1].b_apca004
            DISPLAY aapq911_filter_parser('apcadocdt') TO s_detail1[1].b_apcadocdt
            DISPLAY aapq911_filter_parser('apca001') TO s_detail1[1].b_apca001
            DISPLAY aapq911_filter_parser('apcadocno') TO s_detail1[1].b_apcadocno
            DISPLAY aapq911_filter_parser('apca035') TO s_detail1[1].b_apca035
            DISPLAY aapq911_filter_parser('apca038') TO s_detail1[1].b_apca038
            DISPLAY aapq911_filter_parser('apca066') TO s_detail1[1].b_apca066
            DISPLAY aapq911_filter_parser('apca100') TO s_detail1[1].b_apca100
            DISPLAY aapq911_filter_parser('apca108') TO s_detail1[1].b_apca108
            DISPLAY aapq911_filter_parser('apca118') TO s_detail1[1].b_apca118
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_apcacomp>>----
         #Ctrlp:construct.c.filter.page1.b_apcacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcacomp
            #add-point:ON ACTION controlp INFIELD b_apcacomp name="construct.c.filter.page1.b_apcacomp"
            
            #END add-point
 
 
         #----<<apcacomp_desc>>----
         #----<<b_apcald>>----
         #Ctrlp:construct.c.page1.b_apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcald
            #add-point:ON ACTION controlp INFIELD b_apcald name="construct.c.filter.page1.b_apcald"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160812-00027#2 --s add 
            LET g_qryparam.where = " glaald IN ",g_wc_apcald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept  
            #160812-00027#2 --e add 
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcald  #顯示到畫面上
            NEXT FIELD b_apcald                     #返回原欄位
    


            #END add-point
 
 
         #----<<apcald_desc>>----
         #----<<b_apca004>>----
         #Ctrlp:construct.c.page1.b_apca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca004
            #add-point:ON ACTION controlp INFIELD b_apca004 name="construct.c.filter.page1.b_apca004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160920-00019#2---s
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #160920-00019#2---e
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca004  #顯示到畫面上
            NEXT FIELD b_apca004                     #返回原欄位
    


            #END add-point
 
 
         #----<<apca004_desc>>----
         #----<<pmab031>>----
         #----<<pmab031_desc>>----
         #----<<b_type>>----
         #----<<b_apcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocdt
            #add-point:ON ACTION controlp INFIELD b_apcadocdt name="construct.c.filter.page1.b_apcadocdt"
            
            #END add-point
 
 
         #----<<b_apca001>>----
         #Ctrlp:construct.c.filter.page1.b_apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca001
            #add-point:ON ACTION controlp INFIELD b_apca001 name="construct.c.filter.page1.b_apca001"
            
            #END add-point
 
 
         #----<<apca001_desc>>----
         #----<<b_apcadocno>>----
         #Ctrlp:construct.c.page1.b_apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcadocno
            #add-point:ON ACTION controlp INFIELD b_apcadocno name="construct.c.filter.page1.b_apcadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE  
            #161114-00017#2 --s add            
            LET g_qryparam.where = " apcastus = 'Y' AND  apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",
                                   " AND apcacomp IN ", g_wc_apcacomp      
            #161114-00017#2 --e add
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcadocno  #顯示到畫面上
            NEXT FIELD b_apcadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<apcb047>>----
         #----<<b_apca035>>----
         #Ctrlp:construct.c.page1.b_apca035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca035
            #add-point:ON ACTION controlp INFIELD b_apca035 name="construct.c.filter.page1.b_apca035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161111-00042#2 --s add
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
			   LET l_comp = NULL
			   SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
			   LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glacent = gladent AND glad001= glac002 ",
                                   " AND gladld='",l_ld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"                              
            #161111-00042#2 --s add            
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca035  #顯示到畫面上
            NEXT FIELD b_apca035                     #返回原欄位
    


            #END add-point
 
 
         #----<<apca035_desc>>----
         #----<<b_apca038>>----
         #Ctrlp:construct.c.page1.b_apca038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca038
            #add-point:ON ACTION controlp INFIELD b_apca038 name="construct.c.filter.page1.b_apca038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_apca038()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca038  #顯示到畫面上
            NEXT FIELD b_apca038                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apca066>>----
         #Ctrlp:construct.c.filter.page1.b_apca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca066
            #add-point:ON ACTION controlp INFIELD b_apca066 name="construct.c.filter.page1.b_apca066"
            
            #END add-point
 
 
         #----<<b_apca100>>----
         #Ctrlp:construct.c.page1.b_apca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca100
            #add-point:ON ACTION controlp INFIELD b_apca100 name="construct.c.filter.page1.b_apca100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca100  #顯示到畫面上
            NEXT FIELD b_apca100                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apca108>>----
         #Ctrlp:construct.c.filter.page1.b_apca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca108
            #add-point:ON ACTION controlp INFIELD b_apca108 name="construct.c.filter.page1.b_apca108"
            
            #END add-point
 
 
         #----<<l_apca1081>>----
         #----<<l_apca1082>>----
         #----<<b_apca118>>----
         #Ctrlp:construct.c.filter.page1.b_apca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca118
            #add-point:ON ACTION controlp INFIELD b_apca118 name="construct.c.filter.page1.b_apca118"
            
            #END add-point
 
 
         #----<<l_apca1181>>----
         #----<<l_apca1182>>----
   
 
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
   
      CALL aapq911_filter_show('apcacomp','b_apcacomp')
   CALL aapq911_filter_show('apcald','b_apcald')
   CALL aapq911_filter_show('apca004','b_apca004')
   CALL aapq911_filter_show('apcadocdt','b_apcadocdt')
   CALL aapq911_filter_show('apca001','b_apca001')
   CALL aapq911_filter_show('apcadocno','b_apcadocno')
   CALL aapq911_filter_show('apca035','b_apca035')
   CALL aapq911_filter_show('apca038','b_apca038')
   CALL aapq911_filter_show('apca066','b_apca066')
   CALL aapq911_filter_show('apca100','b_apca100')
   CALL aapq911_filter_show('apca108','b_apca108')
   CALL aapq911_filter_show('apca118','b_apca118')
 
    
   CALL aapq911_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq911.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq911_filter_parser(ps_field)
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
 
{<section id="aapq911.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq911_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq911_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq911.insert" >}
#+ insert
PRIVATE FUNCTION aapq911_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq911.modify" >}
#+ modify
PRIVATE FUNCTION aapq911_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq911.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq911_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq911.delete" >}
#+ delete
PRIVATE FUNCTION aapq911_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq911.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq911_detail_action_trans()
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
 
{<section id="aapq911.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq911_detail_index_setting()
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
            IF g_apca_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apca_d.getLength() AND g_apca_d.getLength() > 0
            LET g_detail_idx = g_apca_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apca_d.getLength() THEN
               LET g_detail_idx = g_apca_d.getLength()
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
 
{<section id="aapq911.mask_functions" >}
 &include "erp/aap/aapq911_mask.4gl"
 
{</section>}
 
{<section id="aapq911.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 創建臨時表
# Memo...........:
# Usage..........: CALL aapq911_create_tmp()
# Date & Author..: 2015/01/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq911_create_tmp()
   DROP TABLE aapq911_tmp;
   CREATE TEMP TABLE aapq911_tmp(
      apcacomp   VARCHAR(10),       
      apcald     VARCHAR(5), 
      apca004    VARCHAR(10),
      type       VARCHAR(500), 
      apcadocdt  DATE, 
      apca001    VARCHAR(10), 
      apcadocno  VARCHAR(20), 
      apca035    VARCHAR(24), 
      apca100    VARCHAR(10), 
      apca108    DECIMAL(20,6), 
      apca1081   VARCHAR(500), 
      apca1082   VARCHAR(500), 
      apca118    DECIMAL(20,6), 
      apca1181   VARCHAR(500), 
      apca1182   VARCHAR(500),
      apcaent    SMALLINT,
      source     SMALLINT,            #150228(1立帳 2沖帳 3調匯)
      apca038    VARCHAR(20),      #傳票號碼   #150902-00001#5
      apca066    VARCHAR(20)     #發票號碼   #150902-00001#5
         )
    
    
   #150319-00004#8-----s      
   #建立臨時表     
   DROP TABLE aapq911_x01_tmp;
   CREATE TEMP TABLE aapq911_x01_tmp(
      apcasite            VARCHAR(10),
      apcasite_desc       VARCHAR(100),
      l_sedate            VARCHAR(500),
      strdate             DATE,
      enddate             DATE,
      curr                VARCHAR(1),
      apcastus            VARCHAR(1),
      l_apcastus_desc     VARCHAR(500),
      apcacomp            VARCHAR(10), 
      apcacomp_desc       VARCHAR(500), 
      apcald              VARCHAR(5), 
      apcald_desc         VARCHAR(500), 
      apca004             VARCHAR(10), 
      apca004_desc        VARCHAR(500), 
      pmab031             VARCHAR(20), 
      pmab031_desc        VARCHAR(500), 
      l_type              VARCHAR(500), 
      apcadocdt           DATE, 
      apca001             VARCHAR(10), 
      apca001_desc        VARCHAR(500), 
      apcadocno           VARCHAR(20), 
      apcb047             VARCHAR(500), 
      apca035             VARCHAR(24), 
      apca035_desc        VARCHAR(500), 
      aapa038             VARCHAR(20),      #150902-00001#5 
      apca066             VARCHAR(20),      #150902-00001#5 
      apca100             VARCHAR(10), 
      apca108             DECIMAL(20,6), 
      l_apca1081          DECIMAL(20,6), 
      l_apca1082          DECIMAL(20,6), 
      apca118             DECIMAL(20,6), 
      l_apca1181          DECIMAL(20,6), 
      l_apca1182          DECIMAL(20,6)
   )
   #150319-00004#8-----e
    
END FUNCTION

################################################################################
# Descriptions...: 輸入臨時表
# Memo...........:
# Usage..........: CALL aapq911_insert_tmp()
# Date & Author..: 2015/01/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq911_insert_tmp()
DEFINE l_glaa003    LIKE glaa_t.glaa003
DEFINE l_apcacomp   LIKE apca_t.apcacomp
DEFINE l_apcald     LIKE apca_t.apcald
DEFINE l_year       LIKE xrea_t.xrea001
DEFINE l_mon        LIKE xrea_t.xrea002
DEFINE l_preyear    LIKE xrea_t.xrea001 #上期年
DEFINE l_premon     LIKE xrea_t.xrea002 #上期月
DEFINE l_ld         LIKE glaa_t.glaald 
DEFINE l_apcastus   STRING
DEFINE l_apcastus1  STRING                #150401-00001#14
DEFINE l_xrdastus   STRING
DEFINE l_apdastus   STRING
DEFINE l_xrea100    LIKE type_t.chr100    #151225-00001#1 放大欄位
DEFINE l_apca100    LIKE apca_t.apca100
DEFINE l_apca1001   STRING                #150401-00001#14
DEFINE l_apce100    LIKE apce_t.apce100
DEFINE l_xrce100    LIKE xrce_t.xrce100
#albireo 150227-----s
DEFINE l_nowyear    LIKE xrea_t.xrea001
DEFINE l_nowmon     LIKE xrea_t.xrea002
#albireo 150227-----e
DEFINE l_apca035      STRING                 #161208-00002#1
DEFINE l_s_fin_2002    LIKE type_t.chr1       #161208-00002#1             
   
   #取得所屬法人+帳別
   CALL s_fin_orga_get_comp_ld(g_input.apcasite) RETURNING g_sub_success,g_errno,l_apcacomp,l_apcald 
   #取得會計參照表號    
   CALL s_ld_sel_glaa(l_apcald,'glaa003') RETURNING g_sub_success,l_glaa003   
   #取上期會計年月
   IF cl_null(g_year) THEN
      LET l_year = YEAR(g_input.strdate)
      LET l_mon  = MONTH(g_input.strdate)
      CALL s_fin_date_get_last_period(l_glaa003,l_apcald,l_year,l_mon)
                        RETURNING g_sub_success,l_preyear,l_premon
   ELSE
      #aapq910上期月份
       CALL s_ld_sel_glaa(g_ld,'glaa003') RETURNING g_sub_success,l_glaa003 
      CALL s_fin_date_get_last_period(l_glaa003,l_apcald,g_year,g_strmon)
                        RETURNING g_sub_success,l_preyear,l_premon               
   END IF     
   
   
   #albireo 150227-----s
   CALL s_fin_date_get_period_value(l_glaa003,l_apcald,g_input.strdate) 
                     RETURNING g_sub_success,l_nowyear,l_nowmon
   #albireo 150227-----e
   
   #161208-00002#1---s---
   CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2002') RETURNING l_s_fin_2002
   IF l_s_fin_2002 = '3' THEN
      LET l_apca035 = 'apcb029' 
   ELSE
      LET l_apca035 = 'apca035' 
   END IF
   #161208-00002#1---e---
   
   #狀態碼 apcastus
   CASE g_input.apcastus    
      WHEN '1' 
         LET l_apcastus = " apcastus = 'Y' "
         LET l_apcastus1= " a.apcastus = 'Y' "     #150401-00001#14
         LET l_xrdastus = " xrdastus = 'Y' "
         LET l_apdastus = " apdastus = 'Y' "
      WHEN '2' #已審核以拋傳票
         LET l_apcastus = " apcastus = 'Y' AND apca037 = 'Y' " 
         LET l_apcastus1= " a.apcastus = 'Y' AND a.apca037 = 'Y' "         #150401-00001#14
         LET l_xrdastus = " xrdastus = 'Y' AND xrda014 IS NOT NULL " 
         LET l_apdastus = " apdastus = 'Y' AND apda014 IS NOT NULL " 
      WHEN '3'  
         LET l_apcastus = " apcastus = 'N' "
         LET l_apcastus = " a.apcastus = 'N' "
         LET l_xrdastus = " xrdastus = 'N' "
         LET l_apdastus = " apdastus = 'N' "
      WHEN '4'
         LET l_apcastus = " apcastus IN ('N','Y','X','A','D','R','W') "
         LET l_apcastus1= " a.apcastus IN ('N','Y','X','A','D','R','W') "  #150401-00001#14
         LET l_xrdastus = " xrdastus IN ('N','Y','X','A','D','R','W') "
         LET l_apdastus = " apdastus IN ('N','Y','X','A','D','R','W') "
   END CASE
   #是否顯示原幣 
   IF g_input.curr = 'Y' THEN
      LET l_xrea100 = 'xrea100'
      LET l_apca100 = 'apca100'
      LET l_apca1001= 'a.apca100'      #150401-00001#14
      LET l_apce100 = 'apce100'
      LET l_xrce100 = 'xrce100' 
   ELSE
      LET l_xrea100 = "''"
      LET l_apca100 = "''"
      LET l_apca1001= "''"             #150401-00001#14
      LET l_apce100 = "''"
      LET l_xrce100 = "''"       
   END IF 
   
   #151225-00001#1  add carolwu 
   IF s_chr_get_index_of(g_wc,'apca035','1') <> 0 THEN
      LET l_xrea100 = "xrea019,",l_xrea100
   ELSE
      LET l_xrea100 = "'',",l_xrea100
   END IF
  #151225-00001#1  end carolwu

   DELETE FROM aapq911_tmp
   #期末餘額 = 本期增加 - 本期減少
   #期末餘額 金額CASE xrea004 link 2% OR IN (02,04) THEN 金額＊－１)  #待抵單以負數值呈現      
   LET g_sql = "   INSERT INTO aapq911_tmp                              ",
               "   SELECT xreacomp ,xreald,xrea009,1            ,'',    ",  
              #151225-00001#1 carolwu 減少一組xrea019
               "           ''       ,''    ,",l_xrea100,",       ", 
               "          0,0,SUM(a),                             ",
               "          0,0,SUM(b),xreaent,0,'',''                      ",  #150228
              #151225-00001#1 增加xrea019
               "      FROM ( SELECT xreacomp ,xreald ,xrea009,1 ,xrea004,xrea019,          ",
               "                    xrea001  ,xrea002,xrea100   ,xrea005,xrea003,xreaent,  ",
               "                    CASE WHEN (xrea004 = '04' OR xrea004 = '02' OR xrea004 LIKE '2%') THEN xrea103*-1 ELSE  xrea103 END a,   ",                    
               "                    CASE WHEN (xrea004 = '04' OR xrea004 = '02' OR xrea004 LIKE '2%') THEN ", # xrea113*-1 ELSE  xrea113 END b    ", #170124-00013#4 maxk 
               #170124-00013#4 --add--s---
               "              (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AP' ) ='2' ",
               "               THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
               "                AND xreb003 = 'AP' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END )*-1 ",
               "                    ELSE   ",
               "               (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AP') ='2' ",
               "               THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
               "                AND xreb003 = 'AP' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) END b    ",   
               #170124-00013#4 --add--e---                     
                              "               FROM xrea_t WHERE xreaent = '",g_enterprise,"' AND xrea003='AP' ",
               "      AND xrea001 = '",l_preyear,"'               ",
               "      AND xrea002 = '",l_premon,"'                ",    
               "      AND xreald IN ",g_wc_apcald CLIPPED,        
		" )",  #151225-00001#1 move by carolwu  括移到後面 
             #  "    WHERE xrea001 = '",l_preyear,"'               ",
             #  "      AND xrea002 = '",l_premon,"'                ",    
             #  "      AND xreald IN ",g_wc_apcald CLIPPED,        
             #  "      AND xrea003 = 'AP'                          ",
               "    GROUP BY xreacomp,xreald,xrea009,",l_xrea100,",xreaent "                                                       
   PREPARE aapq911_tmp_pre01 FROM g_sql
   EXECUTE aapq911_tmp_pre01        
   #增加數apca 期間立帳
   #立帳本期減少 = 0 --> 本期增加 - 0 = 本期減少
   LET g_sql = "   INSERT INTO aapq911_tmp                               ",
               "   SELECT apcacomp,apcald   ,apca004,2,apcadocdt,        ",
               #"          apca001,apcadocno,apca035,",l_apca100,",       ",  #161208-00002#1
               "          apca001,apcadocno, ",l_apca035,",",l_apca100,",",    #161208-00002#1
               "          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc108*-1 ELSE apcc108 END),apca107,  ",
              #"          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc108*-1 ELSE apcc108 END),     ",         #150326apo mark
               "          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN apcc108*-1 ELSE apcc108 END)-apca107,     ", #150326apo 
              #"          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (apcc118+apcc113)*-1 ELSE (apcc118+apcc113) END),apca117, ",   #150327apo mark
               "          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (apcc118)*-1 ELSE (apcc118) END),apca117, ",                   #150327apo 
              #"          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (apcc118+apcc113)*-1 ELSE (apcc118+apcc113) END),   ",         #150326apo mark
              #"          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (apcc118+apcc113)*-1 ELSE (apcc118+apcc113)-apca117 END),   ", #150327apo mark  #150326apo
               "          SUM(CASE WHEN (apca001 ='02' OR apca001 = '04' OR apca001 LIKE '2%') THEN (apcc118)*-1 ELSE (apcc118) END)-apca117,   ", #150327apo  #151208
               "          apcaent,1                                                         ",   #150228
               "          ,apca038,apca066                                                  ",   #150902-00001#5
              #"     FROM apca_t,apcc_t                                                     ",   #161208-00002#1 
               "     FROM apca_t a,apcb_t,apcc_t                                            ",   #161208-00002#1 
               "    WHERE apcaent = apcbent     AND apcaent = apccent     AND apcaent = '",g_enterprise,"' ",  #161208-00002#1
               "      AND apcadocno = apcbdocno AND apcadocno = apccdocno AND apcbseq = apccseq            ",  #161208-00002#1              
              "       AND apcald    = apcbld    AND apcald = apccld                         ",                 #161208-00002#1
              #"    WHERE apcaent = apccent AND apcaent = '",g_enterprise,"'                ",                 #161208-00002#1
               #"      AND apcadocno = apccdocno AND apcald = apccld                        ",                 #161208-00002#1
               "      AND ",l_apcastus CLIPPED , 
               "      AND apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",                             
               "      AND apcald IN ",g_wc_apcald CLIPPED ,
               #"   GROUP BY apcacomp,apcald,apca004,apcadocdt,apca001,apcadocno,apca035,",l_apca100,",apcaent,apca107,apca117"                             
               #"   GROUP BY apcacomp,apcald,apca004,apcadocdt,apca001,apcadocno,apca035,",l_apca100,",apcaent,apca107,apca117,apca038,apca066  "         #150902-00001#5    #161208-00002#1 mark    
                "   GROUP BY apcacomp,apcald,apca004,apcadocdt,apca001,apcadocno,",l_apca035,",",l_apca100,",apcaent,apca107,apca117,apca038,apca066  "   #161208-00002#1 add
   PREPARE aapq911_tmp_pre02 FROM g_sql
   EXECUTE aapq911_tmp_pre02        
   #減少數apce 期間有被[AP]付款沖帳的帳款單者
   #本期增加 = 0 --> 0 - 本期減少 = 期末餘額
   LET g_sql = "   INSERT INTO aapq911_tmp                               ",
              #"   SELECT apcecomp,apceld   ,apce038,2,apdadocdt,        ",   #1504147apo mark
               "   SELECT apcecomp,apceld   ,apda005,2,apdadocdt,        ",   #1504147apo
              #"          apda001      ,apce003,apce016,",l_apce100,",   ",   #150326apo mark
              #"          apce002      ,apce003,apce016,",l_apce100,",   ",   #150409apo mark   #150326apo 
               "          apda001      ,apdadocno,apce016,",l_apce100,",   ", #150409apo
               "          0,SUM(CASE WHEN apce015 ='C' THEN apce109 * -1 ELSE apce109 END),      ",
               "          (0-SUM(CASE WHEN apce015 ='C' THEN apce109 * -1 ELSE apce109 END)),    ",
               "          0,SUM(CASE WHEN apce015 ='C' THEN apce119 * -1 ELSE apce119 END),      ",
               "          (0 - SUM(CASE WHEN apce015 ='C' THEN apce119 * -1 ELSE apce119 END)) , ",
              #"          apdaent,2                                                                ",  #150409apo mark  #150228
               "          apdaent,21                                                             ",  #150409apo
               #"          ,apce029,apce048                                                       ",  #150902-00001#5   #170220-00040#1 mark
               "          ,apda014,apce048                                                       ",                     #170220-00040#1 add
               "     FROM apda_t,apce_t                                                          ",
               "    WHERE apdaent = apceent AND apceent = '",g_enterprise,"'                     ",
               "      AND apdadocno = apcedocno AND apdald = apceld                              ",
               "      AND ",l_apdastus CLIPPED ,                                                 
               "      AND apdadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'     ",                             
               "      AND apceld IN ",g_wc_apcald CLIPPED,
               #-150331apo--(s)
               #150331 carol:來源為aapt430之沖銷紀錄(apda_t+apce_t),帳款單性質1*的要排除, 2*不排除(原因為aapt430只會回寫性質為2*之apcc)
               "      AND NOT ( apce001='aapt430' AND EXISTS(SELECT 1 FROM apca_t ",
               "                                              WHERE apcaent = apceent ",
               "                                                AND apcadocno = apce003 ",
               "                                                AND apcald = apceld ",
               "                                                AND apca001 LIKE '1%')) ",
               #-150331apo--(e)                     
               "      AND apce002 LIKE '4%' ",    #albireo 150227
              #"    GROUP BY apda001,apcecomp,apceld,apce038,apdadocdt,apce003,apce016,",l_apce100,",apdaent  "     #150326apo mark
              #"    GROUP BY apce002,apcecomp,apceld,apce038,apdadocdt,apce003,apce016,",l_apce100,",apdaent  "     #150409apo mark  #150326apo          
              #"    GROUP BY apda001,apcecomp,apceld,apce038,apdadocdt,apdadocno,apce016,",l_apce100,",apdaent  "   #150414apo mark  #150409apo 
              #"    GROUP BY apda001,apcecomp,apceld,apda005,apdadocdt,apdadocno,apce016,",l_apce100,",apdaent  "   #150414apo
              #"    GROUP BY apda001,apcecomp,apceld,apda005,apdadocdt,apdadocno,apce016,",l_apce100,",apdaent,apce029,apce048   "    #150902-00001#5   #170220-00040#1 mark
               "    GROUP BY apda001,apcecomp,apceld,apda005,apdadocdt,apdadocno,apce016,",l_apce100,",apdaent,apda014,apce048   "                      #170220-00040#1 add
   PREPARE aapq911_tmp_pre03 FROM g_sql
   EXECUTE aapq911_tmp_pre03   
   LET g_sql =   "   INSERT INTO aapq911_tmp                               ",
                #"   SELECT apcecomp,apceld   ,apce038,2,apcadocdt,        ",   #150414apo mark
                 "   SELECT apcecomp,apceld   ,apca004,2,apcadocdt,        ",   #150414apo
                #"          apca001      ,apce003,apce016,",l_apce100,",   ",   #150326apo mark
                 "          apce002      ,apce003,apce016,",l_apce100,",   ",   #150326apo
                 "          0,SUM(CASE WHEN apce015 ='C' THEN apce109 * -1 ELSE apce109 END),      ",
                 "          (0-SUM(CASE WHEN apce015 ='C' THEN apce109 * -1 ELSE apce109 END)),    ",
                 "          0,SUM(CASE WHEN apce015 ='C' THEN apce119 * -1 ELSE apce119 END),      ",
                 "          (0 - SUM(CASE WHEN apce015 ='C' THEN apce119 * -1 ELSE apce119 END)) , ",
                 "          apcaent,2                                                                ", #150228
                 "          ,apce029,apce048                                                       ",  #150902-00001#5
                 "     FROM apca_t,apce_t                                                          ",
                 "    WHERE apcaent = apceent AND apceent = '",g_enterprise,"'                     ",
                 "      AND apcadocno = apcedocno AND apcald = apceld                              ",
                 "      AND ",l_apcastus CLIPPED ,                                                 
                 "      AND apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'     ",                             
                 "      AND apceld IN ",g_wc_apcald CLIPPED,
                 "      AND apce002 LIKE '4%' ",    #albireo 150227
                #"    GROUP BY apca001,apcecomp,apceld,apce038,apcadocdt,apce003,apce016,",l_apce100,",apcaent  "   #150326apo mark
                #"    GROUP BY apce002,apcecomp,apceld,apce038,apcadocdt,apce003,apce016,",l_apce100,",apcaent  "   #150414apo mark  #150326apo     
                #"    GROUP BY apce002,apcecomp,apceld,apca004,apcadocdt,apce003,apce016,",l_apce100,",apcaent  "   #150414apo mark  #150326apo           
                 "    GROUP BY apce002,apcecomp,apceld,apca004,apcadocdt,apce003,apce016,",l_apce100,",apcaent,apce029,apce048   "   #150902-00001#5
     PREPARE aapq911_tmp_pre031 FROM g_sql
     EXECUTE aapq911_tmp_pre031 
     
     #減少apcf 期間有被沖暫估(apcf_t)的帳款單者
   #本期增加 = 0 --> 0 - 本期減少 = 期末餘額   
   ##150401-00001#14--MARK--(S)
   #LET g_sql = "   INSERT INTO aapq911_tmp                               ",
   #            "   SELECT apcacomp,apcald   ,apca004,2,apcadocdt,        ",
   #            "          apca001,apcf008,apcf021   ,",l_apca100,",      ",
   #            "          0,SUM(CASE WHEN (apca001 ='02' OR apca001= '04') THEN apcf105 * -1 ELSE apcf105 END),  ",
   #            "          (0-SUM(CASE WHEN (apca001 ='02' OR apca001= '04') THEN apcf105 * -1 ELSE apcf105 END)),",
   #            "          0,SUM(CASE WHEN (apca001 ='02' OR apca001= '04') THEN apcf115 * -1 ELSE apcf115 END),  ",
   #            "          (0-SUM(CASE WHEN (apca001 ='02' OR apca001= '04') THEN apcf115 * -1 ELSE apcf115 END)),",
   #            "          apcaent,1                                                                     ", #150228
   #            "     FROM apcf_t,apca_t                                                                 ", 
   #            "    WHERE apcfent = apcaent AND apcfent = '",g_enterprise,"'                            ",
   #            "      AND apcadocno = apcfdocno AND apcald = apcfld   AND apcf008 != 'DIFF'             ",
   #            "      AND apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'             ", 
#  #             "      AND apcfdocno IN                                                                  ",
#  #             "            (SELECT apcadocno FROM apca_t WHERE apcaent = '",g_enterprise,"'            ",
#  #             "                AND apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'   ", 
#  #             "                AND apcald IN ",g_wc_apcald CLIPPED,")",                                                                   
   #            "      AND ",l_apcastus CLIPPED , 
#  #             "      AND apcf008 = apcadocno                         ",                                        
   #            "      AND apcfld IN ",g_wc_apcald CLIPPED,         
   #            "    GROUP BY apcacomp,apcald,apca004,apcadocdt,apca001,apcf008,apcf021,apcf024,",l_apca100,",apcaent "                             
   ##150401-00001#14--MARK--(E)
   ##150401-00001#14--(S)--增加取得apcf對應的帳款單性質/來判斷正負向位置
   LET g_sql = "   INSERT INTO aapq911_tmp",
               "   SELECT a.apcacomp,a.apcald   ,a.apca004,2,a.apcadocdt, ",
               "          b.apca001,apcf008,apcf021   ,",l_apca1001,",    ",
               "           0,SUM(CASE WHEN (b.apca001 ='02' OR b.apca001= '04') THEN apcf105 * -1 ELSE apcf105 END), ",
               "          (0-SUM(CASE WHEN (b.apca001 ='02' OR b.apca001= '04') THEN apcf105 * -1 ELSE apcf105 END)),",
               "           0,SUM(CASE WHEN (b.apca001 ='02' OR b.apca001= '04') THEN apcf115 * -1 ELSE apcf115 END), ",
               "          (0-SUM(CASE WHEN (b.apca001 ='02' OR b.apca001= '04') THEN apcf115 * -1 ELSE apcf115 END)),",
               "          a.apcaent,1      ",
               "          ,a.apca038,a.apca066                                                       ",  #150902-00001#5
               "     FROM apcf_t,apca_t b,apca_t a    ", 
               "    WHERE a.apcaent = apcfent AND apcfent = '",g_enterprise,"'",
               "      AND a.apcald = apcfld   AND a.apcadocno = apcfdocno AND apcf008 != 'DIFF'",
               "      AND a.apcadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"'", 
               "      AND ",l_apcastus1 CLIPPED , 
               "      AND apcfld IN ",g_wc_apcald CLIPPED,         
               "      AND b.apcadocno = apcf008 AND b.apcald = apcfld AND b.apcaent = apcfent",
               "    GROUP BY a.apcacomp,a.apcald,a.apca004,a.apcadocdt,b.apca001,apcf008,apcf021,apcf024,",l_apca1001,",a.apcaent,a.apca038,a.apca066"   
   ##150401-00001#14--(E)
   PREPARE aapq911_tmp_pre04 FROM g_sql
   EXECUTE aapq911_tmp_pre04                
   #減少xrce 期間有被[AR]收款沖帳的帳款單者, 
   #本期增加 = 0 --> 0 - 本期減少 = 期末餘額   
   LET g_sql = "   INSERT INTO aapq911_tmp                               ",
               "   SELECT xrcecomp,xrceld   ,xrce038,2,xrdadocdt,        ",
               "          ''      ,xrcedocno,xrce016,",l_xrce100,",      ",
               "          0,SUM(CASE WHEN xrce015 ='C' THEN xrce109 * -1 ELSE xrce109 END),  ",
               "          (0-SUM(CASE WHEN xrce015 ='C' THEN xrce109 * -1 ELSE xrce109 END)),",
               "          0,SUM(CASE WHEN xrce015 ='C' THEN xrce119 * -1 ELSE xrce119 END),  ",
               "          (0-SUM(CASE WHEN xrce015 ='C' THEN xrce119 * -1 ELSE xrce119 END)),",
               "          xrceent,0                                                          ",     #150228
               "          ,xrce029,xrce054                                                   ",#150902-00001#5
               "     FROM xrce_t,xrda_t                                                      ",
               "    WHERE xrceent = xrdaent AND xrceent = '",g_enterprise,"'                 ",
               "      AND xrcedocno = xrdadocno AND xrceld = xrdald                          ",
               "      AND ",l_xrdastus CLIPPED ,
               "      AND xrdadocdt BETWEEN '",g_input.strdate,"' AND '",g_input.enddate,"' ",
               "      AND xrceld IN ",g_wc_apcald CLIPPED ,
               "      AND xrce002 like '4%'                                                 ",
               #"    GROUP BY xrcecomp,xrceld,xrce038,xrdadocdt,xrcedocno,xrce016,",l_xrce100,",xrceent"
               "    GROUP BY xrcecomp,xrceld,xrce038,xrdadocdt,xrcedocno,xrce016,",l_xrce100,",xrceent ,xrce029,xrce054" #150902-00001#5
   PREPARE aapq911_tmp_pre05 FROM g_sql
   EXECUTE aapq911_tmp_pre05    

   #albireo 150227-----s
   #取得調匯金額
   LET g_sql = "   INSERT INTO aapq911_tmp                                  ",
               #
               "   SELECT apcacomp,apcald   ,apca004,2,xregdocdt,           ",      #150228 apcadocdt >xregdocdt
              #"          apca001,xregdocno,apca035,",l_apca100,",          ",      #150407apo mark  #150228 apcadocno >xregdocno
              #"          'aapt920',xregdocno,apca035,",l_apca100,",          ",    #150407apo #161208-00002#1  mark
               "          'aapt920',xregdocno,",l_apca035,",",l_apca100,",  ",                 #161208-00002#1  add
               "          0,0,0,CASE WHEN xreh1151 < 0 THEN  0 ELSE xreh1151  END,",
               "          CASE WHEN xreh1151 < 0 THEN  xreh1151*-1 ELSE 0 END,xreh1151,apcaent,3                  ",#150228
               "         ,apca038,apca066                                                                         ",
               "     FROM(",
               #
               "   SELECT apcacomp,apcald   ,apca004,2,xregdocdt,           ",      #150228 apcadocdt >xregdocdt
              #"          apca001,xregdocno,apca035,",l_apca100,",          ",      #150407apo mark   #150228 apcadocno >xregdocno
              #"          'aapt920',xregdocno,apca035,",l_apca100,",        ",      #150407apo        #161208-00002#1  mark
               "          'aapt920',xregdocno,",l_apca035,",",l_apca100,",  ",                        #161208-00002#1  add
               "          SUM(xreh115) xreh1151,apcaent                     ",
               "          ,apca038,apca066                                  ",
              #"     FROM apca_t,xreg_t,xreh_t                              ",                         #161208-00002#1 mark
               "     FROM apca_t,apcb_t,xreg_t,xreh_t                       ",                         #161208-00002#1 mark
               "    WHERE apcaent = '",g_enterprise,"'                      ",                         
               "      AND apcald IN ",g_wc_apcald CLIPPED ,
               "      AND xregdocno = xrehdocno",
               "      AND xregld = xrehld",
               "      AND xregent = xrehent",
               "      AND xrehent = apcaent",
               "      AND xreg001 = '",l_nowyear,"'",
               "      AND xreg002 = '",l_nowmon,"'",
              #"      AND xreh008 < '",g_input.strdate,"'",    #150327apo mark
               "      AND xreh008 <='",g_input.enddate,"'",    #150327apo
               "      AND xreh005 = apcadocno",
               "      AND xreh005 = apcbdocno  AND xreh006 = apcbseq AND xrehld = apcbld ",  #161208-00002#1
               "      AND xregstus = 'Y'",
               "       AND xreg003 = 'AP'",
              #"   GROUP BY apcacomp,apcald,apca004,xregdocdt,apca001,xregdocno,apca035,",l_apca100,",apcaent)"    #150407apo mark     #150228 apcadoc
              #"   GROUP BY apcacomp,apcald,apca004,xregdocdt,xregdocno,apca035,",l_apca100,",apcaent)"            #150407apo
              #"    GROUP BY apcacomp,apcald,apca004,xregdocdt,xregdocno,apca035,",l_apca100,",apcaent,apca038,apca066)"  #150902-00001#5  #161208-00002#1 mark
               "    GROUP BY apcacomp,apcald,apca004,xregdocdt,xregdocno,",l_apca035,",",l_apca100,",apcaent,apca038,apca066)"  #150902-00001#5  #161208-00002#1 mark
   PREPARE aapq911_tmp_pre021 FROM g_sql
   EXECUTE aapq911_tmp_pre021 
   #albireo 150227-----e
END FUNCTION

################################################################################
# Descriptions...: 給予預設值
# Memo...........:
# Usage..........: CALL aapq911_default()
# Date & Author..: 2015/01/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq911_default()
   LET g_input.apcasite = g_site   
   LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)
   LET g_input.curr = 'Y' 
   CALL cl_set_comp_visible('b_apca100,b_apca108,l_apca1081,l_apca1082',TRUE)
   LET g_input.apcastus = '1'
   LET g_input.strdate = s_date_get_first_date(g_today) 
   LET g_input.enddate = g_today     
   CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')
   #取得帳務中心底下之組織範圍
   #CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite   #150127-00007#1 mark
   CALL s_fin_account_center_comp_str() RETURNING g_wc_apcacomp    #150127-00007#1 add
   CALL s_fin_get_wc_str(g_wc_apcacomp) RETURNING g_wc_apcacomp
   #取得帳務中心底下的帳套範圍   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   
   #161229-00047#36 add ------
   LET g_comp = ''
   SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.apcasite AND ooefstus = 'Y'
   CALL s_fin_get_wc_str(g_comp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#36 add end---
   
   DISPLAY BY NAME g_input.apcasite,g_input.curr,g_input.strdate,g_input.enddate,
                   g_input.apcasite_desc
END FUNCTION

################################################################################
# Descriptions...: 設置分頁
# Memo...........:
# Usage..........: CALL aapq911_set_page()
# Date & Author..: Hans By 2015/01/20
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq911_set_page()
DEFINE l_idx    LIKE type_t.num5
DEFINE l_sql    STRING
DEFINE l_ent    LIKE type_t.chr100

   #是否顯示原幣_分頁         
    IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   IF g_input.curr = 'Y' THEN
      CALL g_apca_d2.clear()
      LET l_sql="   SELECT DISTINCT apcaent ",
                "     FROM aapq911_tmp ",
                "    WHERE 1=1 "
      IF NOT cl_null(g_argv[1]) THEN
         LET l_sql = l_sql, "   AND apca100 = '",g_currency,"'  ",
                            "   AND apca004  = '",g_xrea009,"'  ",
                            "   AND apcald   = '",g_ld,"'       "
      END IF
      LET l_sql = l_sql CLIPPED," AND ", g_wc
      LET l_sql = l_sql," ORDER BY apcald,apca004,apca100 "      
     
      PREPARE aapq911_pr FROM l_sql 
      DECLARE aapq911_cr CURSOR FOR aapq911_pr      
      LET l_idx=1  
   
      FOREACH aapq911_cr INTO g_apca_d2[l_idx].apcaent 
         IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = 'FOREACH aapq911_cr'
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
        IF cl_null(g_apca_d2[l_idx].apcald) OR cl_null(g_apca_d2[l_idx].apca004) OR cl_null(g_apca_d2[l_idx].apca100) then
           CALL g_apca_d2.deleteElement(l_idx)
        ELSE
           LET l_idx=l_idx+1
        END IF        
        
      END FOREACH
   ELSE 
      CALL g_apca_d2.clear()
      LET l_sql="   SELECT DISTINCT apcaent  ", 
                "     FROM aapq911_tmp              ",
                "WHERE 1=1 "                 
      IF NOT cl_null(g_argv[1]) THEN
         LET l_sql = l_sql, "   AND apca004  = '",g_xrea009,"'  ",
                            "   AND apcald   = '",g_ld,"'         "
      END IF
      LET l_sql = l_sql CLIPPED , " AND ", g_wc
      LET l_sql = l_sql,"  ORDER BY apcald,apca004 "       
      PREPARE aapq911_pr2 FROM l_sql
      DECLARE aapq911_cr2 CURSOR FOR aapq911_pr2      
      LET l_idx=1  
      FOREACH aapq911_cr2 INTO g_apca_d2[l_idx].apcaent 
         IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = 'FOREACH aapq911_cr2'
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
        IF cl_null(g_apca_d2[l_idx].apcald) OR cl_null(g_apca_d2[l_idx].apca004)  then
           CALL g_apca_d2.deleteElement(l_idx)
        ELSE
           LET l_idx=l_idx+1
        END IF    
     END FOREACH
   END IF   
   
   LET l_idx=l_idx - 1
   CALL g_apca_d2.deleteElement(g_apca_d2.getLength())
   LET g_header_cnt = g_apca_d2.getLength()
   LET g_rec_b = l_idx   
   DISPLAY g_header_cnt TO FORMONLY.h_count    
     
      
   
END FUNCTION

################################################################################
# Descriptions...: 抓分頁取資料
# Memo...........:
# Usage..........: CALL aapq911_fetch1(p_flag)
# Input parameter: p_flag   第幾筆
# Date & Author..: 2015/01/20 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq911_fetch1(p_flag)
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

         IF g_jump > 0 AND g_jump <= g_apca_d2.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE
   #代表沒有資料
   IF g_current_idx = 0 OR g_apca_d2.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_apca_d2.getLength() THEN
      LET g_current_idx = g_apca_d2.getLength()
   END IF

   DISPLAY g_current_idx TO FORMONLY.h_index
#   IF NOT cl_null(g_argv[1]) THEN  
#      LET g_apcald  = g_ld   
#      LET g_apca004 = g_xrea009
#      LET g_apca100 = g_currency                       
#   ELSE            
#      LET g_apcald = g_apca_d2[g_current_idx].apcald
#      LET g_apca004 = g_apca_d2[g_current_idx].apca004
#      LET g_apca100 = g_apca_d2[g_current_idx].apca100
#   END IF
   CALL aapq911_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 報表用暫存檔
# Memo...........:
# Usage..........: CALL aapq911_ins_aapq911_x01()
# Date & Author..: 2016/04/28 By Hans
# Modify.........: #160414-00018#39 
################################################################################
PRIVATE FUNCTION aapq911_ins_aapq911_x01()
DEFINE l_i              LIKE type_t.num5
DEFINE l_apcastus_desc  LIKE type_t.chr500
DEFINE l_x01_tmp      RECORD
      apcasite           LIKE apca_t.apcasite,
      apcasite_desc      LIKE type_t.chr100,
      l_sedate           LIKE type_t.chr500,
      strdate            LIKE apca_t.apcadocdt,
      enddate            LIKE apca_t.apcadocdt,
      curr               LIKE type_t.chr1,
      apcastus           LIKE type_t.chr1,
      l_apcastus_desc    LIKE type_t.chr500,
      apcacomp           LIKE apca_t.apcacomp, 
      apcacomp_desc      LIKE type_t.chr500, 
      apcald             LIKE apca_t.apcald, 
      apcald_desc        LIKE type_t.chr500, 
      apca004            LIKE apca_t.apca004, 
      apca004_desc       LIKE type_t.chr500, 
      pmab031            LIKE type_t.chr20, 
      pmab031_desc       LIKE type_t.chr500, 
      type               LIKE type_t.chr500, 
      apcadocdt          LIKE apca_t.apcadocdt, 
      apca001            LIKE apca_t.apca001, 
      apca001_desc       LIKE type_t.chr500, 
      apcadocno          LIKE apca_t.apcadocno, 
      apcb047            LIKE type_t.chr500, 
      apca035            LIKE apca_t.apca035, 
      apca035_desc       LIKE type_t.chr500, 
      apca038            LIKE apca_t.apca038, 
      apca066            LIKE apca_t.apca066,
      apca100            LIKE apca_t.apca100, 
      apca108            LIKE apca_t.apca108, 
      l_apca1081         LIKE type_t.num20_6, 
      l_apca1082         LIKE type_t.num20_6, 
      apca118            LIKE apca_t.apca118, 
      l_apca1181         LIKE type_t.num20_6, 
      l_apca1182         LIKE type_t.num20_6
   END RECORD

   DELETE FROM aapq911_x01_tmp
   CASE g_input.apcastus
      WHEN '1'
         SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
      WHEN '2'
         SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.2' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
      WHEN '3'
         SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.3' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
      WHEN '4'
         SELECT gzzd005 INTO l_apcastus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_apcastus.4' AND gzzd002 = g_dlang AND gzzd001 = 'aapq911'
   END CASE  
   FOR l_i = 1 TO g_apca_d.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.apcasite_desc      = g_input.apcasite,':',g_input.apcasite_desc
      LET l_x01_tmp.l_sedate           = g_input.strdate,'~',g_input.enddate
      LET l_x01_tmp.curr               = g_input.curr
      LET l_x01_tmp.apcastus           = g_input.apcastus
      LET l_x01_tmp.l_apcastus_desc    = l_apcastus_desc
      LET l_x01_tmp.apcacomp           = g_apca_d[l_i].apcacomp 
      LET l_x01_tmp.apcacomp_desc      = g_apca_d[l_i].apcacomp_desc 
      LET l_x01_tmp.apcald             = g_apca_d[l_i].apcald 
      LET l_x01_tmp.apcald_desc        = g_apca_d[l_i].apcald_desc 
      LET l_x01_tmp.apca004            = g_apca_d[l_i].apca004 
      LET l_x01_tmp.apca004_desc       = g_apca_d[l_i].apca004_desc 
      LET l_x01_tmp.pmab031            = g_apca_d[l_i].pmab031 
      LET l_x01_tmp.pmab031_desc       = g_apca_d[l_i].pmab031_desc 
      LET l_x01_tmp.type               = g_apca_d[l_i].type 
      LET l_x01_tmp.apcadocdt          = g_apca_d[l_i].apcadocdt 
      LET l_x01_tmp.apca001            = g_apca_d[l_i].apca001 
      LET l_x01_tmp.apca001_desc       = g_apca_d[l_i].apca001_desc 
      LET l_x01_tmp.apcadocno          = g_apca_d[l_i].apcadocno 
      LET l_x01_tmp.apcb047            = g_apca_d[l_i].apcb047 
      LET l_x01_tmp.apca035            = g_apca_d[l_i].apca035 
      LET l_x01_tmp.apca035_desc       = g_apca_d[l_i].apca035_desc 
      LET l_x01_tmp.apca100            = g_apca_d[l_i].apca100 
      LET l_x01_tmp.apca108            = g_apca_d[l_i].apca108 
      LET l_x01_tmp.l_apca1081         = g_apca_d[l_i].l_apca1081 
      LET l_x01_tmp.l_apca1082         = g_apca_d[l_i].l_apca1082 
      LET l_x01_tmp.apca118            = g_apca_d[l_i].apca118 
      LET l_x01_tmp.l_apca1181         = g_apca_d[l_i].l_apca1181 
      LET l_x01_tmp.l_apca1182         = g_apca_d[l_i].l_apca1182
      LET l_x01_tmp.apca038            = g_apca_d[l_i].apca038   #150902-00001#5 
      LET l_x01_tmp.apca066            = g_apca_d[l_i].apca066   #150902-00001#5  
      #INSERT INTO aapq911_x01_tmp VALUES(l_x01_tmp.*) #161108-00017#3 mark
      #161108-00017#3 add ------
      INSERT INTO aapq911_x01_tmp (apcasite,apcasite_desc,l_sedate,strdate,enddate,
                                   curr,apcastus,l_apcastus_desc,apcacomp,apcacomp_desc,
                                   apcald,apcald_desc,apca004,apca004_desc,pmab031,
                                   pmab031_desc,type,apcadocdt,apca001,apca001_desc,
                                   apcadocno,apcb047,apca035,apca035_desc,apca038,
                                   apca066,apca100,apca108,l_apca1081,l_apca1082,
                                   apca118,l_apca1181,l_apca1182
                                  )
      VALUES (l_x01_tmp.apcasite,l_x01_tmp.apcasite_desc,l_x01_tmp.l_sedate,l_x01_tmp.strdate,l_x01_tmp.enddate,
              l_x01_tmp.curr,l_x01_tmp.apcastus,l_x01_tmp.l_apcastus_desc,l_x01_tmp.apcacomp,l_x01_tmp.apcacomp_desc,
              l_x01_tmp.apcald,l_x01_tmp.apcald_desc,l_x01_tmp.apca004,l_x01_tmp.apca004_desc,l_x01_tmp.pmab031,
              l_x01_tmp.pmab031_desc,l_x01_tmp.type,l_x01_tmp.apcadocdt,l_x01_tmp.apca001,l_x01_tmp.apca001_desc,
              l_x01_tmp.apcadocno,l_x01_tmp.apcb047,l_x01_tmp.apca035,l_x01_tmp.apca035_desc,l_x01_tmp.apca038,
              l_x01_tmp.apca066,l_x01_tmp.apca100,l_x01_tmp.apca108,l_x01_tmp.l_apca1081,l_x01_tmp.l_apca1082,
              l_x01_tmp.apca118,l_x01_tmp.l_apca1181,l_x01_tmp.l_apca1182
             )
      #161108-00017#3 add end---
   END FOR 

END FUNCTION

 
{</section>}
 
