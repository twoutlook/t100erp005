#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:14(2017-01-05 15:33:40), PR版次:0014(2017-01-05 18:00:19)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000087
#+ Filename...: apmq400
#+ Description: 請購追蹤查詢作業
#+ Creator....: 03079(2014-07-25 14:24:08)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="apmq400.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160510-00019#4   2016/05/18  By lixiang    效能優化
#160617-00019#1   2016/06/20  By Ann_Huang  修正關聯單據明細取折合採購量where條件	
#161207-00033#22  2016/12/21  By lixh       一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#150528-00023#1   2017/01/06  By zhujing    各頁籤增加顯示料號、品名、規格、產品特徵、特徵說明欄位
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
PRIVATE TYPE type_g_pmda_d RECORD
       
       sel LIKE type_t.chr1, 
   pmdastus LIKE pmda_t.pmdastus, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmda002 LIKE pmda_t.pmda002, 
   prog_b_pmda002 STRING, 
   pmda002_desc LIKE type_t.chr500, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda003_desc LIKE type_t.chr500, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb004_desc LIKE type_t.chr500, 
   pmdb004_desc_1 LIKE type_t.chr500, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb005_desc LIKE type_t.chr500, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb007_desc LIKE type_t.chr500, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb050 LIKE pmdb_t.pmdb050
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_pmdl_d RECORD
                               pmdlstus       LIKE pmdl_t.pmdlstus,
                               pmdldocno      LIKE pmdl_t.pmdldocno,
                               pmdldocdt      LIKE pmdl_t.pmdldocdt,
                               pmdl004        LIKE pmdl_t.pmdl004,
                               pmdl004_desc   LIKE type_t.chr500,
                               pmdl002        LIKE pmdl_t.pmdl002,
                               prog_b_pmdl002 STRING,
                               pmdl002_desc   LIKE type_t.chr500,
                               pmdl003        LIKE pmdl_t.pmdl003,
                               pmdl003_desc   LIKE type_t.chr500,
                               pmdnseq        LIKE pmdn_t.pmdnseq,
                               #150528-00023#1 add-S
                               pmdn001        LIKE pmdn_t.pmdn001,
                               pmdn001_desc   LIKE imaal_t.imaal003,
                               pmdn001_desc_1 LIKE imaal_t.imaal004,
                               pmdn002        LIKE pmdn_t.pmdn002,
                               pmdn002_desc   LIKE inaml_t.inaml004,
                               #150528-00023#1 add-E
                               pmdp024        LIKE pmdp_t.pmdp024,
                               pmdn006        LIKE pmdn_t.pmdn006,
                               pmdn006_desc   LIKE type_t.chr500,
                               pmdn012        LIKE pmdn_t.pmdn012,
                               pmdp025        LIKE pmdp_t.pmdp025,
                               pmdp026        LIKE pmdp_t.pmdp026, 
                               pmdn050        LIKE pmdn_t.pmdn050 
                            END RECORD 
 TYPE type_g_pmds_d RECORD  
                               pmdsstus       LIKE pmds_t.pmdsstus,
                               pmdsdocno      LIKE pmds_t.pmdsdocno,
                               pmdsdocdt      LIKE pmds_t.pmdsdocdt,
                               pmds007        LIKE pmds_t.pmds007,
                               pmds007_desc   LIKE type_t.chr500,
                               pmds002        LIKE pmds_t.pmds002,
                               prog_b_pmds002 STRING,
                               pmds002_desc   LIKE type_t.chr500,
                               pmds003        LIKE pmds_t.pmds003,
                               pmds003_desc   LIKE type_t.chr500,
                               pmdtseq        LIKE pmdt_t.pmdtseq,
                               #150528-00023#1 add-S
                               pmdt006        LIKE pmdt_t.pmdt006,
                               pmdt006_desc   LIKE imaal_t.imaal003,
                               pmdt006_desc_1 LIKE imaal_t.imaal004,
                               pmdt007        LIKE pmdt_t.pmdt007,
                               pmdt007_desc   LIKE inaml_t.inaml004,
                               #150528-00023#1 add-E
                               pmdv019        LIKE pmdv_t.pmdv019,
                               pmdt019        LIKE pmdt_t.pmdt019,
                               pmdt019_desc   LIKE type_t.chr500, 
                               pmdt059        LIKE pmdt_t.pmdt059 
                            END RECORD
 TYPE type_g_qcba_d  RECORD
                               qcbastus     LIKE qcba_t.qcbastus,
                               qcbadocno    LIKE qcba_t.qcbadocno,
                               qcba014      LIKE qcba_t.qcba014,
                               qcba024      LIKE qcba_t.qcba024, 
                               qcba024_desc LIKE type_t.chr500,
                               ooag003      LIKE ooag_t.ooag003,
                               ooag003_desc LIKE type_t.chr500,
                               qcba005      LIKE qcba_t.qcba005,
                               qcba005_desc LIKE type_t.chr500,
                               qcba001      LIKE qcba_t.qcba001,
                               qcba002      LIKE qcba_t.qcba002,
                               #150528-00023#1 add-S
                               qcba010        LIKE qcba_t.qcba010,
                               qcba010_desc   LIKE imaal_t.imaal003,
                               qcba010_desc_1 LIKE imaal_t.imaal004,
                               qcba012        LIKE qcba_t.qcba012,
                               qcba012_desc   LIKE inaml_t.inaml004,
                               #150528-00023#1 add-E
                               qcba017      LIKE qcba_t.qcba017,
                               qcba022      LIKE qcba_t.qcba022,
                               qcba023      LIKE qcba_t.qcba023
                            END RECORD 
 TYPE type_g_pmds2_d RECORD
                              pmdsstus       LIKE pmds_t.pmdsstus,
                              pmdsdocno      LIKE pmds_t.pmdsdocno,
                              pmdsdocdt      LIKE pmds_t.pmdsdocdt,
                              pmds007        LIKE pmds_t.pmds007,
                              pmds007_desc   LIKE type_t.chr500,
                              pmds002        LIKE pmds_t.pmds002,
                              prog_b_pmds002 STRING,
                              pmds002_desc   LIKE type_t.chr500,
                              pmds003        LIKE pmds_t.pmds003,
                              pmds003_desc   LIKE type_t.chr500,
                              pmdtseq        LIKE pmdt_t.pmdtseq,
                              #150528-00023#1 add-S
                              pmdt006        LIKE pmdt_t.pmdt006,
                              pmdt006_desc   LIKE imaal_t.imaal003,
                              pmdt006_desc_1 LIKE imaal_t.imaal004,
                              pmdt007        LIKE pmdt_t.pmdt007,
                              pmdt007_desc   LIKE inaml_t.inaml004,
                              #150528-00023#1 add-E
                              pmdv019        LIKE pmdv_t.pmdv019,
                              pmdt019        LIKE pmdt_t.pmdt019,
                              pmdt019_desc   LIKE type_t.chr500,
                              pmdt051        LIKE pmdt_t.pmdt051, 
                              pmdt059        LIKE pmdt_t.pmdt059 
                            END RECORD
