#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq832.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-09-18 11:37:40), PR版次:0005(2016-08-29 16:49:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: aglq832
#+ Description: 多法人現金流量表查詢作業
#+ Creator....: 01534(2015-05-05 15:14:26)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq832.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160302-00006#1  2016/03/02 By 07675 原本单身为不可查询作业，取消单身二次筛选功能
#160318-00025#36 2016/04/20 By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160615-00009#1  2016/06/15 By Ann_Huang 修正欄位第一個本期數無法顯示
#160811-00039#4  2016/08/29 By 02599 查询是自行输入账套时要检核账套权限
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
PRIVATE TYPE type_g_glfb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glfb001 LIKE glfb_t.glfb001, 
   glfbseq LIKE glfb_t.glfbseq, 
   glfbseq1 LIKE glfb_t.glfbseq1, 
   glfb002 LIKE glfb_t.glfb002, 
   glfbl004 LIKE type_t.chr500, 
   nmai004 LIKE type_t.num10, 
   batm01 LIKE type_t.num20_6, 
   satm01 LIKE type_t.num20_6, 
   batm02 LIKE type_t.num20_6, 
   satm02 LIKE type_t.num20_6, 
   batm03 LIKE type_t.num20_6, 
   satm03 LIKE type_t.num20_6, 
   batm04 LIKE type_t.num20_6, 
   satm04 LIKE type_t.num20_6, 
   batm05 LIKE type_t.num20_6, 
   satm05 LIKE type_t.num20_6, 
   batm06 LIKE type_t.num20_6, 
   satm06 LIKE type_t.num20_6, 
   batm07 LIKE type_t.num20_6, 
   satm07 LIKE type_t.num20_6, 
   batm08 LIKE type_t.num20_6, 
   satm08 LIKE type_t.num20_6, 
   batm09 LIKE type_t.num20_6, 
   satm09 LIKE type_t.num20_6, 
   batm10 LIKE type_t.num20_6, 
   satm10 LIKE type_t.num20_6, 
   batm11 LIKE type_t.num20_6, 
   satm11 LIKE type_t.num20_6, 
   batm12 LIKE type_t.num20_6, 
   satm12 LIKE type_t.num20_6, 
   batm13 LIKE type_t.num20_6, 
   satm13 LIKE type_t.num20_6, 
   batm14 LIKE type_t.num20_6, 
   satm14 LIKE type_t.num20_6, 
   batm15 LIKE type_t.num20_6, 
   satm15 LIKE type_t.num20_6, 
   batm16 LIKE type_t.num20_6, 
   satm16 LIKE type_t.num20_6, 
   batm17 LIKE type_t.num20_6, 
   satm17 LIKE type_t.num20_6, 
   batm18 LIKE type_t.num20_6, 
   satm18 LIKE type_t.num20_6, 
   batm19 LIKE type_t.num20_6, 
   satm19 LIKE type_t.num20_6, 
   batm20 LIKE type_t.num20_6, 
   satm20 LIKE type_t.num20_6, 
   batm21 LIKE type_t.num20_6, 
   satm21 LIKE type_t.num20_6, 
   batm22 LIKE type_t.num20_6, 
   satm22 LIKE type_t.num20_6, 
   batm23 LIKE type_t.num20_6, 
   satm23 LIKE type_t.num20_6, 
   batm24 LIKE type_t.num20_6, 
   satm24 LIKE type_t.num20_6, 
   batm25 LIKE type_t.num20_6, 
   satm25 LIKE type_t.num20_6, 
   batm26 LIKE type_t.num20_6, 
   satm26 LIKE type_t.num20_6, 
   batm27 LIKE type_t.num20_6, 
   satm27 LIKE type_t.num20_6, 
   batm28 LIKE type_t.num20_6, 
   satm28 LIKE type_t.num20_6, 
   batm29 LIKE type_t.num20_6, 
   satm29 LIKE type_t.num20_6, 
   batm30 LIKE type_t.num20_6, 
   satm30 LIKE type_t.num20_6, 
   batm31 LIKE type_t.num20_6, 
   satm31 LIKE type_t.num20_6, 
   batm32 LIKE type_t.num20_6, 
   satm32 LIKE type_t.num20_6, 
   batm33 LIKE type_t.num20_6, 
   satm33 LIKE type_t.num20_6, 
   batm34 LIKE type_t.num20_6, 
   satm34 LIKE type_t.num20_6, 
   batm35 LIKE type_t.num20_6, 
   satm35 LIKE type_t.num20_6, 
   batm36 LIKE type_t.num20_6, 
   satm36 LIKE type_t.num20_6, 
   batm37 LIKE type_t.num20_6, 
   satm37 LIKE type_t.num20_6, 
   batm38 LIKE type_t.num20_6, 
   satm38 LIKE type_t.num20_6, 
   batm39 LIKE type_t.num5, 
   satm39 LIKE type_t.num20_6, 
   batm40 LIKE type_t.num20_6, 
   satm40 LIKE type_t.num20_6, 
   batm41 LIKE type_t.num20_6, 
   satm41 LIKE type_t.num20_6, 
   batm42 LIKE type_t.num20_6, 
   satm42 LIKE type_t.num20_6, 
   batm43 LIKE type_t.num20_6, 
   satm43 LIKE type_t.num20_6, 
   batm44 LIKE type_t.num20_6, 
   satm44 LIKE type_t.num20_6, 
   batm45 LIKE type_t.num20_6, 
   satm45 LIKE type_t.num20_6, 
   batm46 LIKE type_t.num20_6, 
   satm46 LIKE type_t.num20_6, 
   batm47 LIKE type_t.num5, 
   satm47 LIKE type_t.num20_6, 
   batm48 LIKE type_t.num20_6, 
   satm48 LIKE type_t.num20_6, 
   batm49 LIKE type_t.num20_6, 
   satm49 LIKE type_t.num20_6, 
   batm50 LIKE type_t.num20_6, 
   satm50 LIKE type_t.num20_6, 
   batms LIKE type_t.num20_6, 
   satms LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table1           STRING
DEFINE tm                    RECORD 
       glfa005               LIKE glfa_t.glfa005,
       glfa005_desc          LIKE type_t.chr500,
       glfa010               LIKE glfa_t.glfa010,
       glfa011               LIKE glfa_t.glfa011,
       glfa012               LIKE glfa_t.glfa012,
       glfa013               LIKE glfa_t.glfa013,
       glfa014               LIKE glfa_t.glfa014,
       glfa015               LIKE glfa_t.glfa015,
       glfa008               LIKE glfa_t.glfa008,
       glfa009               LIKE glfa_t.glfa009,
       show_ad               LIKE type_t.chr1,
       stus                  LIKE type_t.chr1,
       chg_curr              LIKE type_t.chr1,
       curr                  LIKE glaq_t.glaq005,
       rate                  LIKE glaq_t.glaq006,
       type_a                LIKE type_t.chr1,
       type_b                LIKE type_t.chr1,
       type_c                LIKE type_t.chr1
       END RECORD
DEFINE g_multi_glfa005              STRING       
DEFINE l_sub_sql                    STRING 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glfb_d
DEFINE g_master_t                   type_g_glfb_d
DEFINE g_glfb_d          DYNAMIC ARRAY OF type_g_glfb_d
DEFINE g_glfb_d_t        type_g_glfb_d
 
      
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
 
{<section id="aglq832.main" >}
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
   CALL cl_ap_init("agl","")
 
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
   DECLARE aglq832_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq832_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq832_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq832 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq832_init()   
 
      #進入選單 Menu (="N")
      CALL aglq832_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq832
      
   END IF 
   
   CLOSE aglq832_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq832_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq832.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq832_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE  ls_hide     STRING 
   DEFINE  li_i        LIKE type_t.num5
   DEFINE  lc_index    LIKE type_t.chr2
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glfa008','8705')
   CALL cl_set_combo_scc('stus','9922')
#   #建立临时表
   CALL aglq832_create_temp_table()
   CALL cl_set_combo_scc('glfbl004','8026')
   LET ls_hide = ' '    
   FOR li_i = 1 TO 50     #欄位的隱藏
      LET lc_index = li_i USING '&&' 
 #150827-00036#1--mod--str--  
      IF cl_null(ls_hide) THEN
         LET ls_hide = "batm" || lc_index || ",satm" || lc_index 
      ELSE
         LET ls_hide = ls_hide || ",batm" || lc_index || ",satm" || lc_index 
      END IF 
#      IF li_i = 1 THEN      
#         LET ls_hide = ls_hide || "batm" || lc_index || ",satm" || lc_index 
#      ELSE
#         LET ls_hide = ls_hide || ",batm" || lc_index || ",satm" || lc_index 
#      END IF
#150827-00036#1--mod--end
   END FOR 
   CALL cl_set_comp_visible(ls_hide,FALSE)   
#   CALL aglq832_hide_show_atm()
   #end add-point
 
   CALL aglq832_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq832.default_search" >}
PRIVATE FUNCTION aglq832_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glfb001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glfbseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glfbseq1 = '", g_argv[03], "' AND "
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
 
