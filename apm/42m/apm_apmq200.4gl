#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2015-01-19 10:40:15), PR版次:0006(2017-01-13 15:22:46)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: apmq200
#+ Description: 供應商狀況匯總查詢作業
#+ Creator....: 03079(2014-09-09 09:29:22)
#+ Modifier...: 03079 -SD/PR- 01258
 
{</section>}
 
{<section id="apmq200.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160324-00014#1  160429 By Polly 1.帳款明細頁籤資料無顯示2.檢驗明細頁籤，供應商說明未帶出
#160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
#170113-00006#1    17/01/13 By wuxja 供应商资料要抓据点资料
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
PRIVATE TYPE type_g_pmaa_d RECORD
       
       sel LIKE type_t.chr1, 
   pmaa001 LIKE pmaa_t.pmaa001, 
   pmaa001_desc LIKE type_t.chr500, 
   pmaa080 LIKE pmaa_t.pmaa080, 
   pmaa080_desc LIKE type_t.chr500, 
   pmaa047 LIKE pmaa_t.pmaa047, 
   pmaa086 LIKE pmaa_t.pmaa086, 
   pmaa086_desc LIKE type_t.chr500, 
   pmaa005 LIKE pmaa_t.pmaa005, 
   pmaa005_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_pmdl_d  RECORD
                               pmdlstus       LIKE pmdl_t.pmdlstus,     #狀態碼 
                               pmdldocno      LIKE pmdl_t.pmdldocno,    #採購單號  
                               pmdldocdt      LIKE pmdl_t.pmdldocdt,    #採購日期 
                               pmdl002        LIKE pmdl_t.pmdl002,      #採購人員 
                               url_b_pmdl002  STRING,                   # 
                               pmdl002_desc   LIKE type_t.chr500,       # 
                               pmdl003        LIKE pmdl_t.pmdl003,      #採購部門 
                               pmdl003_desc   LIKE pmdl_t.pmdl003,      # 
                               pmdoseq        LIKE pmdo_t.pmdoseq,      #採購項次 
                               pmdoseq1       LIKE pmdo_t.pmdoseq1,     #項序 
                               pmdoseq2       LIKE pmdo_t.pmdoseq2,     #分批序 
                               pmdo003        LIKE pmdo_t.pmdo003,      #子件特性 
                               pmdo001        LIKE pmdo_t.pmdo001,      #料件編號 
                               pmdo001_desc   LIKE type_t.chr500,       #品名 
                               pmdo001_desc_1 LIKE type_t.chr500,       #規格  
                               pmdo002        LIKE pmdo_t.pmdo002,      #產品特徵 
                               pmdo006        LIKE pmdo_t.pmdo006,      #分批採購數量 
                               pmdo004        LIKE pmdo_t.pmdo004,      #採購單位 
                               pmdo004_desc   LIKE type_t.chr500,       # 
                               pmdo013        LIKE pmdo_t.pmdo013,      #到庫日期 
                               pmdo015        LIKE pmdo_t.pmdo015,      #已收貨量 
                               pmdo019        LIKE pmdo_t.pmdo019,      #已入庫量 
                               pmdo040        LIKE pmdo_t.pmdo040,      #倉退量  
                               pmdn050        LIKE pmdn_t.pmdn050       #備註 
                            END RECORD 
 TYPE type_g_pmds_d1 RECORD    #收貨明細   
                               pmdsstus       LIKE pmds_t.pmdsstus,     #狀態碼 
                               pmdsdocno      LIKE pmds_t.pmdsdocno,    #收貨單號 
                               pmdsdocdt      LIKE pmds_t.pmdsdocdt,    #收貨日期 
                               pmds007        LIKE pmds_t.pmds007,      #採購供應商 
                               pmds007_desc   LIKE type_t.chr500,       # 
                               pmds002        LIKE pmds_t.pmds002,      #收貨人員 
                               url_b_pmds002  STRING,                   # 
                               pmds002_desc   LIKE type_t.chr500,       # 
                               pmds003        LIKE pmds_t.pmds003,      #收貨部門 
                               pmds003_desc   LIKE type_t.chr500,       # 
                               pmdtseq        LIKE pmdt_t.pmdtseq,      #項次 
                               pmdt020        LIKE pmdt_t.pmdt020,      #收貨數量 
                               pmdt019        LIKE pmdt_t.pmdt021,      #收貨單位  
                               pmdt019_desc   LIKE type_t.chr500,       # 
                               pmdt053        LIKE pmdt_t.pmdt053,      #允收數量 
                               pmdt054        LIKE pmdt_t.pmdt053,      #已入庫量  
                               pmdt059        LIKE pmdt_t.pmdt059       #備註 
                            END RECORD
 TYPE type_g_qcba_d  RECORD    #檢驗明細 
                               qcbastus       LIKE qcba_t.qcbastus,     #狀態碼 
                               qcbadocno      LIKE qcba_t.qcbadocno,    #檢驗單號 
                               qcbadocdt      LIKE qcba_t.qcbadocdt,    #檢驗日期 
                               qcba024        LIKE qcba_t.qcba024,      #檢驗員 
                               qcba024_desc   LIKE type_t.chr500,       #  
                               ooag003        LIKE ooag_t.ooag003,      #部門  
                               ooag003_desc   LIKE type_t.chr500,       # 
                               qcba005        LIKE qcba_t.qcba005,      #供應商  
                               qcba005_desc   LIKE type_t.chr500,       # 
                               qcba001        LIKE qcba_t.qcba001,      #收貨單號 
                               qcba002        LIKE qcba_t.qcba002,      #收貨項次 
                               qcba017        LIKE qcba_t.qcba017,      #送驗量  
                               qcba022        LIKE qcba_t.qcba022,      #判定結果   
                               qcba023        LIKE qcba_t.qcba023       #合格量  
                            END RECORD
 TYPE type_g_pmds_d2 RECORD    #驗退明細  
                               pmdsstus       LIKE pmds_t.pmdsstus,     #單據狀態 
                               pmdsdocno      LIKE pmds_t.pmdsdocno,    #驗退單號 
                               pmdsdocdt      LIKE pmds_t.pmdsdocdt,    #驗退日期 
                               pmds007        LIKE pmds_t.pmds007,      #供應商 
                               pmds007_desc   LIKE type_t.chr500,       # 
                               pmds002        LIKE pmds_t.pmds002,      #驗退人員 
                               pmds002_desc   LIKE type_t.chr500,       # 
                               pmds003        LIKE pmds_t.pmds003,      #驗退部門 
                               pmds003_desc   LIKE type_t.chr500,       # 
                               pmdt051        LIKE pmdt_t.pmdt051,      #驗退理由 
                               pmdtseq        LIKE pmdt_t.pmdtseq,      #項次 
                               pmdt020        LIKE pmdt_t.pmdt020,      #驗退數量 
                               pmdt019        LIKE pmdt_t.pmdt019,      #單位 
                               pmdt019_desc   LIKE type_t.chr500,       # 
                               pmdt059        LIKE pmdt_t.pmdt059       #備註 
                            END RECORD
 TYPE type_g_pmds_d3 RECORD    #入庫明細  
                               pmdsstus       LIKE pmds_t.pmdsstus,     #單據狀態 
                               pmdsdocno      LIKE pmds_t.pmdsdocno,    #入庫單號 
                               pmdsdocdt      LIKE pmds_t.pmdsdocdt,    #入庫日期 
                               pmds007        LIKE pmds_t.pmds007,      #供應商 
                               pmds007_desc   LIKE type_t.chr500,       # 
                               pmds002        LIKE pmds_t.pmds002,      #入庫人員 
                               pmds002_desc   LIKE type_t.chr500,       # 
                               pmds003        LIKE pmds_t.pmds003,      #入庫部門 
                               pmds003_desc   LIKE type_t.chr500,       # 
                               pmdtseq        LIKE pmdt_t.pmdtseq,      #項次  
                               pmdt020        LIKE pmdt_t.pmdt020,      #入庫數量 
                               pmdt019        LIKE pmdt_t.pmdt019,      #單位 
                               pmdt019_desc   LIKE type_t.chr500,       # 
                               pmdt059        LIKE pmdt_t.pmdt059       #備註 
                            END RECORD
 TYPE type_g_pmds_d4 RECORD    #倉退明細  
                               pmdsstus       LIKE pmds_t.pmdsstus,     #單據狀態 
                               pmdsdocno      LIKE pmds_t.pmdsdocno,    #倉退單號 
                               pmdsdocdt      LIKE pmds_t.pmdsdocdt,    #倉退日期 
                               pmds100        LIKE pmds_t.pmds100,      #倉退方式 
                               pmds007        LIKE pmds_t.pmds007,      #供應商 
                               pmds007_desc   LIKE type_t.chr500,       # 
                               pmds002        LIKE pmds_t.pmds002,      #倉退人員 
                               pmds002_desc   LIKE type_t.chr500,       # 
                               pmds003        LIKE pmds_t.pmds003,      #倉退部門 
                               pmds003_desc   LIKE type_t.chr500,       # 
                               pmdtseq        LIKE pmdt_t.pmdtseq,      #項次 
                               pmdt020        LIKE pmdt_t.pmdt020,      #倉退數量 
                               pmdt019        LIKE pmdt_t.pmdt019,      #單位 
                               pmdt019_desc   LIKE type_t.chr500,       # 
                               pmdt059        LIKE pmdt_t.pmdt059       #備註 
                            END RECORD
 TYPE type_g_apca_d  RECORD    #帳款明細  
                               apcastus       LIKE apca_t.apcastus,     #單據狀態 
                               apcadocno      LIKE apca_t.apcadocno,    #帳款單號 
                               apcadocdt      LIKE apca_t.apcadocdt,    #帳款日期 
                               apca005        LIKE apca_t.apca005,      #付款供應商 
                               apca005_desc   LIKE type_t.chr500,       # 
                               apca014        LIKE apca_t.apca014,      #請款人員 
                               apca014_desc   LIKE type_t.chr500,       # 
                               apca015        LIKE apca_t.apca015,      #請款部門  
                               apca015_desc   LIKE type_t.chr500,       # 
                               apcbseq        LIKE apcb_t.apcbseq,      #項次 
                               apcb007        LIKE apcb_t.apcb007,      #請款數量 
                               apcb006        LIKE apcb_t.apcb006,      #單位 
                               apcb006_desc   LIKE type_t.chr500        # 
                            END RECORD 
DEFINE g_pmdl_d             DYNAMIC ARRAY OF type_g_pmdl_d
DEFINE g_pmdl_d_t           type_g_pmdl_d
DEFINE g_pmds_d1            DYNAMIC ARRAY OF type_g_pmds_d1
DEFINE g_pmds_d1_t          type_g_pmds_d1
DEFINE g_qcba_d             DYNAMIC ARRAY OF type_g_qcba_d
DEFINE g_qcba_d_t           type_g_qcba_d
DEFINE g_pmds_d2            DYNAMIC ARRAY OF type_g_pmds_d2
DEFINE g_pmds_d2_t          type_g_pmds_d2
DEFINE g_pmds_d3            DYNAMIC ARRAY OF type_g_pmds_d3
DEFINE g_pmds_d3_t          type_g_pmds_d3
DEFINE g_pmds_d4            DYNAMIC ARRAY OF type_g_pmds_d4
DEFINE g_pmds_d4_t          type_g_pmds_d4
DEFINE g_apca_d             DYNAMIC ARRAY OF type_g_apca_d
DEFINE g_apca_d_t           type_g_apca_d
DEFINE g_detail_cnt2        LIKE type_t.num5
DEFINE g_detail_cnt3        LIKE type_t.num5
DEFINE g_detail_cnt4        LIKE type_t.num5
DEFINE g_detail_cnt5        LIKE type_t.num5
DEFINE g_detail_cnt6        LIKE type_t.num5
DEFINE g_detail_cnt7        LIKE type_t.num5
DEFINE g_detail_cnt8        LIKE type_t.num5 

 TYPE type_tm        RECORD
                               radio     LIKE type_t.chr1, 
                               bdate     LIKE pmdl_t.pmdldocdt,
                               edate     LIKE pmdl_t.pmdldocdt 
                            END RECORD
DEFINE tm                   type_tm 

#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmaa_d            DYNAMIC ARRAY OF type_g_pmaa_d
DEFINE g_pmaa_d_t          type_g_pmaa_d
 
 
 
 
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
 
{<section id="apmq200.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   CALL apmq200_create_temp()
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
   DECLARE apmq200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq200_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq200_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq200 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq200_init()   
 
      #進入選單 Menu (="N")
      CALL apmq200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq200
      
   END IF 
   
   CLOSE apmq200_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL apmq200_drop_temp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq200_init()
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
   CALL cl_set_combo_scc_part('b_pmdlstus','13','N,X,Y,H,C,A,D,R,W')
   CALL cl_set_combo_scc_part('b_pmdsstus','13','N,X,Y,S')
   CALL cl_set_combo_scc_part('b_qcbastus','13','N,Y,X')
   CALL cl_set_combo_scc_part('b_apcastus','13','N,Y,X,A,D,R,W')

   CALL cl_set_combo_scc('b_pmdo003','2055')
   CALL cl_set_combo_scc('b_qcba022','5072')

   CALL cl_set_combo_scc_part('b_pmdsstus_1','13','N,X,Y,S')
   CALL cl_set_combo_scc_part('b_pmdsstus_2','13','N,X,Y,S')
   CALL cl_set_combo_scc_part('b_pmdsstus_3','13','N,X,Y,S') 
   
   CALL cl_set_combo_scc('b_pmds100','2062') 
   
   LET tm.radio = '1'
   LET tm.bdate = ''
   LET tm.edate = ''

   CALL apmq200_set_entry()
   CALL apmq200_set_no_entry()
   #end add-point
 
   CALL apmq200_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq200.default_search" >}
PRIVATE FUNCTION apmq200_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmaa001 = '", g_argv[01], "' AND "
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
 
{<section id="apmq200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq200_ui_dialog() 
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
   
   #end add-point
 
   
   CALL apmq200_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmaa_d.clear()
 
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
 
         CALL apmq200_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         CONSTRUCT BY NAME g_wc ON pmaa001,pmaa086,pmaa080,pmaa005,pmaa047
            ON ACTION controlp INFIELD pmaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
               LET g_qryparam.where = g_qryparam.where," AND pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabsite = '",g_site,"' AND pmabent = '",g_enterprise,"' AND 1=1) "  #170113-00006#1 add
               CALL q_pmaa001_5()
               DISPLAY g_qryparam.return1 TO pmaa001
               NEXT FIELD CURRENT

            ON ACTION controlp INFIELD pmaa086
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               CALL q_ooag001_2()
               DISPLAY g_qryparam.return1 TO pmaa086
               NEXT FIELD CURRENT

            ON ACTION controlp INFIELD pmaa080
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE

               LET g_qryparam.arg1 = "251"
               CALL q_oocq002()                           #呼叫開窗 
               DISPLAY g_qryparam.return1 TO pmaa080
               NEXT FIELD CURRENT

            ON ACTION controlp INFIELD pmaa005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE

               LET g_qryparam.WHERE = " pmaa004 = '1' "
               CALL q_pmaa001_4()                           #呼叫開窗 
               DISPLAY g_qryparam.return1 TO pmaa005
               NEXT FIELD CURRENT

         END CONSTRUCT

         INPUT BY NAME tm.radio,tm.bdate,tm.edate ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT 
               CALL apmq200_set_entry()
               CALL apmq200_set_no_entry()

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF 
            
            ON CHANGE radio
               CALL apmq200_set_entry()
               CALL apmq200_set_no_entry()

               IF tm.radio != '6' THEN
                  LET tm.bdate = ''
                  LET tm.edate = ''

                  DISPLAY BY NAME tm.bdate,tm.edate
               END IF

            AFTER FIELD bdate
               IF NOT cl_null(tm.bdate) AND NOT cl_null(tm.edate) THEN
                  IF tm.bdate > tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'acr-00068'     #起始日期不能大於截止日期！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err() 
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF

            AFTER FIELD edate
               IF NOT cl_null(tm.bdate) AND NOT cl_null(tm.edate) THEN
                  IF tm.bdate > tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'acr-00068'     #起始日期不能大於截止日期！  
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               END IF
         END INPUT 
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_pmaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq200_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq200_b_fill2()
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
         DISPLAY ARRAY g_pmdl_d TO s_detail2.* ATTRIBUTE(COUNT = g_detail_cnt2)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
         END DISPLAY
         DISPLAY ARRAY g_pmds_d1 TO s_detail3.* ATTRIBUTE(COUNT = g_detail_cnt3)
            BEFORE DISPLAY
               LET g_current_page = 3
            BEFORE ROW
         END DISPLAY
         DISPLAY ARRAY g_qcba_d TO s_detail4.* ATTRIBUTE(COUNT = g_detail_cnt4)
            BEFORE DISPLAY
               LET g_current_page = 4
            BEFORE ROW
         END DISPLAY
         DISPLAY ARRAY g_pmds_d2 TO s_detail5.* ATTRIBUTE(COUNT = g_detail_cnt5)
            BEFORE DISPLAY
               LET g_current_page = 5
            BEFORE ROW
         END DISPLAY
         DISPLAY ARRAY g_pmds_d3 TO s_detail6.* ATTRIBUTE(COUNT = g_detail_cnt6)
            BEFORE DISPLAY
               LET g_current_page = 6
            BEFORE ROW
         END DISPLAY 
         DISPLAY ARRAY g_pmds_d4 TO s_detail7.* ATTRIBUTE(COUNT = g_detail_cnt7)
            BEFORE DISPLAY
               LET g_current_page = 7
            BEFORE ROW
         END DISPLAY
         DISPLAY ARRAY g_apca_d TO s_detail8.* ATTRIBUTE(COUNT = g_detail_cnt8)
            BEFORE DISPLAY
               LET g_current_page = 8
            BEFORE ROW
         END DISPLAY 
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apmq200_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD pmaa001
 
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
            CALL apmq200_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmaa_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_pmdl_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_pmds_d1)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_qcba_d)
               LET g_export_id[4]   = "s_detail4"
               LET g_export_node[5] = base.typeInfo.create(g_pmds_d2)
               LET g_export_id[5]   = "s_detail5"
               LET g_export_node[6] = base.typeInfo.create(g_pmds_d3)
               LET g_export_id[6]   = "s_detail6"
               LET g_export_node[7] = base.typeInfo.create(g_pmds_d4)
               LET g_export_id[7]   = "s_detail7"
               LET g_export_node[8] = base.typeInfo.create(g_apca_d)
               LET g_export_id[8]   = "s_detail8"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq200_b_fill()
 
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
            CALL apmq200_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq200_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq200_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq200_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               LET g_pmaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               LET g_pmaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
 
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq200_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
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
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="apmq200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq200_b_fill()
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
 
   CALL g_pmaa_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',pmaa001,'',pmaa080,'',pmaa047,pmaa086,'',pmaa005,''  ,DENSE_RANK() OVER( ORDER BY pmaa_t.pmaa001) AS RANK FROM pmaa_t", 
 
 
 
                     "",
                     " WHERE pmaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmaa_t"),
                     " ORDER BY pmaa_t.pmaa001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #170113-00006#1  add   --begin--
   LET ls_sql_rank = ls_sql_rank, "AND pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabsite = '",g_site,"' AND pmabent = '",g_enterprise,"' AND 1=1) ",cl_sql_add_filter("pmaa_t"),
                     " ORDER BY pmaa_t.pmaa001"
   #170113-00006#1  add   --end--
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
 
   LET g_sql = "SELECT '',pmaa001,'',pmaa080,'',pmaa047,pmaa086,'',pmaa005,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT UNIQUE 'N',pmaa001,'',pmaa080,'',pmaa047,pmaa086,'',pmaa005,'' ",
               "  FROM pmaa_t ",
               " WHERE pmaaent = ? ", 
               "   AND pmaa002 IN ('1','3') ",       #交易對象類型='1'(供應商),'3'(交易對象：供應商+客戶)的資料才抓
               "   AND ",ls_wc
               
   LET g_sql = g_sql," AND pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabsite = '",g_site,"' AND pmabent = '",g_enterprise,"' AND 1=1) " #170113-00006#1 add

   LET g_sql = g_sql, cl_sql_add_filter("pmaa_t"),
                      " ORDER BY pmaa_t.pmaa001"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq200_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq200_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmaa_d[l_ac].sel,g_pmaa_d[l_ac].pmaa001,g_pmaa_d[l_ac].pmaa001_desc,g_pmaa_d[l_ac].pmaa080, 
       g_pmaa_d[l_ac].pmaa080_desc,g_pmaa_d[l_ac].pmaa047,g_pmaa_d[l_ac].pmaa086,g_pmaa_d[l_ac].pmaa086_desc, 
       g_pmaa_d[l_ac].pmaa005,g_pmaa_d[l_ac].pmaa005_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL apmq200_detail_show("'1'")
 
      CALL apmq200_pmaa_t_mask()
 
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
 
   CALL g_pmaa_d.deleteElement(g_pmaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apmq200_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq200_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq200_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmaa_d.getLength() > 0 THEN
      CALL apmq200_b_fill2()
   END IF
 
      CALL apmq200_filter_show('pmaa001','b_pmaa001')
   CALL apmq200_filter_show('pmaa080','b_pmaa080')
   CALL apmq200_filter_show('pmaa047','b_pmaa047')
   CALL apmq200_filter_show('pmaa086','b_pmaa086')
   CALL apmq200_filter_show('pmaa005','b_pmaa005')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq200_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_date          LIKE pmdl_t.pmdldocdt
   DEFINE l_wc            STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_pmdl_d.clear()
   CALL g_pmds_d1.clear()
   CALL g_qcba_d.clear()
   CALL g_pmds_d2.clear()
   CALL g_pmds_d3.clear()
   CALL g_pmds_d4.clear()
   CALL g_apca_d.clear()  
   
   DELETE FROM apmq200_tmp01  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   #設定日期區間 
   LET l_date = ''
   CASE tm.radio
      WHEN '1'             #最近一周  
         SELECT ADD_MONTHS(g_today,0)-7 INTO l_date FROM DUAL
         LET l_wc = " '",l_date,"' AND '",g_today,"' "
      WHEN '2'             #最近一個月  
         SELECT ADD_MONTHS(g_today,-1) INTO l_date FROM DUAL
         LET l_wc = " '",l_date,"' AND '",g_today,"' "
      WHEN '3'             #最近三個月  
         SELECT ADD_MONTHS(g_today,-3) INTO l_date FROM DUAL
         LET l_wc = " '",l_date,"' AND '",g_today,"' "
      WHEN '4'             #最近六個月  
         SELECT ADD_MONTHS(g_today,-6) INTO l_date FROM DUAL
         LET l_wc = " '",l_date,"' AND '",g_today,"' "
      WHEN '5'             #最近一年  
         SELECT ADD_MONTHS(g_today,-12) INTO l_date FROM DUAL
         LET l_wc = " '",l_date,"' AND '",g_today,"' "
      WHEN '6'             #自訂起迄  
         LET l_wc = " '",tm.bdate,"' AND '",tm.edate,"' "
   END CASE
   
   #採購明細 
   LET g_sql = "SELECT UNIQUE pmdlstus,pmdldocno,pmdldocdt,pmdl002,'', ",
               "              pmdl003,'',pmdoseq,pmdoseq1,pmdoseq2,pmdo003, ",
               "              pmdo001,'','',pmdo001,pmdo006,pmdo004,'',pmdo013, ",
               "              pmdo015,pmdo019,pmdo040,'' ",
               "  FROM pmdl_t,pmdo_t ",
               " WHERE pmdlent   = pmdoent ",
               "   AND pmdlsite  = pmdosite ",
               "   AND pmdldocno = pmdodocno ",
               "   AND pmdlent   = ? ",
               "   AND pmdlsite  = '",g_site,"' ",
               "   AND pmdl004   = ? ", 
               #"   AND pmdlstus  = 'Y' ",
               "   AND pmdldocdt BETWEEN ",l_wc,
               " ORDER BY pmdldocno,pmdoseq,pmdoseq1,pmdoseq2 "

   LET g_sql = cl_sql_add_mask(g_sql)     #遮蔽特定資料 

   PREPARE apmq200_prep2 FROM g_sql
   DECLARE apmq200_curs2 CURSOR FOR apmq200_prep2

   OPEN apmq200_curs2 USING g_enterprise,g_pmaa_d[g_detail_idx].pmaa001

   #採購明細 
   LET l_ac = 1
   FOREACH apmq200_curs2 INTO g_pmdl_d[l_ac].pmdlstus      ,g_pmdl_d[l_ac].pmdldocno,
                              g_pmdl_d[l_ac].pmdldocdt     ,g_pmdl_d[l_ac].pmdl002,
                              g_pmdl_d[l_ac].pmdl002_desc  ,g_pmdl_d[l_ac].pmdl003,
                              g_pmdl_d[l_ac].pmdl003_desc  ,g_pmdl_d[l_ac].pmdoseq,
                              g_pmdl_d[l_ac].pmdoseq1      ,g_pmdl_d[l_ac].pmdoseq2,
                              g_pmdl_d[l_ac].pmdo003       ,g_pmdl_d[l_ac].pmdo001,
                              g_pmdl_d[l_ac].pmdo001_desc  ,g_pmdl_d[l_ac].pmdo001_desc_1,
                              g_pmdl_d[l_ac].pmdo002       ,g_pmdl_d[l_ac].pmdo006, 
                              g_pmdl_d[l_ac].pmdo004       ,g_pmdl_d[l_ac].pmdo004_desc,
                              g_pmdl_d[l_ac].pmdo013       ,g_pmdl_d[l_ac].pmdo015,
                              g_pmdl_d[l_ac].pmdo019       ,g_pmdl_d[l_ac].pmdo040, 
                              g_pmdl_d[l_ac].pmdn050 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
      #取得採購明細的備註 
      SELECT pmdn050 INTO g_pmdl_d[l_ac].pmdn050
        FROM pmdn_t
       WHERE pmdnent   = g_enterprise
         AND pmdndocno = g_pmdl_d[l_ac].pmdldocno
         AND pmdnseq   = g_pmdl_d[l_ac].pmdoseq

      CALL apmq200_detail_show("'2'")

      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH 
   
   #收貨明細 
   LET g_sql = "SELECT pmdsstus,pmdsdocno,pmdsdocdt,pmds007,'',pmds002,'', ",
               "       pmds003,'',pmdtseq,pmdt002,pmdt019,'',pmdt053,pmdt054,pmdt059 ", 
               "  FROM pmds_t,pmdt_t ",
               " WHERE pmdsent   = pmdtent ",
               "   AND pmdssite  = pmdtsite ",
               "   AND pmds000   = '1' ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmdsent   = ? ",
               "   AND pmdssite  = '",g_site,"' ",
               "   AND pmds007   = ? ", 
               #"   AND pmdsstus  = 'Y' ",
               "   AND pmdsdocdt BETWEEN ",l_wc,
               " ORDER BY pmdsdocno,pmds007 "

   LET g_sql = cl_sql_add_mask(g_sql)     #遮蔽特定資料 

   PREPARE apmq200_prep3 FROM g_sql
   DECLARE apmq200_curs3 CURSOR FOR apmq200_prep3

   OPEN apmq200_curs3 USING g_enterprise,g_pmaa_d[g_detail_idx].pmaa001

   #收貨明細 
   DELETE FROM apmq200_tmp01  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
   LET l_ac = 1
   FOREACH apmq200_curs3 INTO g_pmds_d1[l_ac].pmdsstus    ,g_pmds_d1[l_ac].pmdsdocno,
                              g_pmds_d1[l_ac].pmdsdocdt   ,g_pmds_d1[l_ac].pmds007,
                              g_pmds_d1[l_ac].pmds007_desc,g_pmds_d1[l_ac].pmds002,
                              g_pmds_d1[l_ac].pmds002_desc,g_pmds_d1[l_ac].pmds003,
                              g_pmds_d1[l_ac].pmds003_desc,g_pmds_d1[l_ac].pmdtseq,
                              g_pmds_d1[l_ac].pmdt020     ,g_pmds_d1[l_ac].pmdt019,
                              g_pmds_d1[l_ac].pmdt019_desc,g_pmds_d1[l_ac].pmdt053, 
                              g_pmds_d1[l_ac].pmdt054     ,g_pmds_d1[l_ac].pmdt059 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      INSERT INTO apmq200_tmp01(pmdsdocno,pmdtseq,pmds000)  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
                  VALUES(g_pmds_d1[l_ac].pmdsdocno,g_pmds_d1[l_ac].pmdtseq,'1')
                  
      CALL apmq200_detail_show("'3'")

      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH 
                 
   #檢驗明細
  #--160324-00014#1--mark--(S)   
  #LET g_sql = "SELECT qcbastus,qcbadocno,qcbadocdt,qcba024,'','','', ",
  #            "       qcba005,'',qcba001,qcba002,qcba017,qcba022,qcba023 ",
  #--160324-00014#1--mark--(E)              
   LET g_sql = "SELECT qcbastus,qcbadocno,qcbadocdt,qcba024,'', ",      #160324-00014#1 add
               "       qcba005,'','','',qcba001,qcba002,qcba017,qcba022,qcba023 ",  #160324-00014#1 add             
               "  FROM qcba_t,apmq200_tmp01 ",  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
               " WHERE qcbaent  = ? ",
               "   AND qcbasite = '",g_site,"' ",
               "   AND qcba001  = pmdsdocno ",
               "   AND qcba002  = pmdtseq",
               #"   AND qcbastus = 'Y' ",
               "   AND qcbadocdt BETWEEN ",l_wc,
               " ORDER BY qcbadocno "

   LET g_sql = cl_sql_add_mask(g_sql)     #遮蔽特定資料 

   PREPARE apmq200_prep4 FROM g_sql
   DECLARE apmq200_curs4 CURSOR FOR apmq200_prep4

   OPEN apmq200_curs4 USING g_enterprise

   #檢驗明細 
   LET l_ac = 1
   FOREACH apmq200_curs4 INTO g_qcba_d[l_ac].qcbastus    ,g_qcba_d[l_ac].qcbadocno,
                              g_qcba_d[l_ac].qcbadocdt   ,g_qcba_d[l_ac].qcba024,
                              g_qcba_d[l_ac].qcba024_desc,g_qcba_d[l_ac].qcba005,
                              g_qcba_d[l_ac].qcba005_desc,g_qcba_d[l_ac].ooag003,
                              g_qcba_d[l_ac].ooag003_desc,g_qcba_d[l_ac].qcba001,
                              g_qcba_d[l_ac].qcba002     ,g_qcba_d[l_ac].qcba017,
                              g_qcba_d[l_ac].qcba022     ,g_qcba_d[l_ac].qcba023
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      SELECT ooag003 INTO g_qcba_d[l_ac].ooag003
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_qcba_d[l_ac].qcba024

      CALL apmq200_detail_show("'4'")

      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH

   #驗退明細 
   LET g_sql = "SELECT pmdsstus,pmdsdocno,pmdsdocdt,pmds007,'', ",
               "       pmds002,'',pmds003,'',pmdt051,pmdtseq,pmdt020,pmdt019,pmdt059 ",
               "  FROM pmds_t,pmdt_t ",
               " WHERE pmdsent   = pmdtent ",
               "   AND pmdssite  = pmdtsite ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmds000   = '5' ",
               "   AND pmdsent   = ? ", 
               "   AND pmdssite  = '",g_site,"' ",
               "   AND pmds007   = ? ", 
               #"   AND pmdsstus  = 'Y' ",
               "   AND pmdsdocdt BETWEEN ",l_wc,
               " ORDER BY pmdsdocno,pmdtseq "

   LET g_sql = cl_sql_add_mask(g_sql)     #遮蔽特定資料 

   PREPARE apmq200_prep5 FROM g_sql
   DECLARE apmq200_curs5 CURSOR FOR apmq200_prep5

   OPEN apmq200_curs5 USING g_enterprise,g_pmaa_d[g_detail_idx].pmaa001

   #驗退明細 
   LET l_ac = 1
   FOREACH apmq200_curs5 INTO g_pmds_d2[l_ac].pmdsstus    ,g_pmds_d2[l_ac].pmdsdocno,
                              g_pmds_d2[l_ac].pmdsdocdt   ,g_pmds_d2[l_ac].pmds007,
                              g_pmds_d2[l_ac].pmds007_desc,g_pmds_d2[l_ac].pmds002,
                              g_pmds_d2[l_ac].pmds002_desc,g_pmds_d2[l_ac].pmds003,
                              g_pmds_d2[l_ac].pmds003_desc,g_pmds_d2[l_ac].pmdt051,
                              g_pmds_d2[l_ac].pmdtseq     ,g_pmds_d2[l_ac].pmdt020,
                              g_pmds_d2[l_ac].pmdt019     ,g_pmds_d2[l_ac].pmdt059 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err() 
         
         EXIT FOREACH
      END IF

      CALL apmq200_detail_show("'5'")

      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH

   #入庫明細
   LET g_sql = "SELECT pmdsstus,pmdsdocno,pmdsdocdt,pmds007,'', ",
               "       pmds002,'',pmds003,'',pmdtseq,pmdt020,pmdt019,pmdt059 ",
               "  FROM pmds_t,pmdt_t ",
               " WHERE pmdsent   = pmdtent ",
               "   AND pmdssite  = pmdtsite ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmds000   = '6' ",
               "   AND pmdsent   = ? ",
               "   AND pmdssite  = '",g_site,"' ",
               "   AND pmds007   = ? ",  
               #"   AND pmdsstus  = 'Y' ",
               "   AND pmdsdocdt BETWEEN ",l_wc,
               " ORDER BY pmdsdocno,pmdtseq "

   LET g_sql = cl_sql_add_mask(g_sql)     #遮蔽特定資料 

   PREPARE apmq200_prep6 FROM g_sql
   DECLARE apmq200_curs6 CURSOR FOR apmq200_prep6

   OPEN apmq200_curs6 USING g_enterprise,g_pmaa_d[g_detail_idx].pmaa001

   #入庫明細 
   DELETE FROM apmq200_tmp01  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
   LET l_ac = 1
   FOREACH apmq200_curs6 INTO g_pmds_d3[l_ac].pmdsstus    ,g_pmds_d3[l_ac].pmdsdocno,
                              g_pmds_d3[l_ac].pmdsdocdt   ,g_pmds_d3[l_ac].pmds007,
                              g_pmds_d3[l_ac].pmds007_desc,g_pmds_d3[l_ac].pmds002,
                              g_pmds_d3[l_ac].pmds002_desc,g_pmds_d3[l_ac].pmds003,
                              g_pmds_d3[l_ac].pmds003_desc,g_pmds_d3[l_ac].pmdtseq,
                              g_pmds_d3[l_ac].pmdt020     ,g_pmds_d3[l_ac].pmdt019, 
                              g_pmds_d3[l_ac].pmdt059 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     #--160324-00014#1--mark--(S) 
     #INSERT INTO apmq200_pmds_tmp(pmdsdocno,pmdtseq,pmds000)
     #            VALUES(g_pmds_d[l_ac].pmdsdocno,g_pmds_d[l_ac].pmdtseq,'6')
     #--160324-00014#1--mark--(E) 
     #--160324-00014#1--add--(S)      
      INSERT INTO apmq200_tmp01(pmdsdocno,pmdtseq,pmds000)  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
                  VALUES(g_pmds_d3[l_ac].pmdsdocno,g_pmds_d3[l_ac].pmdtseq,'6')
     #--160324-00014#1--add--(E)      
      CALL apmq200_detail_show("'6'") 
      
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH

   #倉退明細
   LET g_sql = "SELECT pmdsstus,pmdsdocno,pmdsdocdt,pmds100,pmds007,'', ",
               "       pmds002,'',pmds003,'',pmdtseq,pmdt020,pmdt019,pmdt059 ",
               "  FROM pmds_t,pmdt_t ",
               " WHERE pmdsent   = pmdtent ",
               "   AND pmdssite  = pmdtsite ",
               "   AND pmdsdocno = pmdtdocno ",
               "   AND pmds000   = '7' ",
               "   AND pmdsent   = ? ",
               "   AND pmdssite  = '",g_site,"' ",
               "   AND pmds007   = ? ", 
               #"   AND pmdsstus  = 'Y' ",
               "   AND pmdsdocdt BETWEEN ",l_wc,
               " ORDER BY pmdsdocno,pmdtseq "

   LET g_sql = cl_sql_add_mask(g_sql)     #遮蔽特定資料  
   
   PREPARE apmq200_prep7 FROM g_sql
   DECLARE apmq200_curs7 CURSOR FOR apmq200_prep7

   OPEN apmq200_curs7 USING g_enterprise,g_pmaa_d[g_detail_idx].pmaa001

   #倉退明細
   LET l_ac = 1
   FOREACH apmq200_curs7 INTO g_pmds_d4[l_ac].pmdsstus,g_pmds_d4[l_ac].pmdsdocno,
                              g_pmds_d4[l_ac].pmdsdocdt,g_pmds_d4[l_ac].pmds100,
                              g_pmds_d4[l_ac].pmds007  ,g_pmds_d4[l_ac].pmds007_desc,
                              g_pmds_d4[l_ac].pmds002  ,g_pmds_d4[l_ac].pmds002_desc,
                              g_pmds_d4[l_ac].pmds003  ,g_pmds_d4[l_ac].pmds003_desc,
                              g_pmds_d4[l_ac].pmdtseq  ,g_pmds_d4[l_ac].pmdt020,
                              g_pmds_d4[l_ac].pmdt019  ,g_pmds_d4[l_ac].pmdt059
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     #--160324-00014#1--mark--(S)      
     #INSERT INTO apmq200_pmds_tmp(pmdsdocno,pmdtseq,pmds000)
     #            VALUES(g_pmds_d[l_ac].pmdsdocno,g_pmds_d[l_ac].pmdtseq,'7')
     #--160324-00014#1--mark--(E)                  
     #--160324-00014#1--add--(S) 
      INSERT INTO apmq200_tmp01(pmdsdocno,pmdtseq,pmds000)  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
                  VALUES(g_pmds_d4[l_ac].pmdsdocno,g_pmds_d4[l_ac].pmdtseq,'7')                  
     #--160324-00014#1--add--(E)
      CALL apmq200_detail_show("'7'")
      
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1   #160324-00014#1 add
   END FOREACH

   #ming apca_t 與 apcb_t可能會有帳別的問題 
   #帳款明細 
   LET g_sql = "SELECT apcastus,apcadocno,apcadocdt,apca005,'', ",
               "       apca014,'',apca015,'',apcbseq,apcb007,apcb006 ",
               "  FROM apca_t,apcb_t,apmq200_tmp01 ",  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
               " WHERE apcaent   = apcbent ",
               "   AND apcald    = apcbld ",
               "   AND apcasite  = apcbsite ",
               "   AND apcadocno = apcbdocno ",
               "   AND apcaent   = ? ",
               "   AND apcasite  = '",g_site,"' ",
               "   AND apcb002   = pmdsdocno ",
               "   AND apcb003   = pmdtseq ", 
               #"   AND apcastus  = 'Y' ",
               "   AND apcadocdt BETWEEN ",l_wc,
               " ORDER BY apcadocno,apcbseq "

   LET g_sql = cl_sql_add_mask(g_sql)     #遮蔽特定資料 

   PREPARE apmq200_prep8 FROM g_sql
   DECLARE apmq200_curs8 CURSOR FOR apmq200_prep8 
   
   OPEN apmq200_curs8 USING g_enterprise

   #帳款明細 
   LET l_ac = 1
   FOREACH apmq200_curs8 INTO g_apca_d[l_ac].apcastus    ,g_apca_d[l_ac].apcadocno,
                              g_apca_d[l_ac].apcadocdt   ,g_apca_d[l_ac].apca005,
                              g_apca_d[l_ac].apca005_desc,g_apca_d[l_ac].apca014,
                              g_apca_d[l_ac].apca014_desc,g_apca_d[l_ac].apca015,
                              g_apca_d[l_ac].apca015_desc,g_apca_d[l_ac].apcbseq,
                              g_apca_d[l_ac].apcb007     ,g_apca_d[l_ac].apcb006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      CALL apmq200_detail_show("'8'")

      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      
   END FOREACH

   CALL g_pmdl_d.deleteElement(g_pmdl_d.getLength())
   CALL g_pmds_d1.deleteElement(g_pmds_d1.getLength())
   CALL g_qcba_d.deleteElement(g_qcba_d.getLength())
   CALL g_pmds_d2.deleteElement(g_pmds_d2.getLength())
   CALL g_pmds_d3.deleteElement(g_pmds_d3.getLength())
   CALL g_pmds_d4.deleteElement(g_pmds_d4.getLength())
   CALL g_apca_d.deleteElement(g_apca_d.getLength())
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apmq200.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq200_detail_show(ps_page)
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
      CALL s_desc_get_trading_partner_abbr_desc(g_pmaa_d[l_ac].pmaa001)
           RETURNING g_pmaa_d[l_ac].pmaa001_desc

      CALL s_desc_get_acc_desc('251',g_pmaa_d[l_ac].pmaa080)
           RETURNING g_pmaa_d[l_ac].pmaa080_desc 
           
      CALL s_desc_get_person_desc(g_pmaa_d[l_ac].pmaa086)
           RETURNING g_pmaa_d[l_ac].pmaa086_desc

      CALL s_desc_get_trading_partner_abbr_desc(g_pmaa_d[l_ac].pmaa005)
           RETURNING g_pmaa_d[l_ac].pmaa005_desc
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #取人員姓名 
      CALL s_desc_get_person_desc(g_pmdl_d[l_ac].pmdl002)
           RETURNING g_pmdl_d[l_ac].pmdl002_desc

      #取部門說明 
      CALL s_desc_get_department_desc(g_pmdl_d[l_ac].pmdl003)
           RETURNING g_pmdl_d[l_ac].pmdl003_desc

      #取料號的品名 規格 
      CALL s_desc_get_item_desc(g_pmdl_d[l_ac].pmdo001)
           RETURNING g_pmdl_d[l_ac].pmdo001_desc,
                     g_pmdl_d[l_ac].pmdo001_desc_1

      #取單位說明 
      CALL s_desc_get_unit_desc(g_pmdl_d[l_ac].pmdo004)
           RETURNING g_pmdl_d[l_ac].pmdo004_desc
   END IF 
   
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #取人員姓名 
      CALL s_desc_get_person_desc(g_pmds_d1[l_ac].pmds002)
           RETURNING g_pmds_d1[l_ac].pmds002_desc

      #取部門說明 
      CALL s_desc_get_department_desc(g_pmds_d1[l_ac].pmds003)
           RETURNING g_pmds_d1[l_ac].pmds003_desc

      #取單位說明 
      CALL s_desc_get_unit_desc(g_pmds_d1[l_ac].pmdt019)
           RETURNING g_pmds_d1[l_ac].pmdt019_desc

      #取供應商名稱 
      CALL s_desc_get_trading_partner_abbr_desc(g_pmds_d1[l_ac].pmds007)
           RETURNING g_pmds_d1[l_ac].pmds007_desc
   END IF 
   
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #取人員姓名 
      CALL s_desc_get_person_desc(g_qcba_d[l_ac].qcba024)
           RETURNING g_qcba_d[l_ac].qcba024_desc

      #取供應商名稱 
      CALL s_desc_get_trading_partner_abbr_desc(g_qcba_d[l_ac].qcba005)
           RETURNING g_qcba_d[l_ac].qcba005_desc 
           
      CALL s_desc_get_department_desc(g_qcba_d[l_ac].ooag003)
           RETURNING g_qcba_d[l_ac].ooag003_desc
   END IF

   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #取人員姓名 
      CALL s_desc_get_person_desc(g_pmds_d2[l_ac].pmds002)
           RETURNING g_pmds_d2[l_ac].pmds002_desc

      #取部門說明 
      CALL s_desc_get_department_desc(g_pmds_d2[l_ac].pmds003)
           RETURNING g_pmds_d2[l_ac].pmds003_desc

      #取單位說明 
      CALL s_desc_get_unit_desc(g_pmds_d2[l_ac].pmdt019) 
           RETURNING g_pmds_d2[l_ac].pmdt019_desc 

      #取供應商名稱 
      CALL s_desc_get_trading_partner_abbr_desc(g_pmds_d2[l_ac].pmds007)
           RETURNING g_pmds_d2[l_ac].pmds007_desc
   END IF 
   
   IF ps_page.getIndexOf("'6'",1) > 0 THEN
      #取人員姓名 
      CALL s_desc_get_person_desc(g_pmds_d3[l_ac].pmds002)
           RETURNING g_pmds_d3[l_ac].pmds002_desc

      #取部門說明 
      CALL s_desc_get_department_desc(g_pmds_d3[l_ac].pmds003)
           RETURNING g_pmds_d3[l_ac].pmds003_desc

      #取單位說明 
      CALL s_desc_get_unit_desc(g_pmds_d3[l_ac].pmdt019) 
           RETURNING g_pmds_d3[l_ac].pmdt019_desc  

      #取供應商名稱 
      CALL s_desc_get_trading_partner_abbr_desc(g_pmds_d3[l_ac].pmds007)
           RETURNING g_pmds_d3[l_ac].pmds007_desc
   END IF 
   
   IF ps_page.getIndexOf("'7'",1) > 0 THEN
      #取人員姓名 
      CALL s_desc_get_person_desc(g_pmds_d4[l_ac].pmds002)
           RETURNING g_pmds_d4[l_ac].pmds002_desc

      #取部門說明 
      CALL s_desc_get_department_desc(g_pmds_d4[l_ac].pmds003)
           RETURNING g_pmds_d4[l_ac].pmds003_desc

      #取單位說明 
      CALL s_desc_get_unit_desc(g_pmds_d4[l_ac].pmdt019) 
           RETURNING g_pmds_d4[l_ac].pmdt019_desc 

      #取供應商名稱  
      CALL s_desc_get_trading_partner_abbr_desc(g_pmds_d4[l_ac].pmds007)
           RETURNING g_pmds_d4[l_ac].pmds007_desc
   END IF 
   
   IF ps_page.getIndexOf("'8'",1) > 0 THEN
      #取人員姓名 
      CALL s_desc_get_person_desc(g_apca_d[l_ac].apca014)
           RETURNING g_apca_d[l_ac].apca014_desc

      #取部門說明 
      CALL s_desc_get_department_desc(g_apca_d[l_ac].apca015)
           RETURNING g_apca_d[l_ac].apca015_desc

      #取單位說明 
      CALL s_desc_get_unit_desc(g_apca_d[l_ac].apcb006) 
           RETURNING g_apca_d[l_ac].apcb006_desc 

      #取供應商名稱 
      CALL s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca005)
           RETURNING g_apca_d[l_ac].apca005_desc
   END IF 
   
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq200.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq200_filter()
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
      CONSTRUCT g_wc_filter ON pmaa001,pmaa080,pmaa047,pmaa086,pmaa005
                          FROM s_detail1[1].b_pmaa001,s_detail1[1].b_pmaa080,s_detail1[1].b_pmaa047, 
                              s_detail1[1].b_pmaa086,s_detail1[1].b_pmaa005
 
         BEFORE CONSTRUCT
                     DISPLAY apmq200_filter_parser('pmaa001') TO s_detail1[1].b_pmaa001
            DISPLAY apmq200_filter_parser('pmaa080') TO s_detail1[1].b_pmaa080
            DISPLAY apmq200_filter_parser('pmaa047') TO s_detail1[1].b_pmaa047
            DISPLAY apmq200_filter_parser('pmaa086') TO s_detail1[1].b_pmaa086
            DISPLAY apmq200_filter_parser('pmaa005') TO s_detail1[1].b_pmaa005
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmaa001>>----
         #Ctrlp:construct.c.page1.b_pmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa001
            #add-point:ON ACTION controlp INFIELD b_pmaa001 name="construct.c.filter.page1.b_pmaa001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "                                                                                                     #170113-00006#1 add 
            LET g_qryparam.where = g_qryparam.where," AND pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabsite = '",g_site,"' AND pmabent = '",g_enterprise,"' AND 1=1) "  #170113-00006#1 add           
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa001  #顯示到畫面上
            NEXT FIELD b_pmaa001                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa001_desc>>----
         #----<<b_pmaa080>>----
         #Ctrlp:construct.c.page1.b_pmaa080
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa080
            #add-point:ON ACTION controlp INFIELD b_pmaa080 name="construct.c.filter.page1.b_pmaa080"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa080  #顯示到畫面上
            NEXT FIELD b_pmaa080                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa080_desc>>----
         #----<<b_pmaa047>>----
         #Ctrlp:construct.c.filter.page1.b_pmaa047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa047
            #add-point:ON ACTION controlp INFIELD b_pmaa047 name="construct.c.filter.page1.b_pmaa047"
            
            #END add-point
 
 
         #----<<b_pmaa086>>----
         #Ctrlp:construct.c.page1.b_pmaa086
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa086
            #add-point:ON ACTION controlp INFIELD b_pmaa086 name="construct.c.filter.page1.b_pmaa086"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa086  #顯示到畫面上
            NEXT FIELD b_pmaa086                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa086_desc>>----
         #----<<b_pmaa005>>----
         #Ctrlp:construct.c.page1.b_pmaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa005
            #add-point:ON ACTION controlp INFIELD b_pmaa005 name="construct.c.filter.page1.b_pmaa005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa005  #顯示到畫面上
            NEXT FIELD b_pmaa005                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa005_desc>>----
 
 
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
 
      CALL apmq200_filter_show('pmaa001','b_pmaa001')
   CALL apmq200_filter_show('pmaa080','b_pmaa080')
   CALL apmq200_filter_show('pmaa047','b_pmaa047')
   CALL apmq200_filter_show('pmaa086','b_pmaa086')
   CALL apmq200_filter_show('pmaa005','b_pmaa005')
 
 
   CALL apmq200_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq200.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq200_filter_parser(ps_field)
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
 
