#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:12(2014-12-08 16:31:16), PR版次:0012(2017-01-16 15:39:26)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000115
#+ Filename...: axrp920
#+ Description: 應收帳款重評價計算作業
#+ Creator....: 01727(2014-08-13 00:00:00)
#+ Modifier...: 01727 -SD/PR- 01531
 
{</section>}
 
{<section id="axrp920.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#151020-00003#4   2015/10/26 By Jessy  只能執行關帳年月對應之年度月份之資料
#151105-00014#1   2015/11/05 By 01727  重评价次月回转时,xreb116累积汇差金额计算错误  SELECT xreb115,xreb125,xreb135--->调整为  SELECT xreb116,xreb126,xreb136
#151125-00006#1   2015/12/05 By 06862  生成單據后立即審核，立即拋轉傳票
#160503-00022#1   2016/05/03 By 02097  增加xreg003的过滤条件
#160811-00009#4   2016/08/19 By 01531  账务中心/法人/账套权限控管
#160905-00002#7   2016/09/05 By 08171  SQL補上ent
#161021-00050#4   2016/10/24 By 08729  處理組織開窗
#161102-00011#1   2016/11/02 By 06821  sql錯誤導致匯率查不到,應補上and
#161104-00019#2   2016/11/22 By 01727  於 PREPARE axrp920_xrca_prep1 相關 SQL 取消 site 條件
#161212-00005#2   2016/12/14 by 02481  标准程式定义采用宣告模式,弃用.*写法
#170116-00037#1   2017/01/16 By 01531  ａｘｒｐ９２０，　ａａｐｐ９２０　調匯生時，如果沖銷參數＝３，　摘要給空值
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
PRIVATE TYPE type_g_xreb_d RECORD
       
       sel LIKE type_t.chr1, 
   xrebld LIKE xreb_t.xrebld, 
   xrebld_desc LIKE type_t.chr500, 
   xrebcomp LIKE xreb_t.xrebcomp, 
   xrebcomp_desc LIKE type_t.chr500, 
   xreb100 LIKE xreb_t.xreb100, 
   glav004 LIKE glav_t.glav004, 
   xreb008 LIKE xreb_t.xreb008, 
   glca002 LIKE type_t.chr500, 
   glca003 LIKE type_t.chr500, 
   xreg005 LIKE xreg_t.xreg005
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單头 type 宣告
 TYPE type_g_master RECORD
       b_site           LIKE xrcb_t.xrcbsite, 
       b_site_desc      LIKE ooefl_t.ooefl003,
       xref001          LIKE xref_t.xref001,
       xref002          LIKE xref_t.xref002
       END RECORD

#模組變數(Module Variables)
DEFINE g_master         type_g_master
DEFINE g_master_t       type_g_master
#161212-00005#2---modify-----begin-------------
#DEFINE g_glaa           RECORD LIKE glaa_t.*
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

#161212-00005#2---modify-----end-------------
DEFINE g_success        LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xreb_d            DYNAMIC ARRAY OF type_g_xreb_d
DEFINE g_xreb_d_t          type_g_xreb_d
 
 
 
 
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
 
{<section id="axrp920.main" >}
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
   DECLARE axrp920_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrp920_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrp920_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp920 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp920_init()   
 
      #進入選單 Menu (="N")
      CALL axrp920_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrp920
      
   END IF 
   
   CLOSE axrp920_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrp920.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrp920_init()
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
   
      CALL cl_set_combo_scc('b_glca002','8317') 
   CALL cl_set_combo_scc('b_glca003','40') 
  
 
   #add-point:畫面資料初始化 name="init.init"
  #CALL cl_set_combo_scc('xref001','9937') #1102 mark
   CALL s_fin_set_comp_scc('xref001','43')   #1102 add
   CALL s_fin_set_comp_scc('xref002','111') #1208 add     
   CALL cl_set_combo_scc('b_glca002','8317') 
   CALL cl_set_combo_scc('b_glca003','8724') 
   CALL s_fin_create_account_center_tmp()
   #end add-point
 
   CALL axrp920_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrp920.default_search" >}
PRIVATE FUNCTION axrp920_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrebld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xreb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xreb002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xreb003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xreb005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xreb006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xreb007 = '", g_argv[07], "' AND "
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
 
{<section id="axrp920.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp920_ui_dialog() 
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
   DEFINE l_xref001         LIKE xref_t.xref001
   DEFINE l_xref002         LIKE xref_t.xref002
   DEFINE l_site            LIKE xrcb_t.xrcbsite
   DEFINE l_success         LIKE type_t.chr1
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
   CALL axrp920_ui_dialog_1()
   RETURN
   #end add-point
 
   
   CALL axrp920_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xreb_d.clear()
 
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
 
         CALL axrp920_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.b_site,g_master.xref001,g_master.xref002

            BEFORE INPUT
               IF cl_null(g_master_t.b_site) THEN
                  CALL axrp920_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.b_site,g_master.b_site_desc,g_master.xref001,g_master.xref002
                    TO b_site,site_desc,xref001,xref002

            BEFORE FIELD b_site
               LET l_site = g_master.b_site

            AFTER FIELD b_site
               LET g_master.b_site_desc = ' '
               DISPLAY BY NAME g_master.b_site_desc
               IF NOT cl_null(g_master.b_site) THEN
                  #資料存在性、有效性檢查
                  LET g_errno = ' '
                  CALL s_fin_account_center_chk(g_master.b_site,'',3,g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.b_site
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL axrp920_site_desc()

            BEFORE FIELD xref001
               LET l_xref001 = g_master.xref001

            ON CHANGE xref001
               IF NOT cl_null(g_master.xref001) THEN
                 #02097--MARK(帳務中心跨法人，因此不可拿帳務中心所屬法人去檢核關帳日)
                 #CALL axrp920_date_chk()
                 #IF NOT cl_null(g_errno) THEN
                 #   LET g_errparam.extend = g_master.xref001
                 #   LET g_errparam.code   = g_errno
                 #   LET g_errparam.popup  = TRUE 
                 #   CALL cl_err()
                 #   #chenying add 1126
                 #   LET g_master.xref001 = l_xref001 
                 #   NEXT FIELD CURRENT 
                 #   #chenying add 1126                       
                 #END IF
                  #chenying add 1126
                  IF NOT cl_null(g_master.xref001) THEN
                     CALL axrp920_b_fill()
                  END IF            
                  #chenying add 1126                    
               END IF

            BEFORE FIELD xref002
               LET l_xref002 = g_master.xref002

            ON CHANGE xref002
               IF NOT cl_null(g_master.xref002) THEN
                 #CALL axrp920_date_chk()
                 #IF NOT cl_null(g_errno) THEN
                 #   LET g_errparam.extend = g_master.xref002
                 #   LET g_errparam.code   = g_errno
                 #   LET g_errparam.popup  = TRUE 
                 #   CALL cl_err()
                 #   #chenying add 1126
                 #   LET g_master.xref002 = l_xref002 
                 #   NEXT FIELD CURRENT 
                 #   #chenying add 1126                     
                 #END IF
                  #chenying add 1126
                  IF NOT cl_null(g_master.xref002) THEN
                     CALL axrp920_b_fill()
                  END IF            
                  #chenying add 1126                  
               END IF

            ON ACTION controlp INFIELD b_site
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.b_site       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 
               #CALL q_ooef001()                         #呼叫開窗  #161021-00050#4 mark
               LET g_qryparam.where = " ooefstus = 'Y' " #161021-00050#4 add
               CALL q_ooef001_46()                       #161021-00050#4 add
               LET g_master.b_site = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.b_site TO b_site               #顯示到畫面上
               CALL axrp920_site_desc()
               NEXT FIELD b_site                               #返回原欄位

         END INPUT  
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xreb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrp920_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrp920_b_fill2()
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
            CALL axrp920_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD b_site
            #end add-point
            NEXT FIELD site
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            LET g_master_t.* =  g_master.*
            CALL axrp920_b_fill()
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
            CALL axrp920_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xreb_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axrp920_b_fill()
 
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
            CALL axrp920_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrp920_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrp920_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrp920_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF NOT cl_null(g_xreb_d[li_idx].xreg005) OR g_xreb_d[li_idx].glca002 = '1' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'axr-00169'
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET g_xreb_d[li_idx].sel = "N"
               END IF
            END FOR
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF NOT cl_null(g_xreb_d[li_idx].xreg005) OR g_xreb_d[li_idx].glca002 = '1' THEN  #1027 xreb023-->xreg005
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'axr-00169'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_xreb_d[li_idx].sel = "N"
                  END IF
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
         ON ACTION batch_execute
            CALL axrp920_cycle_ld()

         ON ACTION click_sel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               CASE
                  WHEN g_xreb_d[li_idx].sel = 'N'
                     IF NOT cl_null(g_xreb_d[li_idx].xreg005) OR g_xreb_d[li_idx].glca002 = '1' THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axr-00169'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_xreb_d[li_idx].sel = "N"
                     ELSE
                        LET g_xreb_d[li_idx].sel = "Y"
                     END IF
                  WHEN g_xreb_d[li_idx].sel = 'Y'
                     LET g_xreb_d[li_idx].sel = "N"
               END CASE
            END FOR
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp920_filter()
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
            INITIALIZE g_master.* TO NULL
            CALL axrp920_def()
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrp920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp920_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_ooef017       LIKE ooef_t.ooef017
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_ld_str        STRING   #160811-00009#4
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
 
   CALL g_xreb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL s_axrt300_get_site(g_user,g_master.b_site,'2') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrebld")
   LET g_wc = g_wc CLIPPED,l_ld_str
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xrebld,'',xrebcomp,'',xreb100,'',xreb008,'','',''  ,DENSE_RANK() OVER( ORDER BY xreb_t.xrebld, 
       xreb_t.xreb001,xreb_t.xreb002,xreb_t.xreb003,xreb_t.xreb005,xreb_t.xreb006,xreb_t.xreb007) AS RANK FROM xreb_t", 
 
 
 
                     "",
                     " WHERE xrebent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xreb_t"),
                     " ORDER BY xreb_t.xrebld,xreb_t.xreb001,xreb_t.xreb002,xreb_t.xreb003,xreb_t.xreb005,xreb_t.xreb006,xreb_t.xreb007"
 
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
 
   LET g_sql = "SELECT '',xrebld,'',xrebcomp,'',xreb100,'',xreb008,'','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.b_site,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_ld_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL axrp920_get_xreald_wc(ls_wc) RETURNING ls_wc
   
   LET g_sql =" SELECT 'N',glaald,'',glaacomp,'',glaa001,'','',glca002,glca003,'' FROM glaa_t,glca_t ",
              "  WHERE glaaent = ? ",
              "    AND glaaent = glcaent ",
              "    AND glaald = glcald ",
              "    AND glca001 = 'AR' ",
              "    AND glca002 <> '1' ",    #無重評不撈出
              "    AND glaald IN ",ls_wc,    
              "  ORDER BY glaald,glaacomp "


   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrp920_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp920_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xreb_d[l_ac].sel,g_xreb_d[l_ac].xrebld,g_xreb_d[l_ac].xrebld_desc,g_xreb_d[l_ac].xrebcomp, 
       g_xreb_d[l_ac].xrebcomp_desc,g_xreb_d[l_ac].xreb100,g_xreb_d[l_ac].glav004,g_xreb_d[l_ac].xreb008, 
       g_xreb_d[l_ac].glca002,g_xreb_d[l_ac].glca003,g_xreb_d[l_ac].xreg005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL s_axrt300_xrca_ref('xrcald',g_xreb_d[l_ac].xrebld,'','')
         RETURNING l_success,g_xreb_d[l_ac].xrebld_desc
      LET g_xreb_d[l_ac].xrebld_desc = g_xreb_d[l_ac].xrebld,"(",g_xreb_d[l_ac].xrebld_desc,")"

      CALL s_axrt300_xrca_ref('xrcasite',g_xreb_d[l_ac].xrebcomp,'','')
         RETURNING l_success,g_xreb_d[l_ac].xrebcomp_desc
      LET g_xreb_d[l_ac].xrebcomp_desc = g_xreb_d[l_ac].xrebcomp,"(",g_xreb_d[l_ac].xrebcomp_desc,")"

      #已做重評價處理後,默認不勾選
      LET l_count = 0
      SELECT COUNT(*) INTO l_count FROM xreb_t WHERE xrebent = g_enterprise AND xrebld = g_xreb_d[l_ac].xrebld
         AND xreb001 = g_master.xref001 AND xreb002 = g_master.xref002 AND xreb003 = 'AR'
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count > 0 THEN LET g_xreb_d[l_ac].sel = 'N' END IF

#      SELECT glca002,glca003 INTO g_xreb_d[l_ac].glca002,g_xreb_d[l_ac].glca003 FROM glca_t
#       WHERE glcaent = g_enterprise
#         AND glcald = g_xreb_d[l_ac].xrebld
#         AND glca001 = 'AR'
 
#1027 --mark--str--
#      SELECT xreb023 INTO g_xreb_d[l_ac].xreb023 FROM xreb_t
#       WHERE xrebent = g_enterprise
#         AND xrebld  = g_xreb_d[l_ac].xrebld
#         AND xreb001 = g_master.xref001
#         AND xreb002 = g_master.xref002
#         AND xreb003 = 'AR'
#1027 --mark--end--
      #1027 --add--str---
      SELECT xreg005 INTO g_xreb_d[l_ac].xreg005 FROM xreg_t 
       WHERE xregent = g_enterprise AND xregld = g_xreb_d[l_ac].xrebld
         AND xreg002 = g_master.xref002
         AND xreg003 = 'AR'      #160503-00022#1
      #1027 --add--end---    
      IF NOT cl_null(g_xreb_d[l_ac].xreg005) OR g_xreb_d[l_ac].glca002 = '1' THEN LET g_xreb_d[l_ac].sel = 'N' END IF

      SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise
         AND glaald = g_xreb_d[l_ac].xrebld

      SELECT MIN(glav004) INTO g_xreb_d[l_ac].glav004 FROM glav_t WHERE glavent = g_enterprise
         AND glav001 = l_glaa003
         AND glav002 = g_master.xref001
         AND glav006 = g_master.xref002

      SELECT MAX(glav004) INTO g_xreb_d[l_ac].xreb008 FROM glav_t WHERE glavent = g_enterprise
         AND glav001 = l_glaa003
         AND glav002 = g_master.xref001
         AND glav006 = g_master.xref002
         
  

      #end add-point
 
      CALL axrp920_detail_show("'1'")
 
      CALL axrp920_xreb_t_mask()
 
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
 
   CALL g_xreb_d.deleteElement(g_xreb_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xreb_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axrp920_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrp920_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrp920_detail_action_trans()
 
   LET l_ac = 1
   IF g_xreb_d.getLength() > 0 THEN
      CALL axrp920_b_fill2()
   END IF
 
      CALL axrp920_filter_show('xrebld','b_xrebld')
   CALL axrp920_filter_show('xrebcomp','b_xrebcomp')
   CALL axrp920_filter_show('xreb100','b_xreb100')
   CALL axrp920_filter_show('glav004','b_glav004')
   CALL axrp920_filter_show('xreb008','b_xreb008')
   CALL axrp920_filter_show('xreg005','b_xreg005')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrp920.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp920_b_fill2()
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
 
{<section id="axrp920.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp920_detail_show(ps_page)
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
 
{<section id="axrp920.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrp920_filter()
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
      CONSTRUCT g_wc_filter ON xrebld,xrebcomp,xreb100,glav004,xreb008,xreg005
                          FROM s_detail1[1].b_xrebld,s_detail1[1].b_xrebcomp,s_detail1[1].b_xreb100, 
                              s_detail1[1].b_glav004,s_detail1[1].b_xreb008,s_detail1[1].b_xreg005
 
         BEFORE CONSTRUCT
                     DISPLAY axrp920_filter_parser('xrebld') TO s_detail1[1].b_xrebld
            DISPLAY axrp920_filter_parser('xrebcomp') TO s_detail1[1].b_xrebcomp
            DISPLAY axrp920_filter_parser('xreb100') TO s_detail1[1].b_xreb100
            DISPLAY axrp920_filter_parser('glav004') TO s_detail1[1].b_glav004
            DISPLAY axrp920_filter_parser('xreb008') TO s_detail1[1].b_xreb008
            DISPLAY axrp920_filter_parser('xreg005') TO s_detail1[1].b_xreg005
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrebld>>----
         #Ctrlp:construct.c.page1.b_xrebld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrebld
            #add-point:ON ACTION controlp INFIELD b_xrebld name="construct.c.filter.page1.b_xrebld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrebld  #顯示到畫面上
            NEXT FIELD b_xrebld                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrebld_desc>>----
         #----<<b_xrebcomp>>----
         #Ctrlp:construct.c.filter.page1.b_xrebcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrebcomp
            #add-point:ON ACTION controlp INFIELD b_xrebcomp name="construct.c.filter.page1.b_xrebcomp"
            
            #END add-point
 
 
         #----<<b_xrebcomp_desc>>----
         #----<<b_xreb100>>----
         #Ctrlp:construct.c.filter.page1.b_xreb100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb100
            #add-point:ON ACTION controlp INFIELD b_xreb100 name="construct.c.filter.page1.b_xreb100"
            
            #END add-point
 
 
         #----<<b_glav004>>----
         #Ctrlp:construct.c.filter.page1.b_glav004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glav004
            #add-point:ON ACTION controlp INFIELD b_glav004 name="construct.c.filter.page1.b_glav004"
            
            #END add-point
 
 
         #----<<b_xreb008>>----
         #Ctrlp:construct.c.filter.page1.b_xreb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb008
            #add-point:ON ACTION controlp INFIELD b_xreb008 name="construct.c.filter.page1.b_xreb008"
            
            #END add-point
 
 
         #----<<b_glca002>>----
         #----<<b_glca003>>----
         #----<<b_xreg005>>----
         #Ctrlp:construct.c.filter.page1.b_xreg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreg005
            #add-point:ON ACTION controlp INFIELD b_xreg005 name="construct.c.filter.page1.b_xreg005"
            
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
 
      CALL axrp920_filter_show('xrebld','b_xrebld')
   CALL axrp920_filter_show('xrebcomp','b_xrebcomp')
   CALL axrp920_filter_show('xreb100','b_xreb100')
   CALL axrp920_filter_show('glav004','b_glav004')
   CALL axrp920_filter_show('xreb008','b_xreb008')
   CALL axrp920_filter_show('xreg005','b_xreg005')
 
 
   CALL axrp920_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp920.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrp920_filter_parser(ps_field)
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
 
{<section id="axrp920.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp920_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp920_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrp920.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrp920_detail_action_trans()
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
 
{<section id="axrp920.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrp920_detail_index_setting()
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
            IF g_xreb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xreb_d.getLength() AND g_xreb_d.getLength() > 0
            LET g_detail_idx = g_xreb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xreb_d.getLength() THEN
               LET g_detail_idx = g_xreb_d.getLength()
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
 
{<section id="axrp920.mask_functions" >}
 &include "erp/axr/axrp920_mask.4gl"
 
{</section>}
 
{<section id="axrp920.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axrp920_site_desc()
   DEFINE l_success      LIKE type_t.chr1

   CALL s_axrt300_xrca_ref('xrcasite',g_master.b_site,'','') RETURNING l_success,g_master.b_site_desc
   DISPLAY g_master.b_site_desc TO site_desc
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
PRIVATE FUNCTION axrp920_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_xref001      LIKE xref_t.xref001
   DEFINE l_xref002      LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017

   IF cl_null(g_master.b_site) THEN RETURN END IF

   IF cl_null(g_master.xref001) THEN RETURN END IF

   IF cl_null(g_master.xref002) THEN RETURN END IF

   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET l_xref001 = YEAR(l_flag)
   LET l_xref002 = MONTH(l_flag)

   LET g_errno = ' '
   IF l_xref001 < g_master.xref001 THEN
      LET g_errno = 'axr-00162'
   END IF

   IF l_xref001 >= g_master.xref001 AND l_xref002 < g_master.xref002 THEN
      LET g_errno = 'axr-00163'
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
PRIVATE FUNCTION axrp920_def()
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_flag            LIKE type_t.dat
   DEFINE l_ooef017         LIKE ooef_t.ooef017

   IF NOT cl_null(g_master.b_site) THEN RETURN END IF

   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.b_site,g_errno
   CALL axrp920_site_desc()

   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET g_master.xref001 = YEAR(l_flag)
   LET g_master.xref002 = MONTH(l_flag)

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
PRIVATE FUNCTION axrp920_get_xreald_wc(p_wc)
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
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
   
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
PRIVATE FUNCTION axrp920_cycle_ld()
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_title     LIKE gzzd_t.gzzd005
   DEFINE l_flag      LIKE type_t.num5   #20150318 Add By 01727

   SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd001 = 'axrt300' AND gzzd002 = g_lang AND gzzd003 = 'lbl_xrcadocno'

   ##20150318 Add By 01727
   LET l_flag = FALSE
   FOR l_i = 1 TO g_xreb_d.getLength()
      IF g_xreb_d[l_i].sel = "Y" THEN
         LET l_flag = TRUE
      END IF
   END FOR
   IF NOT l_flag THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = "N"
      RETURN
   END IF
   ##20150318 Add By 01727

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET g_coll_title[1] = l_title
   LET g_success = 'Y'

   FOR l_i = 1 TO g_xreb_d.getLength()
      IF g_xreb_d[l_i].sel = "Y" THEN
         #161212-00005#2---modify-----begin------------- 
         #SELECT * INTO g_glaa.*
          SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                 glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                 glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                 glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                 glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                 glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
         #161212-00005#2---modify-----end-------------
         FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xreb_d[l_i].xrebld
         CALL axrp920_get_xreb(g_xreb_d[l_i].xrebld,g_xreb_d[l_i].xreb008)
      END IF
   END FOR

   IF g_success = 'N' THEN
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axm-00088'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()      
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
PRIVATE FUNCTION axrp920_get_xreb(p_ld,p_xreb008)
   DEFINE p_ld          LIKE xreb_t.xrebld
   DEFINE p_xreb008     LIKE xreb_t.xreb008
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   #161212-00005#2---modify-----begin-------------
   #DEFINE l_xrca        RECORD LIKE xrca_t.*
   #DEFINE l_xrcb        RECORD LIKE xrcb_t.*
   #DEFINE l_xrcc        RECORD LIKE xrcc_t.*
   #DEFINE l_xreb        RECORD LIKE xreb_t.*
   #DEFINE l_xred        RECORD LIKE xred_t.*
   #DEFINE l_xraf        RECORD LIKE xraf_t.*
   #DEFINE l_glca        RECORD LIKE glca_t.*
   #DEFINE l_glcb        RECORD LIKE glcb_t.*
   DEFINE l_xrca RECORD  #應收憑單單頭
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
       xrca138 LIKE xrca_t.xrca138, #本位幣三應收金額
       xrcaud001 LIKE xrca_t.xrcaud001, #自定義欄位(文字)001
       xrcaud002 LIKE xrca_t.xrcaud002, #自定義欄位(文字)002
       xrcaud003 LIKE xrca_t.xrcaud003, #自定義欄位(文字)003
       xrcaud004 LIKE xrca_t.xrcaud004, #自定義欄位(文字)004
       xrcaud005 LIKE xrca_t.xrcaud005, #自定義欄位(文字)005
       xrcaud006 LIKE xrca_t.xrcaud006, #自定義欄位(文字)006
       xrcaud007 LIKE xrca_t.xrcaud007, #自定義欄位(文字)007
       xrcaud008 LIKE xrca_t.xrcaud008, #自定義欄位(文字)008
       xrcaud009 LIKE xrca_t.xrcaud009, #自定義欄位(文字)009
       xrcaud010 LIKE xrca_t.xrcaud010, #自定義欄位(文字)010
       xrcaud011 LIKE xrca_t.xrcaud011, #自定義欄位(數字)011
       xrcaud012 LIKE xrca_t.xrcaud012, #自定義欄位(數字)012
       xrcaud013 LIKE xrca_t.xrcaud013, #自定義欄位(數字)013
       xrcaud014 LIKE xrca_t.xrcaud014, #自定義欄位(數字)014
       xrcaud015 LIKE xrca_t.xrcaud015, #自定義欄位(數字)015
       xrcaud016 LIKE xrca_t.xrcaud016, #自定義欄位(數字)016
       xrcaud017 LIKE xrca_t.xrcaud017, #自定義欄位(數字)017
       xrcaud018 LIKE xrca_t.xrcaud018, #自定義欄位(數字)018
       xrcaud019 LIKE xrca_t.xrcaud019, #自定義欄位(數字)019
       xrcaud020 LIKE xrca_t.xrcaud020, #自定義欄位(數字)020
       xrcaud021 LIKE xrca_t.xrcaud021, #自定義欄位(日期時間)021
       xrcaud022 LIKE xrca_t.xrcaud022, #自定義欄位(日期時間)022
       xrcaud023 LIKE xrca_t.xrcaud023, #自定義欄位(日期時間)023
       xrcaud024 LIKE xrca_t.xrcaud024, #自定義欄位(日期時間)024
       xrcaud025 LIKE xrca_t.xrcaud025, #自定義欄位(日期時間)025
       xrcaud026 LIKE xrca_t.xrcaud026, #自定義欄位(日期時間)026
       xrcaud027 LIKE xrca_t.xrcaud027, #自定義欄位(日期時間)027
       xrcaud028 LIKE xrca_t.xrcaud028, #自定義欄位(日期時間)028
       xrcaud029 LIKE xrca_t.xrcaud029, #自定義欄位(日期時間)029
       xrcaud030 LIKE xrca_t.xrcaud030  #自定義欄位(日期時間)030
       END RECORD
   DEFINE l_xrcb RECORD  #應收憑單單身
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
       xrcbud001 LIKE xrcb_t.xrcbud001, #自定義欄位(文字)001
       xrcbud002 LIKE xrcb_t.xrcbud002, #自定義欄位(文字)002
       xrcbud003 LIKE xrcb_t.xrcbud003, #自定義欄位(文字)003
       xrcbud004 LIKE xrcb_t.xrcbud004, #自定義欄位(文字)004
       xrcbud005 LIKE xrcb_t.xrcbud005, #自定義欄位(文字)005
       xrcbud006 LIKE xrcb_t.xrcbud006, #自定義欄位(文字)006
       xrcbud007 LIKE xrcb_t.xrcbud007, #自定義欄位(文字)007
       xrcbud008 LIKE xrcb_t.xrcbud008, #自定義欄位(文字)008
       xrcbud009 LIKE xrcb_t.xrcbud009, #自定義欄位(文字)009
       xrcbud010 LIKE xrcb_t.xrcbud010, #自定義欄位(文字)010
       xrcbud011 LIKE xrcb_t.xrcbud011, #自定義欄位(數字)011
       xrcbud012 LIKE xrcb_t.xrcbud012, #自定義欄位(數字)012
       xrcbud013 LIKE xrcb_t.xrcbud013, #自定義欄位(數字)013
       xrcbud014 LIKE xrcb_t.xrcbud014, #自定義欄位(數字)014
       xrcbud015 LIKE xrcb_t.xrcbud015, #自定義欄位(數字)015
       xrcbud016 LIKE xrcb_t.xrcbud016, #自定義欄位(數字)016
       xrcbud017 LIKE xrcb_t.xrcbud017, #自定義欄位(數字)017
       xrcbud018 LIKE xrcb_t.xrcbud018, #自定義欄位(數字)018
       xrcbud019 LIKE xrcb_t.xrcbud019, #自定義欄位(數字)019
       xrcbud020 LIKE xrcb_t.xrcbud020, #自定義欄位(數字)020
       xrcbud021 LIKE xrcb_t.xrcbud021, #自定義欄位(日期時間)021
       xrcbud022 LIKE xrcb_t.xrcbud022, #自定義欄位(日期時間)022
       xrcbud023 LIKE xrcb_t.xrcbud023, #自定義欄位(日期時間)023
       xrcbud024 LIKE xrcb_t.xrcbud024, #自定義欄位(日期時間)024
       xrcbud025 LIKE xrcb_t.xrcbud025, #自定義欄位(日期時間)025
       xrcbud026 LIKE xrcb_t.xrcbud026, #自定義欄位(日期時間)026
       xrcbud027 LIKE xrcb_t.xrcbud027, #自定義欄位(日期時間)027
       xrcbud028 LIKE xrcb_t.xrcbud028, #自定義欄位(日期時間)028
       xrcbud029 LIKE xrcb_t.xrcbud029, #自定義欄位(日期時間)029
       xrcbud030 LIKE xrcb_t.xrcbud030, #自定義欄位(日期時間)030
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
   DEFINE l_xrcc RECORD  #多帳期明細
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
       xrccud001 LIKE xrcc_t.xrccud001, #自定義欄位(文字)001
       xrccud002 LIKE xrcc_t.xrccud002, #自定義欄位(文字)002
       xrccud003 LIKE xrcc_t.xrccud003, #自定義欄位(文字)003
       xrccud004 LIKE xrcc_t.xrccud004, #自定義欄位(文字)004
       xrccud005 LIKE xrcc_t.xrccud005, #自定義欄位(文字)005
       xrccud006 LIKE xrcc_t.xrccud006, #自定義欄位(文字)006
       xrccud007 LIKE xrcc_t.xrccud007, #自定義欄位(文字)007
       xrccud008 LIKE xrcc_t.xrccud008, #自定義欄位(文字)008
       xrccud009 LIKE xrcc_t.xrccud009, #自定義欄位(文字)009
       xrccud010 LIKE xrcc_t.xrccud010, #自定義欄位(文字)010
       xrccud011 LIKE xrcc_t.xrccud011, #自定義欄位(數字)011
       xrccud012 LIKE xrcc_t.xrccud012, #自定義欄位(數字)012
       xrccud013 LIKE xrcc_t.xrccud013, #自定義欄位(數字)013
       xrccud014 LIKE xrcc_t.xrccud014, #自定義欄位(數字)014
       xrccud015 LIKE xrcc_t.xrccud015, #自定義欄位(數字)015
       xrccud016 LIKE xrcc_t.xrccud016, #自定義欄位(數字)016
       xrccud017 LIKE xrcc_t.xrccud017, #自定義欄位(數字)017
       xrccud018 LIKE xrcc_t.xrccud018, #自定義欄位(數字)018
       xrccud019 LIKE xrcc_t.xrccud019, #自定義欄位(數字)019
       xrccud020 LIKE xrcc_t.xrccud020, #自定義欄位(數字)020
       xrccud021 LIKE xrcc_t.xrccud021, #自定義欄位(日期時間)021
       xrccud022 LIKE xrcc_t.xrccud022, #自定義欄位(日期時間)022
       xrccud023 LIKE xrcc_t.xrccud023, #自定義欄位(日期時間)023
       xrccud024 LIKE xrcc_t.xrccud024, #自定義欄位(日期時間)024
       xrccud025 LIKE xrcc_t.xrccud025, #自定義欄位(日期時間)025
       xrccud026 LIKE xrcc_t.xrccud026, #自定義欄位(日期時間)026
       xrccud027 LIKE xrcc_t.xrccud027, #自定義欄位(日期時間)027
       xrccud028 LIKE xrcc_t.xrccud028, #自定義欄位(日期時間)028
       xrccud029 LIKE xrcc_t.xrccud029, #自定義欄位(日期時間)029
       xrccud030 LIKE xrcc_t.xrccud030, #自定義欄位(日期時間)030
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD
   DEFINE l_xreb RECORD  #重評價月結檔
       xrebent LIKE xreb_t.xrebent, #企業編號
       xrebcomp LIKE xreb_t.xrebcomp, #法人
       xrebsite LIKE xreb_t.xrebsite, #帳務中心
       xrebld LIKE xreb_t.xrebld, #帳套
       xreb001 LIKE xreb_t.xreb001, #年度
       xreb002 LIKE xreb_t.xreb002, #期別
       xreb003 LIKE xreb_t.xreb003, #來源模組
       xreb004 LIKE xreb_t.xreb004, #帳款單性質
       xreb005 LIKE xreb_t.xreb005, #單據號碼
       xreb006 LIKE xreb_t.xreb006, #項次
       xreb007 LIKE xreb_t.xreb007, #分期帳款序
       xreb008 LIKE xreb_t.xreb008, #立帳日期
       xreb009 LIKE xreb_t.xreb009, #帳款對象
       xreb010 LIKE xreb_t.xreb010, #收款對象
       xreb011 LIKE xreb_t.xreb011, #部門
       xreb012 LIKE xreb_t.xreb012, #責任中心
       xreb013 LIKE xreb_t.xreb013, #區域
       xreb014 LIKE xreb_t.xreb014, #客群
       xreb015 LIKE xreb_t.xreb015, #產品類別
       xreb016 LIKE xreb_t.xreb016, #人員
       xreb017 LIKE xreb_t.xreb017, #專案編號
       xreb018 LIKE xreb_t.xreb018, #WBS編號
       xreb019 LIKE xreb_t.xreb019, #應收科目
       xreborga LIKE xreb_t.xreborga, #來源組織
       xreb020 LIKE xreb_t.xreb020, #經營方式
       xreb021 LIKE xreb_t.xreb021, #通路
       xreb022 LIKE xreb_t.xreb022, #品牌
       xreb023 LIKE xreb_t.xreb023, #自由核算項一
       xreb024 LIKE xreb_t.xreb024, #自由核算項二
       xreb025 LIKE xreb_t.xreb025, #自由核算項三
       xreb026 LIKE xreb_t.xreb026, #自由核算項四
       xreb027 LIKE xreb_t.xreb027, #自由核算項五
       xreb028 LIKE xreb_t.xreb028, #自由核算項六
       xreb029 LIKE xreb_t.xreb029, #自由核算項七
       xreb030 LIKE xreb_t.xreb030, #自由核算項八
       xreb031 LIKE xreb_t.xreb031, #自由核算項九
       xreb032 LIKE xreb_t.xreb032, #自由核算項十
       xreb033 LIKE xreb_t.xreb033, #摘要
       xreb034 LIKE xreb_t.xreb034, #重評價會計科目
       xreb100 LIKE xreb_t.xreb100, #幣別
       xreb101 LIKE xreb_t.xreb101, #重評價匯率
       xreb102 LIKE xreb_t.xreb102, #上月重評匯率
       xreb103 LIKE xreb_t.xreb103, #本期原幣未沖金額
       xreb113 LIKE xreb_t.xreb113, #本期本幣未沖金額
       xreb114 LIKE xreb_t.xreb114, #本期重評價後本幣金額
       xreb115 LIKE xreb_t.xreb115, #本期匯差金額
       xreb116 LIKE xreb_t.xreb116, #本幣累計匯差
       xreb121 LIKE xreb_t.xreb121, #本位幣二重評價匯率
       xreb122 LIKE xreb_t.xreb122, #本位幣二上月重估匯率
       xreb123 LIKE xreb_t.xreb123, #本期本位幣二未沖金額
       xreb124 LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
       xreb125 LIKE xreb_t.xreb125, #本期本位幣二匯差金額
       xreb126 LIKE xreb_t.xreb126, #本位幣二累計匯差
       xreb131 LIKE xreb_t.xreb131, #本位幣三重評價匯率
       xreb132 LIKE xreb_t.xreb132, #本位幣三上月重估匯率
       xreb133 LIKE xreb_t.xreb133, #本期本位幣三未沖金額
       xreb134 LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
       xreb135 LIKE xreb_t.xreb135, #本期本位幣三匯差金額
       xreb136 LIKE xreb_t.xreb136, #本位幣三累計匯差
       xrebud001 LIKE xreb_t.xrebud001, #自定義欄位(文字)001
       xrebud002 LIKE xreb_t.xrebud002, #自定義欄位(文字)002
       xrebud003 LIKE xreb_t.xrebud003, #自定義欄位(文字)003
       xrebud004 LIKE xreb_t.xrebud004, #自定義欄位(文字)004
       xrebud005 LIKE xreb_t.xrebud005, #自定義欄位(文字)005
       xrebud006 LIKE xreb_t.xrebud006, #自定義欄位(文字)006
       xrebud007 LIKE xreb_t.xrebud007, #自定義欄位(文字)007
       xrebud008 LIKE xreb_t.xrebud008, #自定義欄位(文字)008
       xrebud009 LIKE xreb_t.xrebud009, #自定義欄位(文字)009
       xrebud010 LIKE xreb_t.xrebud010, #自定義欄位(文字)010
       xrebud011 LIKE xreb_t.xrebud011, #自定義欄位(數字)011
       xrebud012 LIKE xreb_t.xrebud012, #自定義欄位(數字)012
       xrebud013 LIKE xreb_t.xrebud013, #自定義欄位(數字)013
       xrebud014 LIKE xreb_t.xrebud014, #自定義欄位(數字)014
       xrebud015 LIKE xreb_t.xrebud015, #自定義欄位(數字)015
       xrebud016 LIKE xreb_t.xrebud016, #自定義欄位(數字)016
       xrebud017 LIKE xreb_t.xrebud017, #自定義欄位(數字)017
       xrebud018 LIKE xreb_t.xrebud018, #自定義欄位(數字)018
       xrebud019 LIKE xreb_t.xrebud019, #自定義欄位(數字)019
       xrebud020 LIKE xreb_t.xrebud020, #自定義欄位(數字)020
       xrebud021 LIKE xreb_t.xrebud021, #自定義欄位(日期時間)021
       xrebud022 LIKE xreb_t.xrebud022, #自定義欄位(日期時間)022
       xrebud023 LIKE xreb_t.xrebud023, #自定義欄位(日期時間)023
       xrebud024 LIKE xreb_t.xrebud024, #自定義欄位(日期時間)024
       xrebud025 LIKE xreb_t.xrebud025, #自定義欄位(日期時間)025
       xrebud026 LIKE xreb_t.xrebud026, #自定義欄位(日期時間)026
       xrebud027 LIKE xreb_t.xrebud027, #自定義欄位(日期時間)027
       xrebud028 LIKE xreb_t.xrebud028, #自定義欄位(日期時間)028
       xrebud029 LIKE xreb_t.xrebud029, #自定義欄位(日期時間)029
       xrebud030 LIKE xreb_t.xrebud030  #自定義欄位(日期時間)030
       END RECORD
   DEFINE l_xred RECORD  #帳齡分析月結檔
       xredent LIKE xred_t.xredent, #企業編號
       xredcomp LIKE xred_t.xredcomp, #法人
       xredsite LIKE xred_t.xredsite, #帳務中心
       xredld LIKE xred_t.xredld, #帳套
       xred001 LIKE xred_t.xred001, #年度
       xred002 LIKE xred_t.xred002, #期別
       xred003 LIKE xred_t.xred003, #來源模組
       xred004 LIKE xred_t.xred004, #帳款單性質
       xred005 LIKE xred_t.xred005, #單據號碼
       xred006 LIKE xred_t.xred006, #項次
       xred007 LIKE xred_t.xred007, #分期期別
       xred008 LIKE xred_t.xred008, #應兌現日
       xred009 LIKE xred_t.xred009, #逾期天數
       xred010 LIKE xred_t.xred010, #信評等級
       xred011 LIKE xred_t.xred011, #帳齡起算日
       xred012 LIKE xred_t.xred012, #壞帳提列比率
       xred013 LIKE xred_t.xred013, #帳齡天數
       xred014 LIKE xred_t.xred014, #提列壞帳準備否
       xred015 LIKE xred_t.xred015, #壞帳提列傳票號碼
       xred016 LIKE xred_t.xred016, #來源組織
       xred103 LIKE xred_t.xred103, #原幣扣抵金額
       xred104 LIKE xred_t.xred104, #原幣壞帳提列數
       xred105 LIKE xred_t.xred105, #原幣傳票提列數
       xred113 LIKE xred_t.xred113, #本幣扣抵金額
       xred114 LIKE xred_t.xred114, #本幣壞帳提列數
       xred115 LIKE xred_t.xred115, #本幣傳票提列數
       xred123 LIKE xred_t.xred123, #本位幣二扣抵金額
       xred124 LIKE xred_t.xred124, #本位幣二壞帳提列數
       xred125 LIKE xred_t.xred125, #本位幣二傳票提列數
       xred133 LIKE xred_t.xred133, #本位幣三扣抵金額
       xred134 LIKE xred_t.xred134, #本位幣三壞帳提列數
       xred135 LIKE xred_t.xred135, #本位幣三傳票提列數
       xredud001 LIKE xred_t.xredud001, #自定義欄位(文字)001
       xredud002 LIKE xred_t.xredud002, #自定義欄位(文字)002
       xredud003 LIKE xred_t.xredud003, #自定義欄位(文字)003
       xredud004 LIKE xred_t.xredud004, #自定義欄位(文字)004
       xredud005 LIKE xred_t.xredud005, #自定義欄位(文字)005
       xredud006 LIKE xred_t.xredud006, #自定義欄位(文字)006
       xredud007 LIKE xred_t.xredud007, #自定義欄位(文字)007
       xredud008 LIKE xred_t.xredud008, #自定義欄位(文字)008
       xredud009 LIKE xred_t.xredud009, #自定義欄位(文字)009
       xredud010 LIKE xred_t.xredud010, #自定義欄位(文字)010
       xredud011 LIKE xred_t.xredud011, #自定義欄位(數字)011
       xredud012 LIKE xred_t.xredud012, #自定義欄位(數字)012
       xredud013 LIKE xred_t.xredud013, #自定義欄位(數字)013
       xredud014 LIKE xred_t.xredud014, #自定義欄位(數字)014
       xredud015 LIKE xred_t.xredud015, #自定義欄位(數字)015
       xredud016 LIKE xred_t.xredud016, #自定義欄位(數字)016
       xredud017 LIKE xred_t.xredud017, #自定義欄位(數字)017
       xredud018 LIKE xred_t.xredud018, #自定義欄位(數字)018
       xredud019 LIKE xred_t.xredud019, #自定義欄位(數字)019
       xredud020 LIKE xred_t.xredud020, #自定義欄位(數字)020
       xredud021 LIKE xred_t.xredud021, #自定義欄位(日期時間)021
       xredud022 LIKE xred_t.xredud022, #自定義欄位(日期時間)022
       xredud023 LIKE xred_t.xredud023, #自定義欄位(日期時間)023
       xredud024 LIKE xred_t.xredud024, #自定義欄位(日期時間)024
       xredud025 LIKE xred_t.xredud025, #自定義欄位(日期時間)025
       xredud026 LIKE xred_t.xredud026, #自定義欄位(日期時間)026
       xredud027 LIKE xred_t.xredud027, #自定義欄位(日期時間)027
       xredud028 LIKE xred_t.xredud028, #自定義欄位(日期時間)028
       xredud029 LIKE xred_t.xredud029, #自定義欄位(日期時間)029
       xredud030 LIKE xred_t.xredud030  #自定義欄位(日期時間)030
       END RECORD
   DEFINE l_xraf RECORD  #壞帳提列率依信評級設定檔
       xrafent LIKE xraf_t.xrafent, #企業編號
       xraf001 LIKE xraf_t.xraf001, #帳齡類型編號
       xraf002 LIKE xraf_t.xraf002, #信評等級
       xraf003 LIKE xraf_t.xraf003, #分段一壞帳提列率
       xraf004 LIKE xraf_t.xraf004, #分段二壞帳提列率
       xraf005 LIKE xraf_t.xraf005, #分段三壞帳提列率
       xraf006 LIKE xraf_t.xraf006, #分段四壞帳提列率
       xraf007 LIKE xraf_t.xraf007, #分段五壞帳提列率
       xraf008 LIKE xraf_t.xraf008, #分段六壞帳提列率
       xraf009 LIKE xraf_t.xraf009, #分段七壞帳提列率
       xraf010 LIKE xraf_t.xraf010, #分段八壞帳提列率
       xraf011 LIKE xraf_t.xraf011, #分段九壞帳提列率
       xraf012 LIKE xraf_t.xraf012, #分段十壞帳提列率
       xraf013 LIKE xraf_t.xraf013, #分段十一壞帳提列率
       xraf014 LIKE xraf_t.xraf014, #分段十二壞帳提列率
       xraf015 LIKE xraf_t.xraf015, #分段十三壞帳提列率
       xraf016 LIKE xraf_t.xraf016, #分段十四壞帳提列率
       xraf017 LIKE xraf_t.xraf017, #分段十五壞帳提列率
       xraf018 LIKE xraf_t.xraf018, #分段十六壞帳提列率
       xraf019 LIKE xraf_t.xraf019, #分段十七壞帳提列率
       xraf020 LIKE xraf_t.xraf020, #分段十八壞帳提列率
       xraf021 LIKE xraf_t.xraf021, #分段十九壞帳提列率
       xraf022 LIKE xraf_t.xraf022, #分段二十壞帳提列率
       xrafud001 LIKE xraf_t.xrafud001, #自定義欄位(文字)001
       xrafud002 LIKE xraf_t.xrafud002, #自定義欄位(文字)002
       xrafud003 LIKE xraf_t.xrafud003, #自定義欄位(文字)003
       xrafud004 LIKE xraf_t.xrafud004, #自定義欄位(文字)004
       xrafud005 LIKE xraf_t.xrafud005, #自定義欄位(文字)005
       xrafud006 LIKE xraf_t.xrafud006, #自定義欄位(文字)006
       xrafud007 LIKE xraf_t.xrafud007, #自定義欄位(文字)007
       xrafud008 LIKE xraf_t.xrafud008, #自定義欄位(文字)008
       xrafud009 LIKE xraf_t.xrafud009, #自定義欄位(文字)009
       xrafud010 LIKE xraf_t.xrafud010, #自定義欄位(文字)010
       xrafud011 LIKE xraf_t.xrafud011, #自定義欄位(數字)011
       xrafud012 LIKE xraf_t.xrafud012, #自定義欄位(數字)012
       xrafud013 LIKE xraf_t.xrafud013, #自定義欄位(數字)013
       xrafud014 LIKE xraf_t.xrafud014, #自定義欄位(數字)014
       xrafud015 LIKE xraf_t.xrafud015, #自定義欄位(數字)015
       xrafud016 LIKE xraf_t.xrafud016, #自定義欄位(數字)016
       xrafud017 LIKE xraf_t.xrafud017, #自定義欄位(數字)017
       xrafud018 LIKE xraf_t.xrafud018, #自定義欄位(數字)018
       xrafud019 LIKE xraf_t.xrafud019, #自定義欄位(數字)019
       xrafud020 LIKE xraf_t.xrafud020, #自定義欄位(數字)020
       xrafud021 LIKE xraf_t.xrafud021, #自定義欄位(日期時間)021
       xrafud022 LIKE xraf_t.xrafud022, #自定義欄位(日期時間)022
       xrafud023 LIKE xraf_t.xrafud023, #自定義欄位(日期時間)023
       xrafud024 LIKE xraf_t.xrafud024, #自定義欄位(日期時間)024
       xrafud025 LIKE xraf_t.xrafud025, #自定義欄位(日期時間)025
       xrafud026 LIKE xraf_t.xrafud026, #自定義欄位(日期時間)026
       xrafud027 LIKE xraf_t.xrafud027, #自定義欄位(日期時間)027
       xrafud028 LIKE xraf_t.xrafud028, #自定義欄位(日期時間)028
       xrafud029 LIKE xraf_t.xrafud029, #自定義欄位(日期時間)029
       xrafud030 LIKE xraf_t.xrafud030  #自定義欄位(日期時間)030
       END RECORD
   DEFINE l_glca RECORD  #帳套別重評價設定檔
       glcaent LIKE glca_t.glcaent, #企業編號
       glcald LIKE glca_t.glcald, #帳套別編號
       glca001 LIKE glca_t.glca001, #子模組編號
       glca002 LIKE glca_t.glca002, #重評價處理模式
       glca003 LIKE glca_t.glca003, #重評價匯率
       glca004 LIKE glca_t.glca004, #扣抵專案減除否
       glca005 LIKE glca_t.glca005, #暫估款納入評價否
       glca006 LIKE glca_t.glca006, #現行重評價年度
       glca007 LIKE glca_t.glca007, #現行重評價月份
       glcaud001 LIKE glca_t.glcaud001, #自定義欄位(文字)001
       glcaud002 LIKE glca_t.glcaud002, #自定義欄位(文字)002
       glcaud003 LIKE glca_t.glcaud003, #自定義欄位(文字)003
       glcaud004 LIKE glca_t.glcaud004, #自定義欄位(文字)004
       glcaud005 LIKE glca_t.glcaud005, #自定義欄位(文字)005
       glcaud006 LIKE glca_t.glcaud006, #自定義欄位(文字)006
       glcaud007 LIKE glca_t.glcaud007, #自定義欄位(文字)007
       glcaud008 LIKE glca_t.glcaud008, #自定義欄位(文字)008
       glcaud009 LIKE glca_t.glcaud009, #自定義欄位(文字)009
       glcaud010 LIKE glca_t.glcaud010, #自定義欄位(文字)010
       glcaud011 LIKE glca_t.glcaud011, #自定義欄位(數字)011
       glcaud012 LIKE glca_t.glcaud012, #自定義欄位(數字)012
       glcaud013 LIKE glca_t.glcaud013, #自定義欄位(數字)013
       glcaud014 LIKE glca_t.glcaud014, #自定義欄位(數字)014
       glcaud015 LIKE glca_t.glcaud015, #自定義欄位(數字)015
       glcaud016 LIKE glca_t.glcaud016, #自定義欄位(數字)016
       glcaud017 LIKE glca_t.glcaud017, #自定義欄位(數字)017
       glcaud018 LIKE glca_t.glcaud018, #自定義欄位(數字)018
       glcaud019 LIKE glca_t.glcaud019, #自定義欄位(數字)019
       glcaud020 LIKE glca_t.glcaud020, #自定義欄位(數字)020
       glcaud021 LIKE glca_t.glcaud021, #自定義欄位(日期時間)021
       glcaud022 LIKE glca_t.glcaud022, #自定義欄位(日期時間)022
       glcaud023 LIKE glca_t.glcaud023, #自定義欄位(日期時間)023
       glcaud024 LIKE glca_t.glcaud024, #自定義欄位(日期時間)024
       glcaud025 LIKE glca_t.glcaud025, #自定義欄位(日期時間)025
       glcaud026 LIKE glca_t.glcaud026, #自定義欄位(日期時間)026
       glcaud027 LIKE glca_t.glcaud027, #自定義欄位(日期時間)027
       glcaud028 LIKE glca_t.glcaud028, #自定義欄位(日期時間)028
       glcaud029 LIKE glca_t.glcaud029, #自定義欄位(日期時間)029
       glcaud030 LIKE glca_t.glcaud030  #自定義欄位(日期時間)030
       END RECORD
   DEFINE l_glcb RECORD  #帳套別壞帳準備設定檔
       glcbent LIKE glcb_t.glcbent, #企業編號
       glcbld LIKE glcb_t.glcbld, #帳套別編號
       glcb001 LIKE glcb_t.glcb001, #子模組編號
       glcb002 LIKE glcb_t.glcb002, #壞帳準備提列方式
       glcb003 LIKE glcb_t.glcb003, #帳齡類型
       glcb004 LIKE glcb_t.glcb004, #提列限額額比率
       glcb005 LIKE glcb_t.glcb005, #現行重評價年度
       glcb006 LIKE glcb_t.glcb006, #現行重評價月份
       glcb007 LIKE glcb_t.glcb007, #暫估類帳款納入分析否
       glcb008 LIKE glcb_t.glcb008, #待抵及帳款減項扣除
       glcbud001 LIKE glcb_t.glcbud001, #自定義欄位(文字)001
       glcbud002 LIKE glcb_t.glcbud002, #自定義欄位(文字)002
       glcbud003 LIKE glcb_t.glcbud003, #自定義欄位(文字)003
       glcbud004 LIKE glcb_t.glcbud004, #自定義欄位(文字)004
       glcbud005 LIKE glcb_t.glcbud005, #自定義欄位(文字)005
       glcbud006 LIKE glcb_t.glcbud006, #自定義欄位(文字)006
       glcbud007 LIKE glcb_t.glcbud007, #自定義欄位(文字)007
       glcbud008 LIKE glcb_t.glcbud008, #自定義欄位(文字)008
       glcbud009 LIKE glcb_t.glcbud009, #自定義欄位(文字)009
       glcbud010 LIKE glcb_t.glcbud010, #自定義欄位(文字)010
       glcbud011 LIKE glcb_t.glcbud011, #自定義欄位(數字)011
       glcbud012 LIKE glcb_t.glcbud012, #自定義欄位(數字)012
       glcbud013 LIKE glcb_t.glcbud013, #自定義欄位(數字)013
       glcbud014 LIKE glcb_t.glcbud014, #自定義欄位(數字)014
       glcbud015 LIKE glcb_t.glcbud015, #自定義欄位(數字)015
       glcbud016 LIKE glcb_t.glcbud016, #自定義欄位(數字)016
       glcbud017 LIKE glcb_t.glcbud017, #自定義欄位(數字)017
       glcbud018 LIKE glcb_t.glcbud018, #自定義欄位(數字)018
       glcbud019 LIKE glcb_t.glcbud019, #自定義欄位(數字)019
       glcbud020 LIKE glcb_t.glcbud020, #自定義欄位(數字)020
       glcbud021 LIKE glcb_t.glcbud021, #自定義欄位(日期時間)021
       glcbud022 LIKE glcb_t.glcbud022, #自定義欄位(日期時間)022
       glcbud023 LIKE glcb_t.glcbud023, #自定義欄位(日期時間)023
       glcbud024 LIKE glcb_t.glcbud024, #自定義欄位(日期時間)024
       glcbud025 LIKE glcb_t.glcbud025, #自定義欄位(日期時間)025
       glcbud026 LIKE glcb_t.glcbud026, #自定義欄位(日期時間)026
       glcbud027 LIKE glcb_t.glcbud027, #自定義欄位(日期時間)027
       glcbud028 LIKE glcb_t.glcbud028, #自定義欄位(日期時間)028
       glcbud029 LIKE glcb_t.glcbud029, #自定義欄位(日期時間)029
       glcbud030 LIKE glcb_t.glcbud030  #自定義欄位(日期時間)030
       END RECORD
   #161212-00005#2---modify-----end-------------
   DEFINE l_glcb003     LIKE glcb_t.glcb003
   DEFINE l_xreb023     LIKE xreb_t.xreb023
   DEFINE l_pmab004     LIKE pmab_t.pmab004
   DEFINE l_xred011     LIKE xred_t.xred011
   DEFINE l_xred012     LIKE xred_t.xred012
   DEFINE l_xred013     LIKE xred_t.xred013
   DEFINE l_xrae002     LIKE xrae_t.xrae002
   DEFINE l_glac004     LIKE glac_t.glac004
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_xreb101     LIKE xreb_t.xreb101
   DEFINE l_xreb121     LIKE xreb_t.xreb121
   DEFINE l_xreb131     LIKE xreb_t.xreb131
   DEFINE l_xreb103     LIKE xreb_t.xreb103
   DEFINE l_xred105     LIKE xred_t.xred105
   DEFINE l_xreb113     LIKE xreb_t.xreb113
   DEFINE l_xreb114     LIKE xreb_t.xreb114
   DEFINE l_xreb123     LIKE xreb_t.xreb123
   DEFINE l_xreb124     LIKE xreb_t.xreb124
   DEFINE l_xreb133     LIKE xreb_t.xreb133
   DEFINE l_xreb134     LIKE xreb_t.xreb134
   DEFINE l_glca002     LIKE glca_t.glca002
   DEFINE l_xreb116     LIKE xreb_t.xreb116
   DEFINE l_xreb126     LIKE xreb_t.xreb126
   DEFINE l_xreb136     LIKE xreb_t.xreb136
   DEFINE l_xred115     LIKE xred_t.xred115
   DEFINE l_xred125     LIKE xred_t.xred125
   DEFINE l_xred135     LIKE xred_t.xred135
   DEFINE l_xreb115_t   LIKE xreb_t.xreb115
   DEFINE l_xreb125_t   LIKE xreb_t.xreb125
   DEFINE l_xreb135_t   LIKE xreb_t.xreb135
   DEFINE l_xred105_t   LIKE xred_t.xred105
   DEFINE l_xred115_t   LIKE xred_t.xred115
   DEFINE l_xred125_t   LIKE xred_t.xred125
   DEFINE l_xred135_t   LIKE xred_t.xred135
   DEFINE l_ooef019     LIKE ooef_t.ooef019
   DEFINE l_ooef015     LIKE ooef_t.ooef015
   DEFINE l_ooef014     LIKE ooef_t.ooef014
   DEFINE l_glav006     LIKE glav_t.glav006
   DEFINE l_xrcf104     LIKE xrcf_t.xrcf104
   DEFINE l_xrcf114     LIKE xrcf_t.xrcf114
   DEFINE l_xrcf124     LIKE xrcf_t.xrcf124
   DEFINE l_xrcf134     LIKE xrcf_t.xrcf134
   DEFINE l_ooaj004     LIKE ooaj_t.ooaj004
   DEFINE l_xred009     LIKE xred_t.xred009
   DEFINE l_xred014     LIKE xred_t.xred014
   DEFINE l_flag        LIKE type_t.chr1     #1027 add
   DEFINE l_ooeg004     LIKE ooeg_t.ooeg004  #1027 add
   DEFINE l_xreb116_sum LIKE xreb_t.xreb116  #1027 add
   DEFINE l_xreb126_sum LIKE xreb_t.xreb126  #1027 add
   DEFINE l_xreb136_sum LIKE xreb_t.xreb136  #1027 add  
   DEFINE l_glaa001     LIKE glaa_t.glaa001  #1027 add
#20141216 add by chenying    
   DEFINE l_glaa003     LIKE glaa_t.glaa003   
   DEFINE l_glaa016     LIKE glaa_t.glaa016   
   DEFINE l_glaa017     LIKE glaa_t.glaa017  
   DEFINE l_last_y         LIKE type_t.num5
   DEFINE l_last_m         LIKE type_t.num5   
#20141216 add by chenying
   DEFINE l_xreb004_str   STRING

   #161212-00005#2---modify-----begin-------------
   #SELECT * INTO l_glcb.* 
    SELECT glcbent,glcbld,glcb001,glcb002,glcb003,glcb004,glcb005,glcb006,glcb007,glcb008,glcbud001,glcbud002,
           glcbud003,glcbud004,glcbud005,glcbud006,glcbud007,glcbud008,glcbud009,glcbud010,glcbud011,glcbud012,
           glcbud013,glcbud014,glcbud015,glcbud016,glcbud017,glcbud018,glcbud019,glcbud020,glcbud021,glcbud022,
           glcbud023,glcbud024,glcbud025,glcbud026,glcbud027,glcbud028,glcbud029,glcbud030 INTO l_glcb.* 
   #161212-00005#2---modify-----end-------------
   FROM glcb_t WHERE glcbent = g_enterprise AND glcbld = p_ld AND glcb001 = 'AR'
   #161212-00005#2---modify-----begin-------------
   #SELECT * INTO l_glca.* 
   SELECT glcaent,glcald,glca001,glca002,glca003,glca004,glca005,glca006,glca007,glcaud001,glcaud002,glcaud003,
          glcaud004,glcaud005,glcaud006,glcaud007,glcaud008,glcaud009,glcaud010,glcaud011,glcaud012,glcaud013,
          glcaud014,glcaud015,glcaud016,glcaud017,glcaud018,glcaud019,glcaud020,glcaud021,glcaud022,glcaud023,
          glcaud024,glcaud025,glcaud026,glcaud027,glcaud028,glcaud029,glcaud030 INTO l_glca.* 
   #161212-00005#2---modify-----end-------------
   FROM glca_t WHERE glcaent = g_enterprise AND glcald = p_ld AND glca001 = 'AR'

   LET l_flag = cl_get_para(g_enterprise,g_site,'S-FIN-1002') #1027 add
   
  #需要走重評價還原作業
  #DELETE FROM xreb_t WHERE xrebent = g_enterprise
  #                     AND xrebld = p_ld
  #                     AND xreb001 = g_master.xref001
  #                     AND xreb002 = g_master.xref002
  #                     AND xreb003 = 'AR'
   #1027 add--sr--                     
   #帐套本币 
   SELECT glaa001 INTO l_glaa001 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_ld 
   #1027 add--end--
   
   #20141216 add by chenying
   LET l_glaa003 = ''
   #取得會計週期參照表+本位幣二&三的幣別
   CALL s_ld_sel_glaa(p_ld,'glaa001|glaa003|glaa016|glaa017')
        RETURNING g_sub_success,l_glaa001,l_glaa003,l_glaa016,l_glaa017   
   #20141216 add by chenying
   
 #161212-00005#2---modify-----begin-------------  
 #LET l_sql = "SELECT * FROM xrca_t,xrcb_t,xrcc_t",
 LET l_sql = "SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,xrcacnfdt,",
             "xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,xrca003,xrca004,xrca005,",
             "xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,xrca018,",
             "xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,",
             "xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,",
             "xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,",
             "xrca059,xrca060,xrca061,xrca062,xrca063,xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,",
             "xrca107,xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,",
             "xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,xrca137,xrca138,xrcaud001,xrcaud002,xrcaud003,xrcaud004,",
             "xrcaud005,xrcaud006,xrcaud007,xrcaud008,xrcaud009,xrcaud010,xrcaud011,xrcaud012,xrcaud013,xrcaud014,",
             "xrcaud015,xrcaud016,xrcaud017,xrcaud018,xrcaud019,xrcaud020,xrcaud021,xrcaud022,xrcaud023,xrcaud024,",
             "xrcaud025,xrcaud026,xrcaud027,xrcaud028,xrcaud029,xrcaud030,",
             "xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,",
             "xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
             "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,",
             "xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,",
             "xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,",
             "xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,",
             "xrcb131,xrcb133,xrcb134,xrcb135,xrcb136,xrcbud001,xrcbud002,xrcbud003,xrcbud004,xrcbud005,xrcbud006,xrcbud007,",
             "xrcbud008,xrcbud009,xrcbud010,xrcbud011,xrcbud012,xrcbud013,xrcbud014,xrcbud015,xrcbud016,xrcbud017,xrcbud018,",
             "xrcbud019,xrcbud020,xrcbud021,xrcbud022,xrcbud023,xrcbud024,xrcbud025,xrcbud026,xrcbud027,xrcbud028,xrcbud029,",
             "xrcbud030,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,xrcb059,xrcb060,xrcb107,",
             "xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,xrcc006,xrcclegl,xrcc008,",
             "xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,",
             "xrcc106,xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,",
             "xrcc122,xrcc123,xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,xrcc133,xrcc134,",
             "xrcc135,xrcc136,xrcc137,xrcc138,xrcc139,xrccud001,xrccud002,xrccud003,xrccud004,xrccud005,xrccud006,xrccud007,",
             "xrccud008,xrccud009,xrccud010,xrccud011,xrccud012,xrccud013,xrccud014,xrccud015,xrccud016,xrccud017,xrccud018,",
             "xrccud019,xrccud020,xrccud021,xrccud022,xrccud023,xrccud024,xrccud025,xrccud026,xrccud027,xrccud028,xrccud029,",
             "xrccud030,xrcc015,xrcc016,xrcc017",
             " FROM xrca_t,xrcb_t,xrcc_t",
 #161212-00005#2---modify-----end-------------
               "  WHERE xrcaent = ",g_enterprise,
               "    AND xrcadocdt <= ? ",
              #"    AND xrcasite = '",g_master.b_site,"' ",   #161104-00019#2 Mark
               "    AND xrcald = ? ",
               "    AND xrcastus = 'Y' ",
               "    AND xrcc108 - xrcc109 <> 0 ",
               "    AND xrcc100 <> '",l_glaa001,"'", #如果交易幣別=帳套幣別，就不作重評價(此暫不考慮本位幣二&三)
               "    AND xrcaent = xrccent ",
               "    AND xrcald = xrccld ",
               "    AND xrcadocno = xrccdocno ",
               "    AND xrcbent = xrccent ",
               "    AND xrcbld = xrccld ",
               "    AND xrcbdocno = xrccdocno ",
               "    AND xrcbseq = xrccseq "
   IF l_glca.glca005 = 'N' THEN
      LET l_sql = l_sql,"   AND (SUBSTR(xrca001,1,1) <> 0 )"  #2014111 add ）
   END IF
   IF l_glca.glca004 = 'N' THEN
      LET l_sql = l_sql,"   AND (SUBSTR(xrca001,1,1) <> 2 )"  #2014111 add ）
   END IF
   LET l_sql = l_sql,
               "  UNION ",
               #161212-00005#2---modify-----begin-------------  
               #"SELECT * ",
               "SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,xrcacnfdt,",
               "xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,xrcasite,xrca003,xrca004,xrca005,",
               "xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,xrca018,",
               "xrca019,xrca020,xrca021,xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,",
               "xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,xrca043,xrca044,xrca045,",
               "xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,",
               "xrca059,xrca060,xrca061,xrca062,xrca063,xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,",
               "xrca107,xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,xrca126,xrca127,",
               "xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,xrca137,xrca138,xrcaud001,xrcaud002,xrcaud003,xrcaud004,",
               "xrcaud005,xrcaud006,xrcaud007,xrcaud008,xrcaud009,xrcaud010,xrcaud011,xrcaud012,xrcaud013,xrcaud014,",
               "xrcaud015,xrcaud016,xrcaud017,xrcaud018,xrcaud019,xrcaud020,xrcaud021,xrcaud022,xrcaud023,xrcaud024,",
               "xrcaud025,xrcaud026,xrcaud027,xrcaud028,xrcaud029,xrcaud030,",
               "xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,",
               "xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
               "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,",
               "xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,",
               "xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,",
               "xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,",
               "xrcb131,xrcb133,xrcb134,xrcb135,xrcb136,xrcbud001,xrcbud002,xrcbud003,xrcbud004,xrcbud005,xrcbud006,xrcbud007,",
               "xrcbud008,xrcbud009,xrcbud010,xrcbud011,xrcbud012,xrcbud013,xrcbud014,xrcbud015,xrcbud016,xrcbud017,xrcbud018,",
               "xrcbud019,xrcbud020,xrcbud021,xrcbud022,xrcbud023,xrcbud024,xrcbud025,xrcbud026,xrcbud027,xrcbud028,xrcbud029,",
               "xrcbud030,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,xrcb059,xrcb060,xrcb107,",
               "xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,xrcc006,xrcclegl,xrcc008,",
               "xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,xrcc101,xrcc102,xrcc103,xrcc104,xrcc105,",
               "xrcc106,xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,xrcc115,xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,",
               "xrcc122,xrcc123,xrcc124,xrcc125,xrcc126,xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,xrcc133,xrcc134,",
               "xrcc135,xrcc136,xrcc137,xrcc138,xrcc139,xrccud001,xrccud002,xrccud003,xrccud004,xrccud005,xrccud006,xrccud007,",
               "xrccud008,xrccud009,xrccud010,xrccud011,xrccud012,xrccud013,xrccud014,xrccud015,xrccud016,xrccud017,xrccud018,",
               "xrccud019,xrccud020,xrccud021,xrccud022,xrccud023,xrccud024,xrccud025,xrccud026,xrccud027,xrccud028,xrccud029,",
               "xrccud030,xrcc015,xrcc016,xrcc017",
               " FROM xrca_t,xrcb_t,xrcc_t",
              #161212-00005#2---modify-----end-------------
               "  WHERE xrcaent = ",g_enterprise,
               "    AND xrcadocdt <= ? ",
              #"    AND xrcasite = '",g_master.b_site,"' ",   #161104-00019#2 Mark
               "    AND xrcald = ? ",
               "    AND xrcastus = 'Y' ",
               "    AND xrcc108 - xrcc109 = 0 ",
               "    AND xrcc100 <> '",l_glaa001,"'", #如果交易幣別=帳套幣別，就不作重評價(此暫不考慮本位幣二&三)
               "    AND xrcaent = xrccent ",
               "    AND xrcald = xrccld ",
               "    AND xrcadocno = xrccdocno ",
               "    AND xrcbent = xrccent ",
               "    AND xrcbld = xrccld ",
               "    AND xrcbdocno = xrccdocno ",
               "    AND xrcbseq = xrccseq ",
               "    AND ( ",
               "         EXISTS ( SELECT 1 FROM xrda_t,xrce_t WHERE xrce003 = xrccdocno ",
               "                                                AND xrce004 = xrccseq ",
               "                                                AND xrce005 = xrcc001 ", 
               "                                                AND xrdald  = xrceld ",
               "                                                AND xrdaent =xrceent ",
               "                                                AND xrdadocno =xrcedocno ",
               "                                                AND xrdastus= 'Y') ",     #AR沖銷
               "     OR  EXISTS ( SELECT 1 FROM xrca_t,xrce_t WHERE xrce003 = xrccdocno ",
               "                                                AND xrce004 = xrccseq ",
               "                                                AND xrce005 = xrcc001 ", 
               "                                                AND xrcald  = xrceld ",
               "                                                AND xrcaent =xrceent ",
               "                                                AND xrcadocno =xrcedocno ",
               "                                                AND xrcastus= 'Y') ",    #AR直接沖帳      
               "     OR  EXISTS ( SELECT 1 FROM xrca_t,xrcf_t WHERE xrcf008 = xrccdocno ",
               "                                                AND xrcf009 = xrccseq ",
               "                                                AND xrcf010 = xrcc001 ", 
               "                                                AND xrcald  = xrcfld ",
               "                                                AND xrcaent =xrcfent ",
               "                                                AND xrcadocno =xrcfdocno ",
               "                                                AND xrcastus= 'Y') ",    #AR沖暫估 
               "     OR  EXISTS ( SELECT 1 FROM apda_t,apce_t WHERE apce003 = xrccdocno ",
               "                                                AND apce004 = xrccseq ",
               "                                                AND apce005 = xrcc001 ", 
               "                                                AND apdald  = apceld ",
               "                                                AND apdaent =apceent ",
               "                                                AND apdadocno =apcedocno ",
               "                                                AND apdastus= 'Y') ",    #AP沖銷
               "        ) "               
   #暫估款納入評價否
   IF l_glca.glca005 <> 'Y' THEN 
      LET l_sql = l_sql," AND SUBSTR(xrca001,1,1) <> '0' "
   END IF
   #扣抵項目減除否
   IF l_glca.glca004 <> 'Y' THEN 
      LET l_sql = l_sql," AND SUBSTR(xrca001,1,1) <> '2' "
   END IF               
   LET l_sql = "SELECT * FROM (",l_sql,")  ORDER BY xrccdocno,xrccseq,xrcc001 "
 
   PREPARE axrp920_xrca_prep1 FROM l_sql
   DECLARE axrp920_xrca_curs1  CURSOR FOR axrp920_xrca_prep1

   FOREACH axrp920_xrca_curs1 USING p_xreb008,p_ld,p_xreb008,p_ld INTO l_xrca.*,l_xrcb.*,l_xrcc.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'

         EXIT FOREACH
      END IF

      LET l_xreb.xrebent = l_xrca.xrcaent
      LET l_xreb.xrebsite= l_xrca.xrcasite
      LET l_xreb.xrebcomp= l_xrca.xrcacomp
      LET l_xreb.xrebld  = l_xrca.xrcald
      LET l_xreb.xreb001 = g_master.xref001
      LET l_xreb.xreb002 = g_master.xref002
      LET l_xreb.xreb003 = 'AR'
      LET l_xreb.xreb004 = l_xrca.xrca001
      LET l_xreb.xreb005 = l_xrcc.xrccdocno
      LET l_xreb.xreb006 = l_xrcc.xrccseq
      LET l_xreb.xreb007 = l_xrcc.xrcc001
      LET l_xreb.xreb008 = l_xrca.xrcadocdt
      LET l_xreb.xreb009 = l_xrca.xrca004
      LET l_xreb.xreb010 = l_xrcb.xrcblegl    #1027 mark
      LET l_xreb.xreb010 = l_xrca.xrca005     #1027 add xreb010:收款对象
      LET l_xreb.xreb102 = l_xrcc.xrcc102     #1027 add
      LET l_xreb.xreb122 = l_xrcc.xrcc122     #1027 add
      LET l_xreb.xreb132 = l_xrcc.xrcc132     #1027 add
      
      #1027 --add--str--
      IF l_flag = '1' OR l_flag = '2' THEN 
         LET l_xreb.xreb011 = l_xrca.xrca015
         #部门所属责任中心
         SELECT ooeg004 INTO l_ooeg004 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = l_xrca.xrca014
         LET l_xreb.xreb012 = l_ooeg004         
         LET l_xreb.xreb013 = ''
         LET l_xreb.xreb014 = ''
         LET l_xreb.xreb015 = ''
         LET l_xreb.xreb016 = ''
         LET l_xreb.xreb017 = ''
         LET l_xreb.xreb018 = ''
         LET l_xreb.xreb019 = l_xrca.xrca035
         LET l_xreb.xreborga = l_xrca.xrcacomp
         LET l_xreb.xreb020 = ''
         LET l_xreb.xreb021 = ''
         LET l_xreb.xreb022 = ''
         LET l_xreb.xreb023 = ''
         LET l_xreb.xreb024 = ''
         LET l_xreb.xreb025 = ''
         LET l_xreb.xreb026 = ''
         LET l_xreb.xreb027 = ''
         LET l_xreb.xreb028 = ''
         LET l_xreb.xreb029 = ''
         LET l_xreb.xreb030 = ''
         LET l_xreb.xreb031 = ''         
         LET l_xreb.xreb032 = ''
         LET l_xreb.xreb033 = ''
         LET l_xreb.xreb100 = l_xrca.xrca100
      ELSE
         LET l_xreb.xreb011 = l_xrcb.xrcb010
         LET l_xreb.xreb012 = l_xrcb.xrcb011
         LET l_xreb.xreb013 = l_xrcb.xrcb024
         LET l_xreb.xreb014 = l_xrcb.xrcb014
         LET l_xreb.xreb015 = l_xrcb.xrcb012
         LET l_xreb.xreb016 = l_xrca.xrca014
         LET l_xreb.xreb017 = l_xrcb.xrcb015
         LET l_xreb.xreb018 = l_xrcb.xrcb016
         LET l_xreb.xreb019 = l_xrcb.xrcb029
         LET l_xreb.xreborga = l_xrcb.xrcborga
         LET l_xreb.xreb020 = l_xrcb.xrcb034
         LET l_xreb.xreb021 = l_xrcb.xrcb035
         LET l_xreb.xreb022 = l_xrcb.xrcb036
         LET l_xreb.xreb023 = l_xrcb.xrcb037
         LET l_xreb.xreb024 = l_xrcb.xrcb038
         LET l_xreb.xreb025 = l_xrcb.xrcb039
         LET l_xreb.xreb026 = l_xrcb.xrcb040
         LET l_xreb.xreb027 = l_xrcb.xrcb041
         LET l_xreb.xreb028 = l_xrcb.xrcb042 
         LET l_xreb.xreb029 = l_xrcb.xrcb043
         LET l_xreb.xreb030 = l_xrcb.xrcb044 
         LET l_xreb.xreb031 = l_xrcb.xrcb045
         LET l_xreb.xreb032 = l_xrcb.xrcb046 
         #LET l_xreb.xreb033 = l_xrcb.xrcb047 #170116-00037#1 mark
         LET l_xreb.xreb033 = ''              #170116-00037#1 add  
         LET l_xreb.xreb100 = l_xrcc.xrcc100
      END IF
      #1027 --add--end--
#1027 --mod--str--      
#      LET l_xreb.xreb011 = l_xrcb.xrcb010    
#      LET l_xreb.xreb012 = l_xrcb.xrcb011    
#      LET l_xreb.xreb013 = l_xrcb.xrcb024
#      LET l_xreb.xreb014 = ''
#      LET l_xreb.xreb015 = l_xrcb.xrcb012
#      LET l_xreb.xreb016 = l_xrca.xrca014
#      LET l_xreb.xreb017 = l_xrca.xrca059
#      LET l_xreb.xreb018 = l_xrcb.xrcb015
#      LET l_xreb.xreb019 = l_xrcb.xrcb016
#      LET l_xreb.xreb020 = l_xrca.xrca057
#      LET l_xreb.xreb021 = l_xrcb.xrcb029
#      LET l_xreb.xreb022 = l_xrcb.xrcb021
#      LET l_xreb.xreb023 = ''
#      LET l_xreb.xreb024 = l_xrcb.xrcborga
#      LET l_xreb.xreb100 = l_xrcc.xrcc100
#1027 --mod--end--

      #獲取重評价匯率
      CALL axrp920_get_rate(l_xrcc.xrcc100,l_glca.glca003,l_xrca.xrcadocno) RETURNING l_xreb101,l_xreb121,l_xreb131

      #未沖金額
      CALL axrp920_get_amt(l_xrcc.xrccdocno,l_xrcc.xrccseq,l_xrcc.xrcc001,l_xreb.xreb004) #20141118 add xreb004
         RETURNING l_xreb103,l_xreb113,l_xreb123,l_xreb133
         
     #CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb103,2) RETURNING l_success,g_errno,l_xreb103 #150823 02097 mark 原幣未沖額不用再取位了, 因為前端已取位完
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb113,2) RETURNING l_success,g_errno,l_xreb113
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb123,2) RETURNING l_success,g_errno,l_xreb123
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb133,2) RETURNING l_success,g_errno,l_xreb133

      IF l_xreb103 = 0 THEN 
         CONTINUE FOREACH 
      END IF

      #取帳齡類型編號
      SELECT glca002 INTO l_glca002 FROM glca_t
       #WHERE glcald = l_xrca.xrcald AND glca001= 'AR' #160905-00002#7 mark
       WHERE glcaent = g_enterprise #160905-00002#7
         AND glcald = l_xrca.xrcald AND glca001= 'AR' #160905-00002#7
#20141216 mark by chenying       
#      IF l_glca002 = '1' THEN
#         IF g_master.xref002 = 1 THEN
#            LET l_xreb116 = l_xreb103 * l_xreb101 - l_xreb113
#            LET l_xreb126 = l_xreb123 * l_xreb121 - l_xreb123
#            LET l_xreb136 = l_xreb133 * l_xreb131 - l_xreb133
#         ELSE
#            SELECT xreb115,xreb125,xreb135
#              INTO l_xreb115_t,l_xreb125_t,l_xreb135_t
#              FROM xreb_t
#             WHERE xrebent = g_enterprise
#               AND xrebld = l_xrca.xrcald           
#               AND xreb001 = g_master.xref001
#               AND xreb002 = g_master.xref002 - 1              
#               AND xreb005 = l_xrcc.xrccdocno
#               AND xreb006 = l_xrcc.xrccseq
#               AND xreb007 = l_xrcc.xrcc001
#            IF cl_null(l_xreb115_t) THEN LET l_xreb115_t = 0 END IF
#            IF cl_null(l_xreb125_t) THEN LET l_xreb125_t = 0 END IF
#            IF cl_null(l_xreb135_t) THEN LET l_xreb135_t = 0 END IF
#            LET l_xreb116 = l_xreb103 * l_xreb101 - l_xreb113 - l_xreb115_t
#            LET l_xreb126 = l_xreb123 * l_xreb121 - l_xreb123 - l_xreb125_t
#            LET l_xreb136 = l_xreb133 * l_xreb131 - l_xreb133 - l_xreb135_t
#         END IF
#      ELSE
#         LET l_xreb116 = l_xreb103 * l_xreb101 - l_xreb113
#         LET l_xreb126 = l_xreb123 * l_xreb121 - l_xreb123
#         LET l_xreb136 = l_xreb133 * l_xreb131 - l_xreb133
#      END IF
#20141216 mark by chenying



      LET l_xreb.xreb101 = l_xreb101
      LET l_xreb.xreb103 = l_xreb103
      LET l_xreb.xreb113 = l_xreb113
      LET l_xreb.xreb114 = l_xreb.xreb103 * l_xreb.xreb101
      
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb113,2) RETURNING l_success,g_errno,l_xreb.xreb113
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb114,2) RETURNING l_success,g_errno,l_xreb.xreb114
      
      LET l_xreb004_str = l_xreb.xreb004
      LET l_xreb004_str = l_xreb004_str.substring(1,1)
      IF l_xreb004_str = '2' OR l_xreb.xreb004 = '02' OR l_xreb.xreb004 = '04' THEN 
         LET l_xreb.xreb103 = l_xreb.xreb103 * -1
         LET l_xreb.xreb113 = l_xreb.xreb113 * -1
         LET l_xreb.xreb114 = l_xreb.xreb114 * -1
      END IF
      
      LET l_xreb.xreb115 = l_xreb.xreb114 - l_xreb.xreb113  
#      LET l_xreb.xreb116 = l_xreb116  #20141216 mark by chenying
      LET l_xreb.xreb121 = l_xreb121
      LET l_xreb.xreb123 = l_xreb123
      LET l_xreb.xreb124 = l_xreb.xreb123 * l_xreb.xreb121
#     LET l_xreb.xreb125 = l_xreb.xreb124 - l_xreb.xreb123 #1027
#      LET l_xreb.xreb126 = l_xreb126  #20141216 mark by chenying
      LET l_xreb.xreb131 = l_xreb131
      LET l_xreb.xreb133 = l_xreb133
      LET l_xreb.xreb134 = l_xreb.xreb133 * l_xreb.xreb131
#     LET l_xreb.xreb135 = l_xreb.xreb134 - l_xreb.xreb133 #1027
#1027 add--str--      
      IF l_xreb.xreb115 = 0 THEN 
         LET l_xreb.xreb135 = 0
         LET l_xreb.xreb125 = 0
      ELSE
         LET l_xreb.xreb135 = l_xreb.xreb115 * l_xreb131
         LET l_xreb.xreb125 = l_xreb.xreb115 * l_xreb121
      END IF
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb123,2) RETURNING l_success,g_errno,l_xreb.xreb123
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb124,2) RETURNING l_success,g_errno,l_xreb.xreb124
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb125,2) RETURNING l_success,g_errno,l_xreb.xreb125
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb133,2) RETURNING l_success,g_errno,l_xreb.xreb133
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb134,2) RETURNING l_success,g_errno,l_xreb.xreb134
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb135,2) RETURNING l_success,g_errno,l_xreb.xreb135
#1027 --add--end--      
#      LET l_xreb.xreb136 = l_xreb136  #20141216 mark by chenying

