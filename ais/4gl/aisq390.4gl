#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq390.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-07-06 17:27:10), PR版次:0004(2016-10-26 13:55:20)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: aisq390
#+ Description: 門店日結對帳單查詢作業
#+ Creator....: 06821(2016-07-06 14:16:27)
#+ Modifier...: 06821 -SD/PR- 08171
 
{</section>}
 
{<section id="aisq390.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160920-00019#5  2016/09/20 By 08732      交易對象開窗調整為q_pmaa001_13
#161006-00005#27 2016/10/24 By Reanna     帳務中心(isafsite)開窗改用q_ooef001_46()/業務組織(isaf004)開窗改用q_ooeg001_4
#161017-00005#1  2016/10/26 By 08171      業務組織開窗根據aooi125法人底下的部門
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
PRIVATE TYPE type_g_isaf_d RECORD
       
       isafsite LIKE isaf_t.isafsite, 
   isafcomp LIKE isaf_t.isafcomp, 
   isafdocno LIKE isaf_t.isafdocno, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isaf003 LIKE isaf_t.isaf003, 
   isaf003_desc LIKE type_t.chr500, 
   isaf004 LIKE isaf_t.isaf004, 
   isaf004_desc LIKE type_t.chr500, 
   isaf057 LIKE isaf_t.isaf057, 
   isaf057_desc LIKE type_t.chr500, 
   isaf103 LIKE isaf_t.isaf103, 
   isaf104 LIKE isaf_t.isaf104, 
   isaf105 LIKE isaf_t.isaf105, 
   isaf113 LIKE isaf_t.isaf113, 
   isaf114 LIKE isaf_t.isaf114, 
   isaf115 LIKE isaf_t.isaf115
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單頭INPUT
TYPE type_g_input    RECORD
       isafsite      LIKE isaf_t.isafsite,
       isafsite_desc LIKE type_t.chr500,
       isafcomp      LIKE isaf_t.isafcomp,
       isafcomp_desc LIKE type_t.chr500
                     END RECORD
DEFINE g_input       type_g_input 
#立帳來源明細
TYPE type_g_isag_d2    RECORD 
        isagseq        LIKE isag_t.isagseq,
        isagorga       LIKE isag_t.isagorga,
        isagorga_desc  LIKE ooefl_t.ooefl003,
        isag001        LIKE isag_t.isag001,
        isag002        LIKE isag_t.isag002,
        isag003        LIKE isag_t.isag003,
        isag009        LIKE isag_t.isag009,
        isag010        LIKE isag_t.isag010,
        imaal004       LIKE imaal_t.imaal004,
        isag016        LIKE isag_t.isag016,
        isag017        LIKE isag_t.isag017,
        isag015        LIKE isag_t.isag015,
        inag009        LIKE inag_t.inag009,
        xmdl047        LIKE xmdl_t.xmdl047,
        inag007        LIKE inag_t.inag007,
        inag007_desc   LIKE type_t.chr100,
        isag006        LIKE isag_t.isag006,
        isag008        LIKE isag_t.isag008,
        isag012        LIKE isag_t.isag012,
        isag004        LIKE isag_t.isag004,
        isag005        LIKE isag_t.isag005,
        isag005_desc   LIKE type_t.chr100,
        isag101        LIKE isag_t.isag101,
        isag103        LIKE isag_t.isag103,
        isag104        LIKE isag_t.isag104,
        isag105        LIKE isag_t.isag105,
        isag113        LIKE isag_t.isag113,
        isag114        LIKE isag_t.isag114,
        isag115        LIKE isag_t.isag115,
        isag116        LIKE isag_t.isag116,
        isag117        LIKE isag_t.isag117,
        isag013        LIKE isag_t.isag013,
        isag014        LIKE isag_t.isag014,
        isag011        LIKE isag_t.isag011     
                       END RECORD
#發票明細
TYPE type_g_isah_d3    RECORD
        isahseq        LIKE isah_t.isahseq,
        isahorga       LIKE isah_t.isahorga,
        isahorga_desc  LIKE ooefl_t.ooefl003,
        isah003        LIKE isah_t.isah003,
        isah004        LIKE isah_t.isah004,
        isah013        LIKE isah_t.isah013,
        isah005        LIKE isah_t.isah005,
        isah005_desc   LIKE type_t.chr100,
        isah010        LIKE isah_t.isah010,
        isah006        LIKE isah_t.isah006,
        isah101        LIKE isah_t.isah101,
        isah103        LIKE isah_t.isah103,
        isah007        LIKE isah_t.isah007,
        isah104        LIKE isah_t.isah104,
        isah105        LIKE isah_t.isah105,
        isah113        LIKE isah_t.isah113,
        isah114        LIKE isah_t.isah114,
        isah115        LIKE isah_t.isah115,
        isah001        LIKE isah_t.isah001,
        isah002        LIKE isah_t.isah002,
        isah008        LIKE isah_t.isah008,
        isah009        LIKE isah_t.isah009,
        isah011        LIKE isah_t.isah011,
        isah106        LIKE isah_t.isah106,
        isah012        LIKE isah_t.isah012,
        isah116        LIKE isah_t.isah116
                       END RECORD
#交易稅明細                 
TYPE type_g_xrcd_d4    RECORD
        xrcdld         LIKE xrcd_t.xrcdld,
        xrcdseq2       LIKE xrcd_t.xrcdseq2,
        xrcdseq        LIKE xrcd_t.xrcdseq, 
        xrcd007        LIKE xrcd_t.xrcd007, 
        xrcd002        LIKE xrcd_t.xrcd002, 
        xrcd002_desc   LIKE type_t.chr100,
        xrcd003        LIKE xrcd_t.xrcd003,
        xrcd006        LIKE xrcd_t.xrcd006,
        xrcd005        LIKE xrcd_t.xrcd005,
        xrcd104        LIKE xrcd_t.xrcd104,
        xrcd103        LIKE xrcd_t.xrcd103,
        xrcd105        LIKE xrcd_t.xrcd105,
        xrcd114        LIKE xrcd_t.xrcd114     
                       END RECORD
#發票歷程檔               
TYPE type_g_isat_d5    RECORD
        isatseq        LIKE isat_t.isatseq,
        isat003        LIKE isat_t.isat003,
        isat004        LIKE isat_t.isat004,
        isat027        LIKE isat_t.isat027,
        isat006        LIKE isat_t.isat006,
        isat002        LIKE isat_t.isat002,
        isat103        LIKE isat_t.isat103,
        isat104        LIKE isat_t.isat104,
        isat105        LIKE isat_t.isat105,
        isat113        LIKE isat_t.isat113,
        isat114        LIKE isat_t.isat114,
        isat115        LIKE isat_t.isat115,
        isat007        LIKE isat_t.isat007,
        isat014        LIKE isat_t.isat014,
        isat106        LIKE isat_t.isat106,
        isat107        LIKE isat_t.isat107,
        isat017        LIKE isat_t.isat017,
        isatsite       LIKE isat_t.isatsite,
        isatdocdt      LIKE isat_t.isatdocdt
                       END RECORD
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_ooef019       LIKE ooef_t.ooef019
DEFINE g_isai002       LIKE isai_t.isai002
DEFINE g_isai008       LIKE isai_t.isai008 
DEFINE g_isag_d2       DYNAMIC ARRAY OF type_g_isag_d2 #立帳來源明細
DEFINE g_isah_d3       DYNAMIC ARRAY OF type_g_isah_d3 #發票明細
DEFINE g_xrcd_d4       DYNAMIC ARRAY OF type_g_xrcd_d4 #交易稅明細 
DEFINE g_isat_d5       DYNAMIC ARRAY OF type_g_isat_d5 #發票歷程檔   
DEFINE g_ctl_where     STRING                          #交易對象控制組WHERE CON
DEFINE g_input_wc      STRING
DEFINE g_wc_comp       STRING
DEFINE g_wc_qry        STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_isaf_d            DYNAMIC ARRAY OF type_g_isaf_d
DEFINE g_isaf_d_t          type_g_isaf_d
 
 
 
 
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
 
{<section id="aisq390.main" >}
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
   CALL cl_ap_init("ais","")
 
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
   DECLARE aisq390_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq390_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq390_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq390 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq390_init()   
 
      #進入選單 Menu (="N")
      CALL aisq390_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq390
      
   END IF 
   
   CLOSE aisq390_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq390.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aisq390_init()
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
   CALL s_fin_create_account_center_tmp()
   CALL aisq390_qbe_clear() 
   CALL cl_set_combo_scc('isag001','8341') 
   CALL cl_set_combo_scc('isat014','9716')
   #end add-point
 
   CALL aisq390_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aisq390.default_search" >}
PRIVATE FUNCTION aisq390_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isafcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isafdocno = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   IF cl_null(g_input_wc) THEN LET g_input_wc = " 1=2 " END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq390.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisq390_ui_dialog() 
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
   DEFINE l_isafcomp LIKE isaf_t.isafcomp
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
 
   
   CALL aisq390_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isaf_d.clear()
 
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
 
         CALL aisq390_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #INPUT條件
         INPUT g_input.isafsite,g_input.isafcomp FROM isafsite,isafcomp
               ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_wc = " 1=1"
               LET g_input_wc = " 1=1 "  
               
            AFTER FIELD isafsite
               LET g_input.isafsite_desc = ''
               LET g_input.isafcomp_desc = ''
               DISPLAY BY NAME g_input.isafsite_desc,g_input.isafcomp_desc
               IF NOT cl_null(g_input.isafsite) THEN
                  CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'1')
                  CALL s_fin_account_center_chk(g_input.isafsite,'','3',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isafsite = ''
                     LET g_input.isafcomp = ''
                     LET g_input.isafsite_desc = s_desc_get_department_desc(g_input.isafsite)
                     LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp)
                     DISPLAY BY NAME g_input.isafsite,g_input.isafsite_desc,g_input.isafcomp,g_input.isafcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_fin_orga_get_comp_ld(g_input.isafsite) RETURNING g_sub_success,g_errno,g_input.isafcomp,g_glaald
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isafsite = ''
                     LET g_input.isafcomp = ''
                     LET g_input.isafsite_desc = s_desc_get_department_desc(g_input.isafsite)
                     LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp)
                     DISPLAY BY NAME g_input.isafsite,g_input.isafsite_desc,g_input.isafcomp,g_input.isafcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_input.isafcomp)THEN
                     CALL s_fin_account_center_with_ld_chk(g_input.isafsite,g_glaald,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.isafsite = ''
                        LET g_input.isafsite_desc = s_desc_get_department_desc(g_input.isafsite)
                        DISPLAY BY NAME g_input.isafsite,g_input.isafsite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL s_control_get_customer_sql('2',g_input.isafsite,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where
               CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'1')
               LET g_input.isafsite_desc = s_desc_get_department_desc(g_input.isafsite)
               LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp)
               DISPLAY BY NAME g_input.isafsite,g_input.isafsite_desc,g_input.isafcomp,g_input.isafcomp_desc
            
            
            AFTER FIELD isafcomp
               LET g_input.isafcomp_desc = ''
               DISPLAY BY NAME g_input.isafcomp_desc
               IF NOT cl_null(g_input.isafcomp) THEN
                  CALL s_fin_comp_chk(g_input.isafcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isafcomp = ''
                     LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp)
                     DISPLAY BY NAME g_input.isafcomp,g_input.isafcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_input.isafsite)THEN
                     CALL s_fin_account_center_with_ld_chk(g_input.isafsite,g_glaald,g_user,'3','Y','',g_today)
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00127'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.isafcomp = ''
                        LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp) 
                        DISPLAY BY NAME g_input.isafcomp,g_input.isafcomp_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'')
                  CALL s_fin_account_center_comp_str() RETURNING g_wc_comp
                  CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp
                  #檢查輸入帳套是否存在帳務中心下帳套範圍內
                  IF s_chr_get_index_of(g_wc_comp,g_input.isafcomp,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00033'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.isafcomp = ''
                     LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp) 
                     DISPLAY BY NAME g_input.isafcomp,g_input.isafcomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp)
               DISPLAY BY NAME g_input.isafcomp,g_input.isafcomp_desc
               #稅區
               LET g_ooef019 = ''
               SELECT ooef019 INTO g_ooef019
                 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.isafcomp AND ooefstus = 'Y'
               CALL aisq390_file_visible ()
            
            
            ON ACTION controlp INFIELD isafsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.isafsite
               #CALL q_ooef001()      #161006-00005#26 mark
               CALL q_ooef001_46()    #161006-00005#26
               LET g_input.isafsite = g_qryparam.return1
               LET g_input.isafsite_desc = s_desc_get_department_desc(g_input.isafsite)
               DISPLAY g_input.isafsite,g_input.isafsite_desc TO isafsite,isafsite_desc
               CALL s_fin_orga_get_comp_ld(g_input.isafsite) RETURNING g_sub_success,g_errno,g_input.isafcomp,g_glaald
               LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp)
               DISPLAY g_input.isafcomp,g_input.isafcomp_desc TO isafcomp,isafcomp_desc
               NEXT FIELD isafsite
            
            
            ON ACTION controlp INFIELD isafcomp
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.isafcomp
               CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'')
               CALL s_fin_account_center_comp_str()RETURNING g_wc_comp
               CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp
               LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_comp
               CALL q_ooef001()
               LET g_input.isafcomp = g_qryparam.return1
               LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp)
               DISPLAY g_input.isafcomp,g_input.isafcomp_desc TO isafcomp,isafcomp_desc
               NEXT FIELD isafcomp
            
         END INPUT
         
         #QBE查詢條件
         CONSTRUCT BY NAME g_input_wc ON isafdocdt,isaf005,isaf057,isaf004
            
            ON ACTION controlp INFIELD isaf005
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO isaf005
               NEXT FIELD isaf005

            ON ACTION controlp INFIELD isaf057
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO isaf057
               NEXT FIELD isaf057
               
            ON ACTION controlp INFIELD isaf004
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " ooegstus = 'Y' AND ooeg009 = '",g_input.isafcomp,"'" #161017-00005#1 add
               #CALL q_ooef001()    #161006-00005#26 mark
               CALL q_ooeg001_4()   #161006-00005#26
               DISPLAY g_qryparam.return1 TO isaf004
               NEXT FIELD isaf004

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_isaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aisq390_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq390_b_fill2()
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
         #立帳來源明細
         DISPLAY ARRAY g_isag_d2 TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_isag_d2.getLength() TO FORMONLY.h_count
               CALL aisq390_b_fill2()
            
         END DISPLAY
         #發票明細
         DISPLAY ARRAY g_isah_d3 TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 3
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_isah_d3.getLength() TO FORMONLY.h_count
         
         END DISPLAY
         #交易稅明細
         DISPLAY ARRAY g_xrcd_d4 TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 4
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_xrcd_d4.getLength() TO FORMONLY.h_count
         
         END DISPLAY
         #發票歷程檔
         DISPLAY ARRAY g_isat_d5 TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 5
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_isat_d5.getLength() TO FORMONLY.h_count
         
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aisq390_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
 
            #end add-point
            NEXT FIELD isafsite
 
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
            CALL aisq390_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_isaf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_isag_d2)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_isah_d3)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_xrcd_d4)
               LET g_export_id[4]   = "s_detail4"
               LET g_export_node[5] = base.typeInfo.create(g_isat_d5)
               LET g_export_id[5]   = "s_detail5"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aisq390_b_fill()
 
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
            CALL aisq390_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq390_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq390_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq390_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aisq390_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
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
            CALL aisq390_qbe_clear() 
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
 
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aisq390.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq390_b_fill()
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
 
   CALL g_isaf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF cl_null(g_input_wc) THEN LET g_input_wc = " 1=1 " END IF
   LET ls_wc =  g_input_wc CLIPPED
   LET ls_wc = ls_wc , " AND isafsite = '",g_input.isafsite,"' AND isafcomp = '",g_input.isafcomp,"' AND isaf050 = '3' ",
                       " AND isaf003 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND ",g_ctl_where,")"
   LET g_wc_qry = ls_wc   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE isafsite,isafcomp,isafdocno,isafdocdt,isaf003,'',isaf004,'',isaf057, 
       '',isaf103,isaf104,isaf105,isaf113,isaf114,isaf115  ,DENSE_RANK() OVER( ORDER BY isaf_t.isafcomp, 
       isaf_t.isafdocno) AS RANK FROM isaf_t",
 
 
                     "",
                     " WHERE isafent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isaf_t"),
                     " ORDER BY isaf_t.isafcomp,isaf_t.isafdocno"
 
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
 
   LET g_sql = "SELECT isafsite,isafcomp,isafdocno,isafdocdt,isaf003,'',isaf004,'',isaf057,'',isaf103, 
       isaf104,isaf105,isaf113,isaf114,isaf115",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq390_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq390_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_isaf_d[l_ac].isafsite,g_isaf_d[l_ac].isafcomp,g_isaf_d[l_ac].isafdocno, 
       g_isaf_d[l_ac].isafdocdt,g_isaf_d[l_ac].isaf003,g_isaf_d[l_ac].isaf003_desc,g_isaf_d[l_ac].isaf004, 
       g_isaf_d[l_ac].isaf004_desc,g_isaf_d[l_ac].isaf057,g_isaf_d[l_ac].isaf057_desc,g_isaf_d[l_ac].isaf103, 
       g_isaf_d[l_ac].isaf104,g_isaf_d[l_ac].isaf105,g_isaf_d[l_ac].isaf113,g_isaf_d[l_ac].isaf114,g_isaf_d[l_ac].isaf115 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #業務人員全名
      LET g_isaf_d[l_ac].isaf057_desc = ''
      SELECT ooag011 INTO g_isaf_d[l_ac].isaf057_desc 
        FROM ooag_t 
       WHERE ooagent= g_enterprise AND ooag001 = g_isaf_d[l_ac].isaf057
      #end add-point
 
      CALL aisq390_detail_show("'1'")
 
      CALL aisq390_isaf_t_mask()
 
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
 
   CALL g_isaf_d.deleteElement(g_isaf_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_isaf_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aisq390_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq390_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq390_detail_action_trans()
 
   LET l_ac = 1
   IF g_isaf_d.getLength() > 0 THEN
      CALL aisq390_b_fill2()
   END IF
 
      CALL aisq390_filter_show('isafsite','b_isafsite')
   CALL aisq390_filter_show('isafcomp','b_isafcomp')
   CALL aisq390_filter_show('isafdocno','b_isafdocno')
   CALL aisq390_filter_show('isafdocdt','b_isafdocdt')
   CALL aisq390_filter_show('isaf003','b_isaf003')
   CALL aisq390_filter_show('isaf004','b_isaf004')
   CALL aisq390_filter_show('isaf057','b_isaf057')
   CALL aisq390_filter_show('isaf103','b_isaf103')
   CALL aisq390_filter_show('isaf104','b_isaf104')
   CALL aisq390_filter_show('isaf105','b_isaf105')
   CALL aisq390_filter_show('isaf113','b_isaf113')
   CALL aisq390_filter_show('isaf114','b_isaf114')
   CALL aisq390_filter_show('isaf115','b_isaf115')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aisq390.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq390_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_isaf056       LIKE isaf_t.isaf056
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   #計價數量
   LET l_sql = " SELECT CASE WHEN rtib017 < 0 THEN rtib017 * -1 ELSE rtib017 END CASE ",
               "   FROM rtia_t,rtib_t ",
               "  WHERE rtiaent = ? ",
               "    AND rtiadocno = ? ",
               "    AND rtibseq = ? ",
               "    AND rtiaent = rtibent ",
               "    AND rtiadocno = rtibdocno ",
               "    AND rtiastus = 'S' "
   PREPARE aisq390_inag009_pb FROM l_sql
   DECLARE aisq390_inag009_cs CURSOR FOR aisq390_inag009_pb
   
   
   #欄位隱顯--------------------------------------------------
   LET l_isaf056 = ''
   SELECT isaf056 INTO l_isaf056 FROM isaf_t 
    WHERE isafent = g_enterprise AND isafcomp = g_isaf_d[l_ac].isafcomp ANd isafdocno = g_isaf_d[l_ac].isafdocno
   CALL cl_set_comp_visible("isag013,isag014,isah008,isah009",TRUE)   
   IF l_isaf056 <> '2' THEN 
      CALL cl_set_comp_visible("isag013,isag014,isah008,isah009",FALSE)
   END IF
   
   #發票明細_發票號碼隱顯
   CALL cl_set_comp_visible("isah002",TRUE)
   IF g_isai008 = 'TW' AND l_isaf056 = '2' THEN
      CALL cl_set_comp_visible("isah002",FALSE)
   END IF
   
   #發票歷程檔_原發票號碼隱顯
   CALL cl_set_comp_visible('isat027',TRUE)   
   IF l_isaf056 = '1' THEN
      CALL cl_set_comp_visible('isat027',FALSE)
   END IF
   #---------------------------------------------------------
   
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   IF g_current_page = 1 THEN
      CALL g_isag_d2.clear()
   END IF
   CALL g_isah_d3.clear()
   CALL g_xrcd_d4.clear()
   CALL g_isat_d5.clear()
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   #立帳來源明細
   IF g_current_page = 1 THEN
      LET l_sql = " SELECT isagseq,isagorga, ",
                  "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = isagent AND ooefl001 = isagorga AND ooefl002='",g_dlang,"'),  ",
                  "        isag001,isag002,isag003,isag009,isag010, ",
                  "        (SELECT imaal004 FROM imaal_t WHERE imaalent = isagent AND imaal001= isag009 AND imaal002='",g_dlang,"'), ",
                  "        isag016,isag017,isag015,'' inag009,'' xmdl047,'', ",
                  "        (SELECT oocal003 FROM oocal_t WHERE oocalent = isagent AND oocal001 = isag005 AND oocal002 = '",g_dlang,"'), ",
                  "        isag006,isag008,isag012,isag004,isag005, ",
                  "        (SELECT oocal003 FROM oocal_t WHERE oocalent = isagent AND oocal001 = isag005 AND oocal002 = '",g_dlang,"'), ",
                  "        isag101,isag103,isag104,isag105,isag113,isag114, ",
                  "        isag115,isag116,isag117,isag013,isag014,isag011 ",
                  "   FROM isag_t,isaf_t ", 
                  "  WHERE isagent = ? AND isagcomp = ? AND isagdocno = ? AND isaf050 = '3' ",
                  "    AND ",g_wc_qry,
                  "    AND isagent = isafent AND isagcomp = isafcomp AND isagdocno = isafdocno "
                   
      PREPARE aisq390_pb2 FROM l_sql
      DECLARE b_fill2_curs CURSOR FOR aisq390_pb2
      LET li_ac = 1
      FOREACH b_fill2_curs USING g_enterprise,g_isaf_d[l_ac].isafcomp,g_isaf_d[l_ac].isafdocno
         INTO g_isag_d2[li_ac].isagseq,g_isag_d2[li_ac].isagorga,g_isag_d2[li_ac].isagorga_desc,g_isag_d2[li_ac].isag001,
              g_isag_d2[li_ac].isag002,g_isag_d2[li_ac].isag003,g_isag_d2[li_ac].isag009,g_isag_d2[li_ac].isag010,
              g_isag_d2[li_ac].imaal004,g_isag_d2[li_ac].isag016,g_isag_d2[li_ac].isag017,g_isag_d2[li_ac].isag015,
              g_isag_d2[li_ac].inag009,g_isag_d2[li_ac].xmdl047,g_isag_d2[li_ac].inag007,g_isag_d2[li_ac].inag007_desc,
              g_isag_d2[li_ac].isag006,g_isag_d2[li_ac].isag008,g_isag_d2[li_ac].isag012,g_isag_d2[li_ac].isag004,
              g_isag_d2[li_ac].isag005,g_isag_d2[li_ac].isag005_desc,g_isag_d2[li_ac].isag101,g_isag_d2[li_ac].isag103,
              g_isag_d2[li_ac].isag104,g_isag_d2[li_ac].isag105,g_isag_d2[li_ac].isag113,g_isag_d2[li_ac].isag114,
              g_isag_d2[li_ac].isag115,g_isag_d2[li_ac].isag116,g_isag_d2[li_ac].isag117,g_isag_d2[li_ac].isag013,
              g_isag_d2[li_ac].isag014,g_isag_d2[li_ac].isag011      
   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:b_fill2_curs"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      
         EXECUTE aisq390_inag009_cs USING g_enterprise,g_isag_d2[li_ac].isag002,g_isag_d2[li_ac].isag003 INTO g_isag_d2[li_ac].inag009
         LET g_isag_d2[li_ac].xmdl047 = 0
         LET g_isag_d2[li_ac].inag007 = g_isag_d2[li_ac].isag005
         LET g_isag_d2[li_ac].inag007_desc = s_desc_get_unit_desc(g_isag_d2[li_ac].inag007)
       
         
         LET li_ac = li_ac + 1
         IF li_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            EXIT FOREACH
         END IF
      END FOREACH
      CALL g_isag_d2.deleteElement(g_isag_d2.getLength())
   END IF
   
   #發票明細
   LET l_sql = " SELECT isahseq,isahorga, ",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = isahent AND ooefl001 = isahorga AND ooefl002='",g_dlang,"'), ",
               "        isah003,isah004,isah013, ",
               "        isah005,",
               "        (SELECT oocal003 FROM oocal_t WHERE oocalent = isahent AND oocal001 = isah005 AND oocal002 = '",g_dlang,"'),",
               "        isah010,isah006,isah101,isah103, ",
               "        isah007,isah104,isah105,isah113,isah114,isah115, ",
               "        isah001,isah002,isah008,isah009,isah011,isah106, ",
               "        isah012,isah116 ",
               "   FROM isah_t,isaf_t ", 
               "  WHERE isahent = ? AND isahcomp = ? AND isahdocno = ? AND isaf050 = '3' ",
               "    AND ",g_wc_qry,
               "    AND isahent = isafent AND isahcomp = isafcomp AND isahdocno = isafdocno "

   PREPARE aisq390_pb3 FROM l_sql
   DECLARE b_fill3_curs CURSOR FOR aisq390_pb3
   LET li_ac = 1
   FOREACH b_fill3_curs USING g_enterprise,g_isaf_d[l_ac].isafcomp,g_isaf_d[l_ac].isafdocno
      INTO g_isah_d3[li_ac].isahseq,g_isah_d3[li_ac].isahorga,g_isah_d3[li_ac].isahorga_desc, 
           g_isah_d3[li_ac].isah003,g_isah_d3[li_ac].isah004,g_isah_d3[li_ac].isah013,
           g_isah_d3[li_ac].isah005,g_isah_d3[li_ac].isah005_desc,g_isah_d3[li_ac].isah010,
           g_isah_d3[li_ac].isah006,g_isah_d3[li_ac].isah101,g_isah_d3[li_ac].isah103, 
           g_isah_d3[li_ac].isah007,g_isah_d3[li_ac].isah104,g_isah_d3[li_ac].isah105,
           g_isah_d3[li_ac].isah113,g_isah_d3[li_ac].isah114,g_isah_d3[li_ac].isah115, 
           g_isah_d3[li_ac].isah001,g_isah_d3[li_ac].isah002,g_isah_d3[li_ac].isah008,
           g_isah_d3[li_ac].isah009,g_isah_d3[li_ac].isah011,g_isah_d3[li_ac].isah106, 
           g_isah_d3[li_ac].isah012,g_isah_d3[li_ac].isah116
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:b_fill3_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_isah_d3.deleteElement(g_isah_d3.getLength())

   #交易稅明細   
   LET l_sql = " SELECT xrcdld,xrcdseq2,xrcdseq,xrcd007,xrcd002, ",
               "        (SELECT oodbl004 FROM oodbl_t WHERE oodblent = xrcdent ",
               "            AND oodbl001 = '",g_ooef019,"' ",
               "            AND oodbl002 = xrcd002 AND oodbl003 = '",g_dlang,"'), ",
               "        xrcd003,xrcd006,xrcd005,xrcd104,xrcd103, ",
               "        xrcd105,xrcd114 ", 
               "   FROM xrcd_t,isaf_t ", 
               "  WHERE xrcdent = ? AND xrcdcomp = ? AND xrcddocno = ? AND xrcdseq2 = 0 ",
               "    AND ",g_wc_qry,
               "    AND xrcdent = isafent AND xrcdcomp = isafcomp AND xrcddocno = isafdocno AND isaf050 = '3'"

   PREPARE aisq390_pb4 FROM l_sql
   DECLARE b_fill4_curs CURSOR FOR aisq390_pb4
   LET li_ac = 1
   FOREACH b_fill4_curs USING g_enterprise,g_isaf_d[l_ac].isafcomp,g_isaf_d[l_ac].isafdocno
      INTO g_xrcd_d4[li_ac].xrcdld,g_xrcd_d4[li_ac].xrcdseq2,g_xrcd_d4[li_ac].xrcdseq,
           g_xrcd_d4[li_ac].xrcd007,g_xrcd_d4[li_ac].xrcd002,g_xrcd_d4[li_ac].xrcd002_desc,g_xrcd_d4[li_ac].xrcd003,
           g_xrcd_d4[li_ac].xrcd006,g_xrcd_d4[li_ac].xrcd005,g_xrcd_d4[li_ac].xrcd104,g_xrcd_d4[li_ac].xrcd103,
           g_xrcd_d4[li_ac].xrcd105,g_xrcd_d4[li_ac].xrcd114

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:b_fill4_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_xrcd_d4.deleteElement(g_xrcd_d4.getLength())
   
   
   #發票歷程檔 
   LET l_sql = " SELECT isatseq,isat003,isat004,isat027,isat006,isat002, ",
               "        isat103,isat104,isat105,isat113,isat114,isat115, ",
               "        isat007,isat014,isat106,isat107,isat017,isatsite, ",
               "        isatdocdt ", 
               "   FROM isat_t,isaf_t ", 
               "  WHERE isatent = ?  AND isatcomp = ? AND isatdocno = ?",
               "    AND ",g_wc_qry,
               "    AND isatent = isafent AND isatcomp = isafcomp AND isatdocno = isafdocno AND isaf050 = '3'"

   PREPARE aisq390_pb5 FROM l_sql
   DECLARE b_fill5_curs CURSOR FOR aisq390_pb5
   LET li_ac = 1
   FOREACH b_fill5_curs USING g_enterprise,g_isaf_d[l_ac].isafcomp,g_isaf_d[l_ac].isafdocno
      INTO g_isat_d5[li_ac].isatseq,g_isat_d5[li_ac].isat003,g_isat_d5[li_ac].isat004,g_isat_d5[li_ac].isat027,
           g_isat_d5[li_ac].isat006,g_isat_d5[li_ac].isat002,g_isat_d5[li_ac].isat103,g_isat_d5[li_ac].isat104,
           g_isat_d5[li_ac].isat105,g_isat_d5[li_ac].isat113,g_isat_d5[li_ac].isat114,g_isat_d5[li_ac].isat115,
           g_isat_d5[li_ac].isat007,g_isat_d5[li_ac].isat014,g_isat_d5[li_ac].isat106,g_isat_d5[li_ac].isat107,
           g_isat_d5[li_ac].isat017,g_isat_d5[li_ac].isatsite,g_isat_d5[li_ac].isatdocdt

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:b_fill5_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_isat_d5.deleteElement(g_isat_d5.getLength())
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aisq390.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq390_detail_show(ps_page)
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
      #帳款客戶名稱
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_isaf_d[l_ac].isaf003
      LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_isaf_d[l_ac].isaf003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_isaf_d[l_ac].isaf003_desc
       
      #業務組織名稱
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_isaf_d[l_ac].isaf004
      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_isaf_d[l_ac].isaf004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_isaf_d[l_ac].isaf004_desc

      #業務人員全名
      LET g_isaf_d[l_ac].isaf057_desc = ''
      SELECT ooag011 INTO g_isaf_d[l_ac].isaf057_desc 
        FROM ooag_t 
       WHERE ooagent= g_enterprise AND ooag001 = g_isaf_d[l_ac].isaf057
      DISPLAY BY NAME g_isaf_d[l_ac].isaf057_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq390.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aisq390_filter()
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
      CONSTRUCT g_wc_filter ON isafsite,isafcomp,isafdocno,isafdocdt,isaf003,isaf004,isaf057,isaf103, 
          isaf104,isaf105,isaf113,isaf114,isaf115
                          FROM s_detail1[1].b_isafsite,s_detail1[1].b_isafcomp,s_detail1[1].b_isafdocno, 
                              s_detail1[1].b_isafdocdt,s_detail1[1].b_isaf003,s_detail1[1].b_isaf004, 
                              s_detail1[1].b_isaf057,s_detail1[1].b_isaf103,s_detail1[1].b_isaf104,s_detail1[1].b_isaf105, 
                              s_detail1[1].b_isaf113,s_detail1[1].b_isaf114,s_detail1[1].b_isaf115
 
         BEFORE CONSTRUCT
                     DISPLAY aisq390_filter_parser('isafsite') TO s_detail1[1].b_isafsite
            DISPLAY aisq390_filter_parser('isafcomp') TO s_detail1[1].b_isafcomp
            DISPLAY aisq390_filter_parser('isafdocno') TO s_detail1[1].b_isafdocno
            DISPLAY aisq390_filter_parser('isafdocdt') TO s_detail1[1].b_isafdocdt
            DISPLAY aisq390_filter_parser('isaf003') TO s_detail1[1].b_isaf003
            DISPLAY aisq390_filter_parser('isaf004') TO s_detail1[1].b_isaf004
            DISPLAY aisq390_filter_parser('isaf057') TO s_detail1[1].b_isaf057
            DISPLAY aisq390_filter_parser('isaf103') TO s_detail1[1].b_isaf103
            DISPLAY aisq390_filter_parser('isaf104') TO s_detail1[1].b_isaf104
            DISPLAY aisq390_filter_parser('isaf105') TO s_detail1[1].b_isaf105
            DISPLAY aisq390_filter_parser('isaf113') TO s_detail1[1].b_isaf113
            DISPLAY aisq390_filter_parser('isaf114') TO s_detail1[1].b_isaf114
            DISPLAY aisq390_filter_parser('isaf115') TO s_detail1[1].b_isaf115
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<b_isafsite>>----
         #Ctrlp:construct.c.filter.page1.b_isafsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafsite
            #add-point:ON ACTION controlp INFIELD b_isafsite name="construct.c.filter.page1.b_isafsite"
            
            #END add-point
 
 
         #----<<b_isafcomp>>----
         #Ctrlp:construct.c.page1.b_isafcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafcomp
            #add-point:ON ACTION controlp INFIELD b_isafcomp name="construct.c.filter.page1.b_isafcomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isafcomp  #顯示到畫面上
            NEXT FIELD b_isafcomp                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isafdocno>>----
         #Ctrlp:construct.c.page1.b_isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocno
            #add-point:ON ACTION controlp INFIELD b_isafdocno name="construct.c.filter.page1.b_isafdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isafdocno  #顯示到畫面上
            NEXT FIELD b_isafdocno                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isafdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_isafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocdt
            #add-point:ON ACTION controlp INFIELD b_isafdocdt name="construct.c.filter.page1.b_isafdocdt"
            
            #END add-point
 
 
         #----<<b_isaf003>>----
         #Ctrlp:construct.c.page1.b_isaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf003
            #add-point:ON ACTION controlp INFIELD b_isaf003 name="construct.c.filter.page1.b_isaf003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()     #160920-00019#5--mark   
            CALL q_pmaa001_13()   #160920-00019#5--add
            DISPLAY g_qryparam.return1 TO b_isaf003  #顯示到畫面上
            NEXT FIELD b_isaf003                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isaf003_desc>>----
         #----<<b_isaf004>>----
         #Ctrlp:construct.c.page1.b_isaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf004
            #add-point:ON ACTION controlp INFIELD b_isaf004 name="construct.c.filter.page1.b_isaf004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf004  #顯示到畫面上
            NEXT FIELD b_isaf004                     #返回原欄位
    
            #END add-point
 
 
         #----<<b_isaf004_desc>>----
         #----<<b_isaf057>>----
         #Ctrlp:construct.c.filter.page1.b_isaf057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf057
            #add-point:ON ACTION controlp INFIELD b_isaf057 name="construct.c.filter.page1.b_isaf057"
            
            #END add-point
 
 
         #----<<b_isaf057_desc>>----
         #----<<b_isaf103>>----
         #Ctrlp:construct.c.filter.page1.b_isaf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf103
            #add-point:ON ACTION controlp INFIELD b_isaf103 name="construct.c.filter.page1.b_isaf103"
            
            #END add-point
 
 
         #----<<b_isaf104>>----
         #Ctrlp:construct.c.filter.page1.b_isaf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf104
            #add-point:ON ACTION controlp INFIELD b_isaf104 name="construct.c.filter.page1.b_isaf104"
            
            #END add-point
 
 
         #----<<b_isaf105>>----
         #Ctrlp:construct.c.filter.page1.b_isaf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf105
            #add-point:ON ACTION controlp INFIELD b_isaf105 name="construct.c.filter.page1.b_isaf105"
            
            #END add-point
 
 
         #----<<b_isaf113>>----
         #Ctrlp:construct.c.filter.page1.b_isaf113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf113
            #add-point:ON ACTION controlp INFIELD b_isaf113 name="construct.c.filter.page1.b_isaf113"
            
            #END add-point
 
 
         #----<<b_isaf114>>----
         #Ctrlp:construct.c.filter.page1.b_isaf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf114
            #add-point:ON ACTION controlp INFIELD b_isaf114 name="construct.c.filter.page1.b_isaf114"
            
            #END add-point
 
 
         #----<<b_isaf115>>----
         #Ctrlp:construct.c.filter.page1.b_isaf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf115
            #add-point:ON ACTION controlp INFIELD b_isaf115 name="construct.c.filter.page1.b_isaf115"
            
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
 
      CALL aisq390_filter_show('isafsite','b_isafsite')
   CALL aisq390_filter_show('isafcomp','b_isafcomp')
   CALL aisq390_filter_show('isafdocno','b_isafdocno')
   CALL aisq390_filter_show('isafdocdt','b_isafdocdt')
   CALL aisq390_filter_show('isaf003','b_isaf003')
   CALL aisq390_filter_show('isaf004','b_isaf004')
   CALL aisq390_filter_show('isaf057','b_isaf057')
   CALL aisq390_filter_show('isaf103','b_isaf103')
   CALL aisq390_filter_show('isaf104','b_isaf104')
   CALL aisq390_filter_show('isaf105','b_isaf105')
   CALL aisq390_filter_show('isaf113','b_isaf113')
   CALL aisq390_filter_show('isaf114','b_isaf114')
   CALL aisq390_filter_show('isaf115','b_isaf115')
 
 
   CALL aisq390_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq390.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aisq390_filter_parser(ps_field)
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
 