DEFINE g_pmdl_d             DYNAMIC ARRAY OF type_g_pmdl_d
DEFINE g_pmdl_d_t           type_g_pmdl_d
DEFINE g_pmds_d             DYNAMIC ARRAY OF type_g_pmds_d
DEFINE g_pmds_d_t           type_g_pmds_d
DEFINE g_qcba_d             DYNAMIC ARRAY OF type_g_qcba_d
DEFINE g_qcba_d_t           type_g_qcba_d 
DEFINE g_pmds2_d            DYNAMIC ARRAY OF type_g_pmds2_d
DEFINE g_pmds2_d_t          type_g_pmds2_d
DEFINE g_pmds3_d            DYNAMIC ARRAY OF type_g_pmds_d
DEFINE g_pmds3_d_t          type_g_pmds_d 
 TYPE type_tm        RECORD
                               radio01     LIKE type_t.chr1,
                               radio02     LIKE type_t.chr1
                            END RECORD
DEFINE tm                   type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmda_d            DYNAMIC ARRAY OF type_g_pmda_d
DEFINE g_pmda_d_t          type_g_pmda_d
 
 
 
 
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
 
{<section id="apmq400.main" >}
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
   DECLARE apmq400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq400_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq400_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq400 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq400_init()   
 
      #進入選單 Menu (="N")
      CALL apmq400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq400
      
   END IF 
   
   CLOSE apmq400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq400.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq400_init()
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
      CALL cl_set_combo_scc_part('b_pmdastus','13','Y,N,TJ,C,A,D,R,W,UH,H,X')
 
      CALL cl_set_combo_scc('b_pmdb032','2035') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('pmdastus','13')
   CALL cl_set_combo_scc('b_pmdlstus','13')
   CALL cl_set_combo_scc('b_pmdsstus','13')
   CALL cl_set_combo_scc('b_qcbastus','13') 
   CALL cl_set_combo_scc('b_pmdsstus1','13')
   CALL cl_set_combo_scc('b_pmdsstus2','13')  
   
   CALL cl_set_combo_scc('pmdb032','2035') 
   
   CALL cl_set_combo_scc('b_qcba022','5072')
   
   LET tm.radio01 = '4'
   LET tm.radio02 = '3'
   #end add-point
 
   CALL apmq400_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq400.default_search" >}
PRIVATE FUNCTION apmq400_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmdadocno = '", g_argv[01], "' AND "
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
 