#20141216 add by chenying
#xreb116 = 上期累计+本期汇差
      #取上期的年度期別
      CALL s_fin_date_get_last_period(l_glaa003,l_xrca.xrcald,l_xreb.xreb001,l_xreb.xreb002)
      RETURNING g_sub_success,l_last_y,l_last_m
      
      LET l_xreb115_t = 0 
      LET l_xreb125_t = 0
      LET l_xreb135_t = 0
       
     #SELECT xreb115,xreb125,xreb135   #151105-00014#1 Mark
      SELECT xreb116,xreb126,xreb136   #151105-00014#1 Add
        INTO l_xreb115_t,l_xreb125_t,l_xreb135_t
        FROM xreb_t
       WHERE xrebent = g_enterprise
         AND xrebld = l_xrca.xrcald
         AND xreb001 = l_last_y   #上期年度  
         AND xreb002 = l_last_m   #上期月份            
         AND xreb005 = l_xrcc.xrccdocno
         AND xreb006 = l_xrcc.xrccseq
         AND xreb007 = l_xrcc.xrcc001
      IF cl_null(l_xreb115_t) THEN LET l_xreb115_t = 0 END IF
      IF cl_null(l_xreb125_t) THEN LET l_xreb125_t = 0 END IF
      IF cl_null(l_xreb135_t) THEN LET l_xreb135_t = 0 END IF
      
      LET l_xreb116 = l_xreb.xreb115 + l_xreb115_t  #本幣累計匯差
      LET l_xreb126 = l_xreb.xreb125 + l_xreb125_t
      LET l_xreb136 = l_xreb.xreb135 + l_xreb135_t
      #2015/01/23 By zhangwei Add---(S)---
      IF l_glca002 = '2' THEN   #次月迴轉
        LET l_xreb.xreb116 = l_xreb.xreb115
        LET l_xreb.xreb126 = l_xreb.xreb125
        LET l_xreb.xreb136 = l_xreb.xreb135
      END IF
      IF l_glca002 = '3' THEN   #次月不迴轉
         LET l_xreb.xreb116 = l_xreb116
         LET l_xreb.xreb126 = l_xreb126
         LET l_xreb.xreb136 = l_xreb136
      END IF
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb116,2) RETURNING l_success,g_errno,l_xreb.xreb116
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb126,2) RETURNING l_success,g_errno,l_xreb.xreb126
      CALL s_curr_round_ld('1',l_xreb.xrebld,g_glaa.glaa001,l_xreb.xreb136,2) RETURNING l_success,g_errno,l_xreb.xreb136
      #2015/01/23 By zhangwei Add---(E)---
      #2015/01/23 By zhangwei Mark---(S)---
     #LET l_xreb.xreb116 = l_xreb116
     #LET l_xreb.xreb126 = l_xreb126
     #LET l_xreb.xreb136 = l_xreb136
      #2015/01/23 By zhangwei Mark---(E)---