{<section id="aisq390.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq390_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq390_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aisq390.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq390_detail_action_trans()
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
 
{<section id="aisq390.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq390_detail_index_setting()
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
            IF g_isaf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isaf_d.getLength() AND g_isaf_d.getLength() > 0
            LET g_detail_idx = g_isaf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isaf_d.getLength() THEN
               LET g_detail_idx = g_isaf_d.getLength()
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
 
{<section id="aisq390.mask_functions" >}
 &include "erp/ais/aisq390_mask.4gl"
 
{</section>}
 
{<section id="aisq390.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aisq390_qbe_clear()
# Date & Author..: 160706 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq390_qbe_clear()
   
   CLEAR FORM
   INITIALIZE g_input.* TO NULL
   
   CALL g_isaf_d.clear()
   CALL g_isag_d2.clear()
   CALL g_isah_d3.clear()
   CALL g_xrcd_d4.clear()
   CALL g_isat_d5.clear()
   
   LET g_input.isafsite = g_site

   CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'')
   CALL s_fin_account_center_comp_str()RETURNING g_wc_comp
   CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp

   CALL s_control_get_customer_sql('2',g_input.isafsite,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where

   #法人
   SELECT ooef017 INTO g_input.isafcomp 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_input.isafsite

   #稅區
   LET g_ooef019 = ''
   SELECT ooef019 INTO g_ooef019
     FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.isafcomp AND ooefstus = 'Y'

   CALL aisq390_file_visible ()
   
   LET g_input.isafsite_desc = s_desc_get_department_desc(g_input.isafsite)
   LET g_input.isafcomp_desc = s_desc_get_department_desc(g_input.isafcomp) 
   DISPLAY g_input.isafsite,g_input.isafsite_desc,g_input.isafcomp,g_input.isafcomp_desc 
        TO isafsite,isafsite_desc,isafcomp,isafcomp_desc
   
END FUNCTION

################################################################################
# Descriptions...: 欄位隱顯
# Memo...........:
# Usage..........: CALL aisq390_file_visible()
# Date & Author..: 160715 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq390_file_visible()

   LET g_isai002 = ''
   LET g_isai008 = ''
   SELECT isai002,isai008 INTO g_isai002,g_isai008 
     FROM isai_t WHERE isaient = g_enterprise  AND isai001 = g_ooef019

   CALL cl_set_comp_visible('isag013.isah001,isah008,isat003',TRUE)
   IF g_isai002 = '1' THEN 
      CALL cl_set_comp_visible('isag013,isah001,isah008,isat003',FALSE)
   END IF
   
   CALL cl_set_comp_visible("isah011,isah106,isah012",TRUE)
   IF g_isai008 = 'TW' THEN 
      CALL cl_set_comp_visible("isah011,isah106,isah012",FALSE)
   END IF

END FUNCTION

 
{</section>}
 