{<section id="apmq400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq400_ui_dialog() 
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
   DEFINE l_sql     STRING
   DEFINE l_success LIKE type_t.num5
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
   CALL gfrm_curr.setFieldHidden('b_pmdl002', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_b_pmdl002', FALSE)

   CALL gfrm_curr.setFieldHidden('b_pmds002', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_b_pmds002', FALSE)

   CALL gfrm_curr.setFieldHidden('b_pmds0021', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_b_pmds0021', FALSE)

   CALL gfrm_curr.setFieldHidden('b_pmds0022', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_b_pmds0022', FALSE)
   #end add-point
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_pmda002', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_b_pmda002', FALSE) 
 
  
 
 
 
   CALL apmq400_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmda_d.clear()
 
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
 
         CALL apmq400_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pmdadocno,pmdadocdt,pmda002,pmda003,
                                   pmdb004,imaa009 ,pmdastus,pmdb032
            ON ACTION controlp INFIELD pmdadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmdadocno()
               DISPLAY g_qryparam.return1 TO pmdadocno  #顯示到畫面上
               NEXT FIELD CURRENT

            ON ACTION controlp INFIELD pmda002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmda002
               NEXT FIELD CURRENT

            ON ACTION controlp INFIELD pmda003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE 
               CALL q_ooeg001()
               DISPLAY g_qryparam.return1 TO pmda003
               NEXT FIELD CURRENT

            ON ACTION controlp INFIELD pmdb004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.WHERE = "1=1 "

               LET l_sql = ''
               CALL s_control_get_sql("imaa001",'6','3',g_user,g_dept) RETURNING l_success,l_sql
               IF l_success THEN
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
               END IF
               CALL q_imaf001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdb004
               NEXT FIELD CURRENT 
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

               NEXT FIELD CURRENT                      #返回原欄位

         END CONSTRUCT 
         
         INPUT BY NAME tm.radio01,tm.radio02 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT
         #end add-point
     
         DISPLAY ARRAY g_pmda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq400_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq400_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page1_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aooi130
                  LET g_action_choice="prog_aooi130"
                  IF cl_auth_chk_act("prog_aooi130") THEN
                     
                     #add-point:ON ACTION prog_aooi130 name="menu.detail_show.page1_sub.prog_aooi130"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aooi130'
               LET la_param.param[1] = g_pmda_d[g_detail_idx].pmda002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_pmdl_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               #LET g_current_page = 1

            BEFORE ROW
               #LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               #LET l_ac = g_detail_idx
               #DISPLAY g_detail_idx TO FORMONLY.h_index
               #DISPLAY g_pmda_d.getLength() TO FORMONLY.h_count
               #LET g_master_idx = l_ac
               #CALL apmq400_b_fill2()

         END DISPLAY
         DISPLAY ARRAY g_pmds_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY

            BEFORE ROW

         END DISPLAY
         DISPLAY ARRAY g_qcba_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY

            BEFORE ROW

         END DISPLAY 
         
         DISPLAY ARRAY g_pmds2_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY

            BEFORE ROW

         END DISPLAY
         DISPLAY ARRAY g_pmds3_d TO s_detail6.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY

            BEFORE ROW

         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apmq400_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD pmdadocno
 
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
            CALL apmq400_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmda_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_pmdl_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_pmds_d)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_qcba_d)
               LET g_export_id[4]   = "s_detail4"
               LET g_export_node[5] = base.typeInfo.create(g_pmds2_d)
               LET g_export_id[5]   = "s_detail5"
               LET g_export_node[6] = base.typeInfo.create(g_pmds3_d)
               LET g_export_id[6]   = "s_detail6"               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq400_b_fill()
 
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
            CALL apmq400_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq400_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq400_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq400_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmda_d.getLength()
               LET g_pmda_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmda_d.getLength()
               LET g_pmda_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmda_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmda_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq400_filter()
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
 
{<section id="apmq400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq400_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_input01       STRING
   DEFINE l_pmdp026       LIKE pmdp_t.pmdp026
   DEFINE l_max_pmdsdocdt LIKE pmds_t.pmdsdocdt 
   DEFINE l_success       LIKE type_t.num5
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
 
   CALL g_pmda_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',pmdastus,'',pmdadocno,pmdadocdt,pmda002,'',pmda003,'','','', 
       '','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY pmda_t.pmdadocno) AS RANK FROM pmda_t", 
 
 
 
                     "",
                     " WHERE pmdaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmda_t"),
                     " ORDER BY pmda_t.pmdadocno"
 
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
 
   LET g_sql = "SELECT '',pmdastus,'',pmdadocno,pmdadocdt,pmda002,'',pmda003,'','','','','','','','', 
       '','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   CASE tm.radio01
      WHEN '1'
         LET l_input01 = " pmdb006 < pmdb049 "
      WHEN '2'
         LET l_input01 = " pmdb006 = pmdb049 "
      WHEN '3'
         LET l_input01 = " pmdb006 > pmdb049 "
      WHEN '4'
         LET l_input01 = ' 1=1'
   END CASE

   LET g_sql = " SELECT UNIQUE 'N',pmdastus,pmdb032,pmdadocno,pmdadocdt,pmda002, ",
               "(SELECT ooag011 FROM ooag_t WHERE ooag001=pmda002 AND ooagent=pmdaent) ooag011,",
               "               pmda003, ",
               "(SELECT ooefl003 FROM ooefl_t WHERE ooefl001=pmda003 AND ooeflent=pmdaent AND ooefl002='"||g_dlang||"') ooefl003,",
               "               pmdbseq,pmdb004,",
               #"               imaal003,imaal004,",  #160510-00019#4  mark
               "(SELECT imaal003 FROM imaal_t WHERE imaalent=pmdbent AND imaal001=pmdb004 AND imaal002='"||g_dlang||"') imaal003, ",   #160510-00019#4 add
               "(SELECT imaal004 FROM imaal_t WHERE imaalent=pmdbent AND imaal001=pmdb004 AND imaal002='"||g_dlang||"') imaal004, ",   #160510-00019#4 add
               "               pmdb005, ",
               "(SELECT inaml004 FROM inaml_t WHERE inamlent=pmdbent AND inaml001=pmdb004 AND inaml002=pmdb005 AND inaml003='"||g_dlang||"') inaml004,",
               "               pmdb006,pmdb007, ",
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=pmdbent AND oocal001=pmdb007 AND oocal002='"||g_dlang||"') oocal003,",
               "               pmdb030,pmdb049,pmdb050 ",
               "   FROM pmda_t,pmdb_t ",
               "   LEFT JOIN imaa_t ON imaaent=pmdbent AND imaa001=pmdb004 ",
               #"   LEFT JOIN imaal_t ON imaalent=pmdbent AND imaal001=pmdb004 AND imaal002='"||g_dlang||"' ",   #160510-00019#4 mark
               "  WHERE pmdaent   = ? ",
               "    AND pmdasite  = '",g_site,"' ",
               "    AND pmdaent   = pmdbent ",
               "    AND pmdasite  = pmdbsite ",
               "    AND pmdadocno = pmdbdocno ",
               "    AND ",ls_wc,
               "    AND ",l_input01
   LET g_sql = g_sql, cl_sql_add_filter("pmda_t"),
                      " ORDER BY pmda_t.pmdadocno,pmdb_t.pmdbseq  "

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq400_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq400_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmda_d[l_ac].sel,g_pmda_d[l_ac].pmdastus,g_pmda_d[l_ac].pmdb032,g_pmda_d[l_ac].pmdadocno, 
       g_pmda_d[l_ac].pmdadocdt,g_pmda_d[l_ac].pmda002,g_pmda_d[l_ac].pmda002_desc,g_pmda_d[l_ac].pmda003, 
       g_pmda_d[l_ac].pmda003_desc,g_pmda_d[l_ac].pmdbseq,g_pmda_d[l_ac].pmdb004,g_pmda_d[l_ac].pmdb004_desc, 
       g_pmda_d[l_ac].pmdb004_desc_1,g_pmda_d[l_ac].pmdb005,g_pmda_d[l_ac].pmdb005_desc,g_pmda_d[l_ac].pmdb006, 
       g_pmda_d[l_ac].pmdb007,g_pmda_d[l_ac].pmdb007_desc,g_pmda_d[l_ac].pmdb030,g_pmda_d[l_ac].pmdb049, 
       g_pmda_d[l_ac].pmdb050
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = apmq400_get_hyper_data("prog_b_pmda002")
         LET g_pmda_d[l_ac].prog_b_pmda002 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_pmda_d[l_ac].pmda002), 
             "</a>"
 
      ELSE 
         LET g_pmda_d[l_ac].prog_b_pmda002 = g_pmda_d[l_ac].pmda002
 
      END IF 
 
 
 
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      IF tm.radio02 <> '3' THEN
         LET l_pmdp026 = ''
         SELECT DISTINCT pmdp026 INTO l_pmdp026
           FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmdpsite = g_site
            AND pmdp003 = g_pmda_d[l_ac].pmdadocno
            AND pmdp004 = g_pmda_d[l_ac].pmdbseq

         LET l_max_pmdsdocdt = ''
         SELECT MAX(pmdsdocdt) INTO l_max_pmdsdocdt
           FROM pmds_t,pmdv_t
          WHERE pmdsent = g_enterprise
            AND pmdssite = g_site
            AND pmdsdocno = pmdvdocno
            AND pmdv014 = g_pmda_d[l_ac].pmdadocno
            AND pmdv015 = g_pmda_d[l_ac].pmdbseq
         #正常:代表請購g_today未超過需求日期 
         #或是g_today已超過需求日期 但請購量已全部入庫且最後一次的入庫日期小於等於需求日期
         IF tm.radio02 = '1' THEN
            IF g_pmda_d[l_ac].pmdb030 < g_today THEN    #所以需求日期<today的就是絕對的安全 反之才要考慮  
               IF NOT (g_pmda_d[l_ac].pmdb006 = l_pmdp026 AND          #請購數量已全部入庫  
                       g_pmda_d[l_ac].pmdb030 >= l_max_pmdsdocdt AND  
                       NOT cl_null(l_max_pmdsdocdt)) THEN              #需求日大於入庫日   
                  CONTINUE FOREACH                                     #不滿足的就是不要  
               END IF
            END IF
         END IF 
         
         #延遲:代表請購需求日期已超過g_today且量未全部入庫，或是已全部入庫但最後一次的入庫日期大於需求日期 
         IF tm.radio02 = '2' THEN
            IF g_pmda_d[l_ac].pmdb030 >= g_today THEN       #如果需求日在今天之後 就不會是延遲  
               CONTINUE FOREACH
            END IF
            IF NOT (g_pmda_d[l_ac].pmdb006 <> l_pmdp026 OR
                    g_pmda_d[l_ac].pmdb030 < l_max_pmdsdocdt OR
                    cl_null(l_max_pmdsdocdt)) THEN
               CONTINUE FOREACH
            END IF
         END IF
      END IF

      #end add-point
 
      CALL apmq400_detail_show("'1'")
 
      CALL apmq400_pmda_t_mask()
 
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
 
   CALL g_pmda_d.deleteElement(g_pmda_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmda_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apmq400_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq400_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq400_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmda_d.getLength() > 0 THEN
      CALL apmq400_b_fill2()
   END IF
 
      CALL apmq400_filter_show('pmdastus','b_pmdastus')
   CALL apmq400_filter_show('pmdb032','b_pmdb032')
   CALL apmq400_filter_show('pmdadocno','b_pmdadocno')
   CALL apmq400_filter_show('pmdadocdt','b_pmdadocdt')
   CALL apmq400_filter_show('pmda002','b_pmda002')
   CALL apmq400_filter_show('pmda003','b_pmda003')
   CALL apmq400_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq400_filter_show('pmdb004','b_pmdb004')
   CALL apmq400_filter_show('pmdb005','b_pmdb005')
   CALL apmq400_filter_show('pmdb006','b_pmdb006')
   CALL apmq400_filter_show('pmdb007','b_pmdb007')
   CALL apmq400_filter_show('pmdb030','b_pmdb030')
   CALL apmq400_filter_show('pmdb049','b_pmdb049')
   CALL apmq400_filter_show('pmdb050','b_pmdb050')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq400.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq400_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_cnt01         LIKE type_t.num5            #因為qcba_t要由收貨資料來 所以多建一個  
   DEFINE l_cnt02         LIKE type_t.num5
   DEFINE l_cnt03         LIKE type_t.num5
   DEFINE l_pmdpdocno     LIKE pmdp_t.pmdpdocno
   DEFINE l_pmdvdocno     LIKE pmdv_t.pmdvdocno 
   DEFINE l_pmdt051       LIKE pmdt_t.pmdt051         #用來接資料而已  
   #ming 20150915 add -----------------------------(S) 
   DEFINE l_pmdpseq       LIKE pmdp_t.pmdpseq
   DEFINE l_pmdvseq       LIKE pmdv_t.pmdvseq
   #ming 20150915 add -----------------------------(E) 
   #161207-00033#22-S
   DEFINE l_pmdl028       LIKE pmdl_t.pmdl028    
   DEFINE l_qcba000       LIKE qcba_t.qcba000    
   DEFINE l_pmds007       LIKE pmds_t.pmds007
   DEFINE l_pmds028       LIKE pmds_t.pmds028
   #161207-00033#22-E
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_pmdl_d.clear()
   CALL g_pmds_d.clear() 
   CALL g_qcba_d.clear()  
   CALL g_pmds2_d.clear()
   CALL g_pmds3_d.clear()

   #ming 20150915 modify --------------------------(S) 
   #LET l_sql = "SELECT DISTINCT pmdpdocno ",
   LET l_sql = "SELECT DISTINCT pmdpdocno,pmdpseq ",
   #ming 20150915 modify --------------------------(E)
               "  FROM pmdp_t ",
               " WHERE pmdpent = '",g_enterprise,"' ",
               "   AND pmdpsite = '",g_site,"' ",
               "   AND pmdp003 = '",g_pmda_d[l_ac].pmdadocno,"' ",            #來源單號   
               "   AND pmdp004 = '",g_pmda_d[l_ac].pmdbseq,"' ",              #來源項次  
               " ORDER BY pmdpdocno "
   PREPARE apmq400_b_fill2_pmdpdocno_prep FROM l_sql
   DECLARE apmq400_b_fill2_pmdpdocno_curs CURSOR FOR apmq400_b_fill2_pmdpdocno_prep

   #ming 20150916 modify ----------------------------------------------------(S) 
   #LET l_sql = "SELECT pmdlstus,pmdldocno,pmdldocdt,pmdl004,'',pmdl002,'',",
   #            "       pmdl003,'',pmdnseq,pmdp024,pmdn006,'',pmdn012,pmdp025,pmdp026,pmdn050 ",
   #            "  FROM pmdl_t,pmdn_t,pmdp_t ",
   #            " WHERE pmdlent   = '",g_enterprise,"' ",
   #            "   AND pmdlsite  = '",g_site,"' ",
   #            "   AND pmdldocno = ? ", 
   #            #ming 20150915 add -------------------(S) 
   #            "   AND pmdnseq   = ? ",
   #            #ming 20150915 add -------------------(E)
   #            "   AND pmdldocno = pmdndocno ",
   #            "   AND pmdndocno = pmdpdocno ",
   #            "   AND pmdnseq   = pmdpseq " 
   #原本採購明細頁面會顯示關聯單據而有多筆資料 
   #但映泰反應採購明細頁面應該跟採購單身一樣只能看到一筆 
   #所以現在不會再取「其他」的關聯單據的「折合採購量」、「已收貨量」、「已入庫量」了 
   #只能看到「部分」的數量 
   LET l_sql = " SELECT pmdlstus,pmdldocno,pmdldocdt,pmdl004, ",
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=pmdlent AND pmaal001=pmdl004 AND pmaal002='"||g_dlang||"') pmaal004,",
               "        pmdl002, ",
               "(SELECT ooag011 FROM ooag_t WHERE ooagent=pmdlent AND ooag001=pmdl002) ooag011,",
               "        pmdl003, ",
               "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent=pmdlent AND ooefl001=pmdl003 AND ooefl002='"||g_dlang||"') ooefl003,",
               #150528-00023#1 mod-S
