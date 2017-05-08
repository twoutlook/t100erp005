#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq440.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-11-30 10:26:45), PR版次:0004(2016-11-30 10:44:19)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000021
#+ Filename...: anmq440
#+ Description: 應付已付未沖查詢作業
#+ Creator....: 01727(2016-07-01 16:50:51)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="anmq440.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160816-00012#4   2016/09/08 By 07900     ANM增加资金中心，帐套，法人三个栏位权限
#161021-00050#8   2016/10/26 By Reanna    资金中心开窗需调整为q_ooef001_33;法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留

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
PRIVATE TYPE type_g_nmck_d RECORD
       
       sel LIKE type_t.chr1, 
   nmckstus LIKE nmck_t.nmckstus, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck002 LIKE nmck_t.nmck002, 
   nmck003 LIKE nmck_t.nmck003, 
   nmck003_desc LIKE type_t.chr500, 
   nmck004 LIKE nmck_t.nmck004, 
   nmck004_desc LIKE type_t.chr500, 
   nmck005 LIKE nmck_t.nmck005, 
   nmck005_desc LIKE type_t.chr500, 
   nmck006 LIKE nmck_t.nmck006, 
   nmck006_desc LIKE type_t.chr500, 
   nmck100 LIKE nmck_t.nmck100, 
   nmck103 LIKE nmck_t.nmck103, 
   nmck101 LIKE nmck_t.nmck101, 
   nmck113 LIKE nmck_t.nmck113, 
   glaa016 LIKE type_t.chr10, 
   nmck121 LIKE nmck_t.nmck121, 
   nmck123 LIKE nmck_t.nmck123, 
   glaa020 LIKE type_t.chr10, 
   nmck131 LIKE nmck_t.nmck131, 
   nmck133 LIKE nmck_t.nmck133, 
   nmck011 LIKE nmck_t.nmck011, 
   nmck012 LIKE nmck_t.nmck012, 
   nmck025 LIKE nmck_t.nmck025, 
   nmck013 LIKE nmck_t.nmck013, 
   nmck013_desc LIKE type_t.chr500, 
   nmck014 LIKE nmck_t.nmck014, 
   nmck015 LIKE nmck_t.nmck015
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_master RECORD
   nmcksite                LIKE nmck_t.nmcksite,
   nmcksite_desc           LIKE ooefl_t.ooefl003,
   nmckcomp                LIKE nmck_t.nmckcomp,
   nmckcomp_desc           LIKE ooefl_t.ooefl003,
   sdate                   LIKE nmck_t.nmckdocdt,
   edate                   LIKE nmck_t.nmckdocdt,
   comb                    LIKE type_t.chr10
                           END RECORD

DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
DEFINE g_comp_wc           STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmck_d            DYNAMIC ARRAY OF type_g_nmck_d
DEFINE g_nmck_d_t          type_g_nmck_d
 
 
 
 
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
 
{<section id="anmq440.main" >}
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
   CALL cl_ap_init("anm","")
 
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
   DECLARE anmq440_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq440_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq440_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq440 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq440_init()   
 
      #進入選單 Menu (="N")
      CALL anmq440_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq440
      
   END IF 
   
   CLOSE anmq440_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq440.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq440_init()
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
      CALL cl_set_combo_scc_part('b_nmckstus','13','N,Y,A,D,R,W,X')
 
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc_part('comb','8310','20,30')
   CALL anmq440_create_tmp()
   CALL cl_set_combo_scc_part('nmckstus','13','N,Y,V,A,D,R,W,X')
   #end add-point
 
   CALL anmq440_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq440.default_search" >}
PRIVATE FUNCTION anmq440_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmckcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmckdocno = '", g_argv[02], "' AND "
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
 
{<section id="anmq440.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq440_ui_dialog() 
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
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_glaa015         LIKE glaa_t.glaa015
   DEFINE l_glaa019         LIKE glaa_t.glaa019
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_wc       STRING   #160816-00012#4 Add
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
 
   
   CALL anmq440_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmck_d.clear()
 
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
 
         CALL anmq440_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.nmcksite,g_master.nmckcomp,g_master.sdate,g_master.edate,g_master.comb

            BEFORE INPUT 
              CALL anmq440_def()

            AFTER FIELD nmcksite
               IF NOT cl_null(g_master.nmcksite) THEN
                  LET l_count = 0
                  SELECT COUNT(1) INTO l_count FROM nmck_t WHERE nmckent = g_enterprise
                     AND nmcksite = g_master.nmcksite
                     AND nmckstus <> 'X'
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00402'
                     LET g_errparam.replace[1] = cl_get_progname("anmt440",g_lang,"2")
                     LET g_errparam.replace[2] = cl_get_progname("anmt460",g_lang,"2")
                     LET g_errparam.extend = g_master.nmcksite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmcksite = ''
                     LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
                     LET g_comp_wc = ''
                     DISPLAY BY NAME g_master.nmcksite_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_master.nmcksite,'',g_user,'6','N','',g_master.edate)
                     RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.nmcksite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmcksite = ''
                     LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
                     LET g_comp_wc = ''
                     DISPLAY BY NAME g_master.nmcksite_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_anm_get_comp_wc('6',g_master.nmcksite,g_master.edate) RETURNING g_comp_wc
 #                 IF NOT cl_null(g_master.nmckcomp) AND s_chr_get_index_of(g_comp_wc,g_master.nmckcomp,1) = 0 THEN  #160816-00012#4  mark
                  IF NOT cl_null(g_master.nmckcomp) THEN   #160816-00012#4 add 
                    IF s_chr_get_index_of(g_comp_wc,g_master.nmckcomp,1) = 0 THEN   #160816-00012#4 add 
                       SELECT ooef017 INTO g_master.nmckcomp
                         FROM ooef_t
                        WHERE ooefent = g_enterprise
                          AND ooef001 = g_master.nmcksite
                        #160816-00012#4 Add  ---(S)---
                        #检查用户是否有资金中心对应法人的权限
                        CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                        LET l_count = 0
                        LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                                    "   AND ooef001 = '",g_master.nmckcomp,"'",
                                    "   AND ooef003 = 'Y'",
                                    "   AND ",l_wc CLIPPED
                        PREPARE anmp410_count_prep1 FROM l_sql
                        EXECUTE anmp410_count_prep1 INTO l_count
                        IF cl_null(l_count) THEN LET l_count = 0 END IF
                        IF l_count = 0 THEN
                           LET g_master.nmckcomp = ''                          
                        END IF
                        #160816-00012#4 Add  ---(E)---
                       LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
                       DISPLAY BY NAME g_master.nmckcomp,g_master.nmckcomp_desc
                    END IF 
                  END IF
                  LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
                  DISPLAY BY NAME g_master.nmcksite_desc
                 
               END IF
               #160816-00012#4 Add  ---(S)---
               LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
               DISPLAY BY NAME g_master.nmcksite_desc
               #160816-00012#4 Add  ---(E)---
               CALL anmq440_set_entry()

            AFTER FIELD nmckcomp
               IF NOT cl_null(g_master.nmckcomp) THEN
                  LET l_count = 0
                  #160816-00012#4 --mark--s--