#20141216 add by chenying

      #1027 add--str--
      #匯差金額>0取重評價匯兌收益，否则重評價匯兌損失
      IF l_xreb.xreb115 > 0 THEN 
         SELECT glab005 INTO l_xreb.xreb034 FROM glab_t 
          WHERE glabent = g_enterprise
            AND glab002 = '8318'
            AND glab003 = '8318_11'
            AND glabld  = l_xrca.xrcald
      ELSE
         SELECT glab005 INTO l_xreb.xreb034 FROM glab_t 
          WHERE glabent = g_enterprise
            AND glab002 = '8318'
            AND glab003 = '8318_12'
            AND glabld  = l_xrca.xrcald      
      END IF
      
      #1027 add--end--
      #161212-00005#2---modify-----begin-------------
      #INSERT INTO xreb_t VALUES(l_xreb.*)
      INSERT INTO xreb_t (xrebent,xrebcomp,xrebsite,xrebld,xreb001,xreb002,xreb003,xreb004,xreb005,xreb006,xreb007,
                          xreb008,xreb009,xreb010,xreb011,xreb012,xreb013,xreb014,xreb015,xreb016,xreb017,xreb018,
                          xreb019,xreborga,xreb020,xreb021,xreb022,xreb023,xreb024,xreb025,xreb026,xreb027,xreb028,
                          xreb029,xreb030,xreb031,xreb032,xreb033,xreb034,xreb100,xreb101,xreb102,xreb103,xreb113,
                          xreb114,xreb115,xreb116,xreb121,xreb122,xreb123,xreb124,xreb125,xreb126,xreb131,xreb132,
                          xreb133,xreb134,xreb135,xreb136,xrebud001,xrebud002,xrebud003,xrebud004,xrebud005,xrebud006,
                          xrebud007,xrebud008,xrebud009,xrebud010,xrebud011,xrebud012,xrebud013,xrebud014,xrebud015,
                          xrebud016,xrebud017,xrebud018,xrebud019,xrebud020,xrebud021,xrebud022,xrebud023,xrebud024,
                          xrebud025,xrebud026,xrebud027,xrebud028,xrebud029,xrebud030)
      VALUES(l_xreb.xrebent,l_xreb.xrebcomp,l_xreb.xrebsite,l_xreb.xrebld,l_xreb.xreb001,l_xreb.xreb002,l_xreb.xreb003,l_xreb.xreb004,l_xreb.xreb005,l_xreb.xreb006,l_xreb.xreb007,
             l_xreb.xreb008,l_xreb.xreb009,l_xreb.xreb010,l_xreb.xreb011,l_xreb.xreb012,l_xreb.xreb013,l_xreb.xreb014,l_xreb.xreb015,l_xreb.xreb016,l_xreb.xreb017,l_xreb.xreb018,
             l_xreb.xreb019,l_xreb.xreborga,l_xreb.xreb020,l_xreb.xreb021,l_xreb.xreb022,l_xreb.xreb023,l_xreb.xreb024,l_xreb.xreb025,l_xreb.xreb026,l_xreb.xreb027,l_xreb.xreb028,
             l_xreb.xreb029,l_xreb.xreb030,l_xreb.xreb031,l_xreb.xreb032,l_xreb.xreb033,l_xreb.xreb034,l_xreb.xreb100,l_xreb.xreb101,l_xreb.xreb102,l_xreb.xreb103,l_xreb.xreb113,
             l_xreb.xreb114,l_xreb.xreb115,l_xreb.xreb116,l_xreb.xreb121,l_xreb.xreb122,l_xreb.xreb123,l_xreb.xreb124,l_xreb.xreb125,l_xreb.xreb126,l_xreb.xreb131,l_xreb.xreb132,
             l_xreb.xreb133,l_xreb.xreb134,l_xreb.xreb135,l_xreb.xreb136,l_xreb.xrebud001,l_xreb.xrebud002,l_xreb.xrebud003,l_xreb.xrebud004,l_xreb.xrebud005,l_xreb.xrebud006,
             l_xreb.xrebud007,l_xreb.xrebud008,l_xreb.xrebud009,l_xreb.xrebud010,l_xreb.xrebud011,l_xreb.xrebud012,l_xreb.xrebud013,l_xreb.xrebud014,l_xreb.xrebud015,
             l_xreb.xrebud016,l_xreb.xrebud017,l_xreb.xrebud018,l_xreb.xrebud019,l_xreb.xrebud020,l_xreb.xrebud021,l_xreb.xrebud022,l_xreb.xrebud023,l_xreb.xrebud024,
             l_xreb.xrebud025,l_xreb.xrebud026,l_xreb.xrebud027,l_xreb.xrebud028,l_xreb.xrebud029,l_xreb.xrebud030)
      #161212-00005#2---modify-----end-------------
      IF SQLCA.sqlerrd[3] <> 1 OR SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE
         LET g_errparam.coll_vals[1] = l_xrca.xrcadocno
         CALL cl_err()
         LET g_success = 'N'
      END IF

      #1027 --add--str--
      #回寫重評價調整數
      IF l_glca002 = '3' THEN
         IF l_xreb.xreb115 <> 0 THEN 