{<section id="apmq200.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq200_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq200.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq200_detail_action_trans()
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
 
{<section id="apmq200.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq200_detail_index_setting()
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
            IF g_pmaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmaa_d.getLength() AND g_pmaa_d.getLength() > 0
            LET g_detail_idx = g_pmaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmaa_d.getLength() THEN
               LET g_detail_idx = g_pmaa_d.getLength()
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
 
{<section id="apmq200.mask_functions" >}
 &include "erp/apm/apmq200_mask.4gl"
 
{</section>}
 
{<section id="apmq200.other_function" readonly="Y" >}

PRIVATE FUNCTION apmq200_create_temp()
   CREATE TEMP TABLE apmq200_tmp01(  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
      pmdsdocno       VARCHAR(20),            #單號  
      pmdtseq         INTEGER,              #項次  
      pmds000         VARCHAR(10)     #單據性質   
   )
END FUNCTION

PRIVATE FUNCTION apmq200_drop_temp()
   DROP TABLE apmq200_tmp01  #160727-00019#13   16/08/03 By 08734 临时表长度超过15码的减少到15码以下 apmq200_pmds_tmp ——> apmq200_tmp01
END FUNCTION

PRIVATE FUNCTION apmq200_set_entry()
   CALL cl_set_comp_entry('bdate,edate',TRUE)
END FUNCTION

PRIVATE FUNCTION apmq200_set_no_entry()
   IF tm.radio != '6' THEN
      CALL cl_set_comp_entry('bdate,edate',FALSE)
   END IF
END FUNCTION

 
{</section>}
 
