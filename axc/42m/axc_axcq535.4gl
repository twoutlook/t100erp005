#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq535.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-04-06 10:23:49), PR版次:0006(2016-11-18 11:23:13)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: axcq535
#+ Description: 採購入庫金額彙總查詢表
#+ Creator....: 02040(2016-04-06 10:23:49)
#+ Modifier...: 02040 -SD/PR- 08993
 
{</section>}
 
{<section id="axcq535.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160503-00007#1  160503 By 02040     QBE條件增加採購入庫、委外入庫搜尋
#160713-00008#1  160713 By 02040     列印報表時，說明欄位取消(代號)+說明，只留說明即可
#160802-00020#4  160804 By dorislai  增加帳套權限管控
#160802-00020#10 160811 By dorislai  增加法人權限管控
#160727-00019#21  2016/08/12  By 08742       系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                            Mod   axcq535_xcck_tmp --> axcq535_tmp01   ,   axcq535_x01_temp --> axcq535_temp02
#161019-00017#5  2016/10/21 By lixiang  调整组织栏位的开窗
#161109-00085#25   2016/11/17  By 08993      整批調整系統星號寫法
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
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d RECORD
       
       sel LIKE type_t.chr1, 
   xccksite LIKE xcck_t.xccksite, 
   xccksite_desc LIKE type_t.chr500, 
   xcck022 LIKE xcck_t.xcck022, 
   xcck022_desc LIKE type_t.chr500, 
   l_xcck202_1 LIKE type_t.num20_6, 
   l_xcck202_2 LIKE type_t.num20_6, 
   l_xcck202_3 LIKE type_t.num20_6, 
   l_xcck202_4 LIKE type_t.num20_6, 
   l_xcck202_5 LIKE type_t.num20_6, 
   l_xcck202_6 LIKE type_t.num20_6, 
   l_xcck202_7 LIKE type_t.num20_6, 
   l_xcck202_8 LIKE type_t.num20_6, 
   l_xcck202_9 LIKE type_t.num20_6, 
   l_xcck202_10 LIKE type_t.num20_6, 
   l_xcck202_11 LIKE type_t.num20_6, 
   l_xcck202_12 LIKE type_t.num20_6, 
   l_xcck202_13 LIKE type_t.num20_6, 
   l_xcck202_sum LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_master RECORD
            xcckcomp LIKE xcck_t.xcckcomp,
            xcckcomp_desc LIKE ooefl_t.ooefl003,
            xcckld  LIKE xcck_t.xcckld,
            xcckld_desc   LIKE glaal_t.glaal003,                   
            xcck003 LIKE xcck_t.xcck003,
            xcck003_desc  LIKE xcatl_t.xcatl003,
            xcck009 LIKE type_t.chr1,
            xcck004 LIKE xcck_t.xcck004,
            xcck005 LIKE xcck_t.xcck005,
            xcck004_1 LIKE xcck_t.xcck004,
            xcck005_1 LIKE xcck_t.xcck005,                   
            xcck001 LIKE xcck_t.xcck001,
            pmaa047 LIKE pmaa_t.pmaa047
                   END RECORD
DEFINE g_master      type_g_master
DEFINE g_master_t    type_g_master   
DEFINE g_glaa003     LIKE glaa_t.glaa003
DEFINE g_no          LIKE type_t.num5
DEFINE g_xcck055     LIKE type_t.num5   #160503-00007#1--add
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xcck_d            DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t          type_g_xcck_d
 
 
 
 
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
 
{<section id="axcq535.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
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
   DECLARE axcq535_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq535_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq535_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq535 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq535_init()   
 
      #進入選單 Menu (="N")
      CALL axcq535_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq535
      
   END IF 
   
   CLOSE axcq535_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq535.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq535_init()
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
   CALL cl_set_combo_scc('pmaa047','4042')
   CALL cl_set_combo_scc('xcck001','8914')
   
   #建立TEMPTABLE
   CALL axcq535_create_temp()
   #end add-point
 
   CALL axcq535_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq535.default_search" >}
PRIVATE FUNCTION axcq535_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xcck002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xcck003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xcck004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xcck005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xcck006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xcck007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xcck008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " xcck009 = '", g_argv[10], "' AND "
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
 
{<section id="axcq535.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq535_ui_dialog() 
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
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_errno            LIKE gzze_t.gzze001
   DEFINE l_flag             LIKE type_t.chr1
   DEFINE l_y                LIKE xcck_t.xcck004
   DEFINE l_m                LIKE xcck_t.xcck005
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
 
   
   CALL axcq535_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xcck_d.clear()
 
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
 
         CALL axcq535_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_master.xcckcomp,g_master.xcckld,g_master.xcck003,g_master.xcck009,g_master.xcck004,g_master.xcck005,g_master.xcck004_1,g_master.xcck005_1,g_master.xcck001,g_master.pmaa047,g_xcck055  #160503-00007#1 add xcck055
          FROM xcckcomp,xcckld,xcck003,xcck009,xcck004,xcck005,xcck004_1,xcck005_1,xcck001,pmaa047,l_xcck055                                                                                            #160503-00007#1 add xcck055
         
            BEFORE INPUT
         
            AFTER FIELD xcckcomp
               IF NOT cl_null(g_master.xcckcomp) AND
                 (g_master.xcckcomp <> g_master_t.xcckcomp OR cl_null(g_master_t.xcckcomp)) THEN         
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcckcomp         
                  IF  NOT cl_chk_exist("v_ooef001_1") THEN
                      LET g_master.xcckcomp = g_master_t.xcckcomp
                      CALL axcq535_xcckcomp_desc()
                      NEXT FIELD CURRENT  
                  END IF
                  CALL axcq535_xcckcomp_desc()
                  LET g_master_t.xcckcomp = g_master.xcckcomp               
               END IF
               
            AFTER FIELD xcckld
               IF NOT cl_null(g_master.xcckld) AND
                 (g_master.xcckld <> g_master_t.xcckld OR cl_null(g_master_t.xcckld)) THEN
                  CALL s_fin_ld_chk(g_master.xcckld,g_user,'N')
                    RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = l_errno
                     LET g_errparam.extend = g_master.xcckld
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_master.xcckld = g_master_t.xcckld
                     CALL axcq535_xcckld_desc()
                     NEXT FIELD CURRENT                
                  END IF
                  IF g_master.xcckld <> g_master_t.xcckld THEN
                     SELECT glaa120,glaa003
                       INTO g_master.xcck003
                       FROM glaa_t
                      WHERE glaaent  = g_enterprise
                        AND glaacomp = g_master.xcckcomp
                        AND glaa014 = 'Y'                            
                  END IF                               
                  CALL axcq535_xcckld_desc()
                  LET g_master_t.xcckld = g_master.xcckld                
               END IF   
            
            AFTER FIELD xcck003
               IF NOT cl_null(g_master.xcck003) AND
                 (g_master_t.xcck003 <> g_master.xcck003 OR cl_null(g_master_t.xcck003)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcck003        
                  IF  NOT cl_chk_exist("v_xcat001") THEN
                      LET g_master.xcck003 = g_master_t.xcck003
                      CALL axcq535_xcck003_desc()
                      NEXT FIELD CURRENT  
                  END IF
                  CALL axcq535_xcck003_desc() 
                  LET g_master_t.xcck003 = g_master.xcck003
               END IF
           
            AFTER FIELD xcck004 
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004_1) THEN
                   IF g_master.xcck004 > g_master.xcck004_1 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'acr-00064'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_master.xcck004 = g_master_t.xcck004
                      NEXT FIELD xcck004
                   END IF
                END IF
                
            AFTER FIELD xcck005
               IF NOT cl_null(g_master.xcck005) AND NOT cl_null(g_master.xcck005_1) THEN
                  IF g_master.xcck005 > 13 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abm-00261'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xcck005 = g_master_t.xcck005
                     NEXT FIELD xcck005                  
                  END IF
                  IF g_master.xcck004 = g_master.xcck004_1 AND g_master.xcck005 > g_master.xcck005_1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00067'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xcck005 = g_master_t.xcck005
                     NEXT FIELD xcck005
                  END IF
               END IF
            AFTER FIELD xcck004_1
               IF NOT cl_null(g_master.xcck004) AND NOT cl_null(g_master.xcck004_1) THEN
                   IF g_master.xcck004 > g_master.xcck004_1 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'acr-00064'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_master.xcck004_1 = g_master_t.xcck004_1
                      NEXT FIELD xcck004_1
                   END IF
                END IF
            AFTER FIELD xcck005_1   
               IF NOT cl_null(g_master.xcck005) AND NOT cl_null(g_master.xcck005_1) THEN
                  IF g_master.xcck005_1 > 13 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abm-00261'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xcck005_1 = g_master_t.xcck005_1
                     NEXT FIELD xcck005_1                  
                  END IF               
                  IF g_master.xcck004 = g_master.xcck004_1 AND g_master.xcck005 > g_master.xcck005_1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00067'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xcck005_1 = g_master_t.xcck005_1
                     NEXT FIELD xcck005_1
                  END IF
               END IF 
           
            ON ACTION controlp INFIELD xcckcomp             
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xcckcomp     
               #160802-00020#10-add-(S)
               #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               #160802-00020#10-add-(E)               
               CALL q_ooef001_2()
               LET g_master.xcckcomp = g_qryparam.return1
               DISPLAY g_master.xcckcomp TO xcckcomp
               NEXT FIELD xcckcomp
           
            ON ACTION controlp INFIELD xcckld             
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xcckld             
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               #160802-00020#4-add-(S)
               IF NOT cl_null(g_wc_cs_ld) THEN
                  LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
               END IF
               #160802-00020#4-add-(E)
               CALL q_authorised_ld()
               LET g_master.xcckld = g_qryparam.return1
               DISPLAY g_master.xcckld TO xcckld
               NEXT FIELD xcckld
              
            ON ACTION controlp INFIELD xcck003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xcck003
               CALL q_xcat001()
               LET g_master.xcck003 = g_qryparam.return1
               DISPLAY g_master.xcck003 TO xcck003
               NEXT FIELD xcck003
           
              #END add-point
           


         END INPUT          
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc ON imag011,xcck010,xcck022,xcck002
              FROM imag011,xcck010,xcck022,xcck002
           
           BEFORE CONSTRUCT
 
           ON ACTION controlp INFIELD imag011
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              CALL q_imag011_2()                       
              DISPLAY g_qryparam.return1 TO imag011  
              NEXT FIELD imag011                     
              
           ON ACTION controlp INFIELD xcck010
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              CALL q_imaf001_15()                   
              DISPLAY g_qryparam.return1 TO xcck010 
              NEXT FIELD xcck010
            
           ON ACTION controlp INFIELD xcck022
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              CALL q_pmaa001_4()                          
              DISPLAY g_qryparam.return1 TO xcck022  
              NEXT FIELD xcck022                     
            
           ON ACTION controlp INFIELD xcck002   
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              CALL q_xcbf001()                     
              DISPLAY g_qryparam.return1 TO xcck002
              NEXT FIELD xcck002  
             
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq535_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axcq535_b_fill2()
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
            CALL axcq535_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL axcq535_default()
            #end add-point
            NEXT FIELD xcckcomp
 
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
            IF NOT axcq535_ins_temp() THEN
               NEXT FIELD xcck004
            END IF
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axcq535_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axcq535_b_fill()
 
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
            CALL axcq535_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq535_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq535_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq535_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xcck_d.getLength()
               LET g_xcck_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xcck_d.getLength()
               LET g_xcck_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xcck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xcck_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xcck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xcck_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq535_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel",FALSE)
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
               CALL axcq535_ins_xg_temp()
               CALL axcq535_x01("1 = 1","axcq535_temp02",g_no)      #160727-00019#21 Mod   axcq535_x01_temp --> axcq535_temp02
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axcq535_ins_xg_temp()
               CALL axcq535_x01("1 = 1","axcq535_temp02",g_no)      #160727-00019#21 Mod   axcq535_x01_temp --> axcq535_temp02
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
            CALL axcq535_default()
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq535.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq535_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axcq535_b_fill3()
   RETURN
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
 
   CALL g_xcck_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',xccksite,'',xcck022,'','','','','','','','','','','','','','', 
       ''  ,DENSE_RANK() OVER( ORDER BY xcck_t.xcckld,xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck003,xcck_t.xcck004, 
       xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009) AS RANK FROM xcck_t", 
 
 
 
                     "",
                     " WHERE xcckent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xcck_t"),
                     " ORDER BY xcck_t.xcckld,xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck003,xcck_t.xcck004,xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
 
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
 
   LET g_sql = "SELECT '',xccksite,'',xcck022,'','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq535_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq535_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xcck_d[l_ac].sel,g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xccksite_desc, 
       g_xcck_d[l_ac].xcck022,g_xcck_d[l_ac].xcck022_desc,g_xcck_d[l_ac].l_xcck202_1,g_xcck_d[l_ac].l_xcck202_2, 
       g_xcck_d[l_ac].l_xcck202_3,g_xcck_d[l_ac].l_xcck202_4,g_xcck_d[l_ac].l_xcck202_5,g_xcck_d[l_ac].l_xcck202_6, 
       g_xcck_d[l_ac].l_xcck202_7,g_xcck_d[l_ac].l_xcck202_8,g_xcck_d[l_ac].l_xcck202_9,g_xcck_d[l_ac].l_xcck202_10, 
       g_xcck_d[l_ac].l_xcck202_11,g_xcck_d[l_ac].l_xcck202_12,g_xcck_d[l_ac].l_xcck202_13,g_xcck_d[l_ac].l_xcck202_sum 
 
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
 
      CALL axcq535_detail_show("'1'")
 
      CALL axcq535_xcck_t_mask()
 
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
 
   CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xcck_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axcq535_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq535_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq535_detail_action_trans()
 
   LET l_ac = 1
   IF g_xcck_d.getLength() > 0 THEN
      CALL axcq535_b_fill2()
   END IF
 
      CALL axcq535_filter_show('xccksite','b_xccksite')
   CALL axcq535_filter_show('xcck022','b_xcck022')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq535.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq535_b_fill2()
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
 
{<section id="axcq535.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq535_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_xcck_d[l_ac].xccksite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xccksite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xccksite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck022
            LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck022_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq535.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axcq535_filter()
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
      CONSTRUCT g_wc_filter ON xccksite,xcck022
                          FROM s_detail1[1].b_xccksite,s_detail1[1].b_xcck022
 
         BEFORE CONSTRUCT
                     DISPLAY axcq535_filter_parser('xccksite') TO s_detail1[1].b_xccksite
            DISPLAY axcq535_filter_parser('xcck022') TO s_detail1[1].b_xcck022
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xccksite>>----
         #Ctrlp:construct.c.page1.b_xccksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccksite
            #add-point:ON ACTION controlp INFIELD b_xccksite name="construct.c.filter.page1.b_xccksite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗  #161019-00017#5
            CALL q_ooef001_1()   #161019-00017#5
            DISPLAY g_qryparam.return1 TO b_xccksite  #顯示到畫面上
            NEXT FIELD b_xccksite                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_xccksite_desc>>----
         #----<<b_xcck022>>----
         #Ctrlp:construct.c.page1.b_xcck022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck022
            #add-point:ON ACTION controlp INFIELD b_xcck022 name="construct.c.filter.page1.b_xcck022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcck022  #顯示到畫面上
            NEXT FIELD b_xcck022                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_xcck022_desc>>----
         #----<<l_xcck202_1>>----
         #----<<l_xcck202_2>>----
         #----<<l_xcck202_3>>----
         #----<<l_xcck202_4>>----
         #----<<l_xcck202_5>>----
         #----<<l_xcck202_6>>----
         #----<<l_xcck202_7>>----
         #----<<l_xcck202_8>>----
         #----<<l_xcck202_9>>----
         #----<<l_xcck202_10>>----
         #----<<l_xcck202_11>>----
         #----<<l_xcck202_12>>----
         #----<<l_xcck202_13>>----
         #----<<l_xcck202_sum>>----
 
 
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
 
      CALL axcq535_filter_show('xccksite','b_xccksite')
   CALL axcq535_filter_show('xcck022','b_xcck022')
 
 
   CALL axcq535_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq535.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axcq535_filter_parser(ps_field)
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
 
{<section id="axcq535.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq535_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq535_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axcq535.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq535_detail_action_trans()
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
 
{<section id="axcq535.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq535_detail_index_setting()
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
            IF g_xcck_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xcck_d.getLength() AND g_xcck_d.getLength() > 0
            LET g_detail_idx = g_xcck_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xcck_d.getLength() THEN
               LET g_detail_idx = g_xcck_d.getLength()
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
 
{<section id="axcq535.mask_functions" >}
 &include "erp/axc/axcq535_mask.4gl"
 
{</section>}
 
{<section id="axcq535.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 法人組織說明
# Memo...........:
# Usage..........: CALL axcq535_xcckld_desc()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20160406 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_xcckld_desc()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcckld_desc 

END FUNCTION

################################################################################
# Descriptions...: 帳套說明
# Memo...........:
# Usage..........: CALL axcq535_xcckcomp_desc()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20160406 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_xcckcomp_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcckcomp_desc 
END FUNCTION

################################################################################
# Descriptions...: 成本計算類型說明
# Memo...........:
# Usage..........: CALL axcq535_xcck003_desc()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 20160406 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_xcck003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcck003_desc
END FUNCTION

################################################################################
# Descriptions...: INPUT預設值
# Memo...........:
# Usage..........: CALL axcq535_default()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160406 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_default()
DEFINE l_success LIKE type_t.num5

  
   #法人組織
   SELECT ooef017 INTO g_master.xcckcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #帳套、成本計算類型
   IF NOT cl_null(g_master.xcckcomp) THEN
      SELECT glaald,glaa120,glaa003
        INTO g_master.xcckld,g_master.xcck003,g_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_master.xcckcomp
         AND glaa014 = 'Y'          
   #    CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6010') 
   #      RETURNING g_master.xcck004 
   END IF   
   

   #取今日期別當截止期別
   CALL s_fin_date_get_period_value(g_glaa003,g_master.xcckld,g_today)
     RETURNING l_success,g_master.xcck004_1,g_master.xcck005_1
     
   LET g_master.xcck004 = g_master.xcck004_1
   #起始期別
   IF NOT cl_null(g_glaa003) THEN
      SELECT MIN(glav006)
        INTO g_master.xcck005
        FROM glav_t
       WHERE glavent = g_enterprise
         AND glav001 = g_glaa003
         AND glav002 = g_master.xcck004          
   END IF     
   
   LET g_master.xcck009 = 'Y'
   LET g_master.xcck001 = '1'
   LET g_master.pmaa047 = '1'
   CALL axcq535_xcckcomp_desc()               
   CALL axcq535_xcckld_desc()  
   CALL axcq535_xcck003_desc()                             
   DISPLAY BY NAME g_master.xcckcomp,g_master.xcckld,g_master.xcck003,g_master.xcck009,g_master.xcck004,g_master.xcck005,g_master.xcck004_1,g_master.xcck005_1,g_master.xcck001,g_master.pmaa047
   LET g_master_t.* = g_master.*            

END FUNCTION

################################################################################
# Descriptions...: TEMP TABLE 建立
# Memo...........:
# Usage..........: CALL axcq535_create_temp()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160408 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_create_temp()

  DROP TABLE axcq535_tmp;
  CREATE TEMP TABLE axcq535_tmp(
     l_no         SMALLINT,
     l_xcck004    SMALLINT,
     l_xcck005    SMALLINT,
     l_name       VARCHAR(255));
  
  DROP TABLE axcq535_tmp01;             #160727-00019#21 Mod   axcq535_xcck_tmp --> axcq535_tmp01
  CREATE TEMP TABLE axcq535_tmp01(      #160727-00019#21 Mod   axcq535_xcck_tmp --> axcq535_tmp01
     xccksite  VARCHAR(10), 
     xcck022  VARCHAR(10), 
     xcck202_1  DECIMAL(20,6), 
     xcck202_2  DECIMAL(20,6), 
     xcck202_3  DECIMAL(20,6), 
     xcck202_4  DECIMAL(20,6), 
     xcck202_5  DECIMAL(20,6), 
     xcck202_6  VARCHAR(30), 
     xcck202_7  DECIMAL(20,6), 
     xcck202_8  DECIMAL(20,6), 
     xcck202_9  DECIMAL(20,6), 
     xcck202_10  DECIMAL(20,6), 
     xcck202_11  DECIMAL(20,6), 
     xcck202_12  DECIMAL(20,6), 
     xcck202_13  DECIMAL(20,6),
     xcck202_sum  DECIMAL(20,6));      

   #XG報表使用
   DROP TABLE axcq535_temp02;         #160727-00019#21 Mod   axcq535_x01_temp --> axcq535_temp02
   CREATE TEMP TABLE axcq535_temp02(  #160727-00019#21 Mod   axcq535_x01_temp --> axcq535_temp02
      xcckcomp  VARCHAR(10),
      xcckcomp_desc  VARCHAR(500),
      xcckld   VARCHAR(5),
      xcckld_desc    VARCHAR(10),                   
      xcck003  VARCHAR(10),
      xcck003_desc   VARCHAR(500),
      xcck004  SMALLINT,
      xcck004_1  SMALLINT,      
      xcck005  SMALLINT,
      xcck005_1  SMALLINT,                   
      xcck001  VARCHAR(1),  
      xccksite  VARCHAR(10), 
      xccksite_desc  VARCHAR(500), 
      xcck022  VARCHAR(10), 
      xcck022_desc  VARCHAR(500), 
      l_xcck202_1  DECIMAL(20,6), 
      l_xcck202_2  DECIMAL(20,6), 
      l_xcck202_3  DECIMAL(20,6), 
      l_xcck202_4  DECIMAL(20,6), 
      l_xcck202_5  DECIMAL(20,6), 
      l_xcck202_6  DECIMAL(20,6), 
      l_xcck202_7  DECIMAL(20,6), 
      l_xcck202_8  DECIMAL(20,6), 
      l_xcck202_9  DECIMAL(20,6), 
      l_xcck202_10  DECIMAL(20,6), 
      l_xcck202_11  DECIMAL(20,6), 
      l_xcck202_12  DECIMAL(20,6), 
      l_xcck202_13  DECIMAL(20,6), 
      l_xcck202_sum  DECIMAL(20,6),
      l_key  DECIMAL(20,0)) 

END FUNCTION

################################################################################
# Descriptions...: 先將資料塞入temp中
# Memo...........:
# Usage..........: CALL axcq535_ins_temp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 160408 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_ins_temp()
  DEFINE ls_m           LIKE type_t.num5
  DEFINE ls_no          LIKE type_t.num5  
  DEFINE ls_name        LIKE gzzd_t.gzzd005        
  DEFINE l_sql          STRING
  DEFINE r_success      LIKE type_t.num5  
  DEFINE l_table_n      STRING
  DEFINE l_max_xcck005  LIKE xcck_t.xcck005
  DEFINE l_no           LIKE type_t.num5 
  DEFINE l_xcck004      LIKE xcck_t.xcck004
  DEFINE l_xcck005      LIKE xcck_t.xcck005
  DEFINE l_name         LIKE gzzd_t.gzzd005
  DEFINE l_where_sql    STRING
  DEFINE l_upd_sql      STRING
 #DEFINE l_title        LIKE gzzd_t.gzzd005
  
    LET r_success = TRUE    
  
    IF cl_null(g_master.xcck004) OR cl_null(g_master.xcck005) OR
       cl_null(g_master.xcck004_1) OR cl_null(g_master.xcck005_1) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code   = 'ain-00345'
       LET g_errparam.extend = ''
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success
    END IF       
    
    #計算期別，查詢期間不可大於13期
    DELETE FROM axcq535_tmp
    LET ls_no = 1
    IF g_master.xcck004 =  g_master.xcck004_1 THEN
       FOR ls_m = g_master.xcck005 TO g_master.xcck005_1
           LET ls_name = g_master.xcck004 ||"/"||ls_m
           INSERT INTO axcq535_tmp(l_no,l_xcck004,l_xcck005,l_name)
             VALUES (ls_no,g_master.xcck004,ls_m,ls_name)
           LET ls_no = ls_no + 1
       END FOR
    ELSE
       #跨年度
       #取(起)年度的最大期別
       SELECT MAX(glav006)
         INTO l_max_xcck005
         FROM glav_t
        WHERE glavent = g_enterprise
          AND glav001 = g_glaa003
          AND glav002 = g_master.xcck004             
        FOR ls_m = g_master.xcck005 TO l_max_xcck005
           LET ls_name = g_master.xcck004||'/'||ls_m
           INSERT INTO axcq535_tmp(l_no,l_xcck004,l_xcck005,l_name)
             VALUES (ls_no,g_master.xcck004,ls_m,ls_name)
           LET ls_no = ls_no + 1
        END FOR
        FOR ls_m = 1 TO g_master.xcck005_1
           LET ls_name = g_master.xcck004_1||'/'||ls_m
           INSERT INTO axcq535_tmp(l_no,l_xcck004,l_xcck005,l_name)
             VALUES (ls_no,g_master.xcck004_1,ls_m,ls_name)
           LET ls_no = ls_no + 1
        END FOR     
    END IF
    LET ls_no = ls_no - 1
    IF ls_no > 13 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code   = 'axc-00762'
       LET g_errparam.extend = ls_no
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success    
    END IF
    
    
    CALL axcq535_set_comp_visible(ls_no) 
  
    DELETE FROM axcq535_tmp01           #160727-00019#21 Mod   axcq535_xcck_tmp --> axcq535_tmp01
    
    LET l_sql = "SELECT l_no,l_xcck004,l_xcck005,l_name FROM axcq535_tmp ",
                " ORDER BY l_no "
    PREPARE axcq532_tmp_pr FROM l_sql
    DECLARE axcq532_tmp_cr CURSOR FOR axcq532_tmp_pr
    
    LET l_where_sql ="  FROM xcck_t ",        
                     "  LEFT JOIN pmaa_t ON xcckent = pmaaent AND xcck022 = pmaa001 ",
                     "  LEFT JOIN imag_t ON xcckent = imagent AND xcckcomp = imagsite AND xcck010 = imag001 ",
                     " WHERE xcckent = ",g_enterprise, 
                     "   AND xcckcomp = '",g_master.xcckcomp,"'",
                     "   AND xcckld = '",g_master.xcckld,"'",
                     "   AND xcck003 = '",g_master.xcck003,"'", 
                     "   AND xcck001 = '",g_master.xcck001,"'"
                    #"   AND (xcck055 = '201' OR xcck055 = '203') "   #160503-00007#1 mark

   IF g_master.xcck009 = 'N' THEN
      #不含倉退金額
      LET l_where_sql = l_where_sql," AND xcck009 = 1 "
   END IF
   #關系企業
   CASE g_master.pmaa047
     WHEN '2'   #排除關系人
       LET l_where_sql = l_where_sql," AND pmaa047 = 'N' "
     WHEN '3'   #僅列印關系人
       LET l_where_sql = l_where_sql," AND pmaa047 = 'Y' "
   END CASE
   
  #--160503-00007#1--add--(S)
   CASE g_xcck055
     WHEN '1' #採購入庫
       LET l_where_sql = l_where_sql," AND xcck055 = '201' "
     WHEN '2' #委外入庫
       LET l_where_sql = l_where_sql," AND xcck055 = '203' "
     OTHERWISE  
       LET l_where_sql = l_where_sql," AND (xcck055 = '201' OR xcck055 = '203') "
   END CASE  
  #--160503-00007#1--add--(E)
   #160802-00020#4-add-(S)
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcckld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   #QBE條件   
   IF NOT cl_null(g_wc) AND g_wc <> ' 1=2' THEN
      LET l_where_sql = l_where_sql," AND ",g_wc
   END IF   

   LET l_sql = "INSERT INTO axcq535_tmp01( xccksite,   xcck022, xcck202_1, xcck202_2, xcck202_3, ",       #160727-00019#21 Mod   axcq535_xcck_tmp --> axcq535_tmp01
               "                             xcck202_4, xcck202_5, xcck202_6, xcck202_7, xcck202_8, ",
               "                             xcck202_9,xcck202_10,xcck202_11,xcck202_12,xcck202_13, ",
               "                             xcck202_sum ) ",
               "     SELECT xccksite,xcck022,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ",l_where_sql,                
               "        AND (xcck004*12+xcck005 BETWEEN ",g_master.xcck004,"*12+",g_master.xcck005," AND ",g_master.xcck004_1,"*12+",g_master.xcck005_1,")",
               "               GROUP BY xccksite,xcck022 "
                                             
  
   PREPARE axcq535_xcck_ins_p FROM l_sql    
    
   EXECUTE axcq535_xcck_ins_p 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcq535_xcck_ins_p"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF       
   
   
   #因效能關系，將UPD的SQL拉出來FOREACH寫
   LET l_sql = " MERGE INTO axcq535_tmp01 a ",          #160727-00019#21 Mod   axcq535_xcck_tmp --> axcq535_tmp01
               "       USING (SELECT xccksite,xcck022,SUM(CASE xcck009 WHEN -1 THEN xcck202 * -1 ELSE xcck202 END) xcck202 ",l_where_sql,
               "                 AND xcck004 = ? AND xcck005 = ? ",
               "               GROUP BY xccksite,xcck022) b ",             
               "        ON(a.xccksite = b.xccksite AND a.xcck022 = b.xcck022) ",
               "  WHEN MATCHED THEN "
    
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_1 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p1 FROM l_upd_sql          

   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_2 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p2 FROM l_upd_sql
   
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_3 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p3 FROM l_upd_sql     
 
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_4 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p4 FROM l_upd_sql 
 
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_5 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p5 FROM l_upd_sql 
 
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_6 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p6 FROM l_upd_sql 
 
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_7 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p7 FROM l_upd_sql 
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_8 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p8 FROM l_upd_sql     
   
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_9 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p9 FROM l_upd_sql 
   
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_10 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p10 FROM l_upd_sql     
   
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_11 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p11 FROM l_upd_sql 
 
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_12 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p12 FROM l_upd_sql 
   
   LET l_upd_sql = ''
   LET l_upd_sql = l_sql," UPDATE SET a.xcck202_13 = nvl(b.xcck202,0) "           
   PREPARE axcq535_xcck_upd_p13 FROM l_upd_sql    
    
      
   
   #報表說明(動態顯示)
   INITIALIZE g_xg_fieldname TO NULL 

   FOREACH axcq532_tmp_cr INTO l_no,l_xcck004,l_xcck005,l_name   

      LET l_table_n = ''
      
      CASE l_no
        WHEN 1
          EXECUTE axcq535_xcck_upd_p1 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_1',l_name)
          LET g_xg_fieldname[16] = l_name
        WHEN 2
          EXECUTE axcq535_xcck_upd_p2 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_2',l_name)
          LET g_xg_fieldname[17] = l_name
        WHEN 3
          EXECUTE axcq535_xcck_upd_p3 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_3',l_name)
          LET g_xg_fieldname[18] = l_name
        WHEN 4
          EXECUTE axcq535_xcck_upd_p4 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_4',l_name)
          LET g_xg_fieldname[19] = l_name
        WHEN 5
          EXECUTE axcq535_xcck_upd_p5 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_5',l_name)
          LET g_xg_fieldname[20] = l_name
        WHEN 6
          EXECUTE axcq535_xcck_upd_p6 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_6',l_name)
          LET g_xg_fieldname[21] = l_name
        WHEN 7
          EXECUTE axcq535_xcck_upd_p7 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_7',l_name)
          LET g_xg_fieldname[22] = l_name
        WHEN 8
          EXECUTE axcq535_xcck_upd_p8 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_8',l_name)
          LET g_xg_fieldname[23] = l_name
        WHEN 9
          EXECUTE axcq535_xcck_upd_p9 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_9',l_name)
          LET g_xg_fieldname[24] = l_name
        WHEN 10
          EXECUTE axcq535_xcck_upd_p10 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_10',l_name)
          LET g_xg_fieldname[25] = l_name
        WHEN 11
          EXECUTE axcq535_xcck_upd_p11 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_11',l_name)
          LET g_xg_fieldname[26] = l_name
        WHEN 12
          EXECUTE axcq535_xcck_upd_p12 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_12',l_name)
          LET g_xg_fieldname[27] = l_name
        WHEN 13
          EXECUTE axcq535_xcck_upd_p13 USING l_xcck004,l_xcck005
          CALL cl_set_comp_att_text('l_xcck202_13',l_name)
          LET g_xg_fieldname[28] = l_name
      END CASE
     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "PREPARE axcq535_xcck_upd_p"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
    
   END FOREACH
    
   #合計
   LET l_sql = "UPDATE axcq535_tmp01 ",        #160727-00019#21 Mod   axcq535_xcck_tmp --> axcq535_tmp01
               "   SET xcck202_sum = (   xcck202_1 +  xcck202_2 + xcck202_3 + xcck202_4 + xcck202_5 ",
               "                      +  xcck202_6 +  xcck202_7 + xcck202_8 + xcck202_9 + xcck202_10 ",
               "                      + xcck202_11 + xcck202_12 + xcck202_13 ) "                  
   PREPARE axcq535_xcck_upd_sum FROM l_sql
   
   EXECUTE axcq535_xcck_upd_sum
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.extend = "PREPARE axcq535_xcck_upd_sum"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF        
   LET l_name = cl_getmsg("axc-00204",g_lang)
   #LET g_xg_fieldname[18] = l_name
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 單身b_fill
# Memo...........:
# Usage..........: CALL axcq535_b_fill3()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160408 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_b_fill3()

   DEFINE ls_wc              STRING
   DEFINE l_pid              LIKE type_t.chr50
   DEFINE ls_sql_rank        STRING
   DEFINE l_xcck202_1_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_2_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_3_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_4_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_5_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_6_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_7_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_8_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_9_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_10_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_11_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_12_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_13_total  LIKE xcck_t.xcck202
   DEFINE l_xcck202_total_sum LIKE xcck_t.xcck202
   
      
   LET l_xcck202_1_total  = 0
   LET l_xcck202_2_total  = 0
   LET l_xcck202_3_total  = 0
   LET l_xcck202_4_total  = 0
   LET l_xcck202_5_total  = 0
   LET l_xcck202_6_total  = 0
   LET l_xcck202_7_total  = 0
   LET l_xcck202_8_total  = 0
   LET l_xcck202_9_total  = 0
   LET l_xcck202_10_total  = 0
   LET l_xcck202_11_total  = 0
   LET l_xcck202_12_total  = 0
   LET l_xcck202_13_total  = 0
   LET l_xcck202_total_sum  = 0

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
 
   CALL g_xcck_d.clear()
 
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   
   LET l_ac = 1
 
   LET ls_sql_rank = "SELECT         '',  xccksite,        '',  xcck022,        '', ",
                     "        xcck202_1, xcck202_2, xcck202_3,xcck202_4, xcck202_5, ",
                     "        xcck202_6, xcck202_7, xcck202_8,xcck202_9,xcck202_10, ",
                     "       xcck202_11,xcck202_12,xcck202_13,xcck202_sum           ",
                     "  FROM axcq535_tmp01 WHERE ",g_wc_filter,           #160727-00019#21 Mod   axcq535_xcck_tmp --> axcq535_tmp01                   
                     " ORDER BY xccksite,xcck022 "

 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill3_cnt_pre FROM g_sql  
   EXECUTE b_fill3_cnt_pre INTO g_tot_cnt
   FREE b_fill3_cnt_pre
 
   IF g_tot_cnt = 0 THEN
      CALL axcq535_set_comp_visible(0)
   END IF
   
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
   
   
   LET g_sql = "SELECT         '',  xccksite,        '',  xcck022,        '', ",
               "        xcck202_1, xcck202_2, xcck202_3,xcck202_4, xcck202_5, ",
               "        xcck202_6, xcck202_7, xcck202_8,xcck202_9,xcck202_10, ",
               "       xcck202_11,xcck202_12,xcck202_13,xcck202_sum           ",
               "  FROM (",ls_sql_rank,")"    

 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq535_pb3 FROM g_sql
   DECLARE b_fill3_curs CURSOR FOR axcq535_pb3

   FOREACH b_fill3_curs INTO g_xcck_d[l_ac].sel,g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xccksite_desc, 
       g_xcck_d[l_ac].xcck022,g_xcck_d[l_ac].xcck022_desc,g_xcck_d[l_ac].l_xcck202_1,g_xcck_d[l_ac].l_xcck202_2, 
       g_xcck_d[l_ac].l_xcck202_3,g_xcck_d[l_ac].l_xcck202_4,g_xcck_d[l_ac].l_xcck202_5,g_xcck_d[l_ac].l_xcck202_6, 
       g_xcck_d[l_ac].l_xcck202_7,g_xcck_d[l_ac].l_xcck202_8,g_xcck_d[l_ac].l_xcck202_9,g_xcck_d[l_ac].l_xcck202_10, 
       g_xcck_d[l_ac].l_xcck202_11,g_xcck_d[l_ac].l_xcck202_12,g_xcck_d[l_ac].l_xcck202_13,g_xcck_d[l_ac].l_xcck202_sum
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:b_fill3_curs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF

      LET l_xcck202_1_total  = l_xcck202_1_total  + g_xcck_d[l_ac].l_xcck202_1
      LET l_xcck202_2_total  = l_xcck202_2_total  + g_xcck_d[l_ac].l_xcck202_2
      LET l_xcck202_3_total  = l_xcck202_3_total  + g_xcck_d[l_ac].l_xcck202_3
      LET l_xcck202_4_total  = l_xcck202_4_total  + g_xcck_d[l_ac].l_xcck202_4
      LET l_xcck202_5_total  = l_xcck202_5_total  + g_xcck_d[l_ac].l_xcck202_5
      LET l_xcck202_6_total  = l_xcck202_6_total  + g_xcck_d[l_ac].l_xcck202_6
      LET l_xcck202_7_total  = l_xcck202_7_total  + g_xcck_d[l_ac].l_xcck202_7
      LET l_xcck202_8_total  = l_xcck202_8_total  + g_xcck_d[l_ac].l_xcck202_8
      LET l_xcck202_9_total  = l_xcck202_9_total  + g_xcck_d[l_ac].l_xcck202_9
      LET l_xcck202_10_total = l_xcck202_10_total + g_xcck_d[l_ac].l_xcck202_10
      LET l_xcck202_11_total = l_xcck202_11_total + g_xcck_d[l_ac].l_xcck202_11
      LET l_xcck202_12_total = l_xcck202_12_total + g_xcck_d[l_ac].l_xcck202_12
      LET l_xcck202_13_total = l_xcck202_13_total + g_xcck_d[l_ac].l_xcck202_13
      LET l_xcck202_total_sum = l_xcck202_total_sum + g_xcck_d[l_ac].l_xcck202_sum
 
      CALL axcq535_detail_show("'1'")
 
      CALL axcq535_xcck_t_mask()
 
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
   
   #合計
   IF g_tot_cnt > 0 THEN
      LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00204",g_lang)
      LET g_xcck_d[l_ac].l_xcck202_1  = l_xcck202_1_total  
      LET g_xcck_d[l_ac].l_xcck202_2  = l_xcck202_2_total  
      LET g_xcck_d[l_ac].l_xcck202_3  = l_xcck202_3_total  
      LET g_xcck_d[l_ac].l_xcck202_4  = l_xcck202_4_total  
      LET g_xcck_d[l_ac].l_xcck202_5  = l_xcck202_5_total  
      LET g_xcck_d[l_ac].l_xcck202_6  = l_xcck202_6_total  
      LET g_xcck_d[l_ac].l_xcck202_7  = l_xcck202_7_total  
      LET g_xcck_d[l_ac].l_xcck202_8  = l_xcck202_8_total  
      LET g_xcck_d[l_ac].l_xcck202_9  = l_xcck202_9_total  
      LET g_xcck_d[l_ac].l_xcck202_10 = l_xcck202_10_total 
      LET g_xcck_d[l_ac].l_xcck202_11 = l_xcck202_11_total 
      LET g_xcck_d[l_ac].l_xcck202_12 = l_xcck202_12_total 
      LET g_xcck_d[l_ac].l_xcck202_13 = l_xcck202_13_total 
      LET g_xcck_d[l_ac].l_xcck202_sum = l_xcck202_total_sum 
      LET l_ac = l_ac + 1   
      #合計欄會不見，故mark
      #CALL g_xcck_d.deleteElement(g_xcck_d.getLength()) 
   ELSE
      CALL g_xcck_d.deleteElement(g_xcck_d.getLength())    
   END IF
   
   
   
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xcck_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   CLOSE b_fill3_curs
   FREE axcq535_pb3 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq535_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq535_detail_action_trans()
 
   LET l_ac = 1
 
   CALL axcq535_filter_show('xccksite','b_xccksite')
   CALL axcq535_filter_show('xcck022','b_xcck022')
END FUNCTION

################################################################################
# Descriptions...: 控制期別欄位顯示
# Memo...........:
# Usage..........: CALL axcq535_set_comp_visible(p_xcck005)
#                  RETURNING 回传参数
# Input parameter: p_xcck005      期別
# Return code....: 
# Date & Author..: 160411 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_set_comp_visible(p_xcck005)
  DEFINE p_xcck005  LIKE xcck_t.xcck005
  
  
  CALL cl_set_comp_visible("l_xcck202_1,l_xcck202_2,l_xcck202_3,l_xcck202_4,l_xcck202_5",TRUE)
  CALL cl_set_comp_visible("l_xcck202_6,l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",TRUE)
  CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",TRUE)


  CASE p_xcck005
    WHEN 0
      CALL cl_set_comp_visible("l_xcck202_1,l_xcck202_2,l_xcck202_3,l_xcck202_4,l_xcck202_5",FALSE)
      CALL cl_set_comp_visible("l_xcck202_6,l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)     
    WHEN 1
      CALL cl_set_comp_visible("l_xcck202_2,l_xcck202_3,l_xcck202_4,l_xcck202_5",FALSE)
      CALL cl_set_comp_visible("l_xcck202_6,l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)      
    WHEN 2
      CALL cl_set_comp_visible("l_xcck202_3,l_xcck202_4,l_xcck202_5",FALSE)
      CALL cl_set_comp_visible("l_xcck202_6,l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)         
    WHEN 3
      CALL cl_set_comp_visible("l_xcck202_4,l_xcck202_5",FALSE)
      CALL cl_set_comp_visible("l_xcck202_6,l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 4
      CALL cl_set_comp_visible("l_xcck202_5",FALSE)
      CALL cl_set_comp_visible("l_xcck202_6,l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 5
      CALL cl_set_comp_visible("l_xcck202_6,l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)        
    WHEN 6
      CALL cl_set_comp_visible("l_xcck202_7,l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 7
      CALL cl_set_comp_visible("l_xcck202_8,l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 8
      CALL cl_set_comp_visible("l_xcck202_9,l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 9
      CALL cl_set_comp_visible("l_xcck202_10",FALSE)
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 10
      CALL cl_set_comp_visible("l_xcck202_11,l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 11
      CALL cl_set_comp_visible("l_xcck202_12,l_xcck202_13",FALSE)  
    WHEN 12
      CALL cl_set_comp_visible("l_xcck202_13",FALSE)  
  END CASE
END FUNCTION

################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........:
# Usage..........: CALL axcq535_ins_xg_temp()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 160413 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq535_ins_xg_temp()

  DEFINE l_x01_tmp RECORD 
     xcckcomp LIKE xcck_t.xcckcomp,
     xcckcomp_desc LIKE ooefl_t.ooefl003,
     xcckld  LIKE xcck_t.xcckld,
     xcckld_desc   LIKE glaal_t.glaal003,                   
     xcck003 LIKE xcck_t.xcck003,
     xcck003_desc  LIKE xcatl_t.xcatl003,
     xcck004 LIKE xcck_t.xcck004,
     xcck004_1 LIKE xcck_t.xcck004,     
     xcck005 LIKE xcck_t.xcck005,
     xcck005_1 LIKE xcck_t.xcck005,                   
     xcck001 LIKE xcck_t.xcck001,     
     xccksite LIKE xcck_t.xccksite, 
     xccksite_desc LIKE type_t.chr500, 
     xcck022 LIKE xcck_t.xcck022, 
     xcck022_desc LIKE type_t.chr500, 
     xcck202_1 LIKE type_t.num20_6, 
     xcck202_2 LIKE type_t.num20_6, 
     xcck202_3 LIKE type_t.num20_6, 
     xcck202_4 LIKE type_t.num20_6, 
     xcck202_5 LIKE type_t.num20_6, 
     xcck202_6 LIKE type_t.num20_6, 
     xcck202_7 LIKE type_t.num20_6, 
     xcck202_8 LIKE type_t.num20_6, 
     xcck202_9 LIKE type_t.num20_6, 
     xcck202_10 LIKE type_t.num20_6, 
     xcck202_11 LIKE type_t.num20_6, 
     xcck202_12 LIKE type_t.num20_6, 
     xcck202_13 LIKE type_t.num20_6, 
     xcck202_sum LIKE type_t.num20_6,
     xcck_key LIKE type_t.num20  
          END RECORD
   DEFINE l_i   LIKE type_t.num5

   DELETE FROM axcq535_temp02;      #160727-00019#21 Mod   axcq535_x01_temp --> axcq535_temp02
   
   FOR l_i = 1 TO g_xcck_d.getLength()
       INITIALIZE l_x01_tmp.* TO NULL
       LET l_x01_tmp.xcckcomp      = g_master.xcckcomp   
      #LET l_x01_tmp.xcckcomp_desc = g_master.xcckcomp,"(",g_master.xcckcomp_desc,")"  #160713-00008#1 mark
       LET l_x01_tmp.xcckcomp_desc = g_master.xcckcomp_desc                            #160713-00008#1 add
       LET l_x01_tmp.xcckld        = g_master.xcckld        
      #LET l_x01_tmp.xcckld_desc   = g_master.xcckld,"(",g_master.xcckld_desc,")"   #160713-00008#1 mark
       LET l_x01_tmp.xcckld_desc   = g_master.xcckld_desc                           #160713-00008#1 add
       LET l_x01_tmp.xcck003       = g_master.xcck003       
      #LET l_x01_tmp.xcck003_desc  = g_master.xcck003,"(",g_master.xcck003_desc,")"  #160713-00008#1 mark
       LET l_x01_tmp.xcck003_desc  = g_master.xcck003_desc                           #160713-00008#1 add
       LET l_x01_tmp.xcck004       = g_master.xcck004       
       LET l_x01_tmp.xcck005       = g_master.xcck005       
       LET l_x01_tmp.xcck004_1     = g_master.xcck004_1     
       LET l_x01_tmp.xcck005_1     = g_master.xcck005_1     
       LET l_x01_tmp.xcck001       = g_master.xcck001              
       LET l_x01_tmp.xccksite = g_xcck_d[l_i].xccksite
       LET l_x01_tmp.xcck022       = g_xcck_d[l_i].xcck022 
       IF l_i = g_xcck_d.getLength() THEN
       ELSE
         #LET l_x01_tmp.xccksite_desc = g_xcck_d[l_i].xccksite,"(",g_xcck_d[l_i].xccksite_desc,")"   #160713-00008#1 mark 
         #LET l_x01_tmp.xcck022_desc  = g_xcck_d[l_i].xcck022,"(",g_xcck_d[l_i].xcck022_desc,")"     #160713-00008#1 mark     
          LET l_x01_tmp.xccksite_desc = g_xcck_d[l_i].xccksite_desc                                  #160713-00008#1 add 
          LET l_x01_tmp.xcck022_desc  = g_xcck_d[l_i].xcck022_desc                                   #160713-00008#1 add        
       END IF
       LET l_x01_tmp.xcck202_1     = g_xcck_d[l_i].l_xcck202_1     
       LET l_x01_tmp.xcck202_2     = g_xcck_d[l_i].l_xcck202_2     
       LET l_x01_tmp.xcck202_3     = g_xcck_d[l_i].l_xcck202_3     
       LET l_x01_tmp.xcck202_4     = g_xcck_d[l_i].l_xcck202_4     
       LET l_x01_tmp.xcck202_5     = g_xcck_d[l_i].l_xcck202_5     
       LET l_x01_tmp.xcck202_6     = g_xcck_d[l_i].l_xcck202_6     
       LET l_x01_tmp.xcck202_7     = g_xcck_d[l_i].l_xcck202_7     
       LET l_x01_tmp.xcck202_8     = g_xcck_d[l_i].l_xcck202_8     
       LET l_x01_tmp.xcck202_9     = g_xcck_d[l_i].l_xcck202_9     
       LET l_x01_tmp.xcck202_10    = g_xcck_d[l_i].l_xcck202_10    
       LET l_x01_tmp.xcck202_11    = g_xcck_d[l_i].l_xcck202_11    
       LET l_x01_tmp.xcck202_12    = g_xcck_d[l_i].l_xcck202_12    
       LET l_x01_tmp.xcck202_13    = g_xcck_d[l_i].l_xcck202_13    
       LET l_x01_tmp.xcck202_sum   = g_xcck_d[l_i].l_xcck202_sum   
       LET l_x01_tmp.xcck_key      = l_i
       #161109-00085#25-s mod
       #INSERT INTO axcq535_temp02 VALUES(l_x01_tmp.*)    #160727-00019#21 Mod   axcq535_x01_temp --> axcq535_temp02 
       INSERT INTO axcq535_temp02 (xcckcomp,xcckcomp_desc,xcckld,xcckld_desc,xcck003,
                                   xcck003_desc,xcck004,xcck004_1,xcck005,xcck005_1,   
                                   xcck001,xccksite,xccksite_desc,xcck022,xcck022_desc,
                                   xcck202_1,xcck202_2,xcck202_3,xcck202_4,xcck202_5,
                                   xcck202_6,xcck202_7,xcck202_8,xcck202_9,xcck202_10,
                                   xcck202_11,xcck202_12,xcck202_13,xcck202_sum,xcck_key)
                            VALUES(l_x01_tmp.xcckcomp,l_x01_tmp.xcckcomp_desc,l_x01_tmp.xcckld,l_x01_tmp.xcckld_desc,l_x01_tmp.xcck003,l_x01_tmp.xcck003_desc,
                                   l_x01_tmp.xcck004,l_x01_tmp.xcck004_1,l_x01_tmp.xcck005,l_x01_tmp.xcck005_1,l_x01_tmp.xcck001,
                                   l_x01_tmp.xccksite,l_x01_tmp.xccksite_desc,l_x01_tmp.xcck022,l_x01_tmp.xcck022_desc,l_x01_tmp.xcck202_1,
                                   l_x01_tmp.xcck202_2,l_x01_tmp.xcck202_3,l_x01_tmp.xcck202_4,l_x01_tmp.xcck202_5,l_x01_tmp.xcck202_6,
                                   l_x01_tmp.xcck202_7,l_x01_tmp.xcck202_8,l_x01_tmp.xcck202_9,l_x01_tmp.xcck202_10,l_x01_tmp.xcck202_11,
                                   l_x01_tmp.xcck202_12,l_x01_tmp.xcck202_13,l_x01_tmp.xcck202_sum,l_x01_tmp.xcck_key)
       #161109-00085#25-e mod       
   END FOR   
 
   LET g_no = 0
   SELECT COUNT(*) INTO g_no
     FROM axcq535_tmp
   IF cl_null(g_no) THEN
      LET g_no = 0
   END IF      
END FUNCTION

 
{</section>}
 