#               "        pmdnseq,0,pmdn006, ",
               "        pmdnseq,",
               "        pmdn001,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdnent AND imaal001 = pmdn001 AND imaal002 = '",g_dlang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdnent AND imaal001 = pmdn001 AND imaal002 = '",g_dlang,"') imaal004,",
               "        pmdn002,",
               "        (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdnent AND inaml001 = pmdn001 AND inaml002 = pmdn002 AND inaml003='",g_dlang,"') inaml004,",
               "        0,pmdn006, ",
               #150528-00023#1 mod-E
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=pmdnent AND oocal001=pmdn006 AND oocal002='"||g_dlang||"') oocal003,",
               "        pmdn012,0,0,pmdn050,pmdl028 ", #161207-00033#22  add pmdl028
               "   FROM pmdl_t,pmdn_t ",
               "  WHERE pmdlent   = '",g_enterprise,"' ",
               "    AND pmdlsite  = '",g_site,"' ",
               "    AND pmdldocno = ? ", 
               "    AND pmdnseq   = ? ",
               "    AND pmdldocno = pmdndocno ",
               "    AND pmdlent = pmdnent "
   #ming 20150916 modify ----------------------------------------------------(E) 
   PREPARE apmq400_b_fill2_pmdl_prep FROM l_sql
   DECLARE apmq400_b_fill2_pmdl_curs CURSOR FOR apmq400_b_fill2_pmdl_prep 
   
   LET l_sql = " SELECT pmdsstus,pmdsdocno,pmdsdocdt,pmds007, ",
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=pmdsent AND pmaal001=pmds007 AND pmaal002='"||g_dlang||"') pmaal004,",
               "        pmds002, ",
               "(SELECT ooag011 FROM ooag_t WHERE ooagent=pmdsent AND ooag001=pmds002) ooag011,",
               "        pmds003, ",
               "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent=pmdsent AND ooefl001=pmds003 AND ooefl002='"||g_dlang||"') ooefl003,",
               #150528-00023#1 mod-S
#               "        pmdtseq,pmdt020,pmdt019, ",
               "        pmdtseq,",
               "        pmdt006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal004,",
               "        pmdt007,",
               "        (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdtent AND inaml001 = pmdt006 AND inaml002 = pmdt007 AND inaml003='",g_dlang,"') inaml004,",
               "        pmdt020,pmdt019, ",
               #150528-00023#1 mod-E
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=pmdtent AND oocal001=pmdt019 AND oocal002='"||g_dlang||"') oocal003,",
               "        pmdt051,pmdt059,pmds028 ", #161207-00033#22  add pmds028
               "   FROM pmds_t,pmdt_t ",
               "  WHERE pmdsent   = '",g_enterprise,"' ",
               "    AND pmdssite  = '",g_site,"' ",
               "    AND pmdt001 = ? ",
               "    AND pmdt002 = ? ",
               "    AND pmdsent = pmdtent ",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmds000 = ? "
   PREPARE apmq400_b_fill2_pmds_prep3 FROM l_sql
   DECLARE apmq400_b_fill2_pmds_curs3 CURSOR FOR apmq400_b_fill2_pmds_prep3

   LET l_cnt = 1
   LET l_cnt02 = 1
   #ming 20150915 modify -------------------------------(S) 
   #FOREACH apmq400_b_fill2_pmdpdocno_curs INTO l_pmdpdocno
   FOREACH apmq400_b_fill2_pmdpdocno_curs INTO l_pmdpdocno,l_pmdpseq
   #ming 20150915 modify -------------------------------(E) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #ming 20150915 modify -------------------------------(S) 
      #FOREACH apmq400_b_fill2_pmdl_curs USING l_pmdpdocno
      FOREACH apmq400_b_fill2_pmdl_curs USING l_pmdpdocno,l_pmdpseq
      #ming 20150915 modify -------------------------------(E) 
         INTO g_pmdl_d[l_cnt].pmdlstus,g_pmdl_d[l_cnt].pmdldocno,
              g_pmdl_d[l_cnt].pmdldocdt,g_pmdl_d[l_cnt].pmdl004,
              g_pmdl_d[l_cnt].pmdl004_desc,g_pmdl_d[l_cnt].pmdl002,
              g_pmdl_d[l_cnt].pmdl002_desc,
              g_pmdl_d[l_cnt].pmdl003,g_pmdl_d[l_cnt].pmdl003_desc,
              #150528-00023#1 mod-S