#                  SELECT COUNT(1) INTO l_count FROM nmck_t WHERE nmckent = g_enterprise
#                     AND nmckcomp = g_master.nmckcomp
#                     AND nmckstus <> 'X'
#                  IF cl_null(l_count) THEN LET l_count = 0 END IF
#                  IF l_count = 0 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'anm-00403'
#                     LET g_errparam.replace[1] = cl_get_progname("anmt440",g_lang,"2")
#                     LET g_errparam.replace[2] = cl_get_progname("anmt460",g_lang,"2")
#                     LET g_errparam.extend = g_master.nmcksite
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_master.nmckcomp = ''
#                     LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
#                     DISPLAY BY NAME g_master.nmckcomp_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  #160816-00012#4 --mark--e--
                  CALL s_fin_comp_chk(g_master.nmckcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''
                     LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
                     DISPLAY BY NAME g_master.nmckcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#4 Add--s--
                  IF NOT cl_null(g_master.nmcksite) THEN  
                     LET l_count = 0
                     SELECT COUNT(1) INTO l_count
                       FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef017 = g_master.nmckcomp 
                        AND ooef001 = g_master.nmcksite
                   #160816-00012#4 Add--e--     
                     IF s_chr_get_index_of(g_comp_wc,g_master.nmckcomp,1) = 0 AND l_count = 0  THEN #160816-00012#4 Add AND l_cnt = 0 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-02928'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.nmckcomp = ''
                        LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  #160816-00012#4 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_master.nmckcomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep2 FROM l_sql
                  EXECUTE anmp410_count_prep2 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmckcomp = ''
                     LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
                     DISPLAY BY NAME g_master.nmckcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#4 Add  ---(E)---
                  DISPLAY BY NAME g_master.nmckcomp_desc                  
               END IF
               #160816-00012#4 Add  ---(S)---
               LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
               DISPLAY BY NAME g_master.nmckcomp_desc
               #160816-00012#4 Add  ---(E)---
               CALL anmq440_set_entry()

            AFTER FIELD sdate
               IF NOT cl_null(g_master.sdate) AND NOT cl_null(g_master.edate) THEN
                  IF g_master.sdate > g_master.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.sdate = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF

            AFTER FIELD edate
               IF NOT cl_null(g_master.sdate) AND NOT cl_null(g_master.edate) THEN
                  IF g_master.sdate > g_master.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00117'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.edate = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF

            ON CHANGE comb
               IF NOT cl_null(g_master.comb) THEN
                  CASE
                     WHEN g_master.comb = '20'
                       CALL anmq440_set_combo_scc('b_nmck002',g_master.comb)
                     WHEN g_master.comb = '30'
                       CALL anmq440_set_combo_scc('b_nmck002',g_master.comb)
                  END CASE
               END IF

            ON ACTION controlp INFIELD nmcksite
               #開窗i段
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmcksite
               #LET g_qryparam.where = " ooef206 = 'Y' AND ooef001 IN (SELECT nmcksite FROM nmck_t WHERE nmckent = '",g_enterprise,"')"  #160816-00012#4 mark
               LET g_qryparam.where = " ooef206 = 'Y'"  #160816-00012#4  add
               LET g_qryparam.arg1=g_user
               #CALL q_ooef001()    #161021-00050#8 mark
               CALL q_ooef001_33()  #161021-00050#8
               LET g_master.nmcksite = g_qryparam.return1
               DISPLAY g_master.nmcksite TO nmcksite
               CALL s_desc_get_department_desc(g_master.nmcksite) RETURNING g_master.nmcksite_desc
               IF cl_null(g_master.edate) THEN
                  LET g_master.edate = g_today
                  CALL s_anm_get_comp_wc('6',g_master.nmcksite,g_today) RETURNING g_comp_wc
               ELSE
                  CALL s_anm_get_comp_wc('6',g_master.nmcksite,g_master.edate) RETURNING g_comp_wc
               END IF
               DISPLAY BY NAME g_master.nmcksite_desc,g_master.nmckcomp_desc
               NEXT FIELD nmcksite


            ON ACTION controlp INFIELD nmckcomp
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmckcomp
               CALL s_anm_get_comp_wc('6',g_master.nmcksite,g_master.edate) RETURNING g_comp_wc   #160816-00012#4 Add
               LET g_qryparam.where = " ooef001 IN ",g_comp_wc
               #160816-00012#4 Add  ---(S)---
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
               LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
               #160816-00012#4 Add  ---(E)---
               #CALL q_ooef001()  #161021-00050#8 mark
               CALL q_ooef001_2() #161021-00050#8
               LET g_master.nmckcomp = g_qryparam.return1
               DISPLAY g_master.nmckcomp TO nmckcomp
               CALL s_desc_get_department_desc(g_master.nmckcomp) RETURNING g_master.nmckcomp_desc
               DISPLAY BY NAME g_master.nmckcomp_desc
               NEXT FIELD nmckcomp

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_nmck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmq440_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq440_b_fill2()
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
            CALL anmq440_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD nmcksite
 
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
            IF g_wc = " 1=2" THEN
               LET g_wc = " 1=1"
            END IF
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL anmq440_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_nmck_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmq440_b_fill()
 
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
            CALL anmq440_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq440_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq440_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq440_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmck_d.getLength()
               LET g_nmck_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmck_d.getLength()
               LET g_nmck_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmck_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmck_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq440_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            LET g_master_t.* = g_master.*
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
               IF g_wc_filter = " 1=2" THEN LET g_wc_filter = " 1=1" END IF
               SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaacomp = g_master.nmckcomp
                  AND glaa014  = 'Y'
               CALL anmq440_x01('anmq440_tmp',g_wc_filter,l_glaa015,l_glaa019)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               IF g_wc_filter = " 1=2" THEN LET g_wc_filter = " 1=1" END IF
               SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaacomp = g_master.nmckcomp
                  AND glaa014  = 'Y'
               CALL anmq440_x01('anmq440_tmp',g_wc_filter,l_glaa015,l_glaa019)
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
            INITIALIZE g_master.* TO NULL
            INITIALIZE g_master_t.* TO NULL
            CALL g_nmck_d.clear()
            CALL anmq440_def()
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="anmq440.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq440_b_fill()
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
 
   CALL g_nmck_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL anmq440_b_ins_tmp()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',nmckstus,nmckdocno,nmckdocdt,nmck002,nmck003,'',nmck004,'',nmck005, 
       '',nmck006,'',nmck100,nmck103,nmck101,nmck113,'',nmck121,nmck123,'',nmck131,nmck133,nmck011,nmck012, 
       nmck025,nmck013,'',nmck014,nmck015  ,DENSE_RANK() OVER( ORDER BY nmck_t.nmckcomp,nmck_t.nmckdocno) AS RANK FROM nmck_t", 
 
 
 
                     "",
                     " WHERE nmckent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmck_t"),
                     " ORDER BY nmck_t.nmckcomp,nmck_t.nmckdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT * FROM anmq440_tmp WHERE 1=1 AND nmckent = ? AND ",ls_wc CLIPPED
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
 
   LET g_sql = "SELECT '',nmckstus,nmckdocno,nmckdocdt,nmck002,nmck003,'',nmck004,'',nmck005,'',nmck006, 
       '',nmck100,nmck103,nmck101,nmck113,'',nmck121,nmck123,'',nmck131,nmck133,nmck011,nmck012,nmck025, 
       nmck013,'',nmck014,nmck015",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT '',nmckstus,nmckdocno,nmckdocdt,nmck002,nmck003,nmck003_desc,nmck004,nmck004_desc,",
               "          nmck005,nmck005_desc,nmck006,nmck006_desc,nmck100,nmck103,nmck101,    ",
               "          nmck113,glaa016,nmck121,nmck123,glaa020,nmck131,nmck133,nmck011,      ",
               "          nmck012, ",    #161125-00036#5 add
               "          nmck025,nmck013,nmck013_desc,nmck014,nmck015",
               "  FROM anmq440_tmp",
               " WHERE nmckent = ?",
               "   AND ",ls_wc CLIPPED,
               " ORDER BY nmckdocno,nmckdocdt"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq440_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq440_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_nmck_d[l_ac].sel,g_nmck_d[l_ac].nmckstus,g_nmck_d[l_ac].nmckdocno,g_nmck_d[l_ac].nmckdocdt, 
       g_nmck_d[l_ac].nmck002,g_nmck_d[l_ac].nmck003,g_nmck_d[l_ac].nmck003_desc,g_nmck_d[l_ac].nmck004, 
       g_nmck_d[l_ac].nmck004_desc,g_nmck_d[l_ac].nmck005,g_nmck_d[l_ac].nmck005_desc,g_nmck_d[l_ac].nmck006, 
       g_nmck_d[l_ac].nmck006_desc,g_nmck_d[l_ac].nmck100,g_nmck_d[l_ac].nmck103,g_nmck_d[l_ac].nmck101, 
       g_nmck_d[l_ac].nmck113,g_nmck_d[l_ac].glaa016,g_nmck_d[l_ac].nmck121,g_nmck_d[l_ac].nmck123,g_nmck_d[l_ac].glaa020, 
       g_nmck_d[l_ac].nmck131,g_nmck_d[l_ac].nmck133,g_nmck_d[l_ac].nmck011,g_nmck_d[l_ac].nmck012,g_nmck_d[l_ac].nmck025, 
       g_nmck_d[l_ac].nmck013,g_nmck_d[l_ac].nmck013_desc,g_nmck_d[l_ac].nmck014,g_nmck_d[l_ac].nmck015 
 
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
 
      CALL anmq440_detail_show("'1'")
 
      CALL anmq440_nmck_t_mask()
 
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
 
   CALL g_nmck_d.deleteElement(g_nmck_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_nmck_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE anmq440_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq440_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq440_detail_action_trans()
 
   LET l_ac = 1
   IF g_nmck_d.getLength() > 0 THEN
      CALL anmq440_b_fill2()
   END IF
 
      CALL anmq440_filter_show('nmckstus','b_nmckstus')
   CALL anmq440_filter_show('nmckdocno','b_nmckdocno')
   CALL anmq440_filter_show('nmckdocdt','b_nmckdocdt')
   CALL anmq440_filter_show('nmck002','b_nmck002')
   CALL anmq440_filter_show('nmck003','b_nmck003')
   CALL anmq440_filter_show('nmck004','b_nmck004')
   CALL anmq440_filter_show('nmck005','b_nmck005')
   CALL anmq440_filter_show('nmck006','b_nmck006')
   CALL anmq440_filter_show('nmck100','b_nmck100')
   CALL anmq440_filter_show('nmck103','b_nmck103')
   CALL anmq440_filter_show('nmck101','b_nmck101')
   CALL anmq440_filter_show('nmck113','b_nmck113')
   CALL anmq440_filter_show('nmck121','b_nmck121')
   CALL anmq440_filter_show('nmck123','b_nmck123')
   CALL anmq440_filter_show('nmck131','b_nmck131')
   CALL anmq440_filter_show('nmck133','b_nmck133')
   CALL anmq440_filter_show('nmck011','b_nmck011')
   CALL anmq440_filter_show('nmck012','b_nmck012')
   CALL anmq440_filter_show('nmck025','b_nmck025')
   CALL anmq440_filter_show('nmck013','b_nmck013')
   CALL anmq440_filter_show('nmck014','b_nmck014')
   CALL anmq440_filter_show('nmck015','b_nmck015')
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmq440.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq440_b_fill2()
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
 
{<section id="anmq440.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq440_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq440.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION anmq440_filter()
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
      CONSTRUCT g_wc_filter ON nmckstus,nmckdocno,nmckdocdt,nmck002,nmck003,nmck004,nmck005,nmck006, 
          nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131,nmck133,nmck011,nmck012,nmck025,nmck013, 
          nmck014,nmck015
                          FROM s_detail1[1].b_nmckstus,s_detail1[1].b_nmckdocno,s_detail1[1].b_nmckdocdt, 
                              s_detail1[1].b_nmck002,s_detail1[1].b_nmck003,s_detail1[1].b_nmck004,s_detail1[1].b_nmck005, 
                              s_detail1[1].b_nmck006,s_detail1[1].b_nmck100,s_detail1[1].b_nmck103,s_detail1[1].b_nmck101, 
                              s_detail1[1].b_nmck113,s_detail1[1].b_nmck121,s_detail1[1].b_nmck123,s_detail1[1].b_nmck131, 
                              s_detail1[1].b_nmck133,s_detail1[1].b_nmck011,s_detail1[1].b_nmck012,s_detail1[1].b_nmck025, 
                              s_detail1[1].b_nmck013,s_detail1[1].b_nmck014,s_detail1[1].b_nmck015
 
         BEFORE CONSTRUCT
                     DISPLAY anmq440_filter_parser('nmckstus') TO s_detail1[1].b_nmckstus
            DISPLAY anmq440_filter_parser('nmckdocno') TO s_detail1[1].b_nmckdocno
            DISPLAY anmq440_filter_parser('nmckdocdt') TO s_detail1[1].b_nmckdocdt
            DISPLAY anmq440_filter_parser('nmck002') TO s_detail1[1].b_nmck002
            DISPLAY anmq440_filter_parser('nmck003') TO s_detail1[1].b_nmck003
            DISPLAY anmq440_filter_parser('nmck004') TO s_detail1[1].b_nmck004
            DISPLAY anmq440_filter_parser('nmck005') TO s_detail1[1].b_nmck005
            DISPLAY anmq440_filter_parser('nmck006') TO s_detail1[1].b_nmck006
            DISPLAY anmq440_filter_parser('nmck100') TO s_detail1[1].b_nmck100
            DISPLAY anmq440_filter_parser('nmck103') TO s_detail1[1].b_nmck103
            DISPLAY anmq440_filter_parser('nmck101') TO s_detail1[1].b_nmck101
            DISPLAY anmq440_filter_parser('nmck113') TO s_detail1[1].b_nmck113
            DISPLAY anmq440_filter_parser('nmck121') TO s_detail1[1].b_nmck121
            DISPLAY anmq440_filter_parser('nmck123') TO s_detail1[1].b_nmck123
            DISPLAY anmq440_filter_parser('nmck131') TO s_detail1[1].b_nmck131
            DISPLAY anmq440_filter_parser('nmck133') TO s_detail1[1].b_nmck133
            DISPLAY anmq440_filter_parser('nmck011') TO s_detail1[1].b_nmck011
            DISPLAY anmq440_filter_parser('nmck012') TO s_detail1[1].b_nmck012
            DISPLAY anmq440_filter_parser('nmck025') TO s_detail1[1].b_nmck025
            DISPLAY anmq440_filter_parser('nmck013') TO s_detail1[1].b_nmck013
            DISPLAY anmq440_filter_parser('nmck014') TO s_detail1[1].b_nmck014
            DISPLAY anmq440_filter_parser('nmck015') TO s_detail1[1].b_nmck015
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmckstus>>----
         #Ctrlp:construct.c.filter.page1.b_nmckstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckstus
            #add-point:ON ACTION controlp INFIELD b_nmckstus name="construct.c.filter.page1.b_nmckstus"
            
            #END add-point
 
 
         #----<<b_nmckdocno>>----
         #Ctrlp:construct.c.page1.b_nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocno
            #add-point:ON ACTION controlp INFIELD b_nmckdocno name="construct.c.filter.page1.b_nmckdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmckdocno  #顯示到畫面上
            NEXT FIELD b_nmckdocno                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_nmckdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocdt
            #add-point:ON ACTION controlp INFIELD b_nmckdocdt name="construct.c.filter.page1.b_nmckdocdt"
            
            #END add-point
 
 
         #----<<b_nmck002>>----
         #Ctrlp:construct.c.filter.page1.b_nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck002
            #add-point:ON ACTION controlp INFIELD b_nmck002 name="construct.c.filter.page1.b_nmck002"
            
            #END add-point
 
 
         #----<<b_nmck003>>----
         #Ctrlp:construct.c.page1.b_nmck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck003
            #add-point:ON ACTION controlp INFIELD b_nmck003 name="construct.c.filter.page1.b_nmck003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck003  #顯示到畫面上
            NEXT FIELD b_nmck003                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_nmck003_desc>>----
         #----<<b_nmck004>>----
         #Ctrlp:construct.c.page1.b_nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck004
            #add-point:ON ACTION controlp INFIELD b_nmck004 name="construct.c.filter.page1.b_nmck004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck004  #顯示到畫面上
            NEXT FIELD b_nmck004                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_nmck004_desc>>----
         #----<<b_nmck005>>----
         #Ctrlp:construct.c.page1.b_nmck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck005
            #add-point:ON ACTION controlp INFIELD b_nmck005 name="construct.c.filter.page1.b_nmck005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck005  #顯示到畫面上
            NEXT FIELD b_nmck005                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_nmck005_desc>>----
         #----<<b_nmck006>>----
         #Ctrlp:construct.c.filter.page1.b_nmck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck006
            #add-point:ON ACTION controlp INFIELD b_nmck006 name="construct.c.filter.page1.b_nmck006"
            
            #END add-point
 
 
         #----<<b_nmck006_desc>>----
         #----<<b_nmck100>>----
         #Ctrlp:construct.c.page1.b_nmck100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck100
            #add-point:ON ACTION controlp INFIELD b_nmck100 name="construct.c.filter.page1.b_nmck100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck100  #顯示到畫面上
            NEXT FIELD b_nmck100                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_nmck103>>----
         #Ctrlp:construct.c.filter.page1.b_nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck103
            #add-point:ON ACTION controlp INFIELD b_nmck103 name="construct.c.filter.page1.b_nmck103"
            
            #END add-point
 
 
         #----<<b_nmck101>>----
         #Ctrlp:construct.c.filter.page1.b_nmck101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck101
            #add-point:ON ACTION controlp INFIELD b_nmck101 name="construct.c.filter.page1.b_nmck101"
            
            #END add-point
 
 
         #----<<b_nmck113>>----
         #Ctrlp:construct.c.filter.page1.b_nmck113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck113
            #add-point:ON ACTION controlp INFIELD b_nmck113 name="construct.c.filter.page1.b_nmck113"
            
            #END add-point
 
 
         #----<<glaa016>>----
         #----<<b_nmck121>>----
         #Ctrlp:construct.c.filter.page1.b_nmck121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck121
            #add-point:ON ACTION controlp INFIELD b_nmck121 name="construct.c.filter.page1.b_nmck121"
            
            #END add-point
 
 
         #----<<b_nmck123>>----
         #Ctrlp:construct.c.filter.page1.b_nmck123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck123
            #add-point:ON ACTION controlp INFIELD b_nmck123 name="construct.c.filter.page1.b_nmck123"
            
            #END add-point
 
 
         #----<<glaa020>>----
         #----<<b_nmck131>>----
         #Ctrlp:construct.c.filter.page1.b_nmck131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck131
            #add-point:ON ACTION controlp INFIELD b_nmck131 name="construct.c.filter.page1.b_nmck131"
            
            #END add-point
 
 
         #----<<b_nmck133>>----
         #Ctrlp:construct.c.filter.page1.b_nmck133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck133
            #add-point:ON ACTION controlp INFIELD b_nmck133 name="construct.c.filter.page1.b_nmck133"
            
            #END add-point
 
 
         #----<<b_nmck011>>----
         #Ctrlp:construct.c.filter.page1.b_nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck011
            #add-point:ON ACTION controlp INFIELD b_nmck011 name="construct.c.filter.page1.b_nmck011"
            
            #END add-point
 
 
         #----<<b_nmck012>>----
         #Ctrlp:construct.c.filter.page1.b_nmck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck012
            #add-point:ON ACTION controlp INFIELD b_nmck012 name="construct.c.filter.page1.b_nmck012"
            
            #END add-point
 
 
         #----<<b_nmck025>>----
         #Ctrlp:construct.c.filter.page1.b_nmck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck025
            #add-point:ON ACTION controlp INFIELD b_nmck025 name="construct.c.filter.page1.b_nmck025"
            
            #END add-point
 
 
         #----<<b_nmck013>>----
         #Ctrlp:construct.c.page1.b_nmck013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck013
            #add-point:ON ACTION controlp INFIELD b_nmck013 name="construct.c.filter.page1.b_nmck013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck013  #顯示到畫面上
            NEXT FIELD b_nmck013                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_nmck013_desc>>----
         #----<<b_nmck014>>----
         #Ctrlp:construct.c.filter.page1.b_nmck014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck014
            #add-point:ON ACTION controlp INFIELD b_nmck014 name="construct.c.filter.page1.b_nmck014"
            
            #END add-point
 
 
         #----<<b_nmck015>>----
         #Ctrlp:construct.c.filter.page1.b_nmck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck015
            #add-point:ON ACTION controlp INFIELD b_nmck015 name="construct.c.filter.page1.b_nmck015"
            
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
 
      CALL anmq440_filter_show('nmckstus','b_nmckstus')
   CALL anmq440_filter_show('nmckdocno','b_nmckdocno')
   CALL anmq440_filter_show('nmckdocdt','b_nmckdocdt')
   CALL anmq440_filter_show('nmck002','b_nmck002')
   CALL anmq440_filter_show('nmck003','b_nmck003')
   CALL anmq440_filter_show('nmck004','b_nmck004')
   CALL anmq440_filter_show('nmck005','b_nmck005')
   CALL anmq440_filter_show('nmck006','b_nmck006')
   CALL anmq440_filter_show('nmck100','b_nmck100')
   CALL anmq440_filter_show('nmck103','b_nmck103')
   CALL anmq440_filter_show('nmck101','b_nmck101')
   CALL anmq440_filter_show('nmck113','b_nmck113')
   CALL anmq440_filter_show('nmck121','b_nmck121')
   CALL anmq440_filter_show('nmck123','b_nmck123')
   CALL anmq440_filter_show('nmck131','b_nmck131')
   CALL anmq440_filter_show('nmck133','b_nmck133')
   CALL anmq440_filter_show('nmck011','b_nmck011')
   CALL anmq440_filter_show('nmck012','b_nmck012')
   CALL anmq440_filter_show('nmck025','b_nmck025')
   CALL anmq440_filter_show('nmck013','b_nmck013')
   CALL anmq440_filter_show('nmck014','b_nmck014')
   CALL anmq440_filter_show('nmck015','b_nmck015')
 
 
   CALL anmq440_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq440.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION anmq440_filter_parser(ps_field)
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
 
{<section id="anmq440.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq440_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq440_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="anmq440.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq440_detail_action_trans()
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
 
{<section id="anmq440.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq440_detail_index_setting()
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
            IF g_nmck_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmck_d.getLength() AND g_nmck_d.getLength() > 0
            LET g_detail_idx = g_nmck_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmck_d.getLength() THEN
               LET g_detail_idx = g_nmck_d.getLength()
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
 
{<section id="anmq440.mask_functions" >}
 &include "erp/anm/anmq440_mask.4gl"
 
{</section>}
 
{<section id="anmq440.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢條件初始化
# Memo...........:
# Usage..........: CALL anmq440_def()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/02 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq440_def()
   DEFINE l_wc       STRING   
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5
   IF cl_null(g_master_t.nmcksite) THEN
      LET g_master.sdate = g_today
      LET g_master.edate = g_today
      LET g_master.comb  = '20'
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_master.edate) RETURNING g_sub_success,g_master.nmcksite,g_errno
      LET g_master.nmcksite_desc = s_desc_get_department_desc(g_master.nmcksite)
      CALL s_anm_get_comp_wc('6',g_master.nmcksite,g_master.edate) RETURNING g_comp_wc
      SELECT ooef017 INTO g_master.nmckcomp FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_master.nmcksite
      LET g_master.nmckcomp_desc = s_desc_get_department_desc(g_master.nmckcomp)
      #160816-00012#4 Add  ---(S)---
      #检查用户是否有资金中心对应法人的权限
      CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
      LET l_count = 0
      LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                  "   AND ooef001 = '",g_master.nmckcomp,"'",
                  "   AND ooef003 = 'Y'",
                  "   AND ",l_wc CLIPPED
      PREPARE anmp410_count_prep FROM l_sql
      EXECUTE anmp410_count_prep INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET g_master.nmckcomp = ''
         LET g_master.nmckcomp_desc = ''    
      END IF
      #160816-00012#4 Add  ---(E)---
      DISPLAY BY NAME g_master.nmcksite_desc,g_master.nmckcomp_desc
      CALL anmq440_set_combo_scc('b_nmck002',g_master.comb)
   ELSE
      LET g_master.* = g_master_t.*
   END IF

   CALL anmq440_set_entry()

END FUNCTION

################################################################################
# Descriptions...: 根據法人主帳套確實是否顯示多本位幣
# Memo...........:
# Usage..........: CALL anmq440_set_entry()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/02 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq440_set_entry()
   DEFINE l_glaa015         LIKE glaa_t.glaa015
   DEFINE l_glaa019         LIKE glaa_t.glaa019

   IF cl_null(g_master.nmckcomp) THEN RETURN END IF

   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaacomp = g_master.nmckcomp
      AND glaa014  = 'Y'

   CALL cl_set_comp_visible('glaa016,b_nmck121,b_nmck123',FALSE)
   CALL cl_set_comp_visible('glaa020,b_nmck131,b_nmck133',FALSE)

   IF l_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('glaa016,b_nmck121,b_nmck123',TRUE)
   END IF

   IF l_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('glaa020,b_nmck131,b_nmck133',TRUE)
   END IF

END FUNCTION

################################################################################
# Descriptions...: 建立臨時表 for 報表
# Memo...........:
# Usage..........: CALL anmq440_create_tmp()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/02 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq440_create_tmp()

   DROP TABLE anmq440_tmp
   CREATE TEMP TABLE anmq440_tmp(
      nmckent       LIKE nmck_t.nmckent,
      nmckstus      LIKE nmck_t.nmckstus,
      nmckstus_desc LIKE type_t.chr500,
      nmckdocno     LIKE nmck_t.nmckdocno, 
      nmckdocdt     LIKE nmck_t.nmckdocdt, 
      nmck002       LIKE nmck_t.nmck002, 
      nmck002_desc  LIKE type_t.chr500,
      nmck003       LIKE nmck_t.nmck003, 
      nmck003_desc  LIKE type_t.chr500, 
      nmck004       LIKE nmck_t.nmck004, 
      nmck004_desc  LIKE type_t.chr500, 
      nmck005       LIKE nmck_t.nmck005, 
      nmck005_desc  LIKE type_t.chr500, 
      nmck006       LIKE nmck_t.nmck006, 
      nmck006_desc  LIKE type_t.chr500, 
      nmck100       LIKE nmck_t.nmck100, 
      nmck103       LIKE nmck_t.nmck103, 
      nmck101       LIKE nmck_t.nmck101, 
      nmck113       LIKE nmck_t.nmck113, 
      glaa016       LIKE type_t.chr10, 
      nmck121       LIKE nmck_t.nmck121, 
      nmck123       LIKE nmck_t.nmck123, 
      glaa020       LIKE type_t.chr10, 
      nmck131       LIKE nmck_t.nmck131, 
      nmck133       LIKE nmck_t.nmck133, 
      nmck011       LIKE nmck_t.nmck011, 
      nmck012       LIKE nmck_t.nmck012,    #161125-00036#5
      nmck025       LIKE nmck_t.nmck025, 
      nmck013       LIKE nmck_t.nmck013, 
      nmck013_desc  LIKE type_t.chr500, 
      nmck014       LIKE nmck_t.nmck014, 
      nmck015       LIKE nmck_t.nmck015)

END FUNCTION

################################################################################
# Descriptions...: 根據查詢條件將資料整批匯入臨時表
# Memo...........:
# Usage..........: CALL anmq440_b_ins_tmp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/07/02 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq440_b_ins_tmp()
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_sql             STRING
   DEFINE l_glaald          LIKE glaa_t.glaald
   DEFINE l_glaa001         LIKE glaa_t.glaa001
   DEFINE l_glaa016         LIKE glaa_t.glaa016
   DEFINE l_glaa020         LIKE glaa_t.glaa020
   DEFINE l_nmck002_desc    STRING
   DEFINE l_nmck003_desc    STRING
   DEFINE l_nmck004_desc    STRING
   DEFINE l_nmck005_desc    STRING
   DEFINE l_nmck006_desc    STRING
   DEFINE l_nmck013_desc    STRING
   DEFINE l_nmckstus_desc   STRING

   LET r_success = TRUE

   DELETE FROM anmq440_tmp

   SELECT glaald,glaa001,glaa016,glaa020 INTO l_glaald,l_glaa001,l_glaa016,l_glaa020 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaacomp = g_master.nmckcomp
      AND glaa014  = 'Y'

   LET l_nmck002_desc = "(SELECT CASE WHEN ooial003 IS NULL THEN '' ELSE ooial003 END FROM ooial_t  WHERE ooialent  = '",g_enterprise,"' AND ooial001  = nmck002 AND ooial002 = '",g_lang,"')"

   LET l_nmck003_desc = "(SELECT ooag011  FROM ooag_t  WHERE ooagent  = '",g_enterprise,"' AND ooag001  = nmck003)"

   LET l_nmck004_desc = "(SELECT nmaal003 FROM nmaal_t WHERE nmaalent = '",g_enterprise,"' AND nmaal001 IN (SELECT nmas001 FROM nmas_t WHERE nmasent = '",g_enterprise,"' AND nmas002 = nmck004) AND nmaal002 = '",g_dlang,"')"

   LET l_nmck005_desc = "(SELECT pmaal003 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = nmck005 AND pmaal002 = '",g_dlang,"')"

   LET l_nmck006_desc = "(SELECT ooag011  FROM ooag_t  WHERE ooagent  = '",g_enterprise,"' AND ooag001  = nmck006)"

   LET l_nmck013_desc = "(SELECT nmabl003 FROM nmabl_t WHERE nmablent = '",g_enterprise,"' AND nmabl001 = nmck013 AND nmabl002 = '",g_dlang,"')"

   LET l_nmckstus_desc= "(SELECT gzcbl002||':'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = nmckstus AND gzcbl003 = '",g_lang,"')"
    
   #161125-00036#5 mark-----s
   #LET l_sql = "INSERT INTO anmq440_tmp (",
   #            " nmck002,nmck003,nmck004,nmck005,nmck006,nmck011,nmck013,nmck014,nmck015,nmckdocno,nmckstus, ",
   #            " nmck025,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131,nmck133,nmckdocdt,nmckstus_desc, ",
   #            " glaa016,glaa020,nmck013_desc,nmck003_desc,nmck004_desc,nmck005_desc,nmck006_desc,nmck002_desc,nmckent)  ",
	#		      " SELECT nmck002,nmck003,nmck004,nmck005,nmck006,nmck011,nmck013,nmck014,nmck015,nmckdocno,nmckstus,
   #                     nmck025,nmck100,nmck103 - apde109,nmck101,nmck113 - apde119,nmck121,nmck123 - apde129,nmck131,nmck133 - apde139,nmckdocdt,",l_nmckstus_desc,",
   #                     '",l_glaa016,"','",l_glaa020,"',",l_nmck013_desc,",",l_nmck003_desc,",",l_nmck004_desc,",",l_nmck005_desc,",",l_nmck006_desc,",nmck002||':'||",l_nmck002_desc,",nmckent
   #                FROM (SELECT nmck002,nmck003,nmck004,nmck005,nmck006,nmck011,nmck013,nmck014,nmck015,nmckdocno,nmckstus,
   #                             nmck025,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131,nmck133,nmckdocdt,nmckent,
   #                            (SELECT CASE WHEN SUM (apde109) IS NULL THEN 0 ELSE SUM (apde109) END
   #                               FROM apda_t, apde_t   WHERE     apdaent = apdeent
   #                                AND apdadocno = apdedocno      AND apdald = apdeld
   #                                AND apdastus = 'N'             AND apde003 = nmckdocno
   #                                AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde109,
   #                            (SELECT CASE WHEN SUM (apde119) IS NULL THEN 0 ELSE SUM (apde119) END
   #                               FROM apda_t, apde_t   WHERE     apdaent = apdeent
   #                                AND apdadocno = apdedocno      AND apdald = apdeld
   #                                AND apdastus = 'N'             AND apde003 = nmckdocno
   #                                AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde119,
   #                            (SELECT CASE WHEN SUM (apde129) IS NULL THEN 0 ELSE SUM (apde129) END
   #                               FROM apda_t, apde_t   WHERE     apdaent = apdeent
   #                                AND apdadocno = apdedocno      AND apdald = apdeld
   #                                AND apdastus = 'N'             AND apde003 = nmckdocno
   #                                AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde129,
   #                            (SELECT CASE WHEN SUM (apde129) IS NULL THEN 0 ELSE SUM (apde129) END
   #                               FROM apda_t, apde_t   WHERE     apdaent = apdeent
   #                                AND apdadocno = apdedocno      AND apdald = apdeld
   #                                AND apdastus = 'N'             AND apde003 = nmckdocno
   #                                AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde139
   #                        FROM nmck_t
   #                       WHERE nmckent = '",g_enterprise,"' AND nmck001 = 'XX' AND nmckstus = 'Y'
   #                         AND nmckcomp = '",g_master.nmckcomp,"'
   #                         AND nmcksite = '",g_master.nmcksite,"'
   #                         AND nmckdocdt BETWEEN '",g_master.sdate,"' AND '",g_master.edate,"'
   #                         AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '",g_master.comb,"' AND ooiaent = '",g_enterprise,"')
   #                         AND ( (nmck023 = '20' AND nmck026 = '11' AND nmck043 = 'Y')
   #                            OR (nmck023 = '30' AND nmck025 IS NOT NULL)))
   #               WHERE nmck103 - apde109 > 0"
   #161125-00036#5 mark-----e
   #161125-00036#5-----s
LET l_sql = "INSERT INTO anmq440_tmp (",
               " nmck002,nmck003,nmck004,nmck005,nmck006,nmck011,nmck012,nmck013,nmck014,nmck015,nmckdocno,nmckstus, ",
               " nmck025,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131,nmck133,nmckdocdt,nmckstus_desc, ",
               " glaa016,glaa020,nmck013_desc,nmck003_desc,nmck004_desc,nmck005_desc,nmck006_desc,nmck002_desc,nmckent)  ",
			      " SELECT nmck002,nmck003,nmck004,nmck005,nmck006,nmck011,nmck012,nmck013,nmck014,nmck015,nmckdocno,nmckstus, ",
               "        nmck025,nmck100,nmck103 - apde109,nmck101,nmck113 - apde119,nmck121,nmck123 - apde129,nmck131,nmck133 - apde139,nmckdocdt,",l_nmckstus_desc,", ",
               "        '",l_glaa016,"','",l_glaa020,"',",l_nmck013_desc,",",l_nmck003_desc,",",l_nmck004_desc,",",l_nmck005_desc,",",l_nmck006_desc,",nmck002||':'||",l_nmck002_desc,",nmckent ",
               "    FROM (SELECT nmck002,nmck003,nmck004,nmck005,nmck006,nmck011,nmck012,nmck013,nmck014,nmck015,nmckdocno,nmckstus, ",
               "                 nmck025,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131,nmck133,nmckdocdt,nmckent, ",
               "                (SELECT CASE WHEN SUM (apde109) IS NULL THEN 0 ELSE SUM (apde109) END ",
               "                   FROM apda_t, apde_t   WHERE     apdaent = apdeent ",
               "                    AND apdadocno = apdedocno      AND apdald = apdeld ",
               "                   AND apdastus = 'N'             AND apde003 = nmckdocno ",
               "                   AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde109, ",
               "                (SELECT CASE WHEN SUM (apde119) IS NULL THEN 0 ELSE SUM (apde119) END ",
               "                   FROM apda_t, apde_t   WHERE     apdaent = apdeent ",
               "                    AND apdadocno = apdedocno      AND apdald = apdeld ",
               "                    AND apdastus = 'N'             AND apde003 = nmckdocno ",
               "                    AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde119, ",
               "                (SELECT CASE WHEN SUM (apde129) IS NULL THEN 0 ELSE SUM (apde129) END ",
               "                   FROM apda_t, apde_t   WHERE     apdaent = apdeent ",
               "                   AND apdadocno = apdedocno      AND apdald = apdeld ",
               "                   AND apdastus = 'N'             AND apde003 = nmckdocno ",
               "                   AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde129, ",
               "                 (SELECT CASE WHEN SUM (apde129) IS NULL THEN 0 ELSE SUM (apde129) END ",
               "                   FROM apda_t, apde_t   WHERE     apdaent = apdeent ",
               "                    AND apdadocno = apdedocno      AND apdald = apdeld ",
               "                    AND apdastus = 'N'             AND apde003 = nmckdocno ",
               "                    AND apdald = '",l_glaald,"'    AND apdeent = '",g_enterprise,"') apde139 ",
               "            FROM nmck_t ",
               "          WHERE nmckent = '",g_enterprise,"' AND nmck001 = 'XX' AND nmckstus = 'Y' ",
               "             AND nmckcomp = '",g_master.nmckcomp,"' ",
               "            AND nmcksite = '",g_master.nmcksite,"' ",
               "             AND nmckdocdt BETWEEN '",g_master.sdate,"' AND '",g_master.edate,"' ",
               "             AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '",g_master.comb,"' AND ooiaent = '",g_enterprise,"') ",
               "             AND ( (nmck023 = '20' AND nmck026 = '11' AND nmck043 = 'Y') ",
               "                OR (nmck023 = '30' AND nmck025 IS NOT NULL))) ",
               "   WHERE nmck103 - apde109 > 0 "
   #161125-00036#5-----e
   PREPARE anmq440_prep FROM l_sql
   EXECUTE anmq440_prep

END FUNCTION

################################################################################
# Descriptions...: 設置票據類別下拉框內容
# Memo...........:
# Usage..........: CALL anmq440_set_combo_scc(p_field,p_scc)
# Input parameter: p_field        欄位代號
#                : p_scc          scc碼
# Date & Author..: 2016/07/05 By  01727
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq440_set_combo_scc(p_field,p_scc)
   DEFINE p_field        LIKE type_t.chr80
   DEFINE p_scc          LIKE type_t.chr10
   DEFINE ps_values      STRING
   DEFINE ps_items       STRING
   DEFINE pc_ooia001     LIKE ooia_t.ooia001      
   DEFINE pc_ooial003    LIKE ooial_t.ooial003  
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE ps_field_name  STRING
   DEFINE lcbo_target    ui.ComboBox
   DEFINE ls_temp        STRING
   DEFINE l_sql          STRING
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING,
             label_tag   STRING,
             label       STRING
                   END RECORD

   LET l_sql = "SELECT ooia001,ooial003",
               "  FROM ooia_t LEFT JOIN ooial_t   ON ooial001 = ooia001",
               "                                 AND ooial002 = '",g_lang,"'",
               "                                 AND ooiaent = ooialent",
               "                                 AND ooiaent = ",g_enterprise,
               " WHERE ooia002 = '",p_scc,"' AND ooiaent=",g_enterprise,
               " ORDER BY ooia001"
   PREPARE p_scc_itemp_pe FROM l_sql
   DECLARE p_scc_itemp_cs CURSOR FOR p_scc_itemp_pe

   LET ps_values = ''
   LET ps_items = ''

   #將選項填入陣列
   LET li_cnt = 1
   FOREACH p_scc_itemp_cs INTO pc_ooia001, pc_ooial003
      LET pa_array[li_cnt].value = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label_tag = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label = pc_ooial003 CLIPPED
      LET li_cnt = li_cnt + 1
   END FOREACH

   LET ps_field_name = p_field

   LET ps_field_name = ps_field_name.trim()

   LET lcbo_target = ui.ComboBox.forName(ps_field_name)
   CALL lcbo_target.clear()

   #以下是Combobox的處理
   FOR li_cnt = 1 TO pa_array.getLength()
       IF cl_null(pa_array[li_cnt].label_tag) THEN
          LET ls_temp = pa_array[li_cnt].label
       ELSE
          LET ls_temp = pa_array[li_cnt].label_tag,":",pa_array[li_cnt].label
       END IF
      CALL lcbo_target.addItem(pa_array[li_cnt].value,ls_temp)
   END FOR

END FUNCTION

 
{</section>}
 