#            SELECT SUM(xreb116),SUM(xreb126),SUM(xreb136) # 累計匯差金額  
#              INTO l_xreb116_sum,l_xreb126_sum,l_xreb136_sum
#              FROM xreb_t 
#             WHERE xrebent = g_enterprise
#               AND xrebld  = l_xreb.xrebld
#               AND xreb005 = l_xreb.xreb005
#               AND xreb006 = l_xreb.xreb006
#               AND xreb007 = l_xreb.xreb007
            IF l_xreb004_str = '2' OR l_xreb.xreb004 = '02' OR l_xreb.xreb004 = '04' THEN 
              #2015/03/19 Mark By 01727 ---(S)---
              #IF l_xreb.xreb116 < 0 THEN LET l_xreb.xreb116 = l_xreb.xreb116 * -1 END IF 
              #IF l_xreb.xreb126 < 0 THEN LET l_xreb.xreb126 = l_xreb.xreb126 * -1 END IF  
              #IF l_xreb.xreb136 < 0 THEN LET l_xreb.xreb136 = l_xreb.xreb136 * -1 END IF 
              #2015/03/19 Mark By 01727 ---(E)---
               LET l_xreb.xreb116 = l_xreb.xreb116 * -1
               LET l_xreb.xreb126 = l_xreb.xreb126 * -1
               LET l_xreb.xreb136 = l_xreb.xreb136 * -1
              #2015/03/19 Add  By 01727 ---(S)---
               
               #2015/03/19 Add  By 01727 ---(E)---
            END IF

            UPDATE xrcc_t SET 
                   xrcc102 = l_xreb.xreb101,
                   xrcc122 = l_xreb.xreb121,
                   xrcc132 = l_xreb.xreb131, 
                   xrcc113 = l_xreb.xreb116,
                   xrcc123 = l_xreb.xreb126,
                   xrcc133 = l_xreb.xreb136                   