#              g_pmdl_d[l_cnt].pmdnseq,g_pmdl_d[l_cnt].pmdp024,
              g_pmdl_d[l_cnt].pmdnseq,g_pmdl_d[l_cnt].pmdn001,
              g_pmdl_d[l_cnt].pmdn001_desc,g_pmdl_d[l_cnt].pmdn001_desc_1,
              g_pmdl_d[l_cnt].pmdn002,g_pmdl_d[l_cnt].pmdn002_desc,
              g_pmdl_d[l_cnt].pmdp024,
              #150528-00023#1 mod-E
              g_pmdl_d[l_cnt].pmdn006,g_pmdl_d[l_cnt].pmdn006_desc,
              g_pmdl_d[l_cnt].pmdn012,g_pmdl_d[l_cnt].pmdp025,
              g_pmdl_d[l_cnt].pmdp026,g_pmdl_d[l_cnt].pmdn050,l_pmdl028  #161207-00033#22 add l_pmdl028
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF 
         
         LET g_hyper_url = apmq400_get_hyper_data("prog_b_pmdl002")
         LET g_pmdl_d[l_cnt].prog_b_pmdl002 = "<a href = '",g_hyper_url,"'>",g_pmdl_d[l_cnt].pmdl002,"</a>"
         
         #ming 20150916 add -------------------------------(S) 
         SELECT pmdp024,pmdp025,pmdp026
           INTO g_pmdl_d[l_cnt].pmdp024,g_pmdl_d[l_cnt].pmdp025,
                g_pmdl_d[l_cnt].pmdp026
           FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmdpsite = g_site
            AND pmdp003  = g_pmda_d[l_ac].pmdadocno
            AND pmdp004  = g_pmda_d[l_ac].pmdbseq
            AND pmdpdocno = g_pmdl_d[l_cnt].pmdldocno  #160617-00019#1 add
         #ming 20150916 add -------------------------------(S) 
         #161207-00033#22-S
         IF NOT cl_null(l_pmdl028) THEN
            CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING g_pmdl_d[l_cnt].pmdl004_desc
         END IF
         #161207-00033#22-E
         LET l_cnt = l_cnt + 1
         IF l_cnt > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      END FOREACH
      
      #ming 20150915 modify --------------------------------(S) 
      #FOREACH apmq400_b_fill2_pmds_curs USING l_pmdvdocno,'5'
      FOREACH apmq400_b_fill2_pmds_curs3 USING l_pmdpdocno,l_pmdpseq,'5'
      #ming 20150915 modify --------------------------------(E) 
         INTO g_pmds2_d[l_cnt02].pmdsstus,    g_pmds2_d[l_cnt02].pmdsdocno,
              g_pmds2_d[l_cnt02].pmdsdocdt,   g_pmds2_d[l_cnt02].pmds007,
              g_pmds2_d[l_cnt02].pmds007_desc,g_pmds2_d[l_cnt02].pmds002,
              g_pmds2_d[l_cnt02].pmds002_desc,g_pmds2_d[l_cnt02].pmds003,
              g_pmds2_d[l_cnt02].pmds003_desc,g_pmds2_d[l_cnt02].pmdtseq,
              #150528-00023#1 add-S
              g_pmds2_d[l_cnt02].pmdt006,g_pmds2_d[l_cnt02].pmdt006_desc,g_pmds2_d[l_cnt02].pmdt006_desc_1,
              g_pmds2_d[l_cnt02].pmdt007,g_pmds2_d[l_cnt02].pmdt007_desc,
              #150528-00023#1 add-E
              g_pmds2_d[l_cnt02].pmdv019,     g_pmds2_d[l_cnt02].pmdt019,
              g_pmds2_d[l_cnt02].pmdt019_desc,g_pmds2_d[l_cnt02].pmdt051, 
              g_pmds2_d[l_cnt02].pmdt059,l_pmdl028  #161207-00033#22 add l_pmdl028
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF 
         
         LET g_hyper_url = apmq400_get_hyper_data("prog_b_pmds0021")
         LET g_pmds2_d[l_cnt02].prog_b_pmds002 = "<a href = '",g_hyper_url,"'>",g_pmds2_d[l_cnt02].pmds002,"</a>"
         #161207-00033#22-S
         IF NOT cl_null(l_pmdl028) THEN
            CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING g_pmds2_d[l_cnt02].pmds007_desc
         END IF
         #161207-00033#22-E
         LET l_cnt02 = l_cnt02 + 1
         IF l_cnt02 > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      END FOREACH 
   END FOREACH

   CALL g_pmdl_d.deleteElement(g_pmdl_d.getLength())
   CALL g_pmds2_d.deleteElement(g_pmds2_d.getLength())


   #--------------------------------------------------------------------------------

   #ming 20150915 modify --------------------------(S) 
   #LET l_sql = "SELECT DISTINCT pmdvdocno ",
   LET l_sql = "SELECT DISTINCT pmdvdocno,pmdvseq ",
   #ming 20150915 modify --------------------------(E) 
               "  FROM pmdv_t ",
               " WHERE pmdvent = '",g_enterprise,"' ",
               "   AND pmdvsite = '",g_site,"' ",
               "   AND pmdv014 = '",g_pmda_d[l_ac].pmdadocno,"' ",            #來源單號   
               "   AND pmdv015 = '",g_pmda_d[l_ac].pmdbseq,"' ",              #來源項次  
               " ORDER BY pmdvdocno "
   PREPARE apmq400_b_fill2_pmdvdocno_prep FROM l_sql
   DECLARE apmq400_b_fill2_pmdvdocno_curs CURSOR FOR apmq400_b_fill2_pmdvdocno_prep 

   LET l_sql = " SELECT pmdsstus,pmdsdocno,pmdsdocdt,pmds007, ",
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=pmdsent AND pmaal001=pmds007 AND pmaal002='"||g_dlang||"') pmaal004,",
               "        pmds002, ",
               "(SELECT ooag011 FROM ooag_t WHERE ooagent=pmdsent AND ooag001=pmds002) ooag011,",
               "        pmds003, ",
               "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent=pmdsent AND ooefl001=pmds003 AND ooefl002='"||g_dlang||"') ooefl003,",
               #150528-00023#1 mod-S
#               "        pmdtseq,pmdv019,pmdt019, ",
               "        pmdtseq,",
               "        pmdt006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal004,",
               "        pmdt007,",
               "        (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdtent AND inaml001 = pmdt006 AND inaml002 = pmdt007 AND inaml003='",g_dlang,"') inaml004,",
               "        pmdv019,pmdt019, ",
               #150528-00023#1 mod-E
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=pmdtent AND oocal001=pmdt019 AND oocal002='"||g_dlang||"') oocal003,",
               "        pmdt051,pmdt059,pmds028 ",   #161207-00033#22 add pmds028
               "   FROM pmds_t,pmdt_t,pmdv_t ",
               "  WHERE pmdsent   = '",g_enterprise,"' ",
               "    AND pmdssite  = '",g_site,"' ",
               "    AND pmdsdocno = ? ",
               #ming 20150915 add --------------------(S)
               "    AND pmdtseq   = ? ",
               #ming 20150915 add --------------------(E)
               "    AND pmdsent = pmdtent ",
               "    AND pmdtent = pmdvent ",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmdtdocno = pmdvdocno ",
               "    AND pmdtseq   = pmdvseq ",
               "    AND pmds000 = ? "
   PREPARE apmq400_b_fill2_pmds_prep FROM l_sql
   DECLARE apmq400_b_fill2_pmds_curs CURSOR FOR apmq400_b_fill2_pmds_prep

   LET l_sql = " SELECT qcbastus,qcbadocno,qcba014,qcba024,ooag011,ooag003,ooefl003,qcba005, ",
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=qcbaent AND pmaal001=qcba005 AND pmaal002='"||g_dlang||"') pmaal004,",
               #150528-00023#1 mod-S
