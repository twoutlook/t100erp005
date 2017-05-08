#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq840.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-04-14 11:58:29), PR版次:0005(2016-08-17 11:04:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: apmq840
#+ Description: 採購單查詢列印作業
#+ Creator....: 02159(2015-03-31 22:09:25)
#+ Modifier...: 02159 -SD/PR- 08742
 
{</section>}
 
{<section id="apmq840.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160816-00001#7  16/08/17 By 08742     抓取理由碼改CALL sub
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
PRIVATE TYPE type_g_pmdl_d RECORD
       
       sel LIKE type_t.chr1, 
   pmdlsite LIKE pmdl_t.pmdlsite, 
   pmdlsite_desc LIKE type_t.chr500, 
   pmdldocno LIKE pmdl_t.pmdldocno, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdl004 LIKE pmdl_t.pmdl004, 
   pmdl004_desc LIKE type_t.chr500, 
   pmdl021 LIKE pmdl_t.pmdl021, 
   pmdl021_desc LIKE type_t.chr500, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl002_desc LIKE type_t.chr500, 
   pmdl003 LIKE pmdl_t.pmdl003, 
   pmdl003_desc LIKE type_t.chr500, 
   pmdl203 LIKE pmdl_t.pmdl203, 
   pmdl200 LIKE pmdl_t.pmdl200, 
   pmdl200_desc LIKE type_t.chr500, 
   pmdl204 LIKE pmdl_t.pmdl204, 
   pmdl204_desc LIKE type_t.chr500, 
   pmdl023 LIKE pmdl_t.pmdl023, 
   pmdl023_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_pmdl2_d RECORD
       pmdnseq LIKE pmdn_t.pmdnseq, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnsite_desc LIKE type_t.chr500, 
   pmdn200 LIKE pmdn_t.pmdn200, 
   pmdn001 LIKE pmdn_t.pmdn001, 
   pmdn001_desc LIKE type_t.chr500, 
   pmdn001_desc_desc LIKE type_t.chr500, 
   pmdn002 LIKE pmdn_t.pmdn002, 
   pmdn002_desc LIKE type_t.chr500, 
   pmdn016 LIKE pmdn_t.pmdn016, 
   pmdn016_desc LIKE type_t.chr500, 
   pmdn017 LIKE pmdn_t.pmdn017, 
   pmdn201 LIKE pmdn_t.pmdn201, 
   pmdn201_desc LIKE type_t.chr500, 
   pmdn202 LIKE pmdn_t.pmdn202, 
   pmdn006 LIKE pmdn_t.pmdn006, 
   pmdn006_desc LIKE type_t.chr500, 
   pmdn007 LIKE pmdn_t.pmdn007, 
   pmdn008 LIKE pmdn_t.pmdn008, 
   pmdn008_desc LIKE type_t.chr500, 
   pmdn009 LIKE pmdn_t.pmdn009, 
   pmdn010 LIKE pmdn_t.pmdn010, 
   pmdn010_desc LIKE type_t.chr500, 
   pmdn011 LIKE pmdn_t.pmdn011, 
   pmdn015 LIKE pmdn_t.pmdn015, 
   pmdn043 LIKE pmdn_t.pmdn043, 
   pmdn046 LIKE pmdn_t.pmdn046, 
   pmdn048 LIKE pmdn_t.pmdn048, 
   pmdn047 LIKE pmdn_t.pmdn047, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   pmdnunit_desc LIKE type_t.chr500, 
   pmdn225 LIKE pmdn_t.pmdn225, 
   pmdn225_desc LIKE type_t.chr500, 
   pmdn203 LIKE pmdn_t.pmdn203, 
   pmdn203_desc LIKE type_t.chr500, 
   pmdn025 LIKE pmdn_t.pmdn025, 
   pmdn025_desc LIKE type_t.chr500, 
   l_pmdn025_addr LIKE type_t.chr500, 
   pmdn028 LIKE pmdn_t.pmdn028, 
   pmdn028_desc LIKE type_t.chr500, 
   pmdn029 LIKE pmdn_t.pmdn029, 
   pmdn029_desc LIKE type_t.chr500, 
   pmdn030 LIKE pmdn_t.pmdn030, 
   pmdn053 LIKE pmdn_t.pmdn053, 
   pmdnorga LIKE pmdn_t.pmdnorga, 
   pmdnorga_desc LIKE type_t.chr500, 
   pmdn026 LIKE pmdn_t.pmdn026, 
   pmdn026_desc LIKE type_t.chr500, 
   l_pmdn026_addr LIKE type_t.chr500, 
   pmdn024 LIKE pmdn_t.pmdn024, 
   pmdn014 LIKE pmdn_t.pmdn014, 
   pmdn012 LIKE pmdn_t.pmdn012, 
   pmdn013 LIKE pmdn_t.pmdn013, 
   pmdn022 LIKE pmdn_t.pmdn022, 
   pmdn023 LIKE pmdn_t.pmdn023, 
   pmdn023_desc LIKE type_t.chr500, 
   pmdn045 LIKE pmdn_t.pmdn045, 
   pmdn206 LIKE pmdn_t.pmdn206, 
   pmdn207 LIKE pmdn_t.pmdn207, 
   pmdn208 LIKE pmdn_t.pmdn208, 
   pmdn209 LIKE pmdn_t.pmdn209, 
   pmdn210 LIKE pmdn_t.pmdn210, 
   pmdn211 LIKE pmdn_t.pmdn211, 
   pmdn212 LIKE pmdn_t.pmdn212, 
   pmdn213 LIKE pmdn_t.pmdn213, 
   pmdn019 LIKE pmdn_t.pmdn019, 
   pmdn020 LIKE pmdn_t.pmdn020, 
   pmdn224 LIKE pmdn_t.pmdn224, 
   pmdn052 LIKE pmdn_t.pmdn052, 
   pmdn049 LIKE pmdn_t.pmdn049, 
   pmdn049_desc LIKE type_t.chr500, 
   pmdn051 LIKE pmdn_t.pmdn051, 
   pmdn051_desc LIKE type_t.chr500, 
   pmdn205 LIKE pmdn_t.pmdn205, 
   pmdn205_desc LIKE type_t.chr500, 
   pmdn214 LIKE pmdn_t.pmdn214, 
   pmdn214_desc LIKE type_t.chr500, 
   pmdn215 LIKE pmdn_t.pmdn215, 
   pmdn216 LIKE pmdn_t.pmdn216, 
   pmdn217 LIKE pmdn_t.pmdn217, 
   pmdn217_desc LIKE type_t.chr500, 
   pmdn218 LIKE pmdn_t.pmdn218, 
   pmdn219 LIKE pmdn_t.pmdn219, 
   pmdn220 LIKE pmdn_t.pmdn220, 
   pmdn220_desc LIKE type_t.chr500, 
   pmdn221 LIKE pmdn_t.pmdn221, 
   pmdn221_desc LIKE type_t.chr500, 
   pmdn222 LIKE pmdn_t.pmdn222, 
   pmdn222_desc LIKE type_t.chr500, 
   pmdn223 LIKE pmdn_t.pmdn223, 
   pmdn223_desc LIKE type_t.chr500, 
   pmdn050 LIKE pmdn_t.pmdn050
       END RECORD
 
PRIVATE TYPE type_g_pmdl3_d RECORD
       pmdosite LIKE pmdo_t.pmdosite, 
   pmdoseq LIKE pmdo_t.pmdoseq, 
   pmdoseq1 LIKE pmdo_t.pmdoseq1, 
   pmdoseq2 LIKE pmdo_t.pmdoseq2, 
   pmdo003 LIKE pmdo_t.pmdo003, 
   pmdo001 LIKE pmdo_t.pmdo001, 
   pmdo001_desc LIKE type_t.chr500, 
   pmdo001_desc_desc LIKE type_t.chr500, 
   pmdo002 LIKE pmdo_t.pmdo002, 
   pmdo005 LIKE pmdo_t.pmdo005, 
   pmdn0141 LIKE type_t.chr500, 
   pmdo200 LIKE pmdo_t.pmdo200, 
   pmdo200_desc LIKE type_t.chr500, 
   pmdo201 LIKE pmdo_t.pmdo201, 
   pmdo004 LIKE pmdo_t.pmdo004, 
   pmdo004_desc LIKE type_t.chr500, 
   pmdo006 LIKE pmdo_t.pmdo006, 
   pmdo028 LIKE pmdo_t.pmdo028, 
   pmdo028_desc LIKE type_t.chr500, 
   pmdo029 LIKE pmdo_t.pmdo029, 
   pmdo013 LIKE pmdo_t.pmdo013, 
   pmdo011 LIKE pmdo_t.pmdo011, 
   pmdo012 LIKE pmdo_t.pmdo012, 
   pmdo010 LIKE pmdo_t.pmdo010, 
   pmdo010_desc LIKE type_t.chr500, 
   pmdo009 LIKE pmdo_t.pmdo009, 
   pmdo015 LIKE pmdo_t.pmdo015, 
   pmdo016 LIKE pmdo_t.pmdo016, 
   pmdo017 LIKE pmdo_t.pmdo017, 
   pmdo040 LIKE pmdo_t.pmdo040, 
   pmdo019 LIKE pmdo_t.pmdo019, 
   pmdo021 LIKE pmdo_t.pmdo021, 
   pmdo030 LIKE pmdo_t.pmdo030, 
   pmdo030_desc LIKE type_t.chr500, 
   pmdo031 LIKE pmdo_t.pmdo031, 
   pmdo022 LIKE pmdo_t.pmdo022, 
   pmdo023 LIKE pmdo_t.pmdo023, 
   pmdo023_desc LIKE type_t.chr500, 
   pmdo024 LIKE pmdo_t.pmdo024, 
   pmdo032 LIKE pmdo_t.pmdo032, 
   pmdo033 LIKE pmdo_t.pmdo033, 
   pmdo034 LIKE pmdo_t.pmdo034, 
   pmdo025 LIKE pmdo_t.pmdo025, 
   pmdo026 LIKE pmdo_t.pmdo026, 
   pmdo026_desc LIKE type_t.chr500, 
   pmdo027 LIKE pmdo_t.pmdo027
       END RECORD
 
PRIVATE TYPE type_g_pmdl4_d RECORD
       xrcdsite LIKE xrcd_t.xrcdsite, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcdseq LIKE xrcd_t.xrcdseq, 
   xrcd007 LIKE xrcd_t.xrcd007, 
   pmdn2001 LIKE type_t.chr500, 
   pmdn0011 LIKE type_t.chr500, 
   pmdn0011_desc LIKE type_t.chr500, 
   pmdn0011_desc_desc LIKE type_t.chr500, 
   pmdn0021 LIKE type_t.chr500, 
   pmdn0021_desc LIKE type_t.chr500, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_desc LIKE type_t.chr500, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd004 LIKE xrcd_t.xrcd004, 
   xrcd104 LIKE xrcd_t.xrcd104
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm        RECORD
     stus           LIKE type_t.chr10
                     END RECORD
DEFINE tm              type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmdl_d            DYNAMIC ARRAY OF type_g_pmdl_d
DEFINE g_pmdl_d_t          type_g_pmdl_d
DEFINE g_pmdl2_d     DYNAMIC ARRAY OF type_g_pmdl2_d
DEFINE g_pmdl2_d_t   type_g_pmdl2_d
 
DEFINE g_pmdl3_d     DYNAMIC ARRAY OF type_g_pmdl3_d
DEFINE g_pmdl3_d_t   type_g_pmdl3_d
 
DEFINE g_pmdl4_d     DYNAMIC ARRAY OF type_g_pmdl4_d
DEFINE g_pmdl4_d_t   type_g_pmdl4_d
 
 
 
 
 
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
DEFINE g_wc2_table3   STRING
DEFINE g_detail2_page_action3 STRING
 
DEFINE g_wc2_table4   STRING
DEFINE g_detail2_page_action4 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
DEFINE g_wc2_filter_table3   STRING
 
DEFINE g_wc2_filter_table4   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmq840.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
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
   DECLARE apmq840_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq840_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq840_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq840 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq840_init()   
 
      #進入選單 Menu (="N")
      CALL apmq840_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq840
      
   END IF 
   
   CLOSE apmq840_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq840.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq840_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_pmdl203','6014') 
   CALL cl_set_combo_scc('b_pmdn045','2035') 
   CALL cl_set_combo_scc('b_pmdn019','2055') 
   CALL cl_set_combo_scc('b_pmdn020','2036') 
   CALL cl_set_combo_scc('b_pmdn215','6739') 
   CALL cl_set_combo_scc('b_pmdn216','6013') 
   CALL cl_set_combo_scc('b_pmdo003','2055') 
   CALL cl_set_combo_scc('b_pmdo009','2057') 
   CALL cl_set_combo_scc('b_pmdo021','2058') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('pmdl203','6014')
   CALL s_aooi500_create_temp() RETURNING l_success   
   #end add-point
 
   CALL apmq840_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq840.default_search" >}
PRIVATE FUNCTION apmq840_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmdldocno = '", g_argv[01], "' AND "
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
 
{<section id="apmq840.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq840_ui_dialog() 
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
   DEFINE l_cmd     STRING
   DEFINE l_where   STRING
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
 
   
   CALL apmq840_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmdl_d.clear()
         CALL g_pmdl2_d.clear()
 
         CALL g_pmdl3_d.clear()
 
         CALL g_pmdl4_d.clear()
 
 
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
 
         CALL apmq840_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT tm.stus
          FROM l_stus
            BEFORE INPUT
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pmdlsite,pmdldocno,pmdl203,pmdldocdt,pmdl003,pmdl002,pmdl200,pmdl004
         
         ON ACTION controlp INFIELD pmdlsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdlsite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO pmdlsite
            NEXT FIELD pmdlsite
            
         ON ACTION controlp INFIELD pmdldocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()
            DISPLAY g_qryparam.return1 TO pmdldocno
            NEXT FIELD pmdldocno
            
         ON ACTION controlp INFIELD pmdl003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()
            DISPLAY g_qryparam.return1 TO pmdl003
            NEXT FIELD pmdl003
            
         ON ACTION controlp INFIELD pmdl002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO pmdl002
            NEXT FIELD pmdl002
            
         ON ACTION controlp INFIELD pmdl200
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdl200') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdl200',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef303 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO pmdl200
            NEXT FIELD pmdl200
            
         ON ACTION controlp INFIELD pmdl004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()
            DISPLAY g_qryparam.return1 TO pmdl004
            NEXT FIELD pmdl004

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_pmdl_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq840_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq840_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_pmdl2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_pmdl3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_pmdl4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page4_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aooi610
                  LET g_action_choice="prog_aooi610"
                  IF cl_auth_chk_act("prog_aooi610") THEN
                     
                     #add-point:ON ACTION prog_aooi610 name="menu.detail_show.page4_sub.prog_aooi610"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aooi610'
               LET la_param.param[1] = g_pmdl4_d[g_detail_idx2].xrcd002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page4.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apmq840_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET tm.stus = 'ALL'
            DISPLAY tm.stus TO l_stus
            CALL cl_set_act_visible("insert,query", FALSE) 
            #end add-point
            NEXT FIELD pmdlsite
 
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
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
            IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table3
            END IF
 
            IF NOT cl_null(g_wc2_table4) AND g_wc2_table4 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table4
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
            IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table3
            END IF
 
            IF NOT cl_null(g_wc2_table4) AND g_wc2_table4 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table4
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL apmq840_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmdl_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_pmdl2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_pmdl3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_pmdl4_d)
               LET g_export_id[4]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq840_b_fill()
 
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
            CALL apmq840_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq840_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq840_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq840_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmdl_d.getLength()
               LET g_pmdl_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmdl_d.getLength()
               LET g_pmdl_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmdl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmdl_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmdl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmdl_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq840_filter()
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
               LET l_cmd = ''
               LET l_where = ''
               FOR li_idx = 1 TO g_pmdl_d.getLength()
                  IF g_pmdl_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_pmdl_d[li_idx].pmdldocno,"'"
                     ELSE
                        LET l_cmd = "'",g_pmdl_d[li_idx].pmdldocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "pmdldocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL apmr840_g01(l_where)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET l_cmd = ''
               LET l_where = ''
               FOR li_idx = 1 TO g_pmdl_d.getLength()
                  IF g_pmdl_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_pmdl_d[li_idx].pmdldocno,"'"
                     ELSE
                        LET l_cmd = "'",g_pmdl_d[li_idx].pmdldocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "pmdldocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL apmr840_g01(l_where)
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
 
{<section id="apmq840.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq840_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'pmdlsite') RETURNING l_where
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
 
   CALL g_pmdl_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF tm.stus != 'ALL' THEN
      LET l_where = l_where CLIPPED," AND pmdlstus = '",tm.stus CLIPPED,"'"
   END IF
   
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',pmdlsite,'',pmdldocno,pmdldocdt,pmdl004,'',pmdl021,'',pmdl002, 
       '',pmdl003,'',pmdl203,pmdl200,'',pmdl204,'',pmdl023,''  ,DENSE_RANK() OVER( ORDER BY pmdl_t.pmdldocno) AS RANK FROM pmdl_t", 
 
 
#table2
                     " LEFT JOIN pmdn_t ON pmdnent = pmdlent AND pmdldocno = pmdndocno",
#table3
                     " LEFT JOIN pmdo_t ON pmdoent = pmdlent AND pmdldocno = pmdodocno",
#table4
                     " LEFT JOIN xrcd_t ON xrcdent = pmdlent AND pmdldocno = xrcddocno",
 
                     "",
                     " WHERE pmdlent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmdl_t"),
                     " ORDER BY pmdl_t.pmdldocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150909 mark by beckxie---S
   #LET ls_sql_rank = "SELECT  UNIQUE 'N',pmdlsite,t1.ooefl003 pmdlsite_desc,pmdldocno,pmdldocdt,pmdl004,t2.pmaal004 pmdl004_desc,pmdl021,t3.pmaal004 pmdl021_desc,pmdl002,", 
   #                  "        t4.ooag011 pmdl002_desc,pmdl003,t5.ooefl003 pmdl003_desc,pmdl203,pmdl200,t6.ooefl003 pmdl200_desc,pmdl204,t7.ooefl003 pmdl204_desc,pmdl023,t8.oojdl004 pmdl023_desc,DENSE_RANK() OVER( ORDER BY pmdl_t.pmdldocno) AS RANK ",
	#				 " FROM pmdl_t ",
   #                  " LEFT JOIN pmdn_t ON pmdnent = pmdlent AND pmdldocno = pmdndocno ",
   #                  " LEFT JOIN pmdo_t ON pmdoent = pmdlent AND pmdldocno = pmdodocno ",
   #                  " LEFT JOIN xrcd_t ON xrcdent = pmdlent AND pmdldocno = xrcddocno ",
	#				 " LEFT JOIN ooefl_t t1 ON t1.ooeflent = pmdlent AND t1.ooefl001 = pmdlsite AND t1.ooefl002 = '"||g_dlang||"' ",
	#				 " LEFT JOIN pmaal_t t2 ON t2.pmaalent = pmdlent AND t2.pmaal001 = pmdl004 AND t2.pmaal002 = '"||g_dlang||"' ",
	#				 " LEFT JOIN pmaal_t t3 ON t3.pmaalent = pmdlent AND t3.pmaal001 = pmdl021 AND t3.pmaal002 = '"||g_dlang||"' ",
	#				 " LEFT JOIN ooag_t t4 ON t4.ooagent = pmdlent AND t4.ooag001=pmdl002  ",
	#				 " LEFT JOIN ooefl_t t5 ON t5.ooeflent = pmdlent AND t5.ooefl001 = pmdl003 AND t5.ooefl002 = '"||g_dlang||"' ",
	#				 " LEFT JOIN ooefl_t t6 ON t6.ooeflent = pmdlent AND t6.ooefl001 = pmdl200 AND t6.ooefl002 = '"||g_dlang||"' ",
	#				 " LEFT JOIN ooefl_t t7 ON t7.ooeflent = pmdlent AND t7.ooefl001 = pmdl204 AND t7.ooefl002 = '"||g_dlang||"' ",
	#				 " LEFT JOIN oojdl_t t8 ON t8.oojdlent = pmdlent AND t8.oojdl001 = pmdl023 AND t8.oojdl002 = '"||g_dlang||"' ",
   #                  " WHERE  pmdl203 IS NOT NULL AND pmdlent= ? AND 1=1 AND ", ls_wc
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmdl_t"),
   #                  " ORDER BY pmdl_t.pmdldocno"
   #150826-00013#1 效能調整 20150909 mark by beckxie---E
   #150826-00013#1 效能調整 20150909 add by beckxie---S
   LET ls_sql_rank = "SELECT  UNIQUE 'N',pmdlsite,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE ooeflent = pmdlent AND ooefl001 = pmdlsite ",
                     "            AND ooefl002 = '"||g_dlang||"') pmdlsite_desc,",
                     "        pmdldocno,pmdldocdt,pmdl004,",
                     "        (SELECT pmaal004",
                     "           FROM pmaal_t",
                     "          WHERE pmaalent = pmdlent AND pmaal001 = pmdl004 ",
                     "            AND pmaal002 = '"||g_dlang||"') pmdl004_desc,",
                     "        pmdl021,",
                     "        (SELECT pmaal004",
                     "           FROM pmaal_t",
                     "          WHERE pmaalent = pmdlent AND pmaal001 = pmdl021 ",
                     "            AND pmaal002 = '"||g_dlang||"') pmdl021_desc,",
                     "        pmdl002,", 
                     "        (SELECT ooag011",
                     "           FROM ooag_t",
                     "          WHERE ooagent = pmdlent AND ooag001=pmdl002) pmdl002_desc,",
                     "        pmdl003,",
                     "        (SELECT ooefl001",
                     "           FROM ooefl_t",
                     "          WHERE ooeflent = pmdlent AND ooefl001 = pmdl003 ",
                     "            AND ooefl002 = '"||g_dlang||"') pmdl003_desc,",
                     "        pmdl203,pmdl200,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE ooeflent = pmdlent AND ooefl001 = pmdl200 ",
                     "            AND ooefl002 = '"||g_dlang||"') pmdl200_desc,",
                     "        pmdl204,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE ooeflent = pmdlent AND ooefl001 = pmdl204 ",
                     "            AND ooefl002 = '"||g_dlang||"') pmdl204_desc,",
                     "        pmdl023,",
                     "        (SELECT oojdl004",
                     "           FROM oojdl_t",
                     "          WHERE oojdlent = pmdlent AND oojdl001 = pmdl023 ",
                     "            AND oojdl002 = '"||g_dlang||"') pmdl023_desc,",
                     "        DENSE_RANK() OVER( ORDER BY pmdl_t.pmdldocno) AS RANK ",
					      " FROM pmdl_t ",
                     " LEFT JOIN pmdn_t ON pmdnent = pmdlent AND pmdldocno = pmdndocno ",
                     " LEFT JOIN pmdo_t ON pmdoent = pmdlent AND pmdldocno = pmdodocno ",
                     " LEFT JOIN xrcd_t ON xrcdent = pmdlent AND pmdldocno = xrcddocno ",
                     " WHERE  pmdl203 IS NOT NULL AND pmdlent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmdl_t"),
                     " ORDER BY pmdl_t.pmdldocno"
   #150826-00013#1 效能調整 20150909 add by beckxie---E
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
 
   LET g_sql = "SELECT '',pmdlsite,'',pmdldocno,pmdldocdt,pmdl004,'',pmdl021,'',pmdl002,'',pmdl003,'', 
       pmdl203,pmdl200,'',pmdl204,'',pmdl023,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  'N',pmdlsite,pmdlsite_desc,pmdldocno,pmdldocdt,pmdl004,pmdl004_desc,pmdl021,pmdl021_desc,pmdl002,", 
                     "   pmdl002_desc,pmdl003,pmdl003_desc,pmdl203,pmdl200,pmdl200_desc,pmdl204,pmdl204_desc,pmdl023,pmdl023_desc ",
               " FROM (",ls_sql_rank,")",
               " WHERE RANK >= ",g_pagestart,
               " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq840_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq840_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmdl_d[l_ac].sel,g_pmdl_d[l_ac].pmdlsite,g_pmdl_d[l_ac].pmdlsite_desc, 
       g_pmdl_d[l_ac].pmdldocno,g_pmdl_d[l_ac].pmdldocdt,g_pmdl_d[l_ac].pmdl004,g_pmdl_d[l_ac].pmdl004_desc, 
       g_pmdl_d[l_ac].pmdl021,g_pmdl_d[l_ac].pmdl021_desc,g_pmdl_d[l_ac].pmdl002,g_pmdl_d[l_ac].pmdl002_desc, 
       g_pmdl_d[l_ac].pmdl003,g_pmdl_d[l_ac].pmdl003_desc,g_pmdl_d[l_ac].pmdl203,g_pmdl_d[l_ac].pmdl200, 
       g_pmdl_d[l_ac].pmdl200_desc,g_pmdl_d[l_ac].pmdl204,g_pmdl_d[l_ac].pmdl204_desc,g_pmdl_d[l_ac].pmdl023, 
       g_pmdl_d[l_ac].pmdl023_desc
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
 
      CALL apmq840_detail_show("'1'")
 
      CALL apmq840_pmdl_t_mask()
 
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
 
   CALL g_pmdl_d.deleteElement(g_pmdl_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmdl_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apmq840_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq840_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq840_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmdl_d.getLength() > 0 THEN
      CALL apmq840_b_fill2()
   END IF
 
      CALL apmq840_filter_show('pmdlsite','b_pmdlsite')
   CALL apmq840_filter_show('pmdldocno','b_pmdldocno')
   CALL apmq840_filter_show('pmdldocdt','b_pmdldocdt')
   CALL apmq840_filter_show('pmdl004','b_pmdl004')
   CALL apmq840_filter_show('pmdl021','b_pmdl021')
   CALL apmq840_filter_show('pmdl002','b_pmdl002')
   CALL apmq840_filter_show('pmdl003','b_pmdl003')
   CALL apmq840_filter_show('pmdl203','b_pmdl203')
   CALL apmq840_filter_show('pmdl200','b_pmdl200')
   CALL apmq840_filter_show('pmdl204','b_pmdl204')
   CALL apmq840_filter_show('pmdl023','b_pmdl023')
   CALL apmq840_filter_show('pmdnseq','b_pmdnseq')
   CALL apmq840_filter_show('pmdnsite','b_pmdnsite')
   CALL apmq840_filter_show('pmdn200','b_pmdn200')
   CALL apmq840_filter_show('pmdn001','b_pmdn001')
   CALL apmq840_filter_show('pmdn002','b_pmdn002')
   CALL apmq840_filter_show('pmdn016','b_pmdn016')
   CALL apmq840_filter_show('pmdn017','b_pmdn017')
   CALL apmq840_filter_show('pmdn201','b_pmdn201')
   CALL apmq840_filter_show('pmdn202','b_pmdn202')
   CALL apmq840_filter_show('pmdn006','b_pmdn006')
   CALL apmq840_filter_show('pmdn007','b_pmdn007')
   CALL apmq840_filter_show('pmdn008','b_pmdn008')
   CALL apmq840_filter_show('pmdn009','b_pmdn009')
   CALL apmq840_filter_show('pmdn010','b_pmdn010')
   CALL apmq840_filter_show('pmdn011','b_pmdn011')
   CALL apmq840_filter_show('pmdn015','b_pmdn015')
   CALL apmq840_filter_show('pmdn043','b_pmdn043')
   CALL apmq840_filter_show('pmdn046','b_pmdn046')
   CALL apmq840_filter_show('pmdn048','b_pmdn048')
   CALL apmq840_filter_show('pmdn047','b_pmdn047')
   CALL apmq840_filter_show('pmdnunit','b_pmdnunit')
   CALL apmq840_filter_show('pmdn225','b_pmdn225')
   CALL apmq840_filter_show('pmdn203','b_pmdn203')
   CALL apmq840_filter_show('pmdn025','b_pmdn025')
   CALL apmq840_filter_show('pmdn028','b_pmdn028')
   CALL apmq840_filter_show('pmdn029','b_pmdn029')
   CALL apmq840_filter_show('pmdn030','b_pmdn030')
   CALL apmq840_filter_show('pmdn053','b_pmdn053')
   CALL apmq840_filter_show('pmdnorga','b_pmdnorga')
   CALL apmq840_filter_show('pmdn026','b_pmdn026')
   CALL apmq840_filter_show('pmdn024','b_pmdn024')
   CALL apmq840_filter_show('pmdn014','b_pmdn014')
   CALL apmq840_filter_show('pmdn012','b_pmdn012')
   CALL apmq840_filter_show('pmdn013','b_pmdn013')
   CALL apmq840_filter_show('pmdn022','b_pmdn022')
   CALL apmq840_filter_show('pmdn023','b_pmdn023')
   CALL apmq840_filter_show('pmdn045','b_pmdn045')
   CALL apmq840_filter_show('pmdn206','b_pmdn206')
   CALL apmq840_filter_show('pmdn207','b_pmdn207')
   CALL apmq840_filter_show('pmdn208','b_pmdn208')
   CALL apmq840_filter_show('pmdn209','b_pmdn209')
   CALL apmq840_filter_show('pmdn210','b_pmdn210')
   CALL apmq840_filter_show('pmdn211','b_pmdn211')
   CALL apmq840_filter_show('pmdn212','b_pmdn212')
   CALL apmq840_filter_show('pmdn213','b_pmdn213')
   CALL apmq840_filter_show('pmdn019','b_pmdn019')
   CALL apmq840_filter_show('pmdn020','b_pmdn020')
   CALL apmq840_filter_show('pmdn224','b_pmdn224')
   CALL apmq840_filter_show('pmdn052','b_pmdn052')
   CALL apmq840_filter_show('pmdn049','b_pmdn049')
   CALL apmq840_filter_show('pmdn051','b_pmdn051')
   CALL apmq840_filter_show('pmdn205','b_pmdn205')
   CALL apmq840_filter_show('pmdn214','b_pmdn214')
   CALL apmq840_filter_show('pmdn215','b_pmdn215')
   CALL apmq840_filter_show('pmdn216','b_pmdn216')
   CALL apmq840_filter_show('pmdn217','b_pmdn217')
   CALL apmq840_filter_show('pmdn218','b_pmdn218')
   CALL apmq840_filter_show('pmdn219','b_pmdn219')
   CALL apmq840_filter_show('pmdn220','b_pmdn220')
   CALL apmq840_filter_show('pmdn221','b_pmdn221')
   CALL apmq840_filter_show('pmdn222','b_pmdn222')
   CALL apmq840_filter_show('pmdn223','b_pmdn223')
   CALL apmq840_filter_show('pmdn050','b_pmdn050')
   CALL apmq840_filter_show('pmdosite','b_pmdosite')
   CALL apmq840_filter_show('pmdoseq','b_pmdoseq')
   CALL apmq840_filter_show('pmdoseq1','b_pmdoseq1')
   CALL apmq840_filter_show('pmdoseq2','b_pmdoseq2')
   CALL apmq840_filter_show('pmdo003','b_pmdo003')
   CALL apmq840_filter_show('pmdo001','b_pmdo001')
   CALL apmq840_filter_show('pmdo002','b_pmdo002')
   CALL apmq840_filter_show('pmdo005','b_pmdo005')
   CALL apmq840_filter_show('pmdo200','b_pmdo200')
   CALL apmq840_filter_show('pmdo201','b_pmdo201')
   CALL apmq840_filter_show('pmdo004','b_pmdo004')
   CALL apmq840_filter_show('pmdo006','b_pmdo006')
   CALL apmq840_filter_show('pmdo028','b_pmdo028')
   CALL apmq840_filter_show('pmdo029','b_pmdo029')
   CALL apmq840_filter_show('pmdo013','b_pmdo013')
   CALL apmq840_filter_show('pmdo011','b_pmdo011')
   CALL apmq840_filter_show('pmdo012','b_pmdo012')
   CALL apmq840_filter_show('pmdo010','b_pmdo010')
   CALL apmq840_filter_show('pmdo009','b_pmdo009')
   CALL apmq840_filter_show('pmdo015','b_pmdo015')
   CALL apmq840_filter_show('pmdo016','b_pmdo016')
   CALL apmq840_filter_show('pmdo017','b_pmdo017')
   CALL apmq840_filter_show('pmdo040','b_pmdo040')
   CALL apmq840_filter_show('pmdo019','b_pmdo019')
   CALL apmq840_filter_show('pmdo021','b_pmdo021')
   CALL apmq840_filter_show('pmdo030','b_pmdo030')
   CALL apmq840_filter_show('pmdo031','b_pmdo031')
   CALL apmq840_filter_show('pmdo022','b_pmdo022')
   CALL apmq840_filter_show('pmdo023','b_pmdo023')
   CALL apmq840_filter_show('pmdo024','b_pmdo024')
   CALL apmq840_filter_show('pmdo032','b_pmdo032')
   CALL apmq840_filter_show('pmdo033','b_pmdo033')
   CALL apmq840_filter_show('pmdo034','b_pmdo034')
   CALL apmq840_filter_show('pmdo025','b_pmdo025')
   CALL apmq840_filter_show('pmdo026','b_pmdo026')
   CALL apmq840_filter_show('pmdo027','b_pmdo027')
   CALL apmq840_filter_show('xrcdsite','b_xrcdsite')
   CALL apmq840_filter_show('xrcdld','b_xrcdld')
   CALL apmq840_filter_show('xrcdseq','b_xrcdseq')
   CALL apmq840_filter_show('xrcd007','b_xrcd007')
   CALL apmq840_filter_show('xrcd002','b_xrcd002')
   CALL apmq840_filter_show('xrcdseq2','b_xrcdseq2')
   CALL apmq840_filter_show('xrcd003','b_xrcd003')
   CALL apmq840_filter_show('xrcd006','b_xrcd006')
   CALL apmq840_filter_show('xrcd004','b_xrcd004')
   CALL apmq840_filter_show('xrcd104','b_xrcd104')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq840.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq840_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_ooef001       LIKE ooef_t.ooef001
   DEFINE l_acc           LIKE gzcb_t.gzcb007   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_pmdl2_d.clear()
#Page3
   CALL g_pmdl3_d.clear()
#Page4
   CALL g_pmdl4_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   LET l_cnt = g_pmdl_d.getLength()
   IF l_cnt <= 0 THEN
     RETURN
   END IF
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE pmdnseq,pmdnsite,'',pmdn200,pmdn001,'','',pmdn002,'',pmdn016,'',pmdn017, 
          pmdn201,'',pmdn202,pmdn006,'',pmdn007,pmdn008,'',pmdn009,pmdn010,'',pmdn011,pmdn015,pmdn043, 
          pmdn046,pmdn048,pmdn047,pmdnunit,'',pmdn225,'',pmdn203,'',pmdn025,'','',pmdn028,'',pmdn029, 
          '',pmdn030,pmdn053,pmdnorga,'',pmdn026,'','',pmdn024,pmdn014,pmdn012,pmdn013,pmdn022,pmdn023, 
          '',pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212,pmdn213,pmdn019,pmdn020, 
          pmdn224,pmdn052,pmdn049,'',pmdn051,'',pmdn205,'',pmdn214,'',pmdn215,pmdn216,pmdn217,'',pmdn218, 
          pmdn219,pmdn220,'',pmdn221,'',pmdn222,'',pmdn223,'',pmdn050 FROM pmdn_t",
                  "",
                  " WHERE pmdnent=? AND pmdndocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdn_t.pmdnseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      #150826-00013#1 效能調整 20150909 mark by beckxie---S
      #LET g_sql = "SELECT  UNIQUE pmdnseq,pmdnsite,t1.ooefl003,pmdn200,pmdn001,t2.imaal003,t3.imaal004,pmdn002,'',pmdn016,'',pmdn017,", 
      #            "        pmdn201,t4.oocal003,pmdn202,pmdn006,t5.oocal003,pmdn007,pmdn008,t6.oocal003,pmdn009,pmdn010,t7.oocal003,pmdn011,pmdn015,pmdn043, ",
      #            "        pmdn046,pmdn048,pmdn047,pmdnunit,t8.ooefl003,pmdn225,t9.ooefl003,pmdn203,t10.ooefl003,pmdn025,'','',pmdn028,t11.inayl003,pmdn029, ",
      #            "        '',pmdn030,pmdn053,pmdnorga,t12.ooefl003,pmdn026,'','',pmdn024,pmdn014,pmdn012,pmdn013,pmdn022,pmdn023, ",
      #            "        t13.pmaal004,pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212,pmdn213,pmdn019,pmdn020, ",
      #            "        pmdn224,pmdn052,pmdn049,'',pmdn051,'',pmdn205,t14.ooefl003,pmdn214,t15.oojdl003,pmdn215,pmdn216,pmdn217,t16.staal003,pmdn218, ", 
      #            "        pmdn219,pmdn220,t17.ooag011,pmdn221,t18.ooefl003,pmdn222,'',pmdn223,'',pmdn050 ",
		#		      "  FROM pmdn_t ",
      #            " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=pmdnsite AND t1.ooefl002='"||g_dlang||"' ",
      #            " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=pmdn001 AND t2.imaal002='"||g_dlang||"' ",
      #            " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=pmdn001 AND t3.imaal002='"||g_dlang||"' ",
      #            " LEFT JOIN oocal_t t4 ON t4.oocalent='"||g_enterprise||"' AND t4.oocal001=pmdn201 AND t4.oocal002='"||g_dlang||"' ",
      #            " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=pmdn006 AND t5.oocal002='"||g_dlang||"' ",
      #            " LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=pmdn008 AND t6.oocal002='"||g_dlang||"' ",
      #            " LEFT JOIN oocal_t t7 ON t7.oocalent='"||g_enterprise||"' AND t7.oocal001=pmdn010 AND t7.oocal002='"||g_dlang||"' ",
      #            " LEFT JOIN ooefl_t t8 ON t8.ooeflent='"||g_enterprise||"' AND t8.ooefl001=pmdnunit AND t8.ooefl002='"||g_dlang||"' ",
      #            " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=pmdn225 AND t9.ooefl002='"||g_dlang||"' ",
      #            " LEFT JOIN ooefl_t t10 ON t10.ooeflent='"||g_enterprise||"' AND t10.ooefl001=pmdn203 AND t10.ooefl002='"||g_dlang||"' ",
      #            " LEFT JOIN inayl_t t11 ON t11.inaylent='"||g_enterprise||"' AND t11.inayl001=pmdn028 AND t11.inayl002='"||g_dlang||"' ",
      #            " LEFT JOIN ooefl_t t12 ON t12.ooeflent='"||g_enterprise||"' AND t12.ooefl001=pmdnorga AND t12.ooefl002='"||g_dlang||"' ",
      #            " LEFT JOIN pmaal_t t13 ON t13.pmaalent='"||g_enterprise||"' AND t13.pmaal001=pmdn023 AND t13.pmaal002='"||g_dlang||"' ",
      #            " LEFT JOIN ooefl_t t14 ON t14.ooeflent='"||g_enterprise||"' AND t14.ooefl001=pmdn205 AND t14.ooefl002='"||g_dlang||"' ",
      #            " LEFT JOIN oojdl_t t15 ON t15.oojdlent='"||g_enterprise||"' AND t15.oojdl001=pmdn214 AND t15.oojdl002='"||g_dlang||"' ",
      #            " LEFT JOIN staal_t t16 ON t16.staalent='"||g_enterprise||"' AND t16.staal001=pmdn217 AND t16.staal002='"||g_dlang||"' ",
      #            " LEFT JOIN ooag_t t17 ON t17.ooagent='"||g_enterprise||"' AND t17.ooag001=pmdn220  ",
      #            " LEFT JOIN ooefl_t t18 ON t18.ooeflent='"||g_enterprise||"' AND t18.ooefl001=pmdn221 AND t18.ooefl002='"||g_dlang||"' ",	  
      #            " WHERE pmdnent=? AND pmdndocno=?"
      #
      #IF NOT cl_null(g_wc2_table2) THEN
      #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      #END IF
      #
      #LET g_sql = g_sql, " ORDER BY pmdn_t.pmdnseq"
      #150826-00013#1 效能調整 20150909 mark by beckxie---E
      #150826-00013#1 效能調整 20150909 add by beckxie---S
      LET g_sql = "SELECT  UNIQUE pmdnseq,pmdnsite,",
                  "        (SELECT ooefl003",
                  "           FROM ooefl_t",
                  "          WHERE ooeflent= pmdnent AND ooefl001=pmdnsite ",
                  "            AND ooefl002='"||g_dlang||"') pmdnsite_desc,",
                  "        pmdn200,pmdn001, t2.imaal003,t2.imaal004,",
                  "        pmdn002,'',pmdn016,",
                  "        (SELECT oodbl004 ",
                  "           FROM oodbl_t ",
                  "          WHERE oodblent= pmdnent ",
                  "            AND oodbl001=(SELECT ooef019 FROM ooef_t WHERE ooefent =pmdnent AND ooef001 =pmdnsite) ",
                  "            AND oodbl002= pmdn016 AND oodbl003='",g_dlang,"'), ",
                  "       pmdn017,pmdn201,",
                  "        (SELECT oocal003",
                  "           FROM oocal_t",
                  "          WHERE oocalent= pmdnent AND oocal001=pmdn201",
                  "            AND oocal002='"||g_dlang||"') pmdn201_desc,",         
                  "        pmdn202,pmdn006,",
                  "        (SELECT oocal003",
                  "           FROM oocal_t",
                  "          WHERE oocalent= pmdnent  AND oocal001=pmdn006 ",
                  "            AND oocal002='"||g_dlang||"') pmdn006_desc,",
                  "        pmdn007,pmdn008,",
                  "        (SELECT oocal003",
                  "           FROM oocal_t",
                  "          WHERE oocalent= pmdnent  AND oocal001=pmdn008 ",
                  "            AND oocal002='"||g_dlang||"') pmdn008_desc,",
                  "        pmdn009,pmdn010,",
                  "        (SELECT oocal003",
                  "           FROM oocal_t",
                  "          WHERE oocalent= pmdnent  AND oocal001=pmdn010 ",
                  "            AND oocal002='"||g_dlang||"') pmdn010_desc,",
                  "        pmdn011,pmdn015,pmdn043,pmdn046,pmdn048,pmdn047,pmdnunit, ",
                  "        (SELECT ooefl003",
                  "           FROM ooefl_t",
                  "          WHERE ooeflent= pmdnent  AND ooefl001=pmdnunit ",
                  "            AND ooefl002='"||g_dlang||"') pmdnunit_desc,",
                  "        pmdn225,",
                  "        (SELECT ooefl003",
                  "           FROM ooefl_t",
                  "          WHERE ooeflent= pmdnent  AND ooefl001=pmdn225 ",
                  "            AND ooefl002='"||g_dlang||"') pmdn225_desc,",
                  "        pmdn203,",
                  "        (SELECT ooefl003",
                  "           FROM ooefl_t",
                  "          WHERE ooeflent= pmdnent  AND ooefl001=pmdn203 ",
                  "            AND ooefl002='"||g_dlang||"') pmdn203_desc,",
                  "        pmdn025,'','',pmdn028,",
                  "        (SELECT inayl003",
                  "           FROM inayl_t",
                  "          WHERE inaylent=  pmdnent  AND inayl001=pmdn028 ",
                  "            AND inayl002='"||g_dlang||"') pmdn028_desc,",
                  "        pmdn029,",
                  #160420-00039#19 160516 by sakura add(S)
                  "        (SELECT inab003 ",
                  "           FROM inab_t ",
                  "          WHERE inabent = pmdnent AND inabsite = pmdnunit ",
                  "            AND inab001 = pmdn028 AND inab002 = pmdn029) pmdn029_desc,",
                  #160420-00039#19 160516 by sakura add(E)
                  "        pmdn030,pmdn053,pmdnorga, ",
                  "        (SELECT ooefl003",
                  "           FROM ooefl_t",
                  "          WHERE ooeflent= pmdnent AND ooefl001=pmdnorga ",
                  "            AND ooefl002='"||g_dlang||"') pmdnorga_desc,",
                  "        pmdn026,'','',pmdn024,pmdn014,pmdn012,pmdn013,pmdn022,pmdn023, ",
                  "        (SELECT pmaal004",
                  "           FROM pmaal_t",
                  "          WHERE pmaalent= pmdnent AND pmaal001=pmdn023 ",
                  "            AND pmaal002='"||g_dlang||"') pmdn023_desc,",
                  "        pmdn045,pmdn206,pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,pmdn212,pmdn213,pmdn019,pmdn020, ",
                  "        pmdn224,pmdn052,pmdn049,",
                  "        (SELECT oocql004 ",
                  "           FROM oocql_t ",
                  "          WHERE oocqlent = pmdnent AND oocql001 = (SELECT gzcb004 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'apmt840') ",
                  "            AND oocql002 = pmdn049 AND oocql003 = '",g_dlang,"'), ",
                  "        pmdn051,",
                  "        (SELECT oocql004 ",
                  "           FROM oocql_t ",
                  "          WHERE oocqlent = pmdnent AND oocql001 = (SELECT gzcb004 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'apmt840') ",
                  "            AND oocql002 = pmdn051 AND oocql003 = '",g_dlang,"'), ",
                  "        pmdn205,",
                  "        (SELECT ooefl003",
                  "           FROM ooefl_t",
                  "          WHERE ooeflent= pmdnent AND ooefl001=pmdn205 ",
                  "            AND ooefl002='"||g_dlang||"') pmdn205_desc,",
                  "        pmdn214,",
                  "        (SELECT oojdl003",
                  "           FROM oojdl_t",
                  "          WHERE oojdlent= pmdnent AND oojdl001=pmdn214 ",
                  "            AND oojdl002='"||g_dlang||"') pmdn214_desc,",
                  "        pmdn215,pmdn216,pmdn217,",
                  "        (SELECT staal003",
                  "           FROM staal_t",
                  "          WHERE staalent= pmdnent  AND staal001=pmdn217 ",
                  "            AND staal002='"||g_dlang||"') pmdn217_desc,",
                  "        pmdn218,pmdn219,pmdn220, ", 
                  "        (SELECT ooag011",
                  "           FROM ooag_t",
                  "          WHERE ooagent= pmdnent  AND ooag001=pmdn220) pmdn220_desc,",
                  "        pmdn221,",
                  "        (SELECT ooefl003",
                  "           FROM ooefl_t",
                  "          WHERE ooeflent= pmdnent  AND ooefl001=pmdn221 ",
                  "            AND ooefl002='"||g_dlang||"') pmdn221_desc,",	  
                  "        pmdn222,",
                  "        (SELECT ooefl003 ",
                  "           FROM ooefl_t ",
                  "          WHERE ooeflent= pmdnent AND ooefl001=pmdn222 ",
                  "            AND ooefl002='"||g_dlang||"') pmdn222_desc,",
                  "        pmdn223,",
                  "        (SELECT ooefl003 ",
                  "           FROM ooefl_t ",
                  "          WHERE ooeflent= pmdnent AND ooefl001=pmdn223 ",
                  "            AND ooefl002='"||g_dlang||"') pmdn223_desc,",
                  "        pmdn050 ",
				      "  FROM pmdn_t ",
                  " LEFT JOIN imaal_t t2 ON t2.imaalent= pmdnent  AND t2.imaal001=pmdn001 AND t2.imaal002='"||g_dlang||"' ",
                  " WHERE pmdnent=? AND pmdndocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdn_t.pmdnseq"
      #150826-00013#1 效能調整 20150909 add by beckxie---E
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq840_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR apmq840_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_pmdl_d[g_detail_idx].pmdldocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_pmdl_d[g_detail_idx].pmdldocno
 
      INTO g_pmdl2_d[l_ac].pmdnseq,g_pmdl2_d[l_ac].pmdnsite,g_pmdl2_d[l_ac].pmdnsite_desc,g_pmdl2_d[l_ac].pmdn200, 
          g_pmdl2_d[l_ac].pmdn001,g_pmdl2_d[l_ac].pmdn001_desc,g_pmdl2_d[l_ac].pmdn001_desc_desc,g_pmdl2_d[l_ac].pmdn002, 
          g_pmdl2_d[l_ac].pmdn002_desc,g_pmdl2_d[l_ac].pmdn016,g_pmdl2_d[l_ac].pmdn016_desc,g_pmdl2_d[l_ac].pmdn017, 
          g_pmdl2_d[l_ac].pmdn201,g_pmdl2_d[l_ac].pmdn201_desc,g_pmdl2_d[l_ac].pmdn202,g_pmdl2_d[l_ac].pmdn006, 
          g_pmdl2_d[l_ac].pmdn006_desc,g_pmdl2_d[l_ac].pmdn007,g_pmdl2_d[l_ac].pmdn008,g_pmdl2_d[l_ac].pmdn008_desc, 
          g_pmdl2_d[l_ac].pmdn009,g_pmdl2_d[l_ac].pmdn010,g_pmdl2_d[l_ac].pmdn010_desc,g_pmdl2_d[l_ac].pmdn011, 
          g_pmdl2_d[l_ac].pmdn015,g_pmdl2_d[l_ac].pmdn043,g_pmdl2_d[l_ac].pmdn046,g_pmdl2_d[l_ac].pmdn048, 
          g_pmdl2_d[l_ac].pmdn047,g_pmdl2_d[l_ac].pmdnunit,g_pmdl2_d[l_ac].pmdnunit_desc,g_pmdl2_d[l_ac].pmdn225, 
          g_pmdl2_d[l_ac].pmdn225_desc,g_pmdl2_d[l_ac].pmdn203,g_pmdl2_d[l_ac].pmdn203_desc,g_pmdl2_d[l_ac].pmdn025, 
          g_pmdl2_d[l_ac].pmdn025_desc,g_pmdl2_d[l_ac].l_pmdn025_addr,g_pmdl2_d[l_ac].pmdn028,g_pmdl2_d[l_ac].pmdn028_desc, 
          g_pmdl2_d[l_ac].pmdn029,g_pmdl2_d[l_ac].pmdn029_desc,g_pmdl2_d[l_ac].pmdn030,g_pmdl2_d[l_ac].pmdn053, 
          g_pmdl2_d[l_ac].pmdnorga,g_pmdl2_d[l_ac].pmdnorga_desc,g_pmdl2_d[l_ac].pmdn026,g_pmdl2_d[l_ac].pmdn026_desc, 
          g_pmdl2_d[l_ac].l_pmdn026_addr,g_pmdl2_d[l_ac].pmdn024,g_pmdl2_d[l_ac].pmdn014,g_pmdl2_d[l_ac].pmdn012, 
          g_pmdl2_d[l_ac].pmdn013,g_pmdl2_d[l_ac].pmdn022,g_pmdl2_d[l_ac].pmdn023,g_pmdl2_d[l_ac].pmdn023_desc, 
          g_pmdl2_d[l_ac].pmdn045,g_pmdl2_d[l_ac].pmdn206,g_pmdl2_d[l_ac].pmdn207,g_pmdl2_d[l_ac].pmdn208, 
          g_pmdl2_d[l_ac].pmdn209,g_pmdl2_d[l_ac].pmdn210,g_pmdl2_d[l_ac].pmdn211,g_pmdl2_d[l_ac].pmdn212, 
          g_pmdl2_d[l_ac].pmdn213,g_pmdl2_d[l_ac].pmdn019,g_pmdl2_d[l_ac].pmdn020,g_pmdl2_d[l_ac].pmdn224, 
          g_pmdl2_d[l_ac].pmdn052,g_pmdl2_d[l_ac].pmdn049,g_pmdl2_d[l_ac].pmdn049_desc,g_pmdl2_d[l_ac].pmdn051, 
          g_pmdl2_d[l_ac].pmdn051_desc,g_pmdl2_d[l_ac].pmdn205,g_pmdl2_d[l_ac].pmdn205_desc,g_pmdl2_d[l_ac].pmdn214, 
          g_pmdl2_d[l_ac].pmdn214_desc,g_pmdl2_d[l_ac].pmdn215,g_pmdl2_d[l_ac].pmdn216,g_pmdl2_d[l_ac].pmdn217, 
          g_pmdl2_d[l_ac].pmdn217_desc,g_pmdl2_d[l_ac].pmdn218,g_pmdl2_d[l_ac].pmdn219,g_pmdl2_d[l_ac].pmdn220, 
          g_pmdl2_d[l_ac].pmdn220_desc,g_pmdl2_d[l_ac].pmdn221,g_pmdl2_d[l_ac].pmdn221_desc,g_pmdl2_d[l_ac].pmdn222, 
          g_pmdl2_d[l_ac].pmdn222_desc,g_pmdl2_d[l_ac].pmdn223,g_pmdl2_d[l_ac].pmdn223_desc,g_pmdl2_d[l_ac].pmdn050 
 
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      #產品特徵說明
      CALL s_feature_description(g_pmdl2_d[l_ac].pmdn001,g_pmdl2_d[l_ac].pmdn002) RETURNING l_success,g_pmdl2_d[l_ac].pmdn002_desc
      #150826-00013# 20160308 mark by beckxie---S
      ##稅別
      #CALL s_desc_get_tax_desc1(g_pmdl2_d[l_ac].pmdnsite,g_pmdl2_d[l_ac].pmdn016) RETURNING g_pmdl2_d[l_ac].pmdn016_desc
      #150826-00013# 20160308 mark by beckxie---E
      #出貨地址
      IF g_pmdl_d[g_detail_idx].pmdl203 = '3' THEN
         LET l_ooef001 = g_pmdl2_d[l_ac].pmdn223
      ELSE
         LET l_ooef001 = g_pmdl2_d[l_ac].pmdnunit
      END IF
      CALL s_apmt840_address_ref('3',g_pmdl2_d[l_ac].pmdn025,l_ooef001)
         RETURNING g_pmdl2_d[l_ac].pmdn025_desc,g_pmdl2_d[l_ac].l_pmdn025_addr
      
      #帳款地址
      CALL s_apmt840_address_ref('5',g_pmdl2_d[l_ac].pmdn026,g_pmdl2_d[l_ac].pmdnorga)
         RETURNING g_pmdl2_d[l_ac].pmdn026_desc,g_pmdl2_d[l_ac].l_pmdn026_addr
      #160420-00039#19 160516 by sakura mark(S)
      ##出貨儲位
      #CALL s_desc_get_locator_desc(g_pmdl2_d[l_ac].pmdnunit,g_pmdl2_d[l_ac].pmdn028,g_pmdl2_d[l_ac].pmdn029)
      #   RETURNING g_pmdl2_d[l_ac].pmdn029_desc
      #160420-00039#19 160516 by sakura mark(E)
      
      #150826-00013# 20160308 mark by beckxie---S
      ##理由碼
      #LET l_acc = ''
      #CALL apmq840_get_gzcb004() RETURNING l_acc
      #CALL s_desc_get_acc_desc(l_acc,g_pmdl2_d[l_ac].pmdn049) RETURNING g_pmdl2_d[l_ac].pmdn049_desc
      #   
      ##結案理由碼
      #CALL s_desc_get_acc_desc(l_acc,g_pmdl2_d[l_ac].pmdn051) RETURNING g_pmdl2_d[l_ac].pmdn051_desc
      #150826-00013# 20160308 add by beckxie---E
      #end add-point
 
      CALL apmq840_detail_show("'2'")
 
      CALL apmq840_pmdn_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table3
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE pmdosite,pmdoseq,pmdoseq1,pmdoseq2,pmdo003,pmdo001,'','',pmdo002,pmdo005, 
          '',pmdo200,'',pmdo201,pmdo004,'',pmdo006,pmdo028,'',pmdo029,pmdo013,pmdo011,pmdo012,pmdo010, 
          '',pmdo009,pmdo015,pmdo016,pmdo017,pmdo040,pmdo019,pmdo021,pmdo030,'',pmdo031,pmdo022,pmdo023, 
          '',pmdo024,pmdo032,pmdo033,pmdo034,pmdo025,pmdo026,'',pmdo027 FROM pmdo_t",
                  "",
                  " WHERE pmdoent=? AND pmdodocno=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdo_t.pmdoseq,pmdo_t.pmdoseq1,pmdo_t.pmdoseq2"
  
      #add-point:單身填充前 name="b_fill2.before_fill3"
      LET g_sql = "SELECT  UNIQUE pmdosite,pmdoseq,pmdoseq1,pmdoseq2,pmdo003,pmdo001,t21.imaal003,t21.imaal004,pmdo002,pmdo005,", 
                  "        '',pmdo200,t23.oocal003,pmdo201,pmdo004,t24.oocal003,pmdo006,pmdo028,t25.oocal003,pmdo029,pmdo013,pmdo011,pmdo012,pmdo010, ",
                  "        t26.oocql004,pmdo009,pmdo015,pmdo016,pmdo017,pmdo040,pmdo019,pmdo021,pmdo030,t27.oocal003,pmdo031,pmdo022,pmdo023, ",
                  "        '',pmdo024,pmdo032,pmdo033,pmdo034,pmdo025,pmdo026,t28.ooag011,pmdo027 ",
		            " FROM pmdo_t",
                  " LEFT JOIN imaal_t t21 ON t21.imaalent='"||g_enterprise||"' AND t21.imaal001=pmdo001 AND t21.imaal002='"||g_dlang||"' ",
                  " LEFT JOIN imaal_t t22 ON t22.imaalent='"||g_enterprise||"' AND t22.imaal001=pmdo001 AND t22.imaal002='"||g_dlang||"' ",
                  " LEFT JOIN oocal_t t23 ON t23.oocalent='"||g_enterprise||"' AND t23.oocal001=pmdo200 AND t23.oocal002='"||g_dlang||"' ",
                  " LEFT JOIN oocal_t t24 ON t24.oocalent='"||g_enterprise||"' AND t24.oocal001=pmdo004 AND t24.oocal002='"||g_dlang||"' ",
                  " LEFT JOIN oocal_t t25 ON t25.oocalent='"||g_enterprise||"' AND t25.oocal001=pmdo028 AND t25.oocal002='"||g_dlang||"' ",
                  " LEFT JOIN oocql_t t26 ON t26.oocqlent='"||g_enterprise||"' AND t26.oocql001='274' AND t26.oocql002=pmdo010 AND t26.oocql003='"||g_dlang||"' ",
                  " LEFT JOIN oocal_t t27 ON t27.oocalent='"||g_enterprise||"' AND t27.oocal001=pmdo030 AND t27.oocal002='"||g_dlang||"' ",
                  " LEFT JOIN ooag_t t28 ON t28.ooagent='"||g_enterprise||"' AND t28.ooag001=pmdo026  ",				  
                  " WHERE pmdoent=? AND pmdodocno=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdo_t.pmdoseq,pmdo_t.pmdoseq1,pmdo_t.pmdoseq2"
      #交期頁籤
      LET l_sql = "SELECT pmdn014",
                  "  FROM pmdn_t",
                  " WHERE pmdnent = ",g_enterprise,
                  "   AND pmdndocno = '",g_pmdl_d[g_detail_idx].pmdldocno,"'",
                  "   AND pmdnseq = ?"
      PREPARE apmq840_pre1 FROM l_sql      
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq840_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR apmq840_pb3
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs3 USING g_enterprise,g_pmdl_d[g_detail_idx].pmdldocno
 
   LET l_ac = 1
   FOREACH b_fill_curs3
      USING g_enterprise,g_pmdl_d[g_detail_idx].pmdldocno
 
      INTO g_pmdl3_d[l_ac].pmdosite,g_pmdl3_d[l_ac].pmdoseq,g_pmdl3_d[l_ac].pmdoseq1,g_pmdl3_d[l_ac].pmdoseq2, 
          g_pmdl3_d[l_ac].pmdo003,g_pmdl3_d[l_ac].pmdo001,g_pmdl3_d[l_ac].pmdo001_desc,g_pmdl3_d[l_ac].pmdo001_desc_desc, 
          g_pmdl3_d[l_ac].pmdo002,g_pmdl3_d[l_ac].pmdo005,g_pmdl3_d[l_ac].pmdn0141,g_pmdl3_d[l_ac].pmdo200, 
          g_pmdl3_d[l_ac].pmdo200_desc,g_pmdl3_d[l_ac].pmdo201,g_pmdl3_d[l_ac].pmdo004,g_pmdl3_d[l_ac].pmdo004_desc, 
          g_pmdl3_d[l_ac].pmdo006,g_pmdl3_d[l_ac].pmdo028,g_pmdl3_d[l_ac].pmdo028_desc,g_pmdl3_d[l_ac].pmdo029, 
          g_pmdl3_d[l_ac].pmdo013,g_pmdl3_d[l_ac].pmdo011,g_pmdl3_d[l_ac].pmdo012,g_pmdl3_d[l_ac].pmdo010, 
          g_pmdl3_d[l_ac].pmdo010_desc,g_pmdl3_d[l_ac].pmdo009,g_pmdl3_d[l_ac].pmdo015,g_pmdl3_d[l_ac].pmdo016, 
          g_pmdl3_d[l_ac].pmdo017,g_pmdl3_d[l_ac].pmdo040,g_pmdl3_d[l_ac].pmdo019,g_pmdl3_d[l_ac].pmdo021, 
          g_pmdl3_d[l_ac].pmdo030,g_pmdl3_d[l_ac].pmdo030_desc,g_pmdl3_d[l_ac].pmdo031,g_pmdl3_d[l_ac].pmdo022, 
          g_pmdl3_d[l_ac].pmdo023,g_pmdl3_d[l_ac].pmdo023_desc,g_pmdl3_d[l_ac].pmdo024,g_pmdl3_d[l_ac].pmdo032, 
          g_pmdl3_d[l_ac].pmdo033,g_pmdl3_d[l_ac].pmdo034,g_pmdl3_d[l_ac].pmdo025,g_pmdl3_d[l_ac].pmdo026, 
          g_pmdl3_d[l_ac].pmdo026_desc,g_pmdl3_d[l_ac].pmdo027
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill3"
      #採購明細資料
      EXECUTE apmq840_pre1 USING g_pmdl3_d[l_ac].pmdoseq
         INTO g_pmdl3_d[l_ac].pmdn0141
      
      #稅別
      CALL s_desc_get_tax_desc1(g_pmdl3_d[l_ac].pmdosite,g_pmdl3_d[l_ac].pmdo023)
         RETURNING g_pmdl3_d[l_ac].pmdo023_desc
      #end add-point
 
      CALL apmq840_detail_show("'3'")
 
      CALL apmq840_pmdo_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table4
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE xrcdsite,xrcdld,xrcdseq,xrcd007,'','','','','','',xrcd002,'',xrcdseq2, 
          xrcd003,xrcd006,xrcd004,xrcd104 FROM xrcd_t",
                  "",
                  " WHERE xrcdent=? AND xrcddocno=?"
  
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY xrcd_t.xrcdld,xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007"
  
      #add-point:單身填充前 name="b_fill2.before_fill4"
      #交易稅頁籤
      LET l_sql = "SELECT pmdn200,pmdn001,pmdn002,imaal003,imaal004",
                  "  FROM pmdn_t",
                  "  LEFT OUTER JOIN imaal_t ON imaalent = pmdnent AND imaal001 = pmdn001 AND imaal002 = '",g_dlang,"'",
                  " WHERE pmdnent = ",g_enterprise,
                  "   AND pmdndocno = '",g_pmdl_d[g_detail_idx].pmdldocno,"'",
                  "   AND pmdnseq = ?"
      PREPARE apmq840_pre2 FROM l_sql
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq840_pb4 FROM g_sql
      DECLARE b_fill_curs4 CURSOR FOR apmq840_pb4
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs4 USING g_enterprise,g_pmdl_d[g_detail_idx].pmdldocno
 
   LET l_ac = 1
   FOREACH b_fill_curs4
      USING g_enterprise,g_pmdl_d[g_detail_idx].pmdldocno
 
      INTO g_pmdl4_d[l_ac].xrcdsite,g_pmdl4_d[l_ac].xrcdld,g_pmdl4_d[l_ac].xrcdseq,g_pmdl4_d[l_ac].xrcd007, 
          g_pmdl4_d[l_ac].pmdn2001,g_pmdl4_d[l_ac].pmdn0011,g_pmdl4_d[l_ac].pmdn0011_desc,g_pmdl4_d[l_ac].pmdn0011_desc_desc, 
          g_pmdl4_d[l_ac].pmdn0021,g_pmdl4_d[l_ac].pmdn0021_desc,g_pmdl4_d[l_ac].xrcd002,g_pmdl4_d[l_ac].xrcd002_desc, 
          g_pmdl4_d[l_ac].xrcdseq2,g_pmdl4_d[l_ac].xrcd003,g_pmdl4_d[l_ac].xrcd006,g_pmdl4_d[l_ac].xrcd004, 
          g_pmdl4_d[l_ac].xrcd104
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill4"
      #採購明細資料
      EXECUTE apmq840_pre2 USING g_pmdl4_d[l_ac].xrcdseq
         INTO g_pmdl4_d[l_ac].pmdn2001,g_pmdl4_d[l_ac].pmdn0011,g_pmdl4_d[l_ac].pmdn0021,
              g_pmdl4_d[l_ac].pmdn0011_desc,g_pmdl4_d[l_ac].pmdn0011_desc_desc
               
      #產品特徵說明
      CALL s_feature_description(g_pmdl4_d[l_ac].pmdn0011,g_pmdl4_d[l_ac].pmdn0021)
         RETURNING l_success,g_pmdl4_d[l_ac].pmdn0021_desc
      
      #稅別
      CALL s_desc_get_tax_desc1(g_pmdl4_d[l_ac].xrcdsite,g_pmdl4_d[l_ac].xrcd002)
         RETURNING g_pmdl4_d[l_ac].xrcd002_desc
      #end add-point
 
      CALL apmq840_detail_show("'4'")
 
      CALL apmq840_xrcd_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_pmdl2_d.deleteElement(g_pmdl2_d.getLength())
#Page3
   CALL g_pmdl3_d.deleteElement(g_pmdl3_d.getLength())
#Page4
   CALL g_pmdl4_d.deleteElement(g_pmdl4_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_pmdl2_d.getLength()
#Page3
   LET li_ac = g_pmdl3_d.getLength()
#Page4
   LET li_ac = g_pmdl4_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apmq840.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq840_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq840.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq840_filter()
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
      CONSTRUCT g_wc_filter ON pmdlsite,pmdldocno,pmdldocdt,pmdl004,pmdl021,pmdl002,pmdl003,pmdl203, 
          pmdl200,pmdl204,pmdl023
                          FROM s_detail1[1].b_pmdlsite,s_detail1[1].b_pmdldocno,s_detail1[1].b_pmdldocdt, 
                              s_detail1[1].b_pmdl004,s_detail1[1].b_pmdl021,s_detail1[1].b_pmdl002,s_detail1[1].b_pmdl003, 
                              s_detail1[1].b_pmdl203,s_detail1[1].b_pmdl200,s_detail1[1].b_pmdl204,s_detail1[1].b_pmdl023 
 
 
         BEFORE CONSTRUCT
                     DISPLAY apmq840_filter_parser('pmdlsite') TO s_detail1[1].b_pmdlsite
            DISPLAY apmq840_filter_parser('pmdldocno') TO s_detail1[1].b_pmdldocno
            DISPLAY apmq840_filter_parser('pmdldocdt') TO s_detail1[1].b_pmdldocdt
            DISPLAY apmq840_filter_parser('pmdl004') TO s_detail1[1].b_pmdl004
            DISPLAY apmq840_filter_parser('pmdl021') TO s_detail1[1].b_pmdl021
            DISPLAY apmq840_filter_parser('pmdl002') TO s_detail1[1].b_pmdl002
            DISPLAY apmq840_filter_parser('pmdl003') TO s_detail1[1].b_pmdl003
            DISPLAY apmq840_filter_parser('pmdl203') TO s_detail1[1].b_pmdl203
            DISPLAY apmq840_filter_parser('pmdl200') TO s_detail1[1].b_pmdl200
            DISPLAY apmq840_filter_parser('pmdl204') TO s_detail1[1].b_pmdl204
            DISPLAY apmq840_filter_parser('pmdl023') TO s_detail1[1].b_pmdl023
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmdlsite>>----
         #Ctrlp:construct.c.page1.b_pmdlsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdlsite
            #add-point:ON ACTION controlp INFIELD b_pmdlsite name="construct.c.filter.page1.b_pmdlsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdlsite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_pmdlsite
            NEXT FIELD b_pmdlsite
            #END add-point
 
 
         #----<<b_pmdlsite_desc>>----
         #----<<b_pmdldocno>>----
         #Ctrlp:construct.c.page1.b_pmdldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdldocno
            #add-point:ON ACTION controlp INFIELD b_pmdldocno name="construct.c.filter.page1.b_pmdldocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()
            DISPLAY g_qryparam.return1 TO b_pmdldocno
            NEXT FIELD b_pmdldocno
            #END add-point
 
 
         #----<<b_pmdldocdt>>----
         #Ctrlp:construct.c.filter.page1.b_pmdldocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdldocdt
            #add-point:ON ACTION controlp INFIELD b_pmdldocdt name="construct.c.filter.page1.b_pmdldocdt"
            
            #END add-point
 
 
         #----<<b_pmdl004>>----
         #Ctrlp:construct.c.page1.b_pmdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl004
            #add-point:ON ACTION controlp INFIELD b_pmdl004 name="construct.c.filter.page1.b_pmdl004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdl004  #顯示到畫面上
            NEXT FIELD b_pmdl004                     #返回原欄位
            #END add-point
 
 
         #----<<b_pmdl004_desc>>----
         #----<<b_pmdl021>>----
         #Ctrlp:construct.c.page1.b_pmdl021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl021
            #add-point:ON ACTION controlp INFIELD b_pmdl021 name="construct.c.filter.page1.b_pmdl021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmac003 = '1'"
            CALL q_pmac002_2()
            DISPLAY g_qryparam.return1 TO b_pmdl021
            NEXT FIELD b_pmdl021
            #END add-point
 
 
         #----<<b_pmdl021_desc>>----
         #----<<b_pmdl002>>----
         #Ctrlp:construct.c.page1.b_pmdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl002
            #add-point:ON ACTION controlp INFIELD b_pmdl002 name="construct.c.filter.page1.b_pmdl002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdl002  #顯示到畫面上
            NEXT FIELD b_pmdl002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdl002_desc>>----
         #----<<b_pmdl003>>----
         #Ctrlp:construct.c.page1.b_pmdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl003
            #add-point:ON ACTION controlp INFIELD b_pmdl003 name="construct.c.filter.page1.b_pmdl003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdl003  #顯示到畫面上
            NEXT FIELD b_pmdl003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdl003_desc>>----
         #----<<b_pmdl203>>----
         #Ctrlp:construct.c.filter.page1.b_pmdl203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl203
            #add-point:ON ACTION controlp INFIELD b_pmdl203 name="construct.c.filter.page1.b_pmdl203"
            
            #END add-point
 
 
         #----<<b_pmdl200>>----
         #Ctrlp:construct.c.filter.page1.b_pmdl200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl200
            #add-point:ON ACTION controlp INFIELD b_pmdl200 name="construct.c.filter.page1.b_pmdl200"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdl200') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdl200',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef303 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_pmdl200
            NEXT FIELD b_pmdl200
            #END add-point
 
 
         #----<<b_pmdl200_desc>>----
         #----<<b_pmdl204>>----
         #Ctrlp:construct.c.filter.page1.b_pmdl204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl204
            #add-point:ON ACTION controlp INFIELD b_pmdl204 name="construct.c.filter.page1.b_pmdl204"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'pmdl204') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdl204',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef302 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_pmdl204
            NEXT FIELD b_pmdl204
            #END add-point
 
 
         #----<<b_pmdl204_desc>>----
         #----<<b_pmdl023>>----
         #Ctrlp:construct.c.page1.b_pmdl023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdl023
            #add-point:ON ACTION controlp INFIELD b_pmdl023 name="construct.c.filter.page1.b_pmdl023"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2"
            CALL q_oojd001_1()
            DISPLAY g_qryparam.return1 TO b_pmdl023
            NEXT FIELD b_pmdl023
            #END add-point
 
 
         #----<<b_pmdl023_desc>>----
 
 
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
 
      CALL apmq840_filter_show('pmdlsite','b_pmdlsite')
   CALL apmq840_filter_show('pmdldocno','b_pmdldocno')
   CALL apmq840_filter_show('pmdldocdt','b_pmdldocdt')
   CALL apmq840_filter_show('pmdl004','b_pmdl004')
   CALL apmq840_filter_show('pmdl021','b_pmdl021')
   CALL apmq840_filter_show('pmdl002','b_pmdl002')
   CALL apmq840_filter_show('pmdl003','b_pmdl003')
   CALL apmq840_filter_show('pmdl203','b_pmdl203')
   CALL apmq840_filter_show('pmdl200','b_pmdl200')
   CALL apmq840_filter_show('pmdl204','b_pmdl204')
   CALL apmq840_filter_show('pmdl023','b_pmdl023')
   CALL apmq840_filter_show('pmdnseq','b_pmdnseq')
   CALL apmq840_filter_show('pmdnsite','b_pmdnsite')
   CALL apmq840_filter_show('pmdn200','b_pmdn200')
   CALL apmq840_filter_show('pmdn001','b_pmdn001')
   CALL apmq840_filter_show('pmdn002','b_pmdn002')
   CALL apmq840_filter_show('pmdn016','b_pmdn016')
   CALL apmq840_filter_show('pmdn017','b_pmdn017')
   CALL apmq840_filter_show('pmdn201','b_pmdn201')
   CALL apmq840_filter_show('pmdn202','b_pmdn202')
   CALL apmq840_filter_show('pmdn006','b_pmdn006')
   CALL apmq840_filter_show('pmdn007','b_pmdn007')
   CALL apmq840_filter_show('pmdn008','b_pmdn008')
   CALL apmq840_filter_show('pmdn009','b_pmdn009')
   CALL apmq840_filter_show('pmdn010','b_pmdn010')
   CALL apmq840_filter_show('pmdn011','b_pmdn011')
   CALL apmq840_filter_show('pmdn015','b_pmdn015')
   CALL apmq840_filter_show('pmdn043','b_pmdn043')
   CALL apmq840_filter_show('pmdn046','b_pmdn046')
   CALL apmq840_filter_show('pmdn048','b_pmdn048')
   CALL apmq840_filter_show('pmdn047','b_pmdn047')
   CALL apmq840_filter_show('pmdnunit','b_pmdnunit')
   CALL apmq840_filter_show('pmdn225','b_pmdn225')
   CALL apmq840_filter_show('pmdn203','b_pmdn203')
   CALL apmq840_filter_show('pmdn025','b_pmdn025')
   CALL apmq840_filter_show('pmdn028','b_pmdn028')
   CALL apmq840_filter_show('pmdn029','b_pmdn029')
   CALL apmq840_filter_show('pmdn030','b_pmdn030')
   CALL apmq840_filter_show('pmdn053','b_pmdn053')
   CALL apmq840_filter_show('pmdnorga','b_pmdnorga')
   CALL apmq840_filter_show('pmdn026','b_pmdn026')
   CALL apmq840_filter_show('pmdn024','b_pmdn024')
   CALL apmq840_filter_show('pmdn014','b_pmdn014')
   CALL apmq840_filter_show('pmdn012','b_pmdn012')
   CALL apmq840_filter_show('pmdn013','b_pmdn013')
   CALL apmq840_filter_show('pmdn022','b_pmdn022')
   CALL apmq840_filter_show('pmdn023','b_pmdn023')
   CALL apmq840_filter_show('pmdn045','b_pmdn045')
   CALL apmq840_filter_show('pmdn206','b_pmdn206')
   CALL apmq840_filter_show('pmdn207','b_pmdn207')
   CALL apmq840_filter_show('pmdn208','b_pmdn208')
   CALL apmq840_filter_show('pmdn209','b_pmdn209')
   CALL apmq840_filter_show('pmdn210','b_pmdn210')
   CALL apmq840_filter_show('pmdn211','b_pmdn211')
   CALL apmq840_filter_show('pmdn212','b_pmdn212')
   CALL apmq840_filter_show('pmdn213','b_pmdn213')
   CALL apmq840_filter_show('pmdn019','b_pmdn019')
   CALL apmq840_filter_show('pmdn020','b_pmdn020')
   CALL apmq840_filter_show('pmdn224','b_pmdn224')
   CALL apmq840_filter_show('pmdn052','b_pmdn052')
   CALL apmq840_filter_show('pmdn049','b_pmdn049')
   CALL apmq840_filter_show('pmdn051','b_pmdn051')
   CALL apmq840_filter_show('pmdn205','b_pmdn205')
   CALL apmq840_filter_show('pmdn214','b_pmdn214')
   CALL apmq840_filter_show('pmdn215','b_pmdn215')
   CALL apmq840_filter_show('pmdn216','b_pmdn216')
   CALL apmq840_filter_show('pmdn217','b_pmdn217')
   CALL apmq840_filter_show('pmdn218','b_pmdn218')
   CALL apmq840_filter_show('pmdn219','b_pmdn219')
   CALL apmq840_filter_show('pmdn220','b_pmdn220')
   CALL apmq840_filter_show('pmdn221','b_pmdn221')
   CALL apmq840_filter_show('pmdn222','b_pmdn222')
   CALL apmq840_filter_show('pmdn223','b_pmdn223')
   CALL apmq840_filter_show('pmdn050','b_pmdn050')
   CALL apmq840_filter_show('pmdosite','b_pmdosite')
   CALL apmq840_filter_show('pmdoseq','b_pmdoseq')
   CALL apmq840_filter_show('pmdoseq1','b_pmdoseq1')
   CALL apmq840_filter_show('pmdoseq2','b_pmdoseq2')
   CALL apmq840_filter_show('pmdo003','b_pmdo003')
   CALL apmq840_filter_show('pmdo001','b_pmdo001')
   CALL apmq840_filter_show('pmdo002','b_pmdo002')
   CALL apmq840_filter_show('pmdo005','b_pmdo005')
   CALL apmq840_filter_show('pmdo200','b_pmdo200')
   CALL apmq840_filter_show('pmdo201','b_pmdo201')
   CALL apmq840_filter_show('pmdo004','b_pmdo004')
   CALL apmq840_filter_show('pmdo006','b_pmdo006')
   CALL apmq840_filter_show('pmdo028','b_pmdo028')
   CALL apmq840_filter_show('pmdo029','b_pmdo029')
   CALL apmq840_filter_show('pmdo013','b_pmdo013')
   CALL apmq840_filter_show('pmdo011','b_pmdo011')
   CALL apmq840_filter_show('pmdo012','b_pmdo012')
   CALL apmq840_filter_show('pmdo010','b_pmdo010')
   CALL apmq840_filter_show('pmdo009','b_pmdo009')
   CALL apmq840_filter_show('pmdo015','b_pmdo015')
   CALL apmq840_filter_show('pmdo016','b_pmdo016')
   CALL apmq840_filter_show('pmdo017','b_pmdo017')
   CALL apmq840_filter_show('pmdo040','b_pmdo040')
   CALL apmq840_filter_show('pmdo019','b_pmdo019')
   CALL apmq840_filter_show('pmdo021','b_pmdo021')
   CALL apmq840_filter_show('pmdo030','b_pmdo030')
   CALL apmq840_filter_show('pmdo031','b_pmdo031')
   CALL apmq840_filter_show('pmdo022','b_pmdo022')
   CALL apmq840_filter_show('pmdo023','b_pmdo023')
   CALL apmq840_filter_show('pmdo024','b_pmdo024')
   CALL apmq840_filter_show('pmdo032','b_pmdo032')
   CALL apmq840_filter_show('pmdo033','b_pmdo033')
   CALL apmq840_filter_show('pmdo034','b_pmdo034')
   CALL apmq840_filter_show('pmdo025','b_pmdo025')
   CALL apmq840_filter_show('pmdo026','b_pmdo026')
   CALL apmq840_filter_show('pmdo027','b_pmdo027')
   CALL apmq840_filter_show('xrcdsite','b_xrcdsite')
   CALL apmq840_filter_show('xrcdld','b_xrcdld')
   CALL apmq840_filter_show('xrcdseq','b_xrcdseq')
   CALL apmq840_filter_show('xrcd007','b_xrcd007')
   CALL apmq840_filter_show('xrcd002','b_xrcd002')
   CALL apmq840_filter_show('xrcdseq2','b_xrcdseq2')
   CALL apmq840_filter_show('xrcd003','b_xrcd003')
   CALL apmq840_filter_show('xrcd006','b_xrcd006')
   CALL apmq840_filter_show('xrcd004','b_xrcd004')
   CALL apmq840_filter_show('xrcd104','b_xrcd104')
 
 
   CALL apmq840_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq840.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq840_filter_parser(ps_field)
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
 
{<section id="apmq840.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq840_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq840_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq840.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq840_detail_action_trans()
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
 
{<section id="apmq840.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq840_detail_index_setting()
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
            IF g_pmdl_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmdl_d.getLength() AND g_pmdl_d.getLength() > 0
            LET g_detail_idx = g_pmdl_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmdl_d.getLength() THEN
               LET g_detail_idx = g_pmdl_d.getLength()
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
 
{<section id="apmq840.mask_functions" >}
 &include "erp/apm/apmq840_mask.4gl"
 
{</section>}
 
{<section id="apmq840.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取理由碼 SCC
# Memo...........:
# Usage..........: CALL apmq840_get_gzcb004()
#                    RETURNING r_gzcb004
# Input parameter: 無
# Return code....: r_gzcb004      SCC代碼
# Date & Author..: 2015/04/03 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq840_get_gzcb004()
DEFINE r_gzcb004        LIKE gzcb_t.gzcb004

   LET r_gzcb004 = ''
   #SELECT gzcb004 INTO r_gzcb004  FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'apmt840'   #160816-00001#7 mark
   LET r_gzcb004 = s_fin_get_scc_value('24','apmt840','2')  #160816-00001#7  Add 
      
   RETURN r_gzcb004
END FUNCTION

 
{</section>}
 