{<section id="aglq832.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq832_ui_dialog()
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
   LET g_errshow = 1
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aglq832_b_fill()
   ELSE
      CALL aglq832_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glfb_d.clear()
 
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
 
         CALL aglq832_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glfb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq832_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq832_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               LET g_detail_cnt = g_glfb_d.getLength() 
               DISPLAY g_detail_cnt TO FORMONLY.h_count  
               DISPLAY g_detail_idx TO FORMONLY.h_index              
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq832_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert", FALSE)
            CALL cl_set_act_visible("filter",FALSE)    #160302-00006#1  2016/03/02 By 07675 
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglq832_insert()
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
               CALL aglq832_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq832_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
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
            CALL aglq832_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glfb_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
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
            CALL aglq832_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq832_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq832_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq832_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
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
 
{<section id="aglq832.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq832_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_glfa004  LIKE glfa_t.glfa004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glfa002  LIKE glfa_t.glfa002
   DEFINE l_glav006  LIKE glav_t.glav006
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_pass     LIKE type_t.num5
   DEFINE l_glav003  LIKE glav_t.glav003
   
   CALL s_ld_bookno()  RETURNING l_success,tm.glfa005
   
   IF l_success = FALSE THEN
      RETURN 
   END IF 
   CALL aglq832_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
   DISPLAY tm.glfa005_desc TO glfa005_desc
   CALL s_ld_chk_authorization(g_user,tm.glfa005) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00164'
      LET g_errparam.extend = tm.glfa005
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET tm.glfa005=NULL
   END IF
   
   LET tm.glfa010=YEAR(g_today)
   LET tm.glfa011=MONTH(g_today)
   LET tm.glfa012=tm.glfa011
   #本期未第一期
   IF tm.glfa011=1 THEN 
      LET tm.glfa013=tm.glfa010-1
      SELECT DISTINCT glav003 INTO l_glav003 FROM glaa_t,glav_t
      WHERE glaaent=glavent AND glaa003=glav001 AND glav002=tm.glfa013
      AND glaald=tm.glfa005
      IF l_glav003='2' THEN
         LET tm.glfa014=13
         LET tm.glfa015=13
      ELSE
         LET tm.glfa014=12
         LET tm.glfa015=12
      END IF
   ELSE
      LET tm.glfa013=tm.glfa010
      LET tm.glfa014=tm.glfa011-1
      LET tm.glfa015=tm.glfa011-1
   END IF
   LET tm.glfa008='1' 
   LET tm.glfa009=2
   LET tm.type_a='Y'
   LET tm.type_b='Y'
   LET tm.type_c='Y'   
   DISPLAY tm.glfa005 TO glfa005
   LET g_multi_glfa005 = tm.glfa005
   DISPLAY BY NAME tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa013,tm.glfa014,tm.glfa015,
                   tm.glfa008,tm.glfa009,tm.type_a,tm.type_b,tm.type_c
   DISPLAY g_multi_glfa005 TO glfa005 
   DISPLAY tm.glfa005_desc TO glfa005_desc 
   #150827-00036#1--add--str--
   LET tm.show_ad='Y'
   LET tm.stus='1'
   LET tm.chg_curr='N'
   LET tm.curr=''
   LET tm.rate=''
   CALL cl_set_comp_entry('curr,rate',FALSE)
   DISPLAY BY NAME tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate
   #150827-00036#1--add--end
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glfb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glfb001,glfbseq,glfbseq1,glfb002
           FROM s_detail1[1].b_glfb001,s_detail1[1].b_glfbseq,s_detail1[1].b_glfbseq1,s_detail1[1].b_glfb002 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glfb001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb001
            #add-point:BEFORE FIELD b_glfb001 name="construct.b.page1.b_glfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb001
            
            #add-point:AFTER FIELD b_glfb001 name="construct.a.page1.b_glfb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb001
            #add-point:ON ACTION controlp INFIELD b_glfb001 name="construct.c.page1.b_glfb001"
            
            #END add-point
 
 
         #----<<b_glfbseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbseq
            #add-point:BEFORE FIELD b_glfbseq name="construct.b.page1.b_glfbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbseq
            
            #add-point:AFTER FIELD b_glfbseq name="construct.a.page1.b_glfbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq
            #add-point:ON ACTION controlp INFIELD b_glfbseq name="construct.c.page1.b_glfbseq"
            
            #END add-point
 
 
         #----<<b_glfbseq1>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbseq1
            #add-point:BEFORE FIELD b_glfbseq1 name="construct.b.page1.b_glfbseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbseq1
            
            #add-point:AFTER FIELD b_glfbseq1 name="construct.a.page1.b_glfbseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq1
            #add-point:ON ACTION controlp INFIELD b_glfbseq1 name="construct.c.page1.b_glfbseq1"
            
            #END add-point
 
 
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.page1.b_glfb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb002
            #add-point:BEFORE FIELD b_glfb002 name="construct.b.page1.b_glfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb002
            
            #add-point:AFTER FIELD b_glfb002 name="construct.a.page1.b_glfb002"
            
            #END add-point
            
 
 
         #----<<glfbl004>>----
         #----<<nmai004>>----
         #----<<batm01>>----
         #----<<satm01>>----
         #----<<batm02>>----
         #----<<satm02>>----
         #----<<batm03>>----
         #----<<satm03>>----
         #----<<batm04>>----
         #----<<satm04>>----
         #----<<batm05>>----
         #----<<satm05>>----
         #----<<batm06>>----
         #----<<satm06>>----
         #----<<batm07>>----
         #----<<satm07>>----
         #----<<batm08>>----
         #----<<satm08>>----
         #----<<batm09>>----
         #----<<satm09>>----
         #----<<batm10>>----
         #----<<satm10>>----
         #----<<batm11>>----
         #----<<satm11>>----
         #----<<batm12>>----
         #----<<satm12>>----
         #----<<batm13>>----
         #----<<satm13>>----
         #----<<batm14>>----
         #----<<satm14>>----
         #----<<batm15>>----
         #----<<satm15>>----
         #----<<batm16>>----
         #----<<satm16>>----
         #----<<batm17>>----
         #----<<satm17>>----
         #----<<batm18>>----
         #----<<satm18>>----
         #----<<batm19>>----
         #----<<satm19>>----
         #----<<batm20>>----
         #----<<satm20>>----
         #----<<batm21>>----
         #----<<satm21>>----
         #----<<batm22>>----
         #----<<satm22>>----
         #----<<batm23>>----
         #----<<satm23>>----
         #----<<batm24>>----
         #----<<satm24>>----
         #----<<batm25>>----
         #----<<satm25>>----
         #----<<batm26>>----
         #----<<satm26>>----
         #----<<batm27>>----
         #----<<satm27>>----
         #----<<batm28>>----
         #----<<satm28>>----
         #----<<batm29>>----
         #----<<satm29>>----
         #----<<batm30>>----
         #----<<satm30>>----
         #----<<batm31>>----
         #----<<satm31>>----
         #----<<batm32>>----
         #----<<satm32>>----
         #----<<batm33>>----
         #----<<satm33>>----
         #----<<batm34>>----
         #----<<satm34>>----
         #----<<batm35>>----
         #----<<satm35>>----
         #----<<batm36>>----
         #----<<satm36>>----
         #----<<batm37>>----
         #----<<satm37>>----
         #----<<batm38>>----
         #----<<satm38>>----
         #----<<batm39>>----
         #----<<satm39>>----
         #----<<batm40>>----
         #----<<satm40>>----
         #----<<batm41>>----
         #----<<satm41>>----
         #----<<batm42>>----
         #----<<satm42>>----
         #----<<batm43>>----
         #----<<satm43>>----
         #----<<batm44>>----
         #----<<satm44>>----
         #----<<batm45>>----
         #----<<satm45>>----
         #----<<batm46>>----
         #----<<satm46>>----
         #----<<batm47>>----
         #----<<satm47>>----
         #----<<batm48>>----
         #----<<satm48>>----
         #----<<batm49>>----
         #----<<satm49>>----
         #----<<batm50>>----
         #----<<satm50>>----
         #----<<batms>>----
         #----<<satms>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
#      CONSTRUCT BY NAME g_multi_glfa005 ON glfa005
#      
#         ON ACTION controlp INFIELD glfa005
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c' 
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " glaastus = 'Y' "
#            #給予arg
#            LET g_qryparam.arg1 = g_user
#            LET g_qryparam.arg2 = g_dept
#            
#            CALL q_authorised_ld2()                                #呼叫開窗              
#            DISPLAY g_qryparam.return1 TO glfa005
#            NEXT FIELD glfa005    
#      END CONSTRUCT

     
      INPUT g_multi_glfa005,tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa013, 
            tm.glfa014,tm.glfa015,tm.glfa008,tm.glfa009,tm.type_a,tm.type_b,tm.type_c,
            tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate  #150827-00036#1 add
       FROM glfa005,glfa010,glfa011,glfa012,glfa013, 
            glfa014,glfa015,glfa008,glfa009,type_a,type_b,type_c,
            show_ad,stus,chg_curr,curr,rate  #150827-00036#1 add
         ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT
            CALL aglq832_glfa005_desc(g_multi_glfa005) RETURNING tm.glfa005_desc
            DISPLAY tm.glfa005_desc TO glfa005_desc   
            
         AFTER FIELD glfa005
            IF NOT cl_null(g_multi_glfa005) THEN
               IF NOT aglq832_get_glfa005() THEN
                  LET g_multi_glfa005 = ''
                  LET tm.glfa005_desc = ''
                  DISPLAY g_multi_glfa005 TO glfa005 
                  DISPLAY tm.glfa005_desc TO glfa005_desc
                  NEXT FIELD glfa005
               END IF
            END IF
            DISPLAY g_multi_glfa005 TO glfa005 
            DISPLAY tm.glfa005_desc TO glfa005_desc
                  
         AFTER FIELD glfa011
            IF tm.glfa011>tm.glfa012 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00227'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa011
            END IF
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa010
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa011>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa011
               END IF
            END IF 

         AFTER FIELD glfa012
            IF tm.glfa012<tm.glfa011 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00228'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa012
            END IF 
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa010
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa012>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa012
               END IF
            END IF
            
         AFTER FIELD glfa014
            IF tm.glfa014>tm.glfa015 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00227'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa014
            END IF 
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa013
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa014>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa014
               END IF
            END IF
            
         AFTER FIELD glfa015
            IF tm.glfa014>tm.glfa015 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00228'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa015
            END IF 
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa013
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa015>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa015
               END IF
            END IF
         AFTER FIELD glfa009
            IF NOT cl_ap_chk_Range(tm.glfa009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glfa009
            END IF
            
            
         AFTER FIELD type_a
            IF tm.type_a NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
            
         AFTER FIELD type_b
            IF tm.type_b NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD type_c
            IF tm.type_c NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
         
         #150827-00036#1--add--str--
         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
         
         ON CHANGE chg_curr
            IF tm.chg_curr = 'Y' THEN
               CALL cl_set_comp_entry('curr,rate',TRUE)
            ELSE
               CALL cl_set_comp_entry('curr,rate',FALSE)
               LET tm.curr=''
               LET tm.rate=''
               DISPLAY BY NAME tm.curr,tm.rate
            END IF
            
         AFTER FIELD curr
            IF NOT cl_null(tm.curr) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=tm.curr
               
               #160318-00025#36  2016/04/20  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#36  2016/04/20  by pengxin  add(E)
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET tm.curr=''
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD rate
            IF NOT cl_null(tm.rate) THEN
               CALL s_num_isnum(tm.rate) RETURNING l_success
               IF l_success=FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD rate
               END IF
            END IF
         #150827-00036#1--add--end

         ON ACTION controlp INFIELD glfa005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glaastus = 'Y' "
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld2()                                #呼叫開窗              
            DISPLAY g_qryparam.return1 TO glfa005
            LET g_multi_glfa005 = g_qryparam.return1
            NEXT FIELD glfa005
         
         #150827-00036#1--add--str--
         ON ACTION controlp INFIELD curr
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.curr  
            CALL q_ooai001()                          #呼叫開窗
            LET tm.curr = g_qryparam.return1
            DISPLAY tm.curr TO curr  #顯示到畫面上
            NEXT FIELD curr 
         #150827-00036#1--add--end
      END INPUT
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
   CALL aglq832_get_data() 
   #end add-point
        
   LET g_error_show = 1
   CALL aglq832_b_fill()
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
 
{<section id="aglq832.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq832_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   CALL aglq832_b_fill2()
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glfb001,glfbseq,glfbseq1,glfb002,'','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '',''  ,DENSE_RANK() OVER( ORDER BY glfb_t.glfb001,glfb_t.glfbseq,glfb_t.glfbseq1) AS RANK FROM glfb_t", 
 
 
 
                     "",
                     " WHERE glfbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfb_t"),
                     " ORDER BY glfb_t.glfb001,glfb_t.glfbseq,glfb_t.glfbseq1"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
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
 
   LET g_sql = "SELECT '',glfb001,glfbseq,glfbseq1,glfb002,'','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq832_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq832_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glfb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glfb_d[l_ac].sel,g_glfb_d[l_ac].glfb001,g_glfb_d[l_ac].glfbseq,g_glfb_d[l_ac].glfbseq1, 
       g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].nmai004,g_glfb_d[l_ac].batm01,g_glfb_d[l_ac].satm01, 
       g_glfb_d[l_ac].batm02,g_glfb_d[l_ac].satm02,g_glfb_d[l_ac].batm03,g_glfb_d[l_ac].satm03,g_glfb_d[l_ac].batm04, 
       g_glfb_d[l_ac].satm04,g_glfb_d[l_ac].batm05,g_glfb_d[l_ac].satm05,g_glfb_d[l_ac].batm06,g_glfb_d[l_ac].satm06, 
       g_glfb_d[l_ac].batm07,g_glfb_d[l_ac].satm07,g_glfb_d[l_ac].batm08,g_glfb_d[l_ac].satm08,g_glfb_d[l_ac].batm09, 
       g_glfb_d[l_ac].satm09,g_glfb_d[l_ac].batm10,g_glfb_d[l_ac].satm10,g_glfb_d[l_ac].batm11,g_glfb_d[l_ac].satm11, 
       g_glfb_d[l_ac].batm12,g_glfb_d[l_ac].satm12,g_glfb_d[l_ac].batm13,g_glfb_d[l_ac].satm13,g_glfb_d[l_ac].batm14, 
       g_glfb_d[l_ac].satm14,g_glfb_d[l_ac].batm15,g_glfb_d[l_ac].satm15,g_glfb_d[l_ac].batm16,g_glfb_d[l_ac].satm16, 
       g_glfb_d[l_ac].batm17,g_glfb_d[l_ac].satm17,g_glfb_d[l_ac].batm18,g_glfb_d[l_ac].satm18,g_glfb_d[l_ac].batm19, 
       g_glfb_d[l_ac].satm19,g_glfb_d[l_ac].batm20,g_glfb_d[l_ac].satm20,g_glfb_d[l_ac].batm21,g_glfb_d[l_ac].satm21, 
       g_glfb_d[l_ac].batm22,g_glfb_d[l_ac].satm22,g_glfb_d[l_ac].batm23,g_glfb_d[l_ac].satm23,g_glfb_d[l_ac].batm24, 
       g_glfb_d[l_ac].satm24,g_glfb_d[l_ac].batm25,g_glfb_d[l_ac].satm25,g_glfb_d[l_ac].batm26,g_glfb_d[l_ac].satm26, 
       g_glfb_d[l_ac].batm27,g_glfb_d[l_ac].satm27,g_glfb_d[l_ac].batm28,g_glfb_d[l_ac].satm28,g_glfb_d[l_ac].batm29, 
       g_glfb_d[l_ac].satm29,g_glfb_d[l_ac].batm30,g_glfb_d[l_ac].satm30,g_glfb_d[l_ac].batm31,g_glfb_d[l_ac].satm31, 
       g_glfb_d[l_ac].batm32,g_glfb_d[l_ac].satm32,g_glfb_d[l_ac].batm33,g_glfb_d[l_ac].satm33,g_glfb_d[l_ac].batm34, 
       g_glfb_d[l_ac].satm34,g_glfb_d[l_ac].batm35,g_glfb_d[l_ac].satm35,g_glfb_d[l_ac].batm36,g_glfb_d[l_ac].satm36, 
       g_glfb_d[l_ac].batm37,g_glfb_d[l_ac].satm37,g_glfb_d[l_ac].batm38,g_glfb_d[l_ac].satm38,g_glfb_d[l_ac].batm39, 
       g_glfb_d[l_ac].satm39,g_glfb_d[l_ac].batm40,g_glfb_d[l_ac].satm40,g_glfb_d[l_ac].batm41,g_glfb_d[l_ac].satm41, 
       g_glfb_d[l_ac].batm42,g_glfb_d[l_ac].satm42,g_glfb_d[l_ac].batm43,g_glfb_d[l_ac].satm43,g_glfb_d[l_ac].batm44, 
       g_glfb_d[l_ac].satm44,g_glfb_d[l_ac].batm45,g_glfb_d[l_ac].satm45,g_glfb_d[l_ac].batm46,g_glfb_d[l_ac].satm46, 
       g_glfb_d[l_ac].batm47,g_glfb_d[l_ac].satm47,g_glfb_d[l_ac].batm48,g_glfb_d[l_ac].satm48,g_glfb_d[l_ac].batm49, 
       g_glfb_d[l_ac].satm49,g_glfb_d[l_ac].batm50,g_glfb_d[l_ac].satm50,g_glfb_d[l_ac].batms,g_glfb_d[l_ac].satms 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glfb_d[l_ac].statepic = cl_get_actipic(g_glfb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq832_detail_show("'1'")      
 
      CALL aglq832_glfb_t_mask()
 
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
   
 
   
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glfb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq832_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq832_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq832_detail_action_trans()
 
   IF g_glfb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq832_fetch()
   END IF
   
      CALL aglq832_filter_show('glfb001','b_glfb001')
   CALL aglq832_filter_show('glfbseq','b_glfbseq')
   CALL aglq832_filter_show('glfbseq1','b_glfbseq1')
   CALL aglq832_filter_show('glfb002','b_glfb002')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq832.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq832_fetch()
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
 
{<section id="aglq832.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq832_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_glfb_d[l_ac].glfb001
            LET g_ref_fields[2] = g_glfb_d[l_ac].glfbseq
            LET g_ref_fields[3] = g_glfb_d[l_ac].glfb002
            LET ls_sql = "SELECT glfbl004 FROM glfbl_t WHERE glfblent='"||g_enterprise||"' AND glfbl001=? AND glfblseq=? AND glfbl002=? AND glfbl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_glfb_d[l_ac].glfbl004 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glfb_d[l_ac].glfbl004

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq832.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq832_filter()
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
      CONSTRUCT g_wc_filter ON glfb001,glfbseq,glfbseq1,glfb002
                          FROM s_detail1[1].b_glfb001,s_detail1[1].b_glfbseq,s_detail1[1].b_glfbseq1, 
                              s_detail1[1].b_glfb002
 
         BEFORE CONSTRUCT
                     DISPLAY aglq832_filter_parser('glfb001') TO s_detail1[1].b_glfb001
            DISPLAY aglq832_filter_parser('glfbseq') TO s_detail1[1].b_glfbseq
            DISPLAY aglq832_filter_parser('glfbseq1') TO s_detail1[1].b_glfbseq1
            DISPLAY aglq832_filter_parser('glfb002') TO s_detail1[1].b_glfb002
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glfb001>>----
         #Ctrlp:construct.c.filter.page1.b_glfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb001
            #add-point:ON ACTION controlp INFIELD b_glfb001 name="construct.c.filter.page1.b_glfb001"
            
            #END add-point
 
 
         #----<<b_glfbseq>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq
            #add-point:ON ACTION controlp INFIELD b_glfbseq name="construct.c.filter.page1.b_glfbseq"
            
            #END add-point
 
 
         #----<<b_glfbseq1>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq1
            #add-point:ON ACTION controlp INFIELD b_glfbseq1 name="construct.c.filter.page1.b_glfbseq1"
            
            #END add-point
 
 
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.filter.page1.b_glfb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    


            #END add-point
 
 
         #----<<glfbl004>>----
         #----<<nmai004>>----
         #----<<batm01>>----
         #----<<satm01>>----
         #----<<batm02>>----
         #----<<satm02>>----
         #----<<batm03>>----
         #----<<satm03>>----
         #----<<batm04>>----
         #----<<satm04>>----
         #----<<batm05>>----
         #----<<satm05>>----
         #----<<batm06>>----
         #----<<satm06>>----
         #----<<batm07>>----
         #----<<satm07>>----
         #----<<batm08>>----
         #----<<satm08>>----
         #----<<batm09>>----
         #----<<satm09>>----
         #----<<batm10>>----
         #----<<satm10>>----
         #----<<batm11>>----
         #----<<satm11>>----
         #----<<batm12>>----
         #----<<satm12>>----
         #----<<batm13>>----
         #----<<satm13>>----
         #----<<batm14>>----
         #----<<satm14>>----
         #----<<batm15>>----
         #----<<satm15>>----
         #----<<batm16>>----
         #----<<satm16>>----
         #----<<batm17>>----
         #----<<satm17>>----
         #----<<batm18>>----
         #----<<satm18>>----
         #----<<batm19>>----
         #----<<satm19>>----
         #----<<batm20>>----
         #----<<satm20>>----
         #----<<batm21>>----
         #----<<satm21>>----
         #----<<batm22>>----
         #----<<satm22>>----
         #----<<batm23>>----
         #----<<satm23>>----
         #----<<batm24>>----
         #----<<satm24>>----
         #----<<batm25>>----
         #----<<satm25>>----
         #----<<batm26>>----
         #----<<satm26>>----
         #----<<batm27>>----
         #----<<satm27>>----
         #----<<batm28>>----
         #----<<satm28>>----
         #----<<batm29>>----
         #----<<satm29>>----
         #----<<batm30>>----
         #----<<satm30>>----
         #----<<batm31>>----
         #----<<satm31>>----
         #----<<batm32>>----
         #----<<satm32>>----
         #----<<batm33>>----
         #----<<satm33>>----
         #----<<batm34>>----
         #----<<satm34>>----
         #----<<batm35>>----
         #----<<satm35>>----
         #----<<batm36>>----
         #----<<satm36>>----
         #----<<batm37>>----
         #----<<satm37>>----
         #----<<batm38>>----
         #----<<satm38>>----
         #----<<batm39>>----
         #----<<satm39>>----
         #----<<batm40>>----
         #----<<satm40>>----
         #----<<batm41>>----
         #----<<satm41>>----
         #----<<batm42>>----
         #----<<satm42>>----
         #----<<batm43>>----
         #----<<satm43>>----
         #----<<batm44>>----
         #----<<satm44>>----
         #----<<batm45>>----
         #----<<satm45>>----
         #----<<batm46>>----
         #----<<satm46>>----
         #----<<batm47>>----
         #----<<satm47>>----
         #----<<batm48>>----
         #----<<satm48>>----
         #----<<batm49>>----
         #----<<satm49>>----
         #----<<batm50>>----
         #----<<satm50>>----
         #----<<batms>>----
         #----<<satms>>----
   
 
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
   
      CALL aglq832_filter_show('glfb001','b_glfb001')
   CALL aglq832_filter_show('glfbseq','b_glfbseq')
   CALL aglq832_filter_show('glfbseq1','b_glfbseq1')
   CALL aglq832_filter_show('glfb002','b_glfb002')
 
    
   CALL aglq832_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq832.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq832_filter_parser(ps_field)
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
 
{<section id="aglq832.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq832_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq832_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq832.insert" >}
#+ insert
PRIVATE FUNCTION aglq832_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq832.modify" >}
#+ modify
PRIVATE FUNCTION aglq832_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq832.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq832_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq832.delete" >}
#+ delete
PRIVATE FUNCTION aglq832_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq832.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq832_detail_action_trans()
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
 
{<section id="aglq832.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq832_detail_index_setting()
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
            IF g_glfb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glfb_d.getLength() AND g_glfb_d.getLength() > 0
            LET g_detail_idx = g_glfb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glfb_d.getLength() THEN
               LET g_detail_idx = g_glfb_d.getLength()
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
 
{<section id="aglq832.mask_functions" >}
 &include "erp/agl/aglq832_mask.4gl"
 
{</section>}
 
{<section id="aglq832.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取賬套
# Memo...........:
# Usage..........: CALL aglq832_get_glfa005()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq832_get_glfa005()
DEFINE   tok            base.StringTokenizer
DEFINE   l_glfa005      LIKE glfa_t.glfa005
DEFINE   r_success      LIKE type_t.num5
DEFINE   i              LIKE type_t.num5
DEFINE   l_cnt          LIKE type_t.num5  
DEFINE   l_glaa005      LIKE glaa_t.glaa005
DEFINE   l_glaa005_t    LIKE glaa_t.glaa005
DEFINE   l_glfa005_desc LIKE glaal_t.glaal002

   LET tok = base.StringTokenizer.create(g_multi_glfa005,"|") 
   LET l_sub_sql = ''
   LET i = 1
   LET r_success = TRUE
   LET l_glaa005_t = ''
   LET l_glaa005 = ''
   LET tm.glfa005_desc = ''
   WHILE tok.hasMoreTokens()  
      LET l_glfa005 = tok.nextToken()
      IF NOT cl_null(l_glfa005) THEN  
         SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glfa005
         IF l_cnt=0 THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00055'
            LET g_errparam.extend = l_glfa005
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT WHILE                  
         END IF
         #160811-00039#4--add--str--
         SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glfa005 AND glaastus='Y'
         IF l_cnt=0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00051'
            LET g_errparam.extend = l_glfa005
            LET g_errparam.popup = FALSE
            CALL cl_err()
            LET r_success = FALSE
            EXIT WHILE
         END IF
         IF NOT s_ld_chk_authorization(g_user,l_glfa005) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00164'
            LET g_errparam.extend = l_glfa005
            LET g_errparam.popup = FALSE
            CALL cl_err()
            LET r_success = FALSE
            EXIT WHILE
         END IF
         #160811-00039#4--add--end
         SELECT glaa005 INTO l_glaa005 FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = l_glfa005
         IF cl_null(l_glaa005_t) THEN
            LET l_glaa005_t = l_glaa005
         END IF  
         IF NOT cl_null(l_glaa005_t) AND NOT cl_null(l_glaa005) THEN
            IF l_glaa005_t <> l_glaa005 THEN
               LET r_success = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00341'
               LET g_errparam.extend = l_glfa005
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT WHILE                  
            END IF
         END IF  
         CALL aglq832_glfa005_desc(l_glfa005) RETURNING l_glfa005_desc
         IF tm.glfa005_desc IS NULL THEN
            LET tm.glfa005_desc = l_glfa005_desc   
         ELSE         
            LET tm.glfa005_desc = tm.glfa005_desc,'/',l_glfa005_desc     
         END IF            
      END IF   
#      LET l_glfa[i].glfa005 = l_glfa005     
#      LET i = i + 1 
      IF cl_null(l_sub_sql) THEN
         LET l_sub_sql = "'",l_glfa005,"'"
      ELSE
         LET l_sub_sql = l_sub_sql,",","'",l_glfa005,"'"
      END IF
      
   END WHILE
#   CALL l_glfa.deleteElement(i)
#   LET i = i -1 
   IF r_success THEN
      LET l_sub_sql = "(",l_sub_sql,")"
   ELSE
      LET l_sub_sql = ''   
   END IF
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq832_glfa005_desc(p_glfa005)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq832_glfa005_desc(p_glfa005)
   DEFINE p_glfa005             LIKE glfa_t.glfa005
   DEFINE r_desc                LIKE glaal_t.glaal002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glfa005
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq832_b_fill2()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq832_b_fill2()
   DEFINE l_seq           LIKE glfb_t.glfbseq
   DEFINE l_seq1          LIKE type_t.num10
   DEFINE l_format        STRING
   DEFINE l_str           STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_glaacomp_t    LIKE glaa_t.glaacomp
   CALL g_glfb_d.clear()
   LET g_sql = "SELECT UNIQUE 'N',seq1,seq,glfb002,glfbl004,nmai004,amt1,amt2,glaacomp",
               "  FROM aglq832_tmp ",
               " WHERE 1=1 ",
               " ORDER BY seq1,seq"
  
   PREPARE aglq832_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq832_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
   #資產
   LET l_glaacomp_t = ''
   LET l_glaacomp = ''
   FOREACH b_fill_curs1 INTO g_glfb_d[l_ac].sel,l_seq1,l_seq,g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].nmai004, 
                             g_glfb_d[l_ac].batm01,g_glfb_d[l_ac].satm01,l_glaacomp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF cl_null(l_glaacomp_t) THEN
         LET l_glaacomp_t = l_glaacomp
      END IF
      IF l_glaacomp_t = l_glaacomp THEN  
         LET g_glfb_d[l_ac].batms = g_glfb_d[l_ac].batm01
         LET g_glfb_d[l_ac].satms = g_glfb_d[l_ac].satm01
         #add by lixh 20150520
         IF cl_null(g_glfb_d[l_ac].batms) THEN LET g_glfb_d[l_ac].batms = 0 END IF
         IF cl_null(g_glfb_d[l_ac].satms) THEN LET g_glfb_d[l_ac].satms = 0 END IF
         #add by lixh 20150520
         LET l_ac = l_ac + 1
      END IF
      #add by lixh 20150520
      IF l_glaacomp_t <> l_glaacomp  AND l_seq < l_ac THEN
         CALL aglq832_row_desc(l_ac,l_seq,l_seq1)
      END IF
      IF l_glaacomp_t <> l_glaacomp  AND l_seq >= l_ac THEN
         LET g_glfb_d[l_ac].batms = g_glfb_d[l_ac].batm01
         LET g_glfb_d[l_ac].satms = g_glfb_d[l_ac].satm01   
         IF cl_null(g_glfb_d[l_ac].batms) THEN LET g_glfb_d[l_ac].batms = 0 END IF
         IF cl_null(g_glfb_d[l_ac].satms) THEN LET g_glfb_d[l_ac].satms = 0 END IF                  
         CALL aglq832_row_desc(l_ac,l_seq,l_seq1)
         LET l_ac = l_ac + 1
      END IF    
      #add by lixh 20150520      
      IF l_ac > g_max_rec THEN
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
   LET g_error_show = 0
   LET l_ac = l_ac - 1
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())       
   LET g_detail_cnt = g_glfb_d.getLength() 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str = ""
   FOR l_i=1 TO tm.glfa009
       LET l_str = l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET l_format = l_format,'.',l_str
   END IF
   CALL cl_set_comp_format("batm01,batm02,batm03,batm04,batm05,batm06,batm07,batm08,batm09,batm10,batm11,batm12,batm13,batm14,batm15,batm16,batm17,batm18,batm19,batm20,batm21,batm22,batm23,batm24,batm25",l_format)
   CALL cl_set_comp_format("batm26,batm27,batm28,batm29,batm30,batm31,batm32,batm33,batm34,batm35,batm36,batm37,batm38,batm39,batm40,batm41,batm42,batm43,batm44,batm45,batm46,batm47,batm48,batm49,batm50",l_format)
   CALL cl_set_comp_format("satm01,satm02,satm03,satm04,satm05,satm06,satm07,satm08,satm09,satm10,satm11,satm12,satm13,satm14,satm15,satm16,satm17,satm18,satm19,satm20,satm21,satm22,satm23,satm24,satm25",l_format)
   CALL cl_set_comp_format("satm26,satm27,satm28,satm29,satm30,satm31,satm32,satm33,satm34,satm35,satm36,satm37,satm38,satm39,satm40,satm41,satm42,satm43,satm44,satm45,satm46,satm47,satm48,satm49,satm50,batms,satms",l_format)   
   LET l_ac = 1
   CALL aglq832_hide_show_atm()
   CALL aglq832_fetch()
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL aglq832_create_temp_table()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq832_create_temp_table()
   DROP TABLE aglq832_tmp;
   CREATE TEMP TABLE aglq832_tmp (
   seq             SMALLINT,
   seq1            SMALLINT,
   glaacomp        VARCHAR(10),
   glfb002         VARCHAR(10),
   glfbl004        VARCHAR(500),
   nmai004         INTEGER,
   amt1            DECIMAL(20,6),
   amt2            DECIMAL(20,6)
   );
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq832_get_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq832_get_data()
DEFINE   l_sql     STRING
DEFINE   l_sql1    STRING
DEFINE   j         LIKE type_t.num10
DEFINE   l_glaacomp  LIKE glaa_t.glaacomp
DEFINE l_amt1               LIKE type_t.num20_6
DEFINE l_amt2               LIKE type_t.num20_6
DEFINE l_amt_s1             LIKE type_t.num20_6
DEFINE l_amt_s2             LIKE type_t.num20_6
DEFINE l_seq                LIKE type_t.num5
DEFINE l_nmak001            LIKE nmak_t.nmak001
DEFINE l_nmakl003           LIKE nmakl_t.nmakl003
DEFINE l_nmai002            LIKE nmai_t.nmai002
DEFINE l_nmail004           LIKE nmail_t.nmail004
DEFINE l_nmai004            LIKE nmai_t.nmai004
DEFINE l_glbd001            LIKE glbd_t.glbd001
DEFINE l_glbdl003           LIKE glbdl_t.glbdl003
DEFINE l_glbd003            LIKE glbd_t.glbd003
DEFINE l_glbe002            LIKE glbe_t.glbe002    
DEFINE l_glbe003            LIKE glbe_t.glbe003
DEFINE l_glbe004            LIKE glbe_t.glbe004
DEFINE l_glbg005            LIKE glbg_t.glbg005
DEFINE l_glac008            LIKE glac_t.glac008
DEFINE l_period             LIKE type_t.num5
DEFINE l_period_e           LIKE type_t.num5
DEFINE l_count              LIKE type_t.num5
DEFINE l_glbeld             LIKE glbe_t.glbeld
DEFINE l_period_e1          LIKE type_t.num5
DEFINE l_amt                LIKE type_t.num20_6
DEFINE l_sql2               STRING

   #刪除臨時表中資料
   DELETE FROM aglq832_tmp
   LET l_sql = " SELECT DISTINCT glaacomp FROM glaa_t ",
               "  WHERE glaaent = '",g_enterprise,"'",
               "    AND glaald IN ",l_sub_sql,
               " ORDER BY glaacomp "
               
   PREPARE aglq832_pr FROM l_sql
   DECLARE aglq832_cs CURSOR FOR aglq832_pr 
   
   CALL cl_err_collect_init()
   LET g_success = TRUE
   LET j = 1              
   FOREACH aglq832_cs INTO l_glaacomp  #法人
      LET l_sql1 =" SELECT DISTINCT glaald FROM glaa_t ",
                  "  WHERE glaaent = '",g_enterprise,"'",
                  "    AND glaacomp = '",l_glaacomp,"'",
                  "    AND glaald IN ",l_sub_sql      
      #直接法
      IF tm.type_a='Y' THEN
         LET g_sql="SELECT DISTINCT nmak001,nmakl003 ",
                   "  FROM nmak_t ",
                   "  LEFT JOIN nmakl_t ON nmakent=nmaklent AND nmakl001=nmak001 AND nmaklent='"||g_enterprise||"' AND nmakl002='"||g_dlang||"' ",
                   " WHERE nmakent=",g_enterprise," AND nmakstus='Y' ",
                   " ORDER BY nmak001"
                
         PREPARE aglq832_pr1 FROM g_sql
         DECLARE aglq832_cs1 CURSOR FOR aglq832_pr1 
         
         #現金變動碼分類下包含的現金變動碼的數量
         LET g_sql="SELECT COUNT(DISTINCT nmai002) ",
                   "  FROM nmai_t ",
                   " WHERE nmaient=",g_enterprise," AND nmaistus='Y' AND nmai003=? ",
         #          "   AND nmai001=(SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.glfa005,"' )"  
                   "   AND nmai001=(SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald IN (",l_sql1 ,"))"        
         PREPARE aglq832_count_pr FROM g_sql
         
         #抓取現金變動碼資料
         LET g_sql="SELECT DISTINCT nmai002,nmail004,nmai004 ",
                   "  FROM nmai_t ",
                   "  LEFT JOIN nmail_t ON nmaient=nmailent AND nmai001=nmail001 AND nmai002=nmail002 AND nmailent='"||g_enterprise||"' AND nmail003='"||g_dlang||"' ",
                   " WHERE nmaient=",g_enterprise," AND nmaistus='Y' AND nmai003=? ",
                 #  "   AND nmai001=(SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.glfa005,"' )",
                   "   AND nmai001=(SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald IN (",l_sql1 ,"))",  
                   " ORDER BY nmai002,nmai004"
                   
         PREPARE aglq832_pr2 FROM g_sql
         DECLARE aglq832_cs2 CURSOR FOR aglq832_pr2
         
         LET g_sql="SELECT SUM(CASE WHEN glbc003='1' THEN glbc009 ELSE (-1)*glbc009 END) ",
                   "  FROM glbc_t,glap_t ",   #150730-00007 1 add glap_t与glbc_t关联资料限定glapstus=S
                   " WHERE glbcent=glapent AND glbcld=glapld AND glbcdocno=glapdocno ", #150730-00007 1 add
                   "   AND glbcent=",g_enterprise," AND glbc010 = '1'",
                   #"   AND glbcld='",tm.glfa005,"'",
                   "   AND glbcld IN (",l_sql1,")",
                   "   AND glbc001=? AND glbc002 BETWEEN ? AND ? ",
                   "   AND glbc004=? "
#                   "   AND glapstus='S' "  #150730-00007 1 add #150827-00036#1 mark
         #150827-00036#1--add--str--
         #凭证状态
         CASE tm.stus
            WHEN '1' LET g_sql=g_sql," AND glapstus='S' "
            WHEN '2' LET g_sql=g_sql," AND glapstus IN ('S','Y') "
            WHEN '3' LET g_sql=g_sql," AND glapstus IN ('S','Y','N') "
         END CASE
         #含审计调整凭证否
         IF tm.show_ad='N' THEN
            LET g_sql=g_sql," AND glap007<>'AD' "
         END IF
         #150827-00036#1--add--end          
         PREPARE aglq832_pr3 FROM g_sql
      END IF
   
      #間接法
      IF tm.type_b='Y' THEN
         LET g_sql="SELECT DISTINCT glbd001,glbdl003,glbd003 ",
                   "  FROM glbe_t,glbd_t ",
                   "  LEFT JOIN glbdl_t ON glbdent=glbdlent AND glbd001=glbdl001 AND glbdlent='"||g_enterprise||"' AND glbdl002='"||g_dlang||"' ",
                   " WHERE glbdent=glbeent AND glbd001=glbe001 AND glbdstus='Y' ",
                   "   AND glbdent=",g_enterprise,
                   "   AND glbeld IN (",l_sql1,")",
                   " ORDER BY glbd001,glbd003 "
        
         PREPARE aglq832_pr4 FROM g_sql
         DECLARE aglq832_cs4 CURSOR FOR aglq832_pr4
         
#         LET g_sql="SELECT glbe002,glbe003,glbe004 ",
         LET g_sql="SELECT glbeld,glbe002,glbe003,glbe004 ",  #add by lixh 20150520
                   "  FROM glbe_t ",
                   " WHERE glbeent=",g_enterprise,
                   " AND glbeld IN (",l_sql1,")",
                   "   AND glbe001=? AND glbestus='Y' ",
                   " ORDER BY glbe002 "
                   
         PREPARE aglq832_pr5 FROM g_sql
         DECLARE aglq832_cs5 CURSOR FOR aglq832_pr5
         
         #借方-貸方
         LET g_sql=" SELECT SUM(glar005-glar006) FROM glar_t ",
                   "  WHERE glarent=",g_enterprise," AND glarld IN (",l_sql1,")",
                   "    AND glar001=?",
                   "    AND glar002=? AND glar003 BETWEEN ? AND ? "
         PREPARE aglq832_pr6 FROM g_sql
         
         #借方
         LET g_sql=" SELECT SUM(glar005) FROM glar_t ",
                   "  WHERE glarent=",g_enterprise," AND glarld IN (",l_sql1,")",
                   "    AND glar001=?",
                   "    AND glar002=? AND glar003 BETWEEN ? AND ? "
         PREPARE aglq832_pr7 FROM g_sql
         
         #貸方
         LET g_sql=" SELECT SUM(glar006) FROM glar_t ",
                   "  WHERE glarent=",g_enterprise," AND glarld IN (",l_sql1,")",
                   "    AND glar001=?",
                   "    AND glar002=? AND glar003 BETWEEN ? AND ? "
         PREPARE aglq832_pr8 FROM g_sql
         
         #人工輸入金額(agli220)
         LET g_sql="SELECT SUM(glbf007) FROM glbf_t ",
                   " WHERE glbfent=",g_enterprise," AND glbfld IN (",l_sql1,")",
                   "   AND glbf001=? AND glbf002 BETWEEN ? AND ? ",
                   "   AND glbf003=? AND glbf004=? "
         PREPARE aglq832_pr9 FROM g_sql
         
         #150827-00036#1--add--str--
         #抓取凭证状态为未审核或已审核的凭证金额（+）
         IF tm.stus <> '1' THEN
            CASE tm.stus
               WHEN '2' LET l_sql2=" AND glapstus ='Y' "
               WHEN '3' LET l_sql2=" AND glapstus IN ('Y','N') "
            END CASE
            #借方-貸方
            LET g_sql=" SELECT SUM(glaq003-glaq004) ",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                      "  WHERE glapent=",g_enterprise," AND glapld IN (",l_sql1,")",
                      "    AND glaq002=?",
                      "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                      l_sql2
            PREPARE aglq832_pr6_1 FROM g_sql
            
            #借方
            LET g_sql=" SELECT SUM(glaq003) ",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                      "  WHERE glapent=",g_enterprise," AND glapld IN (",l_sql1,")",
                      "    AND glaq002=?",
                      "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                      l_sql2
            PREPARE aglq832_pr7_1 FROM g_sql
            
            #貸方
            LET g_sql=" SELECT SUM(glaq004)",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                      "  WHERE glapent=",g_enterprise," AND glapld IN (",l_sql1,")",
                      "    AND glaq002=?",
                      "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                      l_sql2
            PREPARE aglq832_pr8_1 FROM g_sql
         END IF
         #扣减AD审计调整凭证金额(-)
         IF tm.show_ad='N' THEN
            CASE tm.stus
               WHEN '1' LET l_sql2=" AND glapstus ='S' "
               WHEN '2' LET l_sql2=" AND glapstus IN ('Y','S')  "
               WHEN '3' LET l_sql2=" AND glapstus IN ('N','Y','S') "
            END CASE
            #借方-貸方
            LET g_sql=" SELECT SUM(glaq003-glaq004) ",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                      "  WHERE glapent=",g_enterprise," AND glapld IN (",l_sql1,")",
                      "    AND glaq002=?",
                      "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                      "    AND glap007='AD' ",l_sql2
            PREPARE aglq832_pr6_2 FROM g_sql
            
            #借方
            LET g_sql=" SELECT SUM(glaq003) ",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                      "  WHERE glapent=",g_enterprise," AND glapld IN (",l_sql1,")",
                      "    AND glaq002=?",
                      "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                      "    AND glap007='AD' ",l_sql2
            PREPARE aglq832_pr7_2 FROM g_sql
            
            #貸方
            LET g_sql=" SELECT SUM(glaq004)",
                      "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                      "  WHERE glapent=",g_enterprise," AND glapld IN (",l_sql1,")",
                      "    AND glaq002=?",
                      "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                      "    AND glap007='AD' ",l_sql2
            PREPARE aglq832_pr8_2 FROM g_sql
         END IF
         #150827-00036#1--add--end
      END IF
   
      #附註揭露
      IF tm.type_c='Y' THEN
         LET g_sql="SELECT DISTINCT glbg005 ",
                   "  FROM glbg_t ",
                   " WHERE glbgent=",g_enterprise," AND glbgld IN (",l_sql1,")",
                   "   AND glbg001='3' ",
                   "   AND ((glbg002=",tm.glfa010," AND glbg003 BETWEEN ",tm.glfa011," AND ",tm.glfa012,")",
                   "     OR (glbg002=",tm.glfa013," AND glbg003 BETWEEN ",tm.glfa014," AND ",tm.glfa015,") )"
                   
         PREPARE aglq832_pr10 FROM g_sql
         DECLARE aglq832_cs10 CURSOR FOR aglq832_pr10
         
         LET g_sql="SELECT SUM(glbg006) ",
                   "  FROM glbg_t ",
                   " WHERE glbgent=",g_enterprise," AND glbgld IN (",l_sql1,")",
                   "   AND glbg001='3' ",
                   "   AND glbg002=? AND glbg003 BETWEEN ? AND ? ",
                   "   AND glbg005=? "
                   
        PREPARE aglq832_pr11 FROM g_sql
      END IF
   
      
      LET l_seq=0
   
      #直接法
      IF tm.type_a='Y' THEN
         FOREACH aglq832_cs1 INTO l_nmak001,l_nmakl003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'FOREACH aglq832_cs1'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            #判斷該現金變動碼分類下是否包含現金變動碼
            LET l_count=0
            EXECUTE aglq832_count_pr USING l_nmak001 INTO l_count
            IF l_count=0 THEN
               CONTINUE FOREACH
            END IF
            
            LET l_seq=l_seq+1
            INSERT INTO aglq832_tmp(seq,seq1,glaacomp,glfb002,glfbl004,nmai004,amt1,amt2)
                             VALUES(l_seq,j,l_glaacomp,l_nmak001,l_nmakl003,'','','')
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins aglq832_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
            END IF 
            
            FOREACH aglq832_cs2 USING l_nmak001 INTO l_nmai002,l_nmail004,l_nmai004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'FOREACH aglq832_cs2'
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_success = FALSE
                  EXIT FOREACH
               END IF
               LET l_seq=l_seq+1
               #本期數
               EXECUTE aglq832_pr3 USING tm.glfa010,tm.glfa011,tm.glfa012,l_nmai002 INTO l_amt1
               #上期數
               EXECUTE aglq832_pr3 USING tm.glfa013,tm.glfa014,tm.glfa015,l_nmai002 INTO l_amt2
               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
               
               CASE tm.glfa008
                  WHEN '2'  #千
                     LET l_amt1 = l_amt1 / 1000
                     LET l_amt2 = l_amt2 / 1000
                  WHEN '3'  #萬
                     LET l_amt1 = l_amt1 / 10000
                     LET l_amt2 = l_amt2 / 10000
               END CASE
               
               #150827-00036#1--add--str--
               #是否進行幣別轉換
               IF tm.chg_curr='Y'  THEN
                  LET l_amt1 = l_amt1 * tm.rate
                  LET l_amt2 = l_amt2 * tm.rate
               END IF
               #150827-00036#1--add--end
               
               #小數取位
               CALL s_num_round('1',l_amt1,tm.glfa009) RETURNING l_amt1
               CALL s_num_round('1',l_amt2,tm.glfa009) RETURNING l_amt2
               
               INSERT INTO aglq832_tmp(seq,seq1,glaacomp,glfb002,glfbl004,nmai004,amt1,amt2)
                                VALUES(l_seq,j,l_glaacomp,l_nmai002,l_nmail004,l_nmai004,l_amt1,l_amt2)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins aglq832_tmp'
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_success = FALSE
               END IF
            END FOREACH
         END FOREACH
      END IF
   
      #間接法
      IF tm.type_b='Y' THEN
         FOREACH aglq832_cs4 INTO l_glbd001,l_glbdl003,l_glbd003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'FOREACH aglq832_cs4'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            LET l_seq=l_seq+1
            LET l_amt1=0
            LET l_amt2=0
            
            FOREACH aglq832_cs5 USING l_glbd001 INTO l_glbeld,l_glbe002,l_glbe003,l_glbe004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'FOREACH aglq832_cs5'
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_success = FALSE
                  EXIT FOREACH
               END IF
               
               CASE
                  WHEN l_glbe004='1' #異動
                     #本期數
                     EXECUTE aglq832_pr6 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt_s1
                     #上期數
                     EXECUTE aglq832_pr6 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt_s2 
                     IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                     IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                     
                     #150827-00036#1--add--str--
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq832_pr6_1 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 + l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr6_1 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 + l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq832_pr6_2 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 - l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr6_2 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 - l_amt
                     END IF
                     #150827-00036#1--add--end
                  
                  WHEN l_glbe004='2' #期初
                     LET l_period=0
                     #本期數
                     LET l_period_e=tm.glfa012-1
                     EXECUTE aglq832_pr6 USING l_glbe002,tm.glfa010,l_period,l_period_e INTO l_amt_s1
                     #上期數
                     LET l_period_e1=tm.glfa015-1
                     EXECUTE aglq832_pr6 USING l_glbe002,tm.glfa013,l_period,l_period_e1 INTO l_amt_s2
                     IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                     IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                    
                     #150827-00036#1--add--str--
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq832_pr6_1 USING l_glbe002,tm.glfa010,l_period,l_period_e INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 + l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr6_1 USING l_glbe002,tm.glfa013,l_period,l_period_e1 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 + l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq832_pr6_2 USING l_glbe002,tm.glfa010,l_period,l_period_e INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 - l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr6_2 USING l_glbe002,tm.glfa013,l_period,l_period_e1 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 - l_amt
                     END IF
                     #150827-00036#1--add--end
                     
                  WHEN l_glbe004='3' #期末
                     LET l_period=0
                     #本期數
                     EXECUTE aglq832_pr6 USING l_glbe002,tm.glfa010,l_period,tm.glfa012 INTO l_amt_s1
                     #上期數
                     EXECUTE aglq832_pr6 USING l_glbe002,tm.glfa013,l_period,tm.glfa015 INTO l_amt_s2 
                     IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                     IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                     
                     #150827-00036#1--add--str--
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq832_pr6_1 USING l_glbe002,tm.glfa010,l_period,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 + l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr6_1 USING l_glbe002,tm.glfa013,l_period,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 + l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq832_pr6_2 USING l_glbe002,tm.glfa010,l_period,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 - l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr6_2 USING l_glbe002,tm.glfa013,l_period,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 - l_amt
                     END IF
                     #150827-00036#1--add--end
                     
                  WHEN l_glbe004='4' #人工輸入
                     #本期數
                     EXECUTE aglq832_pr9 USING tm.glfa010,tm.glfa011,tm.glfa012,l_glbd001,l_glbe002 INTO l_amt_s1
                     #上期數
                     EXECUTE aglq832_pr9 USING tm.glfa013,tm.glfa014,tm.glfa015,l_glbd001,l_glbe002 INTO l_amt_s2
                     
                  WHEN l_glbe004='5' #借方異動
                     #本期數
                     EXECUTE aglq832_pr7 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt_s1
                     #上期數
                     EXECUTE aglq832_pr7 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt_s2 
                     IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                     IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                     
                     #150827-00036#1--add--str--
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq832_pr7_1 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 + l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr7_1 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 + l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq832_pr7_2 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 - l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr7_2 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 - l_amt
                     END IF
                     #150827-00036#1--add--end
                     
                  WHEN l_glbe004='6' #貸方異動
                     #本期數
                     EXECUTE aglq832_pr8 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt_s1
                     #上期數
                     EXECUTE aglq832_pr8 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt_s2 
                     IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                     IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                     
                     #150827-00036#1--add--str--
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq832_pr8_1 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 + l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr8_1 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 + l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq832_pr8_2 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s1 = l_amt_s1 - l_amt
                        
                        #上期數
                        EXECUTE aglq832_pr8_2 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF
                        LET l_amt_s2 = l_amt_s2 - l_amt
                     END IF
                     #150827-00036#1--add--end
               END CASE
               
               IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
               IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
               IF l_glbe004='1' OR l_glbe004='2' OR l_glbe004='3' THEN
                  #該科目正常餘額形態
                  SELECT glac008 INTO l_glac008 FROM glac_t
                   WHERE glacent=g_enterprise 
                  #   AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005)
                     AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=l_glbeld)     #add by lixh 20150520
                     AND glac002=l_glbe002  
                  IF l_glac008='2' THEN #餘額在貸方
                     LET l_amt_s1=(-1)*l_amt_s1
                     LET l_amt_s2=(-1)*l_amt_s2
                  END IF
               END IF
               IF l_glbe003='+' THEN
                  LET l_amt1=l_amt1 + l_amt_s1
                  LET l_amt2=l_amt2 + l_amt_s2
               END IF
               IF l_glbe003='-' THEN
                  LET l_amt1=l_amt1 - l_amt_s1
                  LET l_amt2=l_amt2 - l_amt_s2
               END IF            
            END FOREACH
            
            
            CASE tm.glfa008
               WHEN '2'  #千
                  LET l_amt1 = l_amt1 / 1000
                  LET l_amt2 = l_amt2 / 1000
               WHEN '3'  #萬
                  LET l_amt1 = l_amt1 / 10000
                  LET l_amt2 = l_amt2 / 10000
            END CASE
            
            #150827-00036#1--add--str--
            #是否進行幣別轉換
            IF tm.chg_curr='Y'  THEN
               LET l_amt1 = l_amt1 * tm.rate
               LET l_amt2 = l_amt2 * tm.rate
            END IF
            #150827-00036#1--add--end
            
            #小數取位
            CALL s_num_round('1',l_amt1,tm.glfa009) RETURNING l_amt1
            CALL s_num_round('1',l_amt2,tm.glfa009) RETURNING l_amt2
            
            INSERT INTO aglq832_tmp(seq,seq1,glaacomp,glfb002,glfbl004,nmai004,amt1,amt2)
                             VALUES(l_seq,j,l_glaacomp,l_glbd001,l_glbdl003,l_glbd003,l_amt1,l_amt2)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins aglq832_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
            END IF
         END FOREACH 
      END IF
   
      #附註揭露
      IF tm.type_c='Y' THEN
         FOREACH aglq832_cs10 INTO l_glbg005
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'FOREACH aglq832_cs10'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            LET l_seq=l_seq+1
            #本期數
            EXECUTE aglq832_pr11 USING tm.glfa010,tm.glfa011,tm.glfa012,l_glbg005 INTO l_amt1
            #上期數
            EXECUTE aglq832_pr11 USING tm.glfa013,tm.glfa014,tm.glfa015,l_glbg005 INTO l_amt2
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            
            CASE tm.glfa008
               WHEN '2'  #千
                  LET l_amt1 = l_amt1 / 1000
                  LET l_amt2 = l_amt2 / 1000
               WHEN '3'  #萬
                  LET l_amt1 = l_amt1 / 10000
                  LET l_amt2 = l_amt2 / 10000
            END CASE
            
            #150827-00036#1--add--str--
            #是否進行幣別轉換
            IF tm.chg_curr='Y'  THEN
               LET l_amt1 = l_amt1 * tm.rate
               LET l_amt2 = l_amt2 * tm.rate
            END IF
            #150827-00036#1--add--end
            
            #小數取位
            CALL s_num_round('1',l_amt1,tm.glfa009) RETURNING l_amt1
            CALL s_num_round('1',l_amt2,tm.glfa009) RETURNING l_amt2
            
            INSERT INTO aglq832_tmp(seq,seq1,glaacomp,glfb002,glfbl004,nmai004,amt1,amt2)
                             VALUES(l_seq,j,l_glaacomp,'',l_glbg005,'',l_amt1,l_amt2)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins aglq832_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
            END IF
         END FOREACH
      END IF           
      LET j = j + 1          
   END FOREACH  
   IF g_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq832_tmp
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq832_row_desc(p_ac,p_seq,p_seq1)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq832_row_desc(p_ac,p_seq,p_seq1)
DEFINE  p_ac      LIKE type_t.num10
DEFINE  p_seq     LIKE type_t.num10
DEFINE  p_seq1    LIKE type_t.num10

   IF p_ac = 0 OR p_seq = 0 THEN
      RETURN
   END IF
   
   IF p_seq1 = 2 THEN
      LET g_glfb_d[p_seq].batm02 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm02 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm02
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm02
   END IF
   
   IF p_seq1 = 3 THEN
      LET g_glfb_d[p_seq].batm03 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm03 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520      
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm03
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm03
   END IF

   IF p_seq1 = 4 THEN
      LET g_glfb_d[p_seq].batm04 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm04 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm04
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm04      
   END IF
   
   IF p_seq1 = 5 THEN
      LET g_glfb_d[p_seq].batm05 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm05 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm05
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm05        
   END IF 

   IF p_seq1 = 6 THEN
      LET g_glfb_d[p_seq].batm06 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm06 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm06
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm06         
   END IF
   
   IF p_seq1 = 7 THEN
      LET g_glfb_d[p_seq].batm07 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm07 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm07
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm07        
   END IF

   IF p_seq1 = 8 THEN
      LET g_glfb_d[p_seq].batm08 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm08 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm08
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm08        
   END IF
   
   IF p_seq1 = 9 THEN
      LET g_glfb_d[p_seq].batm09 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm09 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm09
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm09         
   END IF

   IF p_seq1 = 10 THEN
      LET g_glfb_d[p_seq].batm10 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm10 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm10
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm10        
   END IF
   
   IF p_seq1 = 11 THEN
      LET g_glfb_d[p_seq].batm11 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm11 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm11
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm11       
   END IF  
   
   IF p_seq1 = 12 THEN
      LET g_glfb_d[p_seq].batm12 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm12 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm12
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm12       
   END IF   
   
   IF p_seq1 = 13 THEN
      LET g_glfb_d[p_seq].batm13 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm13 = g_glfb_d[p_ac].satm01 
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520        
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm13
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm13       
   END IF

   IF p_seq1 = 14 THEN
      LET g_glfb_d[p_seq].batm14 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm14 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm14
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm14 
   END IF
   
   IF p_seq1 = 15 THEN
      LET g_glfb_d[p_seq].batm15 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm15 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm15
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm15  
   END IF

   IF p_seq1 = 16 THEN
      LET g_glfb_d[p_seq].batm16 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm16 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm16
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm16 
   END IF
   
   IF p_seq1 = 17 THEN
      LET g_glfb_d[p_seq].batm17 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm17 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm17
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm17 
   END IF

   IF p_seq1 = 18 THEN
      LET g_glfb_d[p_seq].batm18 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm18 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm18
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm18  
   END IF
   
   IF p_seq1 = 19 THEN
      LET g_glfb_d[p_seq].batm19 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm19 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm19
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm19 
   END IF

   IF p_seq1 = 20 THEN
      LET g_glfb_d[p_seq].batm20 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm20 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm20
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm20  
   END IF
   
   IF p_seq1 = 21 THEN
      LET g_glfb_d[p_seq].batm21 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm21 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm21
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm21 
      
   END IF

   IF p_seq1 = 22 THEN
      LET g_glfb_d[p_seq].batm22 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm22 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm22
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm22      
   END IF
  
   IF p_seq1 = 23 THEN
      LET g_glfb_d[p_seq].batm23 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm23 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm23
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm23
   END IF
   IF p_seq1 = 24 THEN
      LET g_glfb_d[p_seq].batm24 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm24 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm24
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm24
   END IF
   IF p_seq1 = 25 THEN
      LET g_glfb_d[p_seq].batm25 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm25 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm25
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm25
   END IF
   IF p_seq1 = 26 THEN
      LET g_glfb_d[p_seq].batm26 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm26 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm26
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm26
   END IF
   IF p_seq1 = 27 THEN
      LET g_glfb_d[p_seq].batm27 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm27 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm27
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm27
   END IF
   IF p_seq1 = 28 THEN
      LET g_glfb_d[p_seq].batm28 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm28 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm28
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm28
   END IF
   IF p_seq1 = 29 THEN
      LET g_glfb_d[p_seq].batm29 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm29 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm29
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm29
   END IF
   IF p_seq1 = 30 THEN
      LET g_glfb_d[p_seq].batm30 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm30 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm30
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm30
   END IF   
   IF p_seq1 = 31 THEN
      LET g_glfb_d[p_seq].batm31 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm31 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm31
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm31
   END IF
   IF p_seq1 = 32 THEN
      LET g_glfb_d[p_seq].batm32 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm32 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm32
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm32
   END IF
   IF p_seq1 = 33 THEN
      LET g_glfb_d[p_seq].batm33 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm33 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm33
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm33
   END IF
   IF p_seq1 = 34 THEN
      LET g_glfb_d[p_seq].batm34 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm34 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm34
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm34
   END IF
   IF p_seq1 = 35 THEN
      LET g_glfb_d[p_seq].batm35 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm35 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm35
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm35
   END IF
   IF p_seq1 = 36 THEN
      LET g_glfb_d[p_seq].batm36 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm36 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm36
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm36
   END IF
   IF p_seq1 = 37 THEN
      LET g_glfb_d[p_seq].batm37 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm37 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm37
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm37
   END IF
   IF p_seq1 = 38 THEN
      LET g_glfb_d[p_seq].batm38 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm38 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm38
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm38
   END IF
   IF p_seq1 = 39 THEN
      LET g_glfb_d[p_seq].batm39 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm39 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm39
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm39
   END IF
   IF p_seq1 = 40 THEN
      LET g_glfb_d[p_seq].batm40 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm40 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm40
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm40
   END IF 
   IF p_seq1 = 41 THEN
      LET g_glfb_d[p_seq].batm41 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm41 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm41
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm41
   END IF
   IF p_seq1 = 42 THEN
      LET g_glfb_d[p_seq].batm42 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm42 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm42
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm42
   END IF
   IF p_seq1 = 43 THEN
      LET g_glfb_d[p_seq].batm43 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm43 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm43
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm43
   END IF
   IF p_seq1 = 44 THEN
      LET g_glfb_d[p_seq].batm44 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm44 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm44
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm44
   END IF
   IF p_seq1 = 45 THEN
      LET g_glfb_d[p_seq].batm45 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm45 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm45
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm45
   END IF
   IF p_seq1 = 46 THEN
      LET g_glfb_d[p_seq].batm46 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm46 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm46
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm46
   END IF
   IF p_seq1 = 47 THEN
      LET g_glfb_d[p_seq].batm47 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm47 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm47
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm47
   END IF
   IF p_seq1 = 48 THEN
      LET g_glfb_d[p_seq].batm48 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm48 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm48
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm48
   END IF
   IF p_seq1 = 49THEN
      LET g_glfb_d[p_seq].batm49 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm49 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm49
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm49
   END IF
   IF p_seq1 = 50 THEN
      LET g_glfb_d[p_seq].batm50 = g_glfb_d[p_ac].batm01
      LET g_glfb_d[p_seq].satm50 = g_glfb_d[p_ac].satm01
      #add by lixh 20150520
      IF cl_null(g_glfb_d[p_seq].batms) THEN
         LET g_glfb_d[p_seq].batms = 0
      END IF
      IF cl_null(g_glfb_d[p_seq].satms) THEN
         LET g_glfb_d[p_seq].satms = 0
      END IF
      #add by lixh 20150520  
      LET g_glfb_d[p_seq].batms = g_glfb_d[p_seq].batms + g_glfb_d[p_seq].batm50
      LET g_glfb_d[p_seq].satms = g_glfb_d[p_seq].satms + g_glfb_d[p_seq].satm50
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 栏位的显示和隐藏
# Memo...........:
# Usage..........: CALL aglq832_hide_show_atm()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq832_hide_show_atm()
DEFINE lc_index        LIKE type_t.chr2
DEFINE li_i            LIKE type_t.num5
DEFINE li_j            LIKE type_t.num5
DEFINE l_msg           LIKE type_t.chr80
DEFINE l_seq1          LIKE type_t.num10
DEFINE l_glaacomp      LIKE glaa_t.glaacomp
DEFINE ls_show         STRING
DEFINE ls_hide         STRING
DEFINE l_field         STRING
DEFINE l_sql           STRING
DEFINE l_str           STRING

   LET ls_show = ' '
   LET ls_hide = ' ' 
   LET l_field = ''  
   LET l_sql = " SELECT DISTINCT seq1,glaacomp FROM aglq832_tmp WHERE 1=1  ORDER BY seq1"
   PREPARE aglq832_glaa_cur FROM l_sql
   DECLARE aglq832_glaa_cnt CURSOR FOR aglq832_glaa_cur
   LET li_i = 1
   FOREACH aglq832_glaa_cnt INTO l_seq1,l_glaacomp     
      LET lc_index = li_i USING '&&' 
      IF li_i = 1 THEN      
         LET ls_show = ls_show || "batm" || lc_index || ",satm" || lc_index 
      ELSE
         LET ls_show = ls_show || ",batm" || lc_index || ",satm" || lc_index 
      END IF   
      LET ls_show = ls_show.trim()   #160615-00009#1  --- add      
      LET l_msg = '' 
      LET l_str = ''
      CALL cl_getmsg('agl-00342',g_lang) RETURNING l_msg 
      CALL s_desc_get_department_desc(l_glaacomp) RETURNING l_str
      LET l_msg = l_str CLIPPED,l_msg   
      LET l_field = 'batm' CLIPPED,lc_index CLIPPED     
      LET l_field = l_field.trim()
      CALL cl_set_comp_att_text(l_field,l_msg)
      LET l_msg = '' 
      LET l_str = ''
      CALL cl_getmsg('agl-00343',g_lang) RETURNING l_msg 
      CALL s_desc_get_department_desc(l_glaacomp) RETURNING l_str
      LET l_msg = l_str CLIPPED,l_msg   
      LET l_field = 'satm' CLIPPED,lc_index CLIPPED     
      LET l_field = l_field.trim()
      CALL cl_set_comp_att_text(l_field,l_msg)      
      LET li_i = li_i + 1      
   END FOREACH  
   CALL cl_set_comp_visible(ls_show,TRUE)  

   FOR li_j = li_i TO 50    #欄位的隐藏     
      LET lc_index = li_j USING '&&' 
      IF li_j = li_i THEN      
         LET ls_hide = ls_hide || "batm" || lc_index || ",satm" || lc_index 
      ELSE
         LET ls_hide = ls_hide || ",batm" || lc_index || ",satm" || lc_index 
      END IF    
   END FOR  
   CALL cl_set_comp_visible(ls_hide,FALSE)
END FUNCTION

 
{</section>}
 