#                   xrcc113 = l_xreb116_sum,
#                   xrcc123 = l_xreb126_sum,
#                   xrcc133 = l_xreb136_sum
             WHERE xrccent = g_enterprise
               AND xrccld  = l_xreb.xrebld             
               AND xrccdocno = l_xreb.xreb005
               AND xrccseq = l_xreb.xreb006
               AND xrcc001 = l_xreb.xreb007  
            IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd xrcc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
            END IF
#1102 mark--
#回写的时候不需要更新xrcc1*8
#            #重計本幣應付金額
#            UPDATE xrcc_t SET xrcc118 = xrcc115 - xrcc116 - xrcc117 + xrcc114 + xrcc113,
#                              xrcc128 = xrcc125 - xrcc126 - xrcc127 + xrcc124 + xrcc123,
#                              xrcc138 = xrcc135 - xrcc136 - xrcc137 + xrcc134 + xrcc133
#             WHERE xrccent = g_enterprise
#               AND xrccld  = l_xreb.xrebld                              
#               AND xrccdocno = l_xreb.xreb005
#               AND xrccseq = l_xreb.xreb006
#               AND xrcc001 = l_xreb.xreb007       
#            IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "upd xrcc_t 2"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET g_success = 'N'
#            END IF  
#1102 mark---
         END IF
      END IF
      
      #回寫帳套重評價年月
      UPDATE glca_t SET glca006 = l_xreb.xreb001,
                        glca007 = l_xreb.xreb002
       WHERE glcaent = g_enterprise  
         AND glcald = l_xreb.xrebld 
         AND glca001 = 'AR'   
      IF SQLCA.SQLcode OR SQLCA.SQLERRD[3]=0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd glca_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF 
      #1027 --add--end--

   END FOREACH

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
PRIVATE FUNCTION axrp920_get_rate(p_xrcc100,p_glca003,p_xrcadocno)
   DEFINE p_glca003         LIKE glca_t.glca003
   DEFINE p_xrcc100         LIKE xrcc_t.xrcc100
   DEFINE p_xrcadocno       LIKE xrca_t.xrcadocno
   DEFINE l_ooef015         LIKE ooef_t.ooef015
   DEFINE ls_wc             STRING
   DEFINE l_sql             STRING
   DEFINE r_xreb101         LIKE xreb_t.xreb101
   DEFINE r_xreb121         LIKE xreb_t.xreb121
   DEFINE r_xreb131         LIKE xreb_t.xreb131
   DEFINE l_ooao004         STRING

   SELECT ooef015 INTO l_ooef015 FROM ooef_t WHERE ooef001 = g_glaa.glaacomp AND ooefent = g_enterprise
   IF cl_null(l_ooef015) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_glaa.glaacomp
      LET g_errparam.code   = 'axr-00170'
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_xrcadocno
      CALL cl_err()
      LET g_success = 'N'
   END IF

   IF p_glca003 = '11' THEN LET ls_wc = 'ooao005' END IF
   IF p_glca003 = '12' THEN LET ls_wc = 'ooao006' END IF
   IF p_glca003 = '13' THEN LET ls_wc = 'ooao007' END IF
   IF p_glca003 = '21' THEN LET ls_wc = 'ooao008' END IF
   IF p_glca003 = '22' THEN LET ls_wc = 'ooao009' END IF
   IF p_glca003 = '31' THEN LET ls_wc = 'ooao011' END IF

   IF g_master.xref002 < 10 THEN
      LET l_ooao004 = g_master.xref001,0,g_master.xref002 USING '<<<<<'
   ELSE
      LET l_ooao004 = g_master.xref001,g_master.xref002 USING '<<<<<'
   END IF
   LET l_ooao004 = cl_replace_str(l_ooao004,' ','')

   #LET l_sql = " SELECT ",ls_wc," FROM ooao_t WHERE ooao001 = '",l_ooef015,"' AND ooao002 = ? AND ooao003 = ?", #160905-00002#7 mark
   #LET l_sql = " SELECT ",ls_wc," FROM ooao_t WHERE ooaoent = '",g_enterprise,"' ooao001 = '",l_ooef015,"' AND ooao002 = ? AND ooao003 = ?", #160905-00002#7  #161102-00011#1 mark  
   LET l_sql = " SELECT ",ls_wc," FROM ooao_t WHERE ooaoent = '",g_enterprise,"' AND ooao001 = '",l_ooef015,"' AND ooao002 = ? AND ooao003 = ?",               #161102-00011#1 add
               "    AND ooao004 = ",l_ooao004,""
   PREPARE axrp920_get_rate_prep FROM l_sql

   IF p_xrcc100 = g_glaa.glaa001 THEN
      LET r_xreb101 = 1
   ELSE
      EXECUTE axrp920_get_rate_prep USING p_xrcc100,g_glaa.glaa001 INTO r_xreb101
   END IF
   IF cl_null(r_xreb101) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_ooef015
      LET g_errparam.code   = 'axr-00171'
      LET g_errparam.popup  = TRUE
      LET g_errparam.replace[1] = p_xrcc100
      LET g_errparam.replace[2] = g_glaa.glaa001
      LET g_errparam.coll_vals[1] = p_xrcadocno
      CALL cl_err()
      LET g_success = 'N'
   END IF

   IF g_glaa.glaa015 = 'Y' THEN
      IF g_glaa.glaa017 = '1' THEN
         EXECUTE axrp920_get_rate_prep USING p_xrcc100,g_glaa.glaa016      INTO r_xreb121
         IF p_xrcc100 = g_glaa.glaa016 THEN LET r_xreb121 = 1 END IF
      ELSE
         EXECUTE axrp920_get_rate_prep USING g_glaa.glaa001,g_glaa.glaa016 INTO r_xreb121
         IF g_glaa.glaa001 = g_glaa.glaa016 THEN LET r_xreb121 = 1 END IF
      END IF
   ELSE
      LET r_xreb121 = 0
   END IF

   IF g_glaa.glaa019 = 'Y' THEN
      IF g_glaa.glaa021 = '1' THEN
         EXECUTE axrp920_get_rate_prep USING p_xrcc100,g_glaa.glaa020      INTO r_xreb131
         IF p_xrcc100 = g_glaa.glaa020 THEN LET r_xreb131 = 1 END IF
      ELSE
         EXECUTE axrp920_get_rate_prep USING g_glaa.glaa001,g_glaa.glaa020 INTO r_xreb131
         IF g_glaa.glaa001 = g_glaa.glaa020 THEN LET r_xreb131 = 1 END IF
      END IF
   ELSE
      LET r_xreb131 = 0
   END IF

   RETURN r_xreb101,r_xreb121,r_xreb131

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
PRIVATE FUNCTION axrp920_get_amt(p_xrccdocno,p_xrccseq,p_xrcc001,p_xreb004)
   #傳入值
   DEFINE p_xrccdocno         LIKE xrcc_t.xrccdocno
   DEFINE p_xrccseq           LIKE xrcc_t.xrccseq
   DEFINE p_xrcc001           LIKE xrcc_t.xrcc001
   #回傳值
   DEFINE r_xreb103           LIKE xreb_t.xreb103
   DEFINE r_xreb113           LIKE xreb_t.xreb113
   DEFINE r_xreb123           LIKE xreb_t.xreb123
   DEFINE r_xreb133           LIKE xreb_t.xreb133
   #其他
   #161212-00005#2---modify-----begin-------------
   #DEFINE l_xrcc              RECORD LIKE xrcc_t.*
   DEFINE l_xrcc RECORD  #多帳期明細
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
       xrccud001 LIKE xrcc_t.xrccud001, #自定義欄位(文字)001
       xrccud002 LIKE xrcc_t.xrccud002, #自定義欄位(文字)002
       xrccud003 LIKE xrcc_t.xrccud003, #自定義欄位(文字)003
       xrccud004 LIKE xrcc_t.xrccud004, #自定義欄位(文字)004
       xrccud005 LIKE xrcc_t.xrccud005, #自定義欄位(文字)005
       xrccud006 LIKE xrcc_t.xrccud006, #自定義欄位(文字)006
       xrccud007 LIKE xrcc_t.xrccud007, #自定義欄位(文字)007
       xrccud008 LIKE xrcc_t.xrccud008, #自定義欄位(文字)008
       xrccud009 LIKE xrcc_t.xrccud009, #自定義欄位(文字)009
       xrccud010 LIKE xrcc_t.xrccud010, #自定義欄位(文字)010
       xrccud011 LIKE xrcc_t.xrccud011, #自定義欄位(數字)011
       xrccud012 LIKE xrcc_t.xrccud012, #自定義欄位(數字)012
       xrccud013 LIKE xrcc_t.xrccud013, #自定義欄位(數字)013
       xrccud014 LIKE xrcc_t.xrccud014, #自定義欄位(數字)014
       xrccud015 LIKE xrcc_t.xrccud015, #自定義欄位(數字)015
       xrccud016 LIKE xrcc_t.xrccud016, #自定義欄位(數字)016
       xrccud017 LIKE xrcc_t.xrccud017, #自定義欄位(數字)017
       xrccud018 LIKE xrcc_t.xrccud018, #自定義欄位(數字)018
       xrccud019 LIKE xrcc_t.xrccud019, #自定義欄位(數字)019
       xrccud020 LIKE xrcc_t.xrccud020, #自定義欄位(數字)020
       xrccud021 LIKE xrcc_t.xrccud021, #自定義欄位(日期時間)021
       xrccud022 LIKE xrcc_t.xrccud022, #自定義欄位(日期時間)022
       xrccud023 LIKE xrcc_t.xrccud023, #自定義欄位(日期時間)023
       xrccud024 LIKE xrcc_t.xrccud024, #自定義欄位(日期時間)024
       xrccud025 LIKE xrcc_t.xrccud025, #自定義欄位(日期時間)025
       xrccud026 LIKE xrcc_t.xrccud026, #自定義欄位(日期時間)026
       xrccud027 LIKE xrcc_t.xrccud027, #自定義欄位(日期時間)027
       xrccud028 LIKE xrcc_t.xrccud028, #自定義欄位(日期時間)028
       xrccud029 LIKE xrcc_t.xrccud029, #自定義欄位(日期時間)029
       xrccud030 LIKE xrcc_t.xrccud030, #自定義欄位(日期時間)030
       xrcc015 LIKE xrcc_t.xrcc015, #收款條件
       xrcc016 LIKE xrcc_t.xrcc016, #帳款類型
       xrcc017 LIKE xrcc_t.xrcc017  #訂單單號
       END RECORD

   #161212-00005#2---modify-----end-------------
   DEFINE l_xrce109           LIKE xrce_t.xrce109
   DEFINE l_xrce119           LIKE xrce_t.xrce119
   DEFINE l_xrce129           LIKE xrce_t.xrce129
   DEFINE l_xrce139           LIKE xrce_t.xrce139
   DEFINE l_xrcc108           LIKE xrcc_t.xrcc108
   DEFINE l_sql               STRING
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE b_date              LIKE type_t.dat
   DEFINE e_date              LIKE type_t.dat
   DEFINE p_xreb004           LIKE xreb_t.xreb004  #20141118
   DEFINE l_apce109           LIKE apce_t.apce109
   DEFINE l_apce119           LIKE apce_t.apce119
   DEFINE l_apce129           LIKE apce_t.apce129
   DEFINE l_apce139           LIKE apce_t.apce139   

   SELECT MIN(glav004) INTO b_date FROM glav_t WHERE glavent = g_enterprise AND glavstus = 'Y'
      AND glav001 = g_glaa.glaa003 AND glav002 = g_master.xref001 AND glav006 = g_master.xref002
   SELECT MAX(glav004) INTO e_date FROM glav_t WHERE glavent = g_enterprise AND glavstus = 'Y'
      AND glav001 = g_glaa.glaa003 AND glav002 = g_master.xref001 AND glav006 = g_master.xref002

  #161212-00005#2---modify-----begin-------------
  # SELECT * INTO l_xrcc.*
   SELECT xrccent,xrccld,xrcccomp,xrccdocno,xrccseq,xrcc001,xrcc002,xrcc003,xrcc004,xrcc005,xrcc006,
          xrcclegl,xrcc008,xrcc009,xrccsite,xrcc010,xrcc011,xrcc012,xrcc013,xrcc014,xrcc100,xrcc101,
          xrcc102,xrcc103,xrcc104,xrcc105,xrcc106,xrcc107,xrcc108,xrcc109,xrcc113,xrcc114,xrcc115,
          xrcc116,xrcc117,xrcc118,xrcc119,xrcc120,xrcc121,xrcc122,xrcc123,xrcc124,xrcc125,xrcc126,
          xrcc127,xrcc128,xrcc129,xrcc130,xrcc131,xrcc132,xrcc133,xrcc134,xrcc135,xrcc136,xrcc137,
          xrcc138,xrcc139,xrccud001,xrccud002,xrccud003,xrccud004,xrccud005,xrccud006,xrccud007,
          xrccud008,xrccud009,xrccud010,xrccud011,xrccud012,xrccud013,xrccud014,xrccud015,xrccud016,
          xrccud017,xrccud018,xrccud019,xrccud020,xrccud021,xrccud022,xrccud023,xrccud024,xrccud025,
          xrccud026,xrccud027,xrccud028,xrccud029,xrccud030,xrcc015,xrcc016,xrcc017 INTO l_xrcc.*
  #161212-00005#2---modify-----end-------------
   FROM xrcc_t WHERE xrccent = g_enterprise
      AND xrccdocno = p_xrccdocno
      AND xrccseq   = p_xrccseq
      AND xrcc001   = p_xrcc001

   LET l_flag = cl_get_para(g_enterprise,g_site,'S-FIN-1002')

   LET l_xrce109 = 0   LET l_xrce119 = 0
   
