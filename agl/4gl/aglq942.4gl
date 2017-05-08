#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq942.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-07-01 11:09:38), PR版次:0004(2017-02-15 18:26:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aglq942
#+ Description: 合併現金流量表查詢作業
#+ Creator....: 06821(2016-05-18 09:34:51)
#+ Modifier...: 06821 -SD/PR- 08734
 
{</section>}
 
{<section id="aglq942.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160517-00002#12 160608  BY 06821  查詢加上GR報表
#151207-00020#19 160701  BY 06821  增加直接法功能
#170207-00018#1  170209  By 08734  ROWNUM整批调整
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
PRIVATE TYPE type_g_gleb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       l_glei003 LIKE type_t.chr500, 
   l_glei004 LIKE type_t.num10, 
   l_amt LIKE type_t.num20_6, 
   l_amt_1 LIKE type_t.num20_6, 
   gleb007 LIKE gleb_t.gleb007 
       END RECORD
PRIVATE TYPE type_g_gleb2_d RECORD
       l_glei003_1 LIKE type_t.chr500, 
   l_glei004_1 LIKE type_t.num10, 
   l_amt2 LIKE type_t.num20_6, 
   l_amt2_1 LIKE type_t.num20_6, 
   gleb026 LIKE gleb_t.gleb026
       END RECORD
 
PRIVATE TYPE type_g_gleb3_d RECORD
       l_glei003_2 LIKE type_t.chr500, 
   l_glei004_2 LIKE type_t.num10, 
   l_amt3 LIKE type_t.num20_6, 
   l_amt3_1 LIKE type_t.num20_6, 
   gleb029 LIKE gleb_t.gleb029
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa003          LIKE glaa_t.glaa003  #會計週期參照表
DEFINE g_glaa004          LIKE glaa_t.glaa004  #會計科目參照表
DEFINE g_glaa138          LIKE glaa_t.glaa138  #合併編制期別
DEFINE g_glaa135          LIKE glaa_t.glaa135  #群組參照表號
DEFINE g_glaa005          LIKE glaa_t.glaa135  #現金變動參照表號    #151207-00020#19 add
DEFINE g_gleb004_s        LIKE gleb_t.gleb004  #季別/半年別轉為期別
DEFINE g_gleb004_e        LIKE gleb_t.gleb004  #季別/半年別轉為期別
DEFINE g_unit             LIKE type_t.num10    #金額單位基數
DEFINE g_input            RECORD               #單頭
          b_glebld        LIKE gleb_t.glebld,
          glebld_desc     LIKE glaal_t.glaal002,
          b_gleb001       LIKE gleb_t.gleb001,
          gleb001_desc    LIKE type_t.chr500,
          b_gleb003       LIKE gleb_t.gleb003,
          b_gleb003_1     LIKE gleb_t.gleb003,
          b_gleb004       LIKE gleb_t.gleb004,
          b_gleb004_1     LIKE gleb_t.gleb004,
          l_s1            LIKE type_t.chr500, 
          l_s1_1          LIKE type_t.chr500, 
          l_hy1           LIKE type_t.chr500, 
          l_hy1_1         LIKE type_t.chr500, 
          b_gleb0041_1    LIKE gleb_t.gleb004,
          b_gleb0041_2    LIKE gleb_t.gleb004,
          l_s11           LIKE type_t.chr500, 
          l_s11_1         LIKE type_t.chr500, 
          l_hy11          LIKE type_t.chr500, 
          l_hy11_1        LIKE type_t.chr500, 
          l_rep_rule      LIKE type_t.chr1, 
          l_curr          LIKE type_t.chr1, 
          l_d             LIKE type_t.chr500, 
          l_s             LIKE type_t.chr1, 
          l_dol           LIKE type_t.chr1 
                          END RECORD
DEFINE g_glab005bs        LIKE glab_t.glab005                         
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_gleb_d
DEFINE g_master_t                   type_g_gleb_d
DEFINE g_gleb_d          DYNAMIC ARRAY OF type_g_gleb_d
DEFINE g_gleb_d_t        type_g_gleb_d
DEFINE g_gleb2_d   DYNAMIC ARRAY OF type_g_gleb2_d
DEFINE g_gleb2_d_t type_g_gleb2_d
 
DEFINE g_gleb3_d   DYNAMIC ARRAY OF type_g_gleb3_d
DEFINE g_gleb3_d_t type_g_gleb3_d
 
 
      
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
 
{<section id="aglq942.main" >}
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
   CALL aglq942_create_tmp()
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
   DECLARE aglq942_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq942_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq942_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq942 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq942_init()   
 
      #進入選單 Menu (="N")
      CALL aglq942_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq942
      
   END IF 
   
   CLOSE aglq942_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq942_tmp
   DROP TABLE aglq942_g01_tmp  #160517-00002#12 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq942.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq942_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('l_curr','9896')
   CALL cl_set_combo_scc('l_dol','8705')
   CALL aglq942_default()
   #end add-point
 
   CALL aglq942_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq942.default_search" >}
PRIVATE FUNCTION aglq942_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glebld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " gleb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " gleb002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " gleb003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " gleb004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " gleb005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " gleb006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " gleb032 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " gleb033 = '", g_argv[09], "' AND "
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
 
{<section id="aglq942.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq942_ui_dialog()
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
      CALL aglq942_b_fill()
   ELSE
      CALL aglq942_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gleb_d.clear()
         CALL g_gleb2_d.clear()
 
         CALL g_gleb3_d.clear()
 
 
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
 
         CALL aglq942_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gleb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq942_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq942_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
 
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_gleb2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_gleb2_d.getLength() TO FORMONLY.h_count
               CALL aglq942_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_gleb3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_gleb3_d.getLength() TO FORMONLY.h_count
               CALL aglq942_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq942_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #160517-00002#12 --s add 
               CALL aglq942_print() 
               #傳入             tmp/             合併帳套/         本期年度/         上期年度/             起始期別/   截止期別/    小數位數/    單位
               CALL aglq942_g01("aglq942_g01_tmp",g_input.b_glebld,g_input.b_gleb003,g_input.b_gleb003_1,g_gleb004_s,g_gleb004_e,g_input.l_d,g_input.l_dol)
               #160517-00002#12 --e add 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #160517-00002#12 --s add 
               CALL aglq942_print() 
               #傳入             tmp/             合併帳套/         本期年度/         上期年度/             起始期別/   截止期別/    小數位數/    單位
               CALL aglq942_g01("aglq942_g01_tmp",g_input.b_glebld,g_input.b_gleb003,g_input.b_gleb003_1,g_gleb004_s,g_gleb004_e,g_input.l_d,g_input.l_dol)
               #160517-00002#12 --e add 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq942_query()
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
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq942_filter()
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
            CALL aglq942_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gleb_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_gleb2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_gleb3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
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
            CALL aglq942_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq942_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq942_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq942_b_fill()
 
         
         
 
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
 
{<section id="aglq942.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq942_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_pdate_s   LIKE glav_t.glav004   
   DEFINE l_pdate_e   LIKE glav_t.glav004   
   DEFINE l_flag      LIKE type_t.chr1
   DEFINE l_errno     LIKE type_t.chr100
   DEFINE l_glav002   LIKE glav_t.glav002  
   DEFINE l_glav005   LIKE glav_t.glav005  
   DEFINE l_sdate_s   LIKE glav_t.glav004
   DEFINE l_sdate_e   LIKE glav_t.glav004
   DEFINE l_glav006   LIKE glav_t.glav006
   DEFINE l_glav007   LIKE glav_t.glav007
   DEFINE l_wdate_s   LIKE glav_t.glav004
   DEFINE l_wdate_e   LIKE glav_t.glav004 
   DEFINE l_argv_s    LIKE gleb_t.gleb004   #編制合併期別抓取條件
   DEFINE l_argv_e    LIKE gleb_t.gleb004   #編制合併期別抓取條件
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gleb_d.clear()
   CALL g_gleb2_d.clear()
 
   CALL g_gleb3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON gleb007,gleb026,gleb029
           FROM s_detail1[1].b_gleb007,s_detail2[1].b_gleb026,s_detail3[1].b_gleb029
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<l_glei003>>----
         #----<<l_glei004>>----
         #----<<l_amt>>----
         #----<<l_amt_1>>----
         #----<<b_gleb007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gleb007
            #add-point:BEFORE FIELD b_gleb007 name="construct.b.page1.b_gleb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gleb007
            
            #add-point:AFTER FIELD b_gleb007 name="construct.a.page1.b_gleb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gleb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gleb007
            #add-point:ON ACTION controlp INFIELD b_gleb007 name="construct.c.page1.b_gleb007"
            
            #END add-point
 
 
         #----<<l_glei003_1>>----
         #----<<l_glei004_1>>----
         #----<<l_amt2>>----
         #----<<l_amt2_1>>----
         #----<<b_gleb026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gleb026
            #add-point:BEFORE FIELD b_gleb026 name="construct.b.page2.b_gleb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gleb026
            
            #add-point:AFTER FIELD b_gleb026 name="construct.a.page2.b_gleb026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gleb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gleb026
            #add-point:ON ACTION controlp INFIELD b_gleb026 name="construct.c.page2.b_gleb026"
            
            #END add-point
 
 
         #----<<l_glei003_2>>----
         #----<<l_glei004_2>>----
         #----<<l_amt3>>----
         #----<<l_amt3_1>>----
         #----<<b_gleb029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gleb029
            #add-point:BEFORE FIELD b_gleb029 name="construct.b.page3.b_gleb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gleb029
            
            #add-point:AFTER FIELD b_gleb029 name="construct.a.page3.b_gleb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_gleb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gleb029
            #add-point:ON ACTION controlp INFIELD b_gleb029 name="construct.c.page3.b_gleb029"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.b_glebld,g_input.b_gleb001,g_input.b_gleb003,g_input.b_gleb003_1,g_input.b_gleb004,
                    g_input.b_gleb004_1,g_input.l_s1,g_input.l_s1_1,g_input.l_hy1,g_input.l_hy1_1,
                    g_input.b_gleb0041_1,g_input.b_gleb0041_2,g_input.l_s11,g_input.l_s11_1,g_input.l_hy11,
                    g_input.l_hy11_1,g_input.l_rep_rule,g_input.l_curr,g_input.l_d,g_input.l_s,
                    g_input.l_dol
                    
         ATTRIBUTE(WITHOUT DEFAULTS) 

         BEFORE INPUT
            CALL aglq942_default()
                                    
         AFTER FIELD b_glebld
            #合併帳別
            LET g_input.glebld_desc = ' '
            DISPLAY BY NAME g_input.glebld_desc
            IF NOT cl_null(g_input.b_glebld) THEN
               CALL s_merge_ld_with_comp_chk(g_input.b_glebld,g_input.b_gleb001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.b_glebld = ''
                  LET g_input.glebld_desc = ''
                  DISPLAY BY NAME g_input.b_glebld,g_input.glebld_desc    
                  NEXT FIELD CURRENT
               END IF             
            END IF
            CALL s_desc_get_ld_desc(g_input.b_glebld) RETURNING g_input.glebld_desc
            DISPLAY BY NAME g_input.b_glebld,g_input.glebld_desc   

            #會計周期參照表
            #SELECT glaa003,glaa138,glaa135,glaa004 INTO g_glaa003,g_glaa138,g_glaa135,g_glaa004 FROM glaa_t                   #151207-00020#19 mark
            SELECT glaa003,glaa138,glaa135,glaa004,glaa005 INTO g_glaa003,g_glaa138,g_glaa135,g_glaa004,g_glaa005 FROM glaa_t  #151207-00020#19 add
             WHERE glaaent = g_enterprise AND glaald = g_input.b_glebld
            
            #依合併報表編制期別,欄位輸入控卡
            CALL aglq942_set_entry()
            #多本位幣,僅可選擇已啟用之多位幣
            CALL aglq942_curr_scc() 
            
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(g_glaa003,g_today,'','')
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
                      
            LET g_input.b_gleb003 = l_glav002   #會計年度
            LET g_input.b_gleb003_1 = g_input.b_gleb003-1
            DISPLAY BY NAME g_input.b_gleb003,g_input.b_gleb003_1 


         AFTER FIELD b_gleb001
            #上層公司
            LET g_input.gleb001_desc = ' '
            DISPLAY BY NAME g_input.gleb001_desc
            IF NOT cl_null(g_input.b_gleb001) THEN
               CALL s_merge_ld_with_comp_chk(g_input.b_glebld,g_input.b_gleb001,g_user,1)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.b_gleb001 = ''
                  LET g_input.gleb001_desc = ''
                  DISPLAY BY NAME g_input.b_gleb001,g_input.gleb001_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_input.gleb001_desc = s_desc_glda001_desc(g_input.b_gleb001)
            DISPLAY BY NAME g_input.b_gleb001,g_input.gleb001_desc

         AFTER FIELD b_gleb003
            IF NOT cl_null(g_input.b_gleb003) THEN
               LET g_input.b_gleb003_1 = g_input.b_gleb003-1
            END IF
            DISPLAY BY NAME g_input.b_gleb003_1
         
         AFTER FIELD b_gleb003_1 #不可修改
         
         AFTER FIELD b_gleb004
            IF NOT cl_null(g_input.b_gleb004_1) THEN
               IF g_input.b_gleb004 > g_input.b_gleb004_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00227'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.b_gleb004 = g_input.b_gleb004_1
                  LET g_input.b_gleb0041_1 = g_input.b_gleb004
                  DISPLAY BY NAME g_input.b_gleb0041_1,g_input.b_gleb004
                  NEXT FIELD CURRENT 
               END IF
            END IF
            LET g_input.b_gleb0041_1 = g_input.b_gleb004
            DISPLAY BY NAME g_input.b_gleb0041_1,g_input.b_gleb004
         
         AFTER FIELD b_gleb004_1
            IF NOT cl_null(g_input.b_gleb004) THEN
               IF g_input.b_gleb004_1 < g_input.b_gleb004  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00228'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.b_gleb004_1 = g_input.b_gleb004
                  LET g_input.b_gleb0041_2 = g_input.b_gleb004_1
                  DISPLAY BY NAME g_input.b_gleb0041_2,g_input.b_gleb004_1
                  NEXT FIELD CURRENT 
               END IF
            END IF
            LET g_input.b_gleb0041_2 = g_input.b_gleb004_1
            DISPLAY BY NAME g_input.b_gleb0041_2,g_input.b_gleb004_1
            
         
         ON CHANGE l_s1
            IF NOT cl_null(g_input.l_s1_1) THEN
               IF g_input.l_s1 > g_input.l_s1_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00065'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_s1 = g_input.l_s1_1
                  LET g_input.l_s11 = g_input.l_s1
                  DISPLAY BY NAME g_input.l_s1,g_input.l_s11
                  NEXT FIELD CURRENT 
               END IF
            END IF
            LET g_input.l_s11 = g_input.l_s1
            DISPLAY BY NAME g_input.l_s1,g_input.l_s11
            
         
         ON CHANGE l_s1_1
            IF NOT cl_null(g_input.l_s1) THEN
               IF g_input.l_s1_1 < g_input.l_s1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00065'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_s1_1 = g_input.l_s1
                  LET g_input.l_s11_1 = g_input.l_s1_1
                  DISPLAY BY NAME g_input.l_s11_1,g_input.l_s1_1
                  NEXT FIELD CURRENT 
               END IF
            END IF
            LET g_input.l_s11_1 = g_input.l_s1_1
            DISPLAY BY NAME g_input.l_s11_1,g_input.l_s1_1
         
         ON CHANGE l_hy1
            IF NOT cl_null(g_input.l_hy1_1) THEN
               IF g_input.l_hy1 > g_input.l_hy1_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00726'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_hy1 = g_input.l_hy1_1
                  LET g_input.l_hy11 = g_input.l_hy1
                  DISPLAY BY NAME g_input.l_hy11,g_input.l_hy1
                  NEXT FIELD CURRENT 
               END IF
            END IF
            
         
         ON CHANGE l_hy1_1
            IF NOT cl_null(g_input.l_hy1) THEN
               IF g_input.l_hy1_1 < g_input.l_hy1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00726'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_hy1_1 = g_input.l_hy1
                  LET g_input.l_hy11_1 = g_input.l_hy1_1
                  DISPLAY BY NAME g_input.l_hy11_1,g_input.l_hy1_1
                  NEXT FIELD CURRENT 
               END IF
            END IF
         
         AFTER FIELD b_gleb0041_1 #上期期別不可修改
         
         AFTER FIELD b_gleb0041_2 #上期期別不可修改

         AFTER FIELD l_s11        #上期季別不可修改

         AFTER FIELD l_s11_1      #上期季別不可修改

         AFTER FIELD l_hy11       #上期半年不可修改

         AFTER FIELD l_hy11_1     #上期半年不可修改

         ON CHANGE l_rep_rule     #預設間接法不可修改

         ON CHANGE l_curr
            CALL aglq942_curr_scc()         

         AFTER FIELD l_d

         AFTER FIELD l_s

         ON CHANGE l_dol  
            CASE g_input.l_dol
               WHEN 1 #元 
                  LET g_unit = '1'  
               WHEN 2 #千
                  LET g_unit = '1000'
               WHEN 3 #萬
                  LET g_unit = '10000'
            END CASE

         ON ACTION controlp INFIELD b_glebld 
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL                                                
            LET g_qryparam.state = 'i'                                                     
            LET g_qryparam.reqry = FALSE                                                   
            LET g_qryparam.default1 = g_input.b_glebld                                     
            LET g_qryparam.arg1 = g_user                                 #人員權限         
            LET g_qryparam.arg2 = g_dept                                 #部門權限         
            LET g_qryparam.where = " glaald IN (SELECT DISTINCT gldbld FROM gldb_t ",              
                                   "             WHERE gldbstus = 'Y' ",                                    
                                   "               AND gldbent = '",g_enterprise,"') "                                               
            CALL q_authorised_ld()                                                         
            LET g_input.b_glebld = g_qryparam.return1                                      
            CALL s_desc_get_ld_desc(g_input.b_glebld) RETURNING g_input.glebld_desc            
            DISPLAY BY NAME g_input.b_glebld,g_input.glebld_desc                         
            NEXT FIELD b_glebld 

         ON ACTION controlp INFIELD b_gleb001
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.b_gleb001
            LET g_qryparam.where = " gldc009 = 'Y' AND gldbstus = 'Y' ",
                                   " AND gldcld = '",g_input.b_glebld,"' "  
            CALL q_gldc001()    
            LET g_input.b_gleb001 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_input.b_gleb001) RETURNING g_input.gleb001_desc
            DISPLAY BY NAME g_input.b_gleb001,g_input.gleb001_desc
            NEXT FIELD b_gleb001

         AFTER INPUT   
            #依編制合併期別抓取條件
            LET l_argv_s = ''
            LET l_argv_e = ''
            CASE g_glaa138
               WHEN 0
                  LET l_argv_s = g_input.b_gleb004
                  LET l_argv_e = g_input.b_gleb004_1
               WHEN 1
                  LET l_argv_s = g_input.l_s1
                  LET l_argv_e = g_input.l_s1_1
               WHEN 2
                  LET l_argv_s = g_input.l_hy1
                  LET l_argv_e = g_input.l_hy1_1
            END CASE
            #將季別或半年別轉為期別
            CALL s_merge_get_glav006(g_glaa003,g_input.b_gleb003,g_glaa138,l_argv_s) RETURNING g_sub_success,g_errno,g_gleb004_s #起始期別
            CALL s_merge_get_glav006(g_glaa003,g_input.b_gleb003,g_glaa138,l_argv_e) RETURNING g_sub_success,g_errno,g_gleb004_e #截止期別
            
            #本期損益BS科目
            LET g_glab005bs = NULL
            SELECT glab005 INTO g_glab005bs 
              FROM glab_t
             WHERE glabent = g_enterprise
               AND glabld  = g_input.b_glebld 
               AND glab001 = '12' 
               AND glab002 = '9929'
               AND glab003 = '9929_04'
            
            #金額轉換單位
            CASE g_input.l_dol
               WHEN 1 #元 
                  LET g_unit = '1'  
               WHEN 2 #千
                  LET g_unit = '1000'
               WHEN 3 #萬
                  LET g_unit = '10000'
            END CASE
            
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
         CALL aglq942_default()
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
   CALL aglq942_b_fill()
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
 
{<section id="aglq942.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq942_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #設定小數位數用--------------
   DEFINE l_format        STRING
   DEFINE l_str           STRING
   DEFINE l_i             LIKE type_t.num5
   ##--------------------------
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq942_insert_tmp()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',gleb007,'','','','',gleb026,'','','','',gleb029  ,DENSE_RANK() OVER( ORDER BY gleb_t.glebld, 
       gleb_t.gleb001,gleb_t.gleb002,gleb_t.gleb003,gleb_t.gleb004,gleb_t.gleb005,gleb_t.gleb006,gleb_t.gleb032, 
       gleb_t.gleb033) AS RANK FROM gleb_t",
 
 
                     "",
                     " WHERE glebent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gleb_t"),
                     " ORDER BY gleb_t.glebld,gleb_t.gleb001,gleb_t.gleb002,gleb_t.gleb003,gleb_t.gleb004,gleb_t.gleb005,gleb_t.gleb006,gleb_t.gleb032,gleb_t.gleb033"
 
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
 
   LET g_sql = "SELECT '','','','',gleb007,'','','','',gleb026,'','','','',gleb029",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = " SELECT l_glei003,l_glei004,l_amt,l_amt_1,'',l_glei003,l_glei004,l_amt2,l_amt2_1,'',l_glei003,l_glei004,l_amt3,l_amt3_1,'' ",
               "   FROM aglq942_tmp "
               #"  WHERE l_seq NOT IN ('121','131')", #期初/期末兩大類不列出細項 #151207-00020#19 mark
               #"  ORDER BY l_seq,l_odr "                                      #151207-00020#19 mark

   #151207-00020#19 --s add
   IF g_input.l_s = 'Y' THEN #附註揭露
      CASE g_input.l_rep_rule
         WHEN 0
            LET g_sql = g_sql," WHERE l_rep_type IN ('0','3') "
         WHEN 1 
            LET g_sql = g_sql," WHERE l_rep_type IN ('1','3') AND l_seq NOT IN ('121','131') "
         WHEN 2 
            LET g_sql = g_sql," WHERE l_rep_type IN ('0','1','3') AND l_seq NOT IN ('121','131') "
      END CASE
   ELSE
      CASE g_input.l_rep_rule
         WHEN 0
            LET g_sql = g_sql," WHERE l_rep_type = '0' "
         WHEN 1 
            LET g_sql = g_sql," WHERE l_rep_type = '1' AND l_seq NOT IN ('121','131') "
         WHEN 2 
            LET g_sql = g_sql," WHERE l_rep_type IN ('0','1') AND l_seq NOT IN ('121','131') "
      END CASE
   END IF
   
   LET g_sql = g_sql,"  ORDER BY l_rep_type,l_seq,l_odr "
   #151207-00020#19 --e add


   PREPARE aglq942_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq942_pb1

   CALL g_gleb_d.clear()
   CALL g_gleb2_d.clear()   
   CALL g_gleb3_d.clear()    

   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
   
   FOREACH b_fill_curs1 INTO g_gleb_d[l_ac].l_glei003,g_gleb_d[l_ac].l_glei004,g_gleb_d[l_ac].l_amt,g_gleb_d[l_ac].l_amt_1, 
       g_gleb_d[l_ac].gleb007,g_gleb2_d[l_ac].l_glei003_1,g_gleb2_d[l_ac].l_glei004_1,g_gleb2_d[l_ac].l_amt2, 
       g_gleb2_d[l_ac].l_amt2_1,g_gleb2_d[l_ac].gleb026,g_gleb3_d[l_ac].l_glei003_2,g_gleb3_d[l_ac].l_glei004_2, 
       g_gleb3_d[l_ac].l_amt3,g_gleb3_d[l_ac].l_amt3_1,g_gleb3_d[l_ac].gleb029
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF   
      

      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_gleb_d[l_ac].l_glei004 = l_ac
      LET g_gleb2_d[l_ac].l_glei004_1 = g_gleb_d[l_ac].l_glei004
      LET g_gleb3_d[l_ac].l_glei004_2 = g_gleb_d[l_ac].l_glei004
      
      #end add-point
 
      CALL aglq942_detail_show("'1'")      
 
      CALL aglq942_gleb_t_mask()
 
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
   LET g_error_show = 0
   
 
   
   CALL g_gleb_d.deleteElement(g_gleb_d.getLength())   
   CALL g_gleb2_d.deleteElement(g_gleb2_d.getLength())
   CALL g_gleb3_d.deleteElement(g_gleb3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"

   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_tot_cnt = g_gleb_d.getLength()
   #end add-point


   LET g_detail_cnt = g_gleb_d.getLength()
#   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs1
   FREE aglq942_pb1
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq942_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq942_detail_action_trans()
 
   IF g_gleb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq942_fetch()
   END IF
   
   CALL aglq942_filter_show('gleb007','b_gleb007')
   CALL aglq942_filter_show('gleb026','b_gleb026')
   CALL aglq942_filter_show('gleb029','b_gleb029')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str = ""
   FOR l_i=1 TO g_input.l_d
       LET l_str = l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET l_format = l_format,'.',l_str
   END IF
   CALL cl_set_comp_format("l_amt,l_amt_1,l_amt2,l_amt2_1,l_amt3,l_amt3_1",l_format)
   #end add-point
   
   RETURN
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq942_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq942_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_gleb_d.clear()
   CALL g_gleb2_d.clear()   
 
   CALL g_gleb3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_gleb_d[l_ac].l_glei003,g_gleb_d[l_ac].l_glei004,g_gleb_d[l_ac].l_amt,g_gleb_d[l_ac].l_amt_1, 
       g_gleb_d[l_ac].gleb007,g_gleb2_d[l_ac].l_glei003_1,g_gleb2_d[l_ac].l_glei004_1,g_gleb2_d[l_ac].l_amt2, 
       g_gleb2_d[l_ac].l_amt2_1,g_gleb2_d[l_ac].gleb026,g_gleb3_d[l_ac].l_glei003_2,g_gleb3_d[l_ac].l_glei004_2, 
       g_gleb3_d[l_ac].l_amt3,g_gleb3_d[l_ac].l_amt3_1,g_gleb3_d[l_ac].gleb029
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_gleb_d[l_ac].statepic = cl_get_actipic(g_gleb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq942_detail_show("'1'")      
 
      CALL aglq942_gleb_t_mask()
 
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
   
 
   
   CALL g_gleb_d.deleteElement(g_gleb_d.getLength())   
   CALL g_gleb2_d.deleteElement(g_gleb2_d.getLength())
 
   CALL g_gleb3_d.deleteElement(g_gleb3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_gleb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq942_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq942_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq942_detail_action_trans()
 
   IF g_gleb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq942_fetch()
   END IF
   
      CALL aglq942_filter_show('gleb007','b_gleb007')
   CALL aglq942_filter_show('gleb026','b_gleb026')
   CALL aglq942_filter_show('gleb029','b_gleb029')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq942.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq942_fetch()
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
 
{<section id="aglq942.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq942_detail_show(ps_page)
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
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq942.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq942_filter()
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
      CONSTRUCT g_wc_filter ON gleb007,gleb026,gleb029
                          FROM s_detail1[1].b_gleb007,s_detail2[1].b_gleb026,s_detail3[1].b_gleb029
 
         BEFORE CONSTRUCT
                     DISPLAY aglq942_filter_parser('gleb007') TO s_detail1[1].b_gleb007
            DISPLAY aglq942_filter_parser('gleb026') TO s_detail2[1].b_gleb026
            DISPLAY aglq942_filter_parser('gleb029') TO s_detail3[1].b_gleb029
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<l_glei003>>----
         #----<<l_glei004>>----
         #----<<l_amt>>----
         #----<<l_amt_1>>----
         #----<<b_gleb007>>----
         #Ctrlp:construct.c.filter.page1.b_gleb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gleb007
            #add-point:ON ACTION controlp INFIELD b_gleb007 name="construct.c.filter.page1.b_gleb007"
            
            #END add-point
 
 
         #----<<l_glei003_1>>----
         #----<<l_glei004_1>>----
         #----<<l_amt2>>----
         #----<<l_amt2_1>>----
         #----<<b_gleb026>>----
         #Ctrlp:construct.c.filter.page2.b_gleb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gleb026
            #add-point:ON ACTION controlp INFIELD b_gleb026 name="construct.c.filter.page2.b_gleb026"
            
            #END add-point
 
 
         #----<<l_glei003_2>>----
         #----<<l_glei004_2>>----
         #----<<l_amt3>>----
         #----<<l_amt3_1>>----
         #----<<b_gleb029>>----
         #Ctrlp:construct.c.filter.page3.b_gleb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gleb029
            #add-point:ON ACTION controlp INFIELD b_gleb029 name="construct.c.filter.page3.b_gleb029"
            
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
   
      CALL aglq942_filter_show('gleb007','b_gleb007')
   CALL aglq942_filter_show('gleb026','b_gleb026')
   CALL aglq942_filter_show('gleb029','b_gleb029')
 
    
   CALL aglq942_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq942.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq942_filter_parser(ps_field)
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
 
{<section id="aglq942.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq942_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq942_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq942.insert" >}
#+ insert
PRIVATE FUNCTION aglq942_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq942.modify" >}
#+ modify
PRIVATE FUNCTION aglq942_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq942.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq942_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq942.delete" >}
#+ delete
PRIVATE FUNCTION aglq942_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq942.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq942_detail_action_trans()
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
 
{<section id="aglq942.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq942_detail_index_setting()
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
            IF g_gleb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_gleb_d.getLength() AND g_gleb_d.getLength() > 0
            LET g_detail_idx = g_gleb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_gleb_d.getLength() THEN
               LET g_detail_idx = g_gleb_d.getLength()
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
 
{<section id="aglq942.mask_functions" >}
 &include "erp/agl/aglq942_mask.4gl"
 
{</section>}
 
{<section id="aglq942.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aglq942_default()
# Date & Author..: 160518 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_default()
DEFINE l_glaacomp  LIKE glaa_t.glaacomp   #法人
DEFINE l_glaald    LIKE glaa_t.glaald     #帳套
DEFINE l_pdate_s   LIKE glav_t.glav004   
DEFINE l_pdate_e   LIKE glav_t.glav004   
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_errno     LIKE type_t.chr100
DEFINE l_glav002   LIKE glav_t.glav002  
DEFINE l_glav005   LIKE glav_t.glav005  
DEFINE l_sdate_s   LIKE glav_t.glav004
DEFINE l_sdate_e   LIKE glav_t.glav004
DEFINE l_glav006   LIKE glav_t.glav006
DEFINE l_glav007   LIKE glav_t.glav007
DEFINE l_wdate_s   LIKE glav_t.glav004
DEFINE l_wdate_e   LIKE glav_t.glav004 

   CLEAR FORM
   INITIALIZE g_input.* TO NULL
   
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
   
   #會計周期參照表
   #SELECT glaa003,glaa138,glaa135,glaa004 INTO g_glaa003,g_glaa138,g_glaa135,g_glaa004 FROM glaa_t                   #151207-00020#19 mark
   SELECT glaa003,glaa138,glaa135,glaa004,glaa005 INTO g_glaa003,g_glaa138,g_glaa135,g_glaa004,g_glaa005 FROM glaa_t  #151207-00020#19 add
    WHERE glaaent = g_enterprise AND glaald = l_glaald
              
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
             
   LET g_input.b_gleb003 = l_glav002   #會計年度
   LET g_input.b_gleb003_1 = g_input.b_gleb003-1
   LET g_input.l_rep_rule = '2'  #151207-00020#19  add
   LET g_input.l_curr = '1'
   LET g_input.l_d = '2'
   LET g_input.l_s = 'Y'
   LET g_input.l_dol = '1'
   
   #預設期別
   CALL cl_set_comp_entry("b_gleb004,b_gleb004_1,l_s1,l_s1_1,l_hy1,l_hy1_1",TRUE)
   LET g_input.b_gleb004 = l_glav006
   LET g_input.b_gleb004_1 = g_input.b_gleb004
   LET g_input.l_s1 = '0'
   LET g_input.l_s1_1 = g_input.l_s1
   LET g_input.l_hy1 = '0'
   LET g_input.l_hy1_1 = g_input.l_hy1 
   CALL cl_set_comp_entry("l_s1,l_s1_1,l_hy1,l_hy1_1",FALSE)
   
   #上期與本期設定相同
   LET g_input.b_gleb0041_1 = g_input.b_gleb004
   LET g_input.b_gleb0041_2 = g_input.b_gleb004_1
   LET g_input.l_s11 = g_input.l_s1
   LET g_input.l_s11_1 = g_input.l_s1_1
   LET g_input.l_hy11 = g_input.l_hy1
   LET g_input.l_hy11_1 = g_input.l_hy1_1
   
   CALL aglq942_curr_scc()
   
   DISPLAY BY NAME g_input.b_gleb003,g_input.b_gleb003_1,g_input.l_rep_rule,
                   g_input.l_curr,g_input.l_d,g_input.l_s,g_input.l_dol,
                   g_input.b_gleb0041_1,g_input.b_gleb004,g_input.b_gleb0041_2,g_input.b_gleb004_1,
                   g_input.l_s11,g_input.l_s1,g_input.l_s11_1,g_input.l_s1_1,
                   g_input.l_hy11,g_input.l_hy1,g_input.l_hy11_1,g_input.l_hy1_1
END FUNCTION

################################################################################
# Descriptions...: 依合併報表編制期別,控制欄位輸入否
# Memo...........:
# Usage..........: CALL aglq942_set_entry()
# Date & Author..: 160518 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_set_entry()
DEFINE l_pdate_s   LIKE glav_t.glav004   
DEFINE l_pdate_e   LIKE glav_t.glav004   
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_errno     LIKE type_t.chr100
DEFINE l_glav002   LIKE glav_t.glav002  
DEFINE l_glav005   LIKE glav_t.glav005  
DEFINE l_sdate_s   LIKE glav_t.glav004
DEFINE l_sdate_e   LIKE glav_t.glav004
DEFINE l_glav006   LIKE glav_t.glav006
DEFINE l_glav007   LIKE glav_t.glav007
DEFINE l_wdate_s   LIKE glav_t.glav004
DEFINE l_wdate_e   LIKE glav_t.glav004 
   
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
       
   CALL cl_set_comp_entry("b_gleb004,b_gleb004_1,l_s1,l_s1_1,l_hy1,l_hy1_1",TRUE)
   CASE g_glaa138
      WHEN 0
         LET g_input.b_gleb004 = l_glav006
         LET g_input.b_gleb004_1 = g_input.b_gleb004
         LET g_input.l_s1 = '0'
         LET g_input.l_s1_1 = g_input.l_s1
         LET g_input.l_hy1 = '0'
         LET g_input.l_hy1_1 = g_input.l_hy1 
         
         CALL cl_set_comp_entry("l_s1,l_s1_1,l_hy1,l_hy1_1",FALSE)
         CALL cl_set_comp_required("b_gleb004,b_gleb004_1",TRUE)
      WHEN 1
         LET g_input.b_gleb004 = ''
         LET g_input.b_gleb004_1 = g_input.b_gleb004
         LET g_input.l_s1 = '1'
         LET g_input.l_s1_1 = g_input.l_s1
         LET g_input.l_hy1 = '0'
         LET g_input.l_hy1_1 = g_input.l_hy1 
         
         CALL cl_set_comp_entry("b_gleb004,b_gleb004_1,l_hy1,l_hy1_1",FALSE)
         CALL cl_set_comp_required("l_s1,l_s1_1",TRUE)
      WHEN 2
         LET g_input.b_gleb004 = ''
         LET g_input.b_gleb004_1 = g_input.b_gleb004
         LET g_input.l_s1 = '0'
         LET g_input.l_s1_1 = g_input.l_s1
         LET g_input.l_hy1 = '1'
         LET g_input.l_hy1_1 = g_input.l_hy1 
         
         CALL cl_set_comp_entry("b_gleb004,b_gleb004_1,l_s1,l_s1_1",FALSE)
         CALL cl_set_comp_required("l_hy1,l_hy1_1",TRUE)
   END CASE
   
   #上期與本期設定相同
   LET g_input.b_gleb0041_1 = g_input.b_gleb004
   LET g_input.b_gleb0041_2 = g_input.b_gleb004_1
   LET g_input.l_s11 = g_input.l_s1
   LET g_input.l_s11_1 = g_input.l_s1_1
   LET g_input.l_hy11 = g_input.l_hy1
   LET g_input.l_hy11_1 = g_input.l_hy1_1
   
   DISPLAY BY NAME g_input.b_gleb0041_1,g_input.b_gleb004,g_input.b_gleb0041_2,g_input.b_gleb004_1,
                   g_input.l_s11,g_input.l_s1,g_input.l_s11_1,g_input.l_s1_1,
                   g_input.l_hy11,g_input.l_hy1,g_input.l_hy11_1,g_input.l_hy1_1
END FUNCTION

################################################################################
# Descriptions...: 多本位幣,僅可選擇已啟用之多位幣
# Memo...........:
# Usage..........: CALL aglq942_curr_scc()
# Date & Author..: 160518 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_curr_scc()
DEFINE l_glaa015 LIKE glaa_t.glaa015
DEFINE l_glaa019 LIKE glaa_t.glaa019              
              
   IF cl_null(g_input.b_glebld)THEN RETURN END IF
   
   CALL cl_set_comp_visible('bpage_1,page_3,page_4',TRUE)
   
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
     FROM glaa_t WHERE glaaent = g_enterprise  AND glaald  = g_input.b_glebld
   
   CASE
      WHEN (l_glaa015 = 'Y' AND l_glaa019 = 'Y')
         CALL cl_set_combo_scc('l_curr','9896') 
         #依單頭多本位幣選擇顯示的幣別
         IF g_input.l_curr = 1 THEN CALL cl_set_comp_visible('page_3,page_4',FALSE) END IF
         IF g_input.l_curr = 2 THEN CALL cl_set_comp_visible('bpage_1,page_4',FALSE) END IF 
         IF g_input.l_curr = 3 THEN CALL cl_set_comp_visible('bpage_1,page_3',FALSE) END IF
         
      WHEN (l_glaa015 = 'N' AND l_glaa019 = 'N')
         CALL cl_set_combo_scc_part('l_curr','9896','1') 
         CALL cl_set_comp_visible('page_3,page_4',FALSE)
         IF g_input.l_curr = 2 OR g_input.l_curr = 3 OR g_input.l_curr = 4 THEN
            LET g_input.l_curr = 1
         END IF         
         
      WHEN (l_glaa015 = 'Y' AND l_glaa019 = 'N')
         CALL cl_set_combo_scc_part('l_curr','9896','1,2,4') 
         #依單頭多本位幣選擇顯示的幣別
         IF g_input.l_curr = 3 THEN LET g_input.l_curr = 1 END IF
         IF g_input.l_curr = 1 THEN CALL cl_set_comp_visible('page_3,page_4',FALSE) END IF
         IF g_input.l_curr = 2 THEN CALL cl_set_comp_visible('bpage_1,page_4',FALSE) END IF 
         IF g_input.l_curr = 4 THEN CALL cl_set_comp_visible('page_4',FALSE) END IF
         
      WHEN (l_glaa015 = 'N' AND l_glaa019 = 'Y')
         CALL cl_set_combo_scc_part('l_curr','9896','1,3,4') 
         #依單頭多本位幣選擇顯示的幣別
         IF g_input.l_curr = 2 THEN LET g_input.l_curr = 1 END IF
         IF g_input.l_curr = 1 THEN CALL cl_set_comp_visible('page_3,page_4',FALSE) END IF
         IF g_input.l_curr = 3 THEN CALL cl_set_comp_visible('bpage_1,page_3',FALSE) END IF
         IF g_input.l_curr = 4 THEN CALL cl_set_comp_visible('page_3',FALSE) END IF     
   END CASE
   
   DISPLAY BY NAME g_input.l_curr
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq942_create_tmp()
# Date & Author..: 160519 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_create_tmp()
   DROP TABLE aglq942_tmp;
   CREATE TEMP TABLE aglq942_tmp(
      l_rep_type    LIKE type_t.chr1,    #報表類型  #151207-00020#19 add (0.直接法 / 1.間接法 / 2.二者 / 3.附註揭露)
      l_seq         LIKE glei_t.glei004, #主類別
      l_odr         LIKE glei_t.glei004, #群組順序
      l_glei003     LIKE type_t.chr500,  #項目
      l_glei004     LIKE glei_t.glei004, #行序
      l_amt         LIKE type_t.num20_6, #本期數
      l_amt_1       LIKE type_t.num20_6, #上期數
      l_amt2        LIKE type_t.num20_6, #本期數(功能幣)
      l_amt2_1      LIKE type_t.num20_6, #上期數(功能幣)
      l_amt3        LIKE type_t.num20_6, #本期數(報告幣)
      l_amt3_1      LIKE type_t.num20_6  #上期數(報告幣) 
                )
   
   #報表列印
   DROP TABLE aglq942_g01_tmp;   
   CREATE TEMP TABLE aglq942_g01_tmp(
      l_rep_type    LIKE type_t.chr1,    #報表類型  #151207-00020#19 add
      l_seq         LIKE glei_t.glei004, #主類別
      l_odr         LIKE glei_t.glei004, #群組順序
      l_glei003     LIKE type_t.chr500,  #項目
      l_glei004     LIKE glei_t.glei004, #行序
      l_amt         LIKE type_t.num20_6, #本期數
      l_amt_1       LIKE type_t.num20_6  #上期數
                )
                
END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........:
# Usage..........: CALL aglq942_insert_tmp()
# Date & Author..: 160519 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_insert_tmp()
DEFINE l_sql           STRING                   
DEFINE l_type          LIKE glei_t.glei004      #變動分類列印順序
DEFINE l_i             LIKE type_t.num10        #行數           
DEFINE l_glei          RECORD                   #agli560來源資料
         glei002       LIKE glei_t.glei002,     #群組編號
         gleil004	     LIKE gleil_t.gleil004,   #說明
         glei003	     LIKE glei_t.glei003,	   #變動分類
         glei004	     LIKE glei_t.glei004 	   #行序
                       END RECORD               
DEFINE l_glej          RECORD                   #agli561來源資料
         glej003       LIKE glej_t.glej003,     #科目編號
         glacl004	     LIKE glacl_t.glacl004,   #說明
         glej004	     LIKE glej_t.glej004,	   #加/減項
         glej005	     LIKE glej_t.glej005 	   #異動類型
                       END RECORD   
#151207-00020#19 --s add            
DEFINE l_nmak          RECORD                   #anmi180來源資料
         nmak001       LIKE nmak_t.nmak001,     #現金異動碼分類編碼
         nmakl003      LIKE nmakl_t.nmakl003,   #說明
         nmak002       LIKE nmak_t.nmak002      #大類
                       END RECORD   
DEFINE l_nmai          RECORD                   #anmi160來源資料
         nmai002       LIKE nmai_t.nmai002,     #現金異動碼編碼
         nmail004	     LIKE nmail_t.nmail004,   #說明
         nmai003	     LIKE nmai_t.nmai003,	   #變動分類碼
         nmai004	     LIKE nmai_t.nmai004 	   #行序
                       END RECORD               
DEFINE l_tit_sum       LIKE type_t.chr500  
DEFINE l_tot_sum       LIKE type_t.chr500     
DEFINE l_gzcbl002      LIKE gzcbl_t.gzcbl002
DEFINE l_gzcbl004      LIKE gzcbl_t.gzcbl004
DEFINE l_seq           LIKE glei_t.glei004
#151207-00020#19 --e add                       
DEFINE l_glei003       LIKE type_t.chr500       #項目說明
DEFINE l_amt           LIKE type_t.num20_6      #本期數
DEFINE l_amt_1         LIKE type_t.num20_6      #上期數
DEFINE l_amt2          LIKE type_t.num20_6      #本期數(功能幣)
DEFINE l_amt2_1        LIKE type_t.num20_6      #上期數(功能幣)
DEFINE l_amt3          LIKE type_t.num20_6      #本期數(報告幣)
DEFINE l_amt3_1        LIKE type_t.num20_6      #上期數(報告幣)
DEFINE l_amt_s         LIKE type_t.num20_6      #群組現金流量(本期)
DEFINE l_amt_s_1       LIKE type_t.num20_6      #群組現金流量(上期)
DEFINE l_amt_s2        LIKE type_t.num20_6      #群組現金流量(本期)
DEFINE l_amt_s2_1      LIKE type_t.num20_6      #群組現金流量(上期)
DEFINE l_amt_s3        LIKE type_t.num20_6      #群組現金流量(本期)
DEFINE l_amt_s3_1      LIKE type_t.num20_6      #群組現金流量(上期)
DEFINE l_sub_amt       LIKE type_t.num20_6      #各活動產生的淨現金(本期)
DEFINE l_sub_amt_1     LIKE type_t.num20_6      #各活動產生的淨現金(上期)
DEFINE l_sub_amt2      LIKE type_t.num20_6      #各活動產生的淨現金(本期)(功能幣)
DEFINE l_sub_amt2_1    LIKE type_t.num20_6      #各活動產生的淨現金(上期)(功能幣)
DEFINE l_sub_amt3      LIKE type_t.num20_6      #各活動產生的淨現金(本期)(報告幣)
DEFINE l_sub_amt3_1    LIKE type_t.num20_6      #各活動產生的淨現金(上期)(報告幣)
DEFINE l_tot_amt       LIKE type_t.num20_6      #本期現金淨增數(本期)
DEFINE l_tot_amt_1     LIKE type_t.num20_6      #本期現金淨增數(上期)
DEFINE l_tot_amt2      LIKE type_t.num20_6      #本期現金淨增數(本期)(功能幣)
DEFINE l_tot_amt2_1    LIKE type_t.num20_6      #本期現金淨增數(上期)(功能幣)
DEFINE l_tot_amt3      LIKE type_t.num20_6      #本期現金淨增數(本期)(報告幣)
DEFINE l_tot_amt3_1    LIKE type_t.num20_6      #本期現金淨增數(上期)(報告幣)
DEFINE l_this_amt      LIKE type_t.num20_6      #本期餘額 (本期) 
DEFINE l_last_amt      LIKE type_t.num20_6      #期初餘額 (本期)
DEFINE l_this_amt2     LIKE type_t.num20_6      #本期餘額 (本期)(功能幣)
DEFINE l_last_amt2     LIKE type_t.num20_6      #期初餘額 (本期)(功能幣)
DEFINE l_this_amt3     LIKE type_t.num20_6      #本期餘額 (本期)(報告幣) 
DEFINE l_last_amt3     LIKE type_t.num20_6      #期初餘額 (本期)(報告幣)
DEFINE l_this_amt_1    LIKE type_t.num20_6      #本期餘額 (上期) 
DEFINE l_last_amt_1    LIKE type_t.num20_6      #期初餘額 (上期)
DEFINE l_this_amt2_1   LIKE type_t.num20_6      #本期餘額 (上期)(功能幣) 
DEFINE l_last_amt2_1   LIKE type_t.num20_6      #期初餘額 (上期)(功能幣)
DEFINE l_this_amt3_1   LIKE type_t.num20_6      #本期餘額 (上期)(報告幣) 
DEFINE l_last_amt3_1   LIKE type_t.num20_6      #期初餘額 (上期)(報告幣)
DEFINE l_glac008       LIKE glac_t.glac008      #科目借貸餘型態
#固定格式_title-------------
DEFINE l_title_1       LIKE type_t.chr500       #營業活動之現金流量
DEFINE l_title_2       LIKE type_t.chr500       #本期淨利(損)
DEFINE l_title_3       LIKE type_t.chr500       #調整項目
DEFINE l_title_4       LIKE type_t.chr500       #營運產生之現金流入(流出)
DEFINE l_title_5       LIKE type_t.chr500       #營業活動產生之淨現金
DEFINE l_title_6       LIKE type_t.chr500       #投資活動之現金流量
DEFINE l_title_7       LIKE type_t.chr500       #投資活動產生之淨現金
DEFINE l_title_8       LIKE type_t.chr500       #理財活動之現金流量
DEFINE l_title_9       LIKE type_t.chr500       #理財活動產生之淨現金
DEFINE l_title_10      LIKE type_t.chr500       #本期現金淨增數
DEFINE l_title_11      LIKE type_t.chr500       #匯率影響數
DEFINE l_title_12      LIKE type_t.chr500       #期初現金及約當現金餘額
DEFINE l_title_13      LIKE type_t.chr500       #期末現金及約當現金餘額
DEFINE l_title_14      LIKE type_t.chr500       #揭露事項   
#---------------------------
                                                
   #刪除臨時表中資料
   DELETE FROM aglq942_tmp

   #151207-00020#19 --s add
   #[直接法]----------------------------------------------------------------------
   LET l_i = 0
   LET l_sub_amt     = 0    #各活動產生的淨現金(本期)
   LET l_sub_amt_1   = 0    #各活動產生的淨現金(上期)
   LET l_sub_amt2    = 0    #各活動產生的淨現金(本期)(功能幣)
   LET l_sub_amt2_1  = 0    #各活動產生的淨現金(上期)(功能幣)
   LET l_sub_amt3    = 0    #各活動產生的淨現金(本期)(報告幣)
   LET l_sub_amt3_1  = 0    #各活動產生的淨現金(上期)(報告幣)
   LET l_tot_amt     = 0    #本期現金淨增數(本期)
   LET l_tot_amt_1   = 0    #本期現金淨增數(上期)
   LET l_tot_amt2    = 0    #本期現金淨增數(本期)(功能幣)
   LET l_tot_amt2_1  = 0    #本期現金淨增數(上期)(功能幣)
   LET l_tot_amt3    = 0    #本期現金淨增數(本期)(報告幣)
   LET l_tot_amt3_1  = 0    #本期現金淨增數(上期)(報告幣)
   LET l_type = ''
   LET l_tit_sum = cl_getmsg('aps-00134',g_dlang)  #合計
   LET l_tot_sum = cl_getmsg('lib-00133',g_dlang)  #總計
   
   #寫入title--------------------------------------------------------
   LET l_gzcbl002 = ''
   LET l_gzcbl004 = ''
   LET g_sql = " SELECT gzcbl002,gzcbl004 FROM gzcb_t,gzcbl_t ",
               "  WHERE gzcb001 ='8026' AND gzcb001 = gzcbl001  ",
               "    AND gzcb002 = gzcbl002 AND gzcbl003='",g_dlang,"'  ",
               "  GROUP BY gzcbl002,gzcbl004 ",
               "  ORDER BY gzcbl002 "
   PREPARE aglq942_scc_pr FROM g_sql
   DECLARE aglq942_scc_cs CURSOR FOR aglq942_scc_pr
   FOREACH aglq942_scc_cs INTO l_gzcbl002,l_gzcbl004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aglq942_scc_cs"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
      LET l_type = ''
      
      #目前有5大類
      CASE l_gzcbl002
         WHEN 1 
            LET l_type = 1 #2給大類1的合計
         WHEN 2  
            LET l_type = 3 #4給大類2的合計
         WHEN 3
            LET l_type = 5 #6給大類3的合計
         WHEN 4 
            LET l_type = 7 #8給大類4的合計
         WHEN 5 
            LET l_type = 9 #10給大類5的合計
      END CASE
     
      INSERT INTO aglq942_tmp VALUES ('0',l_type,'0',l_gzcbl004,'','','','','','','')
   END FOREACH      
   
  
   #-----------------------------------------------------------------
   #取anmi160 抓取現金變動碼資料----
   LET g_sql = " SELECT DISTINCT nmai002,nmail004,nmai003,nmai004 ",
               "   FROM nmai_t ",
               "   LEFT JOIN nmail_t ON nmaient = nmailent AND nmai001 = nmail001 AND nmai002 = nmail002 AND nmail003='"||g_dlang||"' ",
               "  WHERE nmaient = ",g_enterprise," AND nmaistus='Y' ",
               "    AND nmai001 = '",g_glaa005,"' ",
               "    AND nmai003 = ? ",
               "  ORDER BY nmai003,nmai004,nmai002,nmail004 "
   PREPARE aglq942_nmai_pr FROM g_sql
   DECLARE aglq942_nmai_cs CURSOR FOR aglq942_nmai_pr

   #直接法餘額檔glen_t
   #本期
   LET g_sql = " SELECT DISTINCT SUM(glen007),SUM(glen009),SUM(glen011) ",
               "   FROM glen_t ",
               "  WHERE glenent = ",g_enterprise,"  ",
               "    AND glenld = '",g_input.b_glebld,"' ",
               "    AND glen001 = '",g_input.b_gleb001,"' ",
               "    AND glen003 = '",g_input.b_gleb003,"' ",
               "    AND glen004 BETWEEN '",g_gleb004_s,"' AND '",g_gleb004_e,"' ",
               "    AND glen005 = ? "
   PREPARE aglq942_nmai_pr1 FROM g_sql
   DECLARE aglq942_nmai_cs1 CURSOR FOR aglq942_nmai_pr1
   
   #上期
   LET g_sql = " SELECT DISTINCT SUM(glen007),SUM(glen009),SUM(glen011) ",
               "   FROM glen_t ",
               "  WHERE glenent = ",g_enterprise,"  ",
               "    AND glenld = '",g_input.b_glebld,"' ",
               "    AND glen001 = '",g_input.b_gleb001,"' ",
               "    AND glen003 = '",g_input.b_gleb003_1,"' ",
               "    AND glen004 BETWEEN '",g_gleb004_s,"' AND '",g_gleb004_e,"' ",
               "    AND glen005 = ? "
   PREPARE aglq942_nmai_pr2 FROM g_sql
   DECLARE aglq942_nmai_cs2 CURSOR FOR aglq942_nmai_pr2

   #[1].取anmi180 抓取現金變動碼分類碼大類----
   INITIALIZE l_nmak.* TO NULL
   LET g_sql = " SELECT DISTINCT nmak001,nmakl003,nmak002",
               "   FROM nmak_t LEFT JOIN nmakl_t ON nmakent=nmaklent AND nmakl001=nmak001 AND nmakl002='"||g_dlang||"' ",
               "  WHERE nmakent=",g_enterprise," AND nmakstus='Y'  ",
               "    AND nmak001 IN (SELECT nmai003 FROM nmai_t WHERE nmaient = ",g_enterprise," AND nmaistus='Y' ",
               "                       AND nmai001 = '",g_glaa005,"')",
               "  ORDER BY nmak002,nmak001,nmakl003  "
   PREPARE aglq942_nmak_pr FROM g_sql
   DECLARE aglq942_nmak_cs CURSOR FOR aglq942_nmak_pr
   FOREACH aglq942_nmak_cs INTO l_nmak.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aglq942_nmak_cs"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF      

      
      LET l_amt = 0         #本期數
      LET l_amt_1 = 0       #上期數
      LET l_amt2 = 0        #本期數(功能幣)
      LET l_amt2_1 = 0      #上期數(功能幣)
      LET l_amt3 = 0        #本期數(報告幣)
      LET l_amt3_1 = 0      #上期數(報告幣)

      LET l_amt_s = 0            
      LET l_amt_s_1 = 0     
      LET l_amt_s2 = 0     
      LET l_amt_s2_1 = 0
      LET l_amt_s3 = 0        
      LET l_amt_s3_1 = 0

      #目前有5大類
      CASE l_nmak.nmak002[1,1]
         WHEN 1 
            LET l_type = 1 #2給大類1的合計
         WHEN 2  
            LET l_type = 3 #4給大類2的合計
         WHEN 3
            LET l_type = 5 #6給大類3的合計
         WHEN 4 
            LET l_type = 7 #8給大類4的合計
         WHEN 5 
            LET l_type = 9 #10給大類5的合計
      END CASE
      LET l_glei003 = ''
      
      #[2].取anmi160 抓取現金變動碼資料----
      INITIALIZE l_nmai.* TO NULL
      FOREACH aglq942_nmai_cs USING l_nmak.nmak001 INTO l_nmai.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:aglq942_nmai_cs "
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF

         LET l_i = l_i+1
         LET l_amt = 0         #本期數
         LET l_amt_1 = 0       #上期數
         LET l_amt2 = 0        #本期數(功能幣)
         LET l_amt2_1 = 0      #上期數(功能幣)
         LET l_amt3 = 0        #本期數(報告幣)
         LET l_amt3_1 = 0      #上期數(報告幣)
         
         EXECUTE aglq942_nmai_cs1 USING l_nmai.nmai002 INTO l_amt,l_amt2,l_amt3        #本期
         EXECUTE aglq942_nmai_cs2 USING l_nmai.nmai002 INTO l_amt_1,l_amt2_1,l_amt3_1  #上期
         
         IF cl_null(l_amt)    THEN LET l_amt    = 0 END IF #本期數
         IF cl_null(l_amt_1)  THEN LET l_amt_1  = 0 END IF #上期數
         IF cl_null(l_amt2)   THEN LET l_amt2   = 0 END IF #本期數(功能幣)
         IF cl_null(l_amt2_1) THEN LET l_amt2_1 = 0 END IF #上期數(功能幣)
         IF cl_null(l_amt3)   THEN LET l_amt3   = 0 END IF #本期數(報告幣)
         IF cl_null(l_amt3_1) THEN LET l_amt3_1 = 0 END IF #上期數(報告幣)
         
         #單位換算
         LET l_amt = l_amt/g_unit            
         LET l_amt_1 = l_amt_1/g_unit      
         LET l_amt2 = l_amt2/g_unit        
         LET l_amt2_1 = l_amt2_1/g_unit    
         LET l_amt3 = l_amt3/g_unit        
         LET l_amt3_1 = l_amt3_1/g_unit   

         LET l_glei003 = "        ",l_nmai.nmai002," ",l_nmai.nmail004
         INSERT INTO aglq942_tmp VALUES ('0',l_type,l_i,l_glei003,l_i,l_amt,l_amt_1,l_amt2,l_amt2_1,l_amt3,l_amt3_1)  
         
         LET l_amt_s = l_amt_s + l_amt
         LET l_amt_s_1 = l_amt_s_1 + l_amt_1
         LET l_amt_s2 = l_amt_s2 + l_amt2
         LET l_amt_s2_1 = l_amt_s2_1 + l_amt2_1         
         LET l_amt_s3 = l_amt_s3 + l_amt3
         LET l_amt_s3_1 = l_amt_s3_1 + l_amt3_1            
      END FOREACH
      
      LET l_i = l_i+1
      LET l_glei003 = ''
      
      #單位換算
      LET l_amt_s = l_amt_s/g_unit            
      LET l_amt_s_1 = l_amt_s_1/g_unit      
      LET l_amt_s2 = l_amt_s2/g_unit        
      LET l_amt_s2_1 = l_amt_s2_1/g_unit    
      LET l_amt_s3 = l_amt_s3/g_unit        
      LET l_amt_s3_1 = l_amt_s3_1/g_unit    
      
      LET l_glei003 = "        ",l_nmak.nmakl003 CLIPPED,l_tit_sum 
      #寫入現金變動分類碼合計金額------
      INSERT INTO aglq942_tmp VALUES ('0',l_type,l_i,l_glei003,l_i,l_amt_s,l_amt_s_1,l_amt_s2,l_amt_s2_1,l_amt_s3,l_amt_s3_1)  
   END FOREACH
   
   #各活動產生的淨額計算----------------------------
   #依各大類撈出匯總金額
   LET l_seq = ''
   LET l_sql = " SELECT l_seq,SUM(l_amt),SUM(l_amt_1),SUM(l_amt2),SUM(l_amt2_1),SUM(l_amt3),SUM(l_amt3_1) ",
               "   FROM aglq942_tmp ",
               "  WHERE l_rep_type = '0' AND l_seq <> '0' ",
               "  GROUP BY l_seq ",
               "  ORDER BY l_seq "
   PREPARE aglq942_sub_amt0_pr FROM l_sql
   DECLARE aglq942_sub_amt0_cs CURSOR FOR aglq942_sub_amt0_pr 
   FOREACH aglq942_sub_amt0_cs INTO l_seq,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1
      IF cl_null(l_sub_amt)    THEN LET l_sub_amt = 0    END IF
      IF cl_null(l_sub_amt_1)  THEN LET l_sub_amt_1 = 0  END IF
      IF cl_null(l_sub_amt2)   THEN LET l_sub_amt2 = 0   END IF
      IF cl_null(l_sub_amt2_1) THEN LET l_sub_amt2_1 = 0 END IF
      IF cl_null(l_sub_amt3)   THEN LET l_sub_amt3 = 0   END IF
      IF cl_null(l_sub_amt3_1) THEN LET l_sub_amt3_1 = 0 END IF
      
      LET l_type = ''
      #目前有5大類>>要撈說明,給回來大類
      CASE l_seq
         WHEN 1 
            LET l_type = 1 #2給大類1的合計
         WHEN 3  
            LET l_type = 2 #4給大類2的合計
         WHEN 5
            LET l_type = 3 #6給大類3的合計
         WHEN 7 
            LET l_type = 4 #8給大類4的合計
         WHEN 9 
            LET l_type = 5 #10給大類5的合計
      END CASE
      
      LET l_gzcbl004 = ''
      SELECT gzcbl004 INTO l_gzcbl004 FROM gzcb_t,gzcbl_t 
       WHERE gzcb001 ='8026' AND gzcb001 = gzcbl001 AND gzcb002 = l_type
         AND gzcb002 = gzcbl002 AND gzcbl003 = g_dlang 
      
      LET l_gzcbl004 = l_gzcbl004 CLIPPED,l_tit_sum
      INSERT INTO aglq942_tmp VALUES ('0',l_seq+1,0,l_gzcbl004,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1) #151207-00020#19 add  
   END FOREACH

   #總合計----------------------------
   LET l_sql = " SELECT SUM(l_amt),SUM(l_amt_1),SUM(l_amt2),SUM(l_amt2_1),SUM(l_amt3),SUM(l_amt3_1) ",
               "   FROM aglq942_tmp ",
               "  WHERE l_rep_type = '0' AND l_seq IN ('2','4','6','8','10') "
   PREPARE aglq942_sub_amt01_pr FROM l_sql
   DECLARE aglq942_sub_amt01_cs CURSOR FOR aglq942_sub_amt01_pr 
   EXECUTE aglq942_sub_amt01_cs INTO l_tot_amt,l_tot_amt_1,l_tot_amt2,l_tot_amt2_1,l_tot_amt3,l_tot_amt3_1
   IF cl_null(l_tot_amt)    THEN LET l_tot_amt = 0    END IF
   IF cl_null(l_tot_amt_1)  THEN LET l_tot_amt_1 = 0  END IF
   IF cl_null(l_tot_amt2)   THEN LET l_tot_amt2 = 0   END IF
   IF cl_null(l_tot_amt2_1) THEN LET l_tot_amt2_1 = 0 END IF
   IF cl_null(l_tot_amt3)   THEN LET l_tot_amt3 = 0   END IF
   IF cl_null(l_tot_amt3_1) THEN LET l_tot_amt3_1 = 0 END IF
   
   #11:總計
   INSERT INTO aglq942_tmp VALUES ('0','11',0,l_tot_sum,0,l_tot_amt,l_tot_amt_1,l_tot_amt2,l_tot_amt2_1,l_tot_amt3,l_tot_amt3_1) 
   
   #連帶三個空白銜接間接法表格
   IF g_input.l_rep_rule = '2' THEN
      INSERT INTO aglq942_tmp VALUES ('0','11','1','',0,'','','','','','') 
      INSERT INTO aglq942_tmp VALUES ('0','11','2','',0,'','','','','','') 
      INSERT INTO aglq942_tmp VALUES ('0','11','3','',0,'','','','','','') 
   END IF
   #-----------------------------------------------------------------------------
   
   #[間接法]----------------------------------------------------------------------
   LET l_sub_amt     = 0    #各活動產生的淨現金(本期)
   LET l_sub_amt_1   = 0    #各活動產生的淨現金(上期)
   LET l_sub_amt2    = 0    #各活動產生的淨現金(本期)(功能幣)
   LET l_sub_amt2_1  = 0    #各活動產生的淨現金(上期)(功能幣)
   LET l_sub_amt3    = 0    #各活動產生的淨現金(本期)(報告幣)
   LET l_sub_amt3_1  = 0    #各活動產生的淨現金(上期)(報告幣)
   LET l_tot_amt     = 0    #本期現金淨增數(本期)
   LET l_tot_amt_1   = 0    #本期現金淨增數(上期)
   LET l_tot_amt2    = 0    #本期現金淨增數(本期)(功能幣)
   LET l_tot_amt2_1  = 0    #本期現金淨增數(上期)(功能幣)
   LET l_tot_amt3    = 0    #本期現金淨增數(本期)(報告幣)
   LET l_tot_amt3_1  = 0    #本期現金淨增數(上期)(報告幣)
   LET l_this_amt    = 0    #本期餘額 (本期) 
   LET l_last_amt    = 0    #期初餘額 (本期)
   LET l_this_amt2   = 0    #本期餘額 (本期)(功能幣)
   LET l_last_amt2   = 0    #期初餘額 (本期)(功能幣)
   LET l_this_amt3   = 0    #本期餘額 (本期)(報告幣) 
   LET l_last_amt3   = 0    #期初餘額 (本期)(報告幣)
   LET l_this_amt_1  = 0    #本期餘額 (上期) 
   LET l_last_amt_1  = 0    #期初餘額 (上期)
   LET l_this_amt2_1 = 0    #本期餘額 (上期)(功能幣) 
   LET l_last_amt2_1 = 0    #期初餘額 (上期)(功能幣)
   LET l_this_amt3_1 = 0    #本期餘額 (上期)(報告幣) 
   LET l_last_amt3_1 = 0    #期初餘額 (上期)(報告幣)
   LET l_type = ''

   #寫入title--------------------------------------------------------
   LET l_title_1  = cl_getmsg('agl-00444',g_dlang)  #營業活動之現金流量
   LET l_title_2  = cl_getmsg('agl-00445',g_dlang)  #本期淨利(損)
   LET l_title_3  = cl_getmsg('agl-00446',g_dlang)  #調整項目
   LET l_title_4  = cl_getmsg('agl-00457',g_dlang)  #營運產生之現金流入(流出)
   LET l_title_5  = cl_getmsg('agl-00447',g_dlang)  #營業活動產生之淨現金
   LET l_title_6  = cl_getmsg('agl-00448',g_dlang)  #投資活動之現金流量
   LET l_title_7  = cl_getmsg('agl-00449',g_dlang)  #投資活動產生之淨現金
   LET l_title_8  = cl_getmsg('agl-00450',g_dlang)  #理財活動之現金流量
   LET l_title_9  = cl_getmsg('agl-00451',g_dlang)  #理財活動產生之淨現金
   LET l_title_10 = cl_getmsg('agl-00452',g_dlang)  #本期現金淨增數
   LET l_title_11 = cl_getmsg('agl-00453',g_dlang)  #匯率影響數
   LET l_title_12 = cl_getmsg('agl-00454',g_dlang)  #期初現金及約當現金餘額
   LET l_title_13 = cl_getmsg('agl-00455',g_dlang)  #期末現金及約當現金餘額
   LET l_title_14 = cl_getmsg('agl-00456',g_dlang)  #揭露事項 
   
   #151207-00020#19 --s mark
   #INSERT INTO aglq942_tmp VALUES ('1','0',l_title_1,'','','','','','','')
   #INSERT INTO aglq942_tmp VALUES ('2','0',l_title_2,'','','','','','','')
   #INSERT INTO aglq942_tmp VALUES ('3','0',l_title_3,'','','','','','','')
   #INSERT INTO aglq942_tmp VALUES ('4','0',l_title_4,'','','','','','','')
   #INSERT INTO aglq942_tmp VALUES ('6','0',l_title_6,'','','','','','','')
   #INSERT INTO aglq942_tmp VALUES ('8','0',l_title_8,'','','','','','','')
   #151207-00020#19 --e mark
   
   #151207-00020#19 --s add
   #多傳入第一個參數判斷報表內容
   INSERT INTO aglq942_tmp VALUES ('1','1','0',l_title_1,'','','','','','','')
   INSERT INTO aglq942_tmp VALUES ('1','2','0',l_title_2,'','','','','','','')
   INSERT INTO aglq942_tmp VALUES ('1','3','0',l_title_3,'','','','','','','')
   INSERT INTO aglq942_tmp VALUES ('1','4','0',l_title_4,'','','','','','','')
   INSERT INTO aglq942_tmp VALUES ('1','6','0',l_title_6,'','','','','','','')
   INSERT INTO aglq942_tmp VALUES ('1','8','0',l_title_8,'','','','','','','')
   #151207-00020#19 --e add
   
   #-----------------------------------------------------------------

   #取agli561 異動類型----
   LET l_sql= "SELECT glej003,",
              "       (SELECT glacl004 FROM glacl_t,glaa_t WHERE glaclent = ",g_enterprise," AND glacl001 = glaa004 ",
              "           AND glacl002 = glej003 AND glacl003 = '",g_dlang,"' AND glaald = glejld AND glaaent  = glaclent),",
              "       glej004,glej005 ",
              "  FROM glej_t ",
              " WHERE glejent = ",g_enterprise," ",
              "   AND glejld = '",g_input.b_glebld,"' ",
              "   AND glej001 = '",g_input.b_gleb001,"' ",
              "   AND glej002 = ? ",
              "  ORDER BY glej005 "
              
   PREPARE aglq942_glej_pr FROM l_sql
   DECLARE aglq942_glej_cs CURSOR FOR aglq942_glej_pr

   #[1].取agli560 變動分類----
   INITIALIZE l_glei.* TO NULL
   LET g_sql= " SELECT DISTINCT glei002,gleil004,glei003,glei004 ",
              "   FROM glei_t ",
              "   LEFT JOIN gleil_t ON gleilent=gleient AND gleil001=glei001 AND gleil002=glei002 AND gleil003='"||g_dlang||"' ",
              "  WHERE gleient = ",g_enterprise," ",
              "    AND glei001 = '",g_glaa135,"' ",  
              "  ORDER BY glei003,glei004,glei002,gleil004 "
   
   PREPARE aglq942_glei_pr FROM g_sql
   DECLARE aglq942_glei_cs CURSOR FOR aglq942_glei_pr
   FOREACH aglq942_glei_cs INTO l_glei.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aglq942_glei_cs"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF      

      LET l_i = l_i+1
      LET l_amt = 0         #本期數
      LET l_amt_1 = 0       #上期數
      LET l_amt2 = 0        #本期數(功能幣)
      LET l_amt2_1 = 0      #上期數(功能幣)
      LET l_amt3 = 0        #本期數(報告幣)
      LET l_amt3_1 = 0      #上期數(報告幣)

      LET l_amt_s = 0            
      LET l_amt_s_1 = 0     
      LET l_amt_s2 = 0     
      LET l_amt_s2_1 = 0
      LET l_amt_s3 = 0        
      LET l_amt_s3_1 = 0

      #依大類分寫入類別
      CASE l_glei.glei003
         WHEN 1 LET l_type = '3'
         WHEN 2 LET l_type = '1'
         WHEN 3 LET l_type = '4'
         WHEN 4 LET l_type = '6'
         WHEN 5 LET l_type = '8'
         WHEN 6 LET l_type = '121'
         WHEN 7 LET l_type = '131'
      END CASE

      #[2].取agli561 異動類型----
      INITIALIZE l_glej.* TO NULL
      FOREACH aglq942_glej_cs USING l_glei.glei002 INTO l_glej.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:aglq942_glej_cs"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF

         LET l_amt = 0         #本期數
         LET l_amt_1 = 0       #上期數
         LET l_amt2 = 0        #本期數(功能幣)
         LET l_amt2_1 = 0      #上期數(功能幣)
         LET l_amt3 = 0        #本期數(報告幣)
         LET l_amt3_1 = 0      #上期數(報告幣)
         
         #agli561之異動別
         CASE l_glej.glej005  
            WHEN 1
               CALL aglq942_gleb_type1(l_glej.glej003,g_input.b_gleb003,l_glei.glei002,'1') RETURNING l_amt,l_amt2,l_amt3    
               CALL aglq942_gleb_type1(l_glej.glej003,g_input.b_gleb003_1,l_glei.glei002,'1') RETURNING l_amt_1,l_amt2_1,l_amt3_1
            WHEN 2
               CALL aglq942_gleb_type1(l_glej.glej003,g_input.b_gleb003,l_glei.glei002,'2') RETURNING l_amt,l_amt2,l_amt3    
               CALL aglq942_gleb_type1(l_glej.glej003,g_input.b_gleb003_1,l_glei.glei002,'2') RETURNING l_amt_1,l_amt2_1,l_amt3_1
            WHEN 3
               CALL aglq942_gleb_type1(l_glej.glej003,g_input.b_gleb003,l_glei.glei002,'3') RETURNING l_amt,l_amt2,l_amt3    
               CALL aglq942_gleb_type1(l_glej.glej003,g_input.b_gleb003_1,l_glei.glei002,'3') RETURNING l_amt_1,l_amt2_1,l_amt3_1
            WHEN 4
               LET l_glac008 = ''
               SELECT glac008 INTO l_glac008 FROM glac_t WHERE glacent = g_enterprise AND glac001 = g_glaa004 AND glac002 = l_glej.glej003
               IF l_glac008 = '1' THEN
                  #本期數
                  SELECT SUM(glek008-glek009) INTO l_amt FROM glek_t
                   WHERE glekent = g_enterprise
                     AND glekld = g_input.b_glebld
                     AND glek001 = g_input.b_gleb001
                     AND glek002 = g_input.b_gleb003
                     AND glek003 BETWEEN g_gleb004_s AND g_gleb004_e
                     AND glek004 = l_glej_glej002
                     AND glek005 = l_glej_glej003
               
                  #上期數   
                  SELECT SUM(glek008-glek009) INTO l_amt_1 FROM glek_t
                   WHERE glekent = g_enterprise
                     AND glekld = g_input.b_glebld
                     AND glek001 = g_input.b_gleb001
                     AND glek002 = g_input.b_gleb003_1
                     AND glek003 BETWEEN g_gleb004_s AND g_gleb004_e
                     AND glek004 = l_glej_glej002
                     AND glek005 = l_glej_glej003 
               ELSE
                  #本期數
                  SELECT SUM(glek009-glek008) INTO l_amt FROM glek_t
                   WHERE glekent = g_enterprise
                     AND glekld = g_input.b_glebld
                     AND glek001 = g_input.b_gleb001
                     AND glek002 = g_input.b_gleb003
                     AND glek003 BETWEEN g_gleb004_s AND g_gleb004_e
                     AND glek004 = l_glej_glej002
                     AND glek005 = l_glej_glej003
                    
                   #上期數                    
                   SELECT SUM(glek009-glek008) INTO l_amt_1 FROM glek_t
                   WHERE glekent = g_enterprise
                     AND glekld = g_input.b_glebld
                     AND glek001 = g_input.b_gleb001
                     AND glek002 = g_input.b_gleb003_1
                     AND glek003 BETWEEN g_gleb004_s AND g_gleb004_e
                     AND glek004 = l_glej_glej002
                     AND glek005 = l_glej_glej003
               END IF
            WHEN 5
               CALL aglq942_gleb_type2(l_glej.glej003,g_input.b_gleb003,l_glei.glei002,'5') RETURNING l_amt,l_amt2,l_amt3    
               CALL aglq942_gleb_type2(l_glej.glej003,g_input.b_gleb003_1,l_glei.glei002,'5') RETURNING l_amt_1,l_amt2_1,l_amt3_1
            WHEN 6
               CALL aglq942_gleb_type2(l_glej.glej003,g_input.b_gleb003,l_glei.glei002,'6') RETURNING l_amt,l_amt2,l_amt3    
               CALL aglq942_gleb_type2(l_glej.glej003,g_input.b_gleb003_1,l_glei.glei002,'6') RETURNING l_amt_1,l_amt2_1,l_amt3_1
         END CASE
         
         IF cl_null(l_amt)    THEN LET l_amt    = 0 END IF #本期數
         IF cl_null(l_amt_1)  THEN LET l_amt_1  = 0 END IF #上期數
         IF cl_null(l_amt2)   THEN LET l_amt2   = 0 END IF #本期數(功能幣)
         IF cl_null(l_amt2_1) THEN LET l_amt2_1 = 0 END IF #上期數(功能幣)
         IF cl_null(l_amt3)   THEN LET l_amt3   = 0 END IF #本期數(報告幣)
         IF cl_null(l_amt3_1) THEN LET l_amt3_1 = 0 END IF #上期數(報告幣)
             
         #若為減項
         IF l_glej.glej004 = '2' THEN
            LET l_amt    = l_amt    * -1
            LET l_amt_1  = l_amt_1  * -1
            LET l_amt2   = l_amt2   * -1
            LET l_amt2_1 = l_amt2_1 * -1
            LET l_amt3   = l_amt3   * -1
            LET l_amt3_1 = l_amt3_1 * -1
         END IF
  
         LET l_amt_s = l_amt_s + l_amt
         LET l_amt_s_1 = l_amt_s_1 + l_amt_1
         LET l_amt_s2 = l_amt_s2 + l_amt2
         LET l_amt_s2_1 = l_amt_s2_1 + l_amt2_1         
         LET l_amt_s3 = l_amt_s3 + l_amt3
         LET l_amt_s3_1 = l_amt_s3_1 + l_amt3_1            
      END FOREACH

      #單位換算
      LET l_amt_s = l_amt_s/g_unit            
      LET l_amt_s_1 = l_amt_s_1/g_unit      
      LET l_amt_s2 = l_amt_s2/g_unit        
      LET l_amt_s2_1 = l_amt_s2_1/g_unit    
      LET l_amt_s3 = l_amt_s3/g_unit        
      LET l_amt_s3_1 = l_amt_s3_1/g_unit    
      
      #寫入群組金額------
      LET l_glei003 = ''
      SELECT gleil004 INTO l_glei003 FROM gleil_t 
       WHERE gleilent = g_enterprise AND gleil001 = g_glaa135 AND gleil002 = l_glei.glei002 AND gleil003 = g_dlang
      LET l_glei003 = "        ",l_glei003
      #INSERT INTO aglq942_tmp VALUES (l_type,l_i,l_glei003,l_i,l_amt_s,l_amt_s_1,l_amt_s2,l_amt_s2_1,l_amt_s3,l_amt_s3_1)      #151207-00020#19 mark
      INSERT INTO aglq942_tmp VALUES ('1',l_type,l_i,l_glei003,l_i,l_amt_s,l_amt_s_1,l_amt_s2,l_amt_s2_1,l_amt_s3,l_amt_s3_1)   #151207-00020#19 add
      
   END FOREACH
   
   
   #各活動產生的淨額計算------------------------------#########
   #依單一活動撈出匯總金額
   LET l_sql = " SELECT SUM(l_amt),SUM(l_amt_1),SUM(l_amt2),SUM(l_amt2_1),SUM(l_amt3),SUM(l_amt3_1) ",
               "   FROM aglq942_tmp ",
               "  WHERE l_seq = ? "
   PREPARE aglq942_sub_amt7_pr FROM l_sql
   DECLARE aglq942_sub_amt7_cs CURSOR FOR aglq942_sub_amt7_pr 
   
   #營業活動---
   LET l_sql = " SELECT SUM(l_amt),SUM(l_amt_1),SUM(l_amt2),SUM(l_amt2_1),SUM(l_amt3),SUM(l_amt3_1) ",
               "   FROM aglq942_tmp ",
               "  WHERE l_seq IN ('1','2','3','4') "
   PREPARE aglq942_sub_amt5_pr FROM l_sql
   DECLARE aglq942_sub_amt5_cs CURSOR FOR aglq942_sub_amt5_pr 
   EXECUTE aglq942_sub_amt5_cs INTO l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1
   IF cl_null(l_sub_amt)    THEN LET l_sub_amt = 0    END IF
   IF cl_null(l_sub_amt_1)  THEN LET l_sub_amt_1 = 0  END IF
   IF cl_null(l_sub_amt2)   THEN LET l_sub_amt2 = 0   END IF
   IF cl_null(l_sub_amt2_1) THEN LET l_sub_amt2_1 = 0 END IF
   IF cl_null(l_sub_amt3)   THEN LET l_sub_amt3 = 0   END IF
   IF cl_null(l_sub_amt3_1) THEN LET l_sub_amt3_1 = 0 END IF
   #INSERT INTO aglq942_tmp VALUES ('5',0,l_title_5,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1)    #151207-00020#19 mark
   INSERT INTO aglq942_tmp VALUES ('1','5',0,l_title_5,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1) #151207-00020#19 add  

   #投資活動---
   EXECUTE aglq942_sub_amt7_cs USING '6' INTO l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1
   IF cl_null(l_sub_amt)    THEN LET l_sub_amt = 0    END IF
   IF cl_null(l_sub_amt_1)  THEN LET l_sub_amt_1 = 0  END IF
   IF cl_null(l_sub_amt2)   THEN LET l_sub_amt2 = 0   END IF
   IF cl_null(l_sub_amt2_1) THEN LET l_sub_amt2_1 = 0 END IF
   IF cl_null(l_sub_amt3)   THEN LET l_sub_amt3 = 0   END IF
   IF cl_null(l_sub_amt3_1) THEN LET l_sub_amt3_1 = 0 END IF
   #INSERT INTO aglq942_tmp VALUES ('7',0,l_title_7,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1)    #151207-00020#19 mark
   INSERT INTO aglq942_tmp VALUES ('1','7',0,l_title_7,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1) #151207-00020#19 add

   #理財活動---
   EXECUTE aglq942_sub_amt7_cs USING '8' INTO l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1
   IF cl_null(l_sub_amt)    THEN LET l_sub_amt = 0    END IF
   IF cl_null(l_sub_amt_1)  THEN LET l_sub_amt_1 = 0  END IF
   IF cl_null(l_sub_amt2)   THEN LET l_sub_amt2 = 0   END IF
   IF cl_null(l_sub_amt2_1) THEN LET l_sub_amt2_1 = 0 END IF
   IF cl_null(l_sub_amt3)   THEN LET l_sub_amt3 = 0   END IF
   IF cl_null(l_sub_amt3_1) THEN LET l_sub_amt3_1 = 0 END IF
   #INSERT INTO aglq942_tmp VALUES ('9',0,l_title_9,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1)    #151207-00020#19 mark
   INSERT INTO aglq942_tmp VALUES ('1','9',0,l_title_9,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1) #151207-00020#19 add

   #期初---
   EXECUTE aglq942_sub_amt7_cs USING '121' INTO l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1
   IF cl_null(l_sub_amt)    THEN LET l_sub_amt = 0    END IF
   IF cl_null(l_sub_amt_1)  THEN LET l_sub_amt_1 = 0  END IF
   IF cl_null(l_sub_amt2)   THEN LET l_sub_amt2 = 0   END IF
   IF cl_null(l_sub_amt2_1) THEN LET l_sub_amt2_1 = 0 END IF
   IF cl_null(l_sub_amt3)   THEN LET l_sub_amt3 = 0   END IF
   IF cl_null(l_sub_amt3_1) THEN LET l_sub_amt3_1 = 0 END IF
   #INSERT INTO aglq942_tmp VALUES ('12',0,l_title_12,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1)    #151207-00020#19 mark
   INSERT INTO aglq942_tmp VALUES ('1','12',0,l_title_12,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1) #151207-00020#19 add

   #期初---
   EXECUTE aglq942_sub_amt7_cs USING '131' INTO l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1
   IF cl_null(l_sub_amt)    THEN LET l_sub_amt = 0    END IF
   IF cl_null(l_sub_amt_1)  THEN LET l_sub_amt_1 = 0  END IF
   IF cl_null(l_sub_amt2)   THEN LET l_sub_amt2 = 0   END IF
   IF cl_null(l_sub_amt2_1) THEN LET l_sub_amt2_1 = 0 END IF
   IF cl_null(l_sub_amt3)   THEN LET l_sub_amt3 = 0   END IF
   IF cl_null(l_sub_amt3_1) THEN LET l_sub_amt3_1 = 0 END IF
   #INSERT INTO aglq942_tmp VALUES ('13',0,l_title_13,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1)    #151207-00020#19 mark
   INSERT INTO aglq942_tmp VALUES ('1','13',0,l_title_13,0,l_sub_amt,l_sub_amt_1,l_sub_amt2,l_sub_amt2_1,l_sub_amt3,l_sub_amt3_1) #151207-00020#19 add

   #本期現金淨增數計算------------------------------#########
   LET l_sql = " SELECT SUM(l_amt),SUM(l_amt_1),SUM(l_amt2),SUM(l_amt2_1),SUM(l_amt3),SUM(l_amt3_1) ",
               "   FROM aglq942_tmp ",
               "  WHERE l_seq IN ('5','7','9') "
   PREPARE aglq942_sub_amt10_pr FROM l_sql
   DECLARE aglq942_sub_amt10_cs CURSOR FOR aglq942_sub_amt10_pr 
   EXECUTE aglq942_sub_amt10_cs INTO l_tot_amt,l_tot_amt_1,l_tot_amt2,l_tot_amt2_1,l_tot_amt3,l_tot_amt3_1
   IF cl_null(l_tot_amt)    THEN LET l_tot_amt = 0    END IF
   IF cl_null(l_tot_amt_1)  THEN LET l_tot_amt_1 = 0  END IF
   IF cl_null(l_tot_amt2)   THEN LET l_tot_amt2 = 0   END IF
   IF cl_null(l_tot_amt2_1) THEN LET l_tot_amt2_1 = 0 END IF
   IF cl_null(l_tot_amt3)   THEN LET l_tot_amt3 = 0   END IF
   IF cl_null(l_tot_amt3_1) THEN LET l_tot_amt3_1 = 0 END IF
   #INSERT INTO aglq942_tmp VALUES ('10',0,l_title_10,0,l_tot_amt,l_tot_amt_1,l_tot_amt2,l_tot_amt2_1,l_tot_amt3,l_tot_amt3_1)    #151207-00020#19 mark
   INSERT INTO aglq942_tmp VALUES ('1','10',0,l_title_10,0,l_tot_amt,l_tot_amt_1,l_tot_amt2,l_tot_amt2_1,l_tot_amt3,l_tot_amt3_1) #151207-00020#19 add
   
   
   #匯率影響數計算------------------------------#########
   #期末
   EXECUTE aglq942_sub_amt7_cs USING '131' INTO l_last_amt,l_last_amt_1,l_last_amt2,l_last_amt2_1,l_last_amt3,l_last_amt3_1
   IF cl_null(l_last_amt)    THEN LET l_last_amt = 0    END IF
   IF cl_null(l_last_amt_1)  THEN LET l_last_amt_1 = 0  END IF
   IF cl_null(l_last_amt2)   THEN LET l_last_amt2 = 0   END IF
   IF cl_null(l_last_amt2_1) THEN LET l_last_amt2_1 = 0 END IF
   IF cl_null(l_last_amt3)   THEN LET l_last_amt3 = 0   END IF
   IF cl_null(l_last_amt3_1) THEN LET l_last_amt3_1 = 0 END IF
   
   #期初+淨增數
   LET l_sql = " SELECT SUM(l_amt),SUM(l_amt_1),SUM(l_amt2),SUM(l_amt2_1),SUM(l_amt3),SUM(l_amt3_1) ",
               "   FROM aglq942_tmp ",
               "  WHERE l_seq IN ('10','12') "
   PREPARE aglq942_sub_amt11_pr1 FROM l_sql
   DECLARE aglq942_sub_amt11_cs1 CURSOR FOR aglq942_sub_amt11_pr1 
   EXECUTE aglq942_sub_amt11_cs1 INTO l_this_amt,l_this_amt_1,l_this_amt2,l_this_amt2_1,l_this_amt3,l_this_amt3_1
   IF cl_null(l_this_amt)    THEN LET l_this_amt = 0    END IF
   IF cl_null(l_this_amt_1)  THEN LET l_this_amt_1 = 0  END IF
   IF cl_null(l_this_amt2)   THEN LET l_this_amt2 = 0   END IF
   IF cl_null(l_this_amt2_1) THEN LET l_this_amt2_1 = 0 END IF
   IF cl_null(l_this_amt3)   THEN LET l_this_amt3 = 0   END IF
   IF cl_null(l_this_amt3_1) THEN LET l_this_amt3_1 = 0 END IF

   #INSERT INTO aglq942_tmp VALUES ('11',0,l_title_11,0,l_last_amt-l_this_amt,l_last_amt_1-l_this_amt_1,l_last_amt2-l_this_amt2,l_last_amt2_1-l_this_amt2_1,l_last_amt3-l_this_amt3,l_last_amt3_1-l_this_amt3_1)    #151207-00020#19 mark
   INSERT INTO aglq942_tmp VALUES ('1','11',0,l_title_11,0,l_last_amt-l_this_amt,l_last_amt_1-l_this_amt_1,l_last_amt2-l_this_amt2,l_last_amt2_1-l_this_amt2_1,l_last_amt3-l_this_amt3,l_last_amt3_1-l_this_amt3_1) #151207-00020#19 add

   #附註揭露------------------------------#########
   IF g_input.l_s = 'Y' THEN
      #INSERT INTO aglq942_tmp VALUES ('14','0',l_title_14,'','','','','','','')     #151207-00020#19 mark
      INSERT INTO aglq942_tmp VALUES ('3','14','0',l_title_14,'','','','','','','')  #151207-00020#19 add 類型3表示附註揭露
      CALL aglq942_gldz_amt()
   END IF

END FUNCTION

################################################################################
# Descriptions...: 異動金額計算
# Memo...........:
# Usage..........: CALL aglq942_gleb_type1(p_glej003,p_gleb003,p_glei002,p_flag)
# Date & Author..: 160524 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_gleb_type1(p_glej003,p_gleb003,p_glei002,p_flag)
DEFINE p_glej003   LIKE glej_t.glej003      #科目
DEFINE p_gleb003   LIKE gleb_t.gleb003      #年度
DEFINE p_glei002   LIKE glei_t.glei002      #群組
DEFINE p_flag      LIKE type_t.chr1         #判斷傳入異動別
DEFINE l_y         LIKE gleb_t.gleb003      #年度條件 
DEFINE l_m         LIKE gleb_t.gleb004      #期別條件
DEFINE l_sql       STRING     
DEFINE l_cnt       LIKE type_t.num10
DEFINE l_amt       LIKE type_t.num10        #截止該期金額(記帳幣)
DEFINE l_amt2      LIKE type_t.num10        #截止該期金額(功能幣)
DEFINE l_amt3      LIKE type_t.num10        #截止該期金額(報告幣)
DEFINE l_amt1      LIKE type_t.num10        #小於起始之最大期別金額(記帳幣)
DEFINE l_amt21     LIKE type_t.num10        #小於起始之最大期別金額(功能幣)
DEFINE l_amt31     LIKE type_t.num10        #小於起始之最大期別金額(報告幣)
DEFINE l_gleb005   LIKE gleb_t.gleb005
DEFINE l_glel001   LIKE glel_t.glel001
DEFINE r_amt       LIKE type_t.num10        #金額(記帳幣)
DEFINE r_amt2      LIKE type_t.num10        #金額(功能幣)
DEFINE r_amt3      LIKE type_t.num10        #金額(報告幣)

   LET r_amt = 0
   LET r_amt2 = 0
   LET r_amt3 = 0

   LET l_amt   = 0
   LET l_amt2  = 0
   LET l_amt3  = 0
   LET l_amt1  = 0
   LET l_amt21 = 0
   LET l_amt31 = 0
   LET l_cnt = 0
      
   #筆數_BS損益類開帳資料(agli563)
   LET l_sql  = " SELECT COUNT(1) ",
                "   FROM glel_t ",
                "  WHERE glelent = ",g_enterprise," AND glelld = '",g_input.b_glebld,"'  ",
                "    AND glel001 = '",g_input.b_gleb001,"' AND glel002 = '",p_gleb003,"' AND glel003 = '0' "
   DECLARE aglp850_glel_cnt_c CURSOR FROM l_sql

   #BS損益類開帳資料(agli563)
   LET l_sql  = " SELECT glel001,CASE(SELECT glac008 FROM glac_t WHERE glacent = glelent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(glel005-glel006) ELSE SUM(glel006-glel005) END, ",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glelent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(glel008-glel009) ELSE SUM(glel009-glel008) END, ",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glelent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(glel011-glel012) ELSE SUM(glel012-glel011) END ",
                "   FROM glel_t ",
                "  WHERE glelent = ",g_enterprise," AND glelld = '",g_input.b_glebld,"'  ",
                "    AND glel001 = '",g_input.b_gleb001,"' AND glel002 = '",p_gleb003,"' AND glel003 = '0' ",
                "  GROUP BY glel001,glelent "
   DECLARE aglp850_glel_c CURSOR FROM l_sql

   #筆數_資產類開帳資料(agli564)
   LET l_sql  = " SELECT COUNT(1) ",
                "   FROM glem_t ",
                "  WHERE glement = ",g_enterprise," AND glemld = '",g_input.b_glebld,"'  ",
                "    AND glem001 = '",g_input.b_gleb001,"' AND glem002 = '",p_gleb003,"' AND glem003 = '0' ",
                "    AND glem004 = '",p_glei002,"' AND glem005 = '",p_glej003,"' "
   DECLARE aglp850_glem_cnt_c CURSOR FROM l_sql

   #資產類開帳資料(agli564)
   LET l_sql  = " SELECT glem005,CASE(SELECT glac008 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(glem007-glem008) ELSE SUM(glem008-glem007) END, ",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(glem010-glem011) ELSE SUM(glem011-glem010) END,",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glement AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(glem013-glem014) ELSE SUM(glem014-glem013) END ",
                "   FROM glem_t ",
                "  WHERE glement = ",g_enterprise," AND glemld = '",g_input.b_glebld,"'  ",
                "    AND glem001 = '",g_input.b_gleb001,"' AND glem002 = '",p_gleb003,"' AND glem003 = '0' ",
                "    AND glem004 = '",p_glei002,"' AND glem005 = '",p_glej003,"' ",
                "  GROUP BY glem005,glement "
   DECLARE aglp850_glem_c CURSOR FROM l_sql


   #餘額檔gleb_t資料_截止期別
   LET l_sql  = " SELECT gleb005,CASE(SELECT glac008 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(gleb008-gleb009) ELSE SUM(gleb009-gleb008) END,",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(gleb027-gleb028) ELSE SUM(gleb028-gleb027) END,",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(gleb030-gleb031) ELSE SUM(gleb031-gleb030) END ",
                "   FROM gleb_t ",
                "  WHERE glebent = ",g_enterprise," AND glebld = '",g_input.b_glebld,"'  ",
                "    AND gleb001 = '",g_input.b_gleb001,"' AND gleb003 =  ? AND gleb004 = ?  ",
                "    AND gleb005 = '",p_glej003,"' ",
                "  GROUP BY gleb005,glebent "
   DECLARE aglp850_gleb_c CURSOR FROM l_sql
   
   #餘額檔gleb_t資料_小於起始之最大期別
   LET l_sql  = " SELECT gleb005,CASE(SELECT glac008 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(gleb008-gleb009) ELSE SUM(gleb009-gleb008) END,",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(gleb027-gleb028) ELSE SUM(gleb028-gleb027) END,",
                "   CASE(SELECT glac008 FROM glac_t WHERE glacent = glebent AND glac001 = '",g_glaa004,"' AND glac002 = '",p_glej003,"')  ",
                "   WHEN '1' THEN SUM(gleb030-gleb031) ELSE SUM(gleb031-gleb030) END ",
                "   FROM gleb_t ",
                "  WHERE glebent = ",g_enterprise," AND glebld = '",g_input.b_glebld,"'  ",
                "    AND gleb001 = '",g_input.b_gleb001,"' AND gleb003 =  ? ",
                "    AND gleb004 IN (SELECT MAX(gleb004) FROM gleb_t ",
                "                     WHERE glebent = ",g_enterprise," AND glebld = '",g_input.b_glebld,"'  ",
                "                       AND gleb001 = '",g_input.b_gleb001,"' AND gleb003 = ? ",
                "                       AND gleb004 <= ? AND gleb005 = '",p_glej003,"' ) ",
                "    AND gleb005 = '",p_glej003,"' ",
                "  GROUP BY gleb005,glebent "
   DECLARE aglp850_gleb_1_c CURSOR FROM l_sql

   #取得年度期別條件--------------------------
   IF g_gleb004_s = 1 THEN
      LET l_y = p_gleb003 - 1
      LET l_m = ''  
      #獲取當年度會計週期最大期別
      SELECT MAX(glav006) INTO l_m FROM glav_t 
      WHERE glavent = g_enterprise AND glav001 = g_glaa003 AND glav002 = l_y
   ELSE
      LET l_y = p_gleb003
      LET l_m = g_gleb004_s - 1
   END IF
   
   #小於起始期別之最大期別之金額計算-------------
   #取期初開帳資料，無則改取餘額檔
   IF p_glej003 = g_glab005bs THEN
      EXECUTE aglp850_glel_cnt_c INTO l_cnt
   ELSE
      EXECUTE aglp850_glem_cnt_c INTO l_cnt
   END IF

   IF l_cnt > 0 THEN
      IF p_glej003 = g_glab005bs THEN
         EXECUTE aglp850_glel_c INTO l_glel001,l_amt1,l_amt21,l_amt31
      ELSE
         EXECUTE aglp850_glem_c INTO l_gleb005,l_amt1,l_amt21,l_amt31
      END IF
   ELSE
      EXECUTE aglp850_gleb_1_c USING l_y,l_y,l_m INTO l_gleb005,l_amt1,l_amt21,l_amt31
   END IF

   #截止期別之金額計算-------------------------
   EXECUTE aglp850_gleb_c USING p_gleb003,g_gleb004_e INTO l_gleb005,l_amt,l_amt2,l_amt3
   
   IF cl_null(l_amt) THEN LET l_amt = 0 END IF
   IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
   IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
   IF cl_null(l_amt21) THEN LET l_amt21 = 0 END IF
   IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
   IF cl_null(l_amt31) THEN LET l_amt31 = 0 END IF   
   
   #依異動別回傳值
   CASE p_flag 
      #異動
      WHEN 1   
         LET r_amt = l_amt - l_amt1
         LET r_amt2 = l_amt2 - l_amt21
         LET r_amt3 = l_amt3 - l_amt31
         RETURN r_amt,r_amt2,r_amt3 
      #期初
      WHEN 2   
         LET r_amt = l_amt1
         LET r_amt2 = l_amt21
         LET r_amt3 = l_amt31
         RETURN r_amt,r_amt2,r_amt3 
      #期末
      WHEN 3   
         LET r_amt = l_amt
         LET r_amt2 = l_amt2
         LET r_amt3 = l_amt3
         RETURN r_amt,r_amt2,r_amt3 
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 期初金額計算
# Memo...........:
# Usage..........: CALL aglq942_gleb_type2(p_glej003,p_gleb003,p_glei002,p_flag)
# Date & Author..: 160527 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_gleb_type2(p_glej003,p_gleb003,p_glei002,p_flag)
DEFINE p_glej003   LIKE glej_t.glej003      #科目
DEFINE p_gleb003   LIKE gleb_t.gleb003      #年度
DEFINE p_glei002   LIKE glei_t.glei002      #群組
DEFINE p_flag      LIKE type_t.chr1         #判斷傳入異動別
DEFINE l_y         LIKE gleb_t.gleb003      #年度條件 
DEFINE l_m         LIKE gleb_t.gleb004      #期別條件
DEFINE l_sql       STRING     
DEFINE l_cnt       LIKE type_t.num10
DEFINE r_amt       LIKE type_t.num10        #金額(記帳幣)
DEFINE r_amt2      LIKE type_t.num10        #金額(功能幣)
DEFINE r_amt3      LIKE type_t.num10        #金額(報告幣)
DEFINE l_gleb008   LIKE gleb_t.gleb008      #截止該期借方金額(記帳幣)
DEFINE l_gleb009   LIKE gleb_t.gleb009      #截止該期貸方金額(記帳幣)
DEFINE l_gleb027   LIKE gleb_t.gleb027      #截止該期借方金額(功能幣)
DEFINE l_gleb028   LIKE gleb_t.gleb028      #截止該期貸方金額(功能幣)
DEFINE l_gleb030   LIKE gleb_t.gleb030      #截止該期借方金額(報告幣)
DEFINE l_gleb031   LIKE gleb_t.gleb031      #截止該期貸方金額(報告幣)
DEFINE l_gleb0081  LIKE gleb_t.gleb008      #小於起始之最大期別借方金額(記帳幣)
DEFINE l_gleb0091  LIKE gleb_t.gleb009      #小於起始之最大期別貸方金額(記帳幣)
DEFINE l_gleb0271  LIKE gleb_t.gleb027      #小於起始之最大期別借方金額(功能幣)
DEFINE l_gleb0281  LIKE gleb_t.gleb028      #小於起始之最大期別貸方金額(功能幣)
DEFINE l_gleb0301  LIKE gleb_t.gleb030      #小於起始之最大期別借方金額(報告幣)
DEFINE l_gleb0311  LIKE gleb_t.gleb031      #小於起始之最大期別貸方金額(報告幣)


   LET r_amt = 0
   LET r_amt2 = 0
   LET r_amt3 = 0

   LET l_gleb008  = 0
   LET l_gleb009  = 0
   LET l_gleb027  = 0
   LET l_gleb028  = 0
   LET l_gleb030  = 0
   LET l_gleb031  = 0
   LET l_gleb0081 = 0
   LET l_gleb0091 = 0
   LET l_gleb0271 = 0
   LET l_gleb0281 = 0
   LET l_gleb0301 = 0
   LET l_gleb0311 = 0
   LET l_cnt = 0

   #筆數_BS損益類開帳資料(agli563)
   LET l_sql  = " SELECT COUNT(1) ",
                "   FROM glel_t ",
                "  WHERE glelent = ",g_enterprise," AND glelld = '",g_input.b_glebld,"'  ",
                "    AND glel001 = '",g_input.b_gleb001,"' AND glel002 = '",p_gleb003,"' AND glel003 = '0' "
   DECLARE aglp850_glel_cnt_c1 CURSOR FROM l_sql

   #BS損益類開帳資料(agli563)
   LET l_sql  = " SELECT glel005,glel006,glel008,glel009,glel011,glel012 ",
                "   FROM glel_t ",
                "  WHERE glelent = ",g_enterprise," AND glelld = '",g_input.b_glebld,"'  ",
                "    AND glel001 = '",g_input.b_gleb001,"' AND glel002 = '",p_gleb003,"' AND glel003 = '0' "
   DECLARE aglp850_glel_c1 CURSOR FROM l_sql
   
   #筆數_資產類開帳資料(agli564)
   LET l_sql  = " SELECT COUNT(1) ",
                "   FROM glem_t ",
                "  WHERE glement = ",g_enterprise," AND glemld = '",g_input.b_glebld,"'  ",
                "    AND glem001 = '",g_input.b_gleb001,"' AND glem002 = '",p_gleb003,"' AND glem003 = '0' ",
                "    AND glem004 = '",p_glei002,"' AND glem005 = '",p_glej003,"' "
   DECLARE aglp850_glem_cnt_c1 CURSOR FROM l_sql

   #資產類開帳資料(agli564)
   LET l_sql  = " SELECT glem007,glem008,glem010,glem011,glem013,glem014 ",
                "   FROM glem_t ",
                "  WHERE glement = ",g_enterprise," AND glemld = '",g_input.b_glebld,"'  ",
                "    AND glem001 = '",g_input.b_gleb001,"' AND glem002 = '",p_gleb003,"' AND glem003 = '0' ",
                "    AND glem004 = '",p_glei002,"' AND glem005 = '",p_glej003,"' "
   DECLARE aglp850_glem_c1 CURSOR FROM l_sql

   #餘額檔gleb_t資料
   LET l_sql  = " SELECT gleb008,gleb009,gleb027,gleb028,gleb030,gleb031 ",
                "   FROM gleb_t ",
                "  WHERE glebent = ",g_enterprise," AND glebld = '",g_input.b_glebld,"'  ",
                "    AND gleb001 = '",g_input.b_gleb001,"' AND gleb003 =  ? AND gleb004 = ?  ",
                "    AND gleb005 = '",p_glej003,"' "
   DECLARE aglp850_gleb_c1 CURSOR FROM l_sql
   
   #餘額檔gleb_t資料_小於起始之最大期別
   LET l_sql  = " SELECT gleb008,gleb009,gleb027,gleb028,gleb030,gleb031 ",
                "   FROM gleb_t ",
                "  WHERE glebent = ",g_enterprise," AND glebld = '",g_input.b_glebld,"'  ",
                "    AND gleb001 = '",g_input.b_gleb001,"' AND gleb003 =  ? ",
                "    AND gleb004 IN (SELECT MAX(gleb004) FROM gleb_t ",
                "                     WHERE glebent = ",g_enterprise," AND glebld = '",g_input.b_glebld,"'  ",
                "                       AND gleb001 = '",g_input.b_gleb001,"' AND gleb003 = ? ",
                "                       AND gleb004 <= ? AND gleb005 = '",p_glej003,"' ) ",
                "    AND gleb005 = '",p_glej003,"' "
   DECLARE aglp850_gleb_1_c1 CURSOR FROM l_sql


   #取得年度期別條件--------------------------
   IF g_gleb004_s = 1 THEN
      LET l_y = p_gleb003 - 1
      LET l_m = ''  
      #獲取當年度會計週期最大期別
      SELECT MAX(glav006) INTO l_m FROM glav_t 
      WHERE glavent = g_enterprise AND glav001 = g_glaa003 AND glav002 = l_y
   ELSE
      LET l_y = p_gleb003
      LET l_m = g_gleb004_s - 1
   END IF
   
   #小於起始期別之最大期別之金額計算-------------
   #取期初開帳資料，無則改取餘額檔
   IF p_glej003 = g_glab005bs THEN
      EXECUTE aglp850_glel_cnt_c1 INTO l_cnt
   ELSE
      EXECUTE aglp850_glem_cnt_c1 INTO l_cnt
   END IF

   IF l_cnt > 0 THEN
      IF p_glej003 = g_glab005bs THEN
         EXECUTE aglp850_glel_c1 INTO l_gleb0081,l_gleb0091,l_gleb0271,l_gleb0281,l_gleb0301,l_gleb0311
      ELSE
         EXECUTE aglp850_glem_c1 INTO l_gleb0081,l_gleb0091,l_gleb0271,l_gleb0281,l_gleb0301,l_gleb0311
      END IF
   ELSE
      EXECUTE aglp850_gleb_1_c1 USING l_y,l_y,l_m INTO l_gleb0081,l_gleb0091,l_gleb0271,l_gleb0281,l_gleb0301,l_gleb0311
   END IF

   #截止期別之金額計算-------------------------
   EXECUTE aglp850_gleb_c USING p_gleb003,g_gleb004_e INTO l_gleb008,l_gleb009,l_gleb027,l_gleb028,l_gleb030,l_gleb031
   
   IF cl_null(l_gleb008) THEN LET l_gleb008 = 0 END IF
   IF cl_null(l_gleb009) THEN LET l_gleb009 = 0 END IF
   IF cl_null(l_gleb027) THEN LET l_gleb027 = 0 END IF
   IF cl_null(l_gleb028) THEN LET l_gleb028 = 0 END IF
   IF cl_null(l_gleb030) THEN LET l_gleb030 = 0 END IF
   IF cl_null(l_gleb031) THEN LET l_gleb031 = 0 END IF   
   IF cl_null(l_gleb0081) THEN LET l_gleb0081 = 0 END IF
   IF cl_null(l_gleb0091) THEN LET l_gleb0091 = 0 END IF
   IF cl_null(l_gleb0271) THEN LET l_gleb0271 = 0 END IF
   IF cl_null(l_gleb0281) THEN LET l_gleb0281 = 0 END IF
   IF cl_null(l_gleb0301) THEN LET l_gleb0301 = 0 END IF
   IF cl_null(l_gleb0311) THEN LET l_gleb0311 = 0 END IF 

   #依異動別回傳值
   CASE p_flag 
      #借方異動
      WHEN 5
         LET r_amt = l_gleb008 - l_gleb0081
         LET r_amt2 = l_gleb027 - l_gleb0271
         LET r_amt3 = l_gleb030 - l_gleb0301
         RETURN r_amt,r_amt2,r_amt3 
         
      #貸方異動
      WHEN 6  
         LET r_amt = l_gleb009 - l_gleb0091
         LET r_amt2 = l_gleb028 - l_gleb0281
         LET r_amt3 = l_gleb031 - l_gleb0311
         RETURN r_amt,r_amt2,r_amt3 
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 附註揭露
# Memo...........:
# Usage..........: CALL aglq942_gldz_amt()
# Date & Author..: 160530 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_gldz_amt()
DEFINE l_sql          STRING     
DEFINE l_sql1         STRING  
DEFINE l_i            LIKE type_t.num10        #行數   
DEFINE l_gldz005      LIKE gldz_t.gldz005 
DEFINE l_gldz006      LIKE gldz_t.gldz006 
DEFINE l_gldz005_1    LIKE gldz_t.gldz005 
DEFINE l_gldz006_1    LIKE gldz_t.gldz006 
DEFINE l_glei003      LIKE type_t.chr500       #項目
DEFINE l_amt_glbg     LIKE type_t.num20_6      #附註揭露本期數
DEFINE l_amt_glbg_1   LIKE type_t.num20_6      #附註揭露上期數  
DEFINE l_amt_glbg2    LIKE type_t.num20_6      #附註揭露本期數(功能幣)
DEFINE l_amt_glbg2_1  LIKE type_t.num20_6      #附註揭露上期數(功能幣)  
DEFINE l_amt_glbg3    LIKE type_t.num20_6      #附註揭露本期數(報告幣)
DEFINE l_amt_glbg3_1  LIKE type_t.num20_6      #附註揭露上期數(報告幣)

   LET l_i = 0
   
   LET l_amt_glbg    = 0    #揭露本期數
   LET l_amt_glbg_1  = 0    #揭露上期數  
   LET l_amt_glbg2   = 0    #揭露本期數(功能幣)
   LET l_amt_glbg2_1 = 0    #揭露上期數(功能幣)  
   LET l_amt_glbg3   = 0    #揭露本期數(報告幣)
   LET l_amt_glbg3_1 = 0    #揭露上期數(報告幣)
   LET l_glei003 = ''
   LET l_gldz005 = ''
   LET l_gldz006 = ''
   

   #相同揭露說明者---------------
   #本期
   LET l_sql = " SELECT gldz005,gldz006,SUM(gldz007),SUM(gldz009),SUM(gldz011) ",
               "   FROM gldz_t ",
               "  WHERE gldzent = ",g_enterprise," ",
               "    AND gldzld = '",g_input.b_glebld,"' ",
               "    AND gldz001 = '",g_input.b_gleb001,"' ",
               "    AND gldz002 = '3' ", #現金流量表
               "    AND gldz003 = '",g_input.b_gleb003,"' ",
               "    AND gldz004 BETWEEN '",g_gleb004_s,"' AND '",g_gleb004_e,"' ",
               "  GROUP BY gldz005,gldz006 ",
               "  ORDER BY gldz005,gldz006 "
   DECLARE aglq942_gldz_amt_c CURSOR FROM l_sql
   FOREACH aglq942_gldz_amt_c INTO l_gldz005,l_gldz006,l_amt_glbg,l_amt_glbg2,l_amt_glbg3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aglq942_gldz_amt_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_i = l_i +1
      LET l_amt_glbg_1  = 0    #揭露上期數  
      LET l_amt_glbg2_1 = 0    #揭露上期數(功能幣)  
      LET l_amt_glbg3_1 = 0    #揭露上期數(報告幣)

      #上期
      #170207-00018#1  170209  By 08734 mark(S)
      #LET l_sql1 = " SELECT gldz005,gldz006,SUM(gldz007),SUM(gldz009),SUM(gldz011) ",
      #             "   FROM gldz_t ",
      #             "  WHERE gldzent = ",g_enterprise," ",
      #             "    AND gldzld = '",g_input.b_glebld,"' ",
      #             "    AND gldz001 = '",g_input.b_gleb001,"' ",
      #             "    AND gldz002 = '3' ", #現金流量表
      #             "    AND gldz003 = '",g_input.b_gleb003_1,"' ",
      #             "    AND gldz004 BETWEEN '",g_gleb004_s,"' AND '",g_gleb004_e,"' ",
      #             "    AND gldz006 = ? ",
      #             #如有相同名稱會只取一筆的金額(同TT做法)
      #             "    AND rownum = '1' ",
      #             "  GROUP BY gldz005,gldz006 ",
      #             "  ORDER BY gldz005,gldz006 "
      #170207-00018#1  170209  By 08734 mark(E)       
      #170207-00018#1  170209  By 08734 add(S)     
      LET l_sql1 = " SELECT a.gldz005,a.gldz006,a.g007,a.g009,a.g011 FROM ( ",
                   " SELECT gldz005,gldz006,SUM(gldz007) AS g007,SUM(gldz009) AS g009,SUM(gldz011) AS g011",
                   "   FROM gldz_t ",
                   "  WHERE gldzent = ",g_enterprise," ",
                   "    AND gldzld = '",g_input.b_glebld,"' ",
                   "    AND gldz001 = '",g_input.b_gleb001,"' ",
                   "    AND gldz002 = '3' ", #現金流量表
                   "    AND gldz003 = '",g_input.b_gleb003_1,"' ",
                   "    AND gldz004 BETWEEN '",g_gleb004_s,"' AND '",g_gleb004_e,"' ",
                   "    AND gldz006 = ? ",
                   "  GROUP BY gldz005,gldz006 ",
                   "  ORDER BY gldz005,gldz006) a ",
                   " WHERE rownum = '1' "             #如有相同名稱會只取一筆的金額(同TT做法)
      #170207-00018#1  170209  By 08734 add(E)
      
      DECLARE aglq942_gldz_amt2_c CURSOR FROM l_sql1 
      EXECUTE aglq942_gldz_amt2_c USING l_gldz006 INTO l_gldz005_1,l_gldz006_1,l_amt_glbg_1,l_amt_glbg2_1,l_amt_glbg3_1

      IF cl_null(l_amt_glbg) THEN LET l_amt_glbg = 0 END IF
      IF cl_null(l_amt_glbg_1) THEN LET l_amt_glbg_1 = 0 END IF
      IF cl_null(l_amt_glbg2) THEN LET l_amt_glbg2 = 0 END IF
      IF cl_null(l_amt_glbg2_1) THEN LET l_amt_glbg2_1 = 0 END IF
      IF cl_null(l_amt_glbg3) THEN LET l_amt_glbg3 = 0 END IF
      IF cl_null(l_amt_glbg3_1) THEN LET l_amt_glbg3_1 = 0 END IF  
      
      LET l_amt_glbg = l_amt_glbg/g_unit            
      LET l_amt_glbg_1 = l_amt_glbg_1/g_unit      
      LET l_amt_glbg2 = l_amt_glbg2/g_unit        
      LET l_amt_glbg2_1 = l_amt_glbg2_1/g_unit    
      LET l_amt_glbg3 = l_amt_glbg3/g_unit        
      LET l_amt_glbg3_1 = l_amt_glbg3_1/g_unit 
      
      LET l_glei003 = "        ",l_gldz006
      #INSERT INTO aglq942_tmp VALUES ('14',l_i,l_glei003,l_i,l_amt_glbg,l_amt_glbg_1,l_amt_glbg2,l_amt_glbg2_1,l_amt_glbg3,l_amt_glbg3_1)    #151207-00020#19 mark
      INSERT INTO aglq942_tmp VALUES ('3','14',l_i,l_glei003,l_i,l_amt_glbg,l_amt_glbg_1,l_amt_glbg2,l_amt_glbg2_1,l_amt_glbg3,l_amt_glbg3_1) #151207-00020#19 add
   END FOREACH

   #上期_不同揭露說明者---------------
   LET l_amt_glbg    = 0   
   LET l_amt_glbg_1  = 0   
   LET l_amt_glbg2   = 0   
   LET l_amt_glbg2_1 = 0   
   LET l_amt_glbg3   = 0   
   LET l_amt_glbg3_1 = 0 
   LET l_glei003 = ''   
   LET l_gldz005_1 = ''
   LET l_gldz006_1 = ''
   
   LET l_sql = " SELECT gldz005,gldz006,SUM(gldz007),SUM(gldz009),SUM(gldz011) ",
               "   FROM gldz_t ",
               "  WHERE gldzent = ",g_enterprise," ",
               "    AND gldzld = '",g_input.b_glebld,"' ",
               "    AND gldz001 = '",g_input.b_gleb001,"' ",
               "    AND gldz002 = '3' ", #現金流量表
               "    AND gldz003 = '",g_input.b_gleb003_1,"' ",
               "    AND gldz004 BETWEEN '",g_gleb004_s,"' AND '",g_gleb004_e,"' ",
               "    AND gldz006 NOT IN(SELECT DISTINCT gldz006 FROM gldz_t WHERE gldzent = ",g_enterprise,"  ",
               "                          AND gldzld = '",g_input.b_glebld,"' AND gldz001 = '",g_input.b_gleb001,"'  ",
               "                          AND gldz002 = '3' AND gldz003 = '",g_input.b_gleb003,"'   ",
               "                          AND gldz004 BETWEEN '",g_gleb004_s,"' AND '",g_gleb004_e,"') ",
               "  GROUP BY gldz005,gldz006 ",
               "  ORDER BY gldz005,gldz006 "
                  
   DECLARE aglq942_gldz_amt3_c CURSOR FROM l_sql
   FOREACH aglq942_gldz_amt3_c INTO l_gldz005_1,l_gldz006_1,l_amt_glbg_1,l_amt_glbg2_1,l_amt_glbg3_1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:aglq942_gldz_amt_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_i = l_i +1
      IF cl_null(l_amt_glbg) THEN LET l_amt_glbg = 0 END IF
      IF cl_null(l_amt_glbg_1) THEN LET l_amt_glbg_1 = 0 END IF
      IF cl_null(l_amt_glbg2) THEN LET l_amt_glbg2 = 0 END IF
      IF cl_null(l_amt_glbg2_1) THEN LET l_amt_glbg2_1 = 0 END IF
      IF cl_null(l_amt_glbg3) THEN LET l_amt_glbg3 = 0 END IF
      IF cl_null(l_amt_glbg3_1) THEN LET l_amt_glbg3_1 = 0 END IF  
      
      LET l_amt_glbg = l_amt_glbg/g_unit            
      LET l_amt_glbg_1 = l_amt_glbg_1/g_unit      
      LET l_amt_glbg2 = l_amt_glbg2/g_unit        
      LET l_amt_glbg2_1 = l_amt_glbg2_1/g_unit    
      LET l_amt_glbg3 = l_amt_glbg3/g_unit        
      LET l_amt_glbg3_1 = l_amt_glbg3_1/g_unit 
      
      LET l_glei003 = "        ",l_gldz006_1
      #INSERT INTO aglq942_tmp VALUES ('14',l_i,l_glei003,l_i,l_amt_glbg,l_amt_glbg_1,l_amt_glbg2,l_amt_glbg2_1,l_amt_glbg3,l_amt_glbg3_1)    #151207-00020#19 mark
      INSERT INTO aglq942_tmp VALUES ('3','14',l_i,l_glei003,l_i,l_amt_glbg,l_amt_glbg_1,l_amt_glbg2,l_amt_glbg2_1,l_amt_glbg3,l_amt_glbg3_1) #151207-00020#19 add
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 列印
# Memo...........: #160517-00002#12
# Usage..........: CALL aglq942_print()
# Date & Author..: 160608 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq942_print()
DEFINE l_sql        STRING
DEFINE l_i          LIKE type_t.num5
DEFINE l_g01_tmp    RECORD      
       l_rep_type   LIKE type_t.chr1,    #報表類型  #151207-00020#19 add
       l_seq        LIKE glei_t.glei004, #主類別
       l_odr        LIKE glei_t.glei004, #群組順序
       l_glei003    LIKE type_t.chr500,  #項目
       l_glei004    LIKE glei_t.glei004, #行序
       l_amt        LIKE type_t.num20_6, #本期數
       l_amt_1      LIKE type_t.num20_6  #上期數
                    END RECORD  

   INITIALIZE l_g01_tmp.* TO NULL
   
   IF cl_null(g_input.l_curr) THEN RETURN END IF
   
   #刪除臨時表中資料
   DELETE FROM aglq942_g01_tmp

   #151207-00020#19  --s mark
   ##多本位幣顯示記帳幣or全部> 報表印記帳幣
   #IF g_input.l_curr = '1' OR g_input.l_curr = '4' THEN 
   #   LET l_sql = " SELECT l_seq,l_odr,l_glei003,l_glei004,l_amt,l_amt_1 ",          
   #               "   FROM aglq942_tmp ",
   #               "  WHERE l_seq NOT IN ('121','131')", #期初/期末兩大類不列出細項
   #               "    AND l_rep_type = '1' ",  
   #               "  ORDER BY l_seq,l_odr "   
   #        
   #               
   #   PREPARE aglq942_print_pb FROM l_sql
   #   DECLARE aglq942_print_c CURSOR FOR aglq942_print_pb  
   #   FOREACH aglq942_print_c INTO l_g01_tmp.*
   #      IF SQLCA.sqlcode THEN
   #         INITIALIZE g_errparam TO NULL 
   #         LET g_errparam.extend = "FOREACH:aglq942_print_pb" 
   #         LET g_errparam.code   = SQLCA.sqlcode 
   #         LET g_errparam.popup  = TRUE 
   #         CALL cl_err()
   #   
   #         EXIT FOREACH
   #      END IF   
   #      INSERT INTO aglq942_g01_tmp VALUES (l_g01_tmp.*)     
   #   END FOREACH
   #END IF
   #
   ##多本位幣顯示功能幣> 報表印功能幣
   #IF g_input.l_curr = '2' THEN 
   #   #LET l_sql = " SELECT l_seq,l_odr,l_glei003,l_glei004,l_amt2,l_amt2_1 ",          #151207-00020#19  mark
   #   LET l_sql = " SELECT l_rep_type,l_seq,l_odr,l_glei003,l_glei004,l_amt2,l_amt2_1 ",#151207-00020#19  add
   #               "   FROM aglq942_tmp ",
   #               "  WHERE l_seq NOT IN ('121','131')", #期初/期末兩大類不列出細項
   #               "    AND l_rep_type = '1' ",  #151207-00020#19  add
   #               "  ORDER BY l_seq,l_odr "   
   #               
   #               
   #   PREPARE aglq942_print_pb2 FROM l_sql
   #   DECLARE aglq942_print_c2 CURSOR FOR aglq942_print_pb2  
   #   FOREACH aglq942_print_c2 INTO l_g01_tmp.*
   #      IF SQLCA.sqlcode THEN
   #         INITIALIZE g_errparam TO NULL 
   #         LET g_errparam.extend = "FOREACH:aglq942_print_pb2" 
   #         LET g_errparam.code   = SQLCA.sqlcode 
   #         LET g_errparam.popup  = TRUE 
   #         CALL cl_err()
   #   
   #         EXIT FOREACH
   #      END IF   
   #      INSERT INTO aglq942_g01_tmp VALUES (l_g01_tmp.*)   
   #   END FOREACH
   #END IF
   #
   ##多本位幣顯示報告幣> 報表印報告幣
   #IF g_input.l_curr = '3' THEN   
   #   LET l_sql = " SELECT l_seq,l_odr,l_glei003,l_glei004,l_amt3,l_amt3_1 ",         
   #               "   FROM aglq942_tmp "
   #               "  WHERE l_seq NOT IN ('121','131')", #期初/期末兩大類不列出細項
   #               "    AND l_rep_type = '1' ",  #151207-00020#19  add
   #               "  ORDER BY l_seq,l_odr "   
   #               
   #   PREPARE aglq942_print_pb3 FROM l_sql
   #   DECLARE aglq942_print_c3 CURSOR FOR aglq942_print_pb3  
   #   FOREACH aglq942_print_c3 INTO l_g01_tmp.*
   #      IF SQLCA.sqlcode THEN
   #         INITIALIZE g_errparam TO NULL 
   #         LET g_errparam.extend = "FOREACH:aglq942_print_pb3" 
   #         LET g_errparam.code   = SQLCA.sqlcode 
   #         LET g_errparam.popup  = TRUE 
   #         CALL cl_err()
   #   
   #         EXIT FOREACH
   #      END IF   
   #      INSERT INTO aglq942_g01_tmp VALUES (l_g01_tmp.*)    
   #   END FOREACH
   #END IF
   #151207-00020#19  --e mark
   
   #151207-00020#19  --s add
   IF g_input.l_curr = '1' OR g_input.l_curr = '4' THEN 
      FOR l_i = 1 TO g_gleb_d.getLength()   
         INSERT INTO aglq942_g01_tmp
         VALUES('','','',g_gleb_d[l_i].l_glei003,g_gleb_d[l_i].l_glei004,g_gleb_d[l_i].l_amt,g_gleb_d[l_i].l_amt_1)
      END FOR
   END IF
   IF g_input.l_curr = '2' THEN 
      FOR l_i = 1 TO g_gleb_d.getLength()
         INSERT INTO aglq942_g01_tmp
         VALUES('','','',g_gleb_d[l_i].l_glei003,g_gleb_d[l_i].l_glei004,g_gleb2_d[l_i].l_amt2,g_gleb2_d[l_i].l_amt2_1)
      END FOR
   END IF
   IF g_input.l_curr = '3' THEN 
      FOR l_i = 1 TO g_gleb_d.getLength()  
         INSERT INTO aglq942_g01_tmp
         VALUES('','','',g_gleb_d[l_i].l_glei003,g_gleb_d[l_i].l_glei004,g_gleb3_d[l_i].l_amt3,g_gleb3_d[l_i].l_amt3_1)
      END FOR
   END IF
   #151207-00020#19  --e add


END FUNCTION

 
{</section>}
 