#               "        qcba001,qcba002,qcba017,qcba022,qcba023,qcba000 ",  #161207-00033#22 add qcba000
               "        qcba001,qcba002,",
               "        qcba010,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = qcbaent AND imaal001 = qcba010 AND imaal002 = '",g_dlang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = qcbaent AND imaal001 = qcba010 AND imaal002 = '",g_dlang,"') imaal004,",
               "        qcba012,",
               "        (SELECT inaml004 FROM inaml_t WHERE inamlent = qcbaent AND inaml001 = qcba010 AND inaml002 = qcba012 AND inaml003='",g_dlang,"') inaml004,",
               "        qcba017,qcba022,qcba023,qcba000 ",
               #150528-00023#1 mod-E
               "   FROM pmdt_t,qcba_t  ",
               "   LEFT JOIN (SELECT ooagent,ooag001,ooag003,ooefl003,ooag011 FROM ooag_t ",
               "   LEFT JOIN ooefl_t ON ooeflent=ooagent AND ooefl001=ooag003 AND ooefl002='"||g_dlang||"')",
               "     ON ooagent=qcbaent AND ooag001=qcba024 ",
               "  WHERE pmdtent = '",g_enterprise,"' ",
               "    AND pmdtsite = '",g_site,"' ",
               "    AND pmdtdocno = ? ", 
               #ming 20150915 add ----------------(S) 
               "    AND pmdtseq   = ? ",
               #ming 20150915 add ----------------(E) 
               "    AND pmdtent = qcbaent ",
               "    AND pmdtdocno = qcba001 ",
               "    AND pmdtseq = qcba002 "
   PREPARE apmq400_b_fill2_qcba_prep FROM l_sql
   DECLARE apmq400_b_fill2_qcba_curs CURSOR FOR apmq400_b_fill2_qcba_prep 

   LET l_sql = " SELECT pmdsstus,pmdsdocno,pmdsdocdt,pmds007, ",
               "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent=pmdsent AND pmaal001=pmds007 AND pmaal002='"||g_dlang||"') pmaal004,",
               "        pmds002, ",
               "(SELECT ooag011 FROM ooag_t WHERE ooagent=pmdsent AND ooag001=pmds002) ooag011,",
               "        pmds003, ",
               "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent=pmdsent AND ooefl001=pmds003 AND ooefl002='"||g_dlang||"') ooefl003,",
               #150528-00023#1 mod-S
#               "        pmdtseq,pmdv019,pmdt019, ",
               "        pmdtseq,",
               "        pmdt006,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = pmdtent AND imaal001 = pmdt006 AND imaal002 = '",g_dlang,"') imaal004,",
               "        pmdt007,",
               "        (SELECT inaml004 FROM inaml_t WHERE inamlent = pmdtent AND inaml001 = pmdt006 AND inaml002 = pmdt007 AND inaml003='",g_dlang,"') inaml004,",
               "        pmdv019,pmdt019, ",
               #150528-00023#1 mod-E
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=pmdtent AND oocal001=pmdt019 AND oocal002='"||g_dlang||"') oocal003,",
               "        pmdt051,pmdt059,pmds028 ",  #161207-00033#22 add pmds028
               "   FROM pmds_t,pmdt_t,pmdv_t ",
               "  WHERE pmdsent   = '",g_enterprise,"' ",
               "    AND pmdssite  = '",g_site,"' ",
               "    AND pmdsdocno = ? ", 
               #ming 20150915 add -----------------------(S) 
               "    AND pmdtseq   = ? ",
               #ming 20150915 add -----------------------(E) 
               "    AND pmdsent = pmdtent ",
               "    AND pmdtent = pmdvent ",
               "    AND pmdsdocno = pmdtdocno ",
               "    AND pmdtdocno = pmdvdocno ",
               "    AND pmdtseq   = pmdvseq ", 
               #ming 20150924 modify -----(S) 
               "    AND pmdv014 = '",g_pmda_d[l_ac].pmdadocno,"' ",            #來源單號   
               "    AND pmdv015 = '",g_pmda_d[l_ac].pmdbseq,"' ",              #來源項次  
               #ming 20150924 modify -----(E) 
               #"    AND pmds000   IN ('3','6') " 
               "    AND pmds000 IN ('3','6','12','13','16','20','24','25')" 
   PREPARE apmq400_b_fill2_pmds_prep2 FROM l_sql
   DECLARE apmq400_b_fill2_pmds_curs2 CURSOR FOR apmq400_b_fill2_pmds_prep2

   LET l_cnt = 1
   LET l_cnt01 = 1 
   LET l_cnt03 = 1
   #ming 20150915 modify -------------------------------------(S) 
   #FOREACH apmq400_b_fill2_pmdvdocno_curs INTO l_pmdvdocno
   FOREACH apmq400_b_fill2_pmdvdocno_curs INTO l_pmdvdocno,l_pmdvseq
   #ming 20150915 modify -------------------------------------(E) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #ming 20150915 modify ---------------------------------(S) 
      #FOREACH apmq400_b_fill2_pmds_curs USING l_pmdvdocno,'1'
      FOREACH apmq400_b_fill2_pmds_curs USING l_pmdvdocno,l_pmdvseq,'1'
      #ming 20150915 modify ---------------------------------(E) 
         INTO g_pmds_d[l_cnt].pmdsstus,g_pmds_d[l_cnt].pmdsdocno,
              g_pmds_d[l_cnt].pmdsdocdt,g_pmds_d[l_cnt].pmds007,
              g_pmds_d[l_cnt].pmds007_desc,g_pmds_d[l_cnt].pmds002,
              g_pmds_d[l_cnt].pmds002_desc,g_pmds_d[l_cnt].pmds003,
              g_pmds_d[l_cnt].pmds003_desc,g_pmds_d[l_cnt].pmdtseq,
              #150528-00023#1 add-S
              g_pmds_d[l_cnt].pmdt006,g_pmds_d[l_cnt].pmdt006_desc,g_pmds_d[l_cnt].pmdt006_desc_1,
              g_pmds_d[l_cnt].pmdt007,g_pmds_d[l_cnt].pmdt007_desc,
              #150528-00023#1 add-E
              g_pmds_d[l_cnt].pmdv019,g_pmds_d[l_cnt].pmdt019,
              g_pmds_d[l_cnt].pmdt019_desc,l_pmdt051,
              g_pmds_d[l_cnt].pmdt059,l_pmdl028  #161207-00033#22 add l_pmdl028
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF   
         
         LET g_hyper_url = apmq400_get_hyper_data("prog_b_pmds002")
         LET g_pmds_d[l_cnt].prog_b_pmds002 = "<a href = '",g_hyper_url,"'>",g_pmds_d[l_cnt].pmds002,"</a>"
         
         #161207-00033#22-S
         IF NOT cl_null(l_pmdl028) THEN
            CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING g_pmds_d[l_cnt].pmds007_desc
         END IF
         #161207-00033#22-E
         
         LET l_cnt = l_cnt + 1
         IF l_cnt > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      END FOREACH

      #ming 20150915 modify ----------------------------(S) 
      #FOREACH apmq400_b_fill2_qcba_curs  USING l_pmdvdocno
      FOREACH apmq400_b_fill2_qcba_curs  USING l_pmdvdocno,l_pmdvseq
      #ming 20150915 modify ----------------------------(E) 
         INTO g_qcba_d[l_cnt01].qcbastus,g_qcba_d[l_cnt01].qcbadocno,
              g_qcba_d[l_cnt01].qcba014,g_qcba_d[l_cnt01].qcba024, 
              g_qcba_d[l_cnt01].qcba024_desc,g_qcba_d[l_cnt01].ooag003,
              g_qcba_d[l_cnt01].ooag003_desc,g_qcba_d[l_cnt01].qcba005,
              g_qcba_d[l_cnt01].qcba005_desc,g_qcba_d[l_cnt01].qcba001,
              #150528-00023#1 mod-S