#20141118 mark--str--   
#   LET l_sql = "SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)",
#               "  FROM xrce_t, xrda_t                                    ",
#               " WHERE     xrceent = '",g_enterprise,"'                  ",
#               "       AND xrdaent = xrceent                             ",
#               "       AND xrdasite = '",l_xrcc.xrccsite,"'              ",   #1105 add
#               "       AND xrdadocno = xrcedocno                         ",
#               "       AND xrdald = xrceld                               ",
#               "       AND xrdald = '",l_xrcc.xrccld,"'                  ",   #1105 add
#               "       AND xrdadocdt > '",e_date,"'             ",
#               "       AND xrce003 = '",l_xrcc.xrccdocno,"'              ",
#               "       AND xrce004 = '",l_xrcc.xrccseq,"'                ",   #1105 add
#               "       AND xrce005 = '",l_xrcc.xrcc001,"'                "
##1105 --mark--str--
##   IF NOT cl_null(l_flag) AND l_flag = 'Y' THEN
##      LET l_sql = l_sql," AND xrce004 = '",l_xrcc.xrccseq,"'"
##   END IF
##1105 --mark--end---
#   PREPARE axrp910_xrce_prep FROM l_sql
#   EXECUTE axrp910_xrce_prep INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
#20141118 mark--end-- 

