#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq831.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-10-21 14:30:46), PR版次:0004(2016-11-01 14:23:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: apmq831
#+ Description: 要貨追蹤查詢作業
#+ Creator....: 06137(2014-12-10 09:12:45)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="apmq831.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#11   2016/10/21 by sakura 整批修改組織
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
PRIVATE TYPE type_g_pmdb_d RECORD
       
       sel LIKE type_t.chr1, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   pmdbsite_desc LIKE type_t.chr500, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb048_desc LIKE type_t.chr500, 
   pmdb200 LIKE pmdb_t.pmdb200, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb004_desc LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   imaa009_desc LIKE type_t.chr500, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb037_desc LIKE type_t.chr500, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb038_desc LIKE type_t.chr500, 
   pmdb201 LIKE pmdb_t.pmdb201, 
   pmdb201_desc LIKE type_t.chr500, 
   pmdb202 LIKE pmdb_t.pmdb202, 
   pmdb212 LIKE pmdb_t.pmdb212, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb007_desc LIKE type_t.chr500, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb208 LIKE pmdb_t.pmdb208, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb015_desc LIKE type_t.chr500, 
   pmdb207 LIKE pmdb_t.pmdb207, 
   pmdb206 LIKE pmdb_t.pmdb206, 
   pmdb206_desc LIKE type_t.chr500, 
   pmdb209 LIKE pmdb_t.pmdb209, 
   pmdb209_desc LIKE type_t.chr500, 
   pmdb210 LIKE pmdb_t.pmdb210, 
   pmdb211 LIKE pmdb_t.pmdb211, 
   pmdb205 LIKE pmdb_t.pmdb205, 
   pmdb205_desc LIKE type_t.chr500, 
   pmdb203 LIKE pmdb_t.pmdb203, 
   pmdb203_desc LIKE type_t.chr500, 
   pmdb204 LIKE pmdb_t.pmdb204, 
   pmdb204_desc LIKE type_t.chr500, 
   pmdbdocno LIKE pmdb_t.pmdbdocno, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdasite LIKE pmda_t.pmdasite, 
   pmdasite_desc LIKE type_t.chr500, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda002_desc LIKE type_t.chr500, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda003_desc LIKE type_t.chr500, 
   pmdastus LIKE pmda_t.pmdastus
       END RECORD
PRIVATE TYPE type_g_pmdb2_d RECORD
       pmdpdocno LIKE pmdp_t.pmdpdocno, 
   pmdldocdt LIKE pmdl_t.pmdldocdt, 
   pmdl004 LIKE pmdl_t.pmdl004, 
   pmdl004_desc LIKE type_t.chr500, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl002_desc LIKE type_t.chr500, 
   pmdpseq LIKE pmdp_t.pmdpseq, 
   pmdp001 LIKE pmdp_t.pmdp001, 
   pmdp001_desc LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   pmdp002 LIKE pmdp_t.pmdp002, 
   pmdp024 LIKE pmdp_t.pmdp024, 
   pmdp025 LIKE pmdp_t.pmdp025, 
   pmdp026 LIKE pmdp_t.pmdp026, 
   pmdo013 LIKE pmdo_t.pmdo013, 
   pmdn020 LIKE pmdn_t.pmdn020, 
   pmdnunit LIKE pmdn_t.pmdnunit, 
   pmdnunit_desc LIKE type_t.chr500, 
   pmdnsite LIKE pmdn_t.pmdnsite, 
   pmdnsite_desc LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_pmdb3_d RECORD
       pmdvdocno LIKE pmdv_t.pmdvdocno, 
   pmdvseq LIKE pmdv_t.pmdvseq, 
   pmdvseq1 LIKE pmdv_t.pmdvseq1, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmdvsite LIKE pmdv_t.pmdvsite, 
   pmdvsite_desc LIKE type_t.chr500, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds007_desc LIKE type_t.chr500, 
   pmdv001 LIKE pmdv_t.pmdv001, 
   pmdv001_desc LIKE type_t.chr500, 
   imaal004 LIKE imaal_t.imaal004, 
   pmdv002 LIKE pmdv_t.pmdv002, 
   pmdv018 LIKE pmdv_t.pmdv018, 
   pmdv018_desc LIKE type_t.chr500, 
   pmdv019 LIKE pmdv_t.pmdv019
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_pmdb5_d RECORD
       pmdvdocno LIKE pmdv_t.pmdvdocno, 
   pmdvseq LIKE pmdv_t.pmdvseq, 
   pmdvseq1 LIKE pmdv_t.pmdvseq1, 
   pmdsdocdt LIKE pmds_t.pmdsdocdt, 
   pmdvsite LIKE pmdv_t.pmdvsite, 
   pmdvsite_desc LIKE type_t.chr500, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds007_desc LIKE type_t.chr500, 
   pmdv001 LIKE pmdv_t.pmdv001, 
   pmdv001_desc LIKE type_t.chr500, 
   imaal004 LIKE imaal_t.imaal004, 
   pmdv002 LIKE pmdv_t.pmdv002, 
   pmdv018 LIKE pmdv_t.pmdv018, 
   pmdv018_desc LIKE type_t.chr500, 
   pmdv019 LIKE pmdv_t.pmdv019
       END RECORD
       
DEFINE g_pmdb5_d     DYNAMIC ARRAY OF type_g_pmdb5_d
DEFINE g_pmdb5_d_t   type_g_pmdb5_d

DEFINE g_wc2_table5   STRING
DEFINE g_wc2_filter_table5   STRING

 TYPE type_tm        RECORD
    l_pmdp026            LIKE type_t.chr1
                   END RECORD
DEFINE tm              type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmdb_d            DYNAMIC ARRAY OF type_g_pmdb_d
DEFINE g_pmdb_d_t          type_g_pmdb_d
DEFINE g_pmdb2_d     DYNAMIC ARRAY OF type_g_pmdb2_d
DEFINE g_pmdb2_d_t   type_g_pmdb2_d
 
DEFINE g_pmdb3_d     DYNAMIC ARRAY OF type_g_pmdb3_d
DEFINE g_pmdb3_d_t   type_g_pmdb3_d
 
 
 
 
 
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
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
DEFINE g_wc2_filter_table3   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmq831.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
   DECLARE apmq831_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq831_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq831_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq831 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq831_init()   
 
      #進入選單 Menu (="N")
      CALL apmq831_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq831
      
   END IF 
   
   CLOSE apmq831_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq831.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq831_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('b_pmdastus','13','Y,N,TJ,C,A,D,R,W,UH,H,X')
 
      CALL cl_set_combo_scc('b_pmdb208','6013') 
   CALL cl_set_combo_scc('b_pmdb207','6014') 
   CALL cl_set_combo_scc('b_pmdn020','2036') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL cl_set_combo_scc_part('pmdastus','13','N,X,Y,C,A,D,R,W')
   CALL cl_set_combo_scc('pmdb207','6014') 

   LET tm.l_pmdp026 = '0'
   #end add-point
 
   CALL apmq831_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq831.default_search" >}
PRIVATE FUNCTION apmq831_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
 
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmdbdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " pmdbseq = '", g_argv[02], "' AND "
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
 