#              g_qcba_d[l_cnt01].qcba002,g_qcba_d[l_cnt01].qcba017,
              g_qcba_d[l_cnt01].qcba002,
              g_qcba_d[l_cnt01].qcba010,g_qcba_d[l_cnt01].qcba010_desc,g_qcba_d[l_cnt01].qcba010_desc_1,
              g_qcba_d[l_cnt01].qcba012,g_qcba_d[l_cnt01].qcba012_desc,
              g_qcba_d[l_cnt01].qcba017,
              #150528-00023#1 mod-E
              g_qcba_d[l_cnt01].qcba022,g_qcba_d[l_cnt01].qcba023,l_qcba000   #161207-00033#22 add qcba000
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         ##161207-00033#22-S
         IF l_qcba000 = '1' THEN #IQC 採購入庫
            SELECT pmds007,pmds028 INTO l_pmds007,l_pmds028 FROM pmds_t 
             WHERE pmdsent = g_enterprsie
               AND pmdsdocno = g_qcba_d[l_cnt01].qcba001
            IF l_pmds007 = g_qcba_d[l_cnt01].qcba005 THEN
               CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_qcba_d[l_cnt01].qcba005_desc
            END IF             
         END IF
         IF l_qcba000 = '2' THEN #FQC 完工入库
         
         END IF  
         IF l_qcba000 = '3' THEN #PQC 完工入库
         END IF    
         IF l_qcba000 = '4' OR l_qcba000 = '6'  THEN #OQC 出貨 & #RQC 銷退
            SELECT xmdk007,xmdk047 INTO l_pmds007,l_pmds028 FROM xmdk_t 
             WHERE xmdkent = g_enterprise
               AND xmdkdocno = g_qcba_d[l_cnt01].qcba001
            IF l_pmds007 = g_qcba_d[l_cnt01].qcba005 THEN
               CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_qcba_d[l_cnt01].qcba005_desc
            END IF                   
         END IF         
         ##161207-00033#22-E
         LET l_cnt01 = l_cnt01 + 1 
         IF l_cnt01 > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      END FOREACH 
      
      #ming 20150915 modify -----------------------------(S) 
      #FOREACH apmq400_b_fill2_pmds_curs2 USING l_pmdvdocno
      FOREACH apmq400_b_fill2_pmds_curs2 USING l_pmdvdocno,l_pmdvseq
      #ming 20150915 modify -----------------------------(E) 
         INTO g_pmds3_d[l_cnt03].pmdsstus,    g_pmds3_d[l_cnt03].pmdsdocno,
              g_pmds3_d[l_cnt03].pmdsdocdt,   g_pmds3_d[l_cnt03].pmds007,
              g_pmds3_d[l_cnt03].pmds007_desc,g_pmds3_d[l_cnt03].pmds002,
              g_pmds3_d[l_cnt03].pmds002_desc,g_pmds3_d[l_cnt03].pmds003,
              g_pmds3_d[l_cnt03].pmds003_desc,g_pmds3_d[l_cnt03].pmdtseq,
              #150528-00023#1 add-S
              g_pmds3_d[l_cnt03].pmdt006,g_pmds3_d[l_cnt03].pmdt006_desc,g_pmds3_d[l_cnt03].pmdt006_desc_1,
              g_pmds3_d[l_cnt03].pmdt007,g_pmds3_d[l_cnt03].pmdt007_desc,
              #150528-00023#1 add-E
              g_pmds3_d[l_cnt03].pmdv019,     g_pmds3_d[l_cnt03].pmdt019,
              g_pmds3_d[l_cnt03].pmdt019_desc,l_pmdt051,
              g_pmds3_d[l_cnt03].pmdt059,l_pmdl028  #161207-00033#22 add l_pmdl028
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF 
         
         LET g_hyper_url = apmq400_get_hyper_data("prog_b_pmds0022")
         LET g_pmds3_d[l_cnt03].prog_b_pmds002 = "<a href = '",g_hyper_url,"'>",g_pmds3_d[l_cnt03].pmds002,"</a>"
         #161207-00033#22-S
         IF NOT cl_null(l_pmdl028) THEN
            CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING g_pmds3_d[l_cnt03].pmds007_desc
         END IF
         #161207-00033#22-E
         LET l_cnt03 = l_cnt03 + 1
         IF l_cnt03 > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      END FOREACH

   END FOREACH

   CALL g_pmds_d.deleteElement(g_pmds_d.getLength())
   CALL g_qcba_d.deleteElement(g_qcba_d.getLength())   
   CALL g_pmds3_d.deleteElement(g_pmds3_d.getLength())
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
 