#20141118 add--str--
   #原幣未沖金額
   #xrcc108-xrcc109(扣除大於當期的沖帳金額,反推)
   IF p_xreb004[1,1] <> '0' THEN
      SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
      INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
      FROM xrce_t,xrda_t
      WHERE xrceent=xrdaent AND xrcedocno=xrdadocno AND xrceld=xrdald
      AND xrceent=g_enterprise AND xrceld=l_xrcc.xrccld 
      AND xrce003=l_xrcc.xrccdocno AND xrce004=l_xrcc.xrccseq AND xrce005=l_xrcc.xrcc001
      AND xrdadocdt > e_date AND xrdastus='Y'
   ELSE
      SELECT SUM(xrcf105),SUM(xrcf115),SUM(xrcf125),SUM(xrcf135)
      INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
      FROM xrcf_t,xrca_t
      WHERE xrcfent=xrcaent AND xrcfdocno=xrcadocno AND xrcfld=xrcald
      AND xrcfent=g_enterprise AND xrcfld=l_xrcc.xrccld
      AND xrcf008=l_xrcc.xrccdocno AND xrcf009=l_xrcc.xrccseq
      AND xrcadocdt > e_date AND xrcastus='Y'
   END IF
#20141118 add--end--
   IF cl_null(l_xrce109) THEN LET l_xrce109 = 0 END IF
   IF cl_null(l_xrce119) THEN LET l_xrce119 = 0 END IF
   IF cl_null(l_xrce129) THEN LET l_xrce129 = 0 END IF
   IF cl_null(l_xrce139) THEN LET l_xrce139 = 0 END IF

