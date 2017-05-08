#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2015-01-27 15:00:16), PR版次:0009(2017-01-04 13:59:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000053
#+ Filename...: axrp901
#+ Description: 應收帳款檢核作業
#+ Creator....: 01727(2015-01-27 14:55:16)
#+ Modifier...: 01727 -SD/PR- 01531
 
{</section>}
 
{<section id="axrp901.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150112-00025#1   2015/03/27 By 01727 1.應立帳未立帳之交易單據：法人下之 site 皆要檢核  且要檢核輔帳是否立帳，取 aoos020 之輔帳　
#             　　　　　　　　　　　　　 2.執行帳款單檢核：增加條件單別參數要抛傳票之單別才檢核
#150309-00036#1   2015/04/01 By 01727 銷退單立帳條件sql統一:
#                                     1.統一加入 AND xmdk000 IN ('1','2','3','6')
#                                     2.銷退單條件增加排除xmdk082
#                                     OR (xmdk000 = 6 AND xmdk082<>'5') )
#160811-00009#4   2016/08/19 By 01531 账务中心/法人/账套权限控管
#160831-00032#2   2016/09/01 By 07900 金額為0之帳款單不檢核抛傳票否
#160905-00005#1   2016/09/05 By 01727 單身無法勾選
#161021-00050#4   2016/10/24 By 08729 處理組織開窗
#161128-00061#3   2016/12/01 by 02481 标准程式定义采用宣告模式,弃用.*写法
#161219-00009#6   2016/12/22 By 07900 排除有立暫估的出貨單。已立暫估但未立帳者,不應異常顯示。(xmdl053,54,55)
#161026-00010#2   2017/01/04 By 01531 改狀態條件抓取已复核狀態的资料
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
   xrebcomp LIKE xreb_t.xrebcomp, 
   xrebcomp_desc LIKE type_t.chr500, 
   xreb008 LIKE xreb_t.xreb008
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單头 type 宣告
 TYPE type_g_master RECORD
       b_site           LIKE xrcb_t.xrcbsite, 
       b_site_desc      LIKE ooefl_t.ooefl003,
       b_date           LIKE type_t.dat,
       b_chk1           LIKE type_t.chr1,
       b_chk2           LIKE type_t.chr1,
       b_chk3           LIKE type_t.chr1,
       b_chk4           LIKE type_t.chr1
       END RECORD

#模組變數(Module Variables)
DEFINE g_master         type_g_master
DEFINE g_master_t       type_g_master
#161128-00061#3-----modify--begin----------
#DEFINE g_glaa              RECORD LIKE glaa_t.* #160811-00009#4 
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
#161128-00061#3-----modify--end----------
#150408-00006(3)--20150408--add--str--
DEFINE g_glaa003        LIKE glaa_t.glaa003
DEFINE g_pdate_s        LIKE glav_t.glav004
DEFINE g_pdate_e        LIKE glav_t.glav004
#150408-00006(3)--20150408--add--end--
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
 
{<section id="axrp901.main" >}
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
   DECLARE axrp901_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrp901_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrp901_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp901 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp901_init()   
 
      #進入選單 Menu (="N")
      CALL axrp901_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrp901
      
   END IF 
   
   CLOSE axrp901_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrp901.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrp901_init()
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
   CALL s_fin_create_account_center_tmp()   #帳務組織底下所屬組織開窗的temptable
   #end add-point
 
   CALL axrp901_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrp901.default_search" >}
PRIVATE FUNCTION axrp901_default_search()
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
 
{<section id="axrp901.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp901_ui_dialog() 
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
   DEFINE l_site            LIKE xrcb_t.xrcbsite
   DEFINE l_ooef017         LIKE ooef_t.ooef017
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
  #CALL axrp901_ui_dialog_1()
  #RETURN
   CALL axrp901_def()   #160905-00005#1 Add
   #end add-point
 
   
   CALL axrp901_b_fill()
  
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
 
         CALL axrp901_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.b_site,g_master.b_date,g_master.b_chk1,g_master.b_chk2,g_master.b_chk3,g_master.b_chk4

            BEFORE INPUT
               IF cl_null(g_master_t.b_site) THEN
                  CALL axrp901_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.b_site,g_master.b_site_desc,g_master.b_chk1,
                       g_master.b_chk2,g_master.b_chk3,g_master.b_chk4
                    TO b_site,site_desc,b_chk1,b_chk2,b_chk3,b_chk4

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
               CALL axrp901_site_desc()


            ON ACTION controlp INFIELD b_site
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.b_site       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 
               #CALL q_ooef001()                          #161021-00050#4 mark
               LET g_qryparam.where = " ooefstus = 'Y'"  #161021-00050#4 add
               CALL q_ooef001_46()                       #161021-00050#4 add
               LET g_master.b_site = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.b_site TO b_site               #顯示到畫面上
               CALL axrp901_site_desc()
               NEXT FIELD b_site                               #返回原欄位
               
            AFTER INPUT
         END INPUT

         #160905-00005#1 Add  ---(S)---
         INPUT ARRAY g_xreb_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)    
            ON CHANGE sel
               LET l_ac = ARR_CURR()
               IF g_xreb_d[l_ac].sel = 'Y' THEN
               END IF
         END INPUT
         #160905-00005#1 Add  ---(E)---

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
{        #160905-00005#1 Add
         #end add-point
     
         DISPLAY ARRAY g_xreb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrp901_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrp901_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
}        #160905-00005#1 Add
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrp901_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD b_site
            #end add-point
            NEXT FIELD site
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            LET g_master_t.* =  g_master.*
            CALL axrp901_b_fill()
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
            CALL axrp901_b_fill()
 
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
            CALL axrp901_b_fill()
 
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
            CALL axrp901_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrp901_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrp901_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrp901_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
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
            CALL axrp901_process() 
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp901_filter()
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
            CALL axrp901_def()
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrp901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp901_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_ooef017       LIKE ooef_t.ooef017
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_ld_str        STRING #160811-00009#4
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
   #160811-00009#4  Add  ---(S)---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"ooef001","xrebcomp")
   LET g_wc = g_wc," AND ",l_ld_str
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   #160811-00009#4  Add  ---(E)--- 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xrebcomp,'',xreb008  ,DENSE_RANK() OVER( ORDER BY xreb_t.xrebld, 
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
 
   LET g_sql = "SELECT '',xrebcomp,'',xreb008",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.b_site,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL axrp901_get_ooef001_wc(ls_wc) RETURNING ls_wc    
   LET g_sql =" SELECT 'Y',ooef001,'',ooab002 FROM ooef_t,ooab_t ",
              "  WHERE ooefent = ooabent AND ooef001=ooabsite ",
              "    AND ooab001='S-FIN-2007'",
              "    AND ooefent = ? ",
              "    AND ooef001 IN ",ls_wc
              
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrp901_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp901_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xreb_d[l_ac].sel,g_xreb_d[l_ac].xrebcomp,g_xreb_d[l_ac].xrebcomp_desc, 
       g_xreb_d[l_ac].xreb008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL s_axrt300_xrca_ref('xrcasite',g_xreb_d[l_ac].xrebcomp,'','')
         RETURNING l_success,g_xreb_d[l_ac].xrebcomp_desc

      LET  g_xreb_d[l_ac].xreb008 = cl_get_para(g_enterprise,g_xreb_d[l_ac].xrebcomp,'S-FIN-2007')
      #end add-point
 
      CALL axrp901_detail_show("'1'")
 
      CALL axrp901_xreb_t_mask()
 
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
   FREE axrp901_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrp901_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrp901_detail_action_trans()
 
   LET l_ac = 1
   IF g_xreb_d.getLength() > 0 THEN
      CALL axrp901_b_fill2()
   END IF
 
      CALL axrp901_filter_show('xrebcomp','b_xrebcomp')
   CALL axrp901_filter_show('xreb008','b_xreb008')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrp901.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp901_b_fill2()
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
 
{<section id="axrp901.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp901_detail_show(ps_page)
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
 
{<section id="axrp901.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrp901_filter()
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
      CONSTRUCT g_wc_filter ON xrebcomp,xreb008
                          FROM s_detail1[1].b_xrebcomp,s_detail1[1].b_xreb008
 
         BEFORE CONSTRUCT
                     DISPLAY axrp901_filter_parser('xrebcomp') TO s_detail1[1].b_xrebcomp
            DISPLAY axrp901_filter_parser('xreb008') TO s_detail1[1].b_xreb008
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrebcomp>>----
         #Ctrlp:construct.c.filter.page1.b_xrebcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrebcomp
            #add-point:ON ACTION controlp INFIELD b_xrebcomp name="construct.c.filter.page1.b_xrebcomp"
            
            #END add-point
 
 
         #----<<b_xrebcomp_desc>>----
         #----<<b_xreb008>>----
         #Ctrlp:construct.c.filter.page1.b_xreb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb008
            #add-point:ON ACTION controlp INFIELD b_xreb008 name="construct.c.filter.page1.b_xreb008"
            
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
 
      CALL axrp901_filter_show('xrebcomp','b_xrebcomp')
   CALL axrp901_filter_show('xreb008','b_xreb008')
 
 
   CALL axrp901_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp901.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrp901_filter_parser(ps_field)
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
 
{<section id="axrp901.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp901_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp901_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrp901.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrp901_detail_action_trans()
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
 
{<section id="axrp901.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrp901_detail_index_setting()
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
 
{<section id="axrp901.mask_functions" >}
 &include "erp/axr/axrp901_mask.4gl"
 
{</section>}
 
{<section id="axrp901.other_function" readonly="Y" >}

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_site_desc
# Input parameter:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_site_desc()
   DEFINE l_success      LIKE type_t.chr1

   CALL s_axrt300_xrca_ref('xrcasite',g_master.b_site,'','') RETURNING l_success,g_master.b_site_desc
   DISPLAY g_master.b_site_desc TO site_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_def()
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_def()
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_ooef017         LIKE ooef_t.ooef017

   IF NOT cl_null(g_master.b_site) THEN RETURN END IF

   #抓取組織所屬帳務中心
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.b_site,g_errno
   CALL axrp901_site_desc()

   LET g_master.b_date = g_today
   LET g_master.b_chk1 = 'Y'
   LET g_master.b_chk2 = 'Y'
   LET g_master.b_chk3 = 'N'
   LET g_master.b_chk4 = 'N'

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_get_ooef001_wc
# Input parameter:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_get_ooef001_wc(p_wc)
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
# Descriptions...: 批處理
# Memo...........:
# Usage..........: CALL axrp901_process()
# Input parameter:  
# Date & Author..: 2014/9/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_process()
   DEFINE l_colname_1     STRING   
   DEFINE l_colname_2     STRING   
   DEFINE l_colname_3     STRING   
   DEFINE l_colname_4     STRING   
   DEFINE l_colname_5     STRING   
   DEFINE l_comment_1     STRING   
   DEFINE l_comment_2     STRING   
   DEFINE l_comment_3     STRING   
   DEFINE l_comment_4     STRING   
   DEFINE l_comment_5     STRING   
   DEFINE l_n             LIKE type_t.num5   
   #150408-00006(3)--20150408--add--str--
   DEFINE l_comp          LIKE glaa_t.glaacomp
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   #150408-00006(3)--20150408--add--end--

   CALL cl_err_collect_init()  #汇总错误讯息初始化
   CALL s_azzi902_get_gzzd('axrp901',"lbl_xrcald")    RETURNING l_colname_1,l_comment_1  #帳別
   CALL s_azzi902_get_gzzd('axrp901',"lbl_oobx004")   RETURNING l_colname_2,l_comment_2
   CALL s_azzi902_get_gzzd('axrp901',"lbl_apdadocno") RETURNING l_colname_4,l_comment_4  #單據号码
   CALL s_azzi902_get_gzzd('axrp901',"lbl_apdadocdt") RETURNING l_colname_3,l_comment_3  #單據日期
   CALL s_azzi902_get_gzzd('axrp901',"lbl_nmbbseq")   RETURNING l_colname_5,l_comment_5  #項次 
   LET g_coll_title[1] = l_colname_1
   LET g_coll_title[2] = l_colname_2
   LET g_coll_title[3] = l_colname_3
   LET g_coll_title[4] = l_colname_4
   LET g_coll_title[5] = l_colname_5 
      
   LET g_success = 'Y'
   
   #150408-00006(3)--20150408--add--str--   
   IF NOT cl_null(g_master.b_date) THEN 
      SELECT ooef017 INTO l_comp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_master.b_site
      
      SELECT glaa003 INTO g_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = l_comp
      
      CALL s_get_accdate(g_glaa003,g_master.b_date,'','') 
         RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                   l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   END IF
   #150408-00006(3)--20150408--add--end--

   CALL axrp901_execute()
   
   CALL cl_err_collect_show()  #显示错误讯息汇总

   IF g_success = 'Y' THEN
      #执行成功
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL axrp901_b_fill()
   ELSE
      #执行失败
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_execute()
# Input parameter:  
# Date & Author..: 2014/9/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_execute()
   DEFINE ls_wc     STRING
   DEFINE l_ld      LIKE glaa_t.glaald
   DEFINE l_n       LIKE type_t.num5
   
   #取該帳務中心範圍下的法人範圍下的所有帳套
   FOR l_n = 1 TO g_xreb_d.getLength()
      IF g_xreb_d[l_n].sel = "Y" THEN 
  
         #取得帳務組織下所屬成員
         CALL s_fin_account_center_sons_query('3',g_master.b_site,g_today,'1')
         #取得帳務組織下所屬成員之帳別   
         CALL s_fin_account_center_ld_str() RETURNING ls_wc
         #將取回的字串轉換為SQL條件
         CALL axrp901_get_ld_wc(ls_wc) RETURNING ls_wc
         
         LET g_sql =" SELECT glaald FROM glaa_t ",
                    "  WHERE glaaent = ? ",
                    "    AND glaald IN ",ls_wc,
                    "    AND glaacomp = '",g_xreb_d[l_n].xrebcomp,"'",
                    "    AND (glaa014 = 'Y' OR glaa008 = 'Y')" ,#主帳&平行帳               
                    "  ORDER BY glaald "
         PREPARE axrp901_ld_pb FROM g_sql
         DECLARE axrp901_ld_curs CURSOR FOR axrp901_ld_pb
         
         OPEN axrp901_ld_curs USING g_enterprise
         
         FOREACH axrp901_ld_curs INTO l_ld
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = 'N'
               EXIT FOREACH
            END IF  
         
            #161128-00061#3-----modify--begin----------
            #SELECT * INTO g_glaa.* 
             SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                    glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                    glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                    glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                    glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                    glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
            #161128-00061#3-----modify--end----------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_ld 
            
            #執行步驟:
            #STEP1.勾選則檢核:應立帳未立帳之交易單據
            #STEP2.勾選則檢核:執行帳款單檢核
            #STEP3.勾選則檢核:單據號碼連續號檢核
            #STEP4.勾選則檢核:已收款項無沖銷對應記錄者
            
            #======資料檢核階段======
            #STEP1.勾選則檢核:應立帳未立帳之交易單據
            IF g_master.b_chk1 = 'Y' THEN
               CALL axrp901_check1(l_ld)
            END IF
            
            #STEP2.勾選則檢核:帳款單檢核
            IF g_master.b_chk2 = 'Y' THEN
               CALL axrp901_check2(l_ld)
            END IF
            
            #STEP3.勾選則檢核:單據號碼連續號檢核
            IF g_master.b_chk3 = 'Y' THEN
               CALL axrp901_check3(g_xreb_d[l_n].xrebcomp,l_ld)
            END IF
            
            #STEP4.勾選則檢核:已收款項無沖銷對應記錄者
            IF g_master.b_chk4 = 'Y' THEN
               CALL axrp901_check4(l_ld)
            END IF

         END FOREACH
      END IF
   END FOR       
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_check1(p_ld)
# Input parameter:  
# Date & Author..: 2014/9/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_check1(p_ld)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE l_s             LIKE type_t.num5   #帳套主次 1-主帳套 2-次帳套一 3-次帳套二
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_sql           STRING
   DEFINE l_docno         LIKE xmda_t.xmdadocno
   #DEFINE l_dat           LIKE xmda_t.xmdadocdt    #150408-00006(3)--20150408--mark
   DEFINE l_dat           LIKE type_t.chr20         #150408-00006(3)--20150408--add 改成chr类型的,SELECT 日期栏位时也把日期类型的栏位转换成chr类型，不这样做，FOREACH处就会报-932的错(原因不明)
   DEFINE l_xmdb001       LIKE xmdb_t.xmdb001
   DEFINE l_slip          LIKE oobx_t.oobx001
   DEFINE l_prog          LIKE gzza_t.gzza001 
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_wc_xrcacomp   STRING
   DEFINE l_wc1           STRING
   DEFINE l_wc2           STRING
   DEFINE l_wc3           STRING   
   
   #STEP1.判斷主次帳套別
   #STEP2.檢核訂單
   #STEP3.檢核出貨單
   #STEP4.檢核門店收入日結
   #STEP5.檢核門店收款日結
   
   #STEP1.获取主次帳套別
   CALL s_axrt300_sel_ld(p_ld) RETURNING l_success,l_s

   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld

   CALL s_fin_account_center_sons_query('3',l_glaacomp,g_today,'')
   CALL s_fin_account_center_comp_str() RETURNING l_wc_xrcacomp
   CALL s_fin_get_wc_str(l_wc_xrcacomp) RETURNING l_wc_xrcacomp

   #STEP2.檢核訂單
   #訂單多帳期預收款檔未立帳 
   IF l_s = 1 THEN LET l_wc1 = "(xmdb005 <> xmdb008 OR xmdb006 <> xmdb009)" END IF
   IF l_s = 2 THEN LET l_wc1 = "(xmdb005 <> xmdb010 OR xmdb006 <> xmdb011)" END IF
   IF l_s = 3 THEN LET l_wc1 = "(xmdb005 <> xmdb014 OR xmdb006 <> xmdb015)" END IF
   
   LET l_sql = "SELECT DISTINCT xmdadocno,to_char(xmdadocdt,'YY-MM-DD'),xmdb001 ",   #150408-00006(3)--20150408 change xmdadocdt to  to_char(xmdadocdt,'YY-MM-DD')
               "  FROM xmda_t, xmdb_t ", 
               " WHERE xmdastus = 'Y' ",
               "   AND xmdbent = xmdaent AND xmdbent = '",g_enterprise,"'",
               "   AND xmdbdocno = xmdadocno                                                                                        ",
               "   AND xmda039 = '2'",
               "   AND xmdasite IN ",l_wc_xrcacomp,
               #"   AND xmdadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
               "   AND xmdadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "   AND ",l_wc1             
   PREPARE axrp901_xmda_prep FROM l_sql
   DECLARE axrp901_xmda_curs CURSOR FOR axrp901_xmda_prep

   DISPLAY l_sql

   LET l_docno = ""
   LET l_dat = ""
   LET l_xmdb001 = "" 
   LET l_prog = ""
   LET l_slip = ""   
   
   FOREACH axrp901_xmda_curs INTO l_docno,l_dat,l_xmdb001
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00176"  #應立未立帳或金額不符之交易單據 
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = cl_getmsg("axr-00185",g_dlang)
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = l_xmdb001
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()
      LET g_success = 'N'
   END FOREACH   
   
   #STEP3.檢核出貨單
   #151112-00005#1--mark--str--lujh
   #IF l_s = 1 THEN LET l_wc2 = "xmdl027 <> xmdl038" END IF
   #IF l_s = 2 THEN LET l_wc2 = "xmdl027 <> xmdl039" END IF
   #IF l_s = 3 THEN LET l_wc2 = "xmdl027 <> xmdl040" END IF  
   #151112-00005#1--mark--end--lujh
   #151112-00005#1--add--str--lujh   
   IF l_s = 1 THEN LET l_wc2 = "xmdl022 <> xmdl038 AND xmdl022 - xmdl038 <> xmdl053 " END IF  #161219-00009#6 add  AND xmdl022 - xmdl038 <> xmdl053
   IF l_s = 2 THEN LET l_wc2 = "xmdl022 <> xmdl039 AND xmdl022 - xmdl039 <> xmdl054 " END IF  #161219-00009#6 add  AND xmdl022 - xmdl039 <> xmdl054
   IF l_s = 3 THEN LET l_wc2 = "xmdl022 <> xmdl040 AND xmdl022 - xmdl040 <> xmdl055 " END IF  #161219-00009#6 add  AND xmdl022 - xmdl040 <> xmdl055
   #151112-00005#1--add--end--lujh  

   LET l_sql = "SELECT xmdldocno,to_char(xmdkdocdt,'YY-MM-DD'),xmdlseq",   #150408-00006(3)--20150408 change xmdkdocdt to  to_char(xmdkdocdt,'YY-MM-DD')
               "  FROM xmdl_t,xmdk_t ",
               " WHERE xmdkent = xmdlent AND xmdkent = '",g_enterprise,"'",
               "   AND xmdkstus ='S' ",
               "   AND xmdkdocno = xmdldocno ",
               "   AND xmdk000 IN ('1','2','3','6')  ",   #150309-00036#1 Add
               "   AND ((xmdk000 <> 6 AND xmdk002 = '1') OR (xmdk000 = 6 AND xmdk082 <> 5))",   #150309-00036#1 Add
               "   AND xmdksite IN ",l_wc_xrcacomp,
               #"   AND xmdkdocdt <=",g_master.b_date,    #150213-00005(4)--20150330--mark
               #"   AND xmdk001 <=",g_master.b_date,       #150213-00005(4)--20150330--add  #150408-00006(3)--20150408--mark
               "   AND xmdk001  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "   AND ",l_wc2 
               
   PREPARE axrp901_xmdl_prep FROM l_sql
   DECLARE axrp901_xmdl_curs CURSOR FOR axrp901_xmdl_prep

   LET l_docno = ""
   LET l_dat = ""
   LET l_xmdb001 = ""
   LET l_prog = ""
   LET l_slip = ""      
   
   FOREACH axrp901_xmdl_curs INTO l_docno,l_dat,l_xmdb001 
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00176"  #應立未立帳或金額不符之交易單據 
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = cl_getmsg("axr-00186",g_dlang)
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = l_xmdb001
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err() 
      LET g_success = 'N'
   END FOREACH   
   
   #STEP4.檢核門店收入日結
   IF l_s = 1 THEN LET l_wc3 = "debz016 <> debz013" END IF
   IF l_s = 2 THEN LET l_wc3 = "debz017 <> debz013" END IF
   IF l_s = 3 THEN LET l_wc3 = "debz018 <> debz013" END IF  

   LET l_sql = "SELECT debzsite,to_char(debz002,'YY-MM-DD'),'' ",  #150408-00006(3)--20150408 change debz002 to  to_char(debz002,'YY-MM-DD')
               "  FROM debz_t ",
               " WHERE debzent = '",g_enterprise,"'",
               "   AND debzsite IN ",l_wc_xrcacomp,
               #"   AND debz002 <=",g_master.b_date,   #150408-00006(3)--20150408--mark
               "   AND debz002  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "   AND ",l_wc3               
               
   PREPARE axrp901_debz_prep FROM l_sql
   DECLARE axrp901_debz_curs CURSOR FOR axrp901_debz_prep

   LET l_docno = ""
   LET l_dat = ""
   LET l_xmdb001 = ""
   LET l_prog = ""   
   
   FOREACH axrp901_debz_curs INTO l_docno,l_dat,l_xmdb001

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00176"  #應立未立帳或金額不符之交易單據 
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = cl_getmsg("axr-00187",g_dlang) 
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = "adep100" 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()    
      LET g_success = 'N'
   END FOREACH
   
   #STEP5.檢核門店收款日結
   IF l_s = 1 THEN LET l_wc3 = "deby016 <> deby004" END IF
   IF l_s = 2 THEN LET l_wc3 = "deby017 <> deby004" END IF
   IF l_s = 3 THEN LET l_wc3 = "deby018 <> deby004" END IF  

   LET l_sql = "SELECT debysite,to_char(deby003,'YY-MM-DD'),'' ",  #150408-00006(3)--20150408 change deby003 to  to_char(deby003,'YY-MM-DD')
               "  FROM deby_t ",
               " WHERE debyent = '",g_enterprise,"'",
               "   AND debysite IN ",l_wc_xrcacomp,
               #"   AND deby003 <=",g_master.b_date,   #150408-00006(3)--20150408--mark
               "   AND deby003  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "   AND ",l_wc3               
               
   PREPARE axrp901_deby_prep FROM l_sql
   DECLARE axrp901_deby_curs CURSOR FOR axrp901_deby_prep

   LET l_docno = ""
   LET l_dat = ""
   LET l_xmdb001 = ""
   LET l_prog = ""   
   
   FOREACH axrp901_debz_curs INTO l_docno,l_dat,l_xmdb001

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00176"  #應立未立帳或金額不符之交易單據
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = cl_getmsg("axr-00187",g_dlang)
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = "adep100" 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()    
      LET g_success = 'N'
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_check2(p_ld)
# Input parameter:  
# Date & Author..: 2014/9/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_check2(p_ld)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE l_glaald        LIKE glaa_t.glaald
   DEFINE l_sql           STRING
   DEFINE l_docno         LIKE xmda_t.xmdadocno
   #DEFINE l_dat           LIKE xmda_t.xmdadocdt    #150408-00006(3)--20150408--mark
   DEFINE l_dat           LIKE type_t.chr20         #150408-00006(3)--20150408--add 改成chr类型的,SELECT 日期栏位时也把日期类型的栏位转换成chr类型，不这样做，FOREACH处就会报-932的错(原因不明)
   DEFINE l_xmdb001       LIKE xmdb_t.xmdb001
   DEFINE l_slip          LIKE oobx_t.oobx001
   DEFINE l_prog          LIKE gzza_t.gzza001 
   DEFINE l_s             LIKE type_t.num5   #帳套主次 1-主帳套 2-次帳套一 3-次帳套二
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_dfin0030      LIKE type_t.chr1
   DEFINE l_comp          LIKE xrca_t.xrcacomp
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_wc_xrcacomp   STRING
   DEFINE l_ooac004       LIKE ooac_t.ooac004   #20151112 add lujh

   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld

   CALL s_fin_account_center_sons_query('3',l_glaacomp,g_today,'')
   CALL s_fin_account_center_comp_str() RETURNING l_wc_xrcacomp
   CALL s_fin_get_wc_str(l_wc_xrcacomp) RETURNING l_wc_xrcacomp

   #STEP1:應確認未確認單據檢核        1)立帳檔;2)沖帳單
   #STEP2:應轉傳票未轉置傳票檢核      1)立帳檔;2)沖帳單
   #STEP3:已轉傳票但未確認者檢核      1)立帳檔;2)沖帳單
   #STEP4:檢核次帳套有無隨主帳套產生   1)應收單;2)沖帳單
   #STEP5:檢核次帳套是否產生傳票      1)立帳檔;2)沖帳單
   
   #STEP1:應確認未確認單據檢核 
   #1)立帳檔
   LET l_sql = "SELECT xrcadocno,to_char(xrcadocdt,'YY-MM-DD') FROM xrca_t  ",  #150408-00006(3)--20150408 change xrcadocdt to  to_char(xrcadocdt,'YY-MM-DD')
               " WHERE     xrcastus = 'N'                                   ",
               "       AND xrcaent  = '",g_enterprise,"'                    ",
               "       AND xrcasite IN ",l_wc_xrcacomp,
               #"       AND xrcadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
               "       AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "       AND xrcald = '",p_ld,"'                                   "
   PREPARE axrp901_xrca_prep FROM l_sql
   DECLARE axrp901_xrca_curs CURSOR FOR axrp901_xrca_prep

   LET l_docno = ""
   LET l_dat = ""
   LET l_prog = ""   
   
   FOREACH axrp901_xrca_curs INTO l_docno,l_dat
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00177"  #應確認未確認單據檢核  
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ""
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()    
      LET g_success = 'N'
   END FOREACH   

   #2)沖帳單
   LET l_sql = "SELECT xrdadocno,to_char(xrdadocdt,'YY-MM-DD'),xrdacomp FROM xrda_t ",  #150408-00006(3)--20150408 change xrdadocdt to  to_char(xrdadocdt,'YY-MM-DD')
               " WHERE     xrdastus = 'N' ",
               "       AND xrdaent = '",g_enterprise,"'  ",
               "       AND xrdasite IN ",l_wc_xrcacomp,
               #"       AND xrdadocdt <=",g_master.b_date,    #150408-00006(3)--20150408--mark
               "       AND xrdadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "       AND xrdald = '",p_ld,"'   "
   PREPARE axrp901_xrda_prep FROM l_sql
   DECLARE axrp901_xrda_curs CURSOR FOR axrp901_xrda_prep

   LET l_docno = ""
   LET l_dat = ""
   LET l_prog = ""   
   
   FOREACH axrp901_xrda_curs INTO l_docno,l_dat,l_comp
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip
      #150112-00025#1 Add  ---(S)---
      CALL s_fin_get_doc_para(p_ld,l_comp,l_slip,'D-FIN-0030') RETURNING l_dfin0030
      IF l_dfin0030 = 'N' THEN CONTINUE FOREACH END IF
      #150112-00025#1 Add  ---(E)---

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00177"  #應確認未確認單據檢核 
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ""
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()    
      LET g_success = 'N'
   END FOREACH      

   #STEP2:應轉傳票未轉置傳票檢核
   #1)立帳檔
   LET l_sql = "SELECT xrcadocno,to_char(xrcadocdt,'YY-MM-DD') FROM xrca_t ",  #150408-00006(3)--20150408 change xrcadocdt to  to_char(xrcadocdt,'YY-MM-DD')
               " WHERE     xrcastus = 'Y' AND xrca038 IS NULL  ",
               "       AND xrcaent = '",g_enterprise,"'",
               #"       AND xrcadocdt <=",g_master.b_date,  #150408-00006(3)--20150408--mark
               "       AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "       AND xrcasite IN ",l_wc_xrcacomp,
               "       AND xrcald = '",p_ld,"' ",
               "       AND xrca103 > 0 "       #150213-00005(4)--20150330--add   #160831-00032#2   2016/09/01 By 07900 mod '>='->'>' 
   PREPARE axrp901_xrca_prep2 FROM l_sql
   DECLARE axrp901_xrca_curs2 CURSOR FOR axrp901_xrca_prep2

   LET l_docno = ""
   LET l_dat = ""
   LET l_prog = ""   
   
   FOREACH axrp901_xrca_curs2 INTO l_docno,l_dat
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

      #151112-00005#1--add--str--lujh
      #是否抛傳票    
      LET l_ooac004 = ''
      CALL s_fin_get_doc_para(p_ld,'',l_slip,'D-FIN-0030') RETURNING l_ooac004
      
      IF l_ooac004 = 'N' THEN 
         CONTINUE FOREACH
      END IF
      #151112-00005#1--add--end--lujh

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00178"  #應轉置傳票未轉置傳票檢核  
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ""
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()    
      LET g_success = 'N'
   END FOREACH   

   #2)沖帳單
   LET l_sql = "SELECT xrdadocno,to_char(xrdadocdt,'YY-MM-DD') FROM xrda_t  ",  #150408-00006(3)--20150408 change xrdadocdt to  to_char(xrdadocdt,'YY-MM-DD')
               " WHERE     xrdastus = 'Y' AND xrda014 IS NULL               ",
               "       AND xrdaent = '",g_enterprise,"'                     ",
               "       AND xrdasite IN ",l_wc_xrcacomp,
               #"       AND xrdadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
               "       AND xrdadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "       AND xrdald = '",p_ld,"'                                   "
   PREPARE axrp901_xrda_prep2 FROM l_sql
   DECLARE axrp901_xrda_curs2 CURSOR FOR axrp901_xrda_prep2

   LET l_docno = ""
   LET l_dat = ""
   LET l_prog = ""   
   
   FOREACH axrp901_xrda_curs2 INTO l_docno,l_dat
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

      #151112-00005#1--add--str--lujh
      #是否抛傳票    
      LET l_ooac004 = ''
      CALL s_fin_get_doc_para(p_ld,'',l_slip,'D-FIN-0030') RETURNING l_ooac004
      
      IF l_ooac004 = 'N' THEN 
         CONTINUE FOREACH
      END IF
      #151112-00005#1--add--end--lujh

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00178"  #應轉置傳票未轉置傳票檢核
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ""
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()    
      LET g_success = 'N'
   END FOREACH        

   #STEP3:已轉傳票但未確認者檢核
   #1)
   LET l_sql = "SELECT xrcadocno,to_char(xrcadocdt,'YY-MM-DD') FROM xrca_t,glap_t   ",   #150408-00006(3)--20150408 change xrcadocdt to  to_char(xrcadocdt,'YY-MM-DD')
               " WHERE     xrcastus = 'Y'                                           ",
               "       AND xrca038 = glapdocno                                      ",
               "       AND xrcaent = glapent                                        ",
               "       AND xrcald = glapld                                          ",
               "       AND glapstus = 'N'                                           ",
               "       AND xrcasite IN ",l_wc_xrcacomp,
               "       AND xrcaent = '",g_enterprise,"'                             ",
               #"       AND xrcadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
               "       AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "       AND xrcald = '",p_ld,"'                                   "
   PREPARE axrp901_xrca_prep3 FROM l_sql
   DECLARE axrp901_xrca_curs3 CURSOR FOR axrp901_xrca_prep3
 
   LET l_docno = ""
   LET l_dat = ""
   LET l_prog = ""   
   
   FOREACH axrp901_xrca_curs3 INTO l_docno,l_dat
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00179"  #已轉置傳票但未確認者檢核 
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ""
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()  
      LET g_success = 'N'
   END FOREACH

   #2)
   LET l_sql = "SELECT xrdadocno,to_char(xrdadocdt,'YY-MM-DD') FROM xrda_t,glap_t  ",  #150408-00006(3)--20150408 change xrdadocdt to  to_char(xrdadocdt,'YY-MM-DD')
               " WHERE     xrdastus = 'Y'                                          ",
               "       AND xrda014 = glapdocno                                     ",
               "       AND xrdaent = glapent                                       ",
               "       AND xrdald = glapld                                         ",
               "       AND xrdasite IN ",l_wc_xrcacomp,
               "       AND glapstus = 'N'                                          ",
               "       AND xrdaent = '",g_enterprise,"'                            ",
               #"       AND xrdadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
               "       AND xrdadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",  #150408-00006(3)--20150408--add
               "       AND xrdald = '",p_ld,"'                                   "
   PREPARE axrp901_xrda_prep3 FROM l_sql
   DECLARE axrp901_xrda_curs3 CURSOR FOR axrp901_xrda_prep3
 
   LET l_docno = ""
   LET l_dat = ""
   LET l_prog = ""   
   
   FOREACH axrp901_xrda_curs3 INTO l_docno,l_dat
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "axr-00179"  #已轉置傳票但未確認者檢核 
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ""
      LET g_errparam.coll_vals[1] = p_ld
      LET g_errparam.coll_vals[2] = l_prog 
      LET g_errparam.coll_vals[3] = l_dat
      LET g_errparam.coll_vals[4] = l_docno
      LET g_errparam.coll_vals[5] = ''
      LET g_errparam.sqlerr = SQLCA.SQLCODE  
      CALL cl_err()  
      LET g_success = 'N'
   END FOREACH
   
   #STEP4:檢核次帳套有無隨主帳套產生     
   IF g_glaa.glaa014 = 'Y' THEN 
      LET l_sql = " SELECT glaald FROM glaa_t ",
                  "  WHERE glaacomp = '",g_glaa.glaacomp,"'",
                  "    AND glaa023 = '2' "
      PREPARE axrp901_glaa_prep FROM l_sql
      DECLARE axrp901_glaa_curs CURSOR FOR axrp901_glaa_prep

      #1)應收單
      LET l_sql = " SELECT xrcadocno,to_char(xrcadocdt,'YY-MM-DD') FROM xrca_t  ",  #150408-00006(3)--20150408 change xrcadocdt to  to_char(xrcadocdt,'YY-MM-DD')
                  "  WHERE xrcald = ? ",
               "       AND xrcasite IN ",l_wc_xrcacomp
      PREPARE axrp901_xrca_prep4 FROM l_sql
      DECLARE axrp901_xrca_curs4 CURSOR FOR axrp901_xrca_prep4
      
      LET l_glaald = ""
      LET l_docno = ""
      LET l_dat = ""
      LET l_prog = ""  
   
      FOREACH axrp901_glaa_curs INTO l_glaald
        FOREACH axrp901_xrca_curs4 USING l_glaald INTO l_docno,l_dat
           SELECT COUNT(*) INTO l_cnt FROM xrca_t
            WHERE xrcaent = g_enterprise
              AND xrcald = l_glaald
              AND xrcadocno = l_docno
           IF l_cnt = 0 THEN
              CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
              SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip           
           
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "axr-00180"  #檢核次帳套有無跟隨主帳套產生 
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = ""
              LET g_errparam.coll_vals[1] = l_glaald
              LET g_errparam.coll_vals[2] = l_prog 
              LET g_errparam.coll_vals[3] = l_dat
              LET g_errparam.coll_vals[4] = l_docno
              LET g_errparam.coll_vals[5] = ''
              LET g_errparam.sqlerr = SQLCA.SQLCODE  
              CALL cl_err()  
              LET g_success = 'N'           
           END IF
        END FOREACH
      END FOREACH

      #2)沖帳單
      LET l_sql = " SELECT xrdadocno,to_char(xrdadocdt,'YY-MM-DD') FROM xrda_t  ", #150408-00006(3)--20150408 change xrdadocdt to  to_char(xrdadocdt,'YY-MM-DD')
                  "  WHERE xrdald = ? ",
               "       AND xrdasite IN ",l_wc_xrcacomp,
               #"       AND xrdadocdt <=",g_master.b_date  #150408-00006(3)--20150408--mark
               "       AND xrdadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'"   #150408-00006(3)--20150408--add
      PREPARE axrp901_xrda_prep4 FROM l_sql
      DECLARE axrp901_xrda_curs4 CURSOR FOR axrp901_xrda_prep4
 
      LET l_glaald = ""
      LET l_docno = ""
      LET l_dat = ""
      LET l_prog = ""  
      
      FOREACH axrp901_glaa_curs INTO l_glaald
        FOREACH axrp901_xrda_curs4 USING l_glaald INTO l_docno,l_dat
           SELECT COUNT(*) INTO l_cnt FROM xrca_t
            WHERE xrdaent = g_enterprise
              AND xrdald = l_glaald
              AND xrdadocno = l_docno
           IF l_cnt = 0 THEN
              CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
              SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip           
           
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "axr-00180"  #檢核次帳套有無跟隨主帳套產生  
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = ""
              LET g_errparam.coll_vals[1] = l_glaald
              LET g_errparam.coll_vals[2] = l_prog 
              LET g_errparam.coll_vals[3] = l_dat
              LET g_errparam.coll_vals[4] = l_docno
              LET g_errparam.coll_vals[5] = ''
              LET g_errparam.sqlerr = SQLCA.SQLCODE  
              CALL cl_err()  
              LET g_success = 'N'           
           END IF
        END FOREACH
      END FOREACH      
   END IF
   
   
   #STEP5:檢核次帳套是否產生傳票        
   IF g_glaa.glaa014 = 'Y' THEN 

      #1)應收單
      LET l_sql = " SELECT xrcadocno,to_char(xrcadocdt,'YY-MM-DD') FROM xrca_t  ",   #150408-00006(3)--20150408 change xrcadocdt to  to_char(xrcadocdt,'YY-MM-DD')
                  "  WHERE xrcald = ? ",
                  "    AND xrca038 IS NULL ",
                  "    AND xrcasite IN ",l_wc_xrcacomp,
                  #"    AND xrcadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
                  "    AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",   #150408-00006(3)--20150408--add
                  "    AND xrcastus <> 'X'"
                  
      PREPARE axrp901_xrca_prep5 FROM l_sql
      DECLARE axrp901_xrca_curs5 CURSOR FOR axrp901_xrca_prep5
      
      LET l_glaald = ""
      LET l_docno = ""
      LET l_dat = ""
      LET l_prog = ""  
   
      FOREACH axrp901_glaa_curs INTO l_glaald
        FOREACH axrp901_xrca_curs5 USING l_glaald INTO l_docno,l_dat
              CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
              SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip           
              #150112-00025#1 Add  ---(S)---
              CALL s_fin_get_doc_para(l_glaald,l_comp,l_slip,'D-FIN-0030') RETURNING l_dfin0030
              IF l_dfin0030 = 'N' THEN CONTINUE FOREACH END IF
              #150112-00025#1 Add  ---(E)---
           
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "axr-00180" #檢核次帳套有無跟隨主帳套產生  
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = ""
              LET g_errparam.coll_vals[1] = l_glaald
              LET g_errparam.coll_vals[2] = l_prog 
              LET g_errparam.coll_vals[3] = l_dat
              LET g_errparam.coll_vals[4] = l_docno
              LET g_errparam.coll_vals[5] = ''
              LET g_errparam.sqlerr = SQLCA.SQLCODE  
              CALL cl_err()  
              LET g_success = 'N'           

        END FOREACH
      END FOREACH

      #2)沖帳單
      LET l_sql = " SELECT xrdadocno,to_char(xrdadocdt,'YY-MM-DD') FROM xrda_t  ",   #150408-00006(3)--20150408 change xrdadocdt to  to_char(xrdadocdt,'YY-MM-DD')
                  "  WHERE xrdald = ? ",
                  "    AND xrda014 IS NULL ",
                  "    AND xrdasite IN ",l_wc_xrcacomp,
                  #"    AND xrdadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
                  "    AND xrdadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",   #150408-00006(3)--20150408--add
                  "    AND xrdastus <> 'X'"                  
      PREPARE axrp901_xrda_prep5 FROM l_sql
      DECLARE axrp901_xrda_curs5 CURSOR FOR axrp901_xrda_prep5
 
      LET l_glaald = ""
      LET l_docno = ""
      LET l_dat = ""
      LET l_prog = ""  
      
      FOREACH axrp901_glaa_curs INTO l_glaald
        FOREACH axrp901_xrda_curs5 USING l_glaald INTO l_docno,l_dat
 
              CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
              SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip           
              #150112-00025#1 Add  ---(S)---
              CALL s_fin_get_doc_para(l_glaald,l_comp,l_slip,'D-FIN-0030') RETURNING l_dfin0030
              IF l_dfin0030 = 'N' THEN CONTINUE FOREACH END IF
              #150112-00025#1 Add  ---(E)---
           
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "axr-00180" #檢核次帳套有無跟隨主帳套產生
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = ""
              LET g_errparam.coll_vals[1] = l_glaald
              LET g_errparam.coll_vals[2] = l_prog 
              LET g_errparam.coll_vals[3] = l_dat
              LET g_errparam.coll_vals[4] = l_docno
              LET g_errparam.coll_vals[5] = ''
              LET g_errparam.sqlerr = SQLCA.SQLCODE  
              CALL cl_err()  
              LET g_success = 'N'           

        END FOREACH
      END FOREACH      
   END IF   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_check3(p_comp,p_ld)
# Input parameter:  
# Date & Author..: 2014/9/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_check3(p_comp,p_ld)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE l_ar    DYNAMIC ARRAY OF RECORD
        tabnm     LIKE type_t.chr4
                  END RECORD   
   DEFINE l_sql           STRING
   DEFINE l_slip     LIKE oobx_t.oobx001
   DEFINE l_docno    LIKE xrca_t.xrcadocno
   DEFINE l_docno1   LIKE xrca_t.xrcadocno
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_flag     LIKE type_t.chr1
   DEFINE i,j        LIKE type_t.num5
   DEFINE l_max      LIKE type_t.num10   
   #DEFINE l_dat           LIKE xmda_t.xmdadocdt    #150408-00006(3)--20150408--mark
   DEFINE l_dat           LIKE type_t.chr20         #150408-00006(3)--20150408--add 改成chr类型的,SELECT 日期栏位时也把日期类型的栏位转换成chr类型，不这样做，FOREACH处就会报-932的错(原因不明)
   DEFINE l_xmdb001       LIKE xmdb_t.xmdb001
   DEFINE l_prog          LIKE gzza_t.gzza001 
   DEFINE l_doc_len  LIKE type_t.num5       #單號總長度
   DEFINE l_slip_len LIKE type_t.num5       #單別長度
   DEFINE l_oobx007  LIKE oobx_t.oobx007    #所剩流水碼 
   DEFINE p_comp     LIKE ooef_t.ooef017   
   DEFINE l_success  LIKE type_t.chr1
   
   #取得單據流水號總長度
   LET l_doc_len = cl_get_para(g_enterprise,p_comp,'E-COM-0005')
   #單別長度
   LET l_slip_len = 0
   LET l_cnt  = cl_get_para(g_enterprise,p_comp,'E-COM-0001')   #單別長度
   IF l_cnt > 0 THEN
      LET l_slip_len = l_slip_len + l_cnt
   END IF
   LET l_cnt  = cl_get_para(g_enterprise,p_comp,'E-COM-0003')   #營運據點長度
   IF l_cnt > 0 THEN
      LET l_slip_len = l_slip_len + l_cnt
   END IF
   LET l_flag = cl_get_para(g_enterprise,p_comp,'E-COM-0002')   #是否有區隔符號
   IF l_flag = 'Y' THEN
      LET l_slip_len = l_slip_len + 1
   END IF
   LET l_flag = cl_get_para(g_enterprise,p_comp,'E-COM-0004')   #是否有區隔符號
   IF l_flag = 'Y' THEN
      LET l_slip_len = l_slip_len + 1
   END IF
   
   LET l_ar[1].tabnm = 'xrca' 
   LET l_ar[2].tabnm = 'xrda' 
   FOR i = 1 TO l_ar.getLength()
   #1.取一個完整的單號,才能取單別
      LET l_sql = " SELECT xrcadocno",
                  "   FROM xrca_t ",
                  "  WHERE xrcaent = ? AND xrcald = ?",
                  "    AND LENGTH(xrcadocno) = ?",
                  #"    AND xrcadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
                  "    AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",   #150408-00006(3)--20150408--add
                  "    AND xrcadocno LIKE ?"
      LET l_sql = cl_replace_str(l_sql,'xrca',l_ar[i].tabnm)
      PREPARE xrcadocno_pre FROM l_sql
      
      #2.該單別最大流水號
      LET l_sql = " SELECT MAX(substr(xrcadocno,?,?))",
                  "   FROM xrca_t ",
                  "  WHERE xrcaent = ? AND xrcald = ?",
                  "    AND LENGTH(xrcadocno) = ?",
                  #"    AND xrcadocdt <=",g_master.b_date,  #150408-00006(3)--20150408--mark
                  "    AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",   #150408-00006(3)--20150408--add
                  "    AND xrcadocno LIKE ?"
      LET l_sql = cl_replace_str(l_sql,'xrca',l_ar[i].tabnm)
      PREPARE max_pre FROM l_sql
      
      #3.判斷號碼是否存在xrca_t
      LET l_sql = " SELECT count(1) ",
                  "   FROM xrca_t",
                  "  WHERE xrcaent = ? AND xrcald = ? ",
                  #"    AND xrcadocdt <=",g_master.b_date,   #150408-00006(3)--20150408--mark
                  "    AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",   #150408-00006(3)--20150408--add
                  "    AND LENGTH(xrcadocno) = ? ",
                  "    AND to_number(substr(xrcadocno,7,4)) = ? ",
                  "    AND xrcadocno LIKE ? "
      LET l_sql = cl_replace_str(l_sql,'xrca',l_ar[i].tabnm)
      PREPARE xrca_t_pre FROM l_sql
      
      #4.有哪些單別要跑
      LET l_sql = " SELECT DISTINCT substr(xrcadocno,1,?)",
                   "  FROM xrca_t",
                   " WHERE xrcaent = ? AND xrcald = ?",
                   #"   AND xrcadocdt <=",g_master.b_date     #150408-00006(3)--20150408--mark
                   "    AND xrcadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'"   #150408-00006(3)--20150408--add
      LET l_sql = cl_replace_str(l_sql,'xrca',l_ar[i].tabnm)
      PREPARE chk_docno_pre FROM l_sql
      DECLARE chk_docno_cur CURSOR FOR chk_docno_pre
      
      LET l_docno1 = ""
      
      FOREACH chk_docno_cur USING l_slip_len,g_enterprise,p_ld INTO l_docno1
         LET l_docno1 = l_docno1,'%'

         #1.取得該單別相關資訊(1.l_slip:單據別/2.l_oobx007:所剩流水號長度)
         EXECUTE xrcadocno_pre USING g_enterprise,p_ld,l_doc_len,l_docno1 INTO l_docno
         CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
         SELECT oobx007 INTO l_oobx007 FROM oobx_t
          WHERE oobxent = g_enterprise AND oobx001 = l_slip AND oobx002 = 'AXR'
          
         #2.取得目前流水碼已編到的最大位數
         LET i = l_doc_len-l_oobx007+1
         EXECUTE max_pre USING i,l_oobx007,g_enterprise,p_ld,l_doc_len,l_docno INTO l_max
         FOR j = 1 TO l_max
            LET l_cnt = 0 
            EXECUTE xrca_t_pre USING g_enterprise,p_ld,l_doc_len,j,l_docno INTO l_cnt
            IF l_cnt = 0 THEN
               CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
               SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip              
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "axr-00181"  #單據號碼連續號檢核 
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = ""
               LET g_errparam.coll_vals[1] = p_ld
               LET g_errparam.coll_vals[2] = l_prog 
               LET g_errparam.coll_vals[3] = l_dat
               LET g_errparam.coll_vals[4] = l_docno
               LET g_errparam.coll_vals[5] = ''
               LET g_errparam.sqlerr = SQLCA.SQLCODE  
               CALL cl_err()  
               LET g_success = 'N'    
            END IF
         END FOR
      END FOREACH
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_check4(p_ld)
# Input parameter:  
# Date & Author..: 2014/9/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_check4(p_ld)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE l_s             LIKE type_t.num5   #帳套主次 1-主帳套 2-次帳套一 3-次帳套二   
   DEFINE l_sql           STRING
   DEFINE l_docno         LIKE xmda_t.xmdadocno
   #DEFINE l_dat           LIKE xmda_t.xmdadocdt    #150408-00006(3)--20150408--mark
   DEFINE l_dat           LIKE type_t.chr20         #150408-00006(3)--20150408--add 改成chr类型的,SELECT 日期栏位时也把日期类型的栏位转换成chr类型，不这样做，FOREACH处就会报-932的错(原因不明)
   DEFINE l_xmdb001       LIKE xmdb_t.xmdb001
   DEFINE l_slip          LIKE oobx_t.oobx001
   DEFINE l_prog          LIKE gzza_t.gzza001 
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_wc4           STRING
   
   #STEP1.获取主次帳套別
   CALL s_axrt300_sel_ld(p_ld) RETURNING l_success,l_s
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = p_ld

   IF l_s = 1 THEN LET l_wc4 = "nmbb006 <> nmbb008" END IF
   IF l_s = 2 THEN LET l_wc4 = "nmbb006 <> nmbb020" END IF
   IF l_s = 3 THEN LET l_wc4 = "nmbb006 <> nmbb023" END IF  

   LET l_sql = "SELECT nmbadocno,to_char(nmbadocdt,'YY-MM-DD'),nmbbseq       ",   #150408-00006(3)--20150408 change nmbadocdt to  to_char(nmbadocdt,'YY-MM-DD')
               "  FROM nmba_t, nmbb_t                                        ",
               #" WHERE (nmbastus = 'A' OR nmbastus = 'Y')                    ",  #161026-00010#2 mark
               " WHERE nmbastus = 'V'                                         ",  #161026-00010#2 add
               "   AND nmbbdocno = nmbadocno                                 ",
               "   AND nmbaent = '",g_enterprise,"'                          ",
               "   AND nmbacomp = '",l_glaacomp,"'",
               #"   AND nmbadocdt <=",g_master.b_date,  #150408-00006(3)--20150408--mark
               "   AND nmbadocdt  BETWEEN '",g_pdate_s,"' AND '",g_master.b_date,"'",   #150408-00006(3)--20150408--add
               "   AND nmbaent = nmbbent                                     ",
               "   AND ",l_wc4             

   PREPARE axrp901_nmba_prep FROM l_sql
   DECLARE axrp901_nmba_curs CURSOR FOR axrp901_nmba_prep
   
   FOREACH axrp901_nmba_curs INTO l_docno,l_dat,l_xmdb001
      CALL s_aooi200_fin_get_slip(l_docno) RETURNING l_success,l_slip
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip

       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "axr-00184"  #已收款項無沖銷對應記錄者  
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       LET g_errparam.replace[1] = ""
       LET g_errparam.coll_vals[1] = p_ld
       LET g_errparam.coll_vals[2] = l_prog 
       LET g_errparam.coll_vals[3] = l_dat
       LET g_errparam.coll_vals[4] = l_docno
       LET g_errparam.coll_vals[5] = l_xmdb001
       LET g_errparam.sqlerr = SQLCA.SQLCODE  
       CALL cl_err()  
              
       LET g_success = 'N'
   END FOREACH   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrp901_get_ld_wc(p_wc)
# Input parameter:  
# Date & Author..: 2014/9/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp901_get_ld_wc(p_wc)
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

 
{</section>}
 