{<section id="apmq400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq400_detail_show(ps_page)
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
 
{<section id="apmq400.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq400_filter()
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
 
   #應用 qs02 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT前，需先將查詢欄位開啟、顯示欄位隱藏 
   CALL gfrm_curr.setFieldHidden('prog_b_pmda002', TRUE) 
   CALL gfrm_curr.setFieldHidden('b_pmda002', FALSE) 
 
  
 
 
 
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON pmdastus,pmdb032,pmdadocno,pmdadocdt,pmda002,pmda003,pmdbseq,pmdb004, 
          pmdb005,pmdb006,pmdb007,pmdb030,pmdb049,pmdb050
                          FROM s_detail1[1].b_pmdastus,s_detail1[1].b_pmdb032,s_detail1[1].b_pmdadocno, 
                              s_detail1[1].b_pmdadocdt,s_detail1[1].b_pmda002,s_detail1[1].b_pmda003, 
                              s_detail1[1].b_pmdbseq,s_detail1[1].b_pmdb004,s_detail1[1].b_pmdb005,s_detail1[1].b_pmdb006, 
                              s_detail1[1].b_pmdb007,s_detail1[1].b_pmdb030,s_detail1[1].b_pmdb049,s_detail1[1].b_pmdb050 
 
 
         BEFORE CONSTRUCT
                     DISPLAY apmq400_filter_parser('pmdastus') TO s_detail1[1].b_pmdastus
            DISPLAY apmq400_filter_parser('pmdb032') TO s_detail1[1].b_pmdb032
            DISPLAY apmq400_filter_parser('pmdadocno') TO s_detail1[1].b_pmdadocno
            DISPLAY apmq400_filter_parser('pmdadocdt') TO s_detail1[1].b_pmdadocdt
            DISPLAY apmq400_filter_parser('pmda002') TO s_detail1[1].b_pmda002
            DISPLAY apmq400_filter_parser('pmda003') TO s_detail1[1].b_pmda003
            DISPLAY apmq400_filter_parser('pmdbseq') TO s_detail1[1].b_pmdbseq
            DISPLAY apmq400_filter_parser('pmdb004') TO s_detail1[1].b_pmdb004
            DISPLAY apmq400_filter_parser('pmdb005') TO s_detail1[1].b_pmdb005
            DISPLAY apmq400_filter_parser('pmdb006') TO s_detail1[1].b_pmdb006
            DISPLAY apmq400_filter_parser('pmdb007') TO s_detail1[1].b_pmdb007
            DISPLAY apmq400_filter_parser('pmdb030') TO s_detail1[1].b_pmdb030
            DISPLAY apmq400_filter_parser('pmdb049') TO s_detail1[1].b_pmdb049
            DISPLAY apmq400_filter_parser('pmdb050') TO s_detail1[1].b_pmdb050
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmdastus>>----
         #Ctrlp:construct.c.filter.page1.b_pmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdastus
            #add-point:ON ACTION controlp INFIELD b_pmdastus name="construct.c.filter.page1.b_pmdastus"
            
            #END add-point
 
 
         #----<<b_pmdb032>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb032
            #add-point:ON ACTION controlp INFIELD b_pmdb032 name="construct.c.filter.page1.b_pmdb032"
            
            #END add-point
 
 
         #----<<b_pmdadocno>>----
         #Ctrlp:construct.c.page1.b_pmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdadocno
            #add-point:ON ACTION controlp INFIELD b_pmdadocno name="construct.c.filter.page1.b_pmdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdadocno  #顯示到畫面上
            NEXT FIELD b_pmdadocno                     #返回原欄位
    


            #END add-point
 
 
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
 
 
         #----<<prog_b_pmda002>>----
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
         #----<<b_pmdbseq>>----
         #Ctrlp:construct.c.filter.page1.b_pmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbseq
            #add-point:ON ACTION controlp INFIELD b_pmdbseq name="construct.c.filter.page1.b_pmdbseq"
            
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
 
 
         #----<<b_pmdb004_desc>>----
         #----<<b_pmdb004_desc_1>>----
         #----<<b_pmdb005>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb005
            #add-point:ON ACTION controlp INFIELD b_pmdb005 name="construct.c.filter.page1.b_pmdb005"
            
            #END add-point
 
 
         #----<<b_pmdb005_desc>>----
         #----<<b_pmdb006>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb006
            #add-point:ON ACTION controlp INFIELD b_pmdb006 name="construct.c.filter.page1.b_pmdb006"
            
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
         #----<<b_pmdb030>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb030
            #add-point:ON ACTION controlp INFIELD b_pmdb030 name="construct.c.filter.page1.b_pmdb030"
            
            #END add-point
 
 
         #----<<b_pmdb049>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb049
            #add-point:ON ACTION controlp INFIELD b_pmdb049 name="construct.c.filter.page1.b_pmdb049"
            
            #END add-point
 
 
         #----<<b_pmdb050>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb050
            #add-point:ON ACTION controlp INFIELD b_pmdb050 name="construct.c.filter.page1.b_pmdb050"
            
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
 
 
 
 
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_pmda002', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_b_pmda002', FALSE) 
 
  
 
 
 
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL apmq400_filter_show('pmdastus','b_pmdastus')
   CALL apmq400_filter_show('pmdb032','b_pmdb032')
   CALL apmq400_filter_show('pmdadocno','b_pmdadocno')
   CALL apmq400_filter_show('pmdadocdt','b_pmdadocdt')
   CALL apmq400_filter_show('pmda002','b_pmda002')
   CALL apmq400_filter_show('pmda003','b_pmda003')
   CALL apmq400_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq400_filter_show('pmdb004','b_pmdb004')
   CALL apmq400_filter_show('pmdb005','b_pmdb005')
   CALL apmq400_filter_show('pmdb006','b_pmdb006')
   CALL apmq400_filter_show('pmdb007','b_pmdb007')
   CALL apmq400_filter_show('pmdb030','b_pmdb030')
   CALL apmq400_filter_show('pmdb049','b_pmdb049')
   CALL apmq400_filter_show('pmdb050','b_pmdb050')
 
 
   CALL apmq400_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq400.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq400_filter_parser(ps_field)
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
 
{<section id="apmq400.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq400_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq400.get_hyper_data" >}
#應用 qs01 樣板自動產生(Version:9) 
#+ 取得單身串查網址(包含程式代號及參數) 
PRIVATE FUNCTION apmq400_get_hyper_data(ps_field_name) 
   #add-point:get_hyper_data段define-客製 name="get_hyper_data.define_customerization" 
   
   #end add-point 
   DEFINE ps_field_name    STRING 
   DEFINE ps_url           STRING 
   DEFINE ls_js            STRING 
   DEFINE la_param         RECORD 
                           prog       STRING, 
                           actionid   STRING, 
                           background LIKE type_t.chr1, 
                           param      DYNAMIC ARRAY OF STRING 
                           END RECORD 
   DEFINE ps_type          LIKE type_t.chr10 
   #add-point:get_hyper_data段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="get_hyper_data.define" 
   
   #end add-point 
  
  
   #add-point:FUNCTION前置處理 name="get_hyper_data.before_function" 
   
   #end add-point 
  
   LET ps_url = NULL 
  
   # 設定要做串查的程式代碼 
   CASE 
      WHEN ps_field_name = "prog_b_pmda002" 
         LET la_param.prog = "aooi130" 
  
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_pmda_d[l_ac].pmda002 
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_b_pmda002" 
         
         #end add-point 
  
 
   END CASE 
  
   # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
   #add-point:傳入參數設定 name="get_hyper_data.set_parameter" 
   CASE
      WHEN ps_field_name = "prog_b_pmda002"
         LET la_param.prog = "aooi130"
      WHEN ps_field_name = "prog_b_pmdl002"
         LET la_param.prog = "aooi130"
      WHEN ps_field_name = "prog_b_pmds002"
         LET la_param.prog = "aooi130"
      WHEN ps_field_name = "prog_b_pmds0021"
         LET la_param.prog = "aooi130"
      WHEN ps_field_name = "prog_b_pmds0022"
         LET la_param.prog = "aooi130"

   END CASE
   #end add-point 
  
   #將陣列資料組合成一個string字串 
   LET ls_js = util.JSON.stringify(la_param) 
  
   #依環境設定要走GDC或GWC模式 (""表示會依據目前的環境判斷，若有自行定義，會依據所定義的模式去執行) 
   LET ps_type = "" 
   #add-point:定義執行模式 name="get_hyper_data.set_env" 
   
   #end add-point 
  
   #呼叫lib，取得完整的url資訊 
   CALL cl_ap_url(ps_type,ls_js) RETURNING ps_url 
 
   LET ps_url = cl_replace_str(ps_url, "&", "&amp;")  
   RETURN ps_url 
  
END FUNCTION 
 
{</section>}
 
{<section id="apmq400.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq400_detail_action_trans()
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
 
{<section id="apmq400.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq400_detail_index_setting()
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
            IF g_pmda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmda_d.getLength() AND g_pmda_d.getLength() > 0
            LET g_detail_idx = g_pmda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmda_d.getLength() THEN
               LET g_detail_idx = g_pmda_d.getLength()
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
 
{<section id="apmq400.mask_functions" >}
 &include "erp/apm/apmq400_mask.4gl"
 
{</section>}
 
{<section id="apmq400.other_function" readonly="Y" >}

 
{</section>}
 
