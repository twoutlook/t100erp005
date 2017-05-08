#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp340.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2014-05-09 13:34:15), PR版次:0013(2017-01-22 15:52:51)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000147
#+ Filename...: axrp340
#+ Description: 輔助帳套應收帳款資料複製作業
#+ Creator....: 01727(2014-05-07 09:53:59)
#+ Modifier...: 01727 -SD/PR- 01531
 
{</section>}
 
{<section id="axrp340.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#12   2016/04/26 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160731-00372#1    2016/08/16 By 07900       客户开窗不要开供应商
#160811-00009#4    2016/08/22 By 01531       账务中心/法人/账套权限控管
#160913-00017#10   2016/09/22 By 07900       AXR模组调整交易客商开窗
#161017-00011#2    2016/10/19 By 02599       增加控制组权限控管
#161123-00048#4    2016/11/25 By 08729       開窗增加過濾據點
#161128-00061#3    2016/12/01 by 02481       标准程式定义采用宣告模式,弃用.*写法
#170122-00008#1    2017/01/22 By 01531       SQL语句补ENT条件
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
       
       sel LIKE type_t.chr1, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca004 LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr500, 
   xrca100 LIKE xrca_t.xrca100, 
   xrca103 LIKE xrca_t.xrca103, 
   xrca106 LIKE xrca_t.xrca106, 
   xrca104 LIKE xrca_t.xrca104, 
   xrca107 LIKE xrca_t.xrca107, 
   xrca108 LIKE xrca_t.xrca108
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xrca_m RECORD
       xrcald        LIKE xrca_t.xrcald,
       xrcald_desc   LIKE glaal_t.glaal002,
       xrcacomp      LIKE xrca_t.xrcacomp,
       xrcacomp_desc LIKE ooefl_t.ooefl003
       END RECORD

#模組變數(Module Variables)
DEFINE g_xrca_m            type_g_xrca_m
DEFINE g_xrcald            LIKE xrca_t.xrcald
DEFINE g_xrcald_desc       LIKE glaal_t.glaal002
#161128-00061#3-----modify--begin----------
#DEFINE g_glaa_t            RECORD LIKE glaa_t.*
#DEFINE g_glaa              RECORD LIKE glaa_t.* #160811-00009#4 
DEFINE g_glaa_t RECORD  #帳套資料檔
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
#161128-00061#3-----modify--end----------

DEFINE g_success           LIKE type_t.chr1
DEFINE g_sql_ctrl          STRING #161017-00011#2 add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xrca_d            DYNAMIC ARRAY OF type_g_xrca_d
DEFINE g_xrca_d_t          type_g_xrca_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp340.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   
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
   DECLARE axrp340_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrp340_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrp340_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp340 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp340_init()   
 
      #進入選單 Menu (="N")
      CALL axrp340_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrp340
      
   END IF 
   
   CLOSE axrp340_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrp340.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrp340_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   #161017-00011#2--add--str--
   LET g_sql_ctrl = NULL
   #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161123-00048#4 mark
   #161017-00011#2--add--end
   #161123-00048#4-add
   SELECT ooef017 INTO g_xrca_m.xrcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_xrca_m.xrcacomp) RETURNING g_sub_success,g_sql_ctrl
   #161123-00048#4-add
   #end add-point
 
   CALL axrp340_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrp340.default_search" >}