#1105--add--str---
   LET r_xreb103 = l_xrcc.xrcc108 - l_xrcc.xrcc109 + l_xrce109
   LET r_xreb113 = l_xrcc.xrcc118 - l_xrcc.xrcc119 + l_xrce119 + l_xrcc.xrcc113
   LET r_xreb123 = l_xrcc.xrcc128 - l_xrcc.xrcc129 + l_xrce129 + l_xrcc.xrcc123
   LET r_xreb133 = l_xrcc.xrcc138 - l_xrcc.xrcc139 + l_xrce139 + l_xrcc.xrcc133
#1105--add--end---

#20141118 add--str--
   #應付回沖
   SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
     INTO l_apce109,l_apce119,l_apce129,l_apce139
     FROM apda_t,apce_t 
    WHERE apdaent = apceent AND apdald = apceld AND apdadocno = apcedocno
      AND apdaent = g_enterprise 
      AND apdadocdt > e_date
      AND apdasite = l_xrcc.xrccsite    #同一帳務中心
      AND apdald   = l_xrcc.xrccld       #同一帳套
      AND apce003 = l_xrcc.xrccdocno #AR 單號 
      AND apce004 = l_xrcc.xrccseq #AR 項次 
      AND apce005 = l_xrcc.xrcc001 #AR 期別
      AND apdastus= 'Y'
   IF cl_null(l_apce109) THEN LET l_apce109=0 END IF
   IF cl_null(l_apce119) THEN LET l_apce119=0 END IF
   IF cl_null(l_apce129) THEN LET l_apce129=0 END IF
   IF cl_null(l_apce139) THEN LET l_apce139=0 END IF
   LET r_xreb103=r_xreb103 + l_apce109
   LET r_xreb113=r_xreb113 + l_apce119
   LET r_xreb123=r_xreb123 + l_apce129
   LET r_xreb133=r_xreb133 + l_apce139
#20141118 add--end--

#1105 mark---str---
##1027 --mod--str--
##   IF NOT cl_null(l_flag) AND l_flag = 'Y' THEN
##      LET r_xreb103 = l_xrcc.xrcc108 - l_xrcc.xrcc109 + l_xrce109
##      LET r_xreb113 = l_xrcc.xrcc118 - l_xrcc.xrcc119 + l_xrce119
##      LET r_xreb123 = l_xrcc.xrcc128 - l_xrcc.xrcc129 + l_xrce129
##      LET r_xreb133 = l_xrcc.xrcc138 - l_xrcc.xrcc139 + l_xrce139
##   ELSE
#      #若系統設定的是不細沖至項次,需要在反推金額時,將反推的金額依照比例放入項次
#      SELECT SUM(xrcc108) INTO l_xrcc108 FROM xrcc_t WHERE xrccent = g_enterprise
#         AND xrccdocno = l_xrcc.xrccdocno AND xrcc001 = l_xrcc.xrcc001 AND xrccseq = l_xrcc.xrccseq
#      IF cl_null(l_xrcc108) OR l_xrcc108 = 0 THEN LET l_xrcc108 = 1 END IF
#      LET r_xreb103 = l_xrcc.xrcc108 - l_xrcc.xrcc109 + l_xrce109 * (l_xrcc.xrcc108 / l_xrcc108)
#      LET r_xreb103 = s_curr_round(l_xrcc.xrccsite,l_xrcc.xrcc100,r_xreb103,2)
#      LET r_xreb113 = l_xrcc.xrcc118 - l_xrcc.xrcc119 + l_xrce119 * (l_xrcc.xrcc108 / l_xrcc108)
#      LET r_xreb113 = s_curr_round(l_xrcc.xrccsite,g_glaa.glaa001,r_xreb113,2)
#      LET r_xreb123 = l_xrcc.xrcc128 - l_xrcc.xrcc129 + l_xrce129 * (l_xrcc.xrcc108 / l_xrcc108)
#      LET r_xreb123 = s_curr_round(l_xrcc.xrccsite,g_glaa.glaa016,r_xreb123,2)
#      LET r_xreb133 = l_xrcc.xrcc138 - l_xrcc.xrcc139 + l_xrce139 * (l_xrcc.xrcc108 / l_xrcc108)
#      LET r_xreb133 = s_curr_round(l_xrcc.xrccsite,g_glaa.glaa020,r_xreb133,2)
##   END IF 
##1027 --mod--end--
#1105 mark---end---

   IF cl_null(r_xreb103) THEN LET r_xreb103 = 0 END IF
   IF cl_null(r_xreb113) THEN LET r_xreb113 = 0 END IF
   IF cl_null(r_xreb123) THEN LET r_xreb123 = 0 END IF
   IF cl_null(r_xreb133) THEN LET r_xreb133 = 0 END IF

   RETURN r_xreb103,r_xreb113,r_xreb123,r_xreb133

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp920_ui_dialog_1()
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp920_ui_dialog_1()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   #add-point:ui_dialog段define
   DEFINE l_xref001         LIKE xref_t.xref001
   DEFINE l_xref002         LIKE xref_t.xref002
   DEFINE l_site            LIKE xrcb_t.xrcbsite
   DEFINE l_flag            LIKE type_t.dat
   DEFINE l_ooef017         LIKE ooef_t.ooef017
   DEFINE l_success         LIKE type_t.chr1
   #end add-point
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_xreb_d.getLength()
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
 
     #CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT BY NAME g_master.b_site,g_master.xref001,g_master.xref002

            BEFORE INPUT
               IF cl_null(g_master_t.b_site) THEN
                  CALL axrp920_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.b_site,g_master.b_site_desc,g_master.xref001,g_master.xref002
                    TO b_site,site_desc,xref001,xref002

            BEFORE FIELD b_site
               LET l_site = g_master.b_site

            AFTER FIELD b_site
               LET g_master.b_site_desc = ' '
               DISPLAY BY NAME g_master.b_site_desc
               IF NOT cl_null(g_master.b_site) THEN
                  #資料存在性、有效性檢查
                  LET g_errno = ' '
                  CALL s_fin_account_center_chk(g_master.b_site,'',3,g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.b_site
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF l_site != g_master.b_site THEN
                     SELECT ooef017 INTO l_ooef017 FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
                     LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

                     LET g_master.xref001 = YEAR(l_flag)
                     LET g_master.xref002 = MONTH(l_flag)
                  END IF
               END IF
               CALL axrp920_site_desc()

            BEFORE FIELD xref001
               LET l_xref001 = g_master.xref001

            ON CHANGE xref001
               IF NOT cl_null(g_master.xref001) THEN
                 #CALL axrp920_date_chk()
                 #IF NOT cl_null(g_errno) THEN
                 #   LET g_errparam.extend = g_master.xref001
                 #   LET g_errparam.code   = g_errno
                 #   LET g_errparam.popup  = TRUE 
                 #   CALL cl_err()
                 #   #chenying add 1126
                 #   LET g_master.xref001 = l_xref001 
                 #   NEXT FIELD CURRENT 
                 #   #chenying add 1126                       
                 #END IF
                 ##chenying add 1126
                  IF NOT cl_null(g_master.xref001) THEN
                     CALL axrp920_b_fill()
                  END IF            
                  #chenying add 1126                    
               END IF

            BEFORE FIELD xref002
               LET l_xref002 = g_master.xref002

            ON CHANGE xref002
               IF NOT cl_null(g_master.xref002) THEN
                 #02097--MARK--
                 #CALL axrp920_date_chk()
                 #IF NOT cl_null(g_errno) THEN
                 #   LET g_errparam.extend = g_master.xref002
                 #   LET g_errparam.code   = g_errno
                 #   LET g_errparam.popup  = TRUE 
                 #   CALL cl_err()
                 #   #chenying add 1126
                 #   LET g_master.xref002 = l_xref002 
                 #   NEXT FIELD CURRENT 
                 #   #chenying add 1126                     
                 #END IF
                 #02097--MARK--
                  #chenying add 1126
                  IF NOT cl_null(g_master.xref002) THEN
                     CALL axrp920_b_fill()
                  END IF            
                  #chenying add 1126                  
               END IF

            ON ACTION controlp INFIELD b_site
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.b_site       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 
               #CALL q_ooef001()                          #呼叫開窗  #161021-00050#4 mark
               LET g_qryparam.where = " ooefstus = 'Y' " #161021-00050#4 add
               CALL q_ooef001_46()                       #161021-00050#4 add
               LET g_master.b_site = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.b_site TO b_site               #顯示到畫面上
               CALL axrp920_site_desc()
               NEXT FIELD b_site                               #返回原欄位

         END INPUT 

         INPUT ARRAY g_xreb_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)    
            ON CHANGE sel
               LET l_ac = ARR_CURR()
               IF g_xreb_d[l_ac].sel = 'Y' THEN
                  CALL axrp920_clik_chk(l_ac)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xreb_d[l_ac].sel = 'N'
                     DISPLAY g_xreb_d[l_ac].sel TO sel
                     NEXT FIELD sel                     
                  END IF
               END IF
         END INPUT
         #end add-point
 
         #add-point:construct段落

         #end add-point
     
 
 
 
         #add-point:ui_dialog段自定義display array

         #end add-point

        #SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
 
         BEFORE DIALOG
            IF g_xreb_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            NEXT FIELD b_site
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            LET g_wc2 = " 1=1"
 
            #儲存WC資訊
           #CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
            CALL axrp920_b_fill()
      
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
 
         ON ACTION datarefresh   # 重新整理
            CALL axrp920_b_fill()
 
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
 
         #應用 qs19 樣板自動產生(Version:1)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall
               CALL axrp920_clik_chk(li_idx)
               IF NOT cl_null(g_errno) THEN
                  LET g_xreb_d[li_idx].sel = 'N'                    
               END IF
               #end add-point
            END FOR
            
            #add-point:ui_dialog段on action selall
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF NOT cl_null(g_xreb_d[li_idx].xreg005) OR g_xreb_d[li_idx].glca002 = '1' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'axr-00169'
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  LET g_xreb_d[li_idx].sel = "N"
               END IF
            END FOR
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  #151020-00003#4---s
                  CALL axrp920_clik_chk(li_idx)
                  IF NOT cl_null(g_errno) THEN
                     LET g_xreb_d[li_idx].sel = 'N'                    
                  END IF
                  #151020-00003#4---e
                  
                  IF NOT cl_null(g_xreb_d[li_idx].xreg005) OR g_xreb_d[li_idx].glca002 = '1' THEN  #1027 xreb023-->xreg005
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'axr-00169'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_xreb_d[li_idx].sel = "N"
                  END IF
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION batch_execute
            CALL axrp920_cycle_ld()

         ON ACTION click_sel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               CASE
                  WHEN g_xreb_d[li_idx].sel = 'N'
                     IF NOT cl_null(g_xreb_d[li_idx].xreg005) OR g_xreb_d[li_idx].glca002 = '1' THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axr-00169'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_xreb_d[li_idx].sel = "N"
                     ELSE
                        LET g_xreb_d[li_idx].sel = "Y"
                     END IF
                  WHEN g_xreb_d[li_idx].sel = 'Y'
                     LET g_xreb_d[li_idx].sel = "N"
               END CASE
            END FOR
            #end add-point
 
 
 
         #應用 qs16 樣板自動產生(Version:1)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp920_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
         
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
               EXIT DIALOG
            END IF
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION queryplansel
           #CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axrp920_b_fill()
            END IF
 
         ON ACTION qbe_select
            LET ls_wc = ""
            CALL cl_qbe_list("c") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axrp920_b_fill()
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後
            CLEAR FORM
            INITIALIZE g_master.* TO NULL
            CALL axrp920_def()
         #end add-point
 
      END DIALOG 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp920_clik_chk(p_ac)
# Input parameter: 
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp920_clik_chk(p_ac)
   DEFINE p_ac      LIKE type_t.num5
   DEFINE l_count   LIKE type_t.num5
   
   LET g_errno = NULL
   IF cl_null(p_ac) OR p_ac <= 0 THEN
      RETURN 
   END IF
      
   #02097--(S)
   CALL s_aap_evaluation_chk('1','AR',g_xreb_d[p_ac].xrebld,g_xreb_d[p_ac].xrebcomp,g_master.xref001,g_master.xref002) 
        RETURNING g_sub_success,g_errno
   #02097--(E)
   IF g_sub_success THEN
      #檢核 帳別+年度+期別+AR 有存在就提示要做還原
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM xreb_t
       WHERE xrebent = g_enterprise
         AND xrebld  = g_xreb_d[p_ac].xrebld
         AND xreb001 = g_master.xref001
         AND xreb002 = g_master.xref002
         AND xreb003 = 'AR'
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count > 0 THEN
         LET g_errno   = 'axr-00250'
      END IF
   END IF
END FUNCTION

 
{</section>}
 
