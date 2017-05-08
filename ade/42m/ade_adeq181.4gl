#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq181.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-03-31 14:41:46), PR版次:0006(2016-10-26 17:40:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: adeq181
#+ Description: 門店折扣查詢
#+ Creator....: 06540(2015-09-16 08:00:41)
#+ Modifier...: 06137 -SD/PR- 08729
 
{</section>}
 
{<section id="adeq181.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#5     2016/10/19  by  08729  處理組織開窗
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
PRIVATE TYPE type_g_rtjb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       rtjadocdt LIKE rtja_t.rtjadocdt, 
   l_bdate LIKE type_t.chr500, 
   l_edate LIKE type_t.chr500, 
   rtjbsite LIKE rtjb_t.rtjbsite, 
   ooefl003 LIKE ooefl_t.ooefl003, 
   rtjb004 LIKE rtjb_t.rtjb004, 
   imaal003 LIKE imaal_t.imaal003, 
   rtjb025 LIKE rtjb_t.rtjb025, 
   inayl003 LIKE inayl_t.inayl003, 
   rtjb028 LIKE rtjb_t.rtjb028, 
   stfal003 LIKE stfal_t.stfal003, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   rtaxl003 LIKE rtaxl_t.rtaxl003, 
   rtjc002 LIKE type_t.chr500, 
   rtjc013 LIKE rtjc_t.rtjc013 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_sql_detail STRING
DEFINE g_sql_del    STRING 
DEFINE g_sql_ins    STRING
DEFINE g_sum_sql    STRING

#INPUT条件
DEFINE bdate                LIKE type_t.dat
DEFINE edate                LIKE type_t.dat
DEFINE l_sumby              LIKE type_t.chr1

#存旧值
DEFINE l_rtjbsite STRING
DEFINE l_rtjb028  STRING
DEFINE l_rtjb025  STRING
DEFINE l_rtjb003  STRING
DEFINE l_rtaw001  STRING
#160318-00011#1 Modify By Ken 160331(S)
#DEFINE l_stfa003  STRING
#DEFINE l_stfa012  STRING
DEFINE l_rtdx003  STRING
DEFINE l_imaa126  STRING
#160318-00011#1 Modify By Ken 160331(E)
DEFINE l_rtjc002  STRING
DEFINE l_rtjc006  STRING 

DEFINE g_rtjb_d1 DYNAMIC ARRAY OF RECORD  #按库区
   rtjadocdt    LIKE rtja_t.rtjadocdt, 
   l_bdate1     LIKE type_t.chr500, 
   l_edate1     LIKE type_t.chr500, 
   rtjbsite     LIKE rtjb_t.rtjbsite, 
   l_ooefl003_1 LIKE ooefl_t.ooefl003, 
   rtjb025      LIKE rtjb_t.rtjb025, 
   inayl003     LIKE inayl_t.inayl003, 
   rtjb028      LIKE rtjb_t.rtjb028, 
   stfal003     LIKE stfal_t.stfal003, 
   rtaw001      LIKE rtaw_t.rtaw001, 
   rtaxl003     LIKE rtaxl_t.rtaxl003, 
   rtjc002      LIKE rtjc_t.rtjc002, 
   rtjc013      LIKE rtjc_t.rtjc013 
       END RECORD
       
DEFINE g_rtjb_d2 DYNAMIC ARRAY OF RECORD  #按专柜
   rtjadocdt    LIKE rtja_t.rtjadocdt, 
   l_bdate2     LIKE type_t.chr500, 
   l_edate2     LIKE type_t.chr500, 
   rtjbsite     LIKE rtjb_t.rtjbsite,
   l_ooefl003_2 LIKE ooefl_t.ooefl003,    
   rtjb028      LIKE rtjb_t.rtjb028, 
   stfal003     LIKE stfal_t.stfal003, 
   rtaw001      LIKE rtaw_t.rtaw001, 
   rtaxl003     LIKE rtaxl_t.rtaxl003, 
   rtjc002      LIKE rtjc_t.rtjc002, 
   rtjc013      LIKE rtjc_t.rtjc013 
       END RECORD
       
DEFINE g_rtjb_d3 DYNAMIC ARRAY OF RECORD  #按部类
   rtjadocdt    LIKE rtja_t.rtjadocdt, 
   l_bdate3     LIKE type_t.chr500, 
   l_edate3     LIKE type_t.chr500, 
   rtjbsite     LIKE rtjb_t.rtjbsite, 
   l_ooefl003_3 LIKE ooefl_t.ooefl003, 
   rtaw001      LIKE rtaw_t.rtaw001, 
   rtaxl003     LIKE rtaxl_t.rtaxl003, 
   rtjc002      LIKE rtjc_t.rtjc002, 
   rtjc013      LIKE rtjc_t.rtjc013 
       END RECORD
       
DEFINE g_rtjb_d4 DYNAMIC ARRAY OF RECORD  #按门店
   rtjadocdt    LIKE rtja_t.rtjadocdt, 
   l_bdate4     LIKE type_t.chr500, 
   l_edate4     LIKE type_t.chr500, 
   rtjbsite     LIKE rtjb_t.rtjbsite, 
   l_ooefl003_4 LIKE ooefl_t.ooefl003, 
   rtjc002      LIKE rtjc_t.rtjc002, 
   rtjc013      LIKE rtjc_t.rtjc013 
       END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_rtjb_d
DEFINE g_master_t                   type_g_rtjb_d
DEFINE g_rtjb_d          DYNAMIC ARRAY OF type_g_rtjb_d
DEFINE g_rtjb_d_t        type_g_rtjb_d
 
      
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
 
{<section id="adeq181.main" >}
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
   CALL cl_ap_init("ade","")
 
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
   DECLARE adeq181_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq181_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq181_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq181 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq181_init()   
 
      #進入選單 Menu (="N")
      CALL adeq181_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq181
      
   END IF 
   
   CLOSE adeq181_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL adeq181_drop_tmp() RETURNING l_success
   CALL s_aooi500_drop_temp() RETURNING l_success #161006-00008#5 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq181.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq181_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL adeq181_create_tmp() RETURNING l_success
   LET bdate = g_today
   LET edate = g_today
   LET l_sumby = 'N'
   LET l_rtjbsite = g_site
   DISPLAY l_rtjbsite TO rtjbsite
   DISPLAY BY NAME bdate,edate,l_sumby
   #160318-00011#1 Modify By Ken 160331(S)
   #CALL cl_set_combo_scc('stfa003','6013')
   CALL cl_set_combo_scc('rtdx003','6013')
   #160318-00011#1 Modify By Ken 160331(E)
   CALL cl_set_combo_scc('rtjc002','6708') 
   CALL cl_set_combo_scc('b_rtjc002','6708') 
   CALL cl_set_combo_scc('b_rtjc002_1','6708') 
   CALL cl_set_combo_scc('b_rtjc002_2','6708') 
   CALL cl_set_combo_scc('b_rtjc002_3','6708') 
   CALL cl_set_combo_scc('b_rtjc002_4','6708') 
   CALL cl_set_combo_scc('rtjc006','6852') 

   #清空
   LET l_rtjbsite   = ''
   LET l_rtjb028    = ''
   LET l_rtjb025    = ''
   LET l_rtjb003    = ''
   LET l_rtaw001    = ''
   #160318-00011#1 Modify By Ken 160331(S)
   #LET l_stfa003    = ''
   #LET l_stfa012    = ''
   LET l_rtdx003    = ''
   LET l_imaa126    = ''
   #160318-00011#1 Modify By Ken 160331(E)
   LET l_rtjc002    = ''
   LET l_rtjc006    = ''

   #end add-point
 
   CALL adeq181_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq181.default_search" >}
PRIVATE FUNCTION adeq181_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjbdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtjbseq = '", g_argv[02], "' AND "
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
 
{<section id="adeq181.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq181_ui_dialog()
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
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL adeq181_b_fill()
   ELSE
      CALL adeq181_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtjb_d.clear()
 
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
 
         CALL adeq181_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtjb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq181_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq181_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #160126-00002#2 Add By Ken 160203(s)
         CONSTRUCT g_wc_table 
                ON rtjbsite,rtjb028,rtjb025,rtjb003,rtaw001,rtdx003,imaa126,rtjc006,rtjc002  #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
              FROM rtjbsite,rtjb028,rtjb025,rtjb003,rtaw001,rtdx003,imaa126,rtjc006,rtjc002  #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
                         
            BEFORE CONSTRUCT
               #add-point:cs段more_construct
            
               #end add-point 
         
            ON ACTION controlp INFIELD rtjbsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjbsite',g_site,'c')
               CALL q_ooef001_24()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtjbsite  #顯示到畫面上
               NEXT FIELD rtjbsite                     #返回原欄位
         
            ON ACTION controlp INFIELD rtjb003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_imay003()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtjb003  #顯示到畫面上
               NEXT FIELD rtjb003                     #返回原欄位
         
            ON ACTION controlp INFIELD rtjb025
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_inay001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtjb025  #顯示到畫面上
               NEXT FIELD rtjb025                     #返回原欄位
         
            ON ACTION controlp INFIELD rtjb028
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_mhae001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtjb028  #顯示到畫面上
               NEXT FIELD rtjb028                     #返回原欄位
          
            ON ACTION controlp INFIELD rtaw001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
               CALL q_rtax001()                            #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上
               NEXT FIELD rtaw001                     #返回原欄位
         
            ON ACTION controlp INFIELD imaa126   #160318-00011#1 Add By Ken 160331 原stfa012改imaa126
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
#               IF g_argv[1] = 2 THEN
#                  LET g_qryparam.where = " oocq022 = '2'"
#               END IF
               CALL q_oocq002_2002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上  #160318-00011#1 Add By Ken 160331 原stfa012改imaa126
               NEXT FIELD imaa126                     #返回原欄位    #160318-00011#1 Add By Ken 160331 原stfa012改imaa126
         
            AFTER FIELD rtjb028 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjb028
            AFTER FIELD rtjb025 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjb025
            AFTER FIELD rtjb003 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjb003
            AFTER FIELD rtaw001 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtaw001
            #160318-00011#1 Add By Ken 160331(S)
            #AFTER FIELD stfa003 CALL FGL_DIALOG_GETBUFFER() RETURNING l_stfa003
            #AFTER FIELD stfa012 CALL FGL_DIALOG_GETBUFFER() RETURNING l_stfa012
            AFTER FIELD rtdx003 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtdx003
            AFTER FIELD imaa126 CALL FGL_DIALOG_GETBUFFER() RETURNING l_imaa126            
            #160318-00011#1 Add By Ken 160331(E)
            AFTER FIELD rtjc002 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjc002 
            AFTER FIELD rtjc006 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjc006
                                                                      
         END CONSTRUCT  
         
         INPUT bdate,edate,l_sumby FROM bdate,edate,l_sumby
            ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT 
               DISPLAY BY NAME bdate,edate 
               IF cl_null(bdate) THEN 
                 LET bdate = g_today
               END IF
               IF cl_null(edate) THEN            
                 LET edate = g_today
               END IF 
         
            AFTER FIELD bdate
                IF NOT cl_null(bdate) THEN
                         IF bdate > edate THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "" 
                            LET g_errparam.code   = 'amr-00072' # 起始时间不可大于截止时间
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            NEXT FIELD bdate
                         END IF
                      END IF
             AFTER FIELD edate
                IF NOT cl_null(edate) THEN
                   IF edate < bdate THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = "" 
                      LET g_errparam.code   = 'amm-00094' # 结束时间必须大于等于开始时间
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      NEXT FIELD edate
                      END IF
                END IF
            
            AFTER INPUT
               IF INT_FLAG THEN
#               	LET INT_FLAG=0
#                  EXIT INPUT
               END IF
         END INPUT            
         #160126-00002#2 Add By Ken 160203(e)         
         
         
         DISPLAY ARRAY g_rtjb_d1 TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d1.getLength() TO FORMONLY.h_count
 
         END DISPLAY 
         
         
         DISPLAY ARRAY g_rtjb_d2 TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d2.getLength() TO FORMONLY.h_count
 
         END DISPLAY 
         
         
         DISPLAY ARRAY g_rtjb_d3 TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d3.getLength() TO FORMONLY.h_count
 
         END DISPLAY
         
         
         DISPLAY ARRAY g_rtjb_d4 TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_rtjb_d4.getLength() TO FORMONLY.h_count
 
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq181_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160126-00002#2 Add By Ken 160203(S)
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            CALL cl_set_act_visible("insert,query", FALSE)
            #160126-00002#2 Add By Ken 160203(E)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq181_insert()
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
               CALL adeq181_query()
               #add-point:ON ACTION query name="menu.query"
               CALL adeq181_query2()
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
            CALL adeq181_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel", FALSE)   #160126-00002#2 Add By Ken 160203
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
            CALL adeq181_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtjb_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_rtjb_d1)
               LET g_export_id[2]   = "s_detail2"

               LET g_export_node[3] = base.typeInfo.create(g_rtjb_d2)
               LET g_export_id[3]   = "s_detail3"
               
               LET g_export_node[4] = base.typeInfo.create(g_rtjb_d3)
               LET g_export_id[4]   = "s_detail4"
               
               LET g_export_node[5] = base.typeInfo.create(g_rtjb_d4)
               LET g_export_id[5]   = "s_detail5"
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
            CALL adeq181_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq181_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq181_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq181_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         #160126-00002#2 Add By Ken 160203(s)
         ON ACTION ACCEPT
            
            IF cl_null(bdate) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'ade-00164'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD bdate 
            END IF
            
            IF cl_null(edate) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'ade-00165'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD edate 
            END IF            
            
            LET g_detail_idx = 1
            LET g_wc = g_wc_table
            CALL adeq181_b_fill()
            LET l_ac = g_master_idx
            IF g_rtjb_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            END IF            
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = -100 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            
            END IF
         #160126-00002#2 Add By Ken 160203(e)
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
 
{<section id="adeq181.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq181_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   RETURN   #151104-00002#1 20151117 mark by beckxie
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   #RETURN    #151104-00002#1 20151117  add by beckxie
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_rtjb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON rtjadocdt,rtjbsite,ooefl003,rtjb004,imaal003,rtjb025,inayl003,rtjb028, 
          stfal003,rtaw001,rtaxl003,rtjc013
           FROM s_detail1[1].b_rtjadocdt,s_detail1[1].b_rtjbsite,s_detail1[1].b_ooefl003,s_detail1[1].b_rtjb004, 
               s_detail1[1].b_imaal003,s_detail1[1].b_rtjb025,s_detail1[1].b_inayl003,s_detail1[1].b_rtjb028, 
               s_detail1[1].b_stfal003,s_detail1[1].b_rtaw001,s_detail1[1].b_rtaxl003,s_detail1[1].b_rtjc013 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_rtjadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjadocdt
            #add-point:BEFORE FIELD b_rtjadocdt name="construct.b.page1.b_rtjadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjadocdt
            
            #add-point:AFTER FIELD b_rtjadocdt name="construct.a.page1.b_rtjadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocdt
            #add-point:ON ACTION controlp INFIELD b_rtjadocdt name="construct.c.page1.b_rtjadocdt"
            
            #END add-point
 
 
         #----<<l_bdate>>----
         #----<<l_edate>>----
         #----<<b_rtjbsite>>----
         #Ctrlp:construct.c.page1.b_rtjbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbsite
            #add-point:ON ACTION controlp INFIELD b_rtjbsite name="construct.c.page1.b_rtjbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjbsite  #顯示到畫面上
            NEXT FIELD b_rtjbsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjbsite
            #add-point:BEFORE FIELD b_rtjbsite name="construct.b.page1.b_rtjbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjbsite
            
            #add-point:AFTER FIELD b_rtjbsite name="construct.a.page1.b_rtjbsite"
            
            #END add-point
            
 
 
         #----<<b_ooefl003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_ooefl003
            #add-point:BEFORE FIELD b_ooefl003 name="construct.b.page1.b_ooefl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_ooefl003
            
            #add-point:AFTER FIELD b_ooefl003 name="construct.a.page1.b_ooefl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_ooefl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ooefl003
            #add-point:ON ACTION controlp INFIELD b_ooefl003 name="construct.c.page1.b_ooefl003"
            
            #END add-point
 
 
         #----<<b_rtjb004>>----
         #Ctrlp:construct.c.page1.b_rtjb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb004
            #add-point:ON ACTION controlp INFIELD b_rtjb004 name="construct.c.page1.b_rtjb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb004  #顯示到畫面上
            NEXT FIELD b_rtjb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjb004
            #add-point:BEFORE FIELD b_rtjb004 name="construct.b.page1.b_rtjb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjb004
            
            #add-point:AFTER FIELD b_rtjb004 name="construct.a.page1.b_rtjb004"
            
            #END add-point
            
 
 
         #----<<b_imaal003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaal003
            #add-point:BEFORE FIELD b_imaal003 name="construct.b.page1.b_imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaal003
            
            #add-point:AFTER FIELD b_imaal003 name="construct.a.page1.b_imaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaal003
            #add-point:ON ACTION controlp INFIELD b_imaal003 name="construct.c.page1.b_imaal003"
            
            #END add-point
 
 
         #----<<b_rtjb025>>----
         #Ctrlp:construct.c.page1.b_rtjb025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb025
            #add-point:ON ACTION controlp INFIELD b_rtjb025 name="construct.c.page1.b_rtjb025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb025  #顯示到畫面上
            NEXT FIELD b_rtjb025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjb025
            #add-point:BEFORE FIELD b_rtjb025 name="construct.b.page1.b_rtjb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjb025
            
            #add-point:AFTER FIELD b_rtjb025 name="construct.a.page1.b_rtjb025"
            
            #END add-point
            
 
 
         #----<<b_inayl003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_inayl003
            #add-point:BEFORE FIELD b_inayl003 name="construct.b.page1.b_inayl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_inayl003
            
            #add-point:AFTER FIELD b_inayl003 name="construct.a.page1.b_inayl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_inayl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inayl003
            #add-point:ON ACTION controlp INFIELD b_inayl003 name="construct.c.page1.b_inayl003"
            
            #END add-point
 
 
         #----<<b_rtjb028>>----
         #Ctrlp:construct.c.page1.b_rtjb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb028
            #add-point:ON ACTION controlp INFIELD b_rtjb028 name="construct.c.page1.b_rtjb028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb028  #顯示到畫面上
            NEXT FIELD b_rtjb028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjb028
            #add-point:BEFORE FIELD b_rtjb028 name="construct.b.page1.b_rtjb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjb028
            
            #add-point:AFTER FIELD b_rtjb028 name="construct.a.page1.b_rtjb028"
            
            #END add-point
            
 
 
         #----<<b_stfal003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stfal003
            #add-point:BEFORE FIELD b_stfal003 name="construct.b.page1.b_stfal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stfal003
            
            #add-point:AFTER FIELD b_stfal003 name="construct.a.page1.b_stfal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stfal003
            #add-point:ON ACTION controlp INFIELD b_stfal003 name="construct.c.page1.b_stfal003"
            
            #END add-point
 
 
         #----<<b_rtaw001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtaw001
            #add-point:BEFORE FIELD b_rtaw001 name="construct.b.page1.b_rtaw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtaw001
            
            #add-point:AFTER FIELD b_rtaw001 name="construct.a.page1.b_rtaw001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtaw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaw001
            #add-point:ON ACTION controlp INFIELD b_rtaw001 name="construct.c.page1.b_rtaw001"
            
            #END add-point
 
 
         #----<<b_rtaxl003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtaxl003
            #add-point:BEFORE FIELD b_rtaxl003 name="construct.b.page1.b_rtaxl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtaxl003
            
            #add-point:AFTER FIELD b_rtaxl003 name="construct.a.page1.b_rtaxl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaxl003
            #add-point:ON ACTION controlp INFIELD b_rtaxl003 name="construct.c.page1.b_rtaxl003"
            
            #END add-point
 
 
         #----<<b_rtjc002>>----
         #----<<b_rtjc013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjc013
            #add-point:BEFORE FIELD b_rtjc013 name="construct.b.page1.b_rtjc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjc013
            
            #add-point:AFTER FIELD b_rtjc013 name="construct.a.page1.b_rtjc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtjc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjc013
            #add-point:ON ACTION controlp INFIELD b_rtjc013 name="construct.c.page1.b_rtjc013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
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
   
   #end add-point
        
   LET g_error_show = 1
   CALL adeq181_b_fill()
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
 
{<section id="adeq181.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq181_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where       STRING
   DEFINE l_success     LIKE type_t.num5   
   DEFINE sum_rtjc013   LIKE rtjc_t.rtjc013
   DEFINE l_para        LIKE type_t.chr30     #160713-00020#4 160718 by lori add
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtjbsite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   LET g_wc = g_wc," AND ",l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','',rtjbsite,'',rtjb004,'',rtjb025,'',rtjb028,'','','','', 
       ''  ,DENSE_RANK() OVER( ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq) AS RANK FROM rtjb_t",
 
 
                     "",
                     " WHERE rtjbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtjb_t"),
                     " ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #160713-00020#4 160718 by lori mark---(S)
   ##明细资料
   #LET l_sql_detail = " SELECT        '",g_enterprise,"',rtjadocdt,",         #去掉unique
   #                   "               '",bdate,"','",edate,"',",           
   #                   "               rtjbsite,ooefl003,
   #                                   rtjb004,imaal003,
   #                                   rtjb025,inayl003,
   #                                   rtjb028,mhael023,
   #                                   rtaw001,rtaxl003,",
   #                   "               rtjc002,",
   #                   "               SUM(COALESCE(rtjc013,0)) rtjc013",
   #                   " FROM rtja_t,rtjc_t,rtjb_t ",
   #                   #160318-00011#1 Add By Ken 160331(S)
   #                   #" LEFT JOIN stfa_t ON rtjbent = stfaent AND rtjb028 = stfa005  ", #经营方式，有可能换成inaa_t
   #                   " LEFT JOIN rtdx_t ON rtjbent = rtdxent AND rtjbsite = rtdxsite AND rtjb004 = rtdx001 ", #經營方式取rtdx003
   #                   #160318-00011#1 Add By Ken 160331(E)
   #                   " LEFT JOIN ooefl_t ON rtjbent = ooeflent AND rtjbsite = ooefl001 AND ooefl002 = '",g_dlang,"' ",
   #                   " LEFT JOIN imaal_t ON rtjbent = imaalent AND rtjb004 = imaal001 AND imaal002 = '",g_dlang,"' ",
   #                   " LEFT JOIN inayl_t ON rtjbent = inaylent AND rtjb025 = inayl001 AND inayl002 = '",g_dlang,"' ",
   #                   #" LEFT JOIN stfal_t ON rtjbent = stfalent AND rtjb028 = stfal001 AND stfal002 = '",g_dlang,"' ",
   #                   " LEFT JOIN mhael_t ON mhaelent = rtjbent AND mhaelsite = rtjbsite AND mhael001 = rtjb028 AND mhael022 = '",g_dlang,"' ",
   #                   " LEFT JOIN imaa_t ON rtjbent = imaaent AND rtjb004 = imaa001 ",
   #                   " LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
   #                   " LEFT JOIN rtaxl_t ON rtawent = rtaxlent AND rtaw001 = rtaxl001 AND rtaxl002 = '",g_dlang,"' ",
   #                   " WHERE rtjaent = rtjbent AND rtjadocno = rtjbdocno ",
   #                   " AND rtjaent = rtjcent AND rtjadocno = rtjcdocno AND rtjbseq = rtjcseq",
   #                   " AND rtjbent= ? AND 1=1 AND ", ls_wc,
   #                   " AND rtjadocdt between to_date('",bdate,"','yy/mm/dd') AND to_date('",edate,"','yy/mm/dd')"
   #LET l_sql_detail = l_sql_detail, cl_sql_add_filter("rtjb_t"),
   #                  " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtjb004,imaal003,
   #                                       rtjb025,inayl003,rtjb028,mhael023,
   #                                       rtaw001,rtaxl003,rtjc002 "
   #160713-00020#4 160718 by lori mark---(E)
   
   #160713-00020#4 160718 by lori add---(S)
   LET l_para = cl_get_para(g_enterprise,"","E-CIR-0001")
   LET l_sql_detail = " SELECT ",g_enterprise,", ",
                      "        rtjadocdt, ",
                      "      '",bdate,"', ",
                      "      '",edate,"', ",
                      "        rtjbsite, ",  
                      "        (SELECT ooefl003 FROM ooefl_t ",
                      "          WHERE ooeflent = rtjbent AND ooefl001 = rtjbsite AND ooefl002 = '",g_dlang,"') ooefl003, ",
                      "        rtjb004, ",
                      "        (SELECT imaal003 FROM imaal_t ",
                      "          WHERE imaalent = rtjbent AND imaal001 = rtjb004 AND imaal002 = '",g_dlang,"') imaal003, ",
                      "        rtjb025, ",
                      "        (SELECT inayl003 FROM inayl_t ",
                      "          WHERE inaylent = rtjbent AND inayl001 = rtjb025 AND inayl002 = '",g_dlang,"') inayl003, ",
                      "        rtjb028, ",
                      "        (SELECT mhael023 FROM mhael_t ",
                      "          WHERE mhaelent = rtjbent AND mhaelsite = rtjbsite AND mhael001 = rtjb028 AND mhael022 = '",g_dlang,"') mhael023, ",
                      "        rtaw001, ",
                      "        (SELECT rtaxl003 FROM rtaxl_t ",
                      "          WHERE rtaxlent = rtjbent AND rtaxl001 = rtaw001 AND rtaxl002 = '",g_dlang,"') rtaxl003, ",
                      "        rtjc002, ",
                      "        SUM(COALESCE(rtjc013,0)) rtjc013 ",
                      "  FROM (SELECT rtjbent, rtjadocdt, rtjbsite, rtjb004, rtjb025, ",
                      "               rtjb028, rtjc002,   rtjc006,  rtjc013, ",
                      "               (SELECT rtaw001 FROM rtaw_t,imaa_t ",
                      "                 WHERE rtawent = imaaent AND rtaw002 = imaa009 ",
                      "                   AND imaaent = rtjbent AND imaa001 = rtjb004 AND rtaw003 = '",l_para,"') rtaw001, ",
                      "               (SELECT rtdx003 FROM rtdx_t ",
                      "                 WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001= rtjb004) rtdx003, ",
                      "               (SELECT imaa126 FROm imaa_t WHERE imaaent = rtjbent AND imaa001 = rtjb004) imaa126 ",
                      "          FROM rtja_t, rtjb_t, rtjc_t ",
                      "         WHERE rtjaent = rtjbent AND rtjadocno = rtjbdocno ",
                     #"           AND rtjaent = rtjcent AND rtjadocno = rtjcdocno AND rtjbseq = rtjcseq ",                           #160713-00020#8 160727 by lori mark
                      "           AND rtjbent = rtjcent AND rtjbdocno = rtjcdocno AND rtjbseq = rtjcseq ",                           #160713-00020#8 160727 by lori add
                      "           AND rtjaent = ? ",
                      "           AND rtjadocdt BETWEEN TO_DATE('",bdate,"','yyyy/mm/dd') AND TO_DATE('",edate,"','yyyy/mm/dd') ",   #160713-00020#8 160727 by lori add
                                  cl_sql_add_filter("rtjb_t"),") t1 ",
                      " WHERE ",ls_wc,
                     #"   AND rtjadocdt BETWEEN TO_DATE('",bdate,"','yyyy/mm/dd') AND TO_DATE('",edate,"','yyyy/mm/dd') ",           #160713-00020#8 160727 by lori mark
                      " GROUP BY rtjbent,rtjadocdt,rtjbsite,rtjb004,rtjb025,rtjb028,rtaw001,rtjc002 "
   
   #160713-00020#4 160718 by lori add---(E)
   
   #清空临时表                                      
   LET g_sql_del = "DELETE FROM adeq181_tmp "
   EXECUTE IMMEDIATE g_sql_del
   
   #插表
   LET g_sql_ins = " INSERT INTO adeq181_tmp (enterprise,  rtjadocdt,  l_bdate,  l_edate,  
                                              rtjbsite,    ooefl003,   rtjb004,   imaal003, 
                                              rtjb025,     inayl003,   rtjb028,   stfal003, 
                                              rtaw001,     rtaxl003,   rtjc002,   rtjc013)",l_sql_detail
   PREPARE ins_tmp FROM g_sql_ins
   EXECUTE ins_tmp USING g_enterprise
   
   IF l_sumby = 'N' THEN
      CALL cl_set_comp_visible("b_rtjadocdt",TRUE)   
      CALL cl_set_comp_visible("l_bdate",FALSE)
      CALL cl_set_comp_visible("l_edate",FALSE)
     #160713-00020#8 160727 by lori mark and add---(S)
     #LET ls_sql_rank = " SELECT  rtjadocdt,  '','',
     #                            rtjbsite,   ooefl003,   rtjb004,   imaal003,  
     #                            rtjb025,    inayl003,   rtjb028,    stfal003,  
     #                            rtaw001,    rtaxl003, ",
     #                  "         rtjc002,    SUM(rtjc013) A, ",
     #                  "         DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK ",
     #                  " FROM adeq181_tmp WHERE enterprise = ? ",
     #                  " GROUP BY  rtjadocdt,            
     #                              rtjbsite,    ooefl003,
     #                              rtjb004,     imaal003, 
     #                              rtjb025,     inayl003, 
     #                              rtjb028,     stfal003,  
     #                              rtaw001,     rtaxl003,
     #                              RTJC002               ",
     #                  " ORDER BY rtjadocdt,rtjb004 "
      LET ls_sql_rank = " SELECT  rtjadocdt,  '','',
                                  rtjbsite,   ooefl003,   rtjb004,   imaal003,  
                                  rtjb025,    inayl003,   rtjb028,    stfal003,  
                                  rtaw001,    rtaxl003, ",
                        "         rtjc002,    A, ",
                        "         DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK ",
                        "    FROM (SELECT  rtjadocdt,  
                                           rtjbsite,   ooefl003,   rtjb004,   imaal003,  
                                           rtjb025,    inayl003,   rtjb028,    stfal003,  
                                           rtaw001,    rtaxl003, ",
                        "                  rtjc002,    SUM(rtjc013) A ",
                        "          FROM adeq181_tmp WHERE enterprise = ? ",
                        "          GROUP BY  rtjadocdt,            
                                             rtjbsite,    ooefl003,
                                             rtjb004,     imaal003, 
                                             rtjb025,     inayl003, 
                                             rtjb028,     stfal003,  
                                             rtaw001,     rtaxl003,
                                             RTJC002)              ",
                        " ORDER BY rtjadocdt,rtjb004 "   
      #160713-00020#8 160727 by lori mark and add---(E)                        
   ELSE 
      CALL cl_set_comp_visible("b_rtjadocdt",FALSE)   
      CALL cl_set_comp_visible("l_bdate",TRUE)
      CALL cl_set_comp_visible("l_edate",TRUE)  
     #160713-00020#8 160727 by lori mark and add---(S) 
     #LET ls_sql_rank = " SELECT  '' ,        l_bdate,    l_edate,   
     #                            rtjbsite,   ooefl003,   rtjb004,   imaal003,  
     #                            rtjb025,    inayl003,   rtjb028,    stfal003,  
     #                            rtaw001,    rtaxl003, ",
     #                  "         rtjc002,    SUM(rtjc013) A, ",
     #                  "         DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK ",
     #                  " FROM adeq181_tmp WHERE enterprise = ? ",
     #                  " GROUP BY  l_bdate,     l_edate,
     #                              rtjbsite,    ooefl003,
     #                              rtjb004,     imaal003, 
     #                              rtjb025,     inayl003, 
     #                              rtjb028,     stfal003,  
     #                              rtaw001,     rtaxl003,
     #                              RTJC002               ",
     #                  " ORDER BY rtjb004 "
      LET ls_sql_rank = " SELECT  '' ,        l_bdate,    l_edate,   
                                  rtjbsite,   ooefl003,   rtjb004,   imaal003,  
                                  rtjb025,    inayl003,   rtjb028,    stfal003,  
                                  rtaw001,    rtaxl003, ",
                        "         rtjc002,    A, ",
                        "         DENSE_RANK() OVER( ORDER BY rtjb004) AS RANK ",
                        "   FROM (SELECT  l_bdate,    l_edate,   
                                          rtjbsite,   ooefl003,   rtjb004,   imaal003,  
                                          rtjb025,    inayl003,   rtjb028,    stfal003,  
                                          rtaw001,    rtaxl003, ",
                        "                 rtjc002,    SUM(rtjc013) A ",
                        "         FROM adeq181_tmp WHERE enterprise = ? ",
                        "         GROUP BY  l_bdate,     l_edate,
                                            rtjbsite,    ooefl003,
                                            rtjb004,     imaal003, 
                                            rtjb025,     inayl003, 
                                            rtjb028,     stfal003,  
                                            rtaw001,     rtaxl003,
                                            RTJC002)              ",
                        " ORDER BY rtjb004 "                        
     #160713-00020#8 160727 by lori mark and add---(E)                   
   END IF
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
 
   LET g_sql = "SELECT '','','',rtjbsite,'',rtjb004,'',rtjb025,'',rtjb028,'','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF l_sumby = 'N' THEN
      LET g_sql = " SELECT  rtjadocdt,  '','',
                            rtjbsite,   ooefl003,   rtjb004,   imaal003,  
                            rtjb025,    inayl003,   rtjb028,    stfal003,  
                            rtaw001,    rtaxl003, ",
                  "         rtjc002,    A ",
                  "   FROM (",ls_sql_rank,")",
                  "  WHERE RANK >= ",g_pagestart,
                  "    AND RANK < ",g_pagestart + g_num_in_page
   ELSE 
      LET g_sql = " SELECT  '' ,        l_bdate,    l_edate,   
                            rtjbsite,   ooefl003,   rtjb004,   imaal003,  
                            rtjb025,    inayl003,   rtjb028,    stfal003,  
                            rtaw001,    rtaxl003, ",
                  "         rtjc002,    A ",
                  "   FROM (",ls_sql_rank,")",
                  "  WHERE RANK >= ",g_pagestart,
                  "    AND RANK < ",g_pagestart + g_num_in_page
   END IF 
  #DISPLAY 'g_sql----',g_sql
   
   #第一页签 汇总
   LET g_sum_sql = " SELECT SUM(A) ",
                   " FROM (",ls_sql_rank,")"
   PREPARE SUM_PRE FROM g_sum_sql
   EXECUTE SUM_PRE USING g_enterprise INTO sum_rtjc013
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq181_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq181_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtjb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_rtjb_d[l_ac].rtjadocdt,g_rtjb_d[l_ac].l_bdate,g_rtjb_d[l_ac].l_edate,g_rtjb_d[l_ac].rtjbsite, 
       g_rtjb_d[l_ac].ooefl003,g_rtjb_d[l_ac].rtjb004,g_rtjb_d[l_ac].imaal003,g_rtjb_d[l_ac].rtjb025, 
       g_rtjb_d[l_ac].inayl003,g_rtjb_d[l_ac].rtjb028,g_rtjb_d[l_ac].stfal003,g_rtjb_d[l_ac].rtaw001, 
       g_rtjb_d[l_ac].rtaxl003,g_rtjb_d[l_ac].rtjc002,g_rtjb_d[l_ac].rtjc013
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_rtjb_d[l_ac].statepic = cl_get_actipic(g_rtjb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
   DISPLAY sum_rtjc013 TO sum_rtjc013  
        
      #end add-point
 
      CALL adeq181_detail_show("'1'")      
 
      CALL adeq181_rtjb_t_mask()
 
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
   
 
   
   CALL g_rtjb_d.deleteElement(g_rtjb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL adeq181_b_fill1()
   CALL adeq181_b_fill2()
   CALL adeq181_b_fill3()
   CALL adeq181_b_fill4()   
   #end add-point
 
   LET g_detail_cnt = g_rtjb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq181_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq181_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq181_detail_action_trans()
 
   IF g_rtjb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq181_fetch()
   END IF
   
      CALL adeq181_filter_show('rtjadocdt','b_rtjadocdt')
   CALL adeq181_filter_show('rtjbsite','b_rtjbsite')
   CALL adeq181_filter_show('ooefl003','b_ooefl003')
   CALL adeq181_filter_show('rtjb004','b_rtjb004')
   CALL adeq181_filter_show('imaal003','b_imaal003')
   CALL adeq181_filter_show('rtjb025','b_rtjb025')
   CALL adeq181_filter_show('inayl003','b_inayl003')
   CALL adeq181_filter_show('rtjb028','b_rtjb028')
   CALL adeq181_filter_show('stfal003','b_stfal003')
   CALL adeq181_filter_show('rtaw001','b_rtaw001')
   CALL adeq181_filter_show('rtaxl003','b_rtaxl003')
   CALL adeq181_filter_show('rtjc013','b_rtjc013')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq181.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq181_fetch()
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
 
{<section id="adeq181.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq181_detail_show(ps_page)
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
 
{<section id="adeq181.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq181_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
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
      CONSTRUCT g_wc_filter ON rtjadocdt,rtjbsite,ooefl003,rtjb004,imaal003,rtjb025,inayl003,rtjb028, 
          stfal003,rtaw001,rtaxl003,rtjc013
                          FROM s_detail1[1].b_rtjadocdt,s_detail1[1].b_rtjbsite,s_detail1[1].b_ooefl003, 
                              s_detail1[1].b_rtjb004,s_detail1[1].b_imaal003,s_detail1[1].b_rtjb025, 
                              s_detail1[1].b_inayl003,s_detail1[1].b_rtjb028,s_detail1[1].b_stfal003, 
                              s_detail1[1].b_rtaw001,s_detail1[1].b_rtaxl003,s_detail1[1].b_rtjc013
 
         BEFORE CONSTRUCT
                     DISPLAY adeq181_filter_parser('rtjadocdt') TO s_detail1[1].b_rtjadocdt
            DISPLAY adeq181_filter_parser('rtjbsite') TO s_detail1[1].b_rtjbsite
            DISPLAY adeq181_filter_parser('ooefl003') TO s_detail1[1].b_ooefl003
            DISPLAY adeq181_filter_parser('rtjb004') TO s_detail1[1].b_rtjb004
            DISPLAY adeq181_filter_parser('imaal003') TO s_detail1[1].b_imaal003
            DISPLAY adeq181_filter_parser('rtjb025') TO s_detail1[1].b_rtjb025
            DISPLAY adeq181_filter_parser('inayl003') TO s_detail1[1].b_inayl003
            DISPLAY adeq181_filter_parser('rtjb028') TO s_detail1[1].b_rtjb028
            DISPLAY adeq181_filter_parser('stfal003') TO s_detail1[1].b_stfal003
            DISPLAY adeq181_filter_parser('rtaw001') TO s_detail1[1].b_rtaw001
            DISPLAY adeq181_filter_parser('rtaxl003') TO s_detail1[1].b_rtaxl003
            DISPLAY adeq181_filter_parser('rtjc013') TO s_detail1[1].b_rtjc013
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_rtjadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocdt
            #add-point:ON ACTION controlp INFIELD b_rtjadocdt name="construct.c.filter.page1.b_rtjadocdt"
            
            #END add-point
 
 
         #----<<l_bdate>>----
         #----<<l_edate>>----
         #----<<b_rtjbsite>>----
         #Ctrlp:construct.c.page1.b_rtjbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbsite
            #add-point:ON ACTION controlp INFIELD b_rtjbsite name="construct.c.filter.page1.b_rtjbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjbsite  #顯示到畫面上
            NEXT FIELD b_rtjbsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_ooefl003>>----
         #Ctrlp:construct.c.filter.page1.b_ooefl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ooefl003
            #add-point:ON ACTION controlp INFIELD b_ooefl003 name="construct.c.filter.page1.b_ooefl003"
            
            #END add-point
 
 
         #----<<b_rtjb004>>----
         #Ctrlp:construct.c.page1.b_rtjb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb004
            #add-point:ON ACTION controlp INFIELD b_rtjb004 name="construct.c.filter.page1.b_rtjb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb004  #顯示到畫面上
            NEXT FIELD b_rtjb004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaal003>>----
         #Ctrlp:construct.c.filter.page1.b_imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaal003
            #add-point:ON ACTION controlp INFIELD b_imaal003 name="construct.c.filter.page1.b_imaal003"
            
            #END add-point
 
 
         #----<<b_rtjb025>>----
         #Ctrlp:construct.c.page1.b_rtjb025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb025
            #add-point:ON ACTION controlp INFIELD b_rtjb025 name="construct.c.filter.page1.b_rtjb025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb025  #顯示到畫面上
            NEXT FIELD b_rtjb025                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_inayl003>>----
         #Ctrlp:construct.c.filter.page1.b_inayl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inayl003
            #add-point:ON ACTION controlp INFIELD b_inayl003 name="construct.c.filter.page1.b_inayl003"
            
            #END add-point
 
 
         #----<<b_rtjb028>>----
         #Ctrlp:construct.c.page1.b_rtjb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb028
            #add-point:ON ACTION controlp INFIELD b_rtjb028 name="construct.c.filter.page1.b_rtjb028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb028  #顯示到畫面上
            NEXT FIELD b_rtjb028                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stfal003>>----
         #Ctrlp:construct.c.filter.page1.b_stfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stfal003
            #add-point:ON ACTION controlp INFIELD b_stfal003 name="construct.c.filter.page1.b_stfal003"
            
            #END add-point
 
 
         #----<<b_rtaw001>>----
         #Ctrlp:construct.c.filter.page1.b_rtaw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaw001
            #add-point:ON ACTION controlp INFIELD b_rtaw001 name="construct.c.filter.page1.b_rtaw001"
            
            #END add-point
 
 
         #----<<b_rtaxl003>>----
         #Ctrlp:construct.c.filter.page1.b_rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaxl003
            #add-point:ON ACTION controlp INFIELD b_rtaxl003 name="construct.c.filter.page1.b_rtaxl003"
            
            #END add-point
 
 
         #----<<b_rtjc002>>----
         #----<<b_rtjc013>>----
         #Ctrlp:construct.c.filter.page1.b_rtjc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjc013
            #add-point:ON ACTION controlp INFIELD b_rtjc013 name="construct.c.filter.page1.b_rtjc013"
            
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL adeq181_filter_show('rtjadocdt','b_rtjadocdt')
   CALL adeq181_filter_show('rtjbsite','b_rtjbsite')
   CALL adeq181_filter_show('ooefl003','b_ooefl003')
   CALL adeq181_filter_show('rtjb004','b_rtjb004')
   CALL adeq181_filter_show('imaal003','b_imaal003')
   CALL adeq181_filter_show('rtjb025','b_rtjb025')
   CALL adeq181_filter_show('inayl003','b_inayl003')
   CALL adeq181_filter_show('rtjb028','b_rtjb028')
   CALL adeq181_filter_show('stfal003','b_stfal003')
   CALL adeq181_filter_show('rtaw001','b_rtaw001')
   CALL adeq181_filter_show('rtaxl003','b_rtaxl003')
   CALL adeq181_filter_show('rtjc013','b_rtjc013')
 
    
   CALL adeq181_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq181.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq181_filter_parser(ps_field)
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
 
{<section id="adeq181.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq181_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq181_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq181.insert" >}
#+ insert
PRIVATE FUNCTION adeq181_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq181.modify" >}
#+ modify
PRIVATE FUNCTION adeq181_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq181.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq181_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq181.delete" >}
#+ delete
PRIVATE FUNCTION adeq181_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq181.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq181_detail_action_trans()
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
 
{<section id="adeq181.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq181_detail_index_setting()
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
            IF g_rtjb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtjb_d.getLength() AND g_rtjb_d.getLength() > 0
            LET g_detail_idx = g_rtjb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtjb_d.getLength() THEN
               LET g_detail_idx = g_rtjb_d.getLength()
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
 
{<section id="adeq181.mask_functions" >}
 &include "erp/ade/adeq181_mask.4gl"
 
{</section>}
 
{<section id="adeq181.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查询条件录入
# Date & Author..: 2015-09-16 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq181_query2()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準

   #end add-point 
   #add-point:query段define-客製

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_rtjb_d.clear()
   
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
      CONSTRUCT g_wc_table 
             ON rtjbsite,rtjb028,rtjb025,rtjb003,rtaw001,rtdx003,imaa126,rtjc006,rtjc002  #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
           FROM rtjbsite,rtjb028,rtjb025,rtjb003,rtaw001,rtdx003,imaa126,rtjc006,rtjc002  #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
         
            #end add-point 

         ON ACTION controlp INFIELD rtjbsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjbsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjbsite  #顯示到畫面上
            NEXT FIELD rtjbsite                     #返回原欄位
    
         ON ACTION controlp INFIELD rtjb003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb003  #顯示到畫面上
            NEXT FIELD rtjb003                     #返回原欄位
    
         ON ACTION controlp INFIELD rtjb025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb025  #顯示到畫面上
            NEXT FIELD rtjb025                     #返回原欄位
  
         ON ACTION controlp INFIELD rtjb028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtjb028  #顯示到畫面上
            NEXT FIELD rtjb028                     #返回原欄位
       
         ON ACTION controlp INFIELD rtaw001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
            CALL q_rtax001()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上
            NEXT FIELD rtaw001                     #返回原欄位

         ON ACTION controlp INFIELD imaa126   #160318-00011#1 Modify By Ken 160331 stfa012改為imaa126
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
#            IF g_argv[1] = 2 THEN
#               LET g_qryparam.where = " oocq022 = '2'"
#            END IF
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上  #160318-00011#1 Modify By Ken 160331 stfa012改為imaa126
            NEXT FIELD imaa126                     #返回原欄位    #160318-00011#1 Modify By Ken 160331 stfa012改為imaa126

         AFTER FIELD rtjb028 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjb028
         AFTER FIELD rtjb025 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjb025
         AFTER FIELD rtjb003 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjb003
         AFTER FIELD rtaw001 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtaw001
         #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
         #AFTER FIELD stfa003 CALL FGL_DIALOG_GETBUFFER() RETURNING l_stfa003
         #AFTER FIELD stfa012 CALL FGL_DIALOG_GETBUFFER() RETURNING l_stfa012
         AFTER FIELD rtdx003 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtdx003
         AFTER FIELD imaa126 CALL FGL_DIALOG_GETBUFFER() RETURNING l_imaa126         
         #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
         AFTER FIELD rtjc002 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjc002 
         AFTER FIELD rtjc006 CALL FGL_DIALOG_GETBUFFER() RETURNING l_rtjc006
                                                                   
      END CONSTRUCT
      
      #add-point:query段more_construct

      #end add-point 
      
      INPUT bdate,edate,l_sumby FROM bdate,edate,l_sumby
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT 
            DISPLAY BY NAME bdate,edate 
            IF cl_null(bdate) THEN 
              LET bdate = g_today
            END IF
            IF cl_null(edate) THEN            
              LET edate = g_today
            END IF 
     
         AFTER FIELD bdate
             IF NOT cl_null(bdate) THEN
                      IF bdate > edate THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "" 
                         LET g_errparam.code   = 'amr-00072' # 起始时间不可大于截止时间
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         NEXT FIELD bdate
                      END IF
                   END IF
          AFTER FIELD edate
             IF NOT cl_null(edate) THEN
                IF edate < bdate THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   = 'amm-00094' # 结束时间必须大于等于开始时间
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   NEXT FIELD edate
                   END IF
             END IF
         
         AFTER INPUT
            IF INT_FLAG THEN
#            	LET INT_FLAG=0
#               EXIT INPUT
            END IF
      END INPUT       
      
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         return
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前
      BEFORE DIALOG    
         LET l_rtjbsite = g_site
         DISPLAY l_rtjbsite TO rtjbsite
        
         DISPLAY l_rtjb028,
                 l_rtjb025,
                 l_rtjb003,
                 l_rtaw001,
                 #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
                 #l_stfa003,  
                 #l_stfa012,
                 l_rtdx003,
                 l_imaa126,
                 #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
                 l_rtjc002,
                 l_rtjc006
              TO rtjb028,
                 rtjb025,
                 rtjb003,
                 rtaw001,
                 #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
                 #stfa003,
                 #stfa012,
                 rtdx003,
                 imaa126,
                 #160318-00011#1 Modify By Ken 160331 原stfa003改為rtdx003 ,stfa012改為imaa126
                 rtjc002,
                 rtjc006
                 
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET g_wc2 = ls_wc2
      LET g_wc_filter = g_wc_filter_t
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL adeq181_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Date & Author..: 2015-09-16 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq181_create_tmp()
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_session_id       LIKE type_t.num20
   
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "SessionId: ",l_session_id
   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adeq181_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE TEMP TABLE adeq181_tmp(
   enterprise  VARCHAR(500), 
   rtjadocdt   DATE,
   l_bdate     VARCHAR(500), 
   l_edate     VARCHAR(500), 
   rtjbsite    VARCHAR(10), 
   ooefl003    VARCHAR(500), 
   rtjb004     VARCHAR(40), 
   imaal003    VARCHAR(255), 
   rtjb025     VARCHAR(10), 
   inayl003    VARCHAR(500), 
   rtjb028     VARCHAR(20), 
   stfal003    VARCHAR(500), 
   rtaw001     VARCHAR(10), 
   rtaxl003    VARCHAR(500), 
   rtjc002     VARCHAR(10), 
   rtjc013     DECIMAL(20,6)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adeq181_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 删除临时表
# Date & Author..: 2015-09-16 by LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq181_drop_tmp()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adeq181_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq181_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 第二页签（按库区汇总）
# Date & Author..: 2015-09-16 by LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq181_b_fill1()
DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d1.clear()
    
   IF l_sumby = 'N' THEN
      CALL cl_set_comp_visible("b_rtjadocdt_1",TRUE)  
      CALL cl_set_comp_visible("l_bdate1",FALSE)
      CALL cl_set_comp_visible("l_edate1",FALSE)      
      LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003,
                                   rtjb025,inayl003,
                                   rtjb028,stfal003,
                                   rtaw001,rtaxl003,",
                   "               rtjc002, ",
                   "               SUM(rtjc013) ",
                   " FROM adeq181_tmp ",
                   " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtjb025,inayl003,rtjb028,stfal003,rtaw001,rtaxl003,rtjc002 ",
                   " ORDER BY rtjadocdt,rtjb025  "
   ELSE 
      CALL cl_set_comp_visible("b_rtjadocdt_1",FALSE) 
      CALL cl_set_comp_visible("l_bdate1",TRUE)
      CALL cl_set_comp_visible("l_edate1",TRUE)        
      LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003,
                                   rtjb025,inayl003,
                                   rtjb028,stfal003,
                                   rtaw001,rtaxl003,",
                   "               rtjc002, ",
                   "               SUM(rtjc013) ",
                   " FROM adeq181_tmp ",
                   " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003,rtjb025,inayl003,rtjb028,stfal003,rtaw001,rtaxl003,rtjc002 ",
                   " ORDER BY rtjb025  "
   END IF

   PREPARE sel_rtjb1_pre1 FROM l_sql1
   DECLARE sel_rtjb1_cs1  CURSOR FOR sel_rtjb1_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs1 # USING g_enterprise 
                       INTO g_rtjb_d1[l_ac].rtjadocdt,
                            g_rtjb_d1[l_ac].l_bdate1,
                            g_rtjb_d1[l_ac].l_edate1,
                            g_rtjb_d1[l_ac].rtjbsite,
                            g_rtjb_d1[l_ac].l_ooefl003_1,
                            g_rtjb_d1[l_ac].rtjb025,     
                            g_rtjb_d1[l_ac].inayl003,    
                            g_rtjb_d1[l_ac].rtjb028,     
                            g_rtjb_d1[l_ac].stfal003,    
                            g_rtjb_d1[l_ac].rtaw001,     
                            g_rtjb_d1[l_ac].rtaxl003,    
                            g_rtjb_d1[l_ac].rtjc002, 
                            g_rtjb_d1[l_ac].rtjc013 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d1.deleteElement(g_rtjb_d1.getLength())
   
   DISPLAY ARRAY g_rtjb_d1 TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs1
   
END FUNCTION

################################################################################
# Descriptions...: 第三个页签（按专柜汇总）
# Date & Author..: 2015-09-16 By LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq181_b_fill2()
DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d2.clear()
 
   IF l_sumby = 'N' THEN
      CALL cl_set_comp_visible("b_rtjadocdt_2",TRUE)   
      CALL cl_set_comp_visible("l_bdate2",FALSE)
      CALL cl_set_comp_visible("l_edate2",FALSE)   
      LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003, 
                                   rtjb028,stfal003,
                                   rtaw001,rtaxl003,",
                   "               rtjc002, ",
                   "               SUM(rtjc013) ",
                   " FROM adeq181_tmp ",
                   " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtjb028,stfal003,rtaw001,rtaxl003,rtjc002 ",
                   " ORDER BY rtjadocdt,rtjb028 "
   ELSE 
      CALL cl_set_comp_visible("b_rtjadocdt_2",FALSE)   
      CALL cl_set_comp_visible("l_bdate2",TRUE)
      CALL cl_set_comp_visible("l_edate2",TRUE)
      LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003, 
                                   rtjb028,stfal003,
                                   rtaw001,rtaxl003,",
                   "               rtjc002, ",
                   "               SUM(rtjc013) ",
                   " FROM adeq181_tmp ",
                   " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003,rtjb028,stfal003,rtaw001,rtaxl003,rtjc002 ",
                   " ORDER BY rtjb028 "
   END IF
 
   PREPARE sel_rtjb1_pre2 FROM l_sql1
   DECLARE sel_rtjb1_cs2  CURSOR FOR sel_rtjb1_pre2   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs2 # USING g_enterprise 
                       INTO g_rtjb_d2[l_ac].rtjadocdt,
                            g_rtjb_d2[l_ac].l_bdate2,
                            g_rtjb_d2[l_ac].l_edate2,
                            g_rtjb_d2[l_ac].rtjbsite, 
                            g_rtjb_d2[l_ac].l_ooefl003_2,                            
                            g_rtjb_d2[l_ac].rtjb028,     
                            g_rtjb_d2[l_ac].stfal003,    
                            g_rtjb_d2[l_ac].rtaw001,     
                            g_rtjb_d2[l_ac].rtaxl003,    
                            g_rtjb_d2[l_ac].rtjc002,
                            g_rtjb_d2[l_ac].rtjc013 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d2.deleteElement(g_rtjb_d2.getLength())
   
   DISPLAY ARRAY g_rtjb_d2 TO s_detail3.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs2
   
END FUNCTION

################################################################################
# Descriptions...: 第四个页签（按管理品类汇总）
# Date & Author..: 2015-09-16 BY LanJJ
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq181_b_fill3()
DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d3.clear()
   
   IF l_sumby = 'N' THEN
      CALL cl_set_comp_visible("b_rtjadocdt_3",TRUE) 
      CALL cl_set_comp_visible("l_bdate3",FALSE)
      CALL cl_set_comp_visible("l_edate3",FALSE)        
      LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003,
                                   rtaw001,rtaxl003,",
                   "               rtjc002, ",
                   "               SUM(rtjc013) ",
                   " FROM adeq181_tmp ",
                   " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtaw001,rtaxl003,rtjc002 ",
                   " ORDER BY rtjadocdt,rtaw001 "
   ELSE 
      CALL cl_set_comp_visible("b_rtjadocdt_3",FALSE)
      CALL cl_set_comp_visible("l_bdate3",TRUE)
      CALL cl_set_comp_visible("l_edate3",TRUE)      
      LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003,
                                   rtaw001,rtaxl003,",
                   "               rtjc002, ",
                   "               SUM(rtjc013) ",
                   " FROM adeq181_tmp ",
                   " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003,rtaw001,rtaxl003,rtjc002 ",
                   " ORDER BY rtaw001 "
   END IF
   
   
   PREPARE sel_rtjb1_pre3 FROM l_sql1
   DECLARE sel_rtjb1_cs3  CURSOR FOR sel_rtjb1_pre3   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs3 # USING g_enterprise 
                       INTO g_rtjb_d3[l_ac].rtjadocdt,
                            g_rtjb_d3[l_ac].l_bdate3,
                            g_rtjb_d3[l_ac].l_edate3,
                            g_rtjb_d3[l_ac].rtjbsite, 
                            g_rtjb_d3[l_ac].l_ooefl003_3,                            
                            g_rtjb_d3[l_ac].rtaw001,     
                            g_rtjb_d3[l_ac].rtaxl003,    
                            g_rtjb_d3[l_ac].rtjc002,
                            g_rtjb_d3[l_ac].rtjc013 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d3.deleteElement(g_rtjb_d3.getLength())
   
   DISPLAY ARRAY g_rtjb_d3 TO s_detail4.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs3
   
END FUNCTION

################################################################################
# Descriptions...: 第五个页签（按门店汇总）
# Date & Author..: 2015-09-16  By lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq181_b_fill4()
DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_rtjb_d4.clear()
   
   IF l_sumby = 'N' THEN
      CALL cl_set_comp_visible("b_rtjadocdt_4",TRUE)   
      CALL cl_set_comp_visible("l_bdate4",FALSE)
      CALL cl_set_comp_visible("l_edate4",FALSE)      
         LET l_sql1 = " SELECT UNIQUE rtjadocdt,'','',rtjbsite,ooefl003,",
                      "               rtjc002, ",
                      "               SUM(rtjc013) ",
                      " FROM adeq181_tmp ",
                      " GROUP BY rtjadocdt,rtjbsite,ooefl003,rtjc002 ",
                      " ORDER BY rtjadocdt,rtjbsite "
   ELSE 
      CALL cl_set_comp_visible("b_rtjadocdt_4",FALSE)  
      CALL cl_set_comp_visible("l_bdate4",TRUE)
      CALL cl_set_comp_visible("l_edate4",TRUE)      
         LET l_sql1 = " SELECT UNIQUE '',l_bdate,l_edate,rtjbsite,ooefl003,",
                      "               rtjc002, ",
                      "               SUM(rtjc013) ",
                      " FROM adeq181_tmp ",
                      " GROUP BY l_bdate,l_edate,rtjbsite,ooefl003,rtjc002 ",
                      " ORDER BY rtjbsite "
   END IF

   PREPARE sel_rtjb1_pre4 FROM l_sql1
   DECLARE sel_rtjb1_cs4  CURSOR FOR sel_rtjb1_pre4   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_rtjb1_cs4 # USING g_enterprise 
                       INTO g_rtjb_d4[l_ac].rtjadocdt,
                            g_rtjb_d4[l_ac].l_bdate4,
                            g_rtjb_d4[l_ac].l_edate4,
                            g_rtjb_d4[l_ac].rtjbsite, 
                            g_rtjb_d4[l_ac].l_ooefl003_4,                            
                            g_rtjb_d4[l_ac].rtjc002,
                            g_rtjb_d4[l_ac].rtjc013 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_rtjb_d4.deleteElement(g_rtjb_d4.getLength())
   
   DISPLAY ARRAY g_rtjb_d4 TO s_detail5.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   FREE sel_rtjb1_cs4
END FUNCTION

 
{</section>}
 