PRIVATE FUNCTION axrp340_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrcald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xrcadocno = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp340.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp340_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_ooag003      LIKE ooag_t.ooag003
   DEFINE l_success      LIKE type_t.chr1
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_length       LIKE type_t.num5
   DEFINE l_ld_str       STRING #160811-00009#4 
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   LET l_flag = 'N'
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xrcadocno = '", g_argv[02], "'"
      LET g_xrca_m.xrcald = g_argv[1]
      DISPLAY g_argv[02] TO xrcadocno
   ELSE
      LET g_wc = " 1=1"
   END IF

   #end add-point
 
   
   CALL axrp340_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrca_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrp340_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_xrca_m.xrcald ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               IF cl_null(g_xrca_m.xrcald) THEN
                  CALL axrp340_def()
               END IF

            AFTER FIELD xrcald
               LET g_xrca_m.xrcald_desc = ' '
               LET g_xrca_m.xrcacomp_desc = ' '
               DISPLAY BY NAME g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp_desc
               IF NOT cl_null(g_xrca_m.xrcald) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrca_m.xrcald
                  LET g_chkparam.arg2 = ' '
                  #160318-00025#12--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                  #160318-00025#12--add--end
                  IF NOT cl_chk_exist("v_glaald_3") THEN
                     LET g_xrca_m.xrcald = ' '
                     LET g_xrca_m.xrcacomp = ' '
                     CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
                     DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc
                     NEXT FIELD CURRENT
                  #160811-00009#2 Add  ---(S)---
                  ELSE   
                     LET g_errno = ''
                     CALL s_fin_account_center_with_ld_chk('',g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xrca_m.xrcald = ' '
                        LET g_xrca_m.xrcacomp = ' '
                        CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
                        DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc
                        NEXT FIELD CURRENT
                     END IF
                  #160811-00009#2 Add  ---(E)---                        
                  END IF
               END IF
               SELECT glaacomp INTO g_xrca_m.xrcacomp FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaald = g_xrca_m.xrcald
               CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
               CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp_desc
               DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_xrca_m.xrcacomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#4-add

            ON ACTION controlp INFIELD xrcald
               #開窗i段
               CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str #160811-00009#4 
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
               
               #給予arg
               SELECT ooag003 INTO l_ooag003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_user
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = l_ooag003
               #LET g_qryparam.where = "glaa014 = 'Y'"                       #160811-00009#4 
               LET g_qryparam.where = l_ld_str CLIPPED," AND glaa014 = 'Y'"  #160811-00009#4
               CALL q_authorised_ld()                                #呼叫開窗
               
               LET g_xrca_m.xrcald = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_xrca_m.xrcald TO xrcald                     #顯示到畫面上
               CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
               
               NEXT FIELD xrcald                                     #返回原欄位

            AFTER INPUT
               CALL axrp340_b_fill()

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc ON xrca004,xrcadocdt,xrcadocno,xrca003 FROM xrca004,xrcadocdt,xrcadocno,xrca003

            ON ACTION controlp INFIELD xrca004
               #開窗c段
	   		   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			    #  LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"  #160731-00372#1 2016/08/16 By 07900 add  #160913-00017#10  mark 
             #  CALL q_pmaa001_7()     #160913-00017#10  mark                    #呼叫開窗
               #160913-00017#10--ADD(S)--
               LET g_qryparam.arg1="('2','3')"
               #161017-00011#2--add--str--
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #161017-00011#2--add--end
               CALL q_pmaa001_1()
               #160913-00017#10--ADD(E)-    
               DISPLAY g_qryparam.return1 TO xrca004      #顯示到畫面上
               
               NEXT FIELD xrca004                         #返回原欄位

            ON ACTION controlp INFIELD xrcadocno
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      #161017-00011#2--add--str--
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                         "          WHERE pmaaent = ",g_enterprise,
                                         "            AND ",g_sql_ctrl,
                                         "            AND pmaaent = ",g_enterprise,
                                         "            AND pmaa001 = xrca004 )"
               END IF
               #161017-00011#2--add--end
               CALL q_xrcadocno_4()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcadocno    #顯示到畫面上
              
               NEXT FIELD xrcadocno                       #返回原欄位

            ON ACTION controlp INFIELD xrca003
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca003      #顯示到畫面上
               
               NEXT FIELD xrca003                         #返回原欄位

            AFTER CONSTRUCT
               CALL axrp340_b_fill()

         END CONSTRUCT

         INPUT g_xrcald FROM s_xrcald ATTRIBUTE(WITHOUT DEFAULTS)

            AFTER FIELD s_xrcald
               IF NOT cl_null(g_xrcald) THEN
                  LET g_xrcald_desc = ' '
                  DISPLAY BY NAME g_xrcald_desc
                  IF NOT cl_null(g_xrcald) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_xrcald
                     LET g_chkparam.arg2 = g_xrca_m.xrcacomp
                     #160318-00025#12--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
                     #160318-00025#12--add--end
                     IF NOT cl_chk_exist("v_glaald_4") THEN
                        LET g_xrcald = ' '
                        CALL s_axrt300_xrca_ref('xrcald',g_xrcald,'','') RETURNING l_success,g_xrcald_desc
                        DISPLAY BY NAME g_xrcald,g_xrcald_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #人員對應帳套使用權限檢查
                  IF NOT cl_null(g_xrcald) THEN
                     CALL s_ld_chk_authorization(g_user,g_xrcald) RETURNING l_success
                     IF l_success = FALSE THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axr-00022'
                        LET g_errparam.extend = g_xrcald
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcald = ' '
                        CALL s_axrt300_xrca_ref('xrcald',g_xrcald,'','') RETURNING l_success,g_xrcald_desc
                        DISPLAY BY NAME g_xrcald,g_xrcald_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL s_axrt300_xrca_ref('xrcald',g_xrcald,'','') RETURNING l_success,g_xrcald_desc
                  DISPLAY BY NAME g_xrcald,g_xrcald_desc
               END IF

            ON ACTION controlp INFIELD s_xrcald
               #開窗i段
               
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
               
               #給予arg
               SELECT ooag003 INTO l_ooag003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_user
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = l_ooag003
               #LET g_qryparam.where = "glaacomp = '",g_xrca_m.xrcacomp,"' AND glaa008  ='Y' AND glaa023 = '1'"
               LET g_qryparam.where = l_ld_str CLIPPED," AND glaacomp = '",g_xrca_m.xrcacomp,"' AND glaa008  ='Y' AND glaa023 = '1'"  #160811-00009#4
               CALL q_authorised_ld()                                #呼叫開窗
               
               LET g_xrca_m.xrcald = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_xrca_m.xrcald TO xrcald                     #顯示到畫面上
               CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
               
               NEXT FIELD xrcald                                     #返回原欄位

            AFTER INPUT
               CALL axrp340_b_fill()

         END INPUT
         #end add-point
     
         DISPLAY ARRAY g_xrca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrp340_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrp340_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrp340_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF l_flag = 'Y' THEN
               CALL axrp340_b_fill()
               LET l_flag = 'N'
              #NEXT FIELD xrcald   #160731-00372#1 Mark
            END IF
            NEXT FIELD xrcald   #160731-00372#1 Add
            #end add-point
            NEXT FIELD xrca103
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axrp340_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
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
 
         ON ACTION datarefresh   # 重新整理
            CALL axrp340_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrp340_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrp340_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrp340_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrp340_b_fill()
 
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

         ON ACTION batch_execute
            LET l_flag = 'Y'
            CALL axrp340_copy()
            ACCEPT DIALOG

         ON ACTION dbclick
            IF g_xrca_d[l_ac].sel = "Y" THEN
               LET g_xrca_d[l_ac].sel = "N"
            ELSE
               LET g_xrca_d[l_ac].sel = "Y"
            END IF
            DISPLAY g_xrca_d[l_ac].sel TO s_detail1[l_ac].sel
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp340_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
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
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
            CLEAR FORM
            INITIALIZE g_xrca_m.* TO NULL
            CALL axrp340_def()
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrp340.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp340_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xrca_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xrcadocno,xrcadocdt,xrca004,'',xrca100,xrca103,xrca106,xrca104, 
       xrca107,xrca108  ,DENSE_RANK() OVER( ORDER BY xrca_t.xrcald,xrca_t.xrcadocno) AS RANK FROM xrca_t", 
 
 
 
                     "",
                     " WHERE xrcaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrca_t"),
                     " ORDER BY xrca_t.xrcald,xrca_t.xrcadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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
 
   LET g_sql = "SELECT '',xrcadocno,xrcadocdt,xrca004,'',xrca100,xrca103,xrca106,xrca104,xrca107,xrca108", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE 'N',xrcadocno,xrcadocdt,xrca004,'',xrca100,xrca103,xrca106,xrca104,xrca107,xrca108 FROM (    ",
               "  SELECT xrcadocno,xrcadocdt,xrca004,xrca100,xrca103,xrca106,xrca104,xrca107,xrca108,SUM (xrcb118 - xrcb117)",
               "    FROM xrca_t, xrcb_t                                                                                     ",
               "   WHERE     xrcaent = xrcbent                                                                              ",
               "         AND xrcadocno = xrcbdocno                                                                          ",
               "         AND xrcald = xrcbld                                                                                ",
               "         AND xrcaent= ?                                                                                     "
   IF NOT cl_null(g_xrca_m.xrcald) THEN
       LET g_sql = g_sql,
               "         AND xrcald = '",g_xrca_m.xrcald,"'                                                                 "
   END IF
   IF NOT cl_null(g_xrcald) THEN
       LET g_sql = g_sql,
               "         AND xrcadocno NOT IN                                                                               ",
               "                (SELECT xrcadocno FROM xrca_t WHERE xrcaent = '",g_enterprise,"'                            ",
               "                    AND xrcald IN                                                                           ",
               "                       (SELECT glaald FROM glaa_t                                                           ",
               "                         WHERE glaa014 = 'N' AND glaacomp = '",g_xrca_m.xrcacomp,"'))                       "
   END IF

   #161017-00011#2--add--str--
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql,"   AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "                WHERE pmaaent = ",g_enterprise,
                        "                  AND ",g_sql_ctrl,
                        "                  AND pmaaent = xrcaent ",
                        "                  AND pmaa001 = xrca004 )"
   END IF 
   #161017-00011#2--add--end

   LET g_sql = g_sql,"   AND 1=1 AND ", ls_wc CLIPPED, 
               "GROUP BY xrcadocno,xrcadocdt,xrca004,xrca100,xrca103,xrca106,xrca104,xrca107,xrca108                        ",
               "HAVING SUM (xrcb118 - xrcb117) > 0 )                                                                        "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrp340_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp340_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xrca_d[l_ac].sel,g_xrca_d[l_ac].xrcadocno,g_xrca_d[l_ac].xrcadocdt,g_xrca_d[l_ac].xrca004, 
       g_xrca_d[l_ac].xrca004_desc,g_xrca_d[l_ac].xrca100,g_xrca_d[l_ac].xrca103,g_xrca_d[l_ac].xrca106, 
       g_xrca_d[l_ac].xrca104,g_xrca_d[l_ac].xrca107,g_xrca_d[l_ac].xrca108
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrca_d[l_ac].xrca004
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrca_d[l_ac].xrca004_desc = g_xrca_d[l_ac].xrca004,'(', g_rtn_fields[1] , ')'
      #end add-point
 
      CALL axrp340_detail_show("'1'")
 
      CALL axrp340_xrca_t_mask()
 
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
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_xrca_d.deleteElement(g_xrca_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xrca_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axrp340_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrp340_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrp340_detail_action_trans()
 
   LET l_ac = 1
   IF g_xrca_d.getLength() > 0 THEN
      CALL axrp340_b_fill2()
   END IF
 
      CALL axrp340_filter_show('xrcadocno','b_xrcadocno')
   CALL axrp340_filter_show('xrcadocdt','b_xrcadocdt')
   CALL axrp340_filter_show('xrca004','b_xrca004')
   CALL axrp340_filter_show('xrca100','b_xrca100')
   CALL axrp340_filter_show('xrca103','b_xrca103')
   CALL axrp340_filter_show('xrca106','b_xrca106')
   CALL axrp340_filter_show('xrca104','b_xrca104')
   CALL axrp340_filter_show('xrca107','b_xrca107')
   CALL axrp340_filter_show('xrca108','b_xrca108')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrp340.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp340_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axrp340.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp340_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrca_d[l_ac].xrca004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrca_d[l_ac].xrca004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrca_d[l_ac].xrca004_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp340.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrp340_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrcadocno,xrcadocdt,xrca004,xrca100,xrca103,xrca106,xrca104,xrca107,xrca108 
 
                          FROM s_detail1[1].b_xrcadocno,s_detail1[1].b_xrcadocdt,s_detail1[1].b_xrca004, 
                              s_detail1[1].b_xrca100,s_detail1[1].b_xrca103,s_detail1[1].b_xrca106,s_detail1[1].b_xrca104, 
                              s_detail1[1].b_xrca107,s_detail1[1].b_xrca108
 
         BEFORE CONSTRUCT
                     DISPLAY axrp340_filter_parser('xrcadocno') TO s_detail1[1].b_xrcadocno
            DISPLAY axrp340_filter_parser('xrcadocdt') TO s_detail1[1].b_xrcadocdt
            DISPLAY axrp340_filter_parser('xrca004') TO s_detail1[1].b_xrca004
            DISPLAY axrp340_filter_parser('xrca100') TO s_detail1[1].b_xrca100
            DISPLAY axrp340_filter_parser('xrca103') TO s_detail1[1].b_xrca103
            DISPLAY axrp340_filter_parser('xrca106') TO s_detail1[1].b_xrca106
            DISPLAY axrp340_filter_parser('xrca104') TO s_detail1[1].b_xrca104
            DISPLAY axrp340_filter_parser('xrca107') TO s_detail1[1].b_xrca107
            DISPLAY axrp340_filter_parser('xrca108') TO s_detail1[1].b_xrca108
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrcadocno>>----
         #Ctrlp:construct.c.page1.b_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocno
            #add-point:ON ACTION controlp INFIELD b_xrcadocno name="construct.c.filter.page1.b_xrcadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161017-00011#2--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = xrcaent ",
                                      "            AND pmaa001 = xrca004 )"
            END IF                       
            #161017-00011#2--add--end
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcadocno  #顯示到畫面上
            NEXT FIELD b_xrcadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrcadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xrcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocdt
            #add-point:ON ACTION controlp INFIELD b_xrcadocdt name="construct.c.filter.page1.b_xrcadocdt"
            
            #END add-point
 
 
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
			  # LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"  #160731-00372#1 2016/08/16 By 07900 add     #160913-00017#10 mark        
             # CALL q_pmaa001()   #160913-00017#10  mark                  #呼叫開窗
            #160913-00017#10--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            #161017-00011#2--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161017-00011#2--add--end
            CALL q_pmaa001_1()
            #160913-00017#10--ADD(E)-    
            DISPLAY g_qryparam.return1 TO b_xrca004  #顯示到畫面上
            NEXT FIELD b_xrca004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrca004_desc>>----
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
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca100  #顯示到畫面上
            NEXT FIELD b_xrca100                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrca103>>----
         #Ctrlp:construct.c.filter.page1.b_xrca103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca103
            #add-point:ON ACTION controlp INFIELD b_xrca103 name="construct.c.filter.page1.b_xrca103"
            
            #END add-point
 
 
         #----<<b_xrca106>>----
         #Ctrlp:construct.c.filter.page1.b_xrca106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca106
            #add-point:ON ACTION controlp INFIELD b_xrca106 name="construct.c.filter.page1.b_xrca106"
            
            #END add-point
 
 
         #----<<b_xrca104>>----
         #Ctrlp:construct.c.filter.page1.b_xrca104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca104
            #add-point:ON ACTION controlp INFIELD b_xrca104 name="construct.c.filter.page1.b_xrca104"
            
            #END add-point
 
 
         #----<<b_xrca107>>----
         #Ctrlp:construct.c.filter.page1.b_xrca107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca107
            #add-point:ON ACTION controlp INFIELD b_xrca107 name="construct.c.filter.page1.b_xrca107"
            
            #END add-point
 
 
         #----<<b_xrca108>>----
         #Ctrlp:construct.c.filter.page1.b_xrca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca108
            #add-point:ON ACTION controlp INFIELD b_xrca108 name="construct.c.filter.page1.b_xrca108"
            
            #END add-point
 
 
 
 
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL axrp340_filter_show('xrcadocno','b_xrcadocno')
   CALL axrp340_filter_show('xrcadocdt','b_xrcadocdt')
   CALL axrp340_filter_show('xrca004','b_xrca004')
   CALL axrp340_filter_show('xrca100','b_xrca100')
   CALL axrp340_filter_show('xrca103','b_xrca103')
   CALL axrp340_filter_show('xrca106','b_xrca106')
   CALL axrp340_filter_show('xrca104','b_xrca104')
   CALL axrp340_filter_show('xrca107','b_xrca107')
   CALL axrp340_filter_show('xrca108','b_xrca108')
 
 
   CALL axrp340_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp340.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrp340_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="axrp340.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp340_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrp340_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrp340.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrp340_detail_action_trans()
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
 
{<section id="axrp340.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrp340_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
 
{<section id="axrp340.mask_functions" >}
 &include "erp/axr/axrp340_mask.4gl"
 
{</section>}
 
{<section id="axrp340.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axrp340_def()
   DEFINE l_sql         STRING
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_success     LIKE type_t.chr1

#160811-00009#4 mark s---
#   LET l_sql = " SELECT DISTINCT xrah002 FROM xrah_t ",
#               "  WHERE xrah004 IN(SELECT ooag004 FROM ooag_t WHERE ooag001 = '",g_user,"' AND ooagstus = 'Y')",
#               "    AND xrah007 ='Y'",
#               "    AND xrahstus ='Y'",
#               "    AND xrah001 = '1'",
#               "  ORDER BY xrah002"
#   PREPARE axrp340_def_prep FROM l_sql
#   DECLARE axrp340_def_curs CURSOR FOR axrp340_def_prep
#
#   #抓取員工所屬營運據點對應的所有帳務中心
#   FOREACH axrp340_def_curs INTO l_xrcasite
#
#      #根據帳務中心抓取對應法人的主帳套
#      SELECT glaald,glaacomp INTO g_xrca_m.xrcald,g_xrca_m.xrcacomp FROM glaa_t,ooef_t
#       WHERE glaacomp = ooef017
#         AND glaa014  = 'Y'
#         AND ooef001  = l_xrcasite
#
#      IF cl_null(g_xrca_m.xrcald) THEN LET g_xrca_m.xrcald = Null CONTINUE FOREACH END IF
#
#      #根據帳套檢查該員工是否有使用權限
#	  CALL s_ld_chk_authorization(g_user,g_xrca_m.xrcald) RETURNING l_success
#	  IF l_success = 'N' THEN
#	     LET g_xrca_m.xrcald   = NULL
#	     CONTINUE FOREACH
#	  ELSE
#	     EXIT FOREACH
#      END IF
#   END FOREACH
#160811-00009#4 mark e---
   
   #160811-00009#4 add s---
   #根據人員抓取對應法人的主帳套
   SELECT DISTINCT glaald INTO g_xrca_m.xrcald
     FROM glaa_t,ooef_t,ooag_t
    WHERE ooag004 = ooef001
      AND ooagent = ooefent
      AND glaacomp = ooef017
      AND ooefent = glaaent
      AND glaa014 = 'Y'
      AND ooag001 = g_user
      AND glaaent = g_enterprise

   #根據帳套檢查該員工是否有使用權限
   CALL s_ld_chk_authorization(g_user,g_xrca_m.xrcald) RETURNING l_success
   IF l_success = 'N' THEN
      LET g_xrca_m.xrcald   = NULL
   END IF
 
   SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
   LET g_xrca_m.xrcacomp = g_glaa.glaacomp 
   #160811-00009#4 add e---
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_xrca_m.xrcacomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#4-add
   CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
   CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp_desc

   DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp,g_xrca_m.xrcacomp_desc

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
PRIVATE FUNCTION axrp340_copy()
   DEFINE l_count         LIKE type_t.num5
   DEFINE i               LIKE type_t.num5
   DEFINE l_length        LIKE type_t.num5
   DEFINE l_scc40         LIKE type_t.chr2
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_rate          LIKE xrca_t.xrca103
   DEFINE l_rate1         LIKE xrca_t.xrca103
   DEFINE l_rate2         LIKE xrca_t.xrca103
   DEFINE l_rate3         LIKE xrca_t.xrca103
   DEFINE l_wc            STRING

   #161128-00061#3-----modify--begin----------
   #DEFINE l_xrca_t        RECORD LIKE xrca_t.*
   #DEFINE l_xrcb_t        RECORD LIKE xrcb_t.*
   #DEFINE l_xrcc_t        RECORD LIKE xrcc_t.*
   #DEFINE l_xrcd_t        RECORD LIKE xrcd_t.*
   DEFINE l_xrca_t RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票編號
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138  #本位幣三應收金額
       END RECORD

   DEFINE l_xrcb_t RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD
   DEFINE l_xrcc_t RECORD  #多帳期明細
       xrccent LIKE xrcc_t.xrccent, #企業編號
       xrccld LIKE xrcc_t.xrccld, #帳套
       xrcccomp LIKE xrcc_t.xrcccomp, #法人
       xrccdocno LIKE xrcc_t.xrccdocno, #應收帳款單號碼
       xrccseq LIKE xrcc_t.xrccseq, #項次
       xrcc001 LIKE xrcc_t.xrcc001, #期別
       xrcc002 LIKE xrcc_t.xrcc002, #應收收款類別
       xrcc003 LIKE xrcc_t.xrcc003, #應收款日
       xrcc004 LIKE xrcc_t.xrcc004, #容許票據到期日
       xrcc005 LIKE xrcc_t.xrcc005, #帳款起算日
       xrcc006 LIKE xrcc_t.xrcc006, #正負值
       xrcclegl LIKE xrcc_t.xrcclegl, #核算組織
       xrcc008 LIKE xrcc_t.xrcc008, #發票編號
       xrcc009 LIKE xrcc_t.xrcc009, #發票號碼
       xrccsite LIKE xrcc_t.xrccsite, #帳務中心
       xrcc010 LIKE xrcc_t.xrcc010, #發票日期
       xrcc011 LIKE xrcc_t.xrcc011, #出貨單據日期
       xrcc012 LIKE xrcc_t.xrcc012, #立帳日期
       xrcc013 LIKE xrcc_t.xrcc013, #交易認定日期
       xrcc014 LIKE xrcc_t.xrcc014, #出入庫扣帳日期
       xrcc100 LIKE xrcc_t.xrcc100, #交易原幣別
       xrcc101 LIKE xrcc_t.xrcc101, #原幣匯率
       xrcc102 LIKE xrcc_t.xrcc102, #原幣重估後匯率
       xrcc103 LIKE xrcc_t.xrcc103, #重評價調整數
       xrcc104 LIKE xrcc_t.xrcc104, #No Use
       xrcc105 LIKE xrcc_t.xrcc105, #No Use
       xrcc106 LIKE xrcc_t.xrcc106, #No Use
       xrcc107 LIKE xrcc_t.xrcc107, #No Use
       xrcc108 LIKE xrcc_t.xrcc108, #原幣應收金額
       xrcc109 LIKE xrcc_t.xrcc109, #原幣收款沖帳金額
       xrcc113 LIKE xrcc_t.xrcc113, #本幣重評價調整數
       xrcc114 LIKE xrcc_t.xrcc114, #No Use
       xrcc115 LIKE xrcc_t.xrcc115, #No Use
       xrcc116 LIKE xrcc_t.xrcc116, #No Use
       xrcc117 LIKE xrcc_t.xrcc117, #No Use
       xrcc118 LIKE xrcc_t.xrcc118, #本幣應收金額
       xrcc119 LIKE xrcc_t.xrcc119, #本幣收款沖帳金額
       xrcc120 LIKE xrcc_t.xrcc120, #本位幣二幣別
       xrcc121 LIKE xrcc_t.xrcc121, #本位幣二匯率
       xrcc122 LIKE xrcc_t.xrcc122, #本位幣二重估後匯率
       xrcc123 LIKE xrcc_t.xrcc123, #本位幣二重評價調整數
       xrcc124 LIKE xrcc_t.xrcc124, #No Use
       xrcc125 LIKE xrcc_t.xrcc125, #No Use
       xrcc126 LIKE xrcc_t.xrcc126, #No Use
       xrcc127 LIKE xrcc_t.xrcc127, #No Use
       xrcc128 LIKE xrcc_t.xrcc128, #本位幣二應收金額
       xrcc129 LIKE xrcc_t.xrcc129, #本位幣二收款沖帳金額
       xrcc130 LIKE xrcc_t.xrcc130, #本位幣三幣別
       xrcc131 LIKE xrcc_t.xrcc131, #本位幣三匯率
       xrcc132 LIKE xrcc_t.xrcc132, #本位幣三重估後匯率
       xrcc133 LIKE xrcc_t.xrcc133, #本位幣三重評價調整數
       xrcc134 LIKE xrcc_t.xrcc134, #No Use
       xrcc135 LIKE xrcc_t.xrcc135, #No Use
       xrcc136 LIKE xrcc_t.xrcc136, #No Use
       xrcc137 LIKE xrcc_t.xrcc137, #No Use
       xrcc138 LIKE xrcc_t.xrcc138, #本位幣三應收金額
       xrcc139 LIKE xrcc_t.xrcc139, #本位幣三收款沖帳金額
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD 
   DEFINE l_xrcd_t RECORD  #交易稅明細檔
       xrcdent LIKE xrcd_t.xrcdent, #企業編號
       xrcdcomp LIKE xrcd_t.xrcdcomp, #法人
       xrcdld LIKE xrcd_t.xrcdld, #帳套
       xrcdsite LIKE xrcd_t.xrcdsite, #營運據點
       xrcddocno LIKE xrcd_t.xrcddocno, #交易單據編號
       xrcdseq LIKE xrcd_t.xrcdseq, #項次
       xrcdseq2 LIKE xrcd_t.xrcdseq2, #項次2
       xrcdorga LIKE xrcd_t.xrcdorga, #帳務來源SITE
       xrcd001 LIKE xrcd_t.xrcd001, #來源作業別
       xrcd002 LIKE xrcd_t.xrcd002, #稅別
       xrcd003 LIKE xrcd_t.xrcd003, #稅率
       xrcd004 LIKE xrcd_t.xrcd004, #固定課稅金額
       xrcd005 LIKE xrcd_t.xrcd005, #課稅數量
       xrcd006 LIKE xrcd_t.xrcd006, #含稅否
       xrcd007 LIKE xrcd_t.xrcd007, #計算序
       xrcd008 LIKE xrcd_t.xrcd008, #no use
       xrcd009 LIKE xrcd_t.xrcd009, #稅額會計科目
       xrcd010 LIKE xrcd_t.xrcd010, #no use
       xrcd100 LIKE xrcd_t.xrcd100, #幣別
       xrcd101 LIKE xrcd_t.xrcd101, #匯率
       xrcd102 LIKE xrcd_t.xrcd102, #原幣計算基準
       xrcd103 LIKE xrcd_t.xrcd103, #原幣未稅金額
       xrcd104 LIKE xrcd_t.xrcd104, #原幣稅額
       xrcd105 LIKE xrcd_t.xrcd105, #原幣含稅金額
       xrcd106 LIKE xrcd_t.xrcd106, #原幣留抵稅額
       xrcd112 LIKE xrcd_t.xrcd112, #本幣計算基準
       xrcd113 LIKE xrcd_t.xrcd113, #本幣未稅金額
       xrcd114 LIKE xrcd_t.xrcd114, #本幣稅額
       xrcd115 LIKE xrcd_t.xrcd115, #本幣含稅金額
       xrcd116 LIKE xrcd_t.xrcd116, #本幣留抵稅額
       xrcd117 LIKE xrcd_t.xrcd117, #已開發票原幣未稅金額
       xrcd118 LIKE xrcd_t.xrcd118, #已開發票原幣稅額
       xrcd121 LIKE xrcd_t.xrcd121, #本位幣二匯率
       xrcd124 LIKE xrcd_t.xrcd124, #本位幣二稅額
       xrcd131 LIKE xrcd_t.xrcd131, #本位幣三匯率
       xrcd134 LIKE xrcd_t.xrcd134, #本位幣三稅額
       xrcd123 LIKE xrcd_t.xrcd123, #本位幣二未稅金額
       xrcd125 LIKE xrcd_t.xrcd125, #本位幣二含稅金額
       xrcd133 LIKE xrcd_t.xrcd133, #本位幣三未稅金額
       xrcd135 LIKE xrcd_t.xrcd135, #本位幣三含稅金額
       xrcd011 LIKE xrcd_t.xrcd011, #發票編號
       xrcd012 LIKE xrcd_t.xrcd012, #發票號碼
       xrcd013 LIKE xrcd_t.xrcd013  #稅別項次
       END RECORD       
   #161128-00061#3-----modify--end----------    
   
   DEFINE l_8304_01       LIKE glab_t.glab005
   DEFINE l_8304_21       LIKE glab_t.glab005
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_xrca113       LIKE xrca_t.xrca113
   DEFINE l_xrca114       LIKE xrca_t.xrca114
   DEFINE l_xrca118       LIKE xrca_t.xrca118
   DEFINE l_xrcb111       LIKE xrcb_t.xrcb111
   DEFINE l_xrcb113       LIKE xrcb_t.xrcb113
   DEFINE l_xrcb114       LIKE xrcb_t.xrcb114
   DEFINE l_xrcb116       LIKE xrcb_t.xrcb116
   DEFINE l_xrcb123       LIKE xrcb_t.xrcb123
   DEFINE l_xrcb124       LIKE xrcb_t.xrcb124
   DEFINE l_xrcb133       LIKE xrcb_t.xrcb133
   DEFINE l_xrcb134       LIKE xrcb_t.xrcb134
   DEFINE l_xrcd009       LIKE xrcd_t.xrcd009
   DEFINE l_xrcc113       LIKE xrcc_t.xrcc113
   DEFINE l_xrcc114       LIKE xrcc_t.xrcc114
   DEFINE l_xrcc123       LIKE xrcc_t.xrcc123
   DEFINE l_xrcc124       LIKE xrcc_t.xrcc124
   DEFINE l_xrcc133       LIKE xrcc_t.xrcc133
   DEFINE l_xrcc134       LIKE xrcc_t.xrcc134

   LET l_length = g_xrca_d.getLength()
   IF l_length < 1 THEN RETURN END IF

   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_xrcald
      AND glaacomp = (SELECT glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald)

   IF l_count <> 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00236'
      LET g_errparam.extend = g_xrcald
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   #STEP.依照邏輯將資料插入表中
   #     1.匯入xrca_t
   #     2.匯入xrcb_t
   #     3.匯入xrcd_t
   #     4.匯入xrcc_t

   #161128-00061#3-----modify--begin----------
   #SELECT * INTO g_glaa_t.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
          glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
   #161128-00061#3-----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrcald

   LET l_wc = Null
   FOR i = 1 TO l_length
      IF g_xrca_d[i].sel = 'N' THEN CONTINUE FOR END IF
      IF cl_null(l_wc) THEN
         LET l_wc = "xrcadocno IN ('",g_xrca_d[i].xrcadocno,"'"
      ELSE
         LET l_wc = l_wc,",'",g_xrca_d[i].xrcadocno,"'"
      END IF
   END FOR
   LET l_wc = l_wc,")"

   LET g_sql = "SELECT CASE WHEN ROW_NUMBER () OVER (PARTITION BY xrcadocno ORDER BY xrccdocno,xrccseq,xrcc001) = 1 THEN 1 ELSE 0 END flag,         ",
               "       CASE WHEN ROW_NUMBER () OVER (PARTITION BY xrcbdocno,xrcbseq ORDER BY xrccdocno,xrccseq,xrcc001) = 1 THEN 1 ELSE 0 END flag1,",
 #161128-00061#3-----modify--begin----------            
 #             "       xrca_t.*,xrcb_t.*,xrcc_t.*,xrcd_t.*                                                                                          ",
               "xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,xrcacnfdt,",
               "xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,xrca003,xrca004,",
               "xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,xrca015,xrca016,",
               "xrca017,xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,",
               "xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,",
               "xrca042,xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,xrca053,",
               "xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,xrca064,xrca065,",
               "xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,xrca108,xrca113,xrca114,xrca116,xrca117,",
               "xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,xrca133,xrca134,",
               "xrca136,xrca137,xrca138,xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,",
               "xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,xrcb014,",
               "xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,",
               "xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,",
               "xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,",
               "xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,",
               "xrcb116,xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,xrcb134,",
               "xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,xrcb059,xrcb060,xrcb107,",
               "xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,xrcc006,xrcclegl,",
               "xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,xrcc101,xrcc102,xrcc103,",
               "xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,",
               "xrcc119,xrcc120,xrcc121,xrcc122,xrcc123,xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,",
               "xrcc131,xrcc132,xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,xrcc138,xrcc139,xrcc015,xrcc016,xrcc017,",
               "xrcdent,xrcdcomp,xrcdld,xrcdsite,xrcddocno,xrcdseq,xrcdseq2,xrcdorga,xrcd001,xrcd002,xrcd003,xrcd004,",
               "xrcd005,xrcd006,xrcd007,xrcd008,xrcd009,xrcd010,xrcd100,xrcd101,xrcd102,xrcd103,xrcd104,xrcd105,",
               "xrcd106,xrcd112,xrcd113,xrcd114,xrcd115,xrcd116,xrcd117,xrcd118,xrcd121,xrcd124,xrcd131,xrcd134,",
               "xrcd123,xrcd125,xrcd133,xrcd135,xrcd011,xrcd012,xrcd013",
 #161128-00061#3-----modify--end----------             
               "    FROM xrca_t LEFT OUTER JOIN xrcb_t ON xrcaent = xrcbent AND xrcadocno = xrcbdocno AND xrcald = xrcbld                           ",
               "                LEFT OUTER JOIN xrcc_t ON xrcaent = xrccent AND xrcadocno = xrccdocno AND xrcald = xrccld                           ",
               "                LEFT OUTER JOIN xrcd_t ON xrcaent = xrcdent AND xrcadocno = xrcddocno                                               ",
               " WHERE     xrcbseq = xrccseq     AND xrcbseq = xrcdseq                                                                              ",
               "       AND xrcaent = '",g_enterprise,"' AND xrcald = '",g_xrca_m.xrcald,"' AND ",l_wc,
               "       ORDER BY xrccdocno,xrccseq,xrcc001                                                                                           "
   PREPARE axrp340_prep FROM g_sql
   DECLARE axrp340_copy CURSOR FOR axrp340_prep

   CALL s_transaction_begin()
   LET g_success = 'Y'

   FOREACH axrp340_copy INTO l_flag,l_flag1,l_xrca_t.*,l_xrcb_t.*,l_xrcc_t.*,l_xrcd_t.*
      IF l_flag = 1 THEN    #新一筆xrca_t的資料,需要做INS操作
         #本位幣匯率
         CALL s_axrt300_get_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrcald,l_xrca_t.xrcacomp,l_xrca_t.xrca100)
            RETURNING l_success,l_rate1,l_rate2,l_rate3

         SELECT glab005 INTO l_8304_01 FROM glab_t 
          WHERE glabld = g_xrcald
            AND glab002 = l_xrca_t.xrca007 # 帳款類別
            AND glab001 = '13'    # 應收帳務類型科目設定
            AND glab003 = '8304_01'
            AND glabent = g_enterprise #170122-00008#1 add
       
         SELECT glab005 INTO l_8304_21 FROM glab_t 
          WHERE glabld = g_xrcald
            AND glab002 = l_xrca_t.xrca007 # 帳款類別
            AND glab001 = '13'    # 應收帳務類型科目設定
            AND glab003 = '8304_21'
            AND glabent = g_enterprise #170122-00008#1 add

         CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrca_t.xrca103,l_rate1)
            RETURNING l_xrca113
         CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrca_t.xrca104,l_rate1)
            RETURNING l_xrca114
         CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrca_t.xrca108,l_rate1)
            RETURNING l_xrca118

         #xrca_t
         LET l_xrca_t.xrcastus = 'N'
         LET l_xrca_t.xrcald   = g_xrcald
         LET l_xrca_t.xrca035  = l_8304_01
         LET l_xrca_t.xrca036  = l_8304_21
         LET l_xrca_t.xrca037  = 'Y'
         LET l_xrca_t.xrca038  = Null
         LET l_xrca_t.xrca101  = l_rate1
         LET l_xrca_t.xrca106  = 0
         LET l_xrca_t.xrca107  = 0
         LET l_xrca_t.xrca113  = l_xrca113
         LET l_xrca_t.xrca114  = l_xrca114
         LET l_xrca_t.xrca116  = 0
         LET l_xrca_t.xrca117  = 0
         LET l_xrca_t.xrca118  = l_xrca118
         LET l_xrca_t.xrca120  = g_glaa_t.glaa016
         LET l_xrca_t.xrca121  = l_rate2
         LET l_xrca_t.xrca123  = 0
         LET l_xrca_t.xrca124  = 0
         LET l_xrca_t.xrca126  = 0
         LET l_xrca_t.xrca127  = 0
         LET l_xrca_t.xrca128  = 0
         LET l_xrca_t.xrca130  = g_glaa_t.glaa020
         LET l_xrca_t.xrca131  = l_rate3
         LET l_xrca_t.xrca133  = 0
         LET l_xrca_t.xrca134  = 0
         LET l_xrca_t.xrca136  = 0
         LET l_xrca_t.xrca137  = 0
         LET l_xrca_t.xrca138  = 0

         
         #161128-00061#3-----modify--begin----------
         #INSERT INTO xrca_t VALUES (l_xrca_t.*)
         INSERT INTO xrca_t (xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,
                             xrcacnfid,xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,
                             xrcadocdt,xrca001,xrcasite,xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,
                             xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,
                             xrca018,xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,
                             xrca028,xrca029,xrca030,xrca031,xrca032,xrca033,xrca034,xrca035,xrca036,
                             xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,
                             xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,xrca053,xrca054,
                             xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,xrca063,
                             xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,
                             xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,
                             xrca124,xrca126,xrca127,xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,
                             xrca137,xrca138)
          VALUES (l_xrca_t.xrcaent,l_xrca_t.xrcaownid,l_xrca_t.xrcaowndp,l_xrca_t.xrcacrtid,l_xrca_t.xrcacrtdp,l_xrca_t.xrcacrtdt,l_xrca_t.xrcamodid,l_xrca_t.xrcamoddt,
                  l_xrca_t.xrcacnfid,l_xrca_t.xrcacnfdt,l_xrca_t.xrcapstid,l_xrca_t.xrcapstdt,l_xrca_t.xrcastus,l_xrca_t.xrcacomp,l_xrca_t.xrcald,l_xrca_t.xrcadocno,
                  l_xrca_t.xrcadocdt,l_xrca_t.xrca001,l_xrca_t.xrcasite,l_xrca_t.xrca003,l_xrca_t.xrca004,l_xrca_t.xrca005,l_xrca_t.xrca006,l_xrca_t.xrca007,l_xrca_t.xrca008,
                  l_xrca_t.xrca009,l_xrca_t.xrca010,l_xrca_t.xrca011,l_xrca_t.xrca012,l_xrca_t.xrca013,l_xrca_t.xrca014,l_xrca_t.xrca015,l_xrca_t.xrca016,l_xrca_t.xrca017,
                  l_xrca_t.xrca018,l_xrca_t.xrca019,l_xrca_t.xrca020,l_xrca_t.xrca021,l_xrca_t.xrca022,l_xrca_t.xrca023,l_xrca_t.xrca024,l_xrca_t.xrca025,l_xrca_t.xrca026,
                  l_xrca_t.xrca028,l_xrca_t.xrca029,l_xrca_t.xrca030,l_xrca_t.xrca031,l_xrca_t.xrca032,l_xrca_t.xrca033,l_xrca_t.xrca034,l_xrca_t.xrca035,l_xrca_t.xrca036,
                  l_xrca_t.xrca037,l_xrca_t.xrca038,l_xrca_t.xrca039,l_xrca_t.xrca040,l_xrca_t.xrca041,l_xrca_t.xrca042,l_xrca_t.xrca043,l_xrca_t.xrca044,l_xrca_t.xrca045,
                  l_xrca_t.xrca046,l_xrca_t.xrca047,l_xrca_t.xrca048,l_xrca_t.xrca049,l_xrca_t.xrca050,l_xrca_t.xrca051,l_xrca_t.xrca052,l_xrca_t.xrca053,l_xrca_t.xrca054,
                  l_xrca_t.xrca055,l_xrca_t.xrca056,l_xrca_t.xrca057,l_xrca_t.xrca058,l_xrca_t.xrca059,l_xrca_t.xrca060,l_xrca_t.xrca061,l_xrca_t.xrca062,l_xrca_t.xrca063,
                  l_xrca_t.xrca064,l_xrca_t.xrca065,l_xrca_t.xrca066,l_xrca_t.xrca100,l_xrca_t.xrca101,l_xrca_t.xrca103,l_xrca_t.xrca104,l_xrca_t.xrca106,l_xrca_t.xrca107,
                  l_xrca_t.xrca108,l_xrca_t.xrca113,l_xrca_t.xrca114,l_xrca_t.xrca116,l_xrca_t.xrca117,l_xrca_t.xrca118,l_xrca_t.xrca120,l_xrca_t.xrca121,l_xrca_t.xrca123,
                  l_xrca_t.xrca124,l_xrca_t.xrca126,l_xrca_t.xrca127,l_xrca_t.xrca128,l_xrca_t.xrca130,l_xrca_t.xrca131,l_xrca_t.xrca133,l_xrca_t.xrca134,l_xrca_t.xrca136,
                  l_xrca_t.xrca137,l_xrca_t.xrca138)
         #161128-00061#3-----modify--end----------
      
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            LET g_success = 'N'
         END IF
         
      END IF

      IF l_flag1 = 1 THEN
         CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrcb_t.xrcb101,l_rate1)
            RETURNING l_xrcb111
         CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrcb_t.xrcb103,l_rate1)
            RETURNING l_xrcb113
         CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrcb_t.xrcb104,l_rate1)
            RETURNING l_xrcb114
         CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrcb_t.xrcb106,l_rate1)
            RETURNING l_xrcb116

         IF g_glaa_t.glaa015 = 'Y' THEN
            #計算本位幣二金額
            IF g_glaa_t.glaa017 = '1' THEN
               #换算基准:交易原幣
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa016,l_xrcb_t.xrcb103,l_rate2)
                  RETURNING l_xrcb123
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa016,l_xrcb_t.xrcb104,l_rate2)
                  RETURNING l_xrcb124
            ELSE
               #换算基准:帳簿幣別
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa016,l_xrcb_t.xrcb113,l_rate2)
                  RETURNING l_xrcb123
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa016,l_xrcb_t.xrcb114,l_rate2)
                  RETURNING l_xrcb124
            END IF
         END IF
         IF g_glaa_t.glaa019 = 'Y' THEN
            #計算本位幣三金額
            IF g_glaa_t.glaa021 = '1' THEN
               #换算基准:交易原幣
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa020,l_xrcb_t.xrcb103,l_rate3)
                  RETURNING l_xrcb133
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa020,l_xrcb_t.xrcb104,l_rate3)
                  RETURNING l_xrcb134
            ELSE
               #换算基准:帳簿幣別
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa020,l_xrcb_t.xrcb113,l_rate3)
                  RETURNING l_xrcb133
               CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa020,l_xrcb_t.xrcb114,l_rate3)
                  RETURNING l_xrcb134
            END IF
         END IF

         #xrcb_t
         LET l_xrcb_t.xrcbld  = g_xrcald
         LET l_xrcb_t.xrcb025 = NULL
         LET l_xrcb_t.xrcb026 = NULL
         LET l_xrcb_t.xrcb027 = NULL
         LET l_xrcb_t.xrcb028 = NULL
         LET l_xrcb_t.xrcb029 = l_8304_01
         LET l_xrcb_t.xrcb030 = 0
         LET l_xrcb_t.xrcb111 = l_xrcb111
         LET l_xrcb_t.xrcb113 = l_xrcb113
         LET l_xrcb_t.xrcb114 = l_xrcb114
         LET l_xrcb_t.xrcb115 = l_xrcb_t.xrcb113 + l_xrcb_t.xrcb114
         LET l_xrcb_t.xrcb116 = l_xrcb116
         LET l_xrcb_t.xrcb117 = 0
         LET l_xrcb_t.xrcb123 = l_xrcb123
         LET l_xrcb_t.xrcb124 = l_xrcb124
         LET l_xrcb_t.xrcb125 = l_xrcb_t.xrcb123 + l_xrcb_t.xrcb124
         LET l_xrcb_t.xrcb126 = 0
         LET l_xrcb_t.xrcb133 = l_xrcb133
         LET l_xrcb_t.xrcb134 = l_xrcb134
         LET l_xrcb_t.xrcb135 = l_xrcb_t.xrcb133 + l_xrcb_t.xrcb134
         LET l_xrcb_t.xrcb136 = 0

         #161128-00061#3-----modify--begin----------
        #INSERT INTO xrcb_t VALUES (l_xrcb_t.*)
         INSERT INTO xrcb_t (xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
                             xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
                             xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
                             xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
                             xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
                             xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
                             xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
                             xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
                             xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,
                             xrcb059,xrcb060,xrcb107)
          VALUES (l_xrcb_t.xrcbent,l_xrcb_t.xrcbld,l_xrcb_t.xrcbdocno,l_xrcb_t.xrcbseq,l_xrcb_t.xrcbsite,l_xrcb_t.xrcborga,l_xrcb_t.xrcb001,l_xrcb_t.xrcb002,l_xrcb_t.xrcb003,l_xrcb_t.xrcb004,
                  l_xrcb_t.xrcb005,l_xrcb_t.xrcb006,l_xrcb_t.xrcb007,l_xrcb_t.xrcb008,l_xrcb_t.xrcb009,l_xrcb_t.xrcblegl,l_xrcb_t.xrcb010,l_xrcb_t.xrcb011,l_xrcb_t.xrcb012,l_xrcb_t.xrcb013,
                  l_xrcb_t.xrcb014,l_xrcb_t.xrcb015,l_xrcb_t.xrcb016,l_xrcb_t.xrcb017,l_xrcb_t.xrcb018,l_xrcb_t.xrcb019,l_xrcb_t.xrcb020,l_xrcb_t.xrcb021,l_xrcb_t.xrcb022,l_xrcb_t.xrcb023,
                  l_xrcb_t.xrcb024,l_xrcb_t.xrcb025,l_xrcb_t.xrcb026,l_xrcb_t.xrcb027,l_xrcb_t.xrcb028,l_xrcb_t.xrcb029,l_xrcb_t.xrcb030,l_xrcb_t.xrcb031,l_xrcb_t.xrcb032,l_xrcb_t.xrcb033,
                  l_xrcb_t.xrcb034,l_xrcb_t.xrcb035,l_xrcb_t.xrcb036,l_xrcb_t.xrcb037,l_xrcb_t.xrcb038,l_xrcb_t.xrcb039,l_xrcb_t.xrcb040,l_xrcb_t.xrcb041,l_xrcb_t.xrcb042,l_xrcb_t.xrcb043,
                  l_xrcb_t.xrcb044,l_xrcb_t.xrcb045,l_xrcb_t.xrcb046,l_xrcb_t.xrcb047,l_xrcb_t.xrcb048,l_xrcb_t.xrcb049,l_xrcb_t.xrcb050,l_xrcb_t.xrcb051,l_xrcb_t.xrcb100,l_xrcb_t.xrcb101,
                  l_xrcb_t.xrcb102,l_xrcb_t.xrcb103,l_xrcb_t.xrcb104,l_xrcb_t.xrcb105,l_xrcb_t.xrcb106,l_xrcb_t.xrcb111,l_xrcb_t.xrcb113,l_xrcb_t.xrcb114,l_xrcb_t.xrcb115,l_xrcb_t.xrcb116,
                  l_xrcb_t.xrcb117,l_xrcb_t.xrcb118,l_xrcb_t.xrcb119,l_xrcb_t.xrcb121,l_xrcb_t.xrcb123,l_xrcb_t.xrcb124,l_xrcb_t.xrcb125,l_xrcb_t.xrcb126,l_xrcb_t.xrcb131,l_xrcb_t.xrcb133,
                  l_xrcb_t.xrcb134,l_xrcb_t.xrcb135,l_xrcb_t.xrcb136,l_xrcb_t.xrcb052,l_xrcb_t.xrcb053,l_xrcb_t.xrcb054,l_xrcb_t.xrcb055,l_xrcb_t.xrcb056,l_xrcb_t.xrcb057,l_xrcb_t.xrcb058,
                  l_xrcb_t.xrcb059,l_xrcb_t.xrcb060,l_xrcb_t.xrcb107)
         #161128-00061#3-----modify--end----------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            LET g_success = 'N'
         END IF
         
         UPDATE xrca_t SET xrca123 = xrca123 + l_xrcb_t.xrcb123,
                           xrca124 = xrca124 + l_xrcb_t.xrcb124,
                           xrca128 = xrca128 + l_xrcb_t.xrcb123 + l_xrcb_t.xrcb124,
                           xrca133 = xrca133 + l_xrcb_t.xrcb133,
                           xrca134 = xrca134 + l_xrcb_t.xrcb134,
                           xrca138 = xrca138 + l_xrcb_t.xrcb133 + l_xrcb_t.xrcb134
          WHERE xrcadocno = l_xrca_t.xrcadocno
            AND xrcald = g_xrcald
            AND xrcaent = g_enterprise #170122-00008#1 add
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            LET g_success = 'N'
         END IF

         #xrcd_t

         SELECT glab005 INTO l_xrcd009 FROM glab_t
          WHERE glabld   = g_xrcald 
            AND glab001  = '14' 
            AND glab002 = '2'              #-銷項
            AND glab003 = l_xrcd_t.xrcd002 #--稅別
            AND glabent = g_enterprise #170122-00008#1 add
         
         IF cl_null(l_xrcd009) THEN
            SELECT glab005 INTO l_xrcd009 FROM glab_t 
             WHERE glabld = g_xrcald 
               AND glab001 ='12' 
               AND glab002  ='9711' 
               AND glab003 = '9711_91' 
               AND glabent = g_enterprise #170122-00008#1 add
         END IF

         LET l_xrcd_t.xrcdld  = g_xrcald
         LET l_xrcd_t.xrcd009 = l_xrcd009
         LET l_xrcd_t.xrcd101 = l_rate1
         LET l_xrcd_t.xrcd112 = l_xrcd_t.xrcd102 * l_rate1
         LET l_xrcd_t.XRCD113 = l_xrcb_t.xrcb113
         LET l_xrcd_t.XRCD114 = l_xrcb_t.xrcb114
         LET l_xrcd_t.XRCD115 = l_xrcb_t.xrcb115
         LET l_xrcd_t.XRCD116 = 0
         LET l_xrcd_t.xrcd117 = 0
         LET l_xrcd_t.xrcd118 = 0
         LET l_xrcd_t.xrcd121 = l_rate2
         LET l_xrcd_t.xrcd124 = l_xrcb_t.xrcb124
         LET l_xrcd_t.xrcd131 = l_rate3
         LET l_xrcd_t.xrcd134 = l_xrcb_t.xrcb134

         #161128-00061#3-----modify--begin----------
         #INSERT INTO xrcd_t VALUES (l_xrcd_t.*)
          INSERT INTO xrcd_t (xrcdent,xrcdcomp,xrcdld,xrcdsite,xrcddocno,xrcdseq,xrcdseq2,xrcdorga,xrcd001,
                              xrcd002,xrcd003,xrcd004,xrcd005,xrcd006,xrcd007,xrcd008,xrcd009,xrcd010,xrcd100,
                              xrcd101,xrcd102,xrcd103,xrcd104,xrcd105,xrcd106,xrcd112,xrcd113,xrcd114,xrcd115,
                              xrcd116,xrcd117,xrcd118,xrcd121,xrcd124,xrcd131,xrcd134,xrcd123,xrcd125,xrcd133,
                              xrcd135,xrcd011,xrcd012,xrcd013)
           VALUES (l_xrcd_t.xrcdent,l_xrcd_t.xrcdcomp,l_xrcd_t.xrcdld,l_xrcd_t.xrcdsite,l_xrcd_t.xrcddocno,l_xrcd_t.xrcdseq,l_xrcd_t.xrcdseq2,l_xrcd_t.xrcdorga,l_xrcd_t.xrcd001,
                   l_xrcd_t.xrcd002,l_xrcd_t.xrcd003,l_xrcd_t.xrcd004,l_xrcd_t.xrcd005,l_xrcd_t.xrcd006,l_xrcd_t.xrcd007,l_xrcd_t.xrcd008,l_xrcd_t.xrcd009,l_xrcd_t.xrcd010,l_xrcd_t.xrcd100,
                   l_xrcd_t.xrcd101,l_xrcd_t.xrcd102,l_xrcd_t.xrcd103,l_xrcd_t.xrcd104,l_xrcd_t.xrcd105,l_xrcd_t.xrcd106,l_xrcd_t.xrcd112,l_xrcd_t.xrcd113,l_xrcd_t.xrcd114,l_xrcd_t.xrcd115,
                   l_xrcd_t.xrcd116,l_xrcd_t.xrcd117,l_xrcd_t.xrcd118,l_xrcd_t.xrcd121,l_xrcd_t.xrcd124,l_xrcd_t.xrcd131,l_xrcd_t.xrcd134,l_xrcd_t.xrcd123,l_xrcd_t.xrcd125,l_xrcd_t.xrcd133,
                   l_xrcd_t.xrcd135,l_xrcd_t.xrcd011,l_xrcd_t.xrcd012,l_xrcd_t.xrcd013)
         #161128-00061#3-----modify--begin----------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            LET g_success = 'N'
         END IF

      END IF

      #xrcc_t
      CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrcc_t.xrcc103,l_rate1)
         RETURNING l_xrcc113
      CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa001,l_xrcc_t.xrcc104,l_rate1)
         RETURNING l_xrcc114

      IF g_glaa_t.glaa015 = 'Y' THEN
         #計算本位幣二金額
         IF g_glaa_t.glaa017 = '1' THEN
            #换算基准:交易原幣
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa016,l_xrcc_t.xrcc103,l_rate2)
               RETURNING l_xrcc123
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa016,l_xrcc_t.xrcc104,l_rate2)
               RETURNING l_xrcc124
         ELSE
            #换算基准:帳簿幣別
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa016,l_xrcc_t.xrcc113,l_rate2)
               RETURNING l_xrcc123
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa016,l_xrcc_t.xrcc114,l_rate2)
               RETURNING l_xrcc124
         END IF
      END IF
      IF g_glaa_t.glaa019 = 'Y' THEN
         #計算本位幣三金額
         IF g_glaa_t.glaa021 = '1' THEN
            #换算基准:交易原幣
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa020,l_xrcc_t.xrcc103,l_rate3)
               RETURNING l_xrcc133
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,l_xrca_t.xrca100,g_glaa_t.glaa020,l_xrcc_t.xrcc104,l_rate3)
               RETURNING l_xrcc134
         ELSE
            #换算基准:帳簿幣別
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa020,l_xrcc_t.xrcc113,l_rate3)
               RETURNING l_xrcc133
            CALL axrp340_exrate(l_xrca_t.xrcadocdt,g_glaa_t.glaa001,g_glaa_t.glaa020,l_xrcc_t.xrcc114,l_rate3)
               RETURNING l_xrcc134
         END IF
      END IF

      LET l_xrcc_t.xrccld  = g_xrcald
      LET l_xrcc_t.xrcc101 = l_rate1
      LET l_xrcc_t.xrcc102 = 0
      LET l_xrcc_t.xrcc106 = 0
      LET l_xrcc_t.xrcc107 = 0
      LET l_xrcc_t.xrcc108 = l_xrcc_t.xrcc103 + l_xrcc_t.xrcc104
      LET l_xrcc_t.xrcc109 = 0
      LET l_xrcc_t.xrcc113 = l_xrcc113
      LET l_xrcc_t.xrcc114 = l_xrcc114
      LET l_xrcc_t.xrcc115 = l_xrcc_t.xrcc113 + l_xrcc_t.xrcc114
      LET l_xrcc_t.xrcc116 = 0
      LET l_xrcc_t.xrcc117 = 0
      LET l_xrcc_t.xrcc118 = l_xrcc_t.xrcc115
      LET l_xrcc_t.xrcc119 = 0
      LET l_xrcc_t.xrcc120 = g_glaa_t.glaa016
      LET l_xrcc_t.xrcc121 = l_rate2
      LET l_xrcc_t.xrcc122 = 0
      LET l_xrcc_t.xrcc123 = l_xrcc123
      LET l_xrcc_t.xrcc124 = l_xrcc124
      LET l_xrcc_t.xrcc125 = l_xrcc_t.xrcc123 + l_xrcc_t.xrcc124
      LET l_xrcc_t.xrcc126 = 0
      LET l_xrcc_t.xrcc127 = 0
      LET l_xrcc_t.xrcc128 = l_xrcc_t.xrcc125
      LET l_xrcc_t.xrcc129 = 0
      LET l_xrcc_t.xrcc130 = g_glaa_t.glaa020
      LET l_xrcc_t.xrcc131 = l_rate3
      LET l_xrcc_t.xrcc132 = 0
      LET l_xrcc_t.xrcc133 = l_xrcc133
      LET l_xrcc_t.xrcc134 = l_xrcc133
      LET l_xrcc_t.xrcc135 = l_xrcc_t.xrcc133 + l_xrcc_t.xrcc134
      LET l_xrcc_t.xrcc136 = 0
      LET l_xrcc_t.xrcc137 = 0
      LET l_xrcc_t.xrcc138 = l_xrcc_t.xrcc135
      LET l_xrcc_t.xrcc139 = 0

      #161128-00061#3-----modify--begin----------
      #INSERT INTO xrcc_t VALUES (l_xrcc_t.*)
      INSERT INTO xrcc_t (xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,
                          xrcc006,xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,
                          xrcc100,xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,
                          xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,
                          xrcc123,xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,
                          xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,xrcc138,xrcc139,xrcc015,xrcc016,xrcc017)
       VALUES (l_xrcc_t.xrccent,l_xrcc_t.xrccld,l_xrcc_t.xrcccomp,l_xrcc_t.xrccdocno,l_xrcc_t.xrccseq,l_xrcc_t.xrcc001,l_xrcc_t.xrcc002,l_xrcc_t.xrcc003,l_xrcc_t.xrcc004,l_xrcc_t.xrcc005,
               l_xrcc_t.xrcc006,l_xrcc_t.xrcclegl,l_xrcc_t.xrcc008,l_xrcc_t.xrcc009,l_xrcc_t.xrccsite,l_xrcc_t.xrcc010,l_xrcc_t.xrcc011,l_xrcc_t.xrcc012,l_xrcc_t.xrcc013,l_xrcc_t.xrcc014,
               l_xrcc_t.xrcc100,l_xrcc_t.xrcc101,l_xrcc_t.xrcc102,l_xrcc_t.xrcc103,l_xrcc_t.xrcc104,l_xrcc_t.xrcc105,l_xrcc_t.xrcc106,l_xrcc_t.xrcc107,l_xrcc_t.xrcc108,l_xrcc_t.xrcc109,
               l_xrcc_t.xrcc113,l_xrcc_t.xrcc114,l_xrcc_t.xrcc115,l_xrcc_t.xrcc116,l_xrcc_t.xrcc117,l_xrcc_t.xrcc118,l_xrcc_t.xrcc119,l_xrcc_t.xrcc120,l_xrcc_t.xrcc121,l_xrcc_t.xrcc122,
               l_xrcc_t.xrcc123,l_xrcc_t.xrcc124,l_xrcc_t.xrcc125,l_xrcc_t.xrcc126,l_xrcc_t.xrcc127,l_xrcc_t.xrcc128,l_xrcc_t.xrcc129,l_xrcc_t.xrcc130,l_xrcc_t.xrcc131,l_xrcc_t.xrcc132,
               l_xrcc_t.xrcc133,l_xrcc_t.xrcc134,l_xrcc_t.xrcc135,l_xrcc_t.xrcc136,l_xrcc_t.xrcc137,l_xrcc_t.xrcc138,l_xrcc_t.xrcc139,l_xrcc_t.xrcc015,l_xrcc_t.xrcc016,l_xrcc_t.xrcc017)
      #161128-00061#3-----modify--end----------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         LET g_success = 'N'
      END IF

   END FOREACH

   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
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
PRIVATE FUNCTION axrp340_exrate(p_ooan004,p_ooan002,p_ooan003,p_amount,p_tmp)
   DEFINE p_ooan004      LIKE ooan_t.ooan004
   DEFINE p_ooan002      LIKE ooan_t.ooan002
   DEFINE p_ooan003      LIKE ooan_t.ooan003
   DEFINE p_tmp          LIKE ooan_t.ooan005
   DEFINE p_amount       LIKE ooan_t.ooan005
   DEFINE p_t          LIKE ooan_t.ooan005
   DEFINE l_ooef014      LIKE ooef_t.ooef014
   DEFINE l_ooaj004      LIKE ooaj_t.ooaj004
   DEFINE l_ooaj005      LIKE ooaj_t.ooaj005
   #161128-00061#3-----modify--begin----------
   #DEFINE l_ooan         RECORD LIKE ooan_t.*
   DEFINE l_ooan RECORD  #日匯率資料檔
       ooanent LIKE ooan_t.ooanent, #企業編號
       ooan001 LIKE ooan_t.ooan001, #匯率參照表號
       ooan002 LIKE ooan_t.ooan002, #交易幣別
       ooan003 LIKE ooan_t.ooan003, #基礎幣別
       ooan004 LIKE ooan_t.ooan004, #日期
       ooan005 LIKE ooan_t.ooan005, #銀行買入匯率
       ooan006 LIKE ooan_t.ooan006, #銀行賣出匯率
       ooan007 LIKE ooan_t.ooan007, #銀行中價匯率
       ooan008 LIKE ooan_t.ooan008, #海關買入匯率
       ooan009 LIKE ooan_t.ooan009, #海關賣出匯率
       ooan010 LIKE ooan_t.ooan010, #更新時間
       ooan011 LIKE ooan_t.ooan011, #更新方式
       ooan012 LIKE ooan_t.ooan012, #交易貨幣批量
       ooan013 LIKE ooan_t.ooan013  #匯率輸入方式
       END RECORD

   #161128-00061#3-----modify--end----------
   DEFINE l_conv         LIKE type_t.chr1
   DEFINE l_rate         LIKE ooan_t.ooan005
   DEFINE l_ooan001      LIKE ooan_t.ooan001
   DEFINE l_success      LIKE type_t.num5

   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_glaa_t.glaacomp

   #1.取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
   CALL s_curr_sel_ooaj004(l_ooef014,p_ooan003)
        RETURNING l_ooaj004

   #2.取基础币种的汇率精度
   CALL s_curr_sel_ooaj005(l_ooef014,p_ooan003)
        RETURNING l_ooaj005

   #3.取汇率 & 汇率方向
   LET l_conv = '1'  #交易币种对基础币种
   #161128-00061#3-----modify--begin----------
   #SELECT ooan_t.* INTO l_ooan.*
    SELECT ooanent,ooan001,ooan002,ooan003,ooan004,ooan005,ooan006,ooan007,ooan008,
           ooan009,ooan010,ooan011,ooan012,ooan013 INTO l_ooan.*
   #161128-00061#3-----modify--end----------
     FROM ooan_t,ooam_t
    WHERE ooanent = g_enterprise
      AND ooan001 = g_glaa_t.glaa002   #汇率参照表号
      AND ooan002 = p_ooan002   #交易币种
      AND ooan003 = p_ooan003   #基础币种
      AND ooan004 = p_ooan004   #日期
      AND ooament = ooanent
      AND ooam001 = ooan001
      AND ooam003 = ooan003
      AND ooam004 = ooan004
      AND ooamstus = 'Y'
   IF SQLCA.sqlcode THEN
      #交易币种对基础币种的关系不存在时,反向查找
      #161128-00061#3-----modify--begin----------
      #SELECT ooan_t.* INTO l_ooan.*
       SELECT ooanent,ooan001,ooan002,ooan003,ooan004,ooan005,ooan006,ooan007,ooan008,
              ooan009,ooan010,ooan011,ooan012,ooan013 INTO l_ooan.*
      #161128-00061#3-----modify--end----------
        FROM ooan_t,ooam_t
       WHERE ooanent = g_enterprise
         AND ooan001 = g_glaa_t.glaa002   #汇率参照表号
         AND ooan002 = p_ooan003   #基础币种
         AND ooan003 = p_ooan002   #交易币种
         AND ooan004 = p_ooan004
         AND ooament = ooanent
         AND ooam001 = ooan001
         AND ooam003 = ooan003
         AND ooam004 = ooan004
         AND ooamstus = 'Y'
      IF NOT SQLCA.sqlcode THEN
         LET l_conv = '2'   #基础币种对交易币种
      END IF
   END IF

   #交易币种批量
   IF cl_null(l_ooan.ooan012) THEN LET l_ooan.ooan012 = 1 END IF
   
   #4.计算汇率
   #减少处理步骤,以便精确度降低
   IF l_conv = '1' THEN  #存在交易对基础币种的置换关系
      IF l_ooan.ooan013 = '1' OR cl_null(l_ooan.ooan013) THEN   #存在正向的汇率关系
         LET l_rate = p_tmp / l_ooan.ooan012 * p_amount
      ELSE               #若为反向时,要1除取得的汇率
         LET l_rate = 1 / p_tmp * l_ooan.ooan012 * p_amount
      END IF
   ELSE                  #存在基础对交易币种的转换关系
      IF l_ooan.ooan013 = '1' THEN
         LET l_rate = 1 / p_tmp * l_ooan.ooan012 * p_amount
      ELSE
         LET l_rate = p_tmp / l_ooan.ooan012 * p_amount
      END IF
   END IF

   #5.按精度进位小数取位
   IF p_amount > 1 THEN
      #传入的为金额,直接按ooaj004取位
     #CALL s_num_round('1',l_rate,l_ooaj004) RETURNING l_rate   #150821-00002#1 Mark
      CALL s_curr_round_ld('1',g_glaa_t.glaald,p_ooan002,l_rate,2) RETURNING l_success,g_errno,l_rate   #150821-00002#1 Add
   ELSE
      #没有传入金额,根据汇率的精度进行取位
     #CALL s_num_round('1',l_rate,l_ooaj005) RETURNING l_rate   #150821-00002#1 Mark
      CALL s_curr_round_ld('1',g_glaa_t.glaald,p_ooan002,l_rate,3) RETURNING l_success,g_errno,l_rate   #150821-00002#1 Add
   END IF

   RETURN l_rate

END FUNCTION

 
{</section>}
 