{<section id="apmq831.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq831_ui_dialog() 
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
 
   
   CALL apmq831_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmdb_d.clear()
         CALL g_pmdb2_d.clear()
 
         CALL g_pmdb3_d.clear()
 
 
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
 
         CALL apmq831_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME tm.l_pmdp026 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pmdasite,pmdbdocno,pmdbsite,pmdb030,pmdadocdt,pmda002,pmdb207,pmdb205,pmdb203,pmdb037,pmdb015,pmdb004,pmdastus,pmdb049   #160604-00009#99 Add By Ken 160624
         
            #要貨組織
            ON ACTION controlp INFIELD pmdasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO pmdasite
               NEXT FIELD pmdasite
            
            #要貨單號            
            ON ACTION controlp INFIELD pmdbdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmdadocno()
               DISPLAY g_qryparam.return1 TO pmdbdocno
               NEXT FIELD pmdbdocno   

            #需求組織
            ON ACTION controlp INFIELD pmdbsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO pmdbsite
               NEXT FIELD pmdbsite
               
            #申請人員   
            ON ACTION controlp INFIELD pmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmda002
               NEXT FIELD pmda002                 
               
            #採購中心   
            ON ACTION controlp INFIELD pmdb205
               IF s_aooi500_setpoint(g_prog,'pmdb205') THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb205',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
                  CALL q_ooef001_24()
                  DISPLAY g_qryparam.return1 TO pmdb205
                  NEXT FIELD pmdb205
               ELSE    
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "ooef303 = 'Y'"
                  CALL q_ooef001()
                  DISPLAY g_qryparam.return1 TO pmdb205
                  NEXT FIELD pmdb205   
               END IF                  

            #配送中心
            ON ACTION controlp INFIELD pmdb203
               IF s_aooi500_setpoint(g_prog,'pmdb203') THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb203',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
                  CALL q_ooef001_24()
                  DISPLAY g_qryparam.return1 TO pmdb203
                  NEXT FIELD pmdb203
               ELSE    
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = "ooef302 = 'Y'"
                  CALL q_ooef001()
                  DISPLAY g_qryparam.return1 TO pmdb203
                  NEXT FIELD pmdb203 
               END IF                  

            #收貨組織
            ON ACTION controlp INFIELD pmdb037
               IF s_aooi500_setpoint(g_prog,'pmdb037') THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb037',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
                  CALL q_ooef001_24()
                  DISPLAY g_qryparam.return1 TO pmdb037
                  NEXT FIELD pmdb037
               ELSE    
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  #161006-00008#11 by sakura mark(S)
                  #LET g_qryparam.where = "ooef210 = 'Y' "   #採購組織
                  #CALL q_ooef001()
                  #161006-00008#11 by sakura mark(E)
                  #161006-00008#11 by sakura add(S)          
                  LET g_qryparam.arg1 = g_site
                  LET g_qryparam.arg2 = 8
                  CALL q_ooed004_3()                  
                  #161006-00008#11 by sakura add(E)                  
                  DISPLAY g_qryparam.return1 TO pmdb037  
                  NEXT FIELD pmdb037                    
               END IF      
               
            #供應商編號
            ON ACTION controlp INFIELD pmdb015
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()
               DISPLAY g_qryparam.return1 TO pmdb015
               NEXT FIELD pmdb015    

            #商品編號
            ON ACTION controlp INFIELD pmdb004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()
               DISPLAY g_qryparam.return1 TO pmdb004
               NEXT FIELD pmdb004  
                           

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_pmdb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq831_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq831_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_pmdb2_d TO s_detail2.*
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
 
         DISPLAY ARRAY g_pmdb3_d TO s_detail3.*
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
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         DISPLAY ARRAY g_pmdb5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 4
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx          
         END DISPLAY
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apmq831_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
            #end add-point
            NEXT FIELD pmdasite
 
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
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
            IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table3
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL apmq831_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmdb_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_pmdb2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_pmdb3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               #ken---add---s
               LET g_export_node[4] = base.typeInfo.create(g_pmdb5_d)
               LET g_export_id[4]   = "s_detail5"
               #ken---add---e
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq831_b_fill()
 
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
            CALL apmq831_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq831_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq831_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq831_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               LET g_pmdb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               LET g_pmdb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmdb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmdb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq831_filter()
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
 
{<section id="apmq831.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq831_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_input01       STRING
   DEFINE l_where         STRING   #161006-00008#11 by sakura add
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #161006-00008#11 by sakura add(S)
   CALL s_aooi500_sql_where(g_prog,'pmdasite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET g_wc  = g_wc.trim()
   #161006-00008#11 by sakura add(E)
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
 
   CALL g_pmdb_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',pmdbsite,'',pmdb030,pmdb048,'',pmdb200,pmdb004,pmdb005,'','', 
       '','',pmdb037,'',pmdb038,'',pmdb201,'',pmdb202,pmdb212,pmdb007,'',pmdb006,pmdb049,pmdb208,pmdb015, 
       '',pmdb207,pmdb206,'',pmdb209,'',pmdb210,pmdb211,pmdb205,'',pmdb203,'',pmdb204,'',pmdbdocno,pmdbseq, 
       '','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq) AS RANK FROM pmdb_t", 
 
 
#table2
                     " LEFT JOIN pmdp_t ON pmdpent = pmdbent AND pmdbdocno = pmdpdocno AND pmdbseq = pmdpseq AND  = pmdpseq1",
#table3
                     " LEFT JOIN pmdv_t ON pmdvent = pmdbent AND pmdbdocno = pmdvdocno AND pmdbseq = pmdvseq AND  = pmdvseq1",
 
                     "",
                     " WHERE pmdbent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmdb_t"),
                     " ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150907 add by beckxie---S
   LET ls_sql_rank = "SELECT UNIQUE 'N',pmdbsite,",
               "             (SELECT ooefl003",
               "                FROM ooefl_t",
               "               WHERE pmdbent = ooeflent AND pmdbsite = ooefl001 ",
               "                 AND ooefl002 = '",g_dlang,"') pmdbsite_desc,",  #需求組織說明
               "             pmdb030,pmdb048,",
               "             (SELECT oocql004",
               "                FROM oocql_t",
               "               WHERE pmdbent = oocqlent AND oocql001 = '274' AND pmdb048 = oocql002 ",
               "                 AND oocql003 = '",g_dlang,"') pmdb048_desc, ",  #收貨時段說明      
               "             pmdb200,pmdb004,pmdb005,",
               "             (SELECT imaal003",
               "                FROM imaal_t",
               "               WHERE pmdbent = imaalent AND pmdb004 = imaal001 ",
               "                 AND imaal002 = '",g_dlang,"') pmdb005_desc, ",  #品名         
               "             (SELECT imaal004",
               "                FROM imaal_t",
               "               WHERE pmdbent = imaalent AND pmdb004 = imaal001 ",
               "                 AND imaal002 = '",g_dlang,"') pmdb005_desc_desc, ",  #規格
               "             imaa009,",
               "             (SELECT rtaxl003",
               "                FROM rtaxl_t",
               "               WHERE imaaent = rtaxlent AND imaa009 = rtaxl001 ",
               "                 AND rtaxl002= '",g_dlang,"') imaa009_desc,",  #品類說明
               "             pmdb037,",
               "             (SELECT ooefl003",
               "                FROM ooefl_t",
               "               WHERE pmdbent = ooeflent AND pmdb037 = ooefl001 ",
               "                 AND ooefl002 = '",g_dlang,"') pmdb037_desc, ",  #收貨組織說明
               "             pmdb038,",
               "             (SELECT inayl003",
               "                FROM inayl_t",
               "               WHERE pmdbent = inaylent AND pmdb038 = inayl001 ",
               "                 AND inayl002 = '",g_dlang,"') pmdb038_desc,",  #庫位說明
               "             pmdb201,",
               "             (SELECT oocal003",
               "                FROM oocal_t",
               "               WHERE pmdbent = oocalent AND pmdb201 = oocal001 ",
               "                 AND oocal002 = '",g_dlang,"') pmdb201_desc,",  #包裝單位說明
               "             pmdb202,pmdb212,pmdb007, ",
               "             (SELECT oocal003",
               "                FROM oocal_t",
               "               WHERE pmdbent = oocalent AND pmdb007 = oocal001 ",
               "                 AND oocal002 = '",g_dlang,"') pmdb007_desc,",  #要貨單位說明
               "             pmdb006,pmdb049,pmdb208,pmdb015,",
               "             (SELECT pmaal004",
               "                FROM pmaal_t",
               "               WHERE pmdbent = pmaalent AND pmdb015 = pmaal001 ",
               "                 AND pmaal002 = '",g_dlang,"') pmdb015_desc,",  #供應商說明
               "             pmdb207,pmdb206,",
               "             (SELECT ooag011",
               "                FROM ooag_t",
               "               WHERE pmdbent = ooagent AND pmdb206 = ooag001) pmdb206_desc,",  #採購人員全名
               "              pmdb209,",
               "             (SELECT staal003",
               "                FROM staal_t",
               "               WHERE pmdbent = staalent AND pmdb209 = staal001 ",
               "                 AND staal002 = '",g_dlang,"') pmdb209_desc,",  #結算方式說明           
               "             pmdb210,pmdb211,pmdb205,",
               "             (SELECT ooefl003",
               "                FROM ooefl_t",
               "               WHERE pmdbent = ooeflent AND pmdb205 = ooefl001",
               "                 AND ooefl002 = '",g_dlang,"') pmdb205_desc,",  #採購中心說明
               "             pmdb203,",
               "             (SELECT ooefl003",
               "                FROM ooefl_t",
               "               WHERE pmdbent = ooeflent AND pmdb203 = ooefl001 ",
               "                 AND ooefl002 = '",g_dlang,"') pmdb203_desc,",  #配送中心說明
               "             pmdb204,",
               "             (SELECT inayl003",
               "                FROM inayl_t",
               "               WHERE pmdbent = inaylent AND pmdb204 = inayl001 ",
               "                 AND inayl002 = '",g_dlang,"') pmdb204_desc,",  #配送倉庫說明
               "             pmdbdocno,pmdbseq,pmdasite,",
               "             (SELECT ooefl003",
               "                FROM ooefl_t",
               "               WHERE pmdaent = ooeflent AND pmdasite = ooefl001 ",
               "                 AND ooefl002 = '",g_dlang,"') pmdasite_desc,",  #要貨組織說明
               "             pmdadocdt,pmda002,",
               "             (SELECT ooag011",
               "                FROM ooag_t",
               "               WHERE pmdaent = ooagent AND pmda002 = ooag001) pmda002_desc,",  #申請人員全名
               "             pmda003,",
               "             (SELECT ooefl003",
               "                FROM ooefl_t",
               "               WHERE pmdaent = ooeflent AND pmda003 = ooefl001 ",
               "                 AND ooefl002 = '",g_dlang,"') pmda003_desc,",  #申請部門說明
               "             pmdastus, ",
               "             DENSE_RANK() OVER( ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq) AS RANK",
               "  FROM pmda_t ",  #請購單單頭頭檔
               "      ,imaa_t ",  #料件主檔
               "      ,pmdb_t ",  #請購單明細檔
               " WHERE pmdaent   = ? ",
               "   AND pmdaent   = pmdbent ",
               "   AND pmdadocno = pmdbdocno ",
               "   AND pmdaent   = imaaent ",
               "   AND pmdb004   = imaa001 ",
               "   AND ",ls_wc
               
      LET l_input01 = "(SELECT SUM(COALESCE(pmdp026,0)) ",
               "  FROM pmdp_t ",
               " WHERE pmdbent=pmdpent AND pmdbdocno=pmdp003 AND pmdbseq=pmdp004) "
   CASE tm.l_pmdp026
      WHEN '0'  #全部
         LET l_input01 = ' 1=1 '
      WHEN '1'  #要貨量 = 入庫量
         LET l_input01 = " pmdb006 = " ,l_input01
      WHEN '2'  #要貨量 < 入庫量
         LET l_input01 = " pmdb006 < " ,l_input01
      WHEN '3'  #要貨量 > 入庫量
         LET l_input01 = " pmdb006 > " ,l_input01
      OTHERWISE EXIT CASE
   END CASE
   
   LET ls_sql_rank = ls_sql_rank," AND ",l_input01
   LET ls_sql_rank = ls_sql_rank,cl_sql_add_filter("pmda_t"),
              " ORDER BY pmdbdocno,pmdadocdt,pmdbseq  "
   #150826-00013#1 效能調整 20150907 add by beckxie---E
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
 
   LET g_sql = "SELECT '',pmdbsite,'',pmdb030,pmdb048,'',pmdb200,pmdb004,pmdb005,'','','','',pmdb037, 
       '',pmdb038,'',pmdb201,'',pmdb202,pmdb212,pmdb007,'',pmdb006,pmdb049,pmdb208,pmdb015,'',pmdb207, 
       pmdb206,'',pmdb209,'',pmdb210,pmdb211,pmdb205,'',pmdb203,'',pmdb204,'',pmdbdocno,pmdbseq,'','', 
       '','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   #150826-00013#1 效能調整 20150907 mark by beckxie---S
   #LET g_sql = "SELECT UNIQUE 'N',pmdbsite,t1.ooefl003,pmdb030,pmdb048,t2.oocql004,pmdb200,pmdb004,pmdb005,t3.imaal003,t3.imaal004, ",
   #            "              imaa009,t4.rtaxl003,pmdb037,t5.ooefl003,pmdb038,t6.inayl003,pmdb201,t7.oocal003,pmdb202,pmdb212, ",
   #            "              pmdb007,t8.oocal003,pmdb006,pmdb049,pmdb208,pmdb015,t9.pmaal004,pmdb207,pmdb206,t10.ooag011, ",
   #            "              pmdb209,t11.staal003,pmdb210,pmdb211,pmdb205,t12.ooefl003,pmdb203,t13.ooefl003,pmdb204,t14.inayl003, ",
   #            "              pmdbdocno,pmdbseq,pmdasite,t15.ooefl003,pmdadocdt,pmda002,t16.ooag011,pmda003,t17.ooefl003,pmdastus ",
   #            "  FROM pmda_t ",  #請購單單頭頭檔
   #            "     LEFT OUTER JOIN ooefl_t t15 ON pmdaent = t15.ooeflent AND pmdasite = t15.ooefl001 AND t15.ooefl002 = '",g_dlang,"' ",  #要貨組織說明
   #            "     LEFT OUTER JOIN ooag_t  t16 on pmdaent = t16.ooagent AND pmda002 = t16.ooag001 ",  #申請人員全名
   #            "     LEFT OUTER JOIN ooefl_t t17 ON pmdaent = t17.ooeflent AND pmda003 = t17.ooefl001 AND t17.ooefl002 = '",g_dlang,"' ",  #申請部門說明
   #            "      ,imaa_t ",  #料件主檔
   #            "     LEFT OUTER JOIN rtaxl_t t4 on imaaent = t4.rtaxlent AND imaa009 = t4.rtaxl001 AND t4.rtaxl002= '",g_dlang,"' ",  #品類說明
   #            "      ,pmdb_t ",  #請購單明細檔
   #            "     LEFT OUTER JOIN ooefl_t t1 ON pmdbent = t1.ooeflent AND pmdbsite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #需求組織說明
   #            "     LEFT OUTER JOIN oocql_t t2 ON pmdbent = t2.oocqlent AND oocql001 = '274' AND pmdb048 = t2.oocql002 AND t2.oocql003 = '",g_dlang,"' ",  #收貨時段說明           
   #            "     LEFT OUTER JOIN imaal_t t3 on pmdbent = t3.imaalent AND pmdb004 = t3.imaal001 AND t3.imaal002 = '",g_dlang,"' ",  #品名、規格              
   #            "     LEFT OUTER JOIN ooefl_t t5 ON pmdbent = t5.ooeflent AND pmdb037 = t5.ooefl001 AND t5.ooefl002 = '",g_dlang,"' ",  #收貨組織說明
   #            "     LEFT OUTER JOIN inayl_t t6 on pmdbent = t6.inaylent AND pmdb038 = t6.inayl001 AND t6.inayl002 = '",g_dlang,"' ",  #庫位說明
   #            "     LEFT OUTER JOIN oocal_t t7 on pmdbent = t7.oocalent AND pmdb201 = t7.oocal001 AND t7.oocal002 = '",g_dlang,"' ",  #包裝單位說明
   #            "     LEFT OUTER JOIN oocal_t t8 on pmdbent = t8.oocalent AND pmdb007 = t8.oocal001 AND t8.oocal002 = '",g_dlang,"' ",  #要貨單位說明
   #            "     LEFT OUTER JOIN pmaal_t t9 on pmdbent = t9.pmaalent AND pmdb015 = t9.pmaal001 AND t9.pmaal002 = '",g_dlang,"' ",  #供應商說明
   #            "     LEFT OUTER JOIN ooag_t  t10 on pmdbent = t10.ooagent AND pmdb206 = t10.ooag001 ",  #採購人員全名
   #            "     LEFT OUTER JOIN staal_t t11 on pmdbent = t11.staalent AND pmdb209 = t11.staal001 AND t11.staal002 = '",g_dlang,"' ",  #結算方式說明           
   #            "     LEFT OUTER JOIN ooefl_t t12 ON pmdbent = t12.ooeflent AND pmdb205 = t12.ooefl001 AND t12.ooefl002 = '",g_dlang,"' ",  #採購中心說明
   #            "     LEFT OUTER JOIN ooefl_t t13 ON pmdbent = t13.ooeflent AND pmdb203 = t13.ooefl001 AND t13.ooefl002 = '",g_dlang,"' ",  #配送中心說明
   #            "     LEFT OUTER JOIN inayl_t t14 on pmdbent = t14.inaylent AND pmdb204 = t14.inayl001 AND t14.inayl002 = '",g_dlang,"' ",  #配送倉庫說明
   #            " WHERE pmdaent   = ? ",
   #            "   AND pmdaent   = pmdbent ",
   #            "   AND pmdadocno = pmdbdocno ",
   #            "   AND pmdaent   = imaaent ",
   #            "   AND pmdb004   = imaa001 ",
   #            "   AND ",ls_wc
   #            
   #   LET l_input01 = "(SELECT sum(COALESCE(pmdp026,0)) ",
   #            "  FROM pmdp_t ",
   #            " WHERE pmdbent=pmdpent AND pmdbdocno=pmdp003 AND pmdbseq=pmdp004) "
   #CASE tm.l_pmdp026
   #   WHEN '0'  #全部
   #      LET l_input01 = ' 1=1 '
   #   WHEN '1'  #要貨量 = 入庫量
   #      LET l_input01 = " pmdb006 = " ,l_input01
   #   WHEN '2'  #要貨量 < 入庫量
   #      LET l_input01 = " pmdb006 < " ,l_input01
   #   WHEN '3'  #要貨量 > 入庫量
   #      LET l_input01 = " pmdb006 > " ,l_input01
   #   OTHERWISE EXIT CASE
   #END CASE
   #
   #LET g_sql = g_sql," AND ",l_input01
   #LET g_sql = g_sql, cl_sql_add_filter("pmda_t"),
   #            " ORDER BY pmdb_t.pmdbdocno,pmda_t.pmdadocdt,pmdb_t.pmdbseq  "
   #150826-00013#1 效能調整 20150907 mark by beckxie---E
   #150826-00013#1 效能調整 20150907 add by beckxie---S
   #LET g_sql = "SELECT   UNIQUE 'N',",
   #            "    pmdbsite,pmdbsite_desc,pmdb030,pmdb048     ,pmdb048_desc,",
   #            "     pmdb200,pmdb004      ,pmdb005,pmdb005_desc,pmdb005_desc_desc,",
   #            "     imaa009,imaa009_desc ,pmdb037,pmdb037_desc,pmdb038,",
   #            "pmdb038_desc,pmdb201      ,pmdb201_desc        ,pmdb202,",
   #            "     pmdb212,pmdb007      ,pmdb007_desc        ,pmdb006,",
   #            "     pmdb049,pmdb208      ,pmdb015             ,pmdb015_desc,",
   #            "     pmdb207,pmdb206      ,pmdb206_desc        ,pmdb209,pmdb209_desc,",              
   #            "     pmdb210,pmdb211      ,pmdb205             ,pmdb205_desc,pmdb203,",
   #            "pmdb203_desc,pmdb204      ,pmdb204_desc        ,pmdbdocno,pmdbseq,",
   #            "    pmdasite,pmdasite_desc,pmdadocdt           ,pmda002  ,pmda002_desc,",
   #            "     pmda003,pmda003_desc ,pmdastus",
   #            " FROM (",ls_sql_rank,")",
   #           " WHERE RANK >= ",g_pagestart,
   #             " AND RANK < ",g_pagestart + g_num_in_page
   LET g_sql = ls_sql_rank
   #150826-00013#1 效能調整 20150907 add by beckxie---E
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq831_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq831_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmdb_d[l_ac].sel,g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdbsite_desc, 
       g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb048_desc,g_pmdb_d[l_ac].pmdb200, 
       g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004, 
       g_pmdb_d[l_ac].imaa009,g_pmdb_d[l_ac].imaa009_desc,g_pmdb_d[l_ac].pmdb037,g_pmdb_d[l_ac].pmdb037_desc, 
       g_pmdb_d[l_ac].pmdb038,g_pmdb_d[l_ac].pmdb038_desc,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb201_desc, 
       g_pmdb_d[l_ac].pmdb202,g_pmdb_d[l_ac].pmdb212,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb007_desc, 
       g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb049,g_pmdb_d[l_ac].pmdb208,g_pmdb_d[l_ac].pmdb015,g_pmdb_d[l_ac].pmdb015_desc, 
       g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb206,g_pmdb_d[l_ac].pmdb206_desc,g_pmdb_d[l_ac].pmdb209, 
       g_pmdb_d[l_ac].pmdb209_desc,g_pmdb_d[l_ac].pmdb210,g_pmdb_d[l_ac].pmdb211,g_pmdb_d[l_ac].pmdb205, 
       g_pmdb_d[l_ac].pmdb205_desc,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb203_desc,g_pmdb_d[l_ac].pmdb204, 
       g_pmdb_d[l_ac].pmdb204_desc,g_pmdb_d[l_ac].pmdbdocno,g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdasite, 
       g_pmdb_d[l_ac].pmdasite_desc,g_pmdb_d[l_ac].pmdadocdt,g_pmdb_d[l_ac].pmda002,g_pmdb_d[l_ac].pmda002_desc, 
       g_pmdb_d[l_ac].pmda003,g_pmdb_d[l_ac].pmda003_desc,g_pmdb_d[l_ac].pmdastus
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
 
      CALL apmq831_detail_show("'1'")
 
      CALL apmq831_pmdb_t_mask()
 
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
   CALL cl_set_comp_visible('sel',FALSE)
   #end add-point
 
   CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmdb_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apmq831_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq831_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq831_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmdb_d.getLength() > 0 THEN
      CALL apmq831_b_fill2()
   END IF
 
      CALL apmq831_filter_show('pmdbsite','b_pmdbsite')
   CALL apmq831_filter_show('pmdb030','b_pmdb030')
   CALL apmq831_filter_show('pmdb048','b_pmdb048')
   CALL apmq831_filter_show('pmdb200','b_pmdb200')
   CALL apmq831_filter_show('pmdb004','b_pmdb004')
   CALL apmq831_filter_show('pmdb005','b_pmdb005')
   CALL apmq831_filter_show('pmdb037','b_pmdb037')
   CALL apmq831_filter_show('pmdb038','b_pmdb038')
   CALL apmq831_filter_show('pmdb201','b_pmdb201')
   CALL apmq831_filter_show('pmdb202','b_pmdb202')
   CALL apmq831_filter_show('pmdb212','b_pmdb212')
   CALL apmq831_filter_show('pmdb007','b_pmdb007')
   CALL apmq831_filter_show('pmdb006','b_pmdb006')
   CALL apmq831_filter_show('pmdb049','b_pmdb049')
   CALL apmq831_filter_show('pmdb208','b_pmdb208')
   CALL apmq831_filter_show('pmdb015','b_pmdb015')
   CALL apmq831_filter_show('pmdb207','b_pmdb207')
   CALL apmq831_filter_show('pmdb206','b_pmdb206')
   CALL apmq831_filter_show('pmdb209','b_pmdb209')
   CALL apmq831_filter_show('pmdb210','b_pmdb210')
   CALL apmq831_filter_show('pmdb211','b_pmdb211')
   CALL apmq831_filter_show('pmdb205','b_pmdb205')
   CALL apmq831_filter_show('pmdb203','b_pmdb203')
   CALL apmq831_filter_show('pmdb204','b_pmdb204')
   CALL apmq831_filter_show('pmdbdocno','b_pmdbdocno')
   CALL apmq831_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq831_filter_show('pmdasite','b_pmdasite')
   CALL apmq831_filter_show('pmdadocdt','b_pmdadocdt')
   CALL apmq831_filter_show('pmda002','b_pmda002')
   CALL apmq831_filter_show('pmda003','b_pmda003')
   CALL apmq831_filter_show('pmdastus','b_pmdastus')
   CALL apmq831_filter_show('pmdpdocno','b_pmdpdocno')
   CALL apmq831_filter_show('pmdldocdt','b_pmdldocdt')
   CALL apmq831_filter_show('pmdl004','b_pmdl004')
   CALL apmq831_filter_show('pmdl002','b_pmdl002')
   CALL apmq831_filter_show('pmdpseq','b_pmdpseq')
   CALL apmq831_filter_show('pmdp001','b_pmdp001')
   CALL apmq831_filter_show('pmdp002','b_pmdp002')
   CALL apmq831_filter_show('pmdp024','b_pmdp024')
   CALL apmq831_filter_show('pmdp025','b_pmdp025')
   CALL apmq831_filter_show('pmdp026','b_pmdp026')
   CALL apmq831_filter_show('pmdo013','b_pmdo013')
   CALL apmq831_filter_show('pmdn020','b_pmdn020')
   CALL apmq831_filter_show('pmdnunit','b_pmdnunit')
   CALL apmq831_filter_show('pmdnsite','b_pmdnsite')
   CALL apmq831_filter_show('pmdvdocno','b_pmdvdocno')
   CALL apmq831_filter_show('pmdvseq','b_pmdvseq')
   CALL apmq831_filter_show('pmdvseq1','b_pmdvseq1')
   CALL apmq831_filter_show('pmdsdocdt','b_pmdsdocdt')
   CALL apmq831_filter_show('pmdvsite','b_pmdvsite')
   CALL apmq831_filter_show('pmds007','b_pmds007')
   CALL apmq831_filter_show('pmdv001','b_pmdv001')
   CALL apmq831_filter_show('pmdv002','b_pmdv002')
   CALL apmq831_filter_show('pmdv018','b_pmdv018')
   CALL apmq831_filter_show('pmdv019','b_pmdv019')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq831.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq831_b_fill2()
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
#Page2
   CALL g_pmdb2_d.clear()
#Page3
   CALL g_pmdb3_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
#Page4
   CALL g_pmdb5_d.clear()
   
#table5
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      
      #入庫資料SQL
      #150826-00013# 20160308 add by beckxie---S
      #LET g_sql = "SELECT  UNIQUE pmdvdocno,pmdvseq,pmdvseq1,pmdsdocdt,pmdvsite,t1.ooefl003,pmds007,t2.pmaal004, ",
      #            "               pmdv001,t3.imaal003,t3.imaal004,pmdv002,pmdv018,t4.oocal003,pmdv019 ",
      #            " FROM pmds_t ",  #收貨/入庫單頭檔
      #            "       LEFT OUTER JOIN pmaal_t t2 on pmdsent = t2.pmaalent AND pmds007 = t2.pmaal001 AND t2.pmaal002 = '",g_dlang,"' ",  #供應商說明  
      #            "     ,pmdv_t ",  #收貨/入庫需求分配明細檔
      #            "       LEFT OUTER JOIN ooefl_t t1 ON pmdvent = t1.ooeflent AND pmdvsite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #入庫組織說明
      #            "       LEFT OUTER JOIN imaal_t t3 on pmdvent = t3.imaalent AND pmdv001 = t3.imaal001 AND t3.imaal002 = '",g_dlang,"' ",  #品名、規格
      #            "       LEFT OUTER JOIN oocal_t t4 on pmdvent = t4.oocalent AND pmdv018 = t4.oocal001 AND t4.oocal002 = '",g_dlang,"' ",  #要貨單位說明
      #            " WHERE pmdvent=? 
      #              AND pmdv014=? 
      #              AND pmdv015=?
      #              AND pmdsent=pmdvent
      #              AND pmdsdocno=pmdvdocno 
      #              AND (pmds000='6' or pmds000='3') "
      #150826-00013# 20160308 add by beckxie---E
      #150826-00013# 20160308 add by beckxie---S
      LET g_sql = "SELECT  UNIQUE pmdvdocno,pmdvseq,pmdvseq1,pmdsdocdt,pmdvsite,",
                  "               (SELECT ooefl003 ",
                  "                  FROM ooefl_t ",
                  "                 WHERE pmdvent = ooeflent AND pmdvsite = ooefl001 AND ooefl002 = '",g_dlang,"'), ",  #入庫組織說明
                  "               pmds007,",
                  "               (SELECT pmaal004 ",
                  "                  FROM pmaal_t ",
                  "                 WHERE pmdsent = pmaalent AND pmds007 = pmaal001 AND pmaal002 = '",g_dlang,"'), ",  #供應商說明  
                  "               pmdv001,t3.imaal003,t3.imaal004,pmdv002,pmdv018,",
                  "               (SELECT oocal003 ",
                  "                  FROM oocal_t ",
                  "                 WHERE pmdvent = oocalent AND pmdv018 = oocal001 AND oocal002 = '",g_dlang,"'), ",  #要貨單位說明
                  "               pmdv019 ",
                  " FROM pmds_t ",  #收貨/入庫單頭檔
                  "     ,pmdv_t ",  #收貨/入庫需求分配明細檔
                  "       LEFT OUTER JOIN imaal_t t3 on pmdvent = t3.imaalent AND pmdv001 = t3.imaal001 AND t3.imaal002 = '",g_dlang,"' ",  #品名、規格
                  " WHERE pmdvent=? 
                    AND pmdv014=? 
                    AND pmdv015=?
                    AND pmdsent=pmdvent
                    AND pmdsdocno=pmdvdocno 
                    AND (pmds000='6' or pmds000='3') "
      #150826-00013# 20160308 add by beckxie---E
      IF NOT cl_null(g_wc2_table5) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY pmdv_t.pmdvdocno,pmdv_t.pmdvseq"   
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq831_pb5 FROM g_sql
      DECLARE b_fill_curs5 CURSOR FOR apmq831_pb5
   END IF
 
   OPEN b_fill_curs5 USING g_enterprise,g_pmdb_d[g_detail_idx].pmdbdocno
                                  ,g_pmdb_d[g_detail_idx].pmdbseq
 
 
   LET l_ac = 1
   FOREACH b_fill_curs5 INTO 
       g_pmdb5_d[l_ac].pmdvdocno,g_pmdb5_d[l_ac].pmdvseq,g_pmdb5_d[l_ac].pmdvseq1,g_pmdb5_d[l_ac].pmdsdocdt, 
       g_pmdb5_d[l_ac].pmdvsite,g_pmdb5_d[l_ac].pmdvsite_desc,g_pmdb5_d[l_ac].pmds007,g_pmdb5_d[l_ac].pmds007_desc, 
       g_pmdb5_d[l_ac].pmdv001,g_pmdb5_d[l_ac].pmdv001_desc,g_pmdb5_d[l_ac].imaal004,g_pmdb5_d[l_ac].pmdv002, 
       g_pmdb5_d[l_ac].pmdv018,g_pmdb5_d[l_ac].pmdv018_desc,g_pmdb5_d[l_ac].pmdv019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      ##入庫組織說明
      #CALL s_desc_get_department_desc(g_pmdb5_d[l_ac].pmdv001) RETURNING g_pmdb5_d[l_ac].pmdv001_desc

      ##供應商說明
      #CALL s_desc_get_trading_partner_abbr_desc(g_pmdb5_d[l_ac].pmds007) RETURNING g_pmdb5_d[l_ac].pmds007_desc

      ##商品品名、規格
      #CALL s_desc_get_item_desc(g_pmdb5_d[l_ac].pmdv001) RETURNING g_pmdb5_d[l_ac].pmdv001_desc,g_pmdb5_d[l_ac].imaal004
      
      ##要貨單位
      #CALL s_desc_get_unit_desc(g_pmdb5_d[l_ac].pmdv018) RETURNING g_pmdb5_d[l_ac].pmdv018_desc
  
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
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE pmdpdocno,'','','','','',pmdpseq,pmdp001,'','',pmdp002,pmdp024,pmdp025, 
          pmdp026,'','','','','','' FROM pmdp_t",
                  "",
                  " WHERE pmdpent=? AND pmdp003=? AND pmdp004=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdp_t.pmdpdocno,pmdp_t.pmdpseq,pmdp_t.pmdpseq1"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      
      #採購資料SQL
      LET g_sql = "SELECT  UNIQUE pmdpdocno,pmdldocdt,pmdl004,t1.pmaal004,pmdl002,t2.ooag011,pmdpseq,pmdp001,t3.imaal003,t3.imaal004, ",
                   "              pmdp002,pmdp024,pmdp025,pmdp026,t4.pmdo013,pmdn020,pmdnunit,t5.ooefl003,pmdnsite,t6.ooefl003 ",
                   "FROM pmdl_t ",  #採購單頭檔
                   "     LEFT OUTER JOIN pmaal_t t1 on pmdlent = t1.pmaalent AND pmdl004 = t1.pmaal001 AND t1.pmaal002 = '",g_dlang,"' ",  #供應商說明  
                   "     LEFT OUTER JOIN ooag_t  t2 on pmdlent = t2.ooagent AND pmdl002 = t2.ooag001 ",  #採購人員全名
                   "    ,pmdn_t ",  #採購單身明細檔
                   "     LEFT OUTER JOIN pmdo_t t4 on pmdnent = t4.pmdoent AND pmdndocno = t4.pmdodocno AND pmdnseq = t4.pmdoseq ",  #入庫日期(抓pmdo013)                  
                   "     LEFT OUTER JOIN ooefl_t t5 ON pmdnent = t5.ooeflent AND pmdnunit = t5.ooefl001 AND t5.ooefl002 = '",g_dlang,"' ",  #收貨組織說明
                   "     LEFT OUTER JOIN ooefl_t t6 ON pmdnent = t6.ooeflent AND pmdnsite = t6.ooefl001 AND t6.ooefl002 = '",g_dlang,"' ",  #採購組織說明                   
                   "    ,pmdp_t ",  #採購關聯單據明細檔
                   "     LEFT OUTER JOIN imaal_t t3 on pmdpent = t3.imaalent AND pmdp001 = t3.imaal001 AND t3.imaal002 = '",g_dlang,"' ",  #品名、規格
                   "",
                   " WHERE pmdpent   = ? 
                       AND pmdp003   = ? 
                       AND pmdp004   = ? 
                       AND pmdlent   = pmdnent
                       AND pmdldocno = pmdndocno
                       AND pmdndocno = pmdpdocno
                       AND pmdnseq   = pmdpseq "
   
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdp_t.pmdpdocno,pmdp_t.pmdpseq"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq831_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR apmq831_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_pmdb_d[g_detail_idx].pmdbdocno
#                                 ,g_pmdb_d[g_detail_idx].pmdbseq
 
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_pmdb_d[g_detail_idx].pmdbdocno
            ,g_pmdb_d[g_detail_idx].pmdbseq
 
 
      INTO g_pmdb2_d[l_ac].pmdpdocno,g_pmdb2_d[l_ac].pmdldocdt,g_pmdb2_d[l_ac].pmdl004,g_pmdb2_d[l_ac].pmdl004_desc, 
          g_pmdb2_d[l_ac].pmdl002,g_pmdb2_d[l_ac].pmdl002_desc,g_pmdb2_d[l_ac].pmdpseq,g_pmdb2_d[l_ac].pmdp001, 
          g_pmdb2_d[l_ac].pmdp001_desc,g_pmdb2_d[l_ac].imaal004,g_pmdb2_d[l_ac].pmdp002,g_pmdb2_d[l_ac].pmdp024, 
          g_pmdb2_d[l_ac].pmdp025,g_pmdb2_d[l_ac].pmdp026,g_pmdb2_d[l_ac].pmdo013,g_pmdb2_d[l_ac].pmdn020, 
          g_pmdb2_d[l_ac].pmdnunit,g_pmdb2_d[l_ac].pmdnunit_desc,g_pmdb2_d[l_ac].pmdnsite,g_pmdb2_d[l_ac].pmdnsite_desc 
 
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
      
      #end add-point
 
      CALL apmq831_detail_show("'2'")
 
      CALL apmq831_pmdp_t_mask()
 
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
      LET g_sql = "SELECT  UNIQUE pmdvdocno,pmdvseq,pmdvseq1,'',pmdvsite,'','','',pmdv001,'','',pmdv002, 
          pmdv018,'',pmdv019 FROM pmdv_t",
                  "",
                  " WHERE pmdvent=? AND pmdv014=? AND pmdv015=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdv_t.pmdvdocno,pmdv_t.pmdvseq,pmdv_t.pmdvseq1"
  
      #add-point:單身填充前 name="b_fill2.before_fill3"
      
      #收貨資料SQL
      LET g_sql = "SELECT  UNIQUE pmdvdocno,pmdvseq,pmdvseq1,pmdsdocdt,pmdvsite,t1.ooefl003,pmds007,t2.pmaal004, ",
                  "               pmdv001,t3.imaal003,t3.imaal004,pmdv002,pmdv018,t4.oocal003,pmdv019 ",
                  " FROM pmds_t ",  #收貨/入庫單頭檔
                  "       LEFT OUTER JOIN pmaal_t t2 on pmdsent = t2.pmaalent AND pmds007 = t2.pmaal001 AND t2.pmaal002 = '",g_dlang,"' ",  #供應商說明  
                  "     ,pmdv_t ",  #收貨/入庫需求分配明細檔
                  "       LEFT OUTER JOIN ooefl_t t1 ON pmdvent = t1.ooeflent AND pmdvsite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #收貨組織說明
                  "       LEFT OUTER JOIN imaal_t t3 on pmdvent = t3.imaalent AND pmdv001 = t3.imaal001 AND t3.imaal002 = '",g_dlang,"' ",  #品名、規格
                  "       LEFT OUTER JOIN oocal_t t4 on pmdvent = t4.oocalent AND pmdv018 = t4.oocal001 AND t4.oocal002 = '",g_dlang,"' ",  #要貨單位說明
                  " WHERE pmdvent=? 
                    AND pmdv014=? 
                    AND pmdv015=?
                    AND pmdsent=pmdvent
                    AND pmdsdocno=pmdvdocno 
                    AND pmds000='1' "
      
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY pmdv_t.pmdvdocno,pmdv_t.pmdvseq"   
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq831_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR apmq831_pb3
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs3 USING g_enterprise,g_pmdb_d[g_detail_idx].pmdbdocno
#                                 ,g_pmdb_d[g_detail_idx].pmdbseq
 
 
   LET l_ac = 1
   FOREACH b_fill_curs3
      USING g_enterprise,g_pmdb_d[g_detail_idx].pmdbdocno
            ,g_pmdb_d[g_detail_idx].pmdbseq
 
 
      INTO g_pmdb3_d[l_ac].pmdvdocno,g_pmdb3_d[l_ac].pmdvseq,g_pmdb3_d[l_ac].pmdvseq1,g_pmdb3_d[l_ac].pmdsdocdt, 
          g_pmdb3_d[l_ac].pmdvsite,g_pmdb3_d[l_ac].pmdvsite_desc,g_pmdb3_d[l_ac].pmds007,g_pmdb3_d[l_ac].pmds007_desc, 
          g_pmdb3_d[l_ac].pmdv001,g_pmdb3_d[l_ac].pmdv001_desc,g_pmdb3_d[l_ac].imaal004,g_pmdb3_d[l_ac].pmdv002, 
          g_pmdb3_d[l_ac].pmdv018,g_pmdb3_d[l_ac].pmdv018_desc,g_pmdb3_d[l_ac].pmdv019
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
      
      #end add-point
 
      CALL apmq831_detail_show("'3'")
 
      CALL apmq831_pmdv_t_mask()
 
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
   CALL g_pmdb2_d.deleteElement(g_pmdb2_d.getLength())
#Page3
   CALL g_pmdb3_d.deleteElement(g_pmdb3_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
#Page4
   CALL g_pmdb5_d.deleteElement(g_pmdb5_d.getLength())   
   
#Page4
   LET li_ac = g_pmdb5_d.getLength()   
   #end add-point
 
#Page2
   LET li_ac = g_pmdb2_d.getLength()
#Page3
   LET li_ac = g_pmdb3_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
 
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apmq831.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq831_detail_show(ps_page)
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
         
            
            ##需求組織說明     改組到SQL段中
            #CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].pmdbsite_desc
            
            ##收貨時段說明     改組到SQL段中
            #CALL s_desc_get_acc_desc('274',g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc            
            
            ##商品品名、規格
            #CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].imaal004
        
            ##品類說明         改組到SQL段中
            #CALL s_desc_get_rtaxl003_desc(g_pmdb_d[l_ac].imaa009) RETURNING g_pmdb_d[l_ac].imaa009_desc
        
            ##收貨組織說明
            #CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb037) RETURNING g_pmdb_d[l_ac].pmdb037_desc 
        
            ##庫位說明
            #CALL s_desc_get_stock_desc('',g_pmdb_d[l_ac].pmdb038) RETURNING g_pmdb_d[l_ac].pmdb038_desc
            
            ##包裝單位
            #CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb201) RETURNING g_pmdb_d[l_ac].pmdb201_desc
            
            ##要貨單位
            #CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
            
            ##供應商說明
            #CALL s_desc_get_trading_partner_abbr_desc(g_pmdb_d[l_ac].pmdb015) RETURNING g_pmdb_d[l_ac].pmdb015_desc
            
            ##採購人員(全名)        
            #CALL s_desc_get_person_desc(g_pmdb_d[l_ac].pmdb206) RETURNING g_pmdb_d[l_ac].pmdb206_desc            
        
            #結算方式說明            
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb209
            #LET ls_sql = "SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_pmdb_d[l_ac].pmdb209_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb209_desc
        
            ##採購中心說明
            #CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb205) RETURNING g_pmdb_d[l_ac].pmdb205_desc 
        
            ##配送中心說明
            #CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb203) RETURNING g_pmdb_d[l_ac].pmdb203_desc
            
            ##配送庫位說明
            #CALL s_desc_get_stock_desc('',g_pmdb_d[l_ac].pmdb204) RETURNING g_pmdb_d[l_ac].pmdb204_desc
            
            ##要貨組織說明
            #CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].pmdasite_desc            
            
            ##申請人員(全名)        
            #CALL s_desc_get_person_desc(g_pmdb_d[l_ac].pmda002) RETURNING g_pmdb_d[l_ac].pmda002_desc            
            
            ##申請部門說明
            #CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmda003) RETURNING g_pmdb_d[l_ac].pmda003_desc            
            
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            ##供應商說明
            #CALL s_desc_get_trading_partner_abbr_desc(g_pmdb2_d[l_ac].pmdl004) RETURNING g_pmdb2_d[l_ac].pmdl004_desc
            
            ##採購人員(全名)        
            #CALL s_desc_get_person_desc(g_pmdb2_d[l_ac].pmdl002) RETURNING g_pmdb2_d[l_ac].pmdl002_desc
            
            ##商品品名、規格
            #CALL s_desc_get_item_desc(g_pmdb2_d[l_ac].pmdp001) RETURNING g_pmdb2_d[l_ac].pmdp001_desc,g_pmdb2_d[l_ac].imaal004
            
            ##收貨組織說明
            #CALL s_desc_get_department_desc(g_pmdb2_d[l_ac].pmdnunit) RETURNING g_pmdb2_d[l_ac].pmdnunit_desc             

            ##採購組織說明
            #CALL s_desc_get_department_desc(g_pmdb2_d[l_ac].pmdnsite) RETURNING g_pmdb2_d[l_ac].pmdnsite_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

            ##收貨組織說明
            #CALL s_desc_get_department_desc(g_pmdb3_d[l_ac].pmdv001) RETURNING g_pmdb3_d[l_ac].pmdv001_desc
            
            ##供應商說明
            #CALL s_desc_get_trading_partner_abbr_desc(g_pmdb3_d[l_ac].pmds007) RETURNING g_pmdb3_d[l_ac].pmds007_desc

            ##商品品名、規格
            #CALL s_desc_get_item_desc(g_pmdb3_d[l_ac].pmdv001) RETURNING g_pmdb3_d[l_ac].pmdv001_desc,g_pmdb3_d[l_ac].imaal004
            
            ##要貨單位
            #CALL s_desc_get_unit_desc(g_pmdb3_d[l_ac].pmdv018) RETURNING g_pmdb3_d[l_ac].pmdv018_desc


      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq831.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq831_filter()
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
      CONSTRUCT g_wc_filter ON pmdbsite,pmdb030,pmdb048,pmdb200,pmdb004,pmdb005,pmdb037,pmdb038,pmdb201, 
          pmdb202,pmdb212,pmdb007,pmdb006,pmdb049,pmdb208,pmdb015,pmdb207,pmdb206,pmdb209,pmdb210,pmdb211, 
          pmdb205,pmdb203,pmdb204,pmdbdocno,pmdbseq,pmdasite,pmdadocdt,pmda002,pmda003,pmdastus
                          FROM s_detail1[1].b_pmdbsite,s_detail1[1].b_pmdb030,s_detail1[1].b_pmdb048, 
                              s_detail1[1].b_pmdb200,s_detail1[1].b_pmdb004,s_detail1[1].b_pmdb005,s_detail1[1].b_pmdb037, 
                              s_detail1[1].b_pmdb038,s_detail1[1].b_pmdb201,s_detail1[1].b_pmdb202,s_detail1[1].b_pmdb212, 
                              s_detail1[1].b_pmdb007,s_detail1[1].b_pmdb006,s_detail1[1].b_pmdb049,s_detail1[1].b_pmdb208, 
                              s_detail1[1].b_pmdb015,s_detail1[1].b_pmdb207,s_detail1[1].b_pmdb206,s_detail1[1].b_pmdb209, 
                              s_detail1[1].b_pmdb210,s_detail1[1].b_pmdb211,s_detail1[1].b_pmdb205,s_detail1[1].b_pmdb203, 
                              s_detail1[1].b_pmdb204,s_detail1[1].b_pmdbdocno,s_detail1[1].b_pmdbseq, 
                              s_detail1[1].b_pmdasite,s_detail1[1].b_pmdadocdt,s_detail1[1].b_pmda002, 
                              s_detail1[1].b_pmda003,s_detail1[1].b_pmdastus
 
         BEFORE CONSTRUCT
                     DISPLAY apmq831_filter_parser('pmdbsite') TO s_detail1[1].b_pmdbsite
            DISPLAY apmq831_filter_parser('pmdb030') TO s_detail1[1].b_pmdb030
            DISPLAY apmq831_filter_parser('pmdb048') TO s_detail1[1].b_pmdb048
            DISPLAY apmq831_filter_parser('pmdb200') TO s_detail1[1].b_pmdb200
            DISPLAY apmq831_filter_parser('pmdb004') TO s_detail1[1].b_pmdb004
            DISPLAY apmq831_filter_parser('pmdb005') TO s_detail1[1].b_pmdb005
            DISPLAY apmq831_filter_parser('pmdb037') TO s_detail1[1].b_pmdb037
            DISPLAY apmq831_filter_parser('pmdb038') TO s_detail1[1].b_pmdb038
            DISPLAY apmq831_filter_parser('pmdb201') TO s_detail1[1].b_pmdb201
            DISPLAY apmq831_filter_parser('pmdb202') TO s_detail1[1].b_pmdb202
            DISPLAY apmq831_filter_parser('pmdb212') TO s_detail1[1].b_pmdb212
            DISPLAY apmq831_filter_parser('pmdb007') TO s_detail1[1].b_pmdb007
            DISPLAY apmq831_filter_parser('pmdb006') TO s_detail1[1].b_pmdb006
            DISPLAY apmq831_filter_parser('pmdb049') TO s_detail1[1].b_pmdb049
            DISPLAY apmq831_filter_parser('pmdb208') TO s_detail1[1].b_pmdb208
            DISPLAY apmq831_filter_parser('pmdb015') TO s_detail1[1].b_pmdb015
            DISPLAY apmq831_filter_parser('pmdb207') TO s_detail1[1].b_pmdb207
            DISPLAY apmq831_filter_parser('pmdb206') TO s_detail1[1].b_pmdb206
            DISPLAY apmq831_filter_parser('pmdb209') TO s_detail1[1].b_pmdb209
            DISPLAY apmq831_filter_parser('pmdb210') TO s_detail1[1].b_pmdb210
            DISPLAY apmq831_filter_parser('pmdb211') TO s_detail1[1].b_pmdb211
            DISPLAY apmq831_filter_parser('pmdb205') TO s_detail1[1].b_pmdb205
            DISPLAY apmq831_filter_parser('pmdb203') TO s_detail1[1].b_pmdb203
            DISPLAY apmq831_filter_parser('pmdb204') TO s_detail1[1].b_pmdb204
            DISPLAY apmq831_filter_parser('pmdbdocno') TO s_detail1[1].b_pmdbdocno
            DISPLAY apmq831_filter_parser('pmdbseq') TO s_detail1[1].b_pmdbseq
            DISPLAY apmq831_filter_parser('pmdasite') TO s_detail1[1].b_pmdasite
            DISPLAY apmq831_filter_parser('pmdadocdt') TO s_detail1[1].b_pmdadocdt
            DISPLAY apmq831_filter_parser('pmda002') TO s_detail1[1].b_pmda002
            DISPLAY apmq831_filter_parser('pmda003') TO s_detail1[1].b_pmda003
            DISPLAY apmq831_filter_parser('pmdastus') TO s_detail1[1].b_pmdastus
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmdbsite>>----
         #Ctrlp:construct.c.page1.b_pmdbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbsite
            #add-point:ON ACTION controlp INFIELD b_pmdbsite name="construct.c.filter.page1.b_pmdbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_4()                           #呼叫開窗   #161006-00008#11 by sakura mark
            #161006-00008#11 by sakura add(S)
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_site,'c')
            CALL q_ooef001_24()
            #161006-00008#11 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_pmdbsite  #顯示到畫面上
            NEXT FIELD b_pmdbsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdbsite_desc>>----
         #----<<b_pmdb030>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb030
            #add-point:ON ACTION controlp INFIELD b_pmdb030 name="construct.c.filter.page1.b_pmdb030"
            
            #END add-point
 
 
         #----<<b_pmdb048>>----
         #Ctrlp:construct.c.page1.b_pmdb048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb048
            #add-point:ON ACTION controlp INFIELD b_pmdb048 name="construct.c.filter.page1.b_pmdb048"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb048  #顯示到畫面上
            NEXT FIELD b_pmdb048                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb048_desc>>----
         #----<<b_pmdb200>>----
         #Ctrlp:construct.c.page1.b_pmdb200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb200
            #add-point:ON ACTION controlp INFIELD b_pmdb200 name="construct.c.filter.page1.b_pmdb200"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb200  #顯示到畫面上
            NEXT FIELD b_pmdb200                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb004>>----
         #Ctrlp:construct.c.page1.b_pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb004
            #add-point:ON ACTION controlp INFIELD b_pmdb004 name="construct.c.filter.page1.b_pmdb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb004  #顯示到畫面上
            NEXT FIELD b_pmdb004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb005>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb005
            #add-point:ON ACTION controlp INFIELD b_pmdb005 name="construct.c.filter.page1.b_pmdb005"
            
            #END add-point
 
 
         #----<<b_pmdb004_desc>>----
         #----<<imaal004>>----
         #----<<imaa009>>----
         #----<<imaa009_desc>>----
         #----<<b_pmdb037>>----
         #Ctrlp:construct.c.page1.b_pmdb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb037
            #add-point:ON ACTION controlp INFIELD b_pmdb037 name="construct.c.filter.page1.b_pmdb037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #161006-00008#11 by sakura mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO b_pmdb037  #顯示到畫面上
            #NEXT FIELD b_pmdb037                     #返回原欄位
            #161006-00008#11 by sakura mark(E)
            #161006-00008#11 by sakura add(S)
            IF s_aooi500_setpoint(g_prog,'pmdb037') THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb037',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO b_pmdb037
               NEXT FIELD b_pmdb037
            ELSE    
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE       
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = 8
               CALL q_ooed004_3()                  
               DISPLAY g_qryparam.return1 TO b_pmdb037  
               NEXT FIELD b_pmdb037                    
            END IF            
            #161006-00008#11 by sakura add(E)


            #END add-point
 
 
         #----<<b_pmdb037_desc>>----
         #----<<b_pmdb038>>----
         #Ctrlp:construct.c.page1.b_pmdb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb038
            #add-point:ON ACTION controlp INFIELD b_pmdb038 name="construct.c.filter.page1.b_pmdb038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb038  #顯示到畫面上
            NEXT FIELD b_pmdb038                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb038_desc>>----
         #----<<b_pmdb201>>----
         #Ctrlp:construct.c.page1.b_pmdb201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb201
            #add-point:ON ACTION controlp INFIELD b_pmdb201 name="construct.c.filter.page1.b_pmdb201"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb201  #顯示到畫面上
            NEXT FIELD b_pmdb201                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb201_desc>>----
         #----<<b_pmdb202>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb202
            #add-point:ON ACTION controlp INFIELD b_pmdb202 name="construct.c.filter.page1.b_pmdb202"
            
            #END add-point
 
 
         #----<<b_pmdb212>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb212
            #add-point:ON ACTION controlp INFIELD b_pmdb212 name="construct.c.filter.page1.b_pmdb212"
            
            #END add-point
 
 
         #----<<b_pmdb007>>----
         #Ctrlp:construct.c.page1.b_pmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb007
            #add-point:ON ACTION controlp INFIELD b_pmdb007 name="construct.c.filter.page1.b_pmdb007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb007  #顯示到畫面上
            NEXT FIELD b_pmdb007                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb007_desc>>----
         #----<<b_pmdb006>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb006
            #add-point:ON ACTION controlp INFIELD b_pmdb006 name="construct.c.filter.page1.b_pmdb006"
            
            #END add-point
 
 
         #----<<b_pmdb049>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb049
            #add-point:ON ACTION controlp INFIELD b_pmdb049 name="construct.c.filter.page1.b_pmdb049"
            
            #END add-point
 
 
         #----<<b_pmdb208>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb208
            #add-point:ON ACTION controlp INFIELD b_pmdb208 name="construct.c.filter.page1.b_pmdb208"
            
            #END add-point
 
 
         #----<<b_pmdb015>>----
         #Ctrlp:construct.c.page1.b_pmdb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb015
            #add-point:ON ACTION controlp INFIELD b_pmdb015 name="construct.c.filter.page1.b_pmdb015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb015  #顯示到畫面上
            NEXT FIELD b_pmdb015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb015_desc>>----
         #----<<b_pmdb207>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb207
            #add-point:ON ACTION controlp INFIELD b_pmdb207 name="construct.c.filter.page1.b_pmdb207"
            
            #END add-point
 
 
         #----<<b_pmdb206>>----
         #Ctrlp:construct.c.page1.b_pmdb206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb206
            #add-point:ON ACTION controlp INFIELD b_pmdb206 name="construct.c.filter.page1.b_pmdb206"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb206  #顯示到畫面上
            NEXT FIELD b_pmdb206                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb206_desc>>----
         #----<<b_pmdb209>>----
         #Ctrlp:construct.c.page1.b_pmdb209
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb209
            #add-point:ON ACTION controlp INFIELD b_pmdb209 name="construct.c.filter.page1.b_pmdb209"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb209  #顯示到畫面上
            NEXT FIELD b_pmdb209                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb209_desc>>----
         #----<<b_pmdb210>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb210
            #add-point:ON ACTION controlp INFIELD b_pmdb210 name="construct.c.filter.page1.b_pmdb210"
            
            #END add-point
 
 
         #----<<b_pmdb211>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb211
            #add-point:ON ACTION controlp INFIELD b_pmdb211 name="construct.c.filter.page1.b_pmdb211"
            
            #END add-point
 
 
         #----<<b_pmdb205>>----
         #Ctrlp:construct.c.page1.b_pmdb205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb205
            #add-point:ON ACTION controlp INFIELD b_pmdb205 name="construct.c.filter.page1.b_pmdb205"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #161006-00008#11 by sakura mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_3()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO b_pmdb205  #顯示到畫面上
            #NEXT FIELD b_pmdb205                     #返回原欄位
            #161006-00008#11 by sakura mark(E)
            #161006-00008#11 by sakura add(S)
            IF s_aooi500_setpoint(g_prog,'pmdb205') THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb205',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO b_pmdb205
               NEXT FIELD b_pmdb205
            ELSE    
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "ooef303 = 'Y'"
               CALL q_ooef001()
               DISPLAY g_qryparam.return1 TO b_pmdb205
               NEXT FIELD b_pmdb205   
            END IF            
            #161006-00008#11 by sakura add(E)
            #END add-point
 
 
         #----<<b_pmdb205_desc>>----
         #----<<b_pmdb203>>----
         #Ctrlp:construct.c.page1.b_pmdb203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb203
            #add-point:ON ACTION controlp INFIELD b_pmdb203 name="construct.c.filter.page1.b_pmdb203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #161006-00008#11 by sakura mark(S)
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_3()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO b_pmdb203  #顯示到畫面上
            #NEXT FIELD b_pmdb203                     #返回原欄位
            #161006-00008#11 by sakura mark(E)
            #161006-00008#11 by sakura add(S)
            IF s_aooi500_setpoint(g_prog,'pmdb203') THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb203',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO b_pmdb203
               NEXT FIELD b_pmdb203
            ELSE    
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "ooef302 = 'Y'"
               CALL q_ooef001()
               DISPLAY g_qryparam.return1 TO b_pmdb203
               NEXT FIELD b_pmdb203 
            END IF            
            #161006-00008#11 by sakura add(E)


            #END add-point
 
 
         #----<<b_pmdb203_desc>>----
         #----<<b_pmdb204>>----
         #Ctrlp:construct.c.page1.b_pmdb204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb204
            #add-point:ON ACTION controlp INFIELD b_pmdb204 name="construct.c.filter.page1.b_pmdb204"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb204  #顯示到畫面上
            NEXT FIELD b_pmdb204                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb204_desc>>----
         #----<<b_pmdbdocno>>----
         #Ctrlp:construct.c.page1.b_pmdbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbdocno
            #add-point:ON ACTION controlp INFIELD b_pmdbdocno name="construct.c.filter.page1.b_pmdbdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdbdocno  #顯示到畫面上
            NEXT FIELD b_pmdbdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdbseq>>----
         #Ctrlp:construct.c.filter.page1.b_pmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbseq
            #add-point:ON ACTION controlp INFIELD b_pmdbseq name="construct.c.filter.page1.b_pmdbseq"
            
            #END add-point
 
 
         #----<<b_pmdasite>>----
         #Ctrlp:construct.c.page1.b_pmdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdasite
            #add-point:ON ACTION controlp INFIELD b_pmdasite name="construct.c.filter.page1.b_pmdasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_4()                           #呼叫開窗   #161006-00008#11 by sakura mark
            #161006-00008#11 by sakura add(S)
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdasite',g_site,'c')
            CALL q_ooef001_24()             
            #161006-00008#11 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_pmdasite  #顯示到畫面上
            NEXT FIELD b_pmdasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdasite_desc>>----
         #----<<b_pmdadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_pmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdadocdt
            #add-point:ON ACTION controlp INFIELD b_pmdadocdt name="construct.c.filter.page1.b_pmdadocdt"
            
            #END add-point
 
 
         #----<<b_pmda002>>----
         #Ctrlp:construct.c.page1.b_pmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda002
            #add-point:ON ACTION controlp INFIELD b_pmda002 name="construct.c.filter.page1.b_pmda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmda002  #顯示到畫面上
            NEXT FIELD b_pmda002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmda002_desc>>----
         #----<<b_pmda003>>----
         #Ctrlp:construct.c.page1.b_pmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda003
            #add-point:ON ACTION controlp INFIELD b_pmda003 name="construct.c.filter.page1.b_pmda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmda003  #顯示到畫面上
            NEXT FIELD b_pmda003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmda003_desc>>----
         #----<<b_pmdastus>>----
         #Ctrlp:construct.c.filter.page1.b_pmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdastus
            #add-point:ON ACTION controlp INFIELD b_pmdastus name="construct.c.filter.page1.b_pmdastus"
            
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
 
      CALL apmq831_filter_show('pmdbsite','b_pmdbsite')
   CALL apmq831_filter_show('pmdb030','b_pmdb030')
   CALL apmq831_filter_show('pmdb048','b_pmdb048')
   CALL apmq831_filter_show('pmdb200','b_pmdb200')
   CALL apmq831_filter_show('pmdb004','b_pmdb004')
   CALL apmq831_filter_show('pmdb005','b_pmdb005')
   CALL apmq831_filter_show('pmdb037','b_pmdb037')
   CALL apmq831_filter_show('pmdb038','b_pmdb038')
   CALL apmq831_filter_show('pmdb201','b_pmdb201')
   CALL apmq831_filter_show('pmdb202','b_pmdb202')
   CALL apmq831_filter_show('pmdb212','b_pmdb212')
   CALL apmq831_filter_show('pmdb007','b_pmdb007')
   CALL apmq831_filter_show('pmdb006','b_pmdb006')
   CALL apmq831_filter_show('pmdb049','b_pmdb049')
   CALL apmq831_filter_show('pmdb208','b_pmdb208')
   CALL apmq831_filter_show('pmdb015','b_pmdb015')
   CALL apmq831_filter_show('pmdb207','b_pmdb207')
   CALL apmq831_filter_show('pmdb206','b_pmdb206')
   CALL apmq831_filter_show('pmdb209','b_pmdb209')
   CALL apmq831_filter_show('pmdb210','b_pmdb210')
   CALL apmq831_filter_show('pmdb211','b_pmdb211')
   CALL apmq831_filter_show('pmdb205','b_pmdb205')
   CALL apmq831_filter_show('pmdb203','b_pmdb203')
   CALL apmq831_filter_show('pmdb204','b_pmdb204')
   CALL apmq831_filter_show('pmdbdocno','b_pmdbdocno')
   CALL apmq831_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq831_filter_show('pmdasite','b_pmdasite')
   CALL apmq831_filter_show('pmdadocdt','b_pmdadocdt')
   CALL apmq831_filter_show('pmda002','b_pmda002')
   CALL apmq831_filter_show('pmda003','b_pmda003')
   CALL apmq831_filter_show('pmdastus','b_pmdastus')
   CALL apmq831_filter_show('pmdpdocno','b_pmdpdocno')
   CALL apmq831_filter_show('pmdldocdt','b_pmdldocdt')
   CALL apmq831_filter_show('pmdl004','b_pmdl004')
   CALL apmq831_filter_show('pmdl002','b_pmdl002')
   CALL apmq831_filter_show('pmdpseq','b_pmdpseq')
   CALL apmq831_filter_show('pmdp001','b_pmdp001')
   CALL apmq831_filter_show('pmdp002','b_pmdp002')
   CALL apmq831_filter_show('pmdp024','b_pmdp024')
   CALL apmq831_filter_show('pmdp025','b_pmdp025')
   CALL apmq831_filter_show('pmdp026','b_pmdp026')
   CALL apmq831_filter_show('pmdo013','b_pmdo013')
   CALL apmq831_filter_show('pmdn020','b_pmdn020')
   CALL apmq831_filter_show('pmdnunit','b_pmdnunit')
   CALL apmq831_filter_show('pmdnsite','b_pmdnsite')
   CALL apmq831_filter_show('pmdvdocno','b_pmdvdocno')
   CALL apmq831_filter_show('pmdvseq','b_pmdvseq')
   CALL apmq831_filter_show('pmdvseq1','b_pmdvseq1')
   CALL apmq831_filter_show('pmdsdocdt','b_pmdsdocdt')
   CALL apmq831_filter_show('pmdvsite','b_pmdvsite')
   CALL apmq831_filter_show('pmds007','b_pmds007')
   CALL apmq831_filter_show('pmdv001','b_pmdv001')
   CALL apmq831_filter_show('pmdv002','b_pmdv002')
   CALL apmq831_filter_show('pmdv018','b_pmdv018')
   CALL apmq831_filter_show('pmdv019','b_pmdv019')
 
 
   CALL apmq831_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq831.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq831_filter_parser(ps_field)
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
 
{<section id="apmq831.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq831_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq831_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq831.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq831_detail_action_trans()
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
 
{<section id="apmq831.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq831_detail_index_setting()
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
            IF g_pmdb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmdb_d.getLength() AND g_pmdb_d.getLength() > 0
            LET g_detail_idx = g_pmdb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmdb_d.getLength() THEN
               LET g_detail_idx = g_pmdb_d.getLength()
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
 
{<section id="apmq831.mask_functions" >}
 &include "erp/apm/apmq831_mask.4gl"
 
{</section>}
 
{<section id="apmq831.other_function" readonly="Y" >}

 
{</section>}
 
